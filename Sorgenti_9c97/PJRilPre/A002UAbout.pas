unit A002UAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GIFImg, jpeg, ExtCtrls, StdCtrls, A000UInterfaccia, Vcl.Imaging.pngimage;

type
  TA002FAbout = class(TForm)
    PnlAbout: TPanel;
    pnlPartners: TPanel;
    imgMondoedp: TImage;
    imgIrisWIN: TImage;
    ImgOracle: TImage;
    pnlMiddle: TPanel;
    lblInfo: TLabel;
    tmrShowForm: TTimer;
    procedure FormShow(Sender: TObject);
    procedure tmrShowFormTimer(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A002FAbout: TA002FAbout;

implementation

{$R *.dfm}

procedure TA002FAbout.FormResize(Sender: TObject);
begin
  if A002FAbout.Width <> 600 then
    A002FAbout.Width:=600;
  if A002FAbout.Height <= 450 then
    A002FAbout.Height:=450;
end;

procedure TA002FAbout.FormShow(Sender: TObject);
var S:String;
  function ModuliInstCount:Integer;
  var i:Integer;
      Temp:String;
  begin
    Result:=0;
    Temp:=Trim(Parametri.ModuliInstallati);
    for i:=1 to Length(Temp) do
      if #$D = Temp[i] then
        inc(Result);
  end;
begin
  tmrShowForm.Enabled:=True;
  A002FAbout.AlphaBlendValue:=0;
  if Parametri.ModuliInstallati = '' then
    S:='nessuno'
  else
    S:=Parametri.ModuliInstallati;
  lblInfo.Caption:='IrisWIN - ' + Application.Title + #13 +
                   'Versione: ' + Parametri.VersionePJ + ' (' + Parametri.BuildPJ  + ')' + #13 +
                   'Data di rilascio: ' + Parametri.DataPJ + #13 + #13 +
                   (*
                   'by Mondo Edp' + #13 +
                   'Via Barbaresco, 11' + #13#10 + '12100 CUNEO' + #13 + #13 +
                   'Contatti:' + #13 +
                   'http://www.mondoedp.com' + #13 +
                   'e-mail informazioni: staff@mondoedp.com' + #13 +
                   'e-mail assistenza: assistenza@mondoedp.com' + #13 +
                   'Tel: 0171 34 66 85 - Fax: 0171 34 66 86' + #13 + #13 +
                   *)
                   'Moduli installati:' + #13 +
                   S;
    A002FAbout.Height:=A002FAbout.Height + (ModuliInstCount * 7);
end;

procedure TA002FAbout.tmrShowFormTimer(Sender: TObject);
begin
  A002FAbout.AlphaBlendValue:=A002FAbout.AlphaBlendValue + 5;
  if A002FAbout.AlphaBlendValue >= 255 then
    tmrShowForm.Enabled:=False;
end;

end.
