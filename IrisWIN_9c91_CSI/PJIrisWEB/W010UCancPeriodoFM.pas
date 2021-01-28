unit W010UCancPeriodoFM;

interface

uses
  W010URichiestaAssenzeDM, R010UPaginaWeb, W000UMessaggi,
  A000UCostanti, C018UIterAutDM, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  Variants, SysUtils, Classes, Controls, Forms, IWApplication, IWAppForm, IWTypes,
  IWVCLBaseContainer, IWContainer, IWRegion,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton,
  IWHTMLContainer, IWHTML40Container, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompEdit, meIWEdit, IWCompLabel, meIWLabel, meIWButton,
  IWCompJQueryWidget, DB, OracleData;

type
  TW010FCancPeriodoFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    IWTemplateProcessorFrame: TIWTemplateProcessorHTML;
    jQVisFrame: TIWJQueryWidget;
    lblRichiestaOrig: TmeIWLabel;
    lblErrore: TmeIWLabel;
    btnConferma: TmeIWButton;
    btnAnnulla: TmeIWButton;
    lblDal: TmeIWLabel;
    edtDal: TmeIWEdit;
    lblAl: TmeIWLabel;
    edtAl: TmeIWEdit;
    lblPeriodo: TmeIWLabel;
    jqPeriodo: TIWJQueryWidget;
    lblPeriodoOrig: TmeIWLabel;
    lblCausaleOrig: TmeIWLabel;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
  private
    IdRevocato: Integer;
    Progressivo: Integer;
    CausOrig: String;
    DescCausOrig: String;
    DalOrig, AlOrig: TDateTime;
    Dal, Al: TDateTime;
    procedure actInsRevoca(const PTipoRichiesta: String;
      const PProgressivo: Integer; const PDal, PAl: TDateTime);
    procedure ConfermaInsRichiesta;
    procedure AnnullaInsRichiesta;
  public
    IdOrig: Integer;
    DataProposta: TDateTime;
    C018: TC018FIterAutDM;
    W010DM: TW010FRichiestaAssenzeDM;
    procedure Visualizza;
  end;

implementation

{$R *.dfm}

uses A000UInterfaccia, W010URichiestaAssenze, W033UProspettoAssenze;

procedure TW010FCancPeriodoFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=(Self.Owner as TIWAppForm);
  W010DM:=nil;
  C018:=nil;
  IdOrig:=0;
  DataProposta:=DATE_NULL;
  CausOrig:='';
  DescCausOrig:='';
  DalOrig:=DATE_NULL;
  AlOrig:=DATE_NULL;
  Dal:=DATE_NULL;
  Al:=DATE_NULL;
end;

procedure TW010FCancPeriodoFM.Visualizza;
var
  Titolo: String;
begin
  // posiziona il dataset sulla richiesta per cui occorre cancellare il periodo
  with W010DM.selT050 do
  begin
    Close;
    SetVariable('DATALAVORO',Parametri.DataLavoro);
    SetVariable('FILTRO_ANAG','');
    SetVariable('FILTRO_PERIODO','');
    SetVariable('FILTRO_VISUALIZZAZIONE',Format('and T_ITER.ID = %d',[IdOrig]));
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    SetVariable('FILTRO_STRUTTURA','');
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    Open;

    if RecordCount <> 1 then
      raise Exception.Create(Format('Richiesta originale %d non trovata!',[IdOrig]));

    Progressivo:=FieldByName('PROGRESSIVO').AsInteger;
    DalOrig:=FieldByName('DAL').AsDateTime;
    AlOrig:=FieldByName('AL').AsDateTime;
    CausOrig:=FieldByName('CAUSALE').AsString;
    DescCausOrig:=FieldByName('D_CAUSALE').AsString;
  end;

  // dati richiesta originale
  lblCausaleOrig.Caption:=Format('%s (%s)',[CausOrig,DescCausOrig]);
  lblPeriodoOrig.Caption:=Format('dal %s al %s',[FormatDateTime('dd/mm/yyyy',DalOrig),FormatDateTime('dd/mm/yyyy',AlOrig)]);

  // periodo di default
  if (DataProposta <> DATE_NULL) and (DataProposta >= DalOrig) and (DataProposta <= AlOrig) then
  begin
    // data proposta valorizzata e coerente con il periodo: utilizza questa
    edtDal.Text:=FormatDateTime('dd/mm/yyyy',DataProposta);
    edtAl.Text:=edtDal.Text;
  end
  else
  begin
    // primo gg della richiesta
    edtDal.Text:=FormatDateTime('dd/mm/yyyy',DalOrig);
    edtAl.Text:=edtDal.Text;
  end;

  Titolo:='Richiesta cancellazione periodo';
  jqPeriodo.OnReady.Text:=Format(jqPeriodo.OnReady.Text,
                                 [R180Anno(DalOrig),R180Mese(DalOrig) - 1,R180Giorno(DalOrig),
                                  R180Anno(AlOrig),R180Mese(AlOrig)- 1,R180Giorno(AlOrig),
                                  edtDal.HTMLName,
                                  edtAl.HTMLName]);

  if (DalOrig = DATE_NULL) or (AlOrig = DATE_NULL) then
    raise Exception.Create('Date di riferimento della richiesta non impostate!');
  if (DalOrig > AlOrig) then
    raise Exception.Create('Date di riferimento della richiesta non impostate correttamente!');
  if (DalOrig = AlOrig) then
    raise Exception.Create('La funzione di cancellazione periodo non è disponibile per un periodo di un giorno singolo!');

  btnAnnulla.SetFocus;
  TR010FPaginaWeb(Self.Parent).VisualizzajQMessaggio(jQVisFrame,300,-1,EM2PIXEL * 10,Titolo,'#' + Name,False,True)
end;

{ DONE : TEST IW 15 }
procedure TW010FCancPeriodoFM.btnConfermaClick(Sender: TObject);
// fase di controlli prima della conferma
var
  S: String;
begin
  lblErrore.Caption:='';

  // controlli generali sul periodo
  if Trim(edtDal.Text) = '' then
  begin
    lblErrore.Caption:='Indicare la data iniziale';
    Exit;
  end;
  if Trim(edtAl.Text) = '' then
  begin
    lblErrore.Caption:='Indicare la data finale';
    Exit;
  end;
  if not TryStrToDate(edtDal.Text,Dal) then
  begin
    lblErrore.Caption:='La data iniziale non è corretta';
    Exit;
  end;
  if not TryStrToDate(edtAl.Text,Al) then
  begin
    lblErrore.Caption:='La data finale non è corretta';
    Exit;
  end;
  if Dal > Al then
  begin
    lblErrore.Caption:=A000TraduzioneStringhe(A000MSG_W010_MSG_DATA_FINE_MAGG_INIZIO);
    Exit;
  end;

  // periodo da cancellare interno al periodo originale
  if Dal < DalOrig then
  begin
    lblErrore.Caption:='La data iniziale non è compresa nel periodo della richiesta';
    Exit;
  end;
  if Al > AlOrig then
  begin
    lblErrore.Caption:='La data finale non è compresa nel periodo della richiesta';
    Exit;
  end;
  if (Dal = DalOrig) and (Al = AlOrig) then
  begin
    lblErrore.Caption:='Per cancellare l''intero periodo è necessario utilizzare la funzione di revoca';
    Exit;
  end;

  // intersezione con altra cancellazione
  with W010DM.selCancInt do
  begin
    Close;
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DAL',Dal);
    SetVariable('AL',Al);
    Open;
    if RecordCount > 0 then
    begin
      if FieldByName('DAL').AsDateTime = FieldByName('AL').AsDateTime then
        lblErrore.Caption:=Format('Il periodo indicato è già compreso nella richiesta di cancellazione per il giorno %s.',
                                  [FieldByName('DAL').AsString])
      else
        lblErrore.Caption:=Format('Il periodo indicato è già compreso nella richiesta di cancellazione dal %s al %s.',
                                  [FieldByName('DAL').AsString,FieldByName('AL').AsString]);
      Exit;
    end;
  end;

  // conferma la richiesta di cancellazione periodo
  actInsRevoca('C',Progressivo,Dal,Al);
  Free;
end;

// ################### ATTENZIONE! CODICE DUPLICATO.INIZIO ###################
// empoli - commessa 2012/102.ini
// Questo codice è duplicato (cfr. W010URichiestaAssenze)
// se si trova del tempo sarebbe bene tentare di unificare questa gestione
// che utilizza strutture dati proprie della form W010URichiestaAssenze
procedure TW010FCancPeriodoFM.actInsRevoca(const PTipoRichiesta: String;
  const PProgressivo: Integer; const PDal, PAl: TDateTime);
// inserisce una richiesta di revoca oppure di cancellazione periodo
// PTipoRichiesta:
//   'R' -> revoca
//   'C' -> cancellazione periodo
// FN:
//   rowid del record della richiesta da rettificare
// PDal e PAl: periodo di revoca
//   'R' -> sono uguali al periodo originale
//   'C' -> sono quelli inseriti dall'utente, interni al periodo originale
var
  i, Anno: Integer;
  DataNasOrig: TDateTime;
  TipoRichOrig,CausOrig,TGOrig,NumOreOrig,AOreOrig,
  NumOrePrevOrig,AOrePrevOrig: String;
begin
  with W010DM.selT050 do
  begin
    // verifica blocco dati
    WR000DM.selDatiBloccati.Close;
    Anno:=R180Anno(FieldByName('DAL').AsDateTime);
    for i:=R180Mese(FieldByName('DAL').AsDateTime) to R180Mese(FieldByName('AL').AsDateTime) do
    begin
      if WR000DM.selDatiBloccati.DatoBloccato(PProgressivo,EncodeDate(Anno,i,1),'T040') then
      begin
        MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_MSG_INS_REVOC_ANNULLATO),ESCLAMA);
        Exit;
      end;
    end;

    // salva i dati in variabili di appoggio
    IdRevocato:=FieldByName('ID').AsInteger;
    TipoRichOrig:=FieldByName('TIPO_RICHIESTA').AsString;
    CausOrig:=FieldByName('CAUSALE').AsString;
    TGOrig:=FieldByName('TIPOGIUST').AsString;
    NumOreOrig:=FieldByName('NUMEROORE').AsString;
    AOreOrig:=FieldByName('AORE').AsString;
    NumOrePrevOrig:=FieldByName('NUMEROORE_PREV').AsString;
    AOrePrevOrig:=FieldByName('AORE_PREV').AsString;
    if FieldByName('DATANAS').IsNull then
      DataNasOrig:=0
    else
      DataNasOrig:=FieldByName('DATANAS').AsDateTime;

    // inserisce la richiesta di revoca
    Append;
    FieldByName('PROGRESSIVO').AsInteger:=PProgressivo; //selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    FieldByName('DAL').AsDateTime:=PDal;
    FieldByName('AL').AsDateTime:=PAl;
    FieldByName('CAUSALE').AsString:=CausOrig;
    FieldByName('TIPOGIUST').AsString:=TGOrig;
    FieldByName('NUMEROORE').AsString:=NumOreOrig;
    FieldByName('AORE').AsString:=AOreOrig;
    FieldByName('NUMEROORE_PREV').AsString:=NumOrePrevOrig;
    FieldByName('AORE_PREV').AsString:=AOrePrevOrig;
    if DataNasOrig = 0 then
      FieldByName('DATANAS').Value:=null
    else
      FieldByName('DATANAS').AsDateTime:=DataNasOrig;
  end;

  if not C018.WarningRichiesta(PTipoRichiesta) then
    TR010FPaginaWeb(Self.Parent).Messaggio('Conferma',Format(A000TraduzioneStringhe(A000MSG_W010_PARAM_C018_CONTINUA),[C018.MessaggioOperazione]),ConfermaInsRichiesta,AnnullaInsRichiesta)
  else
    ConfermaInsRichiesta;
end;


procedure TW010FCancPeriodoFM.ConfermaInsRichiesta;
begin
  with W010DM.selT050 do
  begin
    try
      C018.InsRichiesta('C','',IntToStr(IdRevocato));
      if C018.MessaggioOperazione <> '' then
      begin
        Cancel;
        raise Exception.Create(C018.MessaggioOperazione);
      end;
      // EMPOLI_ASL11: segnala anomalia su dati modificati (T852)
      //if AnomaliaAss <> 0 then
      //  C018.SetDatoAutorizzatore('SUPERO_COMPETENZE','S',0);
    except
      on E: Exception do
      begin
        MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W010_PARAM_INS_FALLITO),[e.Message]),ESCLAMA);
        if State <> dsBrowse then
          Cancel;
      end;
    end;
    SessioneOracle.Commit;
  end;
end;

procedure TW010FCancPeriodoFM.AnnullaInsRichiesta;
begin
  W010DM.selT050.Cancel;
end;
// ################### ATTENZIONE! CODICE DUPLICATO - FINE ###################

procedure TW010FCancPeriodoFM.btnAnnullaClick(Sender: TObject);
begin
  Free;
end;

end.
