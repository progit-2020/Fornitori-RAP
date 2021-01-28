unit A034UIntPagheMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, OracleData, A000UCostanti, A000USessione, A000UInterfaccia,
  ControlloVociPaghe, Oracle;

type
  TEvDataset = procedure (DataSet: TDataSet) of object;

  TA034FIntPagheMW = class(TR005FDataModuleMW)
    selC9ScaricoPaghe: TOracleDataSet;
    delT193: TOracleQuery;
    procedure selC9ScaricoPagheAfterScroll(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FSelT190: TOracleDataSet;
  public
    selControlloVociPaghe:TControlloVociPaghe;
    procedure ImpostaSelC9ScaricoPaghe;
    function AcceptFilterT190: Boolean;
    procedure CalcFieldsT190;
    property selT190_Funzioni: TOracleDataset read FSelT190 write FSelT190;
    procedure AllineaCodici;
    procedure EliminaInterfaccia;
  end;

implementation

{$R *.dfm}

//impostazioni selC9ScaricoPaghe
//Non fare nella create perche FSelT190 non impostato (nella afterscroll imposta filtered di FSelT190)
function TA034FIntPagheMW.AcceptFilterT190: Boolean;
begin
  Result:=FselT190.FieldByName('Codice').AsString = selC9ScaricoPaghe.FieldByName('Codice').AsString;
end;

procedure TA034FIntPagheMW.AllineaCodici;
var
  i: Integer;
  evBeforePost, evAfterPost, evBeforeInsert: TevDataset;
begin
  evBeforePost:=FselT190.BeforePost;
  evAfterPost:=FselT190.AfterPost;
  evBeforeInsert:=FselT190.BeforeInsert;
  FselT190.BeforePost:=nil;
  FselT190.AfterPost:=nil;
  FselT190.BeforeInsert:=nil;

  while not selC9ScaricoPaghe.Eof do
  begin
    for i:=1 to High(VettConst) do
      if FselT190.SearchRecord('CodInterno',VettConst[i].CodInt,[srFromBeginning]) then
      begin
        //Aggiornamento numero d'ordine
        if FselT190.FieldByName('Ordine').AsInteger <> VettConst[i].Ordine then
        begin
          FselT190.Edit;
          FselT190.FieldByName('Ordine').AsInteger:=VettConst[i].Ordine;
        end;
        //Aggiornamento unità di misura descrittiva
        if FselT190.FieldByName('UM').IsNull then
        begin
          if FselT190.State = dsBrowse then
            FselT190.Edit;
          FselT190.FieldByName('UM').AsString:=VettConst[i].Misura;
        end;
        if FselT190.State = dsEdit then
          FselT190.Post;
      end
      else
      //Inserimento nuovo dato
      begin
        FselT190.Append;
        FselT190.FieldByName('Codice').AsString:=selC9ScaricoPaghe.FieldByName('Codice').AsString;
        FselT190.FieldByName('CodInterno').AsString:=VettConst[i].CodInt;
        FselT190.FieldByName('Ordine').AsInteger:=VettConst[i].Ordine;
        FselT190.FieldByName('Flag').AsString:='N';
        FselT190.FieldByName('UM').AsString:=VettConst[i].Misura;
        FselT190.Post;
      end;
    selC9ScaricoPaghe.Next;
  end;
  SessioneOracle.Commit;
  FselT190.BeforePost:=evBeforePost;
  FselT190.AfterPost:=evAfterPost;
  FselT190.BeforeInsert:=evBeforeInsert;

  selC9ScaricoPaghe.First;
end;

procedure TA034FIntPagheMW.CalcFieldsT190;
var
  i: Integer;
begin
  for i:=1 to High(VettConst) do
    if FselT190.FieldByName('CodInterno').AsString = VettConst[i].CodInt then
    begin
      FselT190.FieldByName('Descrizione').AsString:=VettConst[i].Descrizione;
      Break;
    end;
end;

procedure TA034FIntPagheMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selControlloVociPaghe:=TControlloVociPaghe.Create(Self,'');
end;

procedure TA034FIntPagheMW.DataModuleDestroy(Sender: TObject);
begin
  try
    FreeAndNil(selControlloVociPaghe);
  except
  end;

  inherited;
end;

procedure TA034FIntPagheMW.EliminaInterfaccia;
begin
  delT193.SetVariable('CODICE',FselT190.FieldByName('CODICE').AsString);
  delT193.Execute;
  while not FselT190.Eof do
    FselT190.Delete;

  SessioneOracle.Commit;
end;

procedure TA034FIntPagheMW.ImpostaSelC9ScaricoPaghe;
begin
  selC9ScaricoPaghe.Close;
  selC9ScaricoPaghe.SQL.Clear;
  if A000LookupTabella(Parametri.CampiRiferimento.C9_ScaricoPaghe,selC9ScaricoPaghe) then
  begin
    if selC9ScaricoPaghe.VariableIndex('DECORRENZA') >= 0 then
      selC9ScaricoPaghe.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
  end
  else
    selC9ScaricoPaghe.SQL.Add('SELECT ''<INTERFACCIA UNICA>'' CODICE,NULL DESCRIZIONE FROM DUAL');
  selC9ScaricoPaghe.Open;
end;

procedure TA034FIntPagheMW.selC9ScaricoPagheAfterScroll(DataSet: TDataSet);
begin
  FSelT190.Filtered:=False;
  FSelT190.Filtered:=True;
end;

end.
