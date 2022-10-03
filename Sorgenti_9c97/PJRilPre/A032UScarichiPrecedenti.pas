unit A032UScarichiPrecedenti;

interface

uses
  // rimozione variabile globale R200FScaricoTimbratureDtM.ini
  // include spostata da sezione implementation
  R200UScaricoTimbratureDtM,
  // rimozione variabile globale R200FScaricoTimbratureDtM.ini
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, CheckLst, Buttons, DBCtrls, C180FunzioniGenerali,
  Mask, Menus, A000UInterfaccia, A003UDataLavoroBis, A032UScarico, OracleData,
  StrUtils, ComCtrls;

type
  TFile = record
    Nome:String;
    Data:TDateTime;
  end;

type
  TA032ScarichiPrecedenti = class(TForm)
    pnlTop: TPanel;
    lblParametrizzazione: TDBText;
    dlgPathTimb: TOpenDialog;
    lblPrametrizzazionelbl: TLabel;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullaselezione1: TMenuItem;
    Invertiselezione1: TMenuItem;
    pnlFiles: TPanel;
    Splitter1: TSplitter;
    pnlAzioni: TPanel;
    btnConferma: TBitBtn;
    btnChiudi: TBitBtn;
    mmMessaggi: TMemo;
    GroupBox1: TGroupBox;
    lstFiles: TCheckListBox;
    Panel1: TPanel;
    Label1: TLabel;
    lblDataA: TLabel;
    lblDataDa: TLabel;
    edtFiltroNome: TEdit;
    edtDataDa: TMaskEdit;
    btnselDataDa: TBitBtn;
    edtDataA: TMaskEdit;
    btnselDataA: TBitBtn;
    stdBar1: TStatusBar;
    prgBar1: TProgressBar;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edtFDataDa: TMaskEdit;
    BitBtn1: TBitBtn;
    edtFDataA: TMaskEdit;
    BitBtn2: TBitBtn;
    edtFOraDa: TMaskEdit;
    Label4: TLabel;
    edtFOraA: TMaskEdit;
    Label5: TLabel;
    btnRefresh: TBitBtn;
    edtPathTimb: TEdit;
    btnTimb: TButton;
    lblPercorsoFile: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnTimbClick(Sender: TObject);
    procedure btnEsciClick(Sender: TObject);
    procedure lstFilesMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edtFiltroNomeChange(Sender: TObject);
    procedure edtDataDaExit(Sender: TObject);
    procedure edtDataAExit(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Annullaselezione1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
    procedure btnselDataDaClick(Sender: TObject);
    procedure btnselDataAClick(Sender: TObject);
    procedure edtFOraDaExit(Sender: TObject);
    procedure edtFDataDaExit(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
  private
    VetFile:array of TFile;
    procedure QuickSort(iLo, iHi: Integer);
    procedure CaricaFile(var Lista:TCheckListBox;Path:String);
  public
  end;

var
  A032ScarichiPrecedenti: TA032ScarichiPrecedenti;

implementation

// rimozione variabile globale R200FScaricoTimbratureDtM.ini
// include spostata in sezione interface
//uses R200UScaricoTimbratureDtM;
// rimozione variabile globale R200FScaricoTimbratureDtM.fine

{$R *.dfm}

procedure TA032ScarichiPrecedenti.QuickSort(iLo, iHi: Integer);
var Lo, Hi: Integer;
    Mid:TDate;
    T:TFile;
begin
  Lo := iLo;
  Hi := iHi;
  Mid := VetFile[(Lo + Hi) div 2].Data;
  repeat
    while VetFile[Lo].Data > Mid do Inc(Lo);
    while VetFile[Hi].Data < Mid do Dec(Hi);
    if Lo <= Hi then
      begin
      T := VetFile[Lo];
      VetFile[Lo]:=VetFile[Hi];
      VetFile[Hi]:=T;
      Inc(Lo);
      Dec(Hi);
      end;
  until Lo > Hi;
  if Hi > iLo then QuickSort(iLo, Hi);
  if Lo < iHi then QuickSort(Lo, iHi);
end;

procedure TA032ScarichiPrecedenti.Selezionatutto1Click(Sender: TObject);
var i:integer;
begin
  for i:=0 to lstFiles.Count - 1 do
    lstFiles.Checked[i]:=True;
end;

procedure TA032ScarichiPrecedenti.CaricaFile(var Lista:TCheckListBox;Path:String);
var FFile:TSearchRec;
    i:integer;
begin
  Lista.Items.Clear;
  SetLength(VetFile,0);
  if (Path = '') or Not DirectoryExists(Path) then
    Exit;
  if FindFirst(Path + IfThen(edtFiltroNome.Text = '','*.*',edtFiltroNome.Text),faSysFile,FFile) <> 0 then
    Exit;
  repeat
    if (FFile.Name <> '.') and (FFile.Name <> '..') and
       (Trunc(FFile.TimeStamp) >= StrToDate(edtDataDa.Text)) and
       (Trunc(FFile.TimeStamp) <= StrToDate(edtDataA.Text)) then
    begin
      SetLength(VetFile,length(VetFile) + 1);
      VetFile[Length(VetFile)-1].Nome:=FFile.Name;
      VetFile[Length(VetFile)-1].Data:=FFile.TimeStamp;
    end;
  until FindNext(FFile) <> 0;
  if length(VetFile) > 0 then
    QuickSort(Low(VetFile),High(VetFile));
  for i:=Low(VetFile) to High(VetFile) do
    Lista.Items.Add(R180DimLung(VetFile[i].Nome,45) + DateTimeToStr(VetFile[i].Data));
end;

procedure TA032ScarichiPrecedenti.edtDataAExit(Sender: TObject);
begin
  try
    StrToDate(edtDataA.Text);
  Except Exit; end;
  CaricaFile(lstFiles,edtPathTimb.Text);
end;

procedure TA032ScarichiPrecedenti.edtDataDaExit(Sender: TObject);
begin
  try
    StrToDate(edtDataA.Text);
  Except Exit; end;
  CaricaFile(lstFiles,edtPathTimb.Text);
end;

procedure TA032ScarichiPrecedenti.edtFDataDaExit(Sender: TObject);
begin
  try
    StrToDate(TEdit(Sender).Text);
  Except Exit; end;
end;

procedure TA032ScarichiPrecedenti.edtFiltroNomeChange(Sender: TObject);
begin
  CaricaFile(lstFiles,edtPathTimb.Text);
end;

procedure TA032ScarichiPrecedenti.edtFOraDaExit(Sender: TObject);
begin
  if TEdit(Sender).Text <> '__.__' then
    R180OraValidate(TEdit(Sender).Text);
end;

procedure TA032ScarichiPrecedenti.Annullaselezione1Click(Sender: TObject);
var i:integer;
begin
  for i:=0 to lstFiles.Count - 1 do
    lstFiles.Checked[i]:=False;
end;

procedure TA032ScarichiPrecedenti.btnselDataAClick(Sender: TObject);
begin
  edtDataA.Text:=DateToStr(DataOut(StrToDate(edtDataA.Text),'Data A','U'));
  CaricaFile(lstFiles,edtPathTimb.Text);
end;

procedure TA032ScarichiPrecedenti.btnselDataDaClick(Sender: TObject);
begin;
  edtDataDa.Text:=DateToStr(DataOut(StrToDate(edtDataDa.Text),'Data Da','U'));
  CaricaFile(lstFiles,edtPathTimb.Text);  
end;

procedure TA032ScarichiPrecedenti.BitBtn1Click(Sender: TObject);
begin
  edtFDataDA.Text:=DateToStr(DataOut(StrToDate(edtFDataDA.Text),'Data Da','U'));
end;

procedure TA032ScarichiPrecedenti.BitBtn2Click(Sender: TObject);
begin
  edtFDataA.Text:=DateToStr(DataOut(StrToDate(edtFDataA.Text),'Data A','U'));
end;

procedure TA032ScarichiPrecedenti.btnChiudiClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TA032ScarichiPrecedenti.btnConfermaClick(Sender: TObject);
var i,ItemsChecked:Integer;
begin
  if R180MessageBox('Recuperare i files selezionati?',DOMANDA) = mrNo then
    Exit;
  // rimozione variabile globale R200FScaricoTimbratureDtM.ini
  {R200FScaricoTimbratureDtM}A032FScarico.R200DM.QI100.SearchRecord('SCARICO',A032FScarico.EScarico.KeyValue,[srFromBeginning]);
  // rimozione variabile globale R200FScaricoTimbratureDtM.fine
  Screen.Cursor:=crHourGlass;
  try
    // rimozione variabile globale R200FScaricoTimbratureDtM.ini
    {R200FScaricoTimbratureDtM}A032FScarico.R200DM.DataIRecupero:=StrToDate(edtFDataDa.Text) + (R180OreMinutiExt(edtFOraDa.Text) / 1440);
    {R200FScaricoTimbratureDtM}A032FScarico.R200DM.DataFRecupero:=StrToDate(edtFDataA.Text) + (R180OreMinutiExt(edtFOraA.Text) / 1440);
    // rimozione variabile globale R200FScaricoTimbratureDtM.fine
    mmMessaggi.Lines.Clear;
    ItemsChecked:=0;
    for i:=0 to lstFiles.Items.Count - 1 do
      if lstFiles.Checked[i] then
        inc(ItemsChecked);
    prgBar1.Max:=ItemsChecked;
    prgBar1.Min:=0;
    for i:=0 to lstFiles.Items.Count - 1 do
      if lstFiles.Checked[i] then
      begin
        // rimozione variabile globale R200FScaricoTimbratureDtM.ini
        {R200FScaricoTimbratureDtM}A032FScarico.R200DM.LMessaggi.Clear;
        {R200FScaricoTimbratureDtM}A032FScarico.R200DM.NFRecupero:=edtPathTimb.Text + '\' + VetFile[i].Nome;
        stdBar1.Panels[0].Text:='File attualmente in acquisizione: ' + VetFile[i].Nome;
        // rimozione variabile globale R200FScaricoTimbratureDtM.fine
        prgBar1.StepBy(1);
        Application.ProcessMessages;
        {R200FScaricoTimbratureDtM}A032FScarico.R200DM.Scarico(True,False); // rimozione variabile globale R200FScaricoTimbratureDtM
        // rimozione variabile globale R200FScaricoTimbratureDtM.ini
        with {R200FScaricoTimbratureDtM}A032FScarico.R200DM do
        begin
          RegistraMsg.LeggiMessaggi(RegistraMsg.ID);
          mmMessaggi.Lines.Add('<< Acquisizione file: ' + VetFile[i].Nome + ' >>');
          while Not RegistraMsg.selI005.Eof do
          begin
            mmMessaggi.Lines.Add(RegistraMsg.selI005.FieldByName('DATA_MSG').AsString + ' - ' + RegistraMsg.selI005.FieldByName('MSG').AsString);
            RegistraMsg.selI005.Next;
          end;
        end;
        // rimozione variabile globale R200FScaricoTimbratureDtM.fine
      end;
  finally
    Screen.Cursor:=crDefault;
    stdBar1.Panels[0].Text:='';
    {R200FScaricoTimbratureDtM}A032FScarico.R200DM.NFRecupero:=''; // rimozione variabile globale R200FScaricoTimbratureDtM
    prgBar1.Position:=0;
  end;
  ShowMessage('Scarico terminato');
  CaricaFile(lstFiles,edtPathTimb.Text);
end;

procedure TA032ScarichiPrecedenti.btnEsciClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TA032ScarichiPrecedenti.btnRefreshClick(Sender: TObject);
begin
  CaricaFile(lstFiles,edtPathTimb.Text);
end;

procedure TA032ScarichiPrecedenti.btnTimbClick(Sender: TObject);
begin
  dlgPathTimb.InitialDir:=edtPathTimb.Text;
  if dlgPathTimb.Execute then
  begin
    edtPathTimb.Text:=R180EstraiPercorsoFile(dlgPathTimb.FileName);
    CaricaFile(lstFiles,edtPathTimb.Text);
  end;
end;

procedure TA032ScarichiPrecedenti.FormShow(Sender: TObject);
begin
  edtDataDa.Text:=DateToStr(Date);
  edtDataA.Text:=DateToStr(Date);
  edtFDataDa.Text:=DateToStr(Date);
  edtFDataA.Text:=DateToStr(Date);
  edtFOraDa.Text:='00.00';
  edtFOraA.Text:='23.59';
  // rimozione variabile globale R200FScaricoTimbratureDtM.ini
  with {R200FScaricoTimbratureDtM}A032FScarico.R200DM do
    edtPathTimb.Text:=R180EstraiPercorsoFile(QI100.FieldByName('NOMEFILE').AsString);
  // rimozione variabile globale R200FScaricoTimbratureDtM.fine
  lstFiles.MultiSelect:=True;
  CaricaFile(lstFiles,edtPathTimb.Text);
end;

procedure TA032ScarichiPrecedenti.Invertiselezione1Click(Sender: TObject);
var i:integer;
begin
  for i:=0 to lstFiles.Count - 1 do
    lstFiles.Checked[i]:=Not lstFiles.Checked[i];
end;

procedure TA032ScarichiPrecedenti.lstFilesMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i:integer;
begin
  if LstFiles.SelCount > 1 then
    for i:=0 to LstFiles.Items.Count - 1 do
      if LstFiles.Selected[i] then
        LstFiles.Checked[i]:=Not LstFiles.Checked[i];
end;

end.
