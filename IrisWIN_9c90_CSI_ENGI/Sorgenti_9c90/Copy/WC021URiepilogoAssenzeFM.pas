unit WC021URiepilogoAssenzeFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, WR010UBase,
  IWCompButton, meIWButton, IWCompMemo, meIWMemo, IWCompGrids, meIWGrid,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb,R600, meIWRegion, medpIWTabControl,
  A000UInterfaccia, medpIWMessageDlg, StrUtils, DateUtils;

type
  TWC021FProceduraVisualizza = procedure of object;
  TWC021RiepilogoModalResultEvents = procedure(Sender: TObject; Result: Boolean) of object;

  TWC021FRiepilogoAssenzeFM = class(TWR200FBaseFM)
    btnChiudi: TmeIWButton;
    grdTabDetail: TmedpIWTabControl;
    WC021RiepilogoRG: TmeIWRegion;
    lblEtichettaMatricola: TmeIWLabel;
    lblEtichettaCausale: TmeIWLabel;
    lblMatricola: TmeIWLabel;
    lblNome: TmeIWLabel;
    lblCausale: TmeIWLabel;
    lblEtichettaDataFamRif: TmeIWLabel;
    lblEtichettaPeriodoCumulo: TmeIWLabel;
    lblEtichettaNumeroFruizioni: TmeIWLabel;
    lblDataFamRif: TmeIWLabel;
    lblPeriodoCumulo: TmeIWLabel;
    lblNumeroFruizioni: TmeIWLabel;
    lblEtichettaPeriodiRapporto: TmeIWLabel;
    lblEtichettaCompArrotondata: TmeIWLabel;
    lblEtichettaCompTotale: TmeIWLabel;
    lblEtichettaCompSoloFerie: TmeIWLabel;
    lblEtichettaPartTime: TmeIWLabel;
    lblEtichettaAbilAnagr: TmeIWLabel;
    lblEtichettaDecurtazione: TmeIWLabel;
    lblEtichettaFruizMMContinuativi: TmeIWLabel;
    lblMaxIndividuale: TmeIWLabel;
    lblCompTotale: TmeIWLabel;
    lblPeriodiRapporto: TmeIWLabel;
    lblCompArrotondata: TmeIWLabel;
    lblCompSoloFerie: TmeIWLabel;
    lblPartTime: TmeIWLabel;
    lblAbilAnagr: TmeIWLabel;
    lblDecurtazione: TmeIWLabel;
    lblEtichettaFruizMMInteri: TmeIWLabel;
    lblFruizMMInteri: TmeIWLabel;
    lblFruizMMContinuativi: TmeIWLabel;
    lblEtichettaMaxIndividuale: TmeIWLabel;
    lblCompFinale: TmeIWLabel;
    lblEtichettaCompFinale: TmeIWLabel;
    lblEtichettaPartTimeApplicato: TmeIWLabel;
    lblPartTimeApplicato: TmeIWLabel;
    lblFruizMinima: TmeIWLabel;
    lblEtichettaFruizMinima: TmeIWLabel;
    lblRaggruppamento: TmeIWLabel;
    grdRiepilogo: TmeIWGrid;
    lblEtichettaNome: TmeIWLabel;
    TemplateRiepilogoRG: TIWTemplateProcessorHTML;
    WC021AssenzeCumulateRG: TmeIWRegion;
    grdAssenzeCumulate: TmeIWGrid;
    TemplateAssenzeRG: TIWTemplateProcessorHTML;
    WC021PeriodiCumulatiRG: TmeIWRegion;
    grdPeriodiCumulati: TmeIWGrid;
    TemplatePeriodiRG: TIWTemplateProcessorHTML;
    btnCambiaFineCumulo: TmeIWButton;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdRiepilogoRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure grdCumuloRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure btnCambiaFineCumuloClick(Sender: TObject);
  private
    R600DtM1: TR600DtM1;
    RowFruitoCorrente: Integer;
    FProgressivo: Integer;
    FDataRiepilogo, FDataNas, FC, FCI: TDateTime;
    Giustif: TGiustificativo;
    procedure IntestazioneGrdRiepilogo(UMisura: String);
    procedure CaricaDatiAssenzeCumulate;
    procedure CaricaDatiPeriodiCumulati;
    procedure ImpostaComponenti(PAbilitaModificaFineCumulo: Boolean;
      PFineCumuloAlternativa: TDateTime);
  public
    ResultEvent: TWC021RiepilogoModalResultEvents;
    VisualizzaFrame: TWC021FProceduraVisualizza;
    procedure CaricaDati(Prog: Integer; Causale: String; DataOperazione,DataNas: TDateTime);
  end;

implementation

{$R *.dfm}
procedure TWC021FRiepilogoAssenzeFM.grdCumuloRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  inherited;
  if not C190RenderCell (ACell,ARow,AColumn,True,True,False) then
    Exit;
end;

procedure TWC021FRiepilogoAssenzeFM.grdRiepilogoRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  if not C190RenderCell (ACell,ARow,AColumn,True,True,False) then
    Exit;

  //Se Fruito A.C. < Fruiz.Anno Minima allora coloro in blu la riga del Fruito A.C.
  if ARow = RowFruitoCorrente then  //Riga Fruito A.C.
  begin
    if R600Dtm1.UMisura = 'G' then  //Giorni
    begin
      if StrToFloatDef(grdRiepilogo.Cell[RowFruitoCorrente,7].Text,0) < StrToFloatDef(R600Dtm1.RiepilogoAssenze[0].FruizMinimaAC,0) then
        ACell.css:=ACell.css + ' font_blu';
    end
    else  //Ore
    begin
      if R180OreMinutiExt(grdRiepilogo.Cell[RowFruitoCorrente,7].Text) < R180OreMinutiExt(R600Dtm1.RiepilogoAssenze[0].FruizMinimaAC) then
        ACell.css:=ACell.css + ' font_blu';
    end;
  end;

  //Se Negativo allora coloro in rosso la cella
  if Pos('-',ACell.Text) > 0 then
    ACell.css:=ACell.css + ' font_rossoImp';
end;

procedure TWC021FRiepilogoAssenzeFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  R600DtM1:=TR600DtM1.Create(Self);
  grdTabDetail.AggiungiTab('Riepilogo',WC021RiepilogoRG);
end;

procedure TWC021FRiepilogoAssenzeFM.CaricaDati(Prog:Integer; Causale: String; DataOperazione,DataNas: TDateTime);
begin
  Giustif.Inserimento:=False;
  Giustif.Modo:='I';
  Giustif.Causale:=Causale;

  with R600DtM1 do
  begin
    RiferimentoDataNascita.Data:=DataNas;
    GetIDFamiliare(Prog); // csi
    LetturaAssenze:=True;
    Visualizza:=True;
    SetLength(PeriodiCumulati,0);
    SetLength(RiepilogoAssenze,0);
    //salvo in parametri per poter fare cambio data fine cumulo
    FProgressivo:=Prog;
    FDataRiepilogo:=DataOperazione;
    FDataNas:=DataNas;
    RiepilogaAssenze(FProgressivo,FDataRiepilogo,Giustif,False,RiferimentoDataNascita{FDataNas}); // csi
    FC:=FineCumulo;
    FCI:=FineCumuloIntero;

    if RiepilogoAssenze[0].Messaggio = '' then
    begin
      //carica i dati della R600 sui compoenti grafici
      ImpostaComponenti(((TipoCumulo <> 'H') and (FCI > FC)),FCI);
      if Length(AssenzeCumulateOrdData) > 0 then
      begin
        CaricaDatiAssenzeCumulate;
        CaricaDatiPeriodiCumulati;
      end
      else
      begin
        WC021AssenzeCumulateRG.Visible:=False;
        WC021PeriodiCumulatiRG.Visible:=False;
      end;
      grdTabDetail.ActiveTab:=WC021RiepilogoRG;
    end
    else
    begin
      MsgBox.WebMessageDlg(RiepilogoAssenze[0].Messaggio,mtError,[mbOk],nil,'');
      btnChiudiClick(nil);
      Exit;
    end;

    LetturaAssenze:=False;
    Visualizza:=False;
  end;
  if Assigned(VisualizzaFrame) then
    VisualizzaFrame;
end;

procedure TWC021FRiepilogoAssenzeFM.CaricaDatiPeriodiCumulati;
var Row, i: Integer;
begin
  with grdPeriodiCumulati do
  begin
    ColumnCount:=4;
    RowCount:=Length(R600DtM1.PeriodiCumulati) + 1;
    Row:=0;
    Cell[Row,0].Text:='Dal';
    Cell[Row,1].Text:='Al';
    Cell[Row,2].Text:='Causali';
    Cell[Row,3].Text:='Coniuge';

    for i:=0 to High(R600DtM1.PeriodiCumulati) do
    begin
      inc(Row);
      Cell[Row,0].Text:=DateToStr(R600DtM1.PeriodiCumulati[i].Dal);
      Cell[Row,1].Text:=DateToStr(R600DtM1.PeriodiCumulati[i].Al);
      Cell[Row,2].Text:=R600DtM1.PeriodiCumulati[i].Causali;
      Cell[Row,3].Text:=IfThen(R600DtM1.PeriodiCumulati[i].Coniuge,'SI','');
    end;
  end;
  grdTabDetail.AggiungiTab('Periodi cumulati',WC021PeriodiCumulatiRG);
end;

procedure TWC021FRiepilogoAssenzeFM.CaricaDatiAssenzeCumulate;
var
  Row, i: Integer;
  OreConteggiateTot:Integer;
begin
  with grdAssenzeCumulate do
  begin
    ColumnCount:=7;
    RowCount:=1;
    Row:=0;
    Cell[Row,0].Text:='Data';
    Cell[Row,1].Text:='Causale';
    Cell[Row,2].Text:='Tipo';
    Cell[Row,3].Text:='Ore';
    Cell[Row,4].Text:='Valore';
    Cell[Row,5].Text:='Coniuge';
    Cell[Row,6].Text:='Richiesta web';

    for i:=0 to High(R600DtM1.AssenzeCumulateOrdData) do
    begin
      if R600DtM1.AssenzeCumulateOrdData[i].DaVisualizzare then
      begin
        inc(Row);
        grdAssenzeCumulate.RowCount:=grdAssenzeCumulate.RowCount + 1;
        Cell[Row,0].Text:=R600DtM1.AssenzeCumulateOrdData[i].Data;
        Cell[Row,1].Text:=R600DtM1.AssenzeCumulateOrdData[i].Causale;
        Cell[Row,2].Text:=R600DtM1.AssenzeCumulateOrdData[i].Tipo;
        Cell[Row,3].Text:=R600DtM1.AssenzeCumulateOrdData[i].Ore;
        Cell[Row,4].Text:=R600DtM1.AssenzeCumulateOrdData[i].OreConteggiate;
        OreConteggiateTot:=OreConteggiateTot + R180OreMinuti(R600DtM1.AssenzeCumulateOrdData[i].OreConteggiate);
        Cell[Row,5].Text:=IfThen(R600DtM1.AssenzeCumulateOrdData[i].Coniuge,'SI','');
        Cell[Row,6].Text:=IfThen(R600DtM1.AssenzeCumulateOrdData[i].RichiestaWeb,'SI','');
      end;
    end;
    //Aggiungo riga per totale OreConteggiate
    inc(Row);
    grdAssenzeCumulate.RowCount:=grdAssenzeCumulate.RowCount + 1;
    Cell[Row,0].Text:='Totale';
    Cell[Row,4].Text:=R180MinutiOre(OreConteggiateTot);
  end;
  grdTabDetail.AggiungiTab('Assenze cumulate',WC021AssenzeCumulateRG);
end;

procedure TWC021FRiepilogoAssenzeFM.ImpostaComponenti(PAbilitaModificaFineCumulo: Boolean; PFineCumuloAlternativa: TDateTime);
var VisFamRif, TotaleGiorni, ColonnaZero: boolean;
  i,j, Row: Integer;
  CssInvisible: String;
begin
  with R600DtM1 do
  begin
    lblMatricola.Caption:=RiepilogoAssenze[0].Matricola;
    lblNome.Caption:=RiepilogoAssenze[0].Nominativo;
    lblCausale.Caption:=Giustificativo.Causale + ' - ' + Giustificativo.Raggruppamento;
    lblPeriodoCumulo.Caption:=RiepilogoAssenze[0].PeriodoCumulo;//DescrizionePeriodoCumulo;
    VisFamRif:=RiepilogoAssenze[0].VisFamRif;//(R180CarattereDef(Q265.FieldByName('Cumulo_familiari').AsString,1,'N') in ['S','D']) or (R180CarattereDef(Q265.FieldByName('Fruizione_Familiari').AsString,1,'N') in ['S','D']);
    lblEtichettaDataFamRif.Visible:=VisFamRif;
    lblDataFamRif.Visible:=VisFamRif;
    if VisFamRif then
    lblDataFamRif.Caption:=RiepilogoAssenze[0].Familiare;//DateToStr(RiferimentoDataNascita.Data);
    // numero di periodi
    lblNumeroFruizioni.Caption:=IntToStr(RiepilogoAssenze[0].NumPeriodi);
    lblRaggruppamento.Caption:='Profilo assenze: ' + RiepilogoAssenze[0].ProfiloAssenze;//DescrizioneProfiloAssenze;
    // comptenza totale
    lblCompTotale.Caption:=RiepilogoAssenze[0].CompLordeAC;//R180GiorniOreToStr(CompTotali + IfThen(ProfiloAssenze <> '',VariazionePartTime),UMisura,'%3.2f');
    // variazioni alle competenze lorde
    lblPeriodiRapporto.Caption:=RiepilogoAssenze[0].VarPeriodiRapporto;//R180GiorniOreToStr(-VariazionePeriodiRapporto,UMisura,'%3.2f');
    lblCompArrotondata.Caption:=RiepilogoAssenze[0].AbbattiAssCess;//R180GiorniOreToStr(-CompArrotondate,UMisura,'%3.2f');
    lblCompSoloFerie.Caption:=RiepilogoAssenze[0].DecurtazNonMatura;//R180GiorniOreToStr(-CompSoloFerie,UMisura,'%3.2f');
    lblPartTime.Caption:=RiepilogoAssenze[0].VarPartTime;//R180GiorniOreToStr(-VariazionePartTime,UMisura,'%3.2f');
    lblAbilAnagr.Caption:=RiepilogoAssenze[0].VarAbilitazioneAnagrafica;//R180GiorniOreToStr(-VariazioneAbilitazioneAnagrafica,UMisura,'%3.2f');
    lblDecurtazione.Caption:=RiepilogoAssenze[0].VarCompManuale;//R180GiorniOreToStr(VariazioneCompetenzeF,UMisura,'%3.2f');
    IF TipoCumulo = 'F' then
    begin
      // AOSTA_REGIONE - commessa 2012/152.ini
      lblFruizMMInteri.Caption:=RiepilogoAssenze[0].VarFruizMMInteri;//R180GiorniOreToStr(VariazioneFruizMMInteri,UMisura,'%3.2f');
      lblMaxIndividuale.Caption:=RiepilogoAssenze[0].VarMaxIndividuale;//R180GiorniOreToStr(VariazioneMaxIndividuale,UMisura,'%3.2f');
      lblFruizMMContinuativi.Caption:=RiepilogoAssenze[0].VarFruizMMContinuativi;//R180GiorniOreToStr(VariazioneFruizMMContinuativi,UMisura,'%3.2f');
      // AOSTA_REGIONE - commessa 2012/152.fine
    end
    else
    begin
      CssInvisible:='invisibile';
      lblEtichettaFruizMMInteri.Css:=CssInvisible;
      lblFruizMMInteri.Css:=CssInvisible;
      lblEtichettaMaxIndividuale.Css:=CssInvisible;
      lblMaxIndividuale.Css:=CssInvisible;
      lblEtichettaFruizMMContinuativi.Css:=CssInvisible;
      lblFruizMMContinuativi.Css:=CssInvisible;
    end;
    // competenza finale = netta
    lblCompFinale.Caption:=RiepilogoAssenze[0].CompNetteAC;//R180GiorniOreToStr(CompTotali + IfThen(ProfiloAssenze <> '',VariazionePartTime) - VariazionePeriodiRapporto - CompArrotondate - CompSoloFerie - VariazionePartTime - VariazioneAbilitazioneAnagrafica + VariazioneCompetenzeF + VariazioneFruizMMInteri + VariazioneMaxIndividuale + VariazioneFruizMMContinuativi,UMisura,'%3.2f');

    // Lorena 29/12/2005: modifiche per nuova gestione profili assenze con Fruizione Minima A.C.
    lblEtichettaFruizMinima.Caption:=RiepilogoAssenze[0].TitoloFruizMinimaAC;//TitoloFruizioneMinimaAC;
    lblFruizMinima.Caption:=RiepilogoAssenze[0].FruizMinimaAC;//R180GiorniOreToStr(FruizMinimaAC,UMisura,'%3.2f');
    //Part-time
    lblPartTimeApplicato.Text:=RiepilogoAssenze[0].PartTime;//ElencoProfPartTime;
    IntestazioneGrdRiepilogo(UMisura);
    //Galliera: visualizzazione assenze ad ore in giorni!!!
    TotaleGiorni:=True;
    if (UMisura = 'G') or (ValenzaGiornaliera = 0) then
    begin
      TotaleGiorni:=False;
      grdRiepilogo.ColumnCount:=8;
    end;

    for i:=1 to 6 do
    begin
      Row:=1;
      //1
      if RiepilogoAssenze[0].Residuabile then
      begin
        grdRiepilogo.Cell[Row,i].Text:=R180GiorniOreToStr(ResiduiVal[i],UMisura);
        if i = 1 then
        begin
          grdRiepilogo.Cell[Row,0].Text:='Comp. precedente';
          //Totale
          grdRiepilogo.Cell[Row,7].Text:=RiepilogoAssenze[0].CP;//R180GiorniOreToStr(T1,UMisura);
          if TotaleGiorni and RiepilogoAssenze[0].EsisteResiduo then
            grdRiepilogo.Cell[Row,8].Text:=RiepilogoAssenze[0].H_CP;//Format('%3.2f',[TrasformaOre2Giorni(T1)]);//Format('%3.2f',[T1/ValenzaGiornaliera]);
        end;
        inc(Row);
      end;
      //2
      grdRiepilogo.Cell[Row,i].Text:=R180GiorniOreToStr(VisCompetenzeAC[i],UMisura);
      if i = 1 then
      begin
        grdRiepilogo.Cell[Row,0].Text:='Comp. corrente';
        //Totale
        grdRiepilogo.Cell[Row,7].Text:=RiepilogoAssenze[0].CC;//R180GiorniOreToStr(T2,UMisura);
        if TotaleGiorni then
          grdRiepilogo.Cell[Row,8].Text:=RiepilogoAssenze[0].H_CC;//Format('%3.2f',[TrasformaOre2Giorni(T2)]);//Format('%3.2f',[T2/ValenzaGiornaliera]);
      end;
      inc(Row);
      //3
      if RiepilogoAssenze[0].Residuabile then
      begin
        grdRiepilogo.Cell[Row,i].Text:=R180GiorniOreToStr(VisFruitoAP[i],UMisura);
        if i = 1 then
        begin
          grdRiepilogo.Cell[Row,0].Text:='Fruito precedente';
          //totale
          grdRiepilogo.Cell[Row,7].Text:=RiepilogoAssenze[0].FP;//R180GiorniOreToStr(T3,UMisura);
          if TotaleGiorni and RiepilogoAssenze[0].EsisteResiduo then
            grdRiepilogo.Cell[Row,8].Text:=RiepilogoAssenze[0].H_FP;//Format('%3.2f',[TrasformaOre2Giorni(T3)]);//Format('%3.2f',[T3/ValenzaGiornaliera]);
        end;
        inc(Row);
      end;
      //4
      RowFruitoCorrente:=Row;
      grdRiepilogo.Cell[Row,i].Text:=R180GiorniOreToStr(VisFruitoAC[i],UMisura);
      if i = 1 then
      begin
        grdRiepilogo.Cell[Row,0].Text:='Fruito corrente';
        //totale
        grdRiepilogo.Cell[Row,7].Text:=RiepilogoAssenze[0].FC;//R180GiorniOreToStr(T4,UMisura);
        if TotaleGiorni then
          grdRiepilogo.Cell[Row,8].Text:=RiepilogoAssenze[0].H_FC;//Format('%3.2f',[TrasformaOre2Giorni(T4)]);//Format('%3.2f',[T4/ValenzaGiornaliera]);
      end;
      inc(Row);
      //5
      if RiepilogoAssenze[0].Residuabile then
      begin
        grdRiepilogo.Cell[Row,i].Text:=R180GiorniOreToStr(ResiduiVal[i] - VisFruitoAP[i],UMisura);
        if i = 1 then
        begin
          grdRiepilogo.Cell[Row,0].Text:='Residuo precedente';   //Lorena 29/12/2005
          //totale
          grdRiepilogo.Cell[Row,7].Text:=RiepilogoAssenze[0].RP;//R180GiorniOreToStr(T5,UMisura);
          if TotaleGiorni and RiepilogoAssenze[0].EsisteResiduo then
            grdRiepilogo.Cell[Row,8].Text:=RiepilogoAssenze[0].H_RP//Format('%3.2f',[TrasformaOre2Giorni(T5)]);//Format('%3.2f',[T5/ValenzaGiornaliera]);  //Lorena 29/12/2005
        end;
        inc(Row);
      end;
      //6
      grdRiepilogo.Cell[Row,i].Text:=R180GiorniOreToStr(VisCompetenzeAC[i] - VisFruitoAC[i],UMisura);
      if i = 1 then
      begin
        grdRiepilogo.Cell[Row,0].Text:='Residuo corrente';     //Lorena 29/12/2005
        //totale
        grdRiepilogo.Cell[Row,7].Text:=RiepilogoAssenze[0].RC;//R180GiorniOreToStr(T6,UMisura);
        if TotaleGiorni then
          grdRiepilogo.Cell[Row,8].Text:=RiepilogoAssenze[0].H_RC;//Format('%3.2f',[TrasformaOre2Giorni(T6)]);//Format('%3.2f',[T6/ValenzaGiornaliera]);    //Lorena 29/12/2005
      end;
      inc(Row);
      //7
      if RiepilogoAssenze[0].Residuabile then
      begin
        grdRiepilogo.Cell[Row,i].Text:=R180GiorniOreToStr(Competenze[i],UMisura);
        if i = 1 then
        begin
          grdRiepilogo.Cell[Row,0].Text:='Residuo totale';       //Lorena 29/12/2005
          //totale
          grdRiepilogo.Cell[Row,7].Text:=RiepilogoAssenze[0].R;//R180GiorniOreToStr(T7,UMisura);
          if TotaleGiorni then
            grdRiepilogo.Cell[Row,8].Text:=RiepilogoAssenze[0].H_R;//Format('%3.2f',[TrasformaOre2Giorni(T7)]);//Format('%3.2f',[T7/ValenzaGiornaliera]);    //Lorena 29/12/2005
        end;
        Inc(Row);
      end;
      //Vis.comp.parziali se esiste profilo assenze               // Lorena 29/12/2005
      if RiepilogoAssenze[0].CompAnnoSolare then
      begin
        //8
        grdRiepilogo.Cell[Row,i].Text:=R180GiorniOreToStr(CompetenzeParziali[i],UMisura);
        if i = 1 then
        begin
          grdRiepilogo.Cell[Row,0].Text:='Comp. parziali';
          //totale
          grdRiepilogo.Cell[Row,7].Text:=RiepilogoAssenze[0].CParz;//R180GiorniOreToStr(T8,UMisura);
        end;
        inc(Row);
        //9
        grdRiepilogo.Cell[Row,i].Text:=R180GiorniOreToStr(CompetenzeParziali[i] - VisFruitoAC[i],UMisura);
        if i = 1 then
        begin
          grdRiepilogo.Cell[Row,0].Text:='Residuo parziale';
          //totale
          grdRiepilogo.Cell[Row,7].Text:=RiepilogoAssenze[0].RParz;//R180GiorniOreToStr(T9,UMisura);
        end;
        inc(Row);
      end;
    end;
    grdRiepilogo.RowCount:=Row;
    //Alberto 15/02/2006
    for j:=1 to grdRiepilogo.ColumnCount - 1 do
    begin
      ColonnaZero:=True;
      for i:=1 to grdRiepilogo.RowCount - 1 do
      begin
        if (Trim(grdRiepilogo.Cell[i,j].Text) <> '') and (Trim(grdRiepilogo.Cell[i,j].Text) <> '0') and (Trim(grdRiepilogo.Cell[i,j].Text) <> '00.00') then
        begin
          ColonnaZero:=False;
          Break;
        end;
      end;
      if ColonnaZero then
      begin
        for i:=1 to grdRiepilogo.RowCount - 1 do
          grdRiepilogo.Cell[i,j].Text:='';
      end;
    end;

    btnCambiaFineCumulo.Visible:=PAbilitaModificaFineCumulo;
    btnCambiaFineCumulo.Caption:='Visualizza riepilogo al ' + DateToStr(PFineCumuloAlternativa);
  end;
end;

procedure TWC021FRiepilogoAssenzeFM.IntestazioneGrdRiepilogo(UMisura: String);
begin
  with grdRiepilogo do
  begin
    RowCount:=1;
    RowCount:=10;//Valore massimo poi ridotto in base alle condizioni
    ColumnCount:=9; //Valore massimo poi ridotto in base alle condizioni
    if UMisura = 'G' then
      Cell[0,0].Text:='U.M.: Giorni'
    else
      Cell[0,0].Text:='U.M.: Ore';
    Cell[0,1].Text:='1°fascia';
    Cell[0,2].Text:='2°fascia';
    Cell[0,3].Text:='3°fascia';
    Cell[0,4].Text:='4°fascia';
    Cell[0,5].Text:='5°fascia';
    Cell[0,6].Text:='6°fascia';
    Cell[0,7].Text:='Totali';
    Cell[0,8].Text:='Totali(G)';
  end;
end;

procedure TWC021FRiepilogoAssenzeFM.btnCambiaFineCumuloClick(Sender: TObject);
var SaveDataRiepilogo: TDateTime;
begin
  inherited;
  with R600Dtm1 do
  begin
    SaveDataRiepilogo:=FDataRiepilogo;
    if FDataRiepilogo = FC then
      FDataRiepilogo:=FCI
    else
      FDataRiepilogo:=FC;
    SetLength(RiepilogoAssenze,0);
    // csi.ini
    RiferimentoDataNascita.Data:=FDataNas;
    GetIDFamiliare(FProgressivo);
    // csi.fine
    RiepilogaAssenze(FProgressivo,FDataRiepilogo,Giustif,False,RiferimentoDataNascita{FDataNas}); // csi

    ImpostaComponenti(True,SaveDataRiepilogo);
  end;
end;

procedure TWC021FRiepilogoAssenzeFM.btnChiudiClick(Sender: TObject);
begin
  if assigned(ResultEvent) then
    ResultEvent(Self,False);

  FreeAndNil(R600DtM1);
  ReleaseOggetti;
  Free;
end;

end.
