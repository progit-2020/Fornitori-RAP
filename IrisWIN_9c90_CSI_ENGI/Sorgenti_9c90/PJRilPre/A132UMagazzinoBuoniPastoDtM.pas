unit A132UMagazzinoBuoniPastoDtM;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData,A132UMagazzinoBuoniPastoMW, R004UGESTSTORICODTM;

type
  TA132FMagazzinoBuoniPastoDtM = class(TR004FGestStoricoDtM)
    selT691: TOracleDataSet;
    selT691DATA_ACQUISTO: TDateTimeField;
    selT691DATA_SCADENZA: TDateTimeField;
    selT691BUONIPASTO: TIntegerField;
    selT691TICKET: TIntegerField;
    selT691DIM_BLOCCHETTO: TIntegerField;
    selT691ID_DAL: TFloatField;
    selT691ID_AL: TFloatField;
    dsrT691: TDataSource;
    procedure selT691BeforePost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    A132MW:TA132FMagazzinoBuoniPastoMW;
  end;

var
  A132FMagazzinoBuoniPastoDtM: TA132FMagazzinoBuoniPastoDtM;

implementation

{$R *.dfm}

procedure TA132FMagazzinoBuoniPastoDtM.DataModuleCreate(Sender: TObject);
begin
  A132MW:=TA132FMagazzinoBuoniPastoMW.Create(nil);
  A132MW.selT691:=selT691;
  inherited;
  selT691.Open;
end;

procedure TA132FMagazzinoBuoniPastoDtM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A132MW);
end;

procedure TA132FMagazzinoBuoniPastoDtM.selT691BeforePost(DataSet: TDataSet);
begin
  A132MW.selT691BeforePost;
end;

end.
