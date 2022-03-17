unit A042UGrafico;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeeProcs, TeEngine, Chart, Grids, ExtCtrls, Series, GanttCh, StdCtrls, QRPDFFilt,
  Buttons, Printers, A000UCostanti, A000USessione,A000UInterfaccia, Variants,SynPdf;

type
  TA042FGrafico = class(TForm)
    Panel1: TPanel;
    BtnEsci: TBitBtn;
    BitBtn1: TBitBtn;
    Chart1: TChart;
    Series1: TGanttSeries;
    Series2: TGanttSeries;
    Series3: TGanttSeries;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    ChartLegenda: TChart;
    Panel4: TPanel;
    Label2: TLabel;
    Image1: TImage;
    Label3: TLabel;
    Image2: TImage;
    Label4: TLabel;
    Image3: TImage;
    Label5: TLabel;
    ChkLineeVerticali: TCheckBox;
    ChkLineeOrizzontali: TCheckBox;
    Shape1: TShape;
    edtIntestazione: TEdit;
    Label6: TLabel;
    Series4: TGanttSeries;
    LblTitolo: TLabel;
    LblAzienda: TLabel;
    LblIntestazione: TLabel;
    procedure BtnStampaClick(Sender: TObject);
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure ChkLineeVerticaliClick(Sender: TObject);
    procedure ChkLineeOrizzontaliClick(Sender: TObject);
    procedure edtIntestazioneChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A042FGrafico: TA042FGrafico;

implementation

uses A042UDialogStampa, A042UStampaGrafico, A042UStampaPreAssDtM1;

{$R *.DFM}

procedure TA042FGrafico.BtnStampaClick(Sender: TObject);
var
  i,n,nElementi,nElementoCorrente,nPagina:integer;
  DaData, AData: TDateTime;
  MyOrientation:TPrinterOrientation;
  Pdf: TPdfDocument;
  MF: TMetaFile;
begin
  //Alberto 15/05/2006: stampa della form senza usare il quick report
  //if PrinterSetupDialog1.Execute then
  (*begin
    Panel1.Visible:=False;
    Self.Print;
    Panel1.Visible:=True;
  end;*)
  //(*
  MyOrientation:=A042FStampaGrafico.PrinterSettings.Orientation;
  A042FStampaGrafico.Page.Orientation:=poLandscape;
  if A042FDialogStampa.TipoModulo = 'COM' then
  begin
    A042FStampaGrafico.QRChart1.Chart.BottomAxis.Grid.Visible:=A042FDialogStampa.VisualizzaVLine;
    A042FStampaGrafico.QRChart1.Chart.LeftAxis.Grid.Visible:=A042FDialogStampa.VisualizzaHLine;
    A042FGrafico.LblIntestazione.Caption:=A042FDialogStampa.TitoloGrafico;
  end;


  Pdf:=TPdfDocument.Create;
  try
    with A042FDialogStampa, A042FStampaPreAssDtM1.A042MW do
    begin
      DaData:=StrtoDateTIme(sDaData + ' 00.00.00');
      AData:=StrtoDateTIme(sAData + ' 23.59.59');

      A042FStampaGrafico.QRChart1.Chart.BottomAxis.Minimum:=0;
      A042FStampaGrafico.QRChart1.Chart.BottomAxis.Maximum:=0;
      A042FStampaGrafico.QRLegenda.Chart.BottomAxis.Minimum:=0;
      A042FStampaGrafico.QRLegenda.Chart.BottomAxis.Maximum:=0;
      A042FStampaGrafico.QRChart1.Chart.BottomAxis.Maximum:=AData;
      A042FStampaGrafico.QRChart1.Chart.BottomAxis.Minimum:=DaData;
      A042FStampaGrafico.QRLegenda.Chart.BottomAxis.Maximum:=AData;
      A042FStampaGrafico.QRLegenda.Chart.BottomAxis.Minimum:=DaData;
      A042FStampaGrafico.QRChart1.Chart.BottomAxis.Title.Caption:='DATA: ' + FormatDateTime('dd mmmm yyyy',DaData);
      A042FStampaGrafico.QRLblIntestazione.Caption:=LblIntestazione.Caption;

      nElementi:=length(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiGiustI)-1;
      nElementoCorrente:=0;
      nPagina:=0;

      while nElementi >= 24 do  //Prevedo di stampare un massimo di 24 elemento sull'asse delle y
      begin
        //Ripulisco le serie
        A042FStampaGrafico.QRChart1.Chart.Series[0].Clear;
        A042FStampaGrafico.QRChart1.Chart.Series[1].Clear;
        A042FStampaGrafico.QRChart1.Chart.Series[2].Clear;
        A042FStampaGrafico.QRLegenda.Chart.Series[0].Clear;

        nPagina:=nPagina+1;
        A042FStampaGrafico.QRLblPagina.Caption:='PAGINA ' + inttostr(nPagina);
        //Inizio a piazzare nella serie1 i giustificativi di assenza a giornata intera...
        for i:=1 to 24 do
        begin
          nElementoCorrente:=nElementoCorrente+1;
          //Inserisco il dipendente in ogni caso...
          A042FStampaGrafico.Series1.AddGanttColor(0, 0, i, aPb_DatiDipendentiGiustI[nElementoCorrente].sDescrizione, clwhite);
          //Inserisco i dati del dipendente nella prima serie
          for n:=1 to length(aPb_DatiDipendentiGiustI[nElementoCorrente].aDatiDipendente)-1 do
            if not bPb_MostraCausaliNonAbbinate then
            begin
              if aPb_DatiDipendentiGiustI[nElementoCorrente].aDatiDipendente[n].xColore <> clWhite then  //mostro la causale soltanto se non è bianca...
                A042FStampaGrafico.Series1.AddGanttColor(aPb_DatiDipendentiGiustI[nElementoCorrente].aDatiDipendente[n].dDataDa, aPb_DatiDipendentiGiustI[nElementoCorrente].aDatiDipendente[n].dDataA, i, aPb_DatiDipendentiGiustI[nElementoCorrente].sDescrizione, aPb_DatiDipendentiGiustI[nElementoCorrente].aDatiDipendente[n].xColore);
            end
            else  //altrimenti la mostro comunque
              A042FStampaGrafico.Series1.AddGanttColor(aPb_DatiDipendentiGiustI[nElementoCorrente].aDatiDipendente[n].dDataDa, aPb_DatiDipendentiGiustI[nElementoCorrente].aDatiDipendente[n].dDataA, i, aPb_DatiDipendentiGiustI[nElementoCorrente].sDescrizione, aPb_DatiDipendentiGiustI[nElementoCorrente].aDatiDipendente[n].xColore);
          //Inserisco i dati del dipendente nella seconda serie
          for n:=1 to length(aPb_DatiDipendentiGiustM[nElementoCorrente].aDatiDipendente)-1 do
            if not bPb_MostraCausaliNonAbbinate then
            begin
              if aPb_DatiDipendentiGiustM[nElementoCorrente].aDatiDipendente[n].xColore <> clWhite then  //mostro la causale soltanto se non è bianca...
                A042FStampaGrafico.Series2.AddGanttColor(aPb_DatiDipendentiGiustM[nElementoCorrente].aDatiDipendente[n].dDataDa, aPb_DatiDipendentiGiustM[nElementoCorrente].aDatiDipendente[n].dDataA, i, aPb_DatiDipendentiGiustM[nElementoCorrente].sDescrizione, aPb_DatiDipendentiGiustM[nElementoCorrente].aDatiDipendente[n].xColore);
            end
            else  //altrimenti la mostro comunque
              A042FStampaGrafico.Series2.AddGanttColor(aPb_DatiDipendentiGiustM[nElementoCorrente].aDatiDipendente[n].dDataDa, aPb_DatiDipendentiGiustM[nElementoCorrente].aDatiDipendente[n].dDataA, i, aPb_DatiDipendentiGiustM[nElementoCorrente].sDescrizione, aPb_DatiDipendentiGiustM[nElementoCorrente].aDatiDipendente[n].xColore);
         for n:=1 to length(aPb_DatiDipendentiTimbGiusH[nElementoCorrente].aDatiDipendente)-1 do
            if not bPb_MostraCausaliNonAbbinate then
            begin
              if aPb_DatiDipendentiTimbGiusH[nElementoCorrente].aDatiDipendente[n].xColore <> clWhite then  //mostro la causale soltanto se non è bianca...
                A042FStampaGrafico.Series3.AddGanttColor(aPb_DatiDipendentiTimbGiusH[nElementoCorrente].aDatiDipendente[n].dDataDa, aPb_DatiDipendentiTimbGiusH[nElementoCorrente].aDatiDipendente[n].dDataA, i, aPb_DatiDipendentiTimbGiusH[nElementoCorrente].sDescrizione, aPb_DatiDipendentiTimbGiusH[nElementoCorrente].aDatiDipendente[n].xColore);
            end
            else  //altrimenti la mostro comunque
              A042FStampaGrafico.Series3.AddGanttColor(aPb_DatiDipendentiTimbGiusH[nElementoCorrente].aDatiDipendente[n].dDataDa, aPb_DatiDipendentiTimbGiusH[nElementoCorrente].aDatiDipendente[n].dDataA, i, aPb_DatiDipendentiTimbGiusH[nElementoCorrente].sDescrizione, aPb_DatiDipendentiTimbGiusH[nElementoCorrente].aDatiDipendente[n].xColore);
        end;
        //Compilo infine la legenda delle causali...
        A042FStampaGrafico.Series4.AddGanttColor(0, 0, 0, ' ',clWhite);  //Inserisco la prima causale bianca per creare lo spazio in basso
        n:=0;
        for i:=0 to length(aPb_LegendaCausali)-1 do
          if not bPb_MostraCausaliNonAbbinate then
          begin
            if aPb_LegendaCausali[i].xColore <> clWhite then  //mostro la causale soltanto se non è bianca...
            begin
              n:=n+1;
              if aPb_LegendaCausali[i].sCodice =cPb_CodiceOreNonCausalizzate then
                A042FStampaGrafico.Series4.AddGanttColor(strtodatetime(sDaData + ' 08.00.00'), strtodatetime(sDaData + ' 16.00.00'), n, 'Ore n.c.',aPb_LegendaCausali[i].xColore)
              else
                A042FStampaGrafico.Series4.AddGanttColor(strtodatetime(sDaData + ' 08.00.00'), strtodatetime(sDaData + ' 16.00.00'), n, aPb_LegendaCausali[i].sCodice,aPb_LegendaCausali[i].xColore);
            end;
          end
          else
            if aPb_LegendaCausali[i].sCodice =cPb_CodiceOreNonCausalizzate then
              A042FStampaGrafico.Series4.AddGanttColor(strtodatetime(sDaData + ' 08.00.00'), strtodatetime(sDaData + ' 16.00.00'), i+1, 'Ore n.c.',aPb_LegendaCausali[i].xColore)
            else
              A042FStampaGrafico.Series4.AddGanttColor(strtodatetime(sDaData + ' 08.00.00'), strtodatetime(sDaData + ' 16.00.00'), i+1, aPb_LegendaCausali[i].sCodice,aPb_LegendaCausali[i].xColore);
        A042FStampaGrafico.Series4.AddGanttColor(0, 0, i+1, ' ',clWhite);  //Inserisco la prima causale bianca per creare lo spazio in alto
        //Fine causali...
        nElementi:=nElementi - 24;

        if (Trim(A042FDialogStampa.DocumentoPDF) <> '') and (Trim(A042FDialogStampa.DocumentoPDF) <> '<VUOTO>') and (Trim(A042FDialogStampa.TipoModulo) = 'COM')then
        begin
          A042FStampaGrafico.Prepare;
          MF:=A042FStampaGrafico.QRPrinter.GetPage(1);
          try
            Pdf.DefaultPageWidth := MulDiv(MF.Width,72,Pdf.ScreenLogPixels);
            Pdf.DefaultPageHeight := MulDiv(MF.Height,72,Pdf.ScreenLogPixels);
            Pdf.AddPage;
            // draw the page content
            Pdf.Canvas.RenderMetaFile(MF,1,0,0);
          finally
            MF.Free;
          end;
        end
        else
          A042FStampaGrafico.Print;
      end;
      if nElementi > 0 then
      begin

        //Ripulisco le serie
        A042FStampaGrafico.QRChart1.Chart.Series[0].Clear;
        A042FStampaGrafico.QRChart1.Chart.Series[1].Clear;
        A042FStampaGrafico.QRChart1.Chart.Series[2].Clear;
        A042FStampaGrafico.QRLegenda.Chart.Series[0].Clear;

        nPagina:=nPagina+1;
        A042FStampaGrafico.QRLblPagina.Caption:='PAGINA ' + inttostr(nPagina);
        for i:=1 to nElementi do
        begin
          nElementoCorrente:=nElementoCorrente+1;
          //Inserisco il dipendente in ogni caso...
          A042FStampaGrafico.Series1.AddGanttColor(0, 0, i, aPb_DatiDipendentiGiustI[nElementoCorrente].sDescrizione, clwhite);
          //Inserisco i dati del dipendente nella prima serie
          for n:=1 to length(aPb_DatiDipendentiGiustI[nElementoCorrente].aDatiDipendente)-1 do
            if not bPb_MostraCausaliNonAbbinate then
            begin
              if aPb_DatiDipendentiGiustI[nElementoCorrente].aDatiDipendente[n].xColore <> clWhite then  //mostro la causale soltanto se non è bianca...
                A042FStampaGrafico.Series1.AddGanttColor(aPb_DatiDipendentiGiustI[nElementoCorrente].aDatiDipendente[n].dDataDa, aPb_DatiDipendentiGiustI[nElementoCorrente].aDatiDipendente[n].dDataA, i,aPb_DatiDipendentiGiustI[nElementoCorrente].sDescrizione, aPb_DatiDipendentiGiustI[nElementoCorrente].aDatiDipendente[n].xColore);
            end
            else  //altrimenti la mostro comunque
              A042FStampaGrafico.Series1.AddGanttColor(aPb_DatiDipendentiGiustI[nElementoCorrente].aDatiDipendente[n].dDataDa, aPb_DatiDipendentiGiustI[nElementoCorrente].aDatiDipendente[n].dDataA, i, aPb_DatiDipendentiGiustI[nElementoCorrente].sDescrizione, aPb_DatiDipendentiGiustI[nElementoCorrente].aDatiDipendente[n].xColore);
          //Inserisco i dati del dipendente nella seconda serie
          for n:=1 to length(aPb_DatiDipendentiGiustM[nElementoCorrente].aDatiDipendente)-1 do
            if not bPb_MostraCausaliNonAbbinate then
            begin
              if aPb_DatiDipendentiGiustM[nElementoCorrente].aDatiDipendente[n].xColore <> clWhite then  //mostro la causale soltanto se non è bianca...
                A042FStampaGrafico.Series2.AddGanttColor(aPb_DatiDipendentiGiustM[nElementoCorrente].aDatiDipendente[n].dDataDa, aPb_DatiDipendentiGiustM[nElementoCorrente].aDatiDipendente[n].dDataA, i, aPb_DatiDipendentiGiustM[nElementoCorrente].sDescrizione, aPb_DatiDipendentiGiustM[nElementoCorrente].aDatiDipendente[n].xColore);
            end
            else  //altrimenti la mostro comunque
              A042FStampaGrafico.Series2.AddGanttColor(aPb_DatiDipendentiGiustM[nElementoCorrente].aDatiDipendente[n].dDataDa, aPb_DatiDipendentiGiustM[nElementoCorrente].aDatiDipendente[n].dDataA, i, aPb_DatiDipendentiGiustM[nElementoCorrente].sDescrizione, aPb_DatiDipendentiGiustM[nElementoCorrente].aDatiDipendente[n].xColore);

          for n:=1 to length(aPb_DatiDipendentiTimbGiusH[nElementoCorrente].aDatiDipendente)-1 do
            if not bPb_MostraCausaliNonAbbinate then
            begin
              if aPb_DatiDipendentiTimbGiusH[nElementoCorrente].aDatiDipendente[n].xColore <> clWhite then  //mostro la causale soltanto se non è bianca...
                A042FStampaGrafico.Series3.AddGanttColor(aPb_DatiDipendentiTimbGiusH[nElementoCorrente].aDatiDipendente[n].dDataDa, aPb_DatiDipendentiTimbGiusH[nElementoCorrente].aDatiDipendente[n].dDataA, i, aPb_DatiDipendentiTimbGiusH[nElementoCorrente].sDescrizione, aPb_DatiDipendentiTimbGiusH[nElementoCorrente].aDatiDipendente[n].xColore);
            end
            else  //altrimenti la mostro comunque
              A042FStampaGrafico.Series3.AddGanttColor(aPb_DatiDipendentiTimbGiusH[nElementoCorrente].aDatiDipendente[n].dDataDa, aPb_DatiDipendentiTimbGiusH[nElementoCorrente].aDatiDipendente[n].dDataA, i, aPb_DatiDipendentiTimbGiusH[nElementoCorrente].sDescrizione, aPb_DatiDipendentiTimbGiusH[nElementoCorrente].aDatiDipendente[n].xColore);
        end;
        //Compilo infine la legenda delle causali...
        A042FStampaGrafico.Series4.AddGanttColor(0, 0, 0, ' ',clWhite);
        n:=0;
        for i:=0 to length(aPb_LegendaCausali)-1 do
          if not bPb_MostraCausaliNonAbbinate then
          begin
            if aPb_LegendaCausali[i].xColore <> clWhite then  //mostro la causale soltanto se non è bianca...
            begin
              n:=n+1;
              if aPb_LegendaCausali[i].sCodice =cPb_CodiceOreNonCausalizzate then
                A042FStampaGrafico.Series4.AddGanttColor(strtodatetime(sDaData + ' 08.00.00'), strtodatetime(sDaData + ' 16.00.00'), n, 'Ore n.c.',aPb_LegendaCausali[i].xColore)
              else
                A042FStampaGrafico.Series4.AddGanttColor(strtodatetime(sDaData + ' 08.00.00'), strtodatetime(sDaData + ' 16.00.00'), n, aPb_LegendaCausali[i].sCodice,aPb_LegendaCausali[i].xColore);
            end;
          end
          else
            if aPb_LegendaCausali[i].sCodice =cPb_CodiceOreNonCausalizzate then
              A042FStampaGrafico.Series4.AddGanttColor(strtodatetime(sDaData + ' 08.00.00'), strtodatetime(sDaData + ' 16.00.00'), i+1, 'Ore n.c.',aPb_LegendaCausali[i].xColore)
            else
              A042FStampaGrafico.Series4.AddGanttColor(strtodatetime(sDaData + ' 08.00.00'), strtodatetime(sDaData + ' 16.00.00'), i+1, aPb_LegendaCausali[i].sCodice,aPb_LegendaCausali[i].xColore);
        A042FStampaGrafico.Series4.AddGanttColor(0, 0, i+1, ' ',clWhite);  //Inserisco la prima causale bianca per creare lo spazio in alto
        //Fine causali...

        if (Trim(A042FDialogStampa.DocumentoPDF) <> '') and (Trim(A042FDialogStampa.DocumentoPDF) <> '<VUOTO>') and (Trim(A042FDialogStampa.TipoModulo) = 'COM')then
        begin
          A042FStampaGrafico.Prepare;
          MF:=A042FStampaGrafico.QRPrinter.GetPage(1);
          try
            Pdf.DefaultPageWidth := MulDiv(MF.Width,72,Pdf.ScreenLogPixels);
            Pdf.DefaultPageHeight := MulDiv(MF.Height,72,Pdf.ScreenLogPixels);
            Pdf.AddPage;
            Pdf.Canvas.RenderMetaFile(MF,1,0,0);
          finally
            MF.Free;
          end;
        end
        else
          A042FStampaGrafico.Print;
      end;
    end;
    if (Trim(A042FDialogStampa.DocumentoPDF) <> '') and (Trim(A042FDialogStampa.DocumentoPDF) <> '<VUOTO>') and (Trim(A042FDialogStampa.TipoModulo) = 'COM')then
      Pdf.SaveToFile(A042FDialogStampa.DocumentoPDF);
  finally
    Pdf.free;
  end;
  A042FStampaGrafico.Page.Orientation:=MyOrientation;
  //*)
end;

procedure TA042FGrafico.BtnPrinterSetUpClick(Sender: TObject);
begin
  A042FDialogStampa.PrinterSetupDialog1.Execute
end;

procedure TA042FGrafico.ChkLineeVerticaliClick(Sender: TObject);
begin
  Chart1.BottomAxis.Grid.Visible:=ChkLineeVerticali.Checked;
  A042FStampaGrafico.QRChart1.Chart.BottomAxis.Grid.Visible:=ChkLineeVerticali.Checked;
end;

procedure TA042FGrafico.ChkLineeOrizzontaliClick(Sender: TObject);
begin
  Chart1.LeftAxis.Grid.Visible:=ChkLineeOrizzontali.Checked;
  A042FStampaGrafico.QRChart1.Chart.LeftAxis.Grid.Visible:=ChkLineeOrizzontali.Checked;
end;

procedure TA042FGrafico.edtIntestazioneChange(Sender: TObject);
begin
  LblIntestazione.Caption:=edtIntestazione.Text;
end;

procedure TA042FGrafico.FormActivate(Sender: TObject);
begin
  LblIntestazione.Caption:='';
  edtIntestazione.Text:='';
  LblAzienda.Caption:=Parametri.RagioneSociale;
end;

end.
