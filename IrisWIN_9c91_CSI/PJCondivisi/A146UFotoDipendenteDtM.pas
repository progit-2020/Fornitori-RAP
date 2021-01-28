unit A146UFotoDipendenteDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, A000UInterfaccia, DB, OracleData, C180FunzioniGenerali;

type
  TA146FFotoDipendenteDtM = class(TR004FGestStoricoDtM)
    selT032: TOracleDataSet;
    selT032FOTO: TBlobField;
    selT032PROGRESSIVO: TIntegerField;
    selT032FILE_FOTO: TStringField;
    DT032: TDataSource;
    procedure selT032NewRecord(DataSet: TDataSet);
    procedure selT032BeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A146FFotoDipendenteDtM: TA146FFotoDipendenteDtM;

implementation

uses A146UFotoDipendente;

{$R *.dfm}

procedure TA146FFotoDipendenteDtM.selT032BeforePost(DataSet: TDataSet);
begin
  if Not FileExists(selT032FILE_FOTO.AsString) and (Not selT032FILE_FOTO.isNull) then
  begin
    selT032FILE_FOTO.Clear;
    Raise Exception.Create('Percorso file inesistente');
  end;
  inherited;  
end;

procedure TA146FFotoDipendenteDtM.selT032NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT032PROGRESSIVO.AsInteger:=A146FFotoDipendente.Progressivo;
end;

end.
