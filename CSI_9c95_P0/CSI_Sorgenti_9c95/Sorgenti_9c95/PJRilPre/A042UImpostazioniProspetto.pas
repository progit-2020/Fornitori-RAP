unit A042UImpostazioniProspetto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask, Variants;

type
  TA042FImpostazioniProspetto = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    RbtIntervallo1: TRadioButton;
    RbtGiornata1: TRadioButton;
    RbtIntervallo2: TRadioButton;
    RbtGiornata2: TRadioButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    MskLimite2: TMaskEdit;
    MskLimite1: TMaskEdit;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A042FImpostazioniProspetto: TA042FImpostazioniProspetto;
procedure OpenA042ImpostazioniProspetto;

implementation

uses A042UDialogStampa, A042UStampaPreAssDtM1;

{$R *.DFM}

procedure OpenA042ImpostazioniProspetto;
begin
  try
    Application.CreateForm(TA042FImpostazioniProspetto,A042FImpostazioniProspetto);
    A042FImpostazioniProspetto.ShowModal;
  finally
    A042FImpostazioniProspetto.Free;
  end;
end;

procedure TA042FImpostazioniProspetto.FormCreate(Sender: TObject);
begin
  with A042FDialogStampa do
  begin

    MskLimite1.Text:=FormatDateTime('hh.nn',A042FStampaPreAssDtM1.A042MW.tPb_Limite1);
    RbtIntervallo1.Checked:=A042FStampaPreAssDtM1.A042MW.bPb_Intervallo1;
    RbtGiornata1.Checked:=A042FStampaPreAssDtM1.A042MW.bPb_Giornata1;

    MskLimite2.Text:=FormatDateTime('hh.nn',A042FStampaPreAssDtM1.A042MW.tPb_Limite2);
    RbtIntervallo2.Checked:=A042FStampaPreAssDtM1.A042MW.bPb_Intervallo2;
    RbtGiornata2.Checked:=A042FStampaPreAssDtM1.A042MW.bPb_Giornata2;

  end;
end;

procedure TA042FImpostazioniProspetto.BitBtn1Click(Sender: TObject);
begin

  with A042FDialogStampa do
  begin
    try
      A042FStampaPreAssDtM1.A042MW.tPb_Limite1:=StrToTime(MskLimite1.Text);
    except
      raise exception.Create(MskLimite1.Text + ' non è un''ora valida.');
    end;
    A042FStampaPreAssDtM1.A042MW.bPb_Intervallo1:=RbtIntervallo1.Checked;
    A042FStampaPreAssDtM1.A042MW.bPb_Giornata1:=RbtGiornata1.Checked;
    try
      A042FStampaPreAssDtM1.A042MW.tPb_Limite2:=StrToTime(MskLimite2.Text);
    except
      raise exception.Create(MskLimite2.Text + ' non è un''ora valida.');
    end;
    A042FStampaPreAssDtM1.A042MW.bPb_Intervallo2:=RbtIntervallo2.Checked;
    A042FStampaPreAssDtM1.A042MW.bPb_Giornata2:=RbtGiornata2.Checked;
  end;

  A042FImpostazioniProspetto.Close;
  
end;

end.
