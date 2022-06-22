unit A011UEntiLocaliMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData, A000UMessaggi;

type
  TA011FEntiLocaliMW = class(TR005FDataModuleMW)
    selCodCatastale: TOracleDataSet;
    selRegioneFiscale: TOracleDataSet;
    selT481: TOracleDataSet;
    dsrT481: TDataSource;
    selT482: TOracleDataSet;
    dsrT482: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
    selEnte:TOracleDataset;
    procedure ValidaCodiceCatastale;
    procedure selEnteBeforePost(Tabella:String);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TA011FEntiLocaliMW }

procedure TA011FEntiLocaliMW.ValidaCodiceCatastale;
begin
  if Trim(selEnte.FieldByName('CODCATASTALE').AsString) <> '' then
  begin
    selCodCatastale.SetVariable('CodCatastale',selEnte.FieldByName('CODCATASTALE').AsString);
    selCodCatastale.SetVariable('Codice',selEnte.FieldByName('CODICE').AsString);
    selCodCatastale.Close;
    selCodCatastale.Open;
    if selCodCatastale.FieldByName('NCODCATASTALE').AsInteger > 0 then
    begin
      selEnte.FieldByName('CODCATASTALE').FocusControl;
      raise Exception.Create(A000MSG_A011_ERR_CODICE_CATASTALE);
    end;
  end;
end;

procedure TA011FEntiLocaliMW.selEnteBeforePost(Tabella:String);
begin
  if Tabella = 'C' then
    selEnte.FieldByName('CODCATASTALE').AsString:=Trim(selEnte.FieldByName('CODCATASTALE').AsString)
  else if Tabella = 'R' then
  begin
    //Controllo che in caso di più regioni con stesso COD_IRPEF solo una deve avere FISCALE = 'N'
    if selEnte.FieldByName('FISCALE').AsString = 'N' then
    begin
      selRegioneFiscale.Close;
      selRegioneFiscale.SetVariable('CODICE',selEnte.FieldByName('COD_IRPEF').AsString);
      if selEnte.State = dsInsert then
        selRegioneFiscale.SetVariable('RIGA','0')
      else
        selRegioneFiscale.SetVariable('RIGA',selEnte.RowId);
      selRegioneFiscale.Open;
      if selRegioneFiscale.RecordCount > 0 then //Con questo codice IRPEF, esiste già una regione non significativa ai soli fini dell''addizionale IRPEF
        raise Exception.Create(A000MSG_A011_ERR_REGIONE_FISCALE);
    end;
  end;
end;

end.
