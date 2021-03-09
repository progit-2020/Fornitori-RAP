unit A077UCOMServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs(*,A077UCOMRemoteDtM*);

type
  TA077FCOMServer = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    (*A077CS:TA077ComServer;*)
  public
    { Public declarations }
  end;

var
  A077FCOMServer: TA077FCOMServer;

implementation

{$R *.dfm}

procedure TA077FCOMServer.FormCreate(Sender: TObject);
begin
  (*A077CS:=TA077COMServer.Create(nil);*)
end;

end.
