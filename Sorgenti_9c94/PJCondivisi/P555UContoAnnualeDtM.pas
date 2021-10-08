unit P555UContoAnnualeDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione, A000UInterfaccia,  RegistrazioneLog, OracleData, Oracle,
  R004UGestStoricoDtM, C700USelezioneAnagrafe,P999UGenerale, Variants,
  C180FunzioniGenerali, DBClient;

type
  TP555FContoAnnualeDtM = class(TR004FGestStoricoDtM)
    selP554: TOracleDataSet;
    selP555: TOracleDataSet;
    dsrP555: TDataSource;
    selP552Riga: TOracleDataSet;
    selP552Col: TOracleDataSet;
    selP552: TOracleDataSet;
    dsrP552: TDataSource;
    dsrP552Riga: TDataSource;
    dsrP552Col: TDataSource;
    selQuery: TOracleDataSet;
    cdsValori: TClientDataSet;
    cdsValoriVARIABILE: TStringField;
    cdsValoriVALORE: TStringField;
    dsrQuery: TDataSource;
    LungCampi: TOracleDataSet;
    MaxAnno: TOracleDataSet;
    selP555ID_CONTOANN: TFloatField;
    selP555PROGRESSIVO: TFloatField;
    selP555RIGA: TIntegerField;
    selP555COLONNA: TIntegerField;
    selP555VALORE: TFloatField;
    selP555Desc_Riga: TStringField;
    selP555Desc_Colonna: TStringField;
    selP555Valore_Costante: TStringField;
    selDip: TOracleDataSet;
    dsrDip: TDataSource;
    selP555canc: TOracleDataSet;
    selP552RigaANNO: TIntegerField;
    selP552RigaCOD_TABELLA: TStringField;
    selP552RigaRIGA: TIntegerField;
    selP552RigaDESCRIZIONE: TStringField;
    selP552RigaVALORE_COSTANTE: TStringField;
    selP552ColANNO: TIntegerField;
    selP552ColCOD_TABELLA: TStringField;
    selP552ColCOLONNA: TIntegerField;
    selP552ColDESCRIZIONE: TStringField;
    selDipMATRICOLA: TStringField;
    selDipCOGNOME: TStringField;
    selDipNOME: TStringField;
    selDipVALORE: TFloatField;
    procedure selP555CalcFields(DataSet: TDataSet);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure selP555ApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: string);
    procedure selP555NewRecord(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure selP554AfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    AnnoRegole:Integer;
  end;

var
  P555FContoAnnualeDtM: TP555FContoAnnualeDtM;

implementation

uses P555UContoAnnuale;

{$R *.DFM}


procedure TP555FContoAnnualeDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selP554,[evBeforeDelete,
                              evAfterDelete]);
  selP554.Open;
  MaxAnno.Close;
  if C700Progressivo = 0 then
    MaxAnno.SetVariable('PROGRESSIVO',-1)
  else
    MaxAnno.SetVariable('PROGRESSIVO',C700Progressivo);
  MaxAnno.Open;
  if MaxAnno.FieldByName('ANNO').AsInteger <> 0 then
  begin
    if (not selP554.SearchRecord('ANNO',MaxAnno.FieldByName('ANNO').AsInteger,[srFromBeginning])) and (C700Progressivo <> 0) then
    begin
      MaxAnno.Close;
      MaxAnno.SetVariable('PROGRESSIVO',-1);
      MaxAnno.Open;
      selP554.SearchRecord('ANNO',MaxAnno.FieldByName('ANNO').AsInteger,[srFromBeginning]);
    end;
  end
  else if C700Progressivo <> 0 then
  begin
    MaxAnno.Close;
    MaxAnno.SetVariable('PROGRESSIVO',-1);
    MaxAnno.Open;
    selP554.SearchRecord('ANNO',MaxAnno.FieldByName('ANNO').AsInteger,[srFromBeginning]);
  end;
end;

procedure TP555FContoAnnualeDtM.selP554AfterScroll(DataSet: TDataSet);
begin
  inherited;
  AnnoRegole:=0;
  selQuery.Close;
  selQuery.SQL.Clear;
  selQuery.DeleteVariables;
  selQuery.SQL.Add('SELECT MAX(ANNO) ANNO FROM P552_CONTOANNREGOLE WHERE ANNO <= ' + selP554.FieldByName('ANNO').AsString);
  selQuery.Open;
  if selQuery.RecordCount > 0 then
    AnnoRegole:=selQuery.FieldByName('ANNO').AsInteger;
  selP552.Close;
  selP552.SetVariable('ANNO',selP554.FieldByName('ANNO').AsInteger);
  selP552.Open;
  selP552.SearchRecord('COD_TABELLA',selP554.FieldByName('COD_TABELLA').AsString,[srFromBeginning]);
  P555FContoAnnuale.cmbRicerca.KeyValue:=selP554.FieldByName('COD_TABELLA').AsString;

  if P555FContoAnnuale.rgpTipoDati.ItemIndex = 2 then
    P555FContoAnnuale.AggiornaRiepTabellari
  else
    P555FContoAnnuale.Aggiorna;

  P555FContoAnnuale.AbilitazioniComponenti;
end;

procedure TP555FContoAnnualeDtM.selP555NewRecord(DataSet: TDataSet);
begin
  inherited;
  selP555.FieldByName('ID_CONTOANN').AsInteger:=selP554.FieldByName('ID_CONTOANN').AsInteger;
  if P555FContoAnnuale.rgpTipoDati.ItemIndex = 0 then
    selP555.FieldByName('PROGRESSIVO').AsInteger:=C700Progressivo
  else if P555FContoAnnuale.rgpTipoDati.ItemIndex = 1 then
    selP555.FieldByName('PROGRESSIVO').AsInteger:=-1;
end;

procedure TP555FContoAnnualeDtM.selP555ApplyRecord(Sender: TOracleDataSet;
  Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  inherited;
 case Action of
    'D':RegistraLog.SettaProprieta('C',R180Query2NomeTabella(Sender),Copy(Name,1,4),Sender,True);
    'I':RegistraLog.SettaProprieta('I',R180Query2NomeTabella(Sender),Copy(Name,1,4),Sender,True);
    'U':RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Sender),Copy(Name,1,4),Sender,True);
  end;
  if Action in ['D','I','U'] then
    RegistraLog.RegistraOperazione;
end;

procedure TP555FContoAnnualeDtM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if selP554.FieldByName('CHIUSO').AsString = 'S' then
    raise Exception.Create('L''elaborato risulta già chiuso per cui non può essere cancellato!');
end;

procedure TP555FContoAnnualeDtM.selP555CalcFields(DataSet: TDataSet);
begin
  inherited;
  if selP552Riga.SearchRecord('ANNO;COD_TABELLA;RIGA',VarArrayOf([AnnoRegole,selP554.FieldByName('COD_TABELLA').AsString,selP555.FieldByName('RIGA').AsInteger]),[srFromBeginning]) then
  begin
    selP555.FieldByName('DESC_RIGA').AsString:=selP552Riga.FieldByName('DESCRIZIONE').AsString;
    selP555.FieldByName('VALORE_COSTANTE').AsString:=selP552Riga.FieldByName('VALORE_COSTANTE').AsString;
  end;
  if selP552Col.SearchRecord('ANNO;COD_TABELLA;COLONNA',VarArrayOf([AnnoRegole,selP554.FieldByName('COD_TABELLA').AsString,selP555.FieldByName('COLONNA').AsInteger]),[srFromBeginning]) then
    selP555.FieldByName('DESC_COLONNA').AsString:=selP552Col.FieldByName('DESCRIZIONE').AsString;
end;

end.

