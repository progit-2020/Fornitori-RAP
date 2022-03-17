unit A137UCalcoloSpeseAccessoMW;

interface

uses
  System.SysUtils, Forms,System.Classes, R005UDataModuleMW, Data.DB, OracleData,C180FunzioniGenerali,
  A000UMessaggi, A000UInterfaccia, Variants, Datasnap.DBClient, Oracle, DatiBloccati,
  A000USessione;

type
  TA137FCalcoloSpeseAccessoMW = class(TR005FDataModuleMW)
    dsrM010: TDataSource;
    selM010: TOracleDataSet;
    selM010TIPO_MISSIONE: TStringField;
    selM010DESCRIZIONE: TStringField;
    selT275: TOracleDataSet;
    selT430: TOracleDataSet;
    selT100: TOracleDataSet;
    selT361: TOracleDataSet;
    selM041: TOracleDataSet;
    selT480: TOracleDataSet;
    selM042: TOracleDataSet;
    TabellaStampa: TClientDataSet;
    selM040: TOracleDataSet;
    insM040: TOracleQuery;
    selM052: TOracleDataSet;
    insM052: TOracleQuery;
    updM052: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure InserisciDipendente(TipCodPart, CodLocPart: String;
      KmPercorsi: Real);
  public
    TrovateAnomalie:Boolean;
    lstDescPresenze:TStringList;
    lstCodPresenze:TStringList;
    selDatiBloccati:TDatiBloccati;
    procedure ElaboraElemento(DataComp: TDateTime; Progressivo: Integer;PresenzeEscluse: String);
    procedure CreaTabellaStampa;
    procedure RegistraMese(DataComp: TDateTime; TipoTrasferta: String);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA137FCalcoloSpeseAccessoMW.DataModuleCreate(Sender: TObject);
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  inherited;
  selM010.Open;
  lstDescPresenze:=TStringList.Create;
  lstCodPresenze:=TStringList.Create;
  selM041.Open;
  selM042.Open;
  selT361.Open;
  selT480.Open;
  selT275.Open;
  with selT275 do
    while not Eof do
    begin
      lstCodPresenze.Add(FieldByName('Codice').AsString);
      lstDescPresenze.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  selDatiBloccati:=TDatiBloccati.Create(Self);
end;

procedure TA137FCalcoloSpeseAccessoMW.ElaboraElemento(DataComp: TDateTime; Progressivo: Integer;PresenzeEscluse: String);
var
  Giorno: TDateTime;
  KmPercorsiGG,KmPercorsiMese,KmPercorsiDist: Real;
  NTimbTot: Integer;
  TipLocPartAnag,CodLocPartAnag,TipLocSpostPar,CodLocSpostPar,RilLocSpostPar,TipLocSpostArr,CodLocSpostArr,RilLocSpostArr: String;
  MessaggioAnomalia: String;
  NTimb,I: Integer;

begin
  Giorno:=DataComp;
  KmPercorsiMese:=0;
  NTimbTot:=0;
  //Scorro ogni giorno del mese
  while Giorno <= R180FineMese(DataComp) do
  begin
    try
      //Inizializzo le variabili
      TipLocPartAnag:='';
      CodLocPartAnag:='';
      TipLocSpostPar:='';
      CodLocSpostPar:='';
      RilLocSpostPar:='';
      TipLocSpostArr:='';
      CodLocSpostArr:='';
      RilLocSpostArr:='';
      KmPercorsiGG:=0;
     //Cerco la località di partenza anagrafica del dipendente
      with selT430 do
      begin
        Close;
        SetVariable('PROGRESSIVO',Progressivo);
        SetVariable('DATAGG',Giorno);
        Open;
        if RecordCount = 0 then
          Abort
        else if FieldByName('COD_LOCALITA_DIST_LAVORO').AsString = '' then
        begin
          //Segnalare Anomalia per dipendente senza località partenza anagrafica in data
          //Passare al giorno successivo
          //Registra anomalie su file txt
          MessaggioAnomalia:=Format(A000MSG_A137_MSG_FMT_NO_LOC_PART,[FormatDateTime('DD/MM/YYYY',Giorno)]);
          RegistraMsg.InserisciMessaggio('A',MessaggioAnomalia,'',Progressivo);
          TrovateAnomalie:=True;
          Abort;
        end
        else
        begin
          TipLocPartAnag:=FieldByName('TIPO_LOCALITA_DIST_LAVORO').AsString;
          CodLocPartAnag:=FieldByName('COD_LOCALITA_DIST_LAVORO').AsString;
        end;
      end;
      //Cerco le timbrature giornaliere del dipendente
      with selT100 do
      begin
        Close;
        SetVariable('PROGRESSIVO',Progressivo);
        SetVariable('DATAGG',Giorno);
        if PresenzeEscluse <> '' then
          SetVariable('PRESENZE_ESCLUSE','AND NVL(CAUSALE,''#NULL#'') NOT IN (''' + StringReplace(PresenzeEscluse,',',''',''',[rfReplaceAll]) + ''')')
        else
          SetVariable('PRESENZE_ESCLUSE','');
        Open;
        NTimb:=0;
        //Primo scorrimento delle timbrature per estrarne il numero e verificare la correttezza dei dati da utilizzare
        while not Eof do
        begin
          NTimb:=NTimb + 1;
          NTimbTot:=NTimbTot + 1;
          if FieldByName('RILEVATORE').AsString = '' then
          begin
            //Segnalare Anomalia per timbrature senza rilevatore in data
            //Passare al giorno successivo
            //Registra anomalie su file txt
            MessaggioAnomalia:=Format(A000MSG_A137_MSG_FMT_NO_RILEVATORE,[FormatDateTime('DD/MM/YYYY',Giorno)]);
            //R180AppendFile(PercorsoFileAnomalie,MessaggioAnomalia);
            //danilo 30.11.2012 RegistraMsg.InserisciMessaggio('A',MessaggioAnomalia,'',C700Progressivo);
            RegistraMsg.InserisciMessaggio('I',MessaggioAnomalia,'',Progressivo);//danilo 30.11.2012
            TrovateAnomalie:=True;
            //danilo 30.11.2012 abort;
          end
          else
          begin
            //Controllo che le località dei rilevatori siano state impostate correttamente
            if (not selT361.SearchRecord('CODICE',VarArrayOf([FieldByName('RILEVATORE').AsString]),[srFromBeginning]))
                or (selT361.FieldByName('COD_LOCALITA').AsString = '') then
            begin
              //Segnalare Anomalia per rilevatore senza dati per località
              //Passare al giorno successivo
              //Registra anomalie su file txt
              MessaggioAnomalia:=Format(A000MSG_A137_MSG_FMT_RIL_NO_LOC,[FormatDateTime('DD/MM/YYYY',Giorno),FieldByName('RILEVATORE').AsString]);
              //R180AppendFile(PercorsoFileAnomalie,MessaggioAnomalia);
              RegistraMsg.InserisciMessaggio('A',MessaggioAnomalia,'',Progressivo);
              TrovateAnomalie:=True;
              Abort;
            end;
          end;
          Next;
        end;
        //Secondo scorrimento delle timbrature per calcolare le distanze chilometriche
        First;
        for I:=1 to RecordCount do
        begin
          KmPercorsiDist:=0;
          //Timbratura di Entrata
          if FieldByName('VERSO').AsString = 'E' then
          begin
            //Se la prima timbratura è un'entrata calcolo l'accesso da casa
            if I = 1 then
            begin
              if selT361.SearchRecord('CODICE',VarArrayOf([FieldByName('RILEVATORE').AsString]),[srFromBeginning]) then
              begin
                if (TipLocPartAnag = selT361.FieldByName('TIPO_LOCALITA').AsString) and
                   (CodLocPartAnag = selT361.FieldByName('COD_LOCALITA').AsString) then
                  KmPercorsiDist:=0
                else if (selM041.SearchRecord('TIPO1;LOCALITA1;TIPO2;LOCALITA2',VarArrayOf([TipLocPartAnag,CodLocPartAnag,selT361.FieldByName('TIPO_LOCALITA').AsString,selT361.FieldByName('COD_LOCALITA').AsString]),[srFromBeginning]))
                     or (selM041.SearchRecord('TIPO1;LOCALITA1;TIPO2;LOCALITA2',VarArrayOf([selT361.FieldByName('TIPO_LOCALITA').AsString,selT361.FieldByName('COD_LOCALITA').AsString,TipLocPartAnag,CodLocPartAnag]),[srFromBeginning])) then
                  KmPercorsiDist:=selM041.FieldByName('CHILOMETRI').AsFloat
                else
                begin
                  //Segnalare Anomalia per distanza tra località inesistente
                  //Passare al giorno successivo
                  //Registra anomalie su file txt
                  MessaggioAnomalia:=Format(A000MSG_A137_MSG_FMT_DIST_NO_IMP,[FormatDateTime('DD/MM/YYYY',Giorno),CodLocPartAnag,'Loc.Residenza',selT361.FieldByName('COD_LOCALITA').AsString,'Rilevatore ' + FieldByName('RILEVATORE').AsString]);
                  //R180AppendFile(PercorsoFileAnomalie,MessaggioAnomalia);
                  RegistraMsg.InserisciMessaggio('A',MessaggioAnomalia,'',Progressivo);
                  TrovateAnomalie:=True;
                  abort;
                end;
              end;
            end
            else if CodLocSpostPar <> '' then
            begin
              if selT361.SearchRecord('CODICE',VarArrayOf([FieldByName('RILEVATORE').AsString]),[srFromBeginning]) then
              begin
                TipLocSpostArr:=selT361.FieldByName('TIPO_LOCALITA').AsString;
                CodLocSpostArr:=selT361.FieldByName('COD_LOCALITA').AsString;
                RilLocSpostArr:=FieldByName('RILEVATORE').AsString;
              end
              else //danilo 30.11.2012: se non trovo il rilevatore, non do anomalia; semplicemente ignoro lo spostamento
              begin
                TipLocSpostArr:=TipLocSpostPar;
                CodLocSpostArr:=CodLocSpostPar;
                RilLocSpostArr:=RilLocSpostPar;
              end;
              if (TipLocSpostPar = TipLocSpostArr) and (CodLocSpostPar = CodLocSpostArr) then
                KmPercorsiDist:=0
              else if (selM041.SearchRecord('TIPO1;LOCALITA1;TIPO2;LOCALITA2',VarArrayOf([TipLocSpostPar,CodLocSpostPar,TipLocSpostArr,CodLocSpostArr]),[srFromBeginning]))
                   or (selM041.SearchRecord('TIPO1;LOCALITA1;TIPO2;LOCALITA2',VarArrayOf([TipLocSpostArr,CodLocSpostArr,TipLocSpostPar,CodLocSpostPar]),[srFromBeginning])) then
              begin
                KmPercorsiDist:=selM041.FieldByName('CHILOMETRI').AsFloat;
                //Svuoto le località di partenza e arrivo dello spostamento
                TipLocSpostPar:='';
                CodLocSpostPar:='';
                RilLocSpostPar:='';
                TipLocSpostArr:='';
                CodLocSpostArr:='';
                RilLocSpostArr:='';
              end
              else
              begin
                //Segnalare Anomalia per distanza tra località inesistente
                //Passare al giorno successivo
                //Registra anomalie su file txt
                MessaggioAnomalia:=Format(A000MSG_A137_MSG_FMT_DIST_NO_IMP,[FormatDateTime('DD/MM/YYYY',Giorno),CodLocSpostPar,'Rilevatore ' + RilLocSpostPar,CodLocSpostArr,'Rilevatore ' + RilLocSpostArr]);
                //R180AppendFile(PercorsoFileAnomalie,MessaggioAnomalia);
                RegistraMsg.InserisciMessaggio('A',MessaggioAnomalia,'',Progressivo);
                TrovateAnomalie:=True;
                //Svuoto le località di partenza e arrivo dello spostamento
                TipLocSpostPar:='';
                CodLocSpostPar:='';
                RilLocSpostPar:='';
                TipLocSpostArr:='';
                CodLocSpostArr:='';
                RilLocSpostArr:='';
                abort;
              end;
            end;
          end
          //Timbratura di Uscita
          else if FieldByName('VERSO').AsString = 'U' then
          begin
            //Se l'ultima timbratura è un'uscita calcolo l'accesso a casa
            if I = NTimb then
            begin
              if selT361.SearchRecord('CODICE',VarArrayOf([FieldByName('RILEVATORE').AsString]),[srFromBeginning]) then
              begin
                if (TipLocPartAnag = selT361.FieldByName('TIPO_LOCALITA').AsString) and
                   (CodLocPartAnag = selT361.FieldByName('COD_LOCALITA').AsString) then
                  KmPercorsiDist:=0
                else if (selM041.SearchRecord('TIPO1;LOCALITA1;TIPO2;LOCALITA2',VarArrayOf([TipLocPartAnag,CodLocPartAnag,selT361.FieldByName('TIPO_LOCALITA').AsString,selT361.FieldByName('COD_LOCALITA').AsString]),[srFromBeginning])) or
                        (selM041.SearchRecord('TIPO1;LOCALITA1;TIPO2;LOCALITA2',VarArrayOf([selT361.FieldByName('TIPO_LOCALITA').AsString,selT361.FieldByName('COD_LOCALITA').AsString,TipLocPartAnag,CodLocPartAnag]),[srFromBeginning])) then
                  KmPercorsiDist:=selM041.FieldByName('CHILOMETRI').AsFloat
                else
                begin
                  //Segnalare Anomalia per distanza tra località inesistente
                  //Passare al giorno successivo
                  //Registra anomalie su file txt
                  MessaggioAnomalia:=Format(A000MSG_A137_MSG_FMT_DIST_NO_IMP,[FormatDateTime('DD/MM/YYYY',Giorno),CodLocPartAnag,'Loc.Residenza',selT361.FieldByName('COD_LOCALITA').AsString,'Rilevatore ' + FieldByName('RILEVATORE').AsString]);
                  //R180AppendFile(PercorsoFileAnomalie,MessaggioAnomalia);
                  RegistraMsg.InserisciMessaggio('A',MessaggioAnomalia,'',Progressivo);
                  TrovateAnomalie:=True;
                  abort;
                end;
              end;
            end
            //Se la timbratura è un'uscita (ma non è l'ultima) calcolo lo spostamento
            else
            begin
              if selT361.SearchRecord('CODICE',VarArrayOf([FieldByName('RILEVATORE').AsString]),[srFromBeginning]) then
              begin
                TipLocSpostPar:=selT361.FieldByName('TIPO_LOCALITA').AsString;
                CodLocSpostPar:=selT361.FieldByName('COD_LOCALITA').AsString;
                RilLocSpostPar:=FieldByName('RILEVATORE').AsString;
              end;
            end;
          end;
          KmPercorsiGG:=KmPercorsiGG + KmPercorsiDist;
          Next;
        end;
      end;
    except
      KmPercorsiGG:=0;//danilo 30.11.2012 se l'anomalia è bloccante, ignoro le timbrature del giorno
    end;
    KmPercorsiMese:=KmPercorsiMese + KmPercorsiGG;
    Giorno:=Giorno + 1;
  end;
  //Inserisco nel ClientDataSet i chilometri mensili del dipendente
  if KmPercorsiMese <> 0 then
    InserisciDipendente(TipLocPartAnag,CodLocPartAnag,KmPercorsiMese)
  else if NTimbTot > 0 then
  begin
    //Segnalare Anomalia per distanza tra località inesistente
    //Passare al giorno successivo
    //Registra anomalie su file txt
    MessaggioAnomalia:=A000MSG_A137_MSG_NO_KM_PERCORSI;
    //R180AppendFile(PercorsoFileAnomalie,MessaggioAnomalia);
    RegistraMsg.InserisciMessaggio('A',MessaggioAnomalia,'',Progressivo);
    TrovateAnomalie:=True;
  end;
end;

procedure TA137FCalcoloSpeseAccessoMW.InserisciDipendente(TipCodPart,CodLocPart: String; KmPercorsi: Real);
var
  DescLocPartenza: String;
begin
  if TipCodPart = 'C' then
  begin
    if selT480.SearchRecord('CODICE',VarArrayOf([CodLocPart]),[srFromBeginning]) then
      DescLocPartenza:=selT480.FieldByName('CITTA').AsString;
  end
  else if TipCodPart = 'P' then
  begin
    if selM042.SearchRecord('CODICE',VarArrayOf([CodLocPart]),[srFromBeginning]) then
      DescLocPartenza:=selM042.FieldByName('DESCRIZIONE').AsString;
  end;
  TabellaStampa.Insert;
  TabellaStampa.FieldByName('Progressivo').AsInteger:=SelAnagrafe.FieldByName('Progressivo').AsInteger;
  TabellaStampa.FieldByName('Matricola').AsString:=SelAnagrafe.FieldByName('Matricola').AsString;
  TabellaStampa.FieldByName('Badge').AsInteger:=SelAnagrafe.FieldByName('T430Badge').AsInteger;
  TabellaStampa.FieldByName('Cognome').AsString:=SelAnagrafe.FieldByName('Cognome').AsString;
  TabellaStampa.FieldByName('Nome').AsString:=SelAnagrafe.FieldByName('Nome').AsString;
  TabellaStampa.FieldByName('Nominativo').AsString:=SelAnagrafe.FieldByName('Cognome').AsString+' '+SelAnagrafe.FieldByName('Nome').AsString;
  TabellaStampa.FieldByName('DescLocPartenza').AsString:=DescLocPartenza;
  TabellaStampa.FieldByName('KmPercorsi').AsFloat:=KmPercorsi;
  TabellaStampa.Post;
end;

procedure TA137FCalcoloSpeseAccessoMW.CreaTabellaStampa;
begin
  TabellaStampa.Close;
  TabellaStampa.FieldDefs.Clear;
  TabellaStampa.FieldDefs.Add('Progressivo',ftInteger,0,False); //
  TabellaStampa.FieldDefs.Add('Badge',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('Matricola',ftString,8,False);
  TabellaStampa.FieldDefs.Add('Cognome',ftString,30,False);     //
  TabellaStampa.FieldDefs.Add('Nome',ftString,30,False);        //
  TabellaStampa.FieldDefs.Add('Nominativo',ftString,61,False);
  TabellaStampa.FieldDefs.Add('DescLocPartenza',ftString,30,False);
  TabellaStampa.FieldDefs.Add('KmPercorsi',ftFloat,0,False);
  TabellaStampa.IndexDefs.Clear;
  TabellaStampa.IndexDefs.Add('Primario',('Cognome;Nome;Matricola'),[ixUnique]);
  TabellaStampa.IndexName:='Primario';
  TabellaStampa.CreateDataSet;
  TabellaStampa.LogChanges:=False;
  //Label per grid di CLoud
  TabellaStampa.FieldByName('KmPercorsi').DisplayLabel:='Km percorsi';
  TabellaStampa.FieldByName('DescLocPartenza').DisplayLabel:='Località partenza';
end;

procedure TA137FCalcoloSpeseAccessoMW.RegistraMese(DataComp: TDateTime; TipoTrasferta: String);
var
  MessaggioAnomalia: String;
  DiffGg: Integer;
begin
  if TabellaStampa.RecordCount = 0 then
    exit;
  TabellaStampa.First;
  with TabellaStampa do
    while not TabellaStampa.Eof do
    begin
      selM040.Close;
      selM040.SetVariable('Progressivo',FieldByName('PROGRESSIVO').AsInteger);
      selM040.SetVariable('MeseScarico',DataComp);
      selM040.SetVariable('MeseCompetenza',R180FineMese(DataComp));
      selM040.SetVariable('TipoRegistrazione',TipoTrasferta);
      selM040.SetVariable('DataDa',DataComp);
      selM040.SetVariable('OraDa','00.00');
      selM040.SetVariable('DataA',R180FineMese(DataComp));
      selM040.SetVariable('OraA','00.00');
      selM040.Open;
      if selM040.RecordCount = 0 then
      begin
        try
          DiffGg:=Trunc(R180FineMese(DataComp)-DataComp);
          //Inserimento testata trasferta
          insM040.SetVariable('Progressivo',FieldByName('PROGRESSIVO').AsInteger);
          insM040.SetVariable('MeseScarico',DataComp);
          insM040.SetVariable('MeseCompetenza',R180FineMese(DataComp));
          insM040.SetVariable('DataDa',DataComp);
          insM040.SetVariable('TipoRegistrazione',TipoTrasferta);
          insM040.SetVariable('DataA',R180FineMese(DataComp));
          insM040.SetVariable('TotaleGg',DiffGg+1);
          insM040.SetVariable('Durata',R180MinutiOre(DiffGg*60*24));
          insM040.SetVariable('OreIndRidottaHG',DiffGg*24);
          insM040.Execute;
        except
          //Registra anomalie su file txt
          MessaggioAnomalia:=Format(A000MSG_A137_MSG_FMT_GIA_ESISTE,[FieldByName('MATRICOLA').AsString,
                                                                     FieldByName('COGNOME').AsString+' '+FieldByName('NOME').AsString,
                                                                     'Fine mese',
                                                                     FormatDateTime('mm/yyyy',DataComp),
                                                                     FormatDateTime('dd/mm/yyyy',DataComp)]);

          //R180AppendFile(A137FCalcoloSpeseAccesso.PercorsoFileAnomalie,MessaggioAnomalia);
          RegistraMsg.InserisciMessaggio('A',MessaggioAnomalia,'',FieldByName('PROGRESSIVO').AsInteger);
          TrovateAnomalie:=True;
          Next;
          Continue;
        end;
      end;
      selM052.Close;
      selM052.SetVariable('Progressivo',FieldByName('PROGRESSIVO').AsInteger);
      selM052.SetVariable('MeseScarico',DataComp);
      selM052.SetVariable('MeseCompetenza',R180FineMese(DataComp));
      selM052.SetVariable('DataDa',DataComp);
      selM052.SetVariable('OraDa','00.00');
      selM052.SetVariable('CodiceIndennitaKm',TipoTrasferta);
      selM052.Open;
      if selM052.RecordCount = 0 then
        try
          //Inserimento indennità chilometrica
          insM052.SetVariable('Progressivo',FieldByName('PROGRESSIVO').AsInteger);
          insM052.SetVariable('MeseScarico',DataComp);
          insM052.SetVariable('MeseCompetenza',R180FineMese(DataComp));
          insM052.SetVariable('DataDa',DataComp);
          insM052.SetVariable('CodiceIndennitaKm',TipoTrasferta);
          insM052.SetVariable('KmPercorsi',FieldByName('KmPercorsi').AsFloat);
          insM052.Execute;
        except
          //Registra anomalie su file txt
          MessaggioAnomalia:=Format(A000MSG_A137_MSG_FMT_INS_IND_KM,[FieldByName('MATRICOLA').AsString,FieldByName('COGNOME').AsString+' '+FieldByName('NOME').AsString,'Fine mese']);
          //R180AppendFile(A137FCalcoloSpeseAccesso.PercorsoFileAnomalie,MessaggioAnomalia);
          RegistraMsg.InserisciMessaggio('A',MessaggioAnomalia,'',FieldByName('PROGRESSIVO').AsInteger);
          TrovateAnomalie:=True;
          Next;
          Continue;
        end
      else
        try
          //Aggiornamento indennità chilometrica
          updM052.SetVariable('Progressivo',FieldByName('PROGRESSIVO').AsInteger);
          updM052.SetVariable('MeseScarico',DataComp);
          updM052.SetVariable('MeseCompetenza',R180FineMese(DataComp));
          updM052.SetVariable('DataDa',DataComp);
          updM052.SetVariable('CodiceIndennitaKm',TipoTrasferta);
          updM052.SetVariable('KmPercorsi',FieldByName('KmPercorsi').AsFloat);
          updM052.Execute;
        except
          //Registra anomalie su file txt
          MessaggioAnomalia:=Format(A000MSG_A137_MSG_FMT_UPD_IND_KM,[FieldByName('MATRICOLA').AsString,FieldByName('COGNOME').AsString+' '+FieldByName('NOME').AsString,'Fine mese']);
          //R180AppendFile(A137FCalcoloSpeseAccesso.PercorsoFileAnomalie,MessaggioAnomalia);
          RegistraMsg.InserisciMessaggio('A',MessaggioAnomalia,'',FieldByName('PROGRESSIVO').AsInteger);
          TrovateAnomalie:=True;
          Next;
          Continue;
        end;
      Next;
    end;
  SessioneOracle.Commit;
end;

procedure TA137FCalcoloSpeseAccessoMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(lstCodPresenze);
  FreeAndNil(lstDescPresenze);
  TabellaStampa.Close;
  FreeAndNil(selDatiBloccati);
  //Caratto 3/10/2014 in chiusura sessione può gia essere null.
  try
    SessioneOracle.Preferences.TrimStringFields:=False;
  except
  end;
  inherited;
end;

end.
