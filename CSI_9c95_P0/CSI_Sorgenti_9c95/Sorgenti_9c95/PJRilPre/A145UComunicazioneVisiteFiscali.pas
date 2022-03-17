unit A145UComunicazioneVisiteFiscali;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, SelAnagrafe, Buttons, Mask,
  ExtCtrls, ComCtrls, StrUtils,
  C004UParamForm, C180FunzioniGenerali, A000UCostanti, A000USessione, A003UDataLavoroBis,
  A000UInterfaccia, C700USelezioneAnagrafe, C001StampaLib, QueryStorico,
  OracleData, Menus, Printers, DBCtrls, Math, Oracle, TypInfo, A000UMessaggi;

type
  TA145FComunicazioneVisiteFiscali = class(TForm)
    frmSelAnagrafe: TfrmSelAnagrafe;
    StatusBar: TStatusBar;
    ProgressBar: TProgressBar;
    pnlPulsantiStampa: TPanel;
    BtnPrinterSetUp: TBitBtn;
    btnAnteprima: TBitBtn;
    btnStampa: TBitBtn;
    BtnClose: TBitBtn;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    PrinterSetupDialog1: TPrinterSetupDialog;
    btnEsegui: TBitBtn;
    pmnuCausaliAssenza: TPopupMenu;
    SelezionaTuttoCau: TMenuItem;
    AnnullaTuttoCau: TMenuItem;
    pnlElenco: TPanel;
    grpCausali: TGroupBox;
    chkLCausali: TCheckListBox;
    Splitter1: TSplitter;
    grpDettaglio: TGroupBox;
    chkLDettaglio: TCheckListBox;
    pnlIndividuale: TPanel;
    memDato1: TMemo;
    memDato2: TMemo;
    memFirma: TMemo;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    GroupBox1: TGroupBox;
    chkLogo: TCheckBox;
    chkNumProt: TCheckBox;
    edtNumProt: TEdit;
    chkLuogo: TCheckBox;
    edtLuogo: TEdit;
    edtLogoLarg: TEdit;
    pnlTop: TPanel;
    grpOpzioni: TGroupBox;
    chkNote: TCheckBox;
    grpOperazioni: TGroupBox;
    chkIns: TCheckBox;
    chkCanc: TCheckBox;
    chkProl: TCheckBox;
    chkAnnulla: TCheckBox;
    Label2: TLabel;
    edtDataDa: TMaskEdit;
    btnDataDa: TBitBtn;
    Label1: TLabel;
    edtDataA: TMaskEdit;
    btnDataA: TBitBtn;
    chkPeriodiComunicati: TCheckBox;
    rgpTipoStampa: TRadioGroup;
    lblDataDa: TLabel;
    btnDataElaborazione: TBitBtn;
    edtDataElaborazione: TMaskEdit;
    Label3: TLabel;
    dcmbMedicineLegali: TDBLookupComboBox;
    dtxtMedicinaLegale: TDBText;
    chkAggiorna: TCheckBox;
    chkStampaAssMal: TCheckBox;
    grpEsenzioni: TGroupBox;
    lblMesiVerificaEventi: TLabel;
    lblMaxGiorniContinuativi: TLabel;
    chkEsenzioneAutomatica: TCheckBox;
    lblNumeroMinimoEventi: TLabel;
    btnEsenzioni: TBitBtn;
    edtMaxGiorniContinuativi: TEdit;
    edtMesiVerificaEventi: TEdit;
    edtNumeroMinimoEventi: TEdit;
    chkSoloCont: TCheckBox;
    chkFiltroDataComun: TCheckBox;
    procedure btnDataElaborazioneClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkLDettaglioMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure chkLDettaglioMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure btnDataAClick(Sender: TObject);
    procedure btnStampaClick(Sender: TObject);
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure opzioniClick(Sender: TObject);
    procedure btnDataDaClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure SelezionaTuttoCauClick(Sender: TObject);
    procedure edtDataDaChange(Sender: TObject);
    procedure rgpTipoStampaClick(Sender: TObject);
    procedure chkNumProtClick(Sender: TObject);
    procedure chkLuogoClick(Sender: TObject);
    procedure chkLogoClick(Sender: TObject);
    procedure btnEsenzioniClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure chkProlClick(Sender: TObject);
  private
    { Private declarations }
    ItemSposta: Integer;
    {AnnoP500,AnnoOld,AnnoNew: Integer;
    AnnoUnicoNelPeriodo: Boolean;}
    EsistonoComunicazioni: Boolean;
    DataUltimaComunicazione: TDateTime;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure AbilitaOperazioni;
    function Controlli: Boolean;
    function ControlliAnnullamento: Boolean;
    procedure ScorryQueryAnagrafica(Esenzioni:Boolean);
    //procedure CompensaPeriodiCan;
    procedure EstraiUltimaDataComunicazione;
    procedure PopolaDatiElab;
  public
    { Public declarations }
    DocumentoPDF,TipoModulo,MessaggioDCOM: String;
    //ListaDettaglio: TStringList;
    lstElementiDettaglioCOM: TStringList;
    Anteprima: Boolean;
  end;

var
  A145FComunicazioneVisiteFiscali: TA145FComunicazioneVisiteFiscali;
  procedure OpenA145ComunicazioneVisiteFiscali;

implementation

uses A145UComunicazioneVisiteFiscaliDtM, A145UStampaComunicazioneVisiteFiscali,
     A145UStampaIndividuale, A145UEsenzioni;

{$R *.dfm}

procedure OpenA145ComunicazioneVisiteFiscali;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA145ComunicazioniVisiteFiscali') of
    'N':begin
          ShowMessage('Funzione non abilitata!');
          Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TA145FComunicazioneVisiteFiscali,A145FComunicazioneVisiteFiscali);
  Application.CreateForm(TA145FComunicazioneVisiteFiscaliDtM,A145FComunicazioneVisiteFiscaliDtM);
  try
    Screen.Cursor:=crDefault;
    A145FComunicazioneVisiteFiscali.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A145FComunicazioneVisiteFiscali.Free;
    A145FComunicazioneVisiteFiscaliDtM.Free;
  end;
end;

procedure TA145FComunicazioneVisiteFiscali.EstraiUltimaDataComunicazione;
// estrae la data dell'ultima comunicazione presente sulla T047
begin
  DataUltimaComunicazione:=A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW.GetUltimaComunicazione;
  EsistonoComunicazioni:=(DataUltimaComunicazione > EncodeDate(1800,1,1));
  chkAnnulla.Enabled:=EsistonoComunicazioni and Not SolaLettura;
  chkAnnulla.Checked:=chkAnnulla.Checked and EsistonoComunicazioni;
end;

procedure TA145FComunicazioneVisiteFiscali.ScorryQueryAnagrafica(Esenzioni:Boolean);
begin
  // impostazioni progressbar
  ProgressBar.Position:=0;
  ProgressBar.Max:=C700SelAnagrafe.RecordCount;

  with A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW do
  begin
    InizioElaborazione(Esenzioni);

    // ciclo principale sulle persone selezionate
    SelAnagrafe.First;
    while not SelAnagrafe.EOF do
    begin
      frmSelAnagrafe.VisualizzaDipendente;

      // inizializzazione variabili di supporto
      //AnnoOld:=-1;

      ElaboraElemento(Esenzioni);
      // passa all'anagrafica successiva
      SelAnagrafe.Next;
      ProgressBar.StepBy(1);
    end;
  end;
end;

procedure TA145FComunicazioneVisiteFiscali.BtnPrinterSetUpClick(Sender: TObject);
// setup stampante
begin
  if PrinterSetUpDialog1.Execute then
  begin
    C001SettaQuickReport(A145FStampaComunicazioneVisiteFiscali.QRep);
  end;
end;

procedure TA145FComunicazioneVisiteFiscali.rgpTipoStampaClick(Sender: TObject);
begin
  btnEsenzioni.Enabled:=(rgpTipoStampa.ItemIndex = 0) and (not chkAnnulla.Checked);
  pnlElenco.Visible:=rgpTipoStampa.ItemIndex = 0;
  pnlIndividuale.Visible:=rgpTipoStampa.ItemIndex = 1;
  chkStampaAssMal.Visible:=rgpTipoStampa.ItemIndex = 0;
  // la stampa individuale considera solo i nuovi periodi (inserimenti)
  AbilitaOperazioni;
  if rgpTipoStampa.ItemIndex = 1 then
  begin
    //chkIns.Checked:=True;
    //chkProl.Checked:=False;
    chkCanc.Checked:=False;
  end;
end;

function TA145FComunicazioneVisiteFiscali.ControlliAnnullamento: Boolean;
// controlli per l'annullamento di una comunicazione
begin
  // conferma annullamento
  Result:=R180MessageBox(Format(A000MSG_A145_DLG_FMT_ANNULLAMENTO,[DateToStr(DataUltimaComunicazione)]),DOMANDA) = mrYes;
end;

procedure TA145FComunicazioneVisiteFiscali.edtDataDaChange(Sender: TObject);
var
  DataDaTemp,DataATemp:TDateTime;
begin
  if TryStrToDate(edtDataDa.EditText,DataDaTemp) and
     TryStrToDate(edtDataA.EditText,DataATemp) then
  begin
    // se la data di inizio periodo è successiva a quella di fine,
    // reimposta la data di fine = a quella di inizio
    if DataDaTemp > DataATemp then
      edtDataA.Text:=edtDataDa.Text;
  end;
end;

function TA145FComunicazioneVisiteFiscali.Controlli: Boolean;
// controlli per la generazione di una comunicazione / visualizzazione dei periodi comunicati
var
  Messaggio:String;
  Temp: Integer;
begin
  // pulizia variabili
  with A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW do
  begin
    DatiElab.DataElaborazione:=0;
    DatiElab.DataDa:=0;
    DatiElab.DataA:=0;
  end;

  // data elaborazione
  if not chkPeriodiComunicati.Checked then
  begin
    if not TryStrToDate(edtDataElaborazione.Text,A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.DataElaborazione) then
    begin
      if tipoModulo = 'CS' then
        R180MessageBox(A000MSG_A145_ERR_DATA_ELAB,INFORMA)
      else
        raise Exception.Create(A000MSG_A145_ERR_DATA_ELAB);
      edtDataElaborazione.SetFocus;
      Result:=False;
      Exit;
    end;
  end;

  // tipo operazione
  if not (chkIns.Checked or chkProl.Checked or chkCanc.Checked) and (Not chkFiltroDataComun.Checked) then
  begin
    if tipoModulo = 'CS' then
      R180MessageBox(A000MSG_A145_ERR_TIPO_OPERAZIONE,INFORMA)
    else
      raise Exception.Create(A000MSG_A145_ERR_TIPO_OPERAZIONE);

    chkIns.SetFocus;
    Result:=False;
    Exit;
  end;

  if ((chkIns.Checked or chkProl.Checked) and chkCanc.Checked) or chkFiltroDataComun.Checked then
    A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.Operazione:='%'
  else if (chkIns.Checked or chkProl.Checked) then
    A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.Operazione:='I'
  else
    A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.Operazione:='C';

  // controlli per stampa individuale
  if rgpTipoStampa.ItemIndex = 1 then
  begin
    // logo
    if chkLogo.Checked then
    begin
      if edtLogoLarg.Text = '' then
      begin
        if tipoModulo = 'CS' then
          R180MessageBox(A000MSG_A145_ERR_NO_LOGO_LARG,INFORMA)
        else
          raise Exception.Create(A000MSG_A145_ERR_NO_LOGO_LARG);
        edtLogoLarg.SetFocus;
        Result:=False;
        Exit;
      end
      else if not TryStrToInt(edtLogoLarg.Text,Temp) then
      begin
        if tipoModulo = 'CS' then
          R180MessageBox(A000MSG_A145_ERR_LOGO_LARG,INFORMA)
        else
          raise Exception.Create(A000MSG_A145_ERR_LOGO_LARG);

        edtLogoLarg.SetFocus;
        Result:=False;
        Exit;
      end;
    end;

    // num. protocollo
    if chkNumProt.Checked then
    begin
      if edtNumProt.Text = '' then
      begin
        if tipoModulo = 'CS' then
          R180MessageBox(A000MSG_A145_ERR_NO_NUM_PROT,INFORMA)
        else
          raise Exception.Create(A000MSG_A145_ERR_NO_NUM_PROT);
        edtNumProt.SetFocus;
        Result:=False;
        Exit;
      end
    end;

    // luogo di stampa
    if chkLuogo.Checked then
    begin
      if edtLuogo.Text = '' then
      begin
        if tipoModulo = 'CS' then
          R180MessageBox(A000MSG_A145_ERR_NO_LUOGO,INFORMA)
        else
          raise Exception.Create(A000MSG_A145_ERR_NO_LUOGO);
        edtLuogo.SetFocus;
        Result:=False;
        Exit;
      end
    end;
  end;

  // controlli in base all'opzione scelta
  if chkPeriodiComunicati.Checked or chkFiltroDataComun.Checked then
  begin
    // controlli per "includi periodi già comunicati"
    if not TryStrToDate(edtDataDa.Text, A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.DataDa) then
    begin
      if tipoModulo = 'CS' then
        R180MessageBox(A000MSG_A145_ERR_DATA_INIZIO_PERIODO,INFORMA)
      else
        raise Exception.Create(A000MSG_A145_ERR_DATA_INIZIO_PERIODO);
      edtDataDa.SetFocus;
      Result:=False;
      Exit;
    end;

    if not TryStrToDate(edtDataA.Text,A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.DataA) then
    begin
      if tipoModulo = 'CS' then
        R180MessageBox(A000MSG_A145_ERR_DATA_FINE_PERIODO,INFORMA)
      else
        raise Exception.Create(A000MSG_A145_ERR_DATA_FINE_PERIODO);
      edtDataA.SetFocus;
      Result:=False;
      Exit;
    end;

    if A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.DataDa > A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.DataA then
    begin
      if tipoModulo = 'CS' then
        R180MessageBox(A000MSG_A145_ERR_PERIODO,INFORMA)
      else
        raise Exception.Create(A000MSG_A145_ERR_PERIODO);
      edtDataA.SetFocus;
      Result:=False;
      Exit;
    end;
  end
  else if chkAggiorna.Checked then
  begin
    // controlli per "aggiornamento data comunicazione"

    // blocca se la data di comunicazione non è successiva all'ultima in archivio
    if A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.DataElaborazione < DataUltimaComunicazione then
    begin
      if tipoModulo = 'CS' then
        R180MessageBox(Format(A000MSG_A145_ERR_COM_PRECEDENTE,[FormatDateTime('dd/mm/yyyy',DataUltimaComunicazione)]),INFORMA)
      else
        raise Exception.Create(Format(A000MSG_A145_ERR_COM_PRECEDENTE,[FormatDateTime('dd/mm/yyyy',DataUltimaComunicazione)]));
      edtDataElaborazione.SetFocus;
      Result:=False;
      Exit;
    end;

    if tipoModulo = 'CS' then
    begin
      // chiede conferma se data elaborazione è precedente a quella odierna
      if A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.DataElaborazione < Date then
      begin
        Messaggio:=A000MSG_A145_DLG_COM_PREC_SYSDATE;
        if R180MessageBox(Messaggio,DOMANDA) = mrNo then
        begin
          edtDataElaborazione.SetFocus;
          Result:=False;
          Exit;
        end;
      end;

      // conferma aggiornamento
      if dcmbMedicineLegali.KeyValue = null then
        Messaggio:=A000MSG_A145_DLG_AGGIORNAMENTO
      else
        Messaggio:=A000MSG_A145_DLG_AGGIORNAMENTO_MED_LEG;
      if R180MessageBox(Messaggio,DOMANDA) = mrNo then
      begin
        edtDataElaborazione.SetFocus;
        Result:=False;
        Exit;
      end;
    end;
  end;

  // variabile di appoggio per elaborazione dati di domicilio
  {if chkPeriodiComunicati.Checked then
  begin
    AnnoUnicoNelPeriodo:=(R180Anno(DataDa) = R180Anno(DataA));
    AnnoP500:=IfThen(AnnoUnicoNelPeriodo,R180Anno(DataDa),0);
  end
  else
  begin
    AnnoUnicoNelPeriodo:=True;
    AnnoP500:=R180Anno(DataElaborazione);
  end;}

  // controlli ok
  Result:=True;
end;

procedure TA145FComunicazioneVisiteFiscali.PopolaDatiElab;
var
  i: Integer;
begin
  with A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW do
  begin
    DatiElab.bAggiorna:=chkAggiorna.Checked;
    DatiElab.bPeriodiComunicati:=chkPeriodiComunicati.Checked;
    DatiElab.bNumProt:=chkNumProt.Checked;
    DatiElab.sNumProt:=edtNumProt.Text;
    DatiElab.bLuogo:=chkLuogo.Checked;
    DatiElab.sLuogo:=edtLuogo.Text;
    DatiElab.sDato1:=memDato1.Text;
    DatiElab.sDato2:=memDato2.Text;
    DatiElab.sFirma:=memFirma.Text;
    DatiElab.bProl:=chkProl.Checked;
    DatiElab.sMedicineLegali:='';
    if dcmbMedicineLegali.KeyValue <> null then
      DatiElab.sMedicineLegali:=VarToStr(dcmbMedicineLegali.KeyValue);
    DatiElab.bEsenzioneAutomatica:=chkEsenzioneAutomatica.Checked;
    DatiElab.iTipoStampa:=rgpTipoStampa.ItemIndex;
    DatiElab.sMaxGiorniContinuativi:=edtMaxGiorniContinuativi.Text;
    DatiElab.sMesiVerificaEventi:=edtMesiVerificaEventi.Text;
    DatiElab.sNumeroMinimoEventi:=edtNumeroMinimoEventi.Text;
    DatiElab.bFiltroDataComun:=chkFiltroDataComun.Checked;
    DatiElab.bSoloCont:=chkSoloCont.Checked;

    // valorizza la stringlist dei campi di dettaglio richiesti
    DatiElab.ListaDettaglio.Clear;
    if TipoModulo = 'CS' then
    begin
      for i:=0 to chkLDettaglio.Items.Count - 1 do
        if chkLDettaglio.Checked[i] then
          DatiElab.ListaDettaglio.Add(VarToStr(selI010.Lookup('NOME_LOGICO',chkLDettaglio.Items[i],'NOME_CAMPO')));
    end
    else
    begin
      for i:=0 to lstElementiDettaglioCOM.Count - 1 do
        DatiElab.ListaDettaglio.Add(VarToStr(selI010.Lookup('NOME_LOGICO',lstElementiDettaglioCOM[i],'NOME_CAMPO')));
    end;
  end;
end;

procedure TA145FComunicazioneVisiteFiscali.btnStampaClick(Sender: TObject);
// gestione della stampa dei periodi di assenza da comunicare / comunicati
var
  S:String;
  DataInizio,DataFine:TDateTime;
begin
   MessaggioDCOM:='';

  if not Controlli then
    Exit;
  //popolo con i dati dell'interfaccia
  PopolaDatiElab;

  Screen.Cursor:=crHourGlass;
  Anteprima:=Sender = btnAnteprima;

  {
  // valorizza la stringlist delle causali
  ListaCausali.Clear;
  for i:=0 to chkLCausali.Items.Count - 1 do
    if chkLCausali.Checked[i] then
      ListaCausali.Add(Trim(Copy(chkLCausali.Items[i],1,5)));
  }
  with A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW do
  begin
    DataInizio:=IfThen(DatiElab.bPeriodiComunicati,DatiElab.DataDa,DatiElab.DataElaborazione);
    DataFine:=IfThen(DatiElab.bPeriodiComunicati,DatiElab.DataA,DatiElab.DataElaborazione);
  end;
  if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DataInizio,DataFine) then
    C700SelAnagrafe.CloseAll;

  A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.SelAnagrafe:=C700SelAnagrafe;
  A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.ImpostaCampiSelAnagrafe;

  if C700SelAnagrafe.RecordCount = 0 then
  begin
    Screen.Cursor:=crDefault;
    raise Exception.Create(A000MSG_ERR_NO_DIP);
  end;

  // creazione client dataset per la stampa
  A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW.CreaTabellaStampa;

  // se il periodo è all'interno dello stesso anno estrae i nomi
  // delle colonne del domicilio per i dipendenti già in questa fase
  {if AnnoUnicoNelPeriodo then
    EstraiColonneDomicilioP500(AnnoP500);}

  // cerca di compattare i periodi di assenza sulla T047
  StatusBar.Panels[1].Text:='Ottimizzazione periodi di assenza in corso...';
  StatusBar.Repaint;
  A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW.OttimizzaPeriodi;

  StatusBar.Panels[1].Text:='';
  StatusBar.Repaint;

  // elabora la stampa ed aggiorna eventualmente la tabella T047
  ScorryQueryAnagrafica((Sender = btnEsenzioni));

  if A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW.TabellaStampa.RecordCount > 0 then
  begin
    if (Sender = btnEsenzioni) then
    begin
      A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW.CreaTabellaEsenzioni;
      OpenA145Esenzioni;
    end
    else
    begin
      // procede con la stampa
      if rgpTipoStampa.ItemIndex = 0 then
      begin
        with A145FStampaComunicazioneVisiteFiscali do
        begin
          // imposta l'orientamento pagina fisso a "orizzontale"
          QRep.Page.Orientation:=poLandscape;
          // crea il report
          CreaReport;
          DistruggiLstObj;
        end;
      end
      else
        // crea il report
        A145FStampaIndividuale.CreaReport;
      // aggiorna i dati dell'ultima data di comunicazione
      if chkAggiorna.Checked then
        EstraiUltimaDataComunicazione;
    end;
  end
  else
  begin
    S:=A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW.MessaggioNessunPeriodo(chkPeriodiComunicati.Checked);
    if tipoModulo = 'CS' then
      R180MessageBox(s,INFORMA)
    else
      raise Exception.Create(s);
  end;
  
  // chiusura dataset
  A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW.TabellaStampa.Close;

  // riporta alla situazione iniziale
  C700SelAnagrafe.First;
  frmSelAnagrafe.VisualizzaDipendente;
  ProgressBar.Position:=0;
  Screen.Cursor:=crDefault;
end;

procedure TA145FComunicazioneVisiteFiscali.btnEseguiClick(Sender: TObject);
// Annulla l'ultima comunicazione presente in archivio per tutte le medicine legali
begin
  // fase di controllo

  if TipoModulo = 'CS' then
    if not ControlliAnnullamento then
      Exit;
  Screen.Cursor:=crHourGlass;

  with A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW do
  begin
    selT047PAnnullato.Close;
    selT047PAnnullato.SetVariable('DATA_ANNULLAMENTO',DataUltimaComunicazione);
    selT047PAnnullato.Open;

    // impostazioni progressbar
    ProgressBar.Position:=0;
    ProgressBar.Max:=selT047PAnnullato.RecordCount;

    // ciclo di annullamento
    selT047PAnnullato.First;
    while not selT047PAnnullato.Eof do
    begin
      AnnullaDataComunicazione(DataUltimaComunicazione);
      selT047PAnnullato.Next;
      ProgressBar.StepBy(1);
    end;

    // prova a compattare i periodi sulla T047
    StatusBar.Panels[1].Text:='Ottimizzazione periodi di assenza in corso...';
    StatusBar.Repaint;
    CompensaPeriodi;
    UnificaPeriodi;
    StatusBar.Panels[1].Text:='';
    StatusBar.Repaint;
    MessaggioDCOM:='';
    if TipoModulo = 'CS' then
      R180MessageBox(Format(A000MSG_A145_MSG_FMT_CONFERMA_ANNULLAMENTO,[DateToStr(DataUltimaComunicazione)]),INFORMA)
    else
      MessaggioDCOM:=Format(A000MSG_A145_MSG_FMT_CONFERMA_ANNULLAMENTO,[DateToStr(DataUltimaComunicazione)]);
    EstraiUltimaDataComunicazione;

    // riporta alla situazione iniziale
    ProgressBar.Position:=0;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA145FComunicazioneVisiteFiscali.btnEsenzioniClick(Sender: TObject);
begin
  dcmbMedicineLegali.KeyValue:=null;
  A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.selT485.Refresh;
  dcmbMedicineLegali.Refresh;
  chkIns.Checked:=True;
  chkProl.Checked:=True;
  chkCanc.Checked:=True;
  chkPeriodiComunicati.Checked:=False;
  chkAggiorna.Checked:=False;
  chkAnnulla.Checked:=False;
  btnStampaClick(btnEsenzioni);
end;

procedure TA145FComunicazioneVisiteFiscali.btnDataElaborazioneClick(Sender: TObject);
begin
  edtDataElaborazione.Text:=FormatDateTime('dd/mm/yyyy',(DataOut(StrToDate(edtDataElaborazione.Text),'Data di elaborazione','G')));
end;

procedure TA145FComunicazioneVisiteFiscali.btnDataDaClick(Sender: TObject);
begin
  edtDataDa.Text:=FormatDateTime('dd/mm/yyyy',(DataOut(StrToDate(edtDataDa.Text),'Data iniziale del periodo','G')));
end;

procedure TA145FComunicazioneVisiteFiscali.btnDataAClick(Sender: TObject);
begin
  edtDataA.Text:=FormatDateTime('dd/mm/yyyy',(DataOut(StrToDate(edtDataA.Text),'Data finale del periodo','G')));
end;

procedure TA145FComunicazioneVisiteFiscali.FormShow(Sender: TObject);
var
  lstCampiAnagrafici: TStringList;
  s: String;
begin
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,0,True);
  frmSelAnagrafe.SelezionePeriodica:=False;
  CreaC004(SessioneOracle,'A145',Parametri.ProgOper);

  //propone la data di elaborazione
  edtDataElaborazione.Text:=DateToStr(Parametri.DataLavoro);

  chkAggiorna.Enabled:=Not SolaLettura;
  try
    lstCampiAnagrafici:=TStringList.Create();
    A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.getLstCampiAnagrafici(lstCampiAnagrafici);
    for s in lstCampiAnagrafici do
      chkLDettaglio.Items.Add(s);
  finally
    FreeAndNil(lstCampiAnagrafici);
  end;
  A145FStampaComunicazioneVisiteFiscali.ImpostaDataset;
  A145FStampaIndividuale.ImpostaDataset;

  GetParametriFunzione;
  EstraiUltimaDataComunicazione;
end;

procedure TA145FComunicazioneVisiteFiscali.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  try
    C700DataDal:=StrToDate(edtDataElaborazione.Text);
    C700DataLavoro:=StrToDate(edtDataElaborazione.Text);
  except
    C700DataDal:=Parametri.DataLavoro;
    C700DataLavoro:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA145FComunicazioneVisiteFiscali.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA145FComunicazioneVisiteFiscali.GetParametriFunzione;
// Lettura parametri della form
var
  S:String;
  i:Integer;
begin
  rgpTipoStampa.ItemIndex:=StrToIntDef(C004FParamForm.GetParametro('TIPOSTAMPA','0'),0);
  chkIns.Checked:=C004FParamForm.GetParametro('INSERIMENTO','N') = 'S';
  chkProl.Checked:=C004FParamForm.GetParametro('PROLUNGAMENTO','N') = 'S';
  chkCanc.Checked:=C004FParamForm.GetParametro('CANCELLAZIONE','N') = 'S';
  //abiltiazione di chkSoloCont in base a valore id chkProl
  chkProlClick(nil);
  chkNote.Checked:=C004FParamForm.GetParametro('CHKNOTE','N') = 'S';

  chkStampaAssMal.Checked:=C004FParamForm.GetParametro('CHKSTAMPAASSMAL','N') = 'S';
  chkEsenzioneAutomatica.Checked:=C004FParamForm.GetParametro('ESENZIONEAUTO','N') = 'S';
  edtNumeroMinimoEventi.Text:=C004FParamForm.GetParametro('NUMEROMINEVENTI','');
  edtMaxGiorniContinuativi.Text:=C004FParamForm.GetParametro('GIORNICONTINUATIVI','');
  edtMesiVerificaEventi.Text:=C004FParamForm.GetParametro('MESIEVENTI','');

  chkLogo.Checked:=C004FParamForm.GetParametro('CHKLOGO','N') = 'S';
  edtLogoLarg.Text:=C004FParamForm.GetParametro('EDTLOGOLARG','');
  chkNumProt.Checked:=C004FParamForm.GetParametro('CHKNUMPROT','N') = 'S';
  edtNumProt.Text:=C004FParamForm.GetParametro('EDTNUMPROT','');
  chkLuogo.Checked:=C004FParamForm.GetParametro('CHKLUOGO','N') = 'S';
  edtLuogo.Text:=C004FParamForm.GetParametro('EDTLUOGO','');
  memDato1.Text:=C004FParamForm.GetParametro('DATOLIBERO1','');
  memDato2.Text:=C004FParamForm.GetParametro('DATOLIBERO2','');
  memFirma.Text:=C004FParamForm.GetParametro('FIRMA','');

  // opzioni
  if A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.C004_SALVA_OPZIONI then
  begin
    chkPeriodiComunicati.Checked:=(C004FParamForm.GetParametro('PERIODI_COMUNICATI','N') = 'S');
    chkAggiorna.Checked:=(C004FParamForm.GetParametro('AGGIORNAMENTO','N') = 'S');
    chkAnnulla.Checked:=(C004FParamForm.GetParametro('ANNULLAMENTO','N') = 'S');
  end
  else
  begin
    chkPeriodiComunicati.Checked:=False;
    chkAggiorna.Checked:=False;
    chkAnnulla.Checked:=False;
  end;

  // abilitazione periodo per opzione "includi periodi già comunicati"
  edtDataDa.Enabled:=chkPeriodiComunicati.Checked;
  btnDataDa.Enabled:=chkPeriodiComunicati.Checked;
  edtDataA.Enabled:=chkPeriodiComunicati.Checked;
  btnDataA.Enabled:=chkPeriodiComunicati.Checked;

  // abilitazione pulsanti di gestione
  BtnPrinterSetUp.Enabled:=not chkAnnulla.Checked;
  btnAnteprima.Enabled:=not chkAnnulla.Checked;
  btnStampa.Enabled:=not chkAnnulla.Checked;
  btnEsenzioni.Enabled:=(rgpTipoStampa.ItemIndex = 0) and (not chkAnnulla.Checked);
  btnEsegui.Enabled:=chkAnnulla.Checked;

  // elenco campi di dettaglio
  if A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW.selI010 <> nil then
  begin
    S:=C004FParamForm.GetParametro('LISTA_DETTAGLI','');
    if Trim(S) <> '' then
    begin
      for i:=0 to chkLDettaglio.Items.Count - 1 do
        if Pos(VarToStr(A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW.selI010.Lookup('NOME_LOGICO',chkLDettaglio.Items[i],'NOME_CAMPO')),S) > 0 then
          chkLDettaglio.Checked[i]:=True;
    end;
  end;

  // elenco lista causali di assenza
  {
  S:=C004FParamForm.GetParametro('LISTA_CAUSALI','#ND#');
  if S <> '#ND#' then
    R180PutCheckList(S,5,chkLCausali);
  }  
end;

procedure TA145FComunicazioneVisiteFiscali.PutParametriFunzione;
// Salva i parametri della form
begin
  C004FParamForm.Cancella001;

  C004FParamForm.PutParametro('TIPOSTAMPA',IntToStr(rgpTipoStampa.ItemIndex));
  C004FParamForm.PutParametro('INSERIMENTO',IfThen(chkIns.Checked,'S','N'));
  C004FParamForm.PutParametro('PROLUNGAMENTO',IfThen(chkProl.Checked,'S','N'));
  C004FParamForm.PutParametro('CANCELLAZIONE',IfThen(chkCanc.Checked,'S','N'));
  C004FParamForm.PutParametro('ESENZIONEAUTO',IfThen(chkEsenzioneAutomatica.Checked,'S','N'));
  C004FParamForm.PutParametro('NUMEROMINEVENTI',edtNumeroMinimoEventi.Text);
  C004FParamForm.PutParametro('GIORNICONTINUATIVI',edtMaxGiorniContinuativi.Text);
  C004FParamForm.PutParametro('MESIEVENTI',edtMesiVerificaEventi.Text);
  C004FParamForm.PutParametro('CHKLOGO',IfThen(chkLogo.Checked,'S','N'));
  C004FParamForm.PutParametro('EDTLOGOLARG',edtLogoLarg.Text);
  C004FParamForm.PutParametro('CHKNUMPROT',IfThen(chkNumProt.Checked,'S','N'));
  C004FParamForm.PutParametro('EDTNUMPROT',edtNumProt.Text);
  C004FParamForm.PutParametro('CHKLUOGO',IfThen(chkLuogo.Checked,'S','N'));
  C004FParamForm.PutParametro('CHKNOTE',IfThen(chkNote.Checked,'S','N'));
  C004FParamForm.PutParametro('CHKSTAMPAASSMAL',IfThen(chkNote.Checked,'S','N'));
  C004FParamForm.PutParametro('EDTLUOGO',edtLuogo.Text);
  C004FParamForm.PutParametro('DATOLIBERO1',memDato1.Text);
  C004FParamForm.PutParametro('DATOLIBERO2',memDato2.Text);
  C004FParamForm.PutParametro('FIRMA',memFirma.Text);
  // opzioni
  if A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.C004_SALVA_OPZIONI then
  begin
    C004FParamForm.PutParametro('PERIODI_COMUNICATI',IfThen(chkPeriodiComunicati.Checked,'S','N'));
    C004FParamForm.PutParametro('AGGIORNAMENTO',IfThen(chkAggiorna.Checked,'S','N'));
    C004FParamForm.PutParametro('ANNULLAMENTO',IfThen(chkAnnulla.Checked,'S','N'));
  end;

  // Nota
  //  Viene usato un metodo super grezzo per la gestione delle liste di codici:
  //  l'elenco è troncato brutalmente a 80 caratteri

  // elenco campi dettaglio
  with A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW do
  begin
    if Length(DatiElab.ListaDettaglio.Text) > 80 then
      DatiElab.ListaDettaglio.Text:=Copy(DatiElab.ListaDettaglio.Text,1,80);
    C004FParamForm.PutParametro('LISTA_DETTAGLI',DatiElab.ListaDettaglio.Text);
  end;
  // elenco causali per calcolo periodi assenza ultimo anno
  //if Length(ListaCausali.Text) > 80 then
  //  ListaCausali.Text:=Copy(ListaCausali.Text,1,80);
  //C004FParamForm.PutParametro('LISTA_CAUSALI',ListaCausali.Text);

  try SessioneOracle.Commit; except end;
end;

procedure TA145FComunicazioneVisiteFiscali.Selezionatutto1Click(Sender: TObject);
var i: integer;
begin
  with (PopupMenu1.PopupComponent as TCheckListBox) do
  begin
    for i:=0 to Items.Count - 1 do
      Checked[i]:=(Sender = SelezionaTutto1);
  end;
end;

procedure TA145FComunicazioneVisiteFiscali.SelezionaTuttoCauClick(Sender: TObject);
var i: integer;
begin
  with (pmnuCausaliAssenza.PopupComponent as TCheckListBox) do
  begin
    for i:=0 to Items.Count - 1 do
      Checked[i]:=(Sender = SelezionaTuttoCau);
  end;
end;

procedure TA145FComunicazioneVisiteFiscali.AbilitaOperazioni;
begin
  chkIns.Enabled:={(rgpTipoStampa.ItemIndex = 0) and }(not chkAnnulla.Checked);
  chkProl.Enabled:={(rgpTipoStampa.ItemIndex = 0) and }(not chkAnnulla.Checked);
  chkCanc.Enabled:=(rgpTipoStampa.ItemIndex = 0) and (not chkAnnulla.Checked);
end;

procedure TA145FComunicazioneVisiteFiscali.opzioniClick(Sender: TObject);

  procedure GestioneGrpBox;
  begin
    grpOperazioni.Enabled:=Not chkFiltroDataComun.Checked;
    grpOperazioni.Font.Color:=IfThen(grpOperazioni.Enabled,clBlue,clGray);    
    chkIns.Font.Color:=IfThen(grpOperazioni.Enabled,clBlue,clGray);    
    chkProl.Font.Color:=IfThen(grpOperazioni.Enabled,clBlue,clGray);    
    chkCanc.Font.Color:=IfThen(grpOperazioni.Enabled,clBlue,clGray);    
    chkSoloCont.Font.Color:=IfThen(grpOperazioni.Enabled,clBlue,clGray);    
  end;
  
begin
  // disabilita temporaneamente la gestione degli eventi onclick sui checkbox
  chkPeriodiComunicati.OnClick:=nil;
  chkAggiorna.OnClick:=nil;
  chkAnnulla.OnClick:=nil;
  chkFiltroDataComun.OnClick:=nil;
  GestioneGrpBox;
  if (Sender = chkFiltroDataComun) and chkPeriodiComunicati.Checked then
    chkPeriodiComunicati.Checked:=False;
  if (Sender = chkPeriodiComunicati) and chkFiltroDataComun.Checked then
    grpOperazioni.Enabled:=False;
  if (Sender = chkPeriodiComunicati) or (Sender = chkFiltroDataComun) then
  begin
    if chkEsenzioneAutomatica.Checked then
      chkEsenzioneAutomatica.Checked:=False;
    chkEsenzioneAutomatica.Enabled:=not chkPeriodiComunicati.Checked and Not chkFiltroDataComun.Checked;
  end;
  // disabilita gli altri check (sono tutti in esclusiva)
  if chkAggiorna <> Sender then
    chkAggiorna.Checked:=False;
  if chkAnnulla <> Sender then
    chkAnnulla.Checked:=False;
  if Sender <> chkPeriodiComunicati then
    chkPeriodiComunicati.Checked:=False;

  // abilitazione data elaborazione
  edtDataElaborazione.Enabled:=not(chkPeriodiComunicati.Checked or chkAnnulla.Checked or chkFiltroDataComun.Checked);
  btnDataElaborazione.Enabled:=not(chkPeriodiComunicati.Checked or chkAnnulla.Checked or chkFiltroDataComun.Checked);

  // abilitazione combo medicine legali
  dcmbMedicineLegali.Enabled:=not chkAnnulla.Checked;
  if not dcmbMedicineLegali.Enabled then
    dcmbMedicineLegali.ListSource.DataSet.First;

  // abilitazione operazioni stampa
  AbilitaOperazioni;

  // periodo per "includi già comunicati"
  edtDataDa.Enabled:=chkPeriodiComunicati.Checked or chkFiltroDataComun.Checked or chkFiltroDataComun.Checked;
  btnDataDa.Enabled:=chkPeriodiComunicati.Checked or chkFiltroDataComun.Checked or chkFiltroDataComun.Checked;
  edtDataA.Enabled:=chkPeriodiComunicati.Checked or chkFiltroDataComun.Checked or chkFiltroDataComun.Checked;
  btnDataA.Enabled:=chkPeriodiComunicati.Checked or chkFiltroDataComun.Checked or chkFiltroDataComun.Checked;
  edtDataDa.Text:=IfThen(chkPeriodiComunicati.Checked or chkFiltroDataComun.Checked  or chkFiltroDataComun.Checked,DateToStr(Parametri.DataLavoro),'');
  edtDataA.Text:=IfThen(chkPeriodiComunicati.Checked or chkFiltroDataComun.Checked  or chkFiltroDataComun.Checked,DateToStr(Parametri.DataLavoro),'');

  // abilitazione pulsanti di gestione
  BtnPrinterSetUp.Enabled:=not chkAnnulla.Checked;
  btnAnteprima.Enabled:=not chkAnnulla.Checked;
  btnStampa.Enabled:=not chkAnnulla.Checked;
  btnEsenzioni.Enabled:=(rgpTipoStampa.ItemIndex = 0) and (not chkAnnulla.Checked);
  btnEsegui.Enabled:=chkAnnulla.Checked;

  // ripristina i listener dell'evento click sui checkbutton
  chkFiltroDataComun.OnClick:=opzioniClick;
  chkPeriodiComunicati.OnClick:=opzioniClick;
  chkAggiorna.OnClick:=opzioniClick;
  chkAnnulla.OnClick:=opzioniClick;
end;

procedure TA145FComunicazioneVisiteFiscali.chkLDettaglioMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ItemSposta:=chkLDettaglio.ItemIndex;
end;

procedure TA145FComunicazioneVisiteFiscali.chkLDettaglioMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ItemSelezionato: Integer;
begin
  ItemSelezionato:=chkLDettaglio.ItemIndex;
  if (ItemSposta <> -1) and
     (ItemSelezionato <> -1) and
     (ItemSposta <> ItemSelezionato) then
    chkLDettaglio.Items.Exchange(ItemSposta,ItemSelezionato);

  ItemSposta:=- 1;
end;

procedure TA145FComunicazioneVisiteFiscali.chkLogoClick(Sender: TObject);
begin
  if not chkLogo.Checked then
    edtLogoLarg.Text:='';
  edtLogoLarg.Enabled:=chkLogo.Checked;
end;

procedure TA145FComunicazioneVisiteFiscali.chkLuogoClick(Sender: TObject);
begin
  edtLuogo.Enabled:=chkLuogo.Checked;
end;

procedure TA145FComunicazioneVisiteFiscali.chkNumProtClick(Sender: TObject);
begin
  if not chkNumProt.Checked then
    edtNumProt.Text:='';
  edtNumProt.Enabled:=chkNumProt.Checked;
end;

procedure TA145FComunicazioneVisiteFiscali.chkProlClick(Sender: TObject);
begin
  chkSoloCont.Enabled:=chkProl.Checked;
  if not chkProl.Checked then
    chkSoloCont.Checked:=False;
end;

procedure TA145FComunicazioneVisiteFiscali.FormCreate(Sender: TObject);
begin
  TipoModulo:='CS';
  // crea il form di stampa
  A145FStampaComunicazioneVisiteFiscali:=TA145FStampaComunicazioneVisiteFiscali.Create(nil);
  A145FStampaIndividuale:=TA145FStampaIndividuale.Create(nil);
  lstElementiDettaglioCOM:=TStringList.Create;

  pnlElenco.Align:=alClient;
  pnlIndividuale.Align:=alClient;
  pnlIndividuale.Visible:=False;
end;

procedure TA145FComunicazioneVisiteFiscali.FormClose(Sender: TObject;
  var Action: TCloseAction);
var i: Integer;
begin
  // valorizza la stringlist delle causali per salvataggio parametro
  //ListaCausali.Clear;
  //for i:=0 to chkLCausali.Items.Count - 1 do
  //  if chkLCausali.Checked[i] then
  //    ListaCausali.Add(Trim(Copy(chkLCausali.Items[i],1,5)));

  // valorizza la stringlist dei campi di dettaglio anagrafici per salvataggio parametro
  with A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW do
  begin
    if selI010 <> nil then
    begin
      DatiElab.ListaDettaglio.Clear;
      for i:=0 to chkLDettaglio.Items.Count - 1 do
        if chkLDettaglio.Checked[i] then
          DatiElab.ListaDettaglio.Add(VarToStr(selI010.Lookup('NOME_LOGICO',chkLDettaglio.Items[i],'NOME_CAMPO')));
    end;
  end;
  PutParametriFunzione;
  C004FParamForm.Free;

  FreeAndNil(lstElementiDettaglioCOM);
end;

procedure TA145FComunicazioneVisiteFiscali.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
  inherited;
  FreeAndNil(A145FStampaComunicazioneVisiteFiscali);
  FreeAndNil(A145FStampaIndividuale);
end;

end.
