unit Tabelle99;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Menus, DBCtrls, Variants,
  A000USessione, C180FunzioniGenerali;

type
  TFrmTabelle99 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    Stampa1: TMenuItem;
    ImpostaStampante1: TMenuItem;
    StatusBar: TStatusBar;
    PrinterSetupDialog1: TPrinterSetupDialog;
    procedure Exit1Click(Sender: TObject);
    procedure ImpostaStampante1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTabelle99: TFrmTabelle99;

implementation

{$R *.DFM}

procedure TFrmTabelle99.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmTabelle99.ImpostaStampante1Click(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure TFrmTabelle99.FormCreate(Sender: TObject);
begin
  A000SettaVariabiliAmbiente;
  if A000SessioneIrisWIN.Parametri.DataLavoro > 0 then
    StatusBar.Panels[0].Text:='Data lavoro:' + FormatDateTime('dd/mm/yyyy',A000SessioneIrisWIN.Parametri.DataLavoro)
  else
    StatusBar.Panels[0].Text:=FormatDateTime('dd/mm/yyyy',Date);
  R180ToolbarHandleNeeded(Self);
end;

end.
