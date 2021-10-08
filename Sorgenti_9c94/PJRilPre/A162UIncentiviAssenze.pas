unit A162UIncentiviAssenze;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, ComCtrls, StrUtils,
  ToolWin, StdCtrls, Mask, DBCtrls, Buttons, A162UIncentiviAssenzeDtM, Grids,
  DBGrids, ExtCtrls, C180FunzioniGenerali, A161UTipoAbbattimenti, A150UAccorpamentoCausali,
  A000UInterfaccia, A000UCostanti, A000USessione, A003UDataLavoroBis, C013UCheckList,
  System.Actions;

type
  TA162FIncentiviAssenze = class(TR004FGestStorico)
    dgrdAbbattimenti: TDBGrid;
    Panel1: TPanel;
    lblDato1: TLabel;
    dcmbDato1: TDBLookupComboBox;
    dlblDato1: TDBText;
    lblDato2: TLabel;
    dcmbDato2: TDBLookupComboBox;
    dlblDato2: TDBText;
    lblDato3: TLabel;
    dcmbDato3: TDBLookupComboBox;
    dlblDato3: TDBText;
    dcmbTipoAccorpCausali: TDBLookupComboBox;
    lblTipoAccorp: TLabel;
    dlblDescTipoAccorp: TDBText;
    lblPercAbb: TLabel;
    dedtPercAbb: TDBEdit;
    lblPercAbbFranc: TLabel;
    dedtPercAbbFranc: TDBEdit;
    dchkAbbGGInt: TDBCheckBox;
    dcmbCodiciAccorpCausali: TDBLookupComboBox;
    lblCodAccorp: TLabel;
    dedtFranchigia: TDBEdit;
    lblFranchigia: TLabel;
    drdgGestioneFranchigia: TDBRadioGroup;
    dchkFruitoOre: TDBCheckBox;
    lblTipoAbbatt: TLabel;
    dcmbTipoAbbattimento: TDBLookupComboBox;
    dlblDescTipoAbbatt: TDBText;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    lblRisparmio: TLabel;
    Label3: TLabel;
    dedtDataFine: TDBEdit;
    sbtDecorrenzaFine: TSpeedButton;
    dlblDescCausale: TDBText;
    dcmbCausale: TDBLookupComboBox;
    Label5: TLabel;
    lblAssenzeAgg: TLabel;
    dedtAssenzeAgg: TDBEdit;
    btnAssenzeAgg: TBitBtn;
    dchkPropFranchigia: TDBCheckBox;
    dchkSoloGGInt: TDBCheckBox;
    dlblDescCodAccorp: TDBText;
    procedure dcmbDato1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure drdgGestioneFranchigiaClick(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure dedtFranchigiaExit(Sender: TObject);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure sbtDecorrenzaFineClick(Sender: TObject);
    procedure dcmbCausaleCloseUp(Sender: TObject);
    procedure dcmbCausaleKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dchkAbbGGIntClick(Sender: TObject);
    procedure dcmbDato1CloseUp(Sender: TObject);
    procedure dcmbDato1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dcmbDato2CloseUp(Sender: TObject);
    procedure dcmbDato3CloseUp(Sender: TObject);
    procedure dcmbDato3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dcmbDato2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dcmbTipoAccorpCausaliCloseUp(Sender: TObject);
    procedure dcmbTipoAccorpCausaliKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dcmbCodiciAccorpCausaliCloseUp(Sender: TObject);
    procedure dcmbTipoAbbattimentoCloseUp(Sender: TObject);
    procedure dcmbTipoAbbattimentoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAssenzeAggClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dchkSoloGGIntClick(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure dcmbCodiciAccorpCausaliKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dedtDecorrenzaExit(Sender: TObject);
    procedure dcmbCausaleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    oldTipoAccorp: String;
  public
    { Public declarations }
    procedure Abilitazioni;
  end;

var
  A162FIncentiviAssenze: TA162FIncentiviAssenze;

  procedure OpenA162IncentiviAssenze;

implementation

{$R *.dfm}

procedure OpenA162IncentiviAssenze;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA162IncentiviAssenze') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA162FIncentiviAssenze, A162FIncentiviAssenze);
  Application.CreateForm(TA162FIncentiviAssenzeDtM, A162FIncentiviAssenzeDtM);
  try
    Screen.Cursor:=crDefault;
    A162FIncentiviAssenze.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A162FIncentiviAssenze.Free;
    A162FIncentiviAssenzeDtM.Free;
  end;
end;

procedure TA162FIncentiviAssenze.btnAssenzeAggClick(Sender: TObject);
var ElencoValoriChecklist: TElencoValoriChecklist;
begin
  inherited;

  ElencoValoriChecklist:=A162FIncentiviAssenzeDtM.A162FIncentiviAssenzeMW.ListAssenzeAggiuntive(dcmbTipoAccorpCausali.Text, dcmbCodiciAccorpCausali.Text);

  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  try
    clbListaDati.items.Clear;
    clbListaDati.items.assign(ElencoValoriChecklist.lstDescrizione);

    R180PutCheckList(dedtAssenzeAgg.Text,5,C013FCheckList.clbListaDati);
    if ShowModal = mrOK then
      dedtAssenzeAgg.Text:=R180GetCheckList(5,C013FCheckList.clbListaDati);
  finally
    FreeAndNil(ElencoValoriChecklist);
    Release;
  end;
end;

procedure TA162FIncentiviAssenze.btnStoricizzaClick(Sender: TObject);
begin
  inherited;
  dedtDecorrenza.SetFocus;
end;

procedure TA162FIncentiviAssenze.DButtonStateChange(Sender: TObject);
begin
  inherited;
  Abilitazioni;
  oldTipoAccorp:=dcmbTipoAccorpCausali.Text;
end;

procedure TA162FIncentiviAssenze.dchkAbbGGIntClick(Sender: TObject);
begin
  inherited;
  if DButton.State = dsBrowse then
    Exit;
  if dchkAbbGGInt.Checked then
  begin
    A162FIncentiviAssenzeDtM.selT769.FieldByName('CONTA_FRUITO_ORE').AsString:='S';
    A162FIncentiviAssenzeDtM.selT769.FieldByName('CONTA_SOLO_GGINT').AsString:='N';
  end;
  Abilitazioni;
end;

procedure TA162FIncentiviAssenze.dchkSoloGGIntClick(Sender: TObject);
begin
  inherited;
  if DButton.State = dsBrowse then
    Exit;
  if dchkSoloGGInt.Checked then
  begin
    A162FIncentiviAssenzeDtM.selT769.FieldByName('CONTA_FRUITO_ORE').AsString:='S';
    A162FIncentiviAssenzeDtM.selT769.FieldByName('FORZA_ABB_GGINT').AsString:='N';
  end;
  Abilitazioni;
end;

procedure TA162FIncentiviAssenze.dcmbCausaleCloseUp(Sender: TObject);
begin
  inherited;
  dlblDescCausale.Visible:=Trim(dcmbCausale.Text) <> '';
  if DButton.State = dsBrowse then
    Exit;
  with A162FIncentiviAssenzeDtM do
  begin
    if Trim(selT769.FieldByName('CAUSALE').AsString) <> '' then
    begin
      selT769.FieldByName('COD_TIPOACCORPCAUSALI').AsString:=' ';
      selT769.FieldByName('COD_CODICIACCORPCAUSALI').AsString:=' ';
      selT769.FieldByName('TIPO_ABBATTIMENTO').AsString:='';
//      selT769.FieldByName('GESTIONE_FRANCHIGIA').AsString:='Z';
      selT769.FieldByName('FRANCHIGIA_ASSENZE').AsInteger:=0;
      dcmbTipoAccorpCausaliCloseUp(nil);
      dcmbTipoAbbattimentoCloseUp(nil);
    end;
    Abilitazioni;
  end;
end;

procedure TA162FIncentiviAssenze.Abilitazioni;
begin
  with A162FIncentiviAssenzeDtM do
  begin
    lblTipoAccorp.Enabled:=Trim(selT769.FieldByName('CAUSALE').AsString) = '';
    dcmbTipoAccorpCausali.Enabled:=Trim(selT769.FieldByName('CAUSALE').AsString) = '';
    lblCodAccorp.Enabled:=Trim(selT769.FieldByName('CAUSALE').AsString) = '';
    dcmbCodiciAccorpCausali.Enabled:=Trim(selT769.FieldByName('CAUSALE').AsString) = '';
    lblTipoAbbatt.Enabled:=Trim(selT769.FieldByName('CAUSALE').AsString) = '';
    dcmbTipoAbbattimento.Enabled:=Trim(selT769.FieldByName('CAUSALE').AsString) = '';
    drdgGestioneFranchigia.Enabled:=Trim(selT769.FieldByName('CAUSALE').AsString) = '';
    lblFranchigia.Enabled:=drdgGestioneFranchigia.Enabled;
    dedtFranchigia.Enabled:=drdgGestioneFranchigia.Enabled;
    dedtPercAbbFranc.Enabled:=(Trim(selT769.FieldByName('CAUSALE').AsString) <> '') or
                              (selT769.FieldByName('FRANCHIGIA_ASSENZE').AsFloat <> 0);
    lblPercAbbFranc.Enabled:=(Trim(selT769.FieldByName('CAUSALE').AsString) <> '') or
                             (selT769.FieldByName('FRANCHIGIA_ASSENZE').AsFloat <> 0);
    dedtPercAbb.Enabled:=(Trim(selT769.FieldByName('CAUSALE').AsString) <> '');
    lblPercAbb.Enabled:=(Trim(selT769.FieldByName('CAUSALE').AsString) <> '');
    lblAssenzeAgg.Enabled:=(selT769.FieldByName('FRANCHIGIA_ASSENZE').AsFloat <> 0);
    dedtAssenzeAgg.Enabled:=(selT769.FieldByName('FRANCHIGIA_ASSENZE').AsFloat <> 0);
    btnAssenzeAgg.Enabled:=(DButton.State <> dsBrowse) and (selT769.FieldByName('FRANCHIGIA_ASSENZE').AsFloat <> 0);
    dchkPropFranchigia.Enabled:=(selT769.FieldByName('FRANCHIGIA_ASSENZE').AsFloat <> 0);
    lblRisparmio.Visible:=Trim(selT769.FieldByName('TIPO_ABBATTIMENTO').AsString) <> '';
    if lblRisparmio.Visible then
      lblRisparmio.Caption:='Risparmio bilancio: ' + IfThen(selT769.FieldByName('D_RISPARMIO').AsString = 'S','Si','No');
    dchkFruitoOre.Enabled:=(not dchkAbbGGInt.Checked) and (not dchkSoloGGInt.Checked);
    dchkAbbGGInt.Enabled:=not dchkSoloGGInt.Checked;
    if not dchkAbbGGInt.Enabled then
      dchkAbbGGInt.Checked:=False;
    dchkSoloGGInt.Enabled:=not dchkAbbGGInt.Checked;
    if not dchkSoloGGInt.Enabled then
      dchkSoloGGInt.Checked:=False;
  end;
end;

procedure TA162FIncentiviAssenze.dcmbCausaleKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
    //Caratto 26/11/2014 svuotando causale i due edit vengono disabilitati. ripristino default a 100
    A162FIncentiviAssenzeDtM.selT769.FieldByName('PERC_ABB_FRANCHIGIA').AsFloat:=100;
    A162FIncentiviAssenzeDtM.selT769.FieldByName('PERC_ABBATTIMENTO').AsFloat:=100;
  end;
end;

procedure TA162FIncentiviAssenze.dcmbCausaleKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbCausaleCloseUp(nil);
end;

procedure TA162FIncentiviAssenze.dcmbCodiciAccorpCausaliCloseUp(
  Sender: TObject);
begin
  inherited;
  dlblDescCodAccorp.Visible:=Trim(dcmbCodiciAccorpCausali.Text) <> '';
end;

procedure TA162FIncentiviAssenze.dcmbCodiciAccorpCausaliKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbCodiciAccorpCausaliCloseUp(nil);
end;

procedure TA162FIncentiviAssenze.dcmbDato1CloseUp(Sender: TObject);
begin
  inherited;
  dlblDato1.Visible:=Trim(dcmbDato1.Text) <> '';
end;

procedure TA162FIncentiviAssenze.dcmbDato1KeyDown(Sender: TObject;
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

procedure TA162FIncentiviAssenze.dcmbDato1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  dcmbDato1CloseUp(nil);
end;

procedure TA162FIncentiviAssenze.dcmbDato2CloseUp(Sender: TObject);
begin
  inherited;
  dlblDato2.Visible:=Trim(dcmbDato2.Text) <> '';
end;

procedure TA162FIncentiviAssenze.dcmbDato2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  dcmbDato2CloseUp(nil);
end;

procedure TA162FIncentiviAssenze.dcmbDato3CloseUp(Sender: TObject);
begin
  inherited;
  dlblDato3.Visible:=Trim(dcmbDato3.Text) <> '';
end;

procedure TA162FIncentiviAssenze.dcmbDato3KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  dcmbDato3CloseUp(nil);
end;

procedure TA162FIncentiviAssenze.dcmbTipoAbbattimentoCloseUp(Sender: TObject);
begin
  inherited;
  dlblDescTipoAbbatt.Visible:=Trim(dcmbTipoAbbattimento.Text) <> '';
  Abilitazioni;
end;

procedure TA162FIncentiviAssenze.dcmbTipoAbbattimentoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbTipoAbbattimentoCloseUp(nil);
end;

procedure TA162FIncentiviAssenze.dcmbTipoAccorpCausaliCloseUp(Sender: TObject);
begin
  inherited;
  dlblDescTipoAccorp.Visible:=Trim(dcmbTipoAccorpCausali.Text) <> '';
  A162FIncentiviAssenzeDtM.A162FIncentiviAssenzeMW.ImpostaTipoSelT256(Trim(dcmbTipoAccorpCausali.Text));
  //resetto valore di dcmbCodiciAccorpCausali. agisco su campo perchè data-aware
  if oldTipoAccorp <> dcmbTipoAccorpCausali.Text then
  begin
    if A162FIncentiviAssenzeDtM.selT769.State in [dsEdit, dsInsert] then
    begin
      A162FIncentiviAssenzeDtM.selT769.FieldByName('COD_CODICIACCORPCAUSALI').AsString:='';
      dcmbCodiciAccorpCausaliCloseUp(nil);
    end;
  end;
  oldTipoAccorp:=dcmbTipoAccorpCausali.Text;
end;

procedure TA162FIncentiviAssenze.dcmbTipoAccorpCausaliKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbTipoAccorpCausaliCloseUp(nil);
end;

procedure TA162FIncentiviAssenze.dedtDecorrenzaExit(Sender: TObject);
var
  sTmp: String;
begin
  inherited;
  with A162FIncentiviAssenzeDtM do
  begin
    if selT769.State in [dsEdit,dsInsert] then
    begin
      A162FIncentiviAssenzeMW.ImpostaDecorrenzaDatasetLookup;
      //reimposto campi per forzare reload del campo di lookup
      sTmp:=selT769.FieldByName('DATO1').AsString;
      selT769.FieldByName('DATO1').AsString:='';
      selT769.FieldByName('DATO1').AsString:=sTmp;
      sTmp:=selT769.FieldByName('DATO2').AsString;
      selT769.FieldByName('DATO2').AsString:='';
      selT769.FieldByName('DATO2').AsString:=sTmp;

      sTmp:=selT769.FieldByName('DATO3').AsString;
      selT769.FieldByName('DATO3').AsString:='';
      selT769.FieldByName('DATO3').AsString:=sTmp;
    end;
  end;
end;

procedure TA162FIncentiviAssenze.dedtFranchigiaExit(Sender: TObject);
begin
  inherited;
  if DButton.State = dsBrowse then
    Exit;
  if A162FIncentiviAssenzeDtM.selT769.FieldByName('FRANCHIGIA_ASSENZE').AsFloat = 0 then
  begin
    A162FIncentiviAssenzeDtM.selT769.FieldByName('PERC_ABB_FRANCHIGIA').AsFloat:=100;
    A162FIncentiviAssenzeDtM.selT769.FieldByName('ASSENZE_AGGIUNTIVE').AsString:='';
    dedtPercAbbFranc.Enabled:=False;
    lblPercAbbFranc.Enabled:=False;
    lblAssenzeAgg.Enabled:=False;
    dedtAssenzeAgg.Enabled:=False;
    btnAssenzeAgg.Enabled:=False;
    dchkPropFranchigia.Enabled:=False;
  end
  else
  begin
    dedtPercAbbFranc.Enabled:=True;
    lblPercAbbFranc.Enabled:=True;
    dedtPercAbbFranc.SetFocus;
    lblAssenzeAgg.Enabled:=True;
    dedtAssenzeAgg.Enabled:=True;
    btnAssenzeAgg.Enabled:=True;
    dchkPropFranchigia.Enabled:=True;
    if A162FIncentiviAssenzeDtM.selT769.FieldByName('GESTIONE_FRANCHIGIA').AsString = 'R' then
    begin
      A162FIncentiviAssenzeDtM.selT769.FieldByName('TIPO_ABBATTIMENTO').AsString:='';
      dcmbTipoAbbattimentoCloseUp(nil);
    end;
  end;
end;

procedure TA162FIncentiviAssenze.drdgGestioneFranchigiaClick(Sender: TObject);
begin
  inherited;
  Abilitazioni;
end;

procedure TA162FIncentiviAssenze.FormShow(Sender: TObject);
begin
  inherited;
  if Parametri.CampiRiferimento.C7_Dato1 <> '' then
  begin
    lblDato1.Caption:='Codice ' + Parametri.CampiRiferimento.C7_Dato1;
    dgrdAbbattimenti.Columns[0].Title.Caption:=UpperCase(Copy(Parametri.CampiRiferimento.C7_Dato1,1,1)) +
                                          LowerCase(Copy(Parametri.CampiRiferimento.C7_Dato1,2,length(Parametri.CampiRiferimento.C7_Dato1)));
  end
  else
  begin
    lblDato1.Caption:='Dato 1 non definito';
    lblDato1.Enabled:=False;
    dcmbDato1.Enabled:=False;
    dgrdAbbattimenti.Columns[0].Visible:=False;
  end;

  if Parametri.CampiRiferimento.C7_Dato2 <> '' then
  begin
    lblDato2.Caption:='Codice ' + Parametri.CampiRiferimento.C7_Dato2;
    dgrdAbbattimenti.Columns[1].Title.Caption:=UpperCase(Copy(Parametri.CampiRiferimento.C7_Dato2,1,1)) +
                                          LowerCase(Copy(Parametri.CampiRiferimento.C7_Dato2,2,length(Parametri.CampiRiferimento.C7_Dato2)))
  end
  else
  begin
    lblDato2.Caption:='Dato 2 non definito';
    lblDato2.Enabled:=False;
    dcmbDato2.Enabled:=False;
    dgrdAbbattimenti.Columns[1].Visible:=False;
  end;

  if Parametri.CampiRiferimento.C7_Dato3 <> '' then
  begin
    lblDato3.Caption:='Codice ' + Parametri.CampiRiferimento.C7_Dato3;
    dgrdAbbattimenti.Columns[2].Title.Caption:=UpperCase(Copy(Parametri.CampiRiferimento.C7_Dato3,1,1)) +
                                          LowerCase(Copy(Parametri.CampiRiferimento.C7_Dato3,2,length(Parametri.CampiRiferimento.C7_Dato3)));
  end
  else
  begin
    lblDato3.Caption:='Dato 3 non definito';
    lblDato3.Enabled:=False;
    dcmbDato3.Enabled:=False;
    dgrdAbbattimenti.Columns[2].Visible:=False;
  end;

  VisioneCorrente1Click(nil);
end;

procedure TA162FIncentiviAssenze.Nuovoelemento1Click(Sender: TObject);
begin
  inherited;
  if PopupMenu1.PopupComponent = dcmbTipoAbbattimento then
  begin
    OpenA161TipoAbbattimenti;
    A162FIncentiviAssenzeDtM.A162FIncentiviAssenzeMW.selT766.Refresh;
  end
  else
  begin
    OpenA150AccorpamentoCausali(dcmbTipoAccorpCausali.Text,dcmbCodiciAccorpCausali.Text);
    A162FIncentiviAssenzeDtM.A162FIncentiviAssenzeMW.selT256.Refresh;
  end;
end;

procedure TA162FIncentiviAssenze.sbtDecorrenzaFineClick(Sender: TObject);
begin
  inherited;
  with A162FIncentiviAssenzeDtM do
  begin
    if selT769.FieldByName('DECORRENZA_FINE').IsNull then
      selT769.FieldByName('DECORRENZA_FINE').AsDateTime:=Parametri.DataLavoro;
    selT769.FieldByName('DECORRENZA_FINE').AsDateTime:=DataOut(selT769.FieldByName('DECORRENZA_FINE').AsDateTime,'Data fine','G');
  end;
end;

procedure TA162FIncentiviAssenze.TAnnullaClick(Sender: TObject);
begin
  inherited;
  actRefresh.Execute;
end;

procedure TA162FIncentiviAssenze.TInserClick(Sender: TObject);
begin
  inherited;
  dCmbDato1.SetFocus;
end;

end.
