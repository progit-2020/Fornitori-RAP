unit A117UOreLiquidateAnniPrecMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, DBClient, DatiBloccati, A029ULiquidazione,
  OracleData, C180FunzioniGenerali, R450, A000UMessaggi, A000UInterfaccia;

type
  TA117FOreLiquidateAnniPrecMW = class(TR005FDataModuleMW)
    cdsT134: TClientDataSet;
    cdsR450: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FselT134_Funzioni: TOracleDataSet;
    R450DtM:TR450DtM1;
    selDatiBloccati:TDatiBloccati;
    procedure setSelFunzioni(const Value: TOracleDataSet);
  public
    procedure SvuotaCdsR450;
    procedure AggiornaResidui(Progressivo, Anno: Integer);
    procedure SelT134AfterOpen;
    procedure SelT134CalcFields(Progressivo: Integer);
    procedure SelT134BeforePost(Progressivo: Integer);
    procedure SelT134BeforeDelete(Progressivo: Integer);
    procedure SelT134NewRecord(Progressivo: Integer);
    procedure DATAGetText(Sender: TField; var Text: string;DisplayText: Boolean);
    procedure DATASetText(Sender: TField; const Text: String);
    procedure OREPERSEValidate(Sender: TField);
    procedure OREValidate(Sender: TField);
    property selT134_Funzioni: TOracleDataSet read FselT134_Funzioni write setSelFunzioni;
  end;

implementation

{$R *.dfm}

procedure TA117FOreLiquidateAnniPrecMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  //Riepilogo dei saldi annuali delle ore perse (MILANO_HMAGGIORE)
  cdsR450.FieldDefs.Clear;
  cdsR450.FieldDefs.Add('ANNO',ftInteger);
  cdsR450.FieldDefs.Add('OREPERSE_TOT',ftInteger);
  cdsR450.CreateDataSet;
  cdsR450.LogChanges:=False;
  //Copia della Q134 per calcolare il residuo
  cdsT134.FieldDefs.Clear;
  cdsT134.FieldDefs.Add('ANNO',ftInteger);
  cdsT134.FieldDefs.Add('DATA',ftDateTime);
  cdsT134.FieldDefs.Add('ORE_LIQUIDATE',ftInteger);
  cdsT134.FieldDefs.Add('VARIAZIONE_ORE',ftInteger);
  cdsT134.CreateDataSet;
  cdsT134.LogChanges:=False;

  selDatiBloccati:=TDatiBloccati.Create(Self);
  selDatiBloccati.TipoLog:='M';
  R450DtM:=nil;
end;

//Svuoto il riepilogo dei saldi annuali
procedure TA117FOreLiquidateAnniPrecMW.SvuotaCdsR450;
begin
  with cdsR450 do
  begin
    First;
    while not Eof do
      Delete;
  end;
end;

procedure TA117FOreLiquidateAnniPrecMW.AggiornaResidui(Progressivo: Integer; Anno:Integer);
var A029FLiquidazione: TA029FLiquidazione;
begin
//Aggiorno la tabella dei residui tramite la funzione di passaggio di anno
  try
    A029FLiquidazione:=TA029FLiquidazione.Create(nil);
    A029FLiquidazione.AggiornaResiduiSuccessivi(Progressivo,Anno);
  finally
    FreeAndNil(A029FLiquidazione);
  end;
end;

procedure TA117FOreLiquidateAnniPrecMW.setSelFunzioni(
  const Value: TOracleDataSet);
begin
  FselT134_Funzioni:=Value;
end;

procedure TA117FOreLiquidateAnniPrecMW.SelT134AfterOpen;
begin
  //Svuoto la copia di T134
  with cdsT134 do
  begin
    First;
    while not Eof do
      Delete;
  end;
  //Copia il contenuto di T134 in cdsT134
  with FselT134_Funzioni do
  begin
    DisableControls;
    try
      while not Eof do
      begin
        if FieldByName('OREPERSE').AsString = 'S' then
        begin
          cdsT134.Append;
          cdsT134.FieldByName('ANNO').AsInteger:=FselT134_Funzioni.FieldByName('ANNO').AsInteger;
          cdsT134.FieldByName('DATA').AsDateTime:=FselT134_Funzioni.FieldByName('DATA').AsDateTime;
          cdsT134.FieldByName('ORE_LIQUIDATE').AsInteger:=R180OreMinutiExt(FselT134_Funzioni.FieldByName('ORE_LIQUIDATE').AsString);
          cdsT134.FieldByName('VARIAZIONE_ORE').AsInteger:=R180OreMinutiExt(FselT134_Funzioni.FieldByName('VARIAZIONE_ORE').AsString) * -1;
          cdsT134.Post;
        end;
        Next;
      end;
    finally
      First;
      EnableControls;
    end;
  end;
end;

{Calcolo del totale e residuo delle ore perse (MILANO_HMAGGIORE)}
procedure TA117FOreLiquidateAnniPrecMW.SelT134CalcFields(Progressivo: Integer);
var OrePerse:Integer;
begin
  if (FselT134_Funzioni.FieldByName('OREPERSE').AsString = 'S') and (not FselT134_Funzioni.FieldByName('ANNO').IsNull) then
  begin
    //Riepilogo ore perse  a fine anno
    if not cdsR450.Locate('ANNO',FselT134_Funzioni.FieldByName('ANNO').AsInteger,[]) then
    begin
      if R450DtM = nil then
        R450DtM:=TR450DtM1.Create(Self);
      R450DtM.ConteggiMese('Generico',FselT134_Funzioni.FieldByName('ANNO').AsInteger,12,Progressivo);
      cdsR450.Append;
      cdsR450.FieldByName('ANNO').AsInteger:=FselT134_Funzioni.FieldByName('ANNO').AsInteger;
      cdsR450.FieldByName('OREPERSE_TOT').AsInteger:=R450DtM.OrePersePeriodiche + R450DtM.salcompannoprec + R450DtM.salliqannoprec;
      cdsR450.Post;
    end;
    if cdsR450.Locate('ANNO',FselT134_Funzioni.FieldByName('ANNO').AsInteger,[]) then
      FselT134_Funzioni.FieldByName('OREPERSE_TOT').AsString:=R180MinutiOre(cdsR450.FieldByName('OREPERSE_TOT').AsInteger);
    //Riepilogo ore perse indicate nelle variazioni/liquidazioni per calcolo residuo
    OrePerse:=0;
    cdsT134.First;
    while not cdsT134.Eof do
    begin
      if cdsT134.FieldByName('ANNO').AsInteger = FselT134_Funzioni.FieldByName('ANNO').AsInteger then
        inc(OrePerse,cdsT134.FieldByName('ORE_LIQUIDATE').AsInteger + cdsT134.FieldByName('VARIAZIONE_ORE').AsInteger);
      cdsT134.Next;
    end;
    FselT134_Funzioni.FieldByName('OREPERSE_RES').AsString:=R180MinutiOre(R180OreMinutiExt(FselT134_Funzioni.FieldByName('OREPERSE_TOT').AsString) - OrePerse);
  end
  else
  begin
    FselT134_Funzioni.FieldByName('OREPERSE_TOT').AsString:='';
    FselT134_Funzioni.FieldByName('OREPERSE_RES').AsString:='';
  end;
end;

procedure TA117FOreLiquidateAnniPrecMW.SelT134BeforePost(Progressivo: Integer);
var
  AnnoLiq: Integer;
begin
  if selDatiBloccati.DatoBloccato(Progressivo,R180InizioMese(FselT134_Funzioni.FieldByName('DATA').AsDateTime),'T134') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
  AnnoLiq:=R180Anno(FselT134_Funzioni.FieldByName('DATA').AsDateTime);
  if (FselT134_Funzioni.FieldByName('OREPERSE').AsString = 'N') and
     (FselT134_Funzioni.FieldByName('ANNO').AsInteger <> AnnoLiq  - 1) and
     (FselT134_Funzioni.FieldByName('ANNO').AsInteger <> AnnoLiq  - 2) then
    raise Exception.Create(A000MSG_A117_ERR_ANNO_RIF_PREC);
  if (FselT134_Funzioni.FieldByName('OREPERSE').AsString = 'S') and (FselT134_Funzioni.FieldByName('ANNO').AsInteger >= AnnoLiq) then
    raise Exception.Create(A000MSG_A117_ERR_ANNO_RIF_SUCC);
  if (FselT134_Funzioni.FieldByName('OREPERSE').AsString = 'S') and (R180OreMinutiExt(FselT134_Funzioni.FieldByName('VARIAZIONE_ORE').AsString) > 0) then
    raise Exception.Create(A000MSG_A117_ERR_VARIAZ_ORE);
  if QueryPK1.EsisteChiave('T134_ORELIQUIDATEANNIPREC',FselT134_Funzioni.RowId,FselT134_Funzioni.State,['PROGRESSIVO','ANNO','DATA'],
     [FselT134_Funzioni.FieldByName('PROGRESSIVO').AsString,FselT134_Funzioni.FieldByName('ANNO').AsString,FselT134_Funzioni.FieldByName('DATA').AsString]) then
    raise Exception.Create(A000MSG_A117_ERR_LIQ_GIA_REGISTRATA);
end;

procedure TA117FOreLiquidateAnniPrecMW.SelT134BeforeDelete(Progressivo: Integer);
begin
  if selDatiBloccati.DatoBloccato(Progressivo,R180InizioMese(FselT134_Funzioni.FieldByName('DATA').AsDateTime),'T134') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
end;

procedure TA117FOreLiquidateAnniPrecMW.SelT134NewRecord(Progressivo: Integer);
begin
  FselT134_Funzioni.FieldByName('PROGRESSIVO').AsInteger:=Progressivo;
  FselT134_Funzioni.FieldByName('ANNO').AsInteger:=R180Anno(Parametri.DataLavoro) - 2;
  FselT134_Funzioni.FieldByName('DATA').AsDateTime:=R180InizioMese(Parametri.DataLavoro);
  FselT134_Funzioni.FieldByName('ORE_LIQUIDATE').AsString:=' 000.00';
  FselT134_Funzioni.FieldByName('VARIAZIONE_ORE').AsString:=' 000.00';
end;

procedure TA117FOreLiquidateAnniPrecMW.DATAGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then
    Text:=''
  else
    Text:=FormatDateTime('mm/yyyy',Sender.AsDateTime);
end;

procedure TA117FOreLiquidateAnniPrecMW.DATASetText(
  Sender: TField; const Text: String);
begin
  if Trim(Text) <> '/' then
    Sender.AsString:='01/' + Text;
  if Trim(Text) = '/' then
    Sender.Clear;
end;

procedure TA117FOreLiquidateAnniPrecMW.OREPERSEValidate(Sender: TField);
begin
  if (not Sender.IsNull) and (Sender.AsString <> 'S') and (Sender.AsString <> 'N') then
    raise Exception.Create('Sono consentiti solo i valori S/N!');
end;

procedure TA117FOreLiquidateAnniPrecMW.OREValidate(Sender: TField);
begin
  if not Sender.IsNull then
    OreMinutiValidate(Sender.AsString);
end;

procedure TA117FOreLiquidateAnniPrecMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(selDatiBloccati);
  if R450DtM <> nil then
    FreeAndNil(R450DtM);
  inherited;
end;

end.
