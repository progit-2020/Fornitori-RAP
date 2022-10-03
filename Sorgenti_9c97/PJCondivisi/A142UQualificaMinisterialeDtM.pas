unit A142UQualificaMinisterialeDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R004UGESTSTORICODTM, Db, Oracle, OracleData, A000UCostanti, A000USessione,A000UInterfaccia,
  C180FUNZIONIGENERALI, (*Midaslib,*) Crtl, DBClient, Provider, Variants;

type
  TA142FQualificaMinisterialeDtM = class(TR004FGestStoricoDtM)
    selT470: TOracleDataSet;
    selT470CODICE: TStringField;
    selT470DESCRIZIONE: TStringField;
    selT470PROGRESSIVOQM: TIntegerField;
    selT470DEBITOGGQM: TStringField;
    selT470MACRO_CATEG_QM: TStringField;
    selT470DECORRENZA: TDateTimeField;
    selT470DECORRENZA_FINE: TDateTimeField;
    procedure DataModuleCreate(Sender: TObject);
    procedure AfterPost(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A142FQualificaMinisterialeDtM: TA142FQualificaMinisterialeDtM;

implementation

uses A142UQualificaMinisteriale;

{$R *.DFM}

procedure TA142FQualificaMinisterialeDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=A142FQualificaMinisteriale.InterfacciaR004;
  InizializzaDataSet(selT470,[evBeforeEdit,
                              evBeforeInsert,
                              evBeforePost,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost,
                              evOnNewRecord,
                              evOnTranslateMessage]);
  A142FQualificaMinisteriale.DButton.DataSet:=selT470;
  InterfacciaR004.AllineaSoloDecorrenzeIntersecanti:=True;
  selT470.Open;
  while not selT470.Eof do
  begin
    if  (selT470.FieldByName('MACRO_CATEG_QM').AsString <> '')
    and (A142FQualificaMinisteriale.dcmbMacroCategoria.Items.IndexOf(selT470.FieldByName('MACRO_CATEG_QM').AsString) = -1) then
      A142FQualificaMinisteriale.dcmbMacroCategoria.Items.Add(selT470.FieldByName('MACRO_CATEG_QM').AsString);
    selT470.Next;
  end;
  selT470.First;
  A142FQualificaMinisteriale.dcmbMacroCategoria.Refresh;
end;

procedure TA142FQualificaMinisterialeDtM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  if  (selT470.FieldByName('MACRO_CATEG_QM').AsString <> '')
  and (A142FQualificaMinisteriale.dcmbMacroCategoria.Items.IndexOf(selT470.FieldByName('MACRO_CATEG_QM').AsString) = -1) then
    A142FQualificaMinisteriale.dcmbMacroCategoria.Items.Add(selT470.FieldByName('MACRO_CATEG_QM').AsString);
end;

end.
