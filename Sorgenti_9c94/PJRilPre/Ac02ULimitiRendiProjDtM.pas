unit Ac02ULimitiRendiProjDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione, A000UInterfaccia,  RegistrazioneLog, OracleData, Oracle,
  R004UGestStoricoDtM, C180FUNZIONIGENERALI, C700USelezioneAnagrafe, Variants, Ac02ULimitiRendiProjMW;

type
  TAc02FLimitiRendiProjDtM = class(TR004FGestStoricoDtM)
    selT753: TOracleDataSet;
    selT753ORE_MAX: TStringField;
    selT753ORE_FRUITO: TStringField;
    selT753PROGRESSIVO: TIntegerField;
    selT753D_PROG: TStringField;
    selT753C_PROG: TStringField;
    selT753DECORRENZA: TDateTimeField;
    selT753DECORRENZA_FINE: TDateTimeField;
    selT753C_ATT: TStringField;
    selT753D_ATT: TStringField;
    selT753C_TASK: TStringField;
    selT753D_TASK: TStringField;
    selT753ID_T752: TFloatField;
    selT753ID_T750: TFloatField;
    selT753ID_T751: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT753FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    TipoOperazione: String;
    Ac02MW: TAc02FLimitiRendiProjMW;
  end;

var
  Ac02FLimitiRendiProjDtM: TAc02FLimitiRendiProjDtM;

implementation

uses Ac02ULimitiRendiProj, SelAnagrafe;

{$R *.DFM}


procedure TAc02FLimitiRendiProjDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Ac02MW:=TAc02FLimitiRendiProjMW.Create(Self);
  Ac02MW.selT753:=selT753;
  InizializzaDataSet(selT753,[evBeforeEdit,
                              evBeforeInsert,
                              evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost,
                              evOnTranslateMessage]);
  with Ac02FLimitiRendiProj do
  begin
    DButton.DataSet:=selT753;
    CambiaProgressivo;
  end;
end;

procedure TAc02FLimitiRendiProjDtM.selT753FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=Ac02MW.OnFilterRecord(DataSet);
end;

end.
