unit A136UStampaRelazioni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Mask, Grids, DBGrids, ActnList, Menus, StrUtils,
  A000UCostanti, A000USessione, A000UInterfaccia, A003UDataLavoroBis, C004UParamForm, C180FunzioniGenerali,
  ComCtrls, A000UMessaggi;

type
  TA136FStampaRelazioni = class(TForm)
    dgrdStampaRelazioni: TDBGrid;
    pnlImpostazioni: TPanel;
    lblDataStampa: TLabel;
    medtDataStampa: TMaskEdit;
    btnDataStampa: TButton;
    grpTipoRelazione: TGroupBox;
    chkTipoRelS: TCheckBox;
    chkTipoRelL: TCheckBox;
    btnEsegui: TBitBtn;
    Splitter1: TSplitter;
    pnlTitoloStampa: TPanel;
    grpColonneVisibili: TGroupBox;
    chkDecorrenza: TCheckBox;
    chkNomeCampo: TCheckBox;
    chkCodice: TCheckBox;
    chkDescrizione: TCheckBox;
    PopupMenu3: TPopupMenu;
    Ricercatestocontenuto1: TMenuItem;
    Successivo1: TMenuItem;
    N1: TMenuItem;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    N2: TMenuItem;
    Copia2: TMenuItem;
    CopiaInExcel: TMenuItem;
    ActionList1: TActionList;
    actRicercaTestoContenuto: TAction;
    actSuccessivo: TAction;
    grpParametriPartenza: TGroupBox;
    cbxTabPartenza: TComboBox;
    cbxColPartenza: TComboBox;
    lblTabPartenza: TLabel;
    lblColPartenza: TLabel;
    cbxColArrivo: TComboBox;
    lblColArrivo: TLabel;
    Label1: TLabel;
    edtLivelliDaEstrarre: TEdit;
    udLivelliDaEstrarre: TUpDown;
    procedure btnEseguiClick(Sender: TObject);
    procedure btnDataStampaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actRicercaTestoContenutoExecute(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Copia2Click(Sender: TObject);
    procedure CopiaInExcelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtLivelliDaEstrarreExit(Sender: TObject);
    procedure cbxTabPartenzaExit(Sender: TObject);
    procedure cbxColPartenzaExit(Sender: TObject);
    procedure edtLivelliDaEstrarreChange(Sender: TObject);
    procedure cbxColArrivoExit(Sender: TObject);
  private
    { Private declarations }
    TestoContenuto,ColonnePilotate: String;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
  public
    { Public declarations }
  end;

var
  A136FStampaRelazioni: TA136FStampaRelazioni;

implementation

{$R *.dfm}

uses A136URelazioniAnagrafeDtM;

procedure TA136FStampaRelazioni.FormShow(Sender: TObject);
var
  ListTabelle: TStringList;
begin
  //E' necessario specificare da codice l'assegnazione del DataSource alla griglia
  dgrdStampaRelazioni.DataSource:=A136FRelazioniAnagrafeDtM.A136FRelazioniAnagrafeMW.A136FComposizioneRelazioneMW.DStampa;
  medtDataStampa.Text:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro);
  CreaC004(SessioneOracle,'A136',Parametri.ProgOper);
  GetParametriFunzione;
  with A136FRelazioniAnagrafeDtM.selI030 do
  begin
    DisableControls;
    AfterScroll:=nil;
    ListTabelle:=TStringList.Create();
    A136FRelazioniAnagrafeDtM.A136FRelazioniAnagrafeMW.ElencoTabelleStampa(ListTabelle);
    cbxTabPartenza.Items.Assign(ListTabelle);
    FreeAndNil(ListTabelle);
    EnableControls;
    AfterScroll:=A136FRelazioniAnagrafeDtM.selI030AfterScroll;
  end;
end;

procedure TA136FStampaRelazioni.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004FParamForm.Cancella001;
  if chkTipoRelS.Checked then
    C004FParamForm.PutParametro('chkTipoRelS','S')
  else
    C004FParamForm.PutParametro('chkTipoRelS','N');
  if chkTipoRelL.Checked then
    C004FParamForm.PutParametro('chkTipoRelL','S')
  else
    C004FParamForm.PutParametro('chkTipoRelL','N');
  if chkDecorrenza.Checked then
    C004FParamForm.PutParametro('chkDecorrenza','S')
  else
    C004FParamForm.PutParametro('chkDecorrenza','N');
  if chkNomeCampo.Checked then
    C004FParamForm.PutParametro('chkNomeCampo','S')
  else
    C004FParamForm.PutParametro('chkNomeCampo','N');
  if chkCodice.Checked then
    C004FParamForm.PutParametro('chkCodice','S')
  else
    C004FParamForm.PutParametro('chkCodice','N');
  if chkDescrizione.Checked then
    C004FParamForm.PutParametro('chkDescrizione','S')
  else
    C004FParamForm.PutParametro('chkDescrizione','N');
  try SessioneOracle.Commit; except end;
end;

procedure TA136FStampaRelazioni.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
//  FreeAndNil(A136FComposizioneRelazioneMW);
end;

procedure TA136FStampaRelazioni.GetParametriFunzione;
{Leggo i parametri della form}
begin
  chkTipoRelS.Checked:=C004FParamForm.GetParametro('chkTipoRelS','N') = 'S';
  chkTipoRelL.Checked:=C004FParamForm.GetParametro('chkTipoRelL','N') = 'S';
  chkDecorrenza.Checked:=C004FParamForm.GetParametro('chkDecorrenza','N') = 'S';
  chkNomeCampo.Checked:=C004FParamForm.GetParametro('chkNomeCampo','N') = 'S';
  chkCodice.Checked:=C004FParamForm.GetParametro('chkCodice','N') = 'S';
  chkDescrizione.Checked:=C004FParamForm.GetParametro('chkDescrizione','N') = 'S';
end;

procedure TA136FStampaRelazioni.btnDataStampaClick(Sender: TObject);
var Data:TDateTime;
    Anno,Mese,Giorno:Word;
    StrData:String;
begin
  StrData:=medtDataStampa.Text;
  if (Trim(StrData) = '') or (StrData = '  /  /    ') then
    StrData:=FormatDateTime('dd/mm/yyyy',Now);
  Anno:=StrToInt(Copy(StrData,7,4));
  Mese:=StrToInt(Copy(StrData,4,2));
  Giorno:=StrToInt(Copy(StrData,1,2));
  Data:=EncodeDate(Anno,Mese,Giorno);
  Data:=DataOut(Data,'Data','G');
  StrData:=FormatDateTime('dd/mm/yyyy',Data);
  medtDataStampa.Text:=StrData;
end;

procedure TA136FStampaRelazioni.btnEseguiClick(Sender: TObject);
var
  Tipo,StrData,StrutturaStampa:String;
  Data:TDateTime;
  Anno,Mese,Giorno:Word;
begin
  //Controlli sui parametri impostati
  if (Trim(medtDataStampa.Text) = '') or (medtDataStampa.Text = '  /  /    ') then
    raise Exception.Create('Impostare una data di riferimento!');
  if ((cbxTabPartenza.Text = '') and (cbxColPartenza.Text <> ''))
  or ((cbxTabPartenza.Text <> '') and (cbxColPartenza.Text = '')) then
    raise Exception.Create(A000MSG_A136_ERR_TABELLA_COLONNA);
  if (cbxTabPartenza.Text <> '')
  and (cbxTabPartenza.Items.IndexOf(cbxTabPartenza.Text) = -1) then
    raise Exception.Create('Selezionare la tabella tra l''elenco di valori disponibili!');
  if (cbxColPartenza.Text <> '')
  and (cbxColPartenza.Items.IndexOf(cbxColPartenza.Text) = -1) then
    raise Exception.Create('Selezionare la colonna di partenza tra l''elenco di valori disponibili!');
  if (cbxColArrivo.Text <> '')
  and (cbxColArrivo.Items.IndexOf(cbxColArrivo.Text) = -1) then
    raise Exception.Create('Selezionare la colonna di arrivo tra l''elenco di valori disponibili!');
  if  not chkTipoRelS.Checked
  and not chkTipoRelL.Checked then
    raise Exception.Create('Selezionare almeno un tipo di relazione!');
  //Recupero i tipi di relazione da stampare
  Tipo:=',';
  if chkTipoRelS.Checked then
    Tipo:=Tipo + '''S'',';
  if chkTipoRelL.Checked then
    Tipo:=Tipo + '''L'',';
  Tipo:=Copy(Tipo,2,Length(Tipo)-2);
  //Recupero la struttura relazionale completa, se è stata indicata
  StrutturaStampa:='';
  if (cbxColPartenza.Text <> '') and (cbxColArrivo.Text <> '') then
  begin
    with A136FRelazioniAnagrafeDtM do
    begin
      selI030.DisableControls;
      selI030.AfterScroll:=nil;
      StrutturaStampa:=A136FRelazioniAnagrafeMW.CreaStrutturaStampa(cbxTabPartenza.Text, cbxColPartenza.Text , cbxColArrivo.Text);
      selI030.EnableControls;
      selI030.AfterScroll:=A136FRelazioniAnagrafeDtM.selI030AfterScroll;
    end;
  end;
  //Recupero la data della stampa
  StrData:=medtDataStampa.Text;
  Anno:=StrToInt(Copy(StrData,7,4));
  Mese:=StrToInt(Copy(StrData,4,2));
  Giorno:=StrToInt(Copy(StrData,1,2));
  Data:=EncodeDate(Anno,Mese,Giorno);
  //Avvio la stampa
  A136FRelazioniAnagrafeDtM.A136FRelazioniAnagrafeMW.A136FComposizioneRelazioneMW.GestioneStampa(Tipo,Data,0,chkDecorrenza.Checked,chkNomeCampo.Checked,chkCodice.Checked,chkDescrizione.Checked,False,cbxTabPartenza.Text,cbxColPartenza.Text,StrutturaStampa,StrToIntDef(edtLivelliDaEstrarre.Text,0),0,'','');
end;

procedure TA136FStampaRelazioni.cbxTabPartenzaExit(Sender: TObject);
var
  ListColonne: TStringList;
begin
  if cbxTabPartenza.Text <> UpperCase(Trim(cbxTabPartenza.Text)) then
    cbxTabPartenza.Text:=UpperCase(Trim(cbxTabPartenza.Text));
  cbxColPartenza.Items.Clear;
  cbxColArrivo.Items.Clear;
  ColonnePilotate:='';
  if cbxTabPartenza.Text <> '' then
  begin
    with A136FRelazioniAnagrafeDtM do
    begin
      selI030.DisableControls;
      selI030.AfterScroll:=nil;
      ListColonne:=TStringList.Create();
      A136FRelazioniAnagrafeMW.ElencoColonne(cbxTabPartenza.Text,listColonne,ColonnePilotate);
      cbxColPartenza.Items.Assign(ListColonne);
      FreeAndNil(ListColonne);
      selI030.EnableControls;
      selI030.AfterScroll:=A136FRelazioniAnagrafeDtM.selI030AfterScroll;

    end;
  end;
  if cbxColPartenza.Items.IndexOf(cbxColPartenza.Text) = -1 then
    cbxColPartenza.Text:='';
  if cbxColArrivo.Items.IndexOf(cbxColArrivo.Text) = -1 then
    cbxColArrivo.Text:='';
end;

procedure TA136FStampaRelazioni.cbxColPartenzaExit(Sender: TObject);
var
  ListColonneArrivo:TStringList;
begin
  if cbxColPartenza.Text <> UpperCase(Trim(cbxColPartenza.Text)) then
    cbxColPartenza.Text:=UpperCase(Trim(cbxColPartenza.Text));
  cbxColArrivo.Items.Clear;
  if ColonnePilotate <> '' then
  begin
    with A136FRelazioniAnagrafeDtM do
    begin
      selI030.DisableControls;
      selI030.AfterScroll:=nil;
      ListColonneArrivo:=TStringList.Create();
      A136FRelazioniAnagrafeMW.ElencoColonneArrivo(cbxTabPartenza.Text,cbxColPartenza.Text,ColonnePilotate, ListColonneArrivo);
      cbxColArrivo.Items.Assign(ListColonneArrivo);
      FreeAndNil(ListColonneArrivo);
      selI030.EnableControls;
      selI030.AfterScroll:=A136FRelazioniAnagrafeDtM.selI030AfterScroll;
    end;
  end;
end;

procedure TA136FStampaRelazioni.cbxColArrivoExit(Sender: TObject);
begin
  if cbxColArrivo.Text <> UpperCase(Trim(cbxColArrivo.Text)) then
    cbxColArrivo.Text:=UpperCase(Trim(cbxColArrivo.Text));
end;

procedure TA136FStampaRelazioni.Copia2Click(Sender: TObject);
begin
  R180DBGridCopyToClipboard(dgrdStampaRelazioni,Sender = CopiaInExcel);
end;

procedure TA136FStampaRelazioni.CopiaInExcelClick(Sender: TObject);
begin
  R180DBGridCopyToClipboard(dgrdStampaRelazioni,Sender = CopiaInExcel);
end;

procedure TA136FStampaRelazioni.Deselezionatutto1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdStampaRelazioni,'N');
end;

procedure TA136FStampaRelazioni.edtLivelliDaEstrarreChange(Sender: TObject);
begin
  edtLivelliDaEstrarre.Text:=IntToStr(StrToIntDef(edtLivelliDaEstrarre.Text,0));
end;

procedure TA136FStampaRelazioni.edtLivelliDaEstrarreExit(Sender: TObject);
begin
  if (StrToIntDef(edtLivelliDaEstrarre.Text,0) > udLivelliDaEstrarre.Max)
  or (StrToIntDef(edtLivelliDaEstrarre.Text,0) < udLivelliDaEstrarre.Min) then
  begin
    edtLivelliDaEstrarre.SetFocus;
    raise exception.Create('Selezionare un numero di livelli compreso tra ' + IntToStr(udLivelliDaEstrarre.Min) + ' e ' + IntToStr(udLivelliDaEstrarre.Max) + '!');
  end;
end;

procedure TA136FStampaRelazioni.Invertiselezione1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdStampaRelazioni,'C');
end;

procedure TA136FStampaRelazioni.Selezionatutto1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdStampaRelazioni,'S');
end;

procedure TA136FStampaRelazioni.actRicercaTestoContenutoExecute(Sender: TObject);
var
  Trovato: Integer;
begin
  with A136FRelazioniAnagrafeDtM.A136FRelazioniAnagrafeMW.A136FComposizioneRelazioneMW.cdsStampa do
    if Sender = actRicercaTestoContenuto then
    begin
      TestoContenuto:=UpperCase(FieldByName(dgrdStampaRelazioni.SelectedField.FieldName).AsString);
      if InputQuery('Ricerca per testo contenuto',dgrdStampaRelazioni.SelectedField.DisplayLabel,TestoContenuto) then
      begin
        Trovato:=0;
        DisableControls;
        while (not Eof) and (Trovato = 0) do
        begin
          Trovato:=Pos(UpperCase(TestoContenuto),UpperCase(FieldByName(dgrdStampaRelazioni.SelectedField.FieldName).AsString));
          if Trovato = 0 then
            Next;
        end;
        if Trovato = 0 then
        begin
          ShowMessage('Il testo "' + UpperCase(TestoContenuto) + '" non è contenuto in nessun elemento della colonna "' +
            dgrdStampaRelazioni.SelectedField.DisplayLabel +'"');
          First;
        end;
        EnableControls;
      end;
    end
    else
    begin
      Trovato:=0;
      DisableControls;
      while (not Eof) and (Trovato = 0) do
      begin
        if Trovato = 0 then
          Next;
        Trovato:=Pos(UpperCase(TestoContenuto),UpperCase(FieldByName(dgrdStampaRelazioni.SelectedField.FieldName).AsString));
      end;
      if Trovato = 0 then
      begin
        ShowMessage('Il testo "' + UpperCase(TestoContenuto) + '" non è contenuto in nessun altro elemento della colonna "' +
          dgrdStampaRelazioni.SelectedField.DisplayLabel +'"');
        First;
      end;
      EnableControls;
    end;
end;

end.
