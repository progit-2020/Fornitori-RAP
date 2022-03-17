unit C004UParamForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Oracle, DB,
  OracleData, (*Forms, Dialogs,*) Variants;

type
  TC004FParamForm = class(TDataModule)
    selT001: TOracleDataSet;
    DelT001: TOracleQuery;
    InsT001: TOracleQuery;
    selI070: TOracleDataSet;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetParametro(Nome,ValDef:String):String;
    procedure PutParametro(Nome,Valore:String);
    procedure Cancella001;
  end;

var
  C004FParamForm: TC004FParamForm;

function CreaC004(Sessione:TOracleSession; Programma:String; Utente:String; Globale:Boolean = True):TC004FParamForm; overload;
function CreaC004(Sessione:TOracleSession; Programma:String; ProgOperatore:Integer; Globale:Boolean = True):TC004FParamForm; overload;

implementation

{$R *.DFM}

function CreaC004(Sessione:TOracleSession; Programma:String; Utente:String; Globale:Boolean = True):TC004FParamForm;
{Creazione del datamodule con i componenti linkati al database specificato}
var i:Integer;
begin
  Result:=TC004FParamForm.Create(nil);
  if Globale then
    C004FParamForm:=Result;
  with Result do
  begin
    for i:=0 to ComponentCount - 1 do
    begin
      if Components[i] is TOracleQuery then
        (Components[i] as TOracleQuery).Session:=Sessione;
      if Components[i] is TOracleDataSet then
        (Components[i] as TOracleDataSet).Session:=Sessione;
    end;
    selT001.SetVariable('PROG',Programma);
    DelT001.SetVariable('PROG',Programma);
    InsT001.SetVariable('PROG',Programma);
    selT001.SetVariable('UTENTE',Utente);
    DelT001.SetVariable('UTENTE',Utente);
    InsT001.SetVariable('UTENTE',Utente);
    selT001.Open;
  end;
end;

function CreaC004(Sessione:TOracleSession; Programma:String; ProgOperatore:Integer; Globale:Boolean = True):TC004FParamForm;
{Creazione del datamodule con i componenti linkati al database specificato}
var i:Integer;
    Utente:String;
begin
  Result:=TC004FParamForm.Create(nil);
  if Globale then
    C004FParamForm:=Result;
  with Result do
  begin
    for i:=0 to ComponentCount - 1 do
    begin
      if Components[i] is TOracleQuery then
        (Components[i] as TOracleQuery).Session:=Sessione;
      if Components[i] is TOracleDataSet then
        (Components[i] as TOracleDataSet).Session:=Sessione;
    end;
    Utente:=IntToStr(ProgOperatore);
    selI070.SetVariable('PROGRESSIVO',ProgOperatore);
    selI070.Open;
    if selI070.RecordCount > 0 then
      Utente:=selI070.FieldByName('UTENTE').AsString;
    selI070.Close;
    selT001.SetVariable('PROG',Programma);
    DelT001.SetVariable('PROG',Programma);
    InsT001.SetVariable('PROG',Programma);
    selT001.SetVariable('UTENTE',Utente);
    DelT001.SetVariable('UTENTE',Utente);
    InsT001.SetVariable('UTENTE',Utente);
    selT001.Open;
  end;
end;

function TC004FParamForm.GetParametro(Nome,ValDef:String):String;
begin
  Result:=ValDef;
  if selT001.Locate('NOME',Nome,[]) then
    Result:=selT001.FieldByName('VALORE').AsString;
end;

procedure TC004FParamForm.Cancella001;
begin
  try
    DelT001.Execute;
  except
  end;
end;

procedure TC004FParamForm.PutParametro(Nome,Valore:String);
begin
  try
    with InsT001 do
    begin
      SetVariable('NOME',Nome);
      SetVariable('VALORE',Valore);
      Execute;
    end;
  except
  end;
end;

procedure TC004FParamForm.DataModuleDestroy(Sender: TObject);
begin
  selT001.Close;
  DelT001.Close;
  InsT001.Close;
end;

end.
