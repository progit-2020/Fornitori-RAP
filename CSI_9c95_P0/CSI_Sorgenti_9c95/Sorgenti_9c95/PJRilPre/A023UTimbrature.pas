unit A023UTimbrature;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TABELLE99, Menus, ComCtrls, StdCtrls, ExtCtrls, Grids, Spin,
  DBCtrls, Buttons, DB, Variants, OracleData,
  R500Lin, Rp502Pro, R600, RegistrazioneLog, SelAnagrafe, QueryStorico, DatiBloccati,
  C005UDatiAnagrafici, C180FunzioniGenerali, C700USelezioneAnagrafe,
  Math, StrUtils, A000UMessaggi, A000UCostanti, A000USessione, A000UInterfaccia,
  A004UGiustifAssPres, A006UModelliOrario, A025UPianif, A027UCarMen, A028USc, A097UPianifLibProf,
  A023UValidaAssenze, B021UUtils,A000UGestioneTimbraGiustMW;

type
  TNomiGiorni = array[1..7] of String[10];

  TGriglie = record
    Timbrat,Giustif:TStringGrid;
    Giorno:TLabel;
    Pianif:TLabel;
    Orario:TEdit;
    Turni,
    OreLavorate,
    Scostamento,
    Debito,
    EscluseDaNorm:TLabel
  end;

  TTipoCausale = (tcNone,tcAssenza,tcPresenza,tcGiustificazione);

  TA023FTimbrature = class(TFrmTabelle99)
    pnlTop: TPanel;
    EMese: TSpinEdit;
    Label3: TLabel;
    EAnno: TSpinEdit;
    Label4: TLabel;
    ScrollBox3: TScrollBox;
    lblTimbrature: TLabel;
    lblGiustificativi: TLabel;
    BPrec: TBitBtn;
    BSucc: TBitBtn;
    Timbrature1: TMenuItem;
    Inserisci1: TMenuItem;
    Cancella1: TMenuItem;
    Modifica1: TMenuItem;
    Giustificativi1: TMenuItem;
    Inserisci2: TMenuItem;
    Modifica2: TMenuItem;
    SBConteggi: TSpeedButton;
    SpeedButton2: TSpeedButton;
    N2: TMenuItem;
    Pianiforari1: TMenuItem;
    grpLegenda: TGroupBox;
    Label5: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    PopupMenu1: TPopupMenu;
    Inserisci3: TMenuItem;
    Modifica3: TMenuItem;
    Cancella2: TMenuItem;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem3: TMenuItem;
    btnConteggiDiServizio: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpMese: TSpeedButton;
    SpCorrezione: TSpeedButton;
    N3: TMenuItem;
    Ripristinotimbratureoriginali1: TMenuItem;
    Correzionetimbrature1: TMenuItem;
    CompetenzeResidui1: TMenuItem;
    Allineamentotimbratureuguali1: TMenuItem;
    N4: TMenuItem;
    PopupMenu3: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    AggiornaControllo1: TMenuItem;
    AggiornaDataControllo1: TMenuItem;
    Eliminazionetimbratureriscaricate1: TMenuItem;
    Panel1: TPanel;
    frmSelAnagrafe: TfrmSelAnagrafe;
    Panel3: TPanel;
    LData: TLabel;
    Label23: TLabel;
    N5: TMenuItem;
    Conteggidiservizio1: TMenuItem;
    N6: TMenuItem;
    ConteggiDiServizio2: TMenuItem;
    ValidazioneTimbrature1: TMenuItem;
    Gestionemensile1: TMenuItem;
    Pianificazioneliberaprofessione1: TMenuItem;
    Validaassenze1: TMenuItem;
    pnlGiorniTimb: TPanel;
    GTimbrat1: TStringGrid;
    GTimbrat2: TStringGrid;
    GTimbrat3: TStringGrid;
    GTimbrat4: TStringGrid;
    GTimbrat5: TStringGrid;
    GTimbrat6: TStringGrid;
    LGiorno1: TLabel;
    LTurni1: TLabel;
    EOrario1: TEdit;
    LGiorno2: TLabel;
    LTurni2: TLabel;
    EOrario2: TEdit;
    LGiorno3: TLabel;
    LTurni3: TLabel;
    EOrario3: TEdit;
    LGiorno4: TLabel;
    LTurni4: TLabel;
    EOrario4: TEdit;
    LGiorno5: TLabel;
    LTurni5: TLabel;
    EOrario5: TEdit;
    LGiorno6: TLabel;
    LTurni6: TLabel;
    EOrario6: TEdit;
    pnlGiustCont: TPanel;
    pnlGiust: TPanel;
    GGiustif1: TStringGrid;
    GGiustif2: TStringGrid;
    GGiustif3: TStringGrid;
    GGiustif4: TStringGrid;
    GGiustif5: TStringGrid;
    GGiustif6: TStringGrid;
    PConteggi: TPanel;
    LOreLavorate1: TLabel;
    LScostamento1: TLabel;
    LOreLavorate2: TLabel;
    LScostamento2: TLabel;
    LOreLavorate3: TLabel;
    LScostamento3: TLabel;
    LOreLavorate4: TLabel;
    LScostamento4: TLabel;
    LOreLavorate5: TLabel;
    LScostamento5: TLabel;
    LOreLavorate6: TLabel;
    LScostamento6: TLabel;
    LDebito1: TLabel;
    LDebito2: TLabel;
    LDebito3: TLabel;
    LDebito4: TLabel;
    LDebito5: TLabel;
    LDebito6: TLabel;
    Splitter1: TSplitter;
    LCP1: TLabel;
    LCP2: TLabel;
    LCP3: TLabel;
    LCP4: TLabel;
    LCP5: TLabel;
    LCP6: TLabel;
    lblEscluseDaNorm1: TLabel;
    lblEscluseDaNorm2: TLabel;
    lblEscluseDaNorm3: TLabel;
    lblEscluseDaNorm4: TLabel;
    lblEscluseDaNorm5: TLabel;
    lblEscluseDaNorm6: TLabel;
    Accediamodificacausale1: TMenuItem;
    Accediamodificacausale2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure EMeseChange(Sender: TObject);
    procedure GTimbrat1DrawCell(Sender: TObject; Col, Row: Longint;
      Rect: TRect; State: TGridDrawState);
    procedure BPrecClick(Sender: TObject);
    procedure GestioneTimb(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GTimbrat1Enter(Sender: TObject);
    procedure GTimbrat1Exit(Sender: TObject);
    procedure GTimbrat1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SBConteggiClick(Sender: TObject);
    procedure EOrario1DblClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure ConteggiDiServizioClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure DoppioClickTimb(Sender: TObject);
    procedure GestisciKeyDownTimb(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DoppioClickGiust(Sender: TObject);
    procedure GestisciKeyDownGiust(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GestisciMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpMeseClick(Sender: TObject);
    procedure SpCorrezioneClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Ripristinotimbratureoriginali1Click(Sender: TObject);
    procedure Correzionetimbrature1Click(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure AggData(Data: TDateTime);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure ValidazioneTimbrature1Click(Sender: TObject);
    procedure Gestionemensile1Click(Sender: TObject);
    procedure Pianificazioneliberaprofessione1Click(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure Splitter1CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure GTimbrat2SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
    procedure PopupMenu1Popup(Sender: TObject);
  private
    Mese,Anno:Word;
    DisegnaGriglie,ShowOK:Boolean;
    AccessoA004,HintCausale:String;
    LAnomalie,LStorico:TStringList;  //Contiene la lista delle anomalie riscontrate
    OldGiustif,NewGiustif:TGiustificativo;
    Scala:Real;
    procedure PulisciGriglia;
    procedure ColoraCella(Griglia:TStringGrid;Rect:TRect;Color:TColor);
    procedure IncorniciaCella(Griglia:TStringGrid;Rect:TRect);
    procedure Calendario(Data:TDateTime;LGiorno:TLabel);
    procedure Orario(Data:TDateTime;EOrario:TEdit;LTurni:TLabel);
    procedure InsTimbratura(Data:TDateTime;Day,Col,MyTag:Byte);
    function CancTimbratura(Data:TDateTime;Day,Col:Byte):boolean;
    function ModTimbratura(Data:TDateTime;Day,Col:Byte):boolean;
    function InsCancGiustif(Data:TDateTime;Day,Col:Byte):boolean;
    function ModGiustif(Data:TDateTime;Day,Col:Byte):boolean;
    procedure Conteggi(Ind:Byte; Giorno:TDateTime);
    // procedure RipristinaOriginali(Inizio,Fine:TDateTime); // commessa MAN/02 - SVILUPPO 92
    procedure VisualizzaAssenze(Data:TDateTime; Day,Col:Byte);
    //procedure AllineamentoTimbrature(DataI,DataF:TDateTime);  //caratto 12/09/2013
    procedure ValidaAssenza(Day:Integer;DataIn:TDateTime);
    procedure AfterResizeElementiForm;
    procedure GetTipoCausale(const Griglia:TStringGrid;
                             const Day,ColonnaCella:Integer;
                             var CodiceCausale: String;
                             var TipoCausale: TTipoCausale);
  public
    DataCorr:TDateTime;
    FGriglie:Array [1..6] of TGriglie;
    Giorno: Word;
    SB,SN:String;
    procedure CaricaMese;
    procedure CaricaGriglie;
    procedure CambiaProgressivo;
  end;

const
  NomiGiorni: TNomiGiorni = ('Dom','Lun','Mar','Mer','Gio','Ven','Sab');

var
  A023FTimbrature: TA023FTimbrature;

procedure OpenA023Timbrature(Prog:LongInt;Data:TDateTime);

implementation

uses A016UCausAssenze, A020UCausPresenze, A021UCausGiustif,
     A023UTimbratureDtM1, A023UTimbratureMW, A023UGestTimbra, A023UGestGiustif, A023UAnomalie,
     A023UTimbMese, A023UCorrezione, A023UCancTimbRiscaricate, A023UCaricaTimbRich,
     A023UGestMese, A023URipristinoTimbOrig, A023UAllTimbUguali, A023UAllTimbMW;

{$R *.DFM}

procedure OpenA023Timbrature(Prog:LongInt;Data:TDateTime);
{Cartellino}
begin
  if Prog <= 0 then
  begin
    ShowMessage('Nessun dipendente selezionato!');
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA023Timbrature') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A023FTimbrature:=TA023FTimbrature.Create(nil);
  with A023FTimbrature do
  try
    C700Progressivo:=Prog;
    DataCorr:=Data;
    A023FTimbratureDtM1:=TA023FTimbratureDtM1.Create(nil);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    FreeAndNil(A023FTimbratureDtM1);
    Free;
  end;
end;

procedure TA023FTimbrature.FormCreate(Sender: TObject);
{Inizializzazioni}
var AccessoA023:Boolean;
begin
  inherited;
  DataCorr:=Date;
  HintCausale:='';
  Application.HintPause:=100;
  DisegnaGriglie:=False;
  LAnomalie:=TStringList.Create;
  LStorico:=TStringList.Create;
  FGriglie[1].Timbrat:=GTimbrat1;
  FGriglie[1].Giustif:=GGiustif1;
  FGriglie[1].Giorno:=LGiorno1;
  FGriglie[1].Pianif:=LCP1;
  FGriglie[1].Orario:=EOrario1;
  FGriglie[1].OreLavorate:=LOreLavorate1;
  FGriglie[1].Scostamento:=LScostamento1;
  FGriglie[1].Debito:=LDebito1;
  FGriglie[1].Turni:=LTurni1;
  FGriglie[1].EscluseDaNorm:=lblEscluseDaNorm1;
  FGriglie[2].Timbrat:=GTimbrat2;
  FGriglie[2].Giustif:=GGiustif2;
  FGriglie[2].Giorno:=LGiorno2;
  FGriglie[2].Pianif:=LCP2;
  FGriglie[2].Orario:=EOrario2;
  FGriglie[2].Turni:=LTurni2;
  FGriglie[2].OreLavorate:=LOreLavorate2;
  FGriglie[2].Scostamento:=LScostamento2;
  FGriglie[2].Debito:=LDebito2;
  FGriglie[2].EscluseDaNorm:=lblEscluseDaNorm2;
  FGriglie[3].Timbrat:=GTimbrat3;
  FGriglie[3].Giustif:=GGiustif3;
  FGriglie[3].Giorno:=LGiorno3;
  FGriglie[3].Pianif:=LCP3;
  FGriglie[3].Orario:=EOrario3;
  FGriglie[3].Turni:=LTurni3;
  FGriglie[3].OreLavorate:=LOreLavorate3;
  FGriglie[3].Scostamento:=LScostamento3;
  FGriglie[3].Debito:=LDebito3;
  FGriglie[3].EscluseDaNorm:=lblEscluseDaNorm3;
  FGriglie[4].Timbrat:=GTimbrat4;
  FGriglie[4].Giustif:=GGiustif4;
  FGriglie[4].Giorno:=LGiorno4;
  FGriglie[4].Pianif:=LCP4;
  FGriglie[4].Orario:=EOrario4;
  FGriglie[4].Turni:=LTurni4;
  FGriglie[4].OreLavorate:=LOreLavorate4;
  FGriglie[4].Scostamento:=LScostamento4;
  FGriglie[4].Debito:=LDebito4;
  FGriglie[4].EscluseDaNorm:=lblEscluseDaNorm4;
  FGriglie[5].Timbrat:=GTimbrat5;
  FGriglie[5].Giustif:=GGiustif5;
  FGriglie[5].Giorno:=LGiorno5;
  FGriglie[5].Pianif:=LCP5;
  FGriglie[5].Orario:=EOrario5;
  FGriglie[5].Turni:=LTurni5;
  FGriglie[5].OreLavorate:=LOreLavorate5;
  FGriglie[5].Scostamento:=LScostamento5;
  FGriglie[5].Debito:=LDebito5;
  FGriglie[5].EscluseDaNorm:=lblEscluseDaNorm5;
  FGriglie[6].Timbrat:=GTimbrat6;
  FGriglie[6].Giustif:=GGiustif6;
  FGriglie[6].Giorno:=LGiorno6;
  FGriglie[6].Pianif:=LCP6;
  FGriglie[6].Orario:=EOrario6;
  FGriglie[6].Turni:=LTurni6;
  FGriglie[6].OreLavorate:=LOreLavorate6;
  FGriglie[6].Scostamento:=LScostamento6;
  FGriglie[6].Debito:=LDebito6;
  FGriglie[6].EscluseDaNorm:=lblEscluseDaNorm6;
  //Inibizioni Read-Only
  AccessoA023:=SolaLettura;
  AccessoA004:=A000GetInibizioni('Funzione','OpenA004GiustifAssPres');
  {$IFDEF DEBUG_MEDP}
  AccessoA004:='S'; // prova per abilitazione giustificativi
  {$ENDIF}
  //Pianificazioneliberaprofessione1.Visible:=A000GetInibizioni('Funzione','OpenA097PianifLibProf') = 'S';
  Pianificazioneliberaprofessione1.Visible:=False;
  SolaLettura:=AccessoA023;
  A023FCorrezione:=TA023FCorrezione.Create(nil);
end;

procedure TA023FTimbrature.FormShow(Sender: TObject);
{Imposto data di partenza}
var I,G:Integer;
begin
  if DebugHook <> 0 then
    // in debug è sempre abilitato
    Gestionemensile1.Visible:=True
  else
    //Gestionemensile1.Visible:=(Parametri.ModuloInstallato['TORINO_CSI']) and (Parametri.CodiceIntegrazione = 'TO');
    Gestionemensile1.Visible:=(Parametri.ModuloInstallato['TORINO_CSI']) and (Parametri.CampiRiferimento.C32_GestMensile = 'S');
  DecodeDate(DataCorr,Anno,Mese,Giorno);
  G:=Giorno;
  Giorno:=1;
  EMese.Value:=Mese;
  EAnno.Value:=Anno;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  //frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,1,True);
  frmSelAnagrafe.CreaSelAnagrafe(A023FTimbratureDtM1.A023FTimbratureMW,SessioneOracle,StatusBar,1,True);
  Inserisci1.Enabled:=(not SolaLettura) and (Parametri.InserisciTimbrature = 'S');
  Modifica1.Enabled:=not SolaLettura;
  Cancella1.Enabled:=(not SolaLettura) and ((Parametri.CancellaTimbrature = 'S') or (Parametri.T100_CancTimbOrig = 'S'));
  Inserisci3.Enabled:=(not SolaLettura) and (Parametri.InserisciTimbrature = 'S');
  Modifica3.Enabled:=not SolaLettura;
  Cancella2.Enabled:=(not SolaLettura) and ((Parametri.CancellaTimbrature = 'S') or (Parametri.T100_CancTimbOrig = 'S'));
  Inserisci2.Enabled:=AccessoA004 = 'S';
  Modifica2.Enabled:=(not SolaLettura) and (AccessoA004 = 'S');
  MenuItem1.Enabled:=AccessoA004 = 'S';
  MenuItem3.Enabled:=(not SolaLettura) and (AccessoA004 = 'S');
  Validaassenze1.Enabled:=(not SolaLettura) and (AccessoA004 = 'S');
  Ripristinotimbratureoriginali1.Enabled:=(not SolaLettura) and (Parametri.RipristinoTimbOri = 'S');
  Eliminazionetimbratureriscaricate1.Enabled:=not SolaLettura;
  Allineamentotimbratureuguali1.Enabled:=not SolaLettura;
  //Mi posiziono sulla pagina in cui si trova il giorno richiamato
  for i:=1 to ((G - 1) div 6) do
    BPrecClick(BSucc);
end;

procedure TA023FTimbrature.AfterResizeElementiForm;
{ Procedura richiamata dopo il resize della window oppure
  lo spostamento dello splitter per allineare la label dei giustificativi }
begin
  lblGiustificativi.Left:=Splitter1.Left + Splitter1.Width;
  grpLegenda.Left:=Max(470,lblGiustificativi.Left + 110);
end;

procedure TA023FTimbrature.CambiaProgressivo;
begin
  if A023FTimbratureDtM1.A023FTimbratureMW.SelAnagrafe = nil then
    Exit;
  if C700OldProgressivo <> C700Progressivo then
    with A023FTimbratureDtM1 do
    begin
      A023FTimbratureMW.Q031.Close;
      A023FTimbratureMW.Q031.SetVariable('Progressivo',C700Progressivo);
      A023FTimbratureMW.Q031.Open;
      if A023FTimbratureMW.Q031.FieldByName('Data').AsDateTime = 0 then
        LData.Caption:=''
      else
        LData.Caption:=FormatDateTime('dd/mm/yyyy',A023FTimbratureMW.Q031.FieldByName('Data').AsDateTime);
      A023FTimbratureMW.Q031_1.Close;
      A023FTimbratureMW.Q031_1.SetVariable('Progressivo',C700Progressivo);
      A023FTimbratureMW.Q031_1.Open;
      CaricaMese;
    end;
end;

{ Valorizza il codice e il tipo di causale per la timbratura/giustificativo dalla griglia
  per il giorno e l'indice colonna indicati. Se la causale non è presente o non è modificabile
  il relativo viene restituito come vuoto. }
procedure TA023FTimbrature.GetTipoCausale(const Griglia:TStringGrid;
                                          const Day,ColonnaCella:Integer;
                                          var CodiceCausale: String;
                                          var TipoCausale: TTipoCausale);
begin
  TipoCausale:=tcNone;
  CodiceCausale:='';
  if Griglia.Tag > 10 then // Griglia giustificativi
    CodiceCausale:=A023FTimbratureDtM1.A023FTimbratureMW.A000FGestioneTimbraGiustMW.FGiustificativi[Day,ColonnaCella].Causale
  else // Griglia timbrature
    CodiceCausale:=A023FTimbratureDtM1.A023FTimbratureMW.A000FGestioneTimbraGiustMW.FTimbrature[Day,ColonnaCella].Causale;
  if CodiceCausale <> '' then
  begin
    with A023FTimbratureDtM1.A023FTimbratureMW do
    begin
      if (VarToStr(Q265.Lookup('Codice',CodiceCausale,'Codice')) = CodiceCausale) and
         (A000FiltroDizionario('CAUSALI ASSENZA',CodiceCausale)) then // Causale di assenza
        TipoCausale:=tcAssenza
      else if (VarToStr(Q275.Lookup('Codice',CodiceCausale,'Codice')) = CodiceCausale) and
              (A000FiltroDizionario('CAUSALI PRESENZA',CodiceCausale)) then // Causale di presenza
        TipoCausale:=tcPresenza
      else if (VarToStr(Q305.Lookup('Codice',CodiceCausale,'Codice')) = CodiceCausale) and
              (A000FiltroDizionario('CAUSALI GIUSTIFICAZIONE',CodiceCausale)) then // Causale di giustificazione
        TipoCausale:=tcGiustificazione
      else
        CodiceCausale:='';
    end;
  end;
end;

procedure TA023FTimbrature.EMeseChange(Sender: TObject);
{Carico i dati del mese corrente}
begin
  if (EMese.Text = '') or (EAnno.Text = '') then
    exit;
  if Sender = Emese then
    begin
    if EMese.Value <> Mese then
      begin
      Mese:=EMese.Value;
      CaricaMese;
      end;
    end
  else
    begin
    if EAnno.Value <> Anno then
      begin
      Anno:=EAnno.Value;
      CaricaMese;
      end;
    end;
end;

procedure TA023FTimbrature.BPrecClick(Sender: TObject);
{Scorre avanti/indietro di 6 giorni}
begin
  if Sender = BPrec then
    if Giorno > 1 then
    begin
      Giorno:=Giorno - 6;
    end
    else
    begin
      if EMese.Value = 1 then
      begin
        EMese.Value:=12;
        EAnno.Value:=EAnno.Value - 1;
      end
      else
        EMese.Value:=EMese.Value - 1;
      Giorno:=A023FCorrezione.CalcolaGiorno(R180GiorniMese(EncodeDate(EAnno.Value,EMese.Value,1)));
    end;
  if (Sender = BSucc) then
    if Giorno < (A023FTimbratureDtM1.A023FTimbratureMW.MaxGiorni - 5) then
    begin
      Giorno:=Giorno + 6;
    end
    else
    begin
      if EMese.Value = 12 then
      begin
        EMese.Value:=1;
        EAnno.Value:=EAnno.Value + 1;
      end
      else
        EMese.Value:=EMese.Value + 1;
      Giorno:=1;
    end;
  CaricaGriglie;
end;

procedure TA023FTimbrature.CaricaMese;
{Cambio i parametri alle query e carico i vettori Timbrature e Giustificativi
con i dati del mese}
begin
  PulisciGriglia;
  A023FTimbratureDtM1.A023FTimbratureMW.caricaMese(EAnno.Value,EMese.Value,SBConteggi.Down);
  CaricaGriglie;
end;

procedure TA023FTimbrature.Pianificazioneliberaprofessione1Click(
  Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA097PianifLibProf(C700Progressivo,EncodeDate(EAnno.Value,EMese.Value,1));
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  C700OldProgressivo:=-1;
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A023FTimbratureDtM1.A023FTimbratureMW);
end;

procedure TA023FTimbrature.PopupMenu1Popup(Sender: TObject);
var
  Griglia:TStringGrid;
  Causale:String;
  Col,Day:Integer;
  TipoCausale:TTipoCausale;
begin
  {Mi posiziono sulla griglia corrente e sulla cella corrente}
  if not(ActiveControl is TStringGrid) then
    exit;
  Griglia:=ActiveControl as TStringGrid;
  Col:=Griglia.Col + 1;
  if Griglia.Tag > 10 then
    Day:=Giorno + Griglia.Tag - 11  {Il giorno rappresentato dalla griglia}
  else
    Day:=Giorno + Griglia.Tag - 1;  {Il giorno rappresentato dalla griglia}

  if Day > A023FTimbratureDtM1.A023FTimbratureMW.MaxGiorni then
    exit;

  //Inforichiesta1.Visible:=A023FTimbratureDtM1.A023FTimbratureMW.A000FGestioneTimbraGiustMW.FTimbrature[Day,Col].IDRichiesta > 0;
  GetTipoCausale(Griglia,Day,Col,Causale,TipoCausale);
  Accediamodificacausale1.Enabled:=TipoCausale <> tcNone;
end;

procedure TA023FTimbrature.PopupMenu2Popup(Sender: TObject);
var
  i:Integer;
  Griglia:TStringGrid;
  Causale:String;
  Day,Col:Integer;
  TipoCausale:TTipoCausale;
begin
  inherited;
  if not(ActiveControl is TStringGrid) then exit;
  Griglia:=ActiveControl as TStringGrid;
  Col:=Griglia.Col + 1;
  if Griglia.Tag > 10 then
    Day:=Giorno + Griglia.Tag - 11  {Il giorno rappresentato dalla griglia}
  else
    Day:=Giorno + Griglia.Tag - 1;  {Il giorno rappresentato dalla griglia}
  if Day > A023FTimbratureDtM1.A023FTimbratureMW.MaxGiorni then exit;

  Validaassenze1.Visible:=False;
  with A023FTimbratureDtM1.A023FTimbratureMW.A000FGestioneTimbraGiustMW do
  begin
    for i:=1 to MaxGiustif do
      if (FGiustificativi[Day,i].Causale <> '') and (FGiustificativi[Day,i].Validata  = 'N') then
        Validaassenze1.Visible:=True;
  end;
  GetTipoCausale(Griglia,Day,Col,Causale,TipoCausale);
  Accediamodificacausale2.Enabled:=TipoCausale <> tcNone;
end;

procedure TA023FTimbrature.PulisciGriglia;
{Pulisce le griglie quando si scorre o si cambia mese}
var LG,i,j:Byte;
begin
  for LG:=1 to 6 do
  begin
    if FGriglie[LG].Timbrat <> nil then
      with FGriglie[LG].Timbrat do
        for i:=0 to RowCount - 1 do
          for j:=0 to ColCount - 1 do
            Cells[i,j]:='';
    if FGriglie[LG].Giustif <> nil then
      with FGriglie[LG].Giustif do
        for i:=0 to RowCount - 1 do
          for j:=0 to ColCount - 1 do
            Cells[i,j]:='';
  end;
end;

procedure TA023FTimbrature.CaricaGriglie;
{Carica le 6 griglie con i dati contenuti nei vettori}
var G:Byte;
    DataCorr:TDateTime;
begin
  DisegnaGriglie:=True;
  LAnomalie.Clear;
  with A023FTimbratureDtM1.A023FTimbratureMW do
  begin
    for G:=Giorno to Giorno + 5 do
    begin
      if G > MaxGiorni then
      begin
        FGriglie[G-Giorno+1].Giorno.ParentColor:=True;
        FGriglie[G-Giorno+1].Giorno.Caption:='';
        FGriglie[G-Giorno+1].Pianif.Visible:=False;
        FGriglie[G-Giorno+1].Orario.ParentFont:=True;
        FGriglie[G-Giorno+1].Orario.Text:='';
        FGriglie[G-Giorno+1].Timbrat.ColCount:=1;
        FGriglie[G-Giorno+1].Giustif.ColCount:=1;
        FGriglie[G-Giorno+1].OreLavorate.Caption:='';
        FGriglie[G-Giorno+1].Scostamento.Caption:='';
        FGriglie[G-Giorno+1].Debito.Caption:='';
        FGriglie[G-Giorno+1].EscluseDaNorm.Caption:='';
      end
      else
      begin
        DataCorr:=EncodeDate(EAnno.Value,EMese.Value,G);
        Calendario(DataCorr,FGriglie[G-Giorno+1].Giorno);
        Orario(DataCorr,FGriglie[G-Giorno+1].Orario,FGriglie[G-Giorno+1].Turni);
        FGriglie[G-Giorno+1].Giorno.Caption:=NomiGiorni[DayOfWeek(DataCorr)]+' '+IntToStr(G);
        FGriglie[G-Giorno+1].Pianif.Visible:=FPianif[G];
        FGriglie[G-Giorno+1].Timbrat.ColCount:=A000FGestioneTimbraGiustMW.FNumTimbrature[G]+1;
        FGriglie[G-Giorno+1].Giustif.ColCount:=A000FGestioneTimbraGiustMW.FNumGiustif[G]+1;
        A023FTimbratureDtM1.A023FTimbratureMW.R502ProDtM1.PrimaVolta:='si';
        if SBConteggi.Down then
          Conteggi(G-Giorno+1,EncodeDate(EAnno.Value,EMese.Value,G));
      end;
      FGriglie[G-Giorno+1].Timbrat.Hint:='';
      FGriglie[G-Giorno+1].Giustif.Hint:='';
      FGriglie[G-Giorno+1].Timbrat.Repaint;
      FGriglie[G-Giorno+1].Giustif.Repaint;
    end;
  end;
end;

procedure TA023FTimbrature.Calendario(Data:TDateTime;LGiorno:TLabel);
{Cerco le caratteristiche del giorno su Calendario Individ/Tabella
(Festivo/Lavorativo)}
begin
  LGiorno.ParentColor:=True; {Ripristino i colori iniziali}
  LGiorno.ParentFont:=True;
  with A023FTimbratureDtM1.A023FTimbratureMW.GetCalend do
  begin
    SetVariable('PROG',C700Progressivo);
    SetVariable('D',Data);
    Execute;
    if (VarToStr(GetVariable('L')) = '') and (VarToStr(GetVariable('F')) = '') and (GetVariable('G') = 0) then
      exit;
    if VarToStr(GetVariable('F')) = 'S' then
      LGiorno.Color:=clYellow; {Festivo}
    if VarToStr(GetVariable('L')) = 'N' then
      LGiorno.Color:=clLime; {Non lavorativo}
    if (VarToStr(GetVariable('F')) = 'S') and    //Festivo e
       (VarToStr(GetVariable('L')) = 'N') then   //non lavorativo
      LGiorno.Color:=clAqua;
  end;
  if DayOfWeek(Data) = 1 then {Domenica}
    LGiorno.Font.Color:=clRed;
end;

procedure TA023FTimbrature.Orario(Data:TDateTime;EOrario:TEdit;LTurni:TLabel);
{Recupera il codice orario dalla pianificazione orari}
begin
  EOrario.ParentFont:=True;
  with A023FTimbratureDtM1.A023FTimbratureMW.Q080 do
    if Locate('Data',Data,[]) then
    begin
      EOrario.Font.Color:=clRed;
      LTurni.Font.Color:=clRed;
      EOrario.Text:=FieldByName('Orario').AsString;
      LTurni.Caption:=A023FTimbratureDtM1.A023FTimbratureMW.TestoTurno(Data);
    end
    else
    begin
      EOrario.Text:='';
      LTurni.Caption:='    ';
    end;
end;

procedure TA023FTimbrature.FormResize(Sender: TObject);
begin
  inherited;
  // sposta la label "Giustificativi"
  AfterResizeElementiForm;
end;

procedure TA023FTimbrature.GTimbrat1DrawCell(Sender: TObject; Col,
  Row: Longint; Rect: TRect; State: TGridDrawState);
{Coloro le celle delle timbrature e dei giustificativi}
var Timbrature:Boolean;
    Testo:String;
    Day:Byte;
    Griglia:TStringGrid;
  procedure ColoraEU(Verso,Flag:String);
  {Verde = Entrate; Azzurro = Uscite}
  var Retng:TRect;
  begin
    Retng:=Rect;
    Retng.Right:=Retng.Right-Round(Griglia.Canvas.TextWidth('999')*0.85);
    if Verso = 'E' then ColoraCella(Griglia,Retng,clLime)
    else ColoraCella(Griglia,Retng,clAqua);
  end;
  procedure ColoraTipoG(Tipo:String);
  {Tutto Rosso = Intera giornata
   Metà rosso =  1/2 giornata}
  var RetGius:TRect;
  begin
    RetGius:=Rect;
    if Tipo = 'I' then ColoraCella(Griglia,Rect,clRed);
    if Tipo = 'M' then
    begin
      RetGius.Right:=(RetGius.Right - RetGius.Left) div 2 + RetGius.Left;
      ColoraCella(Griglia,RetGius,clRed);
    end;
  end;
  function ColoreCausale(Causale:String):TColor;
  {Rosso = Assenza; Verde = Presenza; Blu = Giustificativo; clAqua = Ass.Validata}
  begin
    Result:=clBlack;
    with A023FTimbratureDtM1.A023FTimbratureMW do
    begin
      if Q265.Locate('Codice',Causale,[]) then
      begin
        if A000FGestioneTimbraGiustMW.FGiustificativi[Day,Col+1].Validata = 'N' then
          Result:=clAqua
        else
          Result:=clRed
      end
      else if Q275.Locate('Codice',Causale,[]) then Result:=clGreen
      else if Q305.Locate('Codice',Causale,[]) then Result:=clBlue;
    end;
  end;
begin
  if not DisegnaGriglie then exit;
  Griglia:=Sender as TStringGrid;
  with A023FTimbratureDtM1.A023FTimbratureMW do
  begin
    if Griglia.Tag > 10 then
    begin
      Timbrature:=False;    {Giustificativi}
      Day:=Giorno+Griglia.Tag - 11;  {Il giorno rappresentato dalla griglia}
      if Col + 1 > MaxGiustif then
        exit;
      if Day <= MaxGiorni then
        if A000FGestioneTimbraGiustMW.FGiustificativi[Day,Col + 1].Causale = '' then exit;
    end
    else
    begin
      Timbrature:=True;     {Timbrature}
      Day:=Giorno+Griglia.Tag-1;  {Il giorno rappresentato dalla griglia}
      if Col+1 > MaxTimbrature then exit;
      if Day <= MaxGiorni then
        if A000FGestioneTimbraGiustMW.FTimbrature[Day,Col+1].Ora = null then exit;
    end;
    {Abblenco la cella}
    Griglia.Canvas.Brush.Style:=bsSolid;
    ColoraCella(Griglia,Rect,clWhite);
    if Day > MaxGiorni then exit;
    Case Row of
      0:{Timbrature o Descr.Giustif}
        if Timbrature then
        begin
          if A000FGestioneTimbraGiustMW.FTimbrature[Day,Col+1].Flag='O' then
            Griglia.Canvas.Font.Color:=clRed
          else
            Griglia.Canvas.Font.Color:=clBlack;
          Testo:=' '+FormatDateTime('hh:mm',A000FGestioneTimbraGiustMW.FTimbrature[Day,Col+1].Ora);
          if Trim(A000FGestioneTimbraGiustMW.FTimbrature[Day,Col+1].Rilevatore) <> '' then
            Testo:=Testo+'  '+A000FGestioneTimbraGiustMW.FTimbrature[Day,Col+1].Rilevatore;
          ColoraEU(A000FGestioneTimbraGiustMW.FTimbrature[Day,Col+1].Verso,A000FGestioneTimbraGiustMW.FTimbrature[Day,Col+1].Flag);
        end
        else
        begin
          Griglia.Canvas.Font.Color:=clBlack;
          Testo:=A000FGestioneTimbraGiustMW.FormGiust(Day,Col+1); {Costruisco la descrizione del giustificativo}
          ColoraTipoG(A000FGestioneTimbraGiustMW.FGiustificativi[Day,Col+1].Tipo);
        end;
      1:{Causali}
        if Timbrature then
        begin
          Griglia.Canvas.Font.Color:=ColoreCausale(A000FGestioneTimbraGiustMW.FTimbrature[Day,Col+1].Causale);
          Testo:=' ' + A000FGestioneTimbraGiustMW.FTimbrature[Day,Col+1].Causale;
        end
        else
        begin
          Griglia.Canvas.Font.Color:=ColoreCausale(A000FGestioneTimbraGiustMW.FGiustificativi[Day,Col+1].Causale);
          Testo:=' ' + A000FGestioneTimbraGiustMW.FGiustificativi[Day,Col+1].Causale;
          if A000FGestioneTimbraGiustMW.FGiustificativi[Day,Col+1].Note <> '' then
            Testo:=Testo + '[' + A000FGestioneTimbraGiustMW.FGiustificativi[Day,Col+1].Note + ']';
          if A000FGestioneTimbraGiustMW.FGiustificativi[Day,Col+1].NuovoPeriodo and
             R180In(VarToStr(Q265.Lookup('CODICE',A000FGestioneTimbraGiustMW.FGiustificativi[Day,Col+1].Causale,'TIPOCUMULO')),['I','O']) then
            Testo:=Testo + '(np)';
        end;
    end;
  end;
  {Scrive il testo nella griglia}
  Griglia.Canvas.Brush.Style:=bsClear;
  Griglia.Canvas.TextRect(Rect,Rect.Left,Rect.Top,Testo);
  Griglia.Canvas.Font.Color:=clGreen;
  if State = [gdSelected..gdFocused] then
    IncorniciaCella(Griglia,Rect);
end;

procedure TA023FTimbrature.ColoraCella(Griglia:TStringGrid;Rect:TRect;Color:TColor);
{Colora la metà specificata della cella col colore specificato}
begin
  with Griglia.Canvas do
  begin
    Brush.Color:=Color;
    FillRect(Rect);
  end;
end;

procedure TA023FTimbrature.IncorniciaCella(Griglia:TStringGrid;Rect:TRect);
{Incornicia}
begin
  with Griglia.Canvas do
    begin
    Brush.Style:=bsClear;
    Pen.Color:=clRed;
    Rectangle(Rect.Left+1,Rect.Top+1,Rect.Right-1,Rect.Bottom-1);
    end;
end;

procedure TA023FTimbrature.Gestionemensile1Click(Sender: TObject);
var
  ConteggiAttiviTemp: Boolean;
begin
  inherited;
  ConteggiAttiviTemp:=False;
  try
    A023FGestMese:=TA023FGestMese.Create(nil);
    // disabilita modifica di progressivo, mese e anno
    frmSelAnagrafe.Enabled:=False;
    EMese.Enabled:=False;
    EAnno.Enabled:=False;
    // disabilita i conteggi (tempi di risposta troppo elevati)
    ConteggiAttiviTemp:=SBConteggi.Down;
    SBConteggi.Down:=False;
    SBConteggiClick(nil);
    SBConteggi.Enabled:=False;
    // disabilita correzione anomalie
    SpCorrezione.Enabled:=False;
    Correzionetimbrature1.Enabled:=False;
    Gestionemensile1.Enabled:=False;
    // apre gestione mensile
    with A023FGestMese do
    begin
      Progressivo:=C700Progressivo;
      DataMese:=EncodeDate(EAnno.Value,EMese.Value,1);
      OldConteggiAttivi:=ConteggiAttiviTemp;
      Show;
    end;
  except
    on E:Exception do
    begin
      R180MessageBox('Attenzione! Non è possibile visualizzare la gestione mensile!' + #13#10 +
                     'Si è verificato il seguente errore:' + #13#10 +
                      E.Message, ESCLAMA);
      // ripristina le abilitazioni
      frmSelAnagrafe.Enabled:=True;
      EMese.Enabled:=True;
      EAnno.Enabled:=True;
      SBConteggi.Enabled:=True;
      SBConteggi.Down:=ConteggiAttiviTemp;
      SBConteggiClick(nil);
      SpCorrezione.Enabled:=True;
      Correzionetimbrature1.Enabled:=True;
      FreeAndNil(A023FGestMese);
      Gestionemensile1.Enabled:=True;
    end;
  end;
end;

procedure TA023FTimbrature.GestioneTimb(Sender: TObject);
{Gestione Timbrature/Giustificativi}
var Griglia:TStringGrid;
    Day,Col:Integer;
    Data:TDateTime;
    Causale: String;
    TipoCausale:TTipoCausale;
begin
  {Mi posiziono sulla griglia corrente e sulla cella corrente}
  if not(ActiveControl is TStringGrid) then exit;
  Griglia:=ActiveControl as TStringGrid;
  //if ((Sender as TMenuItem).Tag <=3) and (Griglia.Tag > 10) then exit;
  //if ((Sender as TMenuItem).Tag >3) and (Griglia.Tag < 10) then exit;
  Col:=Griglia.Col + 1;
  if Griglia.Tag > 10 then
    Day:=Giorno + Griglia.Tag - 11  {Il giorno rappresentato dalla griglia}
  else
    Day:=Giorno + Griglia.Tag - 1;  {Il giorno rappresentato dalla griglia}
  if Day > A023FTimbratureDtM1.A023FTimbratureMW.MaxGiorni then exit;
  Data:=StrToDate(IntToStr(Day)+'/'+IntToStr(EMese.Value)+'/'+IntToStr(EAnno.Value));
  if (Sender as TMenuItem).Tag = 6 then
    VisualizzaAssenze(Data,Day,Col)
  else if (Sender as TMenuItem).Tag = 12 then // "Accedi", per aprire maschera modifica causale
  begin
    GetTipoCausale(Griglia,Day,Col,Causale,TipoCausale);
    if Causale <> '' then
    begin
      if TipoCausale = tcAssenza then
        OpenA016CausAssenze(Causale)
      else if TipoCausale = tcPresenza then
        OpenA020CausPresenze(Causale)
      else if TipoCausale = tcGiustificazione then
        OpenA021CausGiustif(Causale);
      A023FTimbratureDtM1.A023FTimbratureMW.R502ProDtM1.Resetta;
      SBConteggiClick(SBConteggi);
    end;
    // Il tag di questo menù non è gestito nel codice sottostante, quindi usciremo
    // senza fare alcuna azione.
  end;
  //Abilitazione solo alla lettura
  if (C700SelAnagrafe.RecordCount = 0) or
     (SolaLettura and not((Sender as TMenuItem).Tag in [4,5])) or
     ((AccessoA004 = 'N') and ((Sender as TMenuItem).Tag in [4,5])) then
    begin
      ShowOK:=False;
      Exit;
    end
  else
    ShowOK := True;
  case (Sender as TMenuItem).Tag of
    1:
      if A023FTimbratureDtM1.A023FTimbratureMW.selDatiBloccati.DatoBloccato(C700Progressivo,A023FTimbratureDtM1.A023FTimbratureMW.selDatiBloccati.MeseBloccoRiepiloghi(Data),'T100') then
        raise Exception.Create(A023FTimbratureDtM1.A023FTimbratureMW.selDatiBloccati.MessaggioLog);
    2,3:
      with A023FTimbratureDtM1.A023FTimbratureMW do
      begin
        if selDatiBloccati.DatoBloccato(C700Progressivo,A023FTimbratureDtM1.A023FTimbratureMW.selDatiBloccati.MeseBloccoRiepiloghi(Data),'T100') then
          raise Exception.Create(A023FTimbratureDtM1.A023FTimbratureMW.selDatiBloccati.MessaggioLog);
        //Chiamata: 83085
        if not A000FiltroDizionario('OROLOGI DI TIMBRATURA',A000FGestioneTimbraGiustMW.FTimbrature[Day,Col].Rilevatore) then
          raise Exception.Create(A000MSG_ERR_RILEVATORE_DIZIONARIO);
      end;
    5:// modifica giustificativo
      begin
        Causale:=A023FTimbratureDtM1.A023FTimbratureMW.A000FGestioneTimbraGiustMW.FGiustificativi[Day,Col].Causale;
        // AOSTA_REGIONE - chiamata 85647.ini
        // se la causale originale ha la gestione visite fiscali, impedisce modifica
        with A023FTimbratureDtM1.A023FTimbratureMW do
        begin
          if VarToStr(Q265.Lookup('CODICE',A000FGestioneTimbraGiustMW.FGiustificativi[Day,Col].Causale,'VISITA_FISCALE')) = 'S' then
            raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A023_ERR_FMT_MOD_VISITA_FISCALE_S),[MenuItem1.Caption.Replace('&','',[])]));
        end;
        // AOSTA_REGIONE - chiamata 85647.fine

        if (A023FTimbratureDtM1.A023FTimbratureMW.GetValStrT230(Causale,'CAUSALI_CHECKCOMPETENZE',Data) <> '') or
           (A023FTimbratureDtM1.A023FTimbratureMW.GetValStrT230(Causale,'CAUSALE_FRUIZORE',Data) <> '') or
           (A023FTimbratureDtM1.A023FTimbratureMW.GetValStrT230(Causale,'CAUSALE_HMASSENZA',Data) <> '') or
           (A023FTimbratureDtM1.A023FTimbratureMW.GetValStrT230(Causale,'CHECK_SOLOCOMPETENZE',Data) = 'S')
        then
        begin
          raise Exception.Create(A000TraduzioneStringhe(A000MSG_A023_ERR_NO_MOD_GIUST));
        end;

        // controllo dati bloccati
        if A023FTimbratureDtM1.A023FTimbratureMW.selDatiBloccati.DatoBloccato(C700Progressivo,A023FTimbratureDtM1.A023FTimbratureMW.selDatiBloccati.MeseBloccoRiepiloghi(Data),'T040') then
          raise Exception.Create(A023FTimbratureDtM1.A023FTimbratureMW.selDatiBloccati.MessaggioLog);
      end;
  end;
  with A023FTimbratureDtM1.A023FTimbratureMW do
    case (Sender as TMenuItem).Tag of
      1:begin
        InsTimbratura(Data,Day,Col,Griglia.Tag);
        Q100.Close;
        Q100.Open;
        end;
      2:if CancTimbratura(Data,Day,Col) then
        begin
          Q100.Close;
          Q100.Open;
          Griglia.ColCount:=A000FGestioneTimbraGiustMW.FNumTimbrature[Day]+1;
          Griglia.Repaint;
        end;
      3:if ModTimbratura(Data,Day,Col) then
        begin
          Griglia.Repaint;
          Q100.Close;
          Q100.Open;
        end;
      4:if InsCancGiustif(Data,Day,Col) then
        begin
          R502ProDtM1.Q320.Close;
          Self.CaricaMese; //su form e non su MW
        end;
      5:if ModGiustif(Data,Day,Col) then
        begin
          Q040.Close;
          Q040.Open;
          R502ProDtM1.Q320.Close;
          Griglia.Repaint;
        end;
      7:AggData(Data);
      8:begin
          Self.ValidaAssenza(Day,Data);  //su form e non su MW
          Self.CaricaMese;  //su form e non su MW
        end;
    end;
end;

procedure TA023FTimbrature.ValidaAssenza(Day:Integer;DataIn:TDateTime);
var StrCaus:String;
begin
  StrCaus:=A023FTimbratureDtM1.A023FTimbratureMW.TrovaAssenzeDaValidare(Day);
  if StrCaus <> '' then
    OpenA023ValidaAssenze(C700Progressivo,DataIn,DataIn,StrCaus);
end;

procedure TA023FTimbrature.InsTimbratura(Data:TDateTime;Day,Col,MyTag:Byte);
{Inserimento timbratura}
begin
  if Parametri.InserisciTimbrature <> 'S' then Exit;
  with A023FTimbratureDtM1.A023FTimbratureMW do
  begin
    if A000FGestioneTimbraGiustMW.FNumTimbrature[Day] = MaxTimbrature then exit;
    A000FGestioneTimbraGiustMW.StatoTimb:=stInserimento;
    Col:=A000FGestioneTimbraGiustMW.FNumTimbrature[Day]+1;
  end;

  A023FGestTimbra:=TA023FGestTimbra.Create(Application);
  with A023FTimbratureDtM1.A023FTimbratureMW.Q100,A023FTimbratureDtM1.A023FTimbratureMW.A000FGestioneTimbraGiustMW.FTimbrature[Day,Col] do
  try
    A023FGestTimbra.DataT:=Data;
    A023FGestTimbra.LData.Caption:=FormatDateTime('mmmm yyyy',Data);
    A023FGestTimbra.EData.ReadOnly:=False;
    A023FGestTimbra.Day:=Day;
    A023FGestTimbra.Col:=Col;
    A023FGestTimbra.MyTag:=MyTag;
    Append;
    A023FGestTimbra.ShowModal;
  finally
    if State in [dsEdit,dsInsert] then
      Cancel;
    A023FGestTimbra.Release;
  end;
//caratto 2/8/2013  SessioneOracle.Commit;
end;

function TA023FTimbrature.CancTimbratura(Data:TDateTime;Day,Col:Byte):boolean;
{Cancellazione timbratura}
begin
  Result:=False;
  // verifica range
  if Col > MaxTimbrature then
    Exit;
  with A023FTimbratureDtM1.A023FTimbratureMW.Q100,A023FTimbratureDtM1.A023FTimbratureMW.A000FGestioneTimbraGiustMW.FTimbrature[Day,Col] do
  begin
    if (Parametri.CancellaTimbrature <> 'S') and (Flag = 'I') then Exit;
    if (Parametri.T100_CancTimbOrig <> 'S') and (Flag = 'O') then Exit;
    if Ora = null then exit;
    if Locate('Data;Ora;Verso;Flag',VarArrayOf([Data,Ora,Verso,Flag]),[]) then
    begin
      if MessageDlg(A000MSG_A023_DLG_CANC_TIMB, mtConfirmation, [mbYes,mbNo], 0) = mrNo then exit;
      A023FTimbratureDtM1.A023FTimbratureMW.A000FGestioneTimbraGiustMW.EseguiCancellaTimbratura(Day,Col);
      Result:=True;
    end;
  end;
end;

function TA023FTimbrature.ModTimbratura(Data:TDateTime;Day,Col:Byte):boolean;
{Modifica timbratura}
begin
  Result:=False;
  // verifica range
  if Col > MaxTimbrature then
    Exit;
  with A023FTimbratureDtM1,A023FTimbratureDtM1.A023FTimbratureMW.Q100,A023FTimbratureDtM1.A023FTimbratureMW.A000FGestioneTimbraGiustMW.FTimbrature[Day,Col] do
    begin {Creo la finestra di dialogo e carico la timbratura con Flag = I}
    if Ora = null then
    begin
      ShowOK:=False;
      exit;
    end
    else
      ShowOK:=True;
    if not(Locate('Data;Ora;Verso;Flag',VarArrayOf([Data,Ora,Verso,Flag]),[])) then exit;
    A023FTimbratureDtM1.A023FTimbratureMW.A000FGestioneTimbraGiustMW.StatoTimb:=stModifica;
    Edit;
    A023FGestTimbra:=TA023FGestTimbra.Create(Application);
    A023FGestTimbra.DataT:=Data;
    A023FGestTimbra.LData.Caption:=FormatDateTime('mmmm yyyy',Data);
    A023FGestTimbra.EData.ReadOnly := True;
    A023FGestTimbra.Day:=Day;
    A023FGestTimbra.Col:=Col;
    //Scelgo le causali di presenza o giustificazione a seconda della causale
    if A023FTimbratureMW.Q275.Locate('Codice',Causale,[]) then
      A023FGestTimbra.RadioGroup2.ItemIndex:=0
    else
      if A023FTimbratureMW.Q305.Locate('Codice',Causale,[]) then
        A023FGestTimbra.RadioGroup2.ItemIndex:=1;
    try
    if A023FGestTimbra.ShowModal = mrOk then
    begin
      A023FTimbratureDtM1.A023FTimbratureMW.A000FGestioneTimbraGiustMW.EseguiModificaTimbratura(Data,Day,Col);
      Result:=True;
    end;
//caratto 2/8/2013 SessioneOracle.Commit;
    finally
      if State in [dsEdit,dsInsert] then Cancel;
      A023FGestTimbra.Release;
    end;
  end;
end;

function TA023FTimbrature.InsCancGiustif(Data:TDateTime;Day,Col:Byte):boolean;
{Inserimento/Cancellazione Giustificativi}
var PData,PTipo,POre1,POre2,PCausale,PTipoMG:String;
    PDataNas:TDateTime;
begin
  Result:=True;
  PData:=FormatDateTime('dd/mm/yyyy',Data);
  with A023FTimbratureDtM1.A023FTimbratureMW.A000FGestioneTimbraGiustMW do
  begin
    try
      PTipo:=FGiustificativi[Day,Col].Tipo;
      POre1:=FormatDateTime('hh:mm',FGiustificativi[Day,Col].DaOre);
      POre2:=FormatDateTime('hh:mm',FGiustificativi[Day,Col].AOre);
      PCausale:=FGiustificativi[Day,Col].Causale;
      PDataNas:=FGiustificativi[Day,Col].DataNas;
      PTipoMG:=FGiustificativi[Day,Col].CSITipoMG;
      if (PTipo = 'I') or (FGiustificativi[Day,Col].Tipo = '') then
      begin
        POre1:='';
        POre2:='';
      end
      else if PTipo = 'M' then
      begin
        if R180OreMinuti(FGiustificativi[Day,Col].DaOre) = 0 then
          POre1:='';
        POre2:='';
      end;
    except
      PTipo:='';
      POre1:='';
      POre2:='';
      PCausale:='';
    end;
  end;
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA004GiustifAssPres(C700Progressivo,PData,PTipo,PTipoMG,POre1,POre2,PCausale,PDataNas,True);
  A023FTimbratureDtM1.A023FTimbratureMW.Q040.Close;
  A023FTimbratureDtM1.A023FTimbratureMW.Q040.Open;
  A023FTimbratureDtM1.A023FTimbratureMW.Q031_1.Close;
  A023FTimbratureDtM1.A023FTimbratureMW.Q031_1.Open;
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  C700OldProgressivo:=-1;
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A023FTimbratureDtM1.A023FTimbratureMW);
end;

function TA023FTimbrature.ModGiustif(Data:TDateTime;Day,Col:Byte):boolean;
{Modifica giustificativo}
var ProgCausOrig:Word;
    L133GGModif,AssFutureElab:Boolean;
    OldDataNas,NewDataNas:TDateTime;
    OldValidata,TipoCaus,StrOldDataNas,StrNewDataNas,MsgCaus:String;
    Ng1,Ng2:Integer;
  function Modificata:Boolean;
  begin
    Result:=False;
    if OldGiustif.Causale <> NewGiustif.Causale then Result:=True;
    if OldGiustif.Modo <> NewGiustif.Modo then Result:=True;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    if OldGiustif.CSITipoMG <> NewGiustif.CSITipoMG then Result:=True;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    if OldGiustif.DaOre <> NewGiustif.DaOre then Result:=True;
    if OldGiustif.AOre <> NewGiustif.AOre then Result:=True;
    if (OldDataNas <> NewDataNas) and (A023FGestGiustif.RGCausali.ItemIndex = 1) then Result:=True;
  end;
begin
  Result:=False;
  AssFutureElab:=True;
  L133GGModif:=False;
  // verifica range
  if Col > MaxGiustif then
    Exit;
  with A023FTimbratureDtM1,A023FTimbratureDtM1.A023FTimbratureMW.A000FGestioneTimbraGiustMW.FGiustificativi[Day,Col] do
  begin {Creo la finestra di dialogo e carico il giustificativo corrente}
    if Causale = '' then
    begin
      ShowOK:=False;
      Exit;
    end
    else
      ShowOK:=True;
    TipoCaus:=IfThen(A023FTimbratureMW.Q275.Locate('Codice',Causale,[]),'P','A');
    if (TipoCaus = 'A') and (not A000FiltroDizionario('CAUSALI ASSENZA',Causale)) then
      Exit;
    if (TipoCaus = 'P') and (not A000FiltroDizionario('CAUSALI PRESENZA',Causale)) then
      Exit;
    if not(A023FTimbratureMW.Q040.Locate('Data;Causale;ProgrCausale',VarArrayOf([Data,Causale,ProgCaus]),[])) then
      Exit;
    A023FGestGiustif:=TA023FGestGiustif.Create(Application);
    A023FTimbratureMW.R600DtM1:=TR600DtM1.Create(Self);
    dsrSG101.DataSet:=A023FTimbratureMW.R600DtM1.selSG101;
    with A023FGestGiustif do
    begin
      DataGiust:=Data;
      Prog:=C700Progressivo;
      LData.Caption:=FormatDateTime('dd/mm/yyyy',Data);
      if TipoCaus = 'P' then
        RGCausali.ItemIndex:=0
      else
        RGCausali.ItemIndex:=1;
      ECausale.KeyValue:=Causale;
      TipoGiust:=R180CarattereDef(Tipo,1,#0);
      if Tipo = 'I' then RGTipoGiust.ItemIndex:=0;
      if Tipo = 'M' then RGTipoGiust.ItemIndex:=1;
      if Tipo = 'N' then
        if RGTipoGiust.Items.Count = 4 then RGTipoGiust.ItemIndex:=2
        else RGTipoGiust.ItemIndex:=0;
      if Tipo = 'D' then
        if RGTipoGiust.Items.Count = 4 then RGTipoGiust.ItemIndex:=3
        else RGTipoGiust.ItemIndex:=1;
      RGTipoGiustClick(nil);
      if TipoGiust in ['N','D'] then
        EDaOre.EditText:=FormatDateTime('hh.mm',DaOre);
      if TipoGiust = 'D' then
        EAOre.EditText:=FormatDateTime('hh.mm',AOre);
      if (TipoGiust = 'M') and (R180OreMinuti(DaOre) > 0) then
        EDaOre.EditText:=FormatDateTime('hh.mm',DaOre);
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
      //*** verificare
      if rgpTipoMG.Visible then
      begin
        rgpTipoMG.ItemIndex:=IfThen(CSITipoMG = 'M',0,1);
      end;
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine

      //Solo per assenze:Imposto i dati in OldGiustif
      OldGiustif.Inserimento:=False;
      case RGTipoGiust.ItemIndex of
        0:OldGiustif.Modo:='I';
        1:OldGiustif.Modo:='M';
        2:OldGiustif.Modo:='N';
        3:OldGiustif.Modo:='D';
      end;
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
      OldGiustif.CSITipoMG:='';
      if rgpTipoMG.Visible then
      begin
        case rgpTipoMG.ItemIndex of
          0: OldGiustif.CSITipoMG:='M';
          1: OldGiustif.CSITipoMG:='P';
        else
        end;
      end;
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
      OldGiustif.Causale:=ECausale.KeyValue;//ECausale.Text;
      OldGiustif.DaOre:=EDaOre.Text;
      OldGiustif.AOre:=EAOre.Text;
      OldDataNas:=DataNas;
      ProgCausOrig:=A023FTimbratureMW.Q040.FieldByName('ProgrCausale').AsInteger;

      // parte nuova da considerare
      A023FTimbratureMW.ImpostaProgressivoSG101;

      A023FTimbratureMW.getDataGestGiustif:=A023FGestGiustif.GetData;
      A023FTimbratureMW.getCausaleGestGiustif:=A023FGestGiustif.GetCausale;
      A023FTimbratureMW.R600DtM1.selSG101.OnFilterRecord:=A023FTimbratureDtM1.A023FTimbratureMW.selSG101FilterRecord;

      A023FTimbratureMW.R600DtM1.selSG101.Open;
      A023FGestGiustif.RefreshSelSG101;

      dcmbFamiliari.KeyValue:=null;
      with A023FTimbratureDtM1.A023FTimbratureMW.A000FGestioneTimbraGiustMW do
      begin
        if FGiustificativi[Day,Col].DataNas <> 0 then
          //dcmbFamiliari.KeyValue:=DateTimeToStr(FGiustificativi[Day,Col].DataNas); // daniloc 30.08.2010
          dcmbFamiliari.KeyValue:=FGiustificativi[Day,Col].DataNas;
        OldValidata:=IfThen(FGiustificativi[Day,Col].Validata = 'S','V','');
      end;
    end;
    try
      with A023FGestGiustif do
      begin
        if ShowModal = mrOk then
        begin
          //Carico i dati della causale modificata
          NewGiustif.Inserimento:=True;
          case RGTipoGiust.ItemIndex of
            0:NewGiustif.Modo:='I';
            1:NewGiustif.Modo:='M';
            2:NewGiustif.Modo:='N';
            3:NewGiustif.Modo:='D';
          end;
          // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
          NewGiustif.CSITipoMG:='';
          if rgpTipoMG.Visible then
          begin
            case rgpTipoMG.ItemIndex of
              0: NewGiustif.CSITipoMG:='M';
              1: NewGiustif.CSITipoMG:='P';
            else
            end;
          end;
          // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
          NewGiustif.Causale:=sCausale;//ECausale.Text;
          NewGiustif.DaOre:=EDaOre.Text;
          NewGiustif.AOre:=EAOre.Text;
          NewDataNas:=0;
          if dcmbFamiliari.KeyValue <> null then
            NewDataNas:=StrToDateTime(dcmbFamiliari.Text);
          //Controllo se il giustificativo è stato modificato
          if Modificata then
          begin
            Result:=A023FTimbratureDtM1.A023FTimbratureMW.ConfermaModifica(RGCausali.ItemIndex,
                                                                           Data,
                                                                           NewDataNas,
                                                                           OldDataNas,
                                                                           OldGiustif,
                                                                           NewGiustif,
                                                                           TipoGiust,
                                                                           ProgCausOrig,
                                                                           OldValidata,
                                                                           Col,
                                                                           L133GGModif);
            // controllo competenze giustificativi futuri relativi alla causale vecchia e a quella nuova
            if Parametri.CampiRiferimento.C23_ContrCompetenze = 'S' then
            begin
              if OldDataNas = 0 then
                StrOldDataNas:=''
              else
                StrOldDataNas:=DateTimeToStr(OldDataNas);
              if NewDataNas = 0 then
                StrNewDataNas:=''
              else
                StrNewDataNas:=DateTimeToStr(NewDataNas);
              Ng1:=A023FTimbratureMW.R600DtM1.ContaGiustifAssFuturi(C700Progressivo,Data,OldGiustif,StrOldDataNas);
              if (OldGiustif.Causale <> NewGiustif.Causale) or (OldDataNas <>  NewDataNas) then
                Ng2:=A023FTimbratureMW.R600DtM1.ContaGiustifAssFuturi(C700Progressivo,Data,NewGiustif,StrNewDataNas)
              else
                Ng2:=0;
              if (Ng1 + Ng2 > 0) then
              begin
                MsgCaus:=Format(A000MSG_A023_MSG_FMT_NCAUS,[IntToStr(Ng1),OldGiustif.Causale]);
                if (OldGiustif.Causale <> NewGiustif.Causale) then
                  MsgCaus:=MsgCaus + Format(A000MSG_A023_MSG_FMT_NCAUS,[IntToStr(Ng2),NewGiustif.Causale]);
                if R180MessageBox(Format(A000MSG_A023_DLG_FMT_RIALLINEA,[MsgCaus]),DOMANDA) = mrYes then
                begin
                  if Ng1 > 0 then
                    A023FTimbratureMW.R600DtM1.GestioneGiustifAssFuturi(C700Progressivo,Data,OldGiustif,StrOldDataNas);
                  if Ng2 > 0 then
                    A023FTimbratureMW.R600DtM1.GestioneGiustifAssFuturi(C700Progressivo,Data,NewGiustif,StrNewDataNas);
                  AssFutureElab:=True;
                  R180MessageBox('Elaborazione terminata',INFORMA);
                end;
              end;
            end;
          end;
        end;
      end;
    finally
      FreeAndNil(A023FTimbratureMW.R600DtM1);
      A023FGestGiustif.Release;
      A023FTimbratureDtM1.A023FTimbratureMW.getDataGestGiustif:=nil;
      A023FTimbratureDtM1.A023FTimbratureMW.getCausaleGestGiustif:=nil;
    end;
  end;
  if L133GGModif or AssFutureElab then
    CaricaMese;
end;

procedure TA023FTimbrature.GTimbrat1Enter(Sender: TObject);
{Disabilita i menu Timbrature/Giustificativi}
var Ind, Day:Byte;
begin
  if (Sender as TStringGrid).Tag < 10 then
  begin
    Day:=Giorno + (Sender as TStringGrid).Tag - 1;
    Timbrature1.Enabled:=True;
  end
  else
  begin
    Day:=Giorno + (Sender as TStringGrid).Tag - 11;
    Giustificativi1.Enabled:=True;
  end;
  //Indice dell'Array FGriglie
  Ind:=Day - Giorno + 1;
  if Day > A023FTimbratureDtM1.A023FTimbratureMW.MaxGiorni then exit;
  //Richiamo i conteggi
  if SBConteggi.Down then
  begin
    LAnomalie.Clear;
    Conteggi(Ind,EncodeDate(EAnno.Value,EMese.Value,Day));
  end;
end;

procedure TA023FTimbrature.GTimbrat1Exit(Sender: TObject);
{Disabilita i menu Timbrature/Giustificativi}
begin
  if (Sender as TStringGrid).Tag < 10 then
    Timbrature1.Enabled:=False
  else
    Giustificativi1.Enabled:=False;
end;

procedure TA023FTimbrature.GTimbrat1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
{Visualizza la descrizione della causale}
var
  Griglia:TStringGrid;
  Day,Row,Col:LongInt;
  NewCausale:String;
  procedure Pulisci;
  begin
    NewCausale:='';
    HintCausale:='';
    StatusBar.Panels[2].Text:='';
    Griglia.Hint:='';
    StatusBar.Repaint;
  end;
begin
  try
    Griglia:=(Sender as TStringGrid);
    Griglia.MouseToCell(X,Y,Col,Row);
    if Row <> 1 then
      exit;
    if Griglia.Tag > 10 then
    begin
      Day:=Giorno + Griglia.Tag - 11;
      // verifica range
      if Col + 1 > MaxGiustif then
      begin
        Pulisci;
        Exit;
      end;
      with A023FTimbratureDtM1.A023FTimbratureMW.A000FGestioneTimbraGiustMW do
      begin
        if FGiustificativi[Day,Col + 1].Causale = '' then
        begin
          Pulisci;
          Exit;
        end;
        NewCausale:=FGiustificativi[Day,Col + 1].Causale
      end;
    end
    else
    begin
      if Col = 0 then
      begin
        Pulisci;
        Exit;
      end;
      Day:=Giorno + Griglia.Tag - 1;  {Il giorno rappresentato dalla griglia}
      // verifica range
      if Col + 1 > MaxTimbrature then
      begin
        Pulisci;
        Exit;
      end;
      with A023FTimbratureDtM1.A023FTimbratureMW.A000FGestioneTimbraGiustMW do
      begin
        if FTimbrature[Day,Col + 1].Causale = '' then
        begin
          Pulisci;
          Exit;
        end;
        NewCausale:=FTimbrature[Day,Col+1].Causale
      end;
    end;
    if HintCausale = NewCausale then
      Exit;
    HintCausale:=NewCausale;
    StatusBar.Panels[2].Text:=A023FTimbratureDtM1.A023FTimbratureMW.DescrizioneCausale(NewCausale);
    Griglia.Hint:=StatusBar.Panels[2].Text;
    StatusBar.Repaint;
  except
    Pulisci;
  end;
end;

procedure TA023FTimbrature.GTimbrat2SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
var Day:Integer;
begin
  inherited;
  {Gestione abilitazione cancellazione timbrature originali/modificate}
  if (Sender as TStringGrid).Tag > 10 then
    Day:=Giorno + (Sender as TStringGrid).Tag - 11
  else
    Day:=Giorno + (Sender as TStringGrid).Tag - 1;
  Cancella1.Enabled:=False;
  Cancella2.Enabled:=False;
  if Day > A023FTimbratureDtM1.A023FTimbratureMW.MaxGiorni then exit;
  //Caratto 1/8/2013 Se si è arrivati a maxTImbrature, l'ultima colonna è fuori range
  if ACol = MaxTimbrature then exit;
  Cancella1.Enabled:=(not SolaLettura) and
                     (((A023FTimbratureDtM1.A023FTimbratureMW.A000FGestioneTimbraGiustMW.FTimbrature[Day,ACol + 1].Flag = 'O') and (Parametri.T100_CancTimbOrig = 'S')) or
                      ((A023FTimbratureDtM1.A023FTimbratureMW.A000FGestioneTimbraGiustMW.FTimbrature[Day,ACol + 1].Flag = 'I') and (Parametri.CancellaTimbrature = 'S')));
  Cancella2.Enabled:=Cancella1.Enabled;
end;

procedure TA023FTimbrature.SBConteggiClick(Sender: TObject);
{Abilita/disabilita i conteggi in tempo reale}
var Inizio,Fine:TDateTime;
    i,G:Byte;
begin
  with SBConteggi do
    begin
    if Down then
      //Apro le tabelle dei conteggi estraendo i dati del mese su cui sono posizionato
      begin
      for i:=0 to PConteggi.ControlCount - 1 do
        (PConteggi.Controls[i] as TLabel).Caption:=#0;
      Hint:='Conteggi on';
      Inizio:=EncodeDate(EAnno.Value,EMese.Value,1);
      Fine:=EncodeDate(EAnno.Value,EMese.Value,A023FTimbratureDtM1.A023FTimbratureMW.MaxGiorni);
      if A023FGestMese <> nil then
      try
        if A023FGestMese.Visible then
          A023FTimbratureDtM1.A023FTimbratureMW.R502ProDtM1.ResettaProg;
      except
      end;
      A023FTimbratureDtM1.A023FTimbratureMW.R502ProDtM1.PeriodoConteggi(Inizio,Fine);
      DisegnaGriglie:=True;
      //Calcolo ore lavorate nei giorni su cui sono gia' posizionato
      LAnomalie.Clear;
      for G:=Giorno to Giorno + 5 do
        begin
        if G > A023FTimbratureDtM1.A023FTimbratureMW.MaxGiorni then
          begin
          FGriglie[G-Giorno+1].OreLavorate.Caption:='';
          FGriglie[G-Giorno+1].Scostamento.Caption:='';
          FGriglie[G-Giorno+1].Debito.Caption:='';
          FGriglie[G-Giorno+1].EscluseDaNorm.Caption:='';
          end
        else
          Conteggi(G-Giorno+1,EncodeDate(EAnno.Value,EMese.Value,G));
        end;
      end
    else
      //Chiudo i conteggi
      Hint:='Conteggi off';
    PConteggi.Visible:=Down;
    end;
end;

procedure TA023FTimbrature.EOrario1DblClick(Sender: TObject);
{Gestione pianificazione turni}
var Data:TDateTime;
    Day:Byte;
    IndPre:String;
begin
  Day:=Giorno;
  if ActiveControl <> nil then
    if ActiveControl.Tag > 10 then
      Day:=Day + ActiveControl.Tag - 11
    else if ActiveControl.Tag > 0 then
      Day:=Day + ActiveControl.Tag - 1;
  IndPre:='';
  Data:=EncodeDate(EAnno.Value,EMese.Value,Day);
  with A023FTimbratureDtM1.A023FTimbratureMW.Q080 do
    if Locate('Data',Data,[]) then IndPre:=FieldByName('IndPresenza').AsString;
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA025Pianif(C700Progressivo,FGriglie[Day - Giorno + 1].Orario.Text,IndPre,Format('%-4s',[FGriglie[Day - Giorno + 1].Turni.Caption]),Data,True);
  with A023FTimbratureDtM1 do
  begin
    C700DatiSelezionati:=C700CampiBase;
    C700Creazione(SessioneOracle);
    C700OldProgressivo:=-1;
    frmSelAnagrafe.RipristinaC00SelAnagrafe(A023FTimbratureDtM1.A023FTimbratureMW);
    //Aggiorno le modifiche della pianificazione
    A023FTimbratureMW.Q080.Close;
    A023FTimbratureMW.Q080.Open;
  end;
  //R502ProDtM1.PeriodoConteggi(Data, Data - 1);
  A023FTimbratureDtM1.A023FTimbratureMW.R502ProDtM1.Q080.Close;
  A023FTimbratureDtM1.A023FTimbratureMW.R502ProDtM1.PeriodoConteggi(EncodeDate(EAnno.Value,EMese.Value,1),R180FineMese(EncodeDate(EAnno.Value,EMese.Value,1)));
  CaricaGriglie;
end;

procedure TA023FTimbrature.Conteggi(Ind:Byte; Giorno:TDateTime);
{Richiama i conteggi e li visualizza nelle TLabel}
var
  ConteggiGiornalieri: TConteggiGiorno;
  s: String;
begin
  A023FTimbratureDtM1.A023FTimbratureMW.CaricaTimbratureGiustificativi;

  ConteggiGiornalieri:=A023FTimbratureDtM1.A023FTimbratureMW.ConteggiGiornalieri(Giorno);
  if ConteggiGiornalieri.Repaint then
    FGriglie[Ind].Timbrat.Repaint;

  FGriglie[Ind].OreLavorate.Caption:=ConteggiGiornalieri.OreLavorate;
  FGriglie[Ind].Scostamento.Caption:=ConteggiGiornalieri.Scostamento;
  FGriglie[Ind].Debito.Caption:=ConteggiGiornalieri.Debito;
  FGriglie[Ind].EscluseDaNorm.Caption:=ConteggiGiornalieri.EscluseDaNorm;

  for s in A023FTimbratureDtM1.A023FTimbratureMW.getLstAnomalieConteggiGiornalieri do
    LAnomalie.Add(s);

  if ConteggiGiornalieri.Blocca then
    Exit;

  if ConteggiGiornalieri.Orario <> '' then
  begin
    if ConteggiGiornalieri.orarioFontNero then
      FGriglie[Ind].Orario.Font.Color:=clBlack;

    FGriglie[Ind].Orario.Text:=ConteggiGiornalieri.Orario;
  end;

  if ConteggiGiornalieri.TurniDaConteggio then
  begin
    FGriglie[Ind].Turni.Caption:=ConteggiGiornalieri.Turni;
    if ConteggiGiornalieri.TurniFontNero then
      FGriglie[Ind].Turni.Font.Color:=clBlack;
  end;

end;


procedure TA023FTimbrature.SpeedButton2Click(Sender: TObject);
begin
  A023FAnomalie:=TA023FAnomalie.Create(nil);
  with A023FAnomalie do
    try
      Memo1.Lines.Clear;
      Memo1.Lines.Assign(LAnomalie);
      ShowModal;
    finally
      Release;
    end;
end;

procedure TA023FTimbrature.ConteggiDiServizioClick(Sender: TObject);
{Richiamo di SC}
var Tag:Byte;
begin
  Tag:=0;
  //Se una griglia ha il fuoco, richiamo i conteggi del giorno
  if ActiveControl is TStringGrid then
    begin
    Tag:=ActiveControl.Tag;
    if Tag > 10 then
      Dec(Tag,10);
    Dec(Tag);
    end;
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA028Sc(C700Progressivo,EncodeDate(EAnno.Value,EMese.Value,Giorno + Tag));
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A023FTimbratureDtM1.A023FTimbratureMW);
end;

procedure TA023FTimbrature.SpeedButton4Click(Sender: TObject);
{Richiamo stampa del cartellino}
begin
  Tag:=0;
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA027CarMen(C700Progressivo,EncodeDate(EAnno.Value,EMese.Value,1));
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A023FTimbratureDtM1.A023FTimbratureMW);
  CaricaMese;
end;

procedure TA023FTimbrature.Splitter1CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  //Accept:=(NewSize >= 272);
  if NewSize < 275 then
    NewSize:=275;
  inherited;
end;

procedure TA023FTimbrature.Splitter1Moved(Sender: TObject);
begin
  inherited;
  AfterResizeElementiForm;
end;

procedure TA023FTimbrature.DoppioClickTimb(Sender: TObject);
var Col,Day : Byte;
    Data : TDateTime;
    menuItem: TMenuItem;
begin
  if SolaLettura or (C700SelAnagrafe.RecordCount = 0) then exit;
  Col:=TStringGrid(Sender).Col;
  Day:=Giorno+TStringGrid(Sender).Tag-1;  {Il giorno rappresentato dalla griglia}
  if Day > A023FTimbratureDtM1.A023FTimbratureMW.MaxGiorni then exit;
  Data:=StrToDate(IntToStr(Day)+'/'+IntToStr(EMese.Value)+'/'+IntToStr(EAnno.Value));

  if Col < A023FTimbratureDtM1.A023FTimbratureMW.A000FGestioneTimbraGiustMW.FNumTimbrature[Day] then
    menuItem:=Modifica3
  else
    menuItem:=Inserisci3;

  GestioneTimb(menuItem);
  if ShowOK=False then
    begin
      InsTimbratura(Data,Day,Col,TStringGrid(Sender).Tag);
      A023FTimbratureDtM1.A023FTimbratureMW.Q100.Close;
      A023FTimbratureDtM1.A023FTimbratureMW.Q100.Open;
    end;
end;

procedure TA023FTimbrature.GestisciKeyDownTimb(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = vk_Delete)and(Shift=[])then
    begin
      GestioneTimb(Cancella2); // richiamo la procedura generale di gestione timbrature.
                               // In questo caso gestisco Cancellazione.
    end
  else
    if (Key = vk_F2)and(Shift=[]) then
      begin
          GestioneTimb(Modifica3); // richiamo la procedura generale di gestione timbrature.
                                  // In questo caso gestisco MODIFICA.
      end
    else
      if (Key = vk_Return)and(Shift=[]) then
        begin
         GestioneTimb(Inserisci3); // richiamo la procedura generale di gestione timbrature.
                                  // In questo caso gestisco INSERIMENTO.
        end;
end;

procedure TA023FTimbrature.DoppioClickGiust(Sender: TObject);
var Col,Day : Byte;
    Data : TDateTime;
begin
  if SolaLettura or (C700SelAnagrafe.RecordCount = 0) then exit;
  Col:=TStringGrid(Sender).Col + 1;
  Day:=Giorno+TStringGrid(Sender).Tag-11;  {Il giorno rappresentato dalla griglia}
  Data:=StrToDate(IntToStr(Day)+'/'+IntToStr(EMese.Value)+'/'+IntToStr(EAnno.Value));
  GestioneTimb(MenuItem3);
  if not ShowOK then
    if InsCancGiustif(Data,Day,Col) then
      CaricaMese;
end;

procedure TA023FTimbrature.GestisciKeyDownGiust(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = vk_Delete)and(Shift=[])then
    GestioneTimb(MenuItem1) // richiamo la procedura generale di gestione timbrature.
                               // In questo caso gestisco Cancellazione.
  else if (Key = vk_F2)and(Shift=[]) then
    GestioneTimb(MenuItem3) // richiamo la procedura generale di gestione timbrature.
                                  // In questo caso gestisco MODIFICA.
  else if (Key = vk_Return)and(Shift=[]) then
    GestioneTimb(MenuItem1); // richiamo la procedura generale di gestione timbrature.
                                  // In questo caso gestisco INSERIMENTO.
end;

procedure TA023FTimbrature.GestisciMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Col,Row:Integer;
begin
  if Button = mbRight then
  begin
    TStringGrid(Sender).MouseToCell(X,Y,Col,Row);
    if (Col >= 0) and (Col < TStringGrid(Sender).ColCount) then
      TStringGrid(Sender).Col:=Col;
    if (Row >= 0) and (Row < TStringGrid(Sender).RowCount) then
      TStringGrid(Sender).Row:=Row;
  end;
end;

procedure TA023FTimbrature.SpMeseClick(Sender: TObject);
begin
  A023FTimbMese:=TA023FTimbMese.Create(nil);
  try
    A023FTimbMese.SN:=SN;
    A023FTimbMese.Anno:=Anno;
    A023FTimbMese.Mese:=Mese;
    A023FTimbMese.Progressivo:=C700Progressivo;
    A023FTimbMese.Q040:=A023FTimbratureDtM1.A023FTimbratureMW.Q040;
    A023FTimbMese.Q100:=A023FTimbratureDtM1.A023FTimbratureMW.Q100;
    A023FTimbMese.Q275:=A023FTimbratureDtM1.A023FTimbratureMW.Q275;
    A023FTimbMese.Q305:=A023FTimbratureDtM1.A023FTimbratureMW.Q305;
    A023FTimbMese.CaricaEdit;
    A023FTimbMese.ShowModal;
  finally
    A023FTimbMese.Release;
  end;
end;

procedure TA023FTimbrature.SpCorrezioneClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  A023FCorrezione.Show;
  if A023FCorrezione.BtnAvvio.Enabled then
    A023FCorrezione.BtnAvvioClick(nil);
end;

procedure TA023FTimbrature.Ripristinotimbratureoriginali1Click(
  Sender: TObject);
{Ripristino timbrature originali nel periodo specificato
 oppure
 Richiamo allineamento timbrature con stessa ora}
var Day:Word;
begin
  if A023FTimbratureDtM1.A023FTimbratureMW.DatoBloccato(EncodeDate(EAnno.Value,EMese.Value,1)) then
    raise Exception.Create(A023FTimbratureDtM1.A023FTimbratureMW.selDatiBloccati.MessaggioLog);

  // salva il giorno selezionato del mese
  if ActiveControl is TStringGrid then
  begin
    Day:=(ActiveControl as TStringGrid).Tag;
    if Day > 10 then
      Dec(Day,10);
    Day:=Day + Giorno - 1;
  end
  else
  begin
    Day:=Giorno;
  end;

  // MONDOEDP - commessa MAN/02 - SVILUPPO 92.ini
  if Sender = Ripristinotimbratureoriginali1 then
  begin
    A023FRipristinoTimbOrig:=TA023FRipristinoTimbOrig.Create(nil);
    try
      // variabili di riferimento
      A023FRipristinoTimbOrig.Progressivo:=C700Progressivo;
      A023FRipristinoTimbOrig.DataInizio:=EncodeDate(EAnno.Value,EMese.Value,Day);
      A023FRipristinoTimbOrig.DataFine:=A023FRipristinoTimbOrig.DataInizio;

      // imposta interfaccia con date di riferimento
      A023FRipristinoTimbOrig.lblMese.Caption:=R180Capitalize(FormatDateTime('mmmm yyyy',A023FRipristinoTimbOrig.DataInizio));
      A023FRipristinoTimbOrig.sedtDal.MaxValue:=R180GiorniMese(A023FRipristinoTimbOrig.DataInizio);
      A023FRipristinoTimbOrig.sedtAl.MaxValue:=R180GiorniMese(A023FRipristinoTimbOrig.DataInizio);
      A023FRipristinoTimbOrig.sedtDal.OnChange:=nil;
      A023FRipristinoTimbOrig.sedtAl.OnChange:=nil;
      A023FRipristinoTimbOrig.sedtDal.Value:=Day;
      A023FRipristinoTimbOrig.sedtAl.Value:=Day;
      A023FRipristinoTimbOrig.sedtDal.OnChange:=A023FRipristinoTimbOrig.sedtDalChange;
      A023FRipristinoTimbOrig.sedtAl.OnChange:=A023FRipristinoTimbOrig.sedtAlChange;

      // se il ripristino è stato confermato ricarica i dati del cartellino
      if A023FRipristinoTimbOrig.ShowModal = mrOk then
      begin
        CaricaMese;
      end;
    finally
      FreeAndNil(A023FRipristinoTimbOrig);
    end;
  end
  // MONDOEDP - commessa MAN/02 - SVILUPPO 92.fine
  // MONDOEDP - commessa MAN/02 SVILUPPO 106.ini
  else if Sender = Allineamentotimbratureuguali1 then
  begin
    A023FAllTimbUguali:=TA023FAllTimbUguali.Create(nil);
    try
      // variabili di riferimento
      A023FAllTimbUguali.DatiAnag:=TA023FAllTimbMW.GetDatiAnag(C700Progressivo,C700SelAnagrafe.FieldByName('COGNOME').AsString,C700SelAnagrafe.FieldByName('NOME').AsString,C700SelAnagrafe.FieldByName('MATRICOLA').AsString);
      A023FAllTimbUguali.DataInizio:=EncodeDate(EAnno.Value,EMese.Value,Day);
      A023FAllTimbUguali.DataFine:=A023FAllTimbUguali.DataInizio;

      // imposta interfaccia con date di riferimento
      A023FAllTimbUguali.lblMese.Caption:=R180Capitalize(FormatDateTime('mmmm yyyy',A023FAllTimbUguali.DataInizio));
      A023FAllTimbUguali.sedtDal.MaxValue:=R180GiorniMese(A023FAllTimbUguali.DataInizio);
      A023FAllTimbUguali.sedtAl.MaxValue:=R180GiorniMese(A023FAllTimbUguali.DataInizio);
      A023FAllTimbUguali.sedtDal.OnChange:=nil;
      A023FAllTimbUguali.sedtAl.OnChange:=nil;
      A023FAllTimbUguali.sedtDal.Value:=Day;
      A023FAllTimbUguali.sedtAl.Value:=Day;
      A023FAllTimbUguali.sedtDal.OnChange:=A023FAllTimbUguali.sedtDalChange;
      A023FAllTimbUguali.sedtAl.OnChange:=A023FAllTimbUguali.sedtAlChange;

      // apre dataset per visualizzare timbrature uguali
      A023FAllTimbUguali.AggiornaVistaTimbrature(A023FAllTimbUguali.DatiAnag,A023FAllTimbUguali.DataInizio,A023FAllTimbUguali.DataFine);

      if A023FAllTimbUguali.ShowModal = mrOk then
      begin
        A023FTimbratureDtM1.A023FTimbratureMW.AllineamentoTimbraturePeriodo(A023FAllTimbUguali.DataInizio,A023FAllTimbUguali.DataFine);
        CaricaMese;
        R180MessageBox('Elaborazione avvenuta.',INFORMA);
      end
      // MONDOEDP - MAN/02 SVILUPPO 106.ini
      else
      begin
        // se sono state scambiate manualmente delle timbrature aggiorna la vista
        if A023FAllTimbUguali.ScambiManualiEffettuati then
          CaricaMese;
      end;
      // MONDOEDP - MAN/02 SVILUPPO 106.fine
    finally
      FreeAndNil(A023FAllTimbUguali);
    end;
  end
  else
  // MONDOEDP - commessa MAN/02 SVILUPPO 106.fine
  begin
    // timbrature riscaricate
    A023FCancTimbRiscaricate:=TA023FCancTimbRiscaricate.Create(nil);
    try
      //Caratto 12/09/2013. Operare solo su selezione corrente
      //frmSelAnagrafe1.Visible:=Sender = Allineamentotimbratureuguali1;
      //chkTuttiDipendenti.Visible:=Sender = Eliminazionetimbratureriscaricate1;
      A023FCancTimbRiscaricate.frmSelAnagrafe1.Visible:=False;
      A023FCancTimbRiscaricate.chkTuttiDipendenti.Visible:=False;
      //fine
      A023FCancTimbRiscaricate.DataInizio:=EncodeDate(EAnno.Value,EMese.Value,Day);
      A023FCancTimbRiscaricate.DataFine:=A023FCancTimbRiscaricate.DataInizio;
      A023FCancTimbRiscaricate.LblDaData.Caption:=FormatDateTime('mmmm yyyy',A023FCancTimbRiscaricate.DataInizio);
      A023FCancTimbRiscaricate.SBDaGG.MaxValue:=R180GiorniMese(A023FCancTimbRiscaricate.DataInizio);
      A023FCancTimbRiscaricate.SBAGG.MaxValue:=R180GiorniMese(A023FCancTimbRiscaricate.DataInizio);
      A023FCancTimbRiscaricate.SBDaGG.Value:=Day;
      A023FCancTimbRiscaricate.SBAGG.Value:=Day;
      if A023FCancTimbRiscaricate.ShowModal = mrOK then
      begin
        Screen.Cursor:=crHourGlass;
        A023FTimbratureDtM1.A023FTimbratureMW.EliminaTimbratureDoppie(A023FCancTimbRiscaricate.chkTuttiDipendenti.Checked,A023FCancTimbRiscaricate.DataInizio,A023FCancTimbRiscaricate.DataFine);
        CaricaMese;
      end;
    finally
      Screen.Cursor:=crDefault;
      A023FCancTimbRiscaricate.Release;
    end;
  end;
end;
(* Caratto 12/09/2013
Spostato su MW e considerato solo progressivo corrente, no C700
procedure TA023FTimbrature.AllineamentoTimbrature(DataI,DataF:TDateTime);
begin
  A023FAllTimb:=TA023FAllTimb.Create(nil);
  with A023FAllTimb do
    try
      Q100.Session:=SessioneOracle;
      Q100Upd.Session:=SessioneOracle;
      //Scorro dipendenti selezionati
      C700SelAnagrafe.First;
      while not C700SelAnagrafe.EOF do
      begin
        Allinea(C700Progressivo,DataI,DataF);
        CaricaMese;
        C700SelAnagrafe.Next;
      end;
    finally
      Free;
      R180MessageBox('Elaborazione avvenuta.','INFORMA');
    end;
end;
*)
// commessa MAN/02 - SVILUPPO 92.ini
{
procedure TA023FTimbrature.RipristinaOriginali(Inizio,Fine:TDateTime);
//Processo di ripristino timbrature originali: cancello tutte le timbrature
//con flag = 'I' e modifico le timbrature con Flag = 'M' o 'C' settando Flag = 'O'
begin
  with A023FTimbratureDtM1 do
  begin
    Q100Delete.SetVariable('Data1',Inizio);
    Q100Delete.SetVariable('Data2',Fine);
    Q100Delete.SetVariable('Progressivo',C700Progressivo);
    Q100Update.SetVariable('Data1',Inizio);
    Q100Update.SetVariable('Data2',Fine);
    Q100Update.SetVariable('Progressivo',C700Progressivo);
    Q100Delete.Execute;
    Q100Update.Execute;
    SessioneOracle.Commit;
    CaricaMese;
  end;
end;
}
// commessa MAN/02 - SVILUPPO 92.fine

procedure TA023FTimbrature.Correzionetimbrature1Click(Sender: TObject);
begin
  SpCorrezioneClick(Self);
end;

procedure TA023FTimbrature.ValidazioneTimbrature1Click(Sender: TObject);
begin
  inherited;
  OpenA023CaricaTimbRich;
  CaricaMese;
end;

procedure TA023FTimbrature.VisualizzaAssenze(Data:TDateTime; Day,Col:Byte);
{Visualizzazione competenze/residui assenze}
var Giustif:TGiustificativo;
begin
  with A023FTimbratureDtM1.A023FTimbratureMW do
  begin
    Giustif.Inserimento:=False;
    Giustif.Modo:='I';
    Giustif.Causale:=A000FGestioneTimbraGiustMW.FGiustificativi[Day,Col].Causale;
    R600DtM1:=TR600DtM1.Create(Self);
    try
      R600DtM1.RiferimentoDataNascita.Data:=A000FGestioneTimbraGiustMW.FGiustificativi[Day,Col].DataNas;
      R600DtM1.VisualizzaAssenze(C700Progressivo,Data,Giustif);
    finally
      FreeAndNil(R600DtM1);
    end;
  end;
end;

procedure TA023FTimbrature.Nuovoelemento1Click(Sender: TObject);
begin
  OpenA006ModelliOrario((PopupMenu3.PopupComponent as TEdit).Text);
  A023FTimbratureDtM1.A023FTimbratureMW.R502ProDtM1.Resetta;
  SBConteggiClick(SBConteggi);
end;

procedure TA023FTimbrature.AggData(Data: TDateTime);
begin
  A023FTimbratureDtM1.A023FTimbratureMW.AggDataControllo(Data);
  if Data = 0 then
    LData.Caption:=''
  else
    LData.Caption:=FormatDateTime('dd/mm/yyyy',Data);
end;

procedure TA023FTimbrature.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  try
    C700DataLavoro:=R180FineMese(EncodeDate(Anno,Mese,Giorno));
  except
    C700Datalavoro:=R180FineMese(Parametri.DataLavoro);
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA023FTimbrature.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  try
    C005DataVisualizzazione:=EncodeDate(Anno,Mese,Giorno);
  except
    C005DataVisualizzazione:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA023FTimbrature.FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
  inherited;
  Resize:=True;
  if NewWidth < 530 then
    NewWidth:=530;
end;

procedure TA023FTimbrature.FormClose(Sender: TObject;
  var Action: TCloseAction);
{Chiude storici e conteggi }
begin
  LAnomalie.Free;
  LStorico.Free;
end;

procedure TA023FTimbrature.FormDestroy(Sender: TObject);
begin
  A023FCorrezione.Free;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

end.
