unit A134UAllineamentoClientDtm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData;

type
  TA134FAllineamentoClientDtm = class(TR004FGestStoricoDtM)
    selI090: TOracleDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A134FAllineamentoClientDtm: TA134FAllineamentoClientDtm;

implementation

{$R *.dfm}

end.
