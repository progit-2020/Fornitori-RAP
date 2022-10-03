unit A024UIndPresenzaMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, Oracle, DB, OracleData, A000USessione,
  A000UMessaggi, A000UInterfaccia, C180FunzioniGenerali;

type
  TA024FIndPresenzaMW = class(TR005FDataModuleMW)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    selT162:TOracleDataSet;
    procedure selT162BeforePost(DataSet: TDataSet);
  end;

implementation

{$R *.dfm}

procedure TA024FIndPresenzaMW.DataModuleCreate(Sender: TObject);
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  inherited;
end;

procedure TA024FIndPresenzaMW.selT162BeforePost(DataSet: TDataSet);
begin
  //Nuovi controlli
end;

end.
