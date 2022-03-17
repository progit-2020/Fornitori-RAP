unit W036UEsperienzeFM;

interface

uses
  SysUtils, Classes, Controls, Forms, IWAppForm,
  IWVCLBaseContainer, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWCompButton, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWTypes, DBClient, IWDBGrids,
  DB, Oracle, StrUtils, Variants, OracleData, WR010UBase,
  A000UInterfaccia, C180FunzioniGenerali, C190FunzioniGeneraliWeb, R010UPAGINAWEB,
  W036UTraspDirigenzaDM,
  medpIWDBGrid, meIWMemo, medpIWMessageDlg, meIWButton, IWCompJQueryWidget, meIWImageFile,
  IWCompGrids, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit, IWCompMemo,
  IWDBStdCtrls, meIWDBEdit, meIWDBMemo, IWApplication, IWCompExtCtrls,
  medpIWImageButton, TypInfo, WR200UBaseFM, UIntfWebT480;

type
  W036AbilitaJQ = procedure(Val:Boolean) of object;

  TW036FEsperienzeFM = class(TWR200FBaseFM)
    lblDal: TmeIWLabel;
    dedtDal: TmeIWDBEdit;
    lblAl: TmeIWLabel;
    dedtAl: TmeIWDBEdit;
    lblTipoAmm: TmeIWLabel;
    dedtTipoAmm: TmeIWDBEdit;
    lblAmm: TmeIWLabel;
    dedtAmm: TmeIWDBEdit;
    lblDComune: TmeIWLabel;
    btnSelComune: TmeIWButton;
    lblSitoWeb: TmeIWLabel;
    dedtSitoWeb: TmeIWDBEdit;
    lblTelUfficio: TmeIWLabel;
    dedtTelUfficio: TmeIWDBEdit;
    lblFaxUfficio: TmeIWLabel;
    dedtFaxUfficio: TmeIWDBEdit;
    lblEmailUfficio: TmeIWLabel;
    dedtEmailUfficio: TmeIWDBEdit;
    lblQualifica: TmeIWLabel;
    dedtQualifica: TmeIWDBEdit;
    lblRuolo: TmeIWLabel;
    dedtRuolo: TmeIWDBEdit;
    lblUniOrg: TmeIWLabel;
    dedtUniOrg: TmeIWDBEdit;
    lblTesto: TmeIWLabel;
    dmemTesto: TmeIWDBMemo;
    DataSourceEsp: TDataSource;
    edtDComune: TmeIWEdit;
    btnModifica: TmedpIWImageButton;
    btnConferma: TmedpIWImageButton;
    btnAnnulla: TmedpIWImageButton;
    btnChiudi: TmedpIWImageButton;
    edtDProvincia: TmeIWEdit;
    lblDProvincia: TmeIWLabel;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure edtDComuneAsyncExit(Sender: TObject; EventParams: TStringList);
    procedure btnModificaClick(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
  private
    IncaricoAttuale: Boolean;
    IntfWebT480:TIntfWebT480;
    procedure ImpostaLabel;
    procedure AbilitaComponenti;
    procedure ResultComune;
  public
    DataSetEsp:TOracleDataSet;
    ReadOnly: Boolean;
    W036DM2:TW036FTraspDirigenzaDM;
    AzioneRichiamo:String;
    evtAbilitaJQ: W036AbilitaJQ;
    procedure Apri;
    procedure Visualizza;
  end;

implementation

uses W036UTraspDirigenza;

{$R *.dfm}

procedure TW036FEsperienzeFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=TIWAppForm(Self.Owner);
end;

procedure TW036FEsperienzeFM.Apri;
begin
  IntfWebT480:=TIntfWebT480.Create(Self.Parent);
  with IntfWebT480 do
  begin
    DataSource:=W036DM2.dsrQ480;
    edtCitta:=edtDComune;
    edtProvincia:=edtDProvincia;
    btnLookup:=btnSelComune;
    CustomResultLookup:=ResultComune;
  end;
  DataSourceEsp.DataSet:=DataSetEsp;
  IncaricoAttuale:=DataSetEsp = W036DM2.selSG210a;
  if AzioneRichiamo = 'M' then
    DataSetEsp.Edit
  else if AzioneRichiamo = 'I' then
    DataSetEsp.Append;
  ImpostaLabel;
  AbilitaComponenti;
end;

procedure TW036FEsperienzeFM.ImpostaLabel;
begin
  lblDal.Caption:=DataSetEsp.FieldByName('DECORRENZA').DisplayLabel;
  lblAl.Caption:=DataSetEsp.FieldByName('DECORRENZA_FINE').DisplayLabel;
  lblTipoAmm.Caption:=DataSetEsp.FieldByName('TIPO_AMMINISTRAZIONE').DisplayLabel;
  lblAmm.Caption:=DataSetEsp.FieldByName('AMMINISTRAZIONE').DisplayLabel;
  lblDComune.Caption:=DataSetEsp.FieldByName('D_COMUNE').DisplayLabel;
  lblDProvincia.Caption:=DataSetEsp.FieldByName('D_PROVINCIA').DisplayLabel;
  lblSitoWeb.Caption:=DataSetEsp.FieldByName('SITO_WEB').DisplayLabel;
  lblTelUfficio.Caption:=DataSetEsp.FieldByName('TEL_UFFICIO').DisplayLabel;
  lblFaxUfficio.Caption:=DataSetEsp.FieldByName('FAX_UFFICIO').DisplayLabel;
  lblEmailUfficio.Caption:=DataSetEsp.FieldByName('EMAIL_UFFICIO').DisplayLabel;
  lblQualifica.Caption:=DataSetEsp.FieldByName('QUALIFICA').DisplayLabel;
  lblRuolo.Caption:=DataSetEsp.FieldByName('RUOLO').DisplayLabel;
  lblUniOrg.Caption:=DataSetEsp.FieldByName('UNITA_ORGANIZZATIVA').DisplayLabel;
  lblTesto.Caption:=DataSetEsp.FieldByName('TESTO').DisplayLabel;
end;

procedure TW036FEsperienzeFM.AbilitaComponenti;
begin
  AbilitaComponentiRegion(IWFrameRegion,DataSetEsp);
  dedtAl.Visible:=not IncaricoAttuale;
  lblAl.Visible:=dedtAl.Visible;
  btnModifica.Visible:=not ReadOnly and (DataSetEsp.State = dsBrowse);
  if btnModifica.Visible then
    btnModifica.Enabled:=True;
  btnConferma.Visible:=DataSetEsp.State <> dsBrowse;
  if btnConferma.Visible then
    btnConferma.Enabled:=True;
  btnAnnulla.Visible:=DataSetEsp.State <> dsBrowse;
  if btnAnnulla.Visible then
    btnAnnulla.Enabled:=True;
  btnChiudi.Visible:=DataSetEsp.State = dsBrowse;
  if btnChiudi.Visible then
    btnChiudi.Enabled:=True;
  edtDComune.Text:=DataSetEsp.FieldByName('D_COMUNE').AsString;
  edtDProvincia.Text:=DataSetEsp.FieldByName('D_PROVINCIA').AsString;
  edtDProvincia.ReadOnly:=True;
  evtAbilitaJQ(DataSetEsp.State <> dsBrowse);
end;

procedure TW036FEsperienzeFM.Visualizza;
var Titolo:String;
begin
  Titolo:=IfThen(DataSetEsp.State = dsInsert,'Inserimento ',IfThen(DataSetEsp.State = dsEdit,'Modifica ','Visualizzazione '))
        + IfThen(IncaricoAttuale,'Incarico attuale','Esperienze precedenti') + ' di '
        + W036DM2.selAnagrafeW.FieldByName('COGNOME').AsString + ' '
        + W036DM2.selAnagrafeW.FieldByName('NOME').AsString + ' ('
        + W036DM2.selAnagrafeW.FieldByName('MATRICOLA').AsString + ')';
  (Self.Parent as TWR010FBase).VisualizzajQMessaggio(JQuery,690,-1,EM2PIXEL * 24,Titolo,'#' + Self.Name,False,True);
end;

procedure TW036FEsperienzeFM.edtDComuneAsyncExit(Sender: TObject; EventParams: TStringList);
begin
  if edtDComune.Text <> DataSetEsp.FieldByName('D_COMUNE').AsString then
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnSelComune.HTMLName]));
end;

procedure TW036FEsperienzeFM.ResultComune;
begin
  DataSetEsp.FieldByName('COMUNE').AsString:=IntfWebT480.ValoreChiave;
  AbilitaComponenti;
end;

procedure TW036FEsperienzeFM.btnModificaClick(Sender: TObject);
begin
  DataSetEsp.Edit;
  AbilitaComponenti;
end;

procedure TW036FEsperienzeFM.btnConfermaClick(Sender: TObject);
var Inserimento:Boolean;
begin
  DataSetEsp.FieldByName('TESTO').AsString:=Copy(R180SostituisciCaratteriSpeciali(Trim(DataSetEsp.FieldByName('TESTO').AsString)),1,1000);
  Inserimento:=DataSetEsp.State = dsInsert;
  DataSetEsp.Post;
  if not IncaricoAttuale then
    W036DM2.EspPrecRowid:=DataSetEsp.RowId
  else if Inserimento then
    with W036DM2.updSG210a do
    begin
      SetVariable('PROGRESSIVO',DataSetEsp.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('DECORRENZA_FINE',DataSetEsp.FieldByName('DECORRENZA').AsDateTime - 1);
      SetVariable('IDRIGA',DataSetEsp.RowId);
      Execute;
      SessioneOracle.Commit;
      //Chiudo il dataset delle esperienze precedenti per refresh
      W036DM2.selSG210b.Close;
    end;
  //Chiudo il dataset corrente per refresh
  DataSetEsp.Close;
  (Self.Owner as TW036FTraspDirigenza).GetCurriculum;
  if AzioneRichiamo = 'A' then
    AbilitaComponenti
  else
    btnChiudiClick(nil);
end;

procedure TW036FEsperienzeFM.btnAnnullaClick(Sender: TObject);
begin
  DataSetEsp.Cancel;
  if AzioneRichiamo = 'A' then
    AbilitaComponenti
  else
    btnChiudiClick(nil);
end;

procedure TW036FEsperienzeFM.btnChiudiClick(Sender: TObject);
begin
  FreeAndNil(IntfWebT480);
  Free;
end;

end.
