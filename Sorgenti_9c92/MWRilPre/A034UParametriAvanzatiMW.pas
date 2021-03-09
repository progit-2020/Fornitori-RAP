unit A034UParametriAvanzatiMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, OracleData, Oracle, A000UInterfaccia,
  A000UMessaggi,ControlloVociPaghe,A000UCostanti, A000USessione;

type
  TA034FParametriAvanzatiMW = class(TR005FDataModuleMW)
    selP200: TOracleDataSet;
    insT193: TOracleQuery;
    selInterfaccia: TOracleDataSet;
    dsrInterfaccia: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public
    selControlloVociPaghe:TControlloVociPaghe;
    function VerificaFormula(ValFormula:String;var Msg: String): Boolean;
    function ImpostaSelInterfaccia(DataLavoro:TDateTime): Boolean;
  end;

implementation

{$R *.dfm}

procedure TA034FParametriAvanzatiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selP200.SetVariable(':CodContratto',Parametri.CodContrattoVoci);
  selP200.Open;
  InsT193.Execute;
  SessioneOracle.Commit;
  //Caricamento voci paghe
  selControlloVociPaghe:=TControlloVociPaghe.Create(Self,'A034');
end;

function TA034FParametriAvanzatiMW.VerificaFormula(ValFormula:String;var Msg: String): Boolean;
var
  OQFormula:TOracleQuery;
  Formula: String;
begin
  Msg:='';
  Formula:=Trim(ValFormula);

  // verifica se la formula è stata impostata
  if Formula = '' then
  begin
    Result:=True;
    Exit;
  end;

  // verifica sintassi formula: "select :FORMULA from DUAL"
  OQFormula:=TOracleQuery.Create(nil);
  try
    try
      OQFormula.Session:=SessioneOracle;
      Formula:=StringReplace(Formula,':VALORE','1',[rfReplaceAll,rfIgnoreCase]);
      Formula:=StringReplace(Formula,':CODICE','''X''',[rfReplaceAll,rfIgnoreCase]);
      Formula:=StringReplace(Formula,':PROGRESSIVO','0',[rfReplaceAll,rfIgnoreCase]);
      Formula:=StringReplace(Formula,':DATA_CASSA','trunc(sysdate)',[rfReplaceAll,rfIgnoreCase]);
      Formula:=StringReplace(Formula,':DATA_COMPETENZA','trunc(sysdate)',[rfReplaceAll,rfIgnoreCase]);
      OQFormula.Sql.Text:='select ' + Formula + ' from dual';
      OQFormula.Execute;
      if OQFormula.FieldCount = 1 then
      begin
        Msg:=A000MSG_A034_MSG_FORMULA_CORRETTA;
        Result:=True;
      end
      else
      begin
        Msg:=A000MSG_A034_ERR_FORMULA_VALORI;
        Result:=False;
      end;
    except
      on E:Exception do
      begin
        if Pos('ORA-01008',E.Message) > 0 then
        begin
          // "ORA-01008: non tutte le variabili sono associate" (probabilmente la var. è digitata in modo errato)
          Msg:=A000MSG_A034_ERR_FORMULA_VARIABILE;
        end
        else
          Msg:=E.Message;
        Msg:=Format(A000MSG_A034_ERR_FMT_FORMULA_ERRORI,[Msg]);
        Result:=False;
      end;
    end;
  finally
    OQFormula.Free;
  end;
end;
procedure TA034FParametriAvanzatiMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(selControlloVociPaghe);
  inherited;
end;

function TA034FParametriAvanzatiMW.ImpostaSelInterfaccia(DataLavoro: TDateTime): Boolean;
begin
  if A000LookupTabella(Parametri.CampiRiferimento.C9_ScaricoPaghe,selInterfaccia) then
  begin
    if selInterfaccia.VariableIndex('DECORRENZA') >= 0 then
      selInterfaccia.SetVariable('DECORRENZA',DataLavoro);
    selInterfaccia.Close;
    selInterfaccia.Open;
    Result:=True;
  end
  else
    Result:=False;
end;

end.
