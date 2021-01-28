unit A132UControllo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, Mask, C180FunzioniGenerali, A000UCostanti, A000USessione, A000UInterfaccia,
  A003UDataLavoroBis, Db, OracleData, DBCtrls;

type
  TA132FControllo = class(TForm)
    Label2: TLabel;
    EDaData: TMaskEdit;
    btnDal: TButton;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    edtBuoniAcq: TEdit;
    edtBuoniRes: TEdit;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    edtTicketAcq: TEdit;
    edtTicketRes: TEdit;
    btnRiepilogoComplessivo: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    edtBuoniScad: TEdit;
    edtTicketScad: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    edtTicketAss: TEdit;
    Label9: TLabel;
    edtBuoniAss: TEdit;
    Label10: TLabel;
    btnRiepilogoFornitura: TBitBtn;
    dcmbDataAcquisto: TDBLookupComboBox;
    EAdata: TMaskEdit;
    btnAl: TButton;
    Label11: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnRiepilogoComplessivoClick(Sender: TObject);
    procedure btnDalClick(Sender: TObject);
    procedure btnAlClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A132FControllo: TA132FControllo;

implementation

{$R *.dfm}

uses A132UMagazzinoBuoniPastoDtM;

procedure TA132FControllo.btnAlClick(Sender: TObject);
begin
  try
    StrToDate(EAData.Text);
  except
    EAData.Text:=DateToStr(R180FineMese(Parametri.DataLavoro));
  end;
  EAData.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(EAData.Text),'Alla data','G'));
end;

procedure TA132FControllo.btnDalClick(Sender: TObject);
begin
  try
    StrToDate(EDaData.Text);
  except
    EDaData.Text:='01/01/1900';
  end;
  EDaData.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(EAData.Text),'Dalla data','G'));
end;

procedure TA132FControllo.btnRiepilogoComplessivoClick(Sender: TObject);
begin
  with A132FMagazzinoBuoniPastoDtM.A132MW do
  begin
    BuoniAcquistati:=0;
    BuoniAssegnati:=0;
    BuoniScaduti:=0;
    TicketAcquistati:=0;
    TicketAssegnati:=0;
    TicketScaduti:=0;
    CalcolaRiepilogoComplessivo:=(Sender = btnRiepilogoComplessivo);
    try
      DataDa:=StrToDate(EDaData.Text);
      DataA:=StrToDate(EAData.Text);
      if DataDa > DataA then
        Abort;
    except
      raise Exception.Create('Periodo errato');
    end;
    DataAcquisto:=StrToDate(dcmbDataAcquisto.KeyValue);
    CalcolaRiepilogo;
    edtBuoniAcq.Text:=IntToStr(BuoniAcquistati);
    edtBuoniAss.Text:=IntToStr(BuoniAssegnati);
    edtBuoniRes.Text:=IntToStr(BuoniResidui);
    edtBuoniScad.Text:=IntToStr(BuoniScaduti);
    edtTicketAcq.Text:=IntToStr(TicketAcquistati);
    edtTicketAss.Text:=IntToStr(TicketAssegnati);
    edtTicketRes.Text:=IntToStr(TicketResidui);
    edtTicketScad.Text:=IntToStr(TicketScaduti);
  end;
end;

procedure TA132FControllo.FormCreate(Sender: TObject);
begin
  EDaData.Text:='01/01/1900';
  EAData.Text:=FormatDateTime('dd/mm/yyyy',Date);
  A132FMagazzinoBuoniPastoDtM.selT691.Last;
  dcmbDataAcquisto.KeyValue:=A132FMagazzinoBuoniPastoDtM.selT691.FieldByName('DATA_ACQUISTO').AsDateTime;
end;

end.
