unit A121UOrganizzSindacaliDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStoricoDtM, Oracle, DB, OracleData, C180FunzioniGenerali,
  A000UInterfaccia, A121URecapitiSindacaliMW;

type
  TA121FOrganizzSindacaliDtM = class(TR004FGestStoricoDtM)
    selT240: TOracleDataSet;
    selT240CODICE: TStringField;
    selT240DECORRENZA: TDateTimeField;
    selT240DESCRIZIONE: TStringField;
    selT240COD_MINISTERIALE: TStringField;
    selT240FILTRO: TStringField;
    selT240RAGGRUPPAMENTO: TStringField;
    selT240SINDACATI_RAGGRUPPATI: TStringField;
    selT240RSU: TStringField;
    selT240VOCEPAGHE: TStringField;
    selT240CAUSALE_COMPETENZE: TStringField;
    selT240CAUSALE_COMPETENZE_NO: TStringField;
    selT240COD_REGIONALE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT240AfterScroll(DataSet: TDataSet);
    procedure selT240RSUValidate(Sender: TField);
    procedure selT240CODICEValidate(Sender: TField);
    procedure selT240RAGGRUPPAMENTOValidate(Sender: TField);
    procedure BeforePost(DataSet: TDataSet); override;
  private
    procedure AggiornaVariabiliMW;
  public
    A121MW: TA121FRecapitiSindacaliMW;
  end;

var
  A121FOrganizzSindacaliDtM: TA121FOrganizzSindacaliDtM;

implementation

uses A121UOrganizzSindacali, A121URecapitiSindacati;

{$R *.dfm}

procedure TA121FOrganizzSindacaliDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=A121FOrganizzSindacali.InterfacciaR004;
  InizializzaDataSet(selT240,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePost,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnNewRecord,
                           evOnTranslateMessage]);

  A121MW:=TA121FRecapitiSindacaliMW.Create(Self);
  A121MW.selT240:=selT240;
  A121MW.AggiornaVariabiliMW:=AggiornaVariabiliMW;
  A121FOrganizzSindacali.DButton.DataSet:=selT240;
  selT240.Open;
end;

procedure TA121FOrganizzSindacaliDtM.BeforePost(DataSet: TDataSet);
begin
  A121MW.BeforePost;
  inherited;
end;

procedure TA121FOrganizzSindacaliDtM.selT240AfterScroll(DataSet: TDataSet);
begin
  inherited;
  with A121FOrganizzSindacali do
  begin
    if selT240.FieldByName('RAGGRUPPAMENTO').AsString = 'S' then
      edtSindacati.Text:=''
    else
      with A121MW.selRaggruppatoIn do
      begin
        Close;
        SetVariable('CODICE',selT240.FieldByName('CODICE').AsString);
        SetVariable('DECORRENZA',selT240.FieldByName('DECORRENZA').AsDateTime);
        Open;
        First;
        edtSindacati.Text:='';
        while not Eof do
        begin
          if Pos(FieldByName('CODICE').AsString,edtSindacati.Text) <= 0 then
          begin
            if edtSindacati.Text <> '' then
              edtSindacati.Text:=edtSindacati.Text + ',';
            edtSindacati.Text:=edtSindacati.Text + FieldByName('CODICE').AsString;
          end;
          Next;
        end;
      end;
    chkRaggruppamentoClick(nil);
  end;
  A121MW.AfterScroll;
end;

procedure TA121FOrganizzSindacaliDtM.selT240RSUValidate(Sender: TField);
begin
  inherited;
  A121MW.FieldRSUValidate;
end;

procedure TA121FOrganizzSindacaliDtM.selT240CODICEValidate(Sender: TField);
begin
  inherited;
  A121MW.FieldCODICEValidate;
end;

procedure TA121FOrganizzSindacaliDtM.selT240RAGGRUPPAMENTOValidate(Sender: TField);
begin
  inherited;
  A121MW.FieldRAGGRUPPAMENTOValidate;
end;

procedure TA121FOrganizzSindacaliDtM.AggiornaVariabiliMW;
begin
  A121MW.RqStoriciPrec:=A121FOrganizzSindacali.chkStoriciPrec.Checked;
  A121MW.RqStoriciSucc:=A121FOrganizzSindacali.chkStoriciSucc.Checked;
end;

end.
