unit A082UCdcPercentDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Oracle, Db, OracleData, R004UGESTSTORICODTM,
  A000UCostanti, A000USessione, A000UInterfaccia, C180FUNZIONIGENERALI, C700USelezioneAnagrafe,
  (*Midaslib,*) DBClient,  Variants,A082UCdcPercentMW;

type
  TA082FCdcPercentDtM = class(TR004FGestStoricoDtM)
    selT433: TOracleDataSet;
    selT433PROGRESSIVO: TIntegerField;
    selT433DECORRENZA: TDateTimeField;
    selT433DECORRENZA_FINE: TDateTimeField;
    selT433CODICE: TStringField;
    selT433PERCENTUALE: TFloatField;
    selT433CODICE_DESCRIZIONE: TStringField;
    procedure selT433CalcFields(DataSet: TDataSet);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure selT433CODICEValidate(Sender: TField);
    procedure selT433CODICESetText(Sender: TField; const Text: string);
    procedure DataModuleCreate(Sender: TObject);
    procedure selT433NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    LungTipoQuota: integer;
    A082FCdcPercentMW: TA082FCdcPercentMW;
    procedure CaricamentocdsT433;
    procedure CaricamentoDati(Query:TOracleDataSet; Dato,ParametriDato:String; var LungTipoQuota:Integer);
  end;

var
  A082FCdcPercentDtM: TA082FCdcPercentDtM;

implementation

uses A082UCdcPercent;

{$R *.DFM}

procedure TA082FCdcPercentDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A082FCdcPercentMW:=TA082FCdcPercentMW.Create(Self);
  A082FCdcPercentMW.selT433_Funzioni:=selT433;
  A082FCdcPercentMW.CreacdsT433;
  InterfacciaR004:=A082FCdcPercent.InterfacciaR004;
  InterfacciaR004.OttimizzaDecorrenzaFine:=False;
  InterfacciaR004.GestioneDecorrenzaFine:=False;
  InizializzaDataSet(selT433,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePost,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnTranslateMessage]);
  A082FCdcPercent.DButton.DataSet:=selT433;
  CaricamentoDati(A082FCdcPercentMW.selCdcPercent,'CODICE',Parametri.CampiRiferimento.C13_CdcPercentualizzati,LungTipoQuota);
  selT433.Open;
//  A082FCdcPercent.DoAfterPost:=True;
end;

procedure TA082FCdcPercentDtM.CaricamentocdsT433;
var situazione:boolean;
begin
  situazione:=A082FCdcPercent.Visionecorrente1.Checked;
  //Tolgo il filtro della visione corrente
  if situazione then
    A082FCdcPercent.Visionecorrente1Click(nil);

  A082FCdcPercentMW.caricaCdsT433;

  if A082FCdcPercent.Visionecorrente1.Checked <> situazione then
    A082FCdcPercent.Visionecorrente1Click(nil);
  selT433.Open;
end;

procedure TA082FCdcPercentDtM.CaricamentoDati(Query: TOracleDataSet; Dato,ParametriDato:String; var LungTipoQuota: Integer);
var Colonna: Integer;
begin
  LungTipoQuota:=0;
  Colonna:=R180GetColonnaDbGrid(A082FCdcPercent.dgrdCdcPercent,dato);
  A082FCdcPercent.dgrdCdcPercent.Columns[colonna].Title.Caption:=UpperCase(Copy(ParametriDato,1,1)) +
                                                                 LowerCase(Copy(ParametriDato,2,length(ParametriDato)));
  if A000LookupTabella(ParametriDato,Query) then
  begin
    if Query.VariableIndex('DECORRENZA') >= 0 then
      Query.SetVariable('DECORRENZA',InterfacciaR004.DataLavoro);
    Query.Close;
    Query.Open;
    //Carico PickList
    with Query do
    begin
      First;
      while not Eof do
      begin
        if Length(FieldByName('CODICE').AsString) > LungTipoQuota then
          LungTipoQuota:=Length(FieldByName('CODICE').AsString);
        Next;
      end;
      First;
      A082FCdcPercent.dgrdCdcPercent.Columns[Colonna].PickList.Clear;
      while not Eof do
      begin
       A082FCdcPercent.dgrdCdcPercent.Columns[Colonna].PickList.Add(Format('%-*s %s',[LungTipoQuota,FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
       Next;
      end;
    end;
  end;
end;

procedure TA082FCdcPercentDtM.selT433NewRecord(DataSet: TDataSet);
var cdc: string;
begin
  inherited;
  cdc:=parametri.campiriferimento.C13_CdcPercentualizzati;
  selT433.FieldByName('PROGRESSIVO').AsInteger:=C700Progressivo;
  selT433.FieldByName('PERCENTUALE').AsFloat:=100;

  with A082FCdcPercentMW do
  begin
    OpenT430(cdc,C700Progressivo,InterfacciaR004.DataLavoro);
    if selT430.FieldByName(''+ cdc +'').AsString <> '' then
      selT433.FieldByName('CODICE').AsString:=selT430.FieldByName(''+ cdc +'').AsString;
  end;
end;

procedure TA082FCdcPercentDtM.selT433CODICESetText(Sender: TField;
  const Text: string);
begin
  inherited;
  Sender.AsString:=Trim(Copy(Text,1,LungTipoQuota));
end;

procedure TA082FCdcPercentDtM.selT433CODICEValidate(Sender: TField);
  var Colonna:Integer;
begin
  inherited;
  Colonna:=R180GetColonnaDbGrid(A082FCdcPercent.dgrdCdcPercent,Sender.FieldName);
  if Colonna >= 0 then
    if (R180IndexOf(A082FCdcPercent.dgrdCdcPercent.Columns[Colonna].PickList,Sender.AsString,LungTipoQuota) = -1) then
      raise Exception.Create('Valore inesistente! Scegliere i valori dalla lista!');
end;

procedure TA082FCdcPercentDtM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A082FCdcPercent.messaggio:=False;
  A082FCdcPercentMW.ElaboraPeriodi;
  A082FCdcPercent.actRefresh.Execute;
  A082FCdcPercentMW.SituazioneModificata:=True;
  A082FCdcPercent.Controlli;
  A082FCdcPercent.messaggio:=True;
end;

procedure TA082FCdcPercentDtM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  A082FCdcPercentMW.ElaboraPeriodi;
  A082FCdcPercent.actRefresh.Execute;
  A082FCdcPercentMW.SituazioneModificata:=True;
  A082FCdcPercent.Controlli;
end;

procedure TA082FCdcPercentDtM.BeforePost(DataSet: TDataSet);
begin
  if selT433.FieldByName('Decorrenza_Fine').IsNull then
    selT433.FieldByName('Decorrenza_Fine').AsString:='31/12/3999';
  if (selT433.FieldByName('Decorrenza').AsDateTime > selT433.FieldByName('Decorrenza_Fine').AsDateTime) and
     (not selT433.FieldByName('Decorrenza_Fine').IsNull) then
    raise Exception.Create('Attenzione. La scadenza non può essere minore della decorrenza.');
  if (selT433.FieldByName('Percentuale').asFloat <= 0) or
     (selT433.FieldByName('Percentuale').asFloat > 100) or
     (selT433.FieldByName('Percentuale').IsNull) then
    raise Exception.Create('Attenzione. La percentuale può assumere valori compresi tra 0 e 100.');
  inherited;
end;

procedure TA082FCdcPercentDtM.selT433CalcFields(DataSet: TDataSet);
begin
  inherited;
  with A082FCdcPercentMW do
  begin
    if selCdcPercent.Active then
    begin
      selCdcPercent.SearchRecord('CODICE',selT433.FieldByName('CODICE').AsString,[srFromBeginning]);
      selT433.FieldByName('CODICE_DESCRIZIONE').AsString:=selCdcPercent.FieldByName('DESCRIZIONE').AsString;
    end;
  end;
end;

end.
