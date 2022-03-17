unit A028USC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, StdCtrls, Buttons, Mask,  ExtCtrls, C700USelezioneAnagrafe,
  A000UCostanti, A000USessione,A000UInterfaccia, SelAnagrafe, Menus, ComCtrls,
  C005UDatiAnagrafici, Variants, A028UScMW;

type
  TA028FSc = class(TForm)
    Label2: TLabel;
    EDaData: TMaskEdit;
    BitBtn1: TBitBtn;
    frmSelAnagrafe: TfrmSelAnagrafe;
    StatusBar: TStatusBar;
    chkRichiesteWeb: TCheckBox;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TfrmSelAnagrafe1btnSelezioneClick(Sender: TObject);
    procedure TfrmSelAnagrafe1R003DatianagraficiClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    AbilCont:Boolean;
  public
    { Public declarations }
    A028FScMW: TA028FScMW;
  end;

var
  A028FSc: TA028FSc;

procedure OpenA028Sc(Prog:LongInt; Data:TDateTime);

implementation

uses A028UScVisual;

{$R *.DFM}

procedure OpenA028Sc(Prog:LongInt; Data:TDateTime);
{Programma di servizio per visualizzare i conteggi}
begin
  if A000GetInibizioni('Funzione','OpenA028Sc') = 'N' then
  begin
    ShowMessage('Funzione non abilitata!');
    Exit;
  end;
  A028FSC:=TA028FSC.Create(nil);
  with A028FSC do
    try
    C700Progressivo:=Prog;
    EDaData.Text:=FormatDateTime('dd/mm/yyyy',Data);
    //EAData.Text:=EDaData.Text;
    ShowModal;
    finally
      Free;
    end;
end;

procedure TA028FSc.FormCreate(Sender: TObject);
begin
  AbilCont:=False;
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  A028FScMW:=TA028FScMW.Create(nil);
end;

procedure TA028FSc.BitBtn1Click(Sender: TObject);
var ContData,FineData:TDateTime;
begin
  (*
  if Trim(EAData.Text) = '/  /' then
    EAData.Text:=EDaData.Text;
  *)
  ContData:=StrToDate(EDaData.Text);
  //FineData:=StrToDate(EAData.Text);
  FineData:=ContData;
  A028FScVisual:=TA028FScVisual.Create(nil);
  A028FScMW.SettaConteggi(ContData,FineData,chkRichiesteWeb.Checked);
  while ContData <= FineData do
  begin
    A028FScMW.EseguiConteggi(C700Progressivo,ContData);
    A028FScVisual.PageControl1.ActivePage:=A028FScVisual.TabSheet1;
    A028FScVisual.ShowModal;
    ContData:=ContData + 1;
  end;
  A028FScVisual.Free;
end;

procedure TA028FSc.BitBtn2Click(Sender: TObject);
begin
  A028FScMW.ResettaConteggi;
end;

procedure TA028FSc.FormDestroy(Sender: TObject);
begin
  FreeAndNil(A028FScMW);
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA028FSc.FormShow(Sender: TObject);
begin
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle, StatusBar,0,True);
end;

procedure TA028FSc.TfrmSelAnagrafe1btnSelezioneClick(Sender: TObject);
begin
  try
    C700DataLavoro:=StrToDate(EDAData.Text);
  except
    C700DataLavoro:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA028FSc.TfrmSelAnagrafe1R003DatianagraficiClick(
  Sender: TObject);
begin
  try
    C005DataVisualizzazione:=StrToDate(EDAData.Text);
  except
    C005DataVisualizzazione:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

end.
