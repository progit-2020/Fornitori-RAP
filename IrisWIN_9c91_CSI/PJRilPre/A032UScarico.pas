unit A032UScarico;

interface

uses
  // rimozione variabile globale R200FScaricoTimbratureDtM.ini
  // include spostata da sezione da sezione implementation
  R200UScaricoTimbratureDtM,
  // rimozione variabile globale R200FScaricoTimbratureDtM.fine
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, StdCtrls, Menus, Buttons, OracleData, A031UParScarico,
  A000UCostanti, A000USessione,A000UInterfaccia, C004UParamForm, Variants;

type
  TA032FScarico = class(TForm)
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    EScarico: TDBLookupComboBox;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    lblAzienda: TLabel;
    lblBadgeChiave: TLabel;
    lblBadge: TLabel;
    Label4: TLabel;
    lblRiga: TLabel;
    chkScarichiAuto: TCheckBox;
    Label5: TLabel;
    lblScarico: TLabel;
    memoMessaggi: TMemo;
    btnScarichiOld: TBitBtn;
    procedure EScaricoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure chkScarichiAutoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnScarichiOldClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
  public
    // rimozione variabile globale R200FScaricoTimbratureDtM.ini
    R200DM: TR200FScaricoTimbratureDtM;
    // rimozione variabile globale R200FScaricoTimbratureDtM.fine
  end;

var
  A032FScarico: TA032FScarico;
  NFCorrente,NFAppoggio,NFScartate,NFCopia:String;
  TFCorrente,TFAppoggio,TFScartate:TextFile;

procedure OpenA032Scarico;

implementation

uses // rimozione variabile globale R200FScaricoTimbratureDtM.ini
     // spostata in sezione interface
     //R200UScaricoTimbratureDtM,
     // rimozione variabile globale R200FScaricoTimbratureDtM.fine
     A032UScarichiPrecedenti;

{$R *.DFM}

procedure OpenA032Scarico;
{Scarico timbrature dai rilevatori}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA032Scarico') of
    'N','R':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
  end;
  A032FScarico:=TA032FScarico.Create(nil);
  with A032FScarico do
  try
    // rimozione variabile globale R200FScaricoTimbratureDtM.ini
    // datamodule creato nell'evento oncreate della form
    //R200FScaricoTimbratureDtM:=TR200FScaricoTimbratureDtM.Create(nil);
    {R200FScaricoTimbratureDtM}R200DM.SessioneOracleB006:=SessioneOracle;
    {R200FScaricoTimbratureDtM}R200DM.ConnettiDataBase(SessioneOracle.LogonDatabase);
    // rimozione variabile globale R200FScaricoTimbratureDtM.fine
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    // datamodule distrutto nell'evento ondestroy della form
    //R200FScaricoTimbratureDtM.Free;
    Release;
  end;
end;

procedure TA032FScarico.FormActivate(Sender: TObject);
{Mi posiziono sullo scarico di Default}
var SQL:String;
begin
  // rimozione variabile globale R200FScaricoTimbratureDtM.ini
  with {R200FScaricoTimbratureDtM}R200DM do
  begin
    if Parametri.Azienda <> 'AZIN' then
    begin
      if QI100.Active then
        QI100.Close;
      SQL:='WHERE (INSTR('','' || I100.AZIENDE || '','','',' + Parametri.Azienda + ','') > 0 ';
      SQL:=SQL + 'OR I100.AZIENDE IS NULL)';
      QI100.SetVariable('WHERE',SQL);
      QI100.Open;
    end;
    EScarico.KeyValue:=QI100.FieldByName('SCARICO').AsString;
    QI100.Filtered:=False;
    LScarico:=lblScarico;
    LAzienda:=lblAzienda;
    LRiga:=lblRiga;
    LBadge:=lblBadge;
    ScrollBox:=ScrollBox1;
  end;
  // rimozione variabile globale R200FScaricoTimbratureDtM.fine
  CreaC004(SessioneOracle,'A032',Parametri.ProgOper);
  EScarico.KeyValue:=C004FParamForm.GetParametro('NOME_SCARICO',EScarico.Text);
  chkScarichiAuto.Checked:=C004FParamForm.GetParametro('SCARICHI_AUTO','N') = 'S';
  EScarico.Enabled:=not chkScarichiAuto.Checked;
end;

procedure TA032FScarico.btnScarichiOldClick(Sender: TObject);
begin
  A032ScarichiPrecedenti:=TA032ScarichiPrecedenti.Create(nil);
  try
    A032ScarichiPrecedenti.ShowModal;
  finally
    FreeAndNil(A032ScarichiPrecedenti);
  end;
end;

procedure TA032FScarico.chkScarichiAutoClick(Sender: TObject);
begin
  EScarico.Enabled:=not chkScarichiAuto.Checked;
  btnScarichiOld.Enabled:=not chkScarichiAuto.Checked;  
end;

procedure TA032FScarico.Nuovoelemento1Click(Sender: TObject);
begin
  OpenA031ParScarico(EScarico.Text);
  // rimozione variabile globale R200FScaricoTimbratureDtM.ini
  with {R200FScaricoTimbratureDtM}R200DM.QI100 do
  begin
    DisableControls;
    Refresh;
    EnableControls;
  end;
  // rimozione variabile globale R200FScaricoTimbratureDtM.fine
end;

procedure TA032FScarico.BitBtn1Click(Sender: TObject);
{Nome file di appoggio = TIaammgg.IRR}
begin
  // rimozione variabile globale R200FScaricoTimbratureDtM.ini
  if not chkScarichiAuto.Checked then
    {R200FScaricoTimbratureDtM}R200DM.QI100.SearchRecord('SCARICO',EScarico.KeyValue,[srFromBeginning]);
  {R200FScaricoTimbratureDtM}R200DM.LMessaggi.Clear;
  Screen.Cursor:=crHourGlass;
  {R200FScaricoTimbratureDtM}R200DM.Scarico(not chkScarichiAuto.Checked,False);
  Screen.Cursor:=crDefault;
  with {R200FScaricoTimbratureDtM}R200DM do
  begin
    RegistraMsg.LeggiMessaggi(RegistraMsg.ID);
    memoMessaggi.Lines.Clear;
    while Not RegistraMsg.selI005.Eof do
    begin
      memoMessaggi.Lines.Add(RegistraMsg.selI005.FieldByName('DATA_MSG').AsString + ' - ' + RegistraMsg.selI005.FieldByName('MSG').AsString);
      RegistraMsg.selI005.Next;
    end;
  end;
  // rimozione variabile globale R200FScaricoTimbratureDtM.fine
  ShowMessage('Scarico terminato');
end;

procedure TA032FScarico.FormCreate(Sender: TObject);
begin
  // rimozione variabile globale R200FScaricoTimbratureDtM.ini
  R200DM:=TR200FScaricoTimbratureDtM.Create(nil);
  // rimozione variabile globale R200FScaricoTimbratureDtM.fine
end;

procedure TA032FScarico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('NOME_SCARICO',VarToStr(EScarico.KeyValue));
  if chkScarichiAuto.Checked then
    C004FParamForm.PutParametro('SCARICHI_AUTO','S')
  else
    C004FParamForm.PutParametro('SCARICHI_AUTO','N');
  try SessioneOracle.Commit; except end;
  C004FParamForm.Free;
end;

procedure TA032FScarico.FormDestroy(Sender: TObject);
begin
  // rimozione variabile globale R200FScaricoTimbratureDtM.ini
  FreeAndNil(R200DM);
  // rimozione variabile globale R200FScaricoTimbratureDtM.fine
end;

procedure TA032FScarico.EScaricoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

end.
