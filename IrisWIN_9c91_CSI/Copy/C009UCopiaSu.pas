unit C009UCopiaSu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, CheckLst, OracleData, Menus, Db, C180FunzioniGenerali,
  Grids, DBGrids, Oracle, Variants, A000UCostanti, A000USessione, A000UInterfaccia;

type
  TC009FCopiaSu = class(TForm)
    Panel1: TPanel;
    btnEsegui: TBitBtn;
    btnChiudi: TBitBtn;
    selDati: TOracleDataSet;
    DataSource1: TDataSource;
    InsRec: TOracleQuery;
    grdChiaveElemento: TStringGrid;
    selID: TOracleDataSet;
    procedure FormShow(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ValoriChiavePrimaria;
    procedure CaricaGriglia;
    procedure ScaricaGriglia;
    procedure InserisciNuovoRecord;
    procedure DuplicazioneArchiviVoci;
    procedure DuplicazioneFondi;
    procedure InserimentoArchiviVoci(sRowId:String);
    function NomiColonne:String;
    function ValoriColonne:String;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdChiaveElementoSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure grdChiaveElementoDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
    LChiavePrimaria:TStringList;
    LValoriOriginali:TStringList;
    LValoriNuovi:TStringList;
    CodContrattoOri,CodVoceOri,CodVoceSpecialeOri,DecorrenzaOri: String;
    CodContrattoDes,CodVoceDes,CodVoceSpecialeDes,DecorrenzaDes: String;
    NomeTabella: String;
    procedure RegistraLogCopia;
  public
    { Public declarations }
    LCampiPredefiniti:TStringList;
    LValoriPredefiniti:TStringList;
    ODS,ODSatt:TOracleDataSet;
    ArrayODS:array of TOracleDataSet;
    sMsgAnomalie:String;
    Storicizzazione,Eseguito:Boolean;
    RangeDecorrenzaInizio,RangeDecorrenzaFine:TDateTime;
    SiglaProgetto:String;
    procedure SetODS(const a:array of TOracleDataSet);
  end;

var
  C009FCopiaSu: TC009FCopiaSu;

implementation

{$R *.DFM}

procedure TC009FCopiaSu.FormCreate(Sender: TObject);
begin
  grdChiaveElemento.Cells[0,0]:='Nome campo';
  grdChiaveElemento.Cells[1,0]:='Nuovo valore';
  LCampiPredefiniti:=TStringList.Create;
  LValoriPredefiniti:=TStringList.Create;
  Storicizzazione:=False;
  Eseguito:=False;
  RangeDecorrenzaInizio:=EncodeDate(1900,1,1);
  RangeDecorrenzaFine:=EncodeDate(3999,12,31);
end;

procedure TC009FCopiaSu.SetODS(const a:array of TOracleDataSet);
var i:Integer;
begin
  SetLength(ArrayODS,Length(a));
  for i:=0 to High(a) do
    ArrayODS[i]:=a[i];
end;

procedure TC009FCopiaSu.FormShow(Sender: TObject);
begin
  LChiavePrimaria:=TStringList.Create;
  LValoriOriginali:=TStringList.Create;
  LValoriNuovi:=TStringList.Create;
  InsRec.Session:=ODS.Session;
  selDati.Session:=ODS.Session;
  selID.Session:=ODS.Session;
  A000GetChiavePrimaria(ODS.Session,R180Query2NomeTabella(ODS),LChiavePrimaria);
  ValoriChiavePrimaria;
  CaricaGriglia;
  //Posizionamento sulla cella selezionabile (ultima riga della seconda colonna)
  grdChiaveElemento.OnSelectCell:=nil;
  grdChiaveElemento.Row:=grdChiaveElemento.RowCount - 1;
  grdChiaveElemento.Col:=1;
  grdChiaveElemento.OnSelectCell:=grdChiaveElementoSelectCell;
  grdChiaveElemento.SetFocus;
end;

procedure TC009FCopiaSu.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  LChiavePrimaria.Free;
  LValoriOriginali.Free;
  LValoriNuovi.Free;
  LCampiPredefiniti.Free;
  LValoriPredefiniti.Free;
end;

procedure TC009FCopiaSu.btnEseguiClick(Sender: TObject);
var i:Integer;
begin
  sMsgAnomalie:='';
  ScaricaGriglia;
  for i:=0 to High(ArrayODS) do
  begin
    ODSatt:=ArrayODS[i];
    InserisciNuovoRecord;
  end;
  if sMsgAnomalie = '' then
  begin
    if not Storicizzazione then
      R180MessageBox('Elaborazione terminata',INFORMA);
  end
  else
    R180MessageBox('Elaborazione terminata con anomalie: ' + CHR(10) + sMsgAnomalie,INFORMA);
  Eseguito:=True;
  Close;
end;

procedure TC009FCopiaSu.ValoriChiavePrimaria;
//Carica stringlist con i valori dei campi che costituiscono chiave primaria
var
  i,j:Integer;
begin
  //Tra tutti i campi ricerco quelli che sono in chiave e ne estraggo i valori
  LValoriOriginali.Clear;
  for i:=0 to LChiavePrimaria.Count - 1 do
  begin
    for j:=0 to ODS.FieldCount - 1 do
      if UpperCase(LChiavePrimaria[i]) = UpperCase(ODS.Fields[j].FieldName) then
      begin
        LValoriOriginali.Add(ODS.Fields[j].AsString);
        break;
      end;
  end;
end;

procedure TC009FCopiaSu.CaricaGriglia;
//Carica la griglia con chiavi e valori
var
  i:Integer;
begin
  grdChiaveElemento.RowCount:=LChiavePrimaria.Count + 1;
  for i:=0 to LChiavePrimaria.Count - 1 do
  begin
    grdChiaveElemento.Cells[0,i + 1]:=ODS.FieldByName(LChiavePrimaria[i]).DisplayLabel;
    //grdChiaveElemento.Cells[0,i + 1]:=LChiavePrimaria[i];
    grdChiaveElemento.Cells[1,i + 1]:=LValoriOriginali[i];
  end;
end;

procedure TC009FCopiaSu.ScaricaGriglia;
//Scarica la griglia con i nuovi valori
var
  i:Integer;
begin
  LValoriNuovi.Clear;
  for i:=0 to LChiavePrimaria.Count - 1 do
    //LValoriNuovi.Add(grdChiaveElemento.Cells[1,i + 1]);  //Lorena 10/09/2008
    LValoriNuovi.Add(StringReplace(grdChiaveElemento.Cells[1,i + 1],'''','''''',[rfReplaceAll]));
end;

procedure TC009FCopiaSu.InserisciNuovoRecord;
var
  i,j:Integer;
  CampiChiave,S,ClassOri,ClassDes: String;
  ValoreChiave:Variant;
  CK,VK:array of String;
begin
  NomeTabella:=UpperCase(R180EstraiNomeTabella(ODSatt.SQL.Text));
  LCampiPredefiniti.Clear;
  if not Storicizzazione then
  begin
    SetLength(CK,LValoriNuovi.Count);
    SetLength(VK,LValoriNuovi.Count);
    j:=0;
    for i:=0 to LValoriNuovi.Count - 1 do
    begin
      if UpperCase(LChiavePrimaria[i]) = 'DECORRENZA' then
      begin
        SetLength(CK,LValoriNuovi.Count - 1);
        SetLength(VK,LValoriNuovi.Count - 1);
      end
      else
      begin
        CK[j]:=LChiavePrimaria[i];
        VK[j]:=LValoriNuovi[i];
        inc(j);
      end;
    end;
    try
      if  Length(CK) > 0 then
        with (ODSatt as TOracleDataSet) do
          if QueryPK1.EsisteChiave(NomeTabella,RowID,dsBrowse,CK,VK) then
            raise Exception.Create('Chiave già esistente!');
    finally
      SetLength(CK,0);
      SetLength(VK,0);
    end;
  end
  else
  begin
    i:=LChiavePrimaria.IndexOf('DECORRENZA');
    if i >= 0 then
      if not R180Between(StrToDate(LValoriNuovi[i]),RangeDecorrenzaInizio,RangeDecorrenzaFine) then
        raise Exception.Create(Format('Attenzione! La decorrenza indicata (%s) è esterna al periodo storico utilizzato (%s-%s).' + #13#10 + 'Per effettuare le modifiche posizionarsi sul periodo storico corretto.',[LValoriNuovi[i],DateToStr(RangeDecorrenzaInizio),DateToStr(RangeDecorrenzaFine)]));
  end;
  //Devo committare la sessione per poter poi fare rollback in caso di errore
  //Attenzione tutte le eventuali transazioni non committate vengono committate ora
  InsRec.Session.Commit;
  try
    //Duplico il record le voci che vengono trattate a parte
    if NomeTabella = 'P200_VOCI' then
      DuplicazioneArchiviVoci
    else if NomeTabella = 'P684_FONDI' then //Duplico i record dei fondi che vengono trattati a parte
      DuplicazioneFondi
    else
    //Duplico il record per tutte le tabelle dove prevista la funzione CopiaSu
    begin
      if NomeTabella = 'P688_RISDESTDET' then //Controllo particolare su CLASS_VOCE e poi proseguo
      begin
        for i:=0 to LChiavePrimaria.Count - 1 do
        begin
          if LChiavePrimaria[i] = 'CLASS_VOCE' then
          begin
            ClassOri:=Trim(LValoriOriginali[i]);
            ClassDes:=Trim(LValoriNuovi[i]);
          end
        end;
        if ClassOri <> ClassDes then
          raise exception.Create('impossibile cambiare CLASS_VOCE!');
      end;
      with InsRec do
      begin
        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO ' + NomeTabella);
        SQL.Add('(' + NomiColonne + ')');
        SQL.Add('SELECT ' + ValoriColonne);
        //SQL.Add('FROM ' + NomeTabella + ' WHERE ' + NomeTabella + '.RowId = ''' + ODSatt.RowId + '''');
        //Alberto 27/06/2003: riferimento alle colonne piuttosto che al RowID
        SQL.Add('FROM ' + NomeTabella + ' WHERE ');
        for i:=0 to LChiavePrimaria.Count - 1 do
        begin
          S:=LChiavePrimaria[i] + ' = ''' + AggiungiApice(LValoriOriginali[i]) + '''';
          if i < LChiavePrimaria.Count - 1 then S:=S + ' AND ';
          SQL.Add(S);
        end;
        Execute;
        //Registrazioe sui log della copia effetuata
        if ODSatt = ODS then
          RegistraLogCopia;
      end;
    end;
    ODSatt.Refresh;
    ValoreChiave:=VarArrayCreate([0,LChiavePrimaria.Count - 1],VarVariant);
    CampiChiave:='';
    for i:=0 to LChiavePrimaria.Count - 1 do
    begin
      if CampiChiave <> '' then CampiChiave:=CampiChiave + ';';
      CampiChiave:=CampiChiave + LChiavePrimaria[i];
    end;
    for i:=0 to LValoriNuovi.Count - 1 do
      ValoreChiave[i]:=LValoriNuovi[i];
    ODSatt.SearchRecord(CampiChiave,ValoreChiave,[srFromBeginning]);
    InsRec.Session.Commit;
  except
    on e:exception do
    begin
      R180MessageBox('Duplicazione fallita: ' + e.Message,ERRORE);
      InsRec.Session.Rollback;
    end;
  end;
end;

procedure TC009FCopiaSu.RegistraLogCopia;
var i,j:Integer;
    S,v:String;
begin
  RegistraLog.SettaProprieta('I',NomeTabella,SiglaProgetto,nil,True);
  for i:=0 to ODSatt.FieldCount - 1 do
  begin
    if ODSatt.Fields[i].FieldKind = fkData then
    begin
      S:=UpperCase(ODSatt.Fields[i].FieldName);
      V:=ODSatt.Fields[i].AsString;
      for j:=0 to LChiavePrimaria.Count - 1 do
        if UpperCase(LChiavePrimaria[j]) = S then
        begin
          V:=LValoriNuovi[j];
          Break;
        end;
      RegistraLog.InserisciDato(S,'',V);
      end;
  end;
  RegistraLog.RegistraOperazione;
end;

procedure TC009FCopiaSu.DuplicazioneArchiviVoci;
//Duplicazione archivio voci
var
  i,iPuntCodVoceSpec:Integer;
begin
  iPuntCodVoceSpec:=0;
  for i:=0 to LChiavePrimaria.Count - 1 do
  begin
    if LChiavePrimaria[i] = 'COD_CONTRATTO' then
    begin
      CodContrattoOri:=Trim(LValoriOriginali[i]);
      CodContrattoDes:=Trim(LValoriNuovi[i]);
    end
    else if LChiavePrimaria[i] = 'COD_VOCE' then
    begin
      CodVoceOri:=Trim(LValoriOriginali[i]);
      CodVoceDes:=Trim(LValoriNuovi[i]);
    end
    else if LChiavePrimaria[i] = 'COD_VOCE_SPECIALE' then
    begin
      CodVoceSpecialeOri:=Trim(LValoriOriginali[i]);
      CodVoceSpecialeDes:=Trim(LValoriNuovi[i]);
      iPuntCodVoceSpec:=i;
    end
    else if LChiavePrimaria[i] = 'DECORRENZA' then
    begin
      DecorrenzaOri:=Trim(LValoriOriginali[i]);
      DecorrenzaDes:=Trim(LValoriNuovi[i]);
    end;
  end;
  if CodVoceSpecialeDes = '' then
  begin
    if (R180MessageBox('Attenzione: non essendo stato specificato il codice voce speciale, verranno duplicate tutte le voci di pari decorrenza ' + Chr(10) +
       'appartenenti al contratto ' + CodContrattoOri + ' con codice voce ' + CodVoceOri + ' lasciando invariato il codice voce speciale.' + Chr(10) +
       'Confermi l''operazione ? ',DOMANDA) = mrNo) then
      exit;
    with selDati do
    begin
      Close;
      DeleteVariables;
      SQL.Clear;
      DeclareVariable('CodContratto',otString);
      DeclareVariable('CodVoce',otString);
      DeclareVariable('Decorrenza',otDate);
      SQL.Add('SELECT COD_VOCE_SPECIALE,ROWID FROM P200_VOCI WHERE COD_CONTRATTO = :CodContratto ');
      SQL.Add('AND COD_VOCE = :CodVoce AND DECORRENZA = :Decorrenza');
      SetVariable('CodContratto',CodContrattoOri);
      SetVariable('CodVoce',CodVoceOri);
      SetVariable('Decorrenza',DecorrenzaOri);
      Open;
      while not selDati.Eof do
      begin
        CodVoceSpecialeOri:=FieldByName('COD_VOCE_SPECIALE').AsString;
        CodVoceSpecialeDes:=CodVoceSpecialeOri;
        LValoriNuovi[iPuntCodVoceSpec]:=CodVoceSpecialeOri;
        InserimentoArchiviVoci(ROWID);
        Next;
      end;
    end;
  end
  else
    InserimentoArchiviVoci(ODS.RowId);
end;

procedure TC009FCopiaSu.InserimentoArchiviVoci(sRowId:String);
//Inserimento records di P200_VOCI e delle tabelle collegate:P201_ASSOGGETTAMENTI, P205_QUOTE e P232_SCAGLIONI
var
  sIdVoce,sOldCod: String;
begin
  LCampiPredefiniti.Clear;
  LValoriPredefiniti.Clear;
  LCampiPredefiniti.Add('ID_VOCE');
  with selID do
  begin
    Close;
    DeleteVariables;
    SQL.Clear;
    SQL.Add('SELECT P200_ID_VOCE.NEXTVAL FROM DUAL');
    Open;
    sIdVoce:=FieldByName('NEXTVAL').AsString;
    LValoriPredefiniti.Add(sIdVoce);
  end;
  with InsRec do
  begin
    //Inserimento tabella P200_VOCI
    SQL.Clear;
    SQL.Add('INSERT INTO ' + NomeTabella);
    SQL.Add('(' + NomiColonne + ')');
    SQL.Add('SELECT ' + ValoriColonne);
    SQL.Add('FROM ' + NomeTabella + ' WHERE ' + NomeTabella + '.RowId = ''' + sRowId + '''');
    Execute;
    //Modifico il codice voce da stampare facendo una replace del vecchio cod.voce con il nuovo
    SQL.Clear;
    SQL.Add('SELECT COD_VOCE ');
    SQL.Add('FROM ' + NomeTabella + ' WHERE ' + NomeTabella + '.RowId = ''' + sRowId + '''');
    Execute;
    sOldCod:=FieldAsString(0);
    SQL.Clear;
    SQL.Add('UPDATE  ' + NomeTabella);
    SQL.Add('SET COD_VOCE_STAMPA = REPLACE(COD_VOCE_STAMPA,''' + sOldCod + ''',COD_VOCE) WHERE ID_VOCE = ' + sIdVoce);
    Execute;
    //Forzo voce copiata a non protetta
//    SQL.Clear;
//    SQL.Add('UPDATE  ' + NomeTabella);
//    SQL.Add('SET PROTETTA = ''N'' WHERE ID_VOCE = ' + sIdVoce);
//    Execute;
    //Inserimento tabella P201_ASSOGGETTAMENTI
    SQL.Clear;
    SQL.Add('INSERT INTO P201_ASSOGGETTAMENTI ');
    SQL.Add('(COD_CONTRATTO, COD_VOCE_PADRE, COD_VOCE_SPECIALE_PADRE, DECORRENZA, ');
    SQL.Add('COD_VOCE_FIGLIO, COD_VOCE_SPECIALE_FIGLIO, ASSOGGETTAMENTO, ASSOGGETTAMENTO13A, DECORRENZA_FINE) ');
    SQL.Add('SELECT ''' + CodContrattoDes + ''', ''' + CodVoceDes + ''', ''' + CodVoceSpecialeDes + ''', ');
    SQL.Add('DECORRENZA, COD_VOCE_FIGLIO, COD_VOCE_SPECIALE_FIGLIO, ASSOGGETTAMENTO, ASSOGGETTAMENTO13A, DECORRENZA_FINE ');
    SQL.Add('FROM P201_ASSOGGETTAMENTI WHERE COD_CONTRATTO = ''' + CodContrattoOri + ''' AND ');
    SQL.Add('COD_VOCE_PADRE = ''' + CodVoceOri + ''' AND COD_VOCE_SPECIALE_PADRE = ''' + CodVoceSpecialeOri + '''');
    Execute;
    //Inserimento tabella P205_QUOTE
    SQL.Clear;
    SQL.Add('INSERT INTO P205_QUOTE ');
    SQL.Add('(COD_CONTRATTO, COD_VOCE_DA_QUOTARE, COD_VOCE_SPECIALE_DA_QUOTARE, DECORRENZA, ');
    SQL.Add('COD_VOCE_IN_QUOTA, COD_VOCE_SPECIALE_IN_QUOTA, ACCUMULO, ACCUMULO_RATEO, COD_VOCE_SPECIALE_DETTAGLIO, COD_VOCE_SPECIALE_DETTAGLIO13A) ');
    SQL.Add('SELECT ''' + CodContrattoDes + ''', ''' + CodVoceDes + ''', ''' + CodVoceSpecialeDes + ''', ');
    SQL.Add('DECORRENZA, COD_VOCE_IN_QUOTA, COD_VOCE_SPECIALE_IN_QUOTA, ACCUMULO, ACCUMULO_RATEO, COD_VOCE_SPECIALE_DETTAGLIO, COD_VOCE_SPECIALE_DETTAGLIO13A ');
    SQL.Add('FROM P205_QUOTE WHERE COD_CONTRATTO = ''' + CodContrattoOri + ''' AND ');
    SQL.Add('COD_VOCE_DA_QUOTARE = ''' + CodVoceOri + ''' AND COD_VOCE_SPECIALE_DA_QUOTARE = ''' + CodVoceSpecialeOri + '''');
    Execute;
    //Inserimento tabella P206_ASSENZEINPDAP
    SQL.Clear;
    SQL.Add('INSERT INTO P206_ASSENZEINPDAP ');
    SQL.Add('(COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE, DECORRENZA, ELIMINA_SEZIONE, ');
    SQL.Add(' ABBATTE_GGUTILI, COD_TIPOSERVIZIO, COD_GESTASSIC_NONCOPERTE, COD_CAUSASOSPENSIONE, ');
    SQL.Add(' PERC_ASP_SINDACALE, PERC_RETRIBUZIONE, NOTE, DECORRENZA_FINE)');
    SQL.Add('SELECT ''' + CodContrattoDes + ''', ''' + CodVoceDes + ''', ''' + CodVoceSpecialeDes + ''', ');
    SQL.Add(' DECORRENZA, ELIMINA_SEZIONE, ABBATTE_GGUTILI, COD_TIPOSERVIZIO, COD_GESTASSIC_NONCOPERTE, COD_CAUSASOSPENSIONE,');
    SQL.Add(' PERC_ASP_SINDACALE, PERC_RETRIBUZIONE, NOTE, DECORRENZA_FINE ');
    SQL.Add('FROM P206_ASSENZEINPDAP WHERE COD_CONTRATTO = ''' + CodContrattoOri + ''' AND ');
    SQL.Add(' COD_VOCE = ''' + CodVoceOri + ''' AND COD_VOCE_SPECIALE = ''' + CodVoceSpecialeOri + '''');
    Execute;
    //Inserimento tabella P216_ACCORPAMENTOVOCI
    SQL.Clear;
    SQL.Add('INSERT INTO P216_ACCORPAMENTOVOCI ');
    SQL.Add('(COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE, COD_TIPOACCORPAMENTOVOCI, COD_CODICIACCORPAMENTOVOCI,');
    SQL.Add('DECORRENZA, PERCENTUALE, IMPORTO_COLONNA, DECORRENZA_FINE) ');
    SQL.Add('SELECT ''' + CodContrattoDes + ''', ''' + CodVoceDes + ''', ''' + CodVoceSpecialeDes + ''', ');
    SQL.Add('COD_TIPOACCORPAMENTOVOCI, COD_CODICIACCORPAMENTOVOCI,');
    SQL.Add('DECORRENZA, PERCENTUALE, IMPORTO_COLONNA, DECORRENZA_FINE ');
    SQL.Add('FROM P216_ACCORPAMENTOVOCI WHERE COD_CONTRATTO = ''' + CodContrattoOri + ''' AND ');
    SQL.Add('COD_VOCE = ''' + CodVoceOri + ''' AND COD_VOCE_SPECIALE = ''' + CodVoceSpecialeOri + '''');
    Execute;
    //Inserimento tabella P232_SCAGLIONI
    SQL.Clear;
    SQL.Add('INSERT INTO P232_SCAGLIONI ');
    SQL.Add('(COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE, DECORRENZA, ID_SCAGLIONE, TIPO_IMPORTO, TIPO_RITENUTA, ');
    SQL.Add('TIPO_APPLICAZIONE, CONGUAGLIO_ANNUALE, CONGUAGLIO_FINE_RAPPORTO, CONGUAGLIO_DOPO_FINE_RAPPORTO, ');
    SQL.Add('COD_VOCE_CONGUAGLIO, COD_VOCE_SPECIALE_CONGUAGLIO, MENSILITA_ANNUE, MASSIMALE1, MASSIMALE2) ');
    SQL.Add('SELECT ''' + CodContrattoDes + ''', ''' + CodVoceDes + ''', ''' + CodVoceSpecialeDes + ''', ');
    SQL.Add('DECORRENZA, P233_ID_SCAGLIONE.NEXTVAL, TIPO_IMPORTO, TIPO_RITENUTA, ');
    SQL.Add('TIPO_APPLICAZIONE, CONGUAGLIO_ANNUALE, CONGUAGLIO_FINE_RAPPORTO, CONGUAGLIO_DOPO_FINE_RAPPORTO, ');
    SQL.Add('COD_VOCE_CONGUAGLIO, COD_VOCE_SPECIALE_CONGUAGLIO, MENSILITA_ANNUE, MASSIMALE1, MASSIMALE2 ');
    SQL.Add('FROM P232_SCAGLIONI WHERE COD_CONTRATTO = ''' + CodContrattoOri + ''' AND ');
    SQL.Add('COD_VOCE = ''' + CodVoceOri + ''' AND COD_VOCE_SPECIALE = ''' + CodVoceSpecialeOri + '''');
    Execute;
    //Inserimento tabella P233_SCAGLIONIFASCE
    SQL.Clear;
    SQL.Add('DECLARE');
    SQL.Add('CURSOR C1 IS SELECT ID_SCAGLIONE, DECORRENZA FROM P232_SCAGLIONI WHERE ');
    SQL.Add('COD_CONTRATTO =''' + CodContrattoOri + ''' AND COD_VOCE = ''' + CodVoceOri + ''' AND ');
    SQL.Add('COD_VOCE_SPECIALE = ''' + CodVoceSpecialeOri + ''';');
    SQL.Add('NewIdSscaglione NUMBER;');
    SQL.Add('P NUMBER;');
    SQL.Add('BEGIN');
    SQL.Add('FOR T1 IN C1 LOOP');
    SQL.Add('BEGIN');
    SQL.Add('SELECT ID_SCAGLIONE INTO NewIdSscaglione FROM P232_SCAGLIONI WHERE ');
    SQL.Add('COD_CONTRATTO = ''' + CodContrattoDes + ''' AND COD_VOCE = ''' + CodVoceDes + ''' AND ');
    SQL.Add('COD_VOCE_SPECIALE = ''' + CodVoceSpecialeDes + ''' AND DECORRENZA = T1.DECORRENZA;');
    SQL.Add('INSERT INTO P233_SCAGLIONIFASCE');
    SQL.Add('(ID_SCAGLIONE, IMPORTO_DA, IMPORTO_A, PERC_IMP)');
    SQL.Add('(SELECT NewIdSscaglione, IMPORTO_DA, IMPORTO_A, PERC_IMP ');
    SQL.Add('FROM P233_SCAGLIONIFASCE WHERE ID_SCAGLIONE = T1.ID_SCAGLIONE);');
    SQL.Add('EXCEPTION');
    SQL.Add('WHEN NO_DATA_FOUND THEN');
    SQL.Add('P:=0;');
    SQL.Add('END;');
    SQL.Add('END LOOP;');
    SQL.Add('END;');
    Execute;
    //Inserimento tabella P230_MINIMALI
    SQL.Clear;
    SQL.Add('INSERT INTO P230_MINIMALI ');
    SQL.Add('(COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE, DECORRENZA, IMPORTO_TEMPO_PIENO, IMPORTO_PART_TIME, ');
    SQL.Add('TIPO_IMPORTO, TIPO_INTEGRAZIONE, COD_VOCE_INTEGRAZIONE, COD_VOCE_SPECIALE_INTEGRAZIONE) ');
    SQL.Add('SELECT ''' + CodContrattoDes + ''', ''' + CodVoceDes + ''', ''' + CodVoceSpecialeDes + ''', ');
    SQL.Add('DECORRENZA, IMPORTO_TEMPO_PIENO, IMPORTO_PART_TIME, ');
    SQL.Add('TIPO_IMPORTO, TIPO_INTEGRAZIONE, COD_VOCE_INTEGRAZIONE, COD_VOCE_SPECIALE_INTEGRAZIONE ');
    SQL.Add('FROM P230_MINIMALI WHERE COD_CONTRATTO = ''' + CodContrattoOri + ''' AND ');
    SQL.Add('COD_VOCE = ''' + CodVoceOri + ''' AND COD_VOCE_SPECIALE = ''' + CodVoceSpecialeOri + '''');
    Execute;
  end;
end;

procedure TC009FCopiaSu.DuplicazioneFondi;
var i:Integer;
  CodFondoOri,CodFondoDes,DecOri,DecDes:String;
begin
  for i:=0 to LChiavePrimaria.Count - 1 do
  begin
    if LChiavePrimaria[i] = 'COD_FONDO' then
    begin
      CodFondoOri:=Trim(LValoriOriginali[i]);
      CodFondoDes:=Trim(LValoriNuovi[i]);
    end
    else if LChiavePrimaria[i] = 'DECORRENZA_DA' then
    begin
      DecOri:=Trim(LValoriOriginali[i]);
      DecDes:=Trim(LValoriNuovi[i]);
    end;
  end;
  with InsRec do
  begin
    //Controllo eventuali intersezioni
    SQL.Clear;
    SQL.Add('select count(*) conta from ' + NomeTabella);
    SQL.Add('where cod_fondo = ''' + CodFondoDes + '''');
    SQL.Add('  and decorrenza_da <= TO_DATE(''31/12/' + Copy(DecDes,7,4) + ''',''DD/MM/YYYY'')');
    SQL.Add('  and decorrenza_a >= TO_DATE(''' + DecDes + ''',''DD/MM/YYYY'')');
    Execute;
    if StrToIntDef(VarToStr(Field(0)),0) > 0 then
      raise exception.Create('periodi intersecanti!');
    //Inserimento tabella P684_FONDI
    SQL.Clear;
    SQL.Add('INSERT INTO ' + NomeTabella);
    SQL.Add('(cod_fondo,decorrenza_da,decorrenza_a,');
    SQL.Add(' descrizione,cod_macrocateg,cod_raggr,data_costituz,filtro_dipendenti)');
    SQL.Add('SELECT ''' + CodFondoDes + ''',TO_DATE(''' + DecDes + ''',''DD/MM/YYYY''),TO_DATE(''31/12/' + Copy(DecDes,7,4) + ''',''DD/MM/YYYY''),');
    SQL.Add(' descrizione,cod_macrocateg,cod_raggr,data_costituz,filtro_dipendenti');
    SQL.Add('FROM ' + NomeTabella + ' WHERE COD_FONDO = ''' + CodFondoOri + ''' AND DECORRENZA_DA = TO_DATE(''' + DecOri + ''',''DD/MM/YYYY'')');
    Execute;
    SQL.Clear;
    SQL.Add('INSERT INTO P686_RISDESTGEN');
    SQL.Add('(cod_fondo,Decorrenza_da,class_voce,cod_voce_gen,descrizione,tipo_voce,ordine_stampa)');
    SQL.Add('SELECT ''' + CodFondoDes + ''',TO_DATE(''' + DecDes + ''',''DD/MM/YYYY''),class_voce,cod_voce_gen,descrizione,tipo_voce,ordine_stampa');
    SQL.Add('FROM P686_RISDESTGEN WHERE COD_FONDO = ''' + CodFondoOri + ''' AND DECORRENZA_DA = TO_DATE(''' + DecOri + ''',''DD/MM/YYYY'')');
    Execute;
    SQL.Clear;
    SQL.Add('INSERT INTO P688_RISDESTDET');
    SQL.Add('(cod_fondo,Decorrenza_da,class_voce,cod_voce_gen,cod_voce_det,');
    SQL.Add(' descrizione,data_riferimento,quantita,datobase,moltiplicatore,');
    SQL.Add(' importo,cod_arrotondamento,filtro_dipendenti,codici_accorpamentovoci)');
    SQL.Add('SELECT ''' + CodFondoDes + ''',TO_DATE(''' + DecDes + ''',''DD/MM/YYYY''),class_voce,cod_voce_gen,cod_voce_det,');
    SQL.Add('  descrizione,data_riferimento,quantita,datobase,moltiplicatore,');
    SQL.Add('  DECODE(CLASS_VOCE,''D'',0,importo),cod_arrotondamento,filtro_dipendenti,codici_accorpamentovoci');
    SQL.Add('FROM P688_RISDESTDET WHERE COD_FONDO = ''' + CodFondoOri + ''' AND DECORRENZA_DA = TO_DATE(''' + DecOri + ''',''DD/MM/YYYY'')');
    Execute;
  end;
end;

function TC009FCopiaSu.NomiColonne:String;
var i:Integer;
begin
  Result:='';
  for i:=0 to ODSatt.FieldCount - 1 do
    if UpperCase(ODSatt.Fields[i].FieldName) <> 'ROWNUM' then
    begin
      //Salto la copia dei campi tipo long
      if ODSatt.Fields[i] is TMemoField then
      begin
        if not(ODSatt.Fields[i].IsNull ) then
        begin
          sMsgAnomalie:=sMsgAnomalie + 'Il campo ' + ODSatt.Fields[i].FieldName + ' non è stato copiato'+ CHR(10);
        end;
      end
      else
      begin
        if (not ODSatt.Fields[i].Calculated) and (not ODSatt.Fields[i].Lookup) then
        begin
          if Result <> '' then Result:=Result + ',';
          Result:=Result + ODSatt.Fields[i].FieldName;
        end;
      end;
    end;
end;

function TC009FCopiaSu.ValoriColonne:String;
var
  i,j:Integer;
  Assegnato:boolean;
begin
  Result:='';
  for i:=0 to ODSatt.FieldCount - 1 do
  begin
    if (UpperCase(ODSatt.Fields[i].FieldName) <> 'ROWNUM') and (not ODSatt.Fields[i].Calculated) and
       (not ODSatt.Fields[i].Lookup) and not(ODSatt.Fields[i] is TMemoField) then
    begin
      if Result <> '' then Result:=Result + ',';
      Assegnato:=False;
      //Scartare dalla duplicazione i campi in chiave
      for j:=0 to LChiavePrimaria.Count - 1 do
        if UpperCase(LChiavePrimaria[j]) = UpperCase(ODSatt.Fields[i].FieldName) then
        begin
          if LValoriNuovi[j] = '' then
            Result:=Result + 'NULL'
          else
            Result:=Result + '''' + LValoriNuovi[j] + '''';
          Assegnato:=True;
          break;
        end;
      if not Assegnato then
      begin
        //Controllo se si tratta di valore predefinito
        for j:=0 to LCampiPredefiniti.Count - 1 do
          if UpperCase(LCampiPredefiniti[j]) = UpperCase(ODSatt.Fields[i].FieldName) then
          begin
            if LValoriPredefiniti[j] = '' then
              Result:=Result + 'NULL'
            else
              Result:=Result + '''' + LValoriPredefiniti[j] + '''';
            Assegnato:=True;
            break;
          end
      end;
      if not Assegnato then
      begin
        Result:=Result + ODSatt.Fields[i].FieldName;
        (*Continue;
        if ODSatt.Fields[i].AsString = '' then
          Result:=Result + 'NULL'
        else
        begin
          if (ODSatt.Fields[i] is TFloatField) and ({$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator = ',') then
            Result:=Result + '''' + StringReplace(ODSatt.Fields[i].AsString,'.',',',[]) + ''''
          else
            Result:=Result + '''' + ODSatt.Fields[i].AsString + '''';
        end;*)
      end;
    end;
  end;
end;

procedure TC009FCopiaSu.grdChiaveElementoSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var Decorrenza:Boolean;
begin
  Decorrenza:=False;
  if ARow <= LChiavePrimaria.Count then
    Decorrenza:=UpperCase(LChiavePrimaria[ARow - 1]) = 'DECORRENZA';
  CanSelect:=(ACol > 0) and (not Storicizzazione or Decorrenza);
end;

procedure TC009FCopiaSu.grdChiaveElementoDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var Decorrenza:Boolean;
begin
  if gdFixed in State then
    exit;
  Decorrenza:=False;
  if ARow <= LChiavePrimaria.Count then
    Decorrenza:=UpperCase(LChiavePrimaria[ARow - 1]) = 'DECORRENZA';
  if (ACol > 0) and (not Storicizzazione or Decorrenza) then
    exit;
  if ACol = 0 then
    grdChiaveElemento.Canvas.Brush.Color:=cl3DLight;
  grdChiaveElemento.Canvas.Font.Color:=clRed;
  grdChiaveElemento.Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top + 2,grdChiaveElemento.Cells[ACol,ARow]);
end;

end.
