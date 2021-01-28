unit R004UGestStorico;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Menus, ExtCtrls, Grids, DbCtrls, DBGrids, StdCtrls, Printers,
  Mask, DB, Buttons, A000UCostanti, A000USessione,A000UInterfaccia, Oracle, OracleData,
  A002UInterfacciaSt, C009UCopiaSu, C180FUnzioniGenerali, ToolWin, ImgList, ActnList,
  Crtl, DBClient, Variants, SelAnagrafe, C700USelezioneAnagrafe, C700USelezioneAnagrafeDtM,
  ToolbarFiglio
  {$IFNDEF VER210}, System.Actions, System.ImageList{$ENDIF};

type
  TEvDataset = procedure (DataSet: TDataSet) of object;

  TInterfacciaR004 = class
    chkStoriciPrec,
    chkStoriciSucc:TCheckBox;
    LChiavePrimaria:TStringList;
    LValoriOriginali:TStringList;
    StoricizzazioneInCorso,
    RipristinoValoriInCorso,
    GestioneStoricizzata,
    OttimizzaStorico,
    OttimizzaDecorrenzaFine,
    AllineaSoloDecorrenzeIntersecanti,
    GestioneDecorrenzaFine:Boolean;
    NomeTabella,
    AliasNomeTabella,
    NomeTabellaPadre,
    StatoBeforePost:String;
    DataLavoro:TDateTime;
    lstDecorrenze:array of TDateTime;
    TabelleRelazionate:array of TOracleDataSet;
    AllineaDecorrenzaFine:procedure(DataSet: TDataSet) of object;
  end;

  TR004FGestStorico = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Chiudi1: TMenuItem;
    R003_N1: TMenuItem;
    Stampa1: TMenuItem;
    StatusBar: TStatusBar;
    DButton: TDataSource;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Copiada1: TMenuItem;
    grbDecorrenza: TGroupBox;
    dedtDecorrenza: TDBEdit;
    lblDecorrenza: TLabel;
    Visionecorrente1: TMenuItem;
    btnStoricizza: TSpeedButton;
    chkStoriciPrec: TCheckBox;
    chkStoriciSucc: TCheckBox;
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    TCerca: TToolButton;
    ToolButton13: TToolButton;
    TPrimo: TToolButton;
    TPrec: TToolButton;
    TSucc: TToolButton;
    TUltimo: TToolButton;
    ToolButton6: TToolButton;
    TInser: TToolButton;
    TModif: TToolButton;
    TCanc: TToolButton;
    ToolButton10: TToolButton;
    TAnnulla: TToolButton;
    TRegis: TToolButton;
    ToolButton14: TToolButton;
    TGomma: TToolButton;
    ToolButton16: TToolButton;
    TStampa: TToolButton;
    ActionList1: TActionList;
    actRicerca: TAction;
    actPrimo: TAction;
    actPrecedente: TAction;
    actSuccessivo: TAction;
    actUltimo: TAction;
    actInserisci: TAction;
    actModifica: TAction;
    actCancella: TAction;
    actConferma: TAction;
    actAnnulla: TAction;
    actStampa: TAction;
    actStoricizza: TAction;
    actDataLavoro: TAction;
    actEsci: TAction;
    ToolButton1: TToolButton;
    actStoricoPrecedente: TAction;
    actStoricoSuccessivo: TAction;
    btnStoricoPrec: TToolButton;
    btnStoricoSucc: TToolButton;
    Datadilavoro1: TMenuItem;
    actVisioneCorrente: TAction;
    actCopiaSu: TAction;
    actGomma: TAction;
    Strumenti1: TMenuItem;
    Ricerca1: TMenuItem;
    Primo1: TMenuItem;
    Precedente1: TMenuItem;
    Successivo1: TMenuItem;
    Ultimo1: TMenuItem;
    Storicoprecedente1: TMenuItem;
    Storicosuccessivo1: TMenuItem;
    Inserisci1: TMenuItem;
    Modifica1: TMenuItem;
    Cancella1: TMenuItem;
    Conferma1: TMenuItem;
    Conferma2: TMenuItem;
    actGomma1: TMenuItem;
    Storicizza1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    actRefresh: TAction;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    Refresh1: TMenuItem;
    actStampaVideata: TAction;
    Stampavideata1: TMenuItem;
    R003_N5: TMenuItem;
    R003_N6: TMenuItem;
    cmbDateDecorrenza: TComboBox;
    actVisioneAnnuale: TAction;
    Visioneannuale1: TMenuItem;
    procedure actVisioneAnnualeExecute(Sender: TObject);
    procedure cmbDateDecorrenzaChange(Sender: TObject);
    procedure dedtDecorrenzaChange(Sender: TObject);
    procedure actStampaVideataExecute(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure Chiudi1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TPrimoClick(Sender: TObject);
    procedure TCancClick(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure TModifClick(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TGommaClick(Sender: TObject);
    procedure TCercaClick(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SettaDBStampa(Sessione:TOracleSession);
    procedure FormShow(Sender: TObject);
    procedure btnStoricoPrecClick(Sender: TObject);
    procedure btnStoricoSuccClick(Sender: TObject);
    procedure Visionecorrente1Click(Sender: TObject);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure actDataLavoroExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure Copiada1Click(Sender: TObject);
  private
    { Private declarations }
    function DataSetName(DSet:TDataSet):string;
    procedure CreaCampiPersistentiQuery2;
    procedure InizializzaQueryStandard;
    procedure InizializzaQueryPersonalizzata;
    function CreaC009(Storicizza:Boolean):Boolean;
    procedure GetValoriChiavePrimaria(var PK:string; var V:Variant; ConDecorrenza:Boolean);
    procedure StampaAnagraficaMista;
    procedure SalvaValoriOriginali;
    procedure RipristinaValoriOriginali;
    function CheckRelazioniEsistenti:boolean;
  protected
    { Protected declarations }
    AliasR001,IntestazioneR001,TitoloR001,FromSql,SelezioneSQL:String;
    NomiCampiR001:TStringList;
    SessioneR001:TOracleSession;
    SQLOriginale:String;
    QueryStampa:TStringList;
    R001LinkC700(*,EseguiStampaMista*):Boolean;
    FiltroR001:Boolean;
    CheckRelazioni: TOracleQuery;
    procedure ParametriStampa;
    procedure NumRecords;
    procedure SetPanelMessage(S:String);
    procedure SetTabelleRelazionate(const DS:array of TOracleDataSet);
    procedure CercaStoricoCorrente;
    procedure GetC700SelAnagrafeInterna;
    procedure GetDateDecorrenza;
  public
    { Public declarations }
    Azienda,Operatore:string;
    TipoDB:TDataBaseDrv;
    MovCassa:Boolean;
    InterfacciaR004:TInterfacciaR004;
    C700SelAnagrafeInterna:TOracleDataSet;
  end;

var
  R004FGestStorico: TR004FGestStorico;

implementation

uses C001URicerca, C001UFiltroTabelle,C001UFiltroTabelleDTM,C001UScegliCampi,
     A003UDataLavoroBis;

{$R *.DFM}

procedure TR004FGestStorico.FormCreate(Sender: TObject);
begin
  StatusBar.Panels[0].Text:='';//FormatDateTime('dd/mm/yyyy',Date);
  NomiCampiR001:=TStringList.Create;
  QueryStampa:=TStringList.Create;
  R001LinkC700:=True;
  FiltroR001:=False;
  //EseguiStampaMista:=True;
  CopiaDa1.Visible:=False;
  InterfacciaR004:=TInterfacciaR004.Create;
  InterfacciaR004.GestioneStoricizzata:=True;
  InterfacciaR004.OttimizzaStorico:=True;
  InterfacciaR004.OttimizzaDecorrenzaFine:=True;
  InterfacciaR004.GestioneDecorrenzaFine:=True;
  InterfacciaR004.AllineaSoloDecorrenzeIntersecanti:=False;
  InterfacciaR004.chkStoriciPrec:=chkStoriciPrec;
  InterfacciaR004.chkStoriciSucc:=chkStoriciSucc;
  InterfacciaR004.LValoriOriginali:=TStringList.Create;
  InterfacciaR004.LChiavePrimaria:=TStringList.Create;
  InterfacciaR004.StoricizzazioneInCorso:=False;
  InterfacciaR004.RipristinoValoriInCorso:=False;
  InterfacciaR004.DataLavoro:=Parametri.DataLavoro;
  if InterfacciaR004.DataLavoro = 0 then
    InterfacciaR004.DataLavoro:=Date;
  StatusBar.Panels[1].Text:='Data lavoro:' + FormatDateTime('dd/mm/yyyy',InterfacciaR004.DataLavoro);
  R180ToolBarHandleNeeded(Self);//Necessario in XE3 quando si rendono invisibili le azioni

  CheckRelazioni:=TOracleQuery.Create(nil);
  if (DButton.DataSet <> nil) and (DButton.DataSet is TOracleDataSet) then
    CheckRelazioni.Session:=TOracleDataSet(DButton.DataSet).Session;
  CheckRelazioni.SQL.Clear;
  CheckRelazioni.SQL.Add('BEGIN');
  CheckRelazioni.SQL.Add('  :result := MEDP_CHECK_RELAZIONI_ESISTENTI (');
  CheckRelazioni.SQL.Add('  :MASCHERA,');
  CheckRelazioni.SQL.Add('  :TABELLA,');
  CheckRelazioni.SQL.Add('  :CHIAVE,');
  CheckRelazioni.SQL.Add('  :DECORRENZA,');
  CheckRelazioni.SQL.Add('  :SCADENZA);');
  CheckRelazioni.SQL.Add('END;');
  CheckRelazioni.DeclareVariable('RESULT',otString);
  CheckRelazioni.DeclareVariable('MASCHERA',otString);
  CheckRelazioni.DeclareVariable('TABELLA',otString);
  CheckRelazioni.DeclareVariable('CHIAVE',otString);
  CheckRelazioni.DeclareVariable('DECORRENZA',otDate);
  CheckRelazioni.DeclareVariable('SCADENZA',otDate);
end;

procedure TR004FGestStorico.SetTabelleRelazionate(const DS:array of TOracleDataSet);
var i:Integer;
begin
  SetLength(InterfacciaR004.TabelleRelazionate,Length(DS));
  for i:=0 to High(DS) do
    InterfacciaR004.TabelleRelazionate[i]:=DS[i];
end;

procedure TR004FGestStorico.FormShow(Sender: TObject);
begin
  if DButton.DataSet <> nil then
  begin
    if DButton.DataSet.Active then
    begin
      GetDateDecorrenza;
      NumRecords;
    end;
    try
      TDateTimeField(DButton.DataSet.FieldByName('DECORRENZA')).DisplayFormat:='dd/mm/yyyy';
      DButton.DataSet.FieldByName('DECORRENZA').EditMask:='!00/00/0000;1;_';
    except
    end;
    if DButton.DataSet is TOracleDataSet then
      (DButton.DataSet as TOracleDataSet).ReadOnly:=SolaLettura;
  end;
  dedtDecorrenza.DataField:='DECORRENZA';
end;

procedure TR004FGestStorico.GetC700SelAnagrafeInterna;
var i:Integer;
begin
  C700SelAnagrafeInterna:=nil;
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TFrmSelAnagrafe then
    begin
      C700SelAnagrafeInterna:=C700SelAnagrafe;
      Break;
    end;
end;

procedure TR004FGestStorico.CreaCampiPersistentiQuery2;
var I:Integer;
begin
  with C001FFiltroTabelleDtM do
    begin
    for I:=Query2.FieldCount-1 downto 0 do
      Query2.Fields[I].Free;
    Query2.FieldDefs.UpDate;
    for I:=0 to Query2.FieldDefs.Count-1 do
      Query2.FieldDefs[I].CreateField(Query2);
    end;
end;

procedure TR004FGestStorico.TPrimoClick(Sender: TObject);
var S,S2,RI,RI2:String;
    ProcAfterScroll:TevDataSet;
  procedure CercaStoricoAvanti;
  begin
    //Cerco il record alla data di lavoro corrente scorrendo il dataset avanti
    if R180GetCampiConcatenati(DButton.DataSet,InterfacciaR004.LChiavePrimaria) <> S then
    begin
      S2:=R180GetCampiConcatenati(DButton.DataSet,InterfacciaR004.LChiavePrimaria);
      RI2:=TOracleDataSet(DButton.DataSet).RowID;
      while (not DButton.DataSet.Eof) and
            (R180GetCampiConcatenati(DButton.DataSet,InterfacciaR004.LChiavePrimaria) = S2) and
            (DButton.DataSet.FieldByName('DECORRENZA').AsDateTime <= InterfacciaR004.DataLavoro) do
      begin
        RI2:=TOracleDataSet(DButton.DataSet).RowID;
        DButton.DataSet.Next;
      end;
      TOracleDataSet(DButton.DataSet).SearchRecord('ROWID',RI2,[srFromBeginning]);
    end;
  end;
  procedure CercaStoricoIndietro;
  begin
    //Cerco il record alla data di lavoro corrente scorrendo il dataset indietro
    if R180GetCampiConcatenati(DButton.DataSet,InterfacciaR004.LChiavePrimaria) <> S then
    begin
      S2:=R180GetCampiConcatenati(DButton.DataSet,InterfacciaR004.LChiavePrimaria);
      RI2:=TOracleDataSet(DButton.DataSet).RowID;
      while (not DButton.DataSet.Bof) and
            (R180GetCampiConcatenati(DButton.DataSet,InterfacciaR004.LChiavePrimaria) = S2) and
            (DButton.DataSet.FieldByName('DECORRENZA').AsDateTime > InterfacciaR004.DataLavoro) do
      begin
        RI2:=TOracleDataSet(DButton.DataSet).RowID;
        DButton.DataSet.Prior;
      end;
      if S2 <> R180GetCampiConcatenati(DButton.DataSet,InterfacciaR004.LChiavePrimaria) then
        TOracleDataSet(DButton.DataSet).SearchRecord('ROWID',RI2,[srFromBeginning]);
    end;
  end;
begin
  RI:=TOracleDataSet(DButton.DataSet).RowID;
  S:=R180GetCampiConcatenati(DButton.DataSet,InterfacciaR004.LChiavePrimaria);
  DButton.DataSet.DisableControls; //Alberto 25/08/2006
  ProcAfterScroll:=DButton.DataSet.AfterScroll;
  DButton.DataSet.AfterScroll:=nil;
  try
    if Sender = actPrimo then
    begin
      DButton.DataSet.First;
      if InterfacciaR004.GestioneStoricizzata and (not actVisioneCorrente.Checked) then
        CercaStoricoAvanti;
    end;
    if Sender = actPrecedente then
    begin
      if (not InterfacciaR004.GestioneStoricizzata) or actVisioneCorrente.Checked then
        DButton.DataSet.Prior
      else
      begin
        if (*(not actVisioneCorrente.Checked)*) InterfacciaR004.GestioneDecorrenzaFine and (DButton.DataSet.FindField('DECORRENZA_FINE') <> nil)
        and not InterfacciaR004.AllineaSoloDecorrenzeIntersecanti then
          //Alberto 25/08/2006: mi posiziono subito sull'ultima decorrenza precedente
          TOracleDataSet(DButton.DataSet).SearchRecord('DECORRENZA_FINE',VarArrayOf([EncodeDate(3999,12,31)]),[srBackward])
        else
          //Se non gestisco la decorrenza_fine (GestioneDecorrenzaFine = False) oppure non prevedo necessariamente il 31/12/3999 (AllineaSoloDecorrenzeIntersecanti = True)
          //allora ciclo sui record per trovare la chiave precedente
          repeat
            DButton.DataSet.Prior;
          until (R180GetCampiConcatenati(DButton.DataSet,InterfacciaR004.LChiavePrimaria) <> S) or DButton.DataSet.Bof;
        CercaStoricoIndietro;
      end;
    end;
    if Sender = actSuccessivo then
    begin
      if (not InterfacciaR004.GestioneStoricizzata) or actVisioneCorrente.Checked then
        DButton.DataSet.Next
      else
      begin
        if (*(not actVisioneCorrente.Checked)*) InterfacciaR004.GestioneDecorrenzaFine and (DButton.DataSet.FindField('DECORRENZA_FINE') <> nil)
        and not InterfacciaR004.AllineaSoloDecorrenzeIntersecanti then
        begin
          //Alberto 25/08/2006: mi posiziono subito sull'ultima decorrenza e vado avanti ancora di un record
          if DButton.DataSet.FieldByName('DECORRENZA_FINE').AsDateTime < EncodeDate(3999,12,31) then
            TOracleDataSet(DButton.DataSet).SearchRecord('DECORRENZA_FINE',VarArrayOf([EncodeDate(3999,12,31)]),[]);
          DButton.DataSet.Next;
        end
        else
          //Se non gestisco la decorrenza_fine (GestioneDecorrenzaFine = False) oppure non prevedo necessariamente il 31/12/3999 (AllineaSoloDecorrenzeIntersecanti = True)
          //allora ciclo sui record per trovare la chiave successiva
          repeat
            DButton.DataSet.Next;
          until (R180GetCampiConcatenati(DButton.DataSet,InterfacciaR004.LChiavePrimaria) <> S) or DButton.DataSet.Eof;
        CercaStoricoAvanti;
      end;
    end;
    if Sender = actUltimo then
    begin
      DButton.DataSet.Last;
      if InterfacciaR004.GestioneStoricizzata and (not actVisioneCorrente.Checked) then
        CercaStoricoIndietro;
    end;
    //Riposizionameto sullo storico precedente al browsing se non è variata la chiave
    if InterfacciaR004.GestioneStoricizzata then
    begin
      if (RI <> TOracleDataSet(DButton.DataSet).RowID) and (R180GetCampiConcatenati(DButton.DataSet,InterfacciaR004.LChiavePrimaria) = S) then
        TOracleDataSet(DButton.DataSet).SearchRecord('ROWID',RI,[srFromBeginning])
      else
        GetDateDecorrenza;
    end;
  finally
    DButton.DataSet.EnableControls;
    DButton.DataSet.AfterScroll:=ProcAfterScroll;
  end;
  NumRecords;
  //forzo scroll per scatenare tutti gli eventi derivati dallo scroll
  TOracleDataSet(DButton.DataSet).SearchRecord('ROWID',TOracleDataSet(DButton.DataSet).RowID,[srFromBeginning]);
end;

procedure TR004FGestStorico.actRefreshExecute(Sender: TObject);
var ID:String;
begin
  if DButton.DataSet is TOracleDataSet then
    ID:=(DButton.DataSet as TOracleDataSet).RowID;
  DButton.DataSet.Refresh;
  if DButton.DataSet is TOracleDataSet then
    DButton.DataSet.Locate('RowID',ID,[]);
end;

procedure TR004FGestStorico.TCancClick(Sender: TObject);
begin
  SetPanelMessage('Cancellazione');
  if DButton.DataSet.RecordCount > 0 then
    if not CheckRelazioniEsistenti then
      if MessageDlg('Confermi cancellazione ?', mtInformation, [mbYes, mbNo], 0) = mrYes then
      begin
        DButton.DataSet.Delete;
        GetDateDecorrenza;
      end;
  NumRecords;
end;

function TR004FGestStorico.CheckRelazioniEsistenti: boolean;
begin
  Result:=True;
  // -- imposta e richiama la function "MEDP_CHECK_RELAZIONI_ESISTENTI"
  CheckRelazioni.Session:=(DButton.DataSet as TOracleDataSet).Session;
  CheckRelazioni.ClearVariables;
  CheckRelazioni.SetVariable('MASCHERA',Copy(Name,1,4));
  CheckRelazioni.SetVariable('TABELLA',DataSetName(DButton.DataSet).ToUpper);
  CheckRelazioni.SetVariable('CHIAVE',R180GetCampiConcatenati(DButton.DataSet,InterfacciaR004.LChiavePrimaria));
  // Imposto DECORRENZA se Gestione Storicizzata, altrimenti default 31/12/3999
  if InterfacciaR004.GestioneStoricizzata then
  begin
    if DButton.DataSet.FindField('DECORRENZA') <> nil then
      CheckRelazioni.SetVariable('DECORRENZA',DButton.DataSet.FieldByName('DECORRENZA').AsDateTime)
    else
      CheckRelazioni.SetVariable('DECORRENZA',DATE_MIN);
  end
  else
    CheckRelazioni.SetVariable('DECORRENZA',DATE_MIN);
  // Imposto SCADENZA se Gestione Decorrenza Fine, altrimenti default 31/12/3999
  if InterfacciaR004.GestioneDecorrenzaFine then
  begin
    if DButton.DataSet.FindField('DECORRENZA_FINE') <> nil then
      CheckRelazioni.SetVariable('SCADENZA',DButton.DataSet.FieldByName('DECORRENZA_FINE').AsDateTime)
    else
      CheckRelazioni.SetVariable('SCADENZA',DATE_MAX);
  end
  else
    CheckRelazioni.SetVariable('SCADENZA',DATE_MAX);
  // esegue richiamo alla funzione oracle
  try
    CheckRelazioni.Execute;
  except
    on E:Exception do
    begin
      Result:=False;
      //RegistraMsg(E.Exception);
    end;
  end;

  // lo imposto a false ed esco (da togliere una volta implementata la function).
  // Result:=False;
  // exit;

  if VarToStr(CheckRelazioni.GetVariable('RESULT')) = 'E1' then
    raise Exception.Create('Errore passaggio parametri')
  else if VarToStr(CheckRelazioni.GetVariable('RESULT')) <> '' then
    raise Exception.Create('Cancellazione impedita in quanto il dato è in uso:' + #13#10 + CheckRelazioni.GetVariable('RESULT'))
  else
    Result:=False;
end;

procedure TR004FGestStorico.TAnnullaClick(Sender: TObject);
begin
  DButton.DataSet.Cancel;
  InterfacciaR004.StoricizzazioneInCorso:=False;
  lbldecorrenza.Font.Color:=clBlue;
  dedtDecorrenza.Hint:='';
  dedtDecorrenza.ShowHint:=False;
end;

procedure TR004FGestStorico.TRegisClick(Sender: TObject);
var DL:TDateTime;
begin
  //Alberto 29/10/2012: Modifica di DataLavoro per riposizionarsi sullo stesso periodo storico modificato
  DL:=InterfacciaR004.DataLavoro;
  if DButton.DataSet.FindField('DECORRENZA_FINE') <> nil then
    InterfacciaR004.DataLavoro:=DButton.DataSet.FieldByName('DECORRENZA_FINE').AsDateTime
  else
    InterfacciaR004.DataLavoro:=DButton.DataSet.FieldByName('DECORRENZA').AsDateTime;
  DButton.DataSet.Post;
  InterfacciaR004.StoricizzazioneInCorso:=False;
  CercaStoricoCorrente;
  InterfacciaR004.DataLavoro:=DL;
  lbldecorrenza.Font.Color:=clBlue;
  dedtDecorrenza.Hint:='';
  dedtDecorrenza.ShowHint:=False;
  GetDateDecorrenza;
  NumRecords;
end;

procedure TR004FGestStorico.TModifClick(Sender: TObject);
begin
  SetPanelMessage('Modifica');
  SalvaValoriOriginali;
  DButton.DataSet.Edit;
end;

procedure TR004FGestStorico.TInserClick(Sender: TObject);
var i:integer;
begin
  SetPanelMessage('Inserimento');
  for i:=0 to ComponentCount -1 do
    if (Components[i] is TTabSheet) and ((Components[i] as TTabSheet).PageIndex=0) then
    begin
      ((Components[i] as TTabSheet).Parent as TPageControl).ActivePage:=(Components[i] as TTabsheet);
      Break;
    end;
  try
    for i:=0 to DButton.DataSet.FieldCount - 1 do
      if DButton.DataSet.Fields[i].Visible then
      begin
        DButton.DataSet.Fields[i].FocusControl;
        Break;
      end;
  except
  end;
  if ActiveControl <> nil then
    if not ActiveControl.CanFocus then
      FindNextControl(ActiveControl,true,true,true);
  DButton.DataSet.Insert;
end;

procedure TR004FGestStorico.DButtonDataChange(Sender: TObject; Field: TField);
begin
  if Field = nil then
  begin
    GetDateDecorrenza;
    NumRecords;
  end;
end;

procedure TR004FGestStorico.GetDateDecorrenza;
var S:String;
    i:Integer;
begin
  if InterfacciaR004.GestioneStoricizzata then
  begin
    if InterfacciaR004.StoricizzazioneInCorso and (Length(InterfacciaR004.TabelleRelazionate) = 0) then
      exit;
    with TOracleDataSet.Create(nil) do
    try
      cmbDateDecorrenza.Items.Clear;
      Session:=SessioneOracle;
      SQL.Add('SELECT DECORRENZA FROM ' + InterfacciaR004.NomeTabella);
      if InterfacciaR004.LChiavePrimaria.Count > 0 then
        SQL.Add('WHERE ');
      for i:=0 to InterfacciaR004.LChiavePrimaria.Count - 1 do
      begin
        S:='';
        if i > 0 then
          S:='AND ';
        S:=S + InterfacciaR004.LChiavePrimaria[i] + '=' + '''' + AggiungiApice(DButton.DataSet.FieldByName(InterfacciaR004.LChiavePrimaria[i]).AsString) + '''';
        SQL.Add(S);
      end;
      SQL.Add('ORDER BY DECORRENZA');
      Open;
      First;
      //if not(InterfacciaR004.StoricizzazioneInCorso and (RecordCount = 0)) then
      SetLength(InterfacciaR004.lstDecorrenze,RecordCount);
      i:=0;
      while not Eof do
      begin
        InterfacciaR004.lstDecorrenze[i]:=FieldByName('DECORRENZA').AsDateTime;
        cmbDateDecorrenza.Items.Add(FieldByName('DECORRENZA').AsString);
        inc(i);
        Next;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TR004FGestStorico.DButtonStateChange(Sender: TObject);
{Abilita/Disabilita i bottoni}
var Browse:Boolean;
    i:Integer;
begin
  if (DButton.State = dsInsert) and R001LinkC700 then
  begin
    GetC700SelAnagrafeInterna;
    if (C700SelAnagrafeInterna <> nil) and (C700SelAnagrafeInterna.RecordCount = 0) then
    begin
      ShowMessage('Inserimento impossibile!' + #13 + 'Nessun dipendente selezionato!');
      DButton.DataSet.Cancel;
      exit;
    end;
  end;
  Browse:=not (DButton.State in [dsInsert,dsEdit]);
  actRicerca.Enabled:=Browse;
  actPrimo.Enabled:=Browse;
  actPrecedente.Enabled:=Browse;
  actSuccessivo.Enabled:=Browse;
  actUltimo.Enabled:=Browse;
  actStampa.Enabled:=Browse;
  actDataLavoro.Enabled:=Browse;
  actCancella.Enabled:=Browse and not(SolaLettura);
  actInserisci.Enabled:=Browse and not(SolaLettura);
  actModifica.Enabled:=Browse and not(SolaLettura);
  actEsci.Enabled:=Browse;
  actConferma.Enabled:=not Browse;
  actAnnulla.Enabled:=not Browse;
  actGomma.Enabled:=not Browse;
  actCopiaSu.Enabled:=Browse and not(SolaLettura);
  actRefresh.Enabled:=Browse;
  try
    actStoricizza.Enabled:=Browse and (not SolaLettura) and (DButton.DataSet.RecordCount > 0);
  except
    actStoricizza.Enabled:=False;
  end;
  actStoricoPrecedente.Enabled:=Browse and not actVisioneCorrente.Checked;
  actStoricoSuccessivo.Enabled:=Browse and not actVisioneCorrente.Checked;
  cmbDateDecorrenza.Enabled:=Browse and not actVisioneCorrente.Checked;
  chkStoriciPrec.Enabled:=not Browse;
  chkStoriciSucc.Enabled:=not Browse;
  chkStoriciPrec.Checked:=False;
  chkStoriciSucc.Checked:=False;
  actVisioneCorrente.Enabled:=Browse;
  if Browse then
  begin
    SetPanelMessage('');
    NumRecords;
    InterfacciaR004.StoricizzazioneInCorso:=False;
  end;
  for i:=0 to Self.ComponentCount - 1 do
    if (Self.Components[i] is TfrmToolbarFiglio) then
      TFrame(Self.Components[i]).Enabled:=Browse
end;

procedure TR004FGestStorico.SetPanelMessage(S:String);
begin
  StatusBar.Panels[StatusBar.Panels.Count - 1].Text:=S;
end;

procedure TR004FGestStorico.NumRecords;
{Calcola il numero di records della tabella}
begin
  if InterfacciaR004.GestioneStoricizzata and InterfacciaR004.StoricizzazioneInCorso and (Length(InterfacciaR004.TabelleRelazionate) = 0) then
    exit;
  StatusBar.Panels[2].Text:=Format('Record %d/%d',[DButton.DataSet.RecNo,DButton.DataSet.RecordCount]);
  cmbDateDecorrenza.ItemIndex:=cmbDateDecorrenza.Items.IndexOf(DButton.DataSet.FieldByName('DECORRENZA').AsString);
end;

procedure TR004FGestStorico.TGommaClick(Sender: TObject);
{Abblenca il contenuto del campo su cui si è posizionati}
  function DatasetReadOnly(DataSet:TDataSet):Boolean;
  begin
    Result:=False;
    if DataSet is TOracleDataSet then
      Result:=TOracleDataSet(DataSet).ReadOnly;
  end;
begin
  //Alberto 12/12/2006: gestione del ReadOnly
  if ActiveControl is TDBEdit then
  begin
    if not (ActiveControl as TDBEdit).Field.ReadOnly then
      (ActiveControl as TDBEdit).Field.Clear;
  end
  else if ActiveControl is TDBLookupComboBox then
    with (ActiveControl as TDBLookupComboBox) do
    begin
      if not DataSource.DataSet.FieldByName(DataField).ReadOnly then
        DataSource.DataSet.FieldByName(DataField).Clear;
    end
  else if ActiveControl is TDBComboBox then
  begin
    if not (ActiveControl as TDBComboBox).Field.ReadOnly then
      (ActiveControl as TDBComboBox).Field.Clear;
  end
  else if ActiveControl is TDBGrid then
  begin
    if not DatasetReadOnly((ActiveControl as TDBGrid).DataSource.DataSet) and
       not (ActiveControl as TDBGrid).SelectedField.ReadOnly and
       not (ActiveControl as TDBGrid).ReadOnly and
       not (ActiveControl as TDBGrid).Columns[(ActiveControl as TDBGrid).SelectedIndex].ReadOnly then
      if (ActiveControl as TDBGrid).DataSource.State in [dsEdit,dsInsert] then
      begin
        if ((ActiveControl as TDBGrid).SelectedField.FieldKind = fkLookup) and (Pos(';',(ActiveControl as TDBGrid).SelectedField.KeyFields) = 0) then
        begin
          (ActiveControl as TDBGrid).SelectedField.Dataset.FieldByName((ActiveControl as TDBGrid).SelectedField.KeyFields).Clear;
          (ActiveControl as TDBGrid).SelectedField.FocusControl;
        end
        else
          (ActiveControl as TDBGrid).SelectedField.Clear;
      end
      else if (ActiveControl as TDBGrid).DataSource.AutoEdit then
      begin
        (ActiveControl as TDBGrid).DataSource.DataSet.Edit;
        if ((ActiveControl as TDBGrid).SelectedField.FieldKind = fkLookup) and (Pos(';',(ActiveControl as TDBGrid).SelectedField.KeyFields) = 0) then
        begin
          (ActiveControl as TDBGrid).SelectedField.Dataset.FieldByName((ActiveControl as TDBGrid).SelectedField.KeyFields).Clear;
          (ActiveControl as TDBGrid).SelectedField.FocusControl;
        end
        else
          (ActiveControl as TDBGrid).SelectedField.Clear;
        if (ActiveControl as TDBGrid).DataSource.State in [dsInsert,dsEdit] then
          (ActiveControl as TDBGrid).DataSource.DataSet.Post;
      end;
  end;
end;

procedure TR004FGestStorico.TCercaClick(Sender: TObject);
{Crea la form di ricerca e si posiziona sul record}
var i,j:Integer;
    Filtro,ElencoCampi:String;
    Valori,Campi:TStringList;
    Pippo:Variant;
    CercaXDecorrenza:Boolean;
    BM:TBookmark;
begin
  Valori:=TStringList.Create;
  Campi:=TStringList.Create;
  ElencoCampi:='';
  FiltroR001:=False;
  C001FRicerca:=TC001FRicerca.Create(nil);
  with C001FRicerca,Dbutton.DataSet do
  try
    Grid.RowCount:=FieldCount + 1;
    j:=0;
    for i:=0 to FieldCount - 1 do
      if not((Fields[i].Calculated) or (Fields[i].Lookup)) then
      begin
        inc(j);
        Campi.Add(Fields[i].FieldName);
        Grid.Cells[0,j]:=Fields[i].DisplayLabel;
      end;
    Grid.RowCount:=Campi.Count + 1;
    if ShowModal = mrOk then
    begin
      CercaXDecorrenza:=False;
      Filtro:='';
      for i:=1 to Grid.RowCount - 1 do
        if Trim(Grid.Cells[1,i]) <> '' then
        begin
          if UpperCase(Campi[i - 1]) = 'DECORRENZA' then
            CercaXDecorrenza:=True;
          ElencoCampi:=ElencoCampi + ';' + Campi[i-1];
          Valori.Add(Trim(Grid.Cells[1,i]));
          if Filtro <> '' then
            Filtro:=Filtro + ' AND ';
          Filtro:=Filtro + '(' + Campi[i-1] + '=' + '''' + StringReplace(Trim(Grid.Cells[1,i]),'%','*',[rfReplaceAll]) + ''')';
        end;
      if chkFiltro.Checked then
      begin
        BM:=GetBookMark;
        { DONE : TEST IW 15 }
        try
          FiltroR001:=Filtro <> '';
          FilterOptions:=[foCaseInsensitive];
          Filter:=Filtro;
          Filtered:=False;
          Filtered:=True;
          GetDateDecorrenza;
          if BookmarkValid(BM) then
            GotoBookMark(BM);
        finally
          FreeBookmark(BM);
        end;
        NumRecords;
      end
      else
      if Valori.Count > 0 then
      begin
        Pippo:=VarArrayCreate([0,Valori.Count - 1],VarVariant);
        for i:=0 to Valori.Count - 1 do
          Pippo[i]:=Valori[i];
        if Valori.Count > 1 then
        begin
          if Locate(Copy(ElencoCampi,2,1000),Pippo,[loCaseInsensitive, loPartialKey]) then
          begin
            GetDateDecorrenza;
            if not CercaXDecorrenza then
              CercaStoricoCorrente;
          end;
        end
        else
        begin
          if Locate(Copy(ElencoCampi,2,1000),Valori[0],[loCaseInsensitive, loPartialKey]) then
          begin
            GetDateDecorrenza;
            if not CercaXDecorrenza then
              CercaStoricoCorrente;
          end;
        end;
        NumRecords;
      end;
    end;
  finally
    C001FRicerca.Free;
    (*
    if FiltroR001 then
      for i:=0 to High(lstFiltriDButton) DO
        lstFiltriDButton[i].Bottone.Down:=False;
    *)
    FreeAndNil(Valori);
    FreeAndNil(Campi);
  end;
end;

procedure TR004FGestStorico.SettaDBStampa(Sessione:TOracleSession);
begin
  with C001FFiltroTabelleDTM do
  begin
    Query1.Session:=Sessione;
    Query2.Session:=Sessione;
    QDistinct.Session:=Sessione;
    Q900.Session:=Sessione;
    selT901.Session:=Sessione;
  end;
end;

procedure TR004FGestStorico.Stampa1Click(Sender: TObject);
{Crea le form per creare la query e la stampa finale}
{Parametri per controllare la stampa parametrica che devono essere impostati
 nell'evento OnCreate della Form discendente:
 - SelezioneSql: Stringa contenente la Query richiesta:tipicamente i campi della tabella
               con gli eventuali JOIN a tabelle-descrizione senza clausole WHERE o ORDER BY
 - FromSql:La parte FROM della Query con gli eventuali JOIN
 Ricordare per i suddetti parametri di specificare eventuali Alias di Tabelle se ci sono
 campi omonimi!
 - NomiCampiR001 (TStringList):Usato per getire campi omonimi di più tabelle:
           ogni Item corrisponde a una colonna della Query 'SelezioneSql'
           e consiste del nome Tabella o Alias  + Nome Campo
           es.:T1.Descrizione
 - AliasR001:Nome dell'alias di database da mettere nelle Query
 - SessioneR001: Sessione Oracle a cui collegarsi
 - TitoloR001:Stringa descrittiva usata nella caption della form di selezione
 - IntestazioneR001:Stringa di intestazione della stampa}
var TipoAlias:String;
begin
  if R001LinkC700 and (Self.FindComponent('frmSelAnagrafe') <> nil) then
  begin
    StampaAnagraficaMista;
    exit;
  end;
  Screen.Cursor:=crHourglass;
  C001SetNomeForm(TForm(Screen.ActiveForm).Name);
  C001FFiltroTabelle:=TC001FFiltroTabelle.Create(nil);
  C001FFiltroTabelleDTM:=TC001FFiltroTabelleDTM.Create(nil);
  C001FScegliCampi:=TC001FScegliCampi.Create(nil);
    try
    C001FFiltroTabelleDTM.Query1.Close;
    C001FFiltroTabelleDTM.Query2.Close;
    C001FFiltroTabelleDTM.QDistinct.Close;
    AliasR001:='';
    SessioneR001:=nil;
    if (DButton.DataSet is TOracleDataSet) then
      begin
      SessioneR001:=(DButton.DataSet as TOracleDataSet).Session;
      AliasR001:='';
      end;
    if AliasR001 = '' then
      TipoAlias:='ORACLE';
    if TipoAlias = 'ORACLE' then
      TipoDB:=dbOracle
    else
      TipoDB:=dbStandard;
    SettaDbStampa(SessioneR001);
    //Carica la SELECT SQL su Query1 e Query2 e carica NomiCampiR001
    if QueryStampa.Count = 0 then
    begin
      NomiCampiR001.Clear;
      InizializzaQueryStandard;
    end
    else
      InizializzaQueryPersonalizzata;
    C001FFiltroTabelle.FROM_SQL:=FromSql;
    C001FFiltroTabelle.IntestazioneQR:=IntestazioneStampa;
    C001FFiltroTabelle.Caption:=C001FFiltroTabelle.Caption + TitoloR001;
    C001FFiltroTabelle.TipoDB:=TipoDB;
    Screen.Cursor:=crDefault;
    C001FFiltroTabelle.ShowModal;

    C001FFiltroTabelleDTM.Query2.Close;
    C001FFiltroTabelleDTM.Query1.Close;
    finally
    Screen.Cursor:=crDefault;
    C001FScegliCampi.Free;
    C001FFiltroTabelleDTM.Free;
    C001FFiltroTabelle.Free;
    end;
end;

procedure TR004FGestStorico.StampaAnagraficaMista;
var ListaCampiQuery2:TStringList;
    CampiAbilitati,
    CampiVisualizzatiOriginali,
    CampiSelezionatiOriginali:String;
begin
  ListaCampiQuery2:=TStringList.Create;
  try
    CampiVisualizzatiOriginali:=C700DatiVisualizzati;
    CampiSelezionatiOriginali:=C700DatiSelezionati;
    C001SetNomeForm(TForm(Screen.ActiveForm).Name);
    C001FFiltroTabelle:=TC001FFiltroTabelle.Create(nil);
    C001FFiltroTabelleDTM:=TC001FFiltroTabelleDTM.Create(nil);
    C001FScegliCampi:=TC001FScegliCampi.Create(nil);
    C001FFiltroTabelle.DataLavoro:=Parametri.DataLavoro;
    (Self.FindComponent('frmSelAnagrafe') as TfrmSelAnagrafe).SalvaC00SelAnagrafe;
    CampiAbilitati:=(Self.FindComponent('frmSelAnagrafe') as TfrmSelAnagrafe).GetCampiAbilitatiC700;
    C700Distruzione;
    C700Progressivo:=-1;
    C700DatiSelezionati:=CampiAbilitati;//C700TuttiCampi;
    C700Creazione(SessioneOracle);
    C700FSelezioneAnagrafeDtM.OpenSelAnagrafe;
    TipoDB:=DataBaseDrv;
    NomiCampiR001.Clear;
    ParametriStampa;
    ListaCampiQuery2.Assign(NomiCampiR001);
    GestisciStampaMista(C700SrcAnagrafe,C700SelAnagrafe,True,ListaCampiQuery2);
  finally
    C001FScegliCampi.Release;
    C001FFiltroTabelleDTM.Free;
    C001FFiltroTabelle.Release;
    ListaCampiQuery2.Free;
    C700Distruzione;
    C700DatiVisualizzati:=CampiVisualizzatiOriginali;
    C700DatiSelezionati:=CampiSelezionatiOriginali;
    C700Creazione(SessioneOracle);
    C700Progressivo:=-1;
    (Self.FindComponent('frmSelAnagrafe') as TfrmSelAnagrafe).RipristinaC00SelAnagrafe;
  end;
end;

procedure TR004FGestStorico.InizializzaQueryStandard;
var i:Integer;
begin
  ParametriStampa;
  CreaCampiPersistentiQuery2;
  C001FFiltroTabelleDTM.Query1.Open;
  C001FFiltroTabelle.StatusBar.Panels[0].Text:=Format('%d Records',[C001FFiltroTabelleDTM.Query1.RecordCount]);
  //Carico nella displayLabel di Query2 il nome colonna nel formato Tabella.Campo
  //Carico nella displayLabel di Query1 la display label della tabella originale
  for i:=0 to NomiCampiR001.Count - 1 do
  begin
    C001FFiltroTabelleDTM.Query2.Fields[i].DisplayLabel:=NomiCampiR001[i];
    C001FFiltroTabelleDTM.Query2.Fields[i].DisplayWidth:=DButton.DataSet.Fields[i].DisplayWidth;
    if (C001FFiltroTabelleDTM.Query2.Fields[i].DataType = ftDateTime) then
      //if (DButton.DataSet.Fields[i] as TDateTimeField).DisplayFormat = '' then
      if (DButton.DataSet.FieldByName(C001FFiltroTabelleDTM.Query2.Fields[i].FieldName) as TDateTimeField).DisplayFormat = '' then
        C001FFiltroTabelleDTM.Query2.Fields[i].DisplayWidth:=15
      else
        C001FFiltroTabelleDTM.Query2.Fields[i].DisplayWidth:=Length((DButton.DataSet.FieldByName(C001FFiltroTabelleDTM.Query2.Fields[i].FieldName) as TDateTimeField).DisplayFormat);
    if (C001FFiltroTabelleDTM.Query2.Fields[i].DataType = ftDate) then
      if (DButton.DataSet.FieldByName(C001FFiltroTabelleDTM.Query2.Fields[i].FieldName) as TDateField).DisplayFormat = '' then
        C001FFiltroTabelleDTM.Query2.Fields[i].DisplayWidth:=15
      else
        C001FFiltroTabelleDTM.Query2.Fields[i].DisplayWidth:=Length((DButton.DataSet.FieldByName(C001FFiltroTabelleDTM.Query2.Fields[i].FieldName) as TDateField).DisplayFormat);
    C001FFiltroTabelleDTM.Query1.Fields[i].DisplayLabel:=DButton.DataSet.FieldByName(C001FFiltroTabelleDTM.Query2.Fields[i].FieldName).DisplayLabel;
    C001FFiltroTabelleDTM.Query1.Fields[i].Visible:=DButton.DataSet.FieldByName(C001FFiltroTabelleDTM.Query2.Fields[i].FieldName).Visible;
    //Riporto la proprietà Display format
    with C001FFiltroTabelleDTM.Query2 do
    try
      case Fields[i].DataType of
        ftDateTime:(Fields[i] as TDateTimeField).DisplayFormat:=(DButton.DataSet.FieldByName(C001FFiltroTabelleDTM.Query2.Fields[i].FieldName) as TDateTimeField).DisplayFormat;
        ftDate:(Fields[i] as TDateField).DisplayFormat:=(DButton.DataSet.FieldByName(C001FFiltroTabelleDTM.Query2.Fields[i].FieldName) as TDateField).DisplayFormat;
        ftInteger:(Fields[i] as TIntegerField).DisplayFormat:=(DButton.DataSet.FieldByName(C001FFiltroTabelleDTM.Query2.Fields[i].FieldName) as TIntegerField).DisplayFormat;
        ftSmallint:(Fields[i] as TSmallintField).DisplayFormat:=(DButton.DataSet.FieldByName(C001FFiltroTabelleDTM.Query2.Fields[i].FieldName) as TSmallintField).DisplayFormat;
        ftTime:(Fields[i] as TTimeField).DisplayFormat:=(DButton.DataSet.FieldByName(C001FFiltroTabelleDTM.Query2.Fields[i].FieldName) as TTimeField).DisplayFormat;
        ftWord:(Fields[i] as TWordField).DisplayFormat:=(DButton.DataSet.FieldByName(C001FFiltroTabelleDTM.Query2.Fields[i].FieldName) as TWordField).DisplayFormat;
        ftBCD:begin
              (Fields[i] as TBCDField).DisplayFormat:=(DButton.DataSet.FieldByName(C001FFiltroTabelleDTM.Query2.Fields[i].FieldName) as TBCDField).DisplayFormat;
              (Fields[i] as TBCDField).Currency:=(DButton.DataSet.FieldByName(C001FFiltroTabelleDTM.Query2.Fields[i].FieldName) as TBCDField).Currency;
              end;
        ftCurrency:begin
                   (Fields[i] as TCurrencyField).DisplayFormat:=(DButton.DataSet.FieldByName(C001FFiltroTabelleDTM.Query2.Fields[i].FieldName) as TCurrencyField).DisplayFormat;
                   (Fields[i] as TCurrencyField).Currency:=(DButton.DataSet.FieldByName(C001FFiltroTabelleDTM.Query2.Fields[i].FieldName) as TCurrencyField).Currency;
                   end;
        ftFloat:begin
                (Fields[i] as TFloatField).DisplayFormat:=(DButton.DataSet.FieldByName(C001FFiltroTabelleDTM.Query2.Fields[i].FieldName) as TFloatField).DisplayFormat;
                (Fields[i] as TFloatField).Currency:=(DButton.DataSet.FieldByName(C001FFiltroTabelleDTM.Query2.Fields[i].FieldName) as TFloatField).Currency;
                end;
      end;
    except
      //Se i due campi hanno formati diversi proseguo
    end;
  end;
end;

procedure TR004FGestStorico.InizializzaQueryPersonalizzata;
var i:Integer;
begin
  C001FFiltroTabelleDTM.Query1.SQL.Assign(QueryStampa);
  C001FFiltroTabelleDTM.Query2.SQL.Assign(QueryStampa);
  CreaCampiPersistentiQuery2;
  for i:=0 to NomiCampiR001.Count - 1 do
    C001FFiltroTabelleDTM.Query2.Fields[i].DisplayLabel:=NomiCampiR001[i];
  C001FFiltroTabelleDTM.Query1.Open;
  C001FFiltroTabelle.StatusBar.Panels[0].Text:=Format('%d Records',[C001FFiltroTabelleDTM.Query1.RecordCount]);
  //Carico la stringa FromSQL
  FromSQL:=UpperCase(EliminaRitornoACapo(C001FFiltroTabelleDTM.Query2.SQL.Text));
  i:=Pos(' FROM ',FromSQL);
  FromSQL:=Copy(FromSQL,i + 1,Length(FromSQL));
  i:=Pos('ORDER BY ',FromSQL);
  if i > 0 then
    FromSQL:=Copy(FromSQL,1,i - 1);
end;

function TR004FGestStorico.DataSetName(DSet:TDataSet):string;
{funzione che restituisce il nome della tabella associata al dataset, nel caso
di una query estrae il nome della prima tabella dopo la clausola FROM}
begin
  result:='';
  if (DSet is TOracleDataSet) then
    result:=R180EstraiNomeTabella(TOracleDataSet(DSet).SQL.Text)
  //Nando aggiunto il 05/03/2002
  else if (DSet is TClientDataSet) then
    result:=TClientDataSet(DSet).Name;
end;

procedure TR004FGestStorico.ParametriStampa;
{Costruisco la stringa SQL Select con tutti i campi della tabella e gli
 eventuali campi di lookup trasformati in Left Join}
var IDC,IDT,IDJ:Byte;
    i,j:Word;
    Campi,Tabelle,JoinOra:TArray<String>;
    Alias,Campo:String;
    Suf:Char;
    function VerificaDimensioneArray(var parArray:TArray<String>):Byte;
    var
      IdxUltimoElemento:Byte;
    begin
      // Controlla se l'ultimo elemento dell'array ha lunghezza maggiore di 800.
      // Se sì, incrementa la lunghezza dell'array di 1 e ritorna l'indice da utilizzare d'ora in avanti.
      IdxUltimoElemento:=Length(parArray) - 1;
      if Length(parArray[IdxUltimoElemento]) > 800 then
      begin
        Inc(IdxUltimoElemento);
        SetLength(parArray,IdxUltimoElemento + 1);
        parArray[IdxUltimoElemento]:='';
      end;
      Result:=IdxUltimoElemento;
    end;
    function StringaInArrayContiene(pStrDaCercare:String;pArray:TArray<String>):Boolean;
    var
      StrCorrente:String;
    begin
      Result:=False;
      for StrCorrente in pArray do
      begin
        if (Pos(pStrDaCercare,StrCorrente) > 0) then
        begin
          Result:=True;
          Break;
        end;
      end;
    end;
begin
  IDC:=0;
  IDT:=0;
  IDJ:=0;
  SetLength(Campi,1);
  SetLength(Tabelle,1);
  SetLength(JoinOra,1);
  Campi[0]:='';
  Tabelle[0]:='';
  JoinOra[0]:='';

  for i:=0 to DButton.DataSet.FieldCount - 1 do
    with DButton.DataSet.Fields[i] do
      begin
      //Se e' un campo di lookup costruisco l'alias e la LEFT JOIN  e lo inserisco
      // nella lista NOMICAMPI
      if Lookup then
        begin
        //,Tabella.Campo
        if UpperCase(DataSetName(LookupDataSet)) = 'T430_STORICO' then
          Continue;
        if Tag > 1000 then
          //Se si tratta di un sotto-Lookup uso dei parametri fissi
          //a seconda del Tag del field
          case Tag of
            1001:begin  //Citta da Codice Comune
                Campo:='T48.Citta';
                IDC:=VerificaDimensioneArray(Campi);
                Campi[IDC]:=Campi[IDC] + ',' + Campo;
                NomiCampiR001.Add(Campo);

                IDT:=VerificaDimensioneArray(Tabelle);
                case DataBaseDrv of
                  dbInterBase,dbStandard:Tabelle[IDT]:=Tabelle[IDT] + ' LEFT JOIN T48Comun.db T48 ON  ' +
                                LookupDataSet.Name + 'A.CodComune=T48.Codice';
                  dbOracle:begin
                           Tabelle[IDT]:=Tabelle[IDT] + ',T48Comun.db T48';
                           IDJ:=VerificaDimensioneArray(JoinOra);
                           if Length(JoinOra[0]) > 0 then JoinOra[IDJ]:=JoinOra[IDJ] + ' AND ';
                           JoinOra[IDJ]:=JoinOra[IDJ] + LookupDataSet.Name + 'A.CodComune=T48.Codice(+)';
                           end;
                end;
                end;
            1002:begin  //Citta da Codice Comune
                Campo:='T19.Descrizione';
                IDC:=VerificaDimensioneArray(Campi);
                Campi[IDC]:=Campi[IDC] + ',' + Campo;
                NomiCampiR001.Add(Campo);

                IDT:=VerificaDimensioneArray(Tabelle);
                case DataBaseDrv of
                  dbInterBase,dbStandard:Tabelle[IDT]:=Tabelle[IDT] + ' LEFT JOIN T19TServ.db T19 ON  ' +
                              LookupDataSet.Name + 'A.CodTipoServizio=T19.CodTipoServizio' ;
                  dbOracle:begin
                           Tabelle[IDT]:=Tabelle[IDT] + ',T19TServ.db T19';
                           IDJ:=VerificaDimensioneArray(JoinOra);
                           if Length(JoinOra[0]) > 0 then JoinOra[IDJ]:=JoinOra[IDJ] + ' AND ';
                           JoinOra[IDJ]:=JoinOra[IDJ] + LookupDataSet.Name + 'A.CodTipoServizio=T19.CodTipoServizio(+)';
                           end;
                end;
                end;
          end
        else if Tag >= 0 then
          //Costruisco la frase sulla base dei dati di lookup
          begin
          Suf:='A';
          repeat
            Alias:=LookupDataSet.Name + Suf;  //Alias = Table.Name + A,B,C...
            if (UpperCase(DataSetName(LookupDataSet)) = 'T480_COMUNI') and (UpperCase(LookupResultField) = 'DESCRIZIONE') then
              Campo:=Alias + '.CITTA'
            else
              Campo:=Alias + '.' + LookupResultField;
            Campo:=Campo + ' ' + FieldName;
            Suf:=Succ(Suf);
          until not StringaInArrayContiene(Campo,Campi);
          IDC:=VerificaDimensioneArray(Campi);
          Campi[IDC]:=Campi[IDC] + ',' + Campo;
          NomiCampiR001.Add(Campo);
          //LEFT JOIN Tabella Alias
          if (not StringaInArrayContiene(Alias,Tabelle)) then
            begin
              IDT:=VerificaDimensioneArray(Tabelle);
            case DataBaseDrv of
              dbInterBase,dbStandard:begin
                                     Tabelle[IDT]:=Tabelle[IDT] + ' LEFT JOIN ' + DataSetName(LookupDataSet) + ' ' + Alias;
                                     Tabelle[IDT]:=Tabelle[IDT] + ' ON T1.' + KeyFields + '=' + Alias + '.' + LookupKeyFields;
                                     end;
              dbOracle:begin
                       Tabelle[IDT]:=Tabelle[IDT] + ',' + DataSetName(LookupDataSet) + ' ' + Alias;
                       IDJ:=VerificaDimensioneArray(JoinOra);
                       if Length(JoinOra[0]) > 0 then JoinOra[IDJ]:=JoinOra[IDJ] + ' AND ';
                       JoinOra[IDJ]:=JoinOra[IDJ] + 'T1.' + KeyFields + '=' + Alias + '.' + LookupKeyFields + '(+)';
                       end;
            end;
            end;
          end;
        end
      else if not Calculated then
        //Se è un campo normale lo inserisco nella lista NOMICAMPI
        begin
          IDC:=VerificaDimensioneArray(Campi);
          Campi[IDC]:=Campi[IDC] + ',' + 'T1.' + FieldName;
          NomiCampiR001.Add('T1.' + FieldName);
        end;
      end;
  with C001FFiltroTabelleDTM.Query2 do
    begin
    //SELECT T1.Col1, T1.Col2, T1.Col3, ..., Tab1.Coln, Tab2.Coln+1 ...
    Sql.Clear;
    SQL.Add('SELECT ');
    for j:=0 to (Length(Campi) - 1) do
    begin
      if (j = 0) then
        SQL.Add(Copy(Campi[0],2,900))
      else
        SQL.Add(Campi[j]);
    end;
    //FROM T430_STORICO T430 LEFT JOIN Tab1 Alias1 LEFT JOIN Tab2 Alias2 ...
    SQL.Add(' FROM ');
    SQL.Add(DataSetName(DButton.DataSet) + ' T1 ');
    for j:=0 to (Length(Tabelle) - 1) do
    begin
      SQL.Add(Tabelle[j]);
    end;
    //Sintassi ORACLE per LEFT JOIN
    if (TipoDB = dbOracle) and (JoinOra[0] <> '') then
    begin
      for j:=0 to (Length(JoinOra) - 1) do
      begin
        if (j = 0) then
          SQL.Add(' WHERE ' + JoinOra[j])
        else
          SQL.Add(JoinOra[j]);
      end;
    end;
    //Carico l'istruzione SQL di Query1, all'inizio uguale a Query2
    C001FFiltroTabelleDTM.Query1.Sql.Clear;
    C001FFiltroTabelleDTM.Query1.Sql.AddStrings(Sql);
    //Carico la stringa SelezioneSQL
    SelezioneSQL:='';
    for i:=0 to Sql.Count - 1 do
      SelezioneSQL:=SelezioneSQL + Sql[i];
    //Carico la stringa FromSQL
    i:=Pos(' FROM ', SelezioneSQL);
    FromSQL:=Copy(SelezioneSQL,i + 1,Length(SelezioneSQL));
    end;
end;

procedure TR004FGestStorico.Chiudi1Click(Sender: TObject);
begin
  Close;
end;

procedure TR004FGestStorico.FormClose(Sender: TObject;
  var Action: TCloseAction);
var i:Integer;  
begin
  if DButton.State in [dsInsert,dsEdit] then
    Action:=caNone
  else
    for i:=0 to Self.ComponentCount - 1 do
      if (Self.Components[i] is TfrmToolbarFiglio) then
        if TfrmToolbarFiglio(Self.Components[i]).actTFConferma.Enabled then
        begin
          Action:=caNone;
          Break;
        end;
end;

procedure TR004FGestStorico.btnStoricoPrecClick(Sender: TObject);
{Scorrimento sullo storico precedente della medesima chiave}
var S:String;
  evAfterScroll: TEvDataSet;
begin
  if (DButton.DataSet is TOracleDataSet) then
  begin
    //Caratto 26/09/2014 inibisco afterScroll per evitare che si scateni troppe volte
    evAfterScroll:=DButton.DataSet.AfterScroll;
    DButton.DataSet.AfterScroll:=nil;
  end;

  S:=R180GetCampiConcatenati(DButton.DataSet,InterfacciaR004.LChiavePrimaria);
  DButton.DataSet.DisableCOntrols;
  try
    DButton.DataSet.Prior;
    if R180GetCampiConcatenati(DButton.DataSet,InterfacciaR004.LChiavePrimaria) <> S then
      DButton.DataSet.Next;
  finally
    DButton.DataSet.EnableControls;
  end;

  if (DButton.DataSet is TOracleDataSet) then
  begin
    //Caratto 26/09/2014 riattivo afterScroll
    DButton.DataSet.AfterScroll:=evAfterScroll;
    //forzo scroll per scatenare tutti gli eventi derivati dallo scroll
    TOracleDataSet(DButton.DataSet).SearchRecord('ROWID',TOracleDataSet(DButton.DataSet).RowId,[srFromBeginning]);
  end;
  NumRecords;
end;

procedure TR004FGestStorico.btnStoricoSuccClick(Sender: TObject);
{Scorrimento sullo storico successivo della medesima chiave}
var S:String;
  evAfterScroll: TEvDataSet;
begin
  if (DButton.DataSet is TOracleDataSet) then
  begin
    //Caratto 26/09/2014 inibisco afterScroll per evitare che si scateni troppe volte
    evAfterScroll:=DButton.DataSet.AfterScroll;
    DButton.DataSet.AfterScroll:=nil;
  end;

  S:=R180GetCampiConcatenati(DButton.DataSet,InterfacciaR004.LChiavePrimaria);
  DButton.DataSet.Next;
  if R180GetCampiConcatenati(DButton.DataSet,InterfacciaR004.LChiavePrimaria) <> S then
    DButton.DataSet.Prior;

  if (DButton.DataSet is TOracleDataSet) then
  begin
    //Caratto 26/09/2014 riattivo afterScroll
    DButton.DataSet.AfterScroll:=evAfterScroll;
    //forzo scroll per scatenare tutti gli eventi derivati dallo scroll
    TOracleDataSet(DButton.DataSet).SearchRecord('ROWID',TOracleDataSet(DButton.DataSet).RowId,[srFromBeginning]);
  end;

  NumRecords;
end;

procedure TR004FGestStorico.Visionecorrente1Click(Sender: TObject);
{Costruzione o ripristino della query per visualizzare solamente i record
validi alla data di lavoro oppure per visualizzare tutti i dati}
var S,SO,PK:String;
    i,PW,PO:Integer;
    V:Variant;
    evAfterScroll: TEvDataSet;
begin

  //Caratto 26/09/2014 inibisco afterScroll per evitare che si scateni troppe volte
  evAfterScroll:=DButton.DataSet.AfterScroll;
  DButton.DataSet.AfterScroll:=nil;

  if InterfacciaR004.LChiavePrimaria.Count > 0 then
    GetValoriChiavePrimaria(PK,V,actVisioneCorrente.Checked);
  if not actVisioneCorrente.Checked and actVisioneAnnuale.Checked then
    actVisioneAnnualeExecute(nil);
  actVisioneCorrente.Checked:=not actVisioneCorrente.Checked;
  btnStoricoPrec.Enabled:=not actVisioneCorrente.Checked;
  btnStoricoSucc.Enabled:=not actVisioneCorrente.Checked;
  DButton.DataSet.Close;
  if TOracleDataSet(DButton.DataSet).VariableIndex('DECORRENZA') >= 0 then
    TOracleDataSet(DButton.DataSet).DeleteVariable('DECORRENZA');
  if actVisioneCorrente.Checked then
  begin
    SQLOriginale:=TOracleDataSet(DButton.DataSet).SQL.Text;
    S:=UpperCase(TOracleDataSet(DButton.DataSet).SQL.Text);
    PW:=Pos('WHERE',S);
    PO:=Pos('ORDER BY',S);
    SO:='';
    if PO > 0 then
    begin
      SO:=Copy(S,PO,Length(S));
      Delete(S,PO,Length(SO));
    end;
    if PW = 0 then
      S:=S + ' WHERE '
    else
      S:=S + ' AND ';
    if InterfacciaR004.AllineaSoloDecorrenzeIntersecanti then
      S:=S + ':DECORRENZA BETWEEN DECORRENZA AND DECORRENZA_FINE '
    else
    begin
      S:=S + 'DECORRENZA = (SELECT MAX(DECORRENZA) FROM ' + InterfacciaR004.NomeTabella + ' WHERE ';
      for i:=0 to InterfacciaR004.LChiavePrimaria.Count - 1 do
      begin
        S:=S + InterfacciaR004.LChiavePrimaria[i] + ' = ' + InterfacciaR004.AliasNomeTabella + '.' + InterfacciaR004.LChiavePrimaria[i];
        if i < InterfacciaR004.LChiavePrimaria.Count - 1 then
          S:=S + ' AND ';
      end;
      if InterfacciaR004.LChiavePrimaria.Count > 0 then
        S:=S + ' AND ';
      S:=S + 'DECORRENZA <= :DECORRENZA) ';
    end;
    S:=S + SO;
    TOracleDataSet(DButton.DataSet).SQL.Text:=S;
    TOracleDataSet(DButton.DataSet).DeclareVariable('DECORRENZA',otDate);
    TOracleDataSet(DButton.DataSet).SetVariable('DECORRENZA',InterfacciaR004.DataLavoro);
  end
  else
//  begin
//    DButton.DataSet.Close;
    TOracleDataSet(DButton.DataSet).SQL.Text:=SQLOriginale;
//  end;
  DButton.DataSet.Open;
  //Caratto 26/09/2014 riattivo afterScroll
  DButton.DataSet.AfterScroll:=evAfterScroll;
  //forzo scroll per scatenare tutti gli eventi derivati dallo scroll
  TOracleDataSet(DButton.DataSet).SearchRecord('ROWID',TOracleDataSet(DButton.DataSet).RowId,[srFromBeginning]);

  NumRecords;
  if InterfacciaR004.LChiavePrimaria.Count > 0 then
    DButton.DataSet.Locate(PK,V,[]);
end;

procedure TR004FGestStorico.actVisioneAnnualeExecute(Sender: TObject);
{Costruzione o ripristino della query per visualizzare solamente i record
la cui decorrenza cade nell'anno individuato dalla data di lavoro}
var S,SO,PK:String;
    PW,PO:Integer;
    V:Variant;
begin
  if InterfacciaR004.LChiavePrimaria.Count > 0 then
    GetValoriChiavePrimaria(PK,V,False);
  if not actVisioneAnnuale.Checked and actVisioneCorrente.Checked then
    Visionecorrente1Click(nil);
  actVisioneAnnuale.Checked:=not actVisioneAnnuale.Checked;
  DButton.DataSet.Close;
  if TOracleDataSet(DButton.DataSet).VariableIndex('DECORRENZA') >= 0 then
    TOracleDataSet(DButton.DataSet).DeleteVariable('DECORRENZA');
  if actVisioneAnnuale.Checked then
  begin
    SQLOriginale:=TOracleDataSet(DButton.DataSet).SQL.Text;
    S:=UpperCase(TOracleDataSet(DButton.DataSet).SQL.Text);
    PW:=Pos('WHERE',S);
    PO:=Pos('ORDER BY',S);
    SO:='';
    if PO > 0 then
    begin
      SO:=Copy(S,PO,Length(S));
      Delete(S,PO,Length(SO));
    end;
    if PW = 0 then
      S:=S + ' WHERE '
    else
      S:=S + ' AND ';
    S:=S + 'TO_CHAR(DECORRENZA,''YYYY'') = TO_CHAR(:DECORRENZA,''YYYY'')';
    S:=S + SO;
    TOracleDataSet(DButton.DataSet).SQL.Text:=S;
    TOracleDataSet(DButton.DataSet).DeclareVariable('DECORRENZA',otDate);
    TOracleDataSet(DButton.DataSet).SetVariable('DECORRENZA',InterfacciaR004.DataLavoro);
  end
  else
    TOracleDataSet(DButton.DataSet).SQL.Text:=SQLOriginale;
  DButton.DataSet.Open;
  NumRecords;
  if InterfacciaR004.LChiavePrimaria.Count > 0 then
    DButton.DataSet.Locate(PK,V,[]);
end;


procedure TR004FGestStorico.GetValoriChiavePrimaria(var PK:string; var V:Variant; ConDecorrenza:Boolean);
var i:Integer;
begin
    //Alberto 30/12/2005: aggiunta la decorrenza per posizionarsi sullo stesso record dopo aver richiesto la visione completa
    PK:='';
    if ConDecorrenza then
      V:=VarArrayCreate([0,InterfacciaR004.LChiavePrimaria.Count], varVariant)
    else
      V:=VarArrayCreate([0,InterfacciaR004.LChiavePrimaria.Count - 1], varVariant);
    for i:=0 to InterfacciaR004.LChiavePrimaria.Count - 1 do
    begin
      V[i]:=DButton.DataSet.FieldByName(InterfacciaR004.LChiavePrimaria[i]).Value;
      if PK <> '' then PK:=PK + ';';
      PK:=PK + InterfacciaR004.LChiavePrimaria[i];
    end;
    //Alberto 30/12/2005: aggiunta la decorrenza per posizionarsi sullo stesso record dopo aver richiesto la visione completa
    if ConDecorrenza then
    begin
      PK:=PK + ';DECORRENZA';
      V[InterfacciaR004.LChiavePrimaria.Count]:=DButton.DataSet.FieldByName('DECORRENZA').Value;
    end;
end;

procedure TR004FGestStorico.btnStoricizzaClick(Sender: TObject);
{Inserimento nuovo record inizializzato con i valori del precedente per storicizzazione}
begin
  SetPanelMessage('Storicizzazione');
  if DButton.DataSet.RecordCount = 0 then
    exit;
  try
    InterfacciaR004.StoricizzazioneInCorso:=True;
    if Length(InterfacciaR004.TabelleRelazionate) > 0 then
    begin
      if CreaC009(True) then
      begin
        SalvaValoriOriginali;
        DButton.DataSet.Edit;
      end;
    end
    else
    begin
      SalvaValoriOriginali;
      DButton.DataSet.Insert;
      RipristinaValoriOriginali;
      DButton.DataSet.FieldByName('Decorrenza').Clear;
      DButton.DataSet.FieldByName('Decorrenza').FocusControl;
      if (not InterfacciaR004.GestioneDecorrenzaFine) and (DButton.DataSet.FindField('DECORRENZA_FINE') <> nil) then
        DButton.DataSet.FieldByName('DECORRENZA_FINE').Clear;
    end;
  except
  end;
end;

procedure TR004FGestStorico.SalvaValoriOriginali;
{Registrazione dati originali in LValoriOriginali nel formato nome=valore}
var i:Integer;
begin
  InterfacciaR004.LValoriOriginali.Clear;
  for i:=0 to DButton.DataSet.FieldDefs.Count - 1 do
  try
    InterfacciaR004.LValoriOriginali.Add(DButton.DataSet.FieldDefs[i].Name + '=' + DButton.DataSet.FieldByName(DButton.DataSet.FieldDefs[i].Name).AsString);
  except
  end;
end;

procedure TR004FGestStorico.RipristinaValoriOriginali;
{Usato in storicizzazione: Ripristino dati originali da LValoriOriginali nel formato nome=valore}
var i:Integer;
begin
  if DButton.State in [dsInsert,dsEdit] then
  try
    InterfacciaR004.RipristinoValoriInCorso:=True;
    for i:=0 to DButton.DataSet.FieldDefs.Count - 1 do
    try
      if (DButton.DataSet.FindField(DButton.DataSet.FieldDefs[i].Name) <> nil) and
         (DButton.DataSet.FieldByName(DButton.DataSet.FieldDefs[i].Name).FieldKind = fkData) then
      begin
        //Non considero i campi legati ad una sequenza e che non fanno parte della chiave primaria
        //Se facesse parte della chiave primaria potrebbe voler dire che è storicizzabile
        if (DButton.DataSet is TOracleDataset) and
           (TOracleDataSet(DButton.DataSet).SequenceField.Field.ToUpper = DButton.DataSet.FieldDefs[i].Name.ToUpper) and
           (InterfacciaR004.LChiavePrimaria.IndexOf(DButton.DataSet.FieldDefs[i].Name) = -1)
        then
          Continue
        else
          DButton.DataSet.FieldByName(DButton.DataSet.FieldDefs[i].Name).AsString:=InterfacciaR004.LValoriOriginali.Values[DButton.DataSet.FieldDefs[i].Name];
      end;
    except
    end;
  finally
    InterfacciaR004.RipristinoValoriInCorso:=False;
  end;
end;

procedure TR004FGestStorico.actDataLavoroExecute(Sender: TObject);
begin
  A003FDataLavoroBis:=TA003FDataLavoroBis.Create(nil);
  try
    A003FDataLavoroBis.DateTimePicker1.Date:=InterfacciaR004.DataLavoro;
    if A003FDataLavoroBis.ShowModal = mrOK then
    begin
      InterfacciaR004.DataLavoro:=A003FDataLavoroBis.DateTimePicker1.Date;
      StatusBar.Panels[1].Text:='Data lavoro: ' + FormatDateTime('dd/mm/yyyy',InterfacciaR004.DataLavoro);
      if actVisioneCorrente.Checked then
      begin
        TOracleDataSet(DButton.DataSet).SetVariable('DECORRENZA',InterfacciaR004.DataLavoro);
        DButton.DataSet.Refresh;
        NumRecords;
      end;
    end;
  finally
    A003FDataLavoroBis.Free;
  end;
end;

procedure TR004FGestStorico.Copiada1Click(Sender: TObject);
{CopiaSu può gestire la duplicazione anche di altre tabelle oltre alla principale,
 tutte devono essere presenti nel DataModule del progetto, e devono essere assegnate a TabelleRelazionate
 tramite la procedura SetTabelleRelazionate, su ogni singolo progetto nell'azione actCopiaSu prima dell'inherited:
   SetTabelleRelazionate([DataSet1,DataSet2,...]);
   inherited;}
begin
  if DButton.DataSet = nil then exit;
  if DButton.State <> dsBrowse then exit;
  if DButton.DataSet.RecordCount < 1 then exit;
  CreaC009(False);
end;

function TR004FGestStorico.CreaC009(Storicizza:Boolean):Boolean;
var S2:String;
    id:Integer;
  procedure RefreshFiltro;
  var S1:String;
  begin
    if (UpperCase(Self.Name) = 'A006FMODELLIORARIO') or
       (UpperCase(Self.Name) = 'A007PROFILIORARI') then
      if DButton.DataSet.FieldByName('CODICE').AsString <> S2 then
      begin
        S1:=DButton.DataSet.FieldByName('CODICE').AsString;
        DButton.DataSet.Refresh;
        if not DButton.DataSet.Locate('CODICE',S2,[]) then
          DButton.DataSet.Locate('CODICE',S1,[]);
      end;
  end;
  function IdxDecorrenza(D:TDateTime):Integer;
  var i:Integer;
  begin
    Result:=-1;
    for i:=High(InterfacciaR004.lstDecorrenze) downto 0 do
      if D >= InterfacciaR004.lstDecorrenze[i] then
      begin
        Result:=i;
        Break;
      end;
  end;
begin
  C009FCopiaSu:=TC009FCopiaSu.Create(nil);
  with C009FCopiaSu do
  try
    SiglaProgetto:=Copy(Self.Name,1,4);
    Storicizzazione:=Storicizza;
    ODS:=TOracleDataSet(DButton.DataSet);
    if Length(InterfacciaR004.TabelleRelazionate) > 0 then
      SetODS(InterfacciaR004.TabelleRelazionate)
    else
      SetODS([ODS]);
    if Storicizzazione then
    begin
      id:=IdxDecorrenza(DButton.DataSet.FieldByName('DECORRENZA').AsDateTime);
      if id >= 0 then
      begin
        if id > 0 then
          C009FCopiaSu.RangeDecorrenzaInizio:=InterfacciaR004.lstDecorrenze[id];
        if id < High(InterfacciaR004.lstDecorrenze) then
          C009FCopiaSu.RangeDecorrenzaFine:=InterfacciaR004.lstDecorrenze[id + 1] - 1;
      end;
    end;
    ShowModal;
    Result:=Eseguito;
    if Eseguito then
    begin
      if Storicizzazione and InterfacciaR004.GestioneDecorrenzaFine and (@InterfacciaR004.AllineaDecorrenzaFine <> nil) then
      begin
        InterfacciaR004.AllineaDecorrenzaFine(ODS);
        SessioneOracle.Commit;
      end;
      S2:=grdChiaveElemento.Cells[1,1];
      if UpperCase(Self.Name) = 'A006FMODELLIORARIO' then
        A000AggiornaFiltroDizionario('MODELLI ORARIO','',S2);
      if UpperCase(Self.Name) = 'A007FPROFILIORARI' then
        A000AggiornaFiltroDizionario('PROFILI ORARIO','',S2);
      RefreshFiltro;
    end
    else if Storicizzazione then
    begin
      InterfacciaR004.StoricizzazioneInCorso:=False;
      SetPanelMessage('');
    end;
  finally
    Free;
  end;
end;

procedure TR004FGestStorico.actStampaVideataExecute(Sender: TObject);
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

procedure TR004FGestStorico.dedtDecorrenzaChange(Sender: TObject);
var P:TPoint;
begin
  lbldecorrenza.Font.Color:=clBlue;
  dedtDecorrenza.Hint:='';
  dedtDecorrenza.ShowHint:=False;
  if DButton.State = dsEdit then
  begin
    lbldecorrenza.Font.Color:=clRed;
    dedtDecorrenza.Hint:='Attenzione: storicizzazione disattivata!';
    dedtDecorrenza.ShowHint:=True;
    P.X:=dedtDecorrenza.Top + 4;
    P.Y:=dedtDecorrenza.Left + 4;
    Application.ActivateHint(P);
  end;
end;

procedure TR004FGestStorico.CercaStoricoCorrente;
var S,RI,PK:String;
    V:Variant;
    evAfterScroll: TEvDataSet;
begin
  if actVisioneCorrente.Checked then
    exit;

  with TOracleDataSet(DButton.DataSet) do
  begin
    //Caratto 26/09/2014 inibisco afterScroll per evitare che si scateni troppe volte
    evAfterScroll:=AfterScroll;
    AfterScroll:=nil;
    DisableControls;
    RI:=RowID;
    S:=R180GetCampiConcatenati(DButton.DataSet,InterfacciaR004.LChiavePrimaria);
    GetValoriChiavePrimaria(PK,V,False);
    DButton.DataSet.Locate(PK,V,[]);
    while (not Eof) and
          (S = R180GetCampiConcatenati(DButton.DataSet,InterfacciaR004.LChiavePrimaria)) and
          (FieldByName('DECORRENZA').AsDateTime <= InterfacciaR004.DataLavoro) do
    begin
      RI:=RowID;
      Next;
    end;
    SearchRecord('ROWID',RI,[srFromBeginning]);
    EnableControls;
    //Caratto 26/09/2014 riattivo afterScroll
    AfterScroll:=evAfterScroll;
    //forzo scroll per scatenare tutti gli eventi derivati dallo scroll
    SearchRecord('ROWID',RowId,[srFromBeginning]);

    NumRecords;
  end;
end;

procedure TR004FGestStorico.cmbDateDecorrenzaChange(Sender: TObject);
var DLOri:TDateTime;
begin
  if cmbDateDecorrenza.ItemIndex = -1 then
    exit;
  DLOri:=InterfacciaR004.DataLavoro;
  InterfacciaR004.DataLavoro:=StrToDate(cmbDateDecorrenza.Items[cmbDateDecorrenza.ItemIndex]);
  CercaStoricoCorrente;
  InterfacciaR004.DataLavoro:=DLOri;
end;

procedure TR004FGestStorico.FormDestroy(Sender: TObject);
begin
  FreeAndNil(NomiCampiR001);
  FreeAndNil(QueryStampa);
  FreeAndNil(CheckRelazioni);
  {
  InterfacciaR004.LValoriOriginali.Free;
  InterfacciaR004.LChiavePrimaria.Free;
  InterfacciaR004.Free;
  }
  {
  if InterfacciaR004 <> nil then
    try
      if InterfacciaR004.LChiavePrimaria <> nil then
        FreeAndNil(InterfacciaR004.LChiavePrimaria);
      if InterfacciaR004.LValoriOriginali <> nil then
        FreeAndNil(InterfacciaR004.LValoriOriginali);
      FreeAndNil(InterfacciaR004);
    except
    end;
  }
end;

end.
