unit A131UGestioneAnticipi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  C180FunzioniGenerali, R001UGESTTAB, DBCtrls, Buttons, Grids, DBGrids, A120UTipiRimborsi,
  ExtCtrls, StdCtrls, Mask, ComCtrls, SelAnagrafe, ActnList, ImgList, DB,
  Menus, ToolWin, C013UCheckList, C700USelezioneAnagrafe, A000UCostanti, A000USessione,
  A000UInterfaccia, C005UDatiAnagrafici, Variants, A003UDataLavoroBis, OracleData,
  C012UVisualizzaTesto, Oracle, System.Actions, A000UMessaggi;

type
  TA131FGestioneAnticipi = class(TR001FGestTab)
    frmSelAnagrafe: TfrmSelAnagrafe;
    TPageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    DEdtCassa: TDBEdit;
    DEdtAnnoMov: TDBEdit;
    DEdtNmov: TDBEdit;
    DEdtDataMov: TDBEdit;
    DEdtQuantita: TDBEdit;
    DEdtImporto: TDBEdit;
    DChkFlag: TDBCheckBox;
    DEdtData: TDBEdit;
    BtnData: TButton;
    GroupBox2: TGroupBox;
    Label11: TLabel;
    DEdtDataStato: TDBEdit;
    DRdGrpStato: TDBRadioGroup;
    BtnDataImp: TButton;
    DBGrid1: TDBGrid;
    BtnDataMOv: TButton;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Panel4: TPanel;
    DGridM050: TDBGrid;
    Label10: TLabel;
    Label12: TLabel;
    Panel5: TPanel;
    DCmbMissioni: TDBLookupComboBox;
    BtnCollega: TSpeedButton;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    LblDataDa: TLabel;
    LblProtocollo: TLabel;
    LblMeseScarico: TLabel;
    LblMeseCompetenza: TLabel;
    DCmbCodVoce: TDBLookupComboBox;
    PopupMenu1: TPopupMenu;
    NuovoElemento1: TMenuItem;
    DMmNote: TDBMemo;
    Panel6: TPanel;
    DBRadioGroup1: TDBRadioGroup;
    LstAnticipi: TListBox;
    BtnElencoAnticipi: TButton;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label21: TLabel;
    ValDataMiss: TLabel;
    ValCassa: TLabel;
    ValAnnoMov: TLabel;
    ValNumMov: TLabel;
    ValCodVoce: TLabel;
    DEdtNSosp: TDBEdit;
    Label22: TLabel;
    dedtDescCodVoce: TDBText;
    rgpFiltro: TRadioGroup;
    Label23: TLabel;
    DBText1: TDBText;
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LstAnticipiClick(Sender: TObject);
    procedure BtnElencoAnticipiClick(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure DRdGrpStatoClick(Sender: TObject);
    procedure DCmbMissioniKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DCmbCodVoceKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DEdtDataMovKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TPageControl1Change(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure NuovoElemento1Click(Sender: TObject);
    procedure BtnCollegaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure BtnDataImpClick(Sender: TObject);
    procedure BtnDataMOvClick(Sender: TObject);
    procedure BtnDataClick(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TfrmSelAnagrafe1btnSelezioneClick(Sender: TObject);
    procedure TfrmSelAnagrafe1R003DatianagraficiClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DEdtNmovDblClick(Sender: TObject);
    procedure rgpFiltroClick(Sender: TObject);
  private
    { Private declarations }
    IdMissione:Integer;
    procedure CambiaProgressivo;
    procedure SetEdit;
    procedure SeekRec;
    //procedure LoadTipiRimborsi(var Edt:TDBEdit);
    procedure ControllaStato(Field: TField = nil);
    procedure PutAnticipi;
    procedure GetAnticipi;
    procedure NormalizzaTitolo(var Grid: TDBGrid);
  public
  end;

var
  A131FGestioneAnticipi: TA131FGestioneAnticipi;

procedure OpenA131GestioneAnticipi(Prog:LongInt;IdMiss:Integer);

implementation

uses A131UGestioneAnticipiDtm;

{$R *.DFM}

procedure OpenA131GestioneAnticipi(Prog:LongInt;IdMiss:Integer);
{Gestione Plus Orario individuale}
begin
  if Prog <= 0 then
  begin
    ShowMessage('Nessun dipendente selezionato!');
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA131GestioneAnticipi') of
    'N':begin
          ShowMessage('Funzione non abilitata!');
          Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A131FGestioneAnticipi:=TA131FGestioneAnticipi.Create(nil);
  with A131FGestioneAnticipi do
  try
    BtnCollega.Enabled:=Not(SolaLettura);
    BtnElencoAnticipi.Enabled:=Not(SolaLettura);
    C700Progressivo:=Prog;
    A131FGestioneAnticipiDtM:=TA131FGestioneAnticipiDtM.Create(nil);
    IdMissione:=IdMiss;
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A131FGestioneAnticipiDtM.Free;
    Free;
  end;
end;

procedure TA131FGestioneAnticipi.SetEdit;
var i:Integer;
begin
  for i:=0 to ComponentCount - 1 do
  begin
    if Components[i] is TDBEdit then
      TDBEdit(Components[i]).DataSource:=DButton;
    if Components[i] is TDBCheckBox then
      TDBCheckBox(Components[i]).DataSource:=DButton;
    if Components[i] is TDBRadioGroup then
      TDBRadioGroup(Components[i]).DataSource:=DButton;
    if Components[i] is TDBMemo then
      TDBMemo(Components[i]).DataSource:=DButton;
  end;
  if False then
    A131FGestioneAnticipiDtm.dscM060.DataSet:=A131FGestioneAnticipiDtm.A131FGestioneAnticipiMW.groupM060
  else
    A131FGestioneAnticipiDtm.dscM060.DataSet:=A131FGestioneAnticipiDtm.selM060;
  DBGrid1.DataSource:=A131FGestioneAnticipiDtm.dscM060;
  DGridM050.DataSource:=A131FGestioneAnticipiDtm.A131FGestioneAnticipiMW.dscM050;
  with A131FGestioneAnticipiDtm do
  begin
    DEdtCassa.DataField:='CASSA';
    DEdtAnnoMov.DataField:='ANNO_MOVIMENTO';
    DEdtNmov.DataField:='NUM_MOVIMENTO';
    DEdtNSosp.DataField:='NROSOSP';
//====================
//SET DBLOOKUPCOMBOBOX
//====================
    DCmbCodVoce.ListSource:=A131FGestioneAnticipiDtm.A131FGestioneAnticipiMW.dscTAnticipi;
    DCmbCodVoce.ListField:='CODICE;DESCRIZIONE';
    DCmbCodVoce.KeyField:='CODICE';
    DCmbCodVoce.DataSource:=DButton;
    DCmbCodVoce.DataField:='COD_VOCE';
//==============================================
    DEdtDataMov.DataField:='DATA_MOVIMENTO';
    DEdtQuantita.DataField:='QUANTITA';
    DEdtImporto.DataField:='IMPORTO';
    DEdtData.DataField:='DATA_MISSIONE';
    DEdtDataStato.DataField:='DATA_IMPOSTAZIONE_STATO';
    DMmNote.DataField:='NOTE';
    DChkFlag.DataField:='FLAG_TOTALIZZATORE';
    DRdGrpStato.DataField:='STATO';
  end;
end;

procedure TA131FGestioneAnticipi.CambiaProgressivo;
Var TempProg:Integer;
begin
  with A131FGestioneAnticipiDtM do
  begin
    TempProg:=C700Progressivo;
//    A131FGestioneAnticipiMW.ImpostaProgressivo(TempProg);
    A131FGestioneAnticipiMW.ImpostaProgressivo;
    NumRecords;
    ControllaStato;
    //posiziono la combo sull'anticipo corrente
    DCmbMissioni.KeyValue:=A131FGestioneAnticipiMW.selM040.FieldByName('IDMISSIONI').AsString;
    A131FGestioneAnticipiMW.CaricaAnticipi;
    //Caratto 20/11/2013 su cambio progressivo svuoto lista anticipi altrimenti idex out of bounds
    LstAnticipi.Items.Clear;
    LstAnticipiClick(nil);
 end;
end;

procedure TA131FGestioneAnticipi.DButtonStateChange(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.Enabled:=DButton.State = dsBrowse;
  rgpFiltro.Enabled:=DButton.State = dsBrowse;
  BtnData.Enabled:=DButton.State in [dsInsert,dsEdit];
  BtnDataImp.Enabled:=DButton.State in [dsInsert,dsEdit];
  BtnDataMov.Enabled:=DButton.State in [dsInsert,dsEdit];
end;

procedure TA131FGestioneAnticipi.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A131FGestioneAnticipiDtm.selM060;
  SetEdit;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A131FGestioneAnticipiDtm.A131FGestioneAnticipiMW,SessioneOracle, StatusBar,2,True);

  with A131FGestioneAnticipiDtm do
  begin
    A131FGestioneAnticipiMW.CaricaAnticipi;
//=============================
//SET DBLOOKUPCOMBOBOX MISSIONI
//=============================
    DCmbMissioni.ListSource:=dscM040;
    DCmbMissioni.ListField:='DATADA;PROTOCOLLO;MESESCARICO;MESECOMPETENZA';
    DCmbMissioni.KeyField:='IDMISSIONI';
  end;
  NormalizzaTitolo(DBGrid1);
  NormalizzaTitolo(DGridM050);

  TabSheet2.TabVisible:=False;
  if False then
    TabSheet2.TabVisible:=True;
end;

procedure TA131FGestioneAnticipi.TfrmSelAnagrafe1btnSelezioneClick(
  Sender: TObject);
begin
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA131FGestioneAnticipi.TfrmSelAnagrafe1R003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=Parametri.DataLavoro;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA131FGestioneAnticipi.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
  inherited;
end;

procedure TA131FGestioneAnticipi.actRefreshExecute(Sender: TObject);
var i:integer;
begin
  inherited;
  //devo fare refresh anche del MW
  with A131FGestioneAnticipiDtm.A131FGestioneAnticipiMW do
    for i:=0 to ComponentCount - 1 do
      if (Components[i] is TOracleDataSet) and (TOracleDataSet(Components[i]).Active) then
          TOracleDataSet(Components[i]).Refresh;

  with A131FGestioneAnticipiDtm do
    for i:=0 to ComponentCount - 1 do
      if (Components[i] is TOracleDataSet) and (TOracleDataSet(Components[i]).Active) then
          TOracleDataSet(Components[i]).Refresh;
end;

procedure TA131FGestioneAnticipi.BtnDataClick(Sender: TObject);
var Ret:TDateTime;
begin
  inherited;
  Ret:=DataOut(Parametri.DataLavoro,'Data Missione','B',True);
  if Ret <> 0 then
    A131FGestioneAnticipiDtm.selM060.FieldByName('DATA_MISSIONE').AsDateTime:=Ret;
end;

procedure TA131FGestioneAnticipi.BtnDataMOvClick(Sender: TObject);
var Ret:TDateTime;
begin
  inherited;
  Ret:=DataOut(Parametri.DataLavoro,'Data Movimento','B',True);
  if Ret <> 0 then
    A131FGestioneAnticipiDtm.selM060.FieldByName('DATA_MOVIMENTO').AsDateTime:=Ret;
end;

procedure TA131FGestioneAnticipi.BtnDataImpClick(Sender: TObject);
var Ret:TDateTime;
begin
  inherited;
  Ret:=DataOut(Parametri.DataLavoro,'Data Impostazione Stato','B',True);
  if Ret <> 0 then
    A131FGestioneAnticipiDtm.selM060.FieldByName('DATA_IMPOSTAZIONE_STATO').AsDateTime:=Ret;
end;

procedure TA131FGestioneAnticipi.SeekRec;
var MemValori:array of Variant;
begin
  with A131FGestioneAnticipiDtm do
  begin
    MemValori:=VarArrayOf([A131FGestioneAnticipiMW.groupM060.FieldByName('CASSA').AsVariant,
                           A131FGestioneAnticipiMW.groupM060.FieldByName('ANNO_MOVIMENTO').AsVariant,
                           A131FGestioneAnticipiMW.groupM060.FieldByName('NUMERO_MOVIMENTO').AsVariant,
                           A131FGestioneAnticipiMW.groupM060.FieldByName('STATO').AsVariant]);
    selM060.Locate('CASSA;ANNO_MOVIMENTO;NUM_MOVIMENTO;STATO',MemValori,[]);
  end;
end;

procedure TA131FGestioneAnticipi.DBGrid1CellClick(Column: TColumn);
begin
  inherited;
  if False then
    SeekRec;
end;

procedure TA131FGestioneAnticipi.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if False then
    SeekRec;
end;

procedure TA131FGestioneAnticipi.FormCreate(Sender: TObject);
begin
  inherited;
  TPageControl1.ActivePageIndex:=0;
end;


procedure TA131FGestioneAnticipi.BtnCollegaClick(Sender: TObject);
var LstAnomalie,LstAnticipiSelezionati:TStringList;
  i:Integer;
begin
  inherited;
  with A131FGestioneAnticipiDtm do
  begin
//===============================
//CONTROLLO SELEZIONE PROGRESSIVO
//===============================
    if C700Progressivo = 0 then
      Raise Exception.Create(A000MSG_ERR_NO_DIP);
//======================================
//CONTROLLO SE CI SONO DATE DA COLLEGARE
//======================================
    if LstAnticipi.Items.Count = 0 then
      Raise Exception.Create(A000MSG_A131_ERR_NO_ANT);

    if (DCmbMissioni.KeyValue = null) or (DCmbMissioni.KeyValue = '')  then
      Raise Exception.Create(A000MSG_A131_ERR_NO_MISSIONE);

    if R180MessageBox(A000MSG_A131_DLG_COLLEGA,'DOMANDA') <> mrYes then
      Exit;
    LstAnticipiSelezionati:=TStringList.Create();
    for i:=0 to LstAnticipi.Items.Count-1 do
      LstAnticipiSelezionati.add(  Copy(LstAnticipi.Items[i],0,5));
    LstAnomalie:=A131FGestioneAnticipiMW.CollegaMissioni(LstAnticipiSelezionati);
  end;

  if lstAnomalie.Count > 0 then
    OpenC012VisualizzaTesto('Anomalie Inserimento Anticipi','',lstAnomalie);
  FreeAndNil(LstAnomalie);
  A131FGestioneAnticipiDtm.A131FGestioneAnticipiMW.CaricaAnticipi;
  LstAnticipi.Clear;
  {for i:=Low(AntArray) to High(AntArray) do
    LstAnticipi.Items.Add(Format('%-5s%-15s%-20s',[AntArray[i].AntId,DateToStr(AntArray[i].DataMis),AntArray[i].CodiceV]));}
end;

(*procedure TA131FGestioneAnticipi.LoadTipiRimborsi(var Edt:TDBEdit);
var Dts:TOracleDataSet;
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  C013FCheckList.clbListaDati.MultiSelect:=False;
  Dts:=TOracleDataSet.Create(nil);
  Dts.Session:=A000SessioneIrisWIN.SessioneOracle;
  Dts.SQL.Add('SELECT M020.CODICE, M020.DESCRIZIONE FROM M020_TIPIRIMBORSI M020 WHERE M020.FLAG_ANTICIPO=''S''');
  Dts.Open;
  Dts.First;
  while Not(Dts.Eof) do
  begin
    C013FCheckList.clbListaDati.Items.Add(Format('%-16s %s',[Dts.FieldByName('CODICE').AsString,Dts.FieldByName('DESCRIZIONE').AsString]));
    Dts.Next;
  end;
  FreeAndNil(Dts);
  Try
    R180PutCheckList(Edt.Text,15,C013FCheckList.clbListaDati);
    C013FCheckList.ShowModal;
  Finally
    Edt.Text:=Trim(R180GetCheckList(15, C013FCheckList.clbListaDati));
    FreeAndNil(C013FCheckList);
  end;
end;*)

procedure TA131FGestioneAnticipi.NuovoElemento1Click(Sender: TObject);
var TempCod:String;
begin
  inherited;
  with A131FGestioneAnticipiDtm do
  begin
    TempCod:='';
    if selM060.Active then
      TempCod:=selM060.FieldByName('COD_VOCE').AsString;
    OpenA120TipiRimborsi(TempCod);
  end;
end;

procedure TA131FGestioneAnticipi.ControllaStato(Field: TField = nil);
var Abilita:Boolean;
begin
  with A131FGestioneAnticipiDtm do
  begin
    actInserisci.Enabled:=Not(SolaLettura);
    if DButton.State in [dsInsert,dsEdit] then
      actInserisci.Enabled:=False;
    if Not(selM060.Active) then
      Exit;
    if (Field = nil) then
    begin
      Abilita:=False;
      if (Pos(selM060.FieldByName('STATO').AsString,Parametri.A131_AnticipiGestibili) <> 0)
         and Not(SolaLettura) then
        Abilita:=True;
      if (DButton.State = dsInsert) or (DButton.State = dsEdit) then
      begin
        Abilita:=False;
      end;
      actModifica.Enabled:=Abilita;
      actCancella.Enabled:=Abilita;
      BtnCollega.Enabled:=Abilita;
    end;
  end;
end;

procedure TA131FGestioneAnticipi.DButtonDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  ControllaStato(Field);
end;

procedure TA131FGestioneAnticipi.TPageControl1Change(Sender: TObject);
begin
  inherited;
  if TPageControl1.ActivePageIndex = 1 then
    with A131FGestioneAnticipiDtm do
    begin
      if IdMissione <> 0 then
        A131FGestioneAnticipiMW.selM040.SearchRecord('ID_MISSIONE',VarArrayOf([IdMissione]),[srFromBeginning]);
      if (Not(A131FGestioneAnticipiMW.selM040.Eof) or Not(A131FGestioneAnticipiMW.selM040.Bof)) then
        DCmbMissioni.KeyValue:=A131FGestioneAnticipiMW.selM040.FieldByName('IDMISSIONI').AsString;
      A131FGestioneAnticipiMW.CaricaAnticipi;
      {LstAnticipi.Clear;
      for i:=Low(AntArray) to High(AntArray) do
        LstAnticipi.Items.Add(Format('%-5s%-15s%-20s',[AntArray[i].AntId,DateToStr(AntArray[i].DataMis),AntArray[i].CodiceV]));}
      LstAnticipi.ItemIndex:=0;
      LstAnticipi.OnClick(self);
    end;
end;

procedure TA131FGestioneAnticipi.DEdtDataMovKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var i, Spazzi:Integer;
begin
  inherited;
  if (DButton.State = dsInsert) then
    DEdtData.Text:=DEdtDataMov.Text;
  Spazzi:=0;
  for i:=0 to Length(DEdtData.Text) do
    if Copy(DEdtData.Text,i,1) <> ' ' then
      inc(Spazzi);
  if (Length(DEdtData.Text) >= 10) and (Spazzi >= 10) then
    A131FGestioneAnticipiDtm.selM060.FieldByName('DATA_MISSIONE').AsDateTime
    :=StrToDate(DEdtData.Text);
end;

procedure TA131FGestioneAnticipi.DEdtNmovDblClick(Sender: TObject);
begin
  A131FGestioneAnticipiDtm.A131FGestioneAnticipiMW.CreaNumMovimento;
end;

procedure TA131FGestioneAnticipi.DCmbCodVoceKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit, dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
  if DButton.State in [dsEdit] then
    Abort;
end;

procedure TA131FGestioneAnticipi.DCmbMissioniKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit, dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA131FGestioneAnticipi.DRdGrpStatoClick(Sender: TObject);
begin
  inherited;
  if (A131FGestioneAnticipi.DButton.State in [dsInsert,dsEdit]) then
    A131FGestioneAnticipiDtm.selM060.FieldByName('DATA_IMPOSTAZIONE_STATO').AsDateTime:=Trunc(R180SysDate(A000SessioneIrisWIN.SessioneOracle));
end;

procedure TA131FGestioneAnticipi.Stampa1Click(Sender: TObject);
begin
  QueryStampa.Clear;
  QueryStampa.Add('SELECT T1.CASSA,T1.ANNO_MOVIMENTO,T1.NUM_MOVIMENTO,T1.COD_VOCE,');
  QueryStampa.Add('T1.DATA_MISSIONE,T1.DATA_MOVIMENTO,T1.QUANTITA,T1.IMPORTO,T1.FLAG_TOTALIZZATORE,');
  QueryStampa.Add('T1.STATO,T1.DATA_IMPOSTAZIONE_STATO,T1.NOTE');
  QueryStampa.Add('FROM M060_ANTICIPI T1');
  NomiCampiR001.Clear;
  NomiCampiR001.Add('T1.CASSA');
  NomiCampiR001.Add('T1.ANNO_MOVIMENTO');
  NomiCampiR001.Add('T1.NUM_MOVIMENTO');
  NomiCampiR001.Add('T1.COD_VOCE');
  NomiCampiR001.Add('T1.DATA_MISSIONE');
  NomiCampiR001.Add('T1.DATA_MOVIMENTO');
  NomiCampiR001.Add('T1.QUANTITA');
  NomiCampiR001.Add('T1.IMPORTO');
  NomiCampiR001.Add('T1.FLAG_TOTALIZZATORE');
  NomiCampiR001.Add('T1.STATO');
  NomiCampiR001.Add('T1.DATA_IMPOSTAZIONE_STATO');
  NomiCampiR001.Add('T1.NOTE');
  inherited;
end;

procedure TA131FGestioneAnticipi.PutAnticipi;
var i:integer;
    S:String;
begin
  S:='';
  for i:=0 to LstAnticipi.Items.Count - 1 do
  begin
    S:=S + Trim(Copy(LstAnticipi.Items[i],0,4));
    if i < LstAnticipi.Items.Count - 1 then
      S:=S + ',';
  end;
  R180PutCheckList(S,5,C013FCheckList.clbListaDati);
end;

procedure TA131FGestioneAnticipi.rgpFiltroClick(Sender: TObject);
begin
  inherited;
  try
    A131FGestioneAnticipiDtm.selM060.DisableControls;
    A131FGestioneAnticipiDtm.selM060.Filtered:=False;
    case rgpFiltro.ItemIndex of
      0: A131FGestioneAnticipiDtm.selM060.Filter:='';
      1: A131FGestioneAnticipiDtm.selM060.Filter:='FLAG_TOTALIZZATORE = ''N''';
      2: A131FGestioneAnticipiDtm.selM060.Filter:='STATO = ''S''';
      3: A131FGestioneAnticipiDtm.selM060.Filter:='STATO = ''P''';
      4: A131FGestioneAnticipiDtm.selM060.Filter:='STATO = ''L''';
      5: A131FGestioneAnticipiDtm.selM060.Filter:='STATO = ''R''';
    end;
    A131FGestioneAnticipiDtm.selM060.Filtered:=True;
  finally
    A131FGestioneAnticipiDtm.selM060.EnableControls;
  end;
  NumRecords;
end;

procedure TA131FGestioneAnticipi.GetAnticipi;
var S,Temp:String;
    i:Integer;
begin
  LstAnticipi.Items.Clear;
  S:=R180GetCheckList(5,C013FCheckList.clbListaDati);
  S:=S + ',';
  while (S <> '') do
  begin
    Temp:=copy(S,0,pos(',',S)-1);
    S:=Copy(S,pos(',',S)+1,Length(S));
    with A131FGestioneAnticipiDtm.A131FGestioneAnticipiMW do
    begin
      for i:=0 to High(AntArray) do
        if AntArray[i].AntId = Trim(Temp) then
          LstAnticipi.Items.Add(FormatDescAnticipo(i));
    end;
  end;
end;

procedure TA131FGestioneAnticipi.BtnElencoAnticipiClick(Sender: TObject);
var i:Integer;
begin
  C013FCheckList:=TC013FCheckList.Create(Self);
  with A131FGestioneAnticipiDtm.A131FGestioneAnticipiMW do
  try
    for i:=0 to High(AntArray) do
      C013FCheckList.clbListaDati.Items.Add(FormatDescAnticipoCompleto(i));
    PutAnticipi;

    if C013FCheckList.ShowModal = mrOK then
      GetAnticipi;
  finally
    C013FCheckList.Release;
  end;
  if LstAnticipi.Items.Count > 0 then
    LstAnticipi.ItemIndex:=0;
  LstAnticipi.OnClick(Self);
end;

procedure TA131FGestioneAnticipi.LstAnticipiClick(Sender: TObject);
var IndAnt:Integer;
begin
  inherited;
  ValDataMiss.Caption:='';
  ValCassa.Caption:='';
  ValAnnoMov.Caption:='';
  ValNumMov.Caption:='';
  ValCodVoce.Caption:='';
  IndAnt:=-1;
  with A131FGestioneAnticipiDtm.A131FGestioneAnticipiMW do
  begin
    if LstAnticipi.ItemIndex >= 0 then
      IndAnt:=GetIndexAntArray(Copy(LstAnticipi.Items[LstAnticipi.itemIndex],0,5));
    if (IndAnt < 0) or (IndAnt > 9999) then
      Exit;
    ValDataMiss.Caption:=DateToStr(AntArray[IndAnt].DataMis);
    ValCassa.Caption:=AntArray[IndAnt].Cassa;
    ValAnnoMov.Caption:=AntArray[IndAnt].Anno;
    ValNumMov.Caption:=IntToStr(AntArray[IndAnt].Numero);
    ValCodVoce.Caption:=AntArray[IndAnt].CodiceV;
  end;
end;

procedure TA131FGestioneAnticipi.NormalizzaTitolo(var Grid:TDBGrid);
var i, j:Integer;
    Titolo, Aus:String;
begin
  For i:=0 to (Grid.Columns.Count-1) do
  begin
    Titolo:=LowerCase(Grid.Columns[i].Title.Caption);
    Titolo:=StringReplace(Titolo,'_',' ',[rfReplaceAll]);
    for j:=0 to Length(Titolo) do
      if (copy(Titolo,j,1) = ' ') or (j = 0) then
      begin
        Aus:=copy(Titolo, 0, j) + UpperCase(copy(Titolo,j+1,1)) +
             copy(Titolo,j+2,length(Titolo));
        Titolo:='';
        Titolo:=Aus;
      end;
    Grid.Columns[i].Title.Caption:=Titolo;
  end;
end;

end.
