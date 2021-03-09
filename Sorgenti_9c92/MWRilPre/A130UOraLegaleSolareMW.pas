unit A130UOraLegaleSolareMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, OracleData, Oracle;

type
  TA130ModalResultEvents = procedure(Incremento:Integer) of object;

  TA130FOraLegaleSolareMW = class(TR005FDataModuleMW)
    selT100: TOracleDataSet;
    selT100MATRICOLA: TStringField;
    selT100NOMINATIVO: TStringField;
    selT100DATA: TDateTimeField;
    selT100ORA: TStringField;
    selT100ORANEW: TStringField;
    selT100VERSO: TStringField;
    selT100RILEVATORE: TStringField;
    selT100CAUSALE: TStringField;
    selT100FLAG: TStringField;
    selT100PROGRESSIVO: TFloatField;
    selT361: TOracleDataSet;
    selT370: TOracleDataSet;
    selT370MATRICOLA: TStringField;
    selT370NOMINATIVO: TStringField;
    selT370DATA: TDateTimeField;
    selT370ORA: TStringField;
    selT370NEWORA: TStringField;
    selT370VERSO: TStringField;
    selT370RILEVATORE: TStringField;
    selT370CAUSALE: TStringField;
    selT370FLAG: TStringField;
    selT370PROGRESSIVO: TFloatField;
    Update: TOracleQuery;
    selTSalva: TOracleDataSet;
    dscSelT100: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    function LunghezzaCampo(F: TField): Integer;
  public
    dtsTimb:TOracleDataSet;
    DataDa,DataA:TDateTime;
    OraDa,OraA,OrologiTimbratura:String;
    IndiceTimbratura,IndiceOra:Integer;
    IncrementEvent:TA130ModalResultEvents;
    procedure ModificaOra;
    procedure SelezionaTimbrature;
    function CreaTestoFile(Intestazione: Boolean):String;
  end;


implementation

uses A000UInterfaccia;

{$R *.dfm}

procedure TA130FOraLegaleSolareMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  dscSelT100.DataSet:=selT100;
end;

procedure TA130FOraLegaleSolareMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  if dtsTimb <> nil then
    FreeAndNil(dtsTimb);
end;

function TA130FOraLegaleSolareMW.CreaTestoFile(Intestazione: Boolean):String;
var S:String;
    i:Integer;
begin
  with dscSelT100.DataSet do
  begin
    First;
    DisableControls;
    if Intestazione then
    begin
      S:='';
      for i:=0 to FieldCount - 1 do
        if Fields[i].Visible then
          S:=S + Format('%-*s',[Lunghezzacampo(Fields[i]),Copy(Fields[i].FieldName,1,Lunghezzacampo(Fields[i]))]);
      S:=S+' '+#13#10;
    end;
    while not Eof do
    begin
      for i:=0 to FieldCount - 1 do
        if Fields[i].Visible then
          S:=S + Format('%-*s',[Lunghezzacampo(Fields[i]), Copy(Fields[i].AsString,1,Lunghezzacampo(Fields[i]))]);
      S:=S+' '+#13#10;
      Next;
    end;
    First;
    EnableControls;
  end;
  Result:=S;
end;

function TA130FOraLegaleSolareMW.LunghezzaCampo(F:TField):Integer;
begin
  if F is TStringField then
    Result:=F.Size
  else
    Result:=F.DisplayWidth;
  if F.Index < F.DataSet.FieldCount then
    inc(Result);
end;

procedure TA130FOraLegaleSolareMW.ModificaOra;
var data: TDateTime;
begin
  try
    if IndiceTimbratura = 0 then
      selTSalva.SetVariable('TABELLA','T100_SALVA_CAMBIOORA')
    else
      selTSalva.SetVariable('TABELLA','T370_SALVA_CAMBIOORA');
    selTSalva.Open;
    dtsTimb.First;
    dtsTimb.DisableControls;
    while not dtsTimb.Eof do
    begin
      data:=dtsTimb.FieldByName('DATA').AsDateTime;
      if (IndiceOra = 0) and (Copy(dtsTimb.FieldByName('NEWORA').AsString,1,2) = '23') then
        data:=data - 1
      else
      begin
        if (IndiceOra = 1) and (Copy(dtsTimb.FieldByName('NEWORA').AsString,1,2) = '0') then
          data:=data + 1;
      end;
      selTSalva.Append;
      selTSalva.FieldByName('PROGRESSIVO').AsInteger:=dtsTimb.FieldByName('PROGRESSIVO').AsInteger;
      selTSalva.FieldByName('DATA').AsDateTime:=dtsTimb.FieldByName('DATA').AsDateTime;
      selTSalva.FieldByName('ORA').AsDateTime:=StrToDateTime('01/01/1900 '+dtsTimb.FieldByName('ORA').AsString);
      selTSalva.FieldByName('VERSO').AsString:=dtsTimb.FieldByName('VERSO').AsString;
      selTSalva.FieldByName('FLAG').AsString:=dtsTimb.FieldByName('FLAG').AsString;
      selTSalva.FieldByName('RILEVATORE').AsString:=dtsTimb.FieldByName('RILEVATORE').AsString;
      selTSalva.FieldByName('CAUSALE').AsString:=dtsTimb.FieldByName('CAUSALE').AsString;
      selTSalva.FieldByName('ID_RIGA').AsString:=dtsTimb.RowId;
      selTSalva.Post;
      Update.Close;
      if IndiceTimbratura = 0 then
        Update.SetVariable('TABELLA','T100_TIMBRATURE')
      else if IndiceTimbratura = 1 then
        Update.SetVariable('TABELLA','T370_TIMBMENSA');
      Update.SetVariable('DATA',data);
      Update.SetVariable('ORA','01/01/1900 ' + dtsTimb.FieldByName('NEWORA').AsString);
      Update.SetVariable('RI',dtsTimb.RowId);
      Update.Execute;
      if Assigned(IncrementEvent) then
        IncrementEvent(1);
      dtsTimb.Next;
    end;
    SessioneOracle.Commit;
    selTSalva.Close;
  finally
    dtsTimb.First;
    dtsTimb.EnableControls;
  end;
end;

procedure TA130FOraLegaleSolareMW.SelezionaTimbrature;
var orologi: String;
    minuti: Integer;
begin
  dscSelT100.DataSet:=dtsTimb;
  dtsTimb.Close;
  //dtsTimb.ClearVariables;
  dtsTimb.SetVariable('DATADA',DataDa);
  dtsTimb.SetVariable('ORADA',OraDa);
  dtsTimb.SetVariable('DATAA',DataA);
  dtsTimb.SetVariable('ORAA',OraA);
  if IndiceOra= 0 then
    minuti:=23
  else
    minuti:=25;
  dtsTimb.SetVariable('MINUTI',minuti);
  if OrologiTimbratura <> '' then
  begin
    orologi:=StringReplace(OrologiTimbratura,',',''''+','+'''',[rfReplaceAll]);
    orologi:='AND RILEVATORE IN ('+''''+orologi+''''+')';
    dtsTimb.SetVariable('OROLOGI',orologi);
  end;
  dtsTimb.Open;
end;

end.
