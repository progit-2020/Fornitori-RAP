unit A160URegoleIncentiviMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, Oracle,
  Data.DB, A000UMessaggi, A000UInterfaccia, A000USessione, ControlloVociPaghe, C180FunzioniGenerali,
  Controls, Math, Variants;

type
  TA160FRegoleIncentiviMW = class(TR005FDataModuleMW)
    dsrInterfaccia: TDataSource;
    selInterfaccia: TOracleDataSet;
    selP150: TOracleDataSet;
    selP030: TOracleDataSet;
    QLiv: TOracleDataSet;
    insT765: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    selControlloVociPaghe:TControlloVociPaghe;
  public
    selT760: TOracleDataSet;
    function BeforePost: String;
    function VerificaVociPaghe(VoceOld,VoceNew:String): String;
    function ValutaInserimentoVocePaghe(Voce: String): Boolean;
    procedure selT760ABBATTIMENTO_MAXValidate(Sender: TField);
    procedure selT760ABBATTIMENTO_MAXSetText(Sender: TField; const Text: string);
    procedure selT760CalcFields;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA160FRegoleIncentiviMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selInterfaccia.SQL.Clear;
  if Parametri.CampiRiferimento.C7_Dato1 <> '' then
  begin
    if A000LookupTabella(Parametri.CampiRiferimento.C7_Dato1,selInterfaccia) then
    begin
      if selInterfaccia.VariableIndex('DECORRENZA') >= 0 then
        selInterfaccia.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
      selInterfaccia.Open;
    end;
  end
  else
    raise exception.Create(A000MSG_A160_INCENTIVI_DATO_1);

  selP150.SetVariable('Decorrenza',Parametri.DataLavoro);
  selP150.Open;
  selP030.SetVariable('Cod_Valuta',selP150.FieldByName('COD_VALUTA_BASE').AsString);
  selP030.SetVariable('Decorrenza',Parametri.DataLavoro);
  selP030.Open;

  selControlloVociPaghe:=TControlloVociPaghe.Create(Self,'');
end;

procedure TA160FRegoleIncentiviMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(selControlloVociPaghe);
end;

function TA160FRegoleIncentiviMW.BeforePost: String;
var VoceOld:String;
begin
inherited;
  if selT760.FieldByName('DECORRENZA').AsDateTime <> R180InizioMese(selT760.FieldByName('DECORRENZA').AsDateTime) then
    //R180MessageBox('Attenzione: la decorrenza è stata spostata all''inizio del mese specificato! ','INFORMA');
    Result:=A000MSG_MSG_DECORRENZA_INIZIO_MESE;
  selT760.FieldByName('DECORRENZA').AsDateTime:=R180InizioMese(selT760.FieldByName('DECORRENZA').AsDateTime);

  if selT760.FieldByName('PROPORZIONE_INCENTIVI').AsString <> '1' then
    selT760.FieldByName('SCAGLIONI_GGEFF').AsString:='N';

  if selT760.FieldByName('TIPO').AsString = 'D' then
  try
    insT765.Execute;
  except
  end;
end;

function TA160FRegoleIncentiviMW.VerificaVociPaghe(VoceOld,VoceNew:String):String;
begin
  Result:='';
  if not (selControlloVociPaghe.ControlloVociPaghe(VoceOld,VoceNew)) then
    Result:=selControlloVociPaghe.MessaggioLog;
end;

function TA160FRegoleIncentiviMW.ValutaInserimentoVocePaghe(Voce: String): Boolean;
begin
  selControlloVociPaghe.ValutaInserimentoVocePaghe(Voce);
end;

procedure TA160FRegoleIncentiviMW.selT760ABBATTIMENTO_MAXValidate(Sender: TField);
begin
  if Sender.AsInteger < 0 then
    raise Exception.Create(A000MSG_MSG_NO_MINORI_ZERO);
end;

procedure TA160FRegoleIncentiviMW.selT760ABBATTIMENTO_MAXSetText(
  Sender: TField; const Text: string);
var decimali:Real;
begin
  decimali:=power(10, - selP030.FieldByName('Num_dec_imp_voce').AsInteger);
  Sender.AsFloat:=R180Arrotonda(StrToFloat(Text),decimali,'P');
end;

procedure TA160FRegoleIncentiviMW.selT760CalcFields;
begin
   if selInterfaccia.Active then
    selT760.FieldByName('D_LIVELLO').AsString:=VarToStr(selInterfaccia.Lookup('CODICE',selT760.FieldByName('LIVELLO').AsString,'DESCRIZIONE'));
end;


end.
