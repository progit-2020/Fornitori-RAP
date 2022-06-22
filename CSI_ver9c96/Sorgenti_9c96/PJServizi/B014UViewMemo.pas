unit B014UViewMemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Variants, DBCtrls, ExtCtrls, A000UInterfaccia, C180FunzioniGenerali;

type
  TB014FViewMemo = class(TForm)
    Memo1: TMemo;
    pnlAzienda: TPanel;
    Label1: TLabel;
    dcmbAzienda: TDBLookupComboBox;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  B014FViewMemo: TB014FViewMemo;

implementation

{$R *.DFM}

uses B014UMonitorIntegrazioneDtM;

procedure TB014FViewMemo.Button1Click(Sender: TObject);
var Carica:Boolean;
begin
  if dcmbAzienda.Text = '' then
    raise Exception.Create('Specificare l''Azienda!');
  with B014FMonitorIntegrazioneDtM do
  begin
    SessioneAzienda.Logoff;
    SessioneAzienda.LogonDatabase:=SessioneOracle.LogonDatabase;
    SessioneAzienda.LogonUserName:=VarToStr(selI090.Lookup('AZIENDA',dcmbAzienda.Text,'UTENTE'));
    SessioneAzienda.LogonPassword:=R180Decripta(VarToStr(selI090.Lookup('AZIENDA',dcmbAzienda.Text,'PAROLACHIAVE')),21041974);
    SessioneAzienda.Logon;
    selSourceB014Personalizzata.Close;
    selSourceB014Personalizzata.Open;
    Memo1.Lines.Clear;
    Carica:=False;
    while not selSourceB014Personalizzata.Eof do
    begin
      if (not Carica) and (Pos('B014PERSONALIZZATA',UpperCase(selSourceB014Personalizzata.FieldByName('TEXT').AsString)) > 0) then
        Carica:=True;
      if Carica then
        Memo1.Lines.Add(TrimRight(selSourceB014Personalizzata.FieldByName('TEXT').AsString));
      selSourceB014Personalizzata.Next;
    end;
    selSourceB014Personalizzata.Close;
    SessioneAzienda.Logoff;
  end;
end;

procedure TB014FViewMemo.FormCreate(Sender: TObject);
begin
  pnlAzienda.Visible:=False;
end;

procedure TB014FViewMemo.FormShow(Sender: TObject);
begin
  if dcmbAzienda.ListSource.DataSet.RecordCOunt = 1 then
  begin
    dcmbAzienda.KeyValue:=dcmbAzienda.ListSource.DataSet.FieldByName('AZIENDA').Value;
    Button1Click(nil);
  end;
end;

end.
