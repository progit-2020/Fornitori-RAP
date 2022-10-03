unit A126UBloccoRiepiloghi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls,C180FunzioniGenerali, A000USessione,A000UInterfaccia,
  ExtCtrls,DB,checklst, ComCtrls, C700USelezioneAnagrafe,
  C004UParamForm, A003UDataLavoroBis, QueryStorico, SelAnagrafe, RegistrazioneLog,
  Menus, C005UDatiAnagrafici, Variants, ActnList, Grids, DBGrids, ImgList,
  ToolWin,A000UMessaggi, System.Actions, System.ImageList;

type
  TA126FBloccoRiepiloghi = class(TForm)
    PrinterSetupDialog1: TPrinterSetupDialog;
    StatusBar: TStatusBar;
    frmSelAnagrafe: TfrmSelAnagrafe;
    PageControl1: TPageControl;
    tabDataCassa: TTabSheet;
    Label1: TLabel;
    Label4: TLabel;
    ActionList1: TActionList;
    actCassaSuccessiva: TAction;
    actCassaPrecedente: TAction;
    actCassaElimina: TAction;
    actCassaAnnulla: TAction;
    tabBloccoRiepiloghi: TTabSheet;
    edtCassaEffettiva: TEdit;
    edtCassaUtilizzata: TEdit;
    actCassaRefresh: TAction;
    Label2: TLabel;
    edtCassaRecords: TEdit;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    SpeedButton4: TSpeedButton;
    Label5: TLabel;
    edtDaData: TEdit;
    edtAData: TEdit;
    chklstRiepiloghi: TCheckListBox;
    ProgressBar1: TProgressBar;
    Panel1: TPanel;
    BtnClose: TBitBtn;
    tabBrowse: TTabSheet;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    chkDipendentiSelezionati: TCheckBox;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ImageList1: TImageList;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    btnBloccoRiepiloghi: TBitBtn;
    btnSbloccoRiepiloghi: TBitBtn;
    DataSource1: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure actCassaRefreshExecute(Sender: TObject);
    procedure actCassaAnnullaExecute(Sender: TObject);
    procedure actCassaSuccessivaExecute(Sender: TObject);
    procedure actCassaPrecedenteExecute(Sender: TObject);
    procedure actCassaEliminaExecute(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure btnBloccoRiepiloghiClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure chkDipendentiSelezionatiClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure FiltraBlocchi;
    function GetRiepiloghiSelezionati:String;
    procedure GetUltimaDataCassa;
  public
    { Public declarations }
    DaData,AData,CassaEffettiva,CassaUtilizzata,DataDa,DataA:TDateTime;
    CampoRagg,NomeCampo,Chiamante:String;
  end;

var
  A126FBloccoRiepiloghi: TA126FBloccoRiepiloghi;

procedure OpenA126BloccoRiepiloghi(Prog:LongInt;pChiamante:String;pDataDa,pDataA:TDateTime);

implementation

uses A126UBloccoRiepiloghiDtM1;

{$R *.DFM}

procedure OpenA126BloccoRiepiloghi(Prog:LongInt;pChiamante:String;pDataDa,pDataA:TDateTime);
// Procedura pubblica di open
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA126BloccoRiepiloghi') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A126FBloccoRiepiloghi:=TA126FBloccoRiepiloghi.Create(nil);
  with A126FBloccoRiepiloghi do
    try
      C700Progressivo:=Prog;
      Chiamante:=pChiamante;
      DataDa:=pDataDa;
      DataA:=pDataA;
      A126FBloccoRiepiloghiDtM1:=TA126FBloccoRiepiloghiDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A126FBloccoRiepiloghiDtM1.Free;
      Free;
    end;
end;

procedure TA126FBloccoRiepiloghi.FiltraBlocchi;
var
  RipristinoSL:Boolean;
  LstRiep: TStringList;
  i: Integer;
begin
  RipristinoSL:=SolaLettura;
  LstRiep:=A126FBloccoRiepiloghiDtM1.A126FBloccoRiepiloghiMW.getLstRiepiloghi;
  SolaLettura:=RipristinoSL;
  for i:=0 to LstRiep.Count - 1 do
    chklstRiepiloghi.Items.Add(LstRiep[i]);

  FreeAndNil(LstRiep);
end;

procedure TA126FBloccoRiepiloghi.FormCreate(Sender: TObject);
begin
  DaData:=R180InizioMese(Date);
  AData:=R180InizioMese(Date);
  edtDaData.Text:=FormatDateTime('mmmm yyyy',DaData);
  edtAData.Text:=FormatDateTime('mmmm yyyy',AData);
end;

procedure TA126FBloccoRiepiloghi.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'A126',Parametri.ProgOper);
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A126FBloccoRiepiloghiDtm1.A126FBloccoRiepiloghiMW,SessioneOracle,StatusBar,0,False);
  frmSelAnagrafe.SelezionePeriodica:=True;
  //Massimo: assegnazione già fatta nel CreaSelAnagrafe
  //A126FBloccoRiepiloghiDtm1.A126FBloccoRiepiloghiMW.SelAnagrafe:=C700SelAnagrafe;
  GetUltimaDataCassa;
  FiltraBlocchi;
  GetParametriFunzione;
  chkDipendentiSelezionati.Checked:=True;
  A126FBloccoRiepiloghiDtM1.selT180.Filtered:=True;
  if (Chiamante <> '') or (A000GetInibizioni('Funzione','OpenA037ScaricoPaghe') <> 'S') then
  begin
    tabDataCassa.TabVisible:=False;
    PageControl1.ActivePage:=tabBloccoRiepiloghi;
    if (Chiamante <> '') then
      frmSelAnagrafe.btnEreditaSelezioneClick(nil);
  end
  else
    PageControl1.ActivePage:=tabDataCassa  //LORENA 22/07/2004
end;

procedure TA126FBloccoRiepiloghi.GetParametriFunzione;
{Leggo i parametri della form}
var i:Integer;
    S:String;
begin
  if DataDa <> 0 then //richiamo esterno
    DaData:=DataDa
  else
    DaData:=StrToDate(C004FParamForm.GetParametro('DADATA',DateToStr(DaData)));
  if DataA <> 0 then //richiamo esterno
    AData:=DataA
  else
    AData:=StrToDate(C004FParamForm.GetParametro('ADATA',DateToStr(AData)));
  edtDaData.Text:=FormatDateTime('mmmm yyyy',DaData);
  edtAData.Text:=FormatDateTime('mmmm yyyy',AData);
  S:='''' + StringReplace(C004FParamForm.GetParametro('RIEPILOGHI',''),',',''',''',[rfReplaceAll]) + '''';
  for i:=0 to chklstRiepiloghi.Items.Count - 1 do
    chklstRiepiloghi.Checked[i]:=Pos('''' + Trim(Copy(chklstRiepiloghi.Items[i],1,6)) + '''',S) > 0;
end;

procedure TA126FBloccoRiepiloghi.PutParametriFunzione;
{Scrivo i parametri della form}
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('DADATA',DateToStr(DaData));
  C004FParamForm.PutParametro('ADATA',DateToStr(AData));
  C004FParamForm.PutParametro('RIEPILOGHI',StringReplace(GetRiepiloghiSelezionati,'''','',[rfReplaceAll]));
  try SessioneOracle.Commit; except end;
end;

procedure TA126FBloccoRiepiloghi.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  C005DataVisualizzazione:=AData;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA126FBloccoRiepiloghi.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700SelAnagrafe.OnFilterRecord:=nil;
  C700DataDal:=DaData;
  C700DataLavoro:=R180FineMese(AData);
  frmSelAnagrafe.btnSelezioneClick(Sender);
  PageControl1Change(nil);
end;

procedure TA126FBloccoRiepiloghi.actCassaRefreshExecute(Sender: TObject);
begin
  GetUltimaDataCassa;
end;

procedure TA126FBloccoRiepiloghi.actCassaAnnullaExecute(Sender: TObject);
begin
  if A126FBloccoRiepiloghiDtM1.A126FBloccoRiepiloghiMW.DataCassaPresente then
    if R180MessageBox(A000MSG_A126_DLG_ANNULLA_CASSA,DOMANDA) = mrYes then
    begin
      A126FBloccoRiepiloghiDtM1.A126FBloccoRiepiloghiMW.AnnullaDataCassa;
      GetUltimaDataCassa;
    end;
end;

procedure TA126FBloccoRiepiloghi.actCassaSuccessivaExecute(Sender: TObject);
begin
  if R180MessageBox(A000MSG_A126_DLG_CASSA_SUCCESSIVA,DOMANDA) = mrYES then
  begin
    A126FBloccoRiepiloghiDtM1.A126FBloccoRiepiloghiMW.DataCassaSuccessiva(CassaEffettiva);
    GetUltimaDataCassa;
  end;
end;

procedure TA126FBloccoRiepiloghi.actCassaPrecedenteExecute(Sender: TObject);
begin
  GetUltimaDataCassa;
  if CassaEffettiva >= CassaUtilizzata then
    raise Exception.Create(A000MSG_A126_ERR_DATA_CASSA_ANTE);
  if R180MessageBox(A000MSG_A126_DLG_CASSA_PRECEDENTE,DOMANDA) = mrYES then
  begin
    A126FBloccoRiepiloghiDtM1.A126FBloccoRiepiloghiMW.DataCassaPrecedente;
    GetUltimaDataCassa;
  end;
end;

procedure TA126FBloccoRiepiloghi.actCassaEliminaExecute(Sender: TObject);
begin
  with A126FBloccoRiepiloghiDtM1.A126FBloccoRiepiloghiMW do
  begin
    if R180MessageBox(MessaggioEliminaDataCassa,DOMANDA) = mrYES then
    begin
      A126FBloccoRiepiloghiDtM1.A126FBloccoRiepiloghiMW.EliminaDataCassa;
      GetUltimaDataCassa;
    end;
  end;
end;

procedure TA126FBloccoRiepiloghi.SpeedButton1Click(Sender: TObject);
begin
  if edtDaData.Text = '' then
    DaData:=R180InizioMese(DataOut(Date,'Data','M'))
  else
    DaData:=R180InizioMese(DataOut(DaData,'Data','M'));
  edtDaData.Text:=FormatDateTime('mmmm yyyy',DaData);
end;

procedure TA126FBloccoRiepiloghi.SpeedButton4Click(Sender: TObject);
begin
  if edtAData.Text = '' then
    AData:=R180InizioMese(DataOut(Date,'Data','M'))
  else
    AData:=R180InizioMese(DataOut(AData,'Data','M'));
  edtAData.Text:=FormatDateTime('mmmm yyyy',AData);
end;

procedure TA126FBloccoRiepiloghi.btnBloccoRiepiloghiClick(Sender: TObject);
{Blocco/Sblocco riepiloghi spcecificati}
var i:Integer;
    Num:Real;
    SNum:String;
begin
  if DaData > AData then
    raise Exception.Create(A000MSG_ERR_PERIODO_ERRATO);
  if C700SelAnagrafe.RecordCount = 0 then
    raise Exception.Create(A000MSG_ERR_NO_DIP);
  if GetRiepiloghiSelezionati = '''*''' then
    raise Exception.Create(A000MSG_A126_ERR_NO_RIEPILOGO);
  //Calcolo del numero di records da elaborare
  Num:=0;
  for i:=0 to chklstRiepiloghi.Count - 1 do
    if chklstRiepiloghi.Checked[i] then
      Num:=Num + 1;
  if C700SelAnagrafe.GetVariable('DATALAVORO') <> R180FineMese(AData) then
  begin
    C700SelAnagrafe.SetVariable('DATALAVORO',R180FineMese(AData));
    C700SelAnagrafe.Close;
  end;
  if C700SelAnagrafe.VariableIndex('C700DATADAL') >= 0 then
    if C700SelAnagrafe.GetVariable('C700DATADAL') <> R180InizioMese(DaData) then
    begin
      C700SelAnagrafe.SetVariable('C700DATADAL',R180InizioMese(DaData));
      C700SelAnagrafe.Close;
    end;
  C700SelAnagrafe.Open;

  A126FBloccoRiepiloghiDtM1.A126FBloccoRiepiloghiMW.DaData:=DaData;
  A126FBloccoRiepiloghiDtM1.A126FBloccoRiepiloghiMW.AData:=AData;
  C700SelAnagrafe.OnFilterRecord:=A126FBloccoRiepiloghiDtM1.A126FBloccoRiepiloghiMW.SelAnagrafeFilterRecord;
  C700SelAnagrafe.Filtered:=True;
  Num:=Num * C700SelAnagrafe.RecordCount;
  SNum:=Format('%n',[Num]);
  SNum:=Copy(SNum,1,Pos({$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator,SNum) - 1);
  C700SelAnagrafe.OnFilterRecord:=nil;
  if Sender = btnBloccoRiepiloghi then
  begin
    if R180MessageBox(Format(A000MSG_A126_DLG_FMT_BLOCCO,[SNum]),DOMANDA) <> mrYes then exit
  end
  else
    if R180MessageBox(Format(A000MSG_A126_DLG_FMT_SBLOCCO,[SNum]),DOMANDA) <> mrYes then exit;
  C700SelAnagrafe.OnFilterRecord:=A126FBloccoRiepiloghiDtM1.A126FBloccoRiepiloghiMW.SelAnagrafeFilterRecord;
  ProgressBar1.Position:=0;
  ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
  C700SelAnagrafe.First;
  frmSelAnagrafe.ElaborazioneInterrompibile:=True;
  Self.Enabled:=False;
  try
    while not C700SelAnagrafe.Eof do
    begin
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar1.Position:=ProgressBar1.Position + 1;
      for i:=0 to chklstRiepiloghi.Count - 1 do
      begin
        if chklstRiepiloghi.Checked[i] then
        begin
          A126FBloccoRiepiloghiDtM1.A126FBloccoRiepiloghiMW.BloccoRiepiloghi(C700Progressivo,Sender = btnBloccoRiepiloghi,chklstRiepiloghi.Items[i]);
          A126FBloccoRiepiloghiDtM1.A126FBloccoRiepiloghiMW.ScriviLog(Sender = btnBloccoRiepiloghi,GetRiepiloghiSelezionati,C700Progressivo);
        end;
      end;
      C700SelAnagrafe.Next;
    end;
  finally
    SessioneOracle.Commit;
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    Self.Enabled:=True;
    frmSelAnagrafe.VisualizzaDipendente;
    C700SelAnagrafe.OnFilterRecord:=nil;
    C700SelAnagrafe.Filtered:=False;
  end;

  if A126FBloccoRiepiloghiDtM1.selT180.Active then
    A126FBloccoRiepiloghiDtM1.selT180.Refresh;
  ProgressBar1.Position:=0;
end;

function TA126FBloccoRiepiloghi.GetRiepiloghiSelezionati:String;
var i:Integer;
begin
  Result:='';
  for i:=0 to chklstRiepiloghi.Items.Count - 1 do
    if chklstRiepiloghi.Checked[i] then
    begin
      if Result <> '' then
        Result:=Result + ',';
      Result:=Result + '''' + Trim(Copy(chklstRiepiloghi.Items[i],1,6)) + '''';
    end;
  if Result = '' then
    Result:='''*''';
end;

procedure TA126FBloccoRiepiloghi.PageControl1Change(Sender: TObject);
{Attivazione della pagina di browse: apertura di selT180}
var S:String;
begin
  if PageControl1.ActivePage = tabBrowse then
    with A126FBloccoRiepiloghiDtM1.selT180 do
    begin
      S:=GetRiepiloghiSelezionati;
      if VarToStr(GetVariable('RIEPILOGO')) <> S then
        Close;
      if GetVariable('DATA1') <> DaData then
        Close;
      if GetVariable('DATA2') <> AData then
        Close;
      if VarToStr(GetVariable('ORDERBY')) = '' then
        SetVariable('ORDERBY','DADATA DESC, MATRICOLA');
      SetVariable('RIEPILOGO',S);
      SetVariable('DATA1',DaData);
      SetVariable('DATA2',AData);
      A126FBloccoRiepiloghiDtM1.selT180.Filtered:=chkDipendentiSelezionati.Checked;
      Open;
    end;
end;

procedure TA126FBloccoRiepiloghi.Deselezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to chklstRiepiloghi.Items.Count - 1 do
    chklstRiepiloghi.Checked[i]:=Sender = Selezionatutto1;
end;

procedure TA126FBloccoRiepiloghi.DBGrid1TitleClick(Column: TColumn);
{Ordiamento cliccando sulla colonna della griglia}
var S:String;
begin
  S:=Column.Field.FieldName;
  if (Column.Field.FieldKind <> fkData) or (S = '') then
    exit;
  with A126FBloccoRiepiloghiDtM1.selT180 do
  begin
    DisableControls;
    Close;
    if VarToStr(GetVariable('ORDERBY')) = S then
      SetVariable('ORDERBY',S + ' DESC')
    else
      SetVariable('ORDERBY',S);
    Open;
    EnableControls;
  end;
end;

procedure TA126FBloccoRiepiloghi.chkDipendentiSelezionatiClick(Sender: TObject);
{Attivazione filtro sui dipendenti selezionati}
begin
  A126FBloccoRiepiloghiDtM1.selT180.Filtered:=chkDipendentiSelezionati.Checked;
end;

procedure TA126FBloccoRiepiloghi.GetUltimaDataCassa;
var
  Records: Integer;
  Util: Boolean;
begin
  with A126FBloccoRiepiloghiDtM1.A126FBloccoRiepiloghiMW do
  begin
    GetCassaEffettiva(CassaEffettiva,Records);
    if Records = 0 then
    begin
      edtCassaEffettiva.Text:='';
      edtCassaRecords.Text:='';
    end
    else
    begin
      edtCassaEffettiva.Text:=FormatDateTime('mmmm yyyy',CassaEffettiva);
      edtCassaRecords.Text:=IntToStr(Records);
    end;

    GetCassaUtilizzata(CassaUtilizzata,Util,CassaEffettiva);
    if Util then
      edtCassaUtilizzata.Text:=FormatDateTime('mmmm yyyy',CassaUtilizzata)
    else
      edtCassaUtilizzata.Text:='';
  end;
end;

procedure TA126FBloccoRiepiloghi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA126FBloccoRiepiloghi.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

end.
