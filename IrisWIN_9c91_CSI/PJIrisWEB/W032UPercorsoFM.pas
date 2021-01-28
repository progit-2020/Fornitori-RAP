unit W032UPercorsoFM;

interface

uses
  W032URichiestaMissioniDM, A000USessione, W000UMessaggi,
  R010UPaginaWeb, C018UIterAutDM, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  IWAppForm, OracleData, Math, IWApplication,
  SysUtils, Classes, Controls, Forms, DB, Variants, StrUtils,
  IWVCLBaseContainer, IWColor, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWCompLabel, meIWLabel, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompEdit, medpIWMultiColumnComboBox, IWCompJQueryWidget,
  IWCompButton, meIWButton, IWCompGrids, IWDBGrids, medpIWDBGrid,
  IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup, meIWRadioGroup,
  IWAdvRadioGroup, meTIWAdvRadioGroup, meIWGrid, meIWLink, meIWCheckBox,
  IWCompCheckbox;

type
  TW032FPercorsoFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    IWTemplateProcessorFrame: TIWTemplateProcessorHTML;
    btnConferma: TmeIWButton;
    btnAnnulla: TmeIWButton;
    jQVisFrame: TIWJQueryWidget;
    lblKmTot: TmeIWLabel;
    lblErrore: TmeIWLabel;
    rgpFlagPercorso: TmeIWRadioGroup;
    lblFlagPercorso: TmeIWLabel;
    grdPercorso: TmeIWGrid;
    cmbNuovaTappa: TMedpIWMultiColumnComboBox;
    lblNuovaTappa: TmeIWLabel;
    btnNuovaTappa: TmeIWButton;
    jqFocus: TIWJQueryWidget;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure rgpFlagPercorsoAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure grdPercorsoRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure btnNuovaTappaClick(Sender: TObject);
    procedure cmbNuovaTappaAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure IWFrameRegionRender(Sender: TObject);
  private
    cmbPartenza: TMedpIWMultiColumnComboBox;
    cmbRientro: TMedpIWMultiColumnComboBox;
    ComuneRes: TComune;
    ComuneDom: TComune;
    ComuneSede: TComune;
    lstLocalita1: TStringList;
    lstLocalita2: TStringList;
    colDistanza: Integer;
    colIndKm: Integer;
    colLocalita: Integer;
    SedeDefinita: Boolean;
    DomicilioResidenzaDefinito: Boolean;
    CaricaRecordInserimentoEffettuato: Boolean;
    procedure PopolaComboLocalita;
    procedure OnPercorsoModificato;
    function  GetTipoDestinazione: String;
    function  ControlliOk(var RErrMsg: String): Boolean;
    function  GetLocalita(const PTipo, PCodLocalita, PDescLocalita: String): TLocalita;
    function  FlagPercorsoIndexToStr(const PIndex: Integer): String;
    function  FlagPercorsoStrToIndex(const PValore: String): Integer;
    function  GetIndexFromCodice(const PCmb: TMedpIWMultiColumnComboBox; const PCodLocalita: String): Integer;
    procedure CaricaGridPercorso;
    procedure ImpostaGrdCampo(var grdCampo: TmeIWGrid; PNomeCampo: String; idx: Integer);
    procedure RimuoviLinkClick(Sender: TObject);
    procedure SpostaGiuLinkClick(Sender: TObject);
    procedure SpostaSuLinkClick(Sender: TObject);
    procedure cmbLocalitaAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure chkIndKmAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure SwapRecord(const PIdx1, PIdx2: Integer);
    function GetComune: TComune; overload;
    function GetComune(const PCodice, PCitta, PCodProvincia,
      PCodRegione: String): TComune; overload;
    procedure ImpostaVista;
    procedure ImpostaAbilitazioniVista;
    procedure CaricaRecordInserimento;
    procedure EvidenziaNuovaLocalitaCombo(PCmb: TMedpIWMultiColumnComboBox);
    procedure PulisciDatiPercorso;
    procedure ReimpostaOrdinePercorso;
    const
      COL_COD_LOCALITA  = 1;
      COL_DESC_LOCALITA = 0;
      COL_TIPO_LOCALITA = 2;
      TIPO_LOCALITA_COMUNE         = 'C';
      TIPO_LOCALITA_PERSONALIZZATA = 'P';
  public
    W032DM: TW032FRichiestaMissioniDM;
    AbilitaModifica: Boolean;
    Inserimento: Boolean;
    PercorsoInfo: TPercorsoInfo;
    procedure Visualizza;
  end;

implementation

uses A000UInterfaccia,
     W032URichiestaMissioni; // evita circular unit reference

{$R *.dfm}

procedure TW032FPercorsoFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=(Self.Owner as TIWAppForm);

  // label per errori
  lblErrore.Caption:='';

  // dati di percorso
  PulisciDatiPercorso;

  // inizializzazione variabili
  lstLocalita1:=TStringList.Create;
  lstLocalita2:=TStringList.Create;
  CaricaRecordInserimentoEffettuato:=False;
  colDistanza:=0;
  colIndKm:=0;
  colLocalita:=0;
  SedeDefinita:=False;
  DomicilioResidenzaDefinito:=False;

  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
  // tappa personalizzabile in base a parametro aziendale
  cmbNuovaTappa.CustomElement:=(Parametri.CampiRiferimento.C8_W032TappeSoloSuDistanziometro <> 'S');
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine
end;

procedure TW032FPercorsoFM.IWFrameRegionRender(Sender: TObject);
begin
  // imposta le abilitazioni dei radiobutton del flag tipo percorso
  // 1. se non è definita la sede aziendale, disabilitare il radiobutton "Sede"
  C190AbilitaComponente(rgpFlagPercorso,SedeDefinita,FlagPercorsoStrToIndex(M140FLAG_PERCORSO_SEDE));
  // 2. se il dipendente non ha impostato né domicilio né residenza, disabilitare il radiobutton "Domicilio"
  C190AbilitaComponente(rgpFlagPercorso,DomicilioResidenzaDefinito,FlagPercorsoStrToIndex(M140FLAG_PERCORSO_DOMICILIO));
end;

function TW032FPercorsoFM.GetLocalita(const PTipo, PCodLocalita, PDescLocalita: String): TLocalita;
begin
  Result.Tipo:=PTipo;
  Result.CodLocalita:=PCodLocalita;
  Result.DescLocalita:=IfThen(PDescLocalita = '','<non indicata>',PDescLocalita);
end;

function TW032FPercorsoFM.GetComune: TComune;
// estrae un record vuoto di TComune
begin
  Result.Codice:='';
  Result.Citta:='';
  Result.CodProvincia:='';
  Result.CodRegione:='';
end;

function TW032FPercorsoFM.GetComune(const PCodice, PCitta, PCodProvincia, PCodRegione: String): TComune;
begin
  Result.Codice:=PCodice;
  Result.Citta:=PCitta;
  Result.CodProvincia:=PCodProvincia;
  Result.CodRegione:=PCodRegione;
end;

function TW032FPercorsoFM.FlagPercorsoStrToIndex(const PValore: String): Integer;
var
  LVal: String;
begin
  LVal:=PValore.ToUpper;
  if PValore = M140FLAG_PERCORSO_SEDE then
    Result:=0
  else if LVal = M140FLAG_PERCORSO_DOMICILIO then
    Result:=1
  else if LVal = M140FLAG_PERCORSO_ALTRO then
    Result:=2
  else
    Result:=-1;
end;

function TW032FPercorsoFM.FlagPercorsoIndexToStr(const PIndex: Integer): String;
begin
  case PIndex of
    0: Result:=M140FLAG_PERCORSO_SEDE;
    1: Result:=M140FLAG_PERCORSO_DOMICILIO;
    2: Result:=M140FLAG_PERCORSO_ALTRO;
  end;
end;

procedure TW032FPercorsoFM.PulisciDatiPercorso;
// pulizia dei dati del percorso
begin
  PercorsoInfo.Partenza:=GetLocalita('','','');
  SetLength(PercorsoInfo.DestinazioneArr,1);
  PercorsoInfo.DestinazioneArr[0]:=GetLocalita('','','');
  PercorsoInfo.ElencoDestinazioni:='';
  PercorsoInfo.ElencoDestinazioniDesc:='';
  PercorsoInfo.Rientro:=GetLocalita('','','');
  PercorsoInfo.Testo:='';
  PercorsoInfo.FlagDestinazione:='';
  PercorsoInfo.FlagPercorso:='';
end;

procedure TW032FPercorsoFM.Visualizza;
var
  Titolo: String;
begin
  // apre dataset delle distanze km
  W032DM.selM041.Close;
  W032DM.selM041.Open;

  // imposta i dati di domicilio e residenza
  with (Self.Owner as TW032FRichiestaMissioni).selAnagrafeW do
  begin
    // imposta il comune di domicilio
    ComuneDom:=GetComune(FieldByName('T430COMUNE_DOM_BASE').AsString,
                         FieldByName('T430D_COMUNE_DOM_BASE').AsString,
                         '','');

    // imposta il comune di residenza
    ComuneRes:=GetComune(FieldByName('T430COMUNE').AsString,
                         FieldByName('T430D_COMUNE').AsString,
                         '','');
  end;
  DomicilioResidenzaDefinito:=(ComuneDom.Codice <> '') or (ComuneRes.Codice <> '');

  // imposta i dati della sede di lavoro
  // 1. se esiste C8_SEDE, e se è valorizzato per il progressivo corrente
  //    considerare il codice della T430.C8_SEDE
  ComuneSede:=GetComune;
  if Parametri.CampiRiferimento.C8_Sede <> '' then
  begin
    try
      with W032DM.selDatoSede do
      begin
        SetVariable('DATOSEDE',Parametri.CampiRiferimento.C8_Sede);
        SetVariable('PROGRESSIVO',(Self.Owner as TW032FRichiestaMissioni).selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
        SetVariable('DATARIF',Parametri.DataLavoro);
        Execute;
        if RowCount > 0 then
        begin
          ComuneSede:=GetComune(FieldAsString(0),
                                FieldAsString(3),
                                FieldAsString(1),
                                FieldAsString(2));
        end
        else
        begin
          ComuneSede:=GetComune;
        end;
      end;
    except
      ComuneSede:=GetComune;
    end;
  end;
  // 2. altrimenti la sede di lavoro si estrae dalla tabella P150
  if ComuneSede.Codice = '' then
  begin
    try
      with W032DM.selP150 do
      begin
        Execute;
        if RowCount > 0 then
        begin
          ComuneSede:=GetComune(FieldAsString(0),
                                FieldAsString(3),
                                FieldAsString(1),
                                FieldAsString(2));
        end
        else
        begin
          ComuneSede:=GetComune;
        end;
      end;
    except
      ComuneSede:=GetComune;
    end;
  end;
  SedeDefinita:=(ComuneSede.Codice <> '');

  // popola le combo per le località del percorso
  PopolaComboLocalita;

  // in inserimento inserisce un record iniziale per la destinazione
  if Inserimento then
    CaricaRecordInserimento;

  // imposta i dati (in inserimento o modifica)
  ImpostaVista;

  // imposta titolo e visualizza frame
  Titolo:='Percorso richiesta' +
          IfThen(not Inserimento,' ' + W032DM.selM140.FieldByName('ID').AsString) +
          Format(' - %s',[IfThen(AbilitaModifica,
                                 IfThen(Inserimento,'inserimento','modifica'),
                                 'visualizzazione')]);
  (Self.Owner as TR010FPaginaWeb).VisualizzajQMessaggio(jQVisFrame,600,-1,EM2PIXEL * 10,Titolo,'#' + Name,not AbilitaModifica,True,-1,'','',btnAnnulla.HTMLName);
  if not AbilitaModifica then
    jqVisFrame.OnReady.Add('$("#w032Riga").hide();');
end;

function TW032FPercorsoFM.GetIndexFromCodice(const PCmb: TMedpIWMultiColumnComboBox; const PCodLocalita: String): Integer;
var
  i: Integer;
begin
  Result:=-1;
  for i:=0 to PCmb.Items.Count - 1 do
  begin
    if PCodLocalita = PCmb.Items[i].RowData[COL_COD_LOCALITA] then
    begin
      Result:=i;
      Break;
    end;
  end;
end;

procedure TW032FPercorsoFM.PopolaComboLocalita;
// carica le stringlist delle località di partenza / rientro e destinazione
var
  Tipo: String;
  Codice: String;
  Elemento: String;
begin
  lstLocalita1.Clear;
  lstLocalita2.Clear;

  // popola le stringlist delle località di partenza e rientro (localita1)
  // proponendo in ordine (se disponibili su M041)
  // 1. sede lavoro
  // 2. domicilio
  // 3. residenza
  with W032DM.selM041Localita do
  begin
    // 1. sede lavoro
    if (ComuneSede.Codice <> '') and
       (SearchRecord('CODICE;TIPO',VarArrayOf([ComuneSede.Codice,'C']),[srFromBeginning])) then
    begin
      Elemento:=Format('%s;%s;%s',[FieldByName('DESCRIZIONE').AsString,ComuneSede.Codice,'C']);
      lstLocalita1.Add(Elemento);
    end;
    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
    // 2. domicilio
    if (ComuneDom.Codice <> '') and
       (SearchRecord('CODICE;TIPO',VarArrayOf([ComuneDom.Codice,'C']),[srFromBeginning])) then
    begin
      Elemento:=Format('%s;%s;%s',[FieldByName('DESCRIZIONE').AsString,ComuneDom.Codice,'C']);
      lstLocalita1.Add(Elemento);
    end;
    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine
    // 2. residenza
    if (ComuneRes.Codice <> '') and
       (SearchRecord('CODICE;TIPO',VarArrayOf([ComuneRes.Codice,'C']),[srFromBeginning])) then
    begin
      Elemento:=Format('%s;%s;%s',[FieldByName('DESCRIZIONE').AsString,ComuneRes.Codice,'C']);
      lstLocalita1.Add(Elemento);
    end;

    // propone gli altri elementi di M041
    First;
    while not Eof do
    begin
      Tipo:=FieldByName('TIPO').AsString;
      Codice:=FieldByName('CODICE').AsString;
      if (Tipo = 'C') and
         ((Codice = ComuneSede.Codice) or (Codice = ComuneDom.Codice) or (Codice = ComuneRes.Codice)) then
      begin
        // codice già considerato: nessuna operazione
      end
      else
      begin
        // aggiunge l'elemento alla combo
        Elemento:=Format('%s;%s;%s',[FieldByName('DESCRIZIONE').AsString,Codice,Tipo]);
        lstLocalita1.Add(Elemento);
      end;
      Next;
    end;
  end;

  // popola la combo delle località di destinazione (localita2)
  with W032DM.selM041Localita do
  begin
    First;
    while not Eof do
    begin
      Elemento:=Format('%s;%s;%s',[FieldByName('DESCRIZIONE').AsString,FieldByName('CODICE').AsString,FieldByName('TIPO').AsString]);
      lstLocalita2.Add(Elemento);
      Next;
    end;
  end;

  // popola la combobox nuova tappa con la lista di località di destinazione
  cmbNuovaTappa.Items.Clear;
  cmbNuovaTappa.LoadItems(lstLocalita2);
end;

procedure TW032FPercorsoFM.CaricaRecordInserimento;
// inserimento dei record iniziali per il percorso minimo (partenza, destinazione, rientro)
var
  LPartenza: TLocalita;
begin
  if CaricaRecordInserimentoEffettuato then
    Exit;

  (*
  // imposta le abilitazioni dei radiobutton del flag tipo percorso
  // 1. se non è definita la sede aziendale, disabilitare il radiobutton "Sede"
  C190AbilitaComponente(rgpFlagPercorso,SedeDefinita,FlagPercorsoStrToIndex(M140FLAG_PERCORSO_SEDE));
  // 2. se il dipendente non ha impostato né domicilio né residenza, disabilitare il radiobutton "Domicilio"
  C190AbilitaComponente(rgpFlagPercorso,DomicilioResidenzaDefinito,FlagPercorsoStrToIndex(M140FLAG_PERCORSO_DOMICILIO));
  *)

  // imposta la località di partenza di default per l'inserimento,
  // con queste possibilità nell'ordine:
  // 1. il comune sede di lavoro
  // 2. in alternativa, il comune di domicilio
  // 3. in alternativa, il comune di residenza
  with W032DM.selM041Localita do
  begin
    if SearchRecord('TIPO;CODICE',VarArrayOf(['C',ComuneSede.Codice]),[srFromBeginning]) then
    begin
      // 1. sede di lavoro
      LPartenza:=GetLocalita('C',ComuneSede.Codice,ComuneSede.Citta);
      rgpFlagPercorso.ItemIndex:=FlagPercorsoStrToIndex(M140FLAG_PERCORSO_SEDE);
    end
    else if SearchRecord('TIPO;CODICE',VarArrayOf(['C',ComuneDom.Codice]),[srFromBeginning]) then
    begin
      // 2. domicilio
      LPartenza:=GetLocalita('C',ComuneDom.Codice,ComuneDom.Citta);
      rgpFlagPercorso.ItemIndex:=FlagPercorsoStrToIndex(M140FLAG_PERCORSO_DOMICILIO);
    end
    else if SearchRecord('TIPO;CODICE',VarArrayOf(['C',ComuneRes.Codice]),[srFromBeginning]) then
    begin
      // 3. residenza
      LPartenza:=GetLocalita('C',ComuneRes.Codice,ComuneRes.Citta);
      rgpFlagPercorso.ItemIndex:=FlagPercorsoStrToIndex(M140FLAG_PERCORSO_DOMICILIO);
    end
    else
    begin
      // default vuoto
      LPartenza:=GetLocalita('','','');
      rgpFlagPercorso.ItemIndex:=FlagPercorsoStrToIndex(M140FLAG_PERCORSO_ALTRO);
    end;
  end;

  // in inserimento propone i valori di default
  if PercorsoInfo.Partenza.CodLocalita = '' then
    PercorsoInfo.Partenza:=LPartenza;
  if PercorsoInfo.Rientro.CodLocalita = '' then
    PercorsoInfo.Rientro:=LPartenza;

  with W032DM.selM141 do
  begin
    if RecordCount > 0 then
      Exit;

    // record per la partenza
    Append;
    FieldByName('ID').AsInteger:=W032DM.selM140.FieldByName('ID').AsInteger;
    FieldByName('ORD').AsInteger:=1;
    FieldByName('LOCALITA').AsString:=PercorsoInfo.Partenza.CodLocalita;
    FieldByName('TIPO_LOCALITA').AsString:=PercorsoInfo.Partenza.Tipo;
    FieldByName('D_LOCALITA').AsString:=PercorsoInfo.Partenza.DescLocalita;
    FieldByName('IND_KM').AsString:='N';
    Post;

    // record per la destinazione
    Append;
    FieldByName('ID').AsInteger:=W032DM.selM140.FieldByName('ID').AsInteger;
    FieldByName('ORD').AsInteger:=2;
    FieldByName('LOCALITA').AsString:='';
    FieldByName('TIPO_LOCALITA').AsString:='';
    FieldByName('D_LOCALITA').AsString:='';
    FieldByName('IND_KM').AsString:='S';
    Post;

    // record per il rientro
    Append;
    FieldByName('ID').AsInteger:=W032DM.selM140.FieldByName('ID').AsInteger;
    FieldByName('ORD').AsInteger:=3;
    FieldByName('LOCALITA').AsString:=PercorsoInfo.Rientro.CodLocalita;
    FieldByName('TIPO_LOCALITA').AsString:=PercorsoInfo.Rientro.Tipo;
    FieldByName('D_LOCALITA').AsString:=PercorsoInfo.Rientro.DescLocalita;
    FieldByName('IND_KM').AsString:='S';
    Post;
  end;

  // segnala che l'operazione è stata eseguita
  CaricaRecordInserimentoEffettuato:=True;
end;

procedure TW032FPercorsoFM.ImpostaAbilitazioniVista;
var
  Abil: Boolean;
  FP: String;
begin
  // gestisce abilitazione alla modifica
  rgpFlagPercorso.Enabled:=AbilitaModifica;

  // abilitazione nuova tappa
  lblNuovaTappa.Visible:=AbilitaModifica;
  cmbNuovaTappa.Visible:=AbilitaModifica;
  btnNuovaTappa.Visible:=AbilitaModifica;

  // pulsanti di conferma e annulla
  btnConferma.Visible:=AbilitaModifica;
  btnAnnulla.Visible:=AbilitaModifica;

  // in base al flag percorso determina se la partenza e il rientro sono modificabili
  if AbilitaModifica then
  begin
    FP:=FlagPercorsoIndexToStr(rgpFlagPercorso.ItemIndex);
    Abil:=FP = M140FLAG_PERCORSO_ALTRO;

    if cmbPartenza <> nil then
      cmbPartenza.Enabled:=Abil;
    if cmbRientro <> nil then
      cmbRientro.Enabled:=Abil;
  end;
end;

procedure TW032FPercorsoFM.ImpostaVista;
begin
  // imposta il flag percorso
  if PercorsoInfo.FlagPercorso <> '' then
    rgpFlagPercorso.ItemIndex:=FlagPercorsoStrToIndex(PercorsoInfo.FlagPercorso);

  // imposta tabella percorso
  CaricaGridPercorso;

  // procede con abilitazioni
  ImpostaAbilitazioniVista;
end;

procedure TW032FPercorsoFM.rgpFlagPercorsoAsyncClick(Sender: TObject; EventParams: TStringList);
var
  LFlagPercorso: String;
  LPartenza, LRientro: TLocalita;
begin
  LFlagPercorso:=FlagPercorsoIndexToStr(rgpFlagPercorso.ItemIndex);

  if (LFlagPercorso = M140FLAG_PERCORSO_SEDE) or
     (LFlagPercorso = M140FLAG_PERCORSO_DOMICILIO) then
  begin
    // in base al valore del flag percorso propone in automatico
    // le località di partenza e rientro
    if LFlagPercorso = M140FLAG_PERCORSO_SEDE then
    begin
      // sede di lavoro
      //   partenza: sede di lavoro
      //   rientro:  sede di lavoro
      LPartenza:=GetLocalita('C',ComuneSede.Codice,ComuneSede.Citta);
      LRientro:=GetLocalita('C',ComuneSede.Codice,ComuneSede.Citta);
    end
    else if LFlagPercorso = M140FLAG_PERCORSO_DOMICILIO then
    begin
      // domicilio
      //   partenza: domicilio (o se non specificato, residenza);
      //   rientro:  domicilio (o se non specificato, residenza);
      if ComuneDom.Codice <> '' then
      begin
        // domicilio
        LPartenza:=GetLocalita('C',ComuneDom.Codice,ComuneDom.Citta);
        LRientro:=GetLocalita('C',ComuneDom.Codice,ComuneDom.Citta);
      end
      else if ComuneRes.Codice <> '' then
      begin
        // residenza
        LPartenza:=GetLocalita('C',ComuneRes.Codice,ComuneRes.Citta);
        LRientro:=GetLocalita('C',ComuneRes.Codice,ComuneRes.Citta);
      end
      else
      begin
        // domicilio e residenza non specificati: caso non gestito
        LPartenza:=GetLocalita('','','');
        LRientro:=GetLocalita('','','');
      end;
    end;

    // imposta la località di partenza
    cmbPartenza.ItemIndex:=GetIndexFromCodice(cmbPartenza,LPartenza.CodLocalita);
    if cmbPartenza.ItemIndex = -1 then
      cmbPartenza.Text:=LPartenza.DescLocalita;
    cmbPartenza.OnAsyncChange(cmbPartenza,nil,-2,'');

    // imposta la località di rientro
    cmbRientro.ItemIndex:=GetIndexFromCodice(cmbRientro,LRientro.CodLocalita);
    if cmbRientro.ItemIndex = -1 then
      cmbRientro.Text:=LRientro.DescLocalita;
    cmbRientro.OnAsyncChange(cmbRientro,nil,-2,'');
  end;

  // ricalcola distanze km
  OnPercorsoModificato;

  // imposta abilitazioni componenti
  ImpostaAbilitazioniVista;
end;

procedure TW032FPercorsoFM.SwapRecord(const PIdx1, PIdx2: Integer);
// swap dei record di selM141 con ORD = PIdx1 e PIdx2
var
  T1, T2: TTappa;
begin
  with W032DM.selM141 do
  begin
    // salva i dati del record 1 in variabili
    if SearchRecord('ORD',PIdx1,[srFromBeginning]) then
    begin
      T1.Localita:=FieldByName('LOCALITA').AsString;
      T1.IndKm:=FieldByName('IND_KM').AsString;
      T1.TipoLocalita:=FieldByName('TIPO_LOCALITA').AsString;
      T1.DescLocalita:=FieldByName('D_LOCALITA').AsString;
      T1.Distanza:=FieldByName('C_DISTANZA').AsInteger;

      // salva i dati del record 2 in variabili
      if SearchRecord('ORD',PIdx2,[srFromBeginning]) then
      begin
        T2.Localita:=FieldByName('LOCALITA').AsString;
        T2.IndKm:=FieldByName('IND_KM').AsString;
        T2.TipoLocalita:=FieldByName('TIPO_LOCALITA').AsString;
        T2.DescLocalita:=FieldByName('D_LOCALITA').AsString;
        T2.Distanza:=FieldByName('C_DISTANZA').AsInteger;

        // modifica il record 2
        Edit;
        FieldByName('LOCALITA').AsString:=T1.Localita;
        FieldByName('IND_KM').AsString:=T1.IndKm;
        FieldByName('TIPO_LOCALITA').AsString:=T1.TipoLocalita;
        FieldByName('D_LOCALITA').AsString:=T1.DescLocalita;
        FieldByName('C_DISTANZA').AsInteger:=T1.Distanza;
        Post;

        // modifica il record 1
        SearchRecord('ORD',PIdx1,[srFromBeginning]);
        Edit;
        FieldByName('LOCALITA').AsString:=T2.Localita;
        FieldByName('IND_KM').AsString:=T2.IndKm;
        FieldByName('TIPO_LOCALITA').AsString:=T2.TipoLocalita;
        FieldByName('D_LOCALITA').AsString:=T2.DescLocalita;
        FieldByName('C_DISTANZA').AsInteger:=T2.Distanza;
        Post;
      end;
    end;
  end;
end;

procedure TW032FPercorsoFM.SpostaSuLinkClick(Sender: TObject);
var
  idx: Integer;
begin
  idx:=(Sender as TmeIWLink).Tag;

  // la partenza e la prima tappa non sono spostabili
  if idx > 2 then
  begin
    SwapRecord(idx, idx - 1);
    CaricaGridPercorso;
  end;
end;

procedure TW032FPercorsoFM.SpostaGiuLinkClick(Sender: TObject);
var
  idx: Integer;
begin
  idx:=(Sender as TmeIWLink).Tag;

  // l'ultima tappa e il rientro non sono spostabili
  if idx < W032DM.selM141.RecordCount - 1 then
  begin
    SwapRecord(idx,idx + 1);
    CaricaGridPercorso;
  end;
end;

procedure TW032FPercorsoFM.RimuoviLinkClick(Sender: TObject);
var
  idx: Integer;
begin
  idx:=(Sender as TmeIWLink).Tag;

  with W032DM.selM141 do
  begin
    // verifica se sono presenti almeno 3 record totali:
    // partenza, destinazione e rientro
    if RecordCount >= 3 then
    begin
      // eliminazione record
      if SearchRecord('ORD',idx,[srFromBeginning]) then
        Delete;
    end;
  end;

  // reimposta i valori del campo ORD
  ReimpostaOrdinePercorso;

  // carica la tabella del percorso
  CaricaGridPercorso;

  // reimposta abilitazioni componenti
  ImpostaAbilitazioniVista;
end;

procedure TW032FPercorsoFM.ImpostaGrdCampo(var grdCampo: TmeIWGrid; PNomeCampo:String;idx:Integer);
var
  colControl: Integer;
  IWCell: TIWGridCell;
  IWLnk: TmeIWLink;
begin
  grdCampo.Css:='gridTrasparente';
  grdCampo.RowCount:=1;
  grdCampo.ColumnCount:=IfThen(AbilitaModifica,3,1);

  // in presenza di una sola tappa non prepara nessun pulsante
  if W032DM.selM141.RecordCount = 3 then
    Exit;

  colControl:=0;
  if AbilitaModifica then
  begin
    // link sposta su
    IWCell:=(grdCampo.Cell[0,colControl] as TIWGridCell);
    IWCell.Css:='width1chr';
    IWCell.Control:=TmeIWLink.Create(Self);

    IWLnk:=(IWCell.Control as TmeIWLink);
    IWLnk.Css:='ui-icon ui-icon-circle-triangle-n';
    IWLnk.Enabled:=W032DM.selM141.RecNo > 2; // valido solo dalla prima tappa in avanti
    IWLnk.Tag:=idx;
    IWLnk.Hint:='Sposta su' + IfThen(not IWLnk.Enabled,' (non consentito)');
    IWLnk.OnClick:=SpostaSuLinkClick;
    inc(colControl);

    // link sposta giù
    IWCell:=(grdCampo.Cell[0,colControl] as TIWGridCell);
    IWCell.Css:='width1chr';
    IWCell.Control:=TmeIWLink.Create(Self);

    IWLnk:=(IWCell.Control as TmeIWLink);
    IWLnk.Css:='ui-icon ui-icon-circle-triangle-s';
    IWLnk.Enabled:=W032DM.selM141.RecNo < W032DM.selM141.RecordCount - 1; // valido solo fino alla penultima tappa
    IWLnk.Tag:=idx;
    IWLnk.Hint:='Sposta giù' + IfThen(not IWLnk.Enabled,' (non consentito)');
    IWLnk.OnClick:=SpostaGiuLinkClick;
    inc(colControl);

    // link rimuovi (presente solo se esistono almeno 2 record)
    IWCell:=(grdCampo.Cell[0,colControl] as TIWGridCell);
    IWCell.Css:='width1chr';
    IWCell.Control:=TmeIWLink.Create(Self);

    IWLnk:=(IWCell.Control as TmeIWLink);
    IWLnk.Css:='ui-icon ui-icon-circle-minus';
    IWLnk.Tag:=idx;
    IWLnk.Hint:='Rimuovi tappa';
    IWLnk.OnClick:=RimuoviLinkClick;
    //inc(colControl);
  end;
end;

procedure TW032FPercorsoFM.cmbLocalitaAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
// modifica inline della località
// IMPORTANTE
//   nel caso di richiamo esplicito dell'evento
//   impostare Index = -2 per evitare il ricalcolo delle distanze km
var
  idx: Integer;
  IWCmb: TMedpIWMultiColumnComboBox;
  Loc: TLocalita;
begin
  idx:=(Sender as TMedpIWMultiColumnComboBox).Tag;
  IWCmb:=(Sender as TMedpIWMultiColumnComboBox);

  // imposta dati della località indicata
  EvidenziaNuovaLocalitaCombo(IWCmb);
  if IWCmb.ItemIndex = -1 then
  begin
    // località non presente su db
    Loc:=GetLocalita('',IWCmb.Text,IWCmb.Text);
  end
  else
  begin
    // località presente su db
    Loc:=GetLocalita(IWCmb.Items[IWCmb.ItemIndex].RowData[COL_TIPO_LOCALITA],
                     IWCmb.Items[IWCmb.ItemIndex].RowData[COL_COD_LOCALITA],
                     IWCmb.Items[IWCmb.ItemIndex].RowData[COL_DESC_LOCALITA]);
  end;

  // modifica il record sul dataset
  with W032DM.selM141 do
  begin
    if SearchRecord('ORD',idx,[srFromBeginning]) then
    begin
      Edit;
      FieldByName('LOCALITA').AsString:=Loc.CodLocalita;
      FieldByName('TIPO_LOCALITA').AsString:=Loc.Tipo;
      FieldByName('D_LOCALITA').AsString:=Loc.DescLocalita;
      Post;
    end;
  end;

  if Sender <> nil then
    OnPercorsoModificato;
end;

procedure TW032FPercorsoFM.cmbNuovaTappaAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  EvidenziaNuovaLocalitaCombo(cmbNuovaTappa);
  lblErrore.Caption:='';
end;

procedure TW032FPercorsoFM.chkIndKmAsyncClick(Sender: TObject; EventParams: TStringList);
// modifica inline dell'indennità km S/N
var
  r, idx, DeltaKm, TotKmInd: Integer;
  IWLbl: TmeIWLabel;
begin
  idx:=(Sender as TmeIWCheckBox).Tag;

  with W032DM.selM141 do
  begin
    // imposta flag indennità km
    SearchRecord('ORD',idx,[srFromBeginning]);
    Edit;
    FieldByName('IND_KM').AsString:=IfThen((Sender as TmeIWCheckBox).Checked,'S','N');
    Post;

    // ricalcola km indennizzati
    TotKmInd:=0;
    First;
    while not Eof do
    begin
      r:=RecNo;
      try
        if FieldByName('IND_KM').AsString = 'S' then
        begin
          IWLbl:=(grdPercorso.Cell[r,colDistanza].Control as TmeIWLabel);
          if TryStrToInt(IWLbl.Caption,DeltaKm) then
            TotKmInd:=TotKmInd + Max(0,DeltaKm);
        end;
      except
      end;
      Next;
    end;
    lblKmTot.Hint:=Format('Percorso indennizzato: km %d',[TotKmInd]);
  end;
end;

procedure TW032FPercorsoFM.CaricaGridPercorso;
var
  r,c,Ordine: Integer;
  IWCmb, IWCmbPrimaTappa: TMedpIWMultiColumnComboBox;
  IWChk: TmeIWCheckBox;
  IWLbl, IWLbl2: TmeIWLabel;
  grdCampo: TmeIWGrid;
  DS: TOracleDataSet;
  JSCode: String;
begin
  DS:=TW032FRichiestaMissioniDM(W032DM).selM141;
  grdPercorso.medpClearComp;

  // puntatore alla combobox della prima tappa
  IWCmbPrimaTappa:=nil;

  // ricarica il dataset se non ci sono modifiche in corso
  if not DS.UpdatesPending then
    DS.Refresh;

  // righe = intestazione + num. tappe
  grdPercorso.RowCount:=1 + DS.RecordCount;
  grdPercorso.ColumnCount:=5;

  cmbPartenza:=nil;
  cmbRientro:=nil;

  // intestazione
  r:=0;
  c:=0;
  grdPercorso.Cell[r,c].Text:='';
  grdPercorso.Cell[r,c].Css:='width5chr';
  inc(c);
  grdPercorso.Cell[r,c].Text:='Tappa';
  grdPercorso.Cell[r,c].Css:='width10chr';
  inc(c);
  grdPercorso.Cell[r,c].Text:='Località';
  grdPercorso.Cell[r,c].Css:='width35chr';
  inc(c);
  grdPercorso.Cell[r,c].Text:='Ind. km';
  grdPercorso.Cell[r,c].Css:='width5chr';
  inc(c);
  grdPercorso.Cell[r,c].Text:='Distanza (km)';
  grdPercorso.Cell[r,c].Css:='width5chr';
  //inc(c);

  // righe di dettaglio del percorso
  DS.First;
  while not DS.Eof do
  begin
    inc(r);
    c:=0;

    // imposta il tag corrente per i componenti
    Ordine:=DS.FieldByName('ORD').AsInteger;

    // griglia campo con pulsanti spostamento / eliminazione
    // visibile solo nel caso di più tappe, escluse partenza e rientro
    if (DS.RecordCount > 3) and
       (DS.RecNo > 1) and
       (DS.RecNo < DS.RecordCount) then
    begin
      grdCampo:=TmeIWGrid.Create(Self);
      grdPercorso.Cell[r,c].Control:=grdCampo;
      ImpostaGrdCampo(grdCampo,DS.FieldByName('LOCALITA').AsString,Ordine);
    end
    else
    begin
      // bug intraweb: non visualizza css della cella se è vuota (si forza un css fittizio)
      grdPercorso.Cell[r,c].Css:='x';
    end;
    inc(c);

    // tappa
    with grdPercorso.Cell[r,c] do
    begin
      Css:='align_left';
      IWLbl:=TmeIWLabel.Create(Self);
      if DS.RecNo = 1 then
        IWLbl.Caption:='Partenza:'
      else if DS.RecNo = DS.RecordCount then
        IWLbl.Caption:='Rientro:'
      else
      begin
        // distingue i casi di destinazione unica / più tappe
        if DS.RecordCount = 3 then
          IWLbl.Caption:='Destinazione:'
        else
          IWLbl.Caption:=Format('Tappa %d:',[DS.RecNo - 1]);
      end;
      IWLbl.Tag:=Ordine;
      // in debug mostra l'ordine nell'hint
      if DebugHook <> 0 then
        IWlbl.Hint:=Format('[ORD = %d]',[Ordine]);
      Control:=IWLbl;
    end;
    inc(c);

    // località
    colLocalita:=c;
    with grdPercorso.Cell[r,c] do
    begin
      Css:='align_center';
      IWCmb:=TMedpIWMultiColumnComboBox.Create(Self);
      IWCmb.Parent:=Self.IWFrameRegion;
      IWCmb.Css:='medpMultiColumnCombo';
      //IWCmb.CssInputText:='medpMultiColumnComboBoxInput width30chr';
      IWCmb.Caption:='';
      IWCmb.CodeColumn:=0;
      IWCmb.ColCount:=2;
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
      // tappa personalizzabile in base a parametro aziendale
      //IWCmb.CustomElement:=True;
      IWCmb.CustomElement:=(Parametri.CampiRiferimento.C8_W032TappeSoloSuDistanziometro <> 'S');
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine
      IWCmb.Enabled:=AbilitaModifica;
      IWCmb.LookupColumn:=1;
      IWCmb.medpAutoResetItems:=True;
      IWCmb.PopupHeight:=15;
      IWCmb.PopupWidth:=20;
      IWCmb.Tag:=Ordine;
      if (DS.RecNo = 1) or (DS.RecNo = DS.RecordCount) then
      begin
        // lista 1 (partenza / rientro)
        IWCmb.LoadItems(lstLocalita1);
      end
      else
      begin
        // lista 2 (destinazione)
        IWCmb.LoadItems(lstLocalita2);
      end;
      IWCmb.ItemIndex:=GetIndexFromCodice(IWCmb,DS.FieldByName('LOCALITA').AsString);
      if IWCmb.ItemIndex = -1 then
        IWCmb.Text:=DS.FieldByName('LOCALITA').AsString;
      IWCmb.OnAsyncChange:=cmbLocalitaAsyncChange;
      EvidenziaNuovaLocalitaCombo(IWCmb);
      Control:=IWCmb;
      IWLbl.ForControl:=IWCmb;
      if (IWCmbPrimaTappa = nil) and
         (DS.RecNo > 1) then
      begin
        IWCmbPrimaTappa:=IWCmb;
      end;
    end;
    if DS.RecNo = 1 then
      cmbPartenza:=IWCmb
    else if DS.RecNo = DS.RecordCount then
      cmbRientro:=IWCmb;
    inc(c);

    // indennità km
    colIndKm:=c;
    // ha senso solo dalla prima tappa in poi
    if DS.RecNo = 1 then
    begin
      // bug intraweb: non visualizza css della cella se è vuota (si forza un css fittizio)
      grdPercorso.Cell[r,c].Css:='x';
    end
    else
    begin
      with grdPercorso.Cell[r,c] do
      begin
        Css:='align_center';
        IWChk:=TmeIWCheckbox.Create(Self);
        IWChk.Caption:='';
        IWChk.Checked:=DS.FieldByName('IND_KM').AsString = 'S';
        IWChk.Tag:=Ordine;
        IWChk.Enabled:=AbilitaModifica;
        IWChk.OnAsyncClick:=chkIndKmAsyncClick;
        Control:=IWChk;
      end;
    end;
    inc(c);

    // distanza
    colDistanza:=c;
    with grdPercorso.Cell[r,c] do
    begin
      Css:='align_right';
      IWLbl2:=TmeIWLabel.Create(Self);
      IWLbl2.Caption:='-';
      IWLbl2.Css:='align_right';
      IWLbl2.Tag:=Ordine;
      Control:=IWLbl2;
    end;
    //inc(c);

    DS.Next;
  end;

  // ricalcola le distanze
  OnPercorsoModificato;

  // focus su combo prima tappa
  if IWCmbPrimaTappa <> nil then
  begin
    // non funziona
    //try IWCmbPrimaTappa.SetFocus; except end;
    // versione alternativa
    JSCode:=Format('setTimeout(function(){ '#13#10 +
                   '  GActiveControl=null; '#13#10 +
                   '  try { document.getElementById("%s").focus(); } catch(err){ } '#13#10 +
                   '}, 200);',
                   [IWCmbPrimaTappa.HTMLName]);
    jqFocus.OnReady.Text:=JSCode;
  end;
end;

procedure TW032FPercorsoFM.OnPercorsoModificato;
// gestione degli effetti della modifica del percorso
var
  i, r, NumDistanze, DeltaKm, DeltaKmPos, TotKm, TotKmInd: Integer;
  FlagIndKmCorr, TrattaDesc: String;
  TrattaNonPrevista: Boolean;   // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2
  LocPrec, LocCorr: TLocalita;
  IWLbl: TmeIWLabel;
  IWChk: TmeIWCheckBox;
  IWCmb: TMedpIWMultiColumnComboBox;
begin
  // inizializzazione variabili
  TotKm:=0;
  TotKmInd:=0;
  NumDistanze:=W032DM.selM141.RecordCount - 1;

  // ciclo di calcolo distanze
  W032DM.selM141.First;
  for i:=0 to NumDistanze do
  begin
    // imposta località corrente e flag ind. km
    FlagIndKmCorr:=W032DM.selM141.FieldByName('IND_KM').AsString;
    LocCorr:=GetLocalita(W032DM.selM141.FieldByName('TIPO_LOCALITA').AsString,
                         W032DM.selM141.FieldByName('LOCALITA').AsString,
                         W032DM.selM141.FieldByName('D_LOCALITA').AsString);
    // sposta il dataset sul record successivo
    W032DM.selM141.Next;

    if i > 0 then
    begin
      // calcola distanza tratta
      if (LocPrec.Tipo = '') or (LocCorr.Tipo = '') then
      begin
        // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
        //DeltaKm:=0;
        DeltaKm:=-1;
        // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine
      end
      else
        DeltaKm:=W032DM.GetDistanzaM041_2P(LocPrec,LocCorr);
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
      TrattaNonPrevista:=DeltaKm < 0;
      DeltaKmPos:=Max(0,DeltaKm);
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine

      // totali
      if FlagIndKmCorr = 'S' then
        TotKmInd:=TotKmInd + DeltaKmPos;
      TotKm:=TotKm + DeltaKmPos;

      r:=i + 1;
      TrattaDesc:=Format('%s - %s',[LocPrec.DescLocalita,LocCorr.DescLocalita]);

      // evidenzia la combo della località per indicare che la tratta
      // non è prevista nel distanziometro
      try
        IWCmb:=(grdPercorso.Cell[r,colLocalita].Control as TMedpIWMultiColumnComboBox);
        IWCmb.FriendlyName:=DeltaKm.ToString;
        EvidenziaNuovaLocalitaCombo(IWCmb);
      except
      end;

      // riporta hint su flag indennità km
      try
        IWChk:=(grdPercorso.Cell[r,colIndKm].Control as TmeIWCheckBox);
        if IWChk <> nil then
        begin
          IWChk.Hint:=Format('Indennità km automatica per la tratta %s',[TrattaDesc]);
        end;
      except
      end;

      // riporta la distanza in tabella
      try
        IWLbl:=(grdPercorso.Cell[r,colDistanza].Control as TmeIWLabel);
        if IWLbl <> nil then
        begin
          // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
          if TrattaNonPrevista then
            IWLbl.Caption:='-'
          else
          // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine
            IWLbl.Caption:=Format('%d',[DeltaKm]);
          IWLbl.Hint:=Format('Distanza tratta %s',[TrattaDesc]);
        end;
      except
      end;
    end;

    // salva la località precedente per calcolo della prossima distanza
    LocPrec:=LocCorr;
  end;

  // distanza totale
  lblKmTot.Caption:=Format('Percorso totale: km %d',[TotKm]);
  lblKmTot.Hint:=Format('Percorso indennizzato: km %d',[TotKmInd]);

  // annulla label di errore
  lblErrore.Caption:='';
end;

procedure TW032FPercorsoFM.EvidenziaNuovaLocalitaCombo(PCmb: TMedpIWMultiColumnComboBox);
var
  LCss,LJs: String;
  KmTratta: Integer;
  LocalitaNonInElenco, TrattaNonPrevista: Boolean;
begin
  if PCmb = nil then
    Exit;

  LCss:='';

  // determina se la località non è presente in elenco
  LocalitaNonInElenco:=(PCmb.ItemIndex = -1) and (PCmb.Text <> '');
  if LocalitaNonInElenco then
    LCss:=LCss + ' font_rosso';

  // determina se la tratta non è prevista nel distanziometro (convenzionalmente km tratta = 0)
  // NOTA
  //   PCmb.FriendlyName = km tratta in formato string (negativo se la tratta è inesistente)
  // IMPORTANTE
  //   la combo con tag = 1 (partenza) non viene considerata
  if PCmb.Tag > 1 then
  begin
    if TryStrToInt(PCmb.FriendlyName,KmTratta) then
    begin
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
      //TrattaNonPrevista:=KmTratta = 0
      TrattaNonPrevista:=KmTratta < 0;
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine
    end
    else
      TrattaNonPrevista:=True;
    if TrattaNonPrevista then
      LCss:=LCss + ' font_rosso';
  end;

  // imposta classe di evidenziazione se necessario
  PCmb.CssInputText:=Format('medpMultiColumnComboBoxInput width30chr %s',[LCss.Trim]);

  // bug intraweb
  // nel caso di chiamata async la proprietà non viene recepita, per cui viene forzata via javascript
  if GGetWebApplicationThreadVar.IsCallBack then
  begin
    LJs:=Format('$("#%s").removeClass().addClass("%s");',[PCmb.HTMLName,PCmb.CssInputText]);
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(LJs);
  end;
end;

function TW032FPercorsoFM.GetTipoDestinazione: String;
// estrae il flag di tipo destinazione in base alle destinazioni
// presenti nel dataset selM141 ed al comune della sede di lavoro:
// - 'R' = regione
// - 'I' = fuori regione
// - 'E' = estero
// - ''  = non riconosciuto
var
  Corrente, CodProvinciaDest, CodRegioneDest: String;
  function Peso(const PFlag: String): Integer;
  begin
    // peso maggiore a E (estero), quindi I (fuori regione) e R (regione)
    if PFlag = 'R' then
      Result:=1
    else if PFlag = 'I' then
      Result:=2
    else if PFlag = 'E' then
      Result:=3
    else
      Result:=0;
  end;
  function IsMaggiore(const P1, P2: String): Boolean;
  begin
    Result:=Peso(P1) > Peso(P2);
  end;
begin
  Result:='';

  W032DM.selM141.First;
  while not W032DM.selM141.Eof do
  begin
    if W032DM.selM141.FieldByName('TIPO_LOCALITA').AsString = 'C' then
    begin
      with W032DM.selT480ComuneDest do
      begin
        try
          SetVariable('CODICE',W032DM.selM141.FieldByName('LOCALITA').AsString);
          Execute;
          CodProvinciaDest:=FieldAsString(1);
          CodRegioneDest:=FieldAsString(2);
        except
          CodProvinciaDest:='';
          CodRegioneDest:='';
        end;
      end;

      // determina il flag di destinazione
      if CodRegioneDest = ComuneSede.CodRegione then
        Corrente:='R'  // R = regione
      else if CodProvinciaDest = 'EE' then
        Corrente:='E'  // E = estero
      else
        Corrente:='I'; // I = fuori regione
    end;

    if IsMaggiore(Corrente,Result) then
      Result:=Corrente;

    if Result = 'E' then
      Break;
    W032DM.selM141.Next;
  end;
end;

procedure TW032FPercorsoFM.ReimpostaOrdinePercorso;
// mantiene la consecutività del campo ORD dopo determinate operazioni
// che potrebbero modificarla o comprometterla
// si imposta il valore di ORD = RecNo
begin
  with W032DM.selM141 do
  begin
    First;
    while not Eof do
    begin
      // mantiene consecutività del campo ORD
      Edit;
      FieldByName('ORD').AsInteger:=RecNo;
      Post;

      Next;
    end;
  end;
end;

procedure TW032FPercorsoFM.grdPercorsoRenderCell(ACell: TIWGridCell; const ARow,
  AColumn: Integer);
begin
  C190RenderCell(ACell,ARow,AColumn,True,True,False);
end;

function TW032FPercorsoFM.ControlliOk(var RErrMsg: String): Boolean;
// effettua controlli input
var
  i, DeltaKm: Integer;
  LLocPrec: TLocalita;
  TrattaNonPrevista: Boolean;
  IWLbl: TmeIWLabel;
begin
  Result:=False;
  RErrMsg:='';

  // controlli sul percorso
  SetLength(PercorsoInfo.DestinazioneArr,W032DM.selM141.RecordCount - 2);
  with W032DM.selM141 do
  begin
    // partenza
    First;
    if FieldByName('LOCALITA').AsString = '' then
    begin
      RErrMsg:='E'' necessario indicare la località di partenza!';
      Exit;
    end;
    PercorsoInfo.Partenza:=GetLocalita(FieldByName('TIPO_LOCALITA').AsString,
                                       FieldByName('LOCALITA').AsString,
                                       FieldByName('D_LOCALITA').AsString);
    // rientro
    Last;
    if FieldByName('LOCALITA').AsString = '' then
    begin
      RErrMsg:='E'' necessario indicare la località di rientro!';
      Exit;
    end;
    PercorsoInfo.Rientro:=GetLocalita(FieldByName('TIPO_LOCALITA').AsString,
                                      FieldByName('LOCALITA').AsString,
                                      FieldByName('D_LOCALITA').AsString);

    // esamina le destinazioni
    LLocPrec:=PercorsoInfo.Partenza;
    i:=0;
    RecNo:=2;
    while RecNo < RecordCount do
    begin
      // controllo località indicata
      if FieldByName('LOCALITA').AsString = '' then
      begin
        if RecordCount = 3 then
          RErrMsg:='E'' necessario indicare la località di destinazione!'
        else
          RErrMsg:=Format('E'' necessario indicare la località della tappa numero %d!',[i + 1]);
        Exit;
      end;

      PercorsoInfo.DestinazioneArr[i]:=GetLocalita(FieldByName('TIPO_LOCALITA').AsString,
                                                   FieldByName('LOCALITA').AsString,
                                                   FieldByName('D_LOCALITA').AsString);;

      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
      if Parametri.CampiRiferimento.C8_W032TappeSoloSuDistanziometro = 'S' then
      begin
        // verifica se la tratta in questione è prevista sul distanziometro
        TrattaNonPrevista:=True;
        try
          IWLbl:=(grdPercorso.Cell[RecNo,colDistanza].Control as TmeIWLabel);
          if TryStrToInt(IWLbl.Caption,DeltaKm) then
            TrattaNonPrevista:=DeltaKm < 0;
        except
        end;
        if TrattaNonPrevista then
        begin
          RErrMsg:=IfThen(Parametri.CampiRiferimento.C8_W032MessaggioTappeInesistenti <> '',
                          Parametri.CampiRiferimento.C8_W032MessaggioTappeInesistenti,
                          'Il percorso indicato non è presente nel distanziometro!'#13#10'Verificare la tratta %s');
          if RErrMsg.Contains('%s') then
            RErrMsg:=Format(RErrMsg,[LLocPrec.DescLocalita + ' - ' + PercorsoInfo.DestinazioneArr[i].DescLocalita]);
          Exit;
        end;
      end;
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine

      // AOSTA_REGIONE - chiamata 87975.ini
      // questi controlli sono stati eliminati in seguito a richiesta utente
      {
      // la destinazione non può essere uguale alla località di partenza
      if PercorsoInfo.DestinazioneArr[i] = PercorsoInfo.Partenza then // cfr. W032URichiestaMissioniDM - class operator TLocalita.Equal
      begin
        if RecordCount = 3 then
        begin
          RErrMsg:='La località di destinazione non può coincidere con la località di partenza!';
          Exit;
        end;
      end;

      // la destinazione non può essere uguale alla località di rientro
      if PercorsoInfo.DestinazioneArr[i] = PercorsoInfo.Rientro then // cfr. W032URichiestaMissioniDM - class operator TLocalita.Equal
      begin
        if RecordCount = 3 then
        begin
          RErrMsg:='La destinazione non può coincidere con la località di rientro!';
          Exit;
        end;
      end;

      // la località non può essere uguale alla precedente
      if PercorsoInfo.DestinazioneArr[i] = LLocPrec then
      begin
        RErrMsg:=Format('La località della tappa numero %d non può coincidere con quella precedente!',[i + 1]);
        Exit;
      end;
      }
      // AOSTA_REGIONE - chiamata 87975.fine

      LLocPrec:=PercorsoInfo.DestinazioneArr[i];
      inc(i);

      Next;
    end;
  end;

  // AOSTA_REGIONE - chiamata 87975.ini
  // il controllo è stato eliminato in seguito a richiesta utente
  {
  // la località di rientro non può essere uguale alla precedente
  if PercorsoInfo.Rientro = LLocPrec then
  begin
    RErrMsg:='La località di rientro non può coincidere con quella precedente!';
    Exit;
  end;
  }
  // AOSTA_REGIONE - chiamata 87975.fine

  // reimposta i valori del campo ORD
  ReimpostaOrdinePercorso;

  // compone testo del percorso
  PercorsoInfo.ElencoDestinazioni:='';
  PercorsoInfo.ElencoDestinazioniDesc:='';
  for i:=0 to High(PercorsoInfo.DestinazioneArr) do
  begin
    PercorsoInfo.ElencoDestinazioni:=PercorsoInfo.ElencoDestinazioni + PercorsoInfo.DestinazioneArr[i].CodLocalita + ',';
    PercorsoInfo.ElencoDestinazioniDesc:=PercorsoInfo.ElencoDestinazioniDesc + ' - ' + PercorsoInfo.DestinazioneArr[i].DescLocalita;
  end;
  if Length(PercorsoInfo.DestinazioneArr) > 0 then
    PercorsoInfo.ElencoDestinazioni:=PercorsoInfo.ElencoDestinazioni.Substring(0,PercorsoInfo.ElencoDestinazioni.Length - 1);
  PercorsoInfo.Testo:=PercorsoInfo.Partenza.DescLocalita +
                      PercorsoInfo.ElencoDestinazioniDesc + ' - ' +
                      PercorsoInfo.Rientro.DescLocalita;

  // flag percorso
  PercorsoInfo.FlagPercorso:=FlagPercorsoIndexToStr(rgpFlagPercorso.ItemIndex);

  // determina il tipo di destinazione in base alla destinazione più lontana:
  // regione (R), fuori regione (I), estero (E)
  PercorsoInfo.FlagDestinazione:=GetTipoDestinazione;

  Result:=True;
end;

procedure TW032FPercorsoFM.btnNuovaTappaClick(Sender: TObject);
var
  idx, MaxOrd: Integer;
  LLoc: TLocalita;
begin
  idx:=cmbNuovaTappa.ItemIndex;
  if (idx = -1) and (Trim(cmbNuovaTappa.Text) = '') then
  begin
    lblErrore.Caption:='Selezionare la nuova tappa dal menu a discesa oppure digitarne una';
    Exit;
  end;

  // imposta i dati della localita scelta
  if idx = -1 then
  begin
    // località non presente su db
    cmbNuovaTappa.Text:=Trim(cmbNuovaTappa.Text);
    LLoc:=GetLocalita('',cmbNuovaTappa.Text,cmbNuovaTappa.Text);
  end
  else
  begin
    // località scelta fra quelle disponibili
    LLoc:=GetLocalita(cmbNuovaTappa.Items[idx].RowData[COL_TIPO_LOCALITA],
                      cmbNuovaTappa.Items[idx].RowData[COL_COD_LOCALITA],
                      cmbNuovaTappa.Items[idx].RowData[COL_DESC_LOCALITA])
  end;

  // aggiunge la località al dataset delle tappe
  with W032DM.selM141 do
  begin
    // aumenta di 1 l'ordine del record di rientro
    Last;
    MaxOrd:=FieldByName('ORD').AsInteger;
    Edit;
    FieldByName('ORD').AsInteger:=FieldByName('ORD').AsInteger + 1;
    Post;

    // inserisce la nuova tappa in penultima posizione (prima del rientro)
    Insert;
    FieldByName('ID').AsInteger:=W032DM.selM140.FieldByName('ID').AsInteger;
    FieldByName('ORD').AsInteger:=MaxOrd;
    FieldByName('LOCALITA').AsString:=LLoc.CodLocalita;
    FieldByName('TIPO_LOCALITA').AsString:=LLoc.Tipo;
    FieldByName('D_LOCALITA').AsString:=LLoc.DescLocalita;
    FieldByName('IND_KM').AsString:='S';
    Post;
  end;

  // riporta modifiche sulla vista
  CaricaGridPercorso;

  // procede con abilitazioni
  ImpostaAbilitazioniVista;

  // svuota combobox per successivo eventuale inserimento
  cmbNuovaTappa.Text:='';
end;

procedure TW032FPercorsoFM.btnConfermaClick(Sender: TObject);
var
  Ok: Boolean;
  ErrStr: String;
begin
  // effettua controlli input
  Ok:=ControlliOk(ErrStr);
  lblErrore.Caption:=ErrStr;

  // se errori termina subito
  if not Ok then
    Exit;

  // conferma il percorso indicato
  try
    (Self.Owner as TW032FRichiestaMissioni).ConfermaPercorso(PercorsoInfo);
  finally
    FreeAndNil(lstLocalita1);
    FreeAndNil(lstLocalita2);
    Free;
  end;
end;

procedure TW032FPercorsoFM.btnAnnullaClick(Sender: TObject);
begin
  if AbilitaModifica then
  begin
    // pulizia dati percorso
    PulisciDatiPercorso;

    if W032DM.selM141.UpdatesPending then
      W032DM.selM141.CancelUpdates;
  end;

  // se necessario annulla le modifiche al percorso indicato
  try
    if AbilitaModifica then
      (Self.Owner as TW032FRichiestaMissioni).AnnullaPercorso;
  finally
    FreeAndNil(lstLocalita1);
    FreeAndNil(lstLocalita2);
    Free;
  end;
end;

end.