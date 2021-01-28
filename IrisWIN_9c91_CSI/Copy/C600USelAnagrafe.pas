unit C600USelAnagrafe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, ExtCtrls, ComCtrls, DB, Oracle, OracleData, Variants,
  A000UInterfaccia, C001URicerca, C004UParamForm, C005UDatiAnagrafici,
  C600USelezioneAnagrafe, C600USelezioneAnagrafeDtM, System.UITypes;

type
  TCambiaProgressivo = procedure of object;
  TC600frmSelAnagrafe = class(TFrame)
    pnlSelAnagrafe: TPanel;
    btnPrimo: TSpeedButton;
    btnPrecedente: TSpeedButton;
    btnSuccessivo: TSpeedButton;
    btnUltimo: TSpeedButton;
    lblDipendente: TLabel;
    btnSelezione: TBitBtn;
    btnRicerca: TBitBtn;
    pmnuDatiAnagrafici: TPopupMenu;
    R003Datianagrafici: TMenuItem;
    Ereditaselezioneprecedente1: TMenuItem;
    btnEreditaSelezione: TBitBtn;
    procedure btnSelezioneClick(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure btnRicercaClick(Sender: TObject);
    procedure R003DatianagraficiClick(Sender: TObject);
    procedure btnEreditaSelezioneClick(Sender: TObject);
  private
    { Private declarations }
    FElaborazioneInterrompibile:Boolean;
    FSoloPersonaleInterno:Boolean;
    FSelezionePeriodica:Boolean;
    OldC004Prog,OldC004Utente:String;
    //C700FSelezioneAnagrafeDtM:TC700FSelezioneAnagrafeDtM;
    function GetC600Progressivo:Integer;
    procedure SetC600Progressivo(Value:Integer);
    procedure SetElaborazioneInterrompibile(Value:Boolean);
    procedure SetSelezionePeriodica(Value:Boolean);
    procedure SetSoloPersonaleInterno(Value:Boolean);
  public
    { Public declarations }
    sbarSelAnagrafe:TStatusBar;
    PanelNum:Word;
    OnCambiaProgressivo:TCambiaProgressivo;
    OldSelAnagrafe,OldCorpoSQL,OldSQLCreato:TStringList;
    OldC600Progressivo:Integer;
    OldC600SelAnagrafeBridge:TC600SelAnagrafeBridge;
    OldOpenC600SelAnagrafe:Boolean;
    ElaborazioneInterrotta:Boolean;
    C600ModalResult:TModalResult;
    //ex-Variabili globali C700
    C600FSelezioneAnagrafe:TC600FSelezioneAnagrafe;
    C600SelAnagrafe:TOracleDataSet;
    C600SrcAnagrafe:TDataSource;  //Usato solamente in C001UFiltroTabelle quando chiama A002UInterfacciaSt
    (*C600Progressivo,*)C600OldProgressivo:LongInt;
    C600DatiVisualizzati,(*C600DatiSelezionati,*)OldC600DatiVisualizzati,OldC600DatiSelezionati:String;
    C600DataLavoro,C600DataDal,OldC600DataLavoro,OldC600DataDal:TDateTime;
    C600SelAnagrafeBridge:TC600SelAnagrafeBridge;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreaSelAnagrafe(Sessione:TOracleSession; sb:TStatusBar; Panel:Word; AbilitaBrowse:Boolean);
    procedure DistruggiSelAnagrafe;
    procedure SalvaC00SelAnagrafe;
    procedure SalvaC600SelAnagrafeBridge;
    procedure RipristinaC00SelAnagrafe;
    procedure RipristinaC600SelAnagrafeBridge;
    procedure SelezionaProgressivo(Progressivo:Integer);
    procedure NumRecords;
    procedure VisualizzaDipendente;
    function SettaPeriodoSelAnagrafe(DataDal,DataLavoro:TDateTime):Boolean;
    function GetCampiAbilitatiC600:String;
    function GetC600SelAnagrafeOrderBy:String;
    procedure PutC600SelAnagrafeOrderBy(Campo:String);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    //ex-Procedure globali C700
    procedure C600Creazione(Db:TOracleSession);
    procedure C600Distruzione;
    procedure C600MergeSelAnagrafe(ODS:TComponent; RicreaVariabili:Boolean = False);
    function C600MergeSettaPeriodo(ODS:TComponent; DataDal,DataLavoro:TDateTime):Boolean;
    function C600SelezionaAnagrafe:TModalResult;
    function C600GetDatiVisualizzati:String;
    function C600CompletaDatiSelezionati:String;

    property C600Progressivo:Integer read GetC600Progressivo write SetC600Progressivo;
    property ElaborazioneInterrompibile:Boolean read FElaborazioneInterrompibile write SetElaborazioneInterrompibile;
    property SelezionePeriodica:Boolean read FSelezionePeriodica write SetSelezionePeriodica;
    property SoloPersonaleInterno:Boolean read FSoloPersonaleInterno write SetSoloPersonaleInterno;
  end;

implementation

{$R *.DFM}

constructor TC600frmSelAnagrafe.Create(AOwner: TComponent);
begin
  inherited;
  FSelezionePeriodica:=False;
  FSoloPersonaleInterno:=True;
end;

destructor TC600frmSelAnagrafe.Destroy;
begin
  inherited;
  if C600FSelezioneAnagrafe <> nil then
    FreeAndNil(C600FSelezioneAnagrafe);
end;

procedure TC600frmSelAnagrafe.CreaSelAnagrafe(Sessione:TOracleSession; sb:TStatusBar; Panel:Word; AbilitaBrowse:Boolean);
begin
  //if C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM <> nil then
  //  exit;
  OldSelAnagrafe:=TStringList.Create;
  OldCorpoSQL:=TStringList.Create;
  OldSQLCreato:=TStringList.Create;
  sbarSelAnagrafe:=sb;
  PanelNum:=Panel;
  btnRicerca.Visible:=AbilitaBrowse;
  btnPrimo.Visible:=AbilitaBrowse;
  btnPrecedente.Visible:=AbilitaBrowse;
  btnSuccessivo.Visible:=AbilitaBrowse;
  btnUltimo.Visible:=AbilitaBrowse;
  R003Datianagrafici.Visible:=AbilitaBrowse;
  Ereditaselezioneprecedente1.Visible:=False;
  btnEreditaSelezione.Visible:=(Trim(C600SelAnagrafeBridge.SQLCreato) <> '') and (UpperCase(Trim(C600SelAnagrafeBridge.SQLCreato)) <> 'T030.PROGRESSIVO = 0');
  if not AbilitaBrowse then
    lblDipendente.Left:=btnRicerca.Left;
  C600OldProgressivo:=-1;
  C600Creazione(Sessione);
  SetSelezionePeriodica(FSelezionePeriodica);
  SetSoloPersonaleInterno(FSoloPersonaleInterno);
  //Alberto
  (*if C700SelAnagrafeBridge.SQLCreato <> '' then
    RipristinaC700SelAnagrafeBridge
  else*)
    C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.OpenSelAnagrafe;
  NumRecords;
  VisualizzaDipendente;
  lblDipendente.Hint:=StringReplace(C600DatiVisualizzati,'T430','',[rfReplaceAll]);
  if @OnCambiaProgressivo <> nil then
    OnCambiaProgressivo;
  C600OldProgressivo:=C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.C600Progressivo;
end;

procedure TC600frmSelAnagrafe.NumRecords;
begin
  if sbarSelAnagrafe <> nil then
  begin
    if ElaborazioneInterrompibile then
      sbarSelAnagrafe.Panels[PanelNum].Text:=Format('Anagr. %d/%d - Esc per interrompere',[C600SelAnagrafe.RecNo,C600SelAnagrafe.RecordCount])
    else
      sbarSelAnagrafe.Panels[PanelNum].Text:=Format('Anagr. %d/%d',[C600SelAnagrafe.RecNo,C600SelAnagrafe.RecordCount]);
    sbarSelAnagrafe.Repaint;
  end;
end;

procedure TC600frmSelAnagrafe.VisualizzaDipendente;
begin
  NumRecords;
  lblDipendente.Caption:=C600GetDatiVisualizzati;
  pnlSelAnagrafe.Repaint;
end;

procedure TC600frmSelAnagrafe.SalvaC00SelAnagrafe;
begin
  OldSelAnagrafe.Assign(C600SelAnagrafe.SQL);
  OldSQLCreato.Assign(C600FSelezioneAnagrafe.SQLCreato);
  OldCorpoSQL.Assign(C600FSelezioneAnagrafe.CorpoSQL);
  OldC600Progressivo:=C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.C600Progressivo;
  OldOpenC600SelAnagrafe:=C600FSelezioneAnagrafe.OpenC600SelAnagrafe;
  OldC600DatiSelezionati:=C600FSelezioneAnagrafe.C600DatiSelezionati;
  OldC600DatiVisualizzati:=C600DatiVisualizzati;
  OldC600DataLavoro:=C600DataLavoro;
  OldC600Datadal:=C600DataDal;
  SalvaC600SelAnagrafeBridge;
  //Gestione C004
  OldC004Prog:='';
  OldC004Utente:='';
  if C004FParamForm <> nil then
  try
    OldC004Prog:=VarToStr(C004FParamForm.selT001.GetVariable('PROG'));
    OldC004Utente:=VarToStr(C004FParamForm.selT001.GetVariable('UTENTE'));
    FreeAndNIl(C004FParamForm);
  except
  end;
end;

procedure TC600frmSelAnagrafe.SalvaC600SelAnagrafeBridge;
begin
  //(*
  OldC600SelAnagrafeBridge:=C600SelAnagrafeBridge;
  C600SelAnagrafeBridge.SQLCreato:=C600FSelezioneAnagrafe.SQLCreato.Text;
  C600SelAnagrafeBridge.Progressivo:=C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.C600Progressivo;
  C600SelAnagrafeBridge.SelezionePeriodica:=FSelezionePeriodica;
  C600SelAnagrafeBridge.SoloPersonaleInterno:=FSoloPersonaleInterno;
  //*)
  (*if C700OldSelAnagrafe = nil then
    C700OldSelAnagrafe:=TOracleDataSet.Create(nil);
  C700OldSelAnagrafe.SQL.Assign(C700SelAnagrafe.SQL);
  C700OldSelAnagrafe.Variables.Assign(C700SelAnagrafe.Variables);*)
end;

function TC600frmSelAnagrafe.SettaPeriodoSelAnagrafe(DataDal,DataLavoro:TDateTime):Boolean;
begin
  Result:=False;
  if C600SelAnagrafe.VariableIndex('DATALAVORO') >= 0 then
    if C600SelAnagrafe.GetVariable('DATALAVORO') <> DataLavoro then
    begin
      C600SelAnagrafe.SetVariable('DATALAVORO',DataLavoro);
      Result:=True;
    end;
  if C600SelAnagrafe.VariableIndex('C600DataDal') >= 0 then
    if C600SelAnagrafe.GetVariable('C600DataDal') <> DataDal then
    begin
      C600SelAnagrafe.SetVariable('C600DataDal',DataDal);
      Result:=True;
    end;
end;

procedure TC600frmSelAnagrafe.RipristinaC00SelAnagrafe;
begin
  C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=OldOpenC600SelAnagrafe;
  C600FSelezioneAnagrafe.C600DatiSelezionati:=OldC600DatiSelezionati;
  C600DatiVisualizzati:=OldC600DatiVisualizzati;
  C600DataLavoro:=OldC600DataLavoro;
  C600DataDal:=OldC600DataDal;
  C600FSelezioneAnagrafe.DataLavoro:=C600DataLavoro;
  C600FSelezioneAnagrafe.DataDal:=C600DataDal;
  C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.C600Progressivo:=-1;
  //C600FSelezioneAnagrafeDtM.OpenSelAnagrafe;
  C600FSelezioneAnagrafe.SQLCreato.Clear;
  with C600SelAnagrafe do
  begin
    if VariableIndex('C600DataDal') >= 0 then
      DeleteVariable('C600DataDal');
    if VariableIndex('C700FILTRO') >= 0 then
      DeleteVariable('C700FILTRO');
    SetVariable('DataLavoro',C600FSelezioneAnagrafe.DataLavoro);
    CloseAll;
    SQL.Assign(OldSelAnagrafe);
    if C600FSelezioneAnagrafe.OpenC600SelAnagrafe then
    begin
      Open;
      SearchRecord('PROGRESSIVO',OldC600Progressivo,[srFromBeginning]);
    end;
  end;
  C600FSelezioneAnagrafe.SQLCreato.Assign(OldSQLCreato);
  C600FSelezioneAnagrafe.WhereSql:=C600FSelezioneAnagrafe.SQLCreato.Text;
  C600FSelezioneAnagrafe.CorpoSQL.Assign(OldCorpoSQL);
  C600FSelezioneAnagrafe.PulisciVecchiaSelezione:=False;
  C600SelAnagrafeBridge:=OldC600SelAnagrafeBridge;
  btnBrowseClick(nil);
  //Alberto: resetto le condizioni opzionali
  SetSelezionePeriodica(FSelezionePeriodica);
  SetSoloPersonaleInterno(FSoloPersonaleInterno);
  SettaPeriodoSelAnagrafe(C600DataLavoro,C600DataDal);
  //Gestione C004
  if OldC004Prog <> '' then
  try
    CreaC004(SessioneOracle,OldC004Prog,OldC004Utente);
  except
  end;
end;

procedure TC600frmSelAnagrafe.RipristinaC600SelAnagrafeBridge;
begin
  if C600SelAnagrafeBridge.SQLCreato = '' then
    exit;
  OldSQLCreato.Text:=C600SelAnagrafeBridge.SQLCreato;
  FSelezionePeriodica:=C600SelAnagrafeBridge.SelezionePeriodica;
  FSoloPersonaleInterno:=C600SelAnagrafeBridge.SoloPersonaleInterno;

  C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.C600Progressivo:=-1;
  C600FSelezioneAnagrafe.SQLCreato.Assign(OldSQLCreato);
  C600FSelezioneAnagrafe.WhereSql:=C600FSelezioneAnagrafe.SQLCreato.Text;
  SetSelezionePeriodica(FSelezionePeriodica);
  SetSoloPersonaleInterno(FSoloPersonaleInterno);

  C600FSelezioneAnagrafe.PulisciVecchiaSelezione:=False;
  C600FSelezioneAnagrafe.actConfermaExecute(C600FSelezioneAnagrafe.actConferma);
  C600SelAnagrafe.SearchRecord('PROGRESSIVO',C600SelAnagrafeBridge.Progressivo,[srFromBeginning]);
end;

function TC600frmSelAnagrafe.GetC600SelAnagrafeOrderBy:String;
var i,j:Integer;
begin
  Result:='';
  for i:=C600FSelezioneAnagrafe.SQLCreato.Count - 1 downto 0 do
    if Pos('ORDER BY',UpperCase(C600FSelezioneAnagrafe.SQLCreato[i])) > 0 then
    begin
      Result:=Copy(C600FSelezioneAnagrafe.SQLCreato[i],Pos('ORDER BY',UpperCase(C600FSelezioneAnagrafe.SQLCreato[i])),Length(C600FSelezioneAnagrafe.SQLCreato[i]));
      for j:=i + 1 to C600FSelezioneAnagrafe.SQLCreato.Count - 1 do
        Result:=Result + C600FSelezioneAnagrafe.SQLCreato[j];
      Break;
    end;
end;

procedure TC600frmSelAnagrafe.PutC600SelAnagrafeOrderBy(Campo:String);
var i,j,p,x:Integer;
    S,S1:String;
begin
  S:='';
  p:=0;
  x:=-1;
  for i:=C600FSelezioneAnagrafe.SQLCreato.Count - 1 downto 0 do
  begin
    p:=Pos('ORDER BY',UpperCase(C600FSelezioneAnagrafe.SQLCreato[i]));
    if p > 0 then
    begin
      x:=i;
      S:=Copy(C600FSelezioneAnagrafe.SQLCreato[i],Pos('ORDER BY',UpperCase(C600FSelezioneAnagrafe.SQLCreato[i])),Length(C600FSelezioneAnagrafe.SQLCreato[i]));
      for j:=i + 1 to C600FSelezioneAnagrafe.SQLCreato.Count - 1 do
        S:=S +  ' ' + C600FSelezioneAnagrafe.SQLCreato[j];
      Break;
    end;
  end;
  if S = '' then
    S:='ORDER BY ' + Campo
  else
  begin
    S:=Copy(S,9,Length(S));
    S1:=StringReplace(Trim(S),' ','',[rfReplaceAll]);
    if (Pos(',' + UpperCase(Campo) + ',',',' + UpperCase(S1) + ',') = 0) or
       (Pos(',' + UpperCase(Campo) + ',',',' + UpperCase(S1) + ',') > 1) then
      S:='ORDER BY ' + Campo + ',' + S
    else
      S:='ORDER BY ' +  S;
  end;
  if x >= 0 then
  begin
    for i:=C600FSelezioneAnagrafe.SQLCreato.Count - 1 downto x + 1 do
      C600FSelezioneAnagrafe.SQLCreato.Delete(i);
    C600FSelezioneAnagrafe.SQLCreato[x]:=Copy(C600FSelezioneAnagrafe.SQLCreato[x],1,p - 1);
    if C600FSelezioneAnagrafe.SQLCreato[x] = '' then
      C600FSelezioneAnagrafe.SQLCreato.Delete(x);
  end;
  C600FSelezioneAnagrafe.SQLCreato.Add(S);
  C600FSelezioneAnagrafe.WhereSQL:=C600FSelezioneAnagrafe.SQLCreato.Text;
end;

procedure TC600frmSelAnagrafe.btnSelezioneClick(Sender: TObject);
begin
  C600ModalResult:=C600SelezionaAnagrafe;
  NumRecords;
  if C600SelAnagrafe.Active then
  begin
    VisualizzaDipendente;
    C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.C600Progressivo:=C600SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    if @OnCambiaProgressivo <> nil then
      OnCambiaProgressivo;
    C600OldProgressivo:=C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.C600Progressivo;
  end;
end;

procedure TC600frmSelAnagrafe.btnBrowseClick(Sender: TObject);
begin
  if Sender <> nil then
    if Sender = btnPrimo then
      C600SelAnagrafe.First
    else if Sender = btnPrecedente then
      C600SelAnagrafe.Prior
    else if Sender = btnSuccessivo then
      C600SelAnagrafe.Next
    else if Sender = btnUltimo then
      C600SelAnagrafe.Last;
  if C600SelAnagrafe.Active then
  begin
    VisualizzaDipendente;
    C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.C600Progressivo:=C600SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  end;
  if @OnCambiaProgressivo <> nil then
    OnCambiaProgressivo;
  C600OldProgressivo:=C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.C600Progressivo;
  NumRecords;
end;

procedure TC600frmSelAnagrafe.SelezionaProgressivo(Progressivo:Integer);
begin
  C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.C600Progressivo:=Progressivo;
  C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.OpenSelAnagrafe;
  btnBrowseClick(nil);
  C600OldProgressivo:=C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.C600Progressivo;
end;

procedure TC600frmSelAnagrafe.btnEreditaSelezioneClick(Sender: TObject);
var P:Integer;
begin
  P:=C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.C600Progressivo;
  RipristinaC600SelAnagrafeBridge;
  C600SelAnagrafe.SearchRecord('PROGRESSIVO',P,[srFromBeginning]);
  NumRecords;
  VisualizzaDipendente;
  lblDipendente.Hint:=StringReplace(C600DatiVisualizzati,'T430','',[rfReplaceAll]);
  if @OnCambiaProgressivo <> nil then
    OnCambiaProgressivo;
  C600OldProgressivo:=C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.C600Progressivo;
end;

procedure TC600frmSelAnagrafe.btnRicercaClick(Sender: TObject);
{Crea la form di ricerca e si posiziona sul record}
var i,j:Integer;
    ElencoCampi:String;
    Valori,Campi:TStringList;
    Pippo:Variant;
begin
  Valori:=TStringList.Create;
  Campi:=TStringList.Create;
  ElencoCampi:='';
  C001FRicerca:=TC001FRicerca.Create(nil);
  with C001FRicerca,C600SelAnagrafe do
    try
    chkFiltro.Visible:=False;
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
      for i:=1 to Grid.RowCount - 1 do
        if Trim(Grid.Cells[1,i]) <> '' then
        begin
          ElencoCampi:=ElencoCampi + ';' + Campi[i-1];
          Valori.Add(Trim(Grid.Cells[1,i]));
        end;
      if Valori.Count > 0 then
        begin
        Pippo:=VarArrayCreate([0,Valori.Count - 1],VarVariant);
        for i:=0 to Valori.Count - 1 do
          Pippo[i]:=Valori[i];
        if Valori.Count > 1 then
          Locate(Copy(ElencoCampi,2,1000),Pippo,[loCaseInsensitive,loPartialKey])
        else
          Locate(Copy(ElencoCampi,2,1000),Valori[0],[loCaseInsensitive,loPartialKey])
        end;
    end;
    finally
      C001FRicerca.Free;
    end;
  NumRecords;
  VisualizzaDipendente;
  C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.C600Progressivo:=C600SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  if @OnCambiaProgressivo <> nil then
    OnCambiaProgressivo;
  C600OldProgressivo:=C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.C600Progressivo;
end;

procedure TC600frmSelAnagrafe.R003DatianagraficiClick(Sender: TObject);
begin
  C005FDatiAnagrafici:=TC005FDatiAnagrafici.Create(nil);
  if C005DataVisualizzazione = 0 then
    C005DataVisualizzazione:=Parametri.DataLavoro;
  try
    C005FDatiAnagrafici.ShowDipendente(C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.C600Progressivo);
  finally
    C005FDatiAnagrafici.Release;
  end;
end;

procedure TC600frmSelAnagrafe.SetSelezionePeriodica(Value:Boolean);
begin
  FSelezionePeriodica:=Value;
  if C600FSelezioneAnagrafe <> nil then
  try
    C600FSelezioneAnagrafe.grpSelezionePeriodica.Enabled:=FSelezionePeriodica;
  except
  end;
end;

procedure TC600frmSelAnagrafe.SetSoloPersonaleInterno(Value:Boolean);
begin
  FSoloPersonaleInterno:=Value;
  if C600FSelezioneAnagrafe <> nil then
  try
    C600FSelezioneAnagrafe.chkEsterni.Visible:=not FSoloPersonaleInterno;
  except
  end;
end;

function TC600frmSelAnagrafe.GetC600Progressivo:Integer;
begin
  Result:=-1;
  try
    Result:=C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.C600Progressivo;
  except
  end;
end;

procedure TC600frmSelAnagrafe.SetC600Progressivo(Value:Integer);
begin
  try
    C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.C600Progressivo:=Value;
  except
  end;
end;

procedure TC600frmSelAnagrafe.SetElaborazioneInterrompibile(Value:Boolean);
var f:TControl;
begin
  FElaborazioneInterrompibile:=Value;
  C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.FElaborazioneInterrompibile:=Value;
  if Value then
    ElaborazioneInterrotta:=False;
  f:=Self.Parent;
  while (not (f is TForm)) and (f.Parent <> nil) do
    f:=f.Parent;
  if f is TForm then
  begin
    TForm(f).KeyPreview:=Value;
    if Value then
      TForm(f).OnKeyPress:=Self.FormKeyPress
    else
      TForm(f).OnKeyPress:=nil;
  end;
end;

procedure TC600frmSelAnagrafe.FormKeyPress(Sender: TObject; var Key: Char);
{Per bloccare l'elaborazione col tasto ESC}
begin
  if Key = #27 then
    if MessageDlg('Interrompere l''elaborazione?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      C600SelAnagrafe.Last;
      ElaborazioneInterrotta:=True;
    end;
end;

function TC600frmSelAnagrafe.GetCampiAbilitatiC600:String;
var i:Integer;
    S:String;
begin
  Result:='';
  for i:=0 to Parametri.ColonneStruttura.Count - 1 do
  begin
    S:=Parametri.ColonneStruttura.ValueFromIndex[i];
    if Pos(',' + S + ',',Parametri.CampiAnagraficiNonVisibili) = 0 then
    begin
      if (Pos('T430',S) <> 1) and ((Pos('P430',S) <> 1)) then
      begin
        if (UpperCase(S) = 'CITTA') or (UpperCase(S) = 'PROVINCIA') then
          S:='T480.' + S
        else
          S:='T030.' + S;
      end;
      if Result <> '' then
        Result:=Result + ',';
      Result:=Result + S;
    end;
  end;
end;

procedure TC600frmSelAnagrafe.DistruggiSelAnagrafe;
begin
  OldSelAnagrafe.Free;
  OldCorpoSQL.Free;
  OldSQLCreato.Free;
  C600Distruzione;
end;

//ex-Procedure globali C700
procedure TC600frmSelAnagrafe.C600Creazione(Db:TOracleSession);
{Creazione della Form e del DataModule}
begin
  C600FSelezioneAnagrafe:=TC600FSelezioneAnagrafe.Create(nil);
  with C600FSelezioneAnagrafe do
  try
    DataLavoro:=C600DataLavoro;
    if C600DatiVisualizzati = 'MATRICOLA,T430BADGE,COGNOME,NOME' then
      C600DatiVisualizzati:=Parametri.DatiC700;
    if C600DatiSelezionati = '' then
      C600DatiSelezionati:=C600CampiBase;
    C600DatiSelezionati:=C600CompletaDatiSelezionati;
    DataBase:=Db;
    C600FSelezioneAnagrafeDtM:=TC600FSelezioneAnagrafeDtM.Create(C600FSelezioneAnagrafe);
    CaricaTVAzienda(False);
    PulisciVecchiaSelezione:=True;
    OpenC600SelAnagrafe:=True;
    //C700SelezionePeriodica:=False;
    //C700SoloPersonaleInterno:=True;
  except
    C600FSelezioneAnagrafeDtM.Free;
    C600FSelezioneAnagrafe.Free;
  end;
  C600SelAnagrafe:=C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.selAnagrafe;
  C600SrcAnagrafe:=TDataSource.Create(nil);
  C600SrcAnagrafe.DataSet:=C600SelAnagrafe;
end;

function TC600frmSelAnagrafe.C600CompletaDatiSelezionati:String;
var lstS,lstV:TStringList;
    i:Integer;
begin
  Result:=C600FSelezioneAnagrafe.C600DatiSelezionati;
  if Result = C600TuttiCampi then
    exit;
  lstS:=TStringList.Create;
  lstV:=TStringList.Create;
  try
    lstS.CommaText:=StringReplace(UpperCase(C600FSelezioneAnagrafe.C600DatiSelezionati),'T030.','',[rfReplaceAll]);
    lstV.CommaText:=UpperCase(C600DatiVisualizzati);
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

procedure TC600frmSelAnagrafe.C600MergeSelAnagrafe(ODS:TComponent; RicreaVariabili:Boolean = False);
{ODS deve essere un OracleDataSet o OracleQuery con il parametro C600SelAnagrafe di tipo Substitution;
 Viene rimpiazzato il parametro :C600SelAnagrafe con il testo SQL di C600SelAnagrafe
 dalla FROM alla ORDER BY escluse.
 Le variabili di ODS vengono integrate con quelle di C600SelAnagrafe (DataLavoro, C600DataDal) cancellando quelle già esistenti o meno a seconda di RicreaVariabili
 Esempio di utilizzo:
 -Subquery-
 ...AND tabella.PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C600SelAnagrafe)
 -Join-
 SELECT * FROM TABELLA1, TABELLA2, :C600SelAnagrafe //la WHERE è già inserita
 AND TABELLA1.CAMPO1 = TABELLA2.CAMPO2
 AND TABELLA1.PROGRESSIVO = T030.PROGRESSIVO
 }
var i:Integer;
    S:String;
begin
  if Trim(C600FSelezioneAnagrafe.CorpoSQL.Text) = '' then
  begin
    //Prima volta che si richiama la procedura
    //C600FSelezioneAnagrafe.QueryDinamica(1);
    C600FSelezioneAnagrafe.QueryDinamica(2);
    C600SelAnagrafe.Open;
  end;
  //Alberto 12/04/2007: gestisco a parte le variabili di tipo Substitution
  S:=C600FSelezioneAnagrafe.CorpoSQL.Text;
  for i:=0 to C600SelAnagrafe.VariableCount - 1 do
   if C600SelAnagrafe.VariableType(i) = otSubst then
     S:=StringReplace(S,C600SelAnagrafe.VariableName(i),C600SelAnagrafe.GetVariable(C600SelAnagrafe.VariableName(i)),[rfIgnoreCase]);
  if ODS is TOracleQuery then
  begin
    //Se ODS è OracleQuery....
    if TOracleQuery(ODS).VariableIndex('C600SelAnagrafe') = -1 then
      exit;
    TOracleQuery(ODS).SetVariable('C600SelAnagrafe',S);
    if TOracleQuery(ODS).VariableIndex('C700Filtro') >= 0 then
      TOracleQuery(ODS).DeleteVariable('C700Filtro');
    if TOracleQuery(ODS).VariableIndex('C600DataDal') >= 0 then
      TOracleQuery(ODS).DeleteVariable('C600DataDal');
    if RicreaVariabili then
    begin
      TOracleQuery(ODS).DeleteVariables;
      TOracleQuery(ODS).DeclareVariable('C600SelAnagrafe',otSubst);
    end;
    for i:=0 to C600SelAnagrafe.VariableCount - 1 do
    begin
      if (TOracleQuery(ODS).VariableIndex(C600SelAnagrafe.VariableName(i)) = -1) and
         (C600SelAnagrafe.VariableType(i) <> otSubst) then
      begin
        TOracleQuery(ODS).DeclareVariable(C600SelAnagrafe.VariableName(i),C600SelAnagrafe.VariableType(i));
        TOracleQuery(ODS).SetVariable(C600SelAnagrafe.VariableName(i),C600SelAnagrafe.GetVariable(i));
      end;
    end;
  end
  else
  begin
    //Se ODS è OracleDataSet...
    if TOracleDataSet(ODS).VariableIndex('C600SelAnagrafe') = -1 then
      exit;
    TOracleDataSet(ODS).SetVariable('C600SelAnagrafe',S);
    if TOracleDataSet(ODS).VariableIndex('C700Filtro') >= 0 then
      TOracleDataSet(ODS).DeleteVariable('C700Filtro');
    if TOracleDataSet(ODS).VariableIndex('C600DataDal') >= 0 then
      TOracleDataSet(ODS).DeleteVariable('C600DataDal');
    if RicreaVariabili then
    begin
      TOracleDataSet(ODS).DeleteVariables;
      TOracleDataSet(ODS).DeclareVariable('C600SelAnagrafe',otSubst);
    end;
    for i:=0 to C600SelAnagrafe.VariableCount - 1 do
    begin
      if (TOracleDataSet(ODS).VariableIndex(C600SelAnagrafe.VariableName(i)) = -1) and
         (C600SelAnagrafe.VariableType(i) <> otSubst) then
      begin
        TOracleDataSet(ODS).DeclareVariable(C600SelAnagrafe.VariableName(i),C600SelAnagrafe.VariableType(i));
        TOracleDataSet(ODS).SetVariable(C600SelAnagrafe.VariableName(i),C600SelAnagrafe.GetVariable(i));
      end;
    end;
  end;
end;

function TC600frmSelAnagrafe.C600MergeSettaPeriodo(ODS:TComponent; DataDal,DataLavoro:TDateTime):Boolean;
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
    if TOracleQuery(ODS).VariableIndex('C600DataDal') >= 0 then
      if TOracleQuery(ODS).GetVariable('C600DataDal') <> DataDal then
      begin
        TOracleQuery(ODS).SetVariable('C600DataDal',DataDal);
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
    if TOracleDataSet(ODS).VariableIndex('C600DataDal') >= 0 then
      if TOracleDataSet(ODS).GetVariable('C600DataDal') <> DataDal then
      begin
        TOracleDataSet(ODS).SetVariable('C600DataDal',DataDal);
        Result:=True;
      end;
  end;
end;

function TC600frmSelAnagrafe.C600SelezionaAnagrafe:TModalResult;
var L,L1:TStringList;
    i,P:Integer;
    VarODS:TOracleDataSet;
begin
  L:=TStringList.Create;
  L1:=TStringList.Create;
  L.Assign(C600SelAnagrafe.SQL);
  L1.Assign(C600FSelezioneAnagrafe.SQLCreato);
  VarODS:=TOracleDataSet.Create(nil);
  for i:=0 to C600SelAnagrafe.VariableCount - 1 do
  begin
    VarODS.DeclareVariable(C600SelAnagrafe.VariableName(i),C600SelAnagrafe.VariableType(i));
    VarODS.SetVariable(C600SelAnagrafe.VariableName(i),C600SelAnagrafe.GetVariable(i));
  end;
  P:=C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.C600Progressivo;
  if C600FSelezioneAnagrafe.C600DatiSelezionati = '' then
    C600FSelezioneAnagrafe.C600DatiSelezionati:=C600CampiBase;
  C600FSelezioneAnagrafe.C600DatiSelezionati:=C600CompletaDatiSelezionati;
  if C600DataLavoro <> C600FSelezioneAnagrafe.DataLavoro then
    C600FSelezioneAnagrafe.DataLavoro:=C600DataLavoro;
  if C600DataDal <> C600FSelezioneAnagrafe.DataDal then
    C600FSelezioneAnagrafe.DataDal:=C600DataDal;
  //C600FSelezioneAnagrafe.chkEsterni.Enabled:=not C700SoloPersonaleInterno;
  //C600FSelezioneAnagrafe.grpSelezionePeriodica.Enabled:=C700SelezionePeriodica;
  if C600FSelezioneAnagrafe.grpSelezionePeriodica.Enabled then
    C600FSelezioneAnagrafe.grpSelezionePeriodica.Caption:='Periodo considerato'
  else
    C600FSelezioneAnagrafe.grpSelezionePeriodica.Caption:='Periodo considerato (' + DateToStr(C600DataLavoro) + ')';
  C600FSelezioneAnagrafe.TVAzienda.OnChange:=nil;
  C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.C600FSelezioneAnagrafe_.DataLavoro:=C600FSelezioneAnagrafe.DataLavoro;
  C600FSelezioneAnagrafe.C600FSelezioneAnagrafeDtM.C600FSelezioneAnagrafe_.C600DatiSelezionati:=C600FSelezioneAnagrafe.C600DatiSelezionati;
  Result:=C600FSelezioneAnagrafe.ShowModal;
  if Result <> mrOK then
  begin
    C600SelAnagrafe.SQL.Assign(L);
    C600FSelezioneAnagrafe.SQLCreato.Assign(L1);
    C600SelAnagrafe.CloseAll;
    C600SelAnagrafe.DeleteVariables;
    for i:=0 to VarODS.VariableCount - 1 do
    begin
      C600SelAnagrafe.DeclareVariable(VarODS.VariableName(i),VarODS.VariableType(i));
      C600SelAnagrafe.SetVariable(VarODS.VariableName(i),VarODS.GetVariable(i));
    end;
    if (L.Text <> '') and C600FSelezioneAnagrafe.OpenC600SelAnagrafe then
    begin
      C600SelAnagrafe.Open;
      C600SelAnagrafe.SearchRecord('PROGRESSIVO',P,[srFromBeginning]);
    end;
  end
  else
    C600FSelezioneAnagrafe.PulisciVecchiaSelezione:=False;
  FreeAndNil(L);
  FreeAndNIl(VarODS);
end;

function TC600frmSelAnagrafe.C600GetDatiVisualizzati:String;
var i:Integer;
    b:Boolean;
begin
  Result:='';
  with TStringList.Create do
  try
    CommaText:=C600DatiVisualizzati;
    b:=False;
    for i:=0 to Count - 1 do
    begin
      if Result <> '' then
        Result:=Result + ' ';
      if ((Strings[i] = 'T430BADGE') or (Strings[i] = 'MATRICOLA')) and ((i = 0) or ((i = 1) and b)) then
      begin
        Result:=Result + Format('%-8s',[C600SelAnagrafe.FieldByName(Strings[i]).AsString]);
        b:=True;
      end
      else
        Result:=Result + C600SelAnagrafe.FieldByName(Strings[i]).AsString;
    end;
  finally
    Free;
  end;
end;

procedure TC600frmSelAnagrafe.C600Distruzione;
{Distruzione delle Forms}
begin
  if C600FSelezioneAnagrafe <> nil then
  begin
    FreeAndNil(C600SrcAnagrafe);
    //FreeAndNil(C600FSelezioneAnagrafeDtM);
    FreeAndNil(C600FSelezioneAnagrafe);
  end;
end;

end.
