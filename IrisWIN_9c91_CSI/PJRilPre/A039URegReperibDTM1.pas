unit A039URegReperibDTM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione,A000UInterfaccia, A000UMessaggi, RegistrazioneLog, OracleData, Oracle,
  C180FunzioniGenerali, Variants, A039URegReperibMW;

type
  TA039FREGREPERIBDTM1 = class(TDataModule)
    selT350: TOracleDataSet;
    selT350CODICE: TStringField;
    selT350DESCRIZIONE: TStringField;
    selT350ORAINIZIO: TDateTimeField;
    selT350ORAFINE: TDateTimeField;
    selT350TIPOORE: TStringField;
    selT350ORENORMALI: TDateTimeField;
    selT350ORECOMPRESENZA: TDateTimeField;
    selT350TIPOTURNO: TStringField;
    selT350RAGGRUPPAMENTO: TStringField;
    selT350ORENONCAUS: TStringField;
    selT350TOLLERANZA: TFloatField;
    selT350VP_TURNO: TStringField;
    selT350VP_ORE: TStringField;
    selT350VP_MAGGIORATE: TStringField;
    selT350VP_NONMAGGIORATE: TStringField;
    selT350TURNO_INTERO: TStringField;
    selT350DETRAZ_MENSA: TStringField;
    selT350TIPOLOGIA: TStringField;
    selT350PIANIF_MAX_MESE: TIntegerField;
    selT350ORE_MIN_INDENNITA: TStringField;
    selT350PIANIF_MAX_MESE_TURNI_INTERI: TStringField;
    selT350BLOCCA_MAX_MESE: TStringField;
    selT350VP_GETTONE_CHIAMATA: TStringField;
    selT350VP_TURNI_OLTREMAX: TStringField;
    selT350TOLL_CHIAMATA_INIZIO: TStringField;
    selT350TOLL_CHIAMATA_FINE: TStringField;
    procedure A034FINTPAGHEDTM1Create(Sender: TObject);
    procedure A034FINTPAGHEDTM1Destroy(Sender: TObject);
    procedure SetTextOre(Sender: TField; const Text: String);
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
    procedure selT350ORAINIZIOGetText(Sender: TField; var Text: string;DisplayText: Boolean);
    procedure selT350AfterPost(DataSet: TDataSet);
    procedure selT350AfterCancel(DataSet: TDataSet);
    procedure selT350AfterDelete(DataSet: TDataSet);
    procedure selT350BeforePost(DataSet: TDataSet);
    procedure selT350NewRecord(DataSet: TDataSet);
    procedure selT350BeforeDelete(DataSet: TDataSet);
    procedure selT350TURNO_INTEROValidate(Sender: TField);
    procedure selT350ORE_MIN_INDENNITAValidate(Sender: TField);
    procedure selT350TOLL_CHIAMATA_INIZIOValidate(Sender: TField);
    procedure selT350TOLL_CHIAMATA_FINEValidate(Sender: TField);
  private
    procedure evtShowMessage (Msg,VocePaghe: String);
    procedure evtAggiornamentoTurni(Msg,VocePaghe: String);
    procedure ControlloVocePaghe(NomeCampo: String);
  public
    A039MW: TA039FRegReperibMW;
  end;

var
  A039FREGREPERIBDTM1: TA039FREGREPERIBDTM1;

implementation

uses A039URegReperib;

{$R *.DFM}

procedure TA039FREGREPERIBDTM1.A034FINTPAGHEDTM1Create(Sender: TObject);
var i:Integer;
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;
  A039MW:=TA039FRegReperibMW.Create(Self);
  A039MW.SelT350:=SelT350;
  A039MW.evtShowMessage:=evtShowMessage;
  A039MW.evtAggiornamentoTurni:=evtAggiornamentoTurni;
  selT350.Open;
  A039FRegReperib.dbrgpTipologiaChange(nil);
end;

procedure TA039FREGREPERIBDTM1.A034FINTPAGHEDTM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA039FREGREPERIBDTM1.selT350AfterPost(DataSet: TDataSet);
begin
  A039MW.AfterPost;
  SessioneOracle.Commit;
  RegistraLog.RegistraOperazione;
end;

procedure TA039FREGREPERIBDTM1.selT350AfterCancel(DataSet: TDataSet);
begin
  A039MW.AfterCancel;
end;

procedure TA039FREGREPERIBDTM1.selT350AfterDelete(DataSet: TDataSet);
begin
  A039MW.AfterDelete;
  RegistraLog.RegistraOperazione;
end;

procedure TA039FREGREPERIBDTM1.SetTextOre(Sender: TField;const Text: String);
begin
  A039MW.VerificaCampoOra(Sender,Text);
end;

procedure TA039FREGREPERIBDTM1.selT350BeforePost(DataSet: TDataSet);
begin
  A039MW.TipoOreItemIndex:=A039FRegReperib.DBRdGrpTipoOre.ItemIndex;
  A039MW.VpTurno:=A039FRegReperib.dEdtVpTurno.Text;
  A039MW.VpOre:=A039FRegReperib.dEdtVpOre.Text;
  A039MW.VpMaggiorate:=A039FRegReperib.dEdtVpMaggiorate.Text;
  A039MW.VpNonMaggiorate:=A039FRegReperib.dEdtVpNonMaggiorate.Text;
  A039MW.GettoneChiamata:=A039FRegReperib.dEdtGettoneChiamata.Text;
  A039MW.BeforePostStep1;
  //Controllo voci paghe
  ControlloVocePaghe('VP_TURNO');
  ControlloVocePaghe('VP_ORE');
  ControlloVocePaghe('VP_MAGGIORATE');
  ControlloVocePaghe('VP_NONMAGGIORATE');
  ControlloVocePaghe('VP_GETTONE_CHIAMATA');
  ControlloVocePaghe('VP_TURNI_OLTREMAX');
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
  if DataSet.State = dsInsert then
    exit;
  //Aggiornamento voci paghe dei turni già riepilogati su T340
  try
    Screen.Cursor:=crHourGlass;
    A039FRegReperib.StatusBar.Panels[2].Text:=A000MSG_A039_MSG_ALLINEAMENTO_IN_CORSO;
    A039MW.BeforePostStep2;
  finally
    A039FRegReperib.StatusBar.Panels[2].Text:='';
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA039FREGREPERIBDTM1.ControlloVocePaghe(NomeCampo: String);
begin
  if selT350.FieldByName(NomeCampo).AsString <> '<SI>' then
  begin
    A039MW.ImpostaVocePaghe(NomeCampo);
    if not A039MW.selControlloVociPaghe.ControlloVociPaghe(A039MW.VoceOld,A039MW.VoceNew) then
      if R180MessageBox(A039MW.selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
        Abort
      else
        A039MW.selControlloVociPaghe.ValutaInserimentoVocePaghe(A039MW.VoceNew);
  end;
end;

procedure TA039FREGREPERIBDTM1.evtShowMessage(Msg,VocePaghe: String);
begin
  //VocePaghe non è necessario su su IrisWin perchè il flusso è del tipo domanda-risposta. Invece su
  //IrisCloud la risposta è cumulativa alla fine
  ShowMessage(Format(Msg,['per la voce paghe ' + VocePaghe]));
end;

procedure TA039FREGREPERIBDTM1.evtAggiornamentoTurni(Msg,VocePaghe: String);
begin
  if MessageDlg(Msg ,mtConfirmation,[mbYes,mbNo],0) = mrYes then
    A039MW.AggiornaVocePaghe
  else
    ShowMessage(Format(A000MSG_A039_FMT_ALLINEAMENTO_RIEPILOGHI,['']));
end;

procedure TA039FREGREPERIBDTM1.selT350NewRecord(DataSet: TDataSet);
begin
  A039MW.NewRecord;
end;

procedure TA039FREGREPERIBDTM1.selT350BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA039FREGREPERIBDTM1.selT350TOLL_CHIAMATA_INIZIOValidate(Sender: TField);
begin
  A039MW.selT350ValidaTollChiamata(Sender);
end;

procedure TA039FREGREPERIBDTM1.selT350TOLL_CHIAMATA_FINEValidate(Sender: TField);
begin
  A039MW.selT350ValidaTollChiamata(Sender);
end;

procedure TA039FREGREPERIBDTM1.selT350TURNO_INTEROValidate(Sender: TField);
begin
  A039MW.selT350ValidaTurnoIntero(Sender);
end;

procedure TA039FREGREPERIBDTM1.selT350ORAINIZIOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  A039MW.selT350GetText(Sender,Text);
end;

procedure TA039FREGREPERIBDTM1.selT350ORE_MIN_INDENNITAValidate(Sender: TField);
begin
  A039MW.selT350ValidaOreMinutiIndennita(Sender,A039FRegReperib.DBEOraIni.Text,A039FRegReperib.DBEOraFine.Text);
end;

procedure TA039FREGREPERIBDTM1.FiltroDizionario(DataSet: TDataSet;var Accept: Boolean);
begin
  A039MW.FiltroDizionario(DataSet,Accept);
end;

end.
