unit A073UControllo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, C180FunzioniGenerali, A000UCostanti, A000USessione,A000UInterfaccia,
  QueryStorico, Variants, Oracledata, SelAnagrafe, R350UCalcoloBuoniDtM,
  C001StampaLib, C700USelezioneAnagrafe,  A003UDataLavoroBis;

type
  TA073FControllo = class(TForm)
    Label1: TLabel;
    EDaData: TMaskEdit;
    Label2: TLabel;
    EAData: TMaskEdit;
    BitBtn1: TBitBtn;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    Edit2: TEdit;
    Label5: TLabel;
    Edit3: TEdit;
    Label6: TLabel;
    Edit4: TEdit;
    Panel2: TPanel;
    lblDipendente: TLabel;
    BitBtn2: TBitBtn;
    LAnom: TLabel;
    btnAnteprima: TBitBtn;
    btnDal: TButton;
    btnAl: TButton;
    btnStampante: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    procedure btnStampanteClick(Sender: TObject);
    procedure btnAlClick(Sender: TObject);
    procedure btnDalClick(Sender: TObject);
    procedure btnAnteprimaClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    {Private declaration}
  public
    Prog:LongInt;

  end;

var
  A073FControllo: TA073FControllo;

implementation

uses A073UAcquistoBuoniDtM1,A073UStampaAcquisti;

{$R *.DFM}

procedure TA073FControllo.FormCreate(Sender: TObject);
begin
  A073FAcquistoBuoniDtM1.A073MW.R350FCalcoloBuoniDtM.selAnagrafe:=C700SelAnagrafe;
  A073FStampaAcquisti:=TA073FStampaAcquisti.Create(nil);
end;

procedure TA073FControllo.BitBtn1Click(Sender: TObject);
begin
  with A073FAcquistoBuoniDtM1.A073MW do
  begin
    try
      Inizio:=StrToDate(EDaData.Text);
      Fine:=StrToDate(EAData.Text);
    except
      raise Exception.Create('Il periodo indicato non è valido!');
    end;
    if Inizio > Fine then
      raise Exception.Create('Le date non sono in ordine cronologico!');
    Progressivo:=Prog;
    Screen.Cursor:=crHourGlass;
    try
     CalcolaRiepilogo;
     Edit1.Text:=BuoniPastoAcquistati;
     Edit2.Text:=TicketAcquistati;
     Edit3.Text:=BuoniPastoMaturati;
     Edit4.Text:=TicketMaturati;
     LAnom.Visible:=Anomalie;
    finally
      Screen.Cursor:=crDefault;
    end;
  end;
end;

procedure TA073FControllo.btnAnteprimaClick(Sender: TObject);
begin
  A073FAcquistoBuoniDtM1.A073MW.SelAnagrafe:=C700SelAnagrafe;
  with A073FAcquistoBuoniDtM1.A073MW do
  begin
    DataA:=StrToDate(EAData.Text);
    CreaBuoniPastoCDS;
    A073FStampaAcquisti.SettaDataset;
    A073FStampaAcquisti.LEnte.Caption:=Parametri.RagioneSociale;
    A073FStampaAcquisti.LTitolo.Caption:='Riepilogo buoni residui alla data ' + EAData.Text;
    A073FStampaAcquisti.QRep.Preview;
  end;
end;

procedure TA073FControllo.FormDestroy(Sender: TObject);
begin
  FreeAndNil(A073FStampaAcquisti);
end;


procedure TA073FControllo.btnDalClick(Sender: TObject);
begin
  try
    StrToDate(EDaData.Text);
  except
    EDaData.Text:=DateToStr(R180InizioMese(Parametri.DataLavoro));
  end;
  EDaData.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(EDaData.Text),'Dalla data','G'));
end;

procedure TA073FControllo.btnAlClick(Sender: TObject);
begin
  try
    StrToDate(EAData.Text);
  except
    EAData.Text:=DateToStr(R180FineMese(Parametri.DataLavoro));
  end;
  EAData.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(EAData.Text),'Alla data','G'));
end;

procedure TA073FControllo.btnStampanteClick(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    C001SettaQuickReport(A073FStampaAcquisti.QRep);
end;

end.
