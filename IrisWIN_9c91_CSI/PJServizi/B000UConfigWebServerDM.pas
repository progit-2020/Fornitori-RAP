unit B000UConfigWebServerDM;

interface

uses
  SysUtils, Classes, DB, OracleData, Oracle, C180FunzioniGenerali, Forms, Controls;

type
  TB000FConfigWebServerDM = class(TDataModule)
    DbMessaggi: TOracleSession;
    selMsgHead: TOracleDataSet;
    selMsgDett: TOracleDataSet;
    dsrMsgHead: TDataSource;
    dsrMsgDett: TDataSource;
    selMsgHeadDATA: TDateTimeField;
    selMsgHeadDATA_INI: TDateTimeField;
    selMsgHeadDATA_FINE: TDateTimeField;
    selMsgHeadMAX_SESSIONI: TStringField;
    selMsgHeadID: TFloatField;
    selMsgHeadCOUNTMSG: TFloatField;
    selMsgDettDATA_MSG: TDateTimeField;
    selMsgDettMSG: TStringField;
    selMsgDettC_TIPO_MSG: TStringField;
    selMsgDettC_NUMSESS: TStringField;
    selMsgDettC_IDSESS: TStringField;
    selMsgDettC_DETT: TStringField;
    selMsgDettC_FORM: TStringField;
    selMsgHeadHOSTNAME: TStringField;
    selMsgHeadHOSTIPADDRESS: TStringField;
    selMsgDettC_BROWSER: TStringField;
    selMsgDettC_IPCLIENT: TStringField;
    selMsgHeadMASCHERA: TStringField;
    procedure selMsgHeadAfterScroll(DataSet: TDataSet);
    procedure selMsgDettCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  B000FConfigWebServerDM: TB000FConfigWebServerDM;

implementation

uses B000UConfigWebServer;

{$R *.dfm}

procedure TB000FConfigWebServerDM.selMsgDettCalcFields(DataSet: TDataSet);
var
  Msg: String;
begin
  Msg:=selMsgDett.FieldByName('MSG').AsString;
  selMsgDett.FieldByName('C_TIPO_MSG').AsString:=Copy(Msg,2,2);
  selMsgDett.FieldByName('C_NUMSESS').AsString:=Copy(Msg,6,5);
  if Pos(';',Msg) = 0 then
  begin
    selMsgDett.FieldByName('C_IDSESS').AsString:='';
    selMsgDett.FieldByName('C_IPCLIENT').AsString:='';
    selMsgDett.FieldByName('C_BROWSER').AsString:='';
    selMsgDett.FieldByName('C_FORM').AsString:='';
    selMsgDett.FieldByName('C_DETT').AsString:=Copy(Msg,31,600);
  end
  else
  begin
    selMsgDett.FieldByName('C_IDSESS').AsString:=Copy(Msg,32,28);
    selMsgDett.FieldByName('C_IPCLIENT').AsString:=Copy(Msg,61,39);
    selMsgDett.FieldByName('C_BROWSER').AsString:=Copy(Msg,101,4);
    selMsgDett.FieldByName('C_FORM').AsString:=StringReplace(Copy(Msg,106,5),';','',[rfReplaceAll]);
    selMsgDett.FieldByName('C_DETT').AsString:=Copy(Msg,112,500);
  end;
end;

procedure TB000FConfigWebServerDM.selMsgHeadAfterScroll(DataSet: TDataSet);
var
  Tmp: String;
begin
  selMsgDett.Close;
  if selMsgHead.RecordCount > 0 then
  begin
    B000FConfigWebServer.grpDett.Caption:=Format('Messaggio <%s> - %d record',[selMsgHead.FieldByName('ID').AsString,selMsgHead.FieldByName('COUNTMSG').AsInteger]);
    Tmp:=B000FConfigWebServer.StatusBar1.SimpleText;
    B000FConfigWebServer.StatusBar1.SimpleText:='Lettura messaggi in corso...';
    B000FConfigWebServer.StatusBar1.Repaint;

    selMsgDett.SetVariable('ID',selMsgHead.FieldByName('ID').AsInteger);
    Screen.Cursor:=crHourGlass;
    try
      selMsgDett.Open;
      selMsgDett.Filtered:=False;
      selMsgDett.Filter:=B000FConfigWebServer.FiltroMsg;
      selMsgDett.Filtered:=(B000FConfigWebServer.FiltroMsg <> '');
    finally
      B000FConfigWebServer.StatusBar1.SimpleText:=Tmp;
      B000FConfigWebServer.StatusBar1.Repaint;
      Screen.Cursor:=crDefault;
    end;
  end;
  B000FConfigWebServer.grpDett.Visible:=(selMsgHead.RecordCount > 0);
end;

end.
