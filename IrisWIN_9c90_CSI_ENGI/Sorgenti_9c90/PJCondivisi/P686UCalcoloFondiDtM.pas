unit P686UCalcoloFondiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, Oracle, DB, OracleData;

type
  TP686FCalcoloFondiDtM = class(TR004FGestStoricoDtM)
    selP684: TOracleDataSet;
    selP688: TOracleDataSet;
    selP442: TOracleDataSet;
    selP690: TOracleDataSet;
    updP684: TOracleQuery;
    updP688: TOracleQuery;
    selP050: TOracleDataSet;
    selP500: TOracleDataSet;
    selP688Conta: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  P686FCalcoloFondiDtM: TP686FCalcoloFondiDtM;

implementation

{$R *.dfm}

procedure TP686FCalcoloFondiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selP690,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
end;

end.
