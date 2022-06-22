unit A002UAnagrafeGestPadre;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Menus, ExtCtrls, DBCtrls, Grids, DBGrids, StdCtrls, StrUtils,
  Mask, DB, Buttons, QueryStorico, A002ULayout, A082UCdcPercent,
  L001Call, C180FunzioniGenerali, OracleData, Oracle, C006UStoriaDati, L021Call,
  ToolWin, ActnList, ImgList, A000UCostanti, A000USessione,A000UInterfaccia, C013UCheckList,
  A002UInterfacciaSt,A011UComuniProvinceRegioni,A005UDatiLiberi,
  A136URelazioniAnagrafe, A142UQualificaMinisteriale, A146UFotoDipendente,
  C001UFiltroTabelle, C001UFiltroTabelleDtM, C001UScegliCampi,
  C700USelezioneAnagrafe, Variants, Printers, Math, Shellapi,A000UMessaggi
  {$IFNDEF VER210}, System.Actions, System.ImageList{$ENDIF};

type

  TA002FAnagrafeGestPadre = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Chiudi1: TMenuItem;
    N1: TMenuItem;
    Stampa1: TMenuItem;
    PrinterSetupDialog1: TPrinterSetupDialog;
    PopupMenu1: TPopupMenu;
    Tutto: TMenuItem;
    Singolo: TMenuItem;
    N2: TMenuItem;
    Nuovo: TMenuItem;
    Panel2: TPanel;
    StatusBar: TStatusBar;
    Label48: TLabel;
    DBText1: TDBText;
    DBText2: TDBText;
    Label1: TLabel;
    DBText3: TDBText;
    Label2: TLabel;
    DBText4: TDBText;
    Label3: TLabel;
    DBText5: TDBText;
    Label4: TLabel;
    DBText6: TDBText;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    L1: TLabel;
    L2: TLabel;
    L3: TLabel;
    L7: TLabel;
    L53: TLabel;
    L4: TLabel;
    L5: TLabel;
    L6: TLabel;
    L50: TLabel;
    L52: TLabel;
    lblTelefono: TLabel;
    lblIndirizzo: TLabel;
    lblComune: TLabel;
    lblCap: TLabel;
    lblProvincia: TLabel;
    L15: TLabel;
    L16: TLabel;
    L17: TLabel;
    L54: TLabel;
    LTipoRapp: TDBText;
    L28: TLabel;
    L26: TLabel;
    LSquadra: TDBText;
    L27: TLabel;
    EMatricola: TDBEdit;
    ECognome: TDBEdit;
    ENome: TDBEdit;
    EditBadge: TDBEdit;
    EEdBadge: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    ENascita: TDBEdit;
    LookupComune: TDBLookupComboBox;
    EComune: TDBEdit;
    ECapNas: TDBEdit;
    EProvNas: TDBEdit;
    ECodFiscale: TDBEdit;
    dedtTelefono: TDBEdit;
    dedtIndirizzo: TDBEdit;
    dcmbComune: TDBLookupComboBox;
    dedtComune: TDBEdit;
    dedtCap: TDBEdit;
    dedtProvincia: TDBEdit;
    EInizio: TDBEdit;
    EFine: TDBEdit;
    EInizioServizio: TDBEdit;
    ETipoRapp: TDBLookupComboBox;
    ETerminali: TDBEdit;
    ESquadra: TDBLookupComboBox;
    ETipoOpe: TDBEdit;
    TabSheet2: TTabSheet;
    L29: TLabel;
    LContratto: TDBText;
    L30: TLabel;
    L55: TLabel;
    LPartTime: TDBText;
    L32: TLabel;
    LCalendario: TDBText;
    L31: TLabel;
    LPlusOra: TDBText;
    L34: TLabel;
    LPOrario: TDBText;
    L33: TLabel;
    LIPresenza: TDBText;
    L56: TLabel;
    LTipoCart: TDBText;
    ECausStraord: TDBCheckBox;
    EStraordE: TDBRadioGroup;
    EStraordEU2: TDBRadioGroup;
    EStraordEU: TDBRadioGroup;
    EStraordU: TDBRadioGroup;
    EContratto: TDBLookupComboBox;
    EOrario: TDBEdit;
    ETGestione: TDBCheckBox;
    EHTeoriche: TDBRadioGroup;
    EParttime: TDBLookupComboBox;
    ECalendario: TDBLookupComboBox;
    EPlusOra: TDBLookupComboBox;
    EPOrario: TDBLookupComboBox;
    EIPresenza: TDBLookupComboBox;
    ETipoCart: TDBLookupComboBox;
    TabSheet3: TTabSheet;
    L35: TLabel;
    LPAssenze: TDBText;
    L42: TLabel;
    L36: TLabel;
    EPAssenze: TDBLookupComboBox;
    ImageList1: TImageList;
    ActionList1: TActionList;
    actRicerca: TAction;
    actPrimo: TAction;
    actPrecedente: TAction;
    actSuccessivo: TAction;
    actUltimo: TAction;
    actInserisci: TAction;
    actModifica: TAction;
    actConferma: TAction;
    actAnnulla: TAction;
    actStampa: TAction;
    actEsci: TAction;
    actStoricoPrecedente: TAction;
    actStoricoSuccessivo: TAction;
    actGomma: TAction;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton13: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    ToolButton9: TToolButton;
    ToolButton11: TToolButton;
    ToolButton14: TToolButton;
    ToolButton12: TToolButton;
    ToolButton16: TToolButton;
    TStampa: TToolButton;
    ToolButton15: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    Ricerca1: TMenuItem;
    Primo1: TMenuItem;
    Precedente1: TMenuItem;
    Successivo1: TMenuItem;
    Ultimo1: TMenuItem;
    Inserisci1: TMenuItem;
    Modifica1: TMenuItem;
    Annulla1: TMenuItem;
    Conferma1: TMenuItem;
    Puliscicampo1: TMenuItem;
    Storicoprecedente1: TMenuItem;
    Storicosuccessivo1: TMenuItem;
    N4: TMenuItem;
    Strumenti1: TMenuItem;
    N3: TMenuItem;
    N5: TMenuItem;
    dedtAssenzeAbilitate: TDBEdit;
    btnSceltaAssenze: TButton;
    dedtPresenzeAbilitate: TDBEdit;
    btnSceltaPresenze: TButton;
    dchkRapportiUniti: TDBCheckBox;
    cmbDateDecorrenza: TComboBox;
    DBText7: TDBText;
    Label5: TLabel;
    N6: TMenuItem;
    Nuovamatricola1: TMenuItem;
    actModificaPrimaDec: TAction;
    N7: TMenuItem;
    Modificaprimadecorrenza1: TMenuItem;
    Tseparator: TToolButton;
    TCdcPercent: TToolButton;
    Centridicostopercentualizzati1: TMenuItem;
    actCdcPercent: TAction;
    DBRadioGroup2: TDBRadioGroup;
    dchkDocente: TDBCheckBox;
    lblLocalitaDistLavoro: TLabel;
    lblQualificaMinisteriale: TLabel;
    dlblQualificaMinisteriale: TDBText;
    drgpTipoLocalitaDistLavoro: TDBRadioGroup;
    dcmbLocalitaDistLavoro: TDBLookupComboBox;
    dedtLocalitaDistLavoro: TDBEdit;
    dcmbQualificaMinisteriale: TDBLookupComboBox;
    Relazioni: TMenuItem;
    Stampavideata1: TMenuItem;
    actFotoDipendente: TAction;
    Fotodeldipendente1: TMenuItem;
    tbtnSepFoto: TToolButton;
    tbtnFotoDipendente: TToolButton;
    grbDecorrenza: TGroupBox;
    lblDecorrenza: TLabel;
    btnStoricizza: TSpeedButton;
    dedtDecorrenza: TDBEdit;
    chkStoriciPrec: TCheckBox;
    chkStoriciSucc: TCheckBox;
    ToolButton20: TToolButton;
    TAnagraficoStipendi: TToolButton;
    actAnagraficoStipendi: TAction;
    AnagraficoStipendi1: TMenuItem;
    ToolButton19: TToolButton;
    actCancella: TAction;
    Cancella1: TMenuItem;
    EInizioIndMat: TDBEdit;
    EFineIndMat: TDBEdit;
    L57: TLabel;
    L58: TLabel;
    lblMedicinaLegale: TLabel;
    dlblMedicinaLegale: TDBText;
    dcmbMedicinaLegale: TDBLookupComboBox;
    LI060EMail: TLabel;
    EI060EMail: TDBEdit;
    ToolButton21: TToolButton;
    TCercaDato: TToolButton;
    actCercaCampo: TAction;
    Cercadato1: TMenuItem;
    N8: TMenuItem;
    Storicizzati: TMenuItem;
    lblIndirizzoDomBase: TLabel;
    dedtIndirizzoDomBase: TDBEdit;
    lblComuneDomBase: TLabel;
    dcmbComuneDomBase: TDBLookupComboBox;
    dedtComuneDomBase: TDBEdit;
    lblCapDomBase: TLabel;
    dedtCapDomBase: TDBEdit;
    lblProvinciaDomBase: TLabel;
    dedtProvinciaDomBase: TDBEdit;
    procedure dcmbKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actCdcPercentExecute(Sender: TObject);
    procedure ImpostaStampante1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure TuttoClick(Sender: TObject);
    procedure NuovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormHide(Sender: TObject);
    procedure ECapNasDblClick(Sender: TObject);
    procedure actlstExecute(Sender: TObject);
    procedure ECodFiscaleEnter(Sender: TObject);
    procedure ECapNasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECodFiscaleKeyDown(Sender: TObject; var Key: Word;
        Shift: TShiftState);
    procedure _FlagStoClick(Sender: TObject);
    procedure EditBadgeDblClick(Sender: TObject);
    procedure EditBadgeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSceltaAssenzeClick(Sender: TObject);
    procedure btnSceltaPresenzeClick(Sender: TObject);
    procedure cmbDateDecorrenzaChange(Sender: TObject);
    procedure Nuovamatricola1Click(Sender: TObject);
    procedure actModificaPrimaDecExecute(Sender: TObject);
    procedure drgpTipoLocalitaDistLavoroChange(Sender: TObject);
    procedure RelazioniClick(Sender: TObject);
    procedure Stampavideata1Click(Sender: TObject);
    procedure actFotoDipendenteExecute(Sender: TObject);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure dedtDecorrenzaExit(Sender: TObject);
    procedure actAnagraficoStipendiExecute(Sender: TObject);
    procedure EI060EMailDblClick(Sender: TObject);
    procedure actCercaCampoExecute(Sender: TObject);
  private
    { Private declarations }
    TipoDato,DatoSearch:String;
    procedure CaricaDatiStorici;
    function  DatoStorico(Oggetto:TObject; var PosDato:String):boolean;
    procedure ApriQBadgeLibero;
    procedure CercaBadgeLibero(i:LongInt);
    procedure AbblencaCampo;
    procedure StampaAnagrafe;
  public
    { Public declarations }
    Azienda,Operatore:string;
    QueryNuova:Boolean;
    function CalcoloCodFiscale(Cognome,Nome,Sesso,CodCat:String; DataNas:TDateTime):string;
  end;

var
  A002FAnagrafeGestPadre: TA002FAnagrafeGestPadre;

implementation

uses A002UAnagrafeVista, A002UAnagrafeDtM1, C006UStoriaDip, A002UCercaCampo, A002UBadgeMsg,
  A002UAnagrafeVistaPadre;

{$R *.DFM}

procedure TA002FAnagrafeGestPadre.FormCreate(Sender: TObject);
{Inizializza dati storici}
begin
  (*try
    WindowState:=TWindowState(StrToInt(R180GetRegistro(HKEY_CURRENT_USER,'A002','WindowState',IntToStr(Ord(WindowState)))));
  except
  end;
  if WindowState = wsNormal then
    try
      Height:=StrToInt(R180GetRegistro(HKEY_CURRENT_USER,'A002','Height',IntToStr(Height)));
      Width:=StrToInt(R180GetRegistro(HKEY_CURRENT_USER,'A002','Width',IntToStr(Width)));
    except
    end;*)

  A002FAnagrafeGestPadre:=Self;
  StatusBar.Panels[0].Text:=FormatDateTime('dd/mm/yyyy',Date);
  //Decorrenza.Text:=FormatDateTime('dd/mm/yyyy',A002FAnagrafeVista.DataLavoro);
  CaricaDatiStorici;
  PageControl1.ActivePage:=TabSheet1;
  R180ToolBarHandleNeeded(Self);
  //Panel3.Visible:=False;
end;

procedure TA002FAnagrafeGestPadre.FormShow(Sender: TObject);
begin
  A002FAnagrafeVista.actSchedaAnagrafica.Checked:=True;
  //FlagSto.Enabled:=Parametri.Storicizzazione = 'S';
  btnStoricizza.Enabled:=Parametri.Storicizzazione = 'S';
  actCdcPercent.Enabled:=A000GetInibizioni('Funzione','OpenA082CdcPercent') <> 'N';
  actFotoDipendente.Enabled:=A000GetInibizioni('Funzione','OpenA146FotoDipendente') <> 'N';

  try
    A002FAnagrafeDtM1.selP430.Open;
    actAnagraficoStipendi.Visible:=A002FAnagrafeDtM1.selP430.FieldByName('ANAGRAFICHE_STIPENDIALI').AsInteger > 0;
    A002FAnagrafeDtM1.selP430.Close;
  except
    actAnagraficoStipendi.Visible:=False;
  end;
end;

procedure TA002FAnagrafeGestPadre.CaricaDatiStorici;
{Inizializza dati storici}
begin
  with A002FAnagrafeVista do
  begin
    SetLength(Storico,NumStorici + 1);
    Storico[1].CampoInput:=EditBadge;
    Storico[2].CampoInput:=EEdBadge;
    Storico[3].CampoInput:=dedtIndirizzo;
    Storico[4].CampoInput:=dedtComune;
    Storico[5].CampoInput:=dedtCap;
    Storico[6].CampoInput:=dedtTelefono;
    Storico[7].CampoInput:=EInizio;
    Storico[8].CampoInput:=EFine;
    Storico[9].CampoInput:=ESquadra;
    Storico[10].CampoInput:=ETipoOpe;
    Storico[11].CampoInput:=ETerminali;
    Storico[12].CampoInput:=ECausStraord;
    Storico[13].CampoInput:=EStraordE;
    Storico[14].CampoInput:=EStraordU;
    Storico[15].CampoInput:=EStraordEU;
    Storico[16].CampoInput:=EContratto;
    Storico[17].CampoInput:=EOrario;
    Storico[18].CampoInput:=EHTeoriche;
    Storico[19].CampoInput:=ETipoCart;
    Storico[20].CampoInput:=ETGestione;
    Storico[21].CampoInput:=EPlusOra;
    Storico[22].CampoInput:=ECalendario;
    Storico[23].CampoInput:=EIPresenza;
    Storico[24].CampoInput:=EPOrario;
    Storico[25].CampoInput:=EPAssenze;
    Storico[26].CampoInput:=dedtAssenzeAbilitate;//EAbCausale1;
    Storico[27].CampoInput:=dedtPresenzeAbilitate;//EAbPresenze1;
    Storico[28].CampoInput:=ETipoRapp;
    Storico[29].CampoInput:=EPartTime;
    Storico[30].CampoInput:=EStraordEU2;
    Storico[31].CampoInput:=dchkDocente;
    Storico[32].CampoInput:=drgpTipoLocalitaDistLavoro;
    Storico[33].CampoInput:=dcmbLocalitaDistLavoro;
    Storico[34].CampoInput:=dcmbQualificaMinisteriale;
    Storico[35].CampoInput:=EInizioIndMat;
    Storico[36].CampoInput:=EFineIndMat;
    Storico[37].CampoInput:=dcmbMedicinaLegale;
    // MONDOEDP - commessa MAN/02 SVILUPPO#108.ini
    Storico[38].CampoInput:=dedtIndirizzoDomBase;
    Storico[39].CampoInput:=dedtComuneDomBase;
    Storico[40].CampoInput:=dedtCapDomBase;
    // MONDOEDP - commessa MAN/02 SVILUPPO#108.fine
  end;
end;

function TA002FAnagrafeGestPadre.DatoStorico(Oggetto:TObject; var PosDato:String):boolean;
{Restituisce true se il campo è collegato a un dato storico}
var i:integer;
begin
  i:=1;
  with A002FAnagrafeVista do
  begin
    while (Storico[i].CampoInput = nil) or ((Storico[i].CampoInput <> Oggetto) and (i < (NumStorici+A002FAnagrafeVista.NumDatiLiberi))) do
      inc(i);
    if Oggetto is TDBEdit then
      PosDato:=TDBEdit(Oggetto).Field.FieldName
    else if Oggetto is TDBLookupComboBox then
      PosDato:=TDBLookupComboBox(Oggetto).Field.FieldName
    else if Oggetto is TDBCheckBox then
      PosDato:=TDBCheckBox(Oggetto).Field.FieldName
    else if Oggetto is TDBRadioGroup then
      PosDato:=TDBRadioGroup(Oggetto).Field.FieldName;
    Result:=Storico[i].CampoInput = Oggetto;
  end;
end;

procedure TA002FAnagrafeGestPadre._FlagStoClick(Sender: TObject);
begin
  (*if A002FAnagrafeDtM1.Q030.State = dsEdit then  //LORENA 07/02/2005
    Decorrenza.Enabled:=FlagSto.Checked;
  if (FlagSto.Checked) or (A002FAnagrafeDtM1.Q030.State = dsInsert) then  //LORENA 07/02/2005
    DecorrenzaExit(nil)
  else
    A002FAnagrafeDtM1.RinfrescaQueryDescrizioni(A002FAnagrafeDtM1.Q430.FieldByName('DATAFINE').AsDateTime);*)
end;

procedure TA002FAnagrafeGestPadre.ImpostaStampante1Click(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure TA002FAnagrafeGestPadre.PopupMenu1Popup(Sender: TObject);
{Se il dato è storico visualizza la voce Storia del dato
 Se il componente è un LookupCombo visualizzo la voce 'Nuovo dato'}
var
  TipoDatoUpper: String;
begin
  N6.Visible:=(PopupMenu1.PopupComponent = EMatricola) and (A002FAnagrafeDtM1.Q030.State = dsInsert);
  NuovaMatricola1.Visible:=(PopupMenu1.PopupComponent = EMatricola) and (A002FAnagrafeDtM1.Q030.State = dsInsert);
  Tutto.Enabled:=not(A002FAnagrafeDtM1.Q030.State = dsInsert);
  Storicizzati.Enabled:=cmbDateDecorrenza.ItemIndex > 0;
  if DatoStorico(PopupMenu1.PopupComponent,TipoDato) then
  begin
    Singolo.Enabled:=not(A002FAnagrafeDtM1.Q030.State = dsInsert);
    TipoDatoUpper:=TipoDato.ToUpper;

    // tipi di dato particolari
    if TipoDatoUpper = 'EDBADGE' then
      TipoDato:='BADGE'
    else if TipoDatoUpper = 'D_COMUNE' then
      TipoDato:='COMUNE'
    // MONDOEDP - commessa MAN/02 SVILUPPO#108.ini
    else if TipoDatoUpper = 'D_COMUNE_DOM_BASE' then
      TipoDato:='COMUNE_DOM_BASE'
    // MONDOEDP - commessa MAN/02 SVILUPPO#108.ini
    else if TipoDatoUpper = 'D_COD_LOCALITA_DIST_LAVORO' then
      TipoDato:='COD_LOCALITA_DIST_LAVORO';
  end
  else
    Singolo.Enabled:=False;
  Nuovo.Visible:=(PopupMenu1.PopupComponent is TDBLookupComboBox);
  Relazioni.Visible:=VarToStr(A002FAnagrafeDtM1.A002FAnagrafeMW.selI030.Lookup('COLONNA',TipoDato,'COLONNA')) = TipoDato;
  N2.Visible:=(PopupMenu1.PopupComponent is TDBLookupComboBox);
end;

procedure TA002FAnagrafeGestPadre.RelazioniClick(Sender: TObject);
begin
  with A002FAnagrafeDtM1 do
  begin
    OpenA136FRelazioniAnagrafe('T430_STORICO',TipoDato,Q430.FieldByName(TipoDato).AsString,Q430.FieldByName('DATADECORRENZA').AsDateTime);
    A002FAnagrafeMW.selI030.Refresh;
    A002FAnagrafeMW.selI035.Refresh;
    A002FAnagrafeMW.RefreshVSQLAppoggio;
    RefreshFiltro(nil);
  end;
end;

procedure TA002FAnagrafeGestPadre.TuttoClick(Sender: TObject);
{Visualizza tutti i dati storici del dipendente}
var
  i,J,k:Integer;
  sOldTipoDato,DataDec:String;
begin
  C006FStoriaDati:=TC006FStoriaDati.Create(nil);
  try
    if Sender = Tutto then
      C006FStoriaDati.GetStoriaDato(A002FAnagrafeDtM1.Q430.FieldByName('Progressivo').AsInteger,'*')
    else if Sender = Storicizzati then
      C006FStoriaDati.GetStoriaDato(A002FAnagrafeDtM1.Q430.FieldByName('Progressivo').AsInteger,'*',StrToDate(cmbDateDecorrenza.Text))
    else
      C006FStoriaDati.GetStoriaDato(A002FAnagrafeDtM1.Q430.FieldByName('Progressivo').AsInteger,TipoDato);
    //Creo la form di visualizzazione dati storici e riempo la grid con i dati estratti
    C006FStoriaDip:=TC006FStoriaDip.Create(Application);
    if Sender <> Tutto then
      C006FStoriaDip.TipoDato:=TipoDato;
    with C006FStoriaDip do
      try
        SetLength(ElencoStorici,C006FStoriaDati.StoriaDipendente.Count + 1);
        sOldTipoDato:=RecStoria(C006FStoriaDati.StoriaDipendente[0]).TipoDato;
        j:=0;
        Grid.RowCount:=2;
        for i:=0 to C006FStoriaDati.StoriaDipendente.Count - 1 do
          if A002FAnagrafeDtM1.A002FAnagrafeMW.selT033_campoDecode.SearchRecord('CAMPODB',RecStoria(C006FStoriaDati.StoriaDipendente[i]).NomeCampo,[srFromBeginning]) or (Sender <> Tutto) then
            //Dalla visualizzazione di tutti gli storici escludo data decorrenza e datafine
            if (RecStoria(C006FStoriaDati.StoriaDipendente[i]).NomeCampo <> 'DATADECORRENZA') and
              (RecStoria(C006FStoriaDati.StoriaDipendente[i]).NomeCampo <> 'DATAFINE') then
            begin
              Grid.RowCount:=j + 2;
              Grid.Cells[0,j + 1]:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).TipoDato;
              Grid.Cells[1,j + 1]:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).DataDec;
              //Se la data fine = 31/12/3999 scrivo 'Corrente'
              if RecStoria(C006FStoriaDati.StoriaDipendente[i]).DataFine = DataFine then
                Grid.Cells[2,j + 1]:='Corrente'
              else
                Grid.Cells[2,j + 1]:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).DataFine;
              Grid.Cells[3,j + 1]:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).Valore;
              Grid.Cells[4,j + 1]:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).Descrizione;
              ElencoStorici[j + 1].NomeCampo:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).TipoDato;
              if sOldTipoDato <> ElencoStorici[j + 1].NomeCampo then
              begin
                sOldTipoDato:=ElencoStorici[j + 1].NomeCampo;
                if ElencoStorici[j].Colore then
                  ElencoStorici[j + 1].Colore:=False
                else
                  ElencoStorici[j + 1].Colore:=True;
              end
              else
                ElencoStorici[j + 1].Colore:=ElencoStorici[j].Colore;
              inc(j);
            end;
        AbilitaMenu:=(A002FAnagrafeDtM1.Q430.State in [dsBrowse]);
        ShowModal;
        if SpostaStorico then
        begin
          for k := cmbDateDecorrenza.Items.Count - 1 downto 0 do
            if EncodeDate(StrToInt(Copy(cmbDateDecorrenza.Items[k],7,4)),StrToInt(Copy(cmbDateDecorrenza.Items[k],4,2)),StrToInt(Copy(cmbDateDecorrenza.Items[k],1,2)))
               <= EncodeDate(StrToInt(Copy(Grid.Cells[1,Grid.Row],7,4)),StrToInt(Copy(Grid.Cells[1,Grid.Row],4,2)),StrToInt(Copy(Grid.Cells[1,Grid.Row],1,2))) then
            begin
              DataDec:=cmbDateDecorrenza.Items[k];
              break;
            end;
          cmbDateDecorrenza.ItemIndex:=cmbDateDecorrenza.Items.IndexOf(DataDec);
          cmbDateDecorrenzaChange(nil);
        end;
      finally
        Release;
      end;
  finally
    C006FStoriaDati.Free;
  end;
end;

procedure TA002FAnagrafeGestPadre.NuovoClick(Sender: TObject);
{Richiama la Dll per caricare i dati delle tabelle}
var
  c:String;
  NDL:Byte;
  Griglia:TInserisciDLL;
  i:integer;
begin
  with A002FAnagrafeDtM1 do
    if PopupMenu1.PopupComponent.Tag = -1 then
    begin
      with SelLocalita do
      begin
        First;
        Griglia.NomeTabella:='M042_LOCALITA';
        Griglia.Titolo:='Località trasferta';
        for i:=0 to FieldCount -1 do
        begin
          Griglia.Display[i]:=Fields[i].DisplayLabel;
          Griglia.Size[i]:=Fields[i].DisplayWidth;
        end;
        Inserisci(Griglia,dcmbLocalitaDistLavoro.Text);
        Refresh;
      end;
      RefreshLookupCache(SelLocalita);
    end
    else if PopupMenu1.PopupComponent.Tag = 1 then
    begin
      if PopupMenu1.PopupComponent=LookupComune then
        c:=EComune.Text
      else if PopupMenu1.PopupComponent=dedtComune then
        c:=dedtComune.Text
      else if PopupMenu1.PopupComponent=dcmbLocalitaDistLavoro then
        c:=dedtLocalitaDistLavoro.Text;
      OpenA011ComuniProvinceRegioni(c,'C');
    end
    else if PopupMenu1.PopupComponent.Tag = 14 then
      OpenA142QualificaMinisteriale((PopupMenu1.PopupComponent as TDBLookupComboBox).Text)
    else if PopupMenu1.PopupComponent.Tag >= 100 then
    begin
      //for NDL:=1 to High(DatiLiberi) + 1 do
      for NDL:=1 to High(DatiLiberi) do
        if DatiLiberi[NDL].Query <> nil then
        begin
          if (PopupMenu1.PopupComponent as TDBLookupComboBox) = DatiLiberi[NDL].ECampo then
          begin
            OpenA005DatiLiberi((PopupMenu1.PopupComponent as TDBLookupComboBox).Field.FieldName,(PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
            if DatiLiberi[NDL].Storico = 'S' then
            begin
              if A002FAnagrafeDtM1.Q430.State = dsBrowse then
                A002FAnagrafeDtM1.Q430.Refresh;
              A002FAnagrafeDtM1.GetDateDecorrenza;
            end;
          end;
        end
        else
          Continue;
    end;
  //Rendo visibili le modifiche apportate nelle DLL
  if (PopupMenu1.PopupComponent.Tag <> 1) then
  begin
    if not ((PopupMenu1.PopupComponent as TDBLookupComboBox).ListSource = nil) then
    begin
      (PopupMenu1.PopupComponent as TDBLookupComboBox).ListSource.DataSet.Close;
      (PopupMenu1.PopupComponent as TDBLookupComboBox).ListSource.DataSet.Open;
    end;
  end
  else
  begin
    A002FAnagrafeDtM1.T480.Close;
    A002FAnagrafeDtM1.T480.Open;
    A002FAnagrafeDtM1.RefreshLookupCache(A002FAnagrafeDtM1.T480);
  end;
end;

procedure TA002FAnagrafeGestPadre.ECapNasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
{Ricava il CAP dalla tabella comuni se si preme Ctrl + Enter}
begin
  if (Key = 13) and (Shift = [ssCtrl]) then
    ECapNasDblClick(Sender);
end;

procedure TA002FAnagrafeGestPadre.ECapNasDblClick(Sender: TObject);
{Ricava il CAP dalla tabella comuni se si fa DoppiClick}
begin
  if A002FAnagrafeDtM1.Q030.State in [dsInsert,dsEdit] then
  begin
    if Sender = ECapNas then
    begin
      // cap comune nascita
      with A002FAnagrafeDtM1.Q030 do
        FieldByName('CAPNas').AsString:=FieldByName('D_CAP').AsString
    end
    else if Sender = dedtCap then
    begin
      // cap comune residenza
      with A002FAnagrafeDtM1.Q430 do
        FieldByName('CAP').AsString:=FieldByName('D_CAP').AsString;
    end
    else if Sender = dedtCapDomBase then
    begin
      // cap comune domicilio
      with A002FAnagrafeDtM1.Q430 do
        FieldByName('CAP_DOM_BASE').AsString:=FieldByName('D_CAP_DOM_BASE').AsString;
    end;
  end;
end;

procedure TA002FAnagrafeGestPadre.AbblencaCampo;
{Abblenca il contenuto del campo su cui si è posizionati}
var F:TField;
begin
  F:=nil;
  if ActiveControl is TDBEdit then
    F:=(ActiveControl as TDBEdit).Field;
  if ActiveControl is TDBLookupComboBox then
    with ActiveControl as TDBLookupComboBox do
      F:=DataSource.DataSet.FieldByName(DataField);
  if ActiveControl is TDBComboBox then
    F:=(ActiveControl as TDBComboBox).Field;
  if ActiveControl is TDBGrid then
    F:=(ActiveControl as TDBGrid).SelectedField;
  if (F <> nil) and (not F.ReadOnly) then
  begin
    if ActiveControl is TDBGrid then
    begin
      if (ActiveControl as TDBGrid).DataSource.State in [dsEdit,dsInsert] then
        F.Clear
      else if (ActiveControl as TDBGrid).DataSource.AutoEdit then
      begin
        (ActiveControl as TDBGrid).DataSource.DataSet.Edit;
        F.Clear;
        (ActiveControl as TDBGrid).DataSource.DataSet.Post;
      end;
    end
    else
      F.Clear;
  end;
end;

procedure TA002FAnagrafeGestPadre.ECodFiscaleKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
{Richiamo la Routine di calcolo del codice fiscale se premo Ctrl + Enter}
begin
   if (ECodFiscale.DataSource.State in [dsEdit,dsInsert]) and (Key = 13) and (Shift = [ssCtrl]) then
    with A002FAnagrafeDtM1.Q030 do
      ECodFiscale.Field.AsString:=CalcoloCodFiscale(FieldByName('Cognome').AsString,
                                                    FieldByName('Nome').AsString,
                                                    FieldByName('Sesso').AsString,
                                                    FieldByName('D_CodCatastale').AsString,
                                                    FieldByName('DataNas').AsDateTime);
end;

procedure TA002FAnagrafeGestPadre.ECodFiscaleEnter(Sender: TObject);
{Richiamo la Routine di calcolo del codice fiscale}
begin
  if (ECodFiscale.DataSource.State in [dsEdit,dsInsert]) and (Trim(ECodFiscale.Field.AsString) = '') then
    with A002FAnagrafeDtM1.Q030 do
      ECodFiscale.Field.AsString:=CalcoloCodFiscale(FieldByName('Cognome').AsString,
                                                    FieldByName('Nome').AsString,
                                                    FieldByName('Sesso').AsString,
                                                    FieldByName('D_CodCatastale').AsString,
                                                    FieldByName('DataNas').AsDateTime);
end;

function TA002FAnagrafeGestPadre.CalcoloCodFiscale(Cognome,Nome,Sesso,CodCat:String; DataNas:TDateTime):String;
{Routine di calcolo del codice fiscale}
type
  TPari = Array [1..36] of Byte;
  TDispari = Array [1..36] of Byte;
const
  Vocali = 'AEIOU';
  Consonanti = 'BCDFGHJKLMNPQRSTVWXYZ';
  Controllo = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Mesi = 'ABCDEHLMPRST';
  Pari:TPari = ( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
                18, 19, 20, 21, 22, 23, 24, 25, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
  Dispari:TDispari = ( 1, 0, 5, 7, 9, 13, 15, 17, 19, 21, 2, 4, 18, 20, 11, 3, 6, 8,
                      12, 14, 16, 10, 22, 25, 24, 23, 1, 0, 5, 7, 9, 13, 15, 17, 19, 21);
var
  cod_fisc, tmp, c_contr:string;
  tmp_voc:array [1..2] of char; // contiene le prime due vocali
  tmp_cons:array [1..4] of char; // contiene le prime 4 consonanti
  Valido:boolean;
  n_voc, n_cons,k,A,M,G:Word;
function Calc_Chk(Cod_Fisc:string):string;
// calcola il carattere di controllo del codice fiscale
// ritorna 'errore' se trovato carattere non consentito
var tmp, k, posiz:Word;
begin
  if Length(Trim(Cod_Fisc)) < 15 then
    begin
    Result:='errore';
    exit;
    end;
  tmp:=0;
  k:=1;
  //Valori dei caratteri dispari
  repeat
    posiz:=Pos(Copy(Cod_Fisc, k, 1),Controllo);
    if Posiz  > 0 then
      tmp:=tmp + Dispari[posiz];
    k:=k + 2;
  until k > 15;
  k:=2;
  repeat
    posiz:=Pos(Copy(Cod_Fisc, k, 1),Controllo);
    tmp:=tmp + Pari[posiz];
    k:=k + 2;
  until k > 14;
  tmp:=(tmp mod 26) + 1;
  Result:=Copy(Controllo, tmp, 1);
end;
begin
  //FUNCTION calc_cf( cognome, nome, sesso, d_nasc, cod_cat )
  // calcola il codice fiscale noti i dati di partenza
  SetLength(Tmp,1);
  Tmp_Voc[1]:=#0;
  Tmp_Voc[2]:=#0;
  Tmp_Cons[1]:=#0;
  Tmp_Cons[2]:=#0;
  Tmp_Cons[3]:=#0;
  Tmp_Cons[4]:=#0;
  Result:=ECodFiscale.Field.AsString;
  if (Trim(Cognome) = '') or (Trim(Nome) = '') or (DataNas = 0) or (Trim(CodCat) = '') then
    exit;
  // calcola le lettere del cognome
  Cognome:=UpperCase(Trim(Cognome ));
  n_voc:=0;
  n_cons:=0;
  for k:=1 to Length(Cognome) do
    begin
    tmp:=Copy(Cognome, k, 1);
    if (Pos(Tmp,Vocali) > 0) and (n_voc < 2) then
      begin
      Inc(n_voc);
      Tmp_Voc[n_voc]:=Tmp[1];
      end;
    if (Pos(Tmp,Consonanti) > 0) and (n_cons < 4) then
      begin
      Inc(n_cons);
      Tmp_Cons[n_cons]:=Tmp[1];
      end;
    if (n_cons = 4) and (n_voc = 2) then
      Break;
    end;
  // ora conosco le prime vocali e consonanti
  Valido:=True;
  case n_cons of
    3,4:cod_fisc:=tmp_cons[1] + tmp_cons[2] + tmp_cons[3];
    2:if n_voc >= 1 then
        cod_fisc:=tmp_cons[1] + tmp_cons[2] + tmp_voc[1]
      else
        Valido:=False;
    1:if n_voc >= 2 then
        cod_fisc:=tmp_cons[1] + tmp_voc[1] + tmp_voc[2]
      else
        if n_voc = 1 then
          cod_fisc:=tmp_cons[1] + tmp_voc[1] + 'X'
        else
          Valido:=False;
    0:if n_voc = 2 then 
        cod_fisc:=tmp_voc[1] + tmp_voc[2] + 'X'
      else
        Valido:=False;
    else
      Valido:=False;
  end;
  if not Valido then
    exit;
  // calcola le lettere del nome
  Nome:=UpperCase(Trim(Nome));
  n_voc:=0;
  n_cons:=0;
  for k:=1 to Length(Nome) do
    begin
    tmp:=Copy(Nome, k, 1);
    if (Pos(Tmp,Vocali) > 0) and (n_voc < 2) then
      begin
      Inc(n_voc);
      Tmp_Voc[n_voc]:=Tmp[1];
      end;
    if (Pos(Tmp,Consonanti) > 0) and (n_cons < 4) then
      begin
      Inc(n_cons);
      Tmp_Cons[n_cons]:=Tmp[1];
      end;
    if (n_cons = 4) and (n_voc = 2) then
      Break;
    end;
  // ora conosco le prime vocali e consonanti
  case n_cons of
    4:cod_fisc:=cod_fisc + tmp_cons[1] + tmp_cons[3] + tmp_cons[4];
    3:cod_fisc:=cod_fisc + tmp_cons[1] + tmp_cons[2] + tmp_cons[3];
    2:if n_voc >= 1 then
        cod_fisc:=cod_fisc + tmp_cons[1] + tmp_cons[2] + tmp_voc[1]
      else
        Valido:=False;
    1:if n_voc >= 2 then
        cod_fisc:=cod_fisc + tmp_cons[1] + tmp_voc[1] + tmp_voc[2]
      else
        if n_voc = 1 then
          cod_fisc:=cod_fisc + tmp_cons[1] + tmp_voc[1] + 'X'
        else
          Valido:=False;
    0:if n_voc = 2 then
        cod_fisc:=cod_fisc + tmp_voc[1] + tmp_voc[2] + 'X'
      else
        Valido:=False;
    else
      Valido:=False;
  end;
  if not Valido then
    exit;
  // calcola la parte relativa alla data di nascita
  DecodeDate(DataNas,A,M,G);
  Cod_Fisc:=Cod_Fisc + Copy(IntToStr(A),3,2);
  Cod_Fisc:=Cod_Fisc + Mesi[M];
  if Sesso = 'F' then
    G:=G + 40;
  if G < 10 then
    tmp:='0' + IntToStr(G)
  else
    tmp:=IntTostr(G);
  Cod_Fisc:=Cod_Fisc + tmp;
  // aggiunge codice catastale
  Cod_Fisc:= Cod_Fisc + CodCat;
  // trasforma eventuali spazi in zeri
  // Clipper - do zerpad with cod_fisc
  // calcola il carattere di controllo
  c_contr:=calc_chk(Cod_Fisc);
  if c_contr = 'errore' then
   exit
  else
    begin
    Cod_Fisc:=Cod_Fisc + c_contr;
    Result:=Cod_Fisc;
    end;
end;

procedure TA002FAnagrafeGestPadre.actlstExecute(Sender: TObject);
{Ricerca il record specificato}
var
  DecorrenzaSave,ScadenzaSave:TDateTime;
  ProgSave:Integer;
begin
  if Sender = actRicerca then
    A002FAnagrafeDtM1.CercaAnagrafe
  else if Sender = actPrimo then
    A002FAnagrafeDtM1.QVista.First
  else if Sender = actPrecedente then
    A002FAnagrafeDtM1.QVista.Prior
  else if Sender = actSuccessivo then
    A002FAnagrafeDtM1.QVista.Next
  else if Sender = actUltimo then
    A002FAnagrafeDtM1.QVista.Last
  else if Sender = actInserisci then
  begin
    //FlagSto.Checked:=False; //LORENA 07/02/2005
    //FlagSto.Enabled:=False; //LORENA 14/07/2005
    btnStoricizza.Enabled:=False;
    //Decorrenza.Enabled:=True;
    A002FAnagrafeDtM1.Q030.Append;
    PageControl1.ActivePage:=TabSheet1;
    A002FAnagrafeDtM1.D030.DataSet.Fields[0].FocusControl;
  end
  else if Sender = actModifica then
  begin
    //FlagSto.Checked:=False;
    //FlagSto.Enabled:=Parametri.Storicizzazione = 'S'; //LORENA 14/07/2005
    btnStoricizza.Enabled:=Parametri.Storicizzazione = 'S';
    //Decorrenza.Enabled:=False; //LORENA 07/02/2005
    A002FAnagrafeDtM1.Q030.Edit;
  end
  else if Sender = actCancella then
  begin
    with A002FAnagrafeDtM1 do
      //Controllo che non si stia cancellando l'unico record presente
      if cmbDateDecorrenza.Items.Count = 1 then
        ShowMessage(A000MSG_A002_ERR_DEL_UNICA_DECORRENZA)
      else if cmbDateDecorrenza.Items.Count > 1 then
      begin
        if MessageDlg('Confermi la cancellazione del periodo storico dal ' + Q430.FieldByName('DATADECORRENZA').AsString + ' al ' + Q430.FieldByName('DATAFINE').AsString + '?', mtInformation, [mbYes, mbNo], 0) = mrYes then
        begin
          ProgSave:=Q430PROGRESSIVO.AsInteger;
          DecorrenzaSave:=Q430DATADECORRENZA.AsDateTime;
          ScadenzaSave:=Q430DATAFINE.AsDateTime;
          //Se non mi trovo sul primo periodo storico...
          if DecorrenzaSave <> StrToDate(cmbDateDecorrenza.Items[0]) then
          begin
            //...lo cancello, mi sposto su quello precedente e ne aggiorno la scadenza...
            RegistraLog.SettaProprieta('C',R180Query2NomeTabella(Q430),Copy(Self.Name,1,4),Q430,False);
            Q430.Delete;
            RegistraLog.RegistraOperazione;
            SessioneOracle.ApplyUpdates([Q430],True);
            SessioneOracle.Commit;
            ChiamaStorico(ProgSave,DecorrenzaSave - 1);
            Q430.Edit;
            Q430DATAFINE.AsDateTime:=ScadenzaSave;
            Q430.Post;
            SessioneOracle.ApplyUpdates([Q430],True);
            SessioneOracle.Commit;
            if not A002FAnagrafeMW.AggiornaPeriodiStorici  then
              R180MessageBox(A000MSG_A002_ERR_DIP_IN_USO,ERRORE);

            SessioneOracle.ApplyUpdates([Q430],True);
            SessioneOracle.Commit;
            ChiamaStorico(ProgSave,DecorrenzaSave);
            GetDateDecorrenza;
          end
          else
          //Se mi trovo sul primo periodo storico...
          begin
            //...mi sposto su quello successivo...
            Q430.Close;
            Q430.SetVariable('DataLav',ScadenzaSave + 1);
            Q430.Open;
            if (not Q430INIZIO.IsNull) and (Q430INIZIO.AsDateTime < Q430DATADECORRENZA.AsDateTime) then
            begin
              //...verifico che la decorrenza successiva sia maggiore o uguale all'inizio rapporto...
              ChiamaStorico(ProgSave,DecorrenzaSave);
              ShowMessage(A000MSG_A002_ERR_DEL_INIZIO_RAPPORTO)
            end
            else
            begin
              if A002FAnagrafeMW.CountAnagraficheStipendiali(ProgSave, DecorrenzaSave + 1,Q430DATADECORRENZA.AsDateTime) > 0 then
              begin
                //...verifico che non esistano periodi storici stipendiali nel periodo di traslazione della decorrenza...
                ChiamaStorico(ProgSave,DecorrenzaSave);
                ShowMessage(Format(A000MSG_A002_ERR_FMT_DEL_STIPENDIALI,[DateToStr(A002FAnagrafeMW.selP430_count.GetVariable('DATA_OLD')),DateToStr(A002FAnagrafeMW.selP430_count.GetVariable('DATA_NEW'))]));
              end
              else
              begin
                //...torno sul primo periodo, lo cancello e mi posiziono sul nuovo primo periodo...
                Q430.Close;
                Q430.SetVariable('DataLav',DecorrenzaSave);
                Q430.Open;
                RegistraLog.SettaProprieta('C',R180Query2NomeTabella(Q430),Copy(Self.Name,1,4),Q430,False);
                Q430.Delete;
                RegistraLog.RegistraOperazione;
                SessioneOracle.ApplyUpdates([Q430],True);
                SessioneOracle.Commit;
                ChiamaStorico(ProgSave,ScadenzaSave + 1);
                //Aggiorno la minima data decorrenza stipendiale, in modo che la Allinea_Periodi_Storici non annulli la posticipazione
                A002FAnagrafeMW.updP430.SetVariable('DATA_NEW',R180InizioMese(Q430DATADECORRENZA.AsDateTime));
                A002FAnagrafeMW.updP430.SetVariable('PROGRESSIVO',ProgSave);
                A002FAnagrafeMW.updP430.Execute;
                if not A002FAnagrafeMW.AggiornaPeriodiStorici  then
                  R180MessageBox(A000MSG_A002_ERR_DIP_IN_USO,ERRORE);

                SessioneOracle.ApplyUpdates([Q430],True);
                SessioneOracle.Commit;
                ChiamaStorico(ProgSave,ScadenzaSave + 1);
                GetDateDecorrenza;
              end;
            end;
          end;
        end;
      end;
  end
  else if Sender = actConferma then
  begin
    if Trim(A002FAnagrafeDtM1.Q030.FieldByName('Matricola').AsString) <> '' then
    try
      PageControl1.SetFocus;
      A002FAnagrafeDtM1.Q030.Post;
      //Decorrenza.Enabled:=False;
      //Compatta ed espande i periodi storici considerando anche gli storici dei dati liberi
      //AggiornaPeriodiStorici;
    except
      raise;
    end
    else
      ShowMessage('E'' richiesta almeno la matricola');
  end
  else if Sender = actAnnulla then
  begin
    A002FAnagrafeDtM1.Q030.Cancel;
    //Decorrenza.Enabled:=False; //LORENA 07/02/2005
    //Compatta ed espande i periodi storici considerando anche gli storici dei dati liberi
    //AggiornaPeriodiStorici;
    A002FAnagrafeDtM1.GetDateDecorrenza;
  end
  else if Sender = actStampa then
    StampaAnagrafe
  else if Sender = actEsci then
     Hide
  else if Sender = actStoricoPrecedente then
    A002FAnagrafeDtM1.ChiamaStorico(A002FAnagrafeDtM1.Q430PROGRESSIVO.AsInteger,A002FAnagrafeDtM1.Q430DATADECORRENZA.AsDateTime - 1)
  else if Sender = actStoricoSuccessivo then
    A002FAnagrafeDtM1.ChiamaStorico(A002FAnagrafeDtM1.Q430PROGRESSIVO.AsInteger,A002FAnagrafeDtM1.Q430DATAFINE.AsDateTime + 1)
  else if Sender = actGomma then
    AbblencaCampo;
  if A002FAnagrafeDtM1.Q030.State = dsInsert then  //LORENA 07/02/2005
    dedtDecorrenzaExit(nil)
  else
    A002FAnagrafeDtM1.RinfrescaQueryDescrizioni(A002FAnagrafeDtM1.Q430.FieldByName('DATAFINE').AsDateTime);
  //A002FAnagrafeVista.StatusBar.Panels[2].Text:=Format('Anagr. %d/%d',[A002FAnagrafeDtM1.Q030.RecNo,A002FAnagrafeDtM1.Q030.RecordCount]);
  actAnagraficoStipendi.Enabled:=not (A002FAnagrafeDtM1.Q030.State in [dsEdit,dsInsert]);
end;

procedure TA002FAnagrafeGestPadre.FormDeactivate(Sender: TObject);
{Inibisce l'abbandono della finestra se non si è in Browse mode}
begin
  if not actPrimo.Enabled then
    Show;
end;

procedure TA002FAnagrafeGestPadre.StampaAnagrafe;
var CampiAbilitati,
    CampiVisualizzatiOriginali,
    CampiSelezionatiOriginali:String;
begin
  try
    CampiVisualizzatiOriginali:=C700DatiVisualizzati;
    CampiSelezionatiOriginali:=C700DatiSelezionati;
    C001SetNomeForm(TForm(Screen.ActiveForm).Name);
    C001FFiltroTabelle:=TC001FFiltroTabelle.Create(nil);
    C001FFiltroTabelleDTM:=TC001FFiltroTabelleDTM.Create(nil);
    C001FScegliCampi:=TC001FScegliCampi.Create(nil);
    C001FFiltroTabelle.DataLavoro:=Parametri.DataLavoro;
    A002FAnagrafeVista.frmSelAnagrafe.SalvaC00SelAnagrafe;
    CampiAbilitati:=A002FAnagrafeVista.frmSelAnagrafe.GetCampiAbilitatiC700;
    C700Distruzione;
    C700Progressivo:=A002FAnagrafeVista.frmSelAnagrafe.OldC700Progressivo;
    C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
    C700DatiSelezionati:=CampiAbilitati;//C700TuttiCampi;
    C001FFiltroTabelle.frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
    C001FFiltroTabelle.frmSelAnagrafe.RipristinaC700SelAnagrafeBridge;
    AssegnaQuery(C700SrcAnagrafe);
  finally
    C001FScegliCampi.Release;
    C001FFiltroTabelleDTM.Free;
    C001FFiltroTabelle.Release;
    C700Distruzione;
    C700DatiVisualizzati:=CampiVisualizzatiOriginali;
    C700DatiSelezionati:=CampiSelezionatiOriginali;
    C700Creazione(SessioneOracle);
    C700OldProgressivo:=-1;
    A002FAnagrafeVista.frmSelAnagrafe.RipristinaC00SelAnagrafe;
  end;
end;

procedure TA002FAnagrafeGestPadre.Stampavideata1Click(Sender: TObject);
var BmpForm,BmpDesktop:TBitmap;
  procedure ScreenShot(activeWindow: bool; destBitmap : TBitmap) ;
  var
     w,h : integer;
     DC : HDC;
     hWin : Cardinal;
     r : TRect;
  begin
     if activeWindow then
     begin
       hWin := GetForegroundWindow;
       dc := GetWindowDC(hWin) ;
       GetWindowRect(hWin,r) ;
       w := r.Right - r.Left;
       h := r.Bottom - r.Top;
     end
     else
     begin
       hWin := GetDesktopWindow;
       dc := GetDC(hWin) ;
       w := GetDeviceCaps (DC, HORZRES) ;
       h := GetDeviceCaps (DC, VERTRES) ;
     end;

     try
      destBitmap.Width := w;
      destBitmap.Height := h;
      BitBlt(destBitmap.Canvas.Handle,
             0,
             0,
             destBitmap.Width,
             destBitmap.Height,
             DC,
             0,
             0,
             SRCCOPY) ;
     finally
      ReleaseDC(hWin, DC) ;
     end;
  end;
  procedure Stampa;
  var
    aInfo,bInfo:PBitmapInfo;
    aInfoSize,bInfoSize:Cardinal;
    aImage,bImage:Pointer;
    aImageSize,bImageSize:Cardinal;
    w,h,ph,pw:extended;
  begin
    //Le variabili che iniziano con "a" sono relative alla BmpForm
    //Le variabili che iniziano con "b" sono relative alla BmpDesktop
    with BmpForm do
    begin
      //Reperisco l'intestazione Info e la Dimensione dell'immagine BmpForm
      GetDIBSizes(Handle,aInfoSize,aImageSize);
      //Allocco la memoria per l'intestazione Info dell'immagine BmpForm
      GetMem(aInfo,aInfoSize);
      try
        //Allocco la memoria per l'immagine BmpForm
        GetMem(aImage,aImageSize);
        try
          //Recupero i bit, la palette e l'intestazione Info dell'immagine BmpForm
          GetDIB(Handle,Palette,aInfo^,aImage^);
          //
          //Reperisco l'intestazione Info e la Dimensione dell'immagine BmpDesktop
          GetDIBSizes(BmpDesktop.Handle,bInfoSize,bImageSize);
          //Allocco la memoria per l'intestazione Info dell'immagine BmpDesktop
          GetMem(bInfo,bInfoSize);
          try
            //Allocco la memoria per l'immagine BmpDesktop
            GetMem(bImage,bImageSize);
            try
              //Recupero i bit, la palette e l'intestazione Info dell'immagine BmpDesktop
              GetDIB(BmpDesktop.Handle,BmpDesktop.Palette,bInfo^,bImage^);
              //Calcolo le proporzioni di altezza e larghezza tra BmpForm e BmpDesktop
              ph:=aInfo^.bmiHeader.biHeight / bInfo^.bmiHeader.biHeight;
              pw:=aInfo^.bmiHeader.biWidth / bInfo^.bmiHeader.biWidth;
            finally
              FreeMem(bImage,bImageSize);
            end;
          finally
            FreeMem(bInfo,bInfoSize);
          end;
          //
          with aInfo^.bmiHeader do
          begin
            Printer.BeginDoc;
            //Se stampa Verticale
            if Printer.PageWidth < Printer.PageHeight then
            begin
              //Calcolo le dimensioni proporzionate considerando i margini in pixel
              w:=(Printer.PageWidth - 100) * pw;
              h:=biHeight / biWidth * w;
              //Se l'altezza proporzionata esce dal foglio, ricalcolo le dimensioni
              if h > (Printer.PageHeight - 100) then
              begin
                h:=(Printer.PageHeight - 100) * ph;
                w:=biWidth / biHeight * h;
              end;
            end
            //Se stampa Orizzontale
            else
            begin
              //Calcolo le dimensioni proporzionate considerando i margini in pixel
              h:=(Printer.PageHeight - 100) * ph;
              w:=biWidth / biHeight * h;
              //Se la larghezza proporzionata esce dal foglio, ricalcolo le dimensioni
              if w > (Printer.PageWidth - 100) then
              begin
                w:=(Printer.PageWidth - 100) * pw;
                h:=biHeight / biWidth * w;
              end;
            end;
            //Effettuo la stampa dell'immagine impostando il top e il left (metà dei margini precedentemente considerati)
            try
              StretchDIBits(Printer.Canvas.Handle,
                            50,50,Trunc(w),Trunc(h),
                            0,0,biWidth,biHeight,
                            aImage,aInfo^,DIB_RGB_COLORS,SRCCOPY);
            finally
              Printer.EndDoc;
            end;
          end;
        finally
          FreeMem(aImage,aImageSize);
        end;
      finally
        FreeMem(aInfo,aInfoSize);
      end;
    end;
  end;
begin
  if PrinterSetupDialog1.Execute then
  try
    Self.Refresh;
    //Ricavo lo screen shot della form attiva
    BmpForm:=TBitmap.Create;
    ScreenShot(TRUE, BmpForm);
    //Ricavo lo screen shot del desktop
    BmpDesktop:=TBitmap.Create;
    ScreenShot(FALSE, BmpDesktop);
    //Lancio la procedura di stampa
    Stampa;
  finally
    BmpForm.FreeImage;
    FreeAndNil(BmpForm);
    BmpDesktop.FreeImage;
    FreeAndNil(BmpDesktop);
  end;
end;

procedure TA002FAnagrafeGestPadre.ApriQBadgeLibero;
{Apro la query per la ricerca del badge libero}
var DD,DF:TDateTime;
begin
  with A002FAnagrafeDtM1.A002FAnagrafeMW.QBadgeLibero do
    begin
    Close;
    DD:=A002FAnagrafeDtM1.Q430DataDecorrenza.AsDateTime;
    DF:=A002FAnagrafeDtM1.Q430DataFine.AsDateTime;
    //if (FlagSto.Checked) or (DD = 0) then
    (*if (A002FAnagrafeDtM1.InterfacciaA002.StoricizzazioneInCorso) or (DD = 0) then
      try
        //DD:=StrToDate(Decorrenza.Text);
      except
        DD:=A002FAnagrafeDtM1.Q430DataDecorrenza.AsDateTime;
      end;*)
    if DD > DF then
      DF:=EncodeDate(3999,12,31);
    SetVariable('Dal',DD);
    SetVariable('Al',DF);
    Open;
    end;
end;

procedure TA002FAnagrafeGestPadre.CercaBadgeLibero(i:LongInt);
{Cerco il primo buco libero tra i badge}
begin
  Screen.Cursor:=crHourGlass;
  if i = 0 then
  begin
    A002FAnagrafeDtM1.A002FAnagrafeMW.QBadgeLibero.Last;
    A002FAnagrafeDtM1.Q430Badge.AsInteger:=A002FAnagrafeDtM1.A002FAnagrafeMW.QBadgeLibero.FieldByName('BADGE').AsInteger + 1;
  end
  else
  begin
    while A002FAnagrafeDtM1.A002FAnagrafeMW.QBadgeLibero.SearchRecord('BADGE',i,[srFromBeginning]) do
      inc(i);
    A002FAnagrafeDtM1.Q430Badge.AsInteger:=i;
  end;
  Screen.Cursor:=crDefault;
end;

procedure TA002FAnagrafeGestPadre.EditBadgeDblClick(Sender: TObject);
{DoppioClick sul Badge:Ricerco successivo Badge libero}
begin
  if not(A002FAnagrafeDtM1.Q430.State in [dsInsert,dsEdit]) then exit;
  with A002FAnagrafeDtM1 do
  begin
    ApriQBadgeLibero;
    CercaBadgeLibero(StrToIntDef(EditBadge.Text,0) + 1);
  end;
end;

procedure TA002FAnagrafeGestPadre.EditBadgeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
{Ricerca primo badge libero a partire da 1 o dopo max badge inserito}
begin
  if ((Key = 65) or (Key = 90)) and (Shift = [ssCtrl]) and (A002FAnagrafeDtM1.Q430.State in [dsInsert,dsEdit]) then
  begin
    ApriQBadgeLibero;
    //Premendo Ctrl + A ricerco primo badge libero a partire da 1
    if key = 65 then
      CercaBadgeLibero(1)
    else
    //Premendo Ctrl + Z ricerco primo badge libero dopo max badge inserito
      CercaBadgeLibero(0);
  end;
end;

procedure TA002FAnagrafeGestPadre.EI060EMailDblClick(Sender: TObject);
begin
  if A002FAnagrafeDtM1.Q030.FieldByName('I060EMail').AsString <> '' then
    ShellExecute(0,'open', pchar('mailto:'+ A002FAnagrafeDtM1.Q030.FieldByName('I060EMail').AsString), NIL, NIL, SW_SHOWNORMAL);
end;

procedure TA002FAnagrafeGestPadre.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
{Chiude solo se si è in Browse mode}
begin
  if actPrimo.Enabled then
    Hide
  else
    CanClose:=False;
end;

procedure TA002FAnagrafeGestPadre.FormHide(Sender: TObject);
{Alza il pulsante SCHEDA}
begin
  A002FAnagrafeVista.actSchedaAnagrafica.Checked:=False;
end;

procedure TA002FAnagrafeGestPadre.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  (*R180PutRegistro(HKEY_CURRENT_USER,'A002','Height',IntToStr(Height));
  R180PutRegistro(HKEY_CURRENT_USER,'A002','Width',IntToStr(Width));
  R180PutRegistro(HKEY_CURRENT_USER,'A002','WindowState',IntToStr(Ord(WindowState)));*)
end;

procedure TA002FAnagrafeGestPadre.FormDestroy(Sender: TObject);
var i:Integer;
begin
  for i:=PageControl1.PageCount - 1 downto 0 do
    if (PageControl1.Pages[i].Caption <> 'Dati anagrafici') and
       (PageControl1.Pages[i].Caption <> 'Parametri orario') and
       (PageControl1.Pages[i].Caption <> 'Presenze/Assenze') then
      PageControl1.Pages[i].Free;
end;

procedure TA002FAnagrafeGestPadre.btnSceltaAssenzeClick(Sender: TObject);
var
  LVal: String;
begin
  if A002FAnagrafeDtM1.D430.State in [dsEdit,dsInsert] then
  begin
    C013FCheckList:=TC013FCheckList.Create(nil);
    try
      C013FCheckList.clbListaDati.Items.Assign(A002FAnagrafeDtM1.ListaAssenze);
      R180PutCheckList(dedtAssenzeAbilitate.Field.AsString,5,C013FCheckList.clbListaDati);
      if (C013FCheckList.ShowModal = mrOK) and (not dedtAssenzeAbilitate.Field.ReadOnly) then
      begin
        LVal:=R180GetCheckList(5,C013FCheckList.clbListaDati);
        if LVal.Length > dedtAssenzeAbilitate.Field.Size  then
          R180MessageBox(Format(A000TraduzioneStringhe(A000MSG_A002_DLG_FMT_FIELD_SIZE),[LVal.Length - dedtAssenzeAbilitate.Field.Size]),ESCLAMA)
        else
          dedtAssenzeAbilitate.Field.AsString:=LVal;
      end;
    finally
      C013FCheckList.Free;
    end;
  end;
end;

procedure TA002FAnagrafeGestPadre.btnSceltaPresenzeClick(Sender: TObject);
var
  LVal: String;
begin
  if A002FAnagrafeDtM1.D430.State in [dsEdit,dsInsert] then
  begin
    C013FCheckList:=TC013FCheckList.Create(nil);
    try
      C013FCheckList.clbListaDati.Items.Assign(A002FAnagrafeDtM1.ListaPresenze);
      R180PutCheckList(dedtPresenzeAbilitate.Field.AsString,5,C013FCheckList.clbListaDati);
      if (C013FCheckList.ShowModal = mrOK) and (not dedtPresenzeAbilitate.Field.ReadOnly) then
      begin
        LVal:=R180GetCheckList(5,C013FCheckList.clbListaDati);
        if LVal.Length > dedtAssenzeAbilitate.Field.Size  then
          R180MessageBox(Format(A000TraduzioneStringhe(A000MSG_A002_DLG_FMT_FIELD_SIZE),[LVal.Length - dedtAssenzeAbilitate.Field.Size]),ESCLAMA)
        else
          dedtPresenzeAbilitate.Field.AsString:=LVal;
      end;
    finally
      C013FCheckList.Free;
    end;
  end;
end;

procedure TA002FAnagrafeGestPadre.btnStoricizzaClick(Sender: TObject);
begin
  with A002FAnagrafeDtM1 do
  begin
    actAnagraficoStipendi.Enabled:=False;
    StoricizzazioneInCorso:=True;
    Q030.Edit;
    D430.DataSet.FieldByName('DATADECORRENZA').Clear;
    D430.DataSet.FieldByName('DATADECORRENZA').FocusControl;
  end;
end;

procedure TA002FAnagrafeGestPadre.cmbDateDecorrenzaChange(Sender: TObject);
begin
  A002FAnagrafeDtM1.ChiamaStorico(A002FAnagrafeDtM1.Q430PROGRESSIVO.AsInteger,StrToDate(cmbDateDecorrenza.Text));
end;

procedure TA002FAnagrafeGestPadre.drgpTipoLocalitaDistLavoroChange(
  Sender: TObject);
var S:String;
begin
  with A002FAnagrafeDtM1 do
  begin
    if (not Q430.Active) or (drgpTipoLocalitaDistLavoro.ItemIndex = -1) then
      exit;
    if Q430.State in [dsEdit,dsInsert] then
      Q430.FieldByName('COD_LOCALITA_DIST_LAVORO').AsString:='';
    if drgpTipoLocalitaDistLavoro.ItemIndex = 0 then
    begin
      S:='SELECT CODICE, CITTA DESCRIZIONE FROM T480_COMUNI ORDER BY CITTA';
      dcmbLocalitaDistLavoro.Tag:=1;
    end
    else
    begin
      S:='SELECT CODICE, DESCRIZIONE FROM M042_LOCALITA ORDER BY DESCRIZIONE';
      dcmbLocalitaDistLavoro.Tag:=-1;
    end;
    if Trim(SelLocalita.SQL.Text) <> Trim(S) then
    begin
      SelLocalita.Close;
      SelLocalita.SQL.Text:=S;
    end;
    SelLocalita.Open;
    RefreshLookupCache(SelLocalita);
  end;
end;

procedure TA002FAnagrafeGestPadre.Nuovamatricola1Click(Sender: TObject);
begin
  with A002FAnagrafeDtM1 do
  begin
    A002FAnagrafeMW.GetNuovaMatricola.Execute;
    Q030.FieldByName('MATRICOLA').AsString:=VarToStr(A002FAnagrafeMW.GetNuovaMatricola.GetVariable('MATRICOLA'));
  end;
end;

procedure TA002FAnagrafeGestPadre.actModificaPrimaDecExecute(
  Sender: TObject);
begin
  A002FBadgeMsg:=TA002FBadgeMsg.Create(nil);
  try
    A002FBadgeMsg.Caption:='<A002> Nuova data decorrenza';
    A002FBadgeMsg.memo1.Visible:=False;
    A002FBadgeMsg.btnCancel.Visible:=True;
    if A002FBadgeMsg.ShowModal = mrOK then
      with A002FAnagrafeDtM1 do
      begin
        if not A002FAnagrafeMW.AggiornaPeriodiStorici  then
          R180MessageBox(A000MSG_A002_ERR_DIP_IN_USO ,ERRORE);
        QVistaAfterScroll(QVista);
      end;
  finally
    A002FBadgeMsg.Release;
  end;
end;

procedure TA002FAnagrafeGestPadre.actAnagraficoStipendiExecute(
  Sender: TObject);
var
  DataSave:TDateTime;
begin
  A002FAnagrafeVistaPadre.actAnagraficoStipendiExecute(A002FAnagrafeVistaPadre.actAnagraficoStipendi);
  with A002FAnagrafeDtM1 do
  begin
    DataSave:=Q430DATADECORRENZA.AsDateTime;
    Q430.Refresh;
    GetDateDecorrenza;
    ChiamaStorico(Q430PROGRESSIVO.AsInteger,DataSave);
  end;
end;

procedure TA002FAnagrafeGestPadre.actCdcPercentExecute(Sender: TObject);
begin
  A002FAnagrafeVistaPadre.actCdcPercentExecute(A002FAnagrafeVistaPadre.actCdcPercent);
end;

procedure TA002FAnagrafeGestPadre.actCercaCampoExecute(Sender: TObject);
var i,j,k,x,jLayout,jLinkComp,PIMin,PIMax:Integer;
    SL:TStringList;
    ElencoCampiTemp:array of TElencoCampi;
begin
  if InputQuery('Ricerca per testo contenuto','Nome campo',DatoSearch) then
  begin
    DatoSearch:=Trim(DatoSearch);
    A002FAnagrafeDtM1.QI010.Open;
    A002FCercaCampo:=TA002FCercaCampo.Create(Application);
    PIMin:=999;
    PIMax:=0;
    with A002FLayout do
      for i:=0 to High(Layout) do
        if not (Layout[i].LinkComp[0] = nil) then
          if Layout[i].LinkComp[0].Visible then
          begin
            //Per ogni campo visibile, prendo i dati necessari
            SetLength(A002FCercaCampo.ElencoCampi,Length(A002FCercaCampo.ElencoCampi) + 1);
            j:=High(A002FCercaCampo.ElencoCampi);
            A002FCercaCampo.ElencoCampi[j].iLayout:=i;
            A002FCercaCampo.ElencoCampi[j].iLinkComp:=0;
            if Layout[i].LinkComp[0] is TLabel then
            begin
              A002FCercaCampo.ElencoCampi[j].Etichetta:=TLabel(Layout[i].LinkComp[0]).Caption;
              if Layout[i].LinkComp[1] is TDBEdit then
                A002FCercaCampo.ElencoCampi[j].NomeDato:=IfThen(TDBEdit(Layout[i].LinkComp[1]).DataSource = A002FAnagrafeDtM1.D430,'T430') + TDBEdit(Layout[i].LinkComp[1]).Field.FieldName
              else if Layout[i].LinkComp[1] is TDBLookupComboBox then
                A002FCercaCampo.ElencoCampi[j].NomeDato:=IfThen(TDBLookupComboBox(Layout[i].LinkComp[1]).DataSource = A002FAnagrafeDtM1.D430,'T430') + TDBLookupComboBox(Layout[i].LinkComp[1]).Field.FieldName;
              A002FCercaCampo.ElencoCampi[j].iLinkComp:=1;
            end
            else if Layout[i].LinkComp[0] is TDBRadioGroup then
            begin
              A002FCercaCampo.ElencoCampi[j].Etichetta:=TDBRadioGroup(Layout[i].LinkComp[0]).Caption;
              A002FCercaCampo.ElencoCampi[j].NomeDato:=IfThen(TDBRadioGroup(Layout[i].LinkComp[0]).DataSource = A002FAnagrafeDtM1.D430,'T430') + TDBRadioGroup(Layout[i].LinkComp[0]).Field.FieldName;
            end
            else if Layout[i].LinkComp[0] is TDBCheckBox then
            begin
              A002FCercaCampo.ElencoCampi[j].Etichetta:=TDBCheckBox(Layout[i].LinkComp[0]).Caption;
              A002FCercaCampo.ElencoCampi[j].NomeDato:=IfThen(TDBCheckBox(Layout[i].LinkComp[0]).DataSource = A002FAnagrafeDtM1.D430,'T430') + TDBCheckBox(Layout[i].LinkComp[0]).Field.FieldName;
            end;
            A002FCercaCampo.ElencoCampi[j].Ridefinito:=VarToStr(A002FAnagrafeDtM1.QI010.Lookup('NOME_CAMPO',A002FCercaCampo.ElencoCampi[j].NomeDato,'NOME_LOGICO'));
            A002FCercaCampo.ElencoCampi[j].Pagina:=TTabSheet(Layout[i].Parent).Caption;
            A002FCercaCampo.ElencoCampi[j].PageIndex:=TTabSheet(Layout[i].Parent).PageIndex;
            //Se il testo non è contenuto in nessun nome del campo, cancello i dati appena prelevati
            if (Pos(UpperCase(DatoSearch),UpperCase(A002FCercaCampo.ElencoCampi[j].Etichetta)) = 0)
            and (Pos(UpperCase(DatoSearch),UpperCase(A002FCercaCampo.ElencoCampi[j].NomeDato)) = 0)
            and (Pos(UpperCase(DatoSearch),UpperCase(A002FCercaCampo.ElencoCampi[j].Ridefinito)) = 0) then
              SetLength(A002FCercaCampo.ElencoCampi,Length(A002FCercaCampo.ElencoCampi) - 1)
            else
            begin
              PIMin:=Min(PIMin,A002FCercaCampo.ElencoCampi[j].PageIndex);
              PIMax:=Max(PIMax,A002FCercaCampo.ElencoCampi[j].PageIndex);
            end;
          end;
    with A002FCercaCampo do
      try
        if High(ElencoCampi) < 0 then
          ShowMessage(Format(A000MSG_A002_ERR_FMT_CERCA_NO_CAMPO,[DatoSearch]))
        else
        begin
          if High(ElencoCampi) = 0 then
            Dato:=ElencoCampi[0].NomeDato
          else
          begin
            Caption:=Caption + ' contenente "' + DatoSearch + '"';
            //Inizializzo l'elenco d'appoggio per l'ordinamento
            SetLength(ElencoCampiTemp,Length(ElencoCampi));
            x:=0;
            //Carico e ordino l'elenco dei campi
            SL:=TStringList.Create;
            for j:=0 to High(ElencoCampi) do
              SL.Add(ElencoCampi[j].NomeDato);
            SL.Sort;
            //Carico l'elenco d'appoggio, ordinando...
            for i:=PIMin to PIMax do //...per PageIndex...
              for k:=0 to SL.Count - 1 do//...e poi per NomeDato
                for j:=0 to High(ElencoCampi) do
                  if (ElencoCampi[j].PageIndex = i)
                  and (ElencoCampi[j].NomeDato = SL[k]) then
                  begin
                    ElencoCampiTemp[x]:=ElencoCampi[j];
                    inc(x);
                    Break;
                  end;
            SL.Free;
            //Ricarico l'elenco originale con i dati dell'elenco d'appoggio ordinato
            SetLength(ElencoCampi,0);
            SetLength(ElencoCampi,Length(ElencoCampiTemp));
            for j:=0 to High(ElencoCampi) do
            begin
              ElencoCampi[j]:=ElencoCampiTemp[j];
              if j > 0 then
                ElencoCampi[j].Colore:=not ElencoCampi[j - 1].Colore;
            end;
            SetLength(ElencoCampiTemp,0);
            //Carico l'elenco nella griglia
            Grid.RowCount:=2;
            for j:=0 to High(ElencoCampi) do
            begin
              Grid.RowCount:=j + 2;
              Grid.Cells[0,j + 1]:=ElencoCampi[j].Etichetta;
              Grid.Cells[1,j + 1]:=ElencoCampi[j].NomeDato;
              Grid.Cells[2,j + 1]:=ElencoCampi[j].Ridefinito;
              Grid.Cells[3,j + 1]:=ElencoCampi[j].Pagina;
            end;
            ShowModal;
          end;
          if Dato <> '' then
          begin
            //Prelevo gli indici per posizionarmi sul campo selezionato
            for j:=0 to High(ElencoCampi) do
              if ElencoCampi[j].NomeDato = Dato then
              begin
                jLayout:=ElencoCampi[j].iLayout;
                jLinkComp:=ElencoCampi[j].iLinkComp;
                Break;
              end;
            PageControl1.ActivePageIndex:=TTabSheet(A002FLayout.Layout[jLayout].Parent).PageIndex;
            TWinControl(A002FLayout.Layout[jLayout].LinkComp[jLinkComp]).SetFocus;
            if A002FLayout.Layout[jLayout].LinkComp[jLinkComp] is TDBRadioGroup then
              if TDBRadioGroup(A002FLayout.Layout[jLayout].LinkComp[jLinkComp]).ItemIndex <> -1 then
                TDBRadioGroup(A002FLayout.Layout[jLayout].LinkComp[jLinkComp]).Buttons[TDBRadioGroup(A002FLayout.Layout[jLayout].LinkComp[jLinkComp]).ItemIndex].SetFocus
              else
                TDBRadioGroup(A002FLayout.Layout[jLayout].LinkComp[jLinkComp]).Buttons[0].SetFocus;
          end;
        end;
      finally
        Release;
      end;
  end;
end;

procedure TA002FAnagrafeGestPadre.actFotoDipendenteExecute(Sender: TObject);
begin
  with A002FAnagrafeDtM1.QVista do
    if FieldByName('PROGRESSIVO').AsInteger > 0 then
      OpenA146FotoDipendente(FieldByName('PROGRESSIVO').AsInteger,FieldByName('MATRICOLA').AsString,FieldByName('COGNOME').AsString,FieldByName('NOME').AsString);
end;

procedure TA002FAnagrafeGestPadre.dcmbKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    if (Sender as TDBLookupComboBox).Field = nil then
      (Sender as TDBLookupComboBox).KeyValue:=null
    else if (not (Sender as TDBLookupComboBox).Field.ReadOnly) and ((Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert]) then
    begin
      (Sender as TDBLookupComboBox).KeyValue:=null;
      (Sender as TDBLookupComboBox).Field.Clear;
    end;
  end;
end;

procedure TA002FAnagrafeGestPadre.dedtDecorrenzaExit(Sender: TObject);
begin
  if A002FAnagrafeDtM1.Q030.State in [dsInsert,dsEdit] then
    A002FAnagrafeDtM1.RinfrescaQueryDescrizioni(A002FAnagrafeDtM1.Q430.FieldByName('DATADECORRENZA').AsDateTime);
end;

end.

