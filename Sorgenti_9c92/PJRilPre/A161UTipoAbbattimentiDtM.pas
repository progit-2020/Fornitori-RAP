unit A161UTipoAbbattimentiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, A161UTipoAbbattimentiMW;

type
  TA161FTipoAbbattimentiDtM = class(TR004FGestStoricoDtM)
    selT766: TOracleDataSet;
    selT766CODICE: TStringField;
    selT766DESCRIZIONE: TStringField;
    selT766RISPARMIO_BILANCIO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    A161FTipoAbbattimentiMW: TA161FTipoAbbattimentiMW;
  end;

var
  A161FTipoAbbattimentiDtM: TA161FTipoAbbattimentiDtM;

implementation

{$R *.dfm}

procedure TA161FTipoAbbattimentiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT766,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);

  A161FTipoAbbattimentiMW:=TA161FTipoAbbattimentiMW.Create(Self);
  A161FTipoAbbattimentiMW.selT766 :=selT766;

end;

end.
