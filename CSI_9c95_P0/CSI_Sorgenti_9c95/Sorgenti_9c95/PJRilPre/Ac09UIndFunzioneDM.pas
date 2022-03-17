unit Ac09UIndFunzioneDM;

interface

uses
  R004UGestStoricoDtM, DB, Classes, OracleData, SysUtils, Ac09UIndFunzioneMW;

type
  TAc09FIndFunzioneDM = class(TR004FGestStoricoDtM)
    selCSI006: TOracleDataSet;
    selCSI006DATA: TDateTimeField;
    selCSI006TIMBRATURE: TStringField;
    selCSI006GIUSTIFICATIVI: TStringField;
    selCSI006ORARIO: TStringField;
    selCSI006ORE_ASSENZA: TStringField;
    selCSI006ORE_RESE: TStringField;
    selCSI006TIPO_RECORD: TStringField;
    selCSI006FASCIA: TStringField;
    selCSI006SUM_ORE: TStringField;
    selCSI006SUM_DISAGIO_SERALE: TStringField;
    selCSI006ID: TFloatField;
    selCSI006PROGRESSIVO: TFloatField;
    selCSI006LISTA_INDFUNZIONE: TStringField;
    selCSI006CONTRATTO: TStringField;
    selCSI006SUM_ORE_A: TStringField;
    selCSI006SUM_DISAGIO_SERALE_A: TStringField;
    selCSI006MATRICOLA: TStringField;
    selCSI006NOME: TStringField;
    selCSI006COGNOME: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selCSI006AfterScroll(DataSet: TDataSet);
    procedure selCSI006CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    Ac09MW: TAc09FIndFunzioneMW;
    procedure evtAssegnaProc(Assegna:Boolean);
  end;

var
  Ac09FIndFunzioneDM: TAc09FIndFunzioneDM;

implementation

uses Ac09UIndFunzione;

{$R *.DFM}

procedure TAc09FIndFunzioneDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selCSI006,[evBeforeEdit,
                                evBeforeInsert,
                                evBeforePostNoStorico,
                                evBeforeDelete,
                                evAfterDelete,
                                evAfterPost,
                                evOnTranslateMessage]);
  Ac09MW:=TAc09FIndFunzioneMW.Create(Self);
  Ac09MW.selCSI006:=selCSI006;
  Ac09MW.evtAssegnaProc:=evtAssegnaProc;
end;

procedure TAc09FIndFunzioneDM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(Ac09MW);
  inherited;
end;

procedure TAc09FIndFunzioneDM.selCSI006AfterScroll(DataSet: TDataSet);
begin
  inherited;
  Ac09MW.selCSI006AfterScroll;
  Ac09FIndFunzione.CaricaListaIndFunzione;
  Ac09FIndFunzione.AbilitazioniComponenti;
end;

procedure TAc09FIndFunzioneDM.selCSI006CalcFields(DataSet: TDataSet);
begin
  inherited;
  Ac09MW.selCSI006CalcFields;
end;

procedure TAc09FIndFunzioneDM.evtAssegnaProc(Assegna:Boolean);
begin
  if Assegna then
  begin
    selCSI006.OnCalcFields:=selCSI006CalcFields;
    selCSI006.AfterScroll:=selCSI006AfterScroll;
  end
  else
  begin
    selCSI006.AfterScroll:=nil;
    selCSI006.OnCalcFields:=nil;
  end;
end;

end.
