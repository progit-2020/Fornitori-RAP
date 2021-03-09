unit A002UBadgeMsg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, A003UDataLavoroBis,
  Buttons, ExtCtrls, Variants, Mask, A000UCostanti, A000USessione, A000UInterfaccia, C180FunzioniGenerali,
  Oracle, OracleData;

type
  TA002FBadgeMsg = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    btnCancel: TBitBtn;
    Memo1: TMemo;
    pnlData: TPanel;
    Label1: TLabel;
    btnData: TBitBtn;
    edtDataDec: TMaskEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnDataClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A002FBadgeMsg: TA002FBadgeMsg;

implementation

uses A002UAnagrafeDtM1;

{$R *.DFM}


procedure TA002FBadgeMsg.BitBtn1Click(Sender: TObject);
var P:String;
    DF,DA,DFP430:TDateTime;
begin
  if memo1.Visible then
  begin
    A002FBadgeMsg.Close;
    Exit;
  end;
  //Modifica data prima decorrenza
  P:=A002FAnagrafeDtM1.Q030.FieldByName('Progressivo').AsString;
  with TOracleDataSet.Create(nil) do
  try
    Session:=SessioneOracle;
    SQL.Add('SELECT MIN(DATAFINE) DATAFINE,MIN(INIZIO) INIZIO FROM T430_STORICO WHERE PROGRESSIVO = ' + P);
    Open;
    DF:=FieldByName('DATAFINE').AsDateTime;
    DA:=FieldByName('INIZIO').AsDateTime;
    Close;
  finally
    Free;
  end;
  if StrToDate(edtDataDec.Text) > DF then
  begin
    R180MessageBox('La data non può essere successiva alla decorrenza del 2° periodo storico (' + DateToStr(DF) + ')! ','ERRORE');
    edtDataDec.SetFocus;
    exit;
  end;
  if StrToDate(edtDataDec.Text) > DA then
    if R180MessageBox('La data è successiva alla prima data di assunzione (' + DateToStr(DA) + '). Continuare?','DOMANDA') <> mrYes then
    begin
      edtDataDec.SetFocus;
      exit;
    end;
  //Verifico di non essere dopo il secondo periodo storico di P430_ANAGRAFICO
  with TOracleDataSet.Create(nil) do
  try
    Session:=SessioneOracle;
    //Forzo 31/12/4999 per gestire la non esistenza di record su P430_ANAGRAFICO
    SQL.Add('SELECT NVL(MIN(DECORRENZA_FINE),TO_DATE(''31124999'',''DDMMYYYY'')) DECORRENZA_FINE FROM P430_ANAGRAFICO WHERE PROGRESSIVO = ' + P);
    Open;
    DFP430:=FieldByName('DECORRENZA_FINE').AsDateTime;
    Close;
  finally
    Free;
  end;
  if StrToDate(edtDataDec.Text) > DFP430 then
  begin
    R180MessageBox('La data non può essere successiva alla decorrenza del 2° periodo storico dell''anagrafico stipendi (' + DateToStr(DFP430) + ')! ','ERRORE');
    edtDataDec.SetFocus;
    exit;
  end;
  if R180MessageBox('La prima decorrenza verrà aggiornata al ' + edtDataDec.Text + ' .Continuare?','DOMANDA') = mrYes then
    with TOracleQuery.Create(nil) do
    try
      Session:=SessioneOracle;
      SQL.Add('UPDATE T430_STORICO SET DATADECORRENZA = :DATADECORRENZA');
      SQL.Add('WHERE PROGRESSIVO = ' + P + ' AND DATADECORRENZA = ');
      SQL.Add('(SELECT MIN(DATADECORRENZA) FROM T430_STORICO WHERE PROGRESSIVO = ' + P + ')');
      DeclareVariable('DATADECORRENZA',otDate);
      SetVariable('DATADECORRENZA',StrToDate(edtDataDec.Text));
      Execute;
      //Se esiste P430_ANAGRAFICO ne aggiorno anche la prima decorrenza
      if DFP430 <> EncodeDate(4999,12,31) then
      begin
        Sql.Clear;
        DeleteVariables;
        SQL.Add('UPDATE P430_ANAGRAFICO SET DECORRENZA = :DECORRENZA');
        SQL.Add('WHERE PROGRESSIVO = ' + P + ' AND DECORRENZA = ');
        SQL.Add('(SELECT MIN(DECORRENZA) FROM P430_ANAGRAFICO WHERE PROGRESSIVO = ' + P + ')');
        DeclareVariable('DECORRENZA',otDate);
        SetVariable('DECORRENZA',StrToDate(edtDataDec.Text));
        Execute;
      end;
      SessioneOracle.Commit;
    finally
      Free;
    end;
  //Close;
  ModalResult:=mrOk;
end;

procedure TA002FBadgeMsg.btnDataClick(Sender: TObject);
begin
  edtDataDec.Text:=DateToStr(DataOut(0,'Data prima decorrenza','G'));
end;

end.
