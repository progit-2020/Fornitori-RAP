unit A160URegoleIncentiviDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, Math, C180FunzioniGenerali,
  A000UCostanti, A000USessione, A000UInterfaccia, ControlloVociPaghe, A160URegoleIncentiviMW;

type
  TA160FRegoleIncentiviDtM = class(TR004FGestStoricoDtM)
    selT760: TOracleDataSet;
    selT760ELENCOLIV: TStringField;
    selT760TIPO: TStringField;
    selT760ABBATTIMENTO_MAX: TFloatField;
    selT760PROPORZIONE_INCENTIVI: TStringField;
    selT760DECORRENZA: TDateTimeField;
    selT760LIVELLO: TStringField;
    selT760D_LIVELLO: TStringField;
    selT760PROPORZIONE_PARTTIME: TStringField;
    selT760TIPO_QUOTEQUANT: TStringField;
    selT760FILE_ISTRUZIONI: TStringField;
    selT760SCAGLIONI_GGEFF: TStringField;
    procedure selT760ABBATTIMENTO_MAXSetText(Sender: TField;
      const Text: string);
    procedure selT760ABBATTIMENTO_MAXValidate(Sender: TField);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT760CalcFields(DataSet: TDataSet);
  private
    selControlloVociPaghe:TControlloVociPaghe;
  public
    A160FRegoleIncentiviMW: TA160FRegoleIncentiviMW;
  end;

var
  A160FRegoleIncentiviDtM: TA160FRegoleIncentiviDtM;

implementation

uses A160URegoleIncentivi;

{$R *.dfm}

procedure TA160FRegoleIncentiviDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=A160FRegoleIncentivi.InterfacciaR004;
  InizializzaDataSet(selT760,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePost,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnNewRecord,
                           evOnTranslateMessage]);

  A160FRegoleIncentiviMW:=TA160FRegoleIncentiviMW.Create(Self);
  A160FRegoleIncentiviMW.selT760:=selT760;
end;

procedure TA160FRegoleIncentiviDtM.BeforePost(DataSet: TDataSet);
var VoceOld:String;
    Msg:String;
begin
  Msg:=A160FRegoleIncentiviMW.BeforePost;
  if Msg <> '' then
    R180MessageBox(Msg,'INFORMA');
  if selT760.FieldByName('TIPO').AsString = 'D' then
  try
    VoceOld:='';
    Msg:=A160FRegoleIncentiviMW.VerificaVociPaghe(VoceOld,'A#I');
    if Msg <> '' then
    begin
      if R180MessageBox(Msg,'DOMANDA') = mrNo then
        Abort
      else
        A160FRegoleIncentiviMW.ValutaInserimentoVocePaghe('A#I');
    end;
  except
  end;
  inherited;
end;

procedure TA160FRegoleIncentiviDtM.selT760ABBATTIMENTO_MAXValidate(Sender: TField);
begin
  inherited;
  A160FRegoleIncentiviMW.selT760ABBATTIMENTO_MAXValidate(Sender);
end;

procedure TA160FRegoleIncentiviDtM.selT760ABBATTIMENTO_MAXSetText(
  Sender: TField; const Text: string);
begin
  inherited;
  A160FRegoleIncentiviMW.selT760ABBATTIMENTO_MAXSetText(Sender, Text);
end;

procedure TA160FRegoleIncentiviDtM.selT760CalcFields(DataSet: TDataSet);
begin
  inherited;
  A160FRegoleIncentiviMW.selT760CalcFields;
  A160FRegoleIncentivi.lblInterfaccia.Caption:=selT760.FieldByName('D_LIVELLO').AsString;
end;

end.
