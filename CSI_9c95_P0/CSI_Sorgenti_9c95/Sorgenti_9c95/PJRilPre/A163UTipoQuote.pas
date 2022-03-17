unit A163UTipoQuote;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, StdCtrls, ComCtrls,
  ToolWin, Mask, DBCtrls, Buttons, Grids, DBGrids, ExtCtrls, A000UInterfaccia,
  A000UCostanti, A000USessione, C013UCheckList, C180FunzioniGenerali,
  System.Actions, A163UTipoQuoteMW, System.ImageList;

type
  TA163FTipoQuote = class(TR004FGestStorico)
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dedtCodice: TDBEdit;
    dedtDescrizione: TDBEdit;
    drdgTipologia: TDBRadioGroup;
    dgrTipoQuote: TDBGrid;
    GroupBox1: TGroupBox;
    dedtVPIntera: TDBEdit;
    lblVPIntera: TLabel;
    lblCausale: TLabel;
    dedtVPProporzionata: TDBEdit;
    lblVPProporzionata: TLabel;
    dedtVPNetta: TDBEdit;
    lblVPNetta: TLabel;
    lblVPNettaRisp: TLabel;
    dedtVPNettaRisp: TDBEdit;
    dedtVPRisparmio: TDBEdit;
    lblVPRisparmio: TLabel;
    dedtVPNoRisp: TDBEdit;
    lblVPNoRisp: TLabel;
    dedtVPQuantitativa: TDBEdit;
    lblVPQuantitativa: TLabel;
    dcmbCausale: TDBLookupComboBox;
    dtxtCausale: TDBText;
    dedtAcconti: TDBEdit;
    lblAcconti: TLabel;
    btnAcconti: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure dcmbCausaleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DButtonStateChange(Sender: TObject);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure btnAccontiClick(Sender: TObject);
    procedure dcmbCausaleCloseUp(Sender: TObject);
    procedure dcmbCausaleKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure drdgTipologiaChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A163FTipoQuote: TA163FTipoQuote;

  procedure OpenA163TipoQuote;

implementation

uses A163UTipoQuoteDtM;

{$R *.dfm}

procedure OpenA163TipoQuote;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA163TipoQuote') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA163FTipoQuote, A163FTipoQuote);
  Application.CreateForm(TA163FTipoQuoteDtM, A163FTipoQuoteDtM);
  try
    Screen.Cursor:=crDefault;
    A163FTipoQuote.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A163FTipoQuote.Free;
    A163FTipoQuoteDtM.Free;
  end;
end;

procedure TA163FTipoQuote.btnAccontiClick(Sender: TObject);
begin
  inherited;
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  try
    //with A163FTipoQuoteDtM.selT765Acc do
    with A163FTipoQuoteDtM.A163FTipoQuoteMW.selT765Acc do
    begin
      Close;
      if drdgTipologia.ItemIndex = 7 then
        SetVariable('TIPOQUOTA','''A'',''S'',''T'',''I'',''V'',''C'',''D''')
      else
        SetVariable('TIPOQUOTA','''A''');
      SetVariable('DATA',A163FTipoQuoteDtM.selT765.FieldByName('DECORRENZA').AsDateTime);
      Open;
      First;
      while not Eof do
      begin
        C013FCheckList.clbListaDati.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
        Next;
      end;
    end;
    R180PutCheckList(dedtAcconti.Text,5,C013FCheckList.clbListaDati);
    if ShowModal = mrOK then
      dedtAcconti.Text:=R180GetCheckList(5,C013FCheckList.clbListaDati);
  finally
    Release;
  end;
end;

procedure TA163FTipoQuote.btnStoricizzaClick(Sender: TObject);
begin
  inherited;
  dedtDecorrenza.SetFocus;
end;

procedure TA163FTipoQuote.DButtonStateChange(Sender: TObject);
begin
  inherited;
  drdgTipologia.Enabled:=not InterfacciaR004.StoricizzazioneInCorso;
  btnAcconti.Enabled:=DButton.State in [dsEdit,dsInsert];
end;

procedure TA163FTipoQuote.dcmbCausaleCloseUp(Sender: TObject);
begin
  inherited;
  dtxtCausale.Visible:=Trim(dcmbCausale.Text) <> '';
end;

procedure TA163FTipoQuote.dcmbCausaleKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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

procedure TA163FTipoQuote.dcmbCausaleKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  dcmbCausaleCloseUp(nil);
end;

procedure TA163FTipoQuote.drdgTipologiaChange(Sender: TObject);
begin
  inherited;
  lblAcconti.Caption:='Acconti di riferimento';
  if drdgTipologia.ItemIndex = 7 then
    lblAcconti.Caption:='Quote qual. di riferimento';
  lblAcconti.Enabled:=drdgTipologia.ItemIndex in [4,5,6,7];
  dedtAcconti.Enabled:=drdgTipologia.ItemIndex in [4,5,6,7];
  btnAcconti.Enabled:=(drdgTipologia.ItemIndex in [4,5,6,7]) and (DButton.State in [dsEdit,dsInsert]);
  lblCausale.Enabled:=drdgTipologia.ItemIndex = 7;
  dcmbCausale.Enabled:=drdgTipologia.ItemIndex = 7;
  dtxtCausale.Visible:=(drdgTipologia.ItemIndex = 7) and (Trim(dcmbCausale.Text) <> '');
  lblVPQuantitativa.Enabled:=drdgTipologia.ItemIndex = 7;
  dedtVPQuantitativa.Enabled:=drdgTipologia.ItemIndex = 7;
  lblVPIntera.Enabled:=not (drdgTipologia.ItemIndex in [7,8]);
  dedtVPIntera.Enabled:=not (drdgTipologia.ItemIndex in [7,8]);
  lblVPProporzionata.Enabled:=not (drdgTipologia.ItemIndex in [7,8]);
  dedtVPProporzionata.Enabled:=not (drdgTipologia.ItemIndex in [7,8]);
  lblVPNetta.Enabled:=drdgTipologia.ItemIndex <> 7;
  dedtVPNetta.Enabled:=drdgTipologia.ItemIndex <> 7;
  lblVPNettaRisp.Enabled:=not (drdgTipologia.ItemIndex in [7,8]);
  dedtVPNettaRisp.Enabled:=not (drdgTipologia.ItemIndex in [7,8]);
  lblVPRisparmio.Enabled:=not (drdgTipologia.ItemIndex in [7,8]);
  dedtVPRisparmio.Enabled:=not (drdgTipologia.ItemIndex in [7,8]);
  lblVPNoRisp.Enabled:=not (drdgTipologia.ItemIndex in [7,8]);
  dedtVPNoRisp.Enabled:=not (drdgTipologia.ItemIndex in [7,8]);
  if DButton.State in [dsEdit,dsInsert] then
  begin
    if not dedtAcconti.Enabled then
      A163FTipoQuoteDtM.selT765.FieldByName('ACCONTI').AsString:='';
    if not dedtVPQuantitativa.Enabled then
      A163FTipoQuoteDtM.selT765.FieldByName('VP_QUANTITATIVA').AsString:='';
    if not dedtVPIntera.Enabled then
      A163FTipoQuoteDtM.selT765.FieldByName('VP_INTERA').AsString:='';
    if not dedtVPProporzionata.Enabled then
      A163FTipoQuoteDtM.selT765.FieldByName('VP_PROPORZIONATA').AsString:='';
    if not dedtVPNetta.Enabled then
      A163FTipoQuoteDtM.selT765.FieldByName('VP_NETTA').AsString:='';
    if not dedtVPNettaRisp.Enabled then
      A163FTipoQuoteDtM.selT765.FieldByName('VP_NETTARISP').AsString:='';
    if not dedtVPRisparmio.Enabled then
      A163FTipoQuoteDtM.selT765.FieldByName('VP_RISPARMIO').AsString:='';
    if not dedtVPNoRisp.Enabled then
      A163FTipoQuoteDtM.selT765.FieldByName('VP_NORISPARMIO').AsString:='';
  end;
end;

procedure TA163FTipoQuote.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A163FTipoQuoteDtM.selT765;
  A163FTipoQuoteDtM.selT765.Open;
  dcmbCausale.ListSource:=A163FTipoQuoteDtM.A163FTipoQuoteMW.dsrT305;
  dtxtCausale.Visible:=Trim(dcmbCausale.Text) <> '';
end;

procedure TA163FTipoQuote.TInserClick(Sender: TObject);
begin
  inherited;
  dedtCodice.SetFocus;
end;

end.
