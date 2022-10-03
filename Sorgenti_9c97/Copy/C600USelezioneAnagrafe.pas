unit C600USelezioneAnagrafe;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, checklst, ExtCtrls, ComCtrls, DBCtrls, Db, A000UInterfaccia, A000USessione,
  Buttons, Menus,C180FunzioniGenerali,QueryStorico, Oracle, ActnList, ImgList,
  ToolWin, OracleData, Grids, DBGrids, Variants, C600USelezioneAnagrafeDtM,
  System.Actions, System.UITypes;

const C600TuttiCampi = 'T030.*,T480.CITTA,T480.PROVINCIA,V430.*';
      C600CampiBase = 'T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO';

type
  PSelezione = ^TSelezione;

  TSelezione = record
    DaValore,AValore:String;
    TotValori,SelValori:TStringList;
    Esistente:Boolean;
  end;

  TC600SelAnagrafeBridge = record
    SQLCreato:String;
    Progressivo:Integer;
    SelezionePeriodica,SoloPersonaleInterno:Boolean;
  end;

  TC600FSelezioneAnagrafe = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    CBValori: TCheckListBox;
    TVAzienda: TTreeView;
    CBDaValore: TComboBox;
    CBAValore: TComboBox;
    Label3: TLabel;
    Panel4: TPanel;
    BitBtn2: TBitBtn;
    Panel5: TPanel;
    LBOrdinamento: TListBox;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Escieconferma1: TMenuItem;
    Escieannulla1: TMenuItem;
    Selezione1: TMenuItem;
    GeneraSQL1: TMenuItem;
    ModificaSQL1: TMenuItem;
    Annullaselezione1: TMenuItem;
    Aggiornaselezione1: TMenuItem;
    StatusBar1: TStatusBar;
    chkCessati: TCheckBox;
    ToolBar1: TToolBar;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ImageList1: TImageList;
    ActionList1: TActionList;
    actConferma: TAction;
    actAnnulla: TAction;
    actSalvaSelezione: TAction;
    actApriSelezione: TAction;
    actEliminaSelezione: TAction;
    actAnteprimaSelezione: TAction;
    actModificaSelezione: TAction;
    actAnnullaSelezione: TAction;
    ToolButton12: TToolButton;
    ToolButton14: TToolButton;
    N1: TMenuItem;
    Apriselezione1: TMenuItem;
    Salvaselezione1: TMenuItem;
    Eliminaselezione1: TMenuItem;
    cmbSelezione: TComboBox;
    ToolButton15: TToolButton;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    dgrdAnteprima: TDBGrid;
    PopupMenu1: TPopupMenu;
    Singolodipendente1: TMenuItem;
    PopupMenu2: TPopupMenu;
    mnuRicercaCompleta: TMenuItem;
    Splitter1: TSplitter;
    Label4: TLabel;
    PopupMenu3: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    grpSelezionePeriodica: TRadioGroup;
    chkEsterni: TCheckBox;
    NRicercaTesto: TMenuItem;
    Ricercatestocontenuto1: TMenuItem;
    Successivo1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TVAziendaDblClick(Sender: TObject);
    procedure TVAziendaChange(Sender: TObject; Node: TTreeNode);
    procedure LBOrdinamentoDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure LBOrdinamentoDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure LBOrdinamentoDblClick(Sender: TObject);
    procedure TVAziendaExit(Sender: TObject);
    procedure actGenerazioneSelezioneExecute(Sender: TObject);
    procedure actModificaSelezioneExecute(Sender: TObject);
    procedure Panel1Exit(Sender: TObject);
    procedure actAnnullaSelezioneExecute(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure CBAValoreEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);
    procedure actApriSelezioneExecute(Sender: TObject);
    procedure actEliminaSelezioneExecute(Sender: TObject);
    procedure actSalvaSelezioneExecute(Sender: TObject);
    procedure cmbSelezioneDblClick(Sender: TObject);
    procedure TVAziendaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TVAziendaEdited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure TVAziendaEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Singolodipendente1Click(Sender: TObject);
    procedure mnuRicercaCompletaClick(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure Ricercatestocontenuto1Click(Sender: TObject);
    procedure Successivo1Click(Sender: TObject);
  private
    { Private declarations }
    VecchioNodo:Integer;
    TreeNodeOrig,TVAziendaSearch:String;
    procedure GetCheck(Source:TStringList);
    procedure PutCheck(Dest:TStringList);
    procedure GestioneVecchioNodo;
    function FormatoValore(Campo:String; Valore:String; Tipo:TFieldType):String;
    function ValoriSelezionati(Campo:String; Lista:TStringList; Tipo:TFieldType):String;
    //procedure QueryDinamica(Modo:Byte);  spostata in Public
    procedure AggiornaSelezione;
    function FormatoCampo(Campo: String): String;

  public
    { Public declarations }
    DataLavoro,DataDal:TDateTime;
    OrderString,SelectString,C600Nome,C600Badge:String;
    DataBase:TOracleSession;
    ListSQL,ListSQLPeriodico,SQLCreato,CorpoSQL:TStringList;
    Componenti:TList;
    PulisciVecchiaSelezione,OpenC600SelAnagrafe:Boolean;
    WhereSql:String;
    //ex-Globali
    C600DatiSelezionati:String;
    C600FSelezioneAnagrafeDtM:TC600FSelezioneAnagrafeDtM;
    procedure PulisciListe;
    function IsCampoCaseInsensitive(Campo: String): Boolean;
    function PrefissoTabella(Campo:String):String;
    //ex-Private
    procedure QueryDinamica(Modo:Byte);
    //ex C600DtM
    procedure CaricaTVAzienda(Completa:Boolean);
  end;

//var
  //C700FSelezioneAnagrafe: TC700FSelezioneAnagrafe;
  (*C700SelAnagrafe:TOracleDataSet;
  C700SrcAnagrafe:TDataSource;  //Usato solamente in C001UFiltroTabelle quando chiama A002UInterfacciaSt
  C700Progressivo,C700OldProgressivo:LongInt;
  C700DatiVisualizzati,C700DatiSelezionati,OldC700DatiVisualizzati,OldC700DatiSelezionati:String;
  C700DataLavoro,C700DataDal,OldC700DataLavoro,OldC700DataDal:TDateTime;
  C700SelAnagrafeBridge:TC700SelAnagrafeBridge;*)
  //C700SelezionePeriodica,C700SoloPersonaleInterno:Boolean;  //Spostare come proprietà di SelAnagrafe!!!!!

(*procedure C700Creazione(Db:TOracleSession);
procedure C700Distruzione;
procedure C700MergeSelAnagrafe(ODS:TComponent; RicreaVariabili:Boolean = False);
function C700MergeSettaPeriodo(ODS:TComponent; DataDal,DataLavoro:TDateTime):Boolean;
function C700SelezionaAnagrafe:TModalResult;
function C700GetDatiVisualizzati:String;
function C700CompletaDatiSelezionati:String;*)

implementation

uses (*C700USelezioneAnagrafeDtM,*) C700USQL;

{$R *.DFM}

(*procedure C700Creazione(Db:TOracleSession);
{Creazione della Form e del DataModule}
begin
  C700FSelezioneAnagrafe:=TC700FSelezioneAnagrafe.Create(nil);
  with C700FSelezioneAnagrafe do
  try
    DataLavoro:=C700DataLavoro;
    if C700DatiVisualizzati = 'MATRICOLA,T430BADGE,COGNOME,NOME' then
      C700DatiVisualizzati:=Parametri.DatiC700;
    if C700DatiSelezionati = '' then
      C700DatiSelezionati:=C700CampiBase;
    C700DatiSelezionati:=C700CompletaDatiSelezionati;
    DataBase:=Db;
    C700FSelezioneAnagrafeDtM:=TC700FSelezioneAnagrafeDtM.Create(nil);
    C700FSelezioneAnagrafe.PulisciVecchiaSelezione:=True;
    C700FSelezioneAnagrafe.OpenC700SelAnagrafe:=True;
    //C700SelezionePeriodica:=False;
    //C700SoloPersonaleInterno:=True;
  except
    C700FSelezioneAnagrafeDtM.Free;
    C700FSelezioneAnagrafe.Free;
  end;
  C700SelAnagrafe:=C700FSelezioneAnagrafeDtM.selAnagrafe;
  C700SrcAnagrafe:=TDataSource.Create(nil);
  C700SrcAnagrafe.DataSet:=C700SelAnagrafe;
end;

function C700CompletaDatiSelezionati:String;
var lstS,lstV:TStringList;
    i:Integer;
begin
  Result:=C700DatiSelezionati;
  if Result = C700TuttiCampi then
    exit;
  lstS:=TStringList.Create;
  lstV:=TStringList.Create;
  try
    lstS.CommaText:=StringReplace(UpperCase(C700DatiSelezionati),'T030.','',[rfReplaceAll]);
    lstV.CommaText:=UpperCase(C700DatiVisualizzati);
    for i:=0 to lstV.Count - 1 do
      if lstS.IndexOf(lstV[i]) = -1 then
      begin
        lstS.Add(lstV[i]);
        if Result <> '' then
          Result:=Result + ',';
        Result:=Result + lstV[i];
      end;
  finally
    lstS.Free;
    lstV.Free;
  end;
end;

procedure C700MergeSelAnagrafe(ODS:TComponent; RicreaVariabili:Boolean = False);
{ODS deve essere un OracleDataSet o OracleQuery con il parametro C700SelAnagrafe di tipo Substitution;
 Viene rimpiazzato il parametro :C700SelAnagrafe con il testo SQL di C700Selanagrafe
 dalla FROM alla ORDER BY escluse.
 Le variabili di ODS vengono integrate con quelle di C700SelAnagrafe (DataLavoro, C700DataDal) cancellando quelle già esistenti o meno a seconda di RicreaVariabili
 Esempio di utilizzo:
 -Subquery-
 ...AND tabella.PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)
 -Join-
 SELECT * FROM TABELLA1, TABELLA2, :C700SelAnagrafe //la WHERE è già inserita
 AND TABELLA1.CAMPO1 = TABELLA2.CAMPO2
 AND TABELLA1.PROGRESSIVO = T030.PROGRESSIVO
 }
var i:Integer;
    S:String;
begin
  if Trim(C700FSelezioneAnagrafe.CorpoSQL.Text) = '' then
  begin
    //Prima volta che si richiama la procedura
    //C700FSelezioneAnagrafe.QueryDinamica(1);
    C700FSelezioneAnagrafe.QueryDinamica(2);
    C700SelAnagrafe.Open;
  end;
  //Alberto 12/04/2007: gestisco a parte le variabili di tipo Substitution
  S:=C700FSelezioneAnagrafe.CorpoSQL.Text;
  for i:=0 to C700SelAnagrafe.VariableCount - 1 do
   if C700SelAnagrafe.VariableType(i) = otSubst then
     S:=StringReplace(S,C700SelAnagrafe.VariableName(i),C700SelAnagrafe.GetVariable(C700SelAnagrafe.VariableName(i)),[rfIgnoreCase]);
  if ODS is TOracleQuery then
  begin
    //Se ODS è OracleQuery....
    if TOracleQuery(ODS).VariableIndex('C700SelAnagrafe') = -1 then
      exit;
    TOracleQuery(ODS).SetVariable('C700SelAnagrafe',S);
    if TOracleQuery(ODS).VariableIndex('C700Filtro') >= 0 then
      TOracleQuery(ODS).DeleteVariable('C700Filtro');
    if TOracleQuery(ODS).VariableIndex('C700DataDal') >= 0 then
      TOracleQuery(ODS).DeleteVariable('C700DataDal');
    if RicreaVariabili then
    begin
      TOracleQuery(ODS).DeleteVariables;
      TOracleQuery(ODS).DeclareVariable('C700SelAnagrafe',otSubst);
    end;
    for i:=0 to C700SelAnagrafe.VariableCount - 1 do
    begin
      if (TOracleQuery(ODS).VariableIndex(C700SelAnagrafe.VariableName(i)) = -1) and
         (C700SelAnagrafe.VariableType(i) <> otSubst) then
      begin
        TOracleQuery(ODS).DeclareVariable(C700SelAnagrafe.VariableName(i),C700SelAnagrafe.VariableType(i));
        TOracleQuery(ODS).SetVariable(C700SelAnagrafe.VariableName(i),C700SelAnagrafe.GetVariable(i));
      end;
    end;
  end
  else
  begin
    //Se ODS è OracleDataSet...
    if TOracleDataSet(ODS).VariableIndex('C700SelAnagrafe') = -1 then
      exit;
    TOracleDataSet(ODS).SetVariable('C700SelAnagrafe',S);
    if TOracleDataSet(ODS).VariableIndex('C700Filtro') >= 0 then
      TOracleDataSet(ODS).DeleteVariable('C700Filtro');
    if TOracleDataSet(ODS).VariableIndex('C700DataDal') >= 0 then
      TOracleDataSet(ODS).DeleteVariable('C700DataDal');
    if RicreaVariabili then
    begin
      TOracleDataSet(ODS).DeleteVariables;
      TOracleDataSet(ODS).DeclareVariable('C700SelAnagrafe',otSubst);
    end;
    for i:=0 to C700SelAnagrafe.VariableCount - 1 do
    begin
      if (TOracleDataSet(ODS).VariableIndex(C700SelAnagrafe.VariableName(i)) = -1) and
         (C700SelAnagrafe.VariableType(i) <> otSubst) then
      begin
        TOracleDataSet(ODS).DeclareVariable(C700SelAnagrafe.VariableName(i),C700SelAnagrafe.VariableType(i));
        TOracleDataSet(ODS).SetVariable(C700SelAnagrafe.VariableName(i),C700SelAnagrafe.GetVariable(i));
      end;
    end;
  end;
end;

function C700MergeSettaPeriodo(ODS:TComponent; DataDal,DataLavoro:TDateTime):Boolean;
{ODS deve essere un OracleDataSet o OracleQuery}
begin
  Result:=False;
  if ODS is TOracleQuery then
  begin
    //Se ODS è OracleQuery...
    if TOracleQuery(ODS).VariableIndex('DATALAVORO') >= 0 then
      if TOracleQuery(ODS).GetVariable('DATALAVORO') <> DataLavoro then
      begin
        TOracleQuery(ODS).SetVariable('DATALAVORO',DataLavoro);
        Result:=True;
      end;
    if TOracleQuery(ODS).VariableIndex('C700DATADAL') >= 0 then
      if TOracleQuery(ODS).GetVariable('C700DATADAL') <> DataDal then
      begin
        TOracleQuery(ODS).SetVariable('C700DATADAL',DataDal);
        Result:=True;
      end;
  end
  else
  begin
    //Se ODS è OracleDataSet...
    if TOracleDataSet(ODS).VariableIndex('DATALAVORO') >= 0 then
      if TOracleDataSet(ODS).GetVariable('DATALAVORO') <> DataLavoro then
      begin
        TOracleDataSet(ODS).SetVariable('DATALAVORO',DataLavoro);
        Result:=True;
      end;
    if TOracleDataSet(ODS).VariableIndex('C700DATADAL') >= 0 then
      if TOracleDataSet(ODS).GetVariable('C700DATADAL') <> DataDal then
      begin
        TOracleDataSet(ODS).SetVariable('C700DATADAL',DataDal);
        Result:=True;
      end;
  end;
end;
 
function C700SelezionaAnagrafe:TModalResult;
var L,L1:TStringList;
    i,P:Integer;
    VarODS:TOracleDataSet;
begin
  L:=TStringList.Create;
  L1:=TStringList.Create;
  L.Assign(C700SelAnagrafe.SQL);
  L1.Assign(C700FSelezioneAnagrafe.SQLCreato);
  VarODS:=TOracleDataSet.Create(nil);
  for i:=0 to C700SelAnagrafe.VariableCount - 1 do
  begin
    VarODS.DeclareVariable(C700SelAnagrafe.VariableName(i),C700SelAnagrafe.VariableType(i));
    VarODS.SetVariable(C700SelAnagrafe.VariableName(i),C700SelAnagrafe.GetVariable(i));
  end;
  P:=C700Progressivo;
  if C700DatiSelezionati = '' then
    C700DatiSelezionati:=C700CampiBase;
  C700DatiSelezionati:=C700CompletaDatiSelezionati;
  if C700DataLavoro <> C700FSelezioneAnagrafe.DataLavoro then
    C700FSelezioneAnagrafe.DataLavoro:=C700DataLavoro;
  if C700DataDal <> C700FSelezioneAnagrafe.DataDal then
    C700FSelezioneAnagrafe.DataDal:=C700DataDal;
  //C700FSelezioneAnagrafe.chkEsterni.Enabled:=not C700SoloPersonaleInterno;
  //C700FSelezioneAnagrafe.grpSelezionePeriodica.Enabled:=C700SelezionePeriodica;
  if C700FSelezioneAnagrafe.grpSelezionePeriodica.Enabled then
    C700FSelezioneAnagrafe.grpSelezionePeriodica.Caption:='Periodo considerato'
  else
    C700FSelezioneAnagrafe.grpSelezionePeriodica.Caption:='Periodo considerato (' + DateToStr(C700DataLavoro) + ')';
  C700FSelezioneAnagrafe.TVAzienda.OnChange:=nil;
  Result:=C700FSelezioneAnagrafe.ShowModal;
  if Result <> mrOK then
  begin
    C700SelAnagrafe.SQL.Assign(L);
    C700FSelezioneAnagrafe.SQLCreato.Assign(L1);
    C700SelAnagrafe.CloseAll;
    C700SelAnagrafe.DeleteVariables;
    for i:=0 to VarODS.VariableCount - 1 do
    begin
      C700SelAnagrafe.DeclareVariable(VarODS.VariableName(i),VarODS.VariableType(i));
      C700SelAnagrafe.SetVariable(VarODS.VariableName(i),VarODS.GetVariable(i));
    end;
    if (L.Text <> '') and C700FSelezioneAnagrafe.OpenC700SelAnagrafe then
    begin
      C700SelAnagrafe.Open;
      C700SelAnagrafe.SearchRecord('PROGRESSIVO',P,[srFromBeginning]);
    end;
  end
  else
    C700FSelezioneAnagrafe.PulisciVecchiaSelezione:=False;
  FreeAndNil(L);
  FreeAndNIl(VarODS);
end;

function C700GetDatiVisualizzati:String;
var i:Integer;
    b:Boolean;
begin
  Result:='';
  with TStringList.Create do
  try
    CommaText:=C700DatiVisualizzati;
    b:=False;
    for i:=0 to Count - 1 do
    begin
      if Result <> '' then
        Result:=Result + ' ';
      if ((Strings[i] = 'T430BADGE') or (Strings[i] = 'MATRICOLA')) and ((i = 0) or ((i = 1) and b)) then
      begin
        Result:=Result + Format('%-8s',[C700SelAnagrafe.FieldByName(Strings[i]).AsString]);
        b:=True;
      end
      else
        Result:=Result + C700SelAnagrafe.FieldByName(Strings[i]).AsString;
    end;
  finally
    Free;
  end;
end;

procedure C700Distruzione;
{Distruzione delle Forms}
begin
  if C700FSelezioneAnagrafe <> nil then
  begin
    FreeAndNil(C700SrcAnagrafe);
    FreeAndNil(C700FSelezioneAnagrafeDtM);
    FreeAndNil(C700FSelezioneAnagrafe);
  end;
end;
*)

function TC600FSelezioneAnagrafe.IsCampoCaseInsensitive(Campo: String): Boolean;
{ Determina se un campo deve essere trattato in modo
  da non considerare differenza fra maiuscole e minuscole. }
{
var
  NomeCampo: String;
  i: Integer;
}
  begin
  // gestione commentata per il momento
  {
  i:=Pos('.',Campo);
  NomeCampo:=Copy(Campo,i + 1,Length(Campo) - i);
  Result:=(NomeCampo = 'COGNOME');
  }
  Result:=False;
end;

procedure TC600FSelezioneAnagrafe.FormCreate(Sender: TObject);
begin
  Componenti:=TList.Create;
  ListSQL:=TStringList.Create;
  ListSQLPeriodico:=TStringList.Create;
  SQLCreato:=TStringList.Create;
  CorpoSQL:=TStringList.Create;
  VecchioNodo:=0;
  actEliminaSelezione.Enabled:=Parametri.C700_SalvaSelezioni = 'S';
  actSalvaSelezione.Enabled:=Parametri.C700_SalvaSelezioni <> 'N';
end;

procedure TC600FSelezioneAnagrafe.PulisciListe;
var i:Integer;
begin
  for i:=Componenti.Count - 1 downto 0 do
    begin
    PSelezione(Componenti.Items[i]).TotValori.Free;
    PSelezione(Componenti.Items[i]).SelValori.Free;
    Dispose(PSelezione(Componenti.Items[i]));
    Componenti.Delete(i);
    end;
  CBDaValore.Items.Clear;
  CBAValore.Items.Clear;
  CBValori.Items.Clear;
end;

procedure TC600FSelezioneAnagrafe.TVAziendaChange(Sender: TObject;
  Node: TTreeNode);
{Carico i dati dalla List Box se sono già registrati in memoria}
var I:Integer;
begin
  GestioneVecchioNodo;
  I:=Node.Index;
  VecchioNodo:=i;
  CBValori.Items.Clear;
  //Da Valore e A Valore li carico comunque poichè li posso inserire manualmente
  CBDaValore.Text:=PSelezione(Componenti.Items[I]).DaValore;
  CBAValore.Text:=PSelezione(Componenti.Items[I]).AValore;
  //Carico i dati del nuovo nodo
  if PSelezione(Componenti.Items[I]).Esistente then
    begin
    CBValori.Items.Assign(PSelezione(Componenti.Items[I]).TotValori);
    CBDaValore.Items.Assign(PSelezione(Componenti.Items[I]).TotValori);
    CBAValore.Items.Assign(PSelezione(Componenti.Items[I]).TotValori);
    GetCheck(PSelezione(Componenti.Items[I]).SelValori);
    end;
  CBValori.Enabled:=PSelezione(Componenti.Items[I]).Esistente;
end;

procedure TC600FSelezioneAnagrafe.GestioneVecchioNodo;
{Memorizzo le selezioni del vecchio nodo e gestisco l'ordinamento per questa colonna}
var Old_Da,Old_A,Old_In:String;
begin
  if (VecchioNodo < 0) or (VecchioNodo >= TVAzienda.Items.Count) then exit;
  Old_Da:=PSelezione(Componenti.Items[VecchioNodo]).DaValore;
  Old_A:=PSelezione(Componenti.Items[VecchioNodo]).AValore;
  Old_In:=PSelezione(Componenti.Items[VecchioNodo]).SelValori.Text;
  //Memorizzo i dati del nodo precedente
  PSelezione(Componenti.Items[VecchioNodo]).DaValore:=CBDaValore.Text;
  PSelezione(Componenti.Items[VecchioNodo]).AValore:=CBAValore.Text;
  //CheckListBox
  if PSelezione(Componenti.Items[VecchioNodo]).Esistente then
    PutCheck(PSelezione(Componenti.Items[VecchioNodo]).SelValori);
  //Verifico se ci sono dei cambiamenti nella selezione per annullare eventualmente quella manuale
  if (Old_Da <> CBDaValore.Text) or (Old_A <> CBAValore.Text) or (Old_In <> PSelezione(Componenti.Items[VecchioNodo]).SelValori.Text) then
  begin
    SQLCreato.Clear;
    cmbSelezione.Text:='';  //Alberto 14/06/2006
  end;
  if (Trim(CBDaValore.Text) <> '') or (Trim(CBAValore.Text) <> '') or
     (PSelezione(Componenti.Items[VecchioNodo]).SelValori.Count > 0) then
  begin
    //Se sono specificati dei dati significativi annullo la selezione manuale e
    //riporto il dato in ordinamento
    if LBOrdinamento.Items.IndexOf(TVAzienda.Items[VecchioNodo].Text) = -1 then
       LBOrdinamento.Items.Add(TVAzienda.Items[VecchioNodo].Text);
  end;
end;

procedure TC600FSelezioneAnagrafe.TVAziendaDblClick(Sender: TObject);
{Selezione di una colonna}
var I:Integer;
begin
  if TVAzienda.Selected = nil then exit;
  I:=TVAzienda.Selected.Index;
  VecchioNodo:=I;
  if not PSelezione(Componenti.Items[i]).Esistente then
    //Costruisco la query per estrarre la colonna richiesta
    with C600FSelezioneAnagrafeDtM.selDistinct do
    begin
      Screen.Cursor:=crHourGlass;
      CBDaValore.Text:='';
      CBAValore.Text:='';
      Close;
      QueryDinamica(0);
      try
        Open;
      except
        actGenerazioneSelezioneExecute(nil);
        QueryDinamica(0);
        Open;
      end;
      //Riempo la lista con i dati della tabella
      PSelezione(Componenti.Items[I]).TotValori.Clear;
      PSelezione(Componenti.Items[I]).TotValori.BeginUpdate;
      while not Eof do
      begin
        PSelezione(Componenti.Items[I]).TotValori.Add(Fields[0].AsString);
        Next;
      end;
      PSelezione(Componenti.Items[I]).TotValori.EndUpdate;
      CBValori.Items.Assign(PSelezione(Componenti.Items[I]).TotValori);
      CBDaValore.Items.Assign(CBValori.Items);
      CBAValore.Items.Assign(CBValori.Items);
      PSelezione(Componenti.Items[i]).Esistente:=True;
      CBDaValore.Text:=PSelezione(Componenti.Items[I]).DaValore;
      CBAValore.Text:=PSelezione(Componenti.Items[I]).AValore;
      GetCheck(PSelezione(Componenti.Items[I]).SelValori);
      CBDaValore.Enabled:=True;
      CBAValore.Enabled:=True;
      CBValori.Enabled:=True;
      Screen.Cursor:=crDefault;
   end;
end;

procedure TC600FSelezioneAnagrafe.QueryDinamica(Modo:Byte);
var i:Integer;
    S,Filtro,OrderBy:String;
    Q:TOracleDataSet;
  function GetHintT030V430:String;
  begin
    Result:=IfThen(chkCessati.Checked,Parametri.CampiRiferimento.C26_HintT030V430,Parametri.CampiRiferimento.C26_HintT030V430_NC);
  end;
  function GetHintT030V430NoTag:String;
  begin
    Result:=StringReplace(StringReplace(GetHintT030V430,'/*+','',[]),'*/','',[]);
  end;
begin
  Q:=C600FSelezioneAnagrafeDtM.selDistinct;
  CorpoSQL.Clear;
  //Colonne restituite dalla select
  case Modo of
    0:begin
        S:='DISTINCT ' + Parametri.ColonneStruttura.Values[TVAzienda.Selected.Text];  //Selezione di una colonna specifica
        Q:=C600FSelezioneAnagrafeDtM.selDistinct;
      end;
    1:begin
        S:='MATRICOLA,COGNOME,NOME,T430BADGE,T430INIZIO,T430FINE,PROGRESSIVO';//Dati anagrafici di base
        Q:=C600FSelezioneAnagrafeDtM.selAnagrafe;
        //Q:=C700FSelezioneAnagrafeDtM.selAnagrafePreview;
      end;
    2:begin
        S:=C600DatiSelezionati;    //Dati anagrafici richiesti
        Q:=C600FSelezioneAnagrafeDtM.selAnagrafe;
      end;
  end;
  with Q do
  begin
    CloseAll;
    //Gestione Query periodica
    if grpSelezionePeriodica.Enabled and (grpSelezionePeriodica.ItemIndex = 1) then
    begin
      SQL.Assign(ListSQLPeriodico);
      SQL.Delete(0);
      SQL.Insert(0,Format('SELECT %s %s FROM',[GetHintT030V430,S]));
      SQL.Text:=StringReplace(SQL.Text,'HintT030V430',GetHintT030V430NoTag,[rfIgnoreCase,rfReplaceAll]);
      CorpoSQL.Assign(ListSQLPeriodico);
      CorpoSQL.Delete(0);
      CorpoSQL.Text:=StringReplace(CorpoSQL.Text,'HintT030V430',GetHintT030V430NoTag,[rfIgnoreCase,rfReplaceAll]);
      Filtro:='';
      OrderBy:='';
      //Filtro sui soli dipendenti in servizio
      if (*(Modo > 0) and*) (not chkCessati.Checked) then
        //Filtro:=Filtro + 'AND EXISTS (SELECT ''X'' FROM T430_STORICO WHERE PROGRESSIVO = T430PROGRESSIVO AND :DATALAVORO >= T430INIZIO AND :C700DATADAL <= NVL(T430FINE,:DATALAVORO))' + #13#10;
        Filtro:=Filtro + 'AND :DATALAVORO >= T430INIZIO AND :C700DATADAL <= NVL(T430FINE,:DATALAVORO)' + #13#10;
      //Alberto: solo personale interno
      if (not chkEsterni.Visible) or (not chkEsterni.Checked) then
        Filtro:=Filtro + 'AND T030.TIPO_PERSONALE = ''I''' + #13#10;
      if Singolodipendente1.Checked then
        Filtro:=Filtro + 'AND T030.PROGRESSIVO = ' + IntToStr(C600FSelezioneAnagrafeDtM.C600Progressivo) + #13#10;
      with SQLCreato do
        for i:=0 to Count - 1 do
          if Pos('ORDER BY',Strings[i]) = 0 then
          begin
            if i = 0 then
              Filtro:=Filtro + 'AND' + #13#10;
            Filtro:=Filtro + Strings[i] + #13#10;
          end
          else if Modo > 0 then
            OrderBy:=OrderBy + Strings[i] + #13#10
          else Break;
      if OrderBy <> '' then
        SQL.Add(OrderBy);
      DeleteVariables;
      DeclareVariable('DATALAVORO',otDate);
      DeclareVariable('C700DATADAL',otDate);
      DeclareVariable('C700FILTRO',otSubst);
      SetVariable('DATALAVORO',DataLavoro);
      SetVariable('C700DATADAL',DataDal);
      SetVariable('C700FILTRO',Filtro);
      exit;
    end;
    SQL.Assign(ListSQL);
    SQL.Delete(0);
    SQL.Insert(0,Format('SELECT %s %s FROM',[IfThen(chkCessati.Checked,Parametri.CampiRiferimento.C26_HintT030V430,Parametri.CampiRiferimento.C26_HintT030V430_NC),S]));
    CorpoSQL.Assign(ListSQL);
    CorpoSQL.Delete(0);
    (*//Alberto 4/4/2006: Gestione del personale interno
    if SoloPersonaleInterno then
    begin
      S:='AND T030.TIPO_PERSONALE = ''I''';
      SQL.Add(S);
      CorpoSQL.Add(S);
    end;*)
    //Filtro sui soli dipendenti in servizio
    if (*(Modo > 0) and*) (not chkCessati.Checked) then
    begin
      //S:='AND EXISTS (SELECT ''X'' FROM T430_STORICO WHERE PROGRESSIVO = T430PROGRESSIVO AND :DataLavoro BETWEEN T430INIZIO AND NVL(T430FINE,:DataLavoro))';
      S:='AND :DATALAVORO BETWEEN T430INIZIO AND NVL(T430FINE,:DATALAVORO)';
      SQL.Add(S);
      CorpoSQL.Add(S);
    end;
    //Alberto: solo personale interno
    if (not chkEsterni.Visible) or (not chkEsterni.Checked) then
    begin
      S:='AND T030.TIPO_PERSONALE = ''I''';
      SQL.Add(S);
      CorpoSQL.Add(S);
    end;
    if Singolodipendente1.Checked then
    begin
      S:='AND T030.PROGRESSIVO = ' + IntToStr(C600FSelezioneAnagrafeDtM.C600Progressivo);
      SQL.Add(S);
      CorpoSQL.Add(S);
    end;
    with SQLCreato do
      for i:=0 to Count - 1 do
        if Pos('ORDER BY',UpperCase(Trim(Strings[i]))) <> 1 then
        begin
          if i = 0 then
          begin
            SQL.Add('AND');
            CorpoSQL.Add('AND');
          end;
          SQL.Add(Strings[i]);
          CorpoSQL.Add(Strings[i]);
        end
        else if Modo > 0 then SQL.Add(Strings[i])
        else Break;
    if Modo = 0 then
      SQL.Add('ORDER BY ' + Parametri.ColonneStruttura.Values[TVAzienda.Selected.Text]);
    DeleteVariables;
    DeclareVariable('DATALAVORO',otDate);
    SetVariable('DATALAVORO',DataLavoro);
  end;
end;

procedure TC600FSelezioneAnagrafe.Ricercatestocontenuto1Click(Sender: TObject);
var TN:TTreeNode;
begin
  if TVAzienda.Selected = nil then
    exit;
  TVAziendaSearch:=Trim(InputBox('Ricerca per testo contenuto','Nome dato',TVAziendaSearch));
  TN:=TVAzienda.Items[0];
  while TN <> nil do
  begin
    TN:=TN.getNextSibling;
    if (TN <> nil) and (Pos(UpperCase(TVAziendaSearch),UpperCase(TN.Text)) > 0 ) then
    begin
      TVAzienda.Select(TN,[]);
      Break;
    end;
  end;
end;

procedure TC600FSelezioneAnagrafe.Successivo1Click(Sender: TObject);
var TN:TTreeNode;
begin
  if TVAzienda.Selected = nil then
    exit;
  if TVAziendaSearch = '' then
  begin
    Ricercatestocontenuto1Click(nil);
    exit;
  end;
  TN:=TVAzienda.Selected;
  while TN <> nil do
  begin
    TN:=TN.getNextSibling;
    if (TN <> nil) and (Pos(UpperCase(TVAziendaSearch),UpperCase(TN.Text)) > 0 ) then
    begin
      TVAzienda.Select(TN,[]);
      Break;
    end;
  end;
end;

procedure TC600FSelezioneAnagrafe.GetCheck(Source:TStringList);
{Leggo gli Items di Source e li Checko in CBValori}
var i,j:Integer;
begin
  for i:=0 to Source.Count - 1 do
  begin
    j:=CBValori.Items.IndexOf(Source[i]);
    if j > -1 then
      CBValori.Checked[j]:=True;
  end;
end;

procedure TC600FSelezioneAnagrafe.PutCheck(Dest:TStringList);
{Salvo gli Items Checkati in SelValori}
var i:Integer;
begin
  Dest.Clear;
  for i:=0 to CBValori.Items.Count - 1 do
    if CBValori.Checked[i] then
      Dest.Add(CBValori.Items[i]);
end;

procedure TC600FSelezioneAnagrafe.TVAziendaExit(Sender: TObject);
{Gestione dati selezionati in uscita dal TreeView}
begin
  BitBtn1.Default:=True;
  BitBtn3.Cancel:=True;
  GestioneVecchioNodo;
end;

procedure TC600FSelezioneAnagrafe.LBOrdinamentoDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if Source = TVAzienda then
    //Drag&Drop da TreeView
    Accept:=LBOrdinamento.Items.IndexOf((Source as TTreeView).Selected.Text) = -1
  else
    if Source = Sender then
      //Drag&Drop da sè stesso per spostamento Items
      Accept:=True;
end;

procedure TC600FSelezioneAnagrafe.LBOrdinamentoDragDrop(Sender, Source: TObject;
  X, Y: Integer);
{Inserimento Campo di ordinamento}
var i:Integer;
    Punto:TPoint;
begin
  Punto.X:=X;
  Punto.Y:=Y;
  i:=LBOrdinamento.ItemAtPos(Punto,True);
  if Source = TVAzienda then
    //Inserimento da TVAzienda
    begin
    if i = -1 then
      LBOrdinamento.Items.Add((Source as TTreeView).Selected.Text)
    else
      LBOrdinamento.Items.Insert(i,(Source as TTreeView).Selected.Text)
    end
  else
    if (Source = Sender) and (i > -1) then
      //Spostamento Campo di ordinamento
      LBOrdinamento.Items.Move(LBOrdinamento.itemIndex,i);
  //Alberto 14/06/2006
  SQLCreato.Clear;
  cmbSelezione.Text:='';
end;

procedure TC600FSelezioneAnagrafe.LBOrdinamentoDblClick(Sender: TObject);
{Cancellazione Campo di ordinamento}
begin
  LBOrdinamento.Items.Delete(LBOrdinamento.ItemIndex);
  //Alberto 14/06/2006
  SQLCreato.Clear;
  cmbSelezione.Text:='';
end;

procedure TC600FSelezioneAnagrafe.actGenerazioneSelezioneExecute(Sender: TObject);
{Generazione SQL}
var i,P:Integer;
    Da,A,Oppure,Ordina,VecchioMemo,Campo1,Valore1,Valore2:String;
begin
  GestioneVecchioNodo;
  //Memorizzo la vecchia selezione e tolgo la parte ORDER BY
  VecchioMemo:=SQLCreato.Text;
  i:=Pos('ORDER BY',VecchioMemo);
  if i > 0 then
    VecchioMemo:=Copy(VecchioMemo,1,i - 1);
  SQLCreato.Clear;
  for i:=0 to TVAzienda.Items.Count - 1 do
    begin
    //Costruzione CAMPO1 >= ... AND CAMPO1 <= ...
    Da:='';
    A:='';
    Oppure:='';
    //Imposto il prefisso della tabella prima del campo
    Campo1:=PrefissoTabella(Parametri.ColonneStruttura.Values[TVAzienda.Items[i].Text]);
    Valore1:=PSelezione(Componenti.Items[i]).DaValore;
    Valore2:=PSelezione(Componenti.Items[i]).AValore;
    P:=Parametri.ColonneStruttura.IndexOfName(TVAzienda.Items[i].Text);
    if (Valore1 <> '') and (Valore2 <> '') then
    begin
      if Valore1 = Valore2 then
      begin
        if Pos('%',Valore1) = 0 then
          Da:=FormatoCampo(Campo1) + ' = ' + FormatoValore(Campo1,Valore1,TFieldType(StrToInt(Parametri.TipiStruttura[P])))
        else
          Da:=FormatoCampo(Campo1) + ' LIKE ' + FormatoValore(Campo1,Valore1,TFieldType(StrToInt(Parametri.TipiStruttura[P])));
      end
      else
        Da:=Format('%s BETWEEN %s AND %s',[FormatoCampo(Campo1),FormatoValore(Campo1,Valore1,TFieldType(StrToint(Parametri.TipiStruttura[P]))),FormatoValore(Campo1,Valore2,TFieldType(StrToInt(Parametri.TipiStruttura[P])))])
    end
    else
    begin
      if Valore1 <> '' then
        Da:=FormatoCampo(Campo1) + ' >= ' + FormatoValore(Campo1,Valore1,TFieldType(StrToint(Parametri.TipiStruttura[P])));
      if Valore2 <> '' then
        A:=FormatoCampo(Campo1) + ' <= ' + FormatoValore(Campo1,Valore2,TFieldType(StrToint(Parametri.TipiStruttura[P])));
      if (Da <> '') and (A <> '') then
        Da:=Da + ' AND ';
      Da:=Da + A;
    end;
    if Da <> '' then Da:='(' + Da + ')';
    //Costruzione CAMPO1 = ... OR CAMPO1 = ... OR .....
    Oppure:=ValoriSelezionati(Campo1,PSelezione(Componenti.Items[i]).SelValori,TFieldType(StrToint(Parametri.TipiStruttura[P])));
    //if Oppure <> '' then Oppure:='(' + Oppure + ')';
    if (Da <> '') and (Oppure <> '') then
      Da:=Da + ' OR ';
    Da:=Da + Oppure;
    if Da <> '' then
      begin
      Da:='(' + Da + ')';
      if SQLCreato.Count > 0 then
        Da:=' AND ' + Da;
      SQLCreato.Add(Da);
      end;
    end;
  //Se è cambiata la selezione reimposto Esistente = False
  //per tutti i dati
  if VecchioMemo <> SQLCreato.Text then
    AggiornaSelezione;
  Ordina:='';
  for i:=0 to LBOrdinamento.Items.Count - 1 do
    Ordina:=Ordina + ', ' + PrefissoTabella(Parametri.ColonneStruttura.Values[LBOrdinamento.Items[i]]);
  if LBOrdinamento.Items.IndexOf('COGNOME') = -1 then
    Ordina:=Ordina + ', ' + PrefissoTabella('COGNOME');
  if LBOrdinamento.Items.IndexOf('NOME') = -1 then
    Ordina:=Ordina + ', ' + PrefissoTabella('NOME');
  if Ordina <> '' then
    SQLCreato.Add('ORDER BY ' + Copy(Ordina,3,Length(Ordina)));
  // split a 2000 caratteri per ogni riga di codice sql
  R180SplitLines(SQLCreato);    
end;

function TC600FSelezioneAnagrafe.PrefissoTabella(Campo:String):String;
{Cerca la tabella di cui fa parte Campo tra T030,T480,V430}
begin
  Result:=AliasTabella(Campo) + '.' + Campo;
end;

function TC600FSelezioneAnagrafe.FormatoCampo(Campo: String): String;
{ se il campo rientra nella lista di quelli da trattare come "case insensitive"
  utilizza il formato "UPPER(CAMPO)"
  altrimenti lascia il campo inalterato }
begin
  Result:=Campo;
  if IsCampoCaseInsensitive(Campo) then
    Result:='UPPER(' + Result + ')';
end;

function TC600FSelezioneAnagrafe.FormatoValore(Campo: String; Valore:String; Tipo:TFieldType):String;
{Formatta il valore inserendo gli apici se stringa,
 e trasformando la data in dd/mm/yyyy
 Inoltre valuta se considerare il campo case insensitive, utilizzando il formato
 "UPPER(campo)" (ha senso solo per i campi di tipo string) }
begin
  if Valore = '' then
    Result:=''''''
  else
  case Tipo of
    ftString:
    begin
      Result:='''' + AggiungiApice(Valore) + '''';
      if IsCampoCaseInsensitive(Campo) then
        Result:='UPPER(' + Result + ')';
    end;
    ftTime:
      Result:='''' + AggiungiApice(Valore) + '''';
    ftDate,ftDateTime:
      Result:='''' + FormatDateTime('dd/mm/yyyy',StrToDate(Valore)) + '''';
    else
      Result:=Valore;
  end;
end;

function TC600FSelezioneAnagrafe.ValoriSelezionati(Campo:String; Lista:TStringList; Tipo:TFieldType):String;
{ Gestione della lista con i valori per la costruzione
  della sintassi CAMPO1 IN (VALORE1, VALORE2,...) OR CAMPO1 IS NULL }
var i:Integer;
    Nullo:Boolean;
begin
  Result:='';
  Nullo:=False;
  
  // gestione della lista di valori
  for i:=0 to Lista.Count - 1 do
  begin
    if FormatoValore(Campo,Lista[i],Tipo) = '''''' then
      Nullo:=True
    else
    begin
      if i > 0 then  Result:=Result + ',';
      Result:=Result + FormatoValore(Campo,Lista[i],Tipo);
    end;
  end;
  if Result <> '' then
    Result:=FormatoCampo(Campo) + ' IN (' + Result + ')';

  // gestione del valore null
  if Nullo then
  begin
    if Result <> '' then
      Result:='(' + Result + ' OR ' + Campo + ' IS NULL' + ')'
    else
      Result:=Campo + ' IS NULL';
  end;
end;

procedure TC600FSelezioneAnagrafe.actModificaSelezioneExecute(Sender: TObject);
{Modifica istruzione SQL}
begin
  if SQLCreato.Count = 0 then
    actGenerazioneSelezioneExecute(nil);
  C700FSQL.Memo1.Lines.Assign(SQLCreato);
  if C700FSQL.ShowModal = mrOK then
  begin
    // split a 2000 caratteri per ogni riga di codice sql
    R180SplitLines(C700FSQL.Memo1.Lines);
    SQLCreato.Assign(C700FSQL.Memo1.Lines);
    actConfermaExecute(nil);
  end;
end;

procedure TC600FSelezioneAnagrafe.Panel1Exit(Sender: TObject);
begin
  GestioneVecchioNodo;
end;

procedure TC600FSelezioneAnagrafe.actAnnullaSelezioneExecute(Sender: TObject);
{Annullo tutti i parametri di selezione}
var i:Integer;
    //NL:Integer
begin
  //NL:=SQLCreato.Count;  //Numero di righe generate per SQL
  SQLCreato.Clear;
  if Sender = actAnnullaSelezione then
    cmbSelezione.Text:='';
  LBOrdinamento.Items.Clear;
  CBDaValore.Text:='';
  CBAValore.Text:='';
  for i:=0 to TVazienda.Items.Count - 1 do
  begin
    //if NL > 0 then  //Alberto 14/06/2006
      //se era stata generata un'istruzione, resetto il parametro...
      //...Esistente in modo da ripetere la Query
      PSelezione(Componenti.Items[i]).Esistente:=False;
    PSelezione(Componenti.Items[i]).DaValore:='';
    PSelezione(Componenti.Items[i]).AValore:='';
    PSelezione(Componenti.Items[i]).SelValori.Clear;
  end;
  if TVAzienda.Items.Count > 0 then
    TVAziendaChange(TVAzienda,TVAzienda.Items[TVAzienda.Selected.Index]);
  if Sender = actAnnullaSelezione then
    actConfermaExecute(actAnnullaSelezione);
end;

procedure TC600FSelezioneAnagrafe.AggiornaSelezione;
{Resetto Esistente = False per forzare la rigenerazione della Query}
var i:Integer;
begin
  for i:=0 to TVAzienda.Items.Count - 1 do
    PSelezione(Componenti.Items[i]).Esistente:=False;
  if TVAzienda.Items.Count > 0 then
    TVAziendaChange(TVAzienda,TVAzienda.Items[TVAzienda.Selected.Index]);
end;

procedure TC600FSelezioneAnagrafe.actConfermaExecute(Sender: TObject);
{Conferma della selezione e ritorno al chiamante}
var Modo:Byte;
    ProgressivoSelezionato:Integer;
    S:String;
begin
  ProgressivoSelezionato:=C600FSelezioneAnagrafeDtM.C600Progressivo;
  if Visible then
    cmbSelezione.SetFocus;
  //Imposto il flag  in modo da restituire le colonne volute
  if Sender = actConferma then
    Modo:=2  //Restituisco i campi specificati dal chiamante
  else
    Modo:=1;  //Restituisco C700CampiBase
  if (SQLCreato.Count = 0) (*or (Sender = actGenerazioneSelezione)*) then
    actGenerazioneSelezioneExecute(nil);
  QueryDinamica(Modo);
  try
    with TOracleQuery.Create(nil) do
    try
      Session:=C600FSelezioneAnagrafeDtM.selAnagrafe.Session;
      //DeclareVariable('DATALAVORO',otDate);
      //if Modo = 2 then
      begin
        Variables.Assign(C600FSelezioneAnagrafeDtM.selAnagrafe.Variables);
        SQL.Assign(C600FSelezioneAnagrafeDtM.selAnagrafe.SQL);
      end;
      (*else
      begin
        Variables.Assign(C700FSelezioneAnagrafeDtM.selAnagrafePreview.Variables);
        SQL.Assign(C700FSelezioneAnagrafeDtM.selAnagrafePreview.SQL);
      end;*)
      Describe;
    finally
      Free;
    end;
  except
    SQLCreato.Clear;
    actGenerazioneSelezioneExecute(nil);
  end;
  //Alberto 16/06/2006: se si preme 'Annulla selezione' si esegue l'anteprima vuota
  if Sender = actAnnullaSelezione then
  begin
    S:=C600FSelezioneAnagrafeDtM.selAnagrafe.SQL.Text;
    if Pos('ORDER BY',UpperCase(S)) > 0 then
    begin
      Insert(' AND T030.PROGRESSIVO = 0 ',S,Pos('ORDER BY',UpperCase(S)));
      C600FSelezioneAnagrafeDtM.selAnagrafe.SQL.Text:=S;
    end;
  end;
  if (Modo = 1) or OpenC600SelAnagrafe then
    try
      Screen.Cursor:=crHourGlass;
      C600FSelezioneAnagrafeDtM.selAnagrafe.Open
    finally
      Screen.Cursor:=crDefault;
    end
  else
  begin
    ModalResult:=mrOK;
    exit;
  end;
  if Sender = actConferma then
  begin
    //Esco dalla Form
    //C700Progressivo:=ProgressivoSelezionato
    //C700FSelezioneAnagrafeDtM.selAnagrafe.SearchRecord('Progressivo',C700Progressivo,[srFromBeginning]);
    C600FSelezioneAnagrafeDtM.selAnagrafe.SearchRecord('Progressivo',ProgressivoSelezionato,[srFromBeginning]);
    ModalResult:=mrOK;
  end
  else
  with C600FSelezioneAnagrafeDtM.selAnagrafe do
  //with C700FSelezioneAnagrafeDtM.selAnagrafePreview do
  begin
    try FieldByName('T430BADGE').DisplayLabel:='BADGE'; except end;
    try FieldByName('T430INIZIO').DisplayLabel:='INIZIO'; except end;
    try FieldByName('T430FINE').DisplayLabel:='FINE'; except end;
    try FieldByName('COGNOME').DisplayWidth:=15; except end;
    try FieldByName('NOME').DisplayWidth:=15; except end;
    try FieldByName('T430INIZIO').DisplayWidth:=10; except end;
    try FieldByName('T430FINE').DisplayWidth:=10; except end;
    StatusBar1.Panels[0].Text:=Format('%d Anagrafiche selezionate',[RecordCount]);
    //C700Progressivo:=FieldByName('Progressivo').AsInteger;
  end;
end;

procedure TC600FSelezioneAnagrafe.FormDestroy(Sender: TObject);
begin
  PulisciListe;
  Componenti.Free;
  ListSQL.Free;
  ListSQLPeriodico.Free;
  CorpoSQL.Free;
  //caratto 16/01/2015 memory leak fin dalle origini
  SqlCreato.Free;
  C600FSelezioneAnagrafeDtM.Free;
  C600FSelezioneAnagrafeDtM:=nil;
end;

procedure TC600FSelezioneAnagrafe.FormDeactivate(Sender: TObject);
begin
  WhereSql:=SQLCreato.Text;
end;

procedure TC600FSelezioneAnagrafe.CBAValoreEnter(Sender: TObject);
begin
  if CBAValore.Text = '' then
    CBAValore.Text:=CBDaValore.Text;
end;

procedure TC600FSelezioneAnagrafe.FormShow(Sender: TObject);
begin
  TVAzienda.OnChange:=TVAziendaChange;
  with C600FSelezioneAnagrafeDtM.selAnagrafe do
  begin
    if not Active then
    begin
      Screen.Cursor:=crHourGlass;
      try
        Open;
      finally
        Screen.Cursor:=crDefault;
      end;
      StatusBar1.Panels[0].Text:=Format('%d Anagrafiche selezionate',[RecordCount]);
    end;
    if RecordCount = 0 then
      PulisciVecchiaSelezione:=True;
    try FieldByName('T430BADGE').DisplayLabel:='BADGE'; except end;
    try FieldByName('T430INIZIO').DisplayLabel:='INIZIO'; except end;
    try FieldByName('T430FINE').DisplayLabel:='FINE'; except end;
    try FieldByName('COGNOME').DisplayWidth:=15; except end;
    try FieldByName('NOME').DisplayWidth:=15; except end;
    try FieldByName('T430INIZIO').DisplayWidth:=10; except end;
    try FieldByName('T430FINE').DisplayWidth:=10; except end;
  end;
  grpSelezionePeriodica.Items[0]:='al ' + FormatDateTime('dd/mm/yyyy',DataLavoro);
  grpSelezionePeriodica.Items[1]:='dal ' + FormatDateTime('dd/mm/yyyy',DataDal) + ' al ' + FormatDateTime('dd/mm/yyyy',DataLavoro);
  C700FSQL:=TC700FSQL.Create(nil);
  //dgrdAnteprima.DataSource:=C700FSelezioneAnagrafeDtM.dscAnagrafePreview;
  dgrdAnteprima.DataSource:=C600FSelezioneAnagrafeDtM.dscAnagrafe;
  if PulisciVecchiaSelezione then
    actAnnullaSelezioneExecute(nil);
end;

procedure TC600FSelezioneAnagrafe.actAnnullaExecute(Sender: TObject);
begin
  ModalResult:=mrAbort;
end;

procedure TC600FSelezioneAnagrafe.actApriSelezioneExecute(Sender: TObject);
begin
  if cmbSelezione.Items.IndexOf(cmbSelezione.Text) < 0 then
    raise Exception.Create('Specificare il nome della selezione');
  actAnnullaSelezioneExecute(nil);
  with C600FSelezioneAnagrafeDtM.selT003 do
  begin
    Close;
    SetVariable('Nome',cmbSelezione.Text);
    Open;
    if RecordCount = 0 then exit;
    SQLCreato.Clear;
    while not Eof do
    begin
      SQLCreato.Add(FieldByName('Riga').AsString);
      Next;
    end;
  end;
  actConfermaExecute(Sender);
end;

procedure TC600FSelezioneAnagrafe.actEliminaSelezioneExecute(Sender: TObject);
begin
  if cmbSelezione.Items.IndexOf(cmbSelezione.Text) < 0 then
    exit;
  if MessageDlg(Format('Eliminare la selezione ''%s''?',[cmbSelezione.Text]),mtConfirmation,[mbYes,mbNo],0) <> mrYes then
    exit;
  with C600FSelezioneAnagrafeDtM.delT003 do
  begin
    SetVariable('Nome',cmbSelezione.Text);
    Execute;
    DataBase.Commit;
  end;
  A000AggiornaFiltroDizionario('SELEZIONI ANAGRAFICHE',cmbSelezione.Text,'');
  cmbSelezione.Text:='';
  C600FSelezioneAnagrafeDtM.GetNomeSelezioni;
end;

procedure TC600FSelezioneAnagrafe.actSalvaSelezioneExecute(Sender: TObject);
var i:Integer;
    Trovato:Boolean;
begin
  if Trim(cmbSelezione.Text) = '' then
    raise Exception.Create('Specificare il nome della selezione');
  if SQLCreato.Count = 0 then
    actGenerazioneSelezioneExecute(nil);
  //Verifico esistenza della selezione da salvare direttamente sul dataset senza filtro per annullare eventuale filtro dizionario.
  with C600FSelezioneAnagrafeDtM.selT003Nome do
  try
    Filtered:=False;
    Open;
    Trovato:=SearchRecord('NOME',cmbSelezione.Text,[srFromBeginning]);
  finally
    Filtered:=True;
    Close;
  end;
  if Trovato then
    //non posso sovrascrivere, oppure la selezione non è visibile nel mio filtro dizionario
    if (Parametri.C700_SalvaSelezioni <> 'S') or (cmbSelezione.Items.IndexOf(cmbSelezione.Text) < 0) then
      raise Exception.Create(Format('Selezione ''%s'' già esistente: impossibile sovrascrivere!',[cmbSelezione.Text]))
    else if MessageDlg(Format('Selezione ''%s'' già esistente: sovrascrivere?',[cmbSelezione.Text]),mtConfirmation,[mbYes,mbNo],0) <> mrYes then
      exit;
  (*
  if cmbSelezione.Items.IndexOf(cmbSelezione.Text) >= 0 then
    if Parametri.C700_SalvaSelezioni <> 'S' then
      raise Exception.Create(Format('Selezione ''%s'' già esistente: impossibile sovrascrivere!',[cmbSelezione.Text]))
    else
      if MessageDlg(Format('Selezione ''%s'' già esistente: sovrascrivere?',[cmbSelezione.Text]),mtConfirmation,[mbYes,mbNo],0) <> mrYes then
        exit;
  *)
  with C600FSelezioneAnagrafeDtM.delT003 do
  begin
    SetVariable('Nome',cmbSelezione.Text);
    Execute;
  end;
  with C600FSelezioneAnagrafeDtM.insT003 do
  begin
    SetVariable('Nome',cmbSelezione.Text);
    for i:=0 to SQLCreato.Count - 1 do
      if Trim(SQLCreato[i]) <> '' then
      begin
        SetVariable('Posizione',i);
        SetVariable('Riga',Trim(SQLCreato[i]));
        Execute;
      end;
    DataBase.Commit;
    A000AggiornaFiltroDizionario('SELEZIONI ANAGRAFICHE','',cmbSelezione.Text);
  end;
  C600FSelezioneAnagrafeDtM.GetNomeSelezioni;
end;

procedure TC600FSelezioneAnagrafe.cmbSelezioneDblClick(Sender: TObject);
begin
  actApriSelezioneExecute(nil);
end;

procedure TC600FSelezioneAnagrafe.TVAziendaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    BitBtn1.Default:=True;
    BitBtn3.Cancel:=True;
  end;
  if Key = VK_F2 then
    TVAzienda.Selected.EditText;
end;

procedure TC600FSelezioneAnagrafe.TVAziendaEdited(Sender: TObject;
  Node: TTreeNode; var S: String);
{Ricerca dei dipendenti sul TreeView}
begin
  inherited;
  CBDaValore.Text:=S;
  CBAValore.Text:=S;
  S:=TreeNodeOrig;
  BitBtn1.Default:=True;
  BitBtn3.Cancel:=True;
  CBDaValore.SetFocus;
end;

procedure TC600FSelezioneAnagrafe.TVAziendaEditing(Sender: TObject;
  Node: TTreeNode; var AllowEdit: Boolean);
begin
  actAnnullaSelezioneExecute(nil);
  TreeNodeOrig:=Node.Text;
  BitBtn1.Default:=False;
  BitBtn3.Cancel:=False;
end;

procedure TC600FSelezioneAnagrafe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  C700FSQL.Free;
end;

procedure TC600FSelezioneAnagrafe.Singolodipendente1Click(Sender: TObject);
begin
  Singolodipendente1.Checked:=not Singolodipendente1.Checked;
  actConfermaExecute(nil);
end;

procedure TC600FSelezioneAnagrafe.mnuRicercaCompletaClick(Sender: TObject);
begin
  mnuRicercaCompleta.Checked:=not mnuRicercaCompleta.Checked;
  (*C700FSelezioneAnagrafeDtM.*)CaricaTVAzienda(mnuRicercaCompleta.Checked);
end;

procedure TC600FSelezioneAnagrafe.Splitter1Moved(Sender: TObject);
begin
  CBDaValore.Width:=Panel2.Width - 32;
  CBAValore.Width:=Panel2.Width - 32;
end;

procedure TC600FSelezioneAnagrafe.Annullatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to CBValori.Items.Count - 1 do
    CBValori.Checked[i]:=Sender = Selezionatutto1;
end;

procedure TC600FSelezioneAnagrafe.CaricaTVAzienda(Completa:Boolean);
var j:Integer;
    P:PSelezione;
    S:String;
begin
  with C600FSelezioneAnagrafeDtM do
  begin
    PulisciListe;
    TVAzienda.OnChange:=nil;
    TVAzienda.Items.BeginUpdate;
    TVAzienda.Items.Clear;
    QCols.SetVariable('APPLICAZIONE',Parametri.Applicazione);
    QCols.Open;
    QCols.First;
    while not QCols.Eof do
    begin
      if Completa or ((not QCols.FieldByName('RICERCA').IsNull) and (QCols.FieldByName('RICERCA').AsInteger >= 0)) then
      begin
        S:=QCols.FieldByName('NOME_CAMPO').AsString;
        if Copy(S,1,6) = 'T430D_' then
          S:=Copy(S,7,Length(S))
        else if Copy(S,1,4) = 'T430' then
          S:=Copy(S,5,Length(S));
        if (Copy(S,1,4) = 'P430') or (S = 'PROGRESSIVO') or
           ((selbT033.RecordCount = 0) or
            (selbT033.SearchRecord('CAMPODB',VarArrayOf([S]),[srFromBeginning]))) then
        begin
          TVAzienda.Items.Add(nil,QCols.FieldByName('NOME_LOGICO').AsString);
          New(P);
          j:=Componenti.Add(P);
          PSelezione(Componenti.Items[j]).DaValore:='';
          PSelezione(Componenti.Items[j]).AValore:='';
          PSelezione(Componenti.Items[j]).TotValori:=TStringList.Create;
          PSelezione(Componenti.Items[j]).SelValori:=TStringList.Create;
          PSelezione(Componenti.Items[j]).Esistente:=False;
        end;
      end;
      QCols.Next;
    end;
    TVAzienda.Items.EndUpdate;
    TVAzienda.OnChange:=TVAziendaChange;
    if TVAzienda.Items.Count > 0 then
      TVAzienda.Selected:=TVAzienda.Items[0];
    QCols.Close;
  end;
end;

end.
