unit A121URecapitiSindacatiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, A121URecapitiSindacaliMW;

type
  TA121FRecapitiSindacatiDtM = class(TR004FGestStoricoDtM)
    selT241: TOracleDataSet;
    selT241CODICE: TStringField;
    selT241DECORRENZA: TDateTimeField;
    selT241TIPO_RECAPITO: TStringField;
    selT241PROG_RECAPITO: TIntegerField;
    selT241DESCRIZIONE: TStringField;
    selT241INDIRIZZO: TStringField;
    selT241Citta: TStringField;
    selT241Provincia: TStringField;
    selT241COMUNE: TStringField;
    selT241CAP: TStringField;
    selT241TELEFONO: TStringField;
    selT241FAX: TStringField;
    selT241COGNOME: TStringField;
    selT241NOME: TStringField;
    selT241TELEFONO_CASA: TStringField;
    selT241TELEFONO_UFFICIO: TStringField;
    selT241CELLULARE: TStringField;
    selT241EMAIL: TStringField;
    procedure selT241AfterScroll(DataSet: TDataSet); 
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure selT241COMUNEChange(Sender: TField);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    A121MW: TA121FRecapitiSindacaliMW;
  end;

var
  A121FRecapitiSindacatiDtM: TA121FRecapitiSindacatiDtM;

implementation

uses A121URecapitiSindacati;

{$R *.dfm}

procedure TA121FRecapitiSindacatiDtM.selT241AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A121FRecapitiSindacati.edtProgressivo.Value:=selT241.FieldByName('PROG_RECAPITO').AsInteger;
end;

procedure TA121FRecapitiSindacatiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=A121FRecapitiSindacati.InterfacciaR004;
  InizializzaDataSet(selT241,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePost,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnNewRecord,
                           evOnTranslateMessage]);
  A121MW:=TA121FRecapitiSindacaliMW.Create(nil);
  A121FRecapitiSindacati.DButton.DataSet:=selT241;
  selT241.SetVariable('CODICE',A121FRecapitiSindacati.Sindacato);
  selT241.FieldByName('CITTA').LookupDataSet:=A121MW.selT480;
  selT241.FieldByName('PROVINCIA').LookupDataSet:=A121MW.selT480;
  selT241.Open;
end;

procedure TA121FRecapitiSindacatiDtM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A121MW);
end;

procedure TA121FRecapitiSindacatiDtM.BeforePost(DataSet: TDataSet);
begin
  inherited;
  selT241.FieldByName('PROG_RECAPITO').AsInteger:=A121FRecapitiSindacati.edtProgressivo.Value;
  A121MW.SelT241BeforePost;
end;

procedure TA121FRecapitiSindacatiDtM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  selT241.FieldByName('CODICE').AsString:=A121FRecapitiSindacati.Sindacato;
  A121FRecapitiSindacati.edtProgressivo.Value:=0;
end;

procedure TA121FRecapitiSindacatiDtM.selT241COMUNEChange(Sender: TField);
begin
  inherited;
  try
    selT241.FieldByName('CAP').AsString:=VarToStr(A121MW.selT480.Lookup('CODICE',selT241.FieldByName('COMUNE').AsString,'CAP'));
  except
  end;
end;

end.
