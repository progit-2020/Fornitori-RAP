unit P030UValuteDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Oracle, Db, OracleData, A000UCostanti, A000USessione,A000UInterfaccia, R004UGestStoricoDtM,
  Variants, P030UValuteMW;

type
  TP030FValuteDtM = class(TR004FGestStoricoDtM)
    selP030: TOracleDataSet;
    selP030COD_VALUTA: TStringField;
    selP030DECORRENZA: TDateTimeField;
    selP030DESCRIZIONE: TStringField;
    selP030ABBREVIAZIONE: TStringField;
    selP030NUM_DEC_IMP_VOCE: TIntegerField;
    selP030NUM_DEC_IMP_UNIT: TIntegerField;
    selP030DECORRENZA_FINE: TDateTimeField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    P030FValuteMW: TP030FValuteMW;
  end;

var
  P030FValuteDtM: TP030FValuteDtM;

implementation

uses P030UValute;

{$R *.DFM}

procedure TP030FValuteDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  P030FValuteMW:=TP030FValuteMW.Create(Self);
  P030FValuteMW.selP030:=selP030;
  InterfacciaR004:=P030FValute.InterfacciaR004;
  InizializzaDataSet(selP030,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePost,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnNewRecord,
                           evOnTranslateMessage]);
  P030FValute.DButton.DataSet:=selP030;
  selP030.Open;
end;

end.
