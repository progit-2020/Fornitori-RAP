unit Ac02ULimitiRendiProjMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, Data.DB, C180FunzioniGenerali,
  Oracle, A000USessione, A000UInterfaccia, A000UMessaggi, Variants, StrUtils;

type
  TAc02FLimitiRendiProjMW = class(TR005FDataModuleMW)
  private
    { Private declarations }
  public
    { Public declarations }
    selT753:TOracleDataset;
    procedure RiapriSelT753(Prog,iOrd:Integer);
    function OnFilterRecord(DataSet: TDataSet): Boolean;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TAc02FLimitiRendiProjMW }

procedure TAc02FLimitiRendiProjMW.RiapriSelT753(Prog,iOrd:Integer);
var OldId:Integer;
    OldDec:TDateTime;
    OBCod,OBDec:String;
begin
  with selT753 do
  begin
    OldId:=FieldByName('ID_T752').AsInteger;
    OldDec:=FieldByName('DECORRENZA').AsDateTime;
    OBCod:='c_prog, c_att, c_task';
    OBDec:='T753.decorrenza, T753.decorrenza_fine';
    SetVariable('ORDINAMENTO',IfThen(iOrd = 0,OBCod + ', ') + OBDec + IfThen(iOrd = 1,', ' + OBCod));
    SetVariable('PROGRESSIVO',Prog);
    Close;
    Open;
    if not SearchRecord('ID_T752;DECORRENZA',VarArrayOf([OldId,OldDec]),[srFromBeginning]) then
      SearchRecord('ID_T752',OldId,[srFromBeginning]);
  end;
end;

function TAc02FLimitiRendiProjMW.OnFilterRecord(DataSet: TDataSet): Boolean;
begin
  Result:=A000FiltroDizionario('PROGETTI RENDICONTABILI',DataSet.FieldByName('ID_T750').AsString);
end;

end.
