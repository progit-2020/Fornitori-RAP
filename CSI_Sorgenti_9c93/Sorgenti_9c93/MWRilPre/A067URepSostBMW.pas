unit A067URepSostBMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, Oracle, DB, OracleData, A000USessione,
  A000UMessaggi, A000UInterfaccia, C180FunzioniGenerali;

type
  TA067FRepSostBMW = class(TR005FDataModuleMW)
    D265: TDataSource;
    Q265: TOracleDataSet;
    Q040: TOracleDataSet;
    Del040: TOracleQuery;
    Ins040: TOracleQuery;
    procedure Q265AfterOpen(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CorreggiAnomalia(Azione, Causale:String; P:LongInt; D:TDateTime; Min:Word);
    procedure ApriQ040(Causale:String; P:LongInt; DataDa,DataA:TDateTime);
  end;


implementation

{$R *.dfm}

procedure TA067FRepSostBMW.DataModuleCreate(Sender: TObject);
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  inherited;
  Q265.Open;
end;

procedure TA067FRepSostBMW.Q265AfterOpen(DataSet: TDataSet);
begin
  Q265.FieldByName('CODICE').DisplayWidth:=8;
end;

procedure TA067FRepSostBMW.ApriQ040(Causale:String; P:LongInt; DataDa,DataA:TDateTime);
begin
  //Lettura delle causali di assenza con causale correttiva già presenti
  Q040.Close;//DaniloA: 29/08/2013: se il dataset non viene mai chiuso, i dati sono sempre relativi al primo progressivo
  Q040.SetVariable('PROGRESSIVO',P);
  Q040.SetVariable('DATA1',DataDa);
  Q040.SetVariable('DATA2',DataA);
  Q040.SetVariable('CAUSALE',Causale);
  Q040.Open;
end;

procedure TA067FRepSostBMW.CorreggiAnomalia(Azione, Causale:String; P:LongInt; D:TDateTime; Min:Word);
  procedure CancT040;
  begin
    with Del040 do
    begin
      SetVariable('PROGRESSIVO',P);
      SetVariable('DATA',D);
      SetVariable('CAUSALE',Causale);
      Execute;
    end;
  end;
  procedure InsT040;
  begin
    with Ins040 do
    begin
      SetVariable('PROGRESSIVO',P);
      SetVariable('DATA',D);
      SetVariable('CAUSALE',Causale);
      SetVariable('DAORE',StrToTime(R180MinutiOre(Min)));
      Execute;
    end;
  end;
begin
  if Q040.Locate('DATA',D,[]) then
  begin
    if Azione = 'I' then
    begin
      if R180OreMinuti(Q040.FieldByName('DAORE').AsDateTime) <> Min then
      begin
        CancT040;
        InsT040;
      end;
    end
    else
      CancT040;
  end
  else
    if Azione = 'I' then
      InsT040;
  SessioneOracle.Commit;
end;

end.
