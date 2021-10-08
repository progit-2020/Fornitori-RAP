unit S746UStatiAvanzamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, StdCtrls, ComCtrls,
  ToolWin, Mask, DBCtrls, Buttons, Math, StrUtils, A003UDataLavoroBis,
  A000UCostanti, A000USessione, A000UInterfaccia, C013UCheckList, C180FunzioniGenerali,
  ExtCtrls, C600USelAnagrafe, System.Actions, System.ImageList;

type
  TS746FStatiAvanzamento = class(TR004FGestStorico)
    pnlTestata: TPanel;
    dedtCodice: TDBEdit;
    lblCodice: TLabel;
    lblDescrizione: TLabel;
    dedtDescrizione: TDBEdit;
    drgpModificabile: TDBRadioGroup;
    lblCodStampa: TLabel;
    lblCodRegola: TLabel;
    dcmbCodRegola: TDBLookupComboBox;
    dcmbCodStampa: TDBLookupComboBox;
    dlblDescCodStampa: TDBText;
    dlblDescCodRegola: TDBText;
    grpPeriodoCompilazione: TGroupBox;
    lblDataDa: TLabel;
    lblDataA: TLabel;
    dedtDataDa: TDBEdit;
    dedtDataA: TDBEdit;
    btnDataDa: TButton;
    btnDataA: TButton;
    grpPeriodoRichiestaVisione: TGroupBox;
    lblDataDaRichiestaVisione: TLabel;
    lblDataARichiestaVisione: TLabel;
    dedtDataDaRichiestaVisione: TDBEdit;
    dedtDataARichiestaVisione: TDBEdit;
    btnDataDaRichiestaVisione: TButton;
    btnDataARichiestaVisione: TButton;
    grpValutazioneIntermedia: TGroupBox;
    dchkValIntermModificabile: TDBCheckBox;
    dchkValIntermObbligatoria: TDBCheckBox;
    dchkCreaAutovalutazione: TDBCheckBox;
    procedure FormShow(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure DButtonStateChange(Sender: TObject);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure dcmbCodRegolaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure drgpModificabileChange(Sender: TObject);
    procedure btnDataDaClick(Sender: TObject);
    procedure dedtDataDaRichiestaVisioneDblClick(Sender: TObject);
    procedure dchkValIntermModificabileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AbilitaComponenti;
  end;

var
  S746FStatiAvanzamento: TS746FStatiAvanzamento;

procedure OpenS746FStatiAvanzamento;

implementation

{$R *.dfm}
uses
  S746UStatiAvanzamentoDtM;

procedure OpenS746FStatiAvanzamento;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenS746FStatiAvanzamento') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourGlass;
  Application.CreateForm(TS746FStatiAvanzamento,S746FStatiAvanzamento);
  Application.CreateForm(TS746FStatiAvanzamentoDtM,S746FStatiAvanzamentoDtM);
  try
    Screen.Cursor:=crDefault;
    S746FStatiAvanzamento.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    S746FStatiAvanzamento.Free;
    S746FStatiAvanzamentoDtM.Free;
  end;
end;

procedure TS746FStatiAvanzamento.FormShow(Sender: TObject);
begin
  inherited;
  dlblDescCodRegola.DataSource:=S746FStatiAvanzamentoDtM.S746FStatiAvanzamentoMW.dSG741;
  dcmbCodRegola.ListSource:=S746FStatiAvanzamentoDtM.S746FStatiAvanzamentoMW.dSG741;
  dlblDescCodStampa.DataSource:=S746FStatiAvanzamentoDtM.S746FStatiAvanzamentoMW.dSG746;
  dcmbCodStampa.ListSource:=S746FStatiAvanzamentoDtM.S746FStatiAvanzamentoMW.dSG746;
  with S746FStatiAvanzamentoDtM.SG746 do
    while not Eof do
    begin
      if (Parametri.DataLavoro >= FieldByName('DECORRENZA').AsDateTime)
      and (Parametri.DataLavoro <= FieldByName('DECORRENZA_FINE').AsDateTime) then
        Break;
      Next;
    end;
  AbilitaComponenti;
end;

procedure TS746FStatiAvanzamento.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TS746FStatiAvanzamento.DButtonStateChange(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TS746FStatiAvanzamento.btnDataDaClick(Sender: TObject);
var NomeCampo,Titolo:String;
begin
  if (Sender as TButton).Name = 'btnDataDa' then
    NomeCampo:='DATA_DA'
  else if (Sender as TButton).Name = 'btnDataA' then
    NomeCampo:='DATA_A'
  else if (Sender as TButton).Name = 'btnDataDaRichiestaVisione' then
    NomeCampo:='DATA_DA_RICHIESTA_VISIONE'
  else if (Sender as TButton).Name = 'btnDataARichiestaVisione' then
    NomeCampo:='DATA_A_RICHIESTA_VISIONE';
  Titolo:=IfThen(Pos('DATA_DA',NomeCampo) > 0,'Data inizio periodo','Data fine periodo');
  with S746FStatiAvanzamentoDtM do
  begin
    if SG746.FieldByName(NomeCampo).IsNull then
      SG746.FieldByName(NomeCampo).AsDateTime:=Parametri.DataLavoro;
    SG746.FieldByName(NomeCampo).AsDateTime:=DataOut(SG746.FieldByName(NomeCampo).AsDateTime,Titolo,'G');
  end;
end;

procedure TS746FStatiAvanzamento.btnStoricizzaClick(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TS746FStatiAvanzamento.dchkValIntermModificabileClick(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TS746FStatiAvanzamento.dcmbCodRegolaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TS746FStatiAvanzamento.dedtDataDaRichiestaVisioneDblClick(Sender: TObject);
begin
  inherited;
  if btnDataDaRichiestaVisione.Enabled then
    S746FStatiAvanzamentoDtM.S746FStatiAvanzamentoMW.ResetPeriodoRichiestaPresaVisione
end;

procedure TS746FStatiAvanzamento.drgpModificabileChange(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
  with S746FStatiAvanzamentoDtM.SG746 do
    if drgpModificabile.ItemIndex = 1 then
      FieldByName('CODSTAMPA').AsInteger:=FieldByName('CODICE').AsInteger - 1;
end;

procedure TS746FStatiAvanzamento.AbilitaComponenti;
begin
  drgpModificabile.Enabled:=StrToIntDef(dedtCodice.Text,0) <> 1;
  dcmbCodStampa.Enabled:=drgpModificabile.ItemIndex <> 1;
  dlblDescCodStampa.Visible:=dcmbCodStampa.KeyValue <> null;
  btnDataDa.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnDataA.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnDataDaRichiestaVisione.Enabled:=btnDataDa.Enabled;
  btnDataARichiestaVisione.Enabled:=btnDataA.Enabled;
  dchkValIntermObbligatoria.Enabled:=dchkValIntermModificabile.Checked;
  if DButton.State in [dsInsert,dsEdit] then
    if not dchkValIntermModificabile.Checked then
      dchkValIntermObbligatoria.Checked:=False;
end;

end.
