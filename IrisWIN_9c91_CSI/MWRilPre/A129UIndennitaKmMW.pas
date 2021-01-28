unit A129UIndennitaKmMW;

interface

uses
  System.SysUtils, System.Classes, Variants, R005UDataModuleMW, Data.DB, OracleData, ControlloVociPaghe;

type
  TA129FIndennitaKmMW = class(TR005FDataModuleMW)
    dsrP030: TDataSource;
    selP030: TOracleDataSet;
    selP030COD_VALUTA: TStringField;
    selP030DECORRENZA: TDateTimeField;
    selP030DESCRIZIONE: TStringField;
    selP030ABBREVIAZIONE: TStringField;
    selP030NUM_DEC_IMP_VOCE: TIntegerField;
    selP030NUM_DEC_IMP_UNIT: TIntegerField;
    dsrP050: TDataSource;
    selP050: TOracleDataSet;
    selP050COD_ARROTONDAMENTO: TStringField;
    selP050COD_VALUTA: TStringField;
    selP050DECORRENZA: TDateTimeField;
    selP050DESCRIZIONE: TStringField;
    selP050VALORE: TFloatField;
    selP050TIPO: TStringField;
    selP050descvaluta: TStringField;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    FSelM021_Funzioni: ToracleDataset;
    selControlloVociPaghe:TControlloVociPaghe;
  public
    procedure InserisciVocePaghe(CampoCodVoce: String);
    function VerificaVociPaghe(CampoCodVoce: String): String;
    procedure selM021CalcFields;
    property selM021_Funzioni: TOracleDataset read FSelM021_Funzioni write FSelM021_Funzioni;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA129FIndennitaKmMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selP050.FieldByName('descvaluta').LookupDataSet:=selP030;
  selControlloVociPaghe:=TControlloVociPaghe.Create(Self,'');
end;

procedure TA129FIndennitaKmMW.selM021CalcFields;
begin
  if selP050.GetVariable('Decorrenza') <> FSelM021_Funzioni.FieldByName('DECORRENZA').AsDateTime then
  begin
    selP050.Close;
    selP050.SetVariable('Decorrenza',FSelM021_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    selP050.Open;
  end;
  if selP030.GetVariable('Decorrenza') <> FSelM021_Funzioni.FieldByName('DECORRENZA').AsDateTime then
  begin
    selP030.Close;
    selP030.SetVariable('Decorrenza',FSelM021_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    selP030.Open;
  end;
  FSelM021_Funzioni.FieldByName('descarrotondamento').AsString:='';
  if selP050.SearchRecord('COD_ARROTONDAMENTO',FSelM021_Funzioni.FieldByName('ARROTONDAMENTO').AsString,[srFromBeginning]) then
    FSelM021_Funzioni.FieldByName('descarrotondamento').AsString:=selP050.FieldByName('DESCRIZIONE').AsString;
end;

function TA129FIndennitaKmMW.VerificaVociPaghe(CampoCodVoce:String): String;
var VoceOld: String;
begin
  Result:='';
  if (FSelM021_Funzioni.State = dsInsert) or (FSelM021_Funzioni.FieldByName(CampoCodVoce).medpOldValue = null) then
    VoceOld:=''
  else
    VoceOld:=FSelM021_Funzioni.FieldByName(CampoCodVoce).medpOldValue;
  if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,FSelM021_Funzioni.FieldByName(CampoCodVoce).AsString) then
    Result:=selControlloVociPaghe.MessaggioLog;
end;

procedure TA129FIndennitaKmMW.InserisciVocePaghe(CampoCodVoce:String);
begin
  //se voce vuota esco ma non faccio abort altrimenti interromperei il salvataggio
  if Trim(FSelM021_Funzioni.FieldByName(CampoCodVoce).AsString) = '' then Exit;

  if not selControlloVociPaghe.ValutaInserimentoVocePaghe(FSelM021_Funzioni.FieldByName(CampoCodVoce).AsString) then
    Abort;
end;

procedure TA129FIndennitaKmMW.DataModuleDestroy(Sender: TObject);
begin
  selP030.Close;
  selP050.Close;
  FreeAndNil(selControlloVociPaghe);
  inherited;
end;

end.
