unit WA004URecapitoVisFiscaliFM;

interface

uses
  WR200UBaseFM, A004UGiustifAssPresMW, A000UInterfaccia, A000UMessaggi,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, UIntfWebT480,
  Controls, medpIWMessageDlg, DB, IWApplication, StrUtils,
  Windows, SysUtils, Variants, Classes, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWCompEdit, meIWEdit, medpIWMultiColumnComboBox,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel,
  meIWLabel, IWCompMemo, meIWMemo, IWCompListbox, IWDBStdCtrls,
  meIWDBLookupComboBox, IWCompButton, meIWButton, IWHTMLControls, meIWLink,
  Forms, IWCompExtCtrls, meIWImageFile, medpIWImageButton;

type
  TWA004FRecapitoVisFiscaliFM = class(TWR200FBaseFM)
    lblDomicilio: TmeIWLabel;
    lblCap: TmeIWLabel;
    edtCap: TmeIWEdit;
    lblTelefono: TmeIWLabel;
    edtTelefono: TmeIWEdit;
    lblIndirizzo: TmeIWLabel;
    edtIndirizzo: TmeIWEdit;
    lblNote: TmeIWLabel;
    memNote: TmeIWMemo;
    lblGrpMedLegale: TmeIWLabel;
    lblMedLegale: TmeIWLabel;
    lblDescrizione: TmeIWLabel;
    btnOK: TmeIWButton;
    btnAnnulla: TmeIWButton;
    cmbMedLegale: TMedpIWMultiColumnComboBox;
    lblDescMedLegale: TmeIWLabel;
    lnkComune: TmeIWLink;
    edtComune: TmeIWEdit;
    btnSelComune: TmeIWButton;
    imgGomma: TmeIWImageFile;
    lblDataEsenzione: TmeIWLabel;
    edtDataEsenzione: TmeIWEdit;
    lblOperatoreEsenzione: TmeIWLabel;
    edtOperatoreEsenzione: TmeIWEdit;
    lblTipoEsenzione: TmeIWLabel;
    lblEsenzione: TmeIWLabel;
    cmbTipoEsenzione: TMedpIWMultiColumnComboBox;
    procedure btnOKClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure cmbMedLegaleAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure imgGommaAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure cmbTipoEsenzioneAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    FMedLegaleTemp: String;
    FCodComune: String;
    FDesComune: String;
    FIndirizzo: String;
    FCap: String;
    FTelefono: String;
    FMedLegale: String;
    FNote: String;
    FTipoEsenzione: String;
    FOperatoreEsenzione: String;
    FDataEsenzione:TDateTime;
    FA004MW: TA004FGiustifAssPresMW;
    IntfWebT480:TIntfWebT480;
    procedure SetA004MW(Val: TA004FGiustifAssPresMW);
    procedure PopolaComboMedicineLegali;
    procedure PopolaComboEsenzioni;
    procedure ResultComune;
    procedure OnConfermaMessaggio(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure OnConfermaSovrascriviMedLeg(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
  public
    Prog: Integer;
    DataInizio: TDateTime;
    //A004MW: TA004FGiustifAssPresMW;
    procedure Visualizza;
    procedure ReleaseOggetti; override;
    property A004MW: TA004FGiustifAssPresMW read FA004MW write SetA004MW;
  end;

implementation

uses WR010UBase;

{$R *.dfm}

procedure TWA004FRecapitoVisFiscaliFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  IntfWebT480:=TIntfWebT480.Create(Self.Parent);
  with IntfWebT480 do
  begin
    Titolo:='Scelta comune per visite fiscali';
    if A004MW <> nil then
      DataSource:=A004MW.dsrQ480;
    edtCitta:=edtComune;
    edtCap:=Self.edtCap;
    btnLookup:=btnSelComune;
    CustomResultLookup:=ResultComune;
  end;
end;

procedure TWA004FRecapitoVisFiscaliFM.SetA004MW(Val: TA004FGiustifAssPresMW);
begin
  FA004MW:=Val;
  IntfWebT480.DataSource:=FA004MW.dsrQ480;
end;

procedure TWA004FRecapitoVisFiscaliFM.Visualizza;
var
  scriptJs:string;
begin
  PopolaComboMedicineLegali;
  PopolaComboEsenzioni;

  // imposta i dati del domicilio alternativo
  with A004MW do
  begin
    FCodComune:=RecapitoAlternativo.CodComune;
    FDesComune:=RecapitoAlternativo.DescComune;
    FCap:=RecapitoAlternativo.Cap;
    FIndirizzo:=RecapitoAlternativo.Indirizzo;
    FTelefono:=RecapitoAlternativo.Telefono;
    FMedLegale:=RecapitoAlternativo.MedLegale;
    FMedLegaleTemp:='';
    FNote:=RecapitoAlternativo.Note;
    FTipoEsenzione:=RecapitoAlternativo.TipoEsenzione;
    FDataEsenzione:=RecapitoAlternativo.DataEsenzione;
    FOperatoreEsenzione:=RecapitoAlternativo.OperatoreEsenzione;

    selT047.Close;
    selT047.SetVariable('PROGRESSIVO',Self.Prog);
    selT047.SetVariable('DATA_INIZIO',Self.DataInizio);
    selT047.Open;

    if selT047.RecordCount > 0 then
    begin
      edtComune.Enabled:=selT047.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull;
      btnSelComune.Enabled:=selT047.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull;
      imgGomma.Enabled:=selT047.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull;
      edtCap.Enabled:=selT047.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull;
      edtIndirizzo.Enabled:=selT047.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull;
      edtTelefono.Enabled:=selT047.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull;
      cmbMedLegale.Enabled:=selT047.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull;
      memNote.Enabled:=selT047.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull;
      cmbTipoEsenzione.Enabled:=selT047.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull;
      if not selT047.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull then
        GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_A004_MSG_RECAPITO_NON_MODIF));
      FCodComune:=selT047.FieldByName('COD_COMUNE').AsString;
      FDesComune:=seLT047.FieldByName('CITTA').AsString;
      FCap:=selT047.FieldByName('CAP').AsString;
      FIndirizzo:=selT047.FieldByName('INDIRIZZO').AsString;
      FTelefono:=selT047.FieldByName('TELEFONO').AsString;
      FMedLegale:=selT047.FieldByName('MEDICINA_LEGALE').AsString;
      FNote:=selt047.FieldByName('NOTE').AsString;
      FTipoEsenzione:=selt047.FieldByName('TIPO_ESENZIONE').AsString;
      FDataEsenzione:=selt047.FieldByName('DATA_ESENZIONE').AsDateTime;
      FOperatoreEsenzione:=selt047.FieldByName('OPERATORE').AsString;
    end;
  end;
  edtComune.Text:=FDesComune;
  edtCap.Text:=FCap;
  edtIndirizzo.Text:=FIndirizzo;
  edtTelefono.Text:=FTelefono;
  cmbMedLegale.Text:=FMedLegale;
  cmbMedLegaleAsyncChange(cmbMedLegale,nil,0,''); //***
  memNote.Lines.Text:=FNote;
  cmbTipoEsenzione.Text:=FTipoEsenzione;
  edtDataEsenzione.Text:=IfThen(FDataEsenzione <> 0,FormatDateTime('dd/mm/yyyy',FDataEsenzione),'');
  edtOperatoreEsenzione.Text:=FOperatoreEsenzione;
  // visualizza in jquery modal dialog
  (Self.Parent as TWR010FBase).VisualizzaJQMessaggio(jQuery,570,-1,EM2PIXEL * 30,'Recapito alternativo per visite fiscali','#wa004_container',False,True);
  C190VisualizzaGroupBox(JQuery,'grpInsManualeINPS',Parametri.ModuloInstallato['TORINO_CSI_PRV']);
end;

procedure TWA004FRecapitoVisFiscaliFM.ResultComune;
begin
  FCodComune:=IntfWebT480.ValoreChiave;
  edtIndirizzo.SetFocus;
  // controlla se il comune è associato ad una medicina legale
  FMedLegaleTemp:=A004MW.EstraiMedLeg(FCodComune);
  if (FMedLegaleTemp <> '') and
     (cmbMedLegale.Text <> '') and
     (cmbMedLegale.Text <> FMedLegaleTemp) then
  begin
    // medicina legale non indicata -> richiede impostazione automatica
    if not MsgBox.KeyExists('MED_LEG_OVERWRITE') then
    begin
      MsgBox.WebMessageDlg(Format(A000TraduzioneStringhe(A000MSG_A004_DLG_FMT_SOVRASCRIVI_MED_LEG),[edtComune.Text]),mtConfirmation,[mbYes,mbNo],OnConfermaSovrascriviMedLeg,'MED_LEG_OVERWRITE');
      Exit;
    end;
  end;
  cmbMedLegale.Text:=FMedLegaleTemp;
  cmbMedLegaleAsyncChange(cmbMedLegale,nil,0,''); //***
end;

procedure TWA004FRecapitoVisFiscaliFM.OnConfermaSovrascriviMedLeg(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
// sovrascrittura medicina legale dopo selezione comune
begin
  if Res = mrYes then
  begin
    cmbMedLegale.Text:=FMedLegaleTemp;
    cmbMedLegaleAsyncChange(cmbMedLegale,nil,0,''); //***
  end;
end;

procedure TWA004FRecapitoVisFiscaliFM.PopolaComboMedicineLegali;
var
  BM: TBookmark;
begin
  cmbMedLegale.Items.Clear;
  with A004MW.selT485 do
  begin
    if Active then
    begin
      // popola la combo delle causali
      BM:=GetBookmark;
      First;
      while not Eof do
      begin
        cmbMedLegale.AddRow(Format('%s;%s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
        Next;
      end;
      if BookmarkValid(BM) then
        GotoBookmark(BM)
      else
        First;
    end;
  end;
end;

procedure TWA004FRecapitoVisFiscaliFM.PopolaComboEsenzioni;
begin
  cmbTipoEsenzione.Items.Clear;
  with A004MW.selT047Esenzioni do
  begin
    Close;
    Open;
    while not Eof do
    begin
      cmbTipoEsenzione.AddRow(FieldByName('TIPO_ESENZIONE').AsString);
      Next;
    end;
  end;
end;

procedure TWA004FRecapitoVisFiscaliFM.cmbMedLegaleAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  if A004MW.selT485.Locate('CODICE',cmbMedLegale.Text,[]) then
    lblDescMedLegale.Caption:=A004MW.selT485.FieldByName('DESCRIZIONE').AsString
  else
    lblDescMedLegale.Caption:='';
end;

procedure TWA004FRecapitoVisFiscaliFM.cmbTipoEsenzioneAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  edtDataEsenzione.Text:=IfThen(Trim(cmbTipoEsenzione.Text) = '','',FormatDateTime('dd/mm/yyyy',Date));
  edtOperatoreEsenzione.Text:=IfThen(Trim(cmbTipoEsenzione.Text) = '','',Parametri.Operatore);
end;

procedure TWA004FRecapitoVisFiscaliFM.imgGommaAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  FCodComune:='';
  edtComune.Clear;
  edtCap.Clear;
  edtIndirizzo.Clear;
  edtTelefono.Clear;
  memNote.Lines.Clear;
end;

procedure TWA004FRecapitoVisFiscaliFM.OnConfermaMessaggio(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
// gestisce la risposta del messaggio modale di conferma
begin
  if Res = mrYes then
  begin
    btnOKClick(nil);
  end;
end;

procedure TWA004FRecapitoVisFiscaliFM.btnOKClick(Sender: TObject);
var
  MedLeg: String;
  procedure InsNuovoRecapito(VecchioVal,NuovoVal:String);
  begin
    with A004MW do
    begin
      if (NuovoVal <> selT047.FieldByName(VecchioVal).AsString) then
        selT047.FieldByName(VecchioVal).AsString:=NuovoVal;
    end;
  end;
begin
  // salva in variabili di appoggio i dati
  FDesComune:=edtComune.Text;
  FCap:=Trim(edtCap.Text);
  FIndirizzo:=Trim(edtIndirizzo.Text);
  FTelefono:=Trim(edtTelefono.Text);
  FNote:=Trim(memNote.Text);

  // controllo coerenza medicina legale
  if FCodComune = '' then
    MedLeg:=''
  else
    MedLeg:=A004MW.EstraiMedLeg(FCodComune);
  if MedLeg <> '' then
  begin
    // associazione presente
    if (cmbMedLegale.Text = '') then
    begin
      // medicina legale non indicata -> richiede impostazione automatica
      if not MsgBox.KeyExists('MED_LEG_BLANK') then
      begin
        MsgBox.WebMessageDlg(A000TraduzioneStringhe(A000MSG_A004_DLG_MED_LEG_AUTOMATICA),mtConfirmation,[mbYes,mbNo],OnConfermaMessaggio,'MED_LEG_BLANK');
        Exit;
      end;
      cmbMedLegale.Text:=MedLeg;
    end
    else if (cmbMedLegale.Text <> '') and
            (cmbMedLegale.Text <> MedLeg) then
    begin
      // medicina legale differente -> chiede conferma
      if not MsgBox.KeyExists('MED_LEG_DIVERSA') then
      begin
        MsgBox.WebMessageDlg(A000TraduzioneStringhe(Format(A000MSG_A004_DLG_FMT_COMUNE_DIFF_MED_LEG,[edtComune.Text])),mtConfirmation,[mbYes,mbNo],OnConfermaMessaggio,'MED_LEG_DIVERSA');
        Exit;
      end;
    end;
  end;

  if cmbMedLegale.Text = '' then
    FMedLegale:=''
  else
    FMedLegale:=cmbMedLegale.Text;

  FTipoEsenzione:=Trim(cmbTipoEsenzione.Text);
  if edtDataEsenzione.Text <> '' then
    FDataEsenzione:=StrToDate(edtDataEsenzione.Text)
  else
    FDataEsenzione:=0;
  FOperatoreEsenzione:=edtOperatoreEsenzione.Text;

  with A004MW do
  begin
    if selT047.RecordCount > 0 then
    begin
      selT047.Edit;
      InsNuovoRecapito('COD_COMUNE',FCodComune);
      InsNuovoRecapito('CAP',FCap);
      InsNuovoRecapito('INDIRIZZO',FIndirizzo);
      InsNuovoRecapito('TELEFONO',FTelefono);
      InsNuovoRecapito('MEDICINA_LEGALE',FMedLegale);
      InsNuovoRecapito('NOTE',FNote);
      InsNuovoRecapito('TIPO_ESENZIONE',FTipoEsenzione);
      InsNuovoRecapito('DATA_ESENZIONE',edtDataEsenzione.Text);
      InsNuovoRecapito('OPERATORE',FOperatoreEsenzione);
      selT047.Post;
    end;
  end;

  //*** verificare.ini
  // imposta i dati del recapito alternativo
  A004MW.RecapitoAlternativo.CodComune:=FCodComune;
  A004MW.RecapitoAlternativo.DescComune:=FDesComune;
  A004MW.RecapitoAlternativo.Cap:=FCap;
  A004MW.RecapitoAlternativo.Indirizzo:=FIndirizzo;
  A004MW.RecapitoAlternativo.Telefono:=FTelefono;
  A004MW.RecapitoAlternativo.MedLegale:=FMedLegale;
  A004MW.RecapitoAlternativo.Note:=FNote;
  A004MW.RecapitoAlternativo.TipoEsenzione:=FTipoEsenzione;
  A004MW.RecapitoAlternativo.DataEsenzione:=FDataEsenzione;
  A004MW.RecapitoAlternativo.OperatoreEsenzione:=FOperatoreEsenzione;
  //*** verificare.fine

  ReleaseOggetti;
  Free;
end;

procedure TWA004FRecapitoVisFiscaliFM.btnAnnullaClick(Sender: TObject);
begin
  ReleaseOggetti;
  Free;
end;

procedure TWA004FRecapitoVisFiscaliFM.ReleaseOggetti;
begin
  FreeAndNil(IntfWebT480);
end;

end.
