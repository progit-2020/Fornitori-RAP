unit A066UValutaStrDtM1;

interface

uses
  C180FunzioniGenerali,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione, A000UInterfaccia, OracleData, Oracle, R004UGESTSTORICODTM,
  Variants, A066UValutaStrMW;

type
  TA066FValutaStrDtM1 = class(TR004FGestStoricoDtM)
    selT730: TOracleDataSet;
    QStampa: TOracleDataSet;
    selT730LIVELLO: TStringField;
    selT730CAUSALE: TStringField;
    selT730MAGGIORAZIONE: TFloatField;
    selT730TARIFFA_LIQ: TFloatField;
    selT730TARIFFA_MAT: TFloatField;
    selT730DECORRENZA: TDateTimeField;
    selT730DECORRENZA_FINE: TDateTimeField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT730AfterOpen(DataSet: TDataSet);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure selT730MAGGIORAZIONEValidate(Sender: TField);
  public
    A066FValutaStrMW: TA066FValutaStrMW;
    DataOld:TDateTime;
    LivelloFiltro: String;
    CausaleFiltro: String;
  end;

var
  A066FValutaStrDtM1: TA066FValutaStrDtM1;

implementation

uses A066UValutaStr;

{$R *.DFM}

procedure TA066FValutaStrDtM1.DataModuleCreate(Sender: TObject);
begin
  inherited;

  if Trim(Parametri.CampiRiferimento.C2_Livello) = '' then
  begin
    R180MessageBox('Per utilizzare questa funzione è necessario impostare'#13#10'il parametro aziendale "B.S.: livello per monetizzazione"!',INFORMA);
    exit;
  end;
  DataOld:=Parametri.DataLavoro;

  InterfacciaR004:=A066FValutaStr.InterfacciaR004;
  InizializzaDataSet(selT730,[evBeforeEdit,
                              evBeforeInsert,
                              evBeforePost,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost,
                              evOnNewRecord,
                              evOnTranslateMessage]);

  A066FValutaStrMW:=TA066FValutaStrMW.Create(Self);
  A066FValutaStrMW.selT730:=selT730;

  selT730.Open;
  A066FValutaStrMW.selT275.Open;
  A066FValutaStrMW.QFasce.Open;
end;

procedure TA066FValutaStrDtM1.selT730AfterOpen(DataSet: TDataSet);
begin
  inherited;
  A066FValutaStrMW.selT730AfterOpen(DataSet);
end;

procedure TA066FValutaStrDtM1.selT730MAGGIORAZIONEValidate(Sender: TField);
begin
  inherited;
  A066FValutaStrMW.selT730MAGGIORAZIONEValidate(Sender);
end;

procedure TA066FValutaStrDtM1.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  A066FValutaStrMW.OnNewRecord(DataSet);
end;

procedure TA066FValutaStrDtM1.BeforePost(DataSet: TDataSet);
begin
  A066FValutaStrMW.BeforePost(DataSet);
  inherited;
end;

end.
