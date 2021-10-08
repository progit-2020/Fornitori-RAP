unit A103UScaricoGiust;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R600, StdCtrls, Buttons, DBCtrls, Menus, A102UParScaricoGiust, DB, R500Lin,
  A000UCostanti, A000USessione,A000UInterfaccia, C180FunzioniGenerali, Variants,
  {C012UVisualizzaTesto,} R250UScaricoGiustificativiDtM, Oracle, OracleData,
  C004UParamForm, A083UMsgElaborazioni;

type

  TTipoCausale = (tcNone,tcAssenza,tcPresenza,tcGiustificazione);

  TA103FScaricoGiust = class(TForm)
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    EScarico: TDBLookupComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    btnAnomalie: TBitBtn;
    Label9: TLabel;
    dsrI150: TDataSource;
    chkScarichiAuto: TCheckBox;
    Label2: TLabel;
    lblAzienda: TLabel;
    Label3: TLabel;
    lblBadge: TLabel;
    Label5: TLabel;
    lblRiga: TLabel;
    Label7: TLabel;
    lblScarico: TLabel;
    LblMatricola: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkScarichiAutoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EScaricoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A103FScaricoGiust: TA103FScaricoGiust;

procedure OpenA103ScaricoGiust;

implementation

{$R *.DFM}

procedure OpenA103ScaricoGiust;
{Scarico timbrature dai rilevatori}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA103ScaricoGiust') of
    'N','R':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
  end;
  A103FScaricoGiust:=TA103FScaricoGiust.Create(nil);
  with A103FScaricoGiust do
  try
//    R250FScaricoGiustificativiDtM:=TR250FScaricoGiustificativiDtM.Create(nil);
//    R250FScaricoGiustificativiDtM.SessioneOracleB015:=SessioneOracle;
//    R250FScaricoGiustificativiDtM.ConnettiDataBase(SessioneOracle.LogonDatabase);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
//    R250FScaricoGiustificativiDtM.Free;
    Release;
  end;
end;

procedure TA103FScaricoGiust.Nuovoelemento1Click(Sender: TObject);
begin
  OpenA102ParScaricoGiust(EScarico.Text);
  with R250FScaricoGiustificativiDtM.SelI150 do
  begin
    DisableControls;
    Refresh;
    EnableControls;
  end;
end;

procedure TA103FScaricoGiust.FormActivate(Sender: TObject);
begin
  with R250FScaricoGiustificativiDtM do
  begin
    if Parametri.Azienda <> 'AZIN' then
    begin
      selI150.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
      selI150.Filtered:=True;
    end;
    EScarico.KeyValue:=selI150.FieldByName('CODICE').AsString;
    selI150.Filtered:=False;
    LScarico:=lblScarico;
    LAzienda:=lblAzienda;
    LRiga:=lblRiga;
    LBadge:=lblBadge;
    LMatricola:=lblMatricola;
    ScrollBox:=ScrollBox1;
  end;
  CreaC004(SessioneOracle,'A103',Parametri.ProgOper);
  EScarico.KeyValue:=C004FParamForm.GetParametro('NOME_SCARICO',EScarico.Text);
  chkScarichiAuto.Checked:=C004FParamForm.GetParametro('SCARICHI_AUTO','N') = 'S';
  EScarico.Enabled:=not chkScarichiAuto.Checked;
  btnAnomalie.Enabled:=False;
end;

procedure TA103FScaricoGiust.BitBtn1Click(Sender: TObject);
begin
  if not chkScarichiAuto.Checked then
    R250FScaricoGiustificativiDtM.selI150.SearchRecord('CODICE',EScarico.KeyValue,[srFromBeginning]);
  //R250FScaricoGiustificativiDtM.LMessaggi.Clear;
  RegistraMsg.IniziaMessaggio('A103');
  Screen.Cursor:=crHourGlass;
  R250FScaricoGiustificativiDtM.Scarico(not chkScarichiAuto.Checked,False);
  Screen.Cursor:=crDefault;
  R180MessageBox('Scarico terminato',INFORMA);
  btnAnomalie.Enabled:=True;
end;

procedure TA103FScaricoGiust.btnAnomalieClick(Sender: TObject);
begin
  //OpenC012VisualizzaTesto('<A103> Visualizzazione delle anomalie di scarico','',R250FScaricoGiustificativiDtM.LMessaggi);
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A103','');
end;

procedure TA103FScaricoGiust.EScaricoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then 
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA103FScaricoGiust.FormShow(Sender: TObject);
begin
  dsrI150.DataSet:=R250FScaricoGiustificativiDtM.selI150;
  R250FScaricoGiustificativiDtM.selI150.Open;
end;

procedure TA103FScaricoGiust.chkScarichiAutoClick(Sender: TObject);
begin
  EScarico.Enabled:=not chkScarichiAuto.Checked;
end;

procedure TA103FScaricoGiust.FormClose(Sender: TObject;
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

procedure TA103FScaricoGiust.FormCreate(Sender: TObject);
begin
  R250FScaricoGiustificativiDtM:=TR250FScaricoGiustificativiDtM.Create(nil);
  R250FScaricoGiustificativiDtM.SessioneOracleB015:=SessioneOracle;
  R250FScaricoGiustificativiDtM.ConnettiDataBase(SessioneOracle.LogonDatabase);
end;

procedure TA103FScaricoGiust.FormDestroy(Sender: TObject);
begin
  R250FScaricoGiustificativiDtM.Free;
end;

end.
