unit P652UINPDAPMMRegoleDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Oracle, Db, OracleData,  A000UCostanti, A000USessione, A000UInterfaccia, R004UGestStoricoDtM, Variants,
  P652UINPDAPMMRegoleMW;

type
  TP652FINPDAPMMRegoleDtM = class(TR004FGestStoricoDtM)
    P660: TOracleDataSet;
    Q050: TOracleDataSet;
    Q050COD_ARROTONDAMENTO: TStringField;
    D050: TDataSource;
    P660DECORRENZA: TDateTimeField;
    P660PARTE: TStringField;
    P660NUMERO: TStringField;
    P660DESCRIZIONE: TStringField;
    P660TIPO_RECORD: TStringField;
    P660SEZIONE_FILE: TStringField;
    P660NUMERO_FILE: TStringField;
    P660FORMATO_FILE: TStringField;
    P660LUNGHEZZA_FILE: TFloatField;
    P660FORMATO_ANNOMESE: TStringField;
    P660NUMERICO: TStringField;
    P660COD_ARROTONDAMENTO: TStringField;
    P660FORMATO: TStringField;
    P660OMETTI_VUOTO: TStringField;
    P660TIPO_DATO: TStringField;
    P660REGOLA_CALCOLO_AUTOMATICA: TStringField;
    P660REGOLA_CALCOLO_MANUALE: TStringField;
    P660REGOLA_MODIFICABILE: TStringField;
    P660COMMENTO: TStringField;
    P660FL_NUMERO_TREDICESIMA: TStringField;
    P660FL_NUMERO_ARRCORR: TStringField;
    P660FL_NUMERO_ARRPREC: TStringField;
    P660desc_FL_NUMERO_ARRCORR: TStringField;
    P660desc_FL_NUMERO_ARRPREC: TStringField;
    P660NOME_FLUSSO: TStringField;
    P660NOME_DATO: TStringField;
    P660CODICI_CAUSALI: TStringField;
    Q050VALORE: TFloatField;
    D660B: TDataSource;
    P660FL_NUMERO_TREDPREC: TStringField;
    P660descFL_NUMERO_TREDPREC: TStringField;
    P660desc_FL_NUMERO_TREDICESIMA: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure P660AfterScroll(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    P652FINPDAPMMRegoleMW: TP652FINPDAPMMRegoleMW;
  end;

var
  P652FINPDAPMMRegoleDtM: TP652FINPDAPMMRegoleDtM;

implementation

uses P652UINPDAPMMRegole;

{$R *.DFM}

procedure TP652FINPDAPMMRegoleDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=P652FINPDAPMMRegole.InterfacciaR004;
  InizializzaDataSet(P660,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePost,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnNewRecord,
                           evOnTranslateMessage]);
  P652FINPDAPMMRegoleMW:=TP652FINPDAPMMRegoleMW.Create(Self);
  P652FINPDAPMMRegoleMW.selP660_Funzioni:=P660;
  P660.FieldByName('descFL_NUMERO_TREDICESIMA').LookupDataSet:=P652FINPDAPMMRegoleMW.P660B;
  P660.FieldByName('descFL_NUMERO_TREDPREC').LookupDataSet:=P652FINPDAPMMRegoleMW.P660B;
  P660.FieldByName('desc_FL_NUMERO_ARRCORR').LookupDataSet:=P652FINPDAPMMRegoleMW.P660B;
  P660.FieldByName('desc_FL_NUMERO_ARRPREC').LookupDataSet:=P652FINPDAPMMRegoleMW.P660B;
  D660B.DataSet:=P652FINPDAPMMRegoleMW.P660B;

  P652FINPDAPMMRegole.DButton.DataSet:=P660;
  P652FINPDAPMMRegoleMW.ImpostaP660B(Parametri.DataLavoro,P652FINPDAPMMRegole.sPb_NomeFlusso,'');
  P660.SetVariable('NOMEFLUSSO',P652FINPDAPMMRegole.sPb_NomeFlusso);
  P660.Open;
  Q050.SetVariable('DECORRENZA',Parametri.DataLavoro);
  Q050.Open;
end;

procedure TP652FINPDAPMMRegoleDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(P652FINPDAPMMRegoleMW);
  inherited;
end;

procedure TP652FINPDAPMMRegoleDtM.P660AfterScroll(DataSet: TDataSet);
begin
  inherited;
  P652FINPDAPMMRegoleMW.ImpostaP660B(P660.FieldByName('DECORRENZA').AsDateTime,P652FINPDAPMMRegole.sPb_NomeFlusso,P660.FieldByName('PARTE').AsString);
end;

end.
