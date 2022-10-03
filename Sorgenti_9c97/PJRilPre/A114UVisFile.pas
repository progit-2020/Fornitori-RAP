unit A114UVisFile;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Printers, C180FunzioniGenerali, Grids,
  DBGrids, Variants;

type
  TA114FVisFile = class(TForm)
    Panel1: TPanel;
    btnStampa: TBitBtn;
    btnSetup: TBitBtn;
    btnEsci: TBitBtn;
    memoAnomalie: TMemo;
    PrinterSetupDialog1: TPrinterSetupDialog;
    SaveDialog1: TSaveDialog;
    DbGrdLog: TDBGrid;
    procedure btnSetupClick(Sender: TObject);
    procedure btnStampaClick(Sender: TObject);
    procedure BtnSalvaLogClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    F:TextFile;
  public
    { Public declarations }
  end;

var
  A114FVisFile: TA114FVisFile;

implementation

uses A114UEstrazioniStampeDtm;

{$R *.DFM}

procedure TA114FVisFile.btnSetupClick(Sender: TObject);
begin
  PrinterSetUpDialog1.Execute;
end;

procedure TA114FVisFile.btnStampaClick(Sender: TObject);
var i:Integer;
    Intestazione:String;
    sDep:string;
begin
  Screen.Cursor:=crHourGlass;
  try
    AssignPrn(F);
    Rewrite(F);
    if DbGrdLog.Visible then
    begin
      Printer.Canvas.Font.Name:='Courier New';
      Printer.Canvas.Font.Size:=7;
      with A114FEstrazioniStampeDtm do
      begin
        if DbGrdLog.DataSource = D932 then
        begin
          SelT932.First;
          Intestazione:='Log estrazione dati dal generatore di stampe';
          writeln(F,Intestazione);
          writeln(F,'');
          while not SelT932.Eof do
          begin
            writeln(F,SelT932DATA.asString + ' ' + SelT932DESCRIZIONE.asString);
            SelT932.Next;
          end;
        end
        else if DbGrdLog.DataSource = DSelect then
        begin
          QSelect.First;
          writeln(F,'Tabella oracle estrazione dati dal generatore di stampe');
          writeln(F,'');
          Intestazione:='';
          for i:=0 to QSelect.FieldCount - 1 do
            if QSelect.Fields[i].Visible then
              Intestazione:=Intestazione + Format('%-*s',[QSelect.Fields[i].DisplayWidth + 1, QSelect.Fields[i].FieldName]);
          writeln(F,Intestazione);
          while not QSelect.Eof do
          begin
            sDep:='';
            for i:=0 to QSelect.Fields.Count - 1 do
              if QSelect.Fields[i].Visible then
                sDep:=sDep + Format('%-*s',[QSelect.Fields[i].DisplayWidth + 1, QSelect.Fields[i].AsString]);
            writeln(F,sDep);
            QSelect.Next;
          end;
        end;
      end;
    end
    else if memoAnomalie.Visible then
    begin
      Printer.Canvas.Font:=memoAnomalie.Font;
      Intestazione:='File ascii estrazione dati dal generatore di stampe';
      writeln(F,Intestazione);
      writeln(F,'');
      for i:=0 to memoAnomalie.Lines.Count - 1 do
        writeln(F,memoAnomalie.Lines[i]);
    end;
  finally
    CloseFile(F);
  end;
  Screen.Cursor:=crDefault;
end;

procedure TA114FVisFile.BtnSalvaLogClick(Sender: TObject);
begin
  if A114FVisFile.Caption='<A114> Tabella oracle di estrazione dati dal generatore di stampe' then
  begin
    SaveDialog1.Title:='Salva contenuto tabella oracle';
    SaveDialog1.DefaultExt := 'txt';
    SaveDialog1.Filter := 'Txt files (*.txt)|*.txt|All files (*.*)|*.*';
    SaveDialog1.FileName:='TabellaOracle.txt';
    SaveDialog1.FilterIndex := 1;
  end
  else
  begin
    SaveDialog1.Title:='Salva file di log';
    SaveDialog1.DefaultExt := 'log';
    SaveDialog1.Filter := 'Log files (*.log)|*.log|All files (*.*)|*.*';
    SaveDialog1.FileName:='EstrazioneDati.log';
    SaveDialog1.FilterIndex := 1;
  end;
  if SaveDialog1.Execute then
  begin
    if FileExists(SaveDialog1.FileName) then
    begin
      if R180MessageBox('Il file ' + SaveDialog1.FileName + ' esiste già. Sostituirlo?', DOMANDA) = mrYes then
        memoAnomalie.Lines.SaveToFile(SaveDialog1.FileName);
    end
    else
      memoAnomalie.Lines.SaveToFile(SaveDialog1.FileName);
  end;
end;

procedure TA114FVisFile.FormResize(Sender: TObject);
var
  nLength,i:integer;
begin
  if DbGrdLog.Visible then
  begin
    nLength:=0;
    for i:=0 to DbGrdLog.Columns.Count-2 do
      nLength:=nLength+DbGrdLog.Columns[i].Width;
    if nLength < A114FVisFile.Width then
      DbGrdLog.Columns[DbGrdLog.Columns.Count-1].Width:=A114FVisFile.Width - nLength;
  end;
end;

end.
