unit W014URiepilogoProfiliFM;

interface

uses
  SysUtils, Classes, Controls, Forms,
  IWVCLBaseContainer, IWColor, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, R010UPaginaWeb, IWCompButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  A000UInterfaccia, R100UCreditiFormativiDtM, R012UWEBANAGRAFICO, IWAppForm,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWCompJQueryWidget, IWCompGrids, C190FunzioniGeneraliWeb, meIWButton, meIWGrid;

type
  TW014FRiepilogoProfiliFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    grdRiepilogo: TmeIWGrid;
    jQRiepilogoAnno: TIWJQueryWidget;
    btnChiudi: TmeIWButton;
    IWTemplateProcessorFrame: TIWTemplateProcessorHTML;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdRiepilogoRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
  private
  public
    R100: TR100FCreditiFormativiDtM;
    procedure CaricaRiepilogo(AnnoRiepilogo: Integer);
  end;

implementation

{$R *.dfm}

procedure TW014FRiepilogoProfiliFM.btnChiudiClick(Sender: TObject);
begin
  Free;
end;

procedure TW014FRiepilogoProfiliFM.CaricaRiepilogo(AnnoRiepilogo: Integer);
var
  sProfiloCrediti: string;
  TotaleFruito: real;
begin
  grdRiepilogo.Clear;
  grdRiepilogo.ColumnCount:=9;
  grdRiepilogo.RowCount:=1;
  grdRiepilogo.Cell[0,0].Text:='Profilo';
  grdRiepilogo.Cell[0,1].Text:='Res.prec.';
  grdRiepilogo.Cell[0,2].Text:='Comp.corr';
  grdRiepilogo.Cell[0,3].Text:='Comp.min.';
  grdRiepilogo.Cell[0,4].Text:='Comp.max.';
  grdRiepilogo.Cell[0,5].Text:='Fruito corr.';
  grdRiepilogo.Cell[0,6].Text:='Res.corr.';
  grdRiepilogo.Cell[0,7].Text:='Res.min.';
  grdRiepilogo.Cell[0,8].Text:='Res.max.';
  with WR000DM do
  begin
    // Selezionare tutti i profili di corso assegnati ad dipendente selezionato...
    if Parametri.CampiRiferimento.C10_FormazioneProfiloCrediti <> '' then
    begin
      // LEGGO IL VAORE DI TALE PARAMETRO NELLO STORICO DEL DIPENDENTE ALLA DATALAVORO
      selT430.Close;
      selT430.SetVariable('FIELD',Parametri.CampiRiferimento.C10_FormazioneProfiloCrediti);
      selT430.SetVariable('PROGRESSIVO',TR012FWebAnagrafico(Self.Parent).selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      selT430.SetVariable('DATALAVORO',Now);
      selT430.Open;
      if (selT430.RecordCount > 0) then
        sProfiloCrediti:=selT430.FieldByName('CAMPO').AsString;
      selT430.Close;
    end;
    // Se il dipendente corrente ha un profilo_crediti caricato sull'anagrafico, seleziono dalla
    // tabella sg655_profilicrediti dove il codice = sProfiloCrediti;
    if sProfiloCrediti <> '' then
    begin
      SelSG655.Close;
      SelSG655.SetVariable('CODICE',sProfiloCrediti);
      SelSG655.Open;
      if SelSG655.RecordCount = 1 then
        grdRiepilogo.RowCount:=SelSG655.RecordCount + 1
      else if SelSG655.RecordCount > 1 then
        grdRiepilogo.RowCount:=SelSG655.RecordCount + 2;
      TotaleFruito:=0;
      while not SelSG655.Eof do
      begin
        R100.ConteggioCrediti(TR012FWebAnagrafico(Self.Parent).selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,EncodeDate(AnnoRiepilogo,1,1),EncodeDate(AnnoRiepilogo,12,31),SelSG655.FieldByName('PROFILO_CREDITI').AsString);
        grdRiepilogo.Cell[SelSG655.RecNo,0].Text:=SelSG655.FieldByName('PROFILO_CREDITI').AsString;
        grdRiepilogo.Cell[SelSG655.RecNo,1].Text:=FloatToStr(R100.CompResCrediti.nResAnnoPrec);
        grdRiepilogo.Cell[SelSG655.RecNo,2].Text:=FloatToStr(R100.CompResCrediti.nCompAnnoCorr);
        grdRiepilogo.Cell[SelSG655.RecNo,3].Text:=FloatToStr(R100.CompResCrediti.nCompMinAnnoCorr);
        grdRiepilogo.Cell[SelSG655.RecNo,4].Text:=FloatToStr(R100.CompResCrediti.nCompMaxAnnoCorr);
        grdRiepilogo.Cell[SelSG655.RecNo,5].Text:=FloatToStr(R100.CompResCrediti.nFruitoPeriodo);
        grdRiepilogo.Cell[SelSG655.RecNo,6].Text:=FloatToStr(R100.CompResCrediti.nResAnnoCorr);
        grdRiepilogo.Cell[SelSG655.RecNo,7].Text:=FloatToStr(R100.CompResCrediti.nResMinAnnoCorr);
        grdRiepilogo.Cell[SelSG655.RecNo,8].Text:=FloatToStr(R100.CompResCrediti.nResMaxAnnoCorr);
        TotaleFruito:=TotaleFruito + R100.CompResCrediti.nFruitoPeriodo;
        SelSG655.Next;
      end;
      if SelSG655.RecordCount > 1 then
      begin
        // Inserisco una ultima riga con il totale
        grdRiepilogo.Cell[SelSG655.RecNo + 1,0].Text:='TOTALE';
        grdRiepilogo.Cell[SelSG655.RecNo + 1,1].Text:='';
        grdRiepilogo.Cell[SelSG655.RecNo + 1,2].Text:='';
        grdRiepilogo.Cell[SelSG655.RecNo + 1,3].Text:='';
        grdRiepilogo.Cell[SelSG655.RecNo + 1,4].Text:='';
        grdRiepilogo.Cell[SelSG655.RecNo + 1,5].Text:=FloatToStr(TotaleFruito);
        grdRiepilogo.Cell[SelSG655.RecNo + 1,6].Text:='';
        grdRiepilogo.Cell[SelSG655.RecNo + 1,7].Text:='';
        grdRiepilogo.Cell[SelSG655.RecNo + 1,8].Text:='';
      end;
      SelSG655.Close;
    end;
  end;

  (Self.Parent as TR010FPaginaWeb).VisualizzajQMessaggio(jQRiepilogoAnno,580,-1,EM2PIXEL * 30,'Riepilogo','#' + Name,False,False);
end;

procedure TW014FRiepilogoProfiliFM.grdRiepilogoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  (Self.Parent as TR010FPaginaWeb).RenderCell(ACell,ARow,AColumn,True,True);

  if (ARow > 0) and (AColumn in [0,1,4,5]) then
  begin
    ACell.Css:='riga_colorata';
    if (ARow = grdRiepilogo.RowCount - 1) and (grdRiepilogo.RowCount > 2) then
      ACell.Css:=ACell.Css + ' ' + 'segnalazione';
  end;
end;

procedure TW014FRiepilogoProfiliFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=(Self.Owner as TIWAppForm);
end;

end.