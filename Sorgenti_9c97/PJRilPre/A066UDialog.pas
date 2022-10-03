unit A066UDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, C001StampaLib, A000UCostanti, A000USessione,A000UInterfaccia, Variants;

type
  TA066FDialog = class(TForm)
    DaLiv: TComboBox;
    Label1: TLabel;
    ALiv: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DaData: TMaskEdit;
    AData: TMaskEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A066FDialog: TA066FDialog;

implementation

uses A066UValutaStrDtM1, A066UStampa;

{$R *.DFM}

procedure TA066FDialog.FormCreate(Sender: TObject);
begin
  A066FStampa:=TA066FStampa.Create(nil);
end;

procedure TA066FDialog.FormShow(Sender: TObject);
begin
  Label1.Caption:='Da ' + Parametri.CampiRiferimento.C2_Livello;
  Label2.Caption:='A ' + Parametri.CampiRiferimento.C2_Livello;
end;

procedure TA066FDialog.BitBtn1Click(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    C001SettaQuickReport(A066FStampa.QRep);
end;

procedure TA066FDialog.BitBtn2Click(Sender: TObject);
var S:String;
begin
  try
    if StrToDate(DaData.Text) > StrToDate(AData.Text) then
      begin
      ShowMessage('Le date non sono in ordine cronologico!');
      exit;
      end;
  except
    raise Exception.Create('Le date non sono specificate correttamente!');
  end;

  //with A066FValutaStrDtM1.QFasce do
  with A066FValutaStrDtM1.A066FValutaStrMW.QFasce do
    begin
    First;
    S:='';
    while not Eof do
      begin
      S:=S + Format('%-17g',[FieldByName('Maggiorazione').AsFloat]);
      Next;
      end;
    end;
  with A066FValutaStrDtM1.QStampa do
    begin
    Close;
    SetVariable('LIVELLO1',DaLiv.Text);
    SetVariable('LIVELLO2',ALiv.Text);
    SetVariable('DATA1',StrToDate(DaData.Text));
    SetVariable('DATA2',StrToDate(AData.Text));
    Open;
    end;
  with A066FStampa do
    begin
    LEnte.Caption:=Parametri.DAzienda;
    LTitolo.Caption:=Label1.Caption + ' ' + DaLiv.Text + ' ' + Label2.Caption + ' ' + ALiv.Text;
    LTitolo2.Caption:='Dal ' + DaData.Text + ' al ' + AData.Text;
    LLivello.Caption:=Parametri.CampiRiferimento.C2_Livello;
    LFasce.Caption:=S;
    QRep.Preview;
    end;
end;

procedure TA066FDialog.FormDestroy(Sender: TObject);
begin
  A066FStampa.Release;
end;

end.
