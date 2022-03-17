unit R001UGestTab;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Menus, Grids, DbCtrls, DBGrids, StdCtrls,
  Mask, DB, Buttons, A000UCostanti, A000USessione, A000UInterfaccia, Oracle, OracleData, ImgList,
  ToolWin, ActnList, C180FunzioniGenerali, Variants, SelAnagrafe, Printers,
  C700USelezioneAnagrafe, ToolbarFiglio
  {$IFNDEF VER210}, System.Actions, System.ImageList{$ENDIF};

type
  TFiltriDButton = record
    Dato:String;
    Componente:TControl;
    Bottone:TSpeedButton;
  end;

  TR001FGestTab = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Chiudi1: TMenuItem;
    N1: TMenuItem;
    Stampa1: TMenuItem;
    StatusBar: TStatusBar;
    DButton: TDataSource;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Copiada1: TMenuItem;
    ImageList1: TImageList;
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
    actStoricoPrecedente: TAction;
    actStoricoSuccessivo: TAction;
    actVisioneCorrente: TAction;
    actCopiaSu: TAction;
    actGomma: TAction;
    Ricerca1: TMenuItem;
    Strumenti1: TMenuItem;
    Primo1: TMenuItem;
    Precedente1: TMenuItem;
    Successivo1: TMenuItem;
    Ultimo1: TMenuItem;
    Inserisci1: TMenuItem;
    Modifica1: TMenuItem;
    Cancella1: TMenuItem;
    Annulla1: TMenuItem;
    Conferma1: TMenuItem;
    Puliscicampo1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    actRefresh: TAction;
    Refresh1: TMenuItem;
    Panel1: TToolBar;
    ToolButton1: TToolButton;
    TCerca: TToolButton;
    ToolButton13: TToolButton;
    TPrimo: TToolButton;
    TPrec: TToolButton;
    TSucc: TToolButton;
    TUltimo: TToolButton;
    ToolButton6: TToolButton;
    btnRefresh: TToolButton;
    ToolButton3: TToolButton;
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
    actStampaVideata: TAction;
    Stampavideata1: TMenuItem;
    procedure actStampaVideataExecute(Sender: TObject);
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
    procedure Copiada1Click(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    ControllaDataSetReadOnly:Boolean;
    LCampiPredefiniti,LValoriPredefiniti:TStringList;
    function DataSetName(DSet:TDataSet):string;
    procedure CreaCampiPersistentiQuery2;
    procedure CreaNuovoElemento(S:String; Posiziona:Boolean);
    procedure CreaNuovaIntPaghe(S:String);
    procedure CreaNuovoCartellino(S:String);
    procedure CreaNuovoContratto(S:String);
    procedure CreaNuovaCausale(Tipo,S:String);
    procedure CreaNuovaParMessaggi(S:String);
    function NomiColonne:String;
    function ValoriColonne(S:String):String;
    procedure StampaAnagraficaMista;
    function CheckRelazioniEsistenti:boolean;
  protected
    { Protected declarations }
    AliasR001,IntestazioneR001,TitoloR001,FromSql,SelezioneSQL:String;
    SessioneR001:TOracleSession;
    R001LinkC700(*,EseguiStampaMista*),pagctrDataSetSingolo:Boolean;
    FiltroR001:Boolean;
    lstFiltriDButton:array of TFiltriDButton;
    CodiceCopiaSu:String;
    CheckRelazioni: TOracleQuery;
    procedure ParametriStampa;
    procedure NumRecords;
    procedure InizializzaQueryStandard;
    procedure InizializzaQueryPersonalizzata;
    procedure GetC700SelAnagrafeInterna;
    procedure FiltraDButton;
  public
    { Public declarations }
    Azienda,Operatore:string;
    TipoDB:TDataBaseDrv;
    MovCassa:Boolean;
    NomiCampiR001:TStringList;
    QueryStampa:TStringList;
    C700SelAnagrafeInterna:TOracleDataSet;
    CopiaInCorso:Boolean;
  end;

var
  R001FGestTab: TR001FGestTab;

implementation

uses A002UInterfacciaSt, C001URicerca,C001UFiltroTabelle,C001UFiltroTabelleDTM,C001UScegliCampi;

{$R *.DFM}

procedure TR001FGestTab.CreaCampiPersistentiQuery2;
var I:Integer;
begin
  with C001FFiltroTabelleDtM do
  begin
    for I:=Query2.FieldCount - 1 downto 0 do
      Query2.Fields[I].Free;
    Query2.FieldDefs.UpDate;
    for I:=0 to Query2.FieldDefs.Count - 1 do
      Query2.FieldDefs[I].CreateField(Query2);
  end;
end;

procedure TR001FGestTab.FormCreate(Sender: TObject);
begin
  if Parametri.DataLavoro > 0 then
    StatusBar.Panels[0].Text:='Data lavoro:' + FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro)
  else
    StatusBar.Panels[0].Text:=FormatDateTime('dd/mm/yyyy',Date);
  NomiCampiR001:=TStringList.Create;
  QueryStampa:=TStringList.Create;
  R001LinkC700:=True;
  FiltroR001:=False;
  SetLength(lstFiltriDButton,0);
  pagctrDataSetSingolo:=True;
  ControllaDataSetReadOnly:=False;
  //EseguiStampaMista:=True;
  actCopiaSu.Visible:=(Self.Name = 'A006FModOra') or
                      (Self.Name = 'A016FCausAssenze') or
                      (Self.Name = 'A020FCausPresenze') or
                      (Self.Name = 'A021FCausGiustif') or
                      (Self.Name = 'A022FContratti') or
                      (Self.Name = 'A034FIntPaghe') or
                      (Self.Name = 'A039FRegReperib') or
                      (Self.Name = 'A052FParCar') or
                      (Self.Name = 'A071FRegoleBuoni') or
                      (Self.Name = 'A076FIndGruppo') or
                      (Self.Name = 'A111FParMessaggi') or
                      (Self.Name = 'A080FModConte') or
                      (Self.Name = 'A102FParScaricoGiust') or
                      (Self.Name = 'A077FGeneratoreStampe') or
                      (Self.Name = 'P077FGeneratoreStampe');
  R180DBGridSetDrawingStyle(Self);
  R180ToolBarHandleNeeded(Self);
  LCampiPredefiniti:=TStringList.Create;
  LCampiPredefiniti.CaseSensitive:=False;
  LValoriPredefiniti:=TStringList.Create;
  CopiaInCorso:=False;

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

procedure TR001FGestTab.GetC700SelAnagrafeInterna;
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

procedure TR001FGestTab.TPrimoClick(Sender: TObject);
begin
  if Sender = actPrimo then
    DButton.DataSet.First;
  if Sender = actPrecedente then
    DButton.DataSet.Prior;
  if Sender = actSuccessivo then
    DButton.DataSet.Next;
  if Sender = actUltimo then
    DButton.DataSet.Last;
  NumRecords;
end;

procedure TR001FGestTab.actRefreshExecute(Sender: TObject);
var ID:String;
begin
  if DButton.DataSet is TOracleDataSet then
    ID:=(DButton.DataSet as TOracleDataSet).RowID;
  DButton.DataSet.Refresh;
  if DButton.DataSet is TOracleDataSet then
    if ID <> '' then
      DButton.DataSet.Locate('RowID',ID,[]);
end;

procedure TR001FGestTab.TCancClick(Sender: TObject);
begin
  if DButton.DataSet.RecordCount > 0 then
    if not CheckRelazioniEsistenti then
      if R180MessageBox('Confermi cancellazione ?',DOMANDA) = mrYes then
      begin
        DButton.DataSet.Delete;
        NumRecords;
      end;
end;

function TR001FGestTab.CheckRelazioniEsistenti: boolean;
var Chiave:String;
begin
  Result:=True;
  Chiave:='CODICE';
  if DataSetName(DButton.DataSet).ToUpper = 'T262_PROFASSANN' then
    Chiave:='CODPROFILO';
  // verifico esistenza campo chiave
  if DButton.DataSet.FindField(Chiave) <> nil then
  begin
    // -- imposta e richiama la function "MEDP_CHECK_RELAZIONI_ESISTENTI"
    CheckRelazioni.Session:=(DButton.DataSet as TOracleDataSet).Session;
    CheckRelazioni.ClearVariables;
    CheckRelazioni.SetVariable('MASCHERA',Copy(Name,1,4));
    CheckRelazioni.SetVariable('TABELLA',DataSetName(DButton.DataSet).ToUpper);
    CheckRelazioni.SetVariable('CHIAVE',DButton.DataSet.FieldByName(Chiave).AsString);
    // Imposto DECORRENZA con valore di default 31/12/3999
    CheckRelazioni.SetVariable('DECORRENZA',DATE_MIN);
    // Imposto SCADENZA con valore di default 31/12/3999
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

    if VarToStr(CheckRelazioni.GetVariable('RESULT')) = 'E1' then
      raise Exception.Create('Errore passaggio parametri')
    else if VarToStr(CheckRelazioni.GetVariable('RESULT')) <> '' then
      raise Exception.Create('Cancellazione impedita in quanto il dato è in uso:' + #13#10 + CheckRelazioni.GetVariable('RESULT'))
    else
      Result:=False;
  end
  else
    Result:=False;
end;

procedure TR001FGestTab.TAnnullaClick(Sender: TObject);
begin
  DButton.DataSet.Cancel;
end;

procedure TR001FGestTab.TRegisClick(Sender: TObject);
begin
  DButton.DataSet.Post;
  NumRecords;
end;

procedure TR001FGestTab.TModifClick(Sender: TObject);
begin
  DButton.DataSet.Edit;
end;

procedure TR001FGestTab.TInserClick(Sender: TObject);
var i:integer;
begin
  if pagctrDataSetSingolo then
    for i:=0 to ComponentCount -1 do
      if (Components[i] is TTabSheet) and ((Components[i] as TTabSheet).PageIndex = 0) then
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
  if Self.ActiveControl = nil then
    Self.FindNextControl(Self.ActiveControl,true,true,true)
  else if not Self.ActiveControl.CanFocus then
    Self.FindNextControl(Self.ActiveControl,true,true,true);
  DButton.DataSet.Insert;
end;

procedure TR001FGestTab.DButtonStateChange(Sender: TObject);
{Abilita/Disabilita i bottoni}
var Browse:Boolean;
    i:Integer;
begin
  if (DButton.State = dsInsert) and R001LinkC700 then
  begin
    GetC700SelAnagrafeInterna;
    if (C700SelAnagrafeInterna <> nil) and (C700SelAnagrafeInterna.RecordCount = 0) then
    begin
      R180MessageBox('Inserimento impossibile!' + #13#10 + 'Nessun dipendente selezionato!',INFORMA);
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
  actCancella.Enabled:=Browse and not(SolaLettura);
  actInserisci.Enabled:=Browse and not(SolaLettura);
  actModifica.Enabled:=Browse and not(SolaLettura);
  actEsci.Enabled:=Browse;
  actConferma.Enabled:=not Browse;
  actAnnulla.Enabled:=not Browse;
  actGomma.Enabled:=not Browse;
  actCopiaSu.Enabled:=Browse and not(SolaLettura);
  actRefresh.Enabled:=Browse;
  for i:=0 to Self.ComponentCount - 1 do
    if (Self.Components[i] is TfrmToolbarFiglio) then
      TFrame(Self.Components[i]).Enabled:=Browse
end;

procedure TR001FGestTab.NumRecords;
{Calcola il numero di records della tabella}
begin
  if DButton.DataSet <> nil then
  begin
    if DButton.DataSet.Active then
      StatusBar.Panels[1].Text:=Format('Record %d/%d',[DButton.DataSet.RecNo,DButton.DataSet.RecordCount])
    else
      StatusBar.Panels[1].Text:=Format('Record %d/%d',[0,0]);
  end;
end;

procedure TR001FGestTab.TGommaClick(Sender: TObject);
{Abblenca il contenuto del campo su cui si è posizionati}
var F:TField;
begin
  F:=nil;
  if ActiveControl is TDBEdit then
    F:=(ActiveControl as TDBEdit).Field;
  if ActiveControl is TDBLookupComboBox then
    with ActiveControl as TDBLookupComboBox do
    begin
      if DataField <> '' then
        F:=DataSource.DataSet.FieldByName(DataField)
      else
        (ActiveControl as TDBLookupComboBox).KeyValue:=null;
    end;
  if ActiveControl is TDBComboBox then
    F:=(ActiveControl as TDBComboBox).Field;
  if ActiveControl is TDBGrid then
    F:=(ActiveControl as TDBGrid).SelectedField;
  if (F <> nil) and (not F.ReadOnly) then
  begin
    if ActiveControl is TDBGrid then
    begin
      if (not (ActiveControl as TDBGrid).ReadOnly) and
         (not (ActiveControl as TDBGrid).Columns[(ActiveControl as TDBGrid).SelectedIndex].ReadOnly) then
      begin
        if (ActiveControl as TDBGrid).DataSource.State in [dsEdit,dsInsert] then
        begin
          if (F.FieldKind = fkLookup) and (Pos(';',F.KeyFields) = 0) then
          begin
            F.Dataset.FieldByName(F.KeyFields).Clear;
            F.FocusControl;
          end
          else
            F.Clear;
        end
        else if (ActiveControl as TDBGrid).DataSource.AutoEdit then
        begin
          (ActiveControl as TDBGrid).DataSource.DataSet.Edit;
          if (F.FieldKind = fkLookup) and (Pos(';',F.KeyFields) = 0) then
          begin
            F.Dataset.FieldByName(F.KeyFields).Clear;
            F.FocusControl;
          end
          else
            F.Clear;
          if (ActiveControl as TDBGrid).DataSource.State in [dsInsert,dsEdit] then
            (ActiveControl as TDBGrid).DataSource.DataSet.Post;
        end;
      end;
    end
    else if F.DataSet.State in [dsEdit,dsInsert] then
      if (F.FieldKind = fkLookup) and (Pos(';',F.KeyFields) = 0) then
      begin
        F.Dataset.FieldByName(F.KeyFields).Clear;
        F.FocusControl;
      end
      else
        F.Clear;
  end;
end;

procedure TR001FGestTab.TCercaClick(Sender: TObject);
{Crea la form di ricerca e si posiziona sul record}
var i,j:Integer;
    ElencoCampi,Filtro:String;
    Valori,Campi:TStringList;
    Pippo:Variant;
    BM:TBookmark;
begin
  Valori:=TStringList.Create;
  Campi:=TStringList.Create;
  ElencoCampi:='';
  C001FRicerca:=TC001FRicerca.Create(nil);
  FiltroR001:=False;
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
      Filtro:='';
      for i:=1 to Grid.RowCount - 1 do
        if Trim(Grid.Cells[1,i]) <> '' then
        begin
          ElencoCampi:=ElencoCampi + ';' + Campi[i-1];
          Valori.Add(Trim(Grid.Cells[1,i]));
          if Filtro <> '' then
            Filtro:=Filtro + ' AND ';
          Filtro:=Filtro + '(' + Campi[i-1] + '=' + '''' + StringReplace(Trim(Grid.Cells[1,i]),'%','*',[rfReplaceAll]) + ''')';
        end;
      if chkFiltro.Checked then
      begin
        { DONE : TEST IW 15 }
        BM:=GetBookMark;
        try
          FiltroR001:=Filtro <> '';
          FilterOptions:=[foCaseInsensitive];
          Filter:=Filtro;
          Filtered:=False;
          Filtered:=True;
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
            Locate(Copy(ElencoCampi,2,1000),Pippo,[loCaseInsensitive, loPartialKey])
          else
            Locate(Copy(ElencoCampi,2,1000),Valori[0],[loCaseInsensitive, loPartialKey]);
          NumRecords;
        end;
    end;
  finally
    C001FRicerca.Free;
    //Caratto 26/06/2014 dava memory leak; non ha mai funzionato
    FreeAndNil(Valori);
    FreeAndNil(Campi);

    if FiltroR001 then
      for i:=0 to High(lstFiltriDButton) DO
        lstFiltriDButton[i].Bottone.Down:=False;
  end;
end;

procedure TR001FGestTab.FiltraDButton;
var Filtro,Valore,RI:String;
    i:Integer;
begin
  if DButton.State <> dsBrowse then
    exit;
  RI:='';
  if (DButton.DataSet is TOracleDataSet) and (TOracleDataSet(DButton.DataSet).RowId <> '') then
    RI:=TOracleDataSet(DButton.DataSet).RowId;
  Filtro:='(true)';//'(1=1)';
  for i:=0 to High(lstFiltriDButton) do
    if lstFiltriDButton[i].Bottone.Down then
    begin
      Valore:='';
      if DButton.Dataset.FindField(lstFiltriDButton[i].Dato) <> nil then
        Valore:=DButton.Dataset.FieldByName(lstFiltriDButton[i].Dato).Text
      else if lstFiltriDButton[i].Componente is TEdit then
        Valore:=TEdit(lstFiltriDButton[i].Componente).Text
      else if lstFiltriDButton[i].Componente is TDBEdit then
        Valore:=TDBEdit(lstFiltriDButton[i].Componente).Text
      else if lstFiltriDButton[i].Componente is TDBLookupComboBox then
        Valore:=TDBLookupComboBox(lstFiltriDButton[i].Componente).Text;
      if Valore <> '' then
        Valore:='''' + AggiungiApice(Valore) + ''''
      else
        Valore:='null';
      Filtro:=Filtro + Format(' and (%s = %s)',[lstFiltriDButton[i].Dato,Valore]);
    end;
  with DButton.DataSet do
  begin
    Filter:=Filtro;
    Filtered:=Filter <> '';
  end;
  if RI <> '' then
    TOracleDataSet(DButton.DataSet).SearchRecord('ROWID',RI,[srFromBeginning]);
  NumRecords;
end;

procedure TR001FGestTab.SettaDBStampa(Sessione:TOracleSession);
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

procedure TR001FGestTab.Stampa1Click(Sender: TObject);
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

procedure TR001FGestTab.StampaAnagraficaMista;
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
    C700Progressivo:=(Self.FindComponent('frmSelAnagrafe') as TfrmSelAnagrafe).OldC700Progressivo;
    C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
    C700DatiSelezionati:=CampiAbilitati;//C700TuttiCampi;
    //C700Creazione(SessioneOracle);
    C001FFiltroTabelle.frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
    C001FFiltroTabelle.frmSelAnagrafe.RipristinaC700SelAnagrafeBridge;
    //C700FSelezioneAnagrafeDtM.OpenSelAnagrafe;
    TipoDB:=DataBaseDrv;
    if QueryStampa.Count = 0 then
    begin
      ParametriStampa;
      //NomiCampiR001.Clear; //ALberto 16/01/2009 per gestire campi di lookup (join)
    end
    else
    begin
      C001FFiltroTabelleDTM.Query1.SQL.Assign(QueryStampa);
      C001FFiltroTabelleDTM.Query2.SQL.Assign(QueryStampa);
    end;
    //NomiCampiR001.Clear;
    //ParametriStampa;
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
    C700OldProgressivo:=-1;
    (Self.FindComponent('frmSelAnagrafe') as TfrmSelAnagrafe).RipristinaC00SelAnagrafe;
  end;
end;

procedure TR001FGestTab.InizializzaQueryStandard;
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

procedure TR001FGestTab.InizializzaQueryPersonalizzata;
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

function TR001FGestTab.DataSetName(DSet:TDataSet):string;
{funzione che restituisce il nome della tabella associata al dataset, nel caso
di una query estrae il nome della prima tabella dopo la clausola FROM}
begin
  result:='';
  (*if (DSet is TTable) then
     result:= (DSet as TTable).TableName
  else if (DSet is TQuery) then
    result:=R180EstraiNomeTabella(TQuery(DSet).Text)
  else*) if (DSet is TOracleDataSet) then
    result:=R180EstraiNomeTabella(TOracleDataSet(DSet).SQL.Text);
end;

procedure TR001FGestTab.ParametriStampa;
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
      if Tag < 0 then
        Continue
      //Se e' un campo di lookup costruisco l'alias e la LEFT JOIN  e lo inserisco
      // nella lista NOMICAMPI
      else if Lookup then
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
            else if UpperCase(DataSetName(LookupDataSet)) = 'DUAL' then
              Campo:='NULL'
            else
              Campo:=Alias + '.' + LookupResultField;
            Campo:=Campo + ' ' + FieldName;
            Suf:=Succ(Suf);
          until not StringaInArrayContiene(Campo,Campi);
          IDC:=VerificaDimensioneArray(Campi);
          Campi[IDC]:=Campi[IDC] + ',' + Campo;
          NomiCampiR001.Add(Campo);
          //LEFT JOIN Tabella Alias
          if (not StringaInArrayContiene(Alias,Tabelle)) and
             (UpperCase(DataSetName(LookupDataSet)) <> 'DUAL') then
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

procedure TR001FGestTab.Chiudi1Click(Sender: TObject);
begin
  Close;
end;

procedure TR001FGestTab.FormShow(Sender: TObject);
begin
  if DButton.DataSet <> nil then
  begin
    if DButton.DataSet.Active then
      NumRecords;
    if DButton.DataSet is TOracleDataSet then
      (DButton.DataSet as TOracleDataSet).ReadOnly:=SolaLettura;
  end
  else
    ControllaDataSetReadOnly:=True;
end;

procedure TR001FGestTab.FormActivate(Sender: TObject);
begin
  if DButton.DataSet <> nil then
  begin
    if DButton.DataSet.Active then
      NumRecords;
    if ControllaDataSetReadOnly and (DButton.DataSet is TOracleDataSet) then
      (DButton.DataSet as TOracleDataSet).ReadOnly:=SolaLettura;
  end;
end;

procedure TR001FGestTab.FormClose(Sender: TObject;
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

procedure TR001FGestTab.FormDestroy(Sender: TObject);
begin
  NomiCampiR001.Free;
  QueryStampa.Free;
  FreeAndNil(LCampiPredefiniti);
  FreeAndNil(LValoriPredefiniti);
  FreeAndNil(CheckRelazioni);
end;

procedure TR001FGestTab.Copiada1Click(Sender: TObject);
var T,Nuovo:String;
begin
  if DButton.DataSet = nil then exit;
  if DButton.State <> dsBrowse then exit;
  if DButton.DataSet.RecordCount < 1 then exit;
  Nuovo:='';
  // Non sarebbe necessario, ma per sicurezza...
  LCampiPredefiniti.Clear;
  LValoriPredefiniti.Clear;
  T:='Codice:';
  if UpperCase(Self.Name) = 'A006FMODORA' then
    T:='Codice orario:'
  else if UpperCase(Self.Name) = 'A016FCAUSASSENZE' then
    T:='Codice assenza:'
  else if UpperCase(Self.Name) = 'A020FCAUSPRESENZE' then
    T:='Codice presenza:'
  else if UpperCase(Self.Name) = 'A021FCAUSGIUSTIF' then
    T:='Codice giustificazione:'
  else if UpperCase(Self.Name) = 'A022FCONTRATTI' then
    T:='Contratto:'
  else if UpperCase(Self.Name) = 'A034FINTPAGHE' then
    T:='Contratto:'
  else if UpperCase(Self.Name) = 'A111FPARMESSAGGI' then
    T:='Parametrizzazione:'
  else if UpperCase(Self.Name) = 'A052FPARCAR' then
    T:='Nome cartellino:';
  if InputQuery('Creazione nuovo elemento',T,Nuovo) then
  begin
    CodiceCopiaSu:=Nuovo;
    CopiaInCorso:=True;
    try
      if UpperCase(Self.Name) = 'A022FCONTRATTI' then
        CreaNuovoContratto(Nuovo)
      else if UpperCase(Self.Name) = 'A034FINTPAGHE' then
        CreaNuovaIntPaghe(Nuovo)
      else if UpperCase(Self.Name) = 'A052FPARCAR' then
        CreaNuovoCartellino(Nuovo)
      else if UpperCase(Self.Name) = 'A020FCAUSPRESENZE' then
        CreaNuovaCausale('PRESENZA',Nuovo)
      else if UpperCase(Self.Name) = 'A016FCAUSASSENZE' then  //LORENA 06/08/2004
        CreaNuovaCausale('ASSENZA',Nuovo)
      else if UpperCase(Self.Name) = 'A021FCAUSGIUSTIF' then  //LORENA 06/08/2004
        CreaNuovaCausale('GIUSTIFICAZIONE',Nuovo)
      else if UpperCase(Self.Name) = 'A111FPARMESSAGGI' then
        CreaNuovaParMessaggi(Nuovo)
      else
        CreaNuovoElemento(Nuovo,True);
      try
        DButton.DataSet.Locate('CODICE',Nuovo,[]);
      except
      end;
    finally
      CopiaInCorso:=False;
    end;
  end
  else
    CodiceCopiaSu:='';
end;

procedure TR001FGestTab.CreaNuovoElemento(S:String; Posiziona:Boolean);
var Q:TOracleQuery;
    NT:String;
begin
  NT:=DataSetName(DButton.DataSet);
  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=TOracleDataSet(DButton.DataSet).Session;
    Q.SQL.Clear;
    Q.SQL.Add('INSERT INTO ' + NT);
    Q.SQL.Add('(' + NomiColonne + ')');
    Q.SQL.Add('SELECT ' + ValoriColonne(S));
    Q.SQL.Add('FROM ' + NT + ' WHERE CODICE = ''' + DButton.DataSet.FieldByName('CODICE').AsString+ '''');
    Q.Execute;
    Q.Session.Commit;
    if UpperCase(Self.Name) = 'A006FMODORA' then
      A000AggiornaFiltroDizionario('MODELLI ORARIO','',S)
    else if UpperCase(Self.Name) = 'A016FCAUSASSENZE' then
      A000AggiornaFiltroDizionario('CAUSALI ASSENZA','',S)
    else if UpperCase(Self.Name) = 'A020FCAUSPRESENZE' then
      A000AggiornaFiltroDizionario('CAUSALI PRESENZA','',S)
    else if UpperCase(Self.Name) = 'A052FPARCAR' then
      A000AggiornaFiltroDizionario('PARAMETRIZZAZIONI CARTELLINO','',S)
    else if UpperCase(Self.Name) = 'A120FTIPIRIMBORSI' then
      A000AggiornaFiltroDizionario('RIMBORSI MISSIONI','',S);
    if Posiziona then
    begin
      DButton.DataSet.Refresh;
      NumRecords;
      DButton.DataSet.Locate('CODICE',S,[]);
    end;
  finally
    Q.Free;
  end;
end;

procedure TR001FGestTab.CreaNuovaIntPaghe(S:String);
var Q:TOracleQuery;
    NT:String;
begin
  NT:=DataSetName(DButton.DataSet);
  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=TOracleDataSet(DButton.DataSet).Session;
    Q.SQL.Clear;
    Q.SQL.Add('DELETE FROM ' + NT);
    Q.SQL.Add('WHERE CODICE = ''' + S + '''');
    Q.Execute;
    Q.SQL.Clear;
    Q.SQL.Add('INSERT INTO ' + NT);
    Q.SQL.Add('(' + NomiColonne + ')');
    Q.SQL.Add('SELECT ' + ValoriColonne(S));
    Q.SQL.Add('FROM ' + NT + ' WHERE CODICE = ''' + DButton.DataSet.FieldByName('CODICE').AsString+ '''');
    Q.Execute;
    Q.SQL.Clear;
    Q.SQL.Add('INSERT INTO T193_VOCIPAGHE_PARAMETRI');
    Q.SQL.Add('(COD_INTERFACCIA, VOCE_PAGHE, DECORRENZA, VOCE_PAGHE_CEDOLINO, VOCE_PAGHE_NEGATIVA, DESCRIZIONE, DAL, AL, AUTOINC_DAL, AUTOINC_AL, ARROTONDAMENTO, FORMULA, SPOSTA_VALIMP, VOCE_PAGHE_SECONDARIA, VOCE_PAGHE_SECONDH, VOCE_PAGHE_ATTRIBUTO, STATO_PER_SCARICO)');
    Q.SQL.Add('SELECT ''' + S + ''', VOCE_PAGHE, DECORRENZA, VOCE_PAGHE_CEDOLINO, VOCE_PAGHE_NEGATIVA, DESCRIZIONE, DAL, AL, AUTOINC_DAL, AUTOINC_AL, ARROTONDAMENTO, FORMULA, SPOSTA_VALIMP, VOCE_PAGHE_SECONDARIA, VOCE_PAGHE_SECONDH, VOCE_PAGHE_ATTRIBUTO, STATO_PER_SCARICO');
    Q.SQL.Add('FROM T193_VOCIPAGHE_PARAMETRI WHERE COD_INTERFACCIA = ''' + DButton.DataSet.FieldByName('CODICE').AsString + '''');
    Q.Execute;
    Q.Session.Commit;
    DButton.DataSet.Refresh;
    NumRecords;
    DButton.DataSet.Locate('CODICE',S,[]);
  finally
    Q.Free;
  end;
end;

procedure TR001FGestTab.CreaNuovoCartellino(S:String);
var Q:TOracleQuery;
begin
  CreaNuovoElemento(S,False);
  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=TOracleDataSet(DButton.DataSet).Session;
    Q.SQL.Clear;
    Q.SQL.Add('DELETE FROM T951_STAMPACARTELLINO_DATI WHERE CODICE = ''' + S + '''');
    Q.Execute;
    Q.SQL.Clear;
    Q.SQL.Add('INSERT INTO T951_STAMPACARTELLINO_DATI');
    Q.SQL.Add('(CODICE,NUMRIGA,RIGA)');
    Q.SQL.Add('SELECT ''' + S + ''',NUMRIGA,RIGA');
    Q.SQL.Add('FROM T951_STAMPACARTELLINO_DATI WHERE CODICE = ''' + DButton.DataSet.FieldByName('CODICE').AsString + '''');
    Q.Execute;
  finally
    Q.Free;
  end;
  DButton.DataSet.Refresh;
  DButton.DataSet.Open;
  NumRecords;
  DButton.DataSet.Locate('CODICE',S,[]);
end;

procedure TR001FGestTab.CreaNuovoContratto(S:String);
var Q:TOracleQuery;
begin
  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=TOracleDataSet(DButton.DataSet).Session;
    Q.SQL.Clear;
    Q.SQL.Add('DELETE FROM T201_MAGGIORAZIONI WHERE CODICE = ''' + S + '''');
    Q.Execute;
    Q.SQL.Clear;
    Q.SQL.Add('INSERT INTO T201_MAGGIORAZIONI');
    Q.SQL.Add('(codice,giorno,fasciada1,fasciada2,fasciada3,fasciada4,fasciaa1,fasciaa2,fasciaa3,fasciaa4,maggior1,maggior2,maggior3,maggior4)');
    Q.SQL.Add('SELECT ''' + S + ''',giorno,fasciada1,fasciada2,fasciada3,fasciada4,fasciaa1,fasciaa2,fasciaa3,fasciaa4,maggior1,maggior2,maggior3,maggior4');
    Q.SQL.Add('FROM T201_MAGGIORAZIONI WHERE CODICE = ''' + DButton.DataSet.FieldByName('CODICE').AsString + '''');
    Q.Execute;
  finally
    Q.Free;
  end;
  CreaNuovoElemento(S,True);
end;

procedure TR001FGestTab.CreaNuovaCausale(Tipo,S:String); //LORENA 06/08/2004, MARCO 06/07/2018
var Q:TOracleQuery;
    S1,S2:String;
    NuovoID:String;
begin
  LCampiPredefiniti.Clear;
  LValoriPredefiniti.Clear;
  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=TOracleDataSet(DButton.DataSet).Session;
    Q.SQL.Clear;
    if Tipo = 'ASSENZA' then
    begin
      S1:='T275_CAUPRESENZE';
      S2:='T305_CAUGIUSTIF';
    end
    else if Tipo = 'PRESENZA' then
    begin
      S1:='T265_CAUASSENZE';
      S2:='T305_CAUGIUSTIF';
    end
    else
    begin
      S1:='T265_CAUASSENZE';
      S2:='T275_CAUPRESENZE';
    end;
    Q.SQL.Add(Format('SELECT COUNT(*) CONTA FROM (SELECT CODICE FROM %s WHERE CODICE = ''%s'' UNION SELECT CODICE FROM %s WHERE CODICE = ''%s'')',[S1,S,S2,S]));
    Q.Execute;
    if Q.FieldAsInteger('CONTA') > 0 then
      raise exception.Create('Codice già esistente!');
    if Tipo = 'PRESENZA' then
    begin
      Q.SQL.Clear;
      Q.SQL.Add('DELETE FROM T276_VOCIPAGHEPRESENZA WHERE CODICE = ''' + S + '''');
      Q.Execute;
      Q.SQL.Clear;
      Q.SQL.Add('INSERT INTO T276_VOCIPAGHEPRESENZA');
      Q.SQL.Add('(codice,tipogiorno,dalle,alle,limite,vocepaghe)');
      Q.SQL.Add('SELECT ''' + S + ''',tipogiorno,dalle,alle,limite,vocepaghe');
      Q.SQL.Add('FROM T276_VOCIPAGHEPRESENZA WHERE CODICE = ''' + DButton.DataSet.FieldByName('CODICE').AsString + '''');
      Q.Execute;
      Q.SQL.Clear;
      Q.SQL.Add('DELETE FROM T277_CAUFASCEABILITATE WHERE CODICE = ''' + S + '''');
      Q.Execute;
      Q.SQL.Clear;
      Q.SQL.Add('INSERT INTO T277_CAUFASCEABILITATE');
      Q.SQL.Add('(codice,tipo_giorno,dalle,alle)');
      Q.SQL.Add('SELECT ''' + S + ''',tipo_giorno,dalle,alle');
      Q.SQL.Add('FROM T277_CAUFASCEABILITATE WHERE CODICE = ''' + DButton.DataSet.FieldByName('CODICE').AsString + '''');
      Q.Execute;
    end;

    if Tipo = 'ASSENZA' then
    begin
      Q.SQL.Clear;
      Q.SQL.Text:='select T265_ID.NEXTVAL from DUAL';
      Q.Execute;
      NuovoID:=Q.FieldAsString('NEXTVAL');
      LCampiPredefiniti.Add('ID');
      LValoriPredefiniti.Add(NuovoID);
    end    
    else if Tipo = 'PRESENZA' then
    begin
      Q.SQL.Clear;
      Q.SQL.Text:='select T275_ID.NEXTVAL from DUAL';
      Q.Execute;
      NuovoID:=Q.FieldAsString('NEXTVAL');
      LCampiPredefiniti.Add('ID');
      LValoriPredefiniti.Add(NuovoID);
    end;

  finally
    Q.Free;
  end;

  try
    CreaNuovoElemento(S,True);
  finally
    LCampiPredefiniti.Clear;
    LValoriPredefiniti.Clear;
  end;

end;

procedure TR001FGestTab.CreaNuovaParMessaggi(S:String);
var Q:TOracleQuery;
begin
  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=TOracleDataSet(DButton.DataSet).Session;
    Q.SQL.Add(Format('SELECT COUNT(*) CODICE FROM T292_PARMESSAGGIDATI WHERE CODICE = ''%s''',[S]));
    Q.Execute;
    if Q.FieldAsInteger('CODICE') > 0 then
      raise exception.Create('Codice già esistente!')
    else
    begin
      Q.SQL.Clear;
      Q.SQL.Add('DELETE FROM T292_PARMESSAGGIDATI WHERE CODICE = ''' + S + '''');
      Q.Execute;
      Q.SQL.Clear;
      Q.SQL.Add('INSERT INTO T292_PARMESSAGGIDATI');
      Q.SQL.Add('(codice,tipo_record,numero_record,tipo,posizione,lunghezza,nome_colonna,formato,valore_default,codice_dato,chiave)');
      Q.SQL.Add('SELECT ''' + S + ''',tipo_record,numero_record,tipo,posizione,lunghezza,nome_colonna,formato,valore_default,codice_dato,chiave');
      Q.SQL.Add('FROM T292_PARMESSAGGIDATI WHERE CODICE = ''' + DButton.DataSet.FieldByName('CODICE').AsString + '''');
      Q.Execute;
    end;
  finally
    Q.Free;
  end;
  CreaNuovoElemento(S,True);
end;

function TR001FGestTab.NomiColonne:String;
var i:Integer;
begin
  Result:='';
  for i:=0 to DButton.DataSet.FieldCount - 1 do
    if (not DButton.DataSet.Fields[i].Calculated) and (not DButton.DataSet.Fields[i].Lookup) then
      begin
      if Result <> '' then Result:=Result + ',';
      Result:=Result + DButton.DataSet.Fields[i].FieldName;
      end;
end;

function TR001FGestTab.ValoriColonne(S:String):String;
var
  i,idxValorePredefinito:Integer;
begin
  Result:='';
  for i:=0 to DButton.DataSet.FieldCount - 1 do
  begin
    if (not DButton.DataSet.Fields[i].Calculated) and (not DButton.DataSet.Fields[i].Lookup) then
    begin
      if Result <> '' then Result:=Result + ',';
      if UpperCase(DButton.DataSet.Fields[i].FieldName) = 'CODICE' then
      begin
        Result:=Result + '''' + S + ''''
      end
      else
      begin
        // LCampiPredefiniti.CaseSensitive è impostato a False
        idxValorePredefinito:=LCampiPredefiniti.IndexOf(DButton.DataSet.Fields[i].FieldName);
        if idxValorePredefinito > -1 then
        begin
          if LValoriPredefiniti[idxValorePredefinito] = '' then
            Result:=Result + 'NULL'
          else
            Result:=Result + '''' + LValoriPredefiniti[idxValorePredefinito] + '''';
        end
        else
        begin
          Result:=Result + DButton.DataSet.Fields[i].FieldName;
        end;
      end;
    end;
  end;
end;

procedure TR001FGestTab.actStampaVideataExecute(Sender: TObject);
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

end.


