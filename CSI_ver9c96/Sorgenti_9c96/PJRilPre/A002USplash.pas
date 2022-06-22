unit A002USplash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Variants, jpeg, GIFImg, Vcl.Imaging.pngimage;

type
  TA002FSplash = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    Image3: TImage;
    Panel2: TPanel;
    Image4: TImage;
    Image2: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A002FSplash: TA002FSplash;

implementation

{$R *.DFM}

procedure TA002FSplash.FormCreate(Sender: TObject);
begin
  if FileExists(ExtractFilePath(Application.ExeName) + 'IrisWIN.bmp') then
    begin
    Image1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'IrisWIN.bmp');
    Image1.Stretch:=(Image1.Picture.Bitmap.Width > Image1.Width) and (Image1.Picture.Bitmap.Height > Image1.Height);
//    Panel1.Visible:=False; //D'Orazio??
    end;
end;

end.
