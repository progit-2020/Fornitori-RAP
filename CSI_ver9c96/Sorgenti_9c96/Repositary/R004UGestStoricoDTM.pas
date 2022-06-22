unit R004UGestStoricoDTM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  A000UCostanti, A000UMessaggi, A000USessione, A000UInterfaccia, Oracle, OracleData, Db, Variants, StdCtrls,
  C180FunzioniGenerali, RegistrazioneLog
  {$IFNDEF IRISWEB}, R004UGestStorico{$ENDIF};

type
  TEventi = set of (evAfterDelete,evAfterPost,evBeforeDelete,evBeforeEdit,evBeforeInsert,evBeforePost,
                    evBeforePostNoStorico,evOnNewRecord,evOnTranslateMessage);

  {$IFDEF IRISWEB}
  TInterfacciaR004 = class
    chkStoriciPrec,
    chkStoriciSucc:TCheckBox;
    LChiavePrimaria:TStringList;
    LValoriOriginali:TStringList;
    StoricizzazioneInCorso,
    GestioneStoricizzata,
    OttimizzaStorico,
    OttimizzaDecorrenzaFine,
    AllineaSoloDecorrenzeIntersecanti,
    GestioneDecorrenzaFine:Boolean;
    NomeTabella,
    AliasNomeTabella,
    NomeTabellaPadre,
    StatoBeforePost:String;
    DataLavoro:TDateTime;
    lstDecorrenze:array of TDateTime;
    TabelleRelazionate:array of TOracleDataSet;
    AllineaDecorrenzaFine:procedure(DataSet: TDataSet) of object;
  end;
  {$ENDIF}

  TR004FGestStoricoDtM = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure BeforeEdit(DataSet: TDataSet); virtual;
    procedure BeforeInsert(DataSet: TDataSet); virtual;
    procedure OnNewRecord(DataSet: TDataSet); virtual;
    procedure BeforePost(DataSet: TDataSet); virtual;
    procedure AfterPost(DataSet: TDataSet); virtual;
    procedure BeforePostNoStorico(DataSet: TDataSet); virtual;
    procedure BeforeDelete(DataSet: TDataSet); virtual;
    procedure AfterDelete(DataSet: TDataSet); virtual;
    procedure OnTranslateMessage(Sender: TOracleDataSet;
      ErrorCode: Integer; const ConstraintName: String; Action: Char;
      var Msg: String); virtual;
  private
    { Private declarations }
    bExecuteUpdateStorici:Boolean;
    QUpdateStorici: TOracleQuery;
    procedure GetDifferenzeDaOriginale(DataSet:TDataSet);
    function OttimizzazioneStorico(DataSet: TDataSet):Boolean;
    procedure AllineaDecorrenzaFine(DataSet: TDataSet);
  public
    { Public declarations }
  protected
    { Protected declarations }
    InterfacciaR004:TInterfacciaR004;
    StoricoOttimizzato:Boolean;
    procedure InizializzaDataSet(DataSet: TOracleDataSet; Eventi:TEventi);
    procedure SetTabelleRelazionate(const DS:array of TOracleDataSet);
    function GetProgressivoLog(DataSet: TDataSet):Integer; virtual;
    function GetDataRiferimentoLog(DataSet: TDataSet):TDateTime; virtual;
  end;

var
  R004FGestStoricoDtM: TR004FGestStoricoDtM;

implementation

{$R *.DFM}

procedure TR004FGestStoricoDtM.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
  if not(SessioneOracle.Connected) then
  begin
    {$IFNDEF IRISWEB}
    if Password(Application.Name) = -1 then
      Application.Terminate;
    A000ParamDBOracle(SessioneOracle);
    {$ENDIF}
  end;
  for i:=0 to Self.ComponentCount - 1 do
    begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
    end;
  A000SettaVariabiliAmbiente;
  QUpdateStorici:=TOracleQuery.Create(nil);
end;

procedure TR004FGestStoricoDtM.InizializzaDataSet(DataSet: TOracleDataSet; Eventi:TEventi);
begin
  if evBeforeEdit in Eventi then
    DataSet.BeforeEdit:=BeforeEdit;
  if evBeforeInsert in Eventi then
    DataSet.BeforeInsert:=BeforeInsert;
  if evBeforePost in Eventi then
    DataSet.BeforePost:=BeforePost;
  if evBeforePostNoStorico in Eventi then
    DataSet.BeforePost:=BeforePostNoStorico;
  if evBeforeDelete in Eventi then
    DataSet.BeforeDelete:=BeforeDelete;
  if evOnNewRecord in Eventi then
    DataSet.OnNewRecord:=OnNewRecord;
  if evAfterDelete in Eventi then
    DataSet.AfterDelete:=AfterDelete;
  if evAfterPost in Eventi then
    DataSet.AfterPost:=AfterPost;
  if evOnTranslateMessage in Eventi then
    DataSet.OnTranslateMessage:=OnTranslateMessage;
  if InterfacciaR004 = nil then
    begin
    InterfacciaR004:=TInterfacciaR004.Create;
    InterfacciaR004.LChiavePrimaria:=TStringList.Create;
    InterfacciaR004.StoricizzazioneInCorso:=False;
    InterfacciaR004.GestioneStoricizzata:=False;
    InterfacciaR004.OttimizzaDecorrenzaFine:=True;
    InterfacciaR004.GestioneDecorrenzaFine:=False;
    InterfacciaR004.AllineaSoloDecorrenzeIntersecanti:=False;
    InterfacciaR004.DataLavoro:=Parametri.DataLavoro;
    if InterfacciaR004.DataLavoro = 0  then
      InterfacciaR004.DataLavoro:=Date;
    end;
  InterfacciaR004.NomeTabella:=UpperCase(R180EstraiNomeTabella(DataSet.SQL.Text));
  if (Copy(InterfacciaR004.AliasNomeTabella,1,1) = '<') and (Copy(InterfacciaR004.AliasNomeTabella,Length(InterfacciaR004.AliasNomeTabella),1) = '>') then
    InterfacciaR004.AliasNomeTabella:=Copy(InterfacciaR004.AliasNomeTabella,2,Length(InterfacciaR004.AliasNomeTabella) - 2)
  else if (Pos('_',InterfacciaR004.NomeTabella) - 1) > 0 then
    InterfacciaR004.AliasNomeTabella:=Copy(InterfacciaR004.NomeTabella,1,Pos('_',InterfacciaR004.NomeTabella) - 1)
  else
    //Modificato da Nando
    InterfacciaR004.AliasNomeTabella:=Copy(InterfacciaR004.NomeTabella,1,4);
  A000GetChiavePrimaria(DataSet.Session,InterfacciaR004.NomeTabella,InterfacciaR004.LChiavePrimaria);
  //Elimino il riferimento a DECORRENZA
  if InterfacciaR004.LChiavePrimaria.IndexOf('DECORRENZA') >= 0 then
    InterfacciaR004.LChiavePrimaria.Delete(InterfacciaR004.LChiavePrimaria.IndexOf('DECORRENZA'));
  InterfacciaR004.AllineaDecorrenzaFine:=AllineaDecorrenzaFine;
end;

procedure TR004FGestStoricoDtM.SetTabelleRelazionate(const DS:array of TOracleDataSet);
var i:Integer;
begin
  SetLength(InterfacciaR004.TabelleRelazionate,Length(DS));
  for i:=0 to High(DS) do
    InterfacciaR004.TabelleRelazionate[i]:=DS[i];
end;

function TR004FGestStoricoDtM.GetProgressivoLog(DataSet: TDataSet):Integer;
begin
  try
    Result:=DataSet.FieldByName('Progressivo').AsInteger;
  except
    Result:=0;
  end;
end;

function TR004FGestStoricoDtM.GetDataRiferimentoLog(DataSet: TDataSet):TDateTime;
begin
  try
    Result:=DataSet.FieldByName('Decorrenza').AsDateTime;
  except
    Result:=0;
  end;
end;

procedure TR004FGestStoricoDtM.BeforeEdit(DataSet: TDataSet);
{I campi chiave sono Read Only}
var i:Integer;
begin
  for i:=0 to DataSet.FieldCount - 1 do
    if InterfacciaR004.LChiavePrimaria.IndexOf(DataSet.Fields[i].FieldName) >= 0 then
      DataSet.Fields[i].ReadOnly:=True;
end;

procedure TR004FGestStoricoDtM.BeforeInsert(DataSet: TDataSet);
{I campi chiave sono Read Only se si sta effettuando una storicizzazione}
var i:Integer;
begin
  for i:=0 to DataSet.FieldCount - 1 do
    if (InterfacciaR004.LChiavePrimaria.IndexOf(DataSet.Fields[i].FieldName) >= 0) and InterfacciaR004.StoricizzazioneInCorso then
      DataSet.Fields[i].ReadOnly:=True
    else
      //Modificato da Nando 
      DataSet.Fields[i].ReadOnly:=False;
end;

procedure TR004FGestStoricoDtM.OnNewRecord(DataSet: TDataSet);
{Impostazione data di decorrenza}
begin
  if InterfacciaR004.GestioneStoricizzata then
    DataSet.FieldByName('Decorrenza').AsDateTime:=EncodeDate(1900,1,1);//InterfacciaR004.DataLavoro;
end;

procedure TR004FGestStoricoDtM.BeforePostNoStorico(DataSet: TDataSet);
{Controllo esistenza della chiave}
var CK,VK:array of String;
    i:Integer;
begin
  {Costruzioni array dei nomi dei campi e dei valori per la ricerca della chiave}
  SetLength(CK,InterfacciaR004.LChiavePrimaria.Count);
  SetLength(VK,InterfacciaR004.LChiavePrimaria.Count);
  for i:=0 to InterfacciaR004.LChiavePrimaria.Count - 1 do
    if TOracleDataSet(DataSet).FindField(InterfacciaR004.LChiavePrimaria[i]) = nil then
    begin
      SetLength(CK,0);
      SetLength(VK,0);
      Break;
    end
    else
    begin
      CK[i]:=InterfacciaR004.LChiavePrimaria[i];
      VK[i]:=TOracleDataSet(DataSet).FieldByName(InterfacciaR004.LChiavePrimaria[i]).AsString;
    end;
  if Length(CK) > 0 then
    // daniloc. -> array CK e VK non deallocati: verificare...
    with (DataSet as TOracleDataSet) do
      if QueryPK1.EsisteChiave(InterfacciaR004.NomeTabella,RowID,State,CK,VK) then
        raise Exception.Create('Chiave già esistente!');
  //GestioneTabellaPadre(DataSet,oqrInsPadre);
  case DataSet.State of
    dsInsert:begin
      InterfacciaR004.StatoBeforePost:='I';
      RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    end;
    dsEdit:begin
      InterfacciaR004.StatoBeforePost:='M';
      RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    end;
  end;
end;

procedure TR004FGestStoricoDtM.BeforePost(DataSet: TDataSet);
{Controllo esistenza della chiave}
var CK,VK,CKDec,VKDec:array of String;
    i,id:Integer;
    DD,DF:TDateTime;
  function IdxDecorrenza(D:TDateTime):Integer;
  var i:Integer;
  begin
    Result:=-1;
    for i:=High(InterfacciaR004.lstDecorrenze) downto 0 do
      if D >= InterfacciaR004.lstDecorrenze[i] then
      begin
        Result:=i;
        Break;
      end;
  end;
begin
  {Costruzioni array dei nomi dei campi e dei valori per la ricerca della chiave}
  SetLength(CK,InterfacciaR004.LChiavePrimaria.Count);
  SetLength(VK,InterfacciaR004.LChiavePrimaria.Count);
  SetLength(CKDec,InterfacciaR004.LChiavePrimaria.Count + 1);
  SetLength(VKDec,InterfacciaR004.LChiavePrimaria.Count + 1);
  for i:=0 to InterfacciaR004.LChiavePrimaria.Count - 1 do
  begin
    CK[i]:=InterfacciaR004.LChiavePrimaria[i];
    VK[i]:=AggiungiApice(TOracleDataSet(DataSet).FieldByName(InterfacciaR004.LChiavePrimaria[i]).AsString);
    CKDec[i]:=InterfacciaR004.LChiavePrimaria[i];
    VKDec[i]:=AggiungiApice(TOracleDataSet(DataSet).FieldByName(InterfacciaR004.LChiavePrimaria[i]).AsString);
  end;
  CKDec[InterfacciaR004.LChiavePrimaria.Count]:='Decorrenza';
  VKDec[InterfacciaR004.LChiavePrimaria.Count]:=TOracleDataSet(DataSet).FieldByName('Decorrenza').AsString;
  if TOracleDataSet(DataSet).FieldByName('Decorrenza').IsNull then
    raise Exception.Create(A000MSG_ERR_DATA_DECORRENZA);
  if ((DataSet.State = dsEdit) or InterfacciaR004.StoricizzazioneInCorso) and
      (not InterfacciaR004.chkStoriciPrec.Checked) and
      (not InterfacciaR004.chkStoriciSucc.Checked) then
  begin
    if QueryPK1.EsisteStoricoSucc(InterfacciaR004.NomeTabella,TOracleDataSet(DataSet).Rowid,TOracleDataSet(DataSet).FieldByName('Decorrenza').AsDateTime,CKDec,VKDec) then
      if MessageDlg('Esistono delle storicizzazioni successive ma le modifiche verranno applicate solo sulla decorrenza corrente. Confermare?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
        Abort;
  end;
  with (DataSet as TOracleDataSet) do
  begin
    if InterfacciaR004.GestioneDecorrenzaFine and
       InterfacciaR004.AllineaSoloDecorrenzeIntersecanti and
       (not FieldByName('DECORRENZA_FINE').IsNull) and
       (FieldByName('DECORRENZA').AsDateTime > FieldByName('DECORRENZA_FINE').AsDateTime) then
      raise Exception.Create('Periodo storico errato: Decorrenza maggiore della Scadenza.');
    if State = dsInsert then
    begin
      //Controllo inserimento nuovo storico (la chiave può esistere ma con decorrenza diversa)
      if InterfacciaR004.StoricizzazioneInCorso then
      begin
        if QueryPK1.EsisteChiave(InterfacciaR004.NomeTabella,RowID,State,CKDec,VKDec) then
          raise Exception.Create('Chiave già esistente!');
        //Controllo che la storicizzazione avvenga all'interno del periodo corrente, a meno che si sia sulla prima decorrenza: in questo caso è consentita la storicizzazione precedente
        if Length(InterfacciaR004.lstDecorrenze) >= 1 then
        begin
          if (StrToDate(InterfacciaR004.LValoriOriginali.Values['DECORRENZA']) <> InterfacciaR004.lstDecorrenze[0]) or
             (FieldByName('DECORRENZA').AsDateTime > InterfacciaR004.lstDecorrenze[0]) then
          begin
            id:=IdxDecorrenza(StrToDate(InterfacciaR004.LValoriOriginali.Values['DECORRENZA']));
            if id >= 0 then
            begin
              DD:=InterfacciaR004.lstDecorrenze[id];
              if id < High(InterfacciaR004.lstDecorrenze) then
                DF:=InterfacciaR004.lstDecorrenze[id + 1] - 1
              else
                DF:=EncodeDate(3999,12,31);
              if not R180Between(FieldByName('DECORRENZA').AsDateTime,DD,DF) then
                raise Exception.Create(Format('Attenzione! La decorrenza indicata (%s) è esterna al periodo storico utilizzato (%s-%s).' + #13#10 + 'Per effettuare le modifiche posizionarsi sul periodo storico corretto.',[FieldByName('DECORRENZA').AsString,DateToStr(DD),DateToStr(DF)]));
            end;
          end;
        end;
      end;
      //Controllo inserimento nuovo elemento (la chiave non può esistere)
      if not InterfacciaR004.StoricizzazioneInCorso then
        if QueryPK1.EsisteChiave(InterfacciaR004.NomeTabella,RowID,State,CK,VK) then
          raise Exception.Create('Chiave già esistente!')
        else
          (*AssegnaNuovoProgressivo;*);
    end;
    if State = dsEdit then
    begin
      if QueryPK1.EsisteChiave(InterfacciaR004.NomeTabella,RowID,State,CKDec,VKDec) then
        raise Exception.Create('Chiave già esistente!');
      if DataSet.FieldByName('DECORRENZA').Value <> DataSet.FieldByName('DECORRENZA').medpOldValue then
      begin
        if MessageDlg('Attenzione! E'' stata modificata la Decorrenza senza storicizzare. Confermare la modifica?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
          Abort;
        //Controllo che la nuova decorrenza non sia oltre la decorrenza fine o antecedente la decorrenza precedente
        if Length(InterfacciaR004.lstDecorrenze) >= 1 then
        begin
          if (StrToDate(InterfacciaR004.LValoriOriginali.Values['DECORRENZA']) <> InterfacciaR004.lstDecorrenze[0]) or
             (FieldByName('DECORRENZA').AsDateTime > InterfacciaR004.lstDecorrenze[0]) then
          begin
            id:=IdxDecorrenza(StrToDate(InterfacciaR004.LValoriOriginali.Values['DECORRENZA']));
            if id >= 0 then
            begin
              if id = 0 then
                DD:=InterfacciaR004.lstDecorrenze[id]
              else
                DD:=InterfacciaR004.lstDecorrenze[id - 1];
              if id < High(InterfacciaR004.lstDecorrenze) then
                DF:=InterfacciaR004.lstDecorrenze[id + 1] - 1
              else
                DF:=EncodeDate(3999,12,31);
              if not R180Between(FieldByName('DECORRENZA').AsDateTime,DD,DF) then
                raise Exception.Create(Format('Attenzione! La decorrenza indicata (%s) è esterna al periodo consentito (%s-%s).' + #13#10 + 'Per effettuare le modifiche posizionarsi sul periodo storico corretto.',[FieldByName('DECORRENZA').AsString,DateToStr(DD),DateToStr(DF)]));
            end;
          end;
        end;
      end;
    end;
  end;
  //GestioneTabellaPadre(DataSet,oqrInsPadre);
  case DataSet.State of
    dsInsert:
    begin
      InterfacciaR004.StatoBeforePost:='I';
      RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    end;
    dsEdit:
    begin
      InterfacciaR004.StatoBeforePost:='M';
      RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    end;
  end;
  GetDifferenzeDaOriginale(DataSet);
end;

procedure TR004FGestStoricoDtM.GetDifferenzeDaOriginale(DataSet:TDataSet);
var i:Integer;
    S,NomeCampo:String;
//    Q:TOracleQuery;
    Differenza:Boolean;
begin
  bExecuteUpdateStorici:=False;
  if (InterfacciaR004.chkStoriciPrec.Checked or InterfacciaR004.chkStoriciSucc.Checked) and
     (InterfacciaR004.StoricizzazioneInCorso or (DataSet.State = dsEdit)) then
  begin
    //distruggo e ricreo oggetto.
    FreeAndNil(QUpdateStorici);
    QUpdateStorici:=TOracleQuery.Create(nil);
    try
      Differenza:=False;
      QUpdateStorici.Session:=TOracleDataSet(DataSet).Session;
      //Update Tabella set Campo1 = 'Valore1', ...
      QUpdateStorici.SQL.Add('UPDATE ' + R180Query2NomeTabella(DataSet) + ' SET');
      for i:=0 to DataSet.FieldDefs.Count - 1 do
      begin
        NomeCampo:=DataSet.FieldDefs[i].Name;
        //Il controllo dei campi variati esclude la chiave primaria della tabella padre,
        //e non quella della tabella figlio
        if (InterfacciaR004.LChiavePrimaria.IndexOf(NomeCampo) = -1) and
           (UpperCase(NomeCampo) <> 'DECORRENZA') then
        try
          if DataSet.FieldByName(NomeCampo).AsString <> InterfacciaR004.LValoriOriginali.Values[NomeCampo] then
          begin
            S:='';
            if Differenza then
              S:=',';
            S:=S + NomeCampo + ' = ''' + AggiungiApice(DataSet.FieldByName(NomeCampo).AsString) + '''';
            QUpdateStorici.SQL.Add(S);
            Differenza:=True;
          end;
        except  
        end;
      end;
      //Nessuna differenza da applicare
      if not Differenza then
        exit;
      //Where Chiave = 'chiave' and DECORRENZA > :DECORRENZA
      QUpdateStorici.SQL.Add('WHERE');
      if InterfacciaR004.LChiavePrimaria.Count = 0 then
        QUpdateStorici.SQL.Add('1 = 1');
      for i:=0 to InterfacciaR004.LChiavePrimaria.Count - 1 do
      begin
        S:=InterfacciaR004.LChiavePrimaria[i] + ' = ''' + AggiungiApice(DataSet.FieldByName(InterfacciaR004.LChiavePrimaria[i]).AsString) + '''';
        if i < InterfacciaR004.LChiavePrimaria.Count - 1 then
          S:=S + 'AND';
        QUpdateStorici.SQL.Add(S);
      end;
      if (InterfacciaR004.chkStoriciPrec.Checked) and (InterfacciaR004.chkStoriciSucc.Checked) then
        QUpdateStorici.SQL.Add('AND DECORRENZA <> :DECORRENZA')
      else if InterfacciaR004.chkStoriciPrec.Checked then
        QUpdateStorici.SQL.Add('AND DECORRENZA < :DECORRENZA')
      else if InterfacciaR004.chkStoriciSucc.Checked then
        QUpdateStorici.SQL.Add('AND DECORRENZA > :DECORRENZA');
      QUpdateStorici.DeclareVariable('DECORRENZA',otDate);
      QUpdateStorici.SetVariable('DECORRENZA',DataSet.FieldByName('DECORRENZA').AsDateTime);
      bExecuteUpdateStorici:=True;
      //Q.Execute;
      //Q.Session.Commit;
    finally
      //FreeAndNil(Q);
    end;
  end;
end;

procedure TR004FGestStoricoDtM.AfterPost(DataSet: TDataSet);
{Refresh del Dataset e riposizionamento sul record inserito o modificato}
var ChiaveSenzaDec,ChiaveConDec:Variant;
    NomiSenzaDec,NomiConDec:String;
    i:Integer;
begin
  if bExecuteUpdateStorici then
  begin
    QUpdateStorici.Execute;
    QUpdateStorici.Session.Commit;
  end;
  StoricoOttimizzato:=False;
  RegistraLog.RegistraOperazione;
  NomiSenzaDec:='';
  NomiConDec:='';
  ChiaveSenzaDec:=VarArrayCreate([0,InterfacciaR004.LChiavePrimaria.Count - 1],VarVariant);
  ChiaveConDec:=VarArrayCreate([0,InterfacciaR004.LChiavePrimaria.Count],VarVariant);
  for i:=0 to InterfacciaR004.LChiavePrimaria.Count - 1 do
  begin
   if i > 0 then
      NomiSenzaDec:=NomiSenzaDec + ';';
    NomiSenzaDec:=NomiSenzaDec + InterfacciaR004.LChiavePrimaria[i];
    ChiaveSenzaDec[i]:=DataSet.FieldByName(InterfacciaR004.LChiavePrimaria[i]).Value;
    ChiaveConDec[i]:=DataSet.FieldByName(InterfacciaR004.LChiavePrimaria[i]).Value;
  end;
  try
    if InterfacciaR004.GestioneStoricizzata then
    begin
      ChiaveConDec[InterfacciaR004.LChiavePrimaria.Count]:=DataSet.FieldByName('DECORRENZA').Value;
      NomiConDec:=NomiSenzaDec;
      if NomiConDec <> '' then
        NomiConDec:=NomiConDec + ';';
      NomiConDec:=NomiConDec + 'DECORRENZA';
      StoricoOttimizzato:=OttimizzazioneStorico(DataSet);
      if InterfacciaR004.GestioneDecorrenzaFine then
        AllineaDecorrenzaFine(DataSet);
      DataSet.Refresh;
      if not DataSet.Locate(NomiConDec,ChiaveConDec,[]) then
        DataSet.Locate(NomiSenzaDec,ChiaveSenzaDec,[]);
    end
    else
    begin
      DataSet.Refresh;
      DataSet.Locate(NomiSenzaDec,ChiaveSenzaDec,[]);
    end;
  finally
    SessioneOracle.Commit;//Per committare registrazione log e altre operazioni eventuali
  end;
end;

function TR004FGestStoricoDtM.OttimizzazioneStorico(DataSet: TDataSet):Boolean;
var DS,DS1:TOracleDataSet;
    S:String;
    i,T:Integer;
    L:TStringList;
    RI:String;
    DatiUguali,TabRelaz:Boolean;
    Decorrenza,DecorrenzaFine:TDateTime;
  function DecorrenzeUguali(ODS:TOracleDataSet; D1,D2:TDateTime):Boolean;
  {Costruzione dell'istruzone:
    (SELECT *(-DECORRENZA) FROM T WHERE PrimaryKey AND DECORRENZA = D1
     MINUS
     SELECT *(-DECORRENZA) FROM T WHERE PrimaryKey AND DECORRENZA = D2)
    UNION
    (SELECT *(-DECORRENZA) FROM T WHERE PrimaryKey AND DECORRENZA = D2
     MINUS
     SELECT *(-DECORRENZA) FROM T WHERE PrimaryKey AND DECORRENZA = D1)
   se non restituisce nessuna riga, il risultato è True altrimenti False}
  var i:Integer;
      Campi,Where:String;
  begin
    Campi:='';
    for i:=0 to ODS.FieldDefs.Count - 1 do
    begin
      //Caratto 25/11/2014 considerare solo i campi fkData. (es. per A162 vi è un campo internalcalc)
      //Alberto 25/03/2015 considerare i campi solo se sono presenti in Fields
      if (ODS.FindField(ODS.FieldDefs[i].Name) <> nil) and (ODS.FieldByName(ODS.FieldDefs[i].Name).FieldKind = fkData) and
         (ODS.FieldDefs[i].Name <> 'DECORRENZA') and ((ODS.FieldDefs[i].Name <> 'DECORRENZA_FINE') or (not InterfacciaR004.OttimizzaDecorrenzaFine)) then
      begin
        if Campi <> '' then Campi:=Campi + ',';
        Campi:=Campi + ODS.FieldDefs[i].Name;
      end;
    end;
    Where:='';
    for i:=0 to InterfacciaR004.LChiavePrimaria.Count - 1 do
      Where:=Where + InterfacciaR004.LChiavePrimaria[i] + ' = ''' + AggiungiApice(DataSet.FieldByName(InterfacciaR004.LChiavePrimaria[i]).AsString) + ''' AND ';
    DS1:=TOracleDataSet.Create(nil);
    with DS1 do
    try
      Session:=DS.Session;
      SQL.Add('SELECT COUNT(*) FROM (');
      SQL.Add('(SELECT ' + Campi + ' FROM ' + UpperCase(R180EstraiNomeTabella(ODS.SQL.Text)));
      SQL.Add('WHERE ' + Where);
      SQL.Add('DECORRENZA = :D1');
      SQL.Add('MINUS');
      SQL.Add('SELECT ' + Campi + ' FROM ' + UpperCase(R180EstraiNomeTabella(ODS.SQL.Text)));
      SQL.Add('WHERE ' + Where);
      SQL.Add('DECORRENZA = :D2)');
      SQL.Add('UNION');
      SQL.Add('(SELECT ' + Campi + ' FROM ' + UpperCase(R180EstraiNomeTabella(ODS.SQL.Text)));
      SQL.Add('WHERE ' + Where);
      SQL.Add('DECORRENZA = :D2');
      SQL.Add('MINUS');
      SQL.Add('SELECT ' + Campi + ' FROM ' + UpperCase(R180EstraiNomeTabella(ODS.SQL.Text)));
      SQL.Add('WHERE ' + Where);
      SQL.Add('DECORRENZA = :D1)');
      SQL.Add(')');
      DeclareVariable('D1',otDate);
      DeclareVariable('D2',otDate);
      SetVariable('D1',D1);
      SetVariable('D2',D2);
      Open;
      Result:=Fields[0].AsInteger = 0;
      Close;
    finally
      FreeAndNil(DS1);
    end;
  end;
begin
  Result:=False;
  if not InterfacciaR004.OttimizzaStorico then
    exit;
  TabRelaz:=True;
  if Length(InterfacciaR004.TabelleRelazionate) = 0 then
  begin
    SetTabelleRelazionate([TOracleDataSet(DataSet)]);
    TabRelaz:=False;
  end;
  DS:=TOracleDataSet.Create(nil);
  L:=TStringList.Create;
  try
    //Lettura delle decorrenze esistenti per la chiave corrente
    DS.Session:=TOracleDataSet(DataSet).Session;
    if InterfacciaR004.AllineaSoloDecorrenzeIntersecanti then
      DS.SQL.Add('SELECT DECORRENZA,DECORRENZA_FINE,ROWID')
    else
      DS.SQL.Add('SELECT DECORRENZA,ROWID');
    DS.SQL.Add('FROM ' + InterfacciaR004.NomeTabella + ' T1');
    if InterfacciaR004.LChiavePrimaria.Count > 0 then
      DS.SQL.Add('WHERE');
    for i:=0 to InterfacciaR004.LChiavePrimaria.Count - 1 do
      begin
      S:=InterfacciaR004.LChiavePrimaria[i] + ' = ''' + AggiungiApice(DataSet.FieldByName(InterfacciaR004.LChiavePrimaria[i]).AsString) + '''';
      if i < InterfacciaR004.LChiavePrimaria.Count - 1 then
        S:=S + ' AND';
      DS.SQL.Add(S);
      end;
    DS.SQL.Add('ORDER BY DECORRENZA');
    DS.Open;
    Decorrenza:=DS.FieldByName('DECORRENZA').AsDateTime;
    DecorrenzaFine:=0;
    if InterfacciaR004.AllineaSoloDecorrenzeIntersecanti and (DS.FindField('DECORRENZA_FINE') <> nil) then
      DecorrenzaFine:=DS.FieldByName('DECORRENZA_FINE').AsDateTime;
    RI:=DS.RowID;
    //Confronto dei dati di una decorrenza con la decorrenza successiva, considerando le eventuali Tabelle Relazionate
    DS.Next;
    while not DS.Eof do
    begin
      DatiUguali:=True;
      if InterfacciaR004.AllineaSoloDecorrenzeIntersecanti and (DS.FindField('DECORRENZA_FINE') <> nil) then
        if DecorrenzaFine + 1 < DS.FieldByName('DECORRENZA').AsDateTime then
          DatiUguali:=False;
      if DatiUguali then
        for T:=0 to High(InterfacciaR004.TabelleRelazionate) do
        begin
          if not DecorrenzeUguali(InterfacciaR004.TabelleRelazionate[T],Decorrenza,DS.FieldByName('DECORRENZA').AsDateTime) then
          begin
            DatiUguali:=False;
            Break;
          end;
        end;
      (*Se sto lavorando su un record diverso dal corrente e tutte le tabelle risultano uguali,
        posso cancellare il record. La cancellazione delle tabelle figlie avviene tramite
        il DELETE CASCADE della chiave relazionale*)
      if (RI <> DS.RowID) and DatiUguali then
      begin
        if InterfacciaR004.AllineaSoloDecorrenzeIntersecanti and (DS.FindField('DECORRENZA_FINE') <> nil) then
        begin
          DecorrenzaFine:=DS.FieldByName('DECORRENZA_FINE').AsDateTime;
          DS.Prior;
          DS.Edit;
          DS.FieldByName('DECORRENZA_FINE').AsDateTime:=DecorrenzaFine;
          DS.Post;
          DS.Next;
        end;
        DS.Delete;
        Result:=True;
      end
      else
      begin
        Decorrenza:=DS.FieldByName('DECORRENZA').AsDateTime;
        if InterfacciaR004.AllineaSoloDecorrenzeIntersecanti and (DS.FindField('DECORRENZA_FINE') <> nil) then
          DecorrenzaFine:=DS.FieldByName('DECORRENZA_FINE').AsDateTime;
        RI:=DS.RowID;
        DS.Next;
      end;
    end;
  finally
    if not TabRelaz then
      SetLength(InterfacciaR004.TabelleRelazionate,0);
    DS.Free;
    L.Free;
  end;
end;

procedure TR004FGestStoricoDtM.AllineaDecorrenzaFine(DataSet: TDataSet);
var NomeTab,Chiave:String;
    i:Integer;
begin
  if DataSet.FindField('DECORRENZA_FINE') = nil then
    exit;
  NomeTab:=InterfacciaR004.NomeTabella;
  Chiave:='';
  for i:=0 to InterfacciaR004.LChiavePrimaria.Count - 1 do
  begin
    if i > 0 then
      Chiave:=chiave + ' and ';
    Chiave:=Chiave + Format('%s = t.%s',[InterfacciaR004.LChiavePrimaria[i],InterfacciaR004.LChiavePrimaria[i]]);
  end;

  with TOracleQuery.Create(nil) do
  try
    Session:=SessioneOracle;
    SQL.Add('begin');
    // update 1: allineamento dei periodi
    // update 2: impostazione dell'ultima decorrenza al 31/12/3999
    SQL.Add('  update ' + NomeTab + ' t set');
    SQL.Add('    DECORRENZA_FINE = (select min(DECORRENZA) - 1 from ' + NomeTab + ' where');
    if Trim(Chiave) <> '' then
      SQL.Add('                      ' + Chiave + ' and');
    SQL.Add('                       DECORRENZA > t.DECORRENZA)');
    SQL.Add('  where');
    SQL.Add('    DECORRENZA < (select max(DECORRENZA) from ' + NomeTab);
    if Trim(Chiave) <> '' then
      SQL.Add('                  where ' + Chiave);
    if InterfacciaR004.AllineaSoloDecorrenzeIntersecanti then
    begin
      // allinea solo i periodi che si intersecano
      SQL.Add('                  ) and');
      SQL.Add('    exists (select ''X'' from ' + NomeTab + ' b');
      SQL.Add('            where  t.ROWID <> b.ROWID and');
      SQL.Add('                  ' + Chiave + ' and');
      SQL.Add('                   t.DECORRENZA < b.DECORRENZA and');
      SQL.Add('                    nvl(t.DECORRENZA_FINE,b.DECORRENZA) >= b.DECORRENZA');
      SQL.Add('           );');
      SQL.Add('  update ' + NomeTab + ' t set');
      SQL.Add('    DECORRENZA_FINE = TO_DATE(''31123999'',''DDMMYYYY'')');
      SQL.Add('  where');
      SQL.Add('    DECORRENZA_FINE is null and');
      SQL.Add('    DECORRENZA = (select max(DECORRENZA) from ' + NomeTab);
      if Trim(Chiave) <> '' then
        SQL.Add('                  where ' + Chiave);
      SQL.Add('                  );');
    end
    else
    begin
      // chiude prima update
      SQL.Add('                  );');
      // update 2. imposta come ultima decorrenza fine il 31/12/3999
      SQL.Add('  update ' + NomeTab + ' t set');
      SQL.Add('    DECORRENZA_FINE = TO_DATE(''31123999'',''DDMMYYYY'')');
      SQL.Add('  where');
      SQL.Add('    DECORRENZA = (select max(DECORRENZA) from ' + NomeTab);
      if Trim(Chiave) <> '' then
        SQL.Add('                  where ' + Chiave);
      SQL.Add('                  );');
    end;
    SQL.Add('end;');
    try
      Execute;
      TOracleDataSet(DataSet).RefreshRecord;
    except
    end;
  finally
    Free;
  end;
end;

procedure TR004FGestStoricoDtM.BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TR004FGestStoricoDtM.AfterDelete(DataSet: TDataSet);
begin
  AfterPost(DataSet);
end;

procedure TR004FGestStoricoDtM.OnTranslateMessage(
  Sender: TOracleDataSet; ErrorCode: Integer; const ConstraintName: String;
  Action: Char; var Msg: String);
{Conversione messaggi Oracle
 2291 = integrity constraint str.name violated – parent key not found
 2292 = integrity constraint str.name violated – child record found}
begin
  if ErrorCode = 20010 then
    Msg:='Record bloccato';
  if ErrorCode = 2291 then
    Msg:='Impossibile inserire - Riferimento mancante su ' + ConstraintName;
  if ErrorCode = 2292 then
    Msg:='Impossibile eliminare - Riferimento esistente su ' + ConstraintName;
end;

procedure TR004FGestStoricoDtM.DataModuleDestroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).CloseAll;
    if Self.Components[i] is TOracleQuery then
      (Self.Components[i] as TOracleQuery).Close;
  end;
  FreeAndNil(QUpdateStorici);
  // memory leak.ini
  if InterfacciaR004 <> nil then
    try
      if InterfacciaR004.LChiavePrimaria <> nil then
        FreeAndNil(InterfacciaR004.LChiavePrimaria);
      if InterfacciaR004.LValoriOriginali <> nil then
        FreeAndNil(InterfacciaR004.LValoriOriginali);
      FreeAndNil(InterfacciaR004);
    except
    end;
  // memory leak.fine
end;

end.
