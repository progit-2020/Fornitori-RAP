unit A168UIncentiviMaturatiMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, Data.DB, DatiBloccati,
  C180FunzioniGenerali,  A000UInterfaccia, Vcl.StdCtrls, C700USelezioneAnagrafe;

type
  TA168FIncentiviMaturatiMW = class(TR005FDataModuleMW)
    selT765: TOracleDataSet;
    selT765CODICE: TStringField;
    selT765DESCRIZIONE: TStringField;
    selT765TIPOQUOTA: TStringField;
    selT766: TOracleDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    selT766RISPARMIO_BILANCIO: TStringField;
    selT763: TOracleDataSet;
    selT763PROGRESSIVO: TFloatField;
    selT763ANNO: TFloatField;
    selT763MESE: TFloatField;
    selT763TIPOQUOTA: TStringField;
    selT763TIPOABBATTIMENTO: TStringField;
    selT763Desc_Abbattimento: TStringField;
    selT763QUOTAABBATTIMENTO: TFloatField;
    selT763MESEAPPLICAZIONEABBATTIMENTO: TDateTimeField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT763CalcFields(DataSet: TDataSet);
    procedure selT763NewRecord(DataSet: TDataSet);
  private
    selDatiBloccati:TDatiBloccati;

  public
    selT762: TOracleDataSet;
    chkVisIntere: TCheckBox;
    chkVisProporzionate: TCheckBox;
    chkVisNette: TCheckBox;
    chkVisNetteRisp: TCheckBox;
    chkVisAssenze: TCheckBox;
    chkVisQuantitative: TCheckBox;
    bVisIntere: boolean;
    bVisProporzionate: boolean;
    bVisNette: boolean;
    bVisNetteRisp: boolean;
    bVisAssenze: boolean;
    bVisQuantitative: boolean;
    edtQuote: TEdit;
    sQuote: String;
    sSource: String;
    procedure BeforeDelete(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet);
    procedure selT762CalcFields(DataSet: TDataSet);
    procedure selT762NewRecord(DataSet: TDataSet);
    procedure AggiornaB;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA168FIncentiviMaturatiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT765.Close;
  selT765.SetVariable('DATA',Parametri.DataLavoro);
  selT765.Open;
  selT766.Open;
  selDatiBloccati:=TDatiBloccati.Create(Self);
end;

procedure TA168FIncentiviMaturatiMW.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if selDatiBloccati.DatoBloccato(selT762.FieldByName('PROGRESSIVO').AsInteger,Encodedate(StrToInt(selT762.FieldByName('Anno').AsString),StrToInt(selT762.FieldByName('Mese').AsString),1),'T762') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
end;

procedure TA168FIncentiviMaturatiMW.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  if selDatiBloccati.DatoBloccato(selT762.FieldByName('PROGRESSIVO').AsInteger,Encodedate(StrToInt(selT762.FieldByName('Anno').AsString),StrToInt(selT762.FieldByName('Mese').AsString),1),'T762') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
end;

procedure TA168FIncentiviMaturatiMW.selT762CalcFields(DataSet: TDataSet);
begin
  inherited;
  if R180Between(selT762.FieldByName('Mese').AsInteger,1,12) then
    selT762.FieldByName('Desc_Mese').AsString:=R180Capitalize(FormatSettings.LongMonthNames[selT762.FieldByName('Mese').AsInteger]);
  selT762.FieldByName('DescGiorniOre').AsString:=selT762.FieldByName('GIORNI_ORE').AsString;
  if selT762.FieldByName('TipoImporto').AsString = '1' then
    selT762.FieldByName('Desc_Importo').AsString:='Quota intera'
  else if selT762.FieldByName('TipoImporto').AsString = '2' then
    selT762.FieldByName('Desc_Importo').AsString:='Quota proporzionata'
  else if selT762.FieldByName('TipoImporto').AsString = '3' then
    selT762.FieldByName('Desc_Importo').AsString:='Quota netta'
  else if selT762.FieldByName('TipoImporto').AsString = '4' then
    selT762.FieldByName('Desc_Importo').AsString:='Quota netta + risparmio'
  else if selT762.FieldByName('TipoImporto').AsString = '5' then
  begin
    selT762.FieldByName('Desc_Importo').AsString:='Quota quantitativa';
    selT762.FieldByName('DescGiorniOre').AsString:=R180MinutiOre(selT762.FieldByName('GIORNI_ORE').AsInteger);
  end
  else
  begin
    if selT766.SearchRecord('CODICE',selT762.FieldByName('TipoImporto').AsString,[srFromBeginning]) then
      selT762.FieldByName('Desc_Importo').AsString:=selT766.FieldByName('DESCRIZIONE').AsString;
  end;
end;

procedure TA168FIncentiviMaturatiMW.selT762NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT762.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

procedure TA168FIncentiviMaturatiMW.selT763CalcFields(DataSet: TDataSet);
begin
  inherited;
  if selT763.FieldByName('TipoAbbattimento').AsString = 'AS' then
    selT763.FieldByName('Desc_Abbattimento').AsString:='Assenze'
  else if selT763.FieldByName('TipoAbbattimento').AsString = 'GS' then
    selT763.FieldByName('Desc_Abbattimento').AsString:='Giorni servizio'
  else if selT763.FieldByName('TipoAbbattimento').AsString = 'PT' then
    selT763.FieldByName('Desc_Abbattimento').AsString:='Part-time';
end;

procedure TA168FIncentiviMaturatiMW.selT763NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT763.FieldByName('PROGRESSIVO').AsInteger:=selT762.FieldByName('PROGRESSIVO').AsInteger;
  selT763.FieldByName('ANNO').AsInteger:=selT762.FieldByName('ANNO').AsInteger;
  selT763.FieldByName('MESE').AsInteger:=selT762.FieldByName('MESE').AsInteger;
  selT763.FieldByName('TIPOQUOTA').AsString:=selT762.FieldByName('CODTIPOQUOTA').AsString;
end;

procedure TA168FIncentiviMaturatiMW.AggiornaB;
var Filtro:String;
begin
    selT762.Close;
    if(sSource <> 'WIN') then
      selT762.SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger)
    else
      selT762.SetVariable('PROG',C700Progressivo);
    Filtro:='';

    if bVisIntere then
      Filtro:='''1''';
    if bVisProporzionate then
    begin
      if Trim(Filtro) <> '' then
        Filtro:=Filtro + ',';
      Filtro:=Filtro + '''2''';
    end;
    if bVisNette then
    begin
      if Trim(Filtro) <> '' then
        Filtro:=Filtro + ',';
      Filtro:=Filtro + '''3''';
    end;
    if bVisNetteRisp then
    begin
      if Trim(Filtro) <> '' then
        Filtro:=Filtro + ',';
      Filtro:=Filtro + '''4''';
    end;
    if bVisQuantitative then
    begin
      if Trim(Filtro) <> '' then
        Filtro:=Filtro + ',';
      Filtro:=Filtro + '''5''';
    end;
    if Trim(Filtro) <> '' then
      Filtro:=' AND (TIPOIMPORTO IN (' + Filtro + ')';
    if bVisAssenze then
    begin
      if Trim(Filtro) <> '' then
        Filtro:=Filtro + ' OR '
      else
        Filtro:=' AND (';
      Filtro:=Filtro + 'TIPOIMPORTO NOT IN (''1'',''2'',''3'',''4'',''5'')';
    end;
    if Trim(Filtro) <> '' then
      Filtro:=Filtro + ')';

    if Trim(sQuote) <> '' then
      Filtro:=Filtro + ' AND (CODTIPOQUOTA IN (''' + StringReplace(sQuote,',',''',''',[rfReplaceAll]) + '''))';
    selT762.SetVariable('FILTRO',Filtro);
    selT762.Open;
end;


procedure TA168FIncentiviMaturatiMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(selDatiBloccati);
end;

end.
