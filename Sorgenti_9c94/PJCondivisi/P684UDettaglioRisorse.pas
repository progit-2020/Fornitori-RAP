unit P684UDettaglioRisorse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  StdCtrls, Buttons, DBCtrls, Mask, ExtCtrls, Oracle, OracleData,
  A000UCostanti, A000USessione, A000UInterfaccia, A003UDataLavoroBis, C180FunzioniGenerali, C600USelAnagrafe;

type
  TP684FDettaglioRisorse = class(TR001FGestTab)
    Panel3: TPanel;
    lblAnno: TLabel;
    lblFondo: TLabel;
    lblCodTabella: TLabel;
    edtFondo: TEdit;
    edtDecorrenza: TEdit;
    Panel2: TPanel;
    lblCodVoceDett: TLabel;
    Label1: TLabel;
    lblCodVoceGen: TLabel;
    dtxtCodVoceGen: TDBText;
    dedtCodVoceGen: TDBEdit;
    dcmbCodVoceGen: TDBLookupComboBox;
    lblDataRif: TLabel;
    lblQuantita: TLabel;
    lblDatoBase: TLabel;
    lblMoltiplicatore: TLabel;
    lblImporto: TLabel;
    lblArrotondamento: TLabel;
    btnDataRif: TBitBtn;
    dedtDataRif: TDBEdit;
    dedtQuantita: TDBEdit;
    dedtDatoBase: TDBEdit;
    dedtMoltiplicatore: TDBEdit;
    dedtImporto: TDBEdit;
    dCmbArrotondamento: TDBLookupComboBox;
    dmemDescrizione: TDBMemo;
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    procedure FormShow(Sender: TObject);
    procedure dcmbCodVoceGenKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dcmbCodVoceGenCloseUp(Sender: TObject);
    procedure dcmbCodVoceGenKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDataRifClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure dedtQuantitaExit(Sender: TObject);
    procedure dedtDatoBaseExit(Sender: TObject);
    procedure dedtMoltiplicatoreExit(Sender: TObject);
    procedure dCmbArrotondamentoCloseUp(Sender: TObject);
    procedure dCmbArrotondamentoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TC600frmSelAnagrafe1btnSelezioneClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FondoElab:String;
    DataElab,DataRif:TDateTime;
  end;

var
  P684FDettaglioRisorse: TP684FDettaglioRisorse;

  procedure OpenP684DettaglioRisorse(Fondo:String;Dec:TDateTime);

implementation

uses P684UDefinizioneFondiDtM, P684UDataRif;

{$R *.dfm}

procedure OpenP684DettaglioRisorse(Fondo:String;Dec:TDateTime);
begin
  Application.CreateForm(TP684FDettaglioRisorse,P684FDettaglioRisorse);
  with P684FDettaglioRisorse do
  try
    DataElab:=Dec;
    FondoElab:=Fondo;
    ShowModal;
  finally
    FreeAndNil(P684FDettaglioRisorse);
  end;
end;

procedure TP684FDettaglioRisorse.btnDataRifClick(Sender: TObject);
begin
  inherited;
  with P684FDefinizioneFondiDtM do
  begin
    if selP688R.FieldByName('DATA_RIFERIMENTO').IsNull then
      selP688R.FieldByName('DATA_RIFERIMENTO').AsDateTime:=Parametri.DataLavoro;
    selP688R.FieldByName('DATA_RIFERIMENTO').AsDateTime:=DataOut(selP688R.FieldByName('DATA_RIFERIMENTO').AsDateTime,'Data riferimento','G');
  end;
end;

procedure TP684FDettaglioRisorse.DButtonStateChange(Sender: TObject);
begin
  inherited;
  btnDataRif.Enabled:=DButton.State in [dsEdit,dsInsert];
  C600frmSelAnagrafe.btnSelezione.Enabled:=DButton.State in [dsEdit,dsInsert];
end;

procedure TP684FDettaglioRisorse.dCmbArrotondamentoCloseUp(Sender: TObject);
begin
  inherited;
  if (DButton.State <> dsEdit) and (DButton.State <> dsInsert) then
    Exit;
  with P684FDefinizioneFondiDtM do
  begin
    if selP688R.FieldByName('COD_ARROTONDAMENTO').AsString <> '' then
    begin
      if selP050.SearchRecord('Cod_Arrotondamento',selP688R.FieldByName('COD_ARROTONDAMENTO').AsString,[srFromBeginning]) and
        (selP688R.FieldByName('IMPORTO').AsFloat <> 0) then
        selP688R.FieldByName('IMPORTO').AsFloat:=
          R180Arrotonda(selP688R.FieldByName('IMPORTO').AsFloat,selP050.FieldByName('VALORE').AsFloat,selP050.FieldByName('TIPO').AsString);
    end;
  end;
end;

procedure TP684FDettaglioRisorse.dCmbArrotondamentoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbArrotondamentoCloseUp(nil);
end;

procedure TP684FDettaglioRisorse.dcmbCodVoceGenCloseUp(Sender: TObject);
begin
  inherited;
  dtxtCodVoceGen.Visible:=Trim(dcmbCodVoceGen.Text) <> '';
end;

procedure TP684FDettaglioRisorse.dcmbCodVoceGenKeyDown(Sender: TObject;
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

procedure TP684FDettaglioRisorse.dcmbCodVoceGenKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbCodVoceGenCloseUp(nil);
end;

procedure TP684FDettaglioRisorse.dedtDatoBaseExit(Sender: TObject);
begin
  inherited;
  with P684FDefinizioneFondiDtM do
  begin
    dedtImporto.ReadOnly:=False;
    if (not selP688R.FieldByName('QUANTITA').IsNull) or (not selP688R.FieldByName('DATOBASE').IsNull) or
       (not selP688R.FieldByName('MOLTIPLICATORE').IsNull) then
      dedtImporto.ReadOnly:=True;
    if (DButton.State <> dsEdit) and (DButton.State <> dsInsert) then
      Exit;
    if (not selP688R.FieldByName('DATOBASE').IsNull) and (selP688R.FieldByName('MOLTIPLICATORE').IsNull) then
      selP688R.FieldByName('MOLTIPLICATORE').AsFloat:=1;
    selP688R.FieldByName('IMPORTO').AsFloat:=selP688R.FieldByName('QUANTITA').AsFloat *
      selP688R.FieldByName('DATOBASE').AsFloat * selP688R.FieldByName('MOLTIPLICATORE').AsFloat;
    if selP688R.FieldByName('COD_ARROTONDAMENTO').AsString <> '' then
    begin
      if selP050.SearchRecord('Cod_Arrotondamento',selP688R.FieldByName('COD_ARROTONDAMENTO').AsString,[srFromBeginning]) and
        (selP688R.FieldByName('IMPORTO').AsFloat <> 0) then
        selP688R.FieldByName('IMPORTO').AsFloat:=
          R180Arrotonda(selP688R.FieldByName('IMPORTO').AsFloat,selP050.FieldByName('VALORE').AsFloat,selP050.FieldByName('TIPO').AsString);
    end;
  end;
end;

procedure TP684FDettaglioRisorse.dedtMoltiplicatoreExit(Sender: TObject);
begin
  inherited;
  with P684FDefinizioneFondiDtM do
  begin
    dedtImporto.ReadOnly:=False;
    if (not selP688R.FieldByName('QUANTITA').IsNull) or (not selP688R.FieldByName('DATOBASE').IsNull) or
       (not selP688R.FieldByName('MOLTIPLICATORE').IsNull) then
      dedtImporto.ReadOnly:=True;
    if (DButton.State <> dsEdit) and (DButton.State <> dsInsert) then
      Exit;
    selP688R.FieldByName('IMPORTO').AsFloat:=selP688R.FieldByName('QUANTITA').AsFloat *
      selP688R.FieldByName('DATOBASE').AsFloat * selP688R.FieldByName('MOLTIPLICATORE').AsFloat;
    if selP688R.FieldByName('COD_ARROTONDAMENTO').AsString <> '' then
    begin
      if selP050.SearchRecord('Cod_Arrotondamento',selP688R.FieldByName('COD_ARROTONDAMENTO').AsString,[srFromBeginning]) and
        (selP688R.FieldByName('IMPORTO').AsFloat <> 0) then
        selP688R.FieldByName('IMPORTO').AsFloat:=
          R180Arrotonda(selP688R.FieldByName('IMPORTO').AsFloat,selP050.FieldByName('VALORE').AsFloat,selP050.FieldByName('TIPO').AsString);
    end;
  end;
end;

procedure TP684FDettaglioRisorse.dedtQuantitaExit(Sender: TObject);
begin
  inherited;
  with P684FDefinizioneFondiDtM do
  begin
    dedtImporto.ReadOnly:=False;
    if (not selP688R.FieldByName('QUANTITA').IsNull) or (not selP688R.FieldByName('DATOBASE').IsNull) or
       (not selP688R.FieldByName('MOLTIPLICATORE').IsNull) then
      dedtImporto.ReadOnly:=True;
    if (DButton.State <> dsEdit) and (DButton.State <> dsInsert) then
      Exit;
    if (not selP688R.FieldByName('QUANTITA').IsNull) and (selP688R.FieldByName('MOLTIPLICATORE').IsNull) then
      selP688R.FieldByName('MOLTIPLICATORE').AsFloat:=1;
    selP688R.FieldByName('IMPORTO').AsFloat:=selP688R.FieldByName('QUANTITA').AsFloat *
      selP688R.FieldByName('DATOBASE').AsFloat * selP688R.FieldByName('MOLTIPLICATORE').AsFloat;
    if selP688R.FieldByName('COD_ARROTONDAMENTO').AsString <> '' then
    begin
      if selP050.SearchRecord('Cod_Arrotondamento',selP688R.FieldByName('COD_ARROTONDAMENTO').AsString,[srFromBeginning]) and
        (selP688R.FieldByName('IMPORTO').AsFloat <> 0) then
        selP688R.FieldByName('IMPORTO').AsFloat:=
          R180Arrotonda(selP688R.FieldByName('IMPORTO').AsFloat,selP050.FieldByName('VALORE').AsFloat,selP050.FieldByName('TIPO').AsString);
    end;
  end;
end;

procedure TP684FDettaglioRisorse.FormDestroy(Sender: TObject);
begin
  inherited;
  C600frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TP684FDettaglioRisorse.FormShow(Sender: TObject);
begin
  inherited;
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=False;
  with P684FDefinizioneFondiDtM do
  begin
    DButton.DataSet:=selP688R;
    edtDecorrenza.Text:=DateToStr(DataElab);
    edtFondo.Text:=FondoElab;
    lblFondo.Caption:=VarToStr(selP684.Lookup('DECORRENZA_DA;COD_FONDO',VarArrayOf([DataElab,FondoElab]),'DESCRIZIONE'));
  end;
end;

procedure TP684FDettaglioRisorse.TC600frmSelAnagrafe1btnSelezioneClick(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TP684FDataRif,P684FDataRif);
  try
    if P684FDataRif.ShowModal = mrOK then
    begin
      C600frmSelAnagrafe.C600DataLavoro:=DataRif;
      C600frmSelAnagrafe.btnSelezioneClick(Sender);
      if C600frmSelAnagrafe.C600ModalResult = mrOK then
      begin
        C600frmSelAnagrafe.C600SelAnagrafe.Close;
        C600frmSelAnagrafe.C600SelAnagrafe.Open;
        P684FDefinizioneFondiDtM.selP688R.FieldByName('QUANTITA').AsFloat:=C600frmSelAnagrafe.C600SelAnagrafe.RecordCount;
      end;
    end;
  finally
    FreeAndNil(P684FDataRif);
  end;
end;

end.
