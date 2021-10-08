unit A002UAnagrafeVistaPadre;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ExtCtrls, Menus, ComCtrls, Grids, DBGrids, Buttons,
  Db, QueryStorico, A000UCostanti, A000UMessaggi, A000USessione,A000UInterfaccia, C004UParamForm, C180FunzioniGenerali, L001Call, L021Call, Oracle,
  A003UDataLavoroBis, A082UCdcPercent, ImgList, ActnList, ToolWin, Shellapi,
  A008UCambioPassword, A008UAzOper,
  A026UDatiLiberi,A044UAllineaStorici,A078URichiestaAssistenza,
  A093UOperazioni,A099UUtilityDB, A083UMsgElaborazioni,
  A134UAllineamentoClient, A136URelazioniAnagrafe,
  (*P430UAnagrafico,*)
  B007UManipolazioneDati, C700USelezioneAnagrafe, C700USelezioneAnagrafeDtM, SelAnagrafe,
  OracleData, Variants, StrUtils, Math
  {$IFNDEF VER210}, System.Actions, System.ImageList{$ENDIF};

type
  StrutObj = record
    CampoInput:TControl;
  end;

  TA002FAnagrafeVistaPadre = class(TForm)
    DBGrid1: TDBGrid;
    Timer1: TTimer;
    TVAzienda: TTreeView;
    Panel6: TPanel;
    Panel7: TPanel;
    SpeedButton30: TSpeedButton;
    MSelect: TMemo;
    PopupMenu1: TPopupMenu;
    Aggiorna1: TMenuItem;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Griglia1: TMenuItem;
    Salvaimpostazionigriglia1: TMenuItem;
    Ripristinadefault1: TMenuItem;
    N9: TMenuItem;
    Nomecolonna1: TMenuItem;
    Cancellacolonna1: TMenuItem;
    Ripristinacolonne1: TMenuItem;
    N23: TMenuItem;
    Informazionisu1: TMenuItem;
    StatusBar: TStatusBar;
    Esci1: TMenuItem;
    actlstBase: TActionList;
    actRicerca: TAction;
    actPrimo: TAction;
    actPrecedente: TAction;
    actSuccessivo: TAction;
    actUltimo: TAction;
    actInserisci: TAction;
    actDataLavoro: TAction;
    actEsci: TAction;
    actAggiornaAnagrafe: TAction;
    actSchedaAnagrafica: TAction;
    Ricerca1: TMenuItem;
    Primo1: TMenuItem;
    Precedente1: TMenuItem;
    Successivo1: TMenuItem;
    Ultimo1: TMenuItem;
    Inserisci1: TMenuItem;
    Aggiornaanagrafe1: TMenuItem;
    Schedaanagrafica1: TMenuItem;
    N1: TMenuItem;
    Datadilavoro1: TMenuItem;
    actlstGrigliaAssistenza: TActionList;
    actSalvaGriglia: TAction;
    actRipristinaGriglia: TAction;
    actNomeColonna: TAction;
    actCancellaColonna: TAction;
    actRipristinaColonne: TAction;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton8: TToolButton;
    Splitter1: TSplitter;
    Splitter3: TSplitter;
    N99: TMenuItem;
    Gestionesicurezza1: TMenuItem;
    actGestioneSicurezza: TAction;
    sepPopMnu1: TMenuItem;
    mnuRicercaCompleta: TMenuItem;
    Richiestadiassistenza1: TMenuItem;
    actRichiestaAssistenza: TAction;
    actRefresh: TAction;
    Refresh1: TMenuItem;
    sep: TMenuItem;
    cdcPercent: TMenuItem;
    actCdcPercent: TAction;
    TCdcPercent: TToolButton;
    N_2: TMenuItem;
    actAllineamentoClient: TAction;
    AllineamentoClient: TMenuItem;
    actFiltroCessati: TAction;
    Filtrocessati1: TMenuItem;
    ImageList1: TImageList;
    actlstAmministrazione: TActionList;
    actAziendeOperatori: TAction;
    actRidefinizioneCampiAnagrafici: TAction;
    actAllineaStorici: TAction;
    actMonitoraggioLog: TAction;
    actDefinizioneDatiLiberi: TAction;
    actRicostruzioneAnagrafico: TAction;
    actUtilityDB: TAction;
    actLayoutSchedaAnagrafica: TAction;
    Amministrazionesistema1: TMenuItem;
    Gestionesicurezza2: TMenuItem;
    Ridefinizionecampianagrafici1: TMenuItem;
    Allineamentodatistorici1: TMenuItem;
    UtilitydelDatabase1: TMenuItem;
    Monitoraggiotabelladilog1: TMenuItem;
    Definizionedatiliberi1: TMenuItem;
    Ricostruzioneanagrafico1: TMenuItem;
    Layoutschedaanagrafica1: TMenuItem;
    N3: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    btnAziendeOperatori: TToolButton;
    ToolButton65: TToolButton;
    actRelazioniAnagrafe: TAction;
    Relazionitradatianagrafici1: TMenuItem;
    frmSelAnagrafe: TfrmSelAnagrafe;
    pnlfrmSelAnagrafe: TPanel;
    ToolButtonSeparator17: TToolButton;
    NRicercaTesto: TMenuItem;
    Ricercatestocontenuto1: TMenuItem;
    Successivo2: TMenuItem;
    PopupMenu2: TPopupMenu;
    mnuCopiaExcel: TMenuItem;
    actMsgElaborazioni: TAction;
    ElaborazioneMessaggi1: TMenuItem;
    actAnagraficoStipendi: TAction;
    TAnagraficoStipendi: TToolButton;
    Schedaanagrafica2: TMenuItem;
    actManipolazioneDati: TAction;
    ManipolazioneDati1: TMenuItem;
    procedure actAmministrazoneSistemaExecute(Sender: TObject);
    procedure MSelectKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Novitdellaversione1Click(Sender: TObject);
    procedure actCdcPercentExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Ripristinadefault1Click(Sender: TObject);
    procedure actlstFunzioniBase(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolBar(Sender: TObject);
    procedure TVAziendaExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure TVAziendaDblClick(Sender: TObject);
    procedure TVAziendaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton30Click(Sender: TObject);
    procedure TVAziendaEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure TVAziendaEdited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure Informazionisu1Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure TVAziendaContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure Aggiorna1Click(Sender: TObject);
    procedure actlstGrigliaExecute(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure mnuRicercaCompletaClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure actRichiestaAssistenzaExecute(Sender: TObject);
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure FormShow(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure DBGrid1ColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
    procedure Ricercatestocontenuto1Click(Sender: TObject);
    procedure Successivo2Click(Sender: TObject);
    procedure mnuCopiaExcelClick(Sender: TObject);
    procedure actAnagraficoStipendiExecute(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    MouseGrid,TimeGrid:boolean;
    NumSec:Byte;
    TreeNodeOrig,TreeNodeNew,TVAziendaSearch:String;
    procedure SalvaGriglia;
    procedure RipristinaGriglia;
    procedure NomeColonna;
    procedure RipristinaColonne;
    procedure DataLavoroShow;
    procedure FiltraCessati;
    procedure AggiornaTVAzienda;
  protected
    PAssenze:String;
    PProgressivo:LongInt;
    //NomePJ,VersionePJ,DataPJ:String;
    procedure DatiLiberiGest;
    procedure LayoutSchedaAnagrafica;
    procedure GetDatiDipendente(Azione:TObject = nil);
  public
    { Public declarations }
    Azienda,Operatore,StrProgOper:String;
    NumDatiLiberi:Byte;
    ProgOper:Word;
    DataLavoro:TDateTime;
    QueryNuova,Registro:Boolean;
    Storico:array of StrutObj;
    procedure InibizioniFunzioni;
    procedure RefreshQVista;
    procedure ResettaTVAzienda;
  end;

var
  A002FAnagrafeVistaPadre: TA002FAnagrafeVistaPadre;

implementation

uses A002UAnagrafeGest, A002UAnagrafeDtM1, A002ULayout, A002UAbout;

{$R *.DFM}

procedure TA002FAnagrafeVistaPadre.FormCreate(Sender: TObject);
{Impostazioni in fase di creazione}    
begin
  A002FAnagrafeVistaPadre:=Self;
  A000SettaVariabiliAmbiente;
  NumDatiLiberi:=0;
  Registro:=False;
  DataLavoro:=Date;
  QueryNuova:=True;
  MouseGrid:=False;
  TimeGrid:=False;
  NumSec:=0;
  R180ToolBarHandleNeeded(Self);
  StatusBar.Panels[0].Text:=FormatDateTime('dd/mm/yyyy',Date);
  StatusBar.Panels[2].Text:='Data di lavoro:' + FormatDateTime('dd/mm/yyyy',DataLavoro);
  //Caption:='<A002> IrisWIN - ' + Application.Title + ' ' + Parametri.VersionePJ + ' - ';
  Caption:=Format('<%s> IrisWIN - %s %s(%s) -',[Copy(ExtractFileName(Application.ExeName),1,4),Application.Title,Parametri.VersionePJ,Parametri.BuildPJ]);
  Informazionisu1.Visible:=UpperCase(Parametri.RagioneSociale) <> 'AZIENDA OSPEDALIERA SANT''ANDREA';
  actRichiestaAssistenza.Visible:=UpperCase(Parametri.RagioneSociale) <> 'AZIENDA OSPEDALIERA SANT''ANDREA';
end;

procedure TA002FAnagrafeVistaPadre.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA002FAnagrafeVistaPadre.FormShow(Sender: TObject);
begin
  GetParametriFunzione;
  C700DatiVisualizzati:='';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  //frmSelAnagrafe.OnCambiaProgressivo:=A002FAnagrafeDtM1.CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  frmSelAnagrafe.SoloPersonaleInterno:=False;
  C700FSelezioneAnagrafe.OpenC700SelAnagrafe:=False;
  frmSelAnagrafe.NumRecords;

  A002FAnagrafeDtM1.QueryAnagrafeStorico;
  Application.CreateForm(TA002FLayout, A002FLayout);

  actGestioneSicurezza.Visible:=not Parametri.AuthDom;
  //GetParametriFunzione;
  SpeedButton30Click(nil);
  if not actFiltroCessati.Checked then
    FiltraCessati;
  try
    A002FAnagrafeDtM1.selP430.Open;
    actAnagraficoStipendi.Visible:=A002FAnagrafeDtM1.selP430.FieldByName('ANAGRAFICHE_STIPENDIALI').AsInteger > 0;
    A002FAnagrafeDtM1.selP430.Close;
  except
    actAnagraficoStipendi.Visible:=False;
  end;
end;

procedure TA002FAnagrafeVistaPadre.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.btnSelezioneClick(Sender);
  if frmSelAnagrafe.C700ModalResult = mrOK then
    RefreshQVista;
end;

procedure TA002FAnagrafeVistaPadre.RefreshQVista;
var p:Integer;
begin
  with A002FAnagrafeDtM1 do
  try
    Screen.Cursor:=crHourGlass;
    p:=0;
    if QVista.Active then
      p:=QVista.FieldByName('PROGRESSIVO').AsInteger;
    QVista.DisableControls;
    QVista.Close;
    C700MergeSelAnagrafe(QVista,False);
    QVista.SetVariable('ORDERBY',frmSelAnagrafe.GetC700SelAnagrafeOrderBy);
    QVista.Open;
    ApplicaQVistaFields;
    QVista.SearchRecord('PROGRESSIVO',p,[srFromBeginning]);
    if QVista.RecordCount = 0 then
      QVistaAfterScroll(nil);
  finally
    QVista.EnableControls;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA002FAnagrafeVistaPadre.InibizioniFunzioni;
{Leggo le inibizioni per disabilitare i menu e gli speed button}
var i,k:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    with Self do
      if (Components[i] is TAction) and (Components[i].Tag > 0) then
        begin
        TAction(Components[i]).Enabled:=False;
        for k:=0 to High(Parametri.AbilitazioniFunzioni) do
          if Parametri.AbilitazioniFunzioni[k].Tag = Components[i].Tag then
            begin
            TAction(Components[i]).Enabled:=Parametri.AbilitazioniFunzioni[k].Inibizione <> 'N';
            Break;
            end;
        end;
  //actInserisci.Enabled:=Parametri.InserimentoMatricole = 'S';
  //Inibizione su archivio anagrafico
  with A002FAnagrafeDtM1 do
    begin
    AbilAnagra:=aaNone;
    for k:=0 to High(Parametri.AbilitazioniFunzioni) do
      if Parametri.AbilitazioniFunzioni[k].Funzione = 'ANAGRAFICO' then
        begin
        if Parametri.AbilitazioniFunzioni[k].Inibizione = 'S' then
          AbilAnagra:=aaReadWrite
        else if Parametri.AbilitazioniFunzioni[k].Inibizione = 'R' then
          AbilAnagra:=aaReadOnly;
        Break;
        end;
    Q030.ReadOnly:=AbilAnagra <> aaReadWrite;
    if AbilAnagra <> aaReadWrite then
      Q030.CachedUpdates:=False;
    actAggiornaAnagrafe.Enabled:=not(AbilAnagra = aaNone);
    A002FAnagrafeGest.ToolBar1.Enabled:=not(AbilAnagra = aaNone);
    Griglia1.Enabled:=not(AbilAnagra = aaNone);
    actInserisci.Enabled:=(AbilAnagra = aaReadWrite) and (Parametri.InserimentoMatricole = 'S');
    end;
end;

procedure TA002FAnagrafeVistaPadre.Ripristinadefault1Click(Sender: TObject);
{Annulla i cambiamenti del layout della griglia}
begin
  if MessageDlg('Cancellare le impostazioni personalizzate della griglia?',
                 mtInformation, [mbYes, mbNo], 0) = mrNo then exit;
  with A002FAnagrafeDtM1 do
    begin
    OperSql.SQL.Clear;
    OperSql.SQL.Add('DELETE FROM T034_LayoutGriglia WHERE Operatore = ' + IntToStr(ProgOper));
    try
      OperSql.Execute;
      SessioneOracle.Commit;
    except
      SessioneOracle.Rollback;
      raise;
    end;
    end;
  MessageDlg('I cambiamenti avranno effetto la prossima volta che verrà riavviato il programma',
              mtInformation, [mbOk], 0);
end;

procedure TA002FAnagrafeVistaPadre.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
{Tasti per ordinare, cancellare e ripristinare le colonne}
begin
  if (Shift = [ssAlt]) then
    begin
    if Key in [Ord('o'),Ord('O')] then
      DBGrid1TitleClick(DbGrid1.Columns[DbGrid1.SelectedIndex]);
    if Key in [Ord('d'),Ord('D')] then
      actlstGrigliaExecute(actCancellaColonna);
    if Key in [Ord('r'),Ord('R')] then
      actlstGrigliaExecute(actRipristinaColonne);
    end;
end;

procedure TA002FAnagrafeVistaPadre.DatiLiberiGest;
{Inserimento dati liberi}
begin
  with A002FAnagrafeDtM1 do
  begin
    QVista.Close;
    if OpenA026DatiLiberi then
    begin
      //Chiudo le query dei dati liberi e reinizializzo i dati liberi
      //ActiveDatiLiberi(False);
      RicostruisciAnagrafico;
    end
    else if AbilAnagra <> aaNone then
    begin
      QVista.Open;
      ApplicaQVistaFields;
      A002FLayout.Attivazione;
    end;
  end;
end;

procedure TA002FAnagrafeVistaPadre.FiltraCessati;
var S:String;
begin
  if not actFiltroCessati.Checked then
  begin
    S:=Format(QDipInServizio,[IntToStr(Parametri.ValiditaCessati)]);
    if Trim(Parametri.Inibizioni.Text) <> '' then
      S:='AND ' + S;
    Parametri.Inibizioni.Add(S);
  end
  else
    Parametri.Inibizioni.Delete(Parametri.Inibizioni.Count - 1);
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe;
  C700FSelezioneAnagrafe.actConfermaExecute(C700FSelezioneAnagrafe.actConferma);
  RefreshQVista;
  AggiornaTVAzienda;
end;

procedure TA002FAnagrafeVistaPadre.AggiornaTVAzienda;
var
  //i:Integer;
  TN,TS,TC:TTreeNode;
  S:String;
begin
  if TVAzienda.Items.Count = 0 then
    exit;
  TS:=TVAzienda.Selected;
  S:='';
  if (TS <> nil) and (TS.Level > 0) then
  begin
    S:=TS.Text;
    TS:=TS.Parent;
  end;
  TN:=TVAzienda.Items[0];
  //Ciclo di aggiornamento sui nodi aperti (expanded)
  repeat
    if TN.HasChildren and (TN.getFirstChild.Text <> 'Valori') then
    begin
      TVAzienda.Selected:=TN;
      if TN.Expanded then
        Aggiorna1Click(nil)
      else
      begin
        TN.DeleteChildren;
        TVAzienda.Items.AddChild(TN,'Valori');
      end;
    end;
    TN:=TN.getNextSibling;
  until TN = nil;
  //Riposizionamento sul nodo precedentemente selezionato
  if TS = nil then
    TVAzienda.Selected:=TVAzienda.Items[0]
  else
  begin
    TVAzienda.Selected:=TS;
    if TS.Expanded and (S <> '') then
    begin
      TC:=TS.getFirstChild;
      while (TC <> nil) and (TC.Text <> S) do
        TC:=TC.getNextSibling;
      if (TC <> nil) and (TC.Text = S) then
        TVAzienda.Selected:=TC;
    end;
  end;
end;

procedure TA002FAnagrafeVistaPadre.actlstFunzioniBase(Sender: TObject);
{Ricerca il record specificato}
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
    A002FAnagrafeGest.Show;
    A002FAnagrafeGest.actlstExecute(A002FAnagrafeGest.actInserisci);
  end
  else if Sender = actSchedaAnagrafica then
    if not actSchedaAnagrafica.Checked then
      A002FAnagrafeGest.Show
    else
      A002FAnagrafeGest.Hide
  else if Sender = actGestioneSicurezza then
    OpenA008GestioneSicurezza(SessioneOracle,True)
  else if Sender = actAggiornaAnagrafe then
    A002FAnagrafeDtM1.GetIntegrazione
  else if Sender = actManipolazioneDati then
  try
    frmSelAnagrafe.SalvaC00SelAnagrafe;
    C700Distruzione;
    OpenB007ManipolazioneDati(A002FAnagrafeDtM1.QVista.FieldByName('PROGRESSIVO').AsInteger);
  finally
    C700DatiSelezionati:=C700CampiBase;
    C700Creazione(SessioneOracle);
    frmSelAnagrafe.RipristinaC00SelAnagrafe;
  end
  else if Sender = actDataLavoro then
    DataLavoroShow
  else if Sender = actFiltroCessati then
    FiltraCessati
  else if Sender = actEsci then
    Close;
end;

procedure TA002FAnagrafeVistaPadre.DataLavoroShow;
{Impostazione data di lavoro}
var DataOld:TDateTime;
    p:Integer;
begin
  DataOld:=DataLavoro;
  DataLavoro:=DataOut(DataLavoro,'Data di lavoro','G');
  Parametri.DataLavoro:=DataLavoro;
  if DataLavoro <> DataOld then
  begin
    if C700MergeSettaPeriodo(A002FAnagrafeDtM1.QVista,DataLavoro,DataLavoro) then
    begin
      StatusBar.Panels[2].Text:='Data di lavoro:' + FormatDateTime('dd/mm/yyyy',DataLavoro);
      //A002FAnagrafeGest.Decorrenza.Text:=FormatDateTime('dd/mm/yyyy',DataLavoro);
      with A002FAnagrafeDtM1 do
      try
        Screen.Cursor:=crHourGlass;
        p:=0;
        if QVista.Active then
          p:=QVista.FieldByName('PROGRESSIVO').AsInteger;
        QVista.DisableControls;
        QVista.Close;
        QVista.Open;
        ApplicaQVistaFields;
        QVista.SearchRecord('PROGRESSIVO',p,[srFromBeginning]);
        if QVista.RecordCount = 0 then
          QVistaAfterScroll(nil);
      finally
        QVista.EnableControls;
        Screen.Cursor:=crDefault;
      end;
    end;
  end;
end;

procedure TA002FAnagrafeVistaPadre.ToolBar(Sender: TObject);
begin
  (Sender as TMenuItem).Checked:=not (Sender as TMenuItem).Checked;
end;

procedure TA002FAnagrafeVistaPadre.TVAziendaExpanding(Sender: TObject;
  Node: TTreeNode; var AllowExpansion: Boolean);
var i:Integer;
begin
  if (Node.Count = 1) and (Node.Item[0].Text = 'Valori') then
    with A002FAnagrafeDtM1.OperSQL do
    begin
      Screen.Cursor:=crHourGlass;
      Close;
      DeleteVariables;
      SQL.Clear;
      case DataBaseDrv of
        dbOracle:SQL.Text:=QVistaOracle;
      end;
      SQL.Insert(0,Format('SELECT %s DISTINCT %s FROM',[Parametri.CampiRiferimento.C26_HintT030V430,Parametri.ColonneStruttura.Values[Node.Text]]));
      //Leggo le inbizioni
      with Parametri.Inibizioni do
        if Count > 0 then
          if Strings[0] <> '' then
            begin
            Sql.Add('AND');
            for i:=0 to Count - 1 do
              Sql.Add(Strings[i]);
            end;
      //Inserimento filtro cessati
      if not(actFiltroCessati.Checked) then
        SQL.Add(' AND TO_DATE(''' + DateToStr(Parametri.DataLavoro) + ''',''DD/MM/YYYY'') BETWEEN T430INIZIO AND ADD_MONTHS(LAST_DAY(NVL(T430FINE,TO_DATE(''31123999'',''DDMMYYYY''))),' + IntToStr(Parametri.ValiditaCessati) + ')');
      //InsErimento ordinamento
      if UpperCase(Parametri.ColonneStruttura.Values[Node.Text]) = 'MATRICOLA' then
        SQL.Add('ORDER BY LPAD(' + Parametri.ColonneStruttura.Values[Node.Text] + ',8,''0'')')
      else
        SQL.Add('ORDER BY ' + Parametri.ColonneStruttura.Values[Node.Text]);
      DeclareVariable('DataLavoro',otDate);
      SetVariable('DataLavoro',DataLavoro);
      ReadBuffer:=100;
      Execute;
      if RowCount > 0 then
        begin
        Node.DeleteChildren;
        TVAzienda.Items.BeginUpdate;
        while not Eof do
          begin
          TVAzienda.Items.AddChild(Node,FieldAsString(0));
          Next;
          end;
        TVAzienda.Items.EndUpdate;
        end
      else
        AllowExpansion:=False;
      Close;
      DeleteVariables;
      ReadBuffer:=25;
      Screen.Cursor:=crDefault;
      end;
end;

procedure TA002FAnagrafeVistaPadre.TVAziendaDblClick(Sender: TObject);
var S:String;
begin
  if TVAzienda.Selected.Level = 0 then exit;
  Screen.Cursor:=crHourGlass;
  if TVAzienda.Selected.Text <> '' then
    S:=Format('%s = ''%s''',[Parametri.ColonneStruttura.Values[TVAzienda.Selected.Parent.Text],AggiungiApice(TVAzienda.Selected.Text)])
  else
    S:=Format('%s IS NULL',[Parametri.ColonneStruttura.Values[TVAzienda.Selected.Parent.Text]]);
  S:=S + #13#10 + VarToStr(A002FAnagrafeDtM1.QVista.GetVariable('ORDERBY'));
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  try
    C700FSelezioneAnagrafe.SQLCreato.Text:=S;
    C700FSelezioneAnagrafe.PulisciVecchiaSelezione:=False;
    C700FSelezioneAnagrafe.actConfermaExecute(C700FSelezioneAnagrafe.actConferma);
    RefreshQVista;
  except
    on E:EOracleError do
    begin
      frmSelAnagrafe.RipristinaC00SelAnagrafe;
      C700FSelezioneAnagrafe.actConfermaExecute(C700FSelezioneAnagrafe.actConferma);
      RefreshQVista;
      ShowMessage(SessioneOracle.ErrorMessage(E.ErrorCode) + #13#10 + 'Selezione non valida!');
    end;
  end;
  Screen.Cursor:=crDefault;
  (*with A002FAnagrafeDtM1,A002FAnagrafeDtM1.QVista do
    begin
    DisableControls;
    Close;
    SQL.Assign(ListSQL);
    if TVAzienda.Selected.Text <> '' then
      SelectString:=Format('AND %s = ''%s''',[Parametri.ColonneStruttura.Values[TVAzienda.Selected.Parent.Text],AggiungiApice(TVAzienda.Selected.Text)])
    else
      SelectString:=Format('AND %s IS NULL',[Parametri.ColonneStruttura.Values[TVAzienda.Selected.Parent.Text]]);
    SQL.Add(SelectString);
    //Imposto eventuale ordinamento
    if Trim(OrderString) <> ''  then
      Sql.Add(OrderString);
    //Imposto la data di lavoro per i dati storici
    SetVariable('DataLavoro',DataLavoro);
    EnableControls;
    try
      Open;
      DbGrid1.RePaint;
    except
      ShowMessage('Selezione non valida!');
    end;
    end;
  Screen.Cursor:=crDefault;*)
end;

procedure TA002FAnagrafeVistaPadre.TVAziendaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
{Risposta di TreeView ai tasti:
  Ctrl + Enter = Selezione
  F2 =  Edit della voce selezionata}
begin
  if (Shift = [ssCtrl]) and (Key = 13) then
    begin
    Key:=0;
    TVAziendaDblClick(Sender);
    end
  else if Key = VK_F2 then
    TVAzienda.Selected.EditText
end;

procedure TA002FAnagrafeVistaPadre.Ricercatestocontenuto1Click(Sender: TObject);
var TN:TTreeNode;
begin
  //if (TVAzienda.Selected = nil) or (not TVAzienda.Selected.HasChildren) then
  //  exit;
  TVAziendaSearch:=Trim(InputBox('Ricerca per testo contenuto','Nome dato',TVAziendaSearch));
  TN:=TVAzienda.Items[0];
  while TN <> nil do
  begin
    if Pos(UpperCase(TVAziendaSearch),UpperCase(TN.Text)) > 0 then
    begin
      TVAzienda.Select(TN,[]);
      Break;
    end;
    TN:=TN.getNextSibling;
  end;
end;

procedure TA002FAnagrafeVistaPadre.Successivo2Click(Sender: TObject);
var TN:TTreeNode;
begin
  if (TVAzienda.Selected = nil) or (not TVAzienda.Selected.HasChildren) then
    exit;
  if TVAziendaSearch = '' then
  begin
    Ricercatestocontenuto1Click(nil);
    exit;
  end;
  TN:=TVAzienda.Selected;
  if TN <> nil then
    TN:=TN.getNextSibling;
  while TN <> nil do
  begin
    if Pos(UpperCase(TVAziendaSearch),UpperCase(TN.Text)) > 0 then
    begin
      TVAzienda.Select(TN,[]);
      Break;
    end;
    TN:=TN.getNextSibling;
  end;
end;

procedure TA002FAnagrafeVistaPadre.SpeedButton30Click(Sender: TObject);
{Esecuzione dello statement}
var i:Integer;
    ErrMsg:String;
begin
  for i:=MSelect.Lines.Count - 1 downto 0 do
    if Trim(MSelect.Lines[i]) = '' then
      MSelect.Lines.Delete(i);
  if MSelect.Lines.Count = 0 then
    exit;
  (*with A002FAnagrafeDtM1,A002FAnagrafeDtM1.QVista do
  begin
    DisableControls;
    Close;
    OldSelect:=SelectString;
    if Trim(OldSelect) = '' then
      OldSelect:='AND PROGRESSIVO = 0';
    SQL.Assign(ListSQL);
    SelectString:='AND';
    for i:=0 to MSelect.Lines.Count - 1 do
      SelectString:=SelectString + ' ' + Trim(MSelect.Lines[i]);
    if Pos('ORDER BY',SelectString) > 0 then
    begin
      OrderString:=Copy(SelectString,Pos('ORDER BY',SelectString),Length(SelectString) + 1);
      SelectString:=Copy(SelectString,1,Pos('ORDER BY',SelectString) - 1);
    end;*)

    frmSelAnagrafe.SalvaC00SelAnagrafe;
    try
      C700FSelezioneAnagrafe.SQLCreato.Assign(MSelect.Lines);
      C700FSelezioneAnagrafe.PulisciVecchiaSelezione:=False;
      C700FSelezioneAnagrafe.actConfermaExecute(C700FSelezioneAnagrafe.actConferma);
      RefreshQVista;
    except
      on E:EOracleError do
      begin
        frmSelAnagrafe.RipristinaC00SelAnagrafe;
        C700FSelezioneAnagrafe.actConfermaExecute(C700FSelezioneAnagrafe.actConferma);
        RefreshQVista;
        ErrMsg:=UpperCase(SessioneOracle.ErrorMessage(E.ErrorCode)) + #13#10;
        ErrMsg:=ErrMsg + 'Selezione non valida, ripulire l''area di testo?';
        if R180MessageBox(ErrMsg,'DOMANDA') = mrYes then
          MSelect.Lines.Clear;
      end;
    end;

    (*SQL.Add(SelectString);
    //Imposto eventuale ordinamento
    if Trim(OrderString)<> ''  then
      Sql.Add(OrderString);
    //Imposto la data di lavoro per i dati storici
    SetVariable('DataLavoro',DataLavoro);
    EnableControls;
    try
      Open;
      DbGrid1.RePaint;
    except
      on E:EOracleError do
      begin
        //Creazione e Visualizzazione Messaggio Errore Oracle
        ErrMsg:=UpperCase(Session.ErrorMessage(E.ErrorCode)) + #13#10;
        ErrMsg:=ErrMsg + 'Selezione non valida, ripulire l''area di testo?';
        if R180MessageBox(ErrMsg,'DOMANDA') = mrYes then
          MSelect.Lines.Clear;

        SQL.Assign(ListSQL);
        SQL.Add(OldSelect);
        SelectString:=OldSelect;
        //Imposto eventuale ordinamento
        if Trim(OrderString)<> ''  then
          Sql.Add(OrderString);
        //Imposto la data di lavoro per i dati storici
        SetVariable('DataLavoro',DataLavoro);
        Open;
        EnableControls;
        DbGrid1.RePaint;
      end;
    end;
  end;*)
end;

procedure TA002FAnagrafeVistaPadre.TVAziendaEditing(Sender: TObject;
  Node: TTreeNode; var AllowEdit: Boolean);
{Inserimento di una voce nel TreeView}
begin
  TreeNodeOrig:=Node.Text;
  AllowEdit:=Node.HasChildren;
end;

procedure TA002FAnagrafeVistaPadre.TVAziendaEdited(Sender: TObject;
  Node: TTreeNode; var S: String);
{Ricerca dei dipendenti sul TreeView}
var TipoCampo:TFieldType;
    NomeCampo,S1,Operatore:String;
    P:Integer;
begin
  TreeNodeNew:=S;
  S:=TreeNodeOrig;
  Screen.Cursor:=crHourGlass;
  NomeCampo:=Parametri.ColonneStruttura.Values[TreeNodeOrig];
  P:=Parametri.ColonneStruttura.IndexOfName(TreeNodeOrig);
  TipoCampo:=TFieldType(StrToInt(Parametri.TipiStruttura[P]));
  if TipoCampo in [ftString] then
  begin
    {if Pos('%',TreeNodeNew) > 0 then
      S1:=Format('%s LIKE ''%s''',[NomeCampo,AggiungiApice(TreeNodeNew)])
    else
      S1:=Format('%s = ''%s''',[NomeCampo,AggiungiApice(TreeNodeNew)]);
    }
    // seleziona l'operatore di confronto
    Operatore:=IfThen(Pos('%',TreeNodeNew) > 0,'LIKE','=');
    // case insensitive per alcuni campi predeterminati (per ora solo cognome)
    if C700FSelezioneAnagrafe.IsCampoCaseInsensitive(NomeCampo) then
      S1:=Format('UPPER(%s) ' + Operatore + ' UPPER(''%s'')',[A000GetSuffissoQVista(NomeCampo) + NomeCampo,AggiungiApice(TreeNodeNew)])
    else
      S1:=Format('%s ' + Operatore + ' ''%s''',[A000GetSuffissoQVista(NomeCampo) + NomeCampo,AggiungiApice(TreeNodeNew)])
  end
  else if TipoCampo in [ftInteger,ftFloat] then
    S1:=Format('%s = %s',[A000GetSuffissoQVista(NomeCampo) + NomeCampo,TreeNodeNew])
  else
    S1:=Format('%s = ''%s''',[A000GetSuffissoQVista(NomeCampo) + NomeCampo,AggiungiApice(TreeNodeNew)]);
  S1:=S1 + #13#10 + VarToStr(A002FAnagrafeDtM1.QVista.GetVariable('ORDERBY'));
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  C700FSelezioneAnagrafe.DataLavoro:=Parametri.DataLavoro;
  C700FSelezioneAnagrafe.Datadal:=Parametri.DataLavoro;
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  try
    C700FSelezioneAnagrafe.SQLCreato.Text:=S1;
    C700FSelezioneAnagrafe.chkCessati.Checked:=True;
    C700FSelezioneAnagrafe.PulisciVecchiaSelezione:=False;
    C700FSelezioneAnagrafe.actConfermaExecute(C700FSelezioneAnagrafe.actConferma);
    RefreshQVista;
  except
    on E:EOracleError do
    begin
      frmSelAnagrafe.RipristinaC00SelAnagrafe;
      C700FSelezioneAnagrafe.actConfermaExecute(C700FSelezioneAnagrafe.actConferma);
      RefreshQVista;
      ShowMessage(SessioneOracle.ErrorMessage(E.ErrorCode) + #13#10 + 'Selezione non valida!');
    end;
  end;
  Screen.Cursor:=crDefault;
end;

procedure TA002FAnagrafeVistaPadre.ResettaTVAzienda;
var
  TN:TTreenode;
begin
  TN:=TVAzienda.Items[0];
  while TN <> nil do
  begin
    if TN.Parent = nil then
    begin
      TN.DeleteChildren;
      TVAzienda.Items.AddChild(TN,'Valori');
    end;
    TN:=TN.getNextSibling;
  end;
end;

procedure TA002FAnagrafeVistaPadre.FormClose(Sender: TObject;
  var Action: TCloseAction);
{Conferma uscita dal programma}
begin
  if MessageDlg('Uscire dalla sessione di lavoro?',
    mtInformation, [mbYes, mbNo], 0) = mrNo then
    Action:=caNone;
  PutParametriFunzione;
end;

procedure TA002FAnagrafeVistaPadre.Informazionisu1Click(Sender: TObject);
//var S:String;
begin
  A002FAbout:=TA002FAbout.Create(nil);
  try
    A002FAbout.ShowModal;
  finally
    FreeAndNil(A002FAbout);
  end;
end;

procedure TA002FAnagrafeVistaPadre.DBGrid1TitleClick(Column: TColumn);
{Ordina la griglia per la colonna selezionata}
var N,P:Integer;
begin
  N:=Column.Index;
  P:=A002FAnagrafeDtM1.QVista.FieldByName('PROGRESSIVO').AsInteger;
  frmSelAnagrafe.PutC700SelAnagrafeOrderBy(Column.FieldName);
  if VarToStr(A002FAnagrafeDtM1.QVista.GetVariable('ORDERBY')) <> frmSelAnagrafe.GetC700SelAnagrafeOrderBy then
  begin
    A002FAnagrafeDtM1.QVista.DisableControls;
    A002FAnagrafeDtM1.QVista.Close;
    A002FAnagrafeDtM1.QVista.SetVariable('ORDERBY',frmSelAnagrafe.GetC700SelAnagrafeOrderBy);
    A002FAnagrafeDtM1.QVista.Open;
    A002FAnagrafeDtM1.ApplicaQVistaFields;
    //A002FAnagrafeDtM1.OrdinaAnagrafe(Column.FieldName);
    DbGrid1.SelectedIndex:=N;
    A002FAnagrafeDtM1.QVista.SearchRecord('PROGRESSIVO',P,[srFromBeginning]);
    A002FAnagrafeDtM1.QVista.EnableControls;
  end;
end;

procedure TA002FAnagrafeVistaPadre.TVAziendaContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled:=TVAzienda.Selected <> nil;
  if Handled then
    Handled:=TVAzienda.Selected.Parent <> nil;
end;

procedure TA002FAnagrafeVistaPadre.Aggiorna1Click(Sender: TObject);
begin
  if TVAzienda.Selected <> nil then
    if TVAzienda.Selected.Parent = nil then
    begin
      TVAzienda.Selected.DeleteChildren;
      TVAzienda.Items.AddChild(TVAzienda.Selected,'Valori');
      TVAzienda.Selected.Expand(False);
    end;
end;

procedure TA002FAnagrafeVistaPadre.LayoutSchedaAnagrafica;
var SolaLetturaOriginale:Boolean;
begin
  SolaLetturaOriginale:=SolaLettura;
  try
    SolaLettura:=A000GetInibizioni('Tag','151') = 'R';
    A002FAnagrafeGest.PageControl1.Parent:=A002FLayout;
    with A002FLayout do
    begin
      Width:=A002FAnagrafeGest.Width;
      Height:=A002FAnagrafeGest.Height;
      ShowModal;
    end;
  finally
    SolaLettura:=SolaLetturaOriginale;
  end;
end;

procedure TA002FAnagrafeVistaPadre.actlstGrigliaExecute(Sender: TObject);
begin
  if Sender = actSalvaGriglia then
    SalvaGriglia
  else if Sender = actRipristinaGriglia then
    RipristinaGriglia
  else if Sender = actNomeColonna then
    NomeColonna
  else if Sender = actCancellaColonna then
    DbGrid1.SelectedField.Visible:=False
  else if Sender = actRipristinaColonne then
    RipristinaColonne
  else if Sender = actRefresh then
  begin
    A002FAnagrafeDtM1.A002FAnagrafeMW.selT033_campoDecode.Close;
    A002FAnagrafeDtM1.A002FAnagrafeMW.selT033_campoDecode.SetVariable('Nome',Parametri.Layout);
    A002FAnagrafeDtM1.A002FAnagrafeMW.selT033_campoDecode.Open;
    A002FAnagrafeDtM1.CaricaGriglia;
  end;
  A002FAnagrafeDtM1.RegistraQVistaFields;
end;

procedure TA002FAnagrafeVistaPadre.SalvaGriglia;
{Salva le impostazioni correnti della griglia}
var i:integer;
    Nome:String;
begin
  if MessageDlg('Salvare le impostazioni personalizzate della griglia?',mtInformation, [mbYes, mbNo], 0) = mrNo then
    exit;
  with A002FAnagrafeDtM1 do
    begin
    OperSql.SQL.Clear;
    OperSql.SQL.Add('DELETE FROM T034_LayoutGriglia WHERE Operatore = ' + IntToStr(ProgOper));
    try
      OperSql.Execute;
      SessioneOracle.Commit;
    except
      SessioneOracle.Rollback;
      exit;
    end;
    try
    for i:=0 to QVista.FieldDefs.Count-1 do
      begin
      Nome:=QVista.FieldDefs[i].Name;
      if (Nome = 'T430PROGRESSIVO') or (Nome = 'PROGRESSIVO') then Continue;
      InsQ034.SetVariable('Operatore',ProgOper);
      InsQ034.SetVariable('NomeCampo',Nome);
      if QVista.FieldByName(Nome).Visible then
        InsQ034.SetVariable('Visible','S')
      else
        InsQ034.SetVariable('Visible','N');
      InsQ034.SetVariable('Posizione',QVista.FieldByName(Nome).Index);
      InsQ034.SetVariable('Lunghezza',Min(QVista.FieldByName(Nome).DisplayWidth,1000)); // limitato a 1000
      InsQ034.SetVariable('Label',QVista.FieldByName(Nome).DisplayLabel);
      InsQ034.Execute;
      end;
    SessioneOracle.Commit;
    except
      SessioneOracle.Rollback;
      exit;
    end;
    end;
end;

procedure TA002FAnagrafeVistaPadre.RipristinaGriglia;
begin
  if MessageDlg('Cancellare le impostazioni personalizzate della griglia?',
                 mtInformation, [mbYes, mbNo], 0) = mrNo then exit;
  with A002FAnagrafeDtM1 do
    begin
    OperSql.SQL.Clear;
    OperSql.SQL.Add('DELETE FROM T034_LayoutGriglia WHERE Operatore = ' + IntToStr(ProgOper));
    try
      OperSql.Execute;
      SessioneOracle.Commit;
    except
      SessioneOracle.Rollback;
      raise;
    end;
    end;
  A002FAnagrafeDtM1.CaricaGriglia;
end;

procedure TA002FAnagrafeVistaPadre.NomeColonna;
{Cambia la label dell'intestazione della colonna}
var Nome:String;
begin
  with DbGrid1 do
    begin
    if SelectedField = nil then exit;
    Nome:=SelectedField.DisplayLabel;
    if InputQuery('Intestazione colonna', 'Nuovo nome:', Nome) then
      if Trim(Nome) <> '' then SelectedField.DisplayLabel:=Nome;
    end;
end;

procedure TA002FAnagrafeVistaPadre.RipristinaColonne;
{Ripristina tutte le colonne}
var
  i:integer;
  Nome:string;
begin
  with A002FAnagrafeDtM1 do
  begin
    for i:=0 to QVista.FieldCount - 1 do
    begin
      Nome:=QVista.Fields[i].FieldName;
      if Copy(Nome,1,6) = 'T430D_' then
        Nome:=Copy(Nome,7,Length(Nome) - 6)
      else if Copy(Nome,1,4) = 'T430' then
        Nome:=Copy(Nome,5,Length(Nome) - 4);
      if A002FAnagrafeMW.selT033_campoDecode.SearchRecord('CAMPODB',VarArrayOf([Nome]),[srFromBeginning]) then
        QVista.Fields[i].Visible:=True
      else
        QVista.Fields[i].Visible:=False;
    end;
    QVista.FieldByName('Progressivo').Visible:=False;
    QVista.FieldByName('T430Progressivo').Visible:=False;
  end;
end;

procedure TA002FAnagrafeVistaPadre.GetDatiDipendente(Azione:TObject = nil);
begin
  PProgressivo:=0;
  with A002FAnagrafeDtM1.QVista do
    if Active then
    begin
      PProgressivo:=FieldByName('Progressivo').AsInteger;
      C700Progressivo:=PProgressivo;
    end;

  //Verifica se deve essere selezionata almeno una anagrafica
  if (Azione <> nil) and (L021RichiedeAnagraficaSelezionata((Azione as TAction).Tag)) and
     (PProgressivo <= 0) then
    raise Exception.Create(A000MSG_ERR_NO_DIP);
end;

procedure TA002FAnagrafeVistaPadre.DBGrid1ColumnMoved(Sender: TObject;
  FromIndex, ToIndex: Integer);
begin
  A002FAnagrafeDtM1.RegistraQVistaFields;
  if FromIndex = ToIndex then
    mnuRicercaCompleta.Checked:=False;
end;

procedure TA002FAnagrafeVistaPadre.DBGrid1DblClick(Sender: TObject);
begin
  if DbGrid1.DataSource.DataSet.RecordCount > 0 then
  begin
    actSchedaAnagrafica.Checked:=True;
    A002FAnagrafeGest.Show;
  end;
end;

procedure TA002FAnagrafeVistaPadre.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  DataFineRap, DataInizioRap:TDateTime;
begin
  with A002FAnagrafeDtM1 do
    if not(gdSelected in State) and QVista.Active and (QVista.RecordCount > 0) then
    begin
      DataFineRap:=QVista.FieldByName('T430FINE').AsDateTime;
      if DataFineRap = 0 then
        DataFineRap:=EncodeDate(3999,12,31);
      DataInizioRap:=QVista.FieldByName('T430INIZIO').AsDateTime;
      if DataInizioRap = 0 then
        DataInizioRap:=EncodeDate(1899,12,30);
      if Filtrocessati1.Checked and ((DataInizioRap > DataLavoro) or (DataFineRap < DataLavoro)) then
        DBGrid1.Canvas.Font.Color:=clRed
      else if (DataInizioRap >= R180InizioMese(DataLavoro)) and (DataInizioRap <= R180FineMese(DataLavoro)) then
        DBGrid1.Canvas.Font.Color:=C700NEO_ASSUNTO
      else
        DBGrid1.Canvas.Font.Color:=clBlack;
      DBGrid1.DefaultDrawColumnCell(Rect,DataCol,Column,State);
    end;
end;

procedure TA002FAnagrafeVistaPadre.mnuCopiaExcelClick(Sender: TObject);
{ Copia in excel la grid con i dati dei dipendenti attualmente selezionati }
var P:Integer;
begin
  try
    P:=A002FAnagrafeDtM1.QVista.FieldByName('PROGRESSIVO').AsInteger;
    A002FAnagrafeDtM1.QVista.AfterScroll:=nil;
    R180DBGridCopyToClipboard(DBGrid1, True, False);
  finally
    A002FAnagrafeDtM1.QVista.SearchRecord('PROGRESSIVO',P,[srFromBeginning]);
    A002FAnagrafeDtM1.QVista.AfterScroll:=A002FAnagrafeDtM1.QVistaAfterScroll;
  end;
end;

procedure TA002FAnagrafeVistaPadre.mnuRicercaCompletaClick(
  Sender: TObject);
begin
  mnuRicercaCompleta.Checked:=not mnuRicercaCompleta.Checked;
  A002FAnagrafeDtM1.CaricaTVAzienda(mnuRicercaCompleta.Checked);
  TVAzienda.SetFocus;
end;

procedure TA002FAnagrafeVistaPadre.PopupMenu1Popup(Sender: TObject);
begin
  Aggiorna1.Visible:=TVAzienda.Items.Count > 0;
  sepPopMnu1.Visible:=TVAzienda.Items.Count > 0;
end;

procedure TA002FAnagrafeVistaPadre.actRichiestaAssistenzaExecute(
  Sender: TObject);
begin
  if Sender = actRichiestaAssistenza then
  try
    GetDatiDipendente(Sender);
    frmSelAnagrafe.SalvaC00SelAnagrafe;
    C700Distruzione;
    OpenA078RichiestaAssistenza(PProgressivo)
  finally
    if C700FSelezioneAnagrafe = nil then
    begin
      C700DatiSelezionati:=C700CampiBase;
      C700Creazione(SessioneOracle);
      frmSelAnagrafe.RipristinaC00SelAnagrafe;
    end;
  end
  else if Sender = actAllineamentoClient then
    OpenA134FAllineamentoClient;
end;


procedure TA002FAnagrafeVistaPadre.GetParametriFunzione;
{Leggo i parametri della form}
var
  i,W,H:Integer;
  sMSelect:String;
begin
  //Leggo ed eseguo l'eventuale filtro sulla griglia
  CreaC004(SessioneOracle,'A002',Parametri.ProgOper);
  sMSelect:='';
  i:=1;
  repeat
    sMSelect:=C004FParamForm.GetParametro('MSELECT' + IntToStr(i),'');
    MSelect.Lines.Text:=MSelect.Lines.Text + sMSelect;
    inc(i);
  until sMSelect = '';
  actFiltroCessati.Checked:=C004FParamForm.GetParametro('VISUALIZZA_CESSATI','S') = 'S';
  W:=StrToIntDef(C004FParamForm.GetParametro('WIDTH','600'),600);
  H:=StrToIntDef(C004FParamForm.GetParametro('HEIGHT','600'),600);
  if (W = -1) or (H = -1) then
    WindowState:=wsMaximized
  else
  begin
    WindowState:=wsNormal;
    Width:=W;
    Height:=H;
  end;
  W:=StrToIntDef(C004FParamForm.GetParametro('WIDTH_SCHEDA','620'),620);
  H:=StrToIntDef(C004FParamForm.GetParametro('HEIGHT_SCHEDA','470'),470);
  if (W = -1) or (H = -1) then
    A002FAnagrafeGest.WindowState:=wsMaximized
  else
  begin
    A002FAnagrafeGest.WindowState:=wsNormal;
    A002FAnagrafeGest.Width:=W;
    A002FAnagrafeGest.Height:=H;
  end;
  FreeAndNil(C004FParamForm);
end;

procedure TA002FAnagrafeVistaPadre.PutParametriFunzione;
{Scrivo i parametri della forma}
var
  i: Integer;
  Str:String;
begin
  //Memorizzo il filtro della griglia
  try
    CreaC004(SessioneOracle,'A002',Parametri.ProgOper);
  except
  end;
  C004FParamForm.Cancella001;
  i:=1;
  while Length(MSelect.Lines.Text) > 0 do
  begin
    C004FParamForm.PutParametro('MSELECT' + IntToStr(i),Copy(MSelect.Lines.Text,1,80));
    MSelect.Lines.Text:=Copy(MSelect.Lines.Text,81,Length(MSelect.Lines.Text) - 80);
    inc(i);
  end;
  Str:='';
  if actFiltroCessati.Checked then
    Str:='S'
  else
    Str:='N';
  C004FParamForm.PutParametro('VISUALIZZA_CESSATI',Str);
  if WindowState = wsMaximized then
  begin
    C004FParamForm.PutParametro('WIDTH','-1');
    C004FParamForm.PutParametro('HEIGHT','-1');
  end
  else
  begin
    C004FParamForm.PutParametro('WIDTH',IntToStr(Width));
    C004FParamForm.PutParametro('HEIGHT',IntToStr(Height));
  end;
  if A002FAnagrafeGest.WindowState = wsMaximized then
  begin
    C004FParamForm.PutParametro('WIDTH_SCHEDA','-1');
    C004FParamForm.PutParametro('HEIGHT_SCHEDA','-1');
  end
  else
  begin
    C004FParamForm.PutParametro('WIDTH_SCHEDA',IntToStr(A002FAnagrafeGest.Width));
    C004FParamForm.PutParametro('HEIGHT_SCHEDA',IntToStr(A002FAnagrafeGest.Height));
  end;
  try SessioneOracle.Commit; except end;
  FreeAndNil(C004FParamForm);
end;

procedure TA002FAnagrafeVistaPadre.actAmministrazoneSistemaExecute(
  Sender: TObject);
begin
  if Sender = actRidefinizioneCampiAnagrafici then
    with A002FAnagrafeDtM1 do
    begin
      if QVista.FieldDefs.Count = 0 then
        raise Exception.Create('Vista V430_STORICO non disponibile, impossibile accedere!');
      RidefAnag(QVista.FieldDefs);
      QI010.Open;
      GetColonneStruttura(False);
      CaricaGriglia;
      RegistraQVistaFields;
      QI010.Close;
      C700FSelezioneAnagrafeDtM.CaricaTVAzienda(C700FSelezioneAnagrafe.mnuRicercaCompleta.Checked);
      CaricaTVAzienda(mnuRicercaCompleta.Checked);
    end
  else if Sender = actDefinizioneDatiLiberi then
    DatiLiberiGest
  else if Sender = actRelazioniAnagrafe then
    OpenA136FRelazioniAnagrafe('','','',0)
  else if Sender = actRicostruzioneAnagrafico then
    A002FAnagrafeDtM1.RicostruisciAnagrafico
  else if Sender = actUtilityDB then
    OpenA099UtilityDB
  else if Sender = actLayoutSchedaAnagrafica then
    LayoutSchedaAnagrafica
  else
  try
    GetDatiDipendente(Sender);
    frmSelAnagrafe.SalvaC00SelAnagrafe;
    C700Distruzione;
    if Sender = actAziendeOperatori then
      OpenA008Operatori
    else if Sender = actAllineaStorici then
      OpenA044AllineaStorici(PProgressivo)
    else if Sender = actMonitoraggioLog then
      OpenA093Operazioni
    else if Sender = actMsgElaborazioni then
      OpenA083MsgElaborazioni('','','','');
  finally
    if C700FSelezioneAnagrafe = nil then
    begin
      C700DatiSelezionati:=C700CampiBase;
      C700Creazione(SessioneOracle);
      frmSelAnagrafe.RipristinaC00SelAnagrafe;
    end;
  end;
end;

procedure TA002FAnagrafeVistaPadre.actAnagraficoStipendiExecute(
  Sender: TObject);
begin
  (*
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  try
    OpenP430FAnagrafico(A002FAnagrafeDtM1.Q030.FieldByName('PROGRESSIVO').AsInteger);
  finally
    C700DatiSelezionati:=C700CampiBase;
    C700Creazione(SessioneOracle);
    frmSelAnagrafe.RipristinaC00SelAnagrafe;
  end;
  *)
end;

procedure TA002FAnagrafeVistaPadre.actCdcPercentExecute(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  try
    OpenA082CdcPercent(A002FAnagrafeDtM1.Q030.FieldByName('PROGRESSIVO').AsInteger);
  finally
    C700DatiSelezionati:=C700CampiBase;
    C700Creazione(SessioneOracle);
    frmSelAnagrafe.RipristinaC00SelAnagrafe;
  end;
end;

procedure TA002FAnagrafeVistaPadre.Novitdellaversione1Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(ExtractFilePath(Application.ExeName) + 'Help\IrisWIN_note.pdf'), nil, PChar(ExtractFilePath(Application.ExeName)), 1);
end;

procedure TA002FAnagrafeVistaPadre.MSelectKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = 13) then
    SpeedButton30Click(Sender);
end;

end.
