unit A163UTipoQuoteMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, Oracle,
  Data.DB, Variants, C180FunzioniGenerali, ControlloVociPaghe, A000UMessaggi;

type
  TA163FTipoQuoteMW = class(TR005FDataModuleMW)
    selT305: TOracleDataSet;
    dsrT305: TDataSource;
    selT765Acc: TOracleDataSet;
    selT762: TOracleQuery;
    selT765Penalizz: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    selControlloVociPaghe:TControlloVociPaghe;
  public
    selT765: TOracleDataSet;
    lstVociPaghe:TStringList;
    function VerificaVociPaghe: String;
    procedure BeforeDelete(DataSet: TDataSet);
    function BeforePost: String;
    procedure selT765CalcFields(DataSet: TDataSet);
    procedure ValutaInserimentoVocePaghe;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA163FTipoQuoteMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT305.Open;
  selControlloVociPaghe:=TControlloVociPaghe.Create(Self,'');
  lstVociPaghe:=TStringList.Create;
end;

function TA163FTipoQuoteMW.VerificaVociPaghe: String;
var Msg: String;

 procedure CheckVociPaghe(Voce:String);
  var VoceOld:String;
  begin
    if (selT765.State = dsInsert) or (selT765.FieldByName(Voce).medpOldValue = null) then
      VoceOld:=''
    else
      VoceOld:=selT765.FieldByName(Voce).medpOldValue;
      if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selT765.FieldByName(Voce).AsString) then
      begin
        Msg:=Msg + #13#10 + StringReplace(StringReplace(selControlloVociPaghe.MessaggioLog,'Continuare?','',[]),'Attenzione: ','',[]);
        lstVociPaghe.Add(Voce);
      end;
  end;
begin
  Msg:='';
  lstVociPaghe.Clear;
  //Controllo voci paghe
  CheckVociPaghe('VP_INTERA');
  CheckVociPaghe('VP_PROPORZIONATA');
  CheckVociPaghe('VP_NETTA');
  CheckVociPaghe('VP_NETTARISP');
  CheckVociPaghe('VP_RISPARMIO');
  CheckVociPaghe('VP_NORISPARMIO');
  CheckVociPaghe('VP_QUANTITATIVA');
  if Msg <> '' then
    Msg:='Attenzione:' + #13#10 + Msg + #13#10 + 'Continuare?';
  Result:=Msg;
end;

function TA163FTipoQuoteMW.BeforePost: String;
var VoceOld:String;
begin
  if trim(selT765.FieldByName('CODICE').AsString) = '-' then
    raise Exception.Create(A000MSG_A163_ERR_CODICE_MENO);
  if trim(selT765.FieldByName('CODICE').AsString) = '_' then
    raise Exception.Create(A000MSG_A163_ERR_CODICE_UNDERSCORE);

  if selT765.FieldByName('TIPOQUOTA').AsString <> VarToStr(selT765.FieldByName('TIPOQUOTA').OldValue) then
  begin
    if selT765.FieldByName('CODICE').AsString = 'A#D' then
      raise exception.Create(A000MSG_A163_ERR_IMP_CAMBIARE);

    selT762.SetVariable('QUOTA',selT765.FieldByName('CODICE').AsString);

    selT762.Execute;
    if selT762.FieldAsInteger(0) > 0 then
      raise exception.Create(A000MSG_A163_ERR_QUOTE_REGISTRATE);
  end;

  if ((selT765.FieldByName('TIPOQUOTA').AsString = 'C') or (selT765.FieldByName('TIPOQUOTA').AsString = 'V')) and
     (Trim(selT765.FieldByName('ACCONTI').AsString) = '') then
     raise exception.Create(A000MSG_A163_ERR_RIFERIMENTO);
  if (selT765.FieldByName('TIPOQUOTA').AsString = 'Q') and (Trim(selT765.FieldByName('CAUSALE_ASSESTAMENTO').AsString) = '') then
     raise exception.Create(A000MSG_A163_ERR_ASSESTAMENTO);
   selT765Penalizz.Execute; //selT765Penalizz.Execute;
  if (selT765.FieldByName('TIPOQUOTA').AsString = 'P') and (selT765Penalizz.FieldAsInteger(0) > 0) then
    raise exception.Create(A000MSG_A163_ERR_PENALIZZAZIONE);

  //Controlli non bloccanti
  if selT765.FieldByName('DECORRENZA').AsDateTime <> R180InizioMese(selT765.FieldByName('DECORRENZA').AsDateTime) then
    //R180MessageBox('Attenzione: la decorrenza è stata spostata all''inizio del mese specificato! ','INFORMA');
    Result:=A000MSG_A163_MSG_DECORRENZA_SPOSTATA;
  selT765.FieldByName('DECORRENZA').AsDateTime:=R180InizioMese(selT765.FieldByName('DECORRENZA').AsDateTime);
end;

procedure TA163FTipoQuoteMW.ValutaInserimentoVocePaghe;
var i:Integer;
begin
  for i:=0 to lstVociPaghe.Count - 1 do
    selControlloVociPaghe.ValutaInserimentoVocePaghe(selT765.FieldByName(lstVociPaghe[i]).AsString);
end;

procedure TA163FTipoQuoteMW.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if selT765.FieldByName('CODICE').AsString = 'A#D' then
    raise exception.Create(A000MSG_A163_ERR_IMP_CANCELLARE);
  selT762.SetVariable('QUOTA',selT765.FieldByName('CODICE').AsString);
  selT762.Execute;
  if selT762.FieldAsInteger(0) > 0 then
    raise exception.Create(A000MSG_A163_ERR_IMP_CANCELLARE_REGIST);
end;

procedure TA163FTipoQuoteMW.selT765CalcFields(DataSet: TDataSet);
begin
  inherited;
  if selT765.FieldByName('TIPOQUOTA').AsString = 'A' then
    selT765.FieldByName('D_TIPOQUOTA').AsString:='Acconto '
  else if selT765.FieldByName('TIPOQUOTA').AsString = 'S' then
    selT765.FieldByName('D_TIPOQUOTA').AsString:='Saldo'
  else if selT765.FieldByName('TIPOQUOTA').AsString = 'T' then
    selT765.FieldByName('D_TIPOQUOTA').AsString:='Saldo Totale'
  else if selT765.FieldByName('TIPOQUOTA').AsString = 'I' then
    selT765.FieldByName('D_TIPOQUOTA').AsString:='Saldo Individuale'
  else if selT765.FieldByName('TIPOQUOTA').AsString = 'V' then
    selT765.FieldByName('D_TIPOQUOTA').AsString:='Saldo Valutativo'
  else if selT765.FieldByName('TIPOQUOTA').AsString = 'C' then
    selT765.FieldByName('D_TIPOQUOTA').AsString:='Saldo Collettivo'
  else if selT765.FieldByName('TIPOQUOTA').AsString = 'D' then
    selT765.FieldByName('D_TIPOQUOTA').AsString:='Saldo Collettivo Valutativo'
  else if selT765.FieldByName('TIPOQUOTA').AsString = 'Q' then
    selT765.FieldByName('D_TIPOQUOTA').AsString:='Quota quantitativa'
  else if selT765.FieldByName('TIPOQUOTA').AsString = 'P' then
    selT765.FieldByName('D_TIPOQUOTA').AsString:='Penalizzazione';
end;

procedure TA163FTipoQuoteMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(selControlloVociPaghe);
  FreeAndNil(lstVociPaghe);
end;

end.
