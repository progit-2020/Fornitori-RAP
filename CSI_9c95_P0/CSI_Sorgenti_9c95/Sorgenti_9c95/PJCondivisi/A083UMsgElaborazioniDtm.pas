unit A083UMsgElaborazioniDtm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, A000UInterfaccia, A083UMsgElaborazioni,
  Oracle, L021Call;

type
  TA083FMsgElaborazioniDtm = class(TR004FGestStoricoDtM)
    selI005Aziende: TOracleDataSet;
    selI005Valori: TOracleDataSet;
    selOutPut: TOracleDataSet;
    selOutAnagrafe: TOracleDataSet;
    selOutPutMASCHERA: TStringField;
    selOutPutOPERATORE: TStringField;
    selOutPutAZIENDA: TStringField;
    selOutPutTIPO: TStringField;
    selOutPutMSG: TStringField;
    selOutAnagrafeMASCHERA: TStringField;
    selOutAnagrafeOPERATORE: TStringField;
    selOutAnagrafeAZIENDA_MSG: TStringField;
    selOutAnagrafeTIPO: TStringField;
    selOutAnagrafeMSG: TStringField;
    selOutAnagrafeNOMINATIVO: TStringField;
    selOutAnagrafeMATRICOLA: TStringField;
    selOutPutDATA_MSG: TDateTimeField;
    selOutAnagrafeDATA_MSG: TDateTimeField;
    selOutPutMATRICOLA: TStringField;
    selOutPutNOMINATIVO: TStringField;
    GetDataDaID: TOracleQuery;
    selOutPutID: TFloatField;
    selOutAnagrafeID: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selOutPutFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selOutPutAfterFetchRecord(Sender: TOracleDataSet; FilterAccept: Boolean; var Action: TAfterFetchRecordAction);
  private
    { Private declarations }
    procedure OpenselI005Aziende;
  public
    { Public declarations }
    function GetAziende:String;
    procedure OpenselI005Valori(Campo:String);    
  end;

var
  A083FMsgElaborazioniDtm: TA083FMsgElaborazioniDtm;

implementation

{$R *.dfm}

function TA083FMsgElaborazioniDtm.GetAziende:String;
var i:Integer;
    SelectAll:Boolean;
begin
  Result:='';
  with A083FMsgElaborazioni do
  begin
    SelectAll:=False;
    for i:=0 to ListChkAziende.Items.Count - 1 do
      if ListChkAziende.Checked[i] then
        Break;
    if (i = ListChkAziende.Items.Count) and  Not ListChkAziende.Checked[i-1] then
      SelectAll:=True;

    for i:=0 to ListChkAziende.Items.Count - 1 do
    begin
      if ListChkAziende.Checked[i] or SelectAll then
      begin
        if Result <> '' then
          Result:=Result + ', ';
        Result:=Result + '''' + ListChkAziende.Items[i] + '''';
      end;
    end;

    if (Result = '') or (chkSelAnagrafe.Checked) then
      Result:='''' + Parametri.Azienda + '''';
  end;
end;

procedure TA083FMsgElaborazioniDtm.DataModuleCreate(Sender: TObject);
begin
  inherited;
  OpenselI005Aziende;
end;

procedure TA083FMsgElaborazioniDtm.OpenselI005Valori(Campo:String);
begin
  selI005Valori.Close;
  selI005Valori.SetVariable('SELECT',Campo);
  selI005Valori.SetVariable('AZIENDA',GetAziende);
  selI005Valori.Open;
end;

procedure TA083FMsgElaborazioniDtm.selOutPutAfterFetchRecord(Sender: TOracleDataSet; FilterAccept: Boolean; var Action: TAfterFetchRecordAction);
begin
  inherited;
  A083FMsgElaborazioni.RefreshNumRecords;
end;

procedure TA083FMsgElaborazioniDtm.selOutPutFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var i:Integer;
begin
  inherited;
  if DataSet.FieldByName('OPERATORE').AsString = 'SERVIZI_MONDOEDP' then
    Accept:=True
  else if DataSet.FieldByName('MASCHERA').AsString = 'B006' then
    Accept:=True
  else if DataSet.FieldByName('MASCHERA').AsString = 'B013' then
    Accept:=True
  else if DataSet.FieldByName('MASCHERA').AsString = 'B014' then
    Accept:=True
  else if DataSet.FieldByName('MASCHERA').AsString = 'B015' then
    Accept:=True
  else if DataSet.FieldByName('MASCHERA').AsString = 'B019' then
    Accept:=True
  else if DataSet.FieldByName('MASCHERA').AsString = 'B021' then
    Accept:=True
  else if DataSet.FieldByName('MASCHERA').AsString = 'B027' then
    Accept:=True
  else if DataSet.FieldByName('MASCHERA').AsString = 'P007' then
    Accept:=True
  else if DataSet.FieldByName('MASCHERA').AsString = 'W000' then
    Accept:=True
  else if DataSet.FieldByName('MASCHERA').AsString = 'A077COM' then
    Accept:=True
  else if DataSet.FieldByName('MASCHERA').AsString = 'P077COM' then
    Accept:=True
  else if DataSet.FieldByName('MASCHERA').AsString = 'A004WEBSRV' then
    Accept:=True
  else if DataSet.FieldByName('MASCHERA').AsString = 'A025WEBSRV' then
    Accept:=True
  else if DataSet.FieldByName('MASCHERA').AsString = 'A040WEBSRV' then
    Accept:=True
  else
  begin
    {Verifica che i log facciano riferimento a maschere presenti su L021Call del progetto}
    i:=low(FunzioniDisponibili);
    while i <= High(FunzioniDisponibili) do
    begin
      if L021VerificaMaschera(DataSet.FieldByName('MASCHERA').AsString,i) and
         L021VerificaApplicazione(Parametri.Applicazione,i) then
        Break;
      inc(i);
    end;
    Accept:=L021VerificaMaschera(DataSet.FieldByName('MASCHERA').AsString,i) and L021VerificaApplicazione(Parametri.Applicazione,i);
  end;
end;

procedure TA083FMsgElaborazioniDtm.OpenselI005Aziende;
begin
  selI005Aziende.Close;
  if Parametri.Azienda <> 'AZIN' then
    selI005Aziende.SetVariable('FILTRO','WHERE I090.AZIENDA = ''' + Parametri.Azienda + '''');
  selI005Aziende.Open;
end;

end.
