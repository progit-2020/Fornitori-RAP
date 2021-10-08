unit A170UGestioneGruppiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, A170UGestioneGruppiMW;

type
  TA170FGestioneGruppiDtM = class(TR004FGestStoricoDtM)
    dsrT773Quote: TDataSource;
    dsrT767Quote: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    A170FGestioneGruppiMW: TA170FGestioneGruppiMW;
  end;

var
  A170FGestioneGruppiDtM: TA170FGestioneGruppiDtM;

implementation

{$R *.dfm}

procedure TA170FGestioneGruppiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A170FGestioneGruppiMW:=TA170FGestioneGruppiMW.Create(Self);
  dsrT773Quote.DataSet:=A170FGestioneGruppiMW.selT773Quote;
  dsrT767Quote.DataSet:=A170FGestioneGruppiMW.selT767Quote;
end;

procedure TA170FGestioneGruppiDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A170FGestioneGruppiMW);
  inherited;
end;

end.
