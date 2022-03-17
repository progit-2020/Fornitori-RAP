unit A080URientriObbligatoriDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStoricoDTM, DB, OracleData,
  A000UInterfaccia, C180FunzioniGenerali, Oracle;

type
  TA080FRientriObbligatoriDtM = class(TR004FGestStoricoDtM)
    selT029: TOracleDataSet;
    selT029CODICE: TStringField;
    selT029DECORRENZA: TDateTimeField;
    selT029GG_LAVORATIVI: TFloatField;
    selT029DECORRENZA_FINE: TDateTimeField;
    selT029RIENTRI_OBBL: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure OnNewRecord(DataSet: TDataSet); override;
  private
    { Private declarations }
    FTipoCartellino:String;
    procedure PutTipoCartellino(Valore:String);
  public
    { Public declarations }
    property TipoCartellino:String read FTipoCartellino write PutTipoCartellino;
  end;

var
  A080FRientriObbligatoriDtM: TA080FRientriObbligatoriDtM;

implementation

{$R *.dfm}

uses A080USoglieStraordinario;

procedure TA080FRientriObbligatoriDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=TA080FSoglieStraordinario(Owner).InterfacciaR004;
  InizializzaDataSet(selT029,[evBeforeInsert,
                              evBeforePost,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost,
                              evOnNewRecord,
                              evOnTranslateMessage]);
end;

procedure TA080FRientriObbligatoriDtM.PutTipoCartellino(Valore:String);
begin
  FTipoCartellino:=Valore;
  R180SetVariable(selT029,'TIPOCARTELLINO',FTipoCartellino);
  selT029.Open;
end;

procedure TA080FRientriObbligatoriDtM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  selT029.FieldByName('CODICE').AsString:=TipoCartellino;
end;

end.
