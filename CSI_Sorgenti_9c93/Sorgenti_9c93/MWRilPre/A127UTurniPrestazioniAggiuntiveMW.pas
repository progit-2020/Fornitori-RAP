unit A127UTurniPrestazioniAggiuntiveMW;

interface

uses
  OracleData, DB, SysUtils, R005UDataModuleMW, A000UInterfaccia, A000UMessaggi;

type
  TA127FTurniPrestazioniAggiuntiveMW = class(TR005FDataModuleMW)
  private
    { Private declarations }
  public
    selT330: TOracleDataSet;
    procedure selT330AfterPost;
    procedure selT330BeforePost;
    procedure selT330ORAINIZIOGetText(Sender: TField; var Text: string);
    procedure selT330ORAINIZIOSetText(Sender: TField; const Text: String);
  end;

implementation

{$R *.dfm}

procedure TA127FTurniPrestazioniAggiuntiveMW.selT330AfterPost;
var S:String;
begin
  S:=selT330.FieldByName('CODICE').AsString;
  selT330.Close;
  selT330.Open;
  selT330.Locate('Codice',S,[]);
end;

procedure TA127FTurniPrestazioniAggiuntiveMW.selT330BeforePost;
begin
  if QueryPK1.EsisteChiave('T330_REG_ATT_AGGIUNTIVE',selT330.RowId,selT330.State,['CODICE'],[selT330.FieldByName('Codice').AsString]) then
    raise Exception.Create(A000MSG_ERR_CODICE_ESISTENTE);
end;

procedure TA127FTurniPrestazioniAggiuntiveMW.selT330ORAINIZIOGetText(Sender: TField; var Text: string);
begin
  if Sender.IsNull then Text:='' else Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

procedure TA127FTurniPrestazioniAggiuntiveMW.selT330ORAINIZIOSetText(Sender: TField; const Text: String);
begin
  {$I CampoOra}
end;

end.
