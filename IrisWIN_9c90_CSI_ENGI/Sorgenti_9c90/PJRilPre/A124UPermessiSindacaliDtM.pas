unit A124UPermessiSindacaliDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, Oracle, DB, OracleData, C700USelezioneAnagrafe,
  C180FunzioniGenerali, A000UCostanti, A000USessione, A000UInterfaccia, C700USelezioneAnagrafeDtM,
  DBClient, A124UPermessiSindacaliMW;

type
  TA124FPermessiSindacaliDtM = class(TR004FGestStoricoDtM)
    selT248: TOracleDataSet;
    selT248PROGRESSIVO: TIntegerField;
    selT248DATA: TDateTimeField;
    selT248NUMERO_PROT: TStringField;
    selT248DATA_PROT: TDateTimeField;
    selT248DALLE: TStringField;
    selT248ALLE: TStringField;
    selT248ABBATTE_COMPETENZE: TStringField;
    selT248COD_SINDACATO: TStringField;
    selT248COD_ORGANISMO: TStringField;
    selT248STATO: TStringField;
    selT248PROT_MODIFICA: TStringField;
    selT248DATA_MODIFICA: TDateTimeField;
    selT248SINDACATO: TStringField;
    selT248RSU: TStringField;
    selT248RAGGRUPPAMENTO: TStringField;
    selT248SINDACATI_RAGGRUPPATI: TStringField;
    selT248ORGANISMO: TStringField;
    selT248ORE: TStringField;
    selT248TIPO_PERMESSO: TStringField;
    selT248PROG_PERMESSO: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selT248DALLEValidate(Sender: TField);
    procedure selT248OREValidate(Sender: TField);
    procedure selT248AfterScroll(DataSet: TDataSet);
    procedure selT248NewRecord(DataSet: TDataSet);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure DataModuleDestroy(Sender: TObject);
  private
    {private declarations}
    procedure evtRichiesta(Msg,Chiave:String);
  public
    A124MW: TA124FPermessiSindacaliMW;
  end;

var
  A124FPermessiSindacaliDtM: TA124FPermessiSindacaliDtM;

implementation

uses A124UPermessiSindacali;

{$R *.dfm}

procedure TA124FPermessiSindacaliDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT248,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  A124MW:=TA124FPermessiSindacaliMW.Create(Self);
  A124MW.A004MW.Chiamante:='A124';
  A124MW.selT248:=selT248;
  A124MW.selT248Canc.AfterDelete:=selT248.AfterDelete;
  A124MW.selT248Canc.AfterPost:=selT248.AfterPost;
  A124MW.selT248Canc.AfterScroll:=selT248.AfterScroll;
  A124MW.selT248Canc.BeforeDelete:=selT248.BeforeDelete;
  A124MW.selT248Canc.BeforePost:=selT248.BeforePost;
  A124MW.selT248Canc.OnNewRecord:=selT248.OnNewRecord;
  A124MW.evtRichiesta:=evtRichiesta;
  selT248.Open;
end;

procedure TA124FPermessiSindacaliDtM.DataModuleDestroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
  inherited;
end;

procedure TA124FPermessiSindacaliDtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  if DataSet.State = dsInsert then
    A124MW.ControlloProgInterno;
  inherited;
  A124MW.selT248BeforePostNoStorico(DataSet);
end;

procedure TA124FPermessiSindacaliDtM.selT248DALLEValidate(Sender: TField);
begin
  inherited;
  A124MW.validaOre(Sender);
end;

procedure TA124FPermessiSindacaliDtM.selT248OREValidate(Sender: TField);
begin
  inherited;
  A124MW.validaOre(Sender);
end;

procedure TA124FPermessiSindacaliDtM.selT248AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A124MW.selT248AfterScroll;
end;

procedure TA124FPermessiSindacaliDtM.selT248NewRecord(DataSet: TDataSet);
begin
  inherited;
  A124MW.selT248NewRecord;
end;

procedure TA124FPermessiSindacaliDtM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A124MW.selT248BeforeDelete(DataSet);
end;

procedure TA124FPermessiSindacaliDtM.evtRichiesta(Msg,Chiave:String);
begin
  if R180MessageBox(Msg,'DOMANDA') <> mrYes then
    Abort;
end;

end.
