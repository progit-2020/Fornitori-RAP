unit QueryStorico;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, OracleData, Oracle, Variants, StrUtils, A000UCostanti;

const
  NumStorici = 40;

  (*
  DatiStoriciFissi:
    'Badge','EdBadge','Indirizzo','Comune','CAP','Telefono',
    'Inizio','Fine','Squadra','TipoOpe','Terminali','CausStraord',
    'StraordE','StraordU','StraordEU','Contratto','TOrario',
    'HTeoriche','TipoCart','TGestione','PlusOra','Calendario',
    'IPresenza','POrario','PAssenze','AbCausale1','AbPresenza1',
    'TipoRapporto','PartTime','StraordEU2','Docente','QUALIFICAMINIST',
    'TIPO_LOCALITA_DIST_LAVORO','COD_LOCALITA_DIST_LAVORO','Inizio_Ind_Mat',
    'Fine_Ind_Mat'
  *)

type
  TQueryStorico = class(TOracleDataSet)
  private
    { Private declarations }
    DatoOld:String;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure GetDatiStorici(Dato:String; Prog:LongInt; Data1,Data2:TDateTime);
    function LocDatoStorico(Data:TDateTime):Boolean;
    function DipendenteInServizio(Dal,Al:TDateTime):Boolean;
  published
    { Published declarations }
  end;

  TDipendenteInServizio = class(TOracleDataSet)
  private
    { Private declarations }
    DatoOld:String;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    function DipendenteInServizio(Prog:Integer; Dal,Al:TDateTime):Boolean;
  published
    { Published declarations }
  end;

  TPeriodoProva = class(TOracleQuery)   //Lorena 04/06/2008
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    FinePeriodoProva,MetaPeriodoProva:TDateTime;
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    function GetPeriodoProva(Prog,DurataProva:Integer;InizioProva:TDateTime):Boolean;
  published
    { Published declarations }
  end;

procedure Register;
function AliasTabella(Campo:String):String;

implementation

uses A000UInterfaccia;

procedure Register;
begin
  RegisterComponents('Samples', [TQueryStorico]);
  RegisterComponents('Samples', [TDipendenteInServizio]);
  RegisterComponents('Samples', [TPeriodoProva]); //Lorena 04/06/2008
end;

(*COMPONENTE TQueryStorico*)
constructor TQueryStorico.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  DatoOld:='';
  DeclareVariable('PROGRESSIVO',otInteger);
  DeclareVariable('DATA1',otDate);
  DeclareVariable('DATA2',otDate);
end;

procedure TQueryStorico.GetDatiStorici(Dato:String; Prog:LongInt; Data1,Data2:TDateTime);
{Apre la query dei dati storici richiesti nel periodo specificato}
begin
  if (Dato <> DatoOld) or (Dato = '') then
  //Costruisco la query solo se sono cambiati i dati richiesti
  begin
    CloseAll;
    DatoOld:=Dato;
    SQL.Clear;
    SQL.Add(Format('SELECT %s T430DATADECORRENZA,T430DATAFINE%s FROM V430_STORICO',[Parametri.CampiRiferimento.C26_HintT030V430,IfThen(Dato <> '',',' + Dato,'')]));
    //SQL.Add(Format('SELECT %s T430DATADECORRENZA,T430DATAFINE%s FROM V430_STORICO',['']));
    SQL.Add('WHERE T430PROGRESSIVO = :PROGRESSIVO AND');
    SQL.Add('T430DATADECORRENZA <= :DATA2 AND');
    SQL.Add('T430DATAFINE >= :DATA1');
    SQL.Add('ORDER BY T430DATADECORRENZA');
  end;
  if Prog <> GetVariable('PROGRESSIVO') then
  begin
    Close;
    SetVariable('PROGRESSIVO',Prog);
  end;
  //if (GetVariable('DATA1') = null) or (Data1 < GetVariable('DATA1'))  then
  if (GetVariable('DATA1') = null) or VarIsEmpty(GetVariable('DATA1')) or (Data1 < GetVariable('DATA1'))  then
  begin
    Close;
    SetVariable('DATA1',Data1);
  end;
  if (GetVariable('DATA2') = null) or VarIsEmpty(GetVariable('DATA2')) or (Data2 > GetVariable('DATA2')) then
  begin
    Close;
    SetVariable('DATA2',Data2);
  end;
  Open;
end;

function TQueryStorico.LocDatoStorico(Data:TDateTime):Boolean;
begin
  Result:=False;
  Last;
  if (Data > FieldByname('T430DATAFINE').AsDateTime) and (FieldByname('T430DATAFINE').AsDateTime < EncodeDate(3999,12,31)) then
  begin
    SetVariable('DATA2',Data);
    Close;
    Open;
  end;
  First;
  while not Eof do
  begin
    if (Data >= FieldByName('T430DataDecorrenza').AsDateTime) and
       (Data <= FieldByName('T430DataFine').AsDateTime) then
    begin
      Result:=True;
      Break;
    end;
    Next;
  end;
end;

function TQueryStorico.DipendenteInServizio(Dal,Al:TDateTime):Boolean;
begin
  if (FindField('T430Inizio') = nil) or (FindField('T430Fine') = nil) then
    begin
    Result:=True;
    exit;
    end;
  Result:=False;
  First;
  while not Eof do
    begin
    if ((FieldByName('T430Inizio').AsDateTime >= Dal) and (FieldByName('T430Inizio').AsDateTime <= Al))
       or
       (FieldByName('T430Inizio').AsDateTime <= Dal) and
       ((FieldByName('T430Fine').IsNull) or (FieldByName('T430Fine').AsDateTime >= Dal)) then
      begin
      Result:=True;
      Break;
      end;
    Next;
    end;
end;

destructor TQueryStorico.Destroy;
begin
  Close;
  inherited Destroy;
end;

function AliasTabella(Campo:String):String;
{Restituisce l'alias della tabella cui appartiene il campo tra:
  T030: T030_Anagrafico
  T480: T480_Comuni
  V430: V430_Storico}
var i:Integer;
begin
  Result:='';
  for i:=1 to High(CampiT030) do
    if Campo = CampiT030[i] then
    begin
      Result:='T030';
      Break;
    end;
  if Result = '' then
    for i:=1 to High(CampiT480) do
      if Campo = CampiT480[i] then
      begin
        Result:='T480';
        Break;
      end;
  if Result = '' then
    Result:='V430';
end;

(*COMPONENTE TDipendenteInServizio*)
constructor TDipendenteInServizio.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  DatoOld:='';
  SQL.Add('SELECT COUNT(*) PERIODI_SERVIZIO FROM T430_STORICO WHERE');
  SQL.Add('PROGRESSIVO = :Progressivo AND');
  SQL.Add('INIZIO <= :DataFine AND');
  SQL.Add('(NVL(FINE,:DataFine) >= :DataInizio)');
  DeclareVariable('Progressivo',otInteger);
  DeclareVariable('DataInizio',otDate);
  DeclareVariable('DataFine',otDate);
  SetVariable('Progressivo',0);
  SetVariable('DataInizio',0);
  SetVariable('DataFine',0);
end;

function TDipendenteInServizio.DipendenteInServizio(Prog:Integer; Dal,Al:TDateTime):Boolean;
begin
  if Prog <> GetVariable('Progressivo') then
  begin
    SetVariable('Progressivo',Prog);
    Close;
  end;
  if VarIsNull(GetVariable('DataInizio')) or (Dal <> VarToDateTime(GetVariable('DataInizio'))) then
  begin
    SetVariable('DataInizio',Dal);
    Close;
  end;
  if VarIsNull(GetVariable('DataFine')) or (Al <> VarToDateTime(GetVariable('DataFine'))) then
  begin
    SetVariable('DataFine',Al);
    Close;
  end;
  Open;
  Result:=FieldByName('PERIODI_SERVIZIO').AsInteger > 0;
end;

destructor TDipendenteInServizio.Destroy;
begin
  Close;
  inherited Destroy;
end;

constructor TPeriodoProva.Create(AOwner:TComponent);  //Lorena 04/06/2008
begin
  inherited Create(AOwner);
  SQL.Clear;
  SQL.Add('DECLARE');
  SQL.Add('  N NUMBER;');
  SQL.Add('BEGIN');
  SQL.Add('  WHILE :DATA1 <= :DATA2 LOOP');
  SQL.Add('    SELECT COUNT(*) INTO N FROM');
  SQL.Add('    T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265 WHERE');
  SQL.Add('    T040.PROGRESSIVO = :PROGRESSIVO AND');
  SQL.Add('    T040.DATA BETWEEN :DATA1 AND :DATA2 AND');
  SQL.Add('    T040.TIPOGIUST = ''I'' AND');
  SQL.Add('    T040.CAUSALE = T265.CODICE AND');
  SQL.Add('    T265.ALLUNGA_PROVA = ''S'';');
  SQL.Add('    :DATA1:=:DATA2 + 1;');
  SQL.Add('    :DATA2:=:DATA2 + N;');
  SQL.Add('  END LOOP;');
  SQL.Add('END;');
  DeleteVariables;
  DeclareVariable('Progressivo',otInteger);
  DeclareVariable('Data1',otDate);
  DeclareVariable('Data2',otDate);
  SetVariable('Progressivo',0);
  SetVariable('Data1',0);
  SetVariable('Data2',0);
end;

function TPeriodoProva.GetPeriodoProva(Prog,DurataProva:Integer;InizioProva:TDateTime):Boolean;  //Lorena 04/06/2008
var IP,FP:TDateTime;
begin
  FinePeriodoProva:=0;
  MetaPeriodoProva:=0;
  IP:=InizioProva;
  FP:=IP + DurataProva - 1;
  SetVariable('Progressivo',Prog);
  SetVariable('Data1',IP);
  SetVariable('Data2',FP);
  Execute;
  FinePeriodoProva:=GetVariable('DATA2');
  MetaPeriodoProva:=IP + (Trunc(FinePeriodoProva - IP) div 2);
  Result:=FinePeriodoProva <> 0;
end;

destructor TPeriodoProva.Destroy;  //Lorena 04/06/2008
begin
  inherited Destroy;
end;

end.

