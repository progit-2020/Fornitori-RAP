unit A176URiepilogoIterAutorizzativiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R004UGestStoricoDTM, Data.DB, OracleData,
  A176URiepilogoIterAutorizzativiMW;

type
  TA176FRiepilogoIterAutorizzativiDM = class(TR004FGestStoricoDtM)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    A176MW:TA176FRiepilogoIterAutorizzativiMW;
  end;

var
  A176FRiepilogoIterAutorizzativiDM: TA176FRiepilogoIterAutorizzativiDM;

implementation

{$R *.dfm}

procedure TA176FRiepilogoIterAutorizzativiDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A176MW:=TA176FRiepilogoIterAutorizzativiMW.Create(nil);
  A176MW.CodForm:='A176';
end;

procedure TA176FRiepilogoIterAutorizzativiDM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A176MW);
  inherited;
end;

end.
