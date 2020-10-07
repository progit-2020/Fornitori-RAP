unit A130UOraLegaleSolare;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SelAnagrafe, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  Menus, C180FunzioniGenerali, Mask, Oracle, OracleData, Checklst, Db, DBCtrls,
  C700USelezioneAnagrafe,A003UDataLavoroBis,A000UInterfaccia,C013UCheckList,
  A000UCostanti, A000USessione, A000UMessaggi;

type
  TA130FOraLegaleSolare = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    btnChiudi: TBitBtn;
    btnSalva: TBitBtn;
    PopupMenu1: TPopupMenu;
    Copia1: TMenuItem;
    Copiainexcel1: TMenuItem;
    svdSalva: TSaveDialog;
    btnVisualizza: TButton;
    btnModifica: TBitBtn;
    Panel3: TPanel;
    rgpLegsol: TRadioGroup;
    edtDatada: TMaskEdit;
    SpeedButton1: TSpeedButton;
    edtDataa: TMaskEdit;
    SpeedButton2: TSpeedButton;
    edtOrada: TMaskEdit;
    edtOraa: TMaskEdit;
    edtOrologi: TEdit;
    SpeedButton3: TSpeedButton;
    Orologi: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    N1: TMenuItem;
    frmSelAnagrafe: TfrmSelAnagrafe;
    Panel2: TPanel;
    dgrdQuery: TDBGrid;
    ProgressBar1: TProgressBar;
    rgrpPresMens: TRadioGroup;
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure edtDatadaChange(Sender: TObject);
    procedure btnSalvaClick(Sender: TObject);
    procedure btnModificaClick(Sender: TObject);
    procedure btnVisualizzaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure edtOraaKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure edtOradaKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Copiainexcel1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure rgrpPresMensClick(Sender: TObject);
  private
    C013FCheckList: TC013FCheckList;
    function LunghezzaCampo(F:TField):Integer;
    procedure Visualizza(dtsTimb:TOracleDataSet);
    procedure Modifica(dtsTimb:TOracleDataSet);
    procedure CaricaOrologi;
    procedure SettaVariabiliMW;
    procedure IncrementaProgresBar(incremento: Integer);
  public
    { Public declarations }
  end;

var
  A130FOraLegaleSolare: TA130FOraLegaleSolare;

procedure OpenA130OraLegaleSolare(Prog:LongInt);

implementation

uses A130UOraLegaleSolareDtM;

{$R *.dfm}

procedure OpenA130OraLegaleSolare(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA130OraLegaleSolare') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A130FOraLegaleSolare:=TA130FOraLegaleSolare.Create(nil);
  with A130FOraLegaleSolare do
  try
    C700Progressivo:=Prog;
    A130FOraLegaleSolareDtM:=TA130FOraLegaleSolareDtM.Create(nil);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A130FOraLegaleSolareDtM.Free;
    Free;
  end;
end;

procedure TA130FOraLegaleSolare.CaricaOrologi;
var orologio: String;
begin
  with A130FOraLegaleSolareDtM.A130MW do
  begin
   if rgrpPresMens.ItemIndex = 0 then
      selT361.SetVariable('TOROLOGIO','P')
    else
      selT361.SetVariable('TOROLOGIO','M');
    A130FOraLegaleSolareDtM.A130MW.selT361.Open;
    if C013FCheckList = nil then
      C013FCheckList:=TC013FCheckList.Create(nil);
    try
      while not A130FOraLegaleSolareDtM.A130MW.selT361.Eof do
      begin
        orologio:=A130FOraLegaleSolareDtM.A130MW.selT361.FieldByName('CODICE').AsString+' '+A130FOraLegaleSolareDtM.A130MW.selT361.FieldByName('DESCRIZIONE').AsString;
        C013FCheckList.clbListaDati.Items.Add(orologio);
        A130FOraLegaleSolareDtM.A130MW.selT361.Next;
      end;
    except
      FreeAndNil(C013FCheckList);
    end;
    selT361.Close;
  end;
end;

procedure TA130FOraLegaleSolare.FormShow(Sender: TObject);
begin
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  CaricaOrologi;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar1,0,False);
  frmSelAnagrafe.NumRecords;
  dgrdQuery.DataSource:=A130FOraLegaleSolareDtM.A130MW.dscSelT100;
  with A130FOraLegaleSolareDtM.A130MW do
    dscSelT100.DataSet:=selT100;
  edtDatada.Text:=DateToStr(Parametri.DataLavoro);
  edtDataa.Text:=DateToStr(Parametri.DataLavoro);
  visualizza(A130FOraLegaleSolareDtM.A130MW.selT100);
  edtDatada.SetFocus;
  A130FOraLegaleSolareDtM.A130MW.IncrementEvent:=IncrementaProgresBar;
end;

procedure TA130FOraLegaleSolare.Selezionatutto1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdQuery,'S');
end;

procedure TA130FOraLegaleSolare.Deselezionatutto1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdQuery,'N');
end;

procedure TA130FOraLegaleSolare.Invertiselezione1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdQuery,'C');
end;

procedure TA130FOraLegaleSolare.Copiainexcel1Click(Sender: TObject);
begin
  R180DBGridCopyToClipboard(dgrdQuery,Sender = Copiainexcel1);
end;

procedure TA130FOraLegaleSolare.SpeedButton1Click(Sender: TObject);
var D:TDateTime;
begin
  try
    D:=StrToDate(edtDatada.Text);
  except
    D:=Parametri.DataLavoro;
  end;
  edtDatada.Text:=FormatDateTime('dd/mm/yyyy',DataOut(D,'Descrizione','G'));
end;

procedure TA130FOraLegaleSolare.SpeedButton2Click(Sender: TObject);
var D:TDateTime;
begin
  try
    D:=StrToDate(edtDataa.Text);
  except
    D:=Parametri.DataLavoro;
  end;
  edtDataa.Text:=FormatDateTime('dd/mm/yyyy',DataOut(D,'Descrizione','G'));
end;

procedure TA130FOraLegaleSolare.edtOradaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    R180OraValidate(edtOrada.Text);
end;

procedure TA130FOraLegaleSolare.edtOraaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    R180OraValidate(edtOraa.Text);
end;


procedure TA130FOraLegaleSolare.SpeedButton3Click(Sender: TObject);
var L:Integer;
begin
  with C013FCheckList do
  begin
    L:=2;
    if C013FCheckList.ShowModal = mrOk then
      edtOrologi.Text:=R180GetCheckList(L,clbListaDati);
  end;
end;

procedure TA130FOraLegaleSolare.FormDestroy(Sender: TObject);
begin
  try
    FreeAndNil(C013FCheckList);
  except
  end;
end;

procedure TA130FOraLegaleSolare.btnVisualizzaClick(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  try
    if rgrpPresMens.ItemIndex = 0 then
      visualizza(A130FOraLegaleSolareDtM.A130MW.selT100)
    else
      visualizza(A130FOraLegaleSolareDtM.A130MW.selT370);
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA130FOraLegaleSolare.Visualizza(dtsTimb:TOracleDataSet);
begin
  if (edtDatada.Text <> '  /  /    ') and (edtDataa.Text <> '  /  /    ') and (edtOrada.Text <> '  .  ') and (edtOraa.Text <> '  .  ') then
  begin
    SettaVariabiliMW;
    A130FOraLegaleSolareDtM.A130MW.dtsTimb:=dtsTimb;
    A130FOraLegaleSolareDtM.A130MW.dtsTimb.ClearVariables;
    C700MergeSelAnagrafe(A130FOraLegaleSolareDtM.A130MW.dtsTimb,False);
    C700MergeSettaPeriodo(A130FOraLegaleSolareDtM.A130MW.dtsTimb,StrToDate(edtDatada.Text),StrToDate(edtDataa.Text));
    A130FOraLegaleSolareDtM.A130MW.SelezionaTimbrature;
    StatusBar1.Panels[1].Text:='Totale timbrature estratte: '+IntToStr(A130FOraLegaleSolareDtM.A130MW.dtsTimb.RecordCount);
    if A130FOraLegaleSolareDtM.A130MW.dtsTimb.RecordCount > 0 then
    begin
      btnModifica.Enabled:=True and (not SolaLettura);
      btnSalva.Enabled:=True;
    end;
    A130FOraLegaleSolareDtM.A130MW.dscSelT100.DataSet:=A130FOraLegaleSolareDtM.A130MW.dtsTimb;
  end;
end;

procedure TA130FOraLegaleSolare.Modifica(dtsTimb:TOracleDataSet);
begin
//applica le modifiche dell'anteprima
  if R180MessageBox(Format(A000MSG_A130_DLG_FMT_APPLICA_MODIFICHE,[edtDatada.Text,edtDataa.Text,edtOrada.Text,edtOraa.Text]), 'DOMANDA') = mrYes then
  begin
    Screen.Cursor:=crHourGlass;
    try
      ProgressBar1.Max:=dtsTimb.RecordCount;
      ProgressBar1.Position:=0;
      SettaVariabiliMW;
      A130FOraLegaleSolareDtM.A130MW.dtsTimb:=dtsTimb;
      A130FOraLegaleSolareDtM.A130MW.ModificaOra;
    finally
      Screen.Cursor:=crDefault;
    end;
    R180MessageBox(A000MSG_MSG_MODIFICA_COMPLETATA,'INFORMA');
    btnModifica.Enabled:=False;
    ProgressBar1.Position:=0;
  end;
end;

procedure TA130FOraLegaleSolare.SettaVariabiliMW;
begin
  with A130FOraLegaleSolareDtM.A130MW do
  begin
    DataDa:=StrToDate(edtDatada.Text);
    DataA:=StrToDate(edtDataa.Text);
    OraDa:=edtOrada.Text;
    OraA:=edtOraa.Text;
    OrologiTimbratura:=edtOrologi.Text;
    IndiceTimbratura:=rgrpPresMens.ItemIndex;
    IndiceOra:=rgpLegSol.ItemIndex;
  end;
end;

procedure TA130FOraLegaleSolare.rgrpPresMensClick(Sender: TObject);
var StrTemp:String;
begin
  with C013FCheckList do
  begin
    StrTemp:=R180GetCheckList(2,clbListaDati);
    clbListaDati.Items.Clear;
    CaricaOrologi;
    R180PutCheckList(StrTemp,2,clbListaDati);
    edtOrologi.Text:=R180GetCheckList(2,clbListaDati);
  end;
  btnVisualizzaClick(Self);
end;

procedure TA130FOraLegaleSolare.btnModificaClick(Sender: TObject);
begin
  if rgrpPresMens.ItemIndex = 0 then
    Modifica(A130FOraLegaleSolareDtM.A130MW.selT100)
  else
    Modifica(A130FOraLegaleSolareDtM.A130MW.selT370);
end;

procedure TA130FOraLegaleSolare.btnSalvaClick(Sender: TObject);
var F:TextFile;
    TestoFile:String;
    Intestazione:Boolean;
begin
  Intestazione:=False;
  if R180MessageBox(A000MSG_A130_DLG_SALVA_INTESTAZIONE,'DOMANDA') = mrYes then
    Intestazione:=True;
  if not svdSalva.Execute then exit;
  AssignFile(F,svdSalva.FileName);
  Rewrite(F);
  TestoFile:=A130FOraLegaleSolareDtM.A130MW.CreaTestoFile(Intestazione);
  writeln(F,TestoFile);
  CloseFile(F);
end;

function TA130FOraLegaleSolare.LunghezzaCampo(F:TField):Integer;
begin
  if F is TStringField then
    Result:=F.Size
  else
    Result:=F.DisplayWidth;
  if F.Index < F.DataSet.FieldCount then
    inc(Result);
end;

procedure TA130FOraLegaleSolare.edtDatadaChange(Sender: TObject);
begin
  btnSalva.Enabled:=False;
  btnModifica.Enabled:=False;
  ProgressBar1.Position:=0;
end;

procedure TA130FOraLegaleSolare.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  frmSelAnagrafe.btnSelezioneClick(Sender);
  edtDatadaChange(nil);
end;

procedure TA130FOraLegaleSolare.IncrementaProgresBar(incremento:Integer);
begin
  ProgressBar1.StepBy(incremento);
end;


end.
