unit A166UQuoteIndividuali;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  Grids, DBGrids, ExtCtrls, A166UQuoteIndividualiDtM, SelAnagrafe, A002UInterfacciaSt,
  C700USelezioneAnagrafe, C001UFiltroTabelleDtM, C001UFiltroTabelle, C001UScegliCampi,
  A000UCostanti, A000USessione,A000UInterfaccia,C005UDatiAnagrafici,C180FunzioniGenerali,
  DBCtrls, StdCtrls, Buttons, Mask, Oracle, OracleData, A003UDataLavoroBis,
  System.Actions;

type
  TA166FQuoteIndividuali = class(TR001FGestTab)
    dgrdQuoteIndividuali: TDBGrid;
    frmSelAnagrafe: TfrmSelAnagrafe;
    Panel2: TPanel;
    dedtDecorrenza: TDBEdit;
    Label1: TLabel;
    dedtScadenza: TDBEdit;
    Label2: TLabel;
    btnDecorrenza: TBitBtn;
    btnScadenza: TBitBtn;
    dedtImporto: TDBEdit;
    lblImporto: TLabel;
    dedtNumOre: TDBEdit;
    lblNumOre: TLabel;
    dedtPenalizzazione: TDBEdit;
    lblPenalizzazione: TLabel;
    dchkForzaProva: TDBCheckBox;
    dcmbTipoQuota: TDBLookupComboBox;
    Label6: TLabel;
    dTxtDescQuota: TDBText;
    lblPercIndividuale: TLabel;
    dedtPercIndividuale: TDBEdit;
    dedtPercStrutturale: TDBEdit;
    lblPercStrutturale: TLabel;
    dchkConsideraSaldo: TDBCheckBox;
    lblTipologia: TLabel;
    dedtPercentuale: TDBEdit;
    lblPercentuale: TLabel;
    dchkPartTime: TDBCheckBox;
    dchkSospendiQuote: TDBCheckBox;
    actAcquisizione: TAction;
    Acquisizionedafile1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure dcmbTipoQuotaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dcmbTipoQuotaCloseUp(Sender: TObject);
    procedure dcmbTipoQuotaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDecorrenzaClick(Sender: TObject);
    procedure btnScadenzaClick(Sender: TObject);
    procedure dchkSospendiQuoteClick(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure actAcquisizioneExecute(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaProgressivo;
  public
    { Public declarations }
  end;

var
  A166FQuoteIndividuali: TA166FQuoteIndividuali;

procedure OpenA166QuoteIndividuali(Prog:LongInt);

implementation

uses A166UAcquisizione;

{$R *.dfm}

procedure OpenA166QuoteIndividuali(Prog:LongInt);
begin
  if Prog <= 0 then
  begin
    ShowMessage('Nessun dipendente selezionato!');
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA166QuoteIndividuali') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA166FQuoteIndividuali, A166FQuoteIndividuali);
  Application.CreateForm(TA166FQuoteIndividualiDtM, A166FQuoteIndividualiDtM);
  try
    C700Progressivo:=Prog;
    Screen.Cursor:=crDefault;
    A166FQuoteIndividuali.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A166FQuoteIndividuali.Free;
    A166FQuoteIndividualiDtM.Free;
  end;
end;

procedure TA166FQuoteIndividuali.FormShow(Sender: TObject);
begin
  inherited;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A166FQuoteIndividualiDtM.A166FQuoteIndividualiMW,SessioneOracle,StatusBar,2,True);
  dTxtDescQuota.Visible:=Trim(dcmbTipoQuota.Text) <> '';
  lblTipologia.Visible:=Trim(dcmbTipoQuota.Text) <> '';
end;

procedure TA166FQuoteIndividuali.TAnnullaClick(Sender: TObject);
begin
  inherited;
  actRefresh.Execute;
end;

procedure TA166FQuoteIndividuali.actAcquisizioneExecute(Sender: TObject);
var s:String;
begin
  inherited;
  s:=A166FQuoteIndividualiDtM.A166FQuoteIndividualiMW.selT765.FieldByName('CODICE').AsString;
  A166FQuoteIndividualiDtM.A166FQuoteIndividualiMW.selT765.First;
  OpenA166Acquisizione;
  A166FQuoteIndividualiDtM.A166FQuoteIndividualiMW.selT765.SearchRecord('CODICE',s,[srFromBeginning]);
  A166FQuoteIndividualiDtM.selT775.Refresh;
end;

procedure TA166FQuoteIndividuali.btnDecorrenzaClick(Sender: TObject);
begin
  inherited;
  with A166FQuoteIndividualiDtM do
  begin
    if selT775.FieldByName('DECORRENZA').IsNull then
      selT775.FieldByName('DECORRENZA').AsDateTime:=Parametri.DataLavoro;
    selT775.FieldByName('DECORRENZA').AsDateTime:=DataOut(selT775.FieldByName('DECORRENZA').AsDateTime,'Data decorrenza','G');
  end;
end;

procedure TA166FQuoteIndividuali.btnScadenzaClick(Sender: TObject);
begin
  inherited;
  with A166FQuoteIndividualiDtM do
  begin
    if selT775.FieldByName('SCADENZA').IsNull then
      selT775.FieldByName('SCADENZA').AsDateTime:=Parametri.DataLavoro;
    selT775.FieldByName('SCADENZA').AsDateTime:=DataOut(selT775.FieldByName('SCADENZA').AsDateTime,'Data scadenza','G');
  end;
end;

procedure TA166FQuoteIndividuali.CambiaProgressivo;
begin
  if C700OldProgressivo <> C700Progressivo then
  begin
    A166FQuoteIndividualiDtM.SettaProgressivo;
    NumRecords;
  end;
end;

procedure TA166FQuoteIndividuali.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA166FQuoteIndividuali.DButtonStateChange(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.Enabled:=DButton.State = dsBrowse;
  btnDecorrenza.Enabled:=DButton.State <> dsBrowse;
  btnScadenza.Enabled:=DButton.State <> dsBrowse;
end;

procedure TA166FQuoteIndividuali.dchkSospendiQuoteClick(Sender: TObject);
begin
  inherited;
  dchkForzaProva.Enabled:=not dchkSospendiQuote.Checked;
  if not dchkForzaProva.Enabled then
    dchkForzaProva.Checked:=False;
  dchkPartTime.Enabled:=not dchkSospendiQuote.Checked;
  if not dchkPartTime.Enabled then
    dchkPartTime.Checked:=False;
end;

procedure TA166FQuoteIndividuali.dcmbTipoQuotaCloseUp(Sender: TObject);
var
  TipoQuota: String;
  txtCodTipoQuota: String;
begin
  inherited;
  if DButton.State in [dsEdit,dsInsert] then
    txtCodTipoQuota:=Trim(dcmbTipoQuota.Text)
  else
    txtCodTipoQuota:=A166FQuoteIndividualiDtM.selT775.FieldByName('CODTIPOQUOTA').AsString.Trim;

  dTxtDescQuota.Visible:=Trim(txtCodTipoQuota) <> '';
  lblTipologia.Visible:=Trim(txtCodTipoQuota) <> '';
  dchkForzaProva.Enabled:=Trim(txtCodTipoQuota) = '';
  if not dchkForzaProva.Enabled then
    dchkForzaProva.Checked:=False;
  dchkPartTime.Enabled:=Trim(txtCodTipoQuota) = '';
  if not dchkPartTime.Enabled then
    dchkPartTime.Checked:=False;
  dchkSospendiQuote.Enabled:=Trim(txtCodTipoQuota) = '';
  if not dchkSospendiQuote.Enabled then
    dchkSospendiQuote.Checked:=False;
  dedtNumOre.Enabled:=False;
  dedtPercentuale.Enabled:=False;
  dedtPercIndividuale.Enabled:=False;
  dedtPercStrutturale.Enabled:=False;
  dchkConsideraSaldo.Enabled:=False;
  dedtPenalizzazione.Enabled:=False;
  dedtImporto.Enabled:=False;
  with A166FQuoteIndividualiDtM.A166FQuoteIndividualiMW do
  begin
    if Trim(txtCodTipoQuota) <> '' then
    begin
      TipoQuota:=getTipoQuotaByCod(Trim(txtCodTipoQuota));
      dedtNumOre.Enabled:=TipoQuota= 'Q';
      dedtPercentuale.Enabled:=not R180In(TipoQuota,['D','Q','P']);
      dedtPercIndividuale.Enabled:=R180In(TipoQuota,['I','V','C','D']);
      dedtPercStrutturale.Enabled:=R180In(TipoQuota,['I','V','C']);
      dchkConsideraSaldo.Enabled:=TipoQuota = 'A';
      dedtPenalizzazione.Enabled:=TipoQuota = 'P';
      dedtImporto.Enabled:=not R180In(TipoQuota,['C','P']);
      if (DButton.State in [dsEdit,dsInsert]) and (TipoQuota = 'C') then
        A166FQuoteIndividualiDtm.selT775.FieldByName('IMPORTO').AsFloat:=-1;

      if (DButton.State in [dsEdit,dsInsert])then
      begin
        if not dedtPercentuale.Enabled then
          A166FQuoteIndividualiDtm.selT775.FieldByName('PERCENTUALE').AsFloat:=100;
      end;
    end;
    lblNumOre.Enabled:=dedtNumOre.Enabled;
    lblPercentuale.Enabled:=dedtPercentuale.Enabled;
    lblPercIndividuale.Enabled:=dedtPercIndividuale.Enabled;
    lblPercStrutturale.Enabled:=dedtPercStrutturale.Enabled;
    lblPenalizzazione.Enabled:=dedtPenalizzazione.Enabled;
    lblImporto.Enabled:=dedtImporto.Enabled;
  end;
end;

procedure TA166FQuoteIndividuali.dcmbTipoQuotaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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

procedure TA166FQuoteIndividuali.dcmbTipoQuotaKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbTipoQuotaCloseUp(nil);
end;

end.
