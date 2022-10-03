unit R002UQRep;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls, QRExport, Variants, QrWebFilt, QRPDFFilt;

type
  TR002FQRep = class(TForm)
    QRep: TQuickRep;
    Titolo: TQRBand;
    LEnte: TQRLabel;
    qlblSysData: TQRSysData;
    LTitolo: TQRLabel;
    QRTextFilter1: TQRTextFilter;
    HTMLFilter: TQRHTMLFilter;
    ExcelFilter: TQRExcelFilter;
    RTFFilter: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    qlblSysPagina: TQRSysData;
    procedure QRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRepAfterPrint(Sender: TObject);
    procedure QRepAfterPreview(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    ThousandSepOri: Char;
  public
    { Public declarations }
  end;

var
  R002FQRep: TR002FQRep;

implementation

{$R *.DFM}

procedure TR002FQRep.QRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  if {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator <> #0 then
    ThousandSepOri:={$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator
  else
    {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=ThousandSepOri;
  if QRep.Exporting and (QRep.ExportFilter is TQRXLSFilter) then
      {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=#0;
end;

procedure TR002FQRep.QRepAfterPrint(Sender: TObject);
begin
  if {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator = #0 then
    {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=ThousandSepOri;
end;

procedure TR002FQRep.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator = #0 then
    {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=ThousandSepOri;
end;

procedure TR002FQRep.FormCreate(Sender: TObject);
begin
  QRep.useQR5Justification:=True;
  ThousandSepOri:={$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator;
end;

procedure TR002FQRep.QRepAfterPreview(Sender: TObject);
begin
  if {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator = #0 then
    {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=ThousandSepOri;
end;

end.
