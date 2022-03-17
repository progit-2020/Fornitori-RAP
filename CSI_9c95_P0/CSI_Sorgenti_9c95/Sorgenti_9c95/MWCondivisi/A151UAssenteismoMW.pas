unit A151UAssenteismoMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, Data.DB,
  Oracle, Datasnap.DBClient, Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Math,
  Xml.XMLDoc, USelI010, C180FunzioniGenerali, ActiveX, XSBuiltIns,
  A000UMessaggi, A000UInterfaccia, A000USessione, StrUtils, Variants;

type
  T151Dlg = procedure(msg,Chiave:String) of object;
  T151ClearKeys = procedure of object;

  TA151FAssenteismoMW = class(TR005FDataModuleMW)
    selSG101: TOracleDataSet;
    selT910: TOracleDataSet;
    selT255: TOracleDataSet;
    selT256: TOracleDataSet;
    dsrT910: TDataSource;
    dsrT255: TDataSource;
    selRighe: TOracleDataSet;
    selT920Ass: TOracleDataSet;
    selDebitoGGQM: TOracleQuery;
    selT920AssGG: TOracleQuery;
    selT920: TOracleDataSet;
    selT040: TOracleDataSet;
    selT909: TOracleDataSet;
    selT911: TOracleDataSet;
    selV430: TOracleDataSet;
    selSQL: TOracleDataSet;
    selI035: TOracleDataSet;
    selI035Rel: TOracleDataSet;
    dsrI010: TDataSource;
    dsrI010B: TDataSource;
    cdsTotale: TClientDataSet;
    cdsDettaglio: TClientDataSet;
    XMLGenerato: TXMLDocument;
    cdsRisultato: TClientDataSet;
    dsrRisultato: TDataSource;
    cdsRighe: TClientDataSet;
    dsrRighe: TDataSource;
    selT430: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure cdsRigheBeforeDelete(DataSet: TDataSet);
    procedure cdsRigheBeforeInsert(DataSet: TDataSet);
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    NodoCorrente:IXmlNode;
    function OpzioneRiepilogo:Boolean;
    function ConvDescDato(const InDato:string):String;
    procedure CaricaPickList;
    procedure CreaTabellaRisultato(Dataset:TClientDataset);
    procedure ElaboraTestata;
    procedure ElaboraNumDip;
    procedure ElaboraPresenze;
    procedure ElaboraEventiAssenze(Accorp:String);
    procedure ElaboraAssenze(Accorp:String);
    procedure ElaboraAssenzeL104(Accorp:String);
    procedure ElaboraFamiliare(Prog:Integer;DataNas,DataAss:TDateTime);
    procedure ElaboraTotaliGenerali;
    procedure Arrotondamenti;
    procedure ElaboraRiepilogo;
    procedure Pulizia;
    procedure CancellaRigheVuote;
  public
    { Public declarations }
    DaData,AData,OldData:TDateTime;
    ElencoColonne,ElencoRighe,ElencoAccorp,ElencoProgAss,ElencoProgAccorp:TStringList;
    CodTabella,Tabella,TipoAccorp,NumDipSel,PresenzeSel,AssenzeSel,RiepilogoSel,sDaData,sAData:String;
    IdUfficioText,IdUfficioValue,IdMittenteText,IdMittenteValue,UserNameText,PasswordText,CodEnteText,URLWSText:String;
    CreaIndice,EsportaTassiAss,EsportaLegge104,EventoAss,
    DettDip,TotGen,RigheVuote,PresGGLav,AssGGLav,GGInt,AssQM,DettGG,DettFam,FruizGG,FruizMG,FruizHH,FruizDH:Boolean;
    OldProg,OldStraord,iEsportaXml,
    iAss,iNumDipPeriodo,iNumDipArrot,iDebitoGGInt,iAssArrot,iRiepArrot,TotGiorniMMCorr,NumEventi,MaxGG:Integer;
    selI010:TselI010;
    selI010B:TselI010;
    selT151: TOracleDataSet;
    PLEsportaXML,lAccorpSel,lNumDip,lPres,lAss,lRiep:TStringList;
    evtRichiesta:T151Dlg;
    evtClearKeys:T151ClearKeys;
    procedure AfterScroll;
    procedure BeforePostNoStorico;
    procedure CaricaElencoColonne;
    procedure CaricaElencoRighe;
    function OpzioneNumDip:Boolean;
    function OpzionePresenze:Boolean;
    function OpzioneEventiAssenze:Boolean;
    function OpzioneAssenze:Boolean;
    function OpzioneAssenzeL104:Boolean;
    function OpzioneRiepilogoDip:Boolean;
    function OpzioneRiepilogoPres:Boolean;
    function OpzioneRiepilogoAss:Boolean;
    procedure RecuperaTabella;
    procedure AggiornaCdsRighe;
    procedure Domande;
    procedure Controlli;
    procedure PreparaElaborazione;
    procedure CaricaTabellaRisultato(Tipo,Accorp:String);
    procedure OperazioniFinali;
    procedure ImpostaColonneGriglia;
    procedure SegnalaErrore(Msg:String);
    procedure ControlliGeneraXmlTassiAss;
    procedure GeneraXmlTassiAss;
    procedure ControlliGeneraXmlLegge104;
    procedure WSLegge104;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses A151UWSPermessiL104;

{$R *.dfm}

procedure TA151FAssenteismoMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT910.SetVariable('APPLICAZIONE','RILPRE');
  selT910.Open;
  selT255.Open;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
  dsrI010.DataSet:=selI010;
  selI010B:=TselI010.Create(Self);
  selI010B.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
  dsrI010B.DataSet:=selI010B;
  ElencoColonne:=TStringList.Create;
  ElencoRighe:=TStringList.Create;
  ElencoAccorp:=TStringList.Create;
  ElencoProgAccorp:=TStringList.Create;
  ElencoProgAss:=TStringList.Create;
  CaricaPickList;
end;

procedure TA151FAssenteismoMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(PLEsportaXML);
  FreeAndNil(selI010);
  FreeAndNil(selI010B);
  FreeAndNil(ElencoColonne);
  FreeAndNil(ElencoRighe);
  FreeAndNil(ElencoAccorp);
  FreeAndNil(ElencoProgAccorp);
  FreeAndNil(ElencoProgAss);
  FreeAndNil(lNumDip);
  FreeAndNil(lPres);
  FreeAndNil(lAss);
  FreeAndNil(lRiep);
  FreeAndNil(lAccorpSel);
end;

procedure TA151FAssenteismoMW.CaricaPickList;
begin
  inherited;
  //Esporta XML
  PLEsportaXML:=TStringList.Create;
  PLEsportaXML.Add('Tassi di assenza');
  PLEsportaXML.Add('Legge 104/1992');
  //Num. Dip.
  lNumDip:=TStringList.Create;
  lNumDip.Add('[100] Numero dipendenti in servizio nel periodo, proporzionati in base ai gg. servizio');
  lNumDip.Add('[101] Numero dipendenti in servizio nel periodo, proporzionati in base ai gg. servizio e alla % di part-time');
  lNumDip.Add('[102] Numero dipendenti in servizio alla data indicata come Periodo di riferimento, calcolati a teste');
  lNumDip.Add('[103] Numero dipendenti in servizio alla data indicata come Periodo di riferimento, calcolati in base alla % di part-time');
  lNumDip.Add('[104] Numero dipendenti fruitori delle assenze accorpate');
  lNumDip.Add('[105] Numero dipendenti medio: somma del Num.dip. in servizio ad ogni fine mese / 12 mesi');
  //Presenze
  lPres:=TStringList.Create;
  lPres.Add('[200] Giorni lavorativi del periodo dovuti da contratto................................................................ <DC_GGLAVORATIVO>');
  lPres.Add('[201] Giorni timbrati.................................................................................................................... <DC_GGTIMBRATO>');
  lPres.Add('[202] Giorni lavorati considerando eventuali ass.di riposo (ferie, permessi, riposi, etc.).............. <DC_GGLAVORATO>');
  lPres.Add('[203] Giorni di presenza considerando eventuali ass.produttive (missioni, formazione, etc.)...... <DC_GGPRESENZA>');
  lPres.Add('[204] Ore timbrate...................................................................................................................... <DC_ORETIMBRATE>');
  lPres.Add('[205] Ore lavorate considerando eventuali ass.di riposo (ferie, permessi, riposi, etc.)................ <DC_ORELAVORATE>');
  lPres.Add('[206] Ore di presenza considerando eventuali ass.produttive (missioni, formazione, etc.).......... <DC_OREPRESENZA>');
  lPres.Add('[207] Ore di straordinario............................................................................................................ <DC_ORESTRAORD>');
  lPres.Add('[208] Ore del debito contrattuale................................................................................................ <DC_OREDEBITO>');
  //Assenze
  lAss:=TStringList.Create;
  lAss.Add('[300] Giorni di assenze accorpate, calcolati in base al debito gg. (Monte ore sett./GG.lav.)');
  lAss.Add('[301] Ore di assenze accorpate............................................................................................. <ASSENZAORERESE>');
  lAss.Add('[302] Numero eventi di assenze accorpate continuative superiori a 10 giorni');
  lAss.Add('[303] Giorni di assenze accorpate, esclusi i giorni degli eventi di assenze accorpate continuative superiori a 10 giorni');
  lAss.Add('[304] Giorni di assenze accorpate, calcolati in base alla rilevazione legge 104/1992');
  lAss.Add('[305] Ore di assenze accorpate, calcolate in centesimi in base alla rilevazione legge 104/1992');
  //Riepilogo
  lRiep:=TStringList.Create;
  lRiep.Add('[400] Tasso di timbratura.......................: [201] GG timbrati / [200] GG lavorativi');
  lRiep.Add('[401] Tasso di utilizzo della forza lavoro: [202] GG lavorati / [200] GG lavorativi');
  lRiep.Add('[402] Tasso di presenza........................: [203] GG presenza / [200] GG lavorativi');
  lRiep.Add('[403] Tasso di assenteismo...................: [300] GG assenza / [200] GG lavorativi');
  lRiep.Add('[404] Media assenze.............................: [300] GG assenza / [104] Num.fruitori');
  lRiep.Add('[405] Media assenze procapite.............: [300] GG assenza / [102] Num.dipendenti');
  lRiep.Add('[406] Media assenze esclusi eventi.......: [303] GG assenza esclusi eventi / [102] Num.dipendenti');
  lRiep.Add('');
  lRiep.Add('[506] Percentuale di presenza...............: 100 - [403] Tasso di assenteismo (Riepilogo)');
  lRiep.Add('[507] Percentuale di assenza................: 100 - [402] Tasso di presenza (Riepilogo)');
  lRiep.Add('');
  lRiep.Add('[900] Dato libero numerico.................... <DC_LIBERO_NUM>');
  lRiep.Add('[901] Dato libero orario ......................... <DC_LIBERO_ORA>');
  //Riepilogo
  lAccorpSel:=TStringList.Create;
end;

procedure TA151FAssenteismoMW.cdsRigheBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  Abort;
end;

procedure TA151FAssenteismoMW.cdsRigheBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  Abort;
end;

procedure TA151FAssenteismoMW.AfterScroll;
begin
  CreaIndice:=True;
end;

procedure TA151FAssenteismoMW.BeforePostNoStorico;
begin
  if Trim(selT151.FieldByName('STAMPA_GENERATORE').AsString) = '' then
    raise exception.Create(A000MSG_A151_ERR_NO_STAMPA);
  if Trim(selT151.FieldByName('COD_TIPOACCORPCAUSALI').AsString) = ''  then
    raise exception.Create(A000MSG_A151_ERR_NO_TIPO_ACCORP);
  if Trim(selT151.FieldByName('COD_CODICIACCORPCAUSALI').AsString) = ''  then
    raise exception.Create(A000MSG_A151_ERR_NO_COD_ACCORP);
  CaricaElencoColonne;
  selT151.FieldByName('COLONNE').AsString:=ElencoColonne.CommaText;
  CaricaElencoRighe;
  selT151.FieldByName('RIGHE').AsString:=ElencoRighe.CommaText;
  selT151.FieldByName('ESPORTA_XML').AsString:='N';
  if iEsportaXml = 0 then
    selT151.FieldByName('ESPORTA_XML').AsString:='S'
  else if iEsportaXml = 1 then
    selT151.FieldByName('ESPORTA_XML').AsString:='L';
  if Trim(selT151.FieldByName('COLONNE').AsString) = '' then
    raise exception.Create(A000MSG_A151_ERR_NO_COLONNE);
  if (Trim(selT151.FieldByName('RIGHE').AsString) = '') and (selT151.FieldByName('DETTAGLIO_DIP').AsString = 'N') then
    raise exception.Create(A000MSG_A151_ERR_NO_RIGHE);
end;

procedure TA151FAssenteismoMW.CaricaElencoColonne;
begin
  ElencoColonne.CommaText:=NumDipSel +
                           IfThen(PresenzeSel <> '',',') + PresenzeSel +
                           IfThen(AssenzeSel <> '',',') + AssenzeSel +
                           IfThen(RiepilogoSel <> '',',') + RiepilogoSel;
end;

procedure TA151FAssenteismoMW.CaricaElencoRighe;
var Valore,s:String;
begin
  Valore:='';
  cdsRighe.DisableControls;
  cdsRighe.First;
  while not cdsRighe.Eof do
  begin
    s:='';
    if cdsRighe.FieldByName('ORDINE').AsInteger <> 999 then
      s:=Format('%3.3d',[cdsRighe.FieldByName('ORDINE').AsInteger]) + '#' + cdsRighe.FieldByName('DATO').AsString;
    if s <> '' then
    begin
      if Trim(Valore) <> '' then
        Valore:=Valore + ',';
      Valore:=Valore + s;
    end;
    cdsRighe.Next;
  end;
  cdsRighe.First;
  cdsRighe.EnableControls;
  ElencoRighe.CommaText:=Valore;
end;

function TA151FAssenteismoMW.OpzioneNumDip:Boolean;
begin
  Result:=False;
  if (R180IndexOf(ElencoColonne,'100',3) >= 0) or (R180IndexOf(ElencoColonne,'101',3) >= 0) or
     (R180IndexOf(ElencoColonne,'102',3) >= 0) or (R180IndexOf(ElencoColonne,'103',3) >= 0) or
     (R180IndexOf(ElencoColonne,'105',3) >= 0) then
    Result:=True;
end;

function TA151FAssenteismoMW.OpzioneRiepilogoDip:Boolean;
begin
  Result:=False;
  if (R180IndexOf(ElencoColonne,'405',3) >= 0) or (R180IndexOf(ElencoColonne,'406',3) >= 0) then
    Result:=True;
end;

function TA151FAssenteismoMW.OpzionePresenze:Boolean;
begin
  Result:=False;
  if (R180IndexOf(ElencoColonne,'200',3) >= 0) or (R180IndexOf(ElencoColonne,'201',3) >= 0) or
     (R180IndexOf(ElencoColonne,'202',3) >= 0) or (R180IndexOf(ElencoColonne,'203',3) >= 0) or
     (R180IndexOf(ElencoColonne,'204',3) >= 0) or (R180IndexOf(ElencoColonne,'205',3) >= 0) or
     (R180IndexOf(ElencoColonne,'206',3) >= 0) or (R180IndexOf(ElencoColonne,'207',3) >= 0) or
     (R180IndexOf(ElencoColonne,'208',3) >= 0) or
     (R180IndexOf(ElencoColonne,'900',3) >= 0) or (R180IndexOf(ElencoColonne,'901',3) >= 0) then
    Result:=True;
end;

function TA151FAssenteismoMW.OpzioneRiepilogoPres:Boolean;
begin
  Result:=False;
  if (R180IndexOf(ElencoColonne,'400',3) >= 0) or (R180IndexOf(ElencoColonne,'401',3) >= 0) or
     (R180IndexOf(ElencoColonne,'402',3) >= 0) or (R180IndexOf(ElencoColonne,'403',3) >= 0) or
     (R180IndexOf(ElencoColonne,'506',3) >= 0) or (R180IndexOf(ElencoColonne,'507',3) >= 0) then
    Result:=True;
end;

function TA151FAssenteismoMW.OpzioneAssenze:Boolean;
begin
  Result:=False;
  if (R180IndexOf(ElencoColonne,'104',3) >= 0) or
     (R180IndexOf(ElencoColonne,'300',3) >= 0) or (R180IndexOf(ElencoColonne,'301',3) >= 0) or
     (R180IndexOf(ElencoColonne,'303',3) >= 0) then
    Result:=True;
end;

function TA151FAssenteismoMW.OpzioneRiepilogoAss:Boolean;
begin
  Result:=False;
  if (R180IndexOf(ElencoColonne,'403',3) >= 0) or (R180IndexOf(ElencoColonne,'404',3) >= 0) or
     (R180IndexOf(ElencoColonne,'405',3) >= 0) or (R180IndexOf(ElencoColonne,'406',3) >= 0) or
     (R180IndexOf(ElencoColonne,'506',3) >= 0) then
    Result:=True;
end;

function TA151FAssenteismoMW.OpzioneAssenzeL104:Boolean;
begin
  Result:=False;
  if (R180IndexOf(ElencoColonne,'304',3) >= 0) or (R180IndexOf(ElencoColonne,'305',3) >= 0) then
    Result:=True;
end;

function TA151FAssenteismoMW.OpzioneEventiAssenze:Boolean;
begin
  Result:=False;
  if (R180IndexOf(ElencoColonne,'302',3) >= 0) or (R180IndexOf(ElencoColonne,'303',3) >= 0) or
     (R180IndexOf(ElencoColonne,'406',3) >= 0) then
    Result:=True;
end;

function TA151FAssenteismoMW.OpzioneRiepilogo:Boolean;
begin
  Result:=False;
  if (R180IndexOf(ElencoColonne,'400',3) >= 0) or (R180IndexOf(ElencoColonne,'401',3) >= 0) or
     (R180IndexOf(ElencoColonne,'402',3) >= 0) or (R180IndexOf(ElencoColonne,'403',3) >= 0) or
     (R180IndexOf(ElencoColonne,'404',3) >= 0) or (R180IndexOf(ElencoColonne,'405',3) >= 0) or (R180IndexOf(ElencoColonne,'406',3) >= 0) or
     (R180IndexOf(ElencoColonne,'506',3) >= 0) or (R180IndexOf(ElencoColonne,'507',3) >= 0) then
    Result:=True;
end;

function TA151FAssenteismoMW.ConvDescDato(const inDato:string):string;
begin
  Result:=inDato;
  R180SetVariable(selT911,'COD_STAMPA',selT910.FieldByName('CODICE').AsString);
  selT911.Open;
  if selT911.Active and selT911.SearchRecord('NOME',InDato,[srFromBeginning]) then
    Result:=selT911.FieldByName('CAPTION').AsString;
end;

procedure TA151FAssenteismoMW.RecuperaTabella;
begin
  Tabella:='';
  if selT910.SearchRecord('CODICE',CodTabella,[srFromBeginning]) then
    Tabella:=selT910.FieldByName('TABELLA').AsString;
end;

procedure TA151FAssenteismoMW.AggiornaCdsRighe;
begin
  //Caricamento righe
  cdsRighe.Close;
  cdsRighe.IndexDefs.Clear;
  cdsRighe.FieldDefs.Clear;
  cdsRighe.FieldDefs.Add('ORDINE',ftInteger);
  cdsRighe.FieldDefs.Add('DATO',ftString,100,False);
  cdsRighe.IndexDefs.Add('Primario','ORDINE',[]);
  cdsRighe.IndexName:='Primario';
  cdsRighe.CreateDataSet;
  cdsRighe.LogChanges:=False;
  cdsRighe.BeforeInsert:=nil;
  //Serve per la gestione della griglia in Cloud:
  cdsRighe.FieldByName('ORDINE').DisplayWidth:=2;
  cdsRighe.FieldByName('ORDINE').DisplayLabel:='Ordin.';
  cdsRighe.FieldByName('DATO').DisplayLabel:='Dato';

  selRighe.Close;
  selRighe.SetVariable('TABELLA',Tabella);
  selRighe.Open;
  selRighe.First;
  while not selRighe.Eof do
  begin
    cdsRighe.Insert;
    if Pos('#' + selRighe.FieldByName('DATOANAG').AsString + ',',selT151.FieldByName('RIGHE').AsString + ',') > 0 then
      cdsRighe.FieldByName('ORDINE').AsInteger:=StrToIntDef(Copy(selT151.FieldByName('RIGHE').AsString, Pos('#' + selRighe.FieldByName('DATOANAG').AsString + ',',selT151.FieldByName('RIGHE').AsString + ',')-3,3),0)
    else
      cdsRighe.FieldByName('ORDINE').AsInteger:=999;
    cdsRighe.FieldByName('DATO').AsString:=selRighe.FieldByName('DATOANAG').AsString;
    cdsRighe.Post;
    selRighe.Next;
  end;

  cdsRighe.First;
  cdsRighe.BeforeInsert:=cdsRigheBeforeInsert;
end;

procedure TA151FAssenteismoMW.Domande;
begin
  if Assigned(evtRichiesta) then
  begin
    if (iEsportaXml = 0) and (CodTabella <> '_ASSPRES') then
      evtRichiesta(Format(A000MSG_A151_DLG_FMT_GARANZIA_EXPORT,['dei tassi di assenza','la stampa _ASSPRES']),'GaranziaTassiAssPres');
    if (iEsportaXml = 1) and (CodTabella <> '_ASSPRESL104') then
      evtRichiesta(Format(A000MSG_A151_DLG_FMT_GARANZIA_EXPORT,['della legge 104/1992','la stampa _ASSPRESL104']),'GaranziaL104AssPres');
    if (iEsportaXml = 1) and (not DettFam) then
      evtRichiesta(Format(A000MSG_A151_DLG_FMT_GARANZIA_EXPORT,['della legge 104/1992','il Dettaglio familiari attivato']),'GaranziaL104DettFam');
    if (iEsportaXml <> 1) and (DettFam) then
      evtRichiesta(Format(A000MSG_A151_DLG_FMT_DETTAGLIO_DATA_FAM,[CodTabella]),'DettaglioDataFam');
  end;
end;

procedure TA151FAssenteismoMW.Controlli;
begin
  if SelAnagrafe.RecordCount <= 0 then
    raise exception.Create(A000MSG_ERR_NO_DIP);
  if DaData > AData then
    raise exception.Create(A000MSG_ERR_DATE_INVERTITE);
  if Trim(TipoAccorp) = ''  then
    raise exception.Create(A000MSG_A151_ERR_NO_TIPO_ACCORP);
  if ElencoAccorp.Count <= 0 then
    raise exception.Create(A000MSG_A151_ERR_NO_COD_ACCORP);
  if ElencoColonne.Count <= 0 then
    raise exception.Create(A000MSG_A151_ERR_NO_COLONNE);
  if (ElencoRighe.Count <= 0) and (not DettDip) then
    raise exception.Create(A000MSG_A151_ERR_NO_RIGHE);

  if CreaIndice then
  begin
    //Creo l'indice sulla tabella di riferimento per velocizzare le estrazioni
    selSQL.Close;
    selSQL.SQL.Clear;
    selSQL.SQL.Add('DROP INDEX ' + Tabella + '_IDX1');
    try
      selSQL.Open;
    except
    end;
    selSQL.Close;
    selSQL.SQL.Clear;
    selSQL.SQL.Add('create index ' + Tabella + '_IDX1 on ' + Tabella + '(PROGRESSIVO, DATACONTEGGIO)');
    selSQL.SQL.Add('  tablespace ' + Parametri.TSIndici);
    try
      selSQL.Open;
    except
    end;
    CreaIndice:=False;
  end;
  //se la tabella esiste ma non per il periodo indicato
  selSQL.Close;
  selSQL.SQL.Clear;
  selSQL.SQL.Add('SELECT COUNT(*) CONTA FROM ' + Tabella );
  selSQL.SQL.Add(' WHERE DATACONTEGGIO BETWEEN TO_DATE(''' + DateToStr(DaData) + ''',''DD/MM/YYYY'')');
  selSQL.SQL.Add('                         AND TO_DATE(''' + DateToStr(AData) + ''',''DD/MM/YYYY'')');
  selSQL.Open;
  if selSQL.FieldByName('CONTA').AsInteger <= 0 then
    raise exception.Create(Format(A000MSG_A151_ERR_FMT_RIGENERA_TABELLA,[Tabella]));
  //Controllo l'esistenza delle colonne richieste sulla tabella di base
  selT920.Close;
  selT920.SetVariable('TABELLA', Tabella);
  selT920.SetVariable('PROGRESSIVO', SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  selT920.SetVariable('DADATA', StrToDate('01/01/1900'));
  selT920.SetVariable('ADATA', StrToDate('31/12/3999'));
  selT920.SetVariable('GGLAV', ' ');
  selT920.SetVariable('DATI', '*');
  selT920.Open;
  if OpzionePresenze or OpzioneRiepilogoPres then
  begin
    if ((R180IndexOf(ElencoColonne,'200',3) >= 0) or OpzioneRiepilogoPres or PresGGLav) and (selT920.FindField('DC_GGLAVORATIVO') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Giorni lavorativi [200 - DC_GGLAVORATIVO]',Tabella]));
    if ((R180IndexOf(ElencoColonne,'201',3) >= 0) or (R180IndexOf(ElencoColonne,'400',3) >= 0)) and (selT920.FindField('DC_GGTIMBRATO') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Giorni timbrati [201 - DC_GGTIMBRATO]',Tabella]));
    if ((R180IndexOf(ElencoColonne,'202',3) >= 0) or (R180IndexOf(ElencoColonne,'401',3) >= 0)) and (selT920.FindField('DC_GGLAVORATO') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Giorni lavorati [202 - DC_GGLAVORATO]',Tabella]));
    if ((R180IndexOf(ElencoColonne,'203',3) >= 0) or (R180IndexOf(ElencoColonne,'402',3) >= 0) or (R180IndexOf(ElencoColonne,'507',3) >= 0)) and (selT920.FindField('DC_GGPRESENZA') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Giorni di presenza [203 - DC_GGPRESENZA]',Tabella]));
    if (R180IndexOf(ElencoColonne,'204',3) >= 0) and (selT920.FindField('DC_ORETIMBRATE') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Ore timbrate [204 - DC_ORETIMBRATE]',Tabella]));
    if (R180IndexOf(ElencoColonne,'205',3) >= 0) and (selT920.FindField('DC_ORELAVORATE') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Ore lavorate [205 - DC_ORELAVORATE]',Tabella]));
    if (R180IndexOf(ElencoColonne,'206',3) >= 0) and (selT920.FindField('DC_OREPRESENZA') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Ore di presenza [206 - DC_OREPRESENZA]',Tabella]));
    if (R180IndexOf(ElencoColonne,'207',3) >= 0) and (selT920.FindField('DC_ORESTRAORD') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Ore di straordinario [207 - DC_ORESTRAORD]',Tabella]));
    if (R180IndexOf(ElencoColonne,'208',3) >= 0) and (selT920.FindField('DC_OREDEBITO') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Ore del debito contrattuale [208 - DC_OREDEBITO]',Tabella]));
    if (R180IndexOf(ElencoColonne,'900',3) >= 0) and (selT920.FindField('DC_LIBERO_NUM') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['libero numerico [900 - DC_LIBERO_NUM]',Tabella]));
    if (R180IndexOf(ElencoColonne,'901',3) >= 0) and (selT920.FindField('DC_LIBERO_ORA') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['libero orario [901 - DC_LIBERO_ORA]',Tabella]));
  end;
  if OpzioneEventiAssenze then
  begin
    if (selT920.FindField('DATACONTEGGIO') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['data conteggio [DATACONTEGGIO]',Tabella]));
    if (selT920.FindField('ASSENZACAUSALE') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Assenza Causale [ASSENZACAUSALE]',Tabella]));
    if (selT920.FindField('ASSENZAGIORNATE') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Assenza giornate [ASSENZAGIORNATE]',Tabella]));
    if (selT920.FindField('ASSENZAUMFRUIZIONE') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Assenza UM fruizione [ASSENZAUMFRUIZIONE]',Tabella]));
    if (selT920.FindField('ASSENZAORERESE') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Assenza ore rese [ASSENZAORERESE]',Tabella]));
    if AssGGLav and (selT920.FindField('DC_GGLAVORATIVO') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Giorno lavorativo [DC_GGLAVORATIVO]',Tabella]));
  end;
  if OpzioneAssenze or OpzioneAssenzeL104 or OpzioneRiepilogoAss then
  begin
    if (AssGGLav or OpzioneRiepilogoAss) and (selT920.FindField('DC_GGLAVORATIVO') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Giorno lavorativo [DC_GGLAVORATIVO]',Tabella]));
    if (selT920.FindField('DATACONTEGGIO') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['data conteggio [DATACONTEGGIO]',Tabella]));
    if (selT920.FindField('ASSENZACAUSALE') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Assenza Causale [ASSENZACAUSALE]',Tabella]));
    if (selT920.FindField('ASSENZAGIORNATE') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Assenza giornate [ASSENZAGIORNATE]',Tabella]));
    if (selT920.FindField('ASSENZAUMFRUIZIONE') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Assenza UM fruizione [ASSENZAUMFRUIZIONE]',Tabella]));
    if (selT920.FindField('ASSENZAORERESE') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Assenza ore rese [ASSENZAORERESE]',Tabella]));
    if (selT920.FindField('ASSENZADATAFAMILIARE') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Assenza Data familiare [ASSENZADATAFAMILIARE]',Tabella]));
    if (selT920.FindField('DEBITOSETTIMANALE') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Debito settimanale [DEBITOSETTIMANALE]',Tabella]));
    if (selT920.FindField('GIORNILAVORATIVI') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Giorni lavorativi [GIORNILAVORATIVI]',Tabella]));
    if (selT920.FindField('DC_OREDEBITO') = nil) then
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Ore debito [DC_OREDEBITO]',Tabella]));
  end;
  if iEsportaXml = 1 then //Legge 104
  begin
    if (selT920.FindField('SESSO') = nil) then
      raise Exception.Create(A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Sesso [SESSO]',Tabella]));
    if (selT920.FindField('DATANAS') = nil) then
      raise Exception.Create(A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Data nascita [DATANAS]',Tabella]));
    if (selT920.FindField('T430DC_COMUNENAS') = nil) then
      raise Exception.Create(A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['calcolato Comune nascita [T430DC_COMUNENAS]',Tabella]));
    if (selT920.FindField('T430DC_COMUNERES') = nil) then
      raise Exception.Create(A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['calcolato Comune residenza [T430DC_COMUNERES]',Tabella]));
    if (selT920.FindField('T430DC_INQUADRAMENTO') = nil) then
      raise Exception.Create(A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['calcolato Inquadramento [T430DC_INQUADRAMENTO]',Tabella]));
    if (selT920.FindField('T430DC_DURATACONTR') = nil) then
      raise Exception.Create(A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['calcolato Durata contratto [T430DC_DURATACONTR]',Tabella]));
    if (selT920.FindField('T430DC_TIPOCONTR') = nil) then
      raise Exception.Create(A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['calcolato Tipo contratto [T430DC_TIPOCONTR]',Tabella]));
    if (selT920.FindField('T430DC_TIPOPT') = nil) then
      raise Exception.Create(A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['calcolato Tipo part-time [T430DC_TIPOPT]',Tabella]));
    if (selT920.FindField('T430DC_PERCPT') = nil) then
      raise Exception.Create(A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['calcolato Percentuale part-time [T430DC_PERCPT]',Tabella]));
    if (selT920.FindField('T430INIZIO') = nil) then
      raise Exception.Create(A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_NO_DATO_TABELLA,['Inizio [T430INIZIO]',Tabella]));
    R180SetVariable(selT909,'NOME','T430DC_INQUADRAMENTO');
    selT909.Open;
    selSQL.Close;
    selSQL.SQL.Clear;
    selSQL.SQL.Add('SELECT ' + selT909.FieldByName('ESPRESSIONE').AsString + ' FROM V430_STORICO WHERE T430PROGRESSIVO = 0');
    try
      selSQL.Open;
    except
      raise Exception.Create(Format(A000MSG_A151_ERR_FMT_ESPRESSIONE_DATO,['calcolato Inquadramento [T430DC_INQUADRAMENTO]']));
    end;
  end;
end;

procedure TA151FAssenteismoMW.PreparaElaborazione;
var Gruppo,Dettaglio,s:String;
  Dato:String;
  i:Integer;
begin
  ElencoProgAccorp.Clear;
  ElencoProgAss.Clear;
  Gruppo:='';
  for i:=0 to ElencoRighe.Count - 1 do
  begin
    if Gruppo <> '' then
      Gruppo:=Gruppo + ' || ''<#>'' || ';
    Dato:=Copy(ElencoRighe.Strings[i],Pos('#',ElencoRighe.Strings[i])+1,Length(ElencoRighe.Strings[i])-3);
    if Copy(Dato,1,7) = 'T430DC_' then
    begin
      R180SetVariable(selT909,'NOME',Dato);
      selT909.Open;
      Gruppo:=Gruppo + selT909.FieldByName('ESPRESSIONE').AsString
    end
    else
      Gruppo:=Gruppo + Dato;
  end;
  if DettDip then
  begin
    if Gruppo <> '' then
      Gruppo:=Gruppo + ' || ''<#>'' || ';
    Gruppo:=Gruppo + 'MATRICOLA';
  end;
  CreaTabellaRisultato(cdsRisultato);
  CreaTabellaRisultato(cdsTotale);
  if OpzioneEventiAssenze then
  begin
    cdsDettaglio.Close;
    cdsDettaglio.IndexDefs.Clear;
    cdsDettaglio.FieldDefs.Clear;
    cdsDettaglio.FieldDefs.Add('PROGRESSIVO',ftInteger);
    for i:=0 to ElencoAccorp.Count - 1 do
      cdsDettaglio.FieldDefs.Add('DATE_' + TipoAccorp + '#' + ElencoAccorp.Strings[i],ftString,1000);
    cdsDettaglio.IndexDefs.Add('Primario','PROGRESSIVO',[]);
    cdsDettaglio.IndexName:='Primario';
    cdsDettaglio.CreateDataSet;
    cdsDettaglio.LogChanges:=False;
  end;
  //Apro la query dei periodi storici per GRUPPO
  selV430.Close;
  s:='';
  if Pos('WHERE',SelAnagrafe.SUBSTITUTEDSQL) > 0 then
  begin
    s:=EliminaRitornoACapo(Copy(SelAnagrafe.SUBSTITUTEDSQL,Pos('WHERE',SelAnagrafe.SUBSTITUTEDSQL)+6,Length(SelAnagrafe.SUBSTITUTEDSQL)-Pos('WHERE',SelAnagrafe.SUBSTITUTEDSQL)-6));
    s:=StringReplace(s,':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine AND','',[rfReplaceAll]);
    s:=StringReplace(s,':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO) AND','',[rfReplaceAll]);
    if Pos('ORDER BY',s) > 0 then
      s:=Copy(s,1,Pos('ORDER BY',s)-1);
  end;
  if s <> '' then
    selV430.SetVariable('FiltroC700',' AND ' + s)
  else
    selV430.SetVariable('FiltroC700',' ');
  selV430.SetVariable('Gruppo',Gruppo);

  Dettaglio:='';
  s:='';
  for i:=0 to ElencoRighe.Count - 1 do
  begin
    Dato:=Copy(ElencoRighe.Strings[i],Pos('#',ElencoRighe.Strings[i])+1,Length(ElencoRighe.Strings[i])-3);
    if Copy(Dato,1,7) = 'T430DC_' then
    begin
      R180SetVariable(selT909,'NOME',Dato);
      selT909.Open;
      Dettaglio:=Dettaglio + IfThen(Dettaglio='','',',') + selT909.FieldByName('ESPRESSIONE').AsString + ' ' + Dato;
      s:=s + IfThen(s='','',',') + selT909.FieldByName('ESPRESSIONE').AsString;
    end
    else
    begin
      Dettaglio:=Dettaglio + IfThen(Dettaglio='','',',') + Dato;
      s:=s + IfThen(s='','',',') + Dato;
    end;
  end;
  if DettDip then
  begin
    Dettaglio:=Dettaglio + IfThen(Dettaglio='','',',') + 'COGNOME,NOME,MATRICOLA,CODFISCALE';
    s:=s + IfThen(s='','',',') + 'COGNOME,NOME,MATRICOLA,CODFISCALE';
  end;
  if Dettaglio <> '' then
    selV430.SetVariable('Dettaglio',Dettaglio)
  else
    selV430.SetVariable('Dettaglio','''''');
  if Dettaglio <> '' then
    selV430.SetVariable('Dettaglio2',s)
  else
    selV430.SetVariable('Dettaglio2','''''');
  selV430.SetVariable('C700DataDal',DaData);
  selV430.SetVariable('DataLavoro',AData);
  selV430.Open;
  selV430.First;
  //Verifico che il dip. sia presente nella tabella generata
  selSQL.Close;
  selSQL.SQL.Clear;
  selSQL.SQL.Add('SELECT DISTINCT PROGRESSIVO FROM ' + Tabella);
  selSQL.Open;
end;

procedure TA151FAssenteismoMW.CreaTabellaRisultato(Dataset:TClientDataset);
var i:Integer;
  s:String;
begin
  Dataset.Close;
  Dataset.IndexDefs.Clear;
  Dataset.FieldDefs.Clear;
  Dataset.FieldDefs.Add('GRUPPO',ftString,2000,False);
  Dataset.FieldDefs.Add('GRUPPO_DESC',ftString,4000,False);
  for i:=0 to ElencoRighe.Count - 1 do
    Dataset.FieldDefs.Add(Copy(ElencoRighe.Strings[i],Pos('#',ElencoRighe.Strings[i])+1,Length(ElencoRighe.Strings[i])-3),ftString,100,False);
  if DettDip then
  begin
    Dataset.FieldDefs.Add('PROGRESSIVO',ftInteger);
    Dataset.FieldDefs.Add('COGNOME',ftString,30,False);
    Dataset.FieldDefs.Add('NOME',ftString,30,False);
    Dataset.FieldDefs.Add('MATRICOLA',ftString,8,False);
    Dataset.FieldDefs.Add('CODFISCALE',ftString,16,False);
  end;
  //Num.dip.
  if OpzioneNumDip or OpzioneRiepilogoDip then
  begin
    Dataset.FieldDefs.Add('NUMDIP',ftFloat);
    Dataset.FieldDefs.Add('NUMDIPPT',ftFloat);
    Dataset.FieldDefs.Add('NUMDIPINIZ',ftFloat);
    Dataset.FieldDefs.Add('NUMDIPFINE',ftFloat);
    Dataset.FieldDefs.Add('NUMDIPINIZPT',ftFloat);
    Dataset.FieldDefs.Add('NUMDIPFINEPT',ftFloat);
    Dataset.FieldDefs.Add('NUMDIPMEDIO',ftFloat);
  end;
  //Presenze
  if OpzionePresenze or OpzioneRiepilogoPres then
  begin
    Dataset.FieldDefs.Add('GGTOT',ftFloat);  //GG lavorativi
    Dataset.FieldDefs.Add('GGTIMB',ftFloat);  //GG timbrati
    Dataset.FieldDefs.Add('GGLAV',ftFloat);  //GG lavorati
    Dataset.FieldDefs.Add('GGPRES',ftFloat);    //GG presenza
    Dataset.FieldDefs.Add('ORETIMB',ftString,10,False); //Ore timbrate
    Dataset.FieldDefs.Add('ORELAV',ftString,10,False); //Ore lavorate
    Dataset.FieldDefs.Add('OREPRES',ftString,10,False); //Ore presenza
    Dataset.FieldDefs.Add('ORESTRAORD',ftString,10,False); //Ore straordinario
    Dataset.FieldDefs.Add('OREDEBITO',ftString,10,False); //Ore debito
    //Dato libero
    Dataset.FieldDefs.Add('LIBERO_NUM',ftFloat);
    Dataset.FieldDefs.Add('LIBERO_ORA',ftString,10,False);
  end;
  if OpzioneEventiAssenze then
  begin
    //Numero dipendenti fruitori assenze - GG assenza - Eventi assenza > 10 gg.
    for i:=0 to ElencoAccorp.Count - 1 do
      Dataset.FieldDefs.Add('ASS10GG_' + TipoAccorp + '#' + ElencoAccorp.Strings[i],ftFloat);
    Dataset.FieldDefs.Add('ASS10GG',ftFloat);
  end;
  if OpzioneAssenze or OpzioneRiepilogoAss then
  begin
    //Numero dipendenti fruitori assenze - GG assenza - Eventi assenza > 10 gg.
    for i:=0 to ElencoAccorp.Count - 1 do
    begin
      Dataset.FieldDefs.Add('NUMDIP_' + TipoAccorp + '#' + ElencoAccorp.Strings[i],ftFloat);
      Dataset.FieldDefs.Add('GGASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i],ftFloat);
      Dataset.FieldDefs.Add('GGASSEV_' + TipoAccorp + '#' + ElencoAccorp.Strings[i],ftFloat);
      Dataset.FieldDefs.Add('HHASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i],ftString,10,False);
    end;
    Dataset.FieldDefs.Add('NUMDIPASS',ftFloat);
    Dataset.FieldDefs.Add('GGASS',ftFloat);
    Dataset.FieldDefs.Add('GGASSEV',ftFloat);
    Dataset.FieldDefs.Add('HHASS',ftString,10,False);
  end;
  if OpzioneAssenzeL104 then
  begin
    //Numero dipendenti fruitori assenze - GG assenza - Eventi assenza > 10 gg. - Tassi
    for i:=0 to ElencoAccorp.Count - 1 do
    begin
      Dataset.FieldDefs.Add('GGASSL104_' + TipoAccorp + '#' + ElencoAccorp.Strings[i],ftFloat);
      Dataset.FieldDefs.Add('HHASSL104_' + TipoAccorp + '#' + ElencoAccorp.Strings[i],ftFloat);
    end;
    Dataset.FieldDefs.Add('GGASSL104',ftFloat);
    Dataset.FieldDefs.Add('HHASSL104',ftFloat);
  end;
  if DettGG then
  begin
    Dataset.FieldDefs.Add('DATAGIUSTIF',ftDate);
    Dataset.FieldDefs.Add('CAUSALE',ftString,5,False);
  end;
  if DettFam then
  begin
    Dataset.FieldDefs.Add('DATANASFAM',ftDateTime);
    Dataset.FieldDefs.Add('GRADOPAR',ftString,20,False);
    Dataset.FieldDefs.Add('TIPOPAR',ftString,10,False);
    Dataset.FieldDefs.Add('NUMGRADO',ftString,2,False);
    Dataset.FieldDefs.Add('MOTIVO_GRADO_3',ftString,50,False);
    Dataset.FieldDefs.Add('COGNOMEFAM',ftString,30,False);
    Dataset.FieldDefs.Add('NOMEFAM',ftString,30,False);
    Dataset.FieldDefs.Add('CODFISCFAM',ftString,16,False);
    Dataset.FieldDefs.Add('SESSOFAM',ftString,1,False);
    Dataset.FieldDefs.Add('COMNASFAM',ftString,30,False);
    if iEsportaXML = 1 then  //L104
    begin
      Dataset.FieldDefs.Add('TIPO_DISABILITA',ftString,20,False);
      Dataset.FieldDefs.Add('ANNO_REVISIONE',ftString,4,False);
      Dataset.FieldDefs.Add('ANNO_AVV',ftString,4,False);
      Dataset.FieldDefs.Add('ANNO_AVV_FAM',ftString,4,False);
      Dataset.FieldDefs.Add('COMRESFAM',ftString,30,False);
      Dataset.FieldDefs.Add('NOME_PA',ftString,100,False);
      Dataset.FieldDefs.Add('DURATA_PA',ftString,30,False);
      Dataset.FieldDefs.Add('PARENTELA_L104',ftString,40,False);
      Dataset.FieldDefs.Add('FIGLIO3ANNI',ftString,2,False);
      Dataset.FieldDefs.Add('ALTERNATIVA',ftString,40,False);
      Dataset.FieldDefs.Add('NOME_PA_ALT',ftString,100,False);
      Dataset.FieldDefs.Add('MOTIVO_GRADO_3_ALT',ftString,50,False);
    end;
  end;
  //Riepilogo
  if OpzioneRiepilogo then
  begin
    Dataset.FieldDefs.Add('TASSOTIMB',ftFloat);  //Tasso forza lavoro
    Dataset.FieldDefs.Add('TASSOLAV',ftFloat);  //Tasso forza lavoro
    Dataset.FieldDefs.Add('TASSOPRES',ftFloat);  //Tasso presenza
    for i:=0 to ElencoAccorp.Count - 1 do
    begin
      Dataset.FieldDefs.Add('TASSOASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i],ftFloat);
      Dataset.FieldDefs.Add('MEDIAASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i],ftFloat);
      Dataset.FieldDefs.Add('MEDIAASSPRO_' + TipoAccorp + '#' + ElencoAccorp.Strings[i],ftFloat);
      Dataset.FieldDefs.Add('MEDIAASSEV_' + TipoAccorp + '#' + ElencoAccorp.Strings[i],ftFloat);
    end;
    Dataset.FieldDefs.Add('TASSOASS',ftFloat);
    Dataset.FieldDefs.Add('MEDIAASS',ftFloat);
    Dataset.FieldDefs.Add('MEDIAASSPRO',ftFloat);
    Dataset.FieldDefs.Add('MEDIAASSEV',ftFloat);
    Dataset.FieldDefs.Add('PERCENTPRES',ftFloat);  //Percentuale presenza
    Dataset.FieldDefs.Add('PERCENTASS',ftFloat);  //Percentuale assenza
  end;
  if DettDip then
  begin
    s:='GRUPPO_DESC;COGNOME;NOME;MATRICOLA';
    if DettFam then
      s:=s + IfThen(s='','',';') + 'DATANASFAM';
    if DettGG then
      s:=s + IfThen(s='','',';') + 'DATAGIUSTIF';
    Dataset.IndexDefs.Add('Primario',s,[]);
  end
  else
    Dataset.IndexDefs.Add('Primario','GRUPPO',[]);
  Dataset.IndexName:='Primario';
  Dataset.CreateDataSet;
  Dataset.LogChanges:=False;
  for i:=0 to ElencoRighe.Count - 1 do
  begin
    Dataset.FieldByName(Copy(ElencoRighe.Strings[i],Pos('#',ElencoRighe.Strings[i])+1,Length(ElencoRighe.Strings[i])-3)).DisplayLabel:=
      ConvDescDato(Copy(ElencoRighe.Strings[i],Pos('#',ElencoRighe.Strings[i])+1,Length(ElencoRighe.Strings[i])-3));
  end;
end;

procedure TA151FAssenteismoMW.CaricaTabellaRisultato(Tipo,Accorp:String);
begin
  cdsRisultato.First;
  if (Tipo = 'ASS') and DettGG then
    cdsRisultato.Append
  else
  begin
    if cdsRisultato.Locate('GRUPPO',TrimRight(selV430.FieldByName('GRUPPO').AsString),[loCaseInsensitive]) then
      cdsRisultato.Edit
    else
      cdsRisultato.Append;
  end;
  ElaboraTestata;
  if Tipo = 'PRES' then
  begin
    if OpzioneNumDip or OpzioneRiepilogoDip then
      ElaboraNumDip;
    if OpzionePresenze or OpzioneRiepilogoPres then
      ElaboraPresenze;
  end
  else if Tipo = 'EV' then
    ElaboraEventiAssenze(Accorp)
  else if Tipo = 'ASS' then
  begin
    if OpzioneAssenze or OpzioneRiepilogoAss then
      ElaboraAssenze(Accorp);
    if OpzioneAssenzeL104 then
      ElaboraAssenzeL104(Accorp);
  end;
  cdsRisultato.Post;
end;

procedure TA151FAssenteismoMW.ElaboraTestata;
var i:Integer;
begin
  cdsRisultato.FieldByName('GRUPPO').AsString:=TrimRight(selV430.FieldByName('GRUPPO').AsString);
  cdsRisultato.FieldByName('GRUPPO_DESC').AsString:='';
  if DettDip then
  begin
    cdsRisultato.FieldByName('COGNOME').AsString:=selV430.FieldByName('COGNOME').AsString;
    cdsRisultato.FieldByName('NOME').AsString:=selV430.FieldByName('NOME').AsString;
    cdsRisultato.FieldByName('MATRICOLA').AsString:=selV430.FieldByName('MATRICOLA').AsString;
    cdsRisultato.FieldByName('CODFISCALE').AsString:=selV430.FieldByName('CODFISCALE').AsString;
    cdsRisultato.FieldByName('PROGRESSIVO').AsInteger:=selV430.FieldByName('PROGRESSIVO').AsInteger;
  end;
  for i:=0 to ElencoRighe.Count - 1 do
    cdsRisultato.FieldByName(Copy(ElencoRighe.Strings[i],Pos('#',ElencoRighe.Strings[i])+1,Length(ElencoRighe.Strings[i])-3)).AsString:=
      selV430.FieldByName(Copy(ElencoRighe.Strings[i],Pos('#',ElencoRighe.Strings[i])+1,Length(ElencoRighe.Strings[i])-3)).AsString;
end;

procedure TA151FAssenteismoMW.ElaboraNumDip;
var App:Real;
  GGPeriodo:Real;
begin
  GGPeriodo:=AData - DaData + 1;
  //Numero dipendenti in servizio nel periodo, calcolati in base ai gg. servizio
  if (R180IndexOf(ElencoColonne,'100',3) >= 0) then
  begin
    App:=selV430.FieldByName('GG').AsFloat / GGPeriodo;
    cdsRisultato.FieldByName('NUMDIP').AsFloat:=cdsRisultato.FieldByName('NUMDIP').AsFloat + App;
  end;
  //Numero dipendenti in servizio nel periodo, calcolati in base ai gg. servizio e alla % PartTime
  if (R180IndexOf(ElencoColonne,'101',3) >= 0) then
  begin
    App:=selV430.FieldByName('GG').AsFloat / GGPeriodo;
    if (not selV430.FieldByName('PT').IsNull) and (selV430.FieldByName('PT').AsFloat <> 100) then
      cdsRisultato.FieldByName('NUMDIPPT').AsFloat:=cdsRisultato.FieldByName('NUMDIPPT').AsFloat +
                                                    (App * selV430.FieldByName('PT').AsFloat / 100)
    else
      cdsRisultato.FieldByName('NUMDIPPT').AsFloat:=cdsRisultato.FieldByName('NUMDIPPT').AsFloat + App;
  end;
  // Numero dipendenti in servizio alla data indicata come Periodo di riferimento, calcolati a teste
  if (R180IndexOf(ElencoColonne,'102',3) >= 0) or (R180IndexOf(ElencoColonne,'405',3) >= 0) or (R180IndexOf(ElencoColonne,'406',3) >= 0) then
  begin
    if (iNumDipPeriodo = 0) and
       (selV430.FieldByName('DEC').AsDateTime = DaData) then
      cdsRisultato.FieldByName('NUMDIPINIZ').AsFloat:=cdsRisultato.FieldByName('NUMDIPINIZ').AsFloat + 1
    else if (iNumDipPeriodo = 1) and
            (selV430.FieldByName('FINE').AsDateTime = AData) then
      cdsRisultato.FieldByName('NUMDIPFINE').AsFloat:=cdsRisultato.FieldByName('NUMDIPFINE').AsFloat + 1;
  end;
  // Numero dipendenti in servizio alla data indicata come Periodo di riferimento, calcolati in base alla % pt
  if (R180IndexOf(ElencoColonne,'103',3) >= 0) then
  begin
    if (iNumDipPeriodo = 0) and
       (selV430.FieldByName('DEC').AsDateTime = DaData) then
    begin
      if (not selV430.FieldByName('PT').IsNull) and (selV430.FieldByName('PT').AsFloat <> 100) then
        cdsRisultato.FieldByName('NUMDIPINIZPT').AsFloat:=cdsRisultato.FieldByName('NUMDIPINIZPT').AsFloat +
                                                        (selV430.FieldByName('PT').AsFloat / 100)
      else
        cdsRisultato.FieldByName('NUMDIPINIZPT').AsFloat:=cdsRisultato.FieldByName('NUMDIPINIZPT').AsFloat + 1;
    end
    else if (iNumDipPeriodo = 1) and
            (selV430.FieldByName('FINE').AsDateTime = AData) then
    begin
      if (not selV430.FieldByName('PT').IsNull) and (selV430.FieldByName('PT').AsFloat <> 100) then
        cdsRisultato.FieldByName('NUMDIPFINEPT').AsFloat:=cdsRisultato.FieldByName('NUMDIPFINEPT').AsFloat +
                                                        (selV430.FieldByName('PT').AsFloat / 100)
      else
        cdsRisultato.FieldByName('NUMDIPFINEPT').AsFloat:=cdsRisultato.FieldByName('NUMDIPFINEPT').AsFloat + 1;
    end;
  end;
  // Numero dipendenti medio
  if (R180IndexOf(ElencoColonne,'105',3) >= 0) then
  begin
    if selV430.FieldByName('FINE').AsDateTime = R180FineMese(selV430.FieldByName('FINE').AsDateTime) then
      App:=(R180Mese(selV430.FieldByName('FINE').AsDateTime) - R180Mese(selV430.FieldByName('DEC').AsDateTime) + 1) / 12
    else
      App:=(R180Mese(selV430.FieldByName('FINE').AsDateTime) - R180Mese(selV430.FieldByName('DEC').AsDateTime)) / 12;
    cdsRisultato.FieldByName('NUMDIPMEDIO').AsFloat:=cdsRisultato.FieldByName('NUMDIPMEDIO').AsFloat + App;
  end;
end;

procedure TA151FAssenteismoMW.ElaboraPresenze;
var s:String;
begin
  selT920.Close;
  selT920.SetVariable('TABELLA', Tabella);
  selT920.SetVariable('PROGRESSIVO', selV430.FieldByName('PROGRESSIVO').AsInteger);
  selT920.SetVariable('DADATA', selV430.FieldByName('DEC').AsDateTime);
  selT920.SetVariable('ADATA', selV430.FieldByName('FINE').AsDateTime);
  if PresGGLav then
    selT920.SetVariable('GGLAV', ' AND DC_GGLAVORATIVO = 1')
  else
    selT920.SetVariable('GGLAV', ' ');
  s:='';
  if (R180IndexOf(ElencoColonne,'200',3) >= 0) or
     (R180IndexOf(ElencoColonne,'400',3) >= 0) or (R180IndexOf(ElencoColonne,'401',3) >= 0) or
     (R180IndexOf(ElencoColonne,'402',3) >= 0) or (R180IndexOf(ElencoColonne,'403',3) >= 0) or
     (R180IndexOf(ElencoColonne,'506',3) >= 0) or (R180IndexOf(ElencoColonne,'507',3) >= 0) then
    s:=s + IfThen(s='','',',') + ' SUM(DC_GGLAVORATIVO) TOT';
  if (R180IndexOf(ElencoColonne,'201',3) >= 0) or (R180IndexOf(ElencoColonne,'400',3) >= 0) then
    s:=s + IfThen(s='','',',') + ' SUM(DC_GGTIMBRATO) TOTTIMB';
  if (R180IndexOf(ElencoColonne,'202',3) >= 0) or (R180IndexOf(ElencoColonne,'401',3) >= 0) then
    s:=s + IfThen(s='','',',') + ' SUM(DC_GGLAVORATO) TOTLAV';
  if (R180IndexOf(ElencoColonne,'203',3) >= 0) or (R180IndexOf(ElencoColonne,'402',3) >= 0) or (R180IndexOf(ElencoColonne,'507',3) >= 0) then
    s:=s + IfThen(s='','',',') + ' SUM(DC_GGPRESENZA) TOTPRES';
  if (R180IndexOf(ElencoColonne,'204',3) >= 0) then
    s:=s + IfThen(s='','',',') + ' SUM(DC_ORETIMBRATE) ORETIMB';
  if (R180IndexOf(ElencoColonne,'205',3) >= 0) then
    s:=s + IfThen(s='','',',') + ' SUM(DC_ORELAVORATE) ORELAV';
  if (R180IndexOf(ElencoColonne,'206',3) >= 0) then
    s:=s + IfThen(s='','',',') + ' SUM(DC_OREPRESENZA) OREPRES';
  if (R180IndexOf(ElencoColonne,'207',3) >= 0) then
    s:=s + IfThen(s='','',',') + ' SUM(DC_ORESTRAORD) ORESTRAORD';
  if (R180IndexOf(ElencoColonne,'208',3) >= 0) then
    s:=s + IfThen(s='','',',') + ' SUM(DC_OREDEBITO) OREDEBITO';
  if (R180IndexOf(ElencoColonne,'900',3) >= 0) then
    s:=s + IfThen(s='','',',') + ' SUM(DC_LIBERO_NUM) LIBERO_NUM';
  if (R180IndexOf(ElencoColonne,'901',3) >= 0) then
    s:=s + IfThen(s='','',',') + ' SUM(DC_LIBERO_ORA) LIBERO_ORA';
  selT920.SetVariable('DATI', s);
  selT920.Open;
  if selT920.RecordCount > 0 then
  begin
    if (R180IndexOf(ElencoColonne,'200',3) >= 0)  or
       (R180IndexOf(ElencoColonne,'400',3) >= 0) or (R180IndexOf(ElencoColonne,'401',3) >= 0) or
       (R180IndexOf(ElencoColonne,'402',3) >= 0) or (R180IndexOf(ElencoColonne,'403',3) >= 0) or
       (R180IndexOf(ElencoColonne,'506',3) >= 0) or (R180IndexOf(ElencoColonne,'507',3) >= 0) then
      cdsRisultato.FieldByName('GGTOT').AsFloat:=cdsRisultato.FieldByName('GGTOT').AsFloat + selT920.FieldByName('TOT').AsFloat;
    if (R180IndexOf(ElencoColonne,'201',3) >= 0) or (R180IndexOf(ElencoColonne,'400',3) >= 0) then
      cdsRisultato.FieldByName('GGTIMB').AsFloat:=cdsRisultato.FieldByName('GGTIMB').AsFloat + selT920.FieldByName('TOTTIMB').AsFloat;
    if (R180IndexOf(ElencoColonne,'202',3) >= 0) or (R180IndexOf(ElencoColonne,'401',3) >= 0) then
      cdsRisultato.FieldByName('GGLAV').AsFloat:=cdsRisultato.FieldByName('GGLAV').AsFloat + selT920.FieldByName('TOTLAV').AsFloat;
    if (R180IndexOf(ElencoColonne,'203',3) >= 0) or (R180IndexOf(ElencoColonne,'402',3) >= 0) or (R180IndexOf(ElencoColonne,'507',3) >= 0) then
      cdsRisultato.FieldByName('GGPRES').AsFloat:=cdsRisultato.FieldByName('GGPRES').AsFloat + selT920.FieldByName('TOTPRES').AsFloat;
    if (R180IndexOf(ElencoColonne,'204',3) >= 0) then
      cdsRisultato.FieldByName('ORETIMB').AsString:=Format('%10s',[R180MinutiOre(R180OreMinutiExt(cdsRisultato.FieldByName('ORETIMB').AsString) + selT920.FieldByName('ORETIMB').AsInteger)]);
    if (R180IndexOf(ElencoColonne,'205',3) >= 0) then
      cdsRisultato.FieldByName('ORELAV').AsString:=Format('%10s',[R180MinutiOre(R180OreMinutiExt(cdsRisultato.FieldByName('ORELAV').AsString) + selT920.FieldByName('ORELAV').AsInteger)]);
    if (R180IndexOf(ElencoColonne,'206',3) >= 0) then
      cdsRisultato.FieldByName('OREPRES').AsString:=Format('%10s',[R180MinutiOre(R180OreMinutiExt(cdsRisultato.FieldByName('OREPRES').AsString) + selT920.FieldByName('OREPRES').AsInteger)]);
    if (R180IndexOf(ElencoColonne,'207',3) >= 0) then
    begin
      if selV430.FieldByName('PROGRESSIVO').AsInteger <> OldProg then
        OldStraord:=0
      else
      begin
        if (selT920.FieldByName('ORESTRAORD').AsInteger < 0) and (OldStraord > 0) then
        begin
          if -selT920.FieldByName('ORESTRAORD').AsInteger <= OldStraord then
          begin
            cdsRisultato.FieldByName('ORESTRAORD').AsString:=Format('%10s',[R180MinutiOre(R180OreMinutiExt(cdsRisultato.FieldByName('ORESTRAORD').AsString) + selT920.FieldByName('ORESTRAORD').AsInteger)]);
            OldStraord:=OldStraord + selT920.FieldByName('ORESTRAORD').AsInteger;
          end
          else
          begin
            cdsRisultato.FieldByName('ORESTRAORD').AsString:=Format('%10s',[R180MinutiOre(R180OreMinutiExt(cdsRisultato.FieldByName('ORESTRAORD').AsString) - OldStraord)]);
            OldStraord:=0;
          end;
        end;
      end;
      if selT920.FieldByName('ORESTRAORD').AsInteger >= 0 then
      begin
        cdsRisultato.FieldByName('ORESTRAORD').AsString:=Format('%10s',[R180MinutiOre(R180OreMinutiExt(cdsRisultato.FieldByName('ORESTRAORD').AsString) + selT920.FieldByName('ORESTRAORD').AsInteger)]);
        OldStraord:=selT920.FieldByName('ORESTRAORD').AsInteger;
      end;
      OldProg:=selV430.FieldByName('PROGRESSIVO').AsInteger;
    end;
    if (R180IndexOf(ElencoColonne,'208',3) >= 0) then
      cdsRisultato.FieldByName('OREDEBITO').AsString:=Format('%10s',[R180MinutiOre(R180OreMinutiExt(cdsRisultato.FieldByName('OREDEBITO').AsString) + selT920.FieldByName('OREDEBITO').AsInteger)]);
    //Dato libero numerico
    if (R180IndexOf(ElencoColonne,'900',3) >= 0) then
      cdsRisultato.FieldByName('LIBERO_NUM').AsFloat:=cdsRisultato.FieldByName('LIBERO_NUM').AsFloat + selT920.FieldByName('LIBERO_NUM').AsFloat;
    //Dato libero orario
    if (R180IndexOf(ElencoColonne,'901',3) >= 0) then
      cdsRisultato.FieldByName('LIBERO_ORA').AsString:=Format('%10s',[R180MinutiOre(R180OreMinutiExt(cdsRisultato.FieldByName('LIBERO_ORA').AsString) + selT920.FieldByName('LIBERO_ORA').AsInteger)]);
  end;
end;

procedure TA151FAssenteismoMW.ElaboraEventiAssenze(Accorp:String);
var j,TotGiorniMMPrec,TotGiorniMMSucc:Integer;
  s:String;
begin
  //-------------------------------------------------------------
  // CONTEGGIO Eventi di assenza > 10 giorni
  //-------------------------------------------------------------
  if OldProg <> selV430.FieldByName('PROGRESSIVO').AsInteger then
  begin
    OldData:=0;
    NumEventi:=0;
    TotGiorniMMCorr:=0;
    EventoAss:=False;
    if cdsDettaglio.State in [dsEdit,dsInsert] then
      cdsDettaglio.Post;
    if cdsDettaglio.Locate('PROGRESSIVO',selV430.FieldByName('PROGRESSIVO').AsInteger,[]) then
      cdsDettaglio.Edit
    else
      cdsDettaglio.Insert;
    cdsDettaglio.FieldByName('PROGRESSIVO').AsInteger:=selV430.FieldByName('PROGRESSIVO').AsInteger;
  end;

  //IMPOSTAZIONE DEI PARAMETRI PER L'APERTURA DEL DATASET ASSENZE selT920Ass
  selT920Ass.SetVariable('TABELLA', Tabella);
  selT920Ass.SetVariable('PROGRESSIVO', selV430.FieldByName('PROGRESSIVO').AsInteger);
  selT920Ass.SetVariable('DADATA', selV430.FieldByName('DEC').AsDateTime);
  selT920Ass.SetVariable('ADATA', selV430.FieldByName('FINE').AsDateTime);
  selT920Ass.SetVariable('TIPOACCORP', TipoAccorp);
  s:='';
  if FruizGG then
    s:=s + '''I''';
  if FruizMG then
  begin
    if Trim(s) <> '' then
      s:=s + ',';
    s:=s + '''M''';
  end;
  if FruizHH then
  begin
    if Trim(s) <> '' then
      s:=s + ',';
    s:=s + '''N''';
  end;
  if FruizDH then
  begin
    if Trim(s) <> '' then
      s:=s + ',';
    s:=s + '''D''';
  end;
  if Trim(s) = '' then
    s:='''I'',''M'',''N'',''D''';
  selT920Ass.SetVariable('UM', s);
  selT920Ass.Close;
  selT920Ass.Open;

  selT920Ass.Filter:='COD_CODICIACCORPCAUSALI = ''' + Accorp + '''';
  selT920Ass.Filtered:=True;
  if selT920Ass.RecordCount <= 0 then
    Exit;
  TotGiorniMMPrec:=0;
  TotGiorniMMSucc:=0;
  selT920Ass.First;
  //se l'assenza è sul primo giorno del mese, conto le assenze del mese precedente (es. se DataConteggio = 1/12 conta quelle tra 1/11 e 30/11)
  if selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime = R180InizioMese(selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime) then
  begin
    selT040.Close;
    selT040.SetVariable('PROGRESSIVO', selV430.FieldByName('PROGRESSIVO').AsInteger);
    selT040.SetVariable('DADATA', R180InizioMese(selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime-1));  //Inizio mese prec.
    selT040.SetVariable('ADATA', selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime-1);  //Fine mese prec.
    selT040.SetVariable('TIPOACCORP', TipoAccorp);
    selT040.SetVariable('CODACCORP', Accorp);
    selT040.SetVariable('ORDINAMENTO','ORDER BY T040.DATA DESC');
    selT040.Open;
    OldData:=selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime;
    while not selT040.Eof do
    begin
      if selT040.FieldByName('DATA').AsDateTime = OldData - 1 then
      begin
        TotGiorniMMPrec:=TotGiorniMMPrec + 1;
        OldData:=selT040.FieldByName('DATA').AsDateTime;
      end
      else
        Break;
      selT040.Next;
    end;
    OldData:=selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime-1;
  end;
  while not selT920Ass.Eof do  //CICLO PER OGNI GIUSTIFICATIVO
  begin
    if selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime = OldData + 1 then
    begin
      TotGiorniMMCorr:=TotGiorniMMCorr + 1;
      if TotGiorniMMPrec + TotGiorniMMCorr > 10 then
      begin
        if not EventoAss then
        begin
          NumEventi:=NumEventi + 1;
          EventoAss:=True;
          for j:=1 to 10 do
            cdsDettaglio.FieldByName('DATE_' + TipoAccorp + '#' + Accorp).AsString:=cdsDettaglio.FieldByName('DATE_' + TipoAccorp + '#' + Accorp).AsString + DateToStr(selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime-j) + ',';
        end;
        cdsDettaglio.FieldByName('DATE_' + TipoAccorp + '#' + Accorp).AsString:=cdsDettaglio.FieldByName('DATE_' + TipoAccorp + '#' + Accorp).AsString + DateToStr(selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime) + ',';
      end;
    end
    else
    begin
      TotGiorniMMPrec:=0;
      TotGiorniMMCorr:=1;
      EventoAss:=False;
    end;
    OldData:=selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime;
    selT920Ass.Next;
  end;
  //Se l'assenza è sull'ultimo giorno del mese, conto le assenze del mese successivo
  if selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime = R180FineMese(selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime) then
  begin
    selT040.Close;
    selT040.SetVariable('PROGRESSIVO', selV430.FieldByName('PROGRESSIVO').AsInteger);
    selT040.SetVariable('DADATA', selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime+1);  //Inizio mese prec.
    selT040.SetVariable('ADATA', R180FineMese(selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime+1));  //Fine mese prec.
    selT040.SetVariable('TIPOACCORP', TipoAccorp);
    selT040.SetVariable('CODACCORP', Accorp);
    selT040.SetVariable('ORDINAMENTO','ORDER BY T040.DATA');
    selT040.Open;
    OldData:=selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime;
    while not selT040.Eof do
    begin
      if selT040.FieldByName('DATA').AsDateTime = OldData + 1 then
      begin
        TotGiorniMMSucc:=TotGiorniMMSucc + 1;
        OldData:=selT040.FieldByName('DATA').AsDateTime;
      end
      else
        Break;
      selT040.Next;
    end;

    if (TotGiorniMMSucc > 0) and (TotGiorniMMSucc + TotGiorniMMCorr > 10) then
    begin
      cdsDettaglio.FieldByName('DATE_' + TipoAccorp + '#' + Accorp).AsString:=cdsDettaglio.FieldByName('DATE_' + TipoAccorp + '#' + Accorp).AsString + DateToStr(selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime) + ',';
      for j:=1 to TotGiorniMMCorr do
        cdsDettaglio.FieldByName('DATE_' + TipoAccorp + '#' + Accorp).AsString:=cdsDettaglio.FieldByName('DATE_' + TipoAccorp + '#' + Accorp).AsString + DateToStr(selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime-j) + ',';
      if EventoAss and (NumEventi > 0) then
        NumEventi:=NumEventi - 1;
    end;
  end;

  selT920Ass.Filter:='';
  selT920Ass.Filtered:=False;
end;

procedure TA151FAssenteismoMW.ElaboraAssenze(Accorp:String);
var DebSett,GGLav,OldGGLav,DebitoGG,
  ContaHHGiornata,TotHHPeriodo:Integer;
  ContaGGGiornata,TotGGPeriodo,TotGGPeriodoNoEventi:Real;
  MaxData,MinData,OldDataNas:TDateTime;
  s,UM,OldCausale:String;
begin
  //-------------------------------------------------------------
  // CONTEGGIO GG.Assenza o Num.Dip.assenza
  //-------------------------------------------------------------
  //IMPOSTAZIONE DEI PARAMETRI PER L'APERTURA DEL DATASET ASSENZE selT920Ass
  selT920Ass.SetVariable('TABELLA', Tabella);
  selT920Ass.SetVariable('PROGRESSIVO', selV430.FieldByName('PROGRESSIVO').AsInteger);
  selT920Ass.SetVariable('DADATA', selV430.FieldByName('DEC').AsDateTime);
  selT920Ass.SetVariable('ADATA', selV430.FieldByName('FINE').AsDateTime);
  selT920Ass.SetVariable('TIPOACCORP', TipoAccorp);
  s:='';
  if FruizGG then
    s:=s + '''I''';
  if FruizMG then
  begin
    if Trim(s) <> '' then
      s:=s + ',';
    s:=s + '''M''';
  end;
  if FruizHH then
  begin
    if Trim(s) <> '' then
      s:=s + ',';
    s:=s + '''N''';
  end;
  if FruizDH then
  begin
    if Trim(s) <> '' then
      s:=s + ',';
    s:=s + '''D''';
  end;
  if Trim(s) = '' then
    s:='''I'',''M'',''N'',''D''';
  selT920Ass.SetVariable('UM', s);
  //APERTURA DEL DATASET ASSENZE selT920Ass
  selT920Ass.Close;
  selT920Ass.Open;
  selT920Ass.Filter:='COD_CODICIACCORPCAUSALI = ''' + Accorp + '''';
  selT920Ass.Filtered:=True;
  if selT920Ass.RecordCount <= 0 then
    Exit;
  ContaGGGiornata:=0;
  ContaHHGiornata:=0;
  TotGGPeriodo:=0;
  TotGGPeriodoNoEventi:=0;
  TotHHPeriodo:=0;
  if selT920Ass.RecordCount > 0 then  //FILTRO LE ASSENZE DELL'ACCORPAMENTO IN ELABORAZIONE
  begin
    selT920Ass.First;
    MinData:=selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime;
    selT920Ass.Last;
    MaxData:=selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime;
    selT920Ass.First;
    UM:=selT920Ass.FieldByName('ASSENZAUMFRUIZIONE').AsString;
    if selT920Ass.FieldByName('ASSENZAUMFRUIZIONE').AsString = 'M' then
      UM:='I';
    if selT920Ass.FieldByName('ASSENZAUMFRUIZIONE').AsString = 'D' then
      UM:='N';
    if ((MaxData - MinData + 1) <= MaxGG) then  //Verifica il max periodo considerato
    begin
      selT920AssGG.SetVariable('PROGRESSIVO',selV430.FieldByName('PROGRESSIVO').AsInteger);
      selT920AssGG.SetVariable('DATA',selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime);
      selT920AssGG.SetVariable('TABELLA',Tabella);
      selT920AssGG.Execute;
      if selT920AssGG.RowCount > 0 then
      begin
        OldGGLav:=StrToIntDef(VarToStr(selT920AssGG.Field(0)),0);
        DebSett:=StrToIntDef(VarToStr(selT920AssGG.Field(1)),0);
        GGLav:=StrToIntDef(VarToStr(selT920AssGG.Field(2)),0);
        DebitoGG:=StrToIntDef(VarToStr(selT920AssGG.Field(3)),0);
      end
      else
      begin
        OldGGLav:=0;
        DebSett:=0;
        GGLav:=0;
        DebitoGG:=0;
      end;
      OldData:=selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime;
      OldCausale:=selT920Ass.FieldByName('ASSENZACAUSALE').AsString;
      OldDataNas:=selT920Ass.FieldByName('ASSENZADATAFAMILIARE').AsDateTime;
      //CICLO PER OGNI GIUSTIFICATIVO
      while not selT920Ass.Eof do
      begin
        if DebSett = 0 then
          RegistraMsg.InserisciMessaggio('I',Format(A000MSG_A151_MSG_DEBITO_0_ORE,[selT920Ass.FieldByName('DATACONTEGGIO').AsString]),'',selV430.FieldByName('PROGRESSIVO').AsInteger);
        if GGLav = 0 then
          RegistraMsg.InserisciMessaggio('I',Format(A000MSG_A151_MSG_0_GIORNI_LAVORATIVI,[selT920Ass.FieldByName('DATACONTEGGIO').AsString]),'',selV430.FieldByName('PROGRESSIVO').AsInteger);

        //Se la data cambia e ContaGG <> 0
        if ((OldData <> selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime) or
            (DettFam and (OldDataNas <> selT920Ass.FieldByName('ASSENZADATAFAMILIARE').AsDateTime))) and
           ((ContaGGGiornata <> 0) or (ContaHHGiornata <> 0)) then
        begin
          if GGInt then
          begin
            if iDebitoGGInt = 0 then //debito da calendario
            begin
              if (GGLav <> 0) and (R180AzzeraPrecisione((ContaGGGiornata * Trunc(DebSett / GGLav))-Trunc(DebSett / GGLav),2)<0) then
                ContaGGGiornata:=0;
              if (GGLav <> 0) and (R180AzzeraPrecisione(ContaHHGiornata-Trunc(DebSett / GGLav),2) < 0) then
                ContaHHGiornata:=0;
            end
            else  //debito giornaliero
            begin
              if (GGLav <> 0) and (R180AzzeraPrecisione((ContaGGGiornata * DebitoGG)-DebitoGG,2)<0) then
                ContaGGGiornata:=0;
              if (GGLav <> 0) and (R180AzzeraPrecisione(ContaHHGiornata-DebitoGG,2)<0) then
                ContaHHGiornata:=0;
            end;
          end;
          if (not AssQM) and (ContaGGGiornata > 1) then  //per ogni gg. posso avere al max 1 gg. di assenza
            ContaGGGiornata:=1;
          //Totalizzo nei contatori del periodo
          TotGGPeriodo:=TotGGPeriodo + ContaGGGiornata;
          TotHHPeriodo:=TotHHPeriodo + ContaHHGiornata;
          if ((R180IndexOf(ElencoColonne,'303',3) >= 0) or (R180IndexOf(ElencoColonne,'406',3) >= 0)) then
          begin
            if (cdsDettaglio.Locate('PROGRESSIVO',selV430.FieldByName('PROGRESSIVO').AsInteger,[])) and
               (cdsDettaglio.FieldByName('DATE_' + TipoAccorp + '#' + Accorp).AsString <> '') then  //Se ci sono dei periodi > 10 gg.
            begin
              //Conto l'assenza solo se non è tra quella degli eventi
              if Pos(','+DateToStr(OldData)+',', ','+cdsDettaglio.FieldByName('DATE_' + TipoAccorp + '#' + Accorp).AsString+',') <= 0 then
                TotGGPeriodoNoEventi:=TotGGPeriodoNoEventi+ ContaGGGiornata;
            end
            else
              TotGGPeriodoNoEventi:=TotGGPeriodoNoEventi+ ContaGGGiornata;
          end;

          if (R180IndexOf(ElencoColonne,'300',3) >= 0) or
             (R180IndexOf(ElencoColonne,'403',3) >= 0) or (R180IndexOf(ElencoColonne,'404',3) >= 0) or
             (R180IndexOf(ElencoColonne,'405',3) >= 0) or
             (R180IndexOf(ElencoColonne,'506',3) >= 0) then
          begin
            cdsRisultato.FieldByName('GGASS_' + TipoAccorp + '#' + Accorp).AsFloat:=
              cdsRisultato.FieldByName('GGASS_' + TipoAccorp + '#' + Accorp).AsFloat + ContaGGGiornata;
            cdsRisultato.FieldByName('GGASS').AsFloat:=cdsRisultato.FieldByName('GGASS').AsFloat + ContaGGGiornata;
          end;
          if (R180IndexOf(ElencoColonne,'301',3) >= 0) then
          begin
            cdsRisultato.FieldByName('HHASS_' + TipoAccorp + '#' + Accorp).AsString:=
              R180MinutiOre(R180OreMinutiExt(cdsRisultato.FieldByName('HHASS_' + TipoAccorp + '#' + Accorp).AsString) + ContaHHGiornata);
            cdsRisultato.FieldByName('HHASS').AsString:=R180MinutiOre(R180OreMinutiExt(cdsRisultato.FieldByName('HHASS').AsString) + ContaHHGiornata);
          end;
          if DettGG then
          begin
            cdsRisultato.FieldByName('DATAGIUSTIF').AsDateTime:=OldData;
            cdsRisultato.FieldByName('CAUSALE').AsString:=OldCausale;
            if DettFam then
            begin
              if OldDataNas <> 0 then
                cdsRisultato.FieldByName('DATANASFAM').AsDateTime:=OldDataNas;
              ElaboraFamiliare(selV430.FieldByName('PROGRESSIVO').AsInteger,OldDataNas,OldData);
            end;
            cdsRisultato.Post;
            cdsRisultato.Append;
            ElaboraTestata;
          end;
          //Azzero i contatori della giornata
          ContaGGGiornata:=0;
          ContaHHGiornata:=0;
        end;
        //Se la data cambia
        if OldData <> selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime then
        begin
          selT920AssGG.SetVariable('PROGRESSIVO',selV430.FieldByName('PROGRESSIVO').AsInteger);
          selT920AssGG.SetVariable('DATA',selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime);
          selT920AssGG.SetVariable('TABELLA',Tabella);
          selT920AssGG.Execute;
          if selT920AssGG.RowCount > 0 then
          begin
            OldGGLav:=StrToIntDef(VarToStr(selT920AssGG.Field(0)),0);
            DebSett:=StrToIntDef(VarToStr(selT920AssGG.Field(1)),0);
            GGLav:=StrToIntDef(VarToStr(selT920AssGG.Field(2)),0);
            DebitoGG:=StrToIntDef(VarToStr(selT920AssGG.Field(3)),0);
          end
          else
          begin
            OldGGLav:=0;
            DebSett:=0;
            GGLav:=0;
            DebitoGG:=0;
          end;
        end;
        //Per ogni data considerata
        if (AssGGLav) and (OldGGLav = 0) then  //Se 'Solo GG.lav' e il giorno non è lav.
        begin
          ContaGGGiornata:=0;
          ContaHHGiornata:=0;
        end
        else if AssQM then  //Se tutti i giorni oppure 'Solo GG.lav' e il giorno è lav., se QM
        begin
          selDebitoGGQM.SetVariable('PROGRESSIVO',selV430.FieldByName('PROGRESSIVO').AsInteger);
          selDebitoGGQM.SetVariable('DATA',selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime);
          selDebitoGGQM.Execute;
          if (selDebitoGGQM.RowsProcessed > 0) and (selT920Ass.FieldByName('ASSRESE').AsInteger <> 0) and
             (Trim(VarToStr(selDebitoGGQM.Field(0))) <> '') and (Trim(VarToStr(selDebitoGGQM.Field(0))) <> '.') then
          begin
            ContaGGGiornata:=ContaGGGiornata + selT920Ass.FieldByName('ASSRESE').AsInteger / R180OreMinutiExt(Trim(VarToStr(selDebitoGGQM.Field(0))));
            if (selT920Ass.FieldByName('ASSGIORN').AsFloat > 0) and (DebSett <> 0) and (GGLav <> 0) and
               (selT920Ass.FieldByName('ASSRESE').AsInteger / Trunc(DebSett / GGLav) > selT920Ass.FieldByName('ASSGIORN').AsFloat) then
              ContaHHGiornata:=ContaHHGiornata + Trunc(selT920Ass.FieldByName('ASSGIORN').AsFloat * (DebSett / GGLav))
            else
              ContaHHGiornata:=ContaHHGiornata + selT920Ass.FieldByName('ASSRESE').AsInteger;
          end
          else
          begin
            if (selT920Ass.FieldByName('ASSRESE').AsInteger <> 0) and (DebSett <> 0) and (GGLav <> 0) then
            begin
              if iDebitoGGInt = 0 then //debito da calendario
                ContaGGGiornata:=ContaGGGiornata + selT920Ass.FieldByName('ASSRESE').AsInteger / Trunc(DebSett / GGLav)
              else  //debito giornaliero
              begin
                if DebitoGG <> 0 then
                  ContaGGGiornata:=ContaGGGiornata + selT920Ass.FieldByName('ASSRESE').AsInteger / DebitoGG
                else
                  ContaGGGiornata:=ContaGGGiornata + selT920Ass.FieldByName('ASSRESE').AsInteger / Trunc(DebSett / GGLav);
              end;
              ContaHHGiornata:=ContaHHGiornata + selT920Ass.FieldByName('ASSRESE').AsInteger;
            end
            else
            begin
              ContaGGGiornata:=ContaGGGiornata + selT920Ass.FieldByName('ASSGIORN').AsFloat;
              if (DebSett <> 0) and (GGLav <> 0) then
                ContaHHGiornata:=ContaHHGiornata + Trunc(selT920Ass.FieldByName('ASSGIORN').AsFloat * (DebSett / GGLav));;
            end;
          end;
        end
        else //Se tutti i giorni oppure 'Solo GG.lav' e il giorno è lav., se no QM
        begin
          if (selT920Ass.FieldByName('ASSRESE').AsInteger <> 0) and (DebSett <> 0) and (GGLav <> 0) then
          begin
            if iDebitoGGInt = 0 then //debito da calendario
              ContaGGGiornata:=ContaGGGiornata + selT920Ass.FieldByName('ASSRESE').AsInteger / Trunc(DebSett / GGLav)
            else  //debito giornaliero
            begin
              if DebitoGG <> 0 then
                ContaGGGiornata:=ContaGGGiornata + selT920Ass.FieldByName('ASSRESE').AsInteger / DebitoGG
              else
                ContaGGGiornata:=ContaGGGiornata + selT920Ass.FieldByName('ASSRESE').AsInteger / Trunc(DebSett / GGLav);
            end;
            ContaHHGiornata:=ContaHHGiornata + selT920Ass.FieldByName('ASSRESE').AsInteger;
          end
          else
          begin
            ContaGGGiornata:=ContaGGGiornata + selT920Ass.FieldByName('ASSGIORN').AsFloat;
            if (DebSett <> 0) and (GGLav <> 0) then
              ContaHHGiornata:=ContaHHGiornata + Trunc(selT920Ass.FieldByName('ASSGIORN').AsFloat * (DebSett / GGLav));;
          end;
        end;
        //Salvataggio dati del record vecchio
        OldData:=selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime;
        OldCausale:=selT920Ass.FieldByName('ASSENZACAUSALE').AsString;
        OldDataNas:=selT920Ass.FieldByName('ASSENZADATAFAMILIARE').AsDateTime;
        if (((selT920Ass.FieldByName('ASSENZAUMFRUIZIONE').AsString = 'N') or (selT920Ass.FieldByName('ASSENZAUMFRUIZIONE').AsString = 'D')) and (UM = 'I')) or
           (((selT920Ass.FieldByName('ASSENZAUMFRUIZIONE').AsString = 'I') or (selT920Ass.FieldByName('ASSENZAUMFRUIZIONE').AsString = 'M')) and (UM = 'N')) then
          RegistraMsg.InserisciMessaggio('I',A000MSG_A151_MSG_TIPI_FRUIZIONE,'',selV430.FieldByName('PROGRESSIVO').AsInteger);
        UM:=selT920Ass.FieldByName('ASSENZAUMFRUIZIONE').AsString;
        if selT920Ass.FieldByName('ASSENZAUMFRUIZIONE').AsString = 'M' then
          UM:='I';
        if selT920Ass.FieldByName('ASSENZAUMFRUIZIONE').AsString = 'D' then
          UM:='N';
        //Lettura nuovo record
        selT920Ass.Next;
      end;
      //--- FINE CICLO
      if (ContaGGGiornata <> 0) or (ContaHHGiornata <> 0) then  //Se Totale assenze del giorno <> 0
      begin
        if GGInt then  //Se 'Solo ass. a gg.intera' e il Totale ass. non copre il debito della giornata, azzero il totale
        begin
          if iDebitoGGInt = 0 then //debito da calendario
          begin
            if (GGLav <> 0) and (R180AzzeraPrecisione((ContaGGGiornata * Trunc(DebSett / GGLav))-Trunc(DebSett / GGLav),2)<0) then
              ContaGGGiornata:=0;
            if (GGLav <> 0) and (R180AzzeraPrecisione(ContaHHGiornata-Trunc(DebSett / GGLav),2) < 0) then
              ContaHHGiornata:=0;
          end
          else  //debito giornaliero
          begin
            if (GGLav <> 0) and (R180AzzeraPrecisione((ContaGGGiornata * DebitoGG)-DebitoGG,2)<0) then
              ContaGGGiornata:=0;
            if (GGLav <> 0) and (R180AzzeraPrecisione(ContaHHGiornata-DebitoGG,2)<0) then
              ContaHHGiornata:=0;
          end;
        end;
        if (not AssQM) and (ContaGGGiornata > 1) then  //per ogni gg. posso avere al max 1 gg. di assenza
          ContaGGGiornata:=1;
        //Totalizzo
        TotGGPeriodo:=TotGGPeriodo + ContaGGGiornata;
        TotHHPeriodo:=TotHHPeriodo + ContaHHGiornata;
        if ((R180IndexOf(ElencoColonne,'303',3) >= 0) or (R180IndexOf(ElencoColonne,'406',3) >= 0)) then
        begin
          if (cdsDettaglio.Locate('PROGRESSIVO',selV430.FieldByName('PROGRESSIVO').AsInteger,[])) and
             (cdsDettaglio.FieldByName('DATE_' + TipoAccorp + '#' + Accorp).AsString <> '') then  //Se ci sono dei periodi > 10 gg.
          begin
            //Conto l'assenza solo se non è tra quella degli eventi
            if Pos(','+DateToStr(OldData)+',', ','+cdsDettaglio.FieldByName('DATE_' + TipoAccorp + '#' + Accorp).AsString+',') <= 0 then
              TotGGPeriodoNoEventi:=TotGGPeriodoNoEventi+ ContaGGGiornata;
          end
          else
            TotGGPeriodoNoEventi:=TotGGPeriodoNoEventi+ ContaGGGiornata;
        end;

        if (R180IndexOf(ElencoColonne,'300',3) >= 0) or
           (R180IndexOf(ElencoColonne,'403',3) >= 0) or (R180IndexOf(ElencoColonne,'404',3) >= 0) or
           (R180IndexOf(ElencoColonne,'405',3) >= 0) or
           (R180IndexOf(ElencoColonne,'506',3) >= 0) then
        begin
          cdsRisultato.FieldByName('GGASS_' + TipoAccorp + '#' + Accorp).AsFloat:=
            cdsRisultato.FieldByName('GGASS_' + TipoAccorp + '#' + Accorp).AsFloat + ContaGGGiornata;
          cdsRisultato.FieldByName('GGASS').AsFloat:=cdsRisultato.FieldByName('GGASS').AsFloat + ContaGGGiornata;
        end;
        if (R180IndexOf(ElencoColonne,'301',3) >= 0) then
        begin
          cdsRisultato.FieldByName('HHASS_' + TipoAccorp + '#' + Accorp).AsString:=
            R180MinutiOre(R180OreMinutiExt(cdsRisultato.FieldByName('HHASS_' + TipoAccorp + '#' + Accorp).AsString) + ContaHHGiornata);
          cdsRisultato.FieldByName('HHASS').AsString:=R180MinutiOre(R180OreMinutiExt(cdsRisultato.FieldByName('HHASS').AsString) + ContaHHGiornata);
        end;
        if DettGG then
        begin
          cdsRisultato.FieldByName('DATAGIUSTIF').AsDateTime:=OldData;
          cdsRisultato.FieldByName('CAUSALE').AsString:=OldCausale;
          if DettFam then
          begin
            if OldDataNas <> 0 then
              cdsRisultato.FieldByName('DATANASFAM').AsDateTime:=OldDataNas;
            ElaboraFamiliare(selV430.FieldByName('PROGRESSIVO').AsInteger,OldDataNas,OldData);
          end;
        end;

      end;
      //--- REGISTRO I CONTATORI DEL PERIODO NEI RELATIVI DATI DI cdsRisultato (CONTATORI CHE NON SONO DETTAGLIATI PER DATA)
      if ((R180IndexOf(ElencoColonne,'104',3) >= 0) or (R180IndexOf(ElencoColonne,'404',3) >= 0)) and
         ((TotGGPeriodo <> 0) or (TotHHPeriodo <> 0)) then
      begin
        if (R180IndexOf(ElencoProgAccorp,Accorp + selV430.FieldByName('PROGRESSIVO').AsString,20) < 0) then
        begin
          cdsRisultato.FieldByName('NUMDIP_' + TipoAccorp + '#' + Accorp).AsFloat:=
            cdsRisultato.FieldByName('NUMDIP_' + TipoAccorp + '#' + Accorp).AsFloat + 1;
          ElencoProgAccorp.Add(Accorp + selV430.FieldByName('PROGRESSIVO').AsString);
        end;
        if (R180IndexOf(ElencoProgAss,selV430.FieldByName('PROGRESSIVO').AsString,10) < 0) then
        begin
          cdsRisultato.FieldByName('NUMDIPASS').AsFloat:=cdsRisultato.FieldByName('NUMDIPASS').AsFloat + 1;
          ElencoProgAss.Add(selV430.FieldByName('PROGRESSIVO').AsString);
        end;
      end;
      if (R180IndexOf(ElencoColonne,'303',3) >= 0) or (R180IndexOf(ElencoColonne,'406',3) >= 0) then
      begin
        cdsRisultato.FieldByName('GGASSEV_' + TipoAccorp + '#' + Accorp).AsFloat:=
          cdsRisultato.FieldByName('GGASSEV_' + TipoAccorp + '#' + Accorp).AsFloat + TotGGPeriodoNoEventi;
        cdsRisultato.FieldByName('GGASSEV').AsFloat:=cdsRisultato.FieldByName('GGASSEV').AsFloat + TotGGPeriodoNoEventi;
      end;
    end;
  end;
  selT920Ass.Filter:='';
  selT920Ass.Filtered:=False;
end;

procedure TA151FAssenteismoMW.ElaboraAssenzeL104(Accorp:String);
var ContaHHGiornata,ContaGGGiornata:Real;
  MaxData,MinData,OldDataNas:TDateTime;
  s,UM,OldCausale:String;
  OldGGLav:Integer;
begin
  //-------------------------------------------------------------
  // CONTEGGIO GG.Assenza o HH.Assenza per legge 104
  //-------------------------------------------------------------
  //IMPOSTAZIONE DEI PARAMETRI PER L'APERTURA DEL DATASET ASSENZE selT920Ass
  selT920Ass.SetVariable('TABELLA', Tabella);
  selT920Ass.SetVariable('PROGRESSIVO', selV430.FieldByName('PROGRESSIVO').AsInteger);
  selT920Ass.SetVariable('DADATA', selV430.FieldByName('DEC').AsDateTime);
  selT920Ass.SetVariable('ADATA', selV430.FieldByName('FINE').AsDateTime);
  selT920Ass.SetVariable('TIPOACCORP', TipoAccorp);
  s:='';
  if FruizGG then
    s:=s + '''I''';
  if FruizMG then
  begin
    if Trim(s) <> '' then
      s:=s + ',';
    s:=s + '''M''';
  end;
  if FruizHH then
  begin
    if Trim(s) <> '' then
      s:=s + ',';
    s:=s + '''N''';
  end;
  if FruizDH then
  begin
    if Trim(s) <> '' then
      s:=s + ',';
    s:=s + '''D''';
  end;
  if Trim(s) = '' then
    s:='''I'',''M'',''N'',''D''';
  selT920Ass.SetVariable('UM', s);
  //APERTURA DEL DATASET ASSENZE selT920Ass
  selT920Ass.Close;
  selT920Ass.Open;
  selT920Ass.Filter:='COD_CODICIACCORPCAUSALI = ''' + Accorp + '''';
  selT920Ass.Filtered:=True;
  if selT920Ass.RecordCount <= 0 then
    Exit;
  ContaGGGiornata:=0;
  ContaHHGiornata:=0;
  if selT920Ass.RecordCount > 0 then  //FILTRO LE ASSENZE DELL'ACCORPAMENTO IN ELABORAZIONE
  begin
    selT920Ass.First;
    MinData:=selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime;
    selT920Ass.Last;
    MaxData:=selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime;
    selT920Ass.First;
    UM:=selT920Ass.FieldByName('ASSENZAUMFRUIZIONE').AsString;
    if selT920Ass.FieldByName('ASSENZAUMFRUIZIONE').AsString = 'M' then
      UM:='I';
    if selT920Ass.FieldByName('ASSENZAUMFRUIZIONE').AsString = 'D' then
      UM:='N';
    if ((MaxData - MinData + 1) <= MaxGG) then  //Verifica il max periodo considerato
    begin
      selT920AssGG.SetVariable('PROGRESSIVO',selV430.FieldByName('PROGRESSIVO').AsInteger);
      selT920AssGG.SetVariable('DATA',selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime);
      selT920AssGG.SetVariable('TABELLA',Tabella);
      selT920AssGG.Execute;
      OldGGLav:=StrToIntDef(VarToStr(selT920AssGG.Field(0)),0);
      OldData:=selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime;
      OldCausale:=selT920Ass.FieldByName('ASSENZACAUSALE').AsString;
      OldDataNas:=selT920Ass.FieldByName('ASSENZADATAFAMILIARE').AsDateTime;
      //CICLO PER OGNI GIUSTIFICATIVO
      while not selT920Ass.Eof do
      begin
        //Se la data cambia e ContaGG <> 0
        if ((OldData <> selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime) or
            (DettFam and (OldDataNas <> selT920Ass.FieldByName('ASSENZADATAFAMILIARE').AsDateTime))) and
           ((ContaGGGiornata <> 0) or (ContaHHGiornata <> 0)) then
        begin
          if ContaGGGiornata > 1 then  //per ogni gg. posso avere al max 1 gg. di assenza
          begin
            RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_PIU_GIORNATE_INTERE,[DateToStr(OldData)]),'',selV430.FieldByName('PROGRESSIVO').AsInteger);
            ContaGGGiornata:=1;
          end;
          if (ContaGGGiornata <> 0) and (ContaHHGiornata <> 0) then  //per ogni gg. posso avere o giornate o ore
          begin
            RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_GG_INTERA_E_ORE,[DateToStr(OldData)]),'',selV430.FieldByName('PROGRESSIVO').AsInteger);
            ContaHHGiornata:=0;
          end;
          //Totalizzo
          if (R180IndexOf(ElencoColonne,'304',3) >= 0) then
          begin
            cdsRisultato.FieldByName('GGASSL104_' + TipoAccorp + '#' + Accorp).AsFloat:=
              cdsRisultato.FieldByName('GGASSL104_' + TipoAccorp + '#' + Accorp).AsFloat + ContaGGGiornata;
            cdsRisultato.FieldByName('GGASSL104').AsFloat:=cdsRisultato.FieldByName('GGASSL104').AsFloat + ContaGGGiornata;
          end;
          if (R180IndexOf(ElencoColonne,'305',3) >= 0) then
          begin
            cdsRisultato.FieldByName('HHASSL104_' + TipoAccorp + '#' + Accorp).AsFloat:=
              cdsRisultato.FieldByName('HHASSL104_' + TipoAccorp + '#' + Accorp).AsFloat + ContaHHGiornata;
            cdsRisultato.FieldByName('HHASSL104').AsFloat:=cdsRisultato.FieldByName('HHASSL104').AsFloat + ContaHHGiornata;
          end;
          if DettGG then
          begin
            cdsRisultato.FieldByName('DATAGIUSTIF').AsDateTime:=OldData;
            cdsRisultato.FieldByName('CAUSALE').AsString:=OldCausale;
            if DettFam then
            begin
              if OldDataNas <> 0 then
                cdsRisultato.FieldByName('DATANASFAM').AsDateTime:=OldDataNas;
              ElaboraFamiliare(selV430.FieldByName('PROGRESSIVO').AsInteger,OldDataNas,OldData);
            end;
            cdsRisultato.Post;
            cdsRisultato.Append;
            ElaboraTestata;
          end;
          //Azzero i contatori della giornata
          ContaGGGiornata:=0;
          ContaHHGiornata:=0;
        end;
        //Se la data cambia
        if OldData <> selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime then
        begin
          selT920AssGG.SetVariable('PROGRESSIVO',selV430.FieldByName('PROGRESSIVO').AsInteger);
          selT920AssGG.SetVariable('DATA',selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime);
          selT920AssGG.SetVariable('TABELLA',Tabella);
          selT920AssGG.Execute;
          OldGGLav:=StrToIntDef(VarToStr(selT920AssGG.Field(0)),0);
        end;
        //Per ogni data considerata
        if (AssGGLav) and (OldGGLav = 0) then  //Se 'Solo GG.lav' e il giorno non è lav.
        begin
          ContaGGGiornata:=0;
          ContaHHGiornata:=0;
        end
        else //Se tutti i giorni oppure 'Solo GG.lav' e il giorno è lav.
        begin
          if selT920Ass.FieldByName('ASSENZAUMFRUIZIONE').AsString = 'I' then
            ContaGGGiornata:=ContaGGGiornata + 1
          else
            ContaHHGiornata:=ContaHHGiornata + R180Arrotonda(selT920Ass.FieldByName('ASSRESE').AsInteger / 60,0.01,'P');  //Conto le ore in centesimi
        end;
        //Salvataggio dati del record vecchio
        OldData:=selT920Ass.FieldByName('DATACONTEGGIO').AsDateTime;
        OldCausale:=selT920Ass.FieldByName('ASSENZACAUSALE').AsString;
        OldDataNas:=selT920Ass.FieldByName('ASSENZADATAFAMILIARE').AsDateTime;
        if (((selT920Ass.FieldByName('ASSENZAUMFRUIZIONE').AsString = 'N') or (selT920Ass.FieldByName('ASSENZAUMFRUIZIONE').AsString = 'D')) and (UM = 'I')) or
           (((selT920Ass.FieldByName('ASSENZAUMFRUIZIONE').AsString = 'I') or (selT920Ass.FieldByName('ASSENZAUMFRUIZIONE').AsString = 'M')) and (UM = 'N')) then
          RegistraMsg.InserisciMessaggio('I',A000MSG_A151_MSG_TIPI_FRUIZIONE,'',selV430.FieldByName('PROGRESSIVO').AsInteger);
        UM:=selT920Ass.FieldByName('ASSENZAUMFRUIZIONE').AsString;
        if selT920Ass.FieldByName('ASSENZAUMFRUIZIONE').AsString = 'M' then
          UM:='I';
        if selT920Ass.FieldByName('ASSENZAUMFRUIZIONE').AsString = 'D' then
          UM:='N';
        //Lettura nuovo record
        selT920Ass.Next;
      end;
      //--- FINE CICLO
      if (ContaGGGiornata <> 0) or (ContaHHGiornata <> 0) then  //Se Totale assenze del giorno <> 0
      begin
        if ContaGGGiornata > 1 then  //per ogni gg. posso avere al max 1 gg. di assenza
        begin
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_PIU_GIORNATE_INTERE,[DateToStr(OldData)]),'',selV430.FieldByName('PROGRESSIVO').AsInteger);
          ContaGGGiornata:=1;
        end;
        if (ContaGGGiornata <> 0) and (ContaHHGiornata <> 0) then  //per ogni gg. posso avere o giornate o ore
        begin
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_GG_INTERA_E_ORE,[DateToStr(OldData)]),'',selV430.FieldByName('PROGRESSIVO').AsInteger);
          ContaHHGiornata:=0;
        end;
        //Totalizzo
        if (R180IndexOf(ElencoColonne,'304',3) >= 0) then
        begin
          cdsRisultato.FieldByName('GGASSL104_' + TipoAccorp + '#' + Accorp).AsFloat:=
            cdsRisultato.FieldByName('GGASSL104_' + TipoAccorp + '#' + Accorp).AsFloat + ContaGGGiornata;
          cdsRisultato.FieldByName('GGASSL104').AsFloat:=cdsRisultato.FieldByName('GGASSL104').AsFloat + ContaGGGiornata;
        end;
        if (R180IndexOf(ElencoColonne,'305',3) >= 0) then
        begin
          cdsRisultato.FieldByName('HHASSL104_' + TipoAccorp + '#' + Accorp).AsFloat:=
            cdsRisultato.FieldByName('HHASSL104_' + TipoAccorp + '#' + Accorp).AsFloat + ContaHHGiornata;
          cdsRisultato.FieldByName('HHASSL104').AsFloat:=cdsRisultato.FieldByName('HHASSL104').AsFloat + ContaHHGiornata;
        end;
        if DettGG then
        begin
          cdsRisultato.FieldByName('DATAGIUSTIF').AsDateTime:=OldData;
          cdsRisultato.FieldByName('CAUSALE').AsString:=OldCausale;
          if DettFam then
          begin
            if OldDataNas <> 0 then
              cdsRisultato.FieldByName('DATANASFAM').AsDateTime:=OldDataNas;
            ElaboraFamiliare(selV430.FieldByName('PROGRESSIVO').AsInteger,OldDataNas,OldData);
          end;
        end;
      end;
    end;
  end;
  selT920Ass.Filter:='';
  selT920Ass.Filtered:=False;
end;

procedure TA151FAssenteismoMW.ElaboraFamiliare(Prog:Integer;DataNas,DataAss:TDateTime);
var DataRif:TDateTime;
begin
  //La data passata in input è la data di riferimento del familiari indicata sui giustificativi
  //Potrebbe essere la data di nascita o la data di adozione del familiare
  R180SetVariable(selSG101,'PROG',Prog);
  R180SetVariable(selSG101,'ADOZ','S');
  R180SetVariable(selSG101,'DATAADOZ',DataNas);
  R180SetVariable(selSG101,'DATARIF',DataAss);
  selSG101.Open;
  if selSG101.RecordCount <= 0 then
  begin
    R180SetVariable(selSG101,'PROG',Prog);
    R180SetVariable(selSG101,'ADOZ','N');
    R180SetVariable(selSG101,'DATANAS',DataNas);
    R180SetVariable(selSG101,'DATARIF',DataAss);
    selSG101.Open;
    if selSG101.RecordCount <= 0 then
    begin
      if DateToStr(DataNas) = '30/12/1899' then
      begin
        if iEsportaXML = 1 then  //L104
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_GIUST_NO_FAMILIARE,[DateToStr(DataAss)]),'',Prog)
        else
          RegistraMsg.InserisciMessaggio('I',Format(A000MSG_A151_ERR_FMT_GIUST_NO_FAMILIARE,[DateToStr(DataAss)]),'',Prog)
      end
      else
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_FAMILIARE_NO_ESISTE,[DateToStr(DataAss),DateToStr(DataNas)]),'',Prog);
      Exit;
    end;
  end;
  if selSG101.FieldByName('GRADOPAR').AsString = 'NS' then
    cdsRisultato.FieldByName('GRADOPAR').AsString:=selSG101.FieldByName('GRADOPAR').AsString + '-Nessuno/Sè stesso'
  else if selSG101.FieldByName('GRADOPAR').AsString = 'CG' then
    cdsRisultato.FieldByName('GRADOPAR').AsString:=selSG101.FieldByName('GRADOPAR').AsString + '-Coniuge'
  else if selSG101.FieldByName('GRADOPAR').AsString = 'FG' then
    cdsRisultato.FieldByName('GRADOPAR').AsString:=selSG101.FieldByName('GRADOPAR').AsString + '-Figlio/Figlia'
  else if selSG101.FieldByName('GRADOPAR').AsString = 'GT' then
    cdsRisultato.FieldByName('GRADOPAR').AsString:=selSG101.FieldByName('GRADOPAR').AsString + '-Genitore'
  else if selSG101.FieldByName('GRADOPAR').AsString = 'FR' then
    cdsRisultato.FieldByName('GRADOPAR').AsString:=selSG101.FieldByName('GRADOPAR').AsString + '-Fratello/Sorella'
  else if selSG101.FieldByName('GRADOPAR').AsString = 'NP' then
    cdsRisultato.FieldByName('GRADOPAR').AsString:=selSG101.FieldByName('GRADOPAR').AsString + '-Nipote'
  else if selSG101.FieldByName('GRADOPAR').AsString = 'NF' then
    cdsRisultato.FieldByName('GRADOPAR').AsString:=selSG101.FieldByName('GRADOPAR').AsString + '-Nipote equiparato Figlio'
  else if selSG101.FieldByName('GRADOPAR').AsString = 'AL' then
    cdsRisultato.FieldByName('GRADOPAR').AsString:=selSG101.FieldByName('GRADOPAR').AsString + '-Altro'
  else if selSG101.FieldByName('GRADOPAR').AsString = 'AF' then
    cdsRisultato.FieldByName('GRADOPAR').AsString:=selSG101.FieldByName('GRADOPAR').AsString + '-Affidato';
  cdsRisultato.FieldByName('TIPOPAR').AsString:='';
  if selSG101.FieldByName('TIPOPAR').AsString = 'P' then
    cdsRisultato.FieldByName('TIPOPAR').AsString:='Parente'
  else if selSG101.FieldByName('TIPOPAR').AsString = 'A' then
    cdsRisultato.FieldByName('TIPOPAR').AsString:='Affine';
  cdsRisultato.FieldByName('NUMGRADO').AsString:=selSG101.FieldByName('NUMGRADO').AsString;
  cdsRisultato.FieldByName('MOTIVO_GRADO_3').AsString:='';
  if selSG101.FieldByName('MOTIVO_GRADO_3').AsString = '1' then
    cdsRisultato.FieldByName('MOTIVO_GRADO_3').AsString:='1-Coniuge della persona disabile con età superiore ai 65 anni'
  else if selSG101.FieldByName('MOTIVO_GRADO_3').AsString = '2' then
    cdsRisultato.FieldByName('MOTIVO_GRADO_3').AsString:='2-Genitore della persona disabile con età superiore ai 65 anni'
  else if selSG101.FieldByName('MOTIVO_GRADO_3').AsString = '3' then
    cdsRisultato.FieldByName('MOTIVO_GRADO_3').AsString:='3-Coniuge affetto da patologia invalidante'
  else if selSG101.FieldByName('MOTIVO_GRADO_3').AsString = '4' then
    cdsRisultato.FieldByName('MOTIVO_GRADO_3').AsString:='4-Genitori affetti da patologia invalidante'
  else if selSG101.FieldByName('MOTIVO_GRADO_3').AsString = '5' then
    cdsRisultato.FieldByName('MOTIVO_GRADO_3').AsString:='5-Coniuge deceduto o mancante'
  else if selSG101.FieldByName('MOTIVO_GRADO_3').AsString = '6' then
    cdsRisultato.FieldByName('MOTIVO_GRADO_3').AsString:='6-Genitori deceduti o mancanti'
  else if selSG101.FieldByName('MOTIVO_GRADO_3').AsString = '7' then
    cdsRisultato.FieldByName('MOTIVO_GRADO_3').AsString:='7-Regime precedente Legge 183/2010';
  if (selSG101.FieldByName('NUMGRADO').AsString = '3') and (Trim(selSG101.FieldByName('MOTIVO_GRADO_3').AsString) = '') then
    if (iEsportaXML = 1) then
      RegistraMsg.InserisciMessaggio('A',A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_FAMILIARE_NO_DATO,[DateToStr(DataNas),'il motivo terzo grado']),'',Prog)
    else
      RegistraMsg.InserisciMessaggio('I',Format(A000MSG_A151_ERR_FMT_FAMILIARE_NO_DATO,[DateToStr(DataNas),'il motivo terzo grado']),'',Prog);
  cdsRisultato.FieldByName('COGNOMEFAM').AsString:='';
  cdsRisultato.FieldByName('NOMEFAM').AsString:='';
  cdsRisultato.FieldByName('SESSOFAM').AsString:='';
  cdsRisultato.FieldByName('CODFISCFAM').AsString:='';
  if selSG101.FieldByName('GRADOPAR').AsString <> 'NS' then
  begin
    cdsRisultato.FieldByName('COGNOMEFAM').AsString:=selSG101.FieldByName('COGNOME').AsString;
    cdsRisultato.FieldByName('NOMEFAM').AsString:=selSG101.FieldByName('NOME').AsString;
    cdsRisultato.FieldByName('CODFISCFAM').AsString:=selSG101.FieldByName('CODFISCALE').AsString;
    if (Trim(selSG101.FieldByName('COGNOME').AsString) = '') then
      if (iEsportaXML = 1) then
        RegistraMsg.InserisciMessaggio('A',A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_FAMILIARE_NO_DATO,[DateToStr(DataNas),'il cognome']),'',Prog)
      else
        RegistraMsg.InserisciMessaggio('I',Format(A000MSG_A151_ERR_FMT_FAMILIARE_NO_DATO,[DateToStr(DataNas),'il cognome']),'',Prog);
    if (Trim(selSG101.FieldByName('NOME').AsString) = '') then
      if (iEsportaXML = 1) then
        RegistraMsg.InserisciMessaggio('A',A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_FAMILIARE_NO_DATO,[DateToStr(DataNas),'il nome']),'',Prog)
      else
        RegistraMsg.InserisciMessaggio('I',Format(A000MSG_A151_ERR_FMT_FAMILIARE_NO_DATO,[DateToStr(DataNas),'il nome']),'',Prog);
    if (Trim(selSG101.FieldByName('CODFISCALE').AsString) = '') then
      if (iEsportaXML = 1) then
        RegistraMsg.InserisciMessaggio('A',A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_FAMILIARE_NO_DATO,[DateToStr(DataNas),'il codice fiscale']),'',Prog)
      else
        RegistraMsg.InserisciMessaggio('I',Format(A000MSG_A151_ERR_FMT_FAMILIARE_NO_DATO,[DateToStr(DataNas),'il codice fiscale']),'',Prog);
    cdsRisultato.FieldByName('SESSOFAM').AsString:=selSG101.FieldByName('SESSO').AsString;
    if (Trim(selSG101.FieldByName('SESSO').AsString) = '') then
      if (iEsportaXML = 1) then
        RegistraMsg.InserisciMessaggio('A',A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_FAMILIARE_NO_DATO,[DateToStr(DataNas),'il sesso']),'',Prog)
      else
        RegistraMsg.InserisciMessaggio('I',Format(A000MSG_A151_ERR_FMT_FAMILIARE_NO_DATO,[DateToStr(DataNas),'il sesso']),'',Prog);
    cdsRisultato.FieldByName('COMNASFAM').AsString:='';
    if Trim(selSG101.FieldByName('COMNASFAM').AsString) <> '-' then
      cdsRisultato.FieldByName('COMNASFAM').AsString:=selSG101.FieldByName('COMNASFAM').AsString;
    if ((Trim(selSG101.FieldByName('COMNASFAM').AsString) = '') or (Trim(selSG101.FieldByName('COMNASFAM').AsString) = '-')) then
      if (iEsportaXML = 1) then
        RegistraMsg.InserisciMessaggio('A',A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_FAMILIARE_NO_DATO,[DateToStr(DataNas),'il comune di nascita']),'',Prog)
      else
        RegistraMsg.InserisciMessaggio('I',Format(A000MSG_A151_ERR_FMT_FAMILIARE_NO_DATO,[DateToStr(DataNas),'il comune di nascita']),'',Prog);
  end;
  if iEsportaXML = 1 then  //L104
  begin
    cdsRisultato.FieldByName('PARENTELA_L104').AsString:='';
    if selSG101.FieldByName('GRADOPAR').AsString = 'NS' then
      cdsRisultato.FieldByName('PARENTELA_L104').AsString:=''
    else if selSG101.FieldByName('GRADOPAR').AsString = 'CG' then
      cdsRisultato.FieldByName('PARENTELA_L104').AsString:='2-Coniuge'
    else if selSG101.FieldByName('GRADOPAR').AsString = 'FG' then
      cdsRisultato.FieldByName('PARENTELA_L104').AsString:='1-Genitore'
    else if selSG101.FieldByName('GRADOPAR').AsString = 'GT' then
      cdsRisultato.FieldByName('PARENTELA_L104').AsString:='3-Figlio'
    else if selSG101.FieldByName('GRADOPAR').AsString = 'FR' then
      cdsRisultato.FieldByName('PARENTELA_L104').AsString:='4-Parente o affine fino al II grado'
    else if selSG101.FieldByName('GRADOPAR').AsString = 'NP' then
    begin
      if cdsRisultato.FieldByName('NUMGRADO').AsString <= '2' then
        cdsRisultato.FieldByName('PARENTELA_L104').AsString:='4-Parente o affine fino al II grado'
      else if cdsRisultato.FieldByName('NUMGRADO').AsString <= '3' then
        cdsRisultato.FieldByName('PARENTELA_L104').AsString:='5-Parente o affine fino al III grado';
    end
    else if selSG101.FieldByName('GRADOPAR').AsString = 'NF' then
    begin
      if cdsRisultato.FieldByName('NUMGRADO').AsString <= '2' then
        cdsRisultato.FieldByName('PARENTELA_L104').AsString:='4-Parente o affine fino al II grado'
      else if cdsRisultato.FieldByName('NUMGRADO').AsString <= '3' then
        cdsRisultato.FieldByName('PARENTELA_L104').AsString:='5-Parente o affine fino al III grado';
    end
    else if selSG101.FieldByName('GRADOPAR').AsString = 'AL' then
    begin
      if cdsRisultato.FieldByName('NUMGRADO').AsString = '' then
        cdsRisultato.FieldByName('PARENTELA_L104').AsString:='6-Nessuno'
      else if cdsRisultato.FieldByName('NUMGRADO').AsString <= '2' then
        cdsRisultato.FieldByName('PARENTELA_L104').AsString:='4-Parente o affine fino al II grado'
      else if cdsRisultato.FieldByName('NUMGRADO').AsString <= '3' then
        cdsRisultato.FieldByName('PARENTELA_L104').AsString:='5-Parente o affine fino al III grado';
    end
    else if selSG101.FieldByName('GRADOPAR').AsString = 'AF' then
      cdsRisultato.FieldByName('PARENTELA_L104').AsString:='7-Affidatario';
    cdsRisultato.FieldByName('FIGLIO3ANNI').AsString:='';
    if selSG101.FieldByName('GRADOPAR').AsString = 'FG' then
    begin  //Figlio fino a 3 anni se Parentela Genitore (guardare la data di metà del periodo + 1)
      DataRif:=DaData + Trunc((AData - DaData + 1) / 2) + 1;
      if Trunc((DataRif - Trunc(DataNas)) / 365) < 3 then
        cdsRisultato.FieldByName('FIGLIO3ANNI').AsString:='Si'
      else
        cdsRisultato.FieldByName('FIGLIO3ANNI').AsString:='No';
    end;
    cdsRisultato.FieldByName('TIPO_DISABILITA').AsString:='';
    if selSG101.FieldByName('TIPO_DISABILITA').AsString = '1' then
      cdsRisultato.FieldByName('TIPO_DISABILITA').AsString:='1-Rivedibile'
    else if selSG101.FieldByName('TIPO_DISABILITA').AsString = '2' then
      cdsRisultato.FieldByName('TIPO_DISABILITA').AsString:='2-Non rivedibile'
    else if selSG101.FieldByName('TIPO_DISABILITA').AsString = '3' then
      cdsRisultato.FieldByName('TIPO_DISABILITA').AsString:='3-Provvisorio';
    if Trim(selSG101.FieldByName('TIPO_DISABILITA').AsString) = '' then
      RegistraMsg.InserisciMessaggio('A',A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_FAMILIARE_NO_DATO,[DateToStr(DataNas),'il tipo disabilità']),'',Prog);
    cdsRisultato.FieldByName('ANNO_REVISIONE').AsString:=Copy(selSG101.FieldByName('ANNO_REVISIONE').AsString,7,4);
    if (selSG101.FieldByName('TIPO_DISABILITA').AsString = '1') and (Trim(selSG101.FieldByName('ANNO_REVISIONE').AsString) = '') then
      RegistraMsg.InserisciMessaggio('A',A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_FAMILIARE_NO_DATO,[DateToStr(DataNas),'la data di revisione']),'',Prog);
    cdsRisultato.FieldByName('ANNO_AVV').AsString:=selSG101.FieldByName('ANNO_AVV').AsString;
    if (selSG101.FieldByName('GRADOPAR').AsString <> 'NS') and (Trim(selSG101.FieldByName('ANNO_AVV').AsString) <> '') then
      RegistraMsg.InserisciMessaggio('A',A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_FAMILIARE_CON_DATO,[DateToStr(DataNas),'l''anno di avvicinamento al proprio domicilio']),'',Prog);
    cdsRisultato.FieldByName('ANNO_AVV_FAM').AsString:=selSG101.FieldByName('ANNO_AVV_FAM').AsString;
    if (selSG101.FieldByName('GRADOPAR').AsString = 'NS') and (Trim(selSG101.FieldByName('ANNO_AVV_FAM').AsString) <> '') then
      RegistraMsg.InserisciMessaggio('A',A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_FAMILIARE_CON_DATO,[DateToStr(DataNas),'l''anno di avvicinamento al domicilio del familiare']),'',Prog);
    cdsRisultato.FieldByName('COMRESFAM').AsString:='';
    if Trim(selSG101.FieldByName('COMRESFAM').AsString) <> '-' then
      cdsRisultato.FieldByName('COMRESFAM').AsString:=selSG101.FieldByName('COMRESFAM').AsString;
    if Trim(selSG101.FieldByName('MATRICOLA').AsString) <> ''  then  //Se matricola valorizzata leggo la residenza da T430 del familiare stesso
    begin
      selT430.Close;
      selT430.SetVariable('MATRFAM',selSG101.FieldByName('MATRICOLA').AsString);
      selT430.SetVariable('DATARIF',DataAss);
      selT430.Open;
      if (selT430.RecordCount > 0) and (Trim(selT430.FieldByName('COMRESFAM').AsString) <> '-') then
        cdsRisultato.FieldByName('COMRESFAM').AsString:=selT430.FieldByName('COMRESFAM').AsString;
    end;
    if (selSG101.FieldByName('GRADOPAR').AsString <> 'NS') and (Trim(cdsRisultato.FieldByName('COMRESFAM').AsString) = '') then
      RegistraMsg.InserisciMessaggio('A',A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_FAMILIARE_NO_DATO,[DateToStr(DataNas),'il comune di residenza']),'',Prog);
    cdsRisultato.FieldByName('NOME_PA').AsString:=selSG101.FieldByName('NOME_PA').AsString;
    cdsRisultato.FieldByName('DURATA_PA').AsString:='';
    if selSG101.FieldByName('DURATA_PA').AsString = '1' then
      cdsRisultato.FieldByName('DURATA_PA').AsString:='1-Tempo indeterminato'
    else if selSG101.FieldByName('DURATA_PA').AsString = '2' then
      cdsRisultato.FieldByName('DURATA_PA').AsString:='2-Tempo determinato';
    if (Trim(selSG101.FieldByName('NOME_PA').AsString) = '') and (Trim(selSG101.FieldByName('DURATA_PA').AsString) <> '') then
      RegistraMsg.InserisciMessaggio('A',A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_FAMILIARE_CON_DATO,[DateToStr(DataNas),'la durata contratto']),'',Prog);
    cdsRisultato.FieldByName('ALTERNATIVA').AsString:='';
    if selSG101.FieldByName('ALTERNATIVA').AsString = '1' then
      cdsRisultato.FieldByName('ALTERNATIVA').AsString:='1-Genitore'
    else if selSG101.FieldByName('ALTERNATIVA').AsString = '2' then
      cdsRisultato.FieldByName('ALTERNATIVA').AsString:='2-Coniuge'
    else if selSG101.FieldByName('ALTERNATIVA').AsString = '3' then
      cdsRisultato.FieldByName('ALTERNATIVA').AsString:='3-Figlio'
    else if selSG101.FieldByName('ALTERNATIVA').AsString = '4' then
      cdsRisultato.FieldByName('ALTERNATIVA').AsString:='4-Parente o affine fino al II grado'
    else if selSG101.FieldByName('ALTERNATIVA').AsString = '5' then
      cdsRisultato.FieldByName('ALTERNATIVA').AsString:='5-Parente o affine fino al III grado'
    else if selSG101.FieldByName('ALTERNATIVA').AsString = '6' then
      cdsRisultato.FieldByName('ALTERNATIVA').AsString:='6-Nessuno'
    else if selSG101.FieldByName('ALTERNATIVA').AsString = '7' then
      cdsRisultato.FieldByName('ALTERNATIVA').AsString:='7-Affidatario';
    if (selSG101.FieldByName('GRADOPAR').AsString = 'FG') and (Trim(selSG101.FieldByName('ALTERNATIVA').AsString) = '') then
      RegistraMsg.InserisciMessaggio('A',A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_FAMILIARE_NO_DATO,[DateToStr(DataNas),'l''alternativa']),'',Prog);
    cdsRisultato.FieldByName('NOME_PA_ALT').AsString:=selSG101.FieldByName('NOME_PA_ALT').AsString;
    cdsRisultato.FieldByName('MOTIVO_GRADO_3_ALT').AsString:='';
    if selSG101.FieldByName('MOTIVO_GRADO_3_ALT').AsString = '1' then
      cdsRisultato.FieldByName('MOTIVO_GRADO_3_ALT').AsString:='1-Coniuge della persona disabile con età superiore ai 65 anni'
    else if selSG101.FieldByName('MOTIVO_GRADO_3_ALT').AsString = '2' then
      cdsRisultato.FieldByName('MOTIVO_GRADO_3_ALT').AsString:='2-Genitore della persona disabile con età superiore ai 65 anni'
    else if selSG101.FieldByName('MOTIVO_GRADO_3_ALT').AsString = '3' then
      cdsRisultato.FieldByName('MOTIVO_GRADO_3_ALT').AsString:='3-Coniuge affetto da patologia invalidante'
    else if selSG101.FieldByName('MOTIVO_GRADO_3_ALT').AsString = '4' then
      cdsRisultato.FieldByName('MOTIVO_GRADO_3_ALT').AsString:='4-Genitori affetti da patologia invalidante'
    else if selSG101.FieldByName('MOTIVO_GRADO_3_ALT').AsString = '5' then
      cdsRisultato.FieldByName('MOTIVO_GRADO_3_ALT').AsString:='5-Coniuge deceduto o mancante'
    else if selSG101.FieldByName('MOTIVO_GRADO_3_ALT').AsString = '6' then
      cdsRisultato.FieldByName('MOTIVO_GRADO_3_ALT').AsString:='6-Genitori deceduti o mancanti'
    else if selSG101.FieldByName('MOTIVO_GRADO_3_ALT').AsString = '7' then
      cdsRisultato.FieldByName('MOTIVO_GRADO_3_ALT').AsString:='7-Regime precedente Legge 183/2010';
    if (selSG101.FieldByName('GRADOPAR').AsString = 'FG') and (selSG101.FieldByName('ALTERNATIVA').AsString = '5') and (Trim(selSG101.FieldByName('MOTIVO_GRADO_3_ALT').AsString) = '') then
      RegistraMsg.InserisciMessaggio('A',A000MSG_A151_MSG_FINI_L104 + Format(A000MSG_A151_ERR_FMT_FAMILIARE_NO_DATO,[DateToStr(DataNas),'il motivo terzo grado dell''alternativa']),'',Prog);
  end;
end;

procedure TA151FAssenteismoMW.OperazioniFinali;
begin
  if TotGen then
    ElaboraTotaliGenerali;
  //Arrotondo e calcolo i tassi e le medie a livello di totale
  cdsRisultato.First;
  while not cdsRisultato.Eof do
  begin
    cdsRisultato.Edit;
    Arrotondamenti;
    if OpzioneRiepilogo then
      ElaboraRiepilogo;
    Pulizia;
    cdsRisultato.Post;
    cdsRisultato.Next;
  end;
  //Cancellazione righe vuote
  if not RigheVuote then
    CancellaRigheVuote;
  cdsRisultato.First;
end;

procedure TA151FAssenteismoMW.ElaboraTotaliGenerali;
var i:Integer;
begin
  cdsTotale.Data:=cdsRisultato.Data;
  cdsTotale.First;
  while not cdsTotale.Eof do
  begin
    if cdsRisultato.Locate('GRUPPO','TOTALE',[loCaseInsensitive]) then
      cdsRisultato.Edit
    else
      cdsRisultato.Append;
    cdsRisultato.FieldByName('GRUPPO').AsString:='TOTALE';
    cdsRisultato.FieldByName('GRUPPO_DESC').AsString:='Totale Generale';
    if OpzioneNumDip or OpzioneRiepilogoDip then
    begin
      cdsRisultato.FieldByName('NUMDIP').AsFloat:=cdsRisultato.FieldByName('NUMDIP').AsFloat + cdsTotale.FieldByName('NUMDIP').AsFloat;
      cdsRisultato.FieldByName('NUMDIPPT').AsFloat:=cdsRisultato.FieldByName('NUMDIPPT').AsFloat + cdsTotale.FieldByName('NUMDIPPT').AsFloat;
      cdsRisultato.FieldByName('NUMDIPINIZ').AsFloat:=cdsRisultato.FieldByName('NUMDIPINIZ').AsFloat + cdsTotale.FieldByName('NUMDIPINIZ').AsFloat;
      cdsRisultato.FieldByName('NUMDIPFINE').AsFloat:=cdsRisultato.FieldByName('NUMDIPFINE').AsFloat + cdsTotale.FieldByName('NUMDIPFINE').AsFloat;
      cdsRisultato.FieldByName('NUMDIPINIZPT').AsFloat:=cdsRisultato.FieldByName('NUMDIPINIZPT').AsFloat + cdsTotale.FieldByName('NUMDIPINIZPT').AsFloat;
      cdsRisultato.FieldByName('NUMDIPFINEPT').AsFloat:=cdsRisultato.FieldByName('NUMDIPFINEPT').AsFloat + cdsTotale.FieldByName('NUMDIPFINEPT').AsFloat;
      cdsRisultato.FieldByName('NUMDIPMEDIO').AsFloat:=cdsRisultato.FieldByName('NUMDIPMEDIO').AsFloat + cdsTotale.FieldByName('NUMDIPMEDIO').AsFloat;
    end;
    if OpzionePresenze or OpzioneRiepilogoPres then
    begin
      cdsRisultato.FieldByName('GGTOT').AsFloat:=cdsRisultato.FieldByName('GGTOT').AsFloat + cdsTotale.FieldByName('GGTOT').AsFloat;
      cdsRisultato.FieldByName('GGTIMB').AsFloat:=cdsRisultato.FieldByName('GGTIMB').AsFloat + cdsTotale.FieldByName('GGTIMB').AsFloat;
      cdsRisultato.FieldByName('GGLAV').AsFloat:=cdsRisultato.FieldByName('GGLAV').AsFloat + cdsTotale.FieldByName('GGLAV').AsFloat;
      cdsRisultato.FieldByName('GGPRES').AsFloat:=cdsRisultato.FieldByName('GGPRES').AsFloat + cdsTotale.FieldByName('GGPRES').AsFloat;
      cdsRisultato.FieldByName('ORETIMB').AsString:=R180MinutiOre(R180OreMinutiExt(cdsRisultato.FieldByName('ORETIMB').AsString) +
                                                                  R180OreMinutiExt(cdsTotale.FieldByName('ORETIMB').AsString));
      cdsRisultato.FieldByName('ORELAV').AsString:=R180MinutiOre(R180OreMinutiExt(cdsRisultato.FieldByName('ORELAV').AsString) +
                                                                 R180OreMinutiExt(cdsTotale.FieldByName('ORELAV').AsString));
      cdsRisultato.FieldByName('OREPRES').AsString:=R180MinutiOre(R180OreMinutiExt(cdsRisultato.FieldByName('OREPRES').AsString) +
                                                                  R180OreMinutiExt(cdsTotale.FieldByName('OREPRES').AsString));
      cdsRisultato.FieldByName('ORESTRAORD').AsString:=R180MinutiOre(R180OreMinutiExt(cdsRisultato.FieldByName('ORESTRAORD').AsString) +
                                                                     R180OreMinutiExt(cdsTotale.FieldByName('ORESTRAORD').AsString));
      cdsRisultato.FieldByName('OREDEBITO').AsString:=R180MinutiOre(R180OreMinutiExt(cdsRisultato.FieldByName('OREDEBITO').AsString) +
                                                                    R180OreMinutiExt(cdsTotale.FieldByName('OREDEBITO').AsString));
      cdsRisultato.FieldByName('LIBERO_NUM').AsFloat:=cdsRisultato.FieldByName('LIBERO_NUM').AsFloat + cdsTotale.FieldByName('LIBERO_NUM').AsFloat;
      cdsRisultato.FieldByName('LIBERO_ORA').AsString:=R180MinutiOre(R180OreMinutiExt(cdsRisultato.FieldByName('LIBERO_ORA').AsString) +
                                                                     R180OreMinutiExt(cdsTotale.FieldByName('LIBERO_ORA').AsString));
    end;
    if OpzioneEventiAssenze then
    begin
      cdsRisultato.FieldByName('ASS10GG').AsFloat:=cdsRisultato.FieldByName('ASS10GG').AsFloat + cdsTotale.FieldByName('ASS10GG').AsFloat;
      for i:=0 to ElencoAccorp.Count - 1 do
      begin
        cdsRisultato.FieldByName('ASS10GG_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
          cdsRisultato.FieldByName('ASS10GG_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat + cdsTotale.FieldByName('ASS10GG_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat;
      end;
    end;
    if OpzioneAssenze or OpzioneRiepilogoAss then
    begin
      cdsRisultato.FieldByName('NUMDIPASS').AsFloat:=cdsRisultato.FieldByName('NUMDIPASS').AsFloat + cdsTotale.FieldByName('NUMDIPASS').AsFloat;
      cdsRisultato.FieldByName('GGASS').AsFloat:=cdsRisultato.FieldByName('GGASS').AsFloat + cdsTotale.FieldByName('GGASS').AsFloat;
      cdsRisultato.FieldByName('GGASSEV').AsFloat:=cdsRisultato.FieldByName('GGASSEV').AsFloat + cdsTotale.FieldByName('GGASSEV').AsFloat;
      cdsRisultato.FieldByName('HHASS').AsString:=R180MinutiOre(R180OreMinutiExt(cdsRisultato.FieldByName('HHASS').AsString) +
                                                                R180OreMinutiExt(cdsTotale.FieldByName('HHASS').AsString));
      for i:=0 to ElencoAccorp.Count - 1 do
      begin
        cdsRisultato.FieldByName('NUMDIP_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
          cdsRisultato.FieldByName('NUMDIP_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat + cdsTotale.FieldByName('NUMDIP_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat;
        cdsRisultato.FieldByName('GGASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
          cdsRisultato.FieldByName('GGASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat + cdsTotale.FieldByName('GGASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat;
        cdsRisultato.FieldByName('GGASSEV_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
          cdsRisultato.FieldByName('GGASSEV_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat + cdsTotale.FieldByName('GGASSEV_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat;
        cdsRisultato.FieldByName('HHASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsString:=
          R180MinutiOre(R180OreMinutiExt(cdsRisultato.FieldByName('HHASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsString) +
                        R180OreMinutiExt(cdsTotale.FieldByName('HHASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsString));
      end;
    end;
    if OpzioneAssenzeL104 then
    begin
      cdsRisultato.FieldByName('GGASSL104').AsFloat:=cdsRisultato.FieldByName('GGASSL104').AsFloat + cdsTotale.FieldByName('GGASSL104').AsFloat;
      cdsRisultato.FieldByName('HHASSL104').AsFloat:=cdsRisultato.FieldByName('HHASSL104').AsFloat + cdsTotale.FieldByName('HHASSL104').AsFloat;
      for i:=0 to ElencoAccorp.Count - 1 do
      begin
        cdsRisultato.FieldByName('GGASSL104_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
          cdsRisultato.FieldByName('GGASSL104_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat + cdsTotale.FieldByName('GGASSL104_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat;
        cdsRisultato.FieldByName('HHASSL104_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
          cdsRisultato.FieldByName('HHASSL104_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat + cdsTotale.FieldByName('HHASSL104_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat;
      end;
    end;
    cdsRisultato.Post;
    cdsTotale.Next;
  end;
end;

procedure TA151FAssenteismoMW.FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=A000FiltroDizionario('GENERATORE DI STAMPE',DataSet.FieldByName('CODICE').AsString);
end;

procedure TA151FAssenteismoMW.Arrotondamenti;
var i:Integer;
  Arrot:String;
begin
  with cdsRisultato do
  begin
    //--- ARROTONDAMENTI
    if OpzioneNumDip or OpzioneRiepilogoDip then
    begin
      if iNumDipArrot <> 0 then
      begin
        case iNumDipArrot of
          1: Arrot:='P';
          2: Arrot:='D';
          3: Arrot:='E';
        end;
        FieldByName('NUMDIP').AsFloat:=R180Arrotonda(FieldByName('NUMDIP').AsFloat,1,Arrot);
        FieldByName('NUMDIPPT').AsFloat:=R180Arrotonda(FieldByName('NUMDIPPT').AsFloat,1,Arrot);
        FieldByName('NUMDIPINIZ').AsFloat:=R180Arrotonda(FieldByName('NUMDIPINIZ').AsFloat,1,Arrot);
        FieldByName('NUMDIPFINE').AsFloat:=R180Arrotonda(FieldByName('NUMDIPFINE').AsFloat,1,Arrot);
        FieldByName('NUMDIPINIZPT').AsFloat:=R180Arrotonda(FieldByName('NUMDIPINIZPT').AsFloat,1,Arrot);
        FieldByName('NUMDIPFINEPT').AsFloat:=R180Arrotonda(FieldByName('NUMDIPFINEPT').AsFloat,1,Arrot);
        FieldByName('NUMDIPMEDIO').AsFloat:=R180Arrotonda(FieldByName('NUMDIPMEDIO').AsFloat,1,Arrot);
      end
      else
      begin
        FieldByName('NUMDIP').AsFloat:=R180Arrotonda(FieldByName('NUMDIP').AsFloat,0.01,'P');
        FieldByName('NUMDIPPT').AsFloat:=R180Arrotonda(FieldByName('NUMDIPPT').AsFloat,0.01,'P');
        FieldByName('NUMDIPINIZ').AsFloat:=R180Arrotonda(FieldByName('NUMDIPINIZ').AsFloat,0.01,'P');
        FieldByName('NUMDIPFINE').AsFloat:=R180Arrotonda(FieldByName('NUMDIPFINE').AsFloat,0.01,'P');
        FieldByName('NUMDIPINIZPT').AsFloat:=R180Arrotonda(FieldByName('NUMDIPINIZPT').AsFloat,0.01,'P');
        FieldByName('NUMDIPFINEPT').AsFloat:=R180Arrotonda(FieldByName('NUMDIPFINEPT').AsFloat,0.01,'P');
        FieldByName('NUMDIPMEDIO').AsFloat:=R180Arrotonda(FieldByName('NUMDIPMEDIO').AsFloat,0.01,'P');
      end;
    end;
    if OpzioneAssenze or OpzioneRiepilogoAss then
    begin
      if iAssArrot <> 0 then
      begin
        case iAssArrot of
          1: Arrot:='P';
          2: Arrot:='D';
          3: Arrot:='E';
        end;
        for i:=0 to ElencoAccorp.Count - 1 do
        begin
          FieldByName('GGASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
            R180Arrotonda(FieldByName('GGASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat,1,Arrot);
          FieldByName('GGASSEV_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
            R180Arrotonda(FieldByName('GGASSEV_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat,1,Arrot);
        end;
        FieldByName('GGASS').AsFloat:=R180Arrotonda(FieldByName('GGASS').AsFloat,1,Arrot);
        FieldByName('GGASSEV').AsFloat:=R180Arrotonda(FieldByName('GGASSEV').AsFloat,1,Arrot);
      end
      else
      begin
        for i:=0 to ElencoAccorp.Count - 1 do
        begin
          FieldByName('GGASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
            R180Arrotonda(FieldByName('GGASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat,0.01,'P');
          FieldByName('GGASSEV_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
            R180Arrotonda(FieldByName('GGASSEV_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat,0.01,'P');
        end;
        FieldByName('GGASS').AsFloat:=R180Arrotonda(FieldByName('GGASS').AsFloat,0.01,'P');
        FieldByName('GGASSEV').AsFloat:=R180Arrotonda(FieldByName('GGASSEV').AsFloat,0.01,'P');
      end;
      if iNumDipArrot <> 0 then
      begin
        case iNumDipArrot of
          1: Arrot:='P';
          2: Arrot:='D';
          3: Arrot:='E';
        end;
        FieldByName('NUMDIPASS').AsFloat:=R180Arrotonda(FieldByName('NUMDIPASS').AsFloat,1,Arrot);
        for i:=0 to ElencoAccorp.Count - 1 do
          FieldByName('NUMDIP_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
            R180Arrotonda(FieldByName('NUMDIP_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat,1,Arrot);
      end
      else
      begin
        FieldByName('NUMDIPASS').AsFloat:=R180Arrotonda(FieldByName('NUMDIPASS').AsFloat,0.01,'P');
        for i:=0 to ElencoAccorp.Count - 1 do
          FieldByName('NUMDIP_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
            R180Arrotonda(FieldByName('NUMDIP_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat,0.01,'P');
      end;
    end;
    if OpzionePresenze then
    begin
      if iRiepArrot <> 0 then
      begin
        case iRiepArrot of
          1: Arrot:='P';
          2: Arrot:='D';
          3: Arrot:='E';
        end;
        FieldByName('LIBERO_NUM').AsFloat:=R180Arrotonda(FieldByName('LIBERO_NUM').AsFloat,1,Arrot)
      end
      else
        FieldByName('LIBERO_NUM').AsFloat:=R180Arrotonda(FieldByName('LIBERO_NUM').AsFloat,0.01,'P');
    end;
  end;
end;

procedure TA151FAssenteismoMW.ElaboraRiepilogo;
var i:Integer;
  Arrot:String;
begin
  //Tasso timbratura
  case iRiepArrot of
    1: Arrot:='P';
    2: Arrot:='D';
    3: Arrot:='E';
  end;
  if (R180IndexOf(ElencoColonne,'400',3) >= 0) then
  begin
    if cdsRisultato.FieldByName('GGTOT').AsFloat <> 0 then
    begin
      cdsRisultato.FieldByName('TASSOTIMB').AsFloat:=
        cdsRisultato.FieldByName('GGTIMB').AsFloat / cdsRisultato.FieldByName('GGTOT').AsFloat * 100;
      if iRiepArrot <> 0 then
        cdsRisultato.FieldByName('TASSOTIMB').AsFloat:=R180Arrotonda(cdsRisultato.FieldByName('TASSOTIMB').AsFloat,1,Arrot)
      else
        cdsRisultato.FieldByName('TASSOTIMB').AsFloat:=R180Arrotonda(cdsRisultato.FieldByName('TASSOTIMB').AsFloat,0.01,'P');
    end;
  end;
  //Tasso utilizzo forza lav.
  if (R180IndexOf(ElencoColonne,'401',3) >= 0) then
  begin
    if cdsRisultato.FieldByName('GGTOT').AsFloat <> 0 then
    begin
      cdsRisultato.FieldByName('TASSOLAV').AsFloat:=
        cdsRisultato.FieldByName('GGLAV').AsFloat / cdsRisultato.FieldByName('GGTOT').AsFloat * 100;
      if iRiepArrot <> 0 then
        cdsRisultato.FieldByName('TASSOLAV').AsFloat:=R180Arrotonda(cdsRisultato.FieldByName('TASSOLAV').AsFloat,1,Arrot)
      else
        cdsRisultato.FieldByName('TASSOLAV').AsFloat:=R180Arrotonda(cdsRisultato.FieldByName('TASSOLAV').AsFloat,0.01,'P');
    end;
  end;
  //Tasso presenza
  if (R180IndexOf(ElencoColonne,'402',3) >= 0) or (R180IndexOf(ElencoColonne,'507',3) >= 0) then
  begin
    if cdsRisultato.FieldByName('GGTOT').AsFloat <> 0 then
    begin
      cdsRisultato.FieldByName('TASSOPRES').AsFloat:=
        cdsRisultato.FieldByName('GGPRES').AsFloat / cdsRisultato.FieldByName('GGTOT').AsFloat * 100;
      if iRiepArrot <> 0 then
        cdsRisultato.FieldByName('TASSOPRES').AsFloat:=R180Arrotonda(cdsRisultato.FieldByName('TASSOPRES').AsFloat,1,Arrot)
      else
        cdsRisultato.FieldByName('TASSOPRES').AsFloat:=R180Arrotonda(cdsRisultato.FieldByName('TASSOPRES').AsFloat,0.01,'P');
    end;
  end;
  //Tasso assenteismo
  if (R180IndexOf(ElencoColonne,'403',3) >= 0) or (R180IndexOf(ElencoColonne,'506',3) >= 0) then
  begin
    if cdsRisultato.FieldByName('GGTOT').AsFloat <> 0 then
    begin
      for i:=0 to ElencoAccorp.Count - 1 do
      begin
        cdsRisultato.FieldByName('TASSOASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
          cdsRisultato.FieldByName('GGASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat /
          cdsRisultato.FieldByName('GGTOT').AsFloat * 100;
        if iRiepArrot <> 0 then
          cdsRisultato.FieldByName('TASSOASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
            R180Arrotonda(cdsRisultato.FieldByName('TASSOASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat,1,Arrot)
        else
          cdsRisultato.FieldByName('TASSOASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
            R180Arrotonda(cdsRisultato.FieldByName('TASSOASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat,0.01,'P');
      end;
      cdsRisultato.FieldByName('TASSOASS').AsFloat:=
        cdsRisultato.FieldByName('GGASS').AsFloat / cdsRisultato.FieldByName('GGTOT').AsFloat * 100;
      if iRiepArrot <> 0 then
        cdsRisultato.FieldByName('TASSOASS').AsFloat:=R180Arrotonda(cdsRisultato.FieldByName('TASSOASS').AsFloat,1,Arrot)
      else
        cdsRisultato.FieldByName('TASSOASS').AsFloat:=R180Arrotonda(cdsRisultato.FieldByName('TASSOASS').AsFloat,0.01,'P');
    end;
  end;
  //Media assenze
  if (R180IndexOf(ElencoColonne,'404',3) >= 0) then
  begin
    for i:=0 to ElencoAccorp.Count - 1 do
    begin
      cdsRisultato.FieldByName('MEDIAASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
        cdsRisultato.FieldByName('GGASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat /
        Max(cdsRisultato.FieldByName('NUMDIP_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat,1);
      if iRiepArrot <> 0 then
        cdsRisultato.FieldByName('MEDIAASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
          R180Arrotonda(cdsRisultato.FieldByName('MEDIAASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat,1,Arrot)
      else
        cdsRisultato.FieldByName('MEDIAASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
          R180Arrotonda(cdsRisultato.FieldByName('MEDIAASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat,0.01,'P');
    end;
    cdsRisultato.FieldByName('MEDIAASS').AsFloat:=
      cdsRisultato.FieldByName('GGASS').AsFloat / Max(cdsRisultato.FieldByName('NUMDIPASS').AsFloat,1);
    if iRiepArrot <> 0 then
      cdsRisultato.FieldByName('MEDIAASS').AsFloat:=R180Arrotonda(cdsRisultato.FieldByName('MEDIAASS').AsFloat,1,Arrot)
    else
      cdsRisultato.FieldByName('MEDIAASS').AsFloat:=R180Arrotonda(cdsRisultato.FieldByName('MEDIAASS').AsFloat,0.01,'P');
  end;
  //Media assenze procapite
  if (R180IndexOf(ElencoColonne,'405',3) >= 0) then
  begin
    for i:=0 to ElencoAccorp.Count - 1 do
    begin
      if iNumDipPeriodo = 0 then
        cdsRisultato.FieldByName('MEDIAASSPRO_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
          cdsRisultato.FieldByName('GGASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat /
          Max(cdsRisultato.FieldByName('NUMDIPINIZ').AsFloat,1)
      else if iNumDipPeriodo = 1 then
        cdsRisultato.FieldByName('MEDIAASSPRO_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
          cdsRisultato.FieldByName('GGASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat /
          Max(cdsRisultato.FieldByName('NUMDIPFINE').AsFloat,1);
      if iRiepArrot <> 0 then
        cdsRisultato.FieldByName('MEDIAASSPRO_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
          R180Arrotonda(cdsRisultato.FieldByName('MEDIAASSPRO_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat,1,Arrot)
      else
        cdsRisultato.FieldByName('MEDIAASSPRO_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
          R180Arrotonda(cdsRisultato.FieldByName('MEDIAASSPRO_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat,0.01,'P');
    end;
    if iNumDipPeriodo = 0 then
      cdsRisultato.FieldByName('MEDIAASSPRO').AsFloat:=
        cdsRisultato.FieldByName('GGASS').AsFloat / Max(cdsRisultato.FieldByName('NUMDIPINIZ').AsFloat,1)
    else if iNumDipPeriodo = 1 then
      cdsRisultato.FieldByName('MEDIAASSPRO').AsFloat:=
        cdsRisultato.FieldByName('GGASS').AsFloat / Max(cdsRisultato.FieldByName('NUMDIPFINE').AsFloat,1);
    if iRiepArrot <> 0 then
      cdsRisultato.FieldByName('MEDIAASSPRO').AsFloat:=R180Arrotonda(cdsRisultato.FieldByName('MEDIAASSPRO').AsFloat,1,Arrot)
    else
      cdsRisultato.FieldByName('MEDIAASSPRO').AsFloat:=R180Arrotonda(cdsRisultato.FieldByName('MEDIAASSPRO').AsFloat,0.01,'P');
  end;
  //Media assenze procapite esclusi eventi > 10 gg.
  if (R180IndexOf(ElencoColonne,'406',3) >= 0) then
  begin
    for i:=0 to ElencoAccorp.Count - 1 do
    begin
      if iNumDipPeriodo = 0 then
        cdsRisultato.FieldByName('MEDIAASSEV_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
          cdsRisultato.FieldByName('GGASSEV_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat /
          Max(cdsRisultato.FieldByName('NUMDIPINIZ').AsFloat,1)
      else if iNumDipPeriodo = 1 then
        cdsRisultato.FieldByName('MEDIAASSEV_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
          cdsRisultato.FieldByName('GGASSEV_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat /
          Max(cdsRisultato.FieldByName('NUMDIPFINE').AsFloat,1);
      if iRiepArrot <> 0 then
        cdsRisultato.FieldByName('MEDIAASSEV_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
          R180Arrotonda(cdsRisultato.FieldByName('MEDIAASSEV_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat,1,Arrot)
      else
        cdsRisultato.FieldByName('MEDIAASSEV_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=
          R180Arrotonda(cdsRisultato.FieldByName('MEDIAASSEV_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat,0.01,'P');
    end;
    if iNumDipPeriodo = 0 then
      cdsRisultato.FieldByName('MEDIAASSEV').AsFloat:=
        cdsRisultato.FieldByName('GGASSEV').AsFloat / Max(cdsRisultato.FieldByName('NUMDIPINIZ').AsFloat,1)
    else if iNumDipPeriodo = 1 then
      cdsRisultato.FieldByName('MEDIAASSEV').AsFloat:=
        cdsRisultato.FieldByName('GGASSEV').AsFloat / Max(cdsRisultato.FieldByName('NUMDIPFINE').AsFloat,1);
    if iRiepArrot <> 0 then
      cdsRisultato.FieldByName('MEDIAASSEV').AsFloat:=R180Arrotonda(cdsRisultato.FieldByName('MEDIAASSEV').AsFloat,1,Arrot)
    else
      cdsRisultato.FieldByName('MEDIAASSEV').AsFloat:=R180Arrotonda(cdsRisultato.FieldByName('MEDIAASSEV').AsFloat,0.01,'P');
  end;
  //Percentuale di presenza
  if (R180IndexOf(ElencoColonne,'506',3) >= 0) then
    if iRiepArrot <> 0 then
      cdsRisultato.FieldByName('PERCENTPRES').AsFloat:=R180Arrotonda(100 - cdsRisultato.FieldByName('TASSOASS').AsFloat,1,Arrot)
    else
      cdsRisultato.FieldByName('PERCENTPRES').AsFloat:=R180Arrotonda(100 - cdsRisultato.FieldByName('TASSOASS').AsFloat,0.01,'P');
  //Percentuale di assenza
  if (R180IndexOf(ElencoColonne,'507',3) >= 0) then
    if iRiepArrot <> 0 then
      cdsRisultato.FieldByName('PERCENTASS').AsFloat:=R180Arrotonda(100 - cdsRisultato.FieldByName('TASSOPRES').AsFloat,1,Arrot)
    else
      cdsRisultato.FieldByName('PERCENTASS').AsFloat:=R180Arrotonda(100 - cdsRisultato.FieldByName('TASSOPRES').AsFloat,0.01,'P');
end;

procedure TA151FAssenteismoMW.Pulizia;
var i:Integer;
begin
  with cdsRisultato do
  begin
    //--- PULIZIA DATI = ZERO
    if OpzioneNumDip then
    begin
      if FieldByName('NUMDIP').AsFloat = 0 then
        FieldByName('NUMDIP').Value:=null;
      if FieldByName('NUMDIPPT').AsFloat = 0 then
        FieldByName('NUMDIPPT').Value:=null;
      if FieldByName('NUMDIPINIZ').AsFloat = 0 then
        FieldByName('NUMDIPINIZ').Value:=null;
      if FieldByName('NUMDIPFINE').AsFloat = 0 then
        FieldByName('NUMDIPFINE').Value:=null;
      if FieldByName('NUMDIPINIZPT').AsFloat = 0 then
        FieldByName('NUMDIPINIZPT').Value:=null;
      if FieldByName('NUMDIPFINEPT').AsFloat = 0 then
        FieldByName('NUMDIPFINEPT').Value:=null;
      if FieldByName('NUMDIPMEDIO').AsFloat = 0 then
        FieldByName('NUMDIPMEDIO').Value:=null;
    end;
    if OpzionePresenze then
    begin
      if FieldByName('GGTOT').AsFloat = 0 then
        FieldByName('GGTOT').Value:=null;
      if FieldByName('GGTIMB').AsFloat = 0 then
        FieldByName('GGTIMB').Value:=null;
      if FieldByName('GGLAV').AsFloat = 0 then
        FieldByName('GGLAV').Value:=null;
      if FieldByName('GGPRES').AsFloat = 0 then
        FieldByName('GGPRES').Value:=null;
      if Trim(FieldByName('ORETIMB').AsString) = '00.00' then
        FieldByName('ORETIMB').Value:=null;
      if Trim(FieldByName('ORELAV').AsString) = '00.00' then
        FieldByName('ORELAV').Value:=null;
      if Trim(FieldByName('OREPRES').AsString) = '00.00' then
        FieldByName('OREPRES').Value:=null;
      if Trim(FieldByName('ORESTRAORD').AsString) = '00.00' then
        FieldByName('ORESTRAORD').Value:=null;
      if Trim(FieldByName('OREDEBITO').AsString) = '00.00' then
        FieldByName('OREDEBITO').Value:=null;
      if FieldByName('LIBERO_NUM').AsFloat = 0 then
        FieldByName('LIBERO_NUM').Value:=null;
      if Trim(FieldByName('LIBERO_ORA').AsString) = '00.00' then
        FieldByName('LIBERO_ORA').Value:=null;
    end;
    if OpzioneEventiAssenze then
    begin
      for i:=0 to ElencoAccorp.Count - 1 do
      begin
        if FieldByName('ASS10GG_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat = 0 then
          FieldByName('ASS10GG_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).Value:=null;
      end;
      if FieldByName('ASS10GG').AsFloat = 0 then
        FieldByName('ASS10GG').Value:=null;
    end;
    if OpzioneAssenze then
    begin
      for i:=0 to ElencoAccorp.Count - 1 do
      begin
        if FieldByName('NUMDIP_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat = 0 then
          FieldByName('NUMDIP_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).Value:=null;
        if FieldByName('GGASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat = 0 then
          FieldByName('GGASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).Value:=null;
        if FieldByName('GGASSEV_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat = 0 then
          FieldByName('GGASSEV_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).Value:=null;
        if Trim(FieldByName('HHASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsString) = '00.00' then
          FieldByName('HHASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).Value:=null;
      end;
      if FieldByName('NUMDIPASS').AsFloat = 0 then
        FieldByName('NUMDIPASS').Value:=null;
      if FieldByName('GGASS').AsFloat = 0 then
        FieldByName('GGASS').Value:=null;
      if FieldByName('GGASSEV').AsFloat = 0 then
        FieldByName('GGASSEV').Value:=null;
      if Trim(FieldByName('HHASS').AsString) = '00.00' then
        FieldByName('HHASS').Value:=null;
    end;
    if OpzioneAssenzeL104 then
    begin
      for i:=0 to ElencoAccorp.Count - 1 do
      begin
        if FieldByName('GGASSL104_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat = 0 then
          FieldByName('GGASSL104_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).Value:=null;
        if FieldByName('HHASSL104_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat = 0 then
          FieldByName('HHASSL104_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).Value:=null;
      end;
      if FieldByName('GGASSL104').AsFloat = 0 then
        FieldByName('GGASSL104').Value:=null;
      if FieldByName('HHASSL104').AsFloat = 0 then
        FieldByName('HHASSL104').Value:=null;
    end;
    if OpzioneRiepilogo then
    begin
      if FieldByName('TASSOTIMB').AsFloat = 0 then
        FieldByName('TASSOTIMB').Value:=null;
      if FieldByName('TASSOLAV').AsFloat = 0 then
        FieldByName('TASSOLAV').Value:=null;
      if FieldByName('TASSOPRES').AsFloat = 0 then
        FieldByName('TASSOPRES').Value:=null;
      for i:=0 to ElencoAccorp.Count - 1 do
      begin
        if FieldByName('TASSOASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat = 0 then
          FieldByName('TASSOASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).Value:=null;
        if FieldByName('MEDIAASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat = 0 then
          FieldByName('MEDIAASS_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).Value:=null;
        if FieldByName('MEDIAASSEV_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat = 0 then
          FieldByName('MEDIAASSEV_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).Value:=null;
        if FieldByName('MEDIAASSPRO_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat = 0 then
          FieldByName('MEDIAASSPRO_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).Value:=null;
      end;
      if FieldByName('TASSOASS').AsFloat = 0 then
        FieldByName('TASSOASS').Value:=null;
      if FieldByName('MEDIAASS').AsFloat = 0 then
        FieldByName('MEDIAASS').Value:=null;
      if FieldByName('MEDIAASSEV').AsFloat = 0 then
        FieldByName('MEDIAASSEV').Value:=null;
      if FieldByName('MEDIAASSPRO').AsFloat = 0 then
        FieldByName('MEDIAASSPRO').Value:=null;
      if FieldByName('PERCENTPRES').AsFloat = 0 then
        FieldByName('PERCENTPRES').Value:=null;
      if FieldByName('PERCENTASS').AsFloat = 0 then
        FieldByName('PERCENTASS').Value:=null;
    end;
  end;
end;

procedure TA151FAssenteismoMW.CancellaRigheVuote;
var RigaVuota:Boolean;
begin
  cdsRisultato.First;
  while not cdsRisultato.Eof do
  begin
    RigaVuota:=True;
    //Se dato vuoto oppure significativo ma non da elaborare (es.quando si richiedono solo i riepiloghi)
    if OpzioneNumDip then
    begin
      if (not cdsRisultato.FieldByName('NUMDIP').IsNull) or
         (not cdsRisultato.FieldByName('NUMDIPPT').IsNull) or
         (not cdsRisultato.FieldByName('NUMDIPINIZ').IsNull) or (not cdsRisultato.FieldByName('NUMDIPFINE').IsNull) or
         (not cdsRisultato.FieldByName('NUMDIPINIZPT').IsNull) or (not cdsRisultato.FieldByName('NUMDIPFINEPT').IsNull) or
         (not cdsRisultato.FieldByName('NUMDIPMEDIO').IsNull) then
        RigaVuota:=False;
    end;
    if OpzionePresenze then
    begin
      if (not cdsRisultato.FieldByName('GGTOT').IsNull) or
         (not cdsRisultato.FieldByName('GGTIMB').IsNull) or
         (not cdsRisultato.FieldByName('GGLAV').IsNull) or
         (not cdsRisultato.FieldByName('GGPRES').IsNull) or
         (not cdsRisultato.FieldByName('ORETIMB').IsNull) or
         (not cdsRisultato.FieldByName('ORELAV').IsNull) or
         (not cdsRisultato.FieldByName('OREPRES').IsNull) or
         (not cdsRisultato.FieldByName('ORESTRAORD').IsNull) or
         (not cdsRisultato.FieldByName('OREDEBITO').IsNull) or
         (not cdsRisultato.FieldByName('LIBERO_NUM').IsNull) or
         (not cdsRisultato.FieldByName('LIBERO_ORA').IsNull) then
        RigaVuota:=False;
    end;
    if OpzioneEventiAssenze then
    begin
      if (not cdsRisultato.FieldByName('ASS10GG').IsNull) then
        RigaVuota:=False;
    end;
    if OpzioneAssenze then
    begin
      if (not cdsRisultato.FieldByName('NUMDIPASS').IsNull) or
         (not cdsRisultato.FieldByName('GGASS').IsNull) or
         (not cdsRisultato.FieldByName('GGASSEV').IsNull) or
         (not cdsRisultato.FieldByName('HHASS').IsNull) then
        RigaVuota:=False;
    end;
    if OpzioneAssenzeL104 then
    begin
      if (not cdsRisultato.FieldByName('GGASSL104').IsNull) or
         (not cdsRisultato.FieldByName('HHASSL104').IsNull) then
        RigaVuota:=False;
    end;
    if OpzioneRiepilogo then
    begin
      if (not cdsRisultato.FieldByName('TASSOTIMB').IsNull) or
         (not cdsRisultato.FieldByName('TASSOLAV').IsNull) or
         (not cdsRisultato.FieldByName('TASSOPRES').IsNull) or
         (not cdsRisultato.FieldByName('TASSOASS').IsNull) or
         (not cdsRisultato.FieldByName('MEDIAASS').IsNull) or
         (not cdsRisultato.FieldByName('MEDIAASSPRO').IsNull) or
         (not cdsRisultato.FieldByName('MEDIAASSEV').IsNull) or
         (not cdsRisultato.FieldByName('PERCENTPRES').IsNull) or
         (not cdsRisultato.FieldByName('PERCENTASS').IsNull) then
        RigaVuota:=False;
    end;
    if RigaVuota then
      cdsRisultato.Delete
    else
      cdsRisultato.Next;
  end;
end;

procedure TA151FAssenteismoMW.ImpostaColonneGriglia;
var i:Integer;
  s:String;
begin
  cdsRisultato.FieldByName('GRUPPO').Visible:=False;  //GRUPPO
  i:=0;
  s:='';
  selT256.Close;
  selT256.SetVariable('TIPO',TipoAccorp);
  selT256.Open;
  while i <= (cdsRisultato.FieldCount - 1) do
  begin
    s:=cdsRisultato.Fields[i].DisplayLabel;
    if s = 'GRUPPO_DESC' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Periodo elab. dal ' + sDaData + ' al ' + sAData;
      cdsRisultato.Fields[i].DisplayWidth:=20;
    end
    else if s = 'COGNOME' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Cognome';
      cdsRisultato.Fields[i].DisplayWidth:=20;
    end
    else if s = 'NOME' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Nome';
      cdsRisultato.Fields[i].DisplayWidth:=20;
    end
    else if s = 'MATRICOLA' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Matricola';
      cdsRisultato.Fields[i].DisplayWidth:=5;
    end
    else if s = 'CODFISCALE' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Cod.fiscale';
      cdsRisultato.Fields[i].DisplayWidth:=16;
    end
    else if s = 'PROGRESSIVO' then
    begin
      cdsRisultato.Fields[i].Visible:=False;
    end
    else if s = 'DATAGIUSTIF' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Data giustif.';
      cdsRisultato.Fields[i].DisplayWidth:=10;
    end
    else if s = 'CAUSALE' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Causale';
      cdsRisultato.Fields[i].DisplayWidth:=10;
    end
    else if s = 'DATANASFAM' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Data riferimento fam.';
      cdsRisultato.Fields[i].DisplayWidth:=10;
    end
    else if s = 'GRADOPAR' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Parentela';
      cdsRisultato.Fields[i].DisplayWidth:=10;
    end
    else if s = 'TIPOPAR' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Tipo';
      cdsRisultato.Fields[i].DisplayWidth:=5;
    end
    else if s = 'NUMGRADO' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Grado';
      cdsRisultato.Fields[i].DisplayWidth:=5;
    end
    else if s = 'MOTIVO_GRADO_3' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Motivo 3° grado';
      cdsRisultato.Fields[i].DisplayWidth:=10;
    end
    else if s = 'COGNOMEFAM' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Cognome fam.';
      cdsRisultato.Fields[i].DisplayWidth:=20;
    end
    else if s = 'NOMEFAM' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Nome fam.';
      cdsRisultato.Fields[i].DisplayWidth:=20;
    end
    else if s = 'SESSOFAM' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Sesso fam.';
      cdsRisultato.Fields[i].DisplayWidth:=5;
    end
    else if s = 'COMNASFAM' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Comune nas.fam.';
      cdsRisultato.Fields[i].DisplayWidth:=20;
    end
    else if s = 'CODFISCFAM' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Cod.fiscale fam.';
      cdsRisultato.Fields[i].DisplayWidth:=16;
    end
    else if s = 'PARENTELA_L104' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Parentela L.104/1992';
      cdsRisultato.Fields[i].DisplayWidth:=20;
    end
    else if s = 'FIGLIO3ANNI' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Figlio fino 3 anni';
      cdsRisultato.Fields[i].DisplayWidth:=10;
    end
    else if s = 'DURATADIP_L104' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Durata contr.dip. L.104/1992';
      cdsRisultato.Fields[i].DisplayWidth:=20;
    end
    else if s = 'CONTRATTODIP_L104' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Tipo contr.dip. L.104/1992';
      cdsRisultato.Fields[i].DisplayWidth:=20;
    end
    else if s = 'TIPO_PTDIP_L104' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Tipo p.t. dip. L.104/1992';
      cdsRisultato.Fields[i].DisplayWidth:=20;
    end
    else if s = 'PERC_PTDIP_L104' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Percentuale p.t. dip. L.104/1992';
      cdsRisultato.Fields[i].DisplayWidth:=20;
    end
    else if s = 'TIPO_DISABILITA' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Tipo disabilità';
      cdsRisultato.Fields[i].DisplayWidth:=10;
    end
    else if s = 'ANNO_REVISIONE' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Anno revisione';
      cdsRisultato.Fields[i].DisplayWidth:=10;
    end
    else if s = 'ANNO_AVV' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Anno avv. proprio dom.';
      cdsRisultato.Fields[i].DisplayWidth:=10;
    end
    else if s = 'ANNO_AVV_FAM' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Anno avv. dom.fam.';
      cdsRisultato.Fields[i].DisplayWidth:=10;
    end
    else if s = 'COMRESFAM' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Comune res.fam.';
      cdsRisultato.Fields[i].DisplayWidth:=20;
    end
    else if s = 'NOME_PA' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Denominazione P.A.';
      cdsRisultato.Fields[i].DisplayWidth:=20;
    end
    else if s = 'DURATA_PA' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Durata contratto P.A.';
      cdsRisultato.Fields[i].DisplayWidth:=10;
    end
    else if s = 'ALTERNATIVA' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Alternativa';
      cdsRisultato.Fields[i].DisplayWidth:=20;
    end
    else if s = 'NOME_PA_ALT' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Denominazione P.A. alt.';
      cdsRisultato.Fields[i].DisplayWidth:=20;
    end
    else if s = 'MOTIVO_GRADO_3_ALT' then
    begin
      cdsRisultato.Fields[i].DisplayLabel:='Motivo 3° grado alt.';
      cdsRisultato.Fields[i].DisplayWidth:=10;
    end
    else if s = 'NUMDIP' then
    begin
      if (R180IndexOf(ElencoColonne,'100',3) >= 0) then
        cdsRisultato.Fields[i].DisplayLabel:='[100] Num.Dip.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'NUMDIPPT' then
    begin
      if (R180IndexOf(ElencoColonne,'101',3) >= 0) then
        cdsRisultato.Fields[i].DisplayLabel:='[101] Num.Dip. % PT'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'NUMDIPINIZ' then
    begin
      if (R180IndexOf(ElencoColonne,'102',3) >= 0) and (iNumDipPeriodo = 0) then
        cdsRisultato.Fields[i].DisplayLabel:='[102] Num.Dip.Inizio Periodo'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'NUMDIPFINE' then
    begin
      if (R180IndexOf(ElencoColonne,'102',3) >= 0) and (iNumDipPeriodo = 1) then
        cdsRisultato.Fields[i].DisplayLabel:='[102] Num.Dip.Fine Periodo'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'NUMDIPINIZPT' then
    begin
      if (R180IndexOf(ElencoColonne,'103',3) >= 0) and (iNumDipPeriodo = 0) then
        cdsRisultato.Fields[i].DisplayLabel:='[103] Num.Dip.%PT Inizio Periodo'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'NUMDIPFINEPT' then
    begin
      if (R180IndexOf(ElencoColonne,'103',3) >= 0) and (iNumDipPeriodo = 1) then
        cdsRisultato.Fields[i].DisplayLabel:='[103] Num.Dip.%PT Fine Periodo'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'NUMDIPMEDIO' then
    begin
      if (R180IndexOf(ElencoColonne,'105',3) >= 0) then
        cdsRisultato.Fields[i].DisplayLabel:='[105] Num.Dip.Medio'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'NUMDIPASS' then
    begin
      if (R180IndexOf(ElencoColonne,'104',3) >= 0) and (iAss in [1,2]) then
        cdsRisultato.Fields[i].DisplayLabel:='[104] Num.Tot.Dip.Ass.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if Copy(s,1,7) = 'NUMDIP_' then
    begin
      if (R180IndexOf(ElencoColonne,'104',3) >= 0) and (iAss in [0,2]) then
        cdsRisultato.Fields[i].DisplayLabel:='[104] Num.Dip.Ass.' +
          VarToStr(selT256.Lookup('COD_CODICIACCORPCAUSALI',Copy(s,Pos('#',s)+1,Length(s)-Pos('#',s)),'DESCRIZIONE'))
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'GGTOT' then
    begin
      if (R180IndexOf(ElencoColonne,'200',3) >= 0) then
        cdsRisultato.Fields[i].DisplayLabel:='[200] GG.Lavorativi'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'GGTIMB' then
    begin
      if (R180IndexOf(ElencoColonne,'201',3) >= 0) then
        cdsRisultato.Fields[i].DisplayLabel:='[201] GG.Timbr.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'GGLAV' then
    begin
      if (R180IndexOf(ElencoColonne,'202',3) >= 0) then
        cdsRisultato.Fields[i].DisplayLabel:='[202] GG.Lav.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'GGPRES' then
    begin
      if (R180IndexOf(ElencoColonne,'203',3) >= 0) then
        cdsRisultato.Fields[i].DisplayLabel:='[203] GG.Pres.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'ORETIMB' then
    begin
      if (R180IndexOf(ElencoColonne,'204',3) >= 0) then
        cdsRisultato.Fields[i].DisplayLabel:='[204] Ore Timbr.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'ORELAV' then
    begin
      if (R180IndexOf(ElencoColonne,'205',3) >= 0) then
        cdsRisultato.Fields[i].DisplayLabel:='[205] Ore Lav.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'OREPRES' then
    begin
      if (R180IndexOf(ElencoColonne,'206',3) >= 0) then
        cdsRisultato.Fields[i].DisplayLabel:='[206] Ore Pres.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'ORESTRAORD' then
    begin
      if (R180IndexOf(ElencoColonne,'207',3) >= 0) then
        cdsRisultato.Fields[i].DisplayLabel:='[207] Ore Straord.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'OREDEBITO' then
    begin
      if (R180IndexOf(ElencoColonne,'208',3) >= 0) then
        cdsRisultato.Fields[i].DisplayLabel:='[208] Ore Debito'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'GGASS' then
    begin
      if (R180IndexOf(ElencoColonne,'300',3) >= 0) and (iAss in [1,2]) then
        cdsRisultato.Fields[i].DisplayLabel:='[300] GG.Ass.Tot.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if Copy(s,1,6) = 'GGASS_' then
    begin
      if (R180IndexOf(ElencoColonne,'300',3) >= 0) and (iAss in [0,2]) then
        cdsRisultato.Fields[i].DisplayLabel:='[300] GG.Ass.' +
          VarToStr(selT256.Lookup('COD_CODICIACCORPCAUSALI',Copy(s,Pos('#',s)+1,Length(s)-Pos('#',s)),'DESCRIZIONE'))
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'HHASS' then
    begin
      if (R180IndexOf(ElencoColonne,'301',3) >= 0) and (iAss in [1,2]) then
        cdsRisultato.Fields[i].DisplayLabel:='[301] HH.Ass.Tot.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if Copy(s,1,6) = 'HHASS_' then
    begin
      if (R180IndexOf(ElencoColonne,'301',3) >= 0) and (iAss in [0,2]) then
        cdsRisultato.Fields[i].DisplayLabel:='[301] HH.Ass.' +
          VarToStr(selT256.Lookup('COD_CODICIACCORPCAUSALI',Copy(s,Pos('#',s)+1,Length(s)-Pos('#',s)),'DESCRIZIONE'))
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'ASS10GGDATE' then
    begin
      cdsRisultato.Fields[i].Visible:=False;
    end
    else if s = 'ASS10GG' then
    begin
      if (R180IndexOf(ElencoColonne,'302',3) >= 0) and (iAss in [1,2]) then
        cdsRisultato.Fields[i].DisplayLabel:='[302] Eventi > 10 GG Tot.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if Copy(s,1,8) = 'ASS10GG_' then
    begin
      if (R180IndexOf(ElencoColonne,'302',3) >= 0) and (iAss in [0,2]) then
        cdsRisultato.Fields[i].DisplayLabel:='[302] Eventi > 10 GG ' +
          VarToStr(selT256.Lookup('COD_CODICIACCORPCAUSALI',Copy(s,Pos('#',s)+1,Length(s)-Pos('#',s)),'DESCRIZIONE'))
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'GGASSEV' then
    begin
      if (R180IndexOf(ElencoColonne,'303',3) >= 0) and (iAss in [1,2]) then
        cdsRisultato.Fields[i].DisplayLabel:='[303] GG.Ass. Esclusi Eventi Tot.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if Copy(s,1,8) = 'GGASSEV_' then
    begin
      if (R180IndexOf(ElencoColonne,'303',3) >= 0) and (iAss in [0,2]) then
        cdsRisultato.Fields[i].DisplayLabel:='[303] GG.Ass. Esclusi Eventi ' +
          VarToStr(selT256.Lookup('COD_CODICIACCORPCAUSALI',Copy(s,Pos('#',s)+1,Length(s)-Pos('#',s)),'DESCRIZIONE'))
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'GGASSL104' then
    begin
      if (R180IndexOf(ElencoColonne,'304',3) >= 0) and (iAss in [1,2]) then
        cdsRisultato.Fields[i].DisplayLabel:='[304] GG.Ass. L.104/1992 Tot.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if Copy(s,1,10) = 'GGASSL104_' then
    begin
      if (R180IndexOf(ElencoColonne,'304',3) >= 0) and (iAss in [0,2]) then
        cdsRisultato.Fields[i].DisplayLabel:='[304] GG.Ass. L.104/1992 ' +
          VarToStr(selT256.Lookup('COD_CODICIACCORPCAUSALI',Copy(s,Pos('#',s)+1,Length(s)-Pos('#',s)),'DESCRIZIONE'))
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'HHASSL104' then
    begin
      if (R180IndexOf(ElencoColonne,'305',3) >= 0) and (iAss in [1,2]) then
        cdsRisultato.Fields[i].DisplayLabel:='[305] HH.Ass. L.104/1992 Tot.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if Copy(s,1,10) = 'HHASSL104_' then
    begin
      if (R180IndexOf(ElencoColonne,'305',3) >= 0) and (iAss in [0,2]) then
        cdsRisultato.Fields[i].DisplayLabel:='[305] HH.Ass. L.104/1992 ' +
          VarToStr(selT256.Lookup('COD_CODICIACCORPCAUSALI',Copy(s,Pos('#',s)+1,Length(s)-Pos('#',s)),'DESCRIZIONE'))
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'TASSOTIMB' then
    begin
      if (R180IndexOf(ElencoColonne,'400',3) >= 0) then
        cdsRisultato.Fields[i].DisplayLabel:='[400] Tasso Timb.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'TASSOLAV' then
    begin
      if (R180IndexOf(ElencoColonne,'401',3) >= 0) then
        cdsRisultato.Fields[i].DisplayLabel:='[401] Tasso Forza Lav.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'TASSOPRES' then
    begin
      if (R180IndexOf(ElencoColonne,'402',3) >= 0) then
        cdsRisultato.Fields[i].DisplayLabel:='[402] Tasso Presenza'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'TASSOASS' then
    begin
      if (R180IndexOf(ElencoColonne,'403',3) >= 0) and (iAss in [1,2]) then
        cdsRisultato.Fields[i].DisplayLabel:='[403] Tasso Ass.Tot.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if Copy(s,1,9) = 'TASSOASS_' then
    begin
      if (R180IndexOf(ElencoColonne,'403',3) >= 0) and (iAss in [0,2]) then
        cdsRisultato.Fields[i].DisplayLabel:='[403] Tasso Ass.' +
          VarToStr(selT256.Lookup('COD_CODICIACCORPCAUSALI',Copy(s,Pos('#',s)+1,Length(s)-Pos('#',s)),'DESCRIZIONE'))
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'MEDIAASS' then
    begin
      if (R180IndexOf(ElencoColonne,'404',3) >= 0) and (iAss in [1,2]) then
        cdsRisultato.Fields[i].DisplayLabel:='[404] Media Ass.Tot.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if Copy(s,1,9) = 'MEDIAASS_' then
    begin
      if (R180IndexOf(ElencoColonne,'404',3) >= 0) and (iAss in [0,2]) then
        cdsRisultato.Fields[i].DisplayLabel:='[404] Media Ass.' +
         VarToStr(selT256.Lookup('COD_CODICIACCORPCAUSALI',Copy(s,Pos('#',s)+1,Length(s)-Pos('#',s)),'DESCRIZIONE'))
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'MEDIAASSPRO' then
    begin
      if (R180IndexOf(ElencoColonne,'405',3) >= 0) and (iAss in [1,2]) then
        cdsRisultato.Fields[i].DisplayLabel:='[405] Media Ass.Pro.Tot.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if Copy(s,1,12) = 'MEDIAASSPRO_' then
    begin
      if (R180IndexOf(ElencoColonne,'405',3) >= 0) and (iAss in [0,2]) then
        cdsRisultato.Fields[i].DisplayLabel:='[405] Media Ass.Pro.' +
          VarToStr(selT256.Lookup('COD_CODICIACCORPCAUSALI',Copy(s,Pos('#',s)+1,Length(s)-Pos('#',s)),'DESCRIZIONE'))
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'MEDIAASSEV' then
    begin
      if (R180IndexOf(ElencoColonne,'406',3) >= 0) and (iAss in [1,2]) then
        cdsRisultato.Fields[i].DisplayLabel:='[406] Media Ass.Esclusi Eventi Tot.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if Copy(s,1,11) = 'MEDIAASSEV_' then
    begin
      if (R180IndexOf(ElencoColonne,'406',3) >= 0) and (iAss in [0,2]) then
        cdsRisultato.Fields[i].DisplayLabel:='[406] Media Ass.Esclusi Eventi ' +
          VarToStr(selT256.Lookup('COD_CODICIACCORPCAUSALI',Copy(s,Pos('#',s)+1,Length(s)-Pos('#',s)),'DESCRIZIONE'))
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'PERCENTPRES' then
    begin
      if (R180IndexOf(ElencoColonne,'506',3) >= 0) then
        cdsRisultato.Fields[i].DisplayLabel:='[506] Percentuale Pres.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'PERCENTASS' then
    begin
      if (R180IndexOf(ElencoColonne,'507',3) >= 0) then
        cdsRisultato.Fields[i].DisplayLabel:='[507] Percentuale Ass.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'LIBERO_NUM' then
    begin
      if (R180IndexOf(ElencoColonne,'900',3) >= 0) then
        cdsRisultato.Fields[i].DisplayLabel:='[900] Dato Libero Num.'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else if s = 'LIBERO_ORA' then
    begin
      if (R180IndexOf(ElencoColonne,'901',3) >= 0) then
        cdsRisultato.Fields[i].DisplayLabel:='[901] Dato Libero Orario'
      else
        cdsRisultato.Fields[i].Visible:=False;
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    end
    else  //Campi di raggruppamento- l'intestazione corrisponde alla caption del dato in stampa
      cdsRisultato.Fields[i].DisplayWidth:=Length(cdsRisultato.Fields[i].DisplayLabel);
    inc(i);
  end;
end;

procedure TA151FAssenteismoMW.SegnalaErrore(Msg:String);
begin
  if Assigned(evtClearKeys) then
    evtClearKeys;
  raise Exception.Create(Msg);
end;

procedure TA151FAssenteismoMW.ControlliGeneraXmlTassiAss;
  function IndiceDato(Dato:String): Integer;
  var j:Integer;
  begin
    //Ritorno la posizione del dato in ElencoRighe
    Result:=-1;
    for j:=0 to ElencoRighe.Count - 1 do
    begin
      if Pos(Dato,ElencoRighe.Strings[j]) > 0 then
        Result:=j;
    end;
  end;
begin
  if Trim(IdUfficioText) = '' then
    SegnalaErrore('Specificare il dato libero di riferimento per ID Ufficio!');
  if (Trim(IdMittenteValue) <> '') and (IndiceDato(IdMittenteValue) < 0) then
    SegnalaErrore('Il campo di riferimento ID Mittente deve essere presente nella griglia risultato!');
  if (IndiceDato(IdUfficioValue) < 0) then
    SegnalaErrore('Il campo di riferimento ID Ufficio deve essere presente nella griglia risultato!');
  if ((cdsRisultato.FindField('TASSOASS') = nil) and (cdsRisultato.FindField('PERCENTASS') = nil)) or
     ((not cdsRisultato.FieldByName('TASSOASS').Visible) and (not cdsRisultato.FieldByName('PERCENTASS').Visible)) then
    SegnalaErrore('Almeno uno tra [403] Tasso di assenteismo - [407] Percentuale di assenza deve essere presente nella griglia risultato!');
  if Assigned(evtRichiesta) then
  begin
    if Trim(IdMittenteText) = '' then
      evtRichiesta(A000MSG_A151_DLG_NO_ID_MITTENTE,'NoIDMittente');
    if cdsRisultato.RecordCount > 1000 then
      evtRichiesta(A000MSG_A151_DLG_EXPORT_1000_TASSI,'Export1000Tassi');
  end;
end;

procedure TA151FAssenteismoMW.GeneraXmlTassiAss;
var Nodo, NodoBase: IXMLNode;
  ProgNum:Integer;
  Mittente,Ufficio:string;
begin
  //Dati di Testata
  XMLGenerato.Active:=False;
  if (not IsLibrary)(*(GGetWebApplicationThreadVar.AppURLBase = '')*) then
    CoInitialize(nil);
  XMLGenerato.Active:=True;
  //Genera Testata
  if XMLGenerato.DocumentElement = nil then
  begin
    XMLGenerato.AddChild('rilevazione_assenze');
    Nodo:=XMLGenerato.DocumentElement;
  end;
  NodoCorrente:=Nodo;
  NodoBase:=NodoCorrente;  //Salvo il nodo corrente
  ProgNum:=0;
  //CICLO su griglia risultato
  while not cdsRisultato.Eof do
  begin
    if cdsRisultato.FieldByName('GRUPPO_DESC').AsString <> 'Totale Generale' then  //salto la riga del totale generale
    begin
      NodoCorrente:=NodoBase;
      //Leggo il valore del campo mittente dalla griglia se campo mittente valorizz.
      Mittente:='';
      if Trim(IdMittenteValue) <> '' then
        Mittente:=cdsRisultato.FieldByName(IdMittenteValue).AsString;
      if (Trim(IdMittenteValue) <> '') and (Mittente = '') then
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_NO_ID,['mittente',IdMittenteValue,cdsRisultato.FieldByName('GRUPPO_DESC').AsString]),'',0)
      else
      begin
        //Leggo il valore del campo ufficio dalla griglia
        Ufficio:='';
        Ufficio:=cdsRisultato.FieldByName(IdUfficioValue).AsString;
        if Ufficio = '' then
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_NO_ID,['ufficio',IdUfficioValue,cdsRisultato.FieldByName('GRUPPO_DESC').AsString]),'',0)
        else
        begin
          ProgNum:=ProgNum+1;
          // ----- NODO tasso_assenza
          Nodo:=NodoCorrente.AddChild('tasso_assenza');
          NodoCorrente:=Nodo;
          // ----- NODO idMittente
          Nodo:=NodoCorrente.AddChild('idMittente');
          if Trim(IdMittenteValue) = '' then   //Se campo mittente non valorizz. --> mittente = valore fisso = progressivo riga
            Nodo.Text:=IntToStr(ProgNum)
          else                         //Se campo mittente valorizz. e presente sulla griglia risultato
            Nodo.Text:=Mittente;
          // ----- NODO id_ufficio
          Nodo:=NodoCorrente.AddChild('id_ufficio');
          Nodo.Text:=Ufficio;          //Campo ufficio presente sulla griglia risultato
          // ----- NODO anno_rif
          Nodo:=NodoCorrente.AddChild('anno_rif');
          Nodo.Text:=InttoStr(R180Anno(AData));
          // ----- NODO mese_rif
          Nodo:=NodoCorrente.AddChild('mese_rif');
          Nodo.Text:=IntToStr(R180Mese(AData));
          // ----- NODO assenza
          Nodo:=NodoCorrente.AddChild('assenza');
          if cdsRisultato.FieldByName('TASSOASS').Visible then
            Nodo.Text:=StringReplace(IfThen(cdsRisultato.FieldByName('TASSOASS').AsString='','0',cdsRisultato.FieldByName('TASSOASS').AsString),',','.',[rfReplaceAll])
          else if cdsRisultato.FieldByName('PERCENTASS').Visible then
            Nodo.Text:=StringReplace(IfThen(cdsRisultato.FieldByName('PERCENTASS').AsString='','0',cdsRisultato.FieldByName('PERCENTASS').AsString),',','.',[rfReplaceAll]);
        end;
      end;
    end;
    cdsRisultato.Next;
  end;
end;

procedure TA151FAssenteismoMW.ControlliGeneraXmlLegge104;
begin
  if Trim(UserNameText) = '' then
    raise Exception.Create('Specificare lo username dell''utenza web service!');
  if Trim(PasswordText) = '' then
    raise Exception.Create('Specificare la password dell''utenza web service!');
  if Trim(CodEnteText) = '' then
    raise Exception.Create('Specificare il codice ente per cui comunicare i dati!');
  if Trim(URLWSText) = '' then
    raise Exception.Create('Specificare l''URL di collegamento al WebService!');
  if not DettDip then
    raise Exception.Create('Il dettaglio dipendente deve essere presente nella griglia risultato!');
  if not DettGG then
    raise Exception.Create('Il dettaglio giornaliero deve essere presente nella griglia risultato!');
  if not DettFam then
    raise Exception.Create('Il dettaglio familiari deve essere presente nella griglia risultato!');
  if (cdsRisultato.FindField('SESSO') = nil) or (not cdsRisultato.FieldByName('SESSO').Visible) then
    raise Exception.Create('Il dato SESSO dipendente deve essere presente nella griglia risultato!');
  if (cdsRisultato.FindField('DATANAS') = nil) or (not cdsRisultato.FieldByName('DATANAS').Visible) then
    raise Exception.Create('Il dato DATANAS dipendente deve essere presente nella griglia risultato!');
  if (cdsRisultato.FindField('T430DC_COMUNENAS') = nil) or (not cdsRisultato.FieldByName('T430DC_COMUNENAS').Visible) then
    raise Exception.Create('Il dato T430DC_COMUNENAS dipendente deve essere presente nella griglia risultato!');
  if (cdsRisultato.FindField('T430DC_COMUNERES') = nil) or (not cdsRisultato.FieldByName('T430DC_COMUNERES').Visible) then
    raise Exception.Create('Il dato T430DC_COMUNERES dipendente deve essere presente nella griglia risultato!');
  if (cdsRisultato.FindField('T430DC_INQUADRAMENTO') = nil) or (not cdsRisultato.FieldByName('T430DC_INQUADRAMENTO').Visible) then
    raise Exception.Create('Il dato T430DC_INQUADRAMENTO dipendente deve essere presente nella griglia risultato!');
  if (cdsRisultato.FindField('T430DC_DURATACONTR') = nil) or (not cdsRisultato.FieldByName('T430DC_DURATACONTR').Visible) then
    raise Exception.Create('Il dato T430DC_DURATACONTR dipendente deve essere presente nella griglia risultato!');
  if (cdsRisultato.FindField('T430DC_TIPOCONTR') = nil) or (not cdsRisultato.FieldByName('T430DC_TIPOCONTR').Visible) then
    raise Exception.Create('Il dato T430DC_TIPOCONTR dipendente deve essere presente nella griglia risultato!');
  if (cdsRisultato.FindField('T430DC_TIPOPT') = nil) or (not cdsRisultato.FieldByName('T430DC_TIPOPT').Visible) then
    raise Exception.Create('Il dato T430DC_TIPOPT dipendente deve essere presente nella griglia risultato!');
  if (cdsRisultato.FindField('T430DC_PERCPT') = nil) or (not cdsRisultato.FieldByName('T430DC_PERCPT').Visible) then
    raise Exception.Create('Il dato T430DC_PERCPT dipendente deve essere presente nella griglia risultato!');
  if (cdsRisultato.FindField('T430INIZIO') = nil) or (not cdsRisultato.FieldByName('T430INIZIO').Visible) then
    raise Exception.Create('Il dato T430INIZIO dipendente deve essere presente nella griglia risultato!');
  if (cdsRisultato.FindField('GGASSL104') = nil) or (not cdsRisultato.FieldByName('GGASSL104').Visible) then
    raise Exception.Create('Il dato [304] Giorni di assenza legge 104/1992 deve essere presente nella griglia risultato!');
  if (cdsRisultato.FindField('HHASSL104') = nil) or (not cdsRisultato.FieldByName('HHASSL104').Visible) then
    raise Exception.Create('Il dato [305] Ore di assenza legge 104/1992 deve essere presente nella griglia risultato!');
end;

procedure TA151FAssenteismoMW.WSLegge104;
var L104PT:Legge104;
    Req:wsdlRequest;
    Res:wsdlResponse;
    per:Array_Of_permesso;
    det:Array_Of_dettaglio;
    ass:Array_Of_assistito;
    PermessiInviati:Integer;
    OldMatricola,NomeProc:String;
    OldProg:Integer;
    OldDataNasFam:TDateTime;
    OldMese,i_p,i_d,i_a:Integer;
    Terzi:Boolean;
  procedure AssegnaPermessoWS;
  begin
    if Length(det) > 0 then
    begin
      per[i_p].dettaglio:=det;
      if Terzi then
      begin
        ass[i_a].permesso:=per;
        Req.inserimentoPermessi.nuovoPermesso.permessiTerzi.assistito:=ass;
      end
      else
        Req.inserimentoPermessi.nuovoPermesso.seStesso.permesso:=per;
    end;
  end;
  procedure InserisciPermessoWS;
  begin
    AssegnaPermessoWS;
    if Length(det) > 0 then
    begin
      try
        try
          Res:=L104PT.InserimentoPermessi(Req);
          if Res.esitoInserimentoPermessi.esito = esito_type(0) then
            inc(PermessiInviati)
          else
            //R180MessageBox('Esito negativo: ' + Res.esitoInserimentoPermessi.errori[0],ERRORE);
            RegistraMsg.InserisciMessaggio('A','Esito negativo: ' + Res.esitoInserimentoPermessi.errori[0],'',OldProg);
          if Res <> nil then Res.Free;//non deve stare nel finally, altrimenti va in access violation
        except
          on E:exception do
          begin
            //R180MessageBox('Errore nel richiamo al WebService! ' + E.Message,ERRORE);
            RegistraMsg.InserisciMessaggio('A','Errore nel richiamo al WebService! ' + E.Message,'',OldProg);
            //abort; //tolto l'abort per permettere l'invio per i dipendenti successivi
          end;
        end;
      finally
        if Req <> nil then
        begin
          Req.Free;
          SetLength(det,0);
          SetLength(per,0);
          SetLength(ass,0);
        end;
      end;
    end;
  end;
  procedure GeneraNuovoPermessoWS;
  begin
    Req:=wsdlRequest.Create;
    Req.userName:=UserNameText;
    Req.pwd:=PasswordText;
    Req.inserimentoPermessi:=inserimentoPermessi.Create;
    Req.inserimentoPermessi.codiceEnte:=StrToInt(CodEnteText);
    Req.inserimentoPermessi.annoRiferimento:=TXSDecimal.Create;
    Req.inserimentoPermessi.annoRiferimento.DecimalString:=IntToStr(R180Anno(AData));
    Req.inserimentoPermessi.nuovoPermesso:=nuovoPermesso_type.Create;
    //dipendente
    Req.inserimentoPermessi.nuovoPermesso.dipendente:=dipendente.Create;
    Req.inserimentoPermessi.nuovoPermesso.dipendente.codiceFiscale:=cdsRisultato.FieldByName('CODFISCALE').AsString;
    if cdsRisultato.FieldByName('CODFISCALE').AsString = '' then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Cod.fiscale','per il dipendente']),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    Req.inserimentoPermessi.nuovoPermesso.dipendente.cognome:=cdsRisultato.FieldByName('COGNOME').AsString;
    if cdsRisultato.FieldByName('COGNOME').AsString = '' then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Cognome','per il dipendente']),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    Req.inserimentoPermessi.nuovoPermesso.dipendente.nome:=cdsRisultato.FieldByName('NOME').AsString;
    if cdsRisultato.FieldByName('NOME').AsString = '' then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Nome','per il dipendente']),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    Req.inserimentoPermessi.nuovoPermesso.dipendente.sesso:=sesso_type(IfThen(cdsRisultato.FieldByName('SESSO').AsString = 'M',0,1));
    if cdsRisultato.FieldByName('SESSO').AsString = '' then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Sesso','per il dipendente']),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    Req.inserimentoPermessi.nuovoPermesso.dipendente.dataNascita:=TXSDate.Create;
    Req.inserimentoPermessi.nuovoPermesso.dipendente.dataNascita.AsDate:=cdsRisultato.FieldByName('DATANAS').AsDateTime;
    if cdsRisultato.FieldByName('DATANAS').AsString = '' then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Data nascita','']),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    Req.inserimentoPermessi.nuovoPermesso.dipendente.comuneNascita:=cdsRisultato.FieldByName('T430DC_COMUNENAS').AsString;
    if cdsRisultato.FieldByName('T430DC_COMUNENAS').AsString = '' then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Comune nascita','']),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    Req.inserimentoPermessi.nuovoPermesso.dipendente.comuneResidenza:=cdsRisultato.FieldByName('T430DC_COMUNERES').AsString;
    if cdsRisultato.FieldByName('T430DC_COMUNERES').AsString = '' then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Comune residenza','']),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    //datiContrattuali
    Req.inserimentoPermessi.nuovoPermesso.datiContrattuali:=datiContrattuali.Create;
    if cdsRisultato.FieldByName('T430DC_INQUADRAMENTO').AsString = '' then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Inquadramento','']),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger)
    else if (cdsRisultato.FieldByName('T430DC_INQUADRAMENTO').AsString <> '1') and (cdsRisultato.FieldByName('T430DC_INQUADRAMENTO').AsString <> '2') and
            (cdsRisultato.FieldByName('T430DC_INQUADRAMENTO').AsString <> '3') and (cdsRisultato.FieldByName('T430DC_INQUADRAMENTO').AsString <> '4') then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_VALORI_DIVERSI,['Inquadramento','1,2,3,4']),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    Req.inserimentoPermessi.nuovoPermesso.datiContrattuali.inquadramento:=cdsRisultato.FieldByName('T430DC_INQUADRAMENTO').AsInteger;
    Req.inserimentoPermessi.nuovoPermesso.datiContrattuali.dataEntrata:=TXSDate.Create;
    Req.inserimentoPermessi.nuovoPermesso.datiContrattuali.dataEntrata.AsDate:=cdsRisultato.FieldByName('T430INIZIO').AsDateTime;
    if cdsRisultato.FieldByName('T430INIZIO').AsString = '' then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Data assunzione','']),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    if cdsRisultato.FieldByName('T430DC_DURATACONTR').AsString = '' then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Durata contratto dipendente','']),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger)
    else if (cdsRisultato.FieldByName('T430DC_DURATACONTR').AsString <> '1') and (cdsRisultato.FieldByName('T430DC_DURATACONTR').AsString <> '2') then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_VALORI_DIVERSI,['Durata contratto dipendente','1,2']),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    Req.inserimentoPermessi.nuovoPermesso.datiContrattuali.durata:=cdsRisultato.FieldByName('T430DC_DURATACONTR').AsInteger;
    if cdsRisultato.FieldByName('T430DC_TIPOCONTR').AsString = '' then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Tipo contratto dipendente','']),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger)
    else if (cdsRisultato.FieldByName('T430DC_TIPOCONTR').AsString <> '1') and (cdsRisultato.FieldByName('T430DC_TIPOCONTR').AsString <> '2') then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_VALORI_DIVERSI,['Tipo contratto dipendente','1,2']),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    Req.inserimentoPermessi.nuovoPermesso.datiContrattuali.tipoContratto:=cdsRisultato.FieldByName('T430DC_TIPOCONTR').AsInteger;
    if cdsRisultato.FieldByName('T430DC_TIPOCONTR').AsString = '2' then
    begin
      if cdsRisultato.FieldByName('T430DC_TIPOPT').AsString = '' then
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Tipo part-time','']),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger)
      else if (cdsRisultato.FieldByName('T430DC_TIPOPT').AsString <> '1') and (cdsRisultato.FieldByName('T430DC_TIPOPT').AsString <> '2')  and (cdsRisultato.FieldByName('T430DC_TIPOPT').AsString <> '3') then
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_VALORI_DIVERSI,['Tipo part-time','1,2,3']),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
      Req.inserimentoPermessi.nuovoPermesso.datiContrattuali.tipoPartTime:=cdsRisultato.FieldByName('T430DC_TIPOPT').AsInteger;
      Req.inserimentoPermessi.nuovoPermesso.datiContrattuali.percentualePartTime:=TXSDecimal.Create;
      if cdsRisultato.FieldByName('T430DC_PERCPT').AsString = '' then
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Percentuale part-time','']),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger)
      else
        Req.inserimentoPermessi.nuovoPermesso.datiContrattuali.percentualePartTime.DecimalString:=StringReplace(FloatToStr(R180Arrotonda(StrToFloat(cdsRisultato.FieldByName('T430DC_PERCPT').AsString),0.01,'P')),',','.',[rfReplaceAll]);
    end;
    //agevolazioni
    Req.inserimentoPermessi.nuovoPermesso.agevolazioni:=agevolazioni.Create;
    Req.inserimentoPermessi.nuovoPermesso.agevolazioni.avvicinamentoSede:=yesNo_type(IfThen(cdsRisultato.FieldByName('ANNO_AVV').AsString = '',1,0));
    if cdsRisultato.FieldByName('ANNO_AVV').AsString <> '' then
      Req.inserimentoPermessi.nuovoPermesso.agevolazioni.avvicinamentoAnno:=cdsRisultato.FieldByName('ANNO_AVV').AsString;
  end;
  procedure GeneraPermessiSeStessoWS;
  begin
    Req.inserimentoPermessi.nuovoPermesso.seStesso:=seStesso.Create;
    Req.inserimentoPermessi.nuovoPermesso.seStesso.tipoDisabilita:=StrToIntDef(Copy(cdsRisultato.FieldByName('TIPO_DISABILITA').AsString,1,1),-1);
    if cdsRisultato.FieldByName('TIPO_DISABILITA').AsString = '' then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Tipo disabilità dipendente','']),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger)
    else if (Copy(cdsRisultato.FieldByName('TIPO_DISABILITA').AsString,1,1) <> '1') and (Copy(cdsRisultato.FieldByName('TIPO_DISABILITA').AsString,1,1) <> '2')  and (Copy(cdsRisultato.FieldByName('TIPO_DISABILITA').AsString,1,1) <> '3') then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_VALORI_DIVERSI,['Tipo disabilità dipendente','1,2,3']),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    if Copy(cdsRisultato.FieldByName('TIPO_DISABILITA').AsString,1,1) = '1' then
    begin
      Req.inserimentoPermessi.nuovoPermesso.seStesso.annoRevisione:=cdsRisultato.FieldByName('ANNO_REVISIONE').AsString;
      if cdsRisultato.FieldByName('ANNO_REVISIONE').AsString = '' then
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Data revisione dipendente','']),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    end;
  end;
  procedure GeneraPermessiTerziWS;
  begin
    if not Terzi then
    begin
      Req.inserimentoPermessi.nuovoPermesso.permessiTerzi:=permessiTerzi.Create;
      Req.inserimentoPermessi.nuovoPermesso.permessiTerzi.avvicinamentoAltriSede:=yesNo_type(IfThen(cdsRisultato.FieldByName('ANNO_AVV_FAM').AsString = '',1,0));
      if cdsRisultato.FieldByName('ANNO_AVV_FAM').AsString <> '' then
        Req.inserimentoPermessi.nuovoPermesso.permessiTerzi.avvicinamentoAltriAnno:=cdsRisultato.FieldByName('ANNO_AVV_FAM').AsString;
      SetLength(ass,0);
    end;
    SetLength(ass,Length(ass) + 1);
    i_a:=High(ass);
    ass[i_a]:=assistito.Create;
    if cdsRisultato.FieldByName('DATANASFAM').AsString = '' then
    begin
      RegistraMsg.InserisciMessaggio('A',A000MSG_A151_ERR_GIUST_NO_FAMILIARE,'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    ass[i_a].codiceFiscale:=cdsRisultato.FieldByName('CODFISCFAM').AsString;
    if cdsRisultato.FieldByName('CODFISCFAM').AsString = '' then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Codice fiscale','per il familiare ' +
        cdsRisultato.FieldByName('COGNOMEFAM').AsString + ' ' + cdsRisultato.FieldByName('NOMEFAM').AsString]),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    ass[i_a].cognome:=cdsRisultato.FieldByName('COGNOMEFAM').AsString;
    if cdsRisultato.FieldByName('COGNOMEFAM').AsString = '' then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Cognome',Format(A000MSG_A151_MSG_FMT_CF_FAMILIARE,[cdsRisultato.FieldByName('CODFISCFAM').AsString])]),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    ass[i_a].nome:=cdsRisultato.FieldByName('NOMEFAM').AsString;
    if cdsRisultato.FieldByName('NOMEFAM').AsString = '' then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Nome',Format(A000MSG_A151_MSG_FMT_CF_FAMILIARE,[cdsRisultato.FieldByName('CODFISCFAM').AsString])]),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    ass[i_a].sesso:=sesso_type(IfThen(cdsRisultato.FieldByName('SESSOFAM').AsString = 'M',0,1));
    if cdsRisultato.FieldByName('SESSOFAM').AsString = '' then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Sesso',Format(A000MSG_A151_MSG_FMT_CF_FAMILIARE,[cdsRisultato.FieldByName('CODFISCFAM').AsString])]),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    //Se il familiare è adottato e quindi DATANASFAM = data adozione, ricerco la data di nascita
    R180SetVariable(selSG101,'PROG',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selSG101,'ADOZ','S');
    R180SetVariable(selSG101,'DATAADOZ',cdsRisultato.FieldByName('DATANASFAM').AsDateTime);
    R180SetVariable(selSG101,'DATARIF',FormatDateTime('dd/mm/yyyy',AData));
    selSG101.Open;
    ass[i_a].dataNascita:=TXSDate.Create;
    if selSG101.RecordCount > 0 then
      ass[i_a].dataNascita.AsDate:=StrToDate(Copy(selSG101.FieldByName('DATANAS').AsString,1,10))
    else
      ass[i_a].dataNascita.AsDate:=StrToDate(Copy(cdsRisultato.FieldByName('DATANASFAM').AsString,1,10));
    ass[i_a].comuneNascita:=Copy(cdsRisultato.FieldByName('COMNASFAM').AsString,1,4);
    if cdsRisultato.FieldByName('COMNASFAM').AsString = '' then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Comune nascita',Format(A000MSG_A151_MSG_FMT_CF_FAMILIARE,[cdsRisultato.FieldByName('CODFISCFAM').AsString])]),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    ass[i_a].comuneResidenza:=Copy(cdsRisultato.FieldByName('COMRESFAM').AsString,1,4);
    if cdsRisultato.FieldByName('COMRESFAM').AsString = '' then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Comune residenza',Format(A000MSG_A151_MSG_FMT_CF_FAMILIARE,[cdsRisultato.FieldByName('CODFISCFAM').AsString])]),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    ass[i_a].parentelaDipendente:=StrToIntDef(Copy(cdsRisultato.FieldByName('PARENTELA_L104').AsString,1,1),-1);
    if cdsRisultato.FieldByName('PARENTELA_L104').AsString = '' then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Parentela',Format(A000MSG_A151_MSG_FMT_CF_FAMILIARE,[cdsRisultato.FieldByName('CODFISCFAM').AsString])]),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    ass[i_a].tipoDisabilita:=StrToIntDef(Copy(cdsRisultato.FieldByName('TIPO_DISABILITA').AsString,1,1),-1);
    if cdsRisultato.FieldByName('TIPO_DISABILITA').AsString = '' then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Tipo disabilità',Format(A000MSG_A151_MSG_FMT_CF_FAMILIARE,[cdsRisultato.FieldByName('CODFISCFAM').AsString])]),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger)
    else if (Copy(cdsRisultato.FieldByName('TIPO_DISABILITA').AsString,1,1) <> '1') and (Copy(cdsRisultato.FieldByName('TIPO_DISABILITA').AsString,1,1) <> '2')  and (Copy(cdsRisultato.FieldByName('TIPO_DISABILITA').AsString,1,1) <> '3') then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_VALORI_DIVERSI + A000MSG_A151_MSG_FMT_CF_FAMILIARE,['Tipo disabilità','1,2,3',cdsRisultato.FieldByName('CODFISCFAM').AsString]),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    if Copy(cdsRisultato.FieldByName('TIPO_DISABILITA').AsString,1,1) = '1' then
    begin
      ass[i_a].annoRevisione:=cdsRisultato.FieldByName('ANNO_REVISIONE').AsString;
      if cdsRisultato.FieldByName('ANNO_REVISIONE').AsString = '' then
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Data revisione',Format(A000MSG_A151_MSG_FMT_CF_FAMILIARE,[cdsRisultato.FieldByName('CODFISCFAM').AsString])]),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    end;
    if cdsRisultato.FieldByName('NUMGRADO').AsString = '3' then
    begin
      ass[i_a].terzoGrado:=terzoGrado.Create;
      ass[i_a].terzoGrado.motivo:=StrToIntDef(Copy(cdsRisultato.FieldByName('MOTIVO_GRADO_3').AsString,1,1),-1);
      if cdsRisultato.FieldByName('MOTIVO_GRADO_3').AsString = '' then
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Motivo terzo grado',Format(A000MSG_A151_MSG_FMT_CF_FAMILIARE,[cdsRisultato.FieldByName('CODFISCFAM').AsString])]),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    end;
    if Copy(cdsRisultato.FieldByName('GRADOPAR').AsString,1,2) = 'FG' then
    begin
      ass[i_a].genitore:=genitore.Create;
      ass[i_a].genitore.figlioFinoTreAnni:=yesNo_type(IfThen(cdsRisultato.FieldByName('FIGLIO3ANNI').AsString = 'Si',0,1));
      ass[i_a].genitore.alternativa:=StrToIntDef(Copy(cdsRisultato.FieldByName('ALTERNATIVA').AsString,1,1),-1);
      if cdsRisultato.FieldByName('ALTERNATIVA').AsString = '' then
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Alternativa',Format(A000MSG_A151_MSG_FMT_CF_FAMILIARE,[cdsRisultato.FieldByName('CODFISCFAM').AsString])]),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger)
      else if Copy(cdsRisultato.FieldByName('ALTERNATIVA').AsString,1,1) <> '6' then
        ass[i_a].genitore.alternativaDipendentePubblico:=yesNo_type(IfThen(cdsRisultato.FieldByName('NOME_PA_ALT').AsString = '',1,0));
      if cdsRisultato.FieldByName('NOME_PA_ALT').AsString <> '' then
        ass[i_a].genitore.alternativaDenominazionePA:=cdsRisultato.FieldByName('NOME_PA_ALT').AsString;
      if Copy(cdsRisultato.FieldByName('ALTERNATIVA').AsString,1,1) = '5' then
      begin
        ass[i_a].genitore.terzoGrado:=terzoGrado.Create;
        ass[i_a].genitore.terzoGrado.motivo:=StrToIntDef(Copy(cdsRisultato.FieldByName('MOTIVO_GRADO_3_ALT').AsString,1,1),-1);
        if cdsRisultato.FieldByName('MOTIVO_GRADO_3_ALT').AsString = '' then
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_RIGA_INVALIDA,['Motivo terzo grado alternativa',Format(A000MSG_A151_MSG_FMT_CF_FAMILIARE,[cdsRisultato.FieldByName('CODFISCFAM').AsString])]),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
      end;
    end;
    if cdsRisultato.FieldByName('NOME_PA').AsString <> '' then
    begin
      ass[i_a].dipendentePubblico:=dipendentePubblico.Create;
      ass[i_a].dipendentePubblico.denominazione:=cdsRisultato.FieldByName('NOME_PA').AsString;
      if cdsRisultato.FieldByName('DURATA_PA').AsString <> '' then
      begin
        ass[i_a].dipendentePubblico.durata:=StrToIntDef(Copy(cdsRisultato.FieldByName('DURATA_PA').AsString,1,1),-1);
        if (Copy(cdsRisultato.FieldByName('DURATA_PA').AsString,1,1) <> '1') and (Copy(cdsRisultato.FieldByName('DURATA_PA').AsString,1,1) <> '2') then
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_VALORI_DIVERSI + A000MSG_A151_MSG_FMT_CF_FAMILIARE,['Durata contratto diversa','1,2',cdsRisultato.FieldByName('CODFISCFAM').AsString]),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
      end;
    end;
  end;
begin
  L104PT:=GetLegge104(False,URLWSText);
  //CICLO su griglia risultato
  OldMatricola:='';
  OldProg:=0;
  OldDataNasFam:=-1;  //Inizializzo a -1 perchè DATANASFAM può essere 0 e quindi poi non funziona il test
  OldMese:=0;
  Terzi:=False;
  while not cdsRisultato.Eof do
  begin
    if cdsRisultato.FieldByName('GRUPPO_DESC').AsString <> 'Totale Generale' then  //salto la riga del totale generale
    try
      NomeProc:='';
      if cdsRisultato.FieldByName('MATRICOLA').AsString <> OldMatricola then
      begin
        NomeProc:='InserisciPermessoWS';
        InserisciPermessoWS;
        Terzi:=False;
        OldDataNasFam:=-1;
        OldMese:=0;
        NomeProc:='GeneraNuovoPermessoWS';
        GeneraNuovoPermessoWS;
      end;
      if cdsRisultato.FieldByName('DATANASFAM').AsDateTime <> OldDataNasFam then
      begin
        NomeProc:='AssegnaPermessoWS';
        AssegnaPermessoWS;
        if Copy(cdsRisultato.FieldByName('GRADOPAR').AsString,1,2) = 'NS' then  //se stesso
        begin
          NomeProc:='GeneraPermessiSeStessoWS';
          GeneraPermessiSeStessoWS;
          Terzi:=False;//DA: aggiunto per sicurezza, ma forse non necessario: utile se i record dei terzi venissero elaborati prima di se stesso
        end
        else
        begin
          NomeProc:='GeneraPermessiTerziWS';
          GeneraPermessiTerziWS;
          Terzi:=True;
        end;
        OldMese:=0;
        SetLength(det,0);
        SetLength(per,0);
      end;
      if R180Mese(cdsRisultato.FieldByName('DATAGIUSTIF').AsDateTime) <> OldMese then
      begin
        NomeProc:='AssegnaPermessoWS';
        AssegnaPermessoWS;
        SetLength(per,Length(per) + 1);
        i_p:=High(per);
        per[i_p]:=permesso.Create;
        per[i_p].mese:=R180Mese(cdsRisultato.FieldByName('DATAGIUSTIF').AsDateTime);
        SetLength(det,0);
      end;
      NomeProc:='WSLegge104';
      SetLength(det,Length(det) + 1);
      i_d:=High(det);
      det[i_d]:=dettaglio.Create;
      det[i_d].giorno:=R180Giorno(cdsRisultato.FieldByName('DATAGIUSTIF').AsDateTime);
      det[i_d].giornata:=cdsRisultato.FieldByName('GGASSL104').AsString <> '';
      det[i_d].ore:=TXSDecimal.Create;
      det[i_d].ore.DecimalString:=IfThen(cdsRisultato.FieldByName('HHASSL104').AsString = '','0',StringReplace(cdsRisultato.FieldByName('HHASSL104').AsString,',','.',[rfReplaceAll]));
      OldProg:=cdsRisultato.FieldByName('PROGRESSIVO').AsInteger;//non salvo la riga del totale generale
    except
      on E:Exception do
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_ERR_GEN,[NomeProc,E.Message]),'',cdsRisultato.FieldByName('PROGRESSIVO').AsInteger);
    end;
    OldMatricola:=cdsRisultato.FieldByName('MATRICOLA').AsString;
    OldDataNasFam:=cdsRisultato.FieldByName('DATANASFAM').AsDateTime;
    OldMese:=R180Mese(cdsRisultato.FieldByName('DATAGIUSTIF').AsDateTime);
    cdsRisultato.Next;
  end;
  InserisciPermessoWS;
end;

end.
