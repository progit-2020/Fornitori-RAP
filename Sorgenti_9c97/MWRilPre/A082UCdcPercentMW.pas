unit A082UCdcPercentMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, OracleData, Oracle,A000UCostanti, A000USessione,A000UInterfaccia,
  DBClient, Provider;

type
  TAfterPost = procedure (DataSet: TDataSet) of object;

  TA082FCdcPercentMW = class(TR005FDataModuleMW)
    selCdcPercent: TOracleDataSet;
    selT430: TOracleDataSet;
    scrT433Decorrenza_Fine: TOracleQuery;
    srcCalcolaPerc: TOracleQuery;
    cdsT433: TClientDataSet;
    delT433: TOracleQuery;
    CopyT433: TOracleQuery;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FselT433_Funzioni: TOracleDataset;
  public
    SituazioneModificata:Boolean;
    procedure CopiaMassivaCDC(ProgOrig,ProgDest:Integer;DataLav:TDateTime);
    procedure openT430(Campo: String; Progressivo: Integer; DataLavoro: TDateTime) ;
    procedure ElaboraPeriodi;
    function Controlli: String;
    property selT433_Funzioni: TOracleDataset read FselT433_Funzioni write FselT433_Funzioni;
    procedure CreaCdsT433;
    procedure CaricaCdsT433;
    procedure CancellaT433(Progressivo: Integer);
    procedure Ripristina;
   end;

implementation

{$R *.dfm}

{ TA082FCdcPercentMW }

procedure TA082FCdcPercentMW.CancellaT433(Progressivo: Integer);
begin
  //Cancello tutto con le nuove modifiche
  delT433.SetVariable('Progressivo',Progressivo);
  delT433.Execute;
  SessioneOracle.Commit;
end;

procedure TA082FCdcPercentMW.CopiaMassivaCDC(ProgOrig,ProgDest:Integer;DataLav:TDateTime);
begin
  CopyT433.SetVariable('PROGRESSIVO_ORIG',ProgOrig);
  CopyT433.SetVariable('PROGRESSIVO_DEST',ProgDest);
  CopyT433.SetVariable('DATALAVORO',DataLav);
  CopyT433.Execute;
end;

procedure TA082FCdcPercentMW.CaricaCdsT433;
var
  i: Integer;
  fn,Row_ID: String;
begin
  Row_ID:=FselT433_Funzioni.RowId;
  cdsT433.Close;
  cdsT433.Open;
  cdsT433.Append;
  cdsT433.EmptyDataSet;

  FselT433_Funzioni.First;
  while not FselT433_Funzioni.Eof do
  begin
    cdsT433.Append;
    for i:=0 to cdsT433.FieldCount - 1 do
    begin
      fn:=cdsT433.FieldDefs[i].Name;
      cdsT433.FieldByName(fn).Value:=FselT433_Funzioni.FieldByName(fn).Value;
    end;
    cdsT433.Post;
    FselT433_Funzioni.Next;
  end;
  if Row_ID <> '' then
    FselT433_Funzioni.SearchRecord('ROWID',row_ID,[srFromBeginning]);


(*  metodo veccchio. il dataset dopo finisce in dsIncative
  FselT433_Funzioni.First;
  with TDataSetProvider.Create(nil) do
  try
    cdsT433.Close;
    DataSet:=FselT433_Funzioni;
    cdsT433.Data:=Data;
  finally
    Free;
  end;
  *)
end;

function TA082FCdcPercentMW.Controlli: String;
begin
  Result:='';
  with srcCalcolaPerc do
  begin
    Close;
//    SetVariable('Progressivo',FselT433_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    //Caratto 18/12/2012 se dataset vuoto leggendo il campo ottengo 0
    SetVariable('Progressivo',StrToInt(VarToStr(FselT433_Funzioni.getVariable('PROGRESSIVO'))));
    Execute;
    if GetVariable('Anomalie') <> Null then
      Result:=GetVariable('Anomalie');
  end;
end;

procedure TA082FCdcPercentMW.CreaCdsT433;
begin
  cdsT433.Close;
  cdsT433.FieldDefs.Clear;
  cdsT433.FieldDefs.Add('Progressivo',ftInteger,0,False);
  cdsT433.FieldDefs.Add('Decorrenza',ftDateTime,0,False);
  cdsT433.FieldDefs.Add('Decorrenza_fine',ftDateTime,0,False);
  cdsT433.FieldDefs.Add('Codice',ftString,80,False);
  cdsT433.FieldDefs.Add('Percentuale',ftFloat,0,False);
  cdsT433.IndexDefs.Clear;
  cdsT433.IndexDefs.Add('Primario',('Decorrenza;Codice'),[ixUnique]);
  cdsT433.IndexName:='Primario';
  cdsT433.CreateDataSet;
  cdsT433.LogChanges:=False;
end;

procedure TA082FCdcPercentMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(cdsT433);
  inherited;
end;

procedure TA082FCdcPercentMW.ElaboraPeriodi;
begin
  scrT433Decorrenza_Fine.SetVariable('PROGRESSIVO',FselT433_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
  scrT433Decorrenza_Fine.SetVariable('CODICE',FselT433_Funzioni.FieldByName('CODICE').AsString);
  scrT433Decorrenza_Fine.Execute;
  SessioneOracle.Commit;
end;

procedure TA082FCdcPercentMW.openT430(Campo: String; Progressivo: Integer; DataLavoro: TDateTime);
begin
  selT430.Close;
  selT430.SetVariable('Campo',Campo);
  selT430.SetVariable('Progressivo',Progressivo);
  selT430.SetVariable('Datalavoro',DataLavoro);
  selT430.Open;
end;

procedure TA082FCdcPercentMW.Ripristina;
var
  evBeforePost, evAfterPost: TAfterPost;
begin
  evAfterPost:=FselT433_Funzioni.AfterPost;
  evBeforePost:=FselT433_Funzioni.BeforePost;
  FselT433_Funzioni.AfterPost:=nil;
  FselT433_Funzioni.BeforePost:=nil;

  //Inserisco i vecchi dati presenti nel ClientDataSet
  cdsT433.Open;
  cdsT433.First;
  while not cdsT433.Eof do
  begin
    FselT433_Funzioni.Insert;
    FselT433_Funzioni.FieldByName('Progressivo').AsInteger:=cdsT433.FieldByName('Progressivo').AsInteger;
    FselT433_Funzioni.FieldByName('Decorrenza').AsDateTime:=cdsT433.FieldByName('Decorrenza').AsDateTime;
    FselT433_Funzioni.FieldByName('Decorrenza_fine').AsDateTime:=cdsT433.FieldByName('Decorrenza_fine').AsDateTime;
    FselT433_Funzioni.FieldByName('Codice').AsString:=cdsT433.FieldByName('Codice').AsString;
    FselT433_Funzioni.FieldByName('Percentuale').AsFloat:=cdsT433.FieldByName('Percentuale').AsFloat;
    FselT433_Funzioni.Post;
    cdsT433.Next;
  end;
  FselT433_Funzioni.AfterPost:=evAfterPost;
  FselT433_Funzioni.BeforePost:=evBeforePost;
end;

end.
