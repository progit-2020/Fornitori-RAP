unit A020UCausPresenzeStoricoDtM1;

interface

uses
  System.SysUtils, System.Classes, R004UGestStoricoDTM, Data.DB, OracleData,
  A020UCausPresenzeStoricoMW, C180FunzioniGenerali;

type
  TA020FCausPresenzeStoricoDtM1 = class(TR004FGestStoricoDtM)
    selT235: TOracleDataSet;
    selT235ID: TIntegerField;
    selT235DECORRENZA: TDateTimeField;
    selT235DECORRENZA_FINE: TDateTimeField;
    selT235DESCRIZIONE: TStringField;
    selT235CODICE: TStringField;
    selT235DESC_CAUSALE: TStringField;
    selT235CAUSCOMP_DEBITOGG: TStringField;
    selT235RENDICONTA_PROGETTI: TStringField;
    selT235ARROT_RIEPGG: TStringField;
    selT235ARROT_RIEPGG_ORENORM: TStringField;
    selT235ARROT_RIEPGG_FASCE: TStringField;
    selT235ARROT_RIEPGG_FINECONT: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforePost(DataSet: TDataSet); override;
  private
    IdCausale:Integer;
  public
    A020FCausPresenzeStoricoMW:TA020FCausPresenzeStoricoMW;
    constructor Create(AOwner: TComponent; IdCausale:Integer); overload;
  end;

var
  A020FCausPresenzeStoricoDtM1: TA020FCausPresenzeStoricoDtM1;

implementation

uses A020UCausPresenzeStorico;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA020FCausPresenzeStoricoDtM1.BeforePost(DataSet: TDataSet);
begin
  inherited;
  if not selT235.FieldByName('ARROT_RIEPGG').IsNull then
    R180OraValidate(selT235.FieldByName('ARROT_RIEPGG').AsString);
end;

constructor TA020FCausPresenzeStoricoDtM1.Create(AOwner: TComponent; IdCausale:Integer);
begin
  Self.IdCausale:=IdCausale;
  A020FCausPresenzeStoricoMW:=TA020FCausPresenzeStoricoMW.Create(Self);
  A020FCausPresenzeStoricoMW.Inizializza(IdCausale);
  A020FCausPresenzeStoricoMW.ApriT275;
  inherited Create(AOwner);
end;

procedure TA020FCausPresenzeStoricoDtM1.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT235.SetVariable('ID',IdCausale);
  InterfacciaR004:=A020FCausPresStorico.InterfacciaR004;
  InizializzaDataSet(selT235,[evBeforeEdit,
                              evBeforeInsert,
                              evBeforePost,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost,
                              evOnNewRecord,
                              evOnTranslateMessage]);
  A020FCausPresStorico.DButton.DataSet:=selT235;
  InterfacciaR004.OttimizzaStorico:=False;

  selT235CODICE.LookupDataSet:=A020FCausPresenzeStoricoMW.selT275;
  selT235DESC_CAUSALE.LookupDataSet:=A020FCausPresenzeStoricoMW.selT275;
  selT235.Open;
end;

end.
