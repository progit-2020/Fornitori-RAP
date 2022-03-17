unit DatiBloccati;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs,
  Db, OracleData, Oracle, Variants, C180FunzioniGenerali,
  A000UCostanti, A000USessione, A000UMessaggi
  {, A000UInterfaccia} // spostata in implementation per circular reference in W001DtM
  ;

type
  TDatiBloccati = class(TOracleDataSet)
  private
    function SessioneOracle:TOracleSession;
    function Parametri:TParametri;
  public
    TipoLog,MessaggioLog: String;
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    function  CheckDatoBloccato(Progressivo:Integer; Data:TDateTime; Riepilogo:String; IgnoraElusione:Boolean = False):Boolean;
    function  DatoBloccato(Progressivo:Integer; Data:TDateTime; Riepilogo:String; IgnoraElusione:Boolean = False):Boolean;
    procedure BloccaRiepilogo(Progressivo:Integer; Dal,Al:TDateTime; Riepilogo:String; Utente:String = '');
    procedure SbloccaRiepilogo(Progressivo:Integer; Dal,Al:TDateTime; Riepilogo:String);
    function MeseBloccoRiepiloghi(Data:TDateTime):TDateTime;
  end;

procedure Register;

implementation

uses A000UInterfaccia;

procedure Register;
begin
  RegisterComponents('Samples', [TDatiBloccati]);
end;

constructor TDatiBloccati.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  ReadBuffer:=2;
  Session:=SessioneOracle;
  //if (AOwner <> nil) and (AOwner is TOracleSession) then
  //  Session:=TOracleSession(AOwner);
  SQL.Add('SELECT COGNOME|| '' '' ||NOME NOME,MATRICOLA,BADGE FROM T180_DATIBLOCCATI T180, T030_ANAGRAFICO T030, T430_STORICO T430');
  SQL.Add('WHERE T180.PROGRESSIVO = T030.PROGRESSIVO AND T030.PROGRESSIVO = T430.PROGRESSIVO(+) AND');
  SQL.Add(':DATA BETWEEN T430.DATADECORRENZA(+) AND T430.DATAFINE(+) AND T030.PROGRESSIVO = :PROGRESSIVO AND');
  SQL.Add(':DATA BETWEEN T180.DAL AND T180.AL AND T180.RIEPILOGO = :RIEPILOGO');  //LORENA 22/07/2004
  DeclareVariable('PROGRESSIVO',otInteger);
  DeclareVariable('DATA',otDate);
  DeclareVariable('RIEPILOGO',otString);
  TipoLog:='F';
  MessaggioLog:='';
end;

procedure TDatiBloccati.BloccaRiepilogo(Progressivo:Integer; Dal,Al:TDateTime; Riepilogo:String; Utente:String = '');
begin
  with TOracleQuery.Create(nil) do
  try
    Session:=Self.Session;
    SQL.Add('begin');
    SQL.Add('T180P_BLOCCARIEPILOGHI(:progressivo,:riepilogo,:dal,:al,:utente);');
    SQL.Add('end;');
    DeclareAndSet('PROGRESSIVO',otInteger,Progressivo);
    DeclareAndSet('RIEPILOGO',otString,Riepilogo);
    DeclareAndSet('DAL',otDate,Dal);
    DeclareAndSet('AL',otDate,Al);
    DeclareAndSet('UTENTE',otString,Utente);
    Execute;
  finally
    Free;
  end;
end;

procedure TDatiBloccati.SbloccaRiepilogo(Progressivo:Integer; Dal,Al:TDateTime; Riepilogo:String);
begin
  with TOracleQuery.Create(nil) do
  try
    Session:=Self.Session;
    SQL.Add('begin');
    SQL.Add('T180P_SBLOCCARIEPILOGHI(:progressivo,:riepilogo,:dal,:al);');
    SQL.Add('end;');
    DeclareAndSet('PROGRESSIVO',otInteger,Progressivo);
    DeclareAndSet('RIEPILOGO',otString,Riepilogo);
    DeclareAndSet('DAL',otDate,Dal);
    DeclareAndSet('AL',otDate,Al);
    Execute;
  finally
    Free;
  end;
end;

function TDatiBloccati.SessioneOracle:TOracleSession;
begin
  if Owner is TOracleSession then
    Result:=TOracleSession(Owner)
  else if Owner is TSessioneIrisWin then
    Result:=TSessioneIrisWin(Owner).SessioneOracle
  else
    Result:=A000UInterfaccia.SessioneOracle;
end;

function TDatiBloccati.Parametri:TParametri;
begin
  if Owner is TSessioneIrisWin then
    Result:=TSessioneIrisWin(Owner).Parametri
  else if (Owner is (TOracleSession)) and (TOracleSession(Owner).Owner is TSessioneIrisWin) then
    Result:=TSessioneIrisWin(TOracleSession(Owner).Owner).Parametri
  else
    Result:=A000UInterfaccia.Parametri;
end;

function TDatiBloccati.CheckDatoBloccato(Progressivo:Integer; Data:TDateTime; Riepilogo:String; IgnoraElusione:Boolean = False):Boolean;
begin
  Result:=False;
  MessaggioLog:='';
  if (not IgnoraElusione) and (Parametri.AbilitaSchedeChiuse = 'S') then
    exit;
  Close;
  R180SetVariable(Self,'PROGRESSIVO',Progressivo);
  R180SetVariable(Self,'DATA',Data);
  R180SetVariable(Self,'RIEPILOGO',Riepilogo);
  Open;
  Result:=RecordCount > 0;
end;

function TDatiBloccati.DatoBloccato(Progressivo:Integer; Data:TDateTime; Riepilogo:String; IgnoraElusione:Boolean = False):Boolean;
var
  S: String;
begin
  Result:=CheckDatoBloccato(Progressivo,Data,Riepilogo,IgnoraElusione);
  if Result then
  try
    S:=Format(A000MSG_DATIBLOCCATI_ERR_FMT_DATI_NONMODIF,[FormatDateTime('dd/mm/yyyy',Data),Riepilogo]);
    if TipoLog = 'F' then
      RegistraMsg.InserisciMessaggio('B',S,'',Progressivo)
    else
      MessaggioLog:=S;
  except
  end;
end;

destructor TDatiBloccati.Destroy;
begin
  Close;
  inherited Destroy;
end;

function TDatiBloccati.MeseBloccoRiepiloghi(Data: TDateTime): TDateTime;
begin
  Result:=R180InizioMese(Data);
  if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
  begin
    if Data < R180InizioMeseSettimanale(Data,False) then
      Result:=R180AddMesi(Result,-1);
  end;
end;

end.





