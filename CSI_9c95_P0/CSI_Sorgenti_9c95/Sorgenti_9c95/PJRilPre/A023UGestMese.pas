unit A023UGestMese;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Oracle, OracleData, Db, A000UInterfaccia,
  C180FunzioniGenerali, R500Lin, Rp502Pro, R600, Grids, DBGrids, StrUtils, Mask,
  ExtCtrls, ComCtrls, DatiBloccati, Math, Buttons, C700USelezioneAnagrafe,
  A003UDataLavoroBis, C013UCheckList, DBClient, Spin, C004UParamForm, ActnList,
  ImgList, Menus, A000UCostanti, A000USessione,A023UTimbratureMW, System.Actions, System.ImageList;

type
  TFiltro = record
    Periodo: String;
    Tipologia: String;
    Scostamento: String;
    DalleAlle: String;
    StraordCaus: String;
    EventoStraord: String;
    Modificato: Boolean;
    SogliaDalleAlle: Integer;
    SoloStraordCaus: Boolean;
  end;  

  TElencoDate = record
    Data:TDateTime;
    Colorata:Boolean;
  end;

  // mw.ini
  //TGiorniConteggi = record
  //  Inizio,
  //  Fine: TDateTime;
  //  GiorniConsideratiList: TStringList;
  //end;
  // mw.fine

  TA023FGestMese = class(TForm)
    dgrdGestMese: TDBGrid;
    pnlTop: TPanel;
    StatusBar1: TStatusBar;
    pnlTop1: TPanel;
    rgpTipo: TRadioGroup;
    grpFiltriVisualizzazione: TGroupBox;
    chkFiltroScost: TCheckBox;
    edtSogliaScost: TMaskEdit;
    cmbFiltroScost: TComboBox;
    chkFiltroDalleAlle: TCheckBox;
    edtSogliaDalleAlle: TMaskEdit;
    lblDipendente: TLabel;
    Label2: TLabel;
    cdsTemp: TClientDataSet;
    cdsTempORE: TIntegerField;
    cdsTempDATA: TDateTimeField;
    cdsCausOre: TClientDataSet;
    cdsCausOreORE: TIntegerField;
    cdsCausOreORE_H: TStringField;
    dscCausOre: TDataSource;
    Label3: TLabel;
    Splitter1: TSplitter;
    grpStraordinarioStandard: TGroupBox;
    Label1: TLabel;                                                    
    cmbCausPres: TComboBox;
    btnAssegnaCausStraord: TBitBtn;
    chkSovrascrivi: TCheckBox;
    cdsTempCAUSALE: TStringField;
    cdsCausOreCAUSALE: TStringField;
    chkFiltroStraordCaus: TCheckBox;
    cdsTempC_ARROT_RIEPGG: TIntegerField;
    cdsCausOreCAUSALIZZATO: TIntegerField;
    actlstBase: TActionList;
    ImageList1: TImageList;
    actDuplica: TAction;
    PopupMenu1: TPopupMenu;
    Duplica1: TMenuItem;
    pnlBottom: TPanel;
    pnlPulsanti: TPanel;
    btnClose: TBitBtn;
    btnAnnulla: TBitBtn;
    grpRiepilogoCausali: TGroupBox;
    dgrdBudgetServizi: TDBGrid;
    edtDataDa: TMaskEdit;
    edtDataA: TMaskEdit;
    btnDataDa: TBitBtn;
    btnDataA: TBitBtn;
    btnSetPeriodo: TBitBtn;
    btnResetPianifCaus: TBitBtn;
    pnlTotCaus: TPanel;
    lblTotStraord: TLabel;
    Label4: TLabel;
    cdsGestMeseTemp: TClientDataSet;
    cdsGestMeseTempGIORNO: TDateField;
    cdsGestMeseTempDALLE: TIntegerField;
    cdsGestMeseTempALLE: TIntegerField;
    cdsGestMeseTempID: TIntegerField;
    actInserisci: TAction;
    Nuova1: TMenuItem;
    actElimina: TAction;
    Elimina1: TMenuItem;
    btnConferma: TBitBtn;
    grpEventiStraordinari: TGroupBox;
    dgrdT722: TDBGrid;
    chkEventiStraordinari: TCheckBox;
    cdsCausOreAVVISO: TStringField;
    Splitter2: TSplitter;
    dgrdCausOre: TDBGrid;
    lblBudgetServizi: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgpTipoClick(Sender: TObject);
    procedure chkFiltroScostClick(Sender: TObject);
    procedure edtSogliaScostChange(Sender: TObject);
    procedure edtSogliaScostExit(Sender: TObject);
    procedure dgrdGestMeseDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnAnnullaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);                           
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dgrdGestMeseExit(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnAssegnaCausClick(Sender: TObject);
    procedure cmbCausPresKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbFiltroScostChange(Sender: TObject);
    procedure edtSogliaDalleAlleChange(Sender: TObject);
    procedure edtSogliaDalleAlleExit(Sender: TObject);
    procedure dgrdGestMeseKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsTempCalcFields(DataSet: TDataSet);
    procedure cdsCausOreCalcFields(DataSet: TDataSet);
    procedure dgrdCausOreDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure actDuplicaExecute(Sender: TObject);
    procedure btnResetPianifCausClick(Sender: TObject);
    procedure btnDataDaClick(Sender: TObject);
    procedure btnDataAClick(Sender: TObject);
    procedure btnSetPeriodoClick(Sender: TObject);
    procedure cdsGestMeseTempFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure actInserisciExecute(Sender: TObject);
    procedure edtDataADblClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);
    procedure chkEventiStraordinariClick(Sender: TObject);
    procedure dgrdT722DblClick(Sender: TObject);
    procedure dgrdBudgetServiziDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    ElencoDate:array of TElencoDate;
    NumDate:Word;
    AccessoA004,OldSogliaScost,OldSogliaDalleAlle: String;
    PresList,AssList:TStringList;
    //GiorniConteggi:TGiorniConteggi; // mw
    selDatiBloccati:TDatiBloccati;
    DataInizioMese,DataFineMese,DataInizio,DataFine: TDateTime;
    ParametriIniziali,EntNomFlex: Boolean;
    BMAttuale:TBookmark;
    procedure CleanFiltro;
    procedure ImpostaAbilitazioniTipo;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure SalvaBookmarkCds;
    procedure RipristinaBookmarkCds;
    procedure PopolaGrid;
    // mw.ini
    //function IsGiornoDaConsiderare(Giorno:TDateTime): Boolean;
    //function CopertoDaTimbratura(Ent,Usc: Integer): Boolean;
    //procedure GestGiorno(Giorno: TDateTime);
    //procedure AggiungiRiga(Giorno:TDateTime; Tipo:String; TagTimb: String; Dalle, Alle:Integer; Causale:String; TotLav,DebitoGG,Scost: Integer);
    // mw.fine
    function ControllaIntersezioni: Boolean;
    procedure SalvaDati;
    procedure ApplicaFiltri(ForzaAggiornamento:Boolean = False);
    procedure InsPianif;
    procedure CancPianif;
    procedure InsGiustif;
    procedure CancGiustif;
    const SOGLIA_NULLA: String = '99999';
  public
    R502ProDtM:TR502ProDtM1;
    Progressivo:Integer;
    DataMese,DataSelezionata:TDateTime;
    OldConteggiAttivi:Boolean;
    CanInsert:Boolean;
    PresPickList,AssPickList: String;
    Filtro: TFiltro;
    procedure TotalizzaPeriodo;
    procedure AssegnaColoriGrid;
  end;

var
  A023FGestMese: TA023FGestMese;

const
  CAUSALE_MOS          = '';                        // per ora è nulla
  CAUSALE_NC           = 'NON CAUSALIZZATO';        // causale convenzionale per totale "non causalizzato"
  AVVISO_SUPERO_DISP   = 'Superata disponibilità';  // avviso di superata disponibilità
  BG_COLOR_NC          = $00FFFF80;                 // riga non causalizzata: sfondo azzurrino
  BG_COLOR_SUPERO_DISP = $000000FF;                 // riga che supera la disponibilità: sfondo rosso
  INFO_RIGA: array[1..3] of String =
  {1}                   ('Causale di autogiustificazione',
  {2}                    'Causale non abilitata',
  {3}                    'Gestione giustificativi non abilitata'
                        );

implementation

uses A023UTimbrature, A023UTimbratureDtM1, A023UGestMeseMW, SelAnagrafe;

{$R *.dfm}

procedure TA023FGestMese.FormCreate(Sender: TObject);
begin
  EntNomFlex:=True; // indica se l'entrata nominale deve includere la flessibilità
  R502ProDtM:=TR502ProDtM1.Create(nil);
  selDatiBloccati:=TDatiBloccati.Create(nil);
  selDatiBloccati.TipoLog:='';
  AccessoA004:=A000GetInibizioni('Funzione','OpenA004GiustifAssPres');
  {$IFDEF DEBUG_MEDP}
  AccessoA004:='S'; // prova per abilitazione giustificativi
  {$ENDIF}
  // carica le liste dei giustificativi di assenza e presenza
  PresPickList:='';
  AssPickList:='';
  try
    PresList:=TStringList.Create;
    AssList:=TStringList.Create;
    with A023FTimbratureDtM1.selAssPres do
    begin
      // ordinamento default: tipo 'P'(presenze), codice
      SetVariable('ORDINAMENTO','ORDER BY 1 DESC,2');
      Filtered:=True;
      Open;
      // ciclo per comporre le stringlist di assenze e presenze + combo delle causali di straord.
      cmbCausPres.Items.BeginUpdate;
      First;
      while not Eof do
      begin
        if FieldByName('TIPO').AsString = 'P' then
        begin
          PresList.Add(FieldByName('CODICE').AsString);
          cmbCausPres.Items.Add(FieldByName('DESCRIZIONE').AsString);
        end
        else
          AssList.Add(FieldByName('CODICE').AsString);
        Next;
      end;
      cmbCausPres.Items.EndUpdate;
    end;
    PresPickList:=PresList.CommaText;
    AssPickList:=AssList.CommaText;
  finally
    FreeAndNil(PresList);
    FreeAndNil(AssList);
  end;
  A023FTimbratureDtM1.selDistT722.Open;
  A023FTimbratureDtM1.GetServiziEventiStr;
  // pulisce informazioni del filtro del client dataset
  CleanFiltro;
  // crea i client dataset
  with cdsTemp do
  begin
    Close;
    CreateDataset;
    LogChanges:=False;
    Open;
  end;
  with cdsCausOre do
  begin
    Close;
    CreateDataset;
    LogChanges:=False;
    Open;
  end;
  with A023FTimbratureDtM1.cdsGestMese do
  begin
    // Notare la differenza tra i campi DATA e DATA_CONTEGGI
    // che hanno sempre lo stesso valore, tranne per i giorni in cui i conteggi sono
    // riferiti al giorno precedente (timbrature a cavallo di mezzanotte per cui
    // i minuti sono stati spostati avanti di 6000)
    Close;
    CreateDataset;
    LogChanges:=False;
    Open;
    AfterScroll:=nil;
    Filter:='';
    Filtered:=False;
    AfterScroll:=A023FTimbratureDtM1.cdsGestMeseAfterScroll;
  end;
  dgrdT722.Visible:=False;
  grpEventiStraordinari.Height:=18;

  // mw.ini
  A023FGestMeseMW:=TA023FGestMeseMW.Create(nil);
  A023FGestMeseMW.Progressivo:=C700Progressivo;
  A023FGestMeseMW.R502ProDtM:=R502ProDtM;
  A023FGestMeseMW.AccessoGiust:=AccessoA004;
  A023FGestMeseMW.SB:=StatusBar1;
  A023FGestMeseMW.Q275:=A023FTimbratureDtM1.A023FTimbratureMW.Q275;
  A023FGestMeseMW.selAssPres:=A023FTimbratureDtM1.selAssPres;
  A023FGestMeseMW.cdsGestMese:=A023FTimbratureDtM1.cdsGestMese;
  // mw.fine
end;

procedure TA023FGestMese.FormShow(Sender: TObject);
var
  DataSearch, DataStop: TDateTime;
  Trovato: Boolean;
begin
  // gestione dei parametri
  CreaC004(SessioneOracle,'A023',Parametri.ProgOper);

  // dati del dipendente
  lblDipendente.Caption:=Format('%-8s %s %s',[C700SelAnagrafe.FieldByName('MATRICOLA').AsString,C700SelAnagrafe.FieldByName('COGNOME').AsString,C700SelAnagrafe.FieldByName('NOME').AsString]);

  // imposta le date del periodo di riferimento
  DataInizioMese:=R180InizioMese(DataMese);
  DataFineMese:=R180FineMese(DataMese);

  // imposta i limiti del periodo
  DataInizio:=DataInizioMese;
  DataFine:=DataFineMese;
  DataSelezionata:=DataInizio;
  edtDataDa.OnChange:=nil;
  edtDataA.OnChange:=nil;
  edtDataDa.Text:=DateToStr(DataInizioMese);
  edtDataA.Text:=DateToStr(DataFineMese);
  SetLength(ElencoDate,32); // range iniziale [1..31] per colorazione alternata griglia

  // legge i parametri associati all'utente
  GetParametriFunzione;

  // mw.ini
  // struttura per i giorni da considerare nei conteggi
  //with GiorniConteggi do
  //begin
  //  Inizio:=0;
  //  Fine:=0;
  //  GiorniConsideratiList:=TStringList.Create;
  //end;
  // mw.fine

  // popolamento dataset
  PopolaGrid;

  // posizionamento cursore
  with A023FTimbratureDtM1.cdsGestMese do
  if RecordCount > 0 then
  begin
    if A023FTimbrature = nil then
      First
    else
    begin
      // posizionamento a partire dalla data selezionata sul cartellino interattivo
      // (il ciclo prosegue sino a fine mese)
      DataSearch:=EncodeDate(A023FTimbrature.EAnno.Value,A023FTimbrature.EMese.Value,A023FTimbrature.Giorno);
      DataStop:=R180FineMese(DataSearch);
      Trovato:=False;
      while DataSearch <= DataStop do
      begin
        Trovato:=Locate('DATA',VarArrayOf([DataSearch]),[]);
        if Trovato then
          Break;
        DataSearch:=DataSearch + 1;
      end;
      // se non trova nessuna data, si posiziona sul primo record
      if not Trovato then
        First;
    end;
  end;
end;

procedure TA023FGestMese.CleanFiltro;
// Pulisce le informazioni relative al filtro del client dataset
begin
  Filtro.Tipologia:='';
  Filtro.Scostamento:='';
  Filtro.DalleAlle:='';
  Filtro.SogliaDalleAlle:=-1;
  Filtro.StraordCaus:='';
  Filtro.SoloStraordCaus:=False;
  Filtro.Modificato:=True;
end;

procedure TA023FGestMese.ImpostaAbilitazioniTipo;
begin
  if rgpTipo.ItemIndex = 2 then
  begin
    cmbCausPres.ItemIndex:=-1;
    chkSovrascrivi.Checked:=False;
    chkFiltroStraordCaus.Checked:=False;
  end;
  cmbCausPres.Enabled:=(rgpTipo.ItemIndex <> 2) and (not chkEventiStraordinari.Checked);
  btnAssegnaCausStraord.Enabled:=(rgpTipo.ItemIndex <> 2) and
                                 ((not chkEventiStraordinari.Checked) or (Pos(',',A023FTimbratureDtM1.selT722.FieldByName('SERVIZI').AsString) = 0));
  chkSovrascrivi.Enabled:=btnAssegnaCausStraord.Enabled;
  chkFiltroStraordCaus.Enabled:=rgpTipo.ItemIndex <> 2;
  dgrdGestMese.Columns[R180GetColonnaDBGrid(dgrdGestMese,'C_AUTORIZZATO')].Visible:=rgpTipo.ItemIndex <> 2;
  actInserisci.Enabled:=rgpTipo.ItemIndex <> 2;
end;

procedure TA023FGestMese.GetParametriFunzione;
var
  SogliaScost,SogliaDalleAlle: String;
begin
  // filtro scostamento
  chkFiltroScost.OnClick:=nil;
  chkFiltroScost.Checked:=C004FParamForm.GetParametro('CHKFILTROSCOST','N') = 'S';
  chkFiltroScost.OnClick:=chkFiltroScostClick;

  cmbFiltroScost.OnChange:=nil;
  cmbFiltroScost.ItemIndex:=StrToInt(C004FParamForm.GetParametro('CMBFILTROSCOST','0'));
  cmbFiltroScost.OnChange:=cmbFiltroScostChange;

  edtSogliaScost.OnChange:=nil;
  SogliaScost:=C004FParamForm.GetParametro('SOGLIASCOST',SOGLIA_NULLA);
  edtSogliaScost.Text:=IfThen(SogliaScost = SOGLIA_NULLA,'',R180MinutiOre(StrToInt(SogliaScost)));
  edtSogliaScost.OnChange:=edtSogliaScostChange;

  // filtro dalle-alle
  chkFiltroDalleAlle.OnClick:=nil;
  chkFiltroDalleAlle.Checked:=C004FParamForm.GetParametro('CHKFILTRODALLEALLE','N') = 'S';
  chkFiltroDalleAlle.OnClick:=chkFiltroScostClick;

  edtSogliaDalleAlle.OnChange:=nil;
  SogliaDalleAlle:=C004FParamForm.GetParametro('SOGLIADALLEALLE',SOGLIA_NULLA);
  edtSogliaDalleAlle.Text:=IfThen(SogliaDalleAlle = SOGLIA_NULLA,'',R180MinutiOre(StrToInt(SogliaDalleAlle)));
  edtSogliaDalleAlle.OnChange:=edtSogliaDalleAlleChange;

  // filtro presenze solo causalizzate
  chkFiltroStraordCaus.OnClick:=nil;
  chkFiltroStraordCaus.Checked:=C004FParamForm.GetParametro('CHKFILTROSTRAORDCAUS','N') = 'S';
  chkFiltroStraordCaus.OnClick:=chkFiltroScostClick;

  // filtro tipologia
  rgpTipo.OnClick:=nil;
  rgpTipo.ItemIndex:=StrToInt(C004FParamForm.GetParametro('RGPTIPO','0'));
  rgpTipo.OnClick:=rgpTipoClick;
  ImpostaAbilitazioniTipo;
  
  ParametriIniziali:=True;
end;

procedure TA023FGestMese.PutParametriFunzione;
begin
  C004FParamForm.Cancella001;

  // filtro tipologia
  C004FParamForm.PutParametro('RGPTIPO',IntToStr(rgpTipo.ItemIndex));

  // filtro scostamento
  C004FParamForm.PutParametro('CHKFILTROSCOST',IfThen(chkFiltroScost.Checked,'S','N'));
  C004FParamForm.PutParametro('CMBFILTROSCOST',IntToStr(cmbFiltroScost.ItemIndex));
  if (Trim(edtSogliaScost.Text) <> '') and
     (Trim(edtSogliaScost.Text) <> '.') and
     (Trim(edtSogliaScost.Text) <> ':') then
    C004FParamForm.PutParametro('SOGLIASCOST',IntToStr(R180OreMinutiExt(edtSogliaScost.Text)))
  else
    C004FParamForm.PutParametro('SOGLIASCOST',SOGLIA_NULLA);

  // filtro dalle-alle
  C004FParamForm.PutParametro('CHKFILTRODALLEALLE',IfThen(chkFiltroDalleAlle.Checked,'S','N'));
  if (Trim(edtSogliaDalleAlle.Text) <> '') and
     (Trim(edtSogliaDalleAlle.Text) <> '.') and
     (Trim(edtSogliaDalleAlle.Text) <> ':') then
    C004FParamForm.PutParametro('SOGLIADALLEALLE',IntToStr(R180OreMinutiExt(edtSogliaDalleAlle.Text)))
  else
    C004FParamForm.PutParametro('SOGLIADALLEALLE',SOGLIA_NULLA);

  // filtro causali di presenza solo causalizzati
  C004FParamForm.PutParametro('CHKFILTROSTRAORDCAUS',IfThen(chkFiltroStraordCaus.Checked,'S','N'));
  try SessioneOracle.Commit; except end;
end;

procedure TA023FGestMese.SalvaBookmarkCds;
// Salva il bookmark del client dataset della gestione mensile
begin
  try
    BMAttuale:=A023FTimbratureDtM1.cdsGestMese.GetBookmark;
  except end;
end;

procedure TA023FGestMese.RipristinaBookmarkCds;
// Ripristina il bookmark del client dataset della gestione mensile.
// In caso di errori il posizionamento avviene sul primo record
begin
  with A023FTimbratureDtM1.cdsGestMese do
  try
    try
      // termina se il client dataset è vuoto
      if RecordCount = 0 then
        Exit;

      // se esiste un bookmark salvato lo valuta
      if BMAttuale <> nil then
      begin
        if BookMarkValid(BMAttuale) then
          GotoBookmark(BMAttuale)
        else
          First;
      end;
    except
      on E:Exception do
        R180MessageBox('Eccezione di tipo ' + E.ClassName  + ': ' + E.Message,INFORMA);
    end;
  finally
    FreeBookmark(BMAttuale);
    BMAttuale:=nil;
  end;
end;

procedure TA023FGestMese.PopolaGrid;
// Popolamento della griglia con le ore di assenza o di presenza
var
  i: Integer;
  OldFiltered: Boolean;
begin
  Screen.Cursor:=crHourGlass;

  // creazione client dataset
  with A023FTimbratureDtM1.cdsGestMese do
  begin
    DisableControls;
    EmptyDataset;
    OldFiltered:=Filtered;
    Filter:='';
    Filtered:=False;
    CleanFiltro;
    AfterScroll:=nil;
    BeforeInsert:=nil;
    BeforePost:=nil;
    AfterPost:=nil;
    FieldByName('DATA').OnValidate:=nil;
    FieldByName('DALLE_H').OnValidate:=nil;
    FieldByName('ALLE_H').OnValidate:=nil;
    FieldByName('CAUSALE').OnValidate:=nil;
    FieldByName('DESC_CAUSALE').OnValidate:=nil;
    // abilita l'edit di tutti i campi
    for i:=0 to FieldCount - 1 do
      Fields[i].ReadOnly:=False;
  end;

  // esegue i conteggi per ogni giorno del mese e carica i dati nella grid
  try
    try
      A023FGestMeseMW.PopolaDataset(DataInizioMese,DataFineMese);
    except
      on E:Exception do
      begin
        StatusBar1.Panels[0].Text:='Anomalia rilevata.';
        StatusBar1.Repaint;
        raise;
      end;
    end;
  finally
    // applica i filtri attualmente selezionati
    // se il dataset era precedentemente filtrato, forza l'applicazione del filtro
    ApplicaFiltri(OldFiltered);

    // reimposta gli eventi del dataset
    with A023FTimbratureDtM1 do
    begin
      cdsGestMese.AfterScroll:=cdsGestMeseAfterScroll;
      cdsGestMese.BeforeInsert:=cdsGestMeseBeforeInsert;
      cdsGestMese.BeforePost:=cdsGestMeseBeforePost;
      cdsGestMese.AfterPost:=cdsGestMeseAfterPost;
      cdsGestMese.FieldByName('DATA').OnValidate:=cdsGestMeseDATAValidate;
      cdsGestMese.FieldByName('DALLE_H').OnValidate:=cdsGestMeseDALLE_HValidate;
      cdsGestMese.FieldByName('ALLE_H').OnValidate:=cdsGestMeseDALLE_HValidate;
      cdsGestMese.FieldByName('CAUSALE').OnValidate:=cdsGestMeseCAUSALEValidate;
      cdsGestMese.FieldByName('DESC_CAUSALE').OnValidate:=cdsGestMeseCAUSALEValidate;
      cdsGestMese.EnableControls;
    end;

    // disabilita l'inserimento manuale nel dataset
    CanInsert:=False;
    StatusBar1.Panels[0].Text:='';
    StatusBar1.Repaint;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA023FGestMese.PopupMenu1Popup(Sender: TObject);
begin
  // abilitazione actElimina
  if (A023FTimbratureDtM1.cdsGestMese.Active) and
     (A023FTimbratureDtM1.cdsGestMese.RecordCount > 0) then
    actElimina.Enabled:=(A023FTimbratureDtM1.cdsGestMese.FieldByName('FLAG_RIGA').AsString <> 'A') and
                        (A023FTimbratureDtM1.cdsGestMese.FieldByName('FLAG_RIGA').AsString <> 'B')
  else
    actElimina.Enabled:=False;
end;

procedure TA023FGestMese.AssegnaColoriGrid;
// Assegna la colorazione alternata alle righe per ogni giorno del periodo
var
  i: Integer;
begin
  with A023FTimbratureDtM1.cdsGestMese do
  try
    // inizializza l'array di impostazione dei colori
    for i:=1 to Length(ElencoDate) - 1 do
    begin
      ElencoDate[i].Data:=0;
      ElencoDate[i].Colorata:=False;
    end;
    // ciclo di assegnazione colori
    NumDate:=1;
    First;
    while not Eof do
    begin
      if NumDate = 1 then
      begin
        ElencoDate[NumDate].Data:=FieldByName('DATA').AsDateTime;
        inc(NumDate);
        end
      else
      begin
        if ElencoDate[NumDate - 1].Data <> FieldByName('DATA').AsDateTime then
        begin
          ElencoDate[NumDate].Data:=FieldByName('DATA').AsDateTime;
          ElencoDate[NumDate].Colorata:=not ElencoDate[NumDate - 1].Colorata;
          inc(NumDate);
        end;
      end;
      Next;
    end;
  except
  end;
end;

procedure TA023FGestMese.ApplicaFiltri(ForzaAggiornamento:Boolean = False);
// Applicazione dei filtri impostati a video al clientdataset principale
var
  FiltroStr,Operatore: String;
  Filtro1,Filtro2,Filtro3,Filtro4,Filtro5,Filtro6: String;
  //DataInizio,DataFine: TDateTime;
begin
  Screen.Cursor:=crHourGlass;
  Filtro.Modificato:=ParametriIniziali or ForzaAggiornamento;
  ParametriIniziali:=False;

  // 1. filtro periodo
  // Nota: Datainizio e Datafine sono impostate sul click del pulsante "Refresh"
  //       il filtro considera la DATA_CONTEGGI!
  Filtro1:='(DATA_CONTEGGI >= ' + FloatToStr(DataInizio) + ' and DATA_CONTEGGI <= ' + FloatToStr(DataFine) + ')';
  Filtro.Modificato:=(Filtro.Modificato) or (Filtro1 <> Filtro.Periodo);
  Filtro.Periodo:=Filtro1;

  // 2. filtro tipologia
  case rgpTipo.ItemIndex of
    0: Filtro2:='';
    1: Filtro2:='(TIPO = ''GP'' or TIPO = ''P'')';
    2: Filtro2:='(TIPO = ''GA'')';
  else Filtro2:='';
  end;
  Filtro.Modificato:=(Filtro.Modificato) or (Filtro2 <> Filtro.Tipologia);
  Filtro.Tipologia:=Filtro2;

  // 3. filtro scostamento
  Filtro3:='';
  if (chkFiltroScost.Checked) and
     (Trim(edtSogliaScost.Text) <> '') and
     (Trim(edtSogliaScost.Text) <> '.') and
     (Trim(edtSogliaScost.Text) <> ':') then
  begin
    try
      if OreMinutiValidate(edtSogliaScost.Text) then
      begin
        case cmbFiltroScost.ItemIndex of
          0: Operatore:='<';
          1: Operatore:='>';
          2: Operatore:='=';
        else
          Operatore:='<';  // default "scostamento minore di"
        end;
        Filtro3:='(SCOST ' + Operatore + ' ' + IntToStr(R180OreMinutiExt(edtSogliaScost.Text)) + ')';
      end;
    except
      Filtro3:='';
    end;
  end;
  Filtro.Modificato:=(Filtro.Modificato) or (Filtro3 <> Filtro.Scostamento);
  Filtro.Scostamento:=Filtro3;

  // 4. filtro periodo dalle-alle
  // IMPORTANTE: non utilizzato qui -> v. cdsGestMese.OnFilterRecord --
  Filtro4:='';
  Filtro.SogliaDalleAlle:=-1;
  if (chkFiltroDalleAlle.Checked) and
     (Trim(edtSogliaDalleAlle.Text) <> '') and
     (Trim(edtSogliaDalleAlle.Text) <> '.') and
     (Trim(edtSogliaDalleAlle.Text) <> ':') then
  begin
    try
      if OreMinutiValidate(edtSogliaDalleAlle.Text) then
      begin
        Filtro4:='(C_PERIODO > ' + IntToStr(R180OreMinutiExt(edtSogliaDalleAlle.Text)) + ')';
        Filtro.SogliaDalleAlle:=R180OreMinutiExt(edtSogliaDalleAlle.Text);
      end;
    except
      Filtro4:='';
      Filtro.SogliaDalleAlle:=-1;
    end;
  end;
  Filtro.Modificato:=(Filtro.Modificato) or (Filtro4 <> Filtro.DalleAlle);
  Filtro.DalleAlle:=Filtro4;

  // 5. filtro straordinari solo causalizzati
  // IMPORTANTE: non utilizzato qui -> v. cdsGestMese.OnFilterRecord --
  Filtro5:=IfThen(chkFiltroStraordCaus.Checked,'(CAUSALE <> '''' and CAUSALE <> ''' + CAUSALE_MOS + ''')','');
  Filtro.Modificato:=(Filtro.Modificato) or (Filtro5 <> Filtro.StraordCaus);
  Filtro.SoloStraordCaus:=chkFiltroStraordCaus.Checked;
  Filtro.StraordCaus:=Filtro5;

  // TORINO_COMUNE - commessa 2012/046.ini
  // 6. filtro evento straordinario
  if chkEventiStraordinari.Checked then
  begin
    Filtro6:=Format('((ID_EVENTO_STR = 0) or (ID_EVENTO_STR = %s))',[A023FTimbratureDtM1.selT722.FieldByName('ID').AsString]);
    Filtro.Modificato:=(Filtro.Modificato) or (Filtro6 <> Filtro.EventoStraord);
    Filtro.EventoStraord:=Filtro6;
  end;
  // TORINO_COMUNE - commessa 2012/046.fine

  // compone il filtro (v. anche cdsGestMese.OnFilterRecord)
  FiltroStr:=Filtro.Periodo;
  FiltroStr:=FiltroStr + IfThen((FiltroStr <> '') and (Filtro.Tipologia <> ''),' and ','') + Filtro.Tipologia;
  FiltroStr:=FiltroStr + IfThen((FiltroStr <> '') and (Filtro.Scostamento <> ''),' and ','') + Filtro.Scostamento;
  FiltroStr:=FiltroStr + IfThen((FiltroStr <> '') and (Filtro.EventoStraord <> ''),' and ','') + Filtro.EventoStraord;

  // applica il filtro al clientdataset
  with A023FTimbratureDtM1.cdsGestMese do
  begin
    if Filtro.Modificato then
    begin
      DisableControls;
      AfterScroll:=nil;
      try
        // filtra il dataset
        Filtered:=False;
        Filter:=FiltroStr;
        Filtered:=(Filtro.Periodo <> '') or
                  (Filtro.Tipologia <> '') or
                  (Filtro.Scostamento <> '') or
                  (Filtro.DalleAlle <> '') or
                  (Filtro.StraordCaus <> '') or
                  (Filtro.EventoStraord <> '');
        // colora la griglia in modo alternato in base al giorno
        AssegnaColoriGrid;
      finally
        AfterScroll:=A023FTimbratureDtM1.cdsGestMeseAfterScroll;
        EnableControls;
      end;
    end;
  end;

  // calcola i totali relativi allo straordinario causalizzato/non caus.
  TotalizzaPeriodo;

  Screen.Cursor:=crDefault;
end;

procedure TA023FGestMese.TotalizzaPeriodo;
// Calcola i totali del mese per le causali di straordinario
var
  Ore,TotCaus,OreIndiv: Integer;
  Causale: String;
  Giorno: TDateTime;
  ConsideraRiga: Boolean;
begin
  // popola il clientdataset di appoggio
  cdsTemp.EmptyDataSet;
  with A023FTimbratureDtM1.cdsGestMese do
  begin
    DisableControls;
    AfterScroll:=nil;
    First;
    while not Eof do
    begin
      // considera solo le righe di straordinario
      if FieldByName('TIPO').AsString = 'GA' then
        Next
      else
      try
        Causale:=FieldByName('CAUSALE').AsString;
        Giorno:=FieldByName('DATA').AsDateTime;
        Ore:=R180OreMinutiExt(FieldByName('ALLE_H').AsString) - R180OreMinutiExt(FieldByName('DALLE_H').AsString);
        // corregge il dato se il periodo è a cavallo della mezzanotte
        if Ore < 0 then
          Ore:=Ore + 1440;
        // differenzia lo straord. non causalizzato / MOS con una causale speciale
        if (Trim(Causale) = '') or (Causale = CAUSALE_MOS) then
          Causale:=CAUSALE_NC;
        ConsideraRiga:=(not chkFiltroStraordCaus.Checked) or (Causale <> CAUSALE_NC);
        if ConsideraRiga then
        begin
          // se la causale/data è già presente ne aggiorna il totale, altrimenti inserisce un nuovo record
          if cdsTemp.Locate('CAUSALE;DATA',VarArrayOf([Causale,Giorno]),[]) then
          begin
            // aggiorna il totale di causale + data
            cdsTemp.Edit;
            cdsTemp.FieldByName('ORE').AsInteger:=cdsTemp.FieldByName('ORE').AsInteger + Ore;
            cdsTemp.Post;
          end
          else
          begin
            // nuovo record
            cdsTemp.Append;
            cdsTemp.FieldByName('CAUSALE').AsString:=Causale;
            cdsTemp.FieldByName('DATA').AsDateTime:=Giorno;
            cdsTemp.FieldByName('ORE').AsInteger:=Ore;
            cdsTemp.Post;
          end;
        end;
      finally
        Next;
      end;
    end;
    // ripristina il dataset principale
    AfterScroll:=A023FTimbratureDtM1.cdsGestMeseAfterScroll;
    EnableControls;
  end;

  // scorre il dataset di appoggio per popolare quello definitivo
  TotCaus:=0;
  cdsCausOre.EmptyDataSet;
  with cdsTemp do
  begin
    cdsCausOre.DisableControls;
    First;
    while not Eof do
    begin
      try
        Causale:=FieldByName('CAUSALE').AsString;
        Ore:=Trunc(R180Arrotonda(FieldByName('ORE').AsInteger,FieldByName('C_ARROT_RIEPGG').AsInteger,'D'));

        // se la causale è già presente ne aggiorna il totale, altrimenti inserisce un nuovo record
        if cdsCausOre.Locate('CAUSALE',VarArrayOf([Causale]),[]) then
        begin
          // aggiorna il totale della causale
          cdsCausOre.Edit;
          cdsCausOre.FieldByName('ORE').AsInteger:=cdsCausOre.FieldByName('ORE').AsInteger + Ore;
          cdsCausOre.Post;
        end
        else
        begin
          // nuovo record
          cdsCausOre.Append;
          cdsCausOre.FieldByName('CAUSALIZZATO').AsInteger:=IfThen(Causale = CAUSALE_NC,0,1);
          cdsCausOre.FieldByName('CAUSALE').AsString:=Causale;
          cdsCausOre.FieldByName('ORE').AsInteger:=Ore;
          cdsCausOre.Post;
        end;

        // aggiorna totale causalizzato
        TotCaus:=TotCaus + Ore;
      finally
        Next;
      end;
    end;
    cdsCausOre.First;
    cdsCausOre.EnableControls;
    lblTotStraord.Caption:=R180MinutiOre(TotCaus);
  end;

  // gestione eventi straordinari.ini
  // se è attiva la gestione eventi straordinari verifica la soglia di disponibilità
  // della causale selezionata
  if (A023FTimbratureDtM1.selT722.Active) and
     (chkEventiStraordinari.Checked) and
     (A023FTimbratureDtM1.selT722.RecordCount > 0) then
  begin
    Causale:=A023FTimbratureDtM1.selT722.FieldByName('CAUSALE_STR').AsString;
    OreIndiv:=R180OreMinutiExt(A023FTimbratureDtM1.selT722.FieldByName('ORE_INDIV').AsString);

    // ciclo sul clientdataset dei totali per verificare soglia
    with cdsCausOre do
    begin
      First;
      while not Eof do
      begin
        try
          if (FieldByName('CAUSALE').AsString = Causale) and
             (FieldByName('ORE').AsInteger > OreIndiv) then
          begin
            Edit;
            FieldByName('AVVISO').AsString:=AVVISO_SUPERO_DISP;
            Post;
          end;
        finally
          Next;
        end;
      end;
    end;
  end;
  // gestione eventi straordinari.fine
end;

procedure TA023FGestMese.rgpTipoClick(Sender: TObject);
begin
  // applica i filtri
  SalvaBookmarkCds;
  ApplicaFiltri;
  RipristinaBookmarkCds;

  ImpostaAbilitazioniTipo;
end;

procedure TA023FGestMese.cdsCausOreCalcFields(DataSet: TDataSet);
begin
  cdsCausOre.FieldByName('ORE_H').AsString:=R180MinutiOre(cdsCausOre.FieldByName('ORE').AsInteger);
end;

procedure TA023FGestMese.cdsTempCalcFields(DataSet: TDataSet);
var
  Arr: Integer;
begin
  with A023FTimbratureDtM1 do
  begin
    // arrotondamento giornaliero
    if A023FTimbratureMW.Q275.SearchRecord('CODICE',cdsTemp.FieldByName('CAUSALE').AsString,[srFromBeginning]) then
      Arr:=R180OreMinutiExt(A023FTimbratureMW.Q275.FieldByName('ARROT_RIEPGG').AsString)
    else
      Arr:=0;
    cdsTemp.FieldByName('C_ARROT_RIEPGG').AsInteger:=IfThen(Arr > 1,Arr,0);
  end;
end;

procedure TA023FGestMese.chkEventiStraordinariClick(Sender: TObject);
var
  idx: Integer;
  //Colonna: TColumn;
begin
  R180SetVariable(A023FTimbratureDtM1.selT722,'PROGRESSIVO',Progressivo);
  A023FTimbratureDtM1.selT722.Active:=chkEventiStraordinari.Checked;
  A023FTimbratureDtM1.ImpostaPickListCausale;
  if A023FTimbratureDtM1.selT722.Active and (A023FTimbratureDtM1.selT722.RecordCount = 0) then
  begin
    chkEventiStraordinari.Checked:=False;
    exit;
  end;
  dgrdT722.Visible:=chkEventiStraordinari.Checked;
  dgrdT722.Enabled:=chkEventiStraordinari.Checked;
  edtDataDa.Enabled:=not chkEventiStraordinari.Checked;
  edtDataA.Enabled:=not chkEventiStraordinari.Checked;
  btnDataDa.Enabled:=not chkEventiStraordinari.Checked;
  btnDataA.Enabled:=not chkEventiStraordinari.Checked;
  cmbCausPres.Enabled:=not chkEventiStraordinari.Checked;
  btnAssegnaCausStraord.Enabled:=(rgpTipo.ItemIndex <> 2) and
                                 ((not chkEventiStraordinari.Checked) or (Pos(',',A023FTimbratureDtM1.selT722.FieldByName('SERVIZI').AsString) = 0));
  chkSovrascrivi.Enabled:=btnAssegnaCausStraord.Enabled;
  grpEventiStraordinari.Height:=IfThen(chkEventiStraordinari.Checked,104,18);
  if chkEventiStraordinari.Checked then
    rgpTipo.ItemIndex:=1;
  // TORINO_COMUNE - commessa 2012/046.ini
  // tabella della gestione mensile
  idx:=R180GetColonnaDBGrid(dgrdGestMese,'ID_EVENTO_STR');
  if idx > -1 then
    dgrdGestMese.Columns[idx].Visible:=chkEventiStraordinari.Checked;

  // dato libero servizio
  idx:=R180GetColonnaDBGrid(dgrdGestMese,'SERVIZIO');
  if idx > -1 then
    dgrdGestMese.Columns[idx].Visible:=chkEventiStraordinari.Checked;

  (*
  // dato libero servizio (descrizione)
  if (A023FTimbratureDtM1.cdsGestMese.FindField('DESC_SERVIZIO') <> nil) and
     (R180GetColonnaDBGrid(dgrdGestMese,'DESC_SERVIZIO') = -1) then
  begin
    Colonna:=TColumn.Create(nil);
    Colonna.FieldName:='DESC_SERVIZIO';
    Colonna.Width:=50;
    Colonna.Visible:=True;
  end;
  *)

  // tabella dei totali
  idx:=R180GetColonnaDBGrid(dgrdCausOre,'AVVISO');
  if idx > -1 then
    dgrdCausOre.Columns[idx].Visible:=chkEventiStraordinari.Checked;
  // TORINO_COMUNE - commessa 2012/046.fine

  A023FTimbratureDtM1.selT723.Close;
  lblBudgetServizi.Visible:=chkEventiStraordinari.Checked;
  dgrdBudgetServizi.Visible:=chkEventiStraordinari.Checked;
  if chkEventiStraordinari.Checked then
    dgrdT722DblClick(nil)
  else
    chkEventiStraordinari.Caption:='Usa regole Eventi Straordinari';
end;

procedure TA023FGestMese.chkFiltroScostClick(Sender: TObject);
begin
  SalvaBookmarkCds;
  ApplicaFiltri;
  RipristinaBookmarkCds;
end;

procedure TA023FGestMese.cmbCausPresKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
    if Sender is TComboBox then
      (Sender as TComboBox).ItemIndex:=-1;
end;

procedure TA023FGestMese.cmbFiltroScostChange(Sender: TObject);
begin
  SalvaBookmarkCds;
  ApplicaFiltri;
  RipristinaBookmarkCds;
end;

procedure TA023FGestMese.edtSogliaScostChange(Sender: TObject);
begin
  if (chkFiltroScost.Checked) and
     (edtSogliaScost.Text <> OldSogliaScost) then
    ApplicaFiltri;
  OldSogliaScost:=edtSogliaScost.Text;
end;

procedure TA023FGestMese.edtSogliaScostExit(Sender: TObject);
begin
  if chkFiltroScost.checked then
    OreMinutiValidate(edtSogliaScost.Text);
end;

procedure TA023FGestMese.btnSetPeriodoClick(Sender: TObject);
var
  Da,A:TDateTime;
  MesiExt: Integer;
  ExtPrec,ExtSucc:Boolean;
begin
  StatusBar1.Panels[0].Text:='';
  StatusBar1.Repaint;

  Da:=StrToDate(edtDataDa.Text);
  A:=StrToDate(edtDataA.Text);

  // verifica la validità delle date
  if (Da < EncodeDate(1900,1,1)) or
     (Da > EncodeDate(2999,12,31)) then
  begin
    edtDataDa.SetFocus;
    raise Exception.Create('La data iniziale del periodo non è valida!');
  end;
  if (A < EncodeDate(1900,1,1)) or
     (A > EncodeDate(2999,12,31)) then
  begin
    edtDataA.SetFocus;
    raise Exception.Create('La data finale del periodo non è valida!');
  end;

  // verifica la validità del periodo
  if Da > A then
  begin
    edtDataA.SetFocus;
    raise Exception.Create('Il periodo indicato non è valido!');
  end;

  // determina i nuovi limiti del periodo di estrazione
  // e valuta se è necessario ripopolare la griglia

  // controlla se è stata anticipata la data di inizio periodo
  ExtPrec:=Da < DataInizioMese;
  DataInizio:=Da;
  if ExtPrec then
  begin
    MesiExt:=(R180Anno(DataInizioMese) - R180Anno(Da)) * 12 +
             (R180Mese(DataInizioMese) - R180Mese(Da));
    SetLength(ElencoDate,Length(ElencoDate) + (MesiExt * 31));
    DataInizioMese:=R180InizioMese(Da);
  end;

  // controlla se è stata posticipata la data di fine periodo
  ExtSucc:=A > DataFineMese;
  DataFine:=A;
  if ExtSucc then
  begin
    MesiExt:=(R180Anno(A) - R180Anno(DataFineMese)) * 12 +
             (R180Mese(A) - R180Mese(DataFineMese));
    SetLength(ElencoDate,Length(ElencoDate) + (MesiExt * 31));
    DataFineMese:=R180FineMese(A);
  end;

  // ripopola la grid solo se necessario, altrimenti applica soltanto i filtri
  if ExtPrec or ExtSucc then
  begin
    if A023FTimbratureDtM1.GestMeseModifichePendenti then
      if R180MessageBox('Attenzione! Il periodo di riferimento è cambiato.' + #13#10 +
                        'Proseguendo, le modifiche non ancora salvate saranno perse.' + #13#10 +
                        'Vuoi continuare?',DOMANDA) = mrNo then
        Exit;
    SalvaBookmarkCds;
    PopolaGrid;
    RipristinaBookmarkCds;
  end
  else
    ApplicaFiltri;
end;

procedure TA023FGestMese.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TA023FGestMese.btnDataDaClick(Sender: TObject);
begin
  edtDataDa.Text:=FormatDateTime('dd/mm/yyyy',(DataOut(StrToDate(edtDataDa.Text),'Data iniziale del periodo','G')));
  //if chkEventiStraordinari.Checked then
  //  edtDataDa.Text:=DateToStr(Max(StrToDate(edtDataDa.Text),A023FTimbratureDtM1.selT722.FieldByName('DAL').AsDateTime));
end;

procedure TA023FGestMese.btnDataAClick(Sender: TObject);
begin
  edtDataA.Text:=FormatDateTime('dd/mm/yyyy',(DataOut(StrToDate(edtDataA.Text),'Data finale del periodo','G')));
  //if chkEventiStraordinari.Checked then
  //  edtDataA.Text:=DateToStr(Min(StrToDate(edtDataA.Text),A023FTimbratureDtM1.selT722.FieldByName('AL').AsDateTime));
end;

procedure TA023FGestMese.edtDataADblClick(Sender: TObject);
var
  Da:TDateTime;
begin
  if TryStrToDate(edtDataDa.Text,Da) then
  begin
    edtDataA.Text:=FormatDateTime('dd/mm/yyyy',R180FineMese(Da));
    //if chkEventiStraordinari.Checked then
    //  edtDataA.Text:=DateToStr(Min(StrToDate(edtDataA.Text),A023FTimbratureDtM1.selT722.FieldByName('AL').AsDateTime));
  end;
end;

procedure TA023FGestMese.edtSogliaDalleAlleChange(Sender: TObject);
begin
  if (chkFiltroDalleAlle.Checked) and
     (edtSogliaDalleAlle.Text <> OldSogliaDalleAlle) then
  begin
    SalvaBookmarkCds;
    ApplicaFiltri;
    RipristinaBookmarkCds;
  end;
  OldSogliaDalleAlle:=edtSogliaDalleAlle.Text;
end;

procedure TA023FGestMese.edtSogliaDalleAlleExit(Sender: TObject);
begin
  if chkFiltroDalleAlle.checked then
    OreMinutiValidate(edtSogliaDalleAlle.Text);
end;

procedure TA023FGestMese.btnAssegnaCausClick(Sender: TObject);
// Imposta la causale di presenza selezionata sulle righe indicate
// (tutte / solo quelle non impostate)
var
  Causale:String;
  CausaleNulla:Boolean;
  function GetCausalizzazione:String;
  begin
    Result:=Causale;
    with A023FTimbratureDtM1 do
    begin
      if chkEventiStraordinari.Checked and
         (DayOfWeek(cdsGestMese.FieldByName('DATA').AsDateTime) = 1) and
         (not selT722.FieldByName('CAUSALE_STR_DOM').IsNull) then
        Result:=selT722.FieldByName('CAUSALE_STR_DOM').AsString;
    end;
  end;
begin
  // causale
  Causale:=Trim(Copy(cmbCausPres.Text,1,5));
  if Causale = '' then begin
    cmbCausPres.SetFocus;
    raise Exception.Create('Selezionare la causale da assegnare!');
  end;
  if R180MessageBox('Assegnare la causale "' + Causale + '" ' +
                    IfThen(chkSovrascrivi.Checked,
                           'a tutte le righe di straordinario?',
                           'alle righe di straordinario non impostate?'),DOMANDA) = mrNo then
    Exit;

  // assegnazione causale
  Screen.Cursor:=crHourGlass;
  StatusBar1.Panels[0].Text:='Assegnazione della causale ' + Causale + ' in corso...';
  StatusBar1.Repaint;
  with A023FTimbratureDtM1.cdsGestMese do
  begin
    try
      AfterScroll:=nil;
      BeforeInsert:=nil;
      BeforePost:=nil;
      AfterPost:=nil;
      DisableControls;
      SalvaBookmarkCds;
      // ciclo di assegnazione causale
      First;
      while not Eof do
      begin
        CausaleNulla:=(FieldByName('CAUSALE').IsNull) or
                      (Trim(FieldByName('CAUSALE').AsString) = '');
        // assegnazione anche alle righe GP
        if (FieldByName('TIPO').AsString = 'P') or
           (FieldByName('TIPO').AsString = 'GP') then
        begin
          if (chkSovrascrivi.Checked) or (CausaleNulla) then
          begin
            Edit;
            FieldByName('CAUSALE').AsString:=GetCausalizzazione;
            if (chkEventiStraordinari.Checked) (*and (Causale = A023FTimbratureDtM1.selT722.FieldByName('CAUSALE_STR').AsString)*) then
            begin
              FieldByName('ID_EVENTO_STR').AsInteger:=A023FTimbratureDtM1.selT722.FieldByName('ID').AsInteger;
              //Assegno il servizio in quanto l'assengazione automatica è abilitata solo se selT722.SERVIZI specifica un solo codice di servizio
              FieldByName('SERVIZIO').AsString:=A023FTimbratureDtM1.selT722.FieldByName('SERVIZI').AsString;
            end;
            Post;
          end;
        end;
        Next;
      end;
    finally
      EnableControls;
      AfterScroll:=A023FTimbratureDtM1.cdsGestMeseAfterScroll;
      BeforeInsert:=A023FTimbratureDtM1.cdsGestMeseBeforeInsert;
      BeforePost:=A023FTimbratureDtM1.cdsGestMeseBeforePost;
      AfterPost:=A023FTimbratureDtM1.cdsGestMeseAfterPost;
      TotalizzaPeriodo;
      RipristinaBookmarkCds;
      StatusBar1.Panels[0].Text:='';
      StatusBar1.Repaint;
      Screen.Cursor:=crDefault;
    end;
  end;
end;

procedure TA023FGestMese.btnAnnullaClick(Sender: TObject);
// Refresh della griglia
begin
  if A023FTimbratureDtM1.GestMeseModifichePendenti then
    if R180MessageBox('Attenzione! Sono presenti modifiche non ancora salvate.' + #13#10 +
                      'Vuoi ripristinare la situazione iniziale?',DOMANDA) = mrNo then
      Exit;
  SalvaBookmarkCds;
  PopolaGrid;
  RipristinaBookmarkCds;
end;

procedure TA023FGestMese.btnResetPianifCausClick(Sender: TObject);
// Resetta la tabella T320_PIANLIBPROFESSIONE per il mese
var
  Da,A:TDateTime;
begin
  if A023FTimbratureDtM1.selT722.Active and
    (A023FTimbratureDtM1.selT722.FieldByName('ID').Value <> A023FTimbratureDtM1.selT723.GetVariable('ID')) then
    raise Exception.Create('Selezionare l''Evento Straordinario corrente (doppio click)');

  Da:=StrToDate(edtDataDa.Text);
  A:=StrToDate(edtDataA.Text);

  // verifica la validità delle date
  if (Da < EncodeDate(1900,1,1)) or
     (Da > EncodeDate(2999,12,31)) then
  begin
    edtDataDa.SetFocus;
    raise Exception.Create('La data iniziale del periodo non è valida!');
  end;
  if (A < EncodeDate(1900,1,1)) or
     (A > EncodeDate(2999,12,31)) then
  begin
    edtDataA.SetFocus;
    raise Exception.Create('La data finale del periodo non è valida!');
  end;

  // verifica la validità del periodo
  if Da > A then
  begin
    edtDataA.SetFocus;
    raise Exception.Create('Il periodo indicato non è valido!');
  end;

  // richiesta conferma
  if R180MessageBox('Si desidera annullare la pianificazione della causalizzazione' + #13#10 +
                    'nel periodo dal ' + DateToStr(Da) + ' al ' + DateToStr(A) + '?',DOMANDA) = mrNo then
    Exit;
  Screen.Cursor:=crHourGlass;
  StatusBar1.Panels[0].Text:='Annullamento pianificazione in corso...';
  StatusBar1.Repaint;

  // cancellazione dei record della tabella T320
  with A023FTimbratureDtM1.delT320 do
  begin
    // esegue la cancellazione dalla T320 i record per la data indicata
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DATA_INIZIO',Da);           // originariamente DataInizio
    SetVariable('DATA_FINE',A);              // originariamente DataFine
    SetVariable('ID_EVENTO_STR',null);
    if (A023FTimbratureDtM1.selT722.Active) and
       (chkEventiStraordinari.Checked) and
       (A023FTimbratureDtM1.selT722.RecordCount > 0) then
      SetVariable('ID_EVENTO_STR',A023FTimbratureDtM1.selT722.FieldByName('ID').AsInteger);
    Execute;
    SessioneOracle.Commit;
  end;

  // cancellazione dei record di blocco riepilogo (utilizzato in W026)
  with A023FTimbratureDtM1.scrSbloccaRiepT325 do
  begin
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DAL',Da);
    SetVariable('AL',A);
    SetVariable('RIEPILOGO','T325');
    Execute;
    SessioneOracle.Commit;
  end;

  // aggiornamento visivo del cartellino interattivo
  if A023FTimbrature <> nil then
  try
    StatusBar1.Panels[0].Text:='Aggiornamento cartellino interattivo in corso...';
    StatusBar1.Repaint;
    A023FTimbrature.CaricaMese;
  finally
    StatusBar1.Panels[0].Text:='';
    StatusBar1.Repaint;
  end;

  // popolamento griglia dopo le cancellazioni
  SalvaBookmarkCds;
  PopolaGrid;
  RipristinaBookmarkCds;

  StatusBar1.Panels[0].Text:='';
  StatusBar1.Repaint;
  Screen.Cursor:=crDefault;
  R180MessageBox('Elaborazione terminata.',INFORMA);
end;

procedure TA023FGestMese.btnConfermaClick(Sender: TObject);
// Salva i dati a video e ripopola la grid
begin
  if A023FTimbratureDtM1.cdsGestMese.RecordCount = 0 then
    raise Exception.Create('Non sono presenti dati da confermare!');
  if R180MessageBox('Salvare le modifiche apportate?',DOMANDA) = mrNo then
    Exit;
  SalvaBookmarkCds;

  if not ControllaIntersezioni then
    Exit;

  // salvataggio dati su T040 e T320
  SalvaDati;

  // refresh del cartellino
  if A023FTimbrature <> nil then
  begin
    try
      StatusBar1.Panels[0].Text:='Aggiornamento cartellino in corso...';
      StatusBar1.Repaint;
      A023FTimbrature.CaricaMese;
    finally
      StatusBar1.Panels[0].Text:='';
      StatusBar1.Repaint;
    end;
  end;

  PopolaGrid;
  RipristinaBookmarkCds;
  if A023FTimbratureDtM1.selT723.Active then
    A023FTimbratureDtM1.selT723.Refresh;
  R180MessageBox('Elaborazione terminata.',INFORMA);
end;

procedure TA023FGestMese.actDuplicaExecute(Sender: TObject);
// Duplicazione della riga attualmente selezionata
var
  OldData,OldDataOrig,OldDataConteggi: TDateTime;
  OldTipo,OldDalleH,OldAlleH,OldCausale,OldCavalloMezzanotte: String;
  OldDalleOrig,OldAlleOrig,OldTotLav,OldDebitoGG,OldScost: Integer;
begin
  with A023FTimbratureDtM1.cdsGestMese do
  begin
    SalvaBookmarkCds;
    // copia dati in variabili
    OldData:=FieldByName('DATA').AsDateTime;
    OldDataConteggi:=FieldByName('DATA_CONTEGGI').AsDateTime;
    OldTipo:=FieldByName('TIPO').AsString;
    OldCavalloMezzanotte:=FieldByName('CAVALLO_MEZZANOTTE').AsString;
    OldDataOrig:=FieldByName('DATA_ORIG').AsDateTime;
    OldDalleOrig:=FieldByName('DALLE_ORIG').AsInteger;
    OldAlleOrig:=FieldByName('ALLE_ORIG').AsInteger;
    OldDalleH:=FieldByName('DALLE_H').AsString;
    OldAlleH:=FieldByName('ALLE_H').AsString;
    OldCausale:=FieldByName('CAUSALE').AsString;
    OldTotLav:=FieldByName('TOTLAV').AsInteger;
    OldDebitoGG:=FieldByName('DEBITOGG').AsInteger;
    OldScost:=FieldByName('SCOST').AsInteger;
    // abilita l'inserimento nel dataset (evita l'abort sul beforeinsert)
    CanInsert:=True;
    // disattiva eventi di validazione campi
    FieldByName('DATA').OnValidate:=nil;
    FieldByName('DALLE_H').OnValidate:=nil;
    FieldByName('ALLE_H').OnValidate:=nil;
    FieldByName('CAUSALE').OnValidate:=nil;
    FieldByName('DESC_CAUSALE').OnValidate:=nil;
    // inserisce la nuova riga con i dati copiati
    try
      Insert;
      FieldByName('FLAG_RIGA').AsString:='D'; // riga duplicata
      FieldByName('FLAG_RIGA_SUBCOD').AsInteger:=1; // riga duplicata
      FieldByName('DATA').AsDateTime:=OldData;
      FieldByName('DATA_CONTEGGI').AsDateTime:=OldDataConteggi;
      FieldByName('TIPO').AsString:=OldTipo;
      FieldByName('CAVALLO_MEZZANOTTE').AsString:=OldCavalloMezzanotte;
      FieldByName('DATA_ORIG').AsDateTime:=OldDataOrig;
      FieldByName('DALLE_ORIG').AsInteger:=OldDalleOrig;
      FieldByName('ALLE_ORIG').AsInteger:=OldAlleOrig;
      FieldByName('DALLE_H').AsString:=OldDalleH;
      FieldByName('ALLE_H').AsString:=OldAlleH;
      FieldByName('CAUSALE').AsString:=OldCausale;
      FieldByName('TOTLAV').AsInteger:=OldTotLav;
      FieldByName('DEBITOGG').AsInteger:=OldDebitoGG;
      FieldByName('SCOST').AsInteger:=OldScost;
      Post;
      // scrolla sulla riga originale (nel tentativo di renderla visibile nella dbgrid)
      // quindi si riposiziona sul campo "dalle" della riga appena inserita
      RipristinaBookmarkCds;
      Next;
      if not FieldByName('DATA').ReadOnly then
        FieldByName('DATA').FocusControl
      else
        FieldByName('DALLE_H').FocusControl;
    finally
      CanInsert:=False;
      // riattiva eventi di validazione campi
      FieldByName('DATA').OnValidate:=A023FTimbratureDtM1.cdsGestMeseDATAValidate;
      FieldByName('DALLE_H').OnValidate:=A023FTimbratureDtM1.cdsGestMeseDALLE_HValidate;
      FieldByName('ALLE_H').OnValidate:=A023FTimbratureDtM1.cdsGestMeseDALLE_HValidate;
      FieldByName('CAUSALE').OnValidate:=A023FTimbratureDtM1.cdsGestMeseCAUSALEValidate;
      FieldByName('DESC_CAUSALE').OnValidate:=A023FTimbratureDtM1.cdsGestMeseCAUSALEValidate;
    end;
  end;
end;

procedure TA023FGestMese.actEliminaExecute(Sender: TObject);
begin
  A023FTimbratureDtM1.cdsGestMese.Delete;
end;

procedure TA023FGestMese.actInserisciExecute(Sender: TObject);
// Inserisce una nuova riga di straordinario nella grid
var
  NewData:TDateTime;
  DalleOrig,AlleOrig,DalleMin,AlleMin,i:Integer;
  Dalle,Alle,CavalloMezzanotte:String;
  AsteriscoCavMez: Boolean;
  TimbList:TStringList;
begin
  // richiede la data della nuova riga di straordinario
  NewData:=DataOut(DataSelezionata,'Data straordinario','G',True);
  // termina se l'utente ha scelto "Cancel"
  if NewData = 0 then
    Exit;
  if (NewData < DataInizio) or (NewData > DataFine) then
  begin
    R180MessageBox('La data deve essere compresa nel periodo attualmente' + #13#10 +
                   'selezionato (' + DateToStr(DataInizio) +
                   ' - ' + DateToStr(DataFine) + ')!',INFORMA);
    Exit;
  end;

  // effettua i conteggi per la data scelta
  R502ProDtM.Conteggi('Cartolina',Progressivo,NewData);

  // esce se non sono presenti timbrature
  if R502ProDtM.n_timbrdip = 0 then
  begin
    R180MessageBox('Nessuna timbratura in data ' + DateToStr(NewData) + '.' + #13#10 +
                   'Non è possibile inserire una riga di straordinario!',INFORMA);
    Exit;
  end;

  try
    TimbList:=TStringList.Create;

    // aggiunge coppie di timbrature di straordinario
    for i:=1 to R502ProDtM.n_timbrdip do
    begin
      DalleMin:=R502ProDtM.ttimbraturedip[i].tminutid_e;
      Dalle:=R180MinutiOre(DalleMin);
      AlleMin:=R502ProDtM.ttimbraturedip[i].tminutid_u;
      Alle:=R180MinutiOre(IfThen(AlleMin >= 1440,AlleMin - 1440,AlleMin));

      // verifica se la coppia di timbrature deve essere considerata
      // esclusi i periodi dalle - alle = 0
      // esclusi i periodi dalle - alle riferiti totalmente al gg. successivo (dalle > 24.00)
      if (DalleMin < AlleMin) and
         (DalleMin < 1440) then
        if not A023FTimbratureDtM1.cdsGestMese.Locate('DATA;DALLE_H;ALLE_H;TIPO',VarArrayOf([NewData,Dalle,Alle,'P']),[]) then
          TimbList.Add(Dalle + ' - ' + Alle + IfThen(AlleMin >= 1440,'*'));  // l'asterisco segnala timbrature a cavallo di mezzanotte
    end;

    if TimbList.Count = 0 then
    begin
      // nessuno spezzone valido
      R180MessageBox('Nessuna riga di straordinario da inserire in data ' + DateToStr(NewData) + '.' + #13#10,INFORMA);
      Abort; //Exit;
    end
    else if TimbList.Count > 1 then
    begin
      // se esistono più spezzoni selezionabili propone la scelta multipla all'utente
      try
        C013FCheckList:=TC013FCheckList.Create(nil);
        C013FCheckList.Width:=180;
        C013FCheckList.Height:=260;
        C013FCheckList.clbListaDati.Items.Assign(TimbList);
        if C013FCheckList.ShowModal <> mrOK then
          Abort; //Exit;
        R180Tokenize(TimbList,R180GetCheckList(14,C013FCheckList.clbListaDati));
      finally
        C013FCheckList.Free;
      end;
    end;

    // ciclo sugli spezzoni selezionati
    for i:=0 to TimbList.Count - 1 do
    begin
      Dalle:=Copy(TimbList[i],1,5);
      Alle:=Copy(TimbList[i],9,5);
      AsteriscoCavMez:=(Copy(TimbList[i],14,1) = '*');

      DalleOrig:=R180OreMinutiExt(Dalle);
      AlleOrig:=R180OreMinutiExt(Alle) + IfThen(AsteriscoCavMez,1440);
      if AlleOrig > 1440 then
        Alle:=R180MinutiOre(AlleOrig - 1440);
      CavalloMezzanotte:=IfThen(AlleOrig >= 1440,'S','N');

      with A023FTimbratureDtM1.cdsGestMese do
      begin
        // abilita l'inserimento nel dataset (evita l'abort sul beforeinsert)
        CanInsert:=True;
        // disattiva eventi di validazione campi
        FieldByName('DATA').OnValidate:=nil;
        FieldByName('DALLE_H').OnValidate:=nil;
        FieldByName('ALLE_H').OnValidate:=nil;
        FieldByName('CAUSALE').OnValidate:=nil;
        FieldByName('DESC_CAUSALE').OnValidate:=nil;
        // inserisce la nuova riga con i dati copiati
        try
          Insert;
          FieldByName('FLAG_RIGA').AsString:='I'; // riga inserita
          FieldByName('FLAG_RIGA_SUBCOD').AsInteger:=1;
          FieldByName('DATA').AsDateTime:=NewData;
          FieldByName('DATA_CONTEGGI').AsDateTime:=NewData; // dato fittizio utilizzato solo ai fini del filtro periodo
          FieldByName('TIPO').AsString:='P';
          FieldByName('CAVALLO_MEZZANOTTE').AsString:=CavalloMezzanotte;
          FieldByName('DATA_ORIG').AsDateTime:=NewData;
          FieldByName('DALLE_ORIG').AsInteger:=DalleOrig;
          FieldByName('ALLE_ORIG').AsInteger:=AlleOrig;
          FieldByName('DALLE_H').AsString:=Dalle;
          FieldByName('ALLE_H').AsString:=Alle;
          //FieldByName('CAUSALE').AsString:=OldCausale;
          FieldByName('TOTLAV').AsInteger:=R502ProDtM.totlav;
          FieldByName('DEBITOGG').AsInteger:=R502ProDtM.debitogg;
          FieldByName('SCOST').AsInteger:=R502ProDtM.scost;
          Post;
          FieldByName('DALLE_H').FocusControl;
        finally
          CanInsert:=False;
          // riattiva eventi di validazione campi
          FieldByName('DATA').OnValidate:=A023FTimbratureDtM1.cdsGestMeseDATAValidate;
          FieldByName('DALLE_H').OnValidate:=A023FTimbratureDtM1.cdsGestMeseDALLE_HValidate;
          FieldByName('ALLE_H').OnValidate:=A023FTimbratureDtM1.cdsGestMeseDALLE_HValidate;
          FieldByName('CAUSALE').OnValidate:=A023FTimbratureDtM1.cdsGestMeseCAUSALEValidate;
          FieldByName('DESC_CAUSALE').OnValidate:=A023FTimbratureDtM1.cdsGestMeseCAUSALEValidate;
        end;
      end;
    end;
  finally
    FreeAndNil(TimbList);
  end;
end;

// mw.ini
{
procedure TA023FGestMese.AggiungiRiga(Giorno:TDateTime; Tipo:String; TagTimb:String;
  Dalle, Alle:Integer; Causale:String; TotLav,DebitoGG,Scost: Integer);
// Aggiunge al client dataset la riga con i valori indicati
var
  FlagRiga,CavalloMezzanotte: String;
  FlagRigaSubCod: Integer;
  GiornoIns: TDateTime;
begin
  // evita la scrittura di un periodo non valido
  if Dalle >= Alle then
    Exit;

  with A023FTimbratureDtM1,cdsGestMese do
  begin
    // imposta il tipo di riga (A = automatica, B = bloccata)
    FlagRiga:='A';
    FlagRigaSubCod:=1;
    if Causale <> '' then
    begin
      // se la causale di assenza è di autogiustificazione -> imposta il flag tipo riga a "B" = bloccato
      if Tipo = 'A' then
        if Q275.SearchRecord('LINK_ASSENZA',Causale,[srFromBeginning]) then
        begin
          FlagRiga:='B';
          FlagRigaSubCod:=1;
        end;

      // se la causale non è tra quelle ammesse -> imposta il flag tipo riga a "B" = bloccato
      if not selAssPres.SearchRecord('CODICE',Causale,[srFromBeginning]) then
      begin
        FlagRiga:='B';
        FlagRigaSubCod:=2;
      end;
    end;

    // imposta il tipo riga "B" se la funzione Giustificativi non è attiva in modifica
    if (AccessoA004 <> 'S') and
       ((Tipo = 'GA') or (Tipo = 'GP')) then
    begin
      FlagRiga:='B';
      FlagRigaSubCod:=3;
    end;

    // determina il giorno da inserire nella griglia (può essere diverso da quello dei conteggi)
    GiornoIns:=Giorno;
    // 1. tag 'GiornoPrec' indica timbrature rif. al giorno precedente
    if TagTimb = 'GiornoPrec' then
      GiornoIns:=GiornoIns - 1;
    // 2. timbrature riferite al giorno successivo (periodo inizia dopo le 23.59)
    if (Dalle >= 1440) and (Alle >= 1440) then
    begin
      GiornoIns:=GiornoIns + 1;
      Dalle:=Dalle - 1440;
      Alle:=Alle - 1440;
    end;

    // gestione periodo a cavallo di mezzanotte
    CavalloMezzanotte:=IfThen((Dalle < 1440) and (Alle >= 1440),'S','N');

    // evita riscrittura di record identici
    // (non considera il flag_riga nella locate, in quanto si tratta dell'inserimento iniziale)
    //if not Locate('DATA;DALLE_H;ALLE_H;TIPO',VarArrayOf([GiornoIns,R180MinutiOre(Dalle),R180MinutiOre(Alle),Tipo]),[]) then
    if not Locate('DATA;DALLE_ORIG;ALLE_ORIG;TIPO',VarArrayOf([GiornoIns,Dalle,Alle,Tipo]),[]) then
    begin
      OnCalcFields:=nil;

      // inserisce il record sul client dataset
      Append;
      FieldByName('FLAG_RIGA').AsString:=FlagRiga;
      FieldByName('FLAG_RIGA_SUBCOD').AsInteger:=FlagRigaSubCod;
      FieldByName('DATA').AsDateTime:=GiornoIns;
      FieldByName('DATA_CONTEGGI').AsDateTime:=Giorno;
      FieldByName('TIPO').AsString:=Tipo;
      FieldByName('CAVALLO_MEZZANOTTE').AsString:=CavalloMezzanotte;
      FieldByName('DATA_ORIG').AsDateTime:=GiornoIns;
      FieldByName('DALLE_ORIG').AsInteger:=Dalle;
      FieldByName('ALLE_ORIG').AsInteger:=Alle;
      FieldByName('DALLE_H').AsString:=R180MinutiOre(Dalle);
      FieldByName('ALLE_H').AsString:=R180MinutiOre(IfThen(CavalloMezzanotte ='S',Alle - 1440,Alle)); // corregge il dato "alle" visualizzato
      FieldByName('CAUSALE').AsString:=Causale;
      FieldByName('CAUSALE_ORIG').AsString:=Causale;
      FieldByName('TOTLAV').AsInteger:=TotLav;
      FieldByName('DEBITOGG').AsInteger:=DebitoGG;
      FieldByName('SCOST').AsInteger:=Scost;
      try
        Post;
      except
        on E: Exception do
          if not (E is EAbort) then
            R180MessageBox(E.Message + ' (' + E.ClassName + ')',ESCLAMA);
      end;

      // aggiunge la data alla lista di giorni considerati
      // *** notare che viene utilizzato il giorno su cui sono stati effettuati i conteggi,
      // *** e non quello effettivamente inserito nella griglia
      if GiorniConteggi.GiorniConsideratiList.IndexOf(DateToStr(Giorno)) = -1 then
        GiorniConteggi.GiorniConsideratiList.Add(DateToStr(Giorno));

      OnCalcFields:=cdsGestMeseCalcFields;
    end;
  end;
end;

function TA023FGestMese.IsGiornoDaConsiderare(Giorno:TDateTime): Boolean;
// Determina se il giorno dato è da considerare nel ricalcolo dei conteggi
// Il giorno è da considerare nei seguenti due casi:
// 1. la data è fuori dal range GiorniConteggi.Inizio - GiorniConteggi.Fine
//    (non si hanno quindi informazioni)
// 2. la data è compresa fra GiorniConteggi.Inizio e GiorniConteggi.Fine e
//    la data è inclusa nella stringlist dei giorni considerati per il ricalcolo:
//    GiorniConteggi.GiorniConsideratiList
begin
  // fuori dal range già valutato -> in assenza di informazioni il giorno viene considerato
  if (Giorno < GiorniConteggi.Inizio) or
     (Giorno > GiorniConteggi.Fine) then
  begin
    Result:=True;
    Exit;
  end;

  // il giorno è compreso nel range -> se è incluso nella stringlist restituisce true
  Result:=GiorniConteggi.GiorniConsideratiList.IndexOf(DateToStr(Giorno)) >= 0;
end;

function TA023FGestMese.CopertoDaTimbratura(Ent,Usc: Integer): Boolean;
// Restituisce True se la timbratura (e/u) specificata è coperta
// da una timbratura effettiva.
var
  i: Integer;
begin
  Result:=False;
  for i:=1 to R502ProDtM.n_timbrdip do
    if (R502ProDtM.ttimbraturedip[i].tminutid_e <= Ent) and
       (R502ProDtM.ttimbraturedip[i].tminutid_u >= Usc) then
    begin
      Result:=True;
      Break;
    end;
end;

procedure TA023FGestMese.GestGiorno(Giorno: TDateTime);
// Gestione giornaliera per verificare tutti i punti di timbratura
var
  i,j,pAss,index: Integer;
  PNConsiderati: TStringList;
  PNAttuale,PuntoNomIntersecato,
  EntNom,UscNom,UltimaUsc,MinutiMensa,
  Im,Fm: Integer;
  ScartoEccedenza,App,TimbE,TimbU:Integer;
  Tipo,UltimoTag: String;
  Prima: Boolean;
  timbArr, timbArrFiltrato: array of t_ttimbraturedip; // array zero-based!!
  function PosizioneIns(val:Integer): Integer;
  // Restituisce la posizione in cui la timbratura deve essere aggiunta
  // l'array timbArr viene ordinato per tminutid_e
  var
    i,cfr: Integer;
  begin
    Result:=0;

    // correzione dato timbratura se > 6000
    if val >= 6000 then
      val:=val - (6000 + 1440);

    // ciclo per reperire la posizione di inserimento
    for i:=Length(timbArr) - 1 downto 0 do
    begin
      // correzione dato se entrata i-esima > 6000
      cfr:=timbArr[i].tminutid_e - IfThen(timbArr[i].tminutid_e >= 6000,6000 + 1440);

      if val > cfr then
      begin
        Result:=i + 1;
        Break;
      end;
    end;
  end;
  function PosizioneAssPres(Dalle,Alle: Integer; var Tipo: String): Integer;
  // se la coppia dalle/alle è già inserita come giustificativo di assenza o presenza
  //  restituisce l'indice del vettore dei giustificativi, altrimenti -1
  var i: Integer;
  begin
    Result:=-1;
    Tipo:='';
    with R502ProDtM do
    begin
      for i:=1 to n_giusdaa do
        if (Dalle = tgius_dallealle[i].tminutida) and
           (Alle = tgius_dallealle[i].tminutia) then
        begin
          Tipo:=IfThen(tgius_dallealle[i].tassenza,'GA','GP');
          Result:=i;
          Break;
        end;
    end;
  end;
  procedure CreaArrTimbrature;
  // Creazione array di timbrature ordinato in base a tminutid_e
  var
    i,j,x:Integer;
  begin
    with R502ProDtM do
    begin
      SetLength(timbArr,0);
      for i:=1 to n_timbrdip do
      begin
        // esclude entrata/uscita uguali
        if ttimbraturedip[i].tminutid_e = ttimbraturedip[i].tminutid_u then
          Continue;
        // determina la posizione di ttimbraturedip[i] nel nuovo array
        x:=PosizioneIns(ttimbraturedip[i].tminutid_e);
        SetLength(timbArr,Length(timbArr) + 1);
        // spostamento elementi
        for j:=Length(timbArr) - 1 downto x + 1 do
        begin
          timbArr[j].inserita:=timbArr[j-1].inserita;
          timbArr[j].oralegsol:=timbArr[j-1].oralegsol;
          timbArr[j].spezzata:=timbArr[j-1].spezzata;
          timbArr[j].tag:=timbArr[j-1].tag;
          timbArr[j].tcausale_e:=timbArr[j-1].tcausale_e;
          timbArr[j].tcausale_u:=timbArr[j-1].tcausale_u;
          timbArr[j].tflagarr_e:=timbArr[j-1].tflagarr_e;
          timbArr[j].tflagarr_u:=timbArr[j-1].tflagarr_u;
          timbArr[j].tminutid_e:=timbArr[j-1].tminutid_e;
          timbArr[j].tminutid_u:=timbArr[j-1].tminutid_u;
          timbArr[j].tpuntnomin:=timbArr[j-1].tpuntnomin;
          timbArr[j].tpuntnominold:=timbArr[j-1].tpuntnominold;
          timbArr[j].trilev_e:=timbArr[j-1].trilev_e;
          timbArr[j].trilev_u:=timbArr[j-1].trilev_u;
        end;
        // copia elemento
        timbArr[x].inserita:=ttimbraturedip[i].inserita;
        timbArr[x].oralegsol:=ttimbraturedip[i].oralegsol;
        timbArr[x].spezzata:=ttimbraturedip[i].spezzata;
        timbArr[x].tag:=ttimbraturedip[i].tag;
        timbArr[x].tcausale_e:=ttimbraturedip[i].tcausale_e;
        timbArr[x].tcausale_u:=ttimbraturedip[i].tcausale_u;
        timbArr[x].tflagarr_e:=ttimbraturedip[i].tflagarr_e;
        timbArr[x].tflagarr_u:=ttimbraturedip[i].tflagarr_u;
        timbArr[x].tminutid_e:=ttimbraturedip[i].tminutid_e;
        timbArr[x].tminutid_u:=ttimbraturedip[i].tminutid_u;
        timbArr[x].tpuntnomin:=ttimbraturedip[i].tpuntnomin;
        timbArr[x].tpuntnominold:=ttimbraturedip[i].tpuntnominold;
        timbArr[x].trilev_e:=ttimbraturedip[i].trilev_e;
        timbArr[x].trilev_u:=ttimbraturedip[i].trilev_u;
        // verifica se le timbrature sono rif. al giorno precedente
        if timbArr[x].tminutid_e >= 6000 then
        begin
          timbArr[x].tag:='GiornoPrec';
          dec(timbArr[x].tminutid_e,6000);
          dec(timbArr[x].tminutid_u,6000);
        end;
      end;
    end;
  end;
  procedure FiltraArrTimbrature(PuntoNom: Integer);
  // Genera un array delle timbrature filtrato in base al punto nominale
  var
    PuntoNomStr: String;
    i,x: Integer;
  begin
    SetLength(timbArrFiltrato,0);
    x:=0;
    PuntoNomStr:=IntToStr(PuntoNom);
    for i:=0 to Length(timbArr) - 1 do
    begin
      if timbArr[i].tpuntnomin = PuntoNom then
      begin
        SetLength(timbArrFiltrato,x+1);
        timbArrFiltrato[x].inserita:=timbArr[i].inserita;
        timbArrFiltrato[x].oralegsol:=timbArr[i].oralegsol;
        timbArrFiltrato[x].spezzata:=timbArr[i].spezzata;
        timbArrFiltrato[x].tag:=timbArr[i].tag;
        timbArrFiltrato[x].tcausale_e:=timbArr[i].tcausale_e;
        timbArrFiltrato[x].tcausale_u:=timbArr[i].tcausale_u;
        timbArrFiltrato[x].tflagarr_e:=timbArr[i].tflagarr_e;
        timbArrFiltrato[x].tflagarr_u:=timbArr[i].tflagarr_u;
        timbArrFiltrato[x].tminutid_e:=timbArr[i].tminutid_e;
        timbArrFiltrato[x].tminutid_u:=timbArr[i].tminutid_u;
        timbArrFiltrato[x].tpuntnomin:=timbArr[i].tpuntnomin;
        timbArrFiltrato[x].tpuntnominold:=timbArr[i].tpuntnominold;
        timbArrFiltrato[x].trilev_e:=timbArr[i].trilev_e;
        timbArrFiltrato[x].trilev_u:=timbArr[i].trilev_u;
        x:=x + 1;
      end;
    end;
  end;
  function IntersecaPuntoNominale(Ent,Usc: Integer; var PNIntersecato: Integer): Boolean;
  // Restituisce True se la timbratura (e/u) interseca il punto nominale indicato
  var i,EntNom,UscNom:Integer;
  begin
    Result:=False;
    PNIntersecato:=0;
    for i:=1 to R502ProDtM.n_timbrnom do
    begin
      EntNom:=R502ProDtM.ttimbraturenom[i].tminutin_e + R502ProDtM.ttimbraturenom[i].flex;
      UscNom:=R502ProDtM.ttimbraturenom[i].tminutin_u;
      
      // verifica intersezione dei punti di timbratura con il punto nominale i-esimo
      if Min(UscNom,Usc) - Max(EntNom,Ent) > 0 then
      begin
        Result:=True;
        PNIntersecato:=i;
        Break;
      end;
    end;
  end;
  function IntersecaMensa(T1,T2: Integer; var PeriodoMensaTot: Integer): Boolean;
  // Restituisce True se la timbratura (e/u) specificata interseca una timbratura di mensa
  // Nel contempo, somma nella variabile PeriodoMensaTot il totale dei min. di mensa
  var
    i: Integer;
  begin
    Result:=False;
    if R502ProDtM.paumenges <> 'si' then
      Exit;

    for i:=0 to Length(R502ProDtM.TimbratureMensa) - 1 do
      if Min(R502ProDtM.TimbratureMensa[i].F,T2) - Max(R502ProDtM.TimbratureMensa[i].I,T1) > 0 then
      begin
        Result:=True;
        PeriodoMensaTot:=PeriodoMensaTot + (T2 - T1);
        Break;
      end;
  end;
begin
  with R502ProDtM do
  begin
    // effettua i conteggi giornalieri
    Conteggi('Cartolina',Progressivo,Giorno);

    // daniloc.ini - 10.06.2010
    // non effettua operazioni se il dipendente non è in servizio nel giorno in elaborazione
    // questo evita problemi in caso dipendenti assunti in corso di mese
    if (dipinser = 'no') then
      Exit;
    // daniloc.fine

    ScartoEccedenza:=SpezzoniNonCausEccedenti;
    // creazione array di ttimbraturedip per il giorno, ordinato in base a tminutid_e
    CreaArrTimbrature;

    PNConsiderati:=TStringList.Create;
    try
      // 1. ciclo su timbrature dipendente
      for i:=0 to Length(timbArr) - 1 do
      begin
        // straordinario
        if timbArr[i].tpuntnomin = 0 then
        begin
          // verifica se la timbratura corrisponde ad un giust. di assenza / presenza
          pAss:=PosizioneAssPres(timbArr[i].tminutid_e, timbArr[i].tminutid_u,Tipo);
          if pAss < 0 then
          begin
            // straordinario (P)
            //Alberto: modifico eventualmente il punto di Entrata se il totale delle timbrature non appoggiate supera l'eccedenza giornaliera
            TimbE:=timbArr[i].tminutid_e;
            TimbU:=timbArr[i].tminutid_u;
            if (ValStrT275[timbArr[i].tcausale_e.tcaus,'ORENORMALI'] <> 'A') then
            begin
              App:=min(ScartoEccedenza,TimbU - TimbE);
              inc(TimbE,App);
              dec(ScartoEccedenza,App);
            end;
            AggiungiRiga(Giorno,'P',timbArr[i].tag,TimbE,TimbU,timbArr[i].tcausale_e.tcaus,totlav,debitogg,scost);
          end
          else
          begin
            // timbratura corrisponde a giustificativo di assenza (GA) oppure presenza (GP)
            AggiungiRiga(Giorno,Tipo,timbArr[i].tag,timbArr[i].tminutid_e,timbArr[i].tminutid_u,tgius_dallealle[pAss].tcausdaa,totlav,debitogg,scost);

            // se questa timbratura interseca uno spezzone con punto nominale > 0,
            // allora questo p.n. viene impostato sulla timbratura (che sarà considerata successivamente)
            if IntersecaPuntoNominale(timbArr[i].tminutid_e,timbArr[i].tminutid_u,PuntoNomIntersecato) then
              timbArr[i].tpuntnomin:=PuntoNomIntersecato;
          end;
        end
        else
        begin
          if debitogg = 0 then
          begin
            // aggiunge tutte le timbrature in caso di debito giornaliero = 0
            AggiungiRiga(Giorno,'P',timbArr[i].tag,timbArr[i].tminutid_e,timbArr[i].tminutid_u,timbArr[i].tcausale_e.tcaus,totlav,debitogg,scost)
          end
          else
          begin
            // salva in una stringlist i punti nominali > 0 (saranno considerati successivamente)
            if not PNConsiderati.Find(IntToStr(timbArr[i].tpuntnomin),index) then
              PNConsiderati.Add(IntToStr(timbArr[i].tpuntnomin));
          end;
        end;
      end;

      // 2. ciclo di controllo sui punti nominali > 0
      MinutiMensa:=0;
      UltimaUsc:=-1;
      for i:=0 to PNConsiderati.Count - 1 do
      begin
        Prima:=True;
        PNAttuale:=StrToInt(PNConsiderati[i]);
        EntNom:=ttimbraturenom[PNAttuale].tminutin_e + IfThen(EntNomFlex,ttimbraturenom[PNAttuale].flex);
        UscNom:=ttimbraturenom[PNAttuale].tminutin_u;

        // crea l'array timbArrFiltrato, come filtro di timbArr con le sole timbrature appoggiate al punto nominale considerato
        FiltraArrTimbrature(PNAttuale);

        // ciclo sulle timbrature appoggiate al punto nominale considerato
        for j:=0 to Length(timbArrFiltrato) - 1 do
        begin
          UltimaUsc:=timbArrFiltrato[j].tminutid_u;
          UltimoTag:=timbArrFiltrato[j].tag;
          if Prima then
          begin
            if not CopertoDaTimbratura(EntNom,timbArrFiltrato[j].tminutid_e) then
            begin
              AggiungiRiga(Giorno,'GA',timbArrFiltrato[j].tag,EntNom,timbArrFiltrato[j].tminutid_e,'',totlav,debitogg,scost);
            end;
            Prima:=False;
          end;
          if j < Length(timbArrFiltrato) - 1 then
          begin
            if not CopertoDaTimbratura(timbArrFiltrato[j].tminutid_u,timbArrFiltrato[j+1].tminutid_e) then
            begin
              // verifica intersezione con pausa mensa
              if IntersecaMensa(timbArrFiltrato[j].tminutid_u,timbArrFiltrato[j+1].tminutid_e,MinutiMensa) then
              begin
                // se tot. pausa mensa > consentito, considera i minuti di sforamento come periodo da giustificare
                if MinutiMensa > R502ProDtM.PauMenMinUtilizzata then
                begin
                  Fm:=timbArrFiltrato[j+1].tminutid_e;
                  Im:=Fm - (MinutiMensa - R502ProDtM.PauMenMinUtilizzata);
                  AggiungiRiga(Giorno,'GA',timbArrFiltrato[j].tag,Im,Fm,'',totlav,debitogg,scost);
                end;
              end
              else
                AggiungiRiga(Giorno,'GA',timbArrFiltrato[j].tag,timbArrFiltrato[j].tminutid_u,timbArrFiltrato[j+1].tminutid_e,'',totlav,debitogg,scost);
            end;
          end;
        end;
        // considera l'ultima uscita
        if UltimaUsc >= 0 then
          if not CopertoDaTimbratura(UltimaUsc,UscNom) then
            AggiungiRiga(Giorno,'GA',UltimoTag,UltimaUsc,UscNom,'',totlav,debitogg,scost);
      end;
    finally
      SetLength(timbArr,0);
      SetLength(timbArrFiltrato,0);
      FreeAndNil(PNConsiderati);
    end;
  end; //=> end with
end;
}
// mw.fine

procedure TA023FGestMese.dgrdBudgetServiziDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if gdSelected in State then
  begin
    dgrdBudgetServizi.Canvas.Brush.Color:=clHighLight;
    dgrdBudgetServizi.Canvas.Font.Color:=clWhite;
  end
  else if A023FTimbratureDtM1.selT723.RecordCount > 0 then
  begin
    if R180OreMInutiExt(A023FTimbratureDtM1.selT723.FieldByName('ORE').AsString) < R180OreMInutiExt(A023FTimbratureDtM1.selT723.FieldByName('ORE_CAUS').AsString) then
    begin
      // evidenzia la riga se è stata superata la disponibilità
      // (se la riga è causalizzata e ha la dicitura di supero disponibilità)
      dgrdBudgetServizi.Canvas.Brush.Color:=BG_COLOR_SUPERO_DISP;
      dgrdBudgetServizi.Canvas.Font.Color:=clWhite;
    end;
  end;
  // colorazione cella
  dgrdBudgetServizi.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TA023FGestMese.dgrdCausOreDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if gdSelected in State then
  begin
    dgrdCausOre.Canvas.Brush.Color:=clHighLight;
    dgrdCausOre.Canvas.Font.Color:=clWhite;
  end
  else if not cdsCausOre.IsEmpty then
  begin
    // effettua considerazioni se il dataset ha almeno una riga
    if cdsCausOre.FieldByName('CAUSALIZZATO').AsInteger = 0 then
    begin
      // evidenzia la riga "non causalizzato" con un colore diverso
      // (se la riga in esame ha totale causalizzato = 0)
      dgrdCausOre.Canvas.Brush.Color:=BG_COLOR_NC;
      dgrdCausOre.Canvas.Font.Color:=clWindowText;
    end
    else if (chkEventiStraordinari.Checked) and
            (cdsCausOre.FieldByName('AVVISO').AsString = AVVISO_SUPERO_DISP) then
    begin
      // evidenzia la riga se è stata superata la disponibilità
      // (se la riga è causalizzata e ha la dicitura di supero disponibilità)
      dgrdCausOre.Canvas.Brush.Color:=BG_COLOR_SUPERO_DISP;
      dgrdCausOre.Canvas.Font.Color:=clWhite;
    end;
  end;

  // colorazione cella
  dgrdCausOre.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TA023FGestMese.dgrdGestMeseDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  i: Integer;
  Selezionata,Colorata: Boolean;
  ColTipoAssenza,ColAutorizzato: Boolean;
begin
  if gdFixed in State then Exit;

  with A023FTimbratureDtM1 do
  begin
    ColTipoAssenza:=(cdsGestMese.FieldByName('TIPO').AsString = 'GA') and
                    (Column.Field = cdsGestMese.FieldByName('TIPO'));
    ColAutorizzato:=Column.Field = cdsGestMese.FieldByName('C_AUTORIZZATO');
    Selezionata:=(gdSelected in State);

    // colori alternati in base alla data del mese
    Colorata:=False;
    for i:=1 to Length(ElencoDate) - 1 do
      if (ElencoDate[i].Colorata) and
         (ElencoDate[i].Data = cdsGestMese.FieldByName('DATA').AsDateTime) then
      begin
        Colorata:=True;
        Break;
      end;

    if Selezionata then
    begin
      // cella selezionata
      dgrdGestMese.Canvas.Brush.Color:=clHighLight;
      dgrdGestMese.Canvas.Font.Color:=clWhite;
    end
    else
    begin
      if Colorata then
      begin
        // cella appartenente ad una riga con colore alternato
        if ColTipoAssenza then
        begin
          dgrdGestMese.Canvas.Font.Color:=$000000FF;
          dgrdGestMese.Canvas.Brush.Color:=$00FFFF80;
        end
        else if ColAutorizzato then
        begin
          dgrdGestMese.Canvas.Font.Color:=clWindowText;
          dgrdGestMese.Canvas.Brush.Color:=$00D3D3D3
        end
        else
        begin
          dgrdGestMese.Canvas.Font.Color:=clWindowText;
          dgrdGestMese.Canvas.Brush.Color:=$00FFFF80;
        end;
      end
      else
      begin
        // cella appartenente ad una riga con colore normale
        dgrdGestMese.Canvas.Font.Color:=clWindowText;
        if ColTipoAssenza then
          dgrdGestMese.Canvas.Font.Color:=$000000FF
        else if ColAutorizzato then
          dgrdGestMese.Canvas.Brush.Color:=$00E2E2E2;
      end;
    end;

    // colorazione cella
    dgrdGestMese.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  end;
end;

procedure TA023FGestMese.dgrdGestMeseExit(Sender: TObject);
// Forza il post quando la griglia è in modifica e perde il fuoco
begin
  with A023FTimbratureDtM1.cdsGestMese do
    if State in [dsInsert,dsEdit] then
      Post;
end;

procedure TA023FGestMese.dgrdGestMeseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  with A023FTimbratureDtM1.cdsGestMese do
  begin
    if Key = vk_Delete then
    begin
      try
        if (not FieldByName('CAUSALE').ReadOnly) and
           ((dgrdGestMese.SelectedField = FieldByName('CAUSALE')) or
            (dgrdGestMese.SelectedField = FieldByName('DESC_CAUSALE'))) then
        begin
          Edit;
          FieldByName('CAUSALE').Clear;
          Post;
        end
        else if (not FieldByName('SERVIZIO').ReadOnly) and
                (dgrdGestMese.SelectedField = FieldByName('SERVIZIO')) then
        begin
          Edit;
          FieldByName('SERVIZIO').Clear;
          Post;
        end;
      except
      end;
    end;
  end;
end;

procedure TA023FGestMese.dgrdT722DblClick(Sender: TObject);
begin
  with A023FTimbratureDtM1 do
    if selT722.RecordCount > 0 then
    begin
      edtDataDa.Text:=selT722.FieldByName('DAL').AsString;
      edtDataA.Text:=selT722.FieldByName('AL').AsString;
      cmbCausPres.ItemIndex:=R180IndexOf(cmbCausPres.Items,selT722.FieldByName('CAUSALE_STR').AsString,5);
      A023FTimbratureDtM1.ImpostaPickListCausale;
      btnSetPeriodoClick(nil);
      //Budget per servizio
      selT723.SetVariable('ID',selT722.FieldByName('ID').AsString);
      selT723.SetVariable('PROGRESSIVO',Progressivo);
      selT723.Close;
      selT723.Open;
      chkEventiStraordinari.Caption:=Format('Usa regole Eventi Straordinari (ID=%d)',[selT722.FieldByName('ID').AsInteger]);
    end;
end;

procedure TA023FGestMese.CancPianif;
// Cancellazione dalla T320 per il progressivo e la data correnti
var
  DataAss: TDateTime;
begin
  with A023FTimbratureDtM1 do
  begin
    // salva i dati del giustificativo in variabili di appoggio
    DataAss:=cdsGestMese.FieldByName('DATA').AsDateTime;

    // verifica dati bloccati
    if SelDatiBloccati.DatoBloccato(Progressivo,SelDatiBloccati.MeseBloccoRiepiloghi(DataAss),'T320') then
      raise Exception.Create(selDatiBloccati.MessaggioLog);
      
    // cancellazione
    try
      delT320.SetVariable('PROGRESSIVO',Progressivo);
      delT320.SetVariable('DATA_INIZIO',DataAss);
      delT320.SetVariable('DATA_FINE',DataAss);
      delT320.SetVariable('ID_EVENTO_STR',null);
      if (A023FTimbratureDtM1.selT722.Active) and
         (chkEventiStraordinari.Checked) and
         (selT722.RecordCount > 0) then
        delT320.SetVariable('ID_EVENTO_STR',selT722.FieldByName('ID').AsInteger);
      delT320.Execute;
      SessioneOracle.Commit;
    except
      on E: Exception do
        raise Exception.Create('Errore durante la cancellazione della pianificazione.' + #13#10 +
                               E.Message);
    end;
  end;
end;

procedure TA023FGestMese.InsPianif;
// Inserisce una riga nella tabella T320
var
  DataAss: TDateTime;
  CausAss,DalleAss,AlleAss,Servizio: String;
  IdEventoStr: Integer;
begin
  with A023FTimbratureDtM1 do
  begin
    // salva i dati in variabili di appoggio
    DataAss:=cdsGestMese.FieldByName('DATA').AsDateTime;
    CausAss:=cdsGestMese.FieldByName('CAUSALE').AsString;
    DalleAss:=cdsGestMese.FieldByName('DALLE_H').AsString;
    AlleAss:=cdsGestMese.FieldByName('ALLE_H').AsString;
    IdEventoStr:=cdsGestMese.FieldByName('ID_EVENTO_STR').AsInteger;
    Servizio:=cdsGestMese.FieldByName('SERVIZIO').AsString;

    // verifica dati bloccati
    if SelDatiBloccati.DatoBloccato(Progressivo,SelDatiBloccati.MeseBloccoRiepiloghi(DataAss),'T320') then
      raise Exception.Create(selDatiBloccati.MessaggioLog);

    try
      // inserimento nuova pianificazione
      insT320.ClearVariables;
      insT320.SetVariable('PROGRESSIVO',Progressivo);
      insT320.SetVariable('DATA',DataAss);
      insT320.SetVariable('DALLE',DalleAss);
      insT320.SetVariable('ALLE',AlleAss);
      insT320.SetVariable('CAUSALE',CausAss);
      // TORINO_COMUNE - commessa 2012/046.ini
      if (chkEventiStraordinari.Checked) and (IdEventoStr > 0) (*and (CausAss = A023FTimbratureDtM1.selT722.FieldByName('CAUSALE_STR').AsString)*) then
      begin
        insT320.SetVariable('ID_EVENTO_STR',IdEventoStr);
        insT320.SetVariable('SERVIZIO',Servizio);
      end;
      // TORINO_COMUNE - commessa 2012/046.fine
      insT320.Execute;
      SessioneOracle.Commit;
    except
      on E: Exception do
        raise Exception.Create('Errore durante l''inserimento della pianificazione.'#13#10 + E.Message);
    end;
  end;
end;

procedure TA023FGestMese.CancGiustif;
// Cancellazione del giustificativo ad ore per il progressivo e la data correnti
var
  DataGiustif: TDateTime;
  DalleGiustif,AlleGiustif,CausGiustif,AssPres: String;
  DaOre,AOre: TDateTime;
  //L133GGModif: Boolean;
begin
  // pre: Q040 viene aperto nel form A023FTimbrature ed è filtrato per il progressivo e tutto il mese di rif.
  with A023FTimbratureDtM1 do
  begin
    DataGiustif:=cdsGestMese.FieldByName('DATA').AsDateTime;
    DalleGiustif:=R180MinutiOre(cdsGestMese.FieldByName('DALLE_ORIG').AsInteger);
    if cdsGestMese.FieldByName('ALLE_ORIG').AsInteger = 1440 then
      AlleGiustif:=R180MinutiOre(0)
    else
      AlleGiustif:=R180MinutiOre(cdsGestMese.FieldByName('ALLE_ORIG').AsInteger);
    DaOre:=StrToTime(DalleGiustif);
    AOre:=StrToTime(AlleGiustif);
    CausGiustif:=cdsGestMese.FieldByName('CAUSALE_ORIG').AsString;

    // causale originale non presente -> nessun giustificativo da cancellare
    if Trim(CausGiustif) = '' then
      Exit;

    // controllo dati bloccati
    if SelDatiBloccati.DatoBloccato(Progressivo,SelDatiBloccati.MeseBloccoRiepiloghi(DataGiustif),'T040') then
      raise Exception.Create(selDatiBloccati.MessaggioLog);

    // cerca il giustificativo da cancellare sulla T040
    if not A023FTimbratureMW.Q040.SearchRecord('DATA;CAUSALE;DAORE;AORE',VarArrayOf([DataGiustif,CausGiustif,DaOre,AOre]),[srFromBeginning]) then
      // anomalia...
      raise Exception.Create('Record del giustificativo da cancellare non trovato.');

    // se il giustificativo non fa parte delle righe bloccate lo elimina
    AssPres:=cdsGestMese.FieldByName('TIPO').AsString;  // AssPres = 'GA' oppure 'GP'
    if not cdsGestMese.Locate('DATA;DALLE_H;ALLE_H;TIPO;FLAG_RIGA',VarArrayOf([DataGiustif,DalleGiustif,AlleGiustif,AssPres,'B']),[]) then
    begin
      try
        A023FTimbratureMW.Q040.Delete;
        if AssPres = 'GA' then
        begin
          // L. 133 - Brunetta
          if DataGiustif >= EncodeDate(2008,6,25) then
          begin
            with A023FTimbratureMW.R600DtM1 do
            begin
              scrDieciGiorniDopo.SetVariable('PROGRESSIVO',Progressivo);
              scrDieciGiorniDopo.SetVariable('DATA',DataGiustif);
              scrDieciGiorniDopo.Execute;
              //L133GGModif:=L133GGModif or (scrDieciGiorniDopo.GetVariable('GGMODIF') > 0);
            end;
          end;
          // gestione periodi di assenza
          with A023FTimbratureMW.Periodiassenza do
          begin
            SetVariable('PROG',Progressivo);
            SetVariable('INIZIO',DataGiustif);
            SetVariable('FINE',DataGiustif);
            SetVariable('CAUS',CausGiustif);
            SetVariable('TG','D');
            SetVariable('OPER','C');
            SetVariable('DALLE',DalleGiustif);
            SetVariable('ALLE',AlleGiustif);
            Execute;
          end;
        end;
        SessioneOracle.Commit;
      except
        on E: Exception do
          R180MessageBox('Errore durante la cancellazione del giustificativo di ' +
                         IfThen(AssPres = 'GA','assenza.','presenza.') + #13#10 +
                         E.Message, ESCLAMA);
      end;
    end;
  end;
end;

procedure TA023FGestMese.InsGiustif;
// inserimento del giustificativo per la riga attualmente considerata
var
  //L133GGModif: Boolean;
  DataGiustif: TDateTime;
  CausGiustif,DalleGiustif,AlleGiustif,AssPres: String;
  ProgrCausale, FruizVincolata, arr: Integer;
  Assenza: TControlloAssenza;
begin
  with A023FTimbratureDtM1 do
  begin
    // salva i dati del giustificativo in variabili di appoggio
    DataGiustif:=cdsGestMese.FieldByName('DATA').AsDateTime;
    CausGiustif:=cdsGestMese.FieldByName('CAUSALE').AsString;
    DalleGiustif:=cdsGestMese.FieldByName('DALLE_H').AsString;
    AlleGiustif:=cdsGestMese.FieldByName('ALLE_H').AsString;

    // verifica dati bloccati
    if SelDatiBloccati.DatoBloccato(Progressivo,SelDatiBloccati.MeseBloccoRiepiloghi(DataGiustif),'T040') then
      raise Exception.Create(selDatiBloccati.MessaggioLog);

    AssPres:=cdsGestMese.FieldByName('TIPO').AsString;
    // controlli per giustificativo di assenza
    if AssPres = 'GA' then
    begin
      // estrae informazioni sulla causale di assenza
      A023FTimbratureMW.Q265.SearchRecord('CODICE',CausGiustif,[srFromBeginning]);

      // verifica vincoli sulla fruizione oraria
      if A023FTimbratureMW.Q265.FieldByName('FRUIZCOMPETENZE_ARR').AsString = 'N' then
        arr:=A023FTimbratureMW.Q265.FieldByName('FRUIZ_ARR').AsInteger
      else
        arr:=0;
      A023FTimbratureMW.R600DtM1.ControllaVincoliFruizione(IfThen(R180OreMinutiExt(AlleGiustif) = 0,1440,R180OreMinutiExt(AlleGiustif)) - R180OreMinutiExt(DalleGiustif),A023FTimbratureMW.Q265.FieldByName('FRUIZ_MIN').AsInteger,A023FTimbratureMW.Q265.FieldByName('FRUIZ_MAX').AsInteger,arr,FruizVincolata);
      if R180OreMinutiExt(DalleGiustif) + FruizVincolata = 1440 then
        AlleGiustif:='00.00'
      else
        AlleGiustif:=R180MinutiOre(R180OreMinutiExt(DalleGiustif) + FruizVincolata);
      if FruizVincolata = 0 then
        raise Exception.Create('Causale: ' + cdsGestMese.FieldByName('DESC_CAUSALE').AsString + #13#10 +
                               'La fruizione è inferiore ai vincoli specificati!');
      // parametro FRUIZ_MAX_DEBITO
      if A023FTimbratureMW.Q265.FieldByName('FRUIZ_MAX_DEBITO').AsString = 'S' then
      begin
        A023FTimbratureMW.R600DtM1.ControllaFruizMaxDebito(DataGiustif,Progressivo,FruizVincolata,CausGiustif,'D',DalleGiustif,AlleGiustif,FruizVincolata);
        if R180OreMinutiExt(DalleGiustif) + FruizVincolata = 1440 then
          AlleGiustif:='00.00'
        else
          AlleGiustif:=R180MinutiOre(R180OreMinutiExt(DalleGiustif) + FruizVincolata);
        if FruizVincolata = 0 then
          raise Exception.Create('Causale: ' + cdsGestMese.FieldByName('DESC_CAUSALE').AsString + #13#10 +
                                 'La fruizione è inferiore ai vincoli specificati!');
      end;

      // controllo dell'inserimento del giustificativo di assenza
      //L133GGModif:=False;
      Assenza.Progressivo:=Progressivo;
      Assenza.Data:=DataGiustif;
      Assenza.DataNas:=0;
      Assenza.OldGiustif.Inserimento:=False;
      Assenza.OldGiustif.Modo:='D';
      Assenza.OldGiustif.Causale:='';
      Assenza.OldGiustif.DaOre:='';
      Assenza.OldGiustif.AOre:='';
      Assenza.NewGiustif.Inserimento:=True;
      Assenza.NewGiustif.Modo:='D';
      Assenza.NewGiustif.Causale:=CausGiustif;
      Assenza.NewGiustif.DaOre:=DalleGiustif;
      Assenza.NewGiustif.AOre:=AlleGiustif;
      if not A023FTimbratureDtM1.A023FTimbratureMW.ControlloAssenze(Assenza,CausGiustif) then
        Exit;
    end;
    ProgrCausale:=0;
    // inserimento del giustificativo
    try
      A023FTimbratureMW.Q040.Append;
      A023FTimbratureMW.Q040.FieldByName('Progressivo').AsInteger:=Progressivo;
      A023FTimbratureMW.Q040.FieldByName('Data').AsDateTime:=DataGiustif;
      A023FTimbratureMW.Q040.FieldByName('Causale').AsString:=CausGiustif;
      A023FTimbratureMW.Q040.FieldByName('ProgrCausale').AsInteger:=ProgrCausale;
      A023FTimbratureMW.Q040.FieldByName('TipoGiust').AsString:='D'; // da ore/a ore
      A023FTimbratureMW.Q040.FieldByName('DaOre').AsDateTime:=StrToTime(DalleGiustif);
      A023FTimbratureMW.Q040.FieldByName('AOre').AsDateTime:=StrToTime(AlleGiustif);
      while True do
      try
        A023FTimbratureMW.Q040.Post;
        Break;
      except
        ProgrCausale:=ProgrCausale + 1;
        A023FTimbratureMW.Q040.FieldByName('PROGRCAUSALE').AsInteger:=ProgrCausale;
      end;

      // controlli per giustificativo di assenza
      if AssPres = 'GA' then
      begin
        {
        //L133 - Brunetta
        if DataAss >= EncodeDate(2008,6,25) then
        begin
          with A023FTimbrature.R600DtM1 do
          begin
            scrDieciGiorniDopo.SetVariable('PROGRESSIVO',Progressivo);
            scrDieciGiorniDopo.SetVariable('DATA',DataAss);
            scrDieciGiorniDopo.Execute;
            L133GGModif:=L133GGModif or (scrDieciGiorniDopo.GetVariable('GGMODIF') > 0);
          end;
        end;
        }
        // gestione periodi di assenza
        with A023FTimbratureMW.Periodiassenza do
        begin
          SetVariable('PROG',Progressivo);
          SetVariable('INIZIO',DataGiustif);
          SetVariable('FINE',DataGiustif);
          SetVariable('CAUS',CausGiustif);
          SetVariable('TG','D');
          SetVariable('OPER','I');
          SetVariable('DALLE',DalleGiustif);
          SetVariable('ALLE',AlleGiustif);
          Execute;
        end;
      end;
      SessioneOracle.Commit;
    except
      on E: Exception do
        R180MessageBox('Errore durante l''inserimento del giustificativo di ' +
                       IfThen(AssPres = 'GA','assenza.','presenza.') + #13#10 +
                       E.Message, ESCLAMA);
      end;
  end;
end;

function TA023FGestMese.ControllaIntersezioni: Boolean;
var
  DalleTime,AlleTime: TDateTime;
  DalleMin,AlleMin: Integer;
  Periodi,DataMsg,DalleMsg,AlleMsg,DicituraOpzionale,Messaggio: String;
  DataAttuale: TDateTime;
  IntersezGiornoSucc: Boolean;
begin
  // ciclo sul client dataset
  with A023FTimbratureDtM1 do
  begin
    // crea un clientdataset temporaneo con i dati duplicati per effettuare i controlli
    cdsGestMeseTemp.CreateDataSet;
    cdsGestMeseTemp.Filter:='';
    cdsGestMeseTemp.Filtered:=False;

    // ciclo di riempimento del dataset temporaneo con i soli record per cui la causale risulta impostata
    cdsGestMese.AfterScroll:=nil;
    cdsGestMese.DisableControls;
    cdsGestMese.First;
    while not cdsGestMese.Eof do
    begin
      if (cdsGestMese.FieldByName('C_MODIFICATO').AsString = 'S') and
         (cdsGestMese.FieldByName('CAUSALE').AsString <> '') then
      begin
        with cdsGestMeseTemp do
        begin
          Append;
          FieldByName('ID').AsInteger:=cdsGestMese.RecNo;
          FieldByName('GIORNO').AsDateTime:=cdsGestMese.FieldByName('DATA').AsDateTime;
          TryStrToTime(cdsGestMese.FieldByName('DALLE_H').AsString,DalleTime);
          DalleMin:=R180OreMinuti(DalleTime);
          FieldByName('DALLE').AsInteger:=DalleMin;
          TryStrToTime(cdsGestMese.FieldByName('ALLE_H').AsString,AlleTime);
          AlleMin:=R180OreMinuti(AlleTime);
          if AlleMin < DalleMin then
            AlleMin:=AlleMin + 1440;
          FieldByName('ALLE').AsInteger:=AlleMin;
          Post;
        end;
      end;
      cdsGestMese.Next;
    end;

    // ciclo di controlli di intersezione periodi
    try
      cdsGestMese.First;
      while not cdsGestMese.Eof do
      begin
        if cdsGestMese.FieldByName('CAUSALE').AsString <> '' then
        begin
          with cdsGestMeseTemp do
          begin
            // filtra il dataset di appoggio per verificare che non ci siano nello
            // stesso giorno periodi intersecanti (v. anche "OnFilterRecord")
            // nota: per intervalli a cavallo di mezzanotte si verifica anche il giorno successivo
            DataAttuale:=cdsGestMese.FieldByName('DATA').AsDateTime;
            Filtered:=False;
            Filter:='((ID <> ' + IntToStr(cdsGestMese.RecNo) + ') and ' +
                    '((GIORNO = ' + FloatToStr(DataAttuale) + ')' +
                    IfThen(cdsGestMese.FieldByName('CAVALLO_MEZZANOTTE').AsString = 'S',
                           'or (GIORNO = ' + FloatToStr(DataAttuale + 1) + '))',
                           ')') +
                    ')';
            Filtered:=True;

            // se ci sono record nel dataset filtrato effettua il controllo sulle intersezioni
            if (RecordCount > 0) then
            begin
              // periodi intersecanti con quello di partenza
              Periodi:='';
              DicituraOpzionale:='';
              First;
              while not Eof do
              begin
                IntersezGiornoSucc:=(cdsGestMese.FieldByName('DATA').AsDateTime = FieldByName('GIORNO').AsDateTime - 1);
                DalleMin:=FieldByName('DALLE').AsInteger;
                AlleMin:=FieldByName('ALLE').AsInteger;
                if AlleMin >= 1440 then
                  AlleMin:=AlleMin - 1440;
                Periodi:=Periodi + R180MinutiOre(DalleMin) + ' - ' + R180MinutiOre(AlleMin) +
                         IfThen(IntersezGiornoSucc,' *') + #13#10;
                if IntersezGiornoSucc then
                  DicituraOpzionale:='(* = rif. al giorno successivo)' + #13#10;
                Next;
              end;

              // periodo di partenza
              DataMsg:=cdsGestMese.FieldByName('DATA').AsString;
              DalleMsg:=cdsGestMese.FieldByName('DALLE_H').AsString;
              AlleMsg:=cdsGestMese.FieldByName('ALLE_H').AsString;
              Messaggio:='Sono state rilevate incongruenze in data ' + DataMsg + '.' + #13#10 +
                         'Il periodo evidenziato [' + DalleMsg + ' - ' + AlleMsg + '] interseca' + #13#10 +
                         IfThen(RecordCount = 1,'il seguente altro periodo: ',
                                                'i seguenti altri ' + IntToStr(RecordCount) + ' periodi: ' + #13#10) +
                         Periodi + DicituraOpzionale + #13#10;
              // messaggio bloccante
              //raise Exception.Create(Messaggio +'E'' necessario correggere questa situazione!');
              // messaggio non bloccante (soluzione temporanea)
              cdsGestMese.EnableControls;
              if R180MessageBox(Messaggio + 'Continuare?',DOMANDA) = mrNo then
              begin
                Result:=False;
                Abort; // esegue le operazioni nel blocco finally
              end;
              cdsGestMese.DisableControls;   
            end;
          end;
        end;
        cdsGestMese.Next;
      end;
      // nessuna intersezione
      Result:=True;
    finally
      cdsGestMeseTemp.EmptyDataSet;
      cdsGestMeseTemp.Close;
      cdsGestMese.EnableControls;
      cdsGestMese.AfterScroll:=cdsGestMeseAfterScroll;
      cdsGestMeseAfterScroll(nil);
    end;
  end;
end;

procedure TA023FGestMese.cdsGestMeseTempFilterRecord(DataSet: TDataSet; var Accept: Boolean);
// Filtra il dataset in modo da mantenere i soli record con periodi intersecanti
// per rilevare eventuali errori
var
  DataIni,DataTemp: TDateTime;
  DalleIni,AlleIni,DalleTemp,AlleTemp: Integer;
begin
  with A023FTimbratureDtM1 do
  begin
    // dati del record di partenza
    DataIni:=cdsGestMese.FieldByName('DATA').AsDateTime;
    DalleIni:=R180OreMinuti(StrToTime(cdsGestMese.FieldByName('DALLE_H').AsString));
    AlleIni:=R180OreMinuti(StrToTime(cdsGestMese.FieldByName('ALLE_H').AsString));
    if AlleIni < DalleIni then
      AlleIni:=AlleIni + 1440;

    // dati del record da confrontare con quello di partenza
    DataTemp:=cdsGestMeseTemp.FieldByName('GIORNO').AsDateTime;
    DalleTemp:=cdsGestMeseTemp.FieldByName('DALLE').AsInteger;
    AlleTemp:=cdsGestMeseTemp.FieldByName('ALLE').AsInteger;
    if DataIni = DataTemp - 1 then
    begin
      DalleTemp:=DalleTemp + 1440;
      AlleTemp:=AlleTemp + 1440;
    end;

    // controlla intersezione periodo
    Accept:=(Min(AlleIni,AlleTemp) - Max(DalleIni,DalleTemp) > 0);
  end;
end;

procedure TA023FGestMese.SalvaDati;
// Inserimento dati sulle tabelle della pianificazione / giustificativi
var
  OldDataIns: TDateTime;
  CausaleNulla,CausaleOrigNulla,RigaBloccata,RigaOriginale,NuovaData: Boolean;
begin
  Screen.Cursor:=crHourGlass;
  StatusBar1.Panels[0].Text:='Salvataggio in corso...';
  StatusBar1.Repaint;
  OldDataIns:=0;

  // ciclo sul client dataset
  with A023FTimbratureDtM1 do
  begin
    cdsGestMese.AfterScroll:=nil;
    A023FTimbratureMW.R600DtM1:=TR600DtM1.Create(Self);
    try
      // ciclo sulle righe del client dataset
      cdsGestMese.First;
      while not cdsGestMese.Eof do
      begin
        // ignora le righe non modificate
        if cdsGestMese.FieldByName('C_MODIFICATO').AsString = 'N' then
        begin
          cdsGestMese.Next;
          Continue;
        end;

        CausaleNulla:=(cdsGestMese.FieldByName('CAUSALE').IsNull) or
                      (Trim(cdsGestMese.FieldByName('CAUSALE').AsString) = '');
        CausaleOrigNulla:=(cdsGestMese.FieldByName('CAUSALE_ORIG').IsNull) or
                          (Trim(cdsGestMese.FieldByName('CAUSALE_ORIG').AsString) = '');
        RigaBloccata:=cdsGestMese.FieldByName('FLAG_RIGA').AsString = 'B';
        RigaOriginale:=cdsGestMese.FieldByName('FLAG_RIGA').AsString = 'A';
        try
          // gestione righe di pianificazione + giustificativi di presenza o assenza
          try
            if (AccessoA004 = 'S') and
               ((cdsGestMese.FieldByName('TIPO').AsString = 'GA') or
                (cdsGestMese.FieldByName('TIPO').AsString = 'GP')) then
            begin
              // Giustificativo di presenza / assenza
              if not RigaBloccata then
              begin
                // cancella solo le righe originali modificate
                if RigaOriginale and (not CausaleOrigNulla) then
                  CancGiustif;

                // se la causale è impostata inserisce il giustificativo
                if not CausaleNulla then
                  InsGiustif;
              end;
            end
            else
            begin
              // Straordinario da pianificare
              // 1. cancellazione pianificazione esistente per il giorno
              NuovaData:=cdsGestMese.FieldByName('DATA').AsDateTime <> OldDataIns;
              if NuovaData then
              begin
                OldDataIns:=cdsGestMese.FieldByName('DATA').AsDateTime;
                CancPianif;
                // cancellazione record di blocco riepilogo (utilizzato in W026)
                // (operazione effettuata solo se non sarà inserita la pianificazione)
                if CausaleNulla then
                begin
                  with A023FTimbratureDtM1.scrSbloccaRiepT325 do
                  begin
                    SetVariable('PROGRESSIVO',Progressivo);
                    SetVariable('DAL',cdsGestMese.FieldByName('DATA').AsDateTime);
                    SetVariable('AL',cdsGestMese.FieldByName('DATA').AsDateTime);
                    SetVariable('RIEPILOGO','T325');
                    Execute;
                    SessioneOracle.Commit;
                  end;
                end;
              end;
              // 2. inserimento pianificazione
              if not CausaleNulla then
              begin
                InsPianif;
                // inserimento record di blocco riepilogo (utilizzato in W026)
                if NuovaData then
                begin
                  with A023FTimbratureDtM1.scrSbloccaRiepT325 do
                  begin
                    SetVariable('PROGRESSIVO',Progressivo);
                    SetVariable('DAL',cdsGestMese.FieldByName('DATA').AsDateTime);
                    SetVariable('AL',cdsGestMese.FieldByName('DATA').AsDateTime);
                    SetVariable('RIEPILOGO','T325');
                    Execute;
                  end;
                  with A023FTimbratureDtM1.scrBloccaRiepT325 do
                  begin
                    SetVariable('PROGRESSIVO',Progressivo);
                    SetVariable('DAL',cdsGestMese.FieldByName('DATA').AsDateTime);
                    SetVariable('AL',cdsGestMese.FieldByName('DATA').AsDateTime);
                    SetVariable('RIEPILOGO','T325');
                    Execute;
                  end;
                  SessioneOracle.Commit;
                end;
              end;
            end;
          except
            // messaggio di errore - conferma per proseguire l'operazione
            on E:EAbort do
            begin
              if R180MessageBox('Proseguire con l''operazione di conferma delle righe successive?',DOMANDA) = mrNo then
                Abort;
            end;
            on E:Exception do
            begin
              if R180MessageBox('Anomalia rilevata!'#13#10 +
                                'Data: ' + cdsGestMese.FieldByName('DATA').AsString + ' (' +
                                cdsGestMese.FieldByName('DALLE_H').AsString + ' - ' +
                                cdsGestMese.FieldByName('ALLE_H').AsString + ')'#13#10 +
                                E.Message + #13#10#13#10 +
                                'Proseguire con l''operazione di conferma delle righe successive?',DOMANDA) = mrNo then
                Abort;
            end;
          end;
        finally
          cdsGestMese.Next;
        end;
      end;
    finally
      FreeAndNil(A023FTimbratureMW.R600DtM1);
      A023FTimbratureMW.Q040.Refresh;
      cdsGestMese.AfterScroll:=cdsGestMeseAfterScroll;
      StatusBar1.Panels[0].Text:='';
      StatusBar1.Repaint;
      Screen.Cursor:=crDefault;
    end;
  end;
end;

procedure TA023FGestMese.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // conferma salvataggio
  if A023FTimbratureDtM1.GestMeseModifichePendenti then
  begin
    if R180MessageBox('Attenzione! Sono presenti modifiche non ancora salvate.'#13#10 +
                      'Vuoi uscire comunque?',DOMANDA) = mrNo then
      CanClose:=False;
  end;
end;

procedure TA023FGestMese.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
  FreeAndNil(Self);
end;

procedure TA023FGestMese.FormDestroy(Sender: TObject);
begin
  // chiusura dataset
  cdsTemp.Close;
  cdsCausOre.Close;
  A023FTimbratureDtM1.selAssPres.Close;
  A023FTimbratureDtM1.cdsGestMese.Close;
  A023FTimbratureDtM1.selDistT722.Close;
  // distruzione oggetti
  SetLength(ElencoDate,0);
  //FreeAndNil(GiorniConteggi.GiorniConsideratiList); // mw
  FreeAndNil(selDatiBloccati);
  FreeAndNil(R502ProDtM);

  // abilita menu e componenti del cartellino
  if A023FTimbrature <> nil then
  begin
    with A023FTimbrature do
    begin
      A023FTimbratureDtM1.A023FTimbratureMW.R502ProDtM1.Q320.Close;
      frmSelAnagrafe.Enabled:=True;
      EMese.Enabled:=True;
      EAnno.Enabled:=True;
      // aggiorna la visualizzazione
      CaricaMese;
      SBConteggi.Enabled:=True;
      SBConteggi.Down:=OldConteggiAttivi;
      SBConteggiClick(nil);
      SpCorrezione.Enabled:=True;
      Correzionetimbrature1.Enabled:=True;
      Gestionemensile1.Enabled:=True;
    end;
  end;

  FreeAndNil(A023FGestMeseMW); // mw.ini
  inherited;
end;

end.
