unit QueryPK;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, OracleData, Oracle, Variants, C180FunzioniGenerali;

type
  TQueryPK = class(TOracleDataSet)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    function EsisteChiave(Tabella,RigaID:String; Stato:TDataSetState; Colonne,Valori:array of String):Boolean;
    function EsisteStoricoSucc(Tabella,Rowid:String; Decorrenza:TDateTime; Colonne,Valori:array of String;const CampoDecorrenza:String = 'DECORRENZA'):Boolean;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TQueryPK]);
end;

constructor TQueryPK.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
end;

function TQueryPK.EsisteChiave(Tabella,RigaID:String; Stato:TDataSetState; Colonne,Valori:array of String):Boolean;
{ Controllo se esistono righe con i valori specificati }
var S:String;
    i:Integer;
begin
  Result:=False;
  Close;
  S:='';
  for i:=0 to High(Colonne) do
    if i <= High(Valori) then
      begin
      if S <> '' then
        S:=S + ' AND ';
      S:=S + Colonne[i] + '=' + '''' + AggiungiApice(Valori[i]) + '''';
      end;
  SQL.Clear;
  SQL.Add(Format('SELECT COUNT(*) FROM %s WHERE %s',[Tabella,S]));
  if (Stato = dsEdit) and (RigaID <> '') then
    SQL.Add(Format('AND ROWID <> ''%s''',[RigaID]));
  try
    S:=SQL.Text;
    Open;
    Result:=Fields[0].AsInteger > 0;
  except
  end;
  Close;
end;

function TQueryPK.EsisteStoricoSucc(Tabella,Rowid:String; Decorrenza:TDateTime; Colonne,Valori:array of String;const campoDecorrenza : String ='DECORRENZA'):Boolean;
{Controllo se esistono righe con i valori specificati}
var S:String;
    i:Integer;
begin
  Result:=False;
  Close;
  S:='';
  for i:=0 to High(Colonne) do
  begin
    if UpperCase(Colonne[i]) = UpperCase(campoDecorrenza) then
      Continue;
    if i <= High(Valori) then
      begin
      if S <> '' then
        S:=S + ' AND ';
      S:=S + Colonne[i] + '=' + '''' + Valori[i] + '''';
      end;
  end;
  SQL.Clear;
  if S = '' then
    S:='1 = 1';
  SQL.Add(Format('SELECT COUNT(*) FROM %s WHERE %s AND '+campoDecorrenza+' > TO_DATE(''%s'',''DDMMYYYY'') AND ROWID <> ''%s''',[Tabella,S,FormatDateTime('ddmmyyyy',Decorrenza),Rowid]));
  try
    Open;
    Result:=Fields[0].AsInteger > 0;
  except
  end;
  Close;
end;

destructor TQueryPK.Destroy;
begin
  Close;
  inherited Destroy;
end;

end.






