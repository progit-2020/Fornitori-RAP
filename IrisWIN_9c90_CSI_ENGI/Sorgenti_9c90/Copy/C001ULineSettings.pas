unit C001ULineSettings;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Variants;

type
  TC001FLineSettings = class(TForm)
    GBDimensioni: TGroupBox;
    EAltezza: TEdit;
    ELarghezza: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    RGTratteggio: TRadioGroup;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    RGAllineamento: TRadioGroup;
    procedure EAltezzaChange(Sender: TObject);
    procedure ELarghezzaChange(Sender: TObject);
    procedure FiltraTasti(Sender: TObject; var Key: Char);
    procedure RGTratteggioClick(Sender: TObject);
    procedure RGAllineamentoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Tratteggio   : Integer;
    Altezza      : Integer;
    Larghezza    : Integer;
    Allineamento : Integer;
  end;

var
  C001FLineSettings: TC001FLineSettings;

implementation

{$R *.DFM}

//------------------------------------------------------------------------------
procedure TC001FLineSettings.EAltezzaChange(Sender: TObject);
var App : Integer;
begin
  try
   App := strtoint(EAltezza.Text);
  except
   App := 1;
  end;
  Altezza := App;
end;

//------------------------------------------------------------------------------
procedure TC001FLineSettings.ELarghezzaChange(Sender: TObject);
var App : Integer;
begin
  try
   App := strtoint(ELarghezza.Text);
  except
   App := 793;
  end;
  Larghezza := App;
end;

//------------------------------------------------------------------------------
procedure TC001FLineSettings.FiltraTasti(Sender: TObject;
  var Key: Char);
begin
  if not(Key in(['0'..'9',#13,#8])) then
    Key := #0;
end;

//------------------------------------------------------------------------------
procedure TC001FLineSettings.RGTratteggioClick(Sender: TObject);
begin
  Tratteggio := RGTratteggio.ItemIndex;
  if Tratteggio = 0 then
    begin
      EAltezza.Enabled := True;
    end
  else
    begin
      EAltezza.Text := '1';
      EAltezza.Enabled := False;
    end;
end;

//------------------------------------------------------------------------------
procedure TC001FLineSettings.RGAllineamentoClick(Sender: TObject);
begin
  Allineamento := RGAllineamento.ItemIndex;
end;
//------------------------------------------------------------------------------
procedure TC001FLineSettings.FormShow(Sender: TObject);
begin
  RGTratteggio.ItemIndex := Tratteggio;
  RGAllineamento.ItemIndex := Allineamento;
  EAltezza.Text := inttostr(Altezza);
  ELarghezza.Text := inttostr(Larghezza);
end;

end.
