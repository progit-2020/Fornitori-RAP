unit P130UPagamentiDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  R004UGestStoricoDTM, Variants, P130UPagamentiMW;

type
  TP130FPagamentiDtM = class(TR004FGestStoricoDtM)
    selP130: TOracleDataSet;
    selP130COD_PAGAMENTO: TStringField;
    selP130DESCRIZIONE: TStringField;
    selP130MOD_PAGAMENTO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    P130FPagamentiMW: TP130FPagamentiMW;
  end;

var
  P130FPagamentiDtM: TP130FPagamentiDtM;

implementation

{$R *.DFM}

uses P130UPagamenti;


procedure TP130FPagamentiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  P130FPagamentiMW:=TP130FPagamentiMW.Create(Self);
  P130FPagamentiMW.selP130:=selP130;
  InizializzaDataSet(selP130,[evBeforeEdit,
                              evBeforeInsert,
                              evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost,
                              evOnTranslateMessage]);
  P130FPagamenti.DButton.DataSet:=selP130;
  selP130.Open;
end;

end.
