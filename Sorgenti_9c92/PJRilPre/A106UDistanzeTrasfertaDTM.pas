unit A106UDistanzeTrasfertaDTM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, A000UInterfaccia,
  A106UDistanzeTrasfertaMW;

type
  TA106FDistanzeTrasfertaDTM = class(TR004FGestStoricoDtM)
    SelM041: TOracleDataSet;
    SelM041TIPO1: TStringField;
    SelM041LOCALITA1: TStringField;
    SelM041TIPO2: TStringField;
    SelM041LOCALITA2: TStringField;
    SelM041CHILOMETRI: TFloatField;
    SelM041desc_comune1: TStringField;
    SelM041desc_localita1: TStringField;
    SelM041desc_comune2: TStringField;
    SelM041desc_localita2: TStringField;
    SelM041desc_capcom1: TStringField;
    SelM041desc_capcom2: TStringField;
    SelM041desc_prov1: TStringField;
    SelM041desc_prov2: TStringField;
    SelM041B: TOracleDataSet;
    DSelM041B: TDataSource;
    SelM041BTIPO1: TStringField;
    SelM041BLOCALITA1: TStringField;
    SelM041BDESC_PARTENZA: TStringField;
    SelM041BTIPO2: TStringField;
    SelM041BLOCALITA2: TStringField;
    SelM041BDESC_DESTINAZIONE: TStringField;
    SelM041BCHILOMETRI: TFloatField;
    SelM041C_CHILOMETRI: TFloatField;
    SelM041BKM_PROPOSTI: TFloatField;
    updM041: TOracleQuery;
    SelM041BCAP1: TStringField;
    SelM041BCAP2: TStringField;
    SelM041BPROV1: TStringField;
    SelM041BPROV2: TStringField;
    procedure SelM041BAfterScroll(DataSet: TDataSet);
    procedure SelM041CalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure DataModuleDestroy(Sender: TObject);
    procedure SelM041BApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: string);
  private
    { Private declarations }
  public
    A106FDistanzeTrasfertaMW: TA106FDistanzeTrasfertaMW;
  end;

var
  A106FDistanzeTrasfertaDTM: TA106FDistanzeTrasfertaDTM;

implementation

uses A106UDistanzeTrasferta;

{$R *.dfm}

procedure TA106FDistanzeTrasfertaDTM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(SelM041,[evBeforePostNoStorico,
                               evBeforeDelete,
                               evBeforeInsert,
                               evBeforeEdit,
                               evAfterDelete,
                               evAfterPost]);
  A106FDistanzeTrasfertaMW:=TA106FDistanzeTrasfertaMW.Create(Self);
  A106FDistanzeTrasfertaMW.SelM041_Funzioni:=SelM041;
  SelM041.FieldByName('desc_comune1').LookupDataSet:=A106FDistanzeTrasfertaMW.SelT480;
  SelM041.FieldByName('desc_comune2').LookupDataSet:=A106FDistanzeTrasfertaMW.SelT480;
  SelM041.FieldByName('desc_localita1').LookupDataSet:=A106FDistanzeTrasfertaMW.SelM042;
  SelM041.FieldByName('desc_localita2').LookupDataSet:=A106FDistanzeTrasfertaMW.SelM042;
  SelM041.Open;
  SelM041B.SetVariable('ORDERBY','order by desc_partenza, desc_destinazione');
  SelM041B.Open;
end;

procedure TA106FDistanzeTrasfertaDTM.SelM041CalcFields(DataSet: TDataSet);
begin
  inherited;
  if (SelM041.FieldByName('TIPO1').AsString = 'C') and (SelM041.FieldByName('LOCALITA1').AsString <> '') then
  begin
    A106FDistanzeTrasfertaMW.SelT480.SearchRecord('CODICE',SelM041.FieldByName('LOCALITA1').AsString,[srFromBeginning]);
    SelM041.FieldByName('desc_capcom1').AsString:=A106FDistanzeTrasfertaMW.SelT480.FieldByName('CAP').AsString;
    SelM041.FieldByName('desc_prov1').AsString:=A106FDistanzeTrasfertaMW.SelT480.FieldByName('PROVINCIA').AsString;
  end
  else
  begin
    SelM041.FieldByName('desc_capcom1').AsString:='';
    SelM041.FieldByName('desc_prov1').AsString:='';
  end;
  if (SelM041.FieldByName('TIPO2').AsString = 'C') and (SelM041.FieldByName('LOCALITA2').AsString <> '') then
  begin
    A106FDistanzeTrasfertaMW.SelT480.SearchRecord('CODICE',SelM041.FieldByName('LOCALITA2').AsString,[srFromBeginning]);
    SelM041.FieldByName('desc_capcom2').AsString:=A106FDistanzeTrasfertaMW.SelT480.FieldByName('CAP').AsString;
    SelM041.FieldByName('desc_prov2').AsString:=A106FDistanzeTrasfertaMW.SelT480.FieldByName('PROVINCIA').AsString;
  end
  else
  begin
    SelM041.FieldByName('desc_capcom2').AsString:='';
    SelM041.FieldByName('desc_prov2').AsString:='';
  end;
end;

procedure TA106FDistanzeTrasfertaDTM.AfterPost(DataSet: TDataSet);
// AOSTA_REGIONE - commessa: 2013/031 VARIE#1 - riesame del 06/02/2014.ini
var
  BM: TBookmark;
// AOSTA_REGIONE - commessa: 2013/031 VARIE#1 - riesame del 06/02/2014.fine
begin
  inherited;

  // AOSTA_REGIONE - commessa: 2013/031 VARIE#1 - riesame del 06/02/2014.ini
  // imposta bookmark per riposizionamento
  BM:=SelM041B.GetBookmark;
  try
    SelM041B.Close;
    SelM041B.Open;

    // riposizionamento sul record originale
    if SelM041B.BookmarkValid(BM) then
      SelM041B.GotoBookmark(BM);
  finally
    SelM041B.FreeBookmark(BM);
  end;
  // AOSTA_REGIONE - commessa: 2013/031 VARIE#1 - riesame del 06/02/2014.fine
end;

procedure TA106FDistanzeTrasfertaDTM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  SelM041B.Close;
  SelM041B.Open;
end;

procedure TA106FDistanzeTrasfertaDTM.BeforePostNoStorico(DataSet: TDataSet);
begin
  A106FDistanzeTrasfertaMW.selM041BeforePost;
  inherited;
end;

procedure TA106FDistanzeTrasfertaDTM.SelM041BAfterScroll(DataSet: TDataSet);
begin
  inherited;
  //Mi posiziono sulla riga corrispondente della query M041
  try
    If SelM041B.RecordCount > 1 then
      SelM041.SearchRecord('TIPO1;LOCALITA1;TIPO2;LOCALITA2',VarArrayOf([SelM041BTIPO1.AsString,SelM041BLOCALITA1.AsString,SelM041BTIPO2.AsString,SelM041BLOCALITA2.AsString]),[srFromBeginning]);
  except
  end;
end;

procedure TA106FDistanzeTrasfertaDTM.SelM041BApplyRecord(Sender: TOracleDataSet;
  Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  inherited;
  if Action = 'U' then
  begin
    // se i km proposti sono calcolati
    if not Sender.FieldByName('KM_PROPOSTI').IsNull then
    begin
      // metodo a. da non utilizzare: dà EArgumentOutOfRangeException sul richiamo a ".Post"
      {
      if selM041.SearchRecord('TIPO1;LOCALITA1;TIPO2;LOCALITA2',
                              VarArrayOf([Sender.FieldByName('TIPO1').AsString,
                                          Sender.FieldByName('LOCALITA1').AsString,
                                          Sender.FieldByName('TIPO2').AsString,
                                          Sender.FieldByName('LOCALITA2').AsString]),
                              [srFromBeginning]) then
      begin
        selM041.Edit;
        selM041.FieldByName('CHILOMETRI').AsInteger:=Sender.FieldByName('KM_PROPOSTI').AsInteger;
        selM041.Post;
      end;
      }

      // metodo b. utilizzo oraclequery per effettuare update
      with updM041 do
      begin
        SetVariable('KM',Sender.FieldByName('KM_PROPOSTI').AsInteger);
        SetVariable('M041ROWID',Sender.RowId);
        Execute;
      end;
    end;

    Applied:=True;
  end;
end;

procedure TA106FDistanzeTrasfertaDTM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A106FDistanzeTrasfertaMW);
  inherited;
end;

end.
