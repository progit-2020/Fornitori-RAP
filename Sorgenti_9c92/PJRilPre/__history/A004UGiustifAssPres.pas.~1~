unit A004UGiustifAssPres;

interface

uses
  A004UGiustifAssPresMW,
  A000UCostanti, A000UMessaggi, A000USessione, A000UInterfaccia,
  A016UCausAssenze, A020UCausPresenze, A083UMsgElaborazioni,
  C004UParamForm, C005UDatiAnagrafici, C180FunzioniGenerali,
  C700USelezioneAnagrafe,  R600,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TABELLE99, ExtCtrls, StdCtrls, Mask, Menus, ComCtrls, DBCtrls, Buttons,
  Grids, DBGrids, OracleData, Spin, SelAnagrafe, Variants, Oracle, DB,
  StrUtils, A087UImpAttestatiMalMW;

type
  TA004FGiustifAssPres = class(TFrmTabelle99)
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    LAOre: TLabel;
    EAOre: TMaskEdit;
    RGTipoGiust: TRadioGroup;
    ECausale: TDBLookupComboBox;
    LCausale: TDBText;
    RGCausali: TRadioGroup;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    DBGrid1: TDBGrid;
    PopupMenu2: TPopupMenu;
    Refresh1: TMenuItem;
    Copiaimpostazioni1: TMenuItem;
    CompetenzeResidui1: TMenuItem;
    frmSelAnagrafe: TfrmSelAnagrafe;
    LDaOre: TLabel;
    EDaOre: TMaskEdit;
    rgpGestione: TRadioGroup;
    lblFamiliari: TLabel;
    dcmbFamiliari: TDBLookupComboBox;
    Causaleselezionata1: TMenuItem;
    CaricaAssenze: TMenuItem;
    PopupMenu3: TPopupMenu;
    Nuovoelemento2: TMenuItem;
    btnRecapitoAlternativo: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    EDaData: TMaskEdit;
    EAData: TMaskEdit;
    SpinEdit1: TSpinEdit;
    chkNuovoPeriodo: TCheckBox;
    lblNote: TLabel;
    edtNote: TEdit;
    CompetenzeResidui2: TMenuItem;
    ProgressBar: TProgressBar;
    BInserisci: TBitBtn;
    BCancella: TBitBtn;
    btnAnomalie: TBitBtn;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    rgpTipoMG: TRadioGroup;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    procedure EADataDblClick(Sender: TObject);
    procedure PopupMenu3Popup(Sender: TObject);
    procedure Nuovoelemento2Click(Sender: TObject);
    procedure ECausaleKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RGTipoGiustClick(Sender: TObject);
    procedure BInserisciClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RGCausaliClick(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure EDaDataExit(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Copiaimpostazioni1Click(Sender: TObject);
    procedure CompetenzeResidui1Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure EADataChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TfrmSelAnagrafe1R003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnRicercaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rgpGestioneClick(Sender: TObject);
    procedure Causaleselezionata1Click(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure CaricaAssenzeClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure btnRecapitoAlternativoClick(Sender: TObject);
    procedure dcmbFamiliariEnter(Sender: TObject);
    procedure ECausaleCloseUp(Sender: TObject);
    procedure ECausaleKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EDaDataChange(Sender: TObject);
    procedure ECausaleContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure CompetenzeResidui2Click(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dcmbFamiliariCloseUp(Sender: TObject);
  private
    Assenza:Boolean;
    DataNasIniziale: TDateTime;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    GestioneTipoMezzaGiornata: Boolean;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    procedure CambiaProgressivo;
    procedure AbilitaRecapitoVisiteFiscali(Abilitato: Boolean);
    function  GetVisitaFiscale: String;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    function  GetRecapitoAbilitato: Boolean;
    procedure AbilitaTipoFruizione;
    procedure AbilitaNote;
    procedure RefreshSelSG101;
    procedure INPS_TO_CSI_InsCanc; inline;
    procedure ImpostaHintFamiliare;
  public
    A004MW: TA004FGiustifAssPresMW;
    RecapitoAbilitato: Boolean;
  end;

{$IFNDEF IRISWEB}
var
  A004FGiustifAssPres: TA004FGiustifAssPres;
{$ENDIF IRISWEB}

procedure OpenA004GiustifAssPres(Prog:LongInt; Data,Tipo,TipoMG,Ore1,Ore2,Causale:String; DataNas:TDateTime; Cartel:Boolean);
procedure OpenA004daA139(Prog:String; Data,Tipo,Ore1,Ore2,Causale:String; DataNas:TDateTime; Cartel:Boolean);
procedure OpenA004GiustifGruppo(Prog:LongInt);

implementation

uses  A004UCaricaAssRich,
      S031UFamiliari, A004URecapitoVisFiscali;

{$R *.DFM}

procedure OpenA004GiustifAssPres(Prog:LongInt; Data,Tipo,TipoMG,Ore1,Ore2,Causale:String; DataNas:TDateTime; Cartel:Boolean);
{Cartel:
   False = da Anagrafico
   True  = da Cartellino}
begin
  if Prog <= 0 then
  begin
    R180MessageBox('Nessun dipendente selezionato!',INFORMA);
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA004GiustifAssPres') of
    'N':begin
          R180MessageBox('Funzione non abilitata!',INFORMA);
          Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A004FGiustifAssPres:=TA004FGiustifAssPres.Create(nil);
  with A004FGiustifAssPres do
  try
    C700Progressivo:=Prog;
    if Cartel then
    begin
      EDaData.Text:=Data;
      EAData.Text:=Data;
      if A004MW.Q275.Locate('Codice',String(Causale),[]) then
        RGCausali.ItemIndex:=0
      else
        RGCausali.ItemIndex:=1;
      if Trim(Causale) <> '' then
        ECausale.KeyValue:=String(Causale);
      DataNasIniziale:=DataNas;
      with RGTipoGiust do
      begin
        if Tipo = 'I' then
          ItemIndex:=0;
        if Tipo = 'M' then
          ItemIndex:=1;
        if Tipo = 'N' then
        begin
          if Items.Count = 4 then
            ItemIndex:=2
          else
            ItemIndex:=0;
        end;
        if Tipo = 'D' then
        begin
          if Items.Count = 4 then
            ItemIndex:=3
          else
            ItemIndex:=1;
        end;
      end;
      //Tipo mezza gg. mattino/pomeriggio
      if (Tipo = 'M') and (TipoMG = 'M') then
        rgpTipoMG.ItemIndex:=0
      else if (Tipo = 'M') and (TipoMG = 'P') then
        rgpTipoMG.ItemIndex:=1;
      if Ore1 <> '' then
        EDaOre.Text:=Ore1;
      if Ore2 <> '' then
        EAOre.Text:=Ore2;
    end
    else if Data <> '' then
    begin
      EDaData.Text:=Data;
      EAData.Text:=Data;
    end
    else
    begin
      EDaData.Text:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro);
      EAData.Text:=EDaData.Text; // commessa MAN/08 SVILUPPO#56 - riesame del 06.09.2013
    end;
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    Free;
  end;
  A004FGiustifAssPres:=nil;
end;

procedure OpenA004daA139(Prog:String; Data,Tipo,Ore1,Ore2,Causale:String; DataNas:TDateTime; Cartel:Boolean);
{Cartel:False = da Anagrafico - True = da Cartellino}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  A004FGiustifAssPres:=TA004FGiustifAssPres.Create(nil);
  with A004FGiustifAssPres do
  try
    if Cartel then
    begin
      EDaData.Text:=Data;
      EAData.Text:=Data;
      if A004MW.Q275.Locate('Codice',String(Causale),[]) then
        RGCausali.ItemIndex:=0
      else
        RGCausali.ItemIndex:=1;
      if Trim(Causale) <> '' then
        ECausale.KeyValue:=String(Causale);
      DataNasIniziale:=DataNas;
      with RGTipoGiust do
      begin
        if Tipo = 'I' then ItemIndex:=0;
        if Tipo = 'M' then ItemIndex:=1;
        if Tipo = 'N' then
          if Items.Count = 4 then ItemIndex:=2 else ItemIndex:=0;
        if Tipo = 'D' then
          if Items.Count = 4 then ItemIndex:=3 else ItemIndex:=1;
      end;
      if Ore1 <> '' then EDaOre.Text:=Ore1;
      if Ore2 <> '' then EAOre.Text:=Ore2;
    end
    else if Data <> '' then
    begin
      EDaData.Text:=Data;
      EAData.Text:=Data;
    end
    else
    begin
      EDaData.Text:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro);
      EAData.Text:=EDaData.Text; // commessa MAN/08 SVILUPPO#56 - riesame del 06.09.2013
    end;

    //Alberto: gestione per passare l'elenco dei progressivi da selezionare nella C700
    OnShow(nil);
    frmSelAnagrafe.OldSQLCreato.Text:='(T030.PROGRESSIVO IN (' + Prog + ')) ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA';
    C700Progressivo:=-1;
    C700FSelezioneAnagrafe.SQLCreato.Assign(frmSelAnagrafe.OldSQLCreato);
    C700FSelezioneAnagrafe.WhereSql:=C700FSelezioneAnagrafe.SQLCreato.Text;
    frmSelAnagrafe.SelezionePeriodica:=False;
    frmSelAnagrafe.SoloPersonaleInterno:=True;
    C700FSelezioneAnagrafe.PulisciVecchiaSelezione:=False;
    C700FSelezioneAnagrafe.actConfermaExecute(C700FSelezioneAnagrafe.actConferma);
    frmSelAnagrafe.NumRecords;
    CambiaProgressivo;
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    Free;
  end;
end;

procedure OpenA004GiustifGruppo(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA004GiustifGruppo') of
    'N':begin
          R180MessageBox('Funzione non abilitata!',INFORMA);
          Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A004FGiustifAssPres:=TA004FGiustifAssPres.Create(nil);
  with A004FGiustifAssPres do
  try
    C700Progressivo:=Prog;
    A004MW.EseguiCommit:=False;
    A004MW.GestioneSingolaDM:=False;
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    Free;
  end;
end;

procedure TA004FGiustifAssPres.FormCreate(Sender: TObject);
var
  Q: TOracleQuery;
begin
  inherited;
  Assenza:=True;
  BInserisci.Enabled:=not SolaLettura;
  BCancella.Enabled:=not SolaLettura;
  btnAnomalie.Enabled:=False;
  A004MW:=TA004FGiustifAssPresMW.Create(nil);
  A004MW.Chiamante:='A004';
  A004MW.GestioneSingolaDM:=True;
  A004MW.ProgressBar:=ProgressBar;
  // impostazioni componenti data aware
  ECausale.ListSource:=A004MW.D265;
  LCausale.DataSource:=A004MW.D265;
  dcmbFamiliari.ListSource:=A004MW.dsrSG101;
  DBGrid1.DataSource:=A004MW.dsrVisualizza;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  Application.HintHidePause:=10000;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine

  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  // visualizzazione e posizionamento del radiogroup tipo mezza giornata
  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=SessioneOracle;
    Q.ReadBuffer:=2;
    Q.SQL.Add('select sum(nvl(CSI_MAX_MGMAT,0) + nvl(CSI_MAX_MGPOM,0)) MAX_MG_TOT ');
    Q.SQL.Add('from   T265_CAUASSENZE ');
    Q.Execute;
    GestioneTipoMezzaGiornata:=Q.FieldAsInteger(0) > 0;
  finally
    FreeAndNil(Q);
  end;
  rgpTipoMG.Visible:=GestioneTipoMezzaGiornata;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
end;

procedure TA004FGiustifAssPres.INPS_TO_CSI_InsCanc;
var
  LCausale: String;
  LCausInps, LCausGestibile, LAbilita: Boolean;
begin
  {-- TORINO_CSI --
  Se causale è presente all'interno della profilazione T269 allora inibisco inserimento/cancellazione della causale}

  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  // considera ora anche un elenco fisso di causali da non gestire manualmente
  // (non è consentito l'inserimento / cancellazione / modifica manuale)
  {
  BCancella.Enabled:=not (A004MW.A087ElencoCausali as TA087InfoCertificati).EsisteCausale(VarToStr(ECausale.KeyValue)) or
                     (not Parametri.ModuloInstallato['TORINO_CSI_PRV']);
  BInserisci.Enabled:=not (A004MW.A087ElencoCausali as TA087InfoCertificati).EsisteCausale(VarToStr(ECausale.KeyValue)) or
                     (not Parametri.ModuloInstallato['TORINO_CSI_PRV']);
  }
  if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
  begin
    // solo per il CSI
    LCausale:=VarToStr(ECausale.KeyValue);
    LCausInps:=(A004MW.A087ElencoCausali as TA087InfoCertificati).EsisteCausale(LCausale);
    LCausGestibile:=R180CercaParolaIntera(LCausale,TO_CSI_CAUSALI_AUTOMATICHE,',') = 0;
    LAbilita:=(LCausGestibile and not LCausInps);
  end
  else
  begin
    LAbilita:=True;
  end;
  BCancella.Enabled:=LAbilita;
  BInserisci.Enabled:=LAbilita;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
end;

procedure TA004FGiustifAssPres.FormShow(Sender: TObject);
begin
  // solo per debug caricamento assenze richieste
  if DebugHook <> 0 then
    A004MW.GestioneSingolaDM:=InputBox('Gestione giustificativi ass./pres.','Indicare la modalità da avviare:'#13#10'S = gestione singola'#13#10'N = gestione collettiva','S') = 'S';

  Self.Caption:='<A004> ' + IfThen(A004MW.GestioneSingolaDM,'Giustificativi ass./pres.','Inserimento giustificativi collettivi');

  // visualizzazione componenti
  rgpGestione.Enabled:=A004MW.GestioneSingolaDM;
  DBGrid1.Visible:=A004MW.GestioneSingolaDM;
  BCancella.Visible:=A004MW.GestioneSingolaDM;
  CompetenzeResidui1.Visible:=A004MW.GestioneSingolaDM;
  ProgressBar.Visible:=True;
  CaricaAssenze.Visible:=not A004MW.GestioneSingolaDM;
  lblFamiliari.Visible:=A004MW.GestioneSingolaDM;
  dcmbFamiliari.Visible:=A004MW.GestioneSingolaDM;
  if not A004MW.GestioneSingolaDM then
  begin
    Width:=ScrollBox1.Left + ScrollBox1.Width + 20;
    HelpContext:=4100;
  end;

  // selezione anagrafe
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A004MW,A004MW.SessioneOracleA004,StatusBar,1,A004MW.GestioneSingolaDM);
  if (RGCausali.ItemIndex = 1) and (DataNasIniziale > 0) then
    dcmbFamiliari.KeyValue:=DataNasIniziale;
  if Visible then
    ECausale.SetFocus;
  INPS_TO_CSI_InsCanc;

  RecapitoAbilitato:=GetRecapitoAbilitato;
  AbilitaRecapitoVisiteFiscali(RecapitoAbilitato);
  AbilitaTipoFruizione;
  CreaC004(A004MW.SessioneOracleA004,'A004',Parametri.ProgOper);
  GetParametriFunzione;
end;

procedure TA004FGiustifAssPres.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  C004FParamForm.Cancella001;
  PutParametriFunzione;
  FreeAndNil(C004FParamForm);
end;

procedure TA004FGiustifAssPres.FormDestroy(Sender: TObject);
begin
  A004MW.SessioneOracleA004.Commit;
  FreeAndNil(A004MW);
  frmSelAnagrafe.DistruggiSelAnagrafe;
  inherited;
end;

function TA004FGiustifAssPres.GetRecapitoAbilitato: Boolean;
var
  DipendentiSelezionati, GestioneDipendenti, CausaleAssenza, FlagVisitaFiscale,
  GiustifAGiornata, Giustif4Scelte: Boolean;
begin
  // introduzione variabili per facilitare debug
  DipendentiSelezionati:=C700SelAnagrafe.RecordCount > 0;
  GestioneDipendenti:=rgpGestione.ItemIndex = 0;
  CausaleAssenza:=RGCausali.ItemIndex = 1;
  FlagVisitaFiscale:=GetVisitaFiscale = 'S';
  GiustifAGiornata:=RGTipoGiust.ItemIndex = 0;
  Giustif4Scelte:=RGTipoGiust.Items.Count = 4;

  // valuta l'abilitazione del recapito alternativo
  Result:=A004MW.GestioneSingolaDM and
          DipendentiSelezionati and
          GestioneDipendenti and
          CausaleAssenza and
          FlagVisitaFiscale and
          GiustifAGiornata and
          Giustif4Scelte;
end;

procedure TA004FGiustifAssPres.GetParametriFunzione;
begin
  A004MW.AnomalieInterattive:=C004FParamForm.GetParametro('ANOMALIE_INTERATTIVE','N') = 'S';
end;

procedure TA004FGiustifAssPres.AbilitaRecapitoVisiteFiscali(Abilitato: Boolean);
var TipoCumulo:String;
begin
  btnRecapitoAlternativo.Enabled:=Abilitato;

  // pulizia dei campi
  if not Abilitato then
  begin
    // nuova gestione recapito alternativo
    A004MW.RecapitoAlternativo.Clear;
  end;
  //Alberto 08/04/2009: Torino_Comune - Gestione nuovo periodo per Tipo cumulo = O
  TipoCumulo:=VarToStr(A004MW.Q265.Lookup('CODICE',ECausale.KeyValue,'TIPOCUMULO'));
  chkNuovoPeriodo.Enabled:=R180In(TipoCumulo,['I','O']) and
                           (rgpGestione.ItemIndex = 0) and
                           (rgTipoGiust.ItemIndex = 0) and
                           A004MW.GestioneSingolaDM{GestioneSingola};
  if not chkNuovoPeriodo.Enabled then
    chkNuovoPeriodo.Checked:=False;
end;

procedure TA004FGiustifAssPres.RefreshSelSG101;
var DN:TDateTime;
begin
  if not A004MW.R600DtM1.selSG101.Active then
    exit;
  A004MW.Var_Causale:=ECausale.Text;
  A004MW.Var_DaData:=EDaData.Text;
  if dcmbFamiliari.KeyValue = null then
    DN:=0
  else
    DN:=dcmbFamiliari.KeyValue;

  with A004MW.R600DtM1.selSG101 do
  begin
    Filtered:=False;
    Filtered:=True;
    if RecordCount = 1 then
      dcmbFamiliari.KeyValue:=FieldByName('DATA').Value
    else if SearchRecord('DATA',DN,[srFromBeginning]) then
      dcmbFamiliari.KeyValue:=DN
    else
      dcmbFamiliari.KeyValue:=null;
  end;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  ImpostaHintFamiliare;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
end;

procedure TA004FGiustifAssPres.CambiaProgressivo;
begin
  with A004MW do
  begin
    dcmbFamiliari.KeyValue:=null;
    Q040.SetVariable('Progressivo',C700Progressivo);
    selT046.SetVariable('Progressivo',C700Progressivo);
    selT046.SetVariable('Data1',DataInizio);
    selT046.SetVariable('Data2',DataFine);
    selConiuge.SetVariable('Progressivo',C700Progressivo);
    R600DtM1.selSG101Causali.SetVariable('Progressivo',C700Progressivo);
    R600DtM1.selSG101Causali.Close;
    R600DtM1.selSG101Causali.Open;
    R600DtM1.selSG101.SetVariable('Progressivo',C700Progressivo);
    R600DtM1.selSG101.Close;
    R600DtM1.selSG101.OnFilterRecord:=selSG101FilterRecord;
    Var_Progressivo:=C700Progressivo; //*** VERIFICARE!!!
    Var_Causale:=ECausale.Text;
    Var_DaData:=EDaData.Text;
    R600DtM1.selSG101.Open;
    RefreshSelSG101;
    LCausale.Visible:=ECausale.KeyValue <> null;
    if rgpGestione.ItemIndex = 0 then
    begin
      Q040.Close;
      Q040.Open;
    end
    else
    begin
      selConiuge.Close;
      selConiuge.Open;
    end;
    // recapito alternativo
    A004MW.RecapitoAlternativo.Clear;

    // impostazione parametri middleware prima di chiamata a procedura
    Var_Gestione:=rgpGestione.ItemIndex;
    Var_FiltroCausaleSelezionata:=CausaleSelezionata1.Checked;
    Var_Causale:=ECausale.Text;
    SettaGiustificativiVisualizzati;
  end;
end;

procedure TA004FGiustifAssPres.RGTipoGiustClick(Sender: TObject);
// Abilita/disabilita Da ore e A ore a seconda dell'opzione selezionata
begin
  EDaOre.Enabled:=RGTipoGiust.ItemIndex > (RGTipoGiust.Items.Count - 4);
  EAOre.Enabled:=RGTipoGiust.ItemIndex > (RGTipoGiust.Items.Count - 2);
  LDaOre.Enabled:=EDaOre.Enabled;
  LAOre.Enabled:=EAOre.Enabled;
  if (RGTipoGiust.ItemIndex = 1) and (RGCausali.ItemIndex = 1) then
    EDaOre.Text:='';
  if Self.Visible then
  begin
    RecapitoAbilitato:=GetRecapitoAbilitato;
    AbilitaRecapitoVisiteFiscali(RecapitoAbilitato);
    AbilitaTipoFruizione;
  end;
end;

procedure TA004FGiustifAssPres.AbilitaNote;
begin
  lblNote.Visible:=(Parametri.CampiRiferimento.C31_NoteGiustificativi = 'S') and (rgpGestione.ItemIndex = 0) and (RGCausali.ItemIndex = 1);
  edtNote.Visible:=lblNote.Visible;
  lblNote.Enabled:=lblNote.Visible and (RGTipoGiust.Items.Count = 4) and (RGTipoGiust.ItemIndex = 1);
  edtNote.Enabled:=lblNote.Enabled;
end;

procedure TA004FGiustifAssPres.BInserisciClick(Sender: TObject);
// Controlla che ci siano tutti i dati richiesti per l'inserimento/cancellazione
var
  Msg: String;
  NGiorni: Integer;

  procedure InizializzaDati;
  begin
    A004MW.Var_Gestione:=rgpGestione.ItemIndex;
    A004MW.Var_TipoGiust:=RGTipoGiust.ItemIndex;
    A004MW.Var_TipoGiust_Count:=RGTipoGiust.Items.Count;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    A004MW.Var_TipoMG:='';
    if rgpTipoMG.Visible then
    begin
      case rgpTipoMG.ItemIndex of
        0: A004MW.Var_TipoMG:='M';
        1: A004MW.Var_TipoMG:='P';
      else
      end;
    end;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    A004MW.Var_DaOre:=EDaOre.Text;
    A004MW.Var_AOre:=EAOre.Text;
    A004MW.Var_DaData:=EDaData.Text;
    A004MW.Var_AData:=EAData.Text;
    A004MW.Var_NumGG:=SpinEdit1.Value;
    A004MW.Var_Causale:=ECausale.Text;
    A004MW.Var_TipoCaus:=RGCausali.ItemIndex;
    if A004MW.GestioneSingolaDM then
      A004MW.Var_Familiari:=StringReplace(VarToStr(dCmbFamiliari.KeyValue),Parametri.TimeSeparatorDef,{$IFNDEF VER210}FormatSettings.{$ENDIF}TimeSeparator,[rfReplaceAll])
    else
      A004MW.Var_Familiari:='';
    A004MW.Var_Note:=IfThen(edtNote.Enabled,edtNote.Text,'');
    A004MW.Var_Progressivo:=C700Progressivo;

    if A004MW.GestioneSingolaDM or C700SelAnagrafe.Bof then
    begin
      try
        A004MW.Controlli(True,Sender = BInserisci);
      except
        on E: Exception do
        begin
          if not (E is EAbort) then
            R180MessageBox(E.Message,ESCLAMA);
          Exit;
        end;
      end;
      EDaOre.Text:=A004MW.Var_DaOre;
      EAOre.Text:=A004MW.Var_AOre;
    end;
    // fine controlli

    // imposta variabile Giustif
    A004MW.Giustif.Inserimento:=Sender = BInserisci;
    case RGTipoGiust.ItemIndex of
      0:A004MW.Giustif.Modo:=R180CarattereDef(IfThen(RGCausali.ItemIndex = 0,'N','I'));
      1:A004MW.Giustif.Modo:=R180CarattereDef(IfThen(RGCausali.ItemIndex = 0,'D','M'));
      2:A004MW.Giustif.Modo:='N';
      3:A004MW.Giustif.Modo:='D';
    end;
    A004MW.Giustif.Causale:=ECausale.Text;
    A004MW.Giustif.DaOre:=EDaOre.Text;
    A004MW.Giustif.AOre:=EAOre.Text;
  end;

  procedure GestioneGiustificativo;
  begin
    A004MW.chkNuovoPeriodo:=chkNuovoPeriodo.Checked;
    // valuta tipo gestione (dipendenti / coniugi esterni)
    if rgpGestione.ItemIndex = 0 then
    begin
      // gestione dipendenti
      if Sender = BInserisci then
      begin
        // inserimento giustificativo
        A004MW.InserisciGiustif(True);
      end
      else
      begin
        // cancellazione giustificativo
        A004MW.CancellaGiustif(True);
      end;
      if not A004MW.GestioneSingolaDM then
        A004MW.DataInizio:=StrToDate(A004MW.Var_DaData); //Alberto 09/04/2009: reimposto DataInizio all'originale, in quanto può essere variata per via del parametro COPRI_GGNONLAV
    end
    else
    begin
      // gestione coniugi esterni
      if Sender = BInserisci then
        A004MW.InserisciGiustFamiliari
      else
        A004MW.CancellaGiustFamiliari;
    end;
  end;

begin
  btnAnomalie.Enabled:=False;

  // controlla selezione dipendenti
  if C700SelAnagrafe.RecordCount = 0 then
  begin
    chkNuovoPeriodo.Checked:=False;
    R180MessageBox(A000TraduzioneStringhe(A000MSG_ERR_NO_DIP),ESCLAMA);
    Exit;
  end;

  A004MW.selDatiBloccati.Close;
  RegistraMsg.IniziaMessaggio('A004');
  if not A004MW.GestioneSingolaDM then
    C700SelAnagrafe.First;
  InizializzaDati;

  // richiede conferma operazione
  NGiorni:=SpinEdit1.Value;
  if NGiorni = 0 then
    Msg:=Format(A000TraduzioneStringhe(A000MSG_A004_DLG_FMT_CONFERMA_DAL_AL),
                [IfThen(Sender = BInserisci,'l''inserimento','la cancellazione'),
                 A004MW.Var_DaData,A004MW.Var_AData])
  else
    Msg:=Format(A000TraduzioneStringhe(A000MSG_A004_DLG_FMT_CONFERMA_DAL_NUMGG),
                [IfThen(Sender = BInserisci,'l''inserimento','la cancellazione'),
                 A004MW.Var_DaData,NGiorni]);
  if R180MessageBox(Msg,DOMANDA) = mrNo then
    Exit;

  // elaborazione
  Screen.Cursor:=crHourGlass;
  ProgressBar.Position:=0;
  if A004MW.GestioneSingolaDM then
  begin
    // progressbar legata al numero di giorni dell'operazione
    ProgressBar.Max:=Trunc(A004MW.DataFine - A004MW.DataInizio) + 1;
    GestioneGiustificativo;
  end
  else
  begin
    // progressbar legata ai dipendenti
    ProgressBar.Max:=C700SelAnagrafe.RecordCount;
    while not C700SelAnagrafe.Eof do
    begin
      // aggiorna progressbar
      ProgressBar.StepBy(1);
      ProgressBar.Repaint;
      //Reinizializza i dati di inserimento che possono modificarsi da un dipendente all'altro dalla gestione della catena di causali
      InizializzaDati;
      // elabora dipendente
      GestioneGiustificativo;
      C700SelAnagrafe.Next;
    end;
    ProgressBar.Position:=0;
    A004MW.SessioneOracleA004.Commit;
  end;

  // impostazione parametri middleware prima di chiamata a procedura
  A004MW.Var_Gestione:=rgpGestione.ItemIndex;
  A004MW.Var_FiltroCausaleSelezionata:=CausaleSelezionata1.Checked;
  A004MW.Var_Causale:=ECausale.Text;
  A004MW.SettaGiustificativiVisualizzati;

  Screen.Cursor:=crDefault;
  Self.chkNuovoPeriodo.Checked:=False;
  // gestione anomalie
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  if (RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB) then
    if R180MessageBox(A000TraduzioneStringhe(A000MSG_DLG_ELAB_ANOMALIE_VIS),DOMANDA) = mrYes then
      btnAnomalieClick(nil);
end;

procedure TA004FGiustifAssPres.RGCausaliClick(Sender: TObject);
// Attivo le causali di assenza o presenza a seconda della selezione
begin
  if (RGCausali.ItemIndex = 0) and (Assenza) then
  begin
    RGTipoGiust.Items.Delete(0);
    RGTipoGiust.Items.Delete(0);
    RGTipoGiust.ItemIndex:=0;
    ECausale.ListSource:=A004MW.D275;
    LCausale.DataSource:=A004MW.D275;
    Assenza:=False;
    RGTipoGiustClick(Sender);
    lblFamiliari.Enabled:=False;
    dcmbFamiliari.Enabled:=False;
  end;
  if (RGCausali.ItemIndex = 1) and (not Assenza) then
  begin
    RGTipoGiust.Items.Insert(0,'Mezza giornata');
    RGTipoGiust.Items.Insert(0,'Giornata');
    RGTipoGiust.ItemIndex:=0;
    ECausale.ListSource:=A004MW.D265;
    LCausale.DataSource:=A004MW.D265;
    Assenza:=True;
    RGTipoGiustClick(Sender);
    lblFamiliari.Enabled:=True;
    dcmbFamiliari.Enabled:=True;
  end;
  ECausale.KeyValue:=null;
  LCausale.Visible:=False;
  CompetenzeResidui1.Visible:=(A004MW.GestioneSingolaDM{GestioneSingola}) and (rgpGestione.ItemIndex = 0) and (rgCausali.ItemIndex = 1);
end;

procedure TA004FGiustifAssPres.Nuovoelemento1Click(Sender: TObject);
// Accedo alla finestra di gestione Causali Assenze/Presenze
var S:String;
begin
  S:=ECausale.text;
  with A004MW do
    Case RGCausali.ItemIndex of
      0:begin
        OpenA020CausPresenze(S);
        Q275.DisableControls;
        Q275.Refresh;
        Q275.EnableControls;
        Q275.SearchRecord('CODICE',S,[srFromBeginning]);
        end;
      1:begin
        OpenA016CausAssenze(S);
        Q265.DisableControls;
        Q265.Refresh;
        Q265.EnableControls;
        Q265.SearchRecord('CODICE',S,[srFromBeginning]);
        end;
    end;

  RecapitoAbilitato:=GetRecapitoAbilitato;
  AbilitaRecapitoVisiteFiscali(RecapitoAbilitato);
  AbilitaTipoFruizione;
end;

// non previsto in intraweb -> spostato nel FormRender
procedure TA004FGiustifAssPres.PopupMenu2Popup(Sender: TObject);
// menu tabella giustificativi
begin
  inherited;
  with A004MW do
  begin
    CompetenzeResidui2.Visible:=(dsrVisualizza.DataSet = Q040B) and
                                (Q040B.RecordCount > 0) and
                                (VarToStr(Q265.Lookup('CODICE',Q040B.FieldByName('CAUSALE').AsString,'DESCRIZIONE')) <> '');
  end;
end;

// non previsto in intraweb -> spostato nel FormRender
procedure TA004FGiustifAssPres.PopupMenu3Popup(Sender: TObject);
// menu familiari
begin
  inherited;
  NuovoElemento2.Enabled:=C700Progressivo > 0;
end;

procedure TA004FGiustifAssPres.Nuovoelemento2Click(Sender: TObject);
// accesso ai familiari
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenS031Familiari(C700Progressivo);
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(A004MW.SessioneOracleA004);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A004MW);

  A004MW.dsrSG101.DataSet.DisableControls;
  A004MW.dsrSG101.DataSet.Refresh;
  A004MW.dsrSG101.DataSet.EnableControls;
end;

procedure TA004FGiustifAssPres.EDaDataChange(Sender: TObject);
begin
  inherited;
  RefreshSelSG101;
  LCausale.Visible:=ECausale.KeyValue <> null;
end;

procedure TA004FGiustifAssPres.EDaDataExit(Sender: TObject);
// Se A Data è vuota assegno il valore di Da Data
begin
  if Trim(EAData.Text) = '/  /' then
    EAdata.Text:=EDaData.Text;
end;

procedure TA004FGiustifAssPres.DBGrid1DblClick(Sender: TObject);
begin
  try
    A004MW.DataInizio:=StrToDate(EDaData.Text);
  except
    A004MW.DataInizio:=0;
  end;
  try
    A004MW.DataFine:=StrToDate(EAData.Text);
  except
    A004MW.DataFine:=DATE_MAX;
  end;

  // aggiornamento tabella giustificativi
  with A004MW do
  begin
    // impostazione parametri middleware prima di chiamata a procedura
    Var_Gestione:=rgpGestione.ItemIndex;
    Var_FiltroCausaleSelezionata:=CausaleSelezionata1.Checked;
    Var_Causale:=ECausale.Text;
    SettaGiustificativiVisualizzati;
  end;
end;

// TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
procedure TA004FGiustifAssPres.ImpostaHintFamiliare;
var
  LDataFamiliare, LDataNas, LDataAdoz: TDateTime;
  LStrDataFamiliare, LNominativo, LHint: String;
  LVData: Variant;
begin
  // imposta hint
  LHint:='';
  LStrDataFamiliare:=VarToStr(dcmbFamiliari.KeyValue).Replace(Parametri.TimeSeparatorDef,{$IFNDEF VER210}FormatSettings.{$ENDIF}TimeSeparator,[rfReplaceAll]);
  if (LStrDataFamiliare <> '') and
     (TryStrToDateTime(LStrDataFamiliare,LDataFamiliare)) then
  begin
    try
      // nominativo
      LNominativo:=VarToStr(dcmbFamiliari.ListSource.Dataset.Lookup('DATA',LDataFamiliare,'NOME'));
      // data di nascita
      LVData:=dcmbFamiliari.ListSource.Dataset.Lookup('DATA',LDataFamiliare,'DATANAS');
      if VarIsNull(LVData) then
        LDataNas:=DATE_NULL
      else
        LDataNas:=VarToDateTime(LVData);
      LHint:=Format('Nominativo: %s'#13#10'Data nascita: %s',[LNominativo,FormatDateTime('dd/mm/yyyy',LDataNas)]);
      // data di adozione
      LVData:=dcmbFamiliari.ListSource.Dataset.Lookup('DATA',LDataFamiliare,'DATAADOZ');
      if not VarIsNull(LVData) then
      begin
        LDataAdoz:=VarToDateTime(LVData);
        LHint:=LHint + #13#10 + Format('Data adozione: %s',[FormatDateTime('dd/mm/yyyy',LDataAdoz)]);
      end;
    except
    end;
  end;
  dcmbFamiliari.Hint:=LHint;
  dcmbFamiliari.ShowHint:=LHint <> '';
end;
// TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine

// TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
procedure TA004FGiustifAssPres.dcmbFamiliariCloseUp(Sender: TObject);
begin
  // imposta hint
  ImpostaHintFamiliare;
end;
// TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine

procedure TA004FGiustifAssPres.dcmbFamiliariEnter(Sender: TObject);
begin
  inherited;
  RefreshSelSG101;
  LCausale.Visible:=ECausale.KeyValue <> null;
end;

procedure TA004FGiustifAssPres.Copiaimpostazioni1Click(Sender: TObject);
// Copio le impostazioni del giustificativo selezionato in modo da poter
// effettuare gli inserimenti/cancellazioni più velocemente
var Tipo:Char;
begin
  with A004MW.Q040B do
  begin
    if FieldByName('D_TipoCausale').AsString = 'Pres' then
      RGCausali.ItemIndex:=0
    else
      RGCausali.ItemIndex:=1;
    ECausale.KeyValue:=FieldByName('Causale').Value;
    dCmbFamiliari.KeyValue:=FieldByName('DataNas').Value;
    if dCmbFamiliari.KeyValue <> null then
      RefreshSelSG101;
    Tipo:=R180CarattereDef(FieldByName('TipoGiust').AsString,1,#0);
    if Tipo = 'I' then
      RGTipoGiust.ItemIndex:=0;
    if Tipo = 'M' then
    begin
      RGTipoGiust.ItemIndex:=1;
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
      if FieldByName('CSI_TIPO_MG').AsString = 'M' then
        rgpTipoMG.ItemIndex:=0
      else if FieldByName('CSI_TIPO_MG').AsString = 'P' then
        rgpTipoMG.ItemIndex:=1
      else
        rgpTipoMG.ItemIndex:=-1;
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fin
    end;
    if Tipo = 'N' then
    begin
      if RGTipoGiust.Items.Count = 4 then
        RGTipoGiust.ItemIndex:=2
      else
        RGTipoGiust.ItemIndex:=0;
    end;
    if Tipo = 'D' then
    begin
      if RGTipoGiust.Items.Count = 4 then
        RGTipoGiust.ItemIndex:=3
      else
        RGTipoGiust.ItemIndex:=1;
    end;
    if Tipo in ['N','D'] then
      EDaOre.EditText:=FormatDateTime('hh:mm',FieldByName('DaOre').AsDateTime);
    if Tipo = 'D' then
      EAOre.EditText:=FormatDateTime('hh:mm',FieldByName('AOre').AsDateTime);
  end;
end;

procedure TA004FGiustifAssPres.CompetenzeResidui1Click(Sender: TObject);
// Visualizzazione Competenze/Residui della causale specificata
var Data:TDateTime;
begin
  try
    Data:=StrToDate(EDaData.Text);
  except
    Data:=Date;
  end;
  with A004MW do
  begin
    if ((R180CarattereDef(Q265.FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D']) or
        (R180CarattereDef(Q265.FieldByName('FRUIZIONE_FAMILIARI').AsString,1,'N') in ['S','D'])) and
       (VarToStr(dcmbFamiliari.KeyValue) = '') then
    begin
      raise Exception.Create('Specificare il familiare di riferimento!');
    end;
    Giustif.Inserimento:=False;
    Giustif.Modo:='I';
    Giustif.Causale:=ECausale.Text;
    Giustif.DaOre:='';
    Giustif.AOre:='';
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    // il tipo mezza giornata è significativo solo per il Modo M
    Giustif.CSITipoMG:='';
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    if VarToStr(dcmbFamiliari.KeyValue) <> '' then
    begin
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
      //R600DtM1.RiferimentoDataNascita.Data:=StrToDateTime(StringReplace(dcmbFamiliari.Text,Parametri.TimeSeparatorDef,{$IFNDEF VER210}FormatSettings.{$ENDIF}TimeSeparator,[rfReplaceAll]));
      R600DtM1.RiferimentoDataNascita.Data:=StrToDateTime(StringReplace(VarToStr(dcmbFamiliari.KeyValue),Parametri.TimeSeparatorDef,{$IFNDEF VER210}FormatSettings.{$ENDIF}TimeSeparator,[rfReplaceAll]));
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
    end;
    R600DtM1.VisualizzaAssenze(C700Progressivo,Data,Giustif);
  end;
end;

procedure TA004FGiustifAssPres.CompetenzeResidui2Click(Sender: TObject);
// Visualizzazione Competenze/Residui della causale specificata
begin
  with A004MW do
  begin
    if ((R180CarattereDef(VarToStr(Q265.Lookup('CODICE',Q040B.FieldByName('CAUSALE').AsString,'CUMULO_FAMILIARI')),1,'N') in ['S','D']) or
        (R180CarattereDef(VarToStr(Q265.Lookup('CODICE',Q040B.FieldByName('CAUSALE').AsString,'FRUIZIONE_FAMILIARI')),1,'N') in ['S','D']))
    and (Q040B.FieldByName('DATANAS').IsNull) then
      raise Exception.Create('Manca il familiare di riferimento!');
    Giustif.Inserimento:=False;
    Giustif.Modo:='I';
    Giustif.Causale:=Q040B.FieldByName('CAUSALE').AsString;
    Giustif.DaOre:='';
    Giustif.AOre:='';
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    // il tipo mezza giornata è significativo solo per il Modo M
    Giustif.CSITipoMG:='';
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    if not Q040B.FieldByName('DATANAS').IsNull then
      R600DtM1.RiferimentoDataNascita.Data:=Q040B.FieldByName('DATANAS').AsDateTime;
    R600DtM1.VisualizzaAssenze(Q040B.FieldByName('PROGRESSIVO').AsInteger,Q040B.FieldByName('DATA').AsDateTime,Giustif);
  end;
end;

procedure TA004FGiustifAssPres.SpinEdit1Change(Sender: TObject);
begin
  EAData.OnChange:=nil;
  EAData.Text:='  /  /    ';
  EAData.OnChange:=EADataChange;
end;

// spostato (non esiste evento equivalente)
procedure TA004FGiustifAssPres.EADataChange(Sender: TObject);
begin
  SpinEdit1.Value:=0;
end;

procedure TA004FGiustifAssPres.TfrmSelAnagrafe1R003DatianagraficiClick(Sender: TObject);
begin
  try
    C005DataVisualizzazione:=StrToDate(EAData.Text);
  except
    try
      C005DataVisualizzazione:=StrToDate(EDaData.Text);
    except
      C005DataVisualizzazione:=Parametri.DataLavoro;
    end;
  end;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA004FGiustifAssPres.frmSelAnagrafebtnRicercaClick(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.btnRicercaClick(Sender);
end;

procedure TA004FGiustifAssPres.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  try
    C700DataLavoro:=StrToDateDef(EAData.Text,Parametri.DataLavoro);
  except
    C700DataLavoro:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
  if A004MW.GestioneSingolaDM then
    CambiaProgressivo;
  BInserisci.Enabled:=C700SelAnagrafe.RecordCount > 0;

  RecapitoAbilitato:=GetRecapitoAbilitato;
  AbilitaRecapitoVisiteFiscali(RecapitoAbilitato);
  AbilitaTipoFruizione;
end;

procedure TA004FGiustifAssPres.PutParametriFunzione;
begin
  C004FParamForm.PutParametro('ANOMALIE_INTERATTIVE',IfThen(A004MW.AnomalieInterattive,'S','N'));
end;

procedure TA004FGiustifAssPres.rgpGestioneClick(Sender: TObject);
begin
  CompetenzeResidui1.Visible:=(A004MW.GestioneSingolaDM) and (rgpGestione.ItemIndex = 0) and (rgCausali.ItemIndex = 1);
  Copiaimpostazioni1.Visible:=rgpGestione.ItemIndex = 0;
  rgCausali.Enabled:=rgpGestione.ItemIndex = 0;

  // per i coniugi esterni è prevista la sola gestione delle assenze
  if rgpGestione.ItemIndex = 1 then
    rgCausali.ItemIndex:=1;

  RecapitoAbilitato:=GetRecapitoAbilitato;
  AbilitaRecapitoVisiteFiscali(RecapitoAbilitato);
  AbilitaTipoFruizione;

  CambiaProgressivo;
end;

procedure TA004FGiustifAssPres.Causaleselezionata1Click(Sender: TObject);
begin
  inherited;

  // aggiornamento tabella giustificativi
  with A004MW do
  begin
    // impostazione parametri middleware prima di chiamata a procedura
    Var_Gestione:=rgpGestione.ItemIndex;
    Var_FiltroCausaleSelezionata:=CausaleSelezionata1.Checked;
    Var_Causale:=ECausale.Text;
    SettaGiustificativiVisualizzati;
  end;
end;

procedure TA004FGiustifAssPres.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A004','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(A004MW.SessioneOracleA004);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A004MW);
end;

procedure TA004FGiustifAssPres.btnRecapitoAlternativoClick(Sender: TObject);
var
  T047DataInizio, T047DataFine:TDateTime;
begin
  if TryStrToDate(EDaData.Text,T047DataInizio) then
    OpenA004RecapitoVisFiscali(A004MW,C700Progressivo,T047DataInizio)
  else
    R180MessageBox('Data di inizio periodo non valida!',ERRORE);
end;

procedure TA004FGiustifAssPres.CaricaAssenzeClick(Sender: TObject);
begin
  OpenA004CaricaAssRich(A004MW);
end;

function TA004FGiustifAssPres.GetVisitaFiscale: String;
// Estrae il valore del flag VISITA_FISCALE a fronte della causale di assenza attualmente selezionata
begin
  Result:=VarToStr(A004MW.Q265.Lookup('CODICE',ECausale.KeyValue,'VISITA_FISCALE'));
  if Result <> 'S' then
    Result:='N';
end;

procedure TA004FGiustifAssPres.AbilitaTipoFruizione;
var
  i: Integer;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  LFruizMaxMattine, LFruizMaxPomeriggi: Integer;
  LCausStr: String;
  LAbilitaTipoMG: Boolean;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
begin
  if ECausale.KeyValue = null then
  begin
    // causale non selezionata
    for i:=0 to RGTipoGiust.ControlCount - 1 do
      with R180RadioGroupButton(RGTipoGiust,i) do
        Enabled:=False;
  end
  else
  begin
    // ciclo di abilitazione dei tipi fruizione
    if RGCausali.ItemIndex = 0 then
    begin
      // causali di presenza
      with A004MW.Q275 do
      begin
        R180RadioGroupButton(RGTipoGiust,0).Enabled:=FieldByName('UM_INSERIMENTO_H').AsString = 'S';
        R180RadioGroupButton(RGTipoGiust,1).Enabled:=FieldByName('UM_INSERIMENTO_D').AsString = 'S';
      end;
    end
    else
    begin
      // causali di assenza
      with A004MW.Q265 do
      begin
        R180RadioGroupButton(RGTipoGiust,0).Enabled:=FieldByName('UM_INSERIMENTO').AsString = 'S';
        R180RadioGroupButton(RGTipoGiust,1).Enabled:=FieldByName('UM_INSERIMENTO_MG').AsString = 'S';
        R180RadioGroupButton(RGTipoGiust,2).Enabled:=FieldByName('UM_INSERIMENTO_H').AsString = 'S';
        R180RadioGroupButton(RGTipoGiust,3).Enabled:=FieldByName('UM_INSERIMENTO_D').AsString = 'S';
      end;
    end;
  end;

  // verifica che l'item attualmente selezionato sia abilitato
  with R180RadioGroupButton(RGTipoGiust,RGTipoGiust.ItemIndex) do
  begin
    if Checked and (not Enabled) then
    begin
      // seleziona il primo radiobutton abilitato nell'ordine
      for i:=0 to RGTipoGiust.ControlCount - 1 do
        with R180RadioGroupButton(RGTipoGiust,i) do
          if Enabled then
          begin
            Checked:=True;
            Break;
          end;
    end;
  end;

  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  // abilitazione tipo mezza giornata
  if GestioneTipoMezzaGiornata then
  begin
    LAbilitaTipoMG:=(RGCausali.ItemIndex = 1) and (RGTipoGiust.ItemIndex = 1);
    if LAbilitaTipoMG then
    begin
      // giustificativo di assenza a mezza giornata
      // abilita l'indicazione della tipologia di mezza giornata
      // solo se la causale prevede fruizioni mattine + pomeriggi > 0
      if ECausale.KeyValue = null then
      begin
        LAbilitaTipoMG:=False;
      end
      else
      begin
        LCausStr:=VarToStr(ECausale.KeyValue);
        LFruizMaxMattine:=StrToIntDef(VarToStr(A004MW.Q265.Lookup('CODICE',LCausStr,'CSI_MAX_MGMAT')),0);
        LFruizMaxPomeriggi:=StrToIntDef(VarToStr(A004MW.Q265.Lookup('CODICE',LCausStr,'CSI_MAX_MGPOM')),0);
        LAbilitaTipoMG:=(LFruizMaxMattine + LFruizMaxPomeriggi) > 0;
      end;
    end;
    rgpTipoMG.Visible:=LAbilitaTipoMG;
  end;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine

  AbilitaNote;
end;

procedure TA004FGiustifAssPres.ECausaleCloseUp(Sender: TObject);
begin
  inherited;
  RefreshSelSG101;
  LCausale.Visible:=ECausale.KeyValue <> null;
  INPS_TO_CSI_InsCanc;
  RecapitoAbilitato:=GetRecapitoAbilitato;
  AbilitaRecapitoVisiteFiscali(RecapitoAbilitato);
  AbilitaTipoFruizione;
end;

procedure TA004FGiustifAssPres.ECausaleContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  inherited;
  CompetenzeResidui1.Enabled:=Assenza and (VarToStr(ECausale.KeyValue) <> '') and (C700Progressivo > 0);
end;

procedure TA004FGiustifAssPres.ECausaleKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    LCausale.Visible:=False;
  end;
end;

procedure TA004FGiustifAssPres.ECausaleKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  RefreshSelSG101;
  LCausale.Visible:=ECausale.KeyValue <> null;
  INPS_TO_CSI_InsCanc;

  RecapitoAbilitato:=GetRecapitoAbilitato;
  AbilitaRecapitoVisiteFiscali(RecapitoAbilitato);
  AbilitaTipoFruizione;
end;

procedure TA004FGiustifAssPres.EADataDblClick(Sender: TObject);
begin
  inherited;
  EAdata.Text:=EDaData.Text;
end;

end.
