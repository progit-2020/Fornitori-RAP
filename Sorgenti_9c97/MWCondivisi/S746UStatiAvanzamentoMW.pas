unit S746UStatiAvanzamentoMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, Data.DB, C180FunzioniGenerali,
  A000UMessaggi, MedpBackupOldValue;

type
  TS746FStatiAvanzamentoMW = class(TR005FDataModuleMW)
    selSG741: TOracleDataSet;
    dSG741: TDataSource;
    selSG746: TOracleDataSet;
    dSG746: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private

  public
    SG746: TOracleDataSet;
    SG746OldValues: TMedpBackupOldValue;
    function BeforePost(DataSet: TDataSet):String;
    procedure RecuperaListaRegole;
    procedure RecuperaListaStampa;
    procedure SG746CODICEValidate;
    procedure SG746DECORRENZAValidate;
    procedure ResetPeriodoRichiestaPresaVisione;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TS746FStatiAvanzamentoMW.BeforePost(DataSet: TDataSet):String;
begin
  Result:='';
  //Periodo di compilazione
  if (SG746.FieldByName('DATA_DA').AsString = '')
  or (SG746.FieldByName('DATA_A').AsString = '') then
    raise exception.Create(A000MSG_S746_ERR_DATE_DA_VALORIZZARE);
  if SG746.FieldByName('DATA_DA').AsDateTime > SG746.FieldByName('DATA_A').AsDateTime then
    raise exception.Create(A000MSG_S746_ERR_ORDINE_DATE_COMP);
  if ((SG746.FieldByName('DATA_DA_RICHIESTA_VISIONE').AsString = '') and (SG746.FieldByName('DATA_A_RICHIESTA_VISIONE').AsString <> ''))
  or ((SG746.FieldByName('DATA_A_RICHIESTA_VISIONE').AsString = '') and (SG746.FieldByName('DATA_DA_RICHIESTA_VISIONE').AsString <> '')) then
    raise exception.Create(A000MSG_S746_ERR_DATE_VAL_O_SVUO);
  if SG746.FieldByName('DATA_DA_RICHIESTA_VISIONE').AsDateTime > SG746.FieldByName('DATA_A_RICHIESTA_VISIONE').AsDateTime then
    raise exception.Create(A000MSG_S746_ERR_ORDINE_DATE_RICH);
  if ((R180Anno(SG746.FieldByName('DATA_DA').AsDateTime) <> (R180Anno(SG746.FieldByName('DECORRENZA').AsDateTime) + 1))
      or (R180Anno(SG746.FieldByName('DATA_A').AsDateTime) <> (R180Anno(SG746.FieldByName('DECORRENZA').AsDateTime) + 1)))
  and ((SG746.FieldByName('DATA_DA').AsDateTime <> SG746OldValues.FieldByName('DATA_DA').Value)
      or (SG746.FieldByName('DATA_A').AsDateTime <> SG746OldValues.FieldByName('DATA_A').Value)) then
    Result:=Format(A000MSG_S746_ERR_FMT_PERIODO_INTERNO,[IntToStr(R180Anno(SG746.FieldByName('DECORRENZA').AsDateTime) + 1)]);
  if (SG746.FieldByName('VAL_INTERM_MODIFICABILE').AsString = 'N') then
    SG746.FieldByName('VAL_INTERM_OBBLIGATORIA').AsString:='N';
  inherited;
end;

procedure TS746FStatiAvanzamentoMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  SG746OldValues:=TmedpBackupOldValue.Create(Self);
end;

procedure TS746FStatiAvanzamentoMW.RecuperaListaRegole;
begin
  R180SetVariable(selSG741,'DATA',SG746.FieldByName('DECORRENZA').AsDateTime);
  selSG741.Open;
end;

procedure TS746FStatiAvanzamentoMW.RecuperaListaStampa;
begin
  R180SetVariable(selSG746,'DATA',SG746.FieldByName('DECORRENZA').AsDateTime);
  R180SetVariable(selSG746,'CODICE',SG746.FieldByName('CODICE').AsInteger);
  R180SetVariable(selSG746,'CODREGOLA',SG746.FieldByName('CODREGOLA').AsString);
  R180SetVariable(selSG746,'DESCRIZIONE',SG746.FieldByName('DESCRIZIONE').AsString);
  selSG746.Open;
end;

procedure TS746FStatiAvanzamentoMW.SG746CODICEValidate;
begin
  inherited;
  RecuperaListaStampa;
  if SG746.FieldByName('CODICE').AsInteger = 1 then
    SG746.FieldByName('MODIFICABILE').AsString:='S';
end;

procedure TS746FStatiAvanzamentoMW.SG746DECORRENZAValidate;
begin
  inherited;
  RecuperaListaRegole;
  RecuperaListaStampa;
end;

procedure TS746FStatiAvanzamentoMW.ResetPeriodoRichiestaPresaVisione;
begin
  SG746.FieldByName('DATA_DA_RICHIESTA_VISIONE').AsDateTime:=EncodeDate(1900,1,1);
  SG746.FieldByName('DATA_A_RICHIESTA_VISIONE').AsDateTime:=EncodeDate(3999,12,31);
end;

end.
