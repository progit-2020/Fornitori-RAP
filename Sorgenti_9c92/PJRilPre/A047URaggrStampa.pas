unit A047URaggrStampa;

interface

uses
  StrUtils, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, ExtCtrls, DB, OracleData, UselI010, Math,
  A000UInterfaccia, A047UTimbMensaMW;

type
  TA047FRaggrStampa = class(TForm)
    pnl: TPanel;
    edtListaCampi: TEdit;
    lstBoxRaggr: TListBox;
    btnConferma: TBitBtn;
    btnAnnulla: TBitBtn;
    procedure lstBoxRaggrDblClick(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure edtListaCampiDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
  private
    { Private declarations }
    TempselI010:TselI010;
    Err_Canc:Boolean;
  public
    { Public declarations }
  end;

var
  A047FRaggrStampa: TA047FRaggrStampa;

  procedure OpenA047RaggrStampa(var InOutStr:String);

implementation

{$R *.dfm}

uses A047UDialogStampa;

procedure OpenA047RaggrStampa(var InOutStr:String);
begin
  A047FRaggrStampa:=TA047FRaggrStampa.Create(nil);
  try
    with A047FRaggrStampa do
    begin
      edtListaCampi.Text:=InOutStr;
      ShowModal;
      if Not Err_Canc then
        InOutStr:=edtListaCampi.Text;
    end;
  finally
    FreeAndNil(A047FRaggrStampa);
  end;
end;

procedure TA047FRaggrStampa.FormCreate(Sender: TObject);
begin
  Err_Canc:=False;
  TempSelI010:=TselI010.Create(Self);
  TempSelI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
end;

procedure TA047FRaggrStampa.FormShow(Sender: TObject);
begin
  TempselI010.First;
  while Not TempselI010.Eof do
  begin
    lstBoxRaggr.Items.Add(TempselI010.FieldByName('NOME_LOGICO').AsString);
    TempselI010.Next;
  end;
end;

procedure TA047FRaggrStampa.btnConfermaClick(Sender: TObject);
var
  Temp:T047ArrListaRaggr;
  S:String;
begin
  S:=Trim(edtListaCampi.Text);
  if (copy(Trim(S),1,1) = ',') or (copy(Trim(S),Length(S),1) = ',') then
  begin
    Err_Canc:=True;
    raise Exception.Create('Elenco campi raggruppamento non valido!');
  end;
  S:=A047FDialogStampa.GetRaggrCampi(edtListaCampi.Text,Temp);
  if S <> '' then
  begin
    Err_Canc:=True;
    raise Exception.Create(S + ':campo inesistente!');
  end;
  SetLength(Temp,0);
  Self.Close;
end;

procedure TA047FRaggrStampa.btnAnnullaClick(Sender: TObject);
begin
  Err_Canc:=True;
  Self.Close;
end;

procedure TA047FRaggrStampa.edtListaCampiDblClick(Sender: TObject);
var
  Temp:String;
  SStart, SEnd:Integer;
begin
  Temp:=edtListaCampi.Text;
  SStart:=edtListaCampi.SelStart;
  while (SStart > 0) and (copy(Temp,SStart,1) <> ',') do
    dec(SStart);
  SEnd:=edtListaCampi.SelStart;
  while (SEnd <= Length(Temp)) and (copy(Temp,SEnd,1) <> ',') do
    inc(SEnd);
  Delete(Temp,IfThen(SStart = 0,1,SStart),SEnd - SStart);
  edtListaCampi.Text:=Trim(Temp);
end;

procedure TA047FRaggrStampa.lstBoxRaggrDblClick(Sender: TObject);
begin
  if edtListaCampi.Text <> '' then
    edtListaCampi.Text:=edtListaCampi.Text + ', ';
  edtListaCampi.Text:=edtListaCampi.Text + lstBoxRaggr.Items[lstBoxRaggr.ItemIndex];
end;

procedure TA047FRaggrStampa.FormDestroy(Sender: TObject);
begin
  FreeAndNil(TempselI010);
end;

end.
