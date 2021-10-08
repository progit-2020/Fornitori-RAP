unit SelAnagrafe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, ExtCtrls, ComCtrls, DB, Oracle, OracleData, Variants,
  A000UCostanti, A000UInterfaccia, C001URicerca, C004UParamForm, C005UDatiAnagrafici,
  C180FunzioniGenerali, C700USelezioneAnagrafe, C700USelezioneAnagrafeDtM,
  R005UDataModuleMW;

type
  TCambiaProgressivo = procedure of object;
  TfrmSelAnagrafe = class(TFrame)
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
    FSelezionePeriodica:Boolean;
    FSoloPersonaleInterno:Boolean;
    FSelezionePeriodicaVal:Byte;
    FSoloPersonaleInternoVal:Boolean;
    FAncheDipendentiCessatiVal:Boolean;
    OldC004Prog,OldC004Utente:String;
    FMiddlewareDM:TR005FDataModuleMW;
    procedure SetElaborazioneInterrompibile(Value:Boolean);
    procedure SetSelezionePeriodica(Value:Boolean);
    procedure SetSoloPersonaleInterno(Value:Boolean);
    procedure SetSelezionePeriodicaVal(Value:Byte);
    procedure SetSoloPersonaleInternoVal(Value:Boolean);
    procedure SetAncheDipendentiCessatiVal(Value:Boolean);
  public
    { Public declarations }
    sbarSelAnagrafe:TStatusBar;
    PanelNum:Word;
    OnCambiaProgressivo:TCambiaProgressivo;
    OldSelAnagrafe,OldCorpoSQL,OldSQLCreato:TStringList;
    OldC700Progressivo:Integer;
    OldC700SelAnagrafeBridge:TC700SelAnagrafeBridge;
    OldOpenC700SelAnagrafe:Boolean;
    ElaborazioneInterrotta:Boolean;
    C700ModalResult:TModalResult;
    constructor Create(AOwner: TComponent); override;
    procedure CreaSelAnagrafe(Sessione:TOracleSession; sb:TStatusBar; Panel:Word; AbilitaBrowse:Boolean); overload;
    procedure CreaSelAnagrafe(MW: TR005FDataModuleMW; Sessione:TOracleSession; sb:TStatusBar; Panel:Word; AbilitaBrowse:Boolean); overload;
    procedure DistruggiSelAnagrafe;
    procedure SalvaC00SelAnagrafe;
    procedure SalvaC700SelAnagrafeBridge;
    procedure RipristinaC00SelAnagrafe; overload;
    procedure RipristinaC00SelAnagrafe(MW: TR005FDataModuleMW); overload;
    procedure RipristinaC700SelAnagrafeBridge;
    procedure SelezionaProgressivo(Progressivo:Integer);
    procedure NumRecords;
    procedure VisualizzaDipendente;
    function SettaPeriodoSelAnagrafe(DataDal,DataLavoro:TDateTime):Boolean;
    function GetCampiAbilitatiC700:String;
    function GetC700SelAnagrafeOrderBy:String;
    procedure PutC700SelAnagrafeOrderBy(Campo:String);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    property ElaborazioneInterrompibile:Boolean read FElaborazioneInterrompibile write SetElaborazioneInterrompibile;
    property SelezionePeriodica:Boolean read FSelezionePeriodica write SetSelezionePeriodica;
    property SoloPersonaleInterno:Boolean read FSoloPersonaleInterno write SetSoloPersonaleInterno;
    property SelezionePeriodicaVal:Byte read FSelezionePeriodicaVal write SetSelezionePeriodicaVal;
    property SoloPersonaleInternoVal:Boolean read FSoloPersonaleInternoVal write SetSoloPersonaleInternoVal;
    property AncheDipendentiCessatiVal:Boolean read FAncheDipendentiCessatiVal write SetAncheDipendentiCessatiVal;
    property MiddlewareDM:TR005FDataModuleMW read FMiddlewareDM;
  end;

implementation

{$R *.DFM}

constructor TfrmSelAnagrafe.Create(AOwner: TComponent);
begin
  inherited;
  FSelezionePeriodica:=False;
  FSoloPersonaleInterno:=True;
  FSelezionePeriodicaVal:=0;
  FSoloPersonaleInternoVal:=True;
  FAncheDipendentiCessatiVal:=True;
  FMiddlewareDM:=nil;
end;

procedure TfrmSelAnagrafe.CreaSelAnagrafe(Sessione:TOracleSession; sb:TStatusBar; Panel:Word; AbilitaBrowse:Boolean);
begin
  if C700FSelezioneAnagrafeDtM <> nil then
    exit;
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
  btnEreditaSelezione.Visible:=(Trim(C700SelAnagrafeBridge.SQLCreato) <> '') and (UpperCase(Trim(C700SelAnagrafeBridge.SQLCreato)) <> 'T030.PROGRESSIVO = 0');
  if not AbilitaBrowse then
    lblDipendente.Left:=btnRicerca.Left;
  C700OldProgressivo:=-1;
  C700Chiamante:='';
  if Owner <> nil then
    C700Chiamante:=Copy(Owner.Name,1,4);
  C700Creazione(Sessione);
  SetSelezionePeriodica(FSelezionePeriodica);
  SetSoloPersonaleInterno(FSoloPersonaleInterno);
  SetSelezionePeriodicaVal(FSelezionePeriodicaVal);
  SetSoloPersonaleInternoVal(FSoloPersonaleInternoVal);
  SetAncheDipendentiCessatiVal(FAncheDipendentiCessatiVal);
  //Alberto
  (*if C700SelAnagrafeBridge.SQLCreato <> '' then
    RipristinaC700SelAnagrafeBridge
  else*)
    C700FSelezioneAnagrafeDtM.OpenSelAnagrafe;
  NumRecords;
  VisualizzaDipendente;
  lblDipendente.Hint:=StringReplace(C700DatiVisualizzati,'T430','',[rfReplaceAll]);
  if @OnCambiaProgressivo <> nil then
    OnCambiaProgressivo;
  C700OldProgressivo:=C700Progressivo;
end;

procedure TfrmSelAnagrafe.CreaSelAnagrafe(MW: TR005FDataModuleMW; Sessione:TOracleSession; sb:TStatusBar; Panel:Word; AbilitaBrowse:Boolean);
begin
  CreaSelAnagrafe(Sessione,sb,Panel,AbilitaBrowse);
  FMiddlewareDM:=MW;
  MW.SelAnagrafe:=C700SelAnagrafe;
  if @OnCambiaProgressivo <> nil then
  begin
    C700OldProgressivo:=-1;
    OnCambiaProgressivo;
    C700OldProgressivo:=C700Progressivo;
  end;
end;

procedure TfrmSelAnagrafe.NumRecords;
begin
  if sbarSelAnagrafe <> nil then
  begin
    if ElaborazioneInterrompibile then
      sbarSelAnagrafe.Panels[PanelNum].Text:=Format('Anagr. %d/%d - Esc per interrompere',[C700SelAnagrafe.RecNo,C700SelAnagrafe.RecordCount])
    else
      sbarSelAnagrafe.Panels[PanelNum].Text:=Format('Anagr. %d/%d',[C700SelAnagrafe.RecNo,C700SelAnagrafe.RecordCount]);
    sbarSelAnagrafe.Repaint;
  end;
end;

procedure TfrmSelAnagrafe.VisualizzaDipendente;
var
  DataFineRap, DataInizioRap:TDateTime;

begin
  NumRecords;
  lblDipendente.Caption:=C700GetDatiVisualizzati;
  if C700SelAnagrafe.Active and (C700SelAnagrafe.RecordCount > 0) then
  begin
    DataFineRap:=C700SelAnagrafe.FieldByName('T430FINE').AsDateTime;
    if DataFineRap = 0 then
      DataFineRap:=EncodeDate(3999,12,31);
    DataInizioRap:=C700SelAnagrafe.FieldByName('T430INIZIO').AsDateTime;
    if DataInizioRap = 0 then
      DataInizioRap:=EncodeDate(1899,12,30);
    if ((C700SelAnagrafe.VariableIndex('C700DATADAL') < 0) and ((DataInizioRap > C700DataLavoro ) or (DataFineRap < C700DataLavoro))) or
       ((C700SelAnagrafe.VariableIndex('C700DATADAL') >= 0) and ((C700DataLavoro < DataInizioRap) or (R180VarToDateTime(C700SelAnagrafe.GetVariable('C700DATADAL')) > DataFineRap))) then
      lblDipendente.Font.Color:=clRed
    else if (DataInizioRap >= R180InizioMese(C700DataLavoro)) and (DataInizioRap <= R180FineMese(C700DataLavoro)) then
      lblDipendente.Font.Color:=C700NEO_ASSUNTO
    else
      lblDipendente.Font.Color:=clBlue;
  end;
  pnlSelAnagrafe.Repaint;
end;

procedure TfrmSelAnagrafe.SalvaC00SelAnagrafe;
begin
  OldSelAnagrafe.Assign(C700SelAnagrafe.SQL);
  OldSQLCreato.Assign(C700FSelezioneAnagrafe.SQLCreato);
  OldCorpoSQL.Assign(C700FSelezioneAnagrafe.CorpoSQL);
  OldC700Progressivo:=C700Progressivo;
  OldOpenC700SelAnagrafe:=C700FSelezioneAnagrafe.OpenC700SelAnagrafe;
  OldC700DatiSelezionati:=C700DatiSelezionati;
  OldC700DatiVisualizzati:=C700DatiVisualizzati;
  OldC700DataLavoro:=C700DataLavoro;
  OldC700DataDal:=C700DataDal;
  if SelezionePeriodicaVal = 1 then
    OldC700Filtro:=C700SelAnagrafe.GetVariable('C700FILTRO');
  SalvaC700SelAnagrafeBridge;
  //Gestione C004
  OldC004Prog:='';
  OldC004Utente:='';
  try
    try
      if (C004FParamForm <> nil) and (C004FParamForm.selT001 <> nil) then
      begin
        OldC004Prog:=VarToStr(C004FParamForm.selT001.GetVariable('PROG'));
        OldC004Utente:=VarToStr(C004FParamForm.selT001.GetVariable('UTENTE'));
        FreeAndNil(C004FParamForm);
      end;
    finally
      C004FParamForm:=nil;
    end;
  except
  end;
end;

procedure TfrmSelAnagrafe.SalvaC700SelAnagrafeBridge;
begin
  //(*
  OldC700SelAnagrafeBridge:=C700SelAnagrafeBridge;
  C700SelAnagrafeBridge.SQLCreato:=C700FSelezioneAnagrafe.SQLCreato.Text;
  C700SelAnagrafeBridge.Progressivo:=C700Progressivo;
  C700SelAnagrafeBridge.SelezionePeriodica:=FSelezionePeriodica;
  C700SelAnagrafeBridge.SoloPersonaleInterno:=FSoloPersonaleInterno;
  C700SelAnagrafeBridge.SelezionePeriodicaVal:=FSelezionePeriodicaVal;
  C700SelAnagrafeBridge.SoloPersonaleInternoVal:=FSoloPersonaleInternoVal;
  C700SelAnagrafeBridge.AncheDipendentiCessatiVal:=FAncheDipendentiCessatiVal;
  //*)
  (*if C700OldSelAnagrafe = nil then
    C700OldSelAnagrafe:=TOracleDataSet.Create(nil);
  C700OldSelAnagrafe.SQL.Assign(C700SelAnagrafe.SQL);
  C700OldSelAnagrafe.Variables.Assign(C700SelAnagrafe.Variables);*)
end;

function TfrmSelAnagrafe.SettaPeriodoSelAnagrafe(DataDal,DataLavoro:TDateTime):Boolean;
begin
  Result:=False;
  if C700SelAnagrafe.VariableIndex('DATALAVORO') >= 0 then
    if C700SelAnagrafe.GetVariable('DATALAVORO') <> DataLavoro then
    begin
      C700SelAnagrafe.SetVariable('DATALAVORO',DataLavoro);
      Result:=True;
    end;
  if C700SelAnagrafe.VariableIndex('C700DATADAL') >= 0 then
    if C700SelAnagrafe.GetVariable('C700DATADAL') <> DataDal then
    begin
      C700SelAnagrafe.SetVariable('C700DATADAL',DataDal);
      Result:=True;
    end;
end;

procedure TfrmSelAnagrafe.RipristinaC00SelAnagrafe;
begin
  if MiddlewareDM <> nil then
    MiddlewareDM.SelAnagrafe:=nil;
  C700FSelezioneAnagrafe.OpenC700SelAnagrafe:=OldOpenC700SelAnagrafe;
  C700DatiSelezionati:=OldC700DatiSelezionati;
  C700DatiVisualizzati:=OldC700DatiVisualizzati;
  C700DataLavoro:=OldC700DataLavoro;
  C700DataDal:=OldC700DataDal;
  C700FSelezioneAnagrafe.DataLavoro:=C700DataLavoro;
  C700FSelezioneAnagrafe.DataDal:=C700DataDal;
  //C700Progressivo:=-1;
  C700Progressivo:=0;
  //C700FSelezioneAnagrafeDtM.OpenSelAnagrafe;
  C700FSelezioneAnagrafe.SQLCreato.Clear;
  with C700SelAnagrafe do
  begin
    if (not SelezionePeriodica) or (SelezionePeriodicaVal = 0) then
    begin
      if VariableIndex('C700DATADAL') >= 0 then
        DeleteVariable('C700DATADAL');
      if VariableIndex('C700FILTRO') >= 0 then
        DeleteVariable('C700FILTRO');
    end
    else
    begin
      if VariableIndex('C700DATADAL') < 0 then
        DeclareVariable('C700DATADAL',otDate);
      if VariableIndex('C700FILTRO') < 0 then
        DeclareVariable('C700FILTRO',otSubst);
      SetVariable('C700DATADAL',C700DataDal);
      SetVariable('C700FILTRO',OldC700Filtro);
    end;
    SetVariable('DataLavoro',C700FSelezioneAnagrafe.DataLavoro);
    CloseAll;
    SQL.Assign(OldSelAnagrafe);
    if C700FSelezioneAnagrafe.OpenC700SelAnagrafe then
    try
      Open;
      SearchRecord('PROGRESSIVO',OldC700Progressivo,[srFromBeginning]);
    except
    end;
  end;
  C700FSelezioneAnagrafe.SQLCreato.Assign(OldSQLCreato);
  C700FSelezioneAnagrafe.WhereSql:=C700FSelezioneAnagrafe.SQLCreato.Text;
  C700FSelezioneAnagrafe.CorpoSQL.Assign(OldCorpoSQL);
  C700FSelezioneAnagrafe.PulisciVecchiaSelezione:=False;
  C700SelAnagrafeBridge:=OldC700SelAnagrafeBridge;
  if C700SelAnagrafe.Active then
    btnBrowseClick(nil);
  //Alberto: resetto le condizioni opzionali
  SetSelezionePeriodica(FSelezionePeriodica);
  SetSoloPersonaleInterno(FSoloPersonaleInterno);
  SetSelezionePeriodicaVal(FSelezionePeriodicaVal);
  SetSoloPersonaleInternoVal(FSoloPersonaleInternoVal);
  SetAncheDipendentiCessatiVal(FAncheDipendentiCessatiVal);
  SettaPeriodoSelAnagrafe(C700DataLavoro,C700DataDal);
  //Gestione C004
  if OldC004Prog <> '' then
  try
    CreaC004(SessioneOracle,OldC004Prog,OldC004Utente);
  except
  end;
  if MiddlewareDM <> nil then
    MiddlewareDM.SelAnagrafe:=C700SelAnagrafe;
end;

procedure TfrmSelAnagrafe.RipristinaC00SelAnagrafe(MW: TR005FDataModuleMW);
begin
  MW.SelAnagrafe:=nil;
  RipristinaC00SelAnagrafe;
  MW.SelAnagrafe:=C700SelAnagrafe;
end;

procedure TfrmSelAnagrafe.RipristinaC700SelAnagrafeBridge;
begin
  if C700SelAnagrafeBridge.SQLCreato = '' then
    exit;
  OldSQLCreato.Text:=C700SelAnagrafeBridge.SQLCreato;
  //FSelezionePeriodica:=C700SelAnagrafeBridge.SelezionePeriodica;
  //FSoloPersonaleInterno:=C700SelAnagrafeBridge.SoloPersonaleInterno;
  if FSelezionePeriodica then
    FSelezionePeriodicaVal:=C700SelAnagrafeBridge.SelezionePeriodicaVal;
  if FSoloPersonaleInterno then
    FSoloPersonaleInternoVal:=C700SelAnagrafeBridge.SoloPersonaleInternoVal;
  FAncheDipendentiCessatiVal:=C700SelAnagrafeBridge.AncheDipendentiCessatiVal;
  //C700Progressivo:=-1;
  C700Progressivo:=0;
  C700FSelezioneAnagrafe.SQLCreato.Assign(OldSQLCreato);
  C700FSelezioneAnagrafe.WhereSql:=C700FSelezioneAnagrafe.SQLCreato.Text;
  SetSelezionePeriodica(FSelezionePeriodica);
  SetSoloPersonaleInterno(FSoloPersonaleInterno);
  SetSelezionePeriodicaVal(FSelezionePeriodicaVal);
  SetSoloPersonaleInternoVal(FSoloPersonaleInternoVal);
  SetAncheDipendentiCessatiVal(FAncheDipendentiCessatiVal);

  C700FSelezioneAnagrafe.PulisciVecchiaSelezione:=False;
  C700FSelezioneAnagrafe.actConfermaExecute(C700FSelezioneAnagrafe.actConferma);
  C700SelAnagrafe.SearchRecord('PROGRESSIVO',C700SelAnagrafeBridge.Progressivo,[srFromBeginning]);
end;

function TfrmSelAnagrafe.GetC700SelAnagrafeOrderBy:String;
var i,j:Integer;
begin
  Result:='';
  for i:=C700FSelezioneAnagrafe.SQLCreato.Count - 1 downto 0 do
    if Pos('ORDER BY',UpperCase(C700FSelezioneAnagrafe.SQLCreato[i])) > 0 then
    begin
      Result:=Copy(C700FSelezioneAnagrafe.SQLCreato[i],Pos('ORDER BY',UpperCase(C700FSelezioneAnagrafe.SQLCreato[i])),Length(C700FSelezioneAnagrafe.SQLCreato[i]));
      for j:=i + 1 to C700FSelezioneAnagrafe.SQLCreato.Count - 1 do
        Result:=Result + C700FSelezioneAnagrafe.SQLCreato[j];
      Break;
    end;
end;

procedure TfrmSelAnagrafe.PutC700SelAnagrafeOrderBy(Campo:String);
var i,j,p,x:Integer;
    S,S1:String;
begin
  S:='';
  p:=0;
  x:=-1;
  for i:=C700FSelezioneAnagrafe.SQLCreato.Count - 1 downto 0 do
  begin
    p:=Pos('ORDER BY',UpperCase(C700FSelezioneAnagrafe.SQLCreato[i]));
    if p > 0 then
    begin
      x:=i;
      S:=Copy(C700FSelezioneAnagrafe.SQLCreato[i],Pos('ORDER BY',UpperCase(C700FSelezioneAnagrafe.SQLCreato[i])),Length(C700FSelezioneAnagrafe.SQLCreato[i]));
      for j:=i + 1 to C700FSelezioneAnagrafe.SQLCreato.Count - 1 do
        S:=S +  ' ' + C700FSelezioneAnagrafe.SQLCreato[j];
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
    for i:=C700FSelezioneAnagrafe.SQLCreato.Count - 1 downto x + 1 do
      C700FSelezioneAnagrafe.SQLCreato.Delete(i);
    C700FSelezioneAnagrafe.SQLCreato[x]:=Copy(C700FSelezioneAnagrafe.SQLCreato[x],1,p - 1);
    if C700FSelezioneAnagrafe.SQLCreato[x] = '' then
      C700FSelezioneAnagrafe.SQLCreato.Delete(x);
  end;
  C700FSelezioneAnagrafe.SQLCreato.Add(S);
  C700FSelezioneAnagrafe.WhereSQL:=C700FSelezioneAnagrafe.SQLCreato.Text;
end;

procedure TfrmSelAnagrafe.btnSelezioneClick(Sender: TObject);
begin
  C700ModalResult:=C700SelezionaAnagrafe;
  if C700ModalResult = mrOK then
  begin
    SelezionePeriodicaVal:=C700FSelezioneAnagrafe.grpSelezionePeriodica.ItemIndex;
    SoloPersonaleInternoVal:=not C700FSelezioneAnagrafe.chkEsterni.Checked;
    AncheDipendentiCessatiVal:=C700FSelezioneAnagrafe.chkCessati.Checked;
  end;
  NumRecords;
  if C700SelAnagrafe.Active then
  begin
    VisualizzaDipendente;
    C700Progressivo:=C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    if @OnCambiaProgressivo <> nil then
      OnCambiaProgressivo;
    C700OldProgressivo:=C700Progressivo;
  end;
end;

procedure TfrmSelAnagrafe.btnBrowseClick(Sender: TObject);
begin
  if Sender <> nil then
    if Sender = btnPrimo then
      C700SelAnagrafe.First
    else if Sender = btnPrecedente then
      C700SelAnagrafe.Prior
    else if Sender = btnSuccessivo then
      C700SelAnagrafe.Next
    else if Sender = btnUltimo then
      C700SelAnagrafe.Last;
  if C700SelAnagrafe.Active then
  begin
    VisualizzaDipendente;
    C700Progressivo:=C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  end;
  if @OnCambiaProgressivo <> nil then
    OnCambiaProgressivo;
  C700OldProgressivo:=C700Progressivo;
  NumRecords;
end;

procedure TfrmSelAnagrafe.SelezionaProgressivo(Progressivo:Integer);
begin
  C700Progressivo:=Progressivo;
  C700FSelezioneAnagrafeDtM.OpenSelAnagrafe;
  btnBrowseClick(nil);
  C700OldProgressivo:=C700Progressivo;
end;

procedure TfrmSelAnagrafe.btnEreditaSelezioneClick(Sender: TObject);
var P:Integer;
begin
  P:=C700Progressivo;
  RipristinaC700SelAnagrafeBridge;
  C700SelAnagrafe.SearchRecord('PROGRESSIVO',P,[srFromBeginning]);
  NumRecords;
  VisualizzaDipendente;
  lblDipendente.Hint:=StringReplace(C700DatiVisualizzati,'T430','',[rfReplaceAll]);
  if @OnCambiaProgressivo <> nil then
    OnCambiaProgressivo;
  C700OldProgressivo:=C700Progressivo;
end;

procedure TfrmSelAnagrafe.btnRicercaClick(Sender: TObject);
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
  with C001FRicerca,C700SelAnagrafe do
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
          Locate(Copy(ElencoCampi,2,1000),Valori[0],[loCaseInsensitive,loPartialKey]);
      end;
    end;
  finally
    C001FRicerca.Free;
    (*Leak*)FreeAndNil(Valori);
    (*Leak*)FreeAndNil(Campi);
  end;
  NumRecords;
  VisualizzaDipendente;
  C700Progressivo:=C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  if @OnCambiaProgressivo <> nil then
    OnCambiaProgressivo;
  C700OldProgressivo:=C700Progressivo;
end;

procedure TfrmSelAnagrafe.R003DatianagraficiClick(Sender: TObject);
begin
  C005FDatiAnagrafici:=TC005FDatiAnagrafici.Create(nil);
  if C005DataVisualizzazione = 0 then
    C005DataVisualizzazione:=Parametri.DataLavoro;
  try
    C005FDatiAnagrafici.ShowDipendente(C700Progressivo);
  finally
    C005FDatiAnagrafici.Release;
  end;
end;

procedure TfrmSelAnagrafe.SetSelezionePeriodica(Value:Boolean);
begin
  FSelezionePeriodica:=Value;
  if C700FSelezioneAnagrafe <> nil then
  try
    C700FSelezioneAnagrafe.grpSelezionePeriodica.Enabled:=FSelezionePeriodica;
    if not FSelezionePeriodica then
      C700FSelezioneAnagrafe.grpSelezionePeriodica.ItemIndex:=0;
  except
  end;
end;

procedure TfrmSelAnagrafe.SetSoloPersonaleInterno(Value:Boolean);
begin
  FSoloPersonaleInterno:=Value;
  if C700FSelezioneAnagrafe <> nil then
  try
    C700FSelezioneAnagrafe.chkEsterni.Visible:=not FSoloPersonaleInterno;
  except
  end;
end;

procedure TfrmSelAnagrafe.SetSelezionePeriodicaVal(Value:Byte);
begin
  FSelezionePeriodicaVal:=Value;
  if C700FSelezioneAnagrafe <> nil then
  try
    C700FSelezioneAnagrafe.grpSelezionePeriodica.ItemIndex:=FSelezionePeriodicaVal;
  except
  end;
end;

procedure TfrmSelAnagrafe.SetSoloPersonaleInternoVal(Value:Boolean);
begin
  FSoloPersonaleInternoVal:=Value;
  if C700FSelezioneAnagrafe <> nil then
  try
    C700FSelezioneAnagrafe.chkEsterni.Checked:=not FSoloPersonaleInternoVal;
  except
  end;
end;

procedure TfrmSelAnagrafe.SetAncheDipendentiCessatiVal(Value:Boolean);
begin
  FAncheDipendentiCessatiVal:=Value;
  if C700FSelezioneAnagrafe <> nil then
  try
    C700FSelezioneAnagrafe.chkCessati.Checked:=FAncheDipendentiCessatiVal;
  except
  end;
end;

procedure TfrmSelAnagrafe.SetElaborazioneInterrompibile(Value:Boolean);
var f:TControl;
begin
  FElaborazioneInterrompibile:=Value;
  C700FSelezioneAnagrafeDtM.FElaborazioneInterrompibile:=Value;
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

procedure TfrmSelAnagrafe.FormKeyPress(Sender: TObject; var Key: Char);
{Per bloccare l'elaborazione col tasto ESC}
begin
  if Key = #27 then
    if MessageDlg('Interrompere l''elaborazione?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      C700SelAnagrafe.Last;
      ElaborazioneInterrotta:=True;
    end;
end;

function TfrmSelAnagrafe.GetCampiAbilitatiC700:String;
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

procedure TfrmSelAnagrafe.DistruggiSelAnagrafe;
begin
  FreeAndNil(OldSelAnagrafe);
  FreeAndNil(OldCorpoSQL);
  FreeAndNil(OldSQLCreato);
  C700Chiamante:='';
  C700Distruzione;
end;

end.
