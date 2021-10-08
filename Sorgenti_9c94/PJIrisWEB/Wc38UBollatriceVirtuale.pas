unit Wc38UBollatriceVirtuale;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  R012UWebAnagrafico, IWVCLComponent,IWBaseLayoutComponent, Math,
  IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, A000UCostanti, A000UInterfaccia, OracleData, IWCompGrids, IWDBGrids, medpIWDBGrid,
  Wc38UBollatriceVirtualeDM, C180FunzioniGenerali, IWApplication,
  IWCompJQueryWidget, IWCompExtCtrls, meIWImageFile, medpIWImageButton,
  medpIWMessageDlg, IWCompMemo, meIWMemo, IW.Browser.InternetExplorer,
  System.DateUtils, System.StrUtils, IWCompListbox, meIWComboBox;

type
  TDatiTimbratura = record
    Progressivo: Integer;
    DataOraServer: TDateTime;  // data e ora del server al momento della timbratura
    Data: TDateTime;           // data salvata su T100, comprensiva della tolleranza
    Ora: TDateTime;            // ora  salvata su T100, comprensiva della tolleranza
    Verso: String;
    Causale: String;
    Rilevatore: String;
  end;

  TWc38FBollatriceVirtuale = class(TR012FWebAnagrafico)
    grdTimbrature: TmedpIWDBGrid;
    lblOraCorrente: TmeIWLabel;
    JQuery: TIWJQueryWidget;
    btnEntrata: TmedpIWImageButton;
    btnUscita: TmedpIWImageButton;
    btnRegistraEntrata: TmeIWButton;
    btnRegistraUscita: TmeIWButton;
    meIWMemo1: TmeIWMemo;
    btnCambiaProgressivo: TmeIWButton;
    lblEntrata: TmeIWLabel;
    lblUscita: TmeIWLabel;
    lblOraEntrata: TmeIWLabel;
    lblOraUscita: TmeIWLabel;
    lblCausale: TmeIWLabel;
    cmbCausale: TmeIWComboBox;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure btnRegistraEntrataClick(Sender: TObject);
    procedure btnEntrataAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnRegistraUscitaClick(Sender: TObject);
    procedure btnUscitaAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnCambiaProgressivoClick(Sender: TObject);
    procedure lblEntrataAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure lblUscitaAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    DatiTimbratura: TDatiTimbratura;
    Wc38DM: TWc38FBollatriceVirtualeDM;
    EsistonoTolleranze: Boolean;
    ParMinutiTolleranzaE, ParMinutiTolleranzaU: Integer;
    function CtrlRegistraTimbratura: String;
    procedure RegistraTimbratura;
    procedure cmbAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure ResultTimbraturaEsci(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultConferma(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    function GetDescVerso(const PVerso: String): String;
    procedure ResultTimbraturaOk(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
  protected
    procedure RefreshPage; override;
  public
    procedure ImpostaOraCorrente(EventParams: TStringList);
    function  InizializzaAccesso: Boolean; override;
    procedure VisualizzaDipendenteCorrente; override;
  end;

const
  LABEL_ENTRATA_HTML = '<img style="cursor:pointer;" src="img/imgEntrata.png"/><span class="etichettaTimbratura">ENTRA</span>';
  LABEL_USCITA_HTML  = '<span class="etichettaTimbratura">ESCI</span><img style="cursor:pointer;" src="img/imgUscita.png"/>';
  FORMATO_ORA_TIMB   = 'hhhh.nn.ss';

implementation

{$R *.dfm}

function TWc38FBollatriceVirtuale.InizializzaAccesso:Boolean;
const
  FUNZIONE = 'InizializzaAccesso';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  Result:=True;
  GetDipendentiDisponibili(Parametri.DataLavoro);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);

  // visualizza i dati del dipendente selezionato
  VisualizzaDipendenteCorrente;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TWc38FBollatriceVirtuale.VisualizzaDipendenteCorrente;
var
  DataOggi: TDateTime;
  Codice, Descrizione: String;
const
  FUNZIONE = 'VisualizzaDipendenteCorrente';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  inherited;

  // salva parametri form
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  DataOggi:=Date;

  // gestione causale
  lblCausale.Visible:=False;
  cmbCausale.Visible:=False;
  if (Parametri.CampiRiferimento.C90_WC38TimbCausalizzabile = 'S') and (not SolaLettura) then
  begin
    // la gestione della causalizzazione è abilitata
    R180SetVariable(Wc38DM.selT275Abilitate,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(Wc38DM.selT275Abilitate,'DATA',DataOggi);
    Wc38DM.selT275Abilitate.Open;
    if Wc38DM.selT275Abilitate.RecordCount > 0 then
    begin
      // sono presenti causali abilitate: le aggiunge alla combobox di selezione
      cmbCausale.Items.BeginUpdate;
      cmbCausale.Items.Add('=');
      while not Wc38DM.selT275Abilitate.Eof do
      begin
        Codice:=Wc38DM.selT275Abilitate.FieldByName('CODICE').AsString;
        Descrizione:=Format('%-5s %s',[Codice,Wc38DM.selT275Abilitate.FieldByName('DESCRIZIONE').AsString]);
        cmbCausale.Items.Values[Descrizione]:=Codice;
        Wc38DM.selT275Abilitate.Next;
      end;
      cmbCausale.Items.EndUpdate;

      // rende visibile i dati della causale e imposta elemento vuoto come default
      lblCausale.Visible:=True;
      cmbCausale.Visible:=True;
      cmbCausale.ItemIndex:=0;
    end;
  end;

  // apre dataset di supporto per timbrature
  Wc38DM.selT100.Close;
  Wc38DM.selT100.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
  Wc38DM.selT100.SetVariable('DATA',DataOggi);
  Wc38DM.selT100.Open;

  grdTimbrature.Caption:='Timbrature del ' + FormatDateTime('dd/mm/yyyy', DataOggi);
  grdTimbrature.medpAttivaGrid(Wc38DM.selT100,False,False,False);

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TWc38FBollatriceVirtuale.IWAppFormCreate(Sender: TObject);
var
  CallBackName: string;
  Js: string;
  fixIE8: string;
begin
  inherited;

  // colonne di V430 da estrarre oltre a quelle standard
  CampiV430:=CampiV430 + ',V430.T430TGESTIONE';

  ParMinutiTolleranzaE:=StrToIntDef(Parametri.CampiRiferimento.C90_WC38Tolleranza_E,0);
  ParMinutiTolleranzaU:=StrToIntDef(Parametri.CampiRiferimento.C90_WC38Tolleranza_U,0);
  EsistonoTolleranze:=(ParMinutiTolleranzaE <> 0) or (ParMinutiTolleranzaU <> 0);
  lblOraEntrata.Visible:=EsistonoTolleranze;
  lblOraUscita.Visible:=EsistonoTolleranze;
  DatiTimbratura.Rilevatore:=Parametri.CampiRiferimento.C90_WC38Rilevatore;

  CambioDipendenteAsync:=True;
  cmbDipendentiDisponibili.OnAsyncChange:=cmbAsyncChange;
  Wc38DM:=TWc38FBollatriceVirtualeDM.Create(Self);

  grdTimbrature.medpRowSelect:=False;
  grdTimbrature.medpRighePagina:=GetRighePaginaTabella;
  grdTimbrature.medpTestoNoRecord:='Nessuna timbratura';

  // imposta ed abilita jquery plugin per orologio
  //http://tutorialzine.com/2013/06/digital-clock/
  CallBackName:=UpperCase(Self.Name) + '.ImpostaOraCorrente';
  GGetWebApplicationThreadVar.RegisterCallBack(CallBackName,ImpostaOraCorrente);

  //Fix per IE8, gli span:before e span:after non funzionano correttamente
  fixIE8:='false';
  if (GGetWebApplicationThreadVar.Browser is TInternetExplorer) and
     (GGetWebApplicationThreadVar.Browser.MajorVersion = 8) then
    fixIE8:='true';

  lblEntrata.Caption:=LABEL_ENTRATA_HTML;
  lblUscita.Caption:=LABEL_USCITA_HTML;
  lblEntrata.Visible:=not SolaLettura;
  lblUscita.Visible:=not SolaLettura;
  lblOraEntrata.Visible:=not SolaLettura and EsistonoTolleranze;
  lblOraUscita.Visible:=not SolaLettura and EsistonoTolleranze;;

  Js:=Format('impostaOrologio(' + fixIE8 + '); setInterval(function () {processAjaxEvent("",null,"%s",false,null,false);}, 1000);',[CallBackName]);
  JQuery.onReady.Text:=JS;
end;

procedure TWc38FBollatriceVirtuale.cmbAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  //Usato AsyncClick e non click perchè vi è la funzione javascript che
  //richiama evento async ogni secondo.
  //un submit durante un evento async viene perso dal fantastico IW (bug segnalato e risposto che è una feature)
  GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(Format('SubmitClick("%s","",true); ',[btncambiaProgressivo.HTMLName]));
end;

procedure TWc38FBollatriceVirtuale.IWAppFormRender(Sender: TObject);
begin
  inherited;
  ImpostaOraCorrente(nil);
end;

procedure TWc38FBollatriceVirtuale.lblEntrataAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  //Usato AsyncClick e non click perchè vi è la funzione javascript che
  //richiama evento async ogni secondo.
  //un submit durante un evento async viene perso dal fantastico IW (bug segnalato e risposto che è una feature)
  DatiTimbratura.DataOraServer:=Now;
  GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(Format('SubmitClick("%s","",true); ',[btnRegistraEntrata.HTMLName]));
end;

procedure TWc38FBollatriceVirtuale.lblUscitaAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  //Usato AsyncClick e non click perchè vi è la funzione javascript che
  //richiama evento async ogni secondo.
  //un submit durante un evento async viene perso dal fantastico IW (bug segnalato e risposto che è una feature)
  DatiTimbratura.DataOraServer:=Now;
  GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(Format('SubmitClick("%s","",true); ',[btnRegistraUscita.HTMLName]));
end;

procedure TWc38FBollatriceVirtuale.btnEntrataAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  //Usato AsyncClick e non click perchè vi è la funzione javascript che
  //richiama evento async ogni secondo.
  //un submit durante un evento async viene perso dal fantastico IW (bug segnalato e risposto che è una feature)
  DatiTimbratura.DataOraServer:=Now;
  GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(Format('SubmitClick("%s","",true); ',[btnRegistraEntrata.HTMLName]));
end;

procedure TWc38FBollatriceVirtuale.btnUscitaAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  //Usato AsyncClick e non click perchè vi è la funzione javascript che
  //richiama evento async ogni secondo.
  //un submit durante un evento async viene perso dal fantastico IW (bug segnalato e risposto che è una feature)
  DatiTimbratura.DataOraServer:=Now;
  GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(Format('SubmitClick("%s","",true); ',[btnRegistraUscita.HTMLName]));
end;

function TWc38FBollatriceVirtuale.GetDescVerso(const PVerso: String): String;
begin
  Result:=IfThen(PVerso = 'E','entrata','uscita');
end;

function TWc38FBollatriceVirtuale.CtrlRegistraTimbratura: String;
// restituire un messaggio per generare un warning non bloccante per l'utente
// controllo 1:
//   verifica la corretta sequenza delle timbrature Entrata/Uscita, controllando il verso
//   dell’ultima timbratura esistente antecedente all’ora considerata (anche nel giorno precedente)
//   restituisce un messaggio di avviso non bloccante in caso la sequenza non sia corretta
// controllo 2:
//   se il dipendente non è turnista, e timbra l'uscita come prima timbratura della giornata,
//   allora dà un messaggio particolare
var
  LTimbPrec: TDatiTimbratura;
  LGiorno: String;
begin
  Result:='';

  // inizializza dati timbratura precedente
  LTimbPrec.Progressivo:=0;
  LTimbPrec.DataOraServer:=DATE_NULL;
  LTimbPrec.Data:=DATE_NULL;
  LTimbPrec.Ora:=DATE_NULL;
  LTimbPrec.Verso:='';
  LTimbPrec.Causale:='';
  LTimbPrec.Rilevatore:='';

  // estrae i dati della timbratura precedente a quella corrente
  Wc38DM.selVT100TimbPrec.Close;
  Wc38DM.selVT100TimbPrec.SetVariable('PROGRESSIVO',DatiTimbratura.Progressivo);
  Wc38DM.selVT100TimbPrec.SetVariable('DATA_TIMB',DatiTimbratura.Ora);
  Wc38DM.selVT100TimbPrec.Open;
  if Wc38DM.selVT100TimbPrec.RecordCount > 0 then
  begin
    // controllo 1
    //   verifica sequenza timbrature

    // salva dati timbratura precedente in struttura di appoggio
    LTimbPrec.Progressivo:=Wc38DM.selVT100TimbPrec.FieldByName('PROGRESSIVO').AsInteger;
    LTimbPrec.Data:=Wc38DM.selVT100TimbPrec.FieldByName('DATA').AsDateTime;
    LTimbPrec.Ora:=Wc38DM.selVT100TimbPrec.FieldByName('ORA').AsDateTime;
    LTimbPrec.Verso:=Wc38DM.selVT100TimbPrec.FieldByName('VERSO').AsString;
    LTimbPrec.Causale:=Wc38DM.selVT100TimbPrec.FieldByName('CAUSALE').AsString;
    LTimbPrec.Rilevatore:=Wc38DM.selVT100TimbPrec.FieldByName('RILEVATORE').AsString;

    // giorno di timbratura precedente rispetto alla timbratura corrente
    if LTimbPrec.Data = DatiTimbratura.Data - 1 then
      LGiorno:='ieri'
    else if LTimbPrec.Data = DatiTimbratura.Data then
      LGiorno:='' // oggi
    else
      LGiorno:=R180NomeGiorno(LTimbPrec.Data) + ' ' + FormatDateTime('dd/mm/yyyy',LTimbPrec.Data);

    // verifica che il verso in inserimento sia diverso da quello della timbratura precedente
    if DatiTimbratura.Verso = LTimbPrec.Verso then
    begin
      // sequenza non corretta -> messaggio di avviso
      Result:=Format('La timbratura non è in sequenza.'#13#10 +
                     'Timbratura richiesta: %s %s'#13#10 +
                     'Ultima timbratura fatta: %s %s %s'#13#10 +
                     'Confermare?',
                     [R180Capitalize(GetDescVerso(DatiTimbratura.Verso)),
                      FormatDateTime(FORMATO_ORA_TIMB,DatiTimbratura.Ora),
                      LGiorno,
                      R180Capitalize(GetDescVerso(LTimbPrec.Verso)),
                      FormatDateTime(FORMATO_ORA_TIMB,LTimbPrec.Ora)]);
    end;
  end;

  // controllo 2
  //   per i non turnisti, se la timbratura è un'uscita,
  //   ed è la prima della giornata dà un messaggio particolare
  if Result = '' then
  begin
    if (R180In(selAnagrafeW.FieldByName('T430TGESTIONE').AsString,['','0'])) and
       (DatiTimbratura.Verso = 'U') and
       (DatiTimbratura.Data <> LTimbPrec.Data) then
    begin
      // prima timbratura: uscita -> messaggio di avviso
      Result:=Format('Timbratura richiesta: %s %s'#13#10 +
                     'La prima timbratura della giornata sarà un''uscita.'#13#10 +
                     'Confermare?',
                     [R180Capitalize(GetDescVerso(DatiTimbratura.Verso)),
                      FormatDateTime(FORMATO_ORA_TIMB,DatiTimbratura.Ora)]);
    end;
  end;
end;

procedure TWc38FBollatriceVirtuale.RefreshPage;
begin
  VisualizzaDipendenteCorrente;
end;

procedure TWc38FBollatriceVirtuale.RegistraTimbratura;
var
  LKey, LMsg, sOraT100: String;
  LDeltaMinuti: Integer;
  LDataOraT100: TDateTime;
begin
  // data / ora effettive in base ai parametri di tolleranza
  LDeltaMinuti:=IfThen(DatiTimbratura.Verso = 'E',-ParMinutiTolleranzaE,ParMinutiTolleranzaU);
  LDataOraT100:=IncMinute(DatiTimbratura.DataOraServer,LDeltaMinuti);

  // imposta i dati della timbratura
  DatiTimbratura.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  DatiTimbratura.Ora:=LDataOraT100;
  DatiTimbratura.Data:=Trunc(LDataOraT100);
  if cmbCausale.Visible then
    DatiTimbratura.Causale:=cmbCausale.Items.ValueFromIndex[cmbCausale.ItemIndex]
  else
    DatiTimbratura.Causale:='';

  // verifica la corretta sequenza delle timbrature E / U
  LKey:='CTRL';
  if not MsgBox.KeyExists(LKey) then
  begin
    LMsg:=CtrlRegistraTimbratura;
    if LMsg <> '' then
    begin
      // messaggio di warning non bloccante
      MsgBox.WebMessageDlg(LMsg,mtWarning,[mbYes,mbNo],ResultConferma,LKey,'Verifica timbratura');
      Abort;
    end
    else
    begin
      // anche se non ci sono warning particolari, dà comunque un messaggio di conferma
      LMsg:=Format('Confermare la timbratura di %s alle ore %s?',
                   [GetDescVerso(DatiTimbratura.Verso),
                    FormatDateTime(FORMATO_ORA_TIMB,DatiTimbratura.Ora)]);
      MsgBox.WebMessageDlg(LMsg,mtConfirmation,[mbYes,mbNo],ResultConferma,LKey,'Conferma timbratura');
      Abort;
    end;
  end;

  // registrazione timbratura
  try
    sOraT100:=FormatDateTime('hhhh:nn:ss',DatiTimbratura.Ora);

    // salvataggio timbratura su T100
    Wc38DM.insT100.SetVariable('PROGRESSIVO',DatiTimbratura.Progressivo);
    Wc38DM.insT100.SetVariable('DATA',DatiTimbratura.Data);
    Wc38DM.insT100.SetVariable('ORA',sOraT100);
    Wc38DM.insT100.SetVariable('VERSO',DatiTimbratura.Verso);
    Wc38DM.insT100.SetVariable('CAUSALE',DatiTimbratura.Causale);
    Wc38DM.insT100.SetVariable('FLAG','O');
    Wc38DM.insT100.SetVariable('RILEVATORE',DatiTimbratura.Rilevatore);
    Wc38DM.insT100.Execute;
    SessioneOracle.Commit;

    // log operazione
    RegistraLog.SettaProprieta('I','T100_TIMBRATURE',medpCodiceForm,nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(DatiTimbratura.Progressivo));
    RegistraLog.InserisciDato('DATA_ORA_SERVER','',DateTimeToStr(DatiTimbratura.DataOraServer));
    RegistraLog.InserisciDato('DATA','',DateToStr(DatiTimbratura.Data));
    RegistraLog.InserisciDato('ORA','',sOraT100);
    RegistraLog.InserisciDato('VERSO','',DatiTimbratura.Verso);
    RegistraLog.InserisciDato('RILEVATORE','',DatiTimbratura.Rilevatore);
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
    if (WR000DM.PaginaSingola <> '') then
      MsgBox.WebMessageDlg('Timbratura inserita con successo',mtInformation,[mbOk],ResultTimbraturaEsci,'')
    else
      MsgBox.WebMessageDlg('Timbratura inserita con successo',mtInformation,[mbOk],ResultTimbraturaOk,'')
  except
    on E: Exception do
    begin
      MsgBox.WebMessageDlg('Errore inserimento timbratura: ' + E.Message,mtError,[mbOk],nil,'');
      MsgBox.ClearKeys;
      Abort;
    end;
  end;
end;

procedure TWc38FBollatriceVirtuale.ResultConferma(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes: RegistraTimbratura;
    mrNo:  MsgBox.ClearKeys;
  end;
end;

procedure TWc38FBollatriceVirtuale.ResultTimbraturaEsci(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  // timbratura inserita -> uscita immediata nel caso di pagina singola
  lnkEsciClick(nil);
end;

procedure TWc38FBollatriceVirtuale.ResultTimbraturaOk(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  // la timbratura è stata inserita correttamente
  MsgBox.ClearKeys;
  VisualizzaDipendenteCorrente;
end;

procedure TWc38FBollatriceVirtuale.btnCambiaProgressivoClick(Sender: TObject);
begin
  OnCambiaProgressivo;
end;

procedure TWc38FBollatriceVirtuale.btnRegistraEntrataClick(Sender: TObject);
begin
  DatiTimbratura.Verso:='E';
  RegistraTimbratura;
  VisualizzaDipendenteCorrente;
end;

procedure TWc38FBollatriceVirtuale.btnRegistraUscitaClick(Sender: TObject);
begin
  DatiTimbratura.Verso:='U';
  RegistraTimbratura;
  VisualizzaDipendenteCorrente;
end;

procedure TWc38FBollatriceVirtuale.ImpostaOraCorrente(EventParams: TStringList);
var
  dNow: TDateTime;
begin
  dNow:=Now;
  lblOraCorrente.Caption:=FormatDateTime('hhhhnnss',dNow) + IntToStr(DayOfWeek(dNow) - 1);
  // entrata e uscita con i minuti di tolleranza
  if EsistonoTolleranze then
  begin
    lblOraEntrata.Caption:=FormatDateTime(FORMATO_ORA_TIMB,IncMinute(dNow,-ParMinutiTolleranzaE));
    lblOraUscita.Caption:=FormatDateTime(FORMATO_ORA_TIMB,IncMinute(dNow,ParMinutiTolleranzaU));
  end;
  if GGetWebApplicationThreadVar.IsCallBack then
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA('aggiornaOrologio();');
end;

end.
