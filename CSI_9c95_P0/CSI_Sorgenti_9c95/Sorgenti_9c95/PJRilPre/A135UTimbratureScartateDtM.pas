unit A135UTimbratureScartateDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle;

type
  TA135FTimbratureScartateDtM = class(TR004FGestStoricoDtM)
    selT103: TOracleDataSet;
    selT103PROGRESSIVO: TFloatField;
    selT103DATA: TDateTimeField;
    selT103ORA: TDateTimeField;
    selT103VERSO: TStringField;
    selT103FLAG: TStringField;
    selT103RILEVATORE: TStringField;
    selT103CAUSALE: TStringField;
    selT100: TOracleDataSet;
    FloatField1: TFloatField;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    D100: TDataSource;
    procedure selT103BeforeInsert(DataSet: TDataSet);
    procedure DateTimeField2GetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure selT103ORAGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure selT103AfterScroll(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A135FTimbratureScartateDtM: TA135FTimbratureScartateDtM;

implementation

uses
  A135UTimbratureScartate;

{$R *.dfm}

procedure TA135FTimbratureScartateDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT103,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  A135FTimbratureScartate.DButton.DataSet:=selT103;
  selT103.Open;
//  selT100.Session:=SessioneOracle;
  selT100.Open;
end;

procedure TA135FTimbratureScartateDtM.selT103AfterScroll(DataSet: TDataSet);
begin
  inherited;
  with selT103 do
    if FieldByName('DATA').IsNull then
      A135FTimbratureScartate.gpbTimbraturePresenza.Caption:='Timbrature di Presenza'
    else
    begin
      if FieldByName('DATA').AsDateTime = selT100.GetVariable('DATAGIORNO') then
        exit
      else
        A135FTimbratureScartate.gpbTimbraturePresenza.Caption:='Timbrature di Presenza del '+DateToStr(FieldByName('DATA').AsDateTime);
    end;
  with selT100 do
  begin
    Close;
    SetVariable('PROGRESSIVO',A135FTimbratureScartate.Progressivo);
    SetVariable('DATAGIORNO',selT103.FieldByName('DATA').AsDateTime);
    Open;
  end;
end;

procedure TA135FTimbratureScartateDtM.selT103ORAGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then Text:='' else Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

procedure TA135FTimbratureScartateDtM.DateTimeField2GetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then Text:='' else Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

procedure TA135FTimbratureScartateDtM.selT103BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  abort;
end;

end.
