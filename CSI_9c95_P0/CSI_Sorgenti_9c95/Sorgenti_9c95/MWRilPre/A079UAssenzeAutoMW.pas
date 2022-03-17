unit A079UAssenzeAutoMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Oracle, R005UDataModuleMW, A000UInterfaccia, A000USessione, A000UMessaggi;

type
  TA079FAssenzeAutoMW = class(TR005FDataModuleMW)
    AssenzeAuto: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    DaData,AData:TDateTime;
    procedure InserimentoAutomaticoAssenze;
    procedure ControllaDate(sDal,sAl:String);
  end;

implementation

{$R *.dfm}

procedure TA079FAssenzeAutoMW.DataModuleCreate(Sender: TObject);
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  inherited;
end;

procedure TA079FAssenzeAutoMW.ControllaDate(sDal,sAl:String);
begin
  try
    DaData:=StrToDate(sDal);
    AData:=StrToDate(sAl);
    if AData < DaData then
      Abort;
  except
    raise Exception.Create(A000MSG_ERR_DATE_RIFERIMENTO);
  end;
end;

procedure TA079FAssenzeAutoMW.InserimentoAutomaticoAssenze;
begin
  with AssenzeAuto do
  begin
    SetVariable('Prog',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('Dal',DaData);
    SetVariable('Al',AData);
    Execute;
  end;
end;

end.
