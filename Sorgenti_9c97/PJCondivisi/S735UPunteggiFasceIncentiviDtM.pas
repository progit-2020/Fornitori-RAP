unit S735UPunteggiFasceIncentiviDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Oracle, Db, OracleData, Variants, StrUtils,
  A000UCostanti, A000USessione, A000UInterfaccia, R004UGestStoricoDtM, S735UPunteggiFasceIncentiviMW;

type
  TS735FPunteggiFasceIncentiviDtM = class(TR004FGestStoricoDtM)
    Q735: TOracleDataSet;
    Q735DECORRENZA: TDateTimeField;
    Q735DECORRENZA_FINE: TDateTimeField;
    Q735PUNTEGGIO_DA: TFloatField;
    Q735PUNTEGGIO_A: TFloatField;
    Q735PERC: TFloatField;
    Q735TIPOLOGIA: TStringField;
    Q735CODQUOTA: TStringField;
    Q735DescQuota: TStringField;
    Q735Quota: TStringField;
    Q735FLESSIBILITA: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforePost(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    S735FPunteggiFasceIncentiviMW: TS735FPunteggiFasceIncentiviMW;
  end;

var
  S735FPunteggiFasceIncentiviDtM: TS735FPunteggiFasceIncentiviDtM;

implementation

uses S735UPunteggiFasceIncentivi;

{$R *.DFM}

procedure TS735FPunteggiFasceIncentiviDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=S735FPunteggiFasceIncentivi.InterfacciaR004;
  InterfacciaR004.OttimizzaDecorrenzaFine:=False;
  InterfacciaR004.AllineaSoloDecorrenzeIntersecanti:=True;
  InizializzaDataSet(Q735,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePost,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnNewRecord,
                           evOnTranslateMessage]);

  S735FPunteggiFasceIncentiviMW:=TS735FPunteggiFasceIncentiviMW.Create(Self);
  S735FPunteggiFasceIncentiviMW.Q735:=Q735;
  Q735.SetVariable('TIPO',S735FPunteggiFasceIncentiviMW.Tipo);
  Q735.Open;
end;

procedure TS735FPunteggiFasceIncentiviDtM.BeforePost(DataSet: TDataSet);
begin
  S735FPunteggiFasceIncentiviMW.BeforePost;

  inherited;
end;

end.
