unit A127UTurniPrestazioniAggiuntiveDtm;

interface

uses
  DB, Classes, OracleData, Forms, Oracle, C180FunzioniGenerali,
  A000UInterfaccia, A000USessione, A127UTurniPrestazioniAggiuntiveMW;

type
  TA127FTurniPrestazioniAggiuntiveDtm = class(TDataModule)
    selT330: TOracleDataSet;
    selT330CODICE: TStringField;
    selT330DESCRIZIONE: TStringField;
    selT330ORAINIZIO: TDateTimeField;
    selT330ORAFINE: TDateTimeField;
    selT330CONTROLLO_PT: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT330AfterDelete(DataSet: TDataSet);
    procedure selT330AfterPost(DataSet: TDataSet);
    procedure selT330BeforeDelete(DataSet: TDataSet);
    procedure selT330BeforePost(DataSet: TDataSet);
    procedure selT330ORAINIZIOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure selT330ORAINIZIOSetText(Sender: TField; const Text: String);
  private
    { Private declarations }
  public
    { Public declarations }
    A127MW:TA127FTurniPrestazioniAggiuntiveMW;
  end;

var
  A127FTurniPrestazioniAggiuntiveDtm: TA127FTurniPrestazioniAggiuntiveDtm;

implementation

uses A127UTurniPrestazioniAggiuntive;

{$R *.DFM}

procedure TA127FTurniPrestazioniAggiuntiveDtm.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;
  A127MW:=TA127FTurniPrestazioniAggiuntiveMW.Create(Self);
  A127MW.selT330:=selT330;
  selT330.Open;
end;

procedure TA127FTurniPrestazioniAggiuntiveDtm.DataModuleDestroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA127FTurniPrestazioniAggiuntiveDtm.selT330AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA127FTurniPrestazioniAggiuntiveDtm.selT330AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  A127MW.selT330AfterPost;
end;

procedure TA127FTurniPrestazioniAggiuntiveDtm.selT330BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA127FTurniPrestazioniAggiuntiveDtm.selT330BeforePost(DataSet: TDataSet);
begin
  A127MW.selT330BeforePost;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA127FTurniPrestazioniAggiuntiveDtm.selT330ORAINIZIOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  A127MW.selT330ORAINIZIOGetText(Sender,Text);
end;

procedure TA127FTurniPrestazioniAggiuntiveDtm.selT330ORAINIZIOSetText(Sender: TField; const Text: String);
begin
  A127MW.selT330ORAINIZIOSetText(Sender,Text);
end;

end.
