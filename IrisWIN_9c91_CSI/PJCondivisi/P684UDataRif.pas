unit P684UDataRif;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons, ExtCtrls, A000UCostanti, A000USessione, A000UInterfaccia, A003UDataLavoroBis;

type
  TP684FDataRif = class(TForm)
    Panel1: TPanel;
    btnOK: TBitBtn;
    BitBtn2: TBitBtn;
    btnDataRif: TBitBtn;
    lblDataRif: TLabel;
    edtDataRif: TMaskEdit;
    procedure btnDataRifClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  P684FDataRif: TP684FDataRif;

implementation

uses P684UDettaglioRisorse;

{$R *.dfm}

procedure TP684FDataRif.btnOKClick(Sender: TObject);
begin
  P684FDettaglioRisorse.DataRif:=StrToDate(edtDataRif.Text);
end;

procedure TP684FDataRif.btnDataRifClick(Sender: TObject);
begin
  edtDataRif.Text:=DateToStr(DataOut(StrToDate(edtDataRif.Text),'Data riferimento','G'));
end;

procedure TP684FDataRif.FormShow(Sender: TObject);
begin
  edtDataRif.Text:=DateToStr(Parametri.DataLavoro);
end;

end.
