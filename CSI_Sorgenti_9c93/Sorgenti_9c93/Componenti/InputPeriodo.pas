unit InputPeriodo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ComCtrls, DateUtils,
  Vcl.StdCtrls, Vcl.Mask, Vcl.WinXPickers, Vcl.Buttons, Math,
  A003UDataLavoroBis, C180FunzioniGenerali;

type
  TAutoCompletamento = (acNessuno, acGiorno, acMese);
  TFormatoData = (fdGiorno, fdMese, fdAnno);

  TfrmInputPeriodo = class(TFrame)
    edtInizio: TMaskEdit;
    edtFine: TMaskEdit;
    lblInizio: TLabel;
    lblFine: TLabel;
    btnIndietro: TBitBtn;
    btnAvanti: TBitBtn;
    btnDataInizio: TBitBtn;
    btnDataFine: TBitBtn;
    procedure edtInizioExit(Sender: TObject);
    procedure edtFineDblClick(Sender: TObject);
    procedure btnIndietroClick(Sender: TObject);
    procedure btnAvantiClick(Sender: TObject);
    procedure btnDataInizioClick(Sender: TObject);
    procedure btnDataFineClick(Sender: TObject);
    procedure edtDataChange(Sender: TObject);
  private
    FAutoCompletamento: TAutoCompletamento;
    _FormatoData: CHAR;
    _CaptionDataOutI: string;
    _CaptionDataOutF: string;
    function CalcolaDeltaGiorni: integer;
    function CalcolaDeltaMesi: integer;
    function MesiInteri: Boolean;
    function StrDataF(Value: TDateTime) : string;
    function ValidateData: Boolean;

    procedure AggiornaMsgBtn;
    procedure StepData(pMoltiplica: SmallInt);

    { Metodi Property }
    function _GetDataInizio: TDateTime;
    procedure _PutDataInizio(const Value: TDateTime);
    function _GetDataFine: TDateTime;
    procedure _PutDataFine(const Value: TDateTime);
    procedure _PutFormatoData(const Value: TFormatoData);
    function _GetFormatoData: TFormatoData;
    procedure _PutCaptionDataOutI(const Value: String);
    function _GetCaptionDataOutI: String;
    procedure _PutCaptionDataOutF(const Value: String);
    function _GetCaptionDataOutF: String;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent) ; override;

    { Property }
    property DataInizio:TDateTime read _GetDataInizio write _PutDataInizio;
    property DataFine:TDateTime read _GetDataFine write _PutDataFine;
    property FormatoData:TFormatoData read _GetFormatoData write _PutFormatoData;
    property AutoCompletamento:TAutoCompletamento read FAutoCompletamento write FAutoCompletamento;
    property CaptionDataOutI:String read _GetCaptionDataOutI write _PutCaptionDataOutI; //Caption della maschera inserimento data
    property CaptionDataOutF:String read _GetCaptionDataOutF write _PutCaptionDataOutF; //Caption della maschera inserimento data
  end;

implementation

{$R *.dfm}

constructor TfrmInputPeriodo.Create(AOwner: TComponent);
  begin
    inherited Create(AOwner) ;
    AutoCompletamento:=acMese;
    FormatoData:=fdGiorno;
    //CaptionDataOutI:=lblInizio.Caption;
    //CaptionDataOutF:=lblFine.Caption;
  end;

{ FormatoData }
function TfrmInputPeriodo._GetFormatoData: TFormatoData;
begin
  if _FormatoData = 'M' then Result:=fdMese
  else if _FormatoData = 'A' then Result:=fdAnno
  else Result:=fdGiorno;
end;

procedure TfrmInputPeriodo._PutFormatoData(const Value: TFormatoData);
var strMask: string;
begin
  case Value of
  fdGiorno:
    begin
      _FormatoData:='G';
      strMask:='!00/00/0000;1;_';
    end;
  fdMese:
    begin
      _FormatoData:='M';
      strMask:='!00/0000;1;_';
    end;
  fdAnno:
    begin
      _FormatoData:='A';
      strMask:='!0000;1;_';
    end;
  end;

  edtInizio.EditMask:=strMask;
  edtFine.EditMask:=strMask;
end;
{ FormatoData ---------}

function TfrmInputPeriodo.StrDataF(Value: TDateTime) : string;
begin
  case FormatoData of
    fdGiorno: Result:=DateTimeToStr(Value);
    fdMese: Result:=FormatDateTime('mm/yyyy', Value);
    fdAnno: Result:=FormatDateTime('yyyy', Value);
  end;
end;

{   CaptionDataOutI   }
procedure TfrmInputPeriodo._PutCaptionDataOutI(const Value: String);
begin
  _CaptionDataOutI:=Value;
end;
function TfrmInputPeriodo._GetCaptionDataOutI: String;
begin
  If _CaptionDataOutI <> '' then Result:=_CaptionDataOutI
    else Result:=lblInizio.Caption;
end;
{   CaptionDataOutI ----}

{   CaptionDataOutF   }
procedure TfrmInputPeriodo._PutCaptionDataOutF(const Value: String);
begin
  _CaptionDataOutF:=Value;
end;
function TfrmInputPeriodo._GetCaptionDataOutF: String;
begin
  If _CaptionDataOutF <> '' then Result:=_CaptionDataOutF
    else Result:=lblFine.Caption;
end;
{   CaptionDataOutF ----}

{ DataInizio }
function TfrmInputPeriodo._GetDataInizio: TDateTime;
var strData : string;
begin

  try
    case FormatoData of
      fdGiorno: strData:=edtInizio.Text;
      fdMese: strData:='01/' + edtInizio.Text;
      fdAnno: strData:='01/01/' + edtInizio.Text;
    end;
    result:=StrToDate(strData);
  except
    result:=0;
  end;
end;

procedure TfrmInputPeriodo._PutDataInizio(const Value: TDateTime);
begin
  if Value > 0 then
    edtInizio.Text:=StrDataF(Value)
  else
    edtInizio.Clear;
end;
{ DataInizio ---------}

{ DataFine }
function TfrmInputPeriodo._GetDataFine: TDateTime;
begin
  try
    Result:=0;
    case FormatoData of
      fdGiorno: Result:=StrToDate(edtFine.Text);
      fdMese: Result:=R180FineMese(StrToDate('01/' + edtFine.Text));
      fdAnno: Result:=StrToDate('31/12/' + edtFine.Text);
    end;
  except
    Result:=0;
  end;
end;

procedure TfrmInputPeriodo._PutDataFine(const Value: TDateTime);
begin
  if Value > 0 then
    edtFine.Text:=StrDataF(Value)
  else
    edtFine.Clear;
end;
{ DataFine ---------}

procedure TfrmInputPeriodo.btnDataFineClick(Sender: TObject);
begin
  DataFine:=DataOut(DataFine, CaptionDataOutF, _FormatoData, False);
end;

procedure TfrmInputPeriodo.btnDataInizioClick(Sender: TObject);
var tmp : TDateTime;
begin
  tmp:=DataInizio;
  DataInizio:=DataOut(DataInizio, CaptionDataOutI, _FormatoData, False);
  if tmp <> DataInizio then edtInizioExit(nil); //forza la procedura dell'exit se la data è cambiata
end;

{Aggiorna l'hitn di btnAvanti e btnIndietro}
procedure TfrmInputPeriodo.AggiornaMsgBtn;
var strMsg: string;
begin
  if ValidateData then
  begin
    btnIndietro.Hint:='Periodo precedente di ';
    btnAvanti.Hint:='Periodo successivo di ';

    if MesiInteri then strMsg:=IntToStr(CalcolaDeltaMesi) + ' mesi'
      else strMsg:=IntToStr(CalcolaDeltaGiorni) + ' giorni';
    btnIndietro.Hint:=btnIndietro.Hint + strMsg;
    btnAvanti.Hint:=btnAvanti.Hint + strMsg;
  end
  else
  begin
    btnIndietro.Hint:='Compilare i campi data';
    btnAvanti.Hint:=btnIndietro.Hint
  end;
end;

procedure TfrmInputPeriodo.btnAvantiClick(Sender: TObject);
begin
  StepData(+1);
end;

procedure TfrmInputPeriodo.btnIndietroClick(Sender: TObject);
begin
  StepData(-1);
end;

{ Controlla che l'intervallo inserito sia valido }
function TfrmInputPeriodo.ValidateData : Boolean;
begin
  if (DataInizio > 0) and (DataFine > 0) then
    Result:=DataFine >= DataInizio
  else
    Result:=False;
end;

{ Calcola la differenza di mesi tra le date inserite arrondata per eccesso}
function TfrmInputPeriodo.CalcolaDeltaMesi() : integer;
begin
  result:=MonthsBetween(DataInizio, DataFine) + 1;
end;

{ Calcola la differenza di giorni tra le date inserite }
function TfrmInputPeriodo.CalcolaDeltaGiorni() : integer;
begin
  result:=Trunc(DataFine - DataInizio) + 1;
end;

{ Se True le date inserite coincidono con inizio e fine mese }
function  TfrmInputPeriodo.MesiInteri(): Boolean;
begin
  if (R180InizioMese(DataInizio) = DataInizio) and
     (R180FineMese(DataFine) = DataFine) then
    Result:=True
  else
    Result:=False;
end;

{ Sposta in avanti o indietro le date per il periodo inserito }
procedure TfrmInputPeriodo.StepData(pMoltiplica: SmallInt);
var Periodo: integer;
    DeltaMesi: integer;
begin
  if (DataInizio = 0) or (DataFine = 0) then
    exit;

  if ValidateData then
    if MesiInteri then
    begin
      DeltaMesi:=pMoltiplica * CalcolaDeltaMesi;
      DataInizio:=R180InizioMese(IncMonth(DataInizio, DeltaMesi));
      DataFine:=R180FineMese(IncMonth(DataFine, DeltaMesi));
    end
  else
  begin
    Periodo:=CalcolaDeltaGiorni;   //DataFine - DataInizio + 1 giorno;
    DataInizio:=DataInizio + pMoltiplica * Periodo;
    DataFine:=DataFine + pMoltiplica * Periodo;
  end
  else raise Exception.Create('Intervallo non valido');
end;

procedure TfrmInputPeriodo.edtDataChange(Sender: TObject);
var strMsg: string;
begin
  {Gestione dell'eccezione della TMaskEdit}
  if StringReplace(TMaskEdit(Sender).Text,' ','',[rfReplaceAll]) = '//' then
    TMaskEdit(Sender).Modified:=False;

  {Aggiorna gli hint di btnAvanti e btnIndietro}
  AggiornaMsgBtn;

  {Gestione dell'hint su edtFine}
  if Sender = edtInizio then
  begin
    strMsg:='Data fine periodo';
    if (DataInizio > 0) and (FormatoData = fdGiorno) then
    begin
      strMsg:=strMsg + chr(10) + chr(13) + 'Doppio click per impostare ';
      case AutoCompletamento of
        acNessuno: ;
        acGiorno: strMsg:=strMsg + FormatDateTime('dd/mm/yyyy',DataInizio);
        acMese: strMsg:=strMsg + FormatDateTime('dd/mm/yyyy', R180FineMese(DataInizio));
      end;
    end;
    edtFine.Hint:=strMsg;
  end;
end;

procedure TfrmInputPeriodo.edtFineDblClick(Sender: TObject);
{assegno la fine in base all'inizio}
begin
  if (DataInizio <= 0) or ((FormatoData <> fdGiorno) and (FormatoData <> fdMese)) then
    exit;

  case AutoCompletamento of
    acNessuno: exit;
    acGiorno:  DataFine:=DataInizio;
    acMese:    DataFine:=R180FineMese(DataInizio);
  end;
end;

procedure TfrmInputPeriodo.edtInizioExit(Sender: TObject);
{Se Fine nulla o minore di Inizio assegno automaticamente la fine in base all'inizio}
begin
  if DataInizio <= 0 then
    exit;

  case AutoCompletamento of
    acNessuno: exit;
    acGiorno:  DataFine:=IfThen(DataInizio > DataFine, DataInizio, DataFine);
    acMese:    DataFine:=IfThen(DataInizio > DataFine, R180FineMese(DataInizio), DataFine);
  end;
end;

end.
