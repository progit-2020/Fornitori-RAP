unit A088UDatiLiberiIterMissioniDtM;

interface

uses
  A000UCostanti,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, A000UInterfaccia, Oracle,
  QueryPK, C180FunzioniGenerali, Datasnap.DBClient,
  A088UDatiLiberiIterMissioniMW;

type
  TA088FDatiLiberiIterMissioniDtM = class(TR004FGestStoricoDtM)
    selM025: TOracleDataSet;
    selM025CODICE: TStringField;
    selM025DESCRIZIONE: TStringField;
    selM025CATEGORIA: TStringField;
    selM025ORDINE: TIntegerField;
    selM025VALORI: TStringField;
    selM025OBBLIGATORIO: TStringField;
    selM025RIGHE: TIntegerField;
    selM024: TOracleDataSet;
    selM024CODICE: TStringField;
    selM024DESCRIZIONE: TStringField;
    selM024ORDINE: TIntegerField;
    selM024MIN_FASE_VISIBILE: TIntegerField;
    selM024MAX_FASE_VISIBILE: TIntegerField;
    selM024MIN_FASE_MODIFICA: TIntegerField;
    selM024MAX_FASE_MODIFICA: TIntegerField;
    selM025FORMATO: TStringField;
    selM025LUNG_MAX: TIntegerField;
    selM025ELENCO_FISSO: TStringField;
    selM025DATO_ANAGRAFICO: TStringField;
    selM025QUERY_VALORE: TStringField;
    selM025VALORE_DEFAULT: TStringField;
    dsrM025: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure BeforeEdit(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure selM025BeforeDelete(DataSet: TDataSet);
    procedure selM025NewRecord(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selM025BeforePost(DataSet: TDataSet);
    procedure selM024AfterScroll(DataSet: TDataSet);
  public
    A088FDatiLiberiIterMissioniMW: TA088FDatiLiberiIterMissioniMW;
    procedure PopolaListeValori;
  end;

var
  A088FDatiLiberiIterMissioniDtM: TA088FDatiLiberiIterMissioniDtM;

implementation

uses
  A088UDatiLiberiIterMissioni;

{$R *.dfm}

procedure TA088FDatiLiberiIterMissioniDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selM024,[evOnNewRecord,
                              evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  selM024.Open;
  selM024.First;
  A088FDatiLiberiIterMissioniMW:=TA088FDatiLiberiIterMissioniMW.Create(Self);
  A088FDatiLiberiIterMissioniMW.selm024_Funzioni:=selM024;
  A088FDatiLiberiIterMissioniMW.selm025_Funzioni:=selM025;
end;

procedure TA088FDatiLiberiIterMissioniDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A088FDatiLiberiIterMissioniMW);
  inherited;
end;

procedure TA088FDatiLiberiIterMissioniDtM.PopolaListeValori;
// popola le picklist per alcuni dati nella grid dei dati liberi (detail)
begin
  // popola picklist di DATO_ANAGRAFICO
  with A088FDatiLiberiIterMissioniMW.selT430Colonne do
  begin
    Open;
    First;
    while not Eof do
    begin
      A088FDatiLiberiIterMissioni.dgrdDatiLiberi.Columns[9].PickList.Add(FieldByName('COLUMN_NAME').AsString);
      Next;
    end;
  end;

  // popola picklist di QUERY_VALORE
  with A088FDatiLiberiIterMissioniMW.selT002 do
  begin
    Open;
    First;
    while not Eof do
    begin
      A088FDatiLiberiIterMissioni.dgrdDatiLiberi.Columns[10].PickList.Add(FieldByName('NOME').AsString);
      Next;
    end;
  end;
end;


// ###################################################
// ##########    GESTIONE TABELLA MASTER    ##########
// ###################################################

procedure TA088FDatiLiberiIterMissioniDtM.selM024AfterScroll(DataSet: TDataSet);
begin
  // apre il dataset figlio
  selM025.Close;
  selM025.SetVariable('CODICE',selM024.FieldByName('CODICE').AsString);
  selM025.Open;
end;

procedure TA088FDatiLiberiIterMissioniDtM.OnNewRecord(DataSet: TDataSet);
begin
  A088FDatiLiberiIterMissioniMW.SelM024NewRecord;
end;

procedure TA088FDatiLiberiIterMissioniDtM.BeforeEdit(DataSet: TDataSet);
begin
  A088FDatiLiberiIterMissioniMW.SelM024BeforeEdit;
  inherited;
end;

procedure TA088FDatiLiberiIterMissioniDtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A088FDatiLiberiIterMissioniMW.SelM024BeforePost;
end;

procedure TA088FDatiLiberiIterMissioniDtM.BeforeDelete(DataSet: TDataSet);
begin
  A088FDatiLiberiIterMissioniMW.SelM024BeforeDelete;
  inherited;
end;



// ###################################################
// ##########    GESTIONE TABELLA DETAIL    ##########
// ###################################################

procedure TA088FDatiLiberiIterMissioniDtM.selM025NewRecord(DataSet: TDataSet);
begin
  inherited;
  A088FDatiLiberiIterMissioniMW.SelM025NewRecord(selM024.FieldByName('CODICE').AsString);
end;

procedure TA088FDatiLiberiIterMissioniDtM.selM025BeforeDelete(DataSet: TDataSet);
begin
  A088FDatiLiberiIterMissioniMW.SelM025BeforeDelete;
  inherited;
end;

procedure TA088FDatiLiberiIterMissioniDtM.selM025BeforePost(DataSet: TDataSet);
begin
  inherited;
  A088FDatiLiberiIterMissioniMW.SelM025BeforePost;
end;



end.
