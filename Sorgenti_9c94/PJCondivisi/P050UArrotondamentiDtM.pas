unit P050UArrotondamentiDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  R004UGestStoricoDtM, Variants, P050UArrotondamentiMW;

type
  TP050FArrotondamentiDtM = class(TR004FGestStoricoDtM)
    Q050K: TOracleDataSet;
    Q050: TOracleDataSet;
    Q050KCOD_ARROTONDAMENTO: TStringField;
    D050: TDataSource;
    Q050COD_ARROTONDAMENTO: TStringField;
    Q050COD_VALUTA: TStringField;
    Q050DECORRENZA: TDateTimeField;
    Q050DESCRIZIONE: TStringField;
    Q050VALORE: TFloatField;
    Q050TIPO: TStringField;
    Q050DECORRENZA_FINE: TDateTimeField;
    procedure DataModuleCreate(Sender: TObject);
    procedure Q050KAfterScroll(DataSet: TDataSet);
    procedure BeforeDelete(DataSet: TDataSet); override;
  private
  public
    { Public declarations }
    P050FArrotondamentiMW: TP050FArrotondamentiMW;
  end;

var
  P050FArrotondamentiDtM: TP050FArrotondamentiDtM;

implementation


{$R *.DFM}

procedure TP050FArrotondamentiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(Q050K,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePostNoStorico,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnTranslateMessage]);
  P050FArrotondamentiMW:=TP050FArrotondamentiMW.Create(Self);
  P050FArrotondamentiMW.Q050K:=Q050K;
  P050FArrotondamentiMW.Q050:=Q050;
  Q050K.Open;
end;

procedure TP050FArrotondamentiDtM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  P050FArrotondamentiMW.P050KBeforeDelete;
end;

procedure TP050FArrotondamentiDtM.Q050KAfterScroll(DataSet: TDataSet);
begin
  inherited;
  P050FArrotondamentiMW.P050KAfterScroll;
end;

end.
