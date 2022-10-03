unit A004URecapitoVisFiscali;

interface

uses
  A004UGiustifAssPresMW, A000UInterfaccia, A000UMessaggi,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ExtCtrls, StrUtils, Math,
  C015UElencoValori, C180FunzioniGenerali, DBCtrls, DB;

type
  TA004FRecapitoVisFiscali = class(TForm)
    grpVisiteFiscali: TGroupBox;
    lblComune: TLabel;
    lblCap: TLabel;
    lblIndirizzo: TLabel;
    lblTelefono: TLabel;
    edtComune: TEdit;
    edtIndirizzo: TEdit;
    edtTelefono: TEdit;
    edtCap: TMaskEdit;
    btnComuni: TBitBtn;
    btnGomma: TBitBtn;
    lblIstruzioni: TLabel;
    Panel1: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    grpMedLegale: TGroupBox;
    lblMedicinaLegale: TLabel;
    dcmbMedicineLegali: TDBLookupComboBox;
    dtxtMedicinaLegale: TDBText;
    lblNote: TLabel;
    MemoNote: TMemo;
    grpEsenzione: TGroupBox;
    lblTipoEsenzione: TLabel;
    cmbTipoEsenzione: TComboBox;
    lblDataEsenzione: TLabel;
    edtOperatoreEsenzione: TEdit;
    lblOperatoreEsenzione: TLabel;
    edtDataEsenzione: TEdit;
    procedure btnComuniClick(Sender: TObject);
    procedure btnGommaClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmbTipoEsenzioneChange(Sender: TObject);
  private
    FCodComune,
    FDesComune,
    FIndirizzo,
    FCap,
    FTelefono,
    FMedLegale,
    FNote,
    FTipoEsenzione,
    FOperatoreEsenzione: String;
    FDataEsenzione:TDateTime;
    T047Progressivo:integer;
    T047DataInizio:TDateTime;
    procedure PopolaComboEsenzioni;
  public
    A004MW: TA004FGiustifAssPresMW;
  end;

var
  A004FRecapitoVisFiscali: TA004FRecapitoVisFiscali;
  procedure OpenA004RecapitoVisFiscali(PA004MW:TA004FGiustifAssPresMW; ProgressivoIn:integer; DataInizioIn:TDateTime);

implementation

uses A004UGiustifAssPres;

{$R *.dfm}

procedure OpenA004RecapitoVisFiscali(PA004MW: TA004FGiustifAssPresMW; ProgressivoIn:integer; DataInizioIn:TDateTime);
begin
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TA004FRecapitoVisFiscali, A004FRecapitoVisFiscali);
  try
    A004FRecapitoVisFiscali.A004MW:=PA004MW;
    A004FRecapitoVisFiscali.T047Progressivo:=ProgressivoIn;
    A004FRecapitoVisFiscali.T047DataInizio:=DataInizioIn;
    Screen.Cursor:=crDefault;
    A004FRecapitoVisFiscali.ShowModal;
  finally
    A004FRecapitoVisFiscali.Free;
  end;
end;

// spostato su frame: Visualizza
procedure TA004FRecapitoVisFiscali.FormShow(Sender: TObject);
begin
  // impostazione datasource per lookupcombo
  dcmbMedicineLegali.ListSource:=A004MW.dscT485;
  dtxtMedicinaLegale.DataSource:=A004MW.dscT485;
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
    FNote:=RecapitoAlternativo.Note;
    FTipoEsenzione:=RecapitoAlternativo.TipoEsenzione;
    FDataEsenzione:=RecapitoAlternativo.DataEsenzione;
    FOperatoreEsenzione:=RecapitoAlternativo.OperatoreEsenzione;

    selT047.Close;
    selT047.SetVariable('PROGRESSIVO',T047Progressivo);
    selT047.SetVariable('DATA_INIZIO',T047DataInizio);
    selT047.Open;

    if selT047.RecordCount > 0 then
    begin
      btnComuni.Enabled:=selT047.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull;
      btnGomma.Enabled:=selT047.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull;
      edtCap.Enabled:=selT047.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull;
      edtIndirizzo.Enabled:=selT047.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull;
      edtTelefono.Enabled:=selT047.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull;
      dcmbMedicineLegali.Enabled:=selT047.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull;
      MemoNote.Enabled:=selT047.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull;
      cmbTipoEsenzione.Enabled:=selT047.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull;
      if not selT047.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull then
        R180MessageBox(A000TraduzioneStringhe(A000MSG_A004_MSG_RECAPITO_NON_MODIF),INFORMA);

      FCodComune:=selT047.FieldByName('COD_COMUNE').asString;
      FDesComune:=seLT047.FieldByName('CITTA').asString;
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
  dcmbMedicineLegali.KeyValue:=FMedLegale;
  MemoNote.Lines.Text:=FNote;
  cmbTipoEsenzione.Text:=FTipoEsenzione;
  edtDataEsenzione.Text:=IfThen(FDataEsenzione <> 0,FormatDateTime('dd/mm/yyyy',FDataEsenzione),'');
  edtOperatoreEsenzione.Text:=FOperatoreEsenzione;
end;

procedure TA004FRecapitoVisFiscali.PopolaComboEsenzioni;
begin
  cmbTipoEsenzione.Items.Clear;
  with A004MW.selT047Esenzioni do
  begin
    Close;
    Open;
    while not Eof do
    begin
      cmbTipoEsenzione.Items.Add(FieldByName('TIPO_ESENZIONE').AsString);
      Next;
    end;
  end;
end;

procedure TA004FRecapitoVisFiscali.btnComuniClick(Sender: TObject);
var
  Selezione,MedLeg: String;
  vCodice: Variant;
begin
  Selezione:='select T480.CITTA, T480.PROVINCIA, T480.CAP, DECODE(T485.CODICE,NULL,'''',T485.CODICE || '' - '' || T485.DESCRIZIONE) "MED. LEGALE", T480.CODICE ' +
             'from   T480_COMUNI T480, T485_MEDICINELEGALI T485, T486_COMUNI_MEDLEGALI T486 ' +
             'where  T486.COD_COMUNE(+) = T480.CODICE ' +
             'and    T485.CODICE (+) = T486.MED_LEGALE ' +
             'order by T480.CITTA ';
  vCodice:=VarArrayOf(['','','']);
  OpenC015FElencoValori('T480_COMUNI','<A004> Selezione del comune di recapito per visita fiscale',Selezione,'CODICE;CITTA;CAP',vCodice,nil,500,400);
  if not VarIsClear(vCodice) then
  begin
    FCodComune:=VarToStr(vCodice[0]);
    edtComune.Text:=VarToStr(vCodice[1]);
    edtCap.Text:=VarToStr(vCodice[2]);
    edtIndirizzo.SetFocus;

    MedLeg:=A004MW.EstraiMedLeg(FCodComune);
    if (MedLeg <> '') and
       (dcmbMedicineLegali.KeyValue <> null) and
       (dcmbMedicineLegali.KeyValue <> '') and
       (dcmbMedicineLegali.KeyValue <> MedLeg) then
    begin
      if R180MessageBox(Format(A000MSG_A004_DLG_FMT_SOVRASCRIVI_MED_LEG,[edtComune.Text]),DOMANDA) = mrNo then
        Exit;
    end;
    dcmbMedicineLegali.KeyValue:=MedLeg;
  end;
end;

procedure TA004FRecapitoVisFiscali.btnGommaClick(Sender: TObject);
begin
  FCodComune:='';
  edtComune.Clear;
  edtCap.Clear;
  edtIndirizzo.Clear;
  edtTelefono.Clear;
  MemoNote.Lines.Clear;
end;

procedure TA004FRecapitoVisFiscali.btnOkClick(Sender: TObject);
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
  FNote:=Trim(MemoNote.Lines.Text);

  // controllo coerenza medicina legale
  if FCodComune = '' then
    MedLeg:=''
  else
    MedLeg:=A004MW.EstraiMedLeg(FCodComune);
  if MedLeg <> '' then
  begin
    // associazione presente
    if ((dcmbMedicineLegali.KeyValue = null) or
        (dcmbMedicineLegali.KeyValue = '')) then
    begin
      // medicina legale non indicata -> richiede impostazione automatica
      if R180MessageBox(A000TraduzioneStringhe(A000MSG_A004_DLG_MED_LEG_AUTOMATICA),DOMANDA) = mrYes then
        dcmbMedicineLegali.KeyValue:=MedLeg;
    end
    else if (dcmbMedicineLegali.KeyValue <> null) and (dcmbMedicineLegali.KeyValue <> '') and
            (dcmbMedicineLegali.KeyValue <> MedLeg) then
    begin
      // medicina legale differente -> chiede conferma
      if R180MessageBox(A000TraduzioneStringhe(Format(A000MSG_A004_DLG_FMT_COMUNE_DIFF_MED_LEG,[edtComune.Text])),DOMANDA) = mrNo then
        Abort;
    end;
  end;

  if dcmbMedicineLegali.KeyValue = null then
    FMedLegale:=''
  else
    FMedLegale:=dcmbMedicineLegali.KeyValue;

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
      InsNuovoRecapito('DATA_ESENZIONE',edtDataEsenzione.Text);//verificare assegnazione del valore vuoto
      InsNuovoRecapito('OPERATORE',FOperatoreEsenzione);
      selT047.Post;
    end;
  end;

  //*** verificare.ini
  // imposta i dati del recapito alternativo
  {
  A004FGiustifAssPres.SetRecapitoAlternativo(
    FCodComune,
    FDesComune,
    FCap,
    FIndirizzo,
    FTelefono,
    FMedLegale,
    FNote);
  }

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

  A004FRecapitoVisFiscali.Close;
end;

procedure TA004FRecapitoVisFiscali.cmbTipoEsenzioneChange(Sender: TObject);
begin
  edtDataEsenzione.Text:=IfThen(Trim(cmbTipoEsenzione.Text) = '','',FormatDateTime('dd/mm/yyyy',Date));
  edtOperatoreEsenzione.Text:=IfThen(Trim(cmbTipoEsenzione.Text) = '','',Parametri.Operatore);
end;

end.
