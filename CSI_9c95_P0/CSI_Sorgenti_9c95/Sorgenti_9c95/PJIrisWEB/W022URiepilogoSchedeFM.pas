unit W022URiepilogoSchedeFM;

interface

uses
  SysUtils, Classes, Controls, Forms, IWAppForm,
  A000UCostanti, C180FunzioniGenerali,
  IWRegion,
  IWCompButton,


  IWTemplateProcessorHTML, R010UPAGINAWEB,
  C190FunzioniGeneraliWeb, DBClient, IWCompJQueryWidget, IWCompGrids,
  meIWGrid, meIWButton, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container;

type
  TW022FRiepilogoSchedeFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    jQRiepilogoSchede: TIWJQueryWidget;
    IWTemplateProcessorFrame: TIWTemplateProcessorHTML;
    btnChiudi: TmeIWButton;
    grdRiepilogoSchede: TmeIWGrid;
    btnCopiaExcel: TmeIWButton;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdRiepilogoSchedeRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure btnCopiaExcelClick(Sender: TObject);
  private
    { Private declarations }
    function  ToCsv: String;
  public
    ARiepilogo,MRiepilogo,GRiepilogo:Word;
    cdsRiepilogo:TClientDataSet;
    procedure Visualizza(Data:TDateTime);
  end;

implementation

{$R *.dfm}

procedure TW022FRiepilogoSchedeFM.btnChiudiClick(Sender: TObject);
begin
  Free;
end;

procedure TW022FRiepilogoSchedeFM.btnCopiaExcelClick(Sender: TObject);
begin
  (Self.Owner as TR010FPaginaWeb).InviaFile('Riepilogo schede per l''anno ' + IntToStr(ARiepilogo) + '.xls',ToCsv);
end;

function TW022FRiepilogoSchedeFM.ToCsv: String;
var
  Riga,ElencoCampiInvisibili: String;
  i: Integer;
begin
  Result:='';
  Riga:='';

  ElencoCampiInvisibili:='A';
  with cdsRiepilogo do
  begin
    if not Active then
      exit;
    DisableControls;
    First;
    try
      while not EOF do
      begin
        Riga:='';
        for i:=0 to FieldCount - 1 do
          if Pos(',' + Fields[i].FieldName + ',',',' + ElencoCampiInvisibili + ',') = 0 then
            Riga:=Riga + '"' + Trim(Fields[i].AsString) + '"' + TAB;
        Result:=Result + Riga + CRLF;
        Next;
      end;
    finally
      First;
      EnableControls;
    end;
  end;
end;

procedure TW022FRiepilogoSchedeFM.grdRiepilogoSchedeRenderCell(ACell: TIWGridCell;const ARow, AColumn: Integer);
begin
  if AColumn = 0 then //Colonna ordinamento
    ACell.Css:='invisibile';
  if AColumn = 2 then //Descrizioni
    ACell.Wrap:=True;
  if (grdRiepilogoSchede.Cell[ARow,0].Text = '1') and (AColumn > 0) then
    ACell.Css:='riga_intestazione';
  if (grdRiepilogoSchede.Cell[ARow,0].Text = '2') and (AColumn > 0) then
    ACell.Css:='bg_celeste';
  if (grdRiepilogoSchede.Cell[ARow,0].Text = '3') and (AColumn > 0) then
    ACell.Css:='riga_colorata';
end;

procedure TW022FRiepilogoSchedeFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=(Self.Owner as TIWAppForm);
end;

procedure TW022FRiepilogoSchedeFM.Visualizza(Data:TDateTime);
var
  i:Integer;
begin
  with cdsRiepilogo do
  begin
    First;
    grdRiepilogoSchede.ColumnCount:=4;
    grdRiepilogoSchede.RowCount:=cdsRiepilogo.RecordCount;

    i:=0;
    while not Eof do
    begin
      grdRiepilogoSchede.Cell[i,0].Text:=FieldByName('A').AsString;
      grdRiepilogoSchede.Cell[i,1].Text:=FieldByName('B').AsString;
      grdRiepilogoSchede.Cell[i,2].Text:=FieldByName('C').AsString;
      grdRiepilogoSchede.Cell[i,3].Text:=FieldByName('D').AsString;
      Next;
      i:=i+1;
    end;

    btnCopiaExcel.Enabled:=RecordCount > 0;
  end;

  DecodeDate(Data,ARiepilogo,MRiepilogo,GRiepilogo);
  (Self.Parent as TR010FPaginaWeb).VisualizzajQMessaggio(jQRiepilogoSchede, 800, -1,EM2PIXEL * 50, 'Riepilogo schede per l''anno ' + IntToStr(ARiepilogo), '#' + Name, False, True);
end;

end.
