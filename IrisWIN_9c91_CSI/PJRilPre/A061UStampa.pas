unit A061UStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StrUtils, DB, StdCtrls, quickrpt, ExtCtrls, Qrctrls, QRPDFFilt,
  C180FunzioniGenerali, A000UCostanti, A000USessione,A000UInterfaccia, QRExport, Variants,
  QRWebFilt, Generics.Collections;

type
  TA061FStampa = class(TForm)
    RepR: TQuickRep;
    QRFoot2: TQRBand;
    QRLabel3: TQRLabel;
    QRMemo1: TQRMemo;
    QRFoot1: TQRBand;
    QRLabel4: TQRLabel;
    QRMemo2: TQRMemo;
    SummaryBand1: TQRBand;
    QRLabel5: TQRLabel;
    QRMemo3: TQRMemo;
    QRBand1: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    DRiduzioni: TQRLabel;
    QRDBText7: TQRDBText;
    QRBTitolo: TQRBand;
    QRLEnte: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLTitolo: TQRLabel;
    QRGroup1: TQRGroup;
    QRGroup2: TQRGroup;
    ChildBand1: TQRChildBand;
    QRLRaggruppamento: TQRLabel;
    QRDBTGruppo: TQRDBText;
    lblBadge: TQRLabel;
    lblMatricola: TQRLabel;
    dlblCognome: TQRDBText;
    dlblBadge: TQRDBText;
    dlblMatricola: TQRDBText;
    QRLabel17: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel11: TQRLabel;
    QRDBText8: TQRDBText;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    bndLegendaFamiliari: TQRChildBand;
    QRLabel1: TQRLabel;
    qrdbtxtMinutiCont: TQRDBText;
    qrlblMinutiCont: TQRLabel;
    qrdbtxtInizio: TQRDBText;
    qrlblInizio: TQRLabel;
    qrlblFine: TQRLabel;
    qrdbtxtFine: TQRDBText;
    procedure RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure QRDBText5Print(sender: TObject; var Value: String);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRFoot2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRFoot1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRFoot2AfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
    procedure QRFoot1AfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
    procedure RepRAfterPrint(Sender: TObject);
    procedure RepRAfterPreview(Sender: TObject);
    procedure QRLabel13Print(sender: TObject; var Value: String);
    procedure QRBTitoloBeforePrint(Sender: TQRCustomBand;var PrintBand: Boolean);
    procedure qrdbtxtMinutiContPrint(sender: TObject; var Value: string);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    ThousandSepOri: Char;
    function GetPosizioneCausale(S:String):Integer;
    function CreaRiduzioni(P:Integer):String;
    function GetTotRiduzioni(P:Integer):String;
  public
    { Public declarations }
    CampoRagg : String;
    NomeCampo : String;
    DaData,AData,DaRegStamp,ARegStamp : TDateTime;
    procedure CreaReport(PreView:Boolean);
  end;

var A061FStampa: TA061FStampa;

implementation

uses A061UDettAssenze;

{$R *.DFM}

//------------------------------------------------------------------------------
procedure TA061FStampa.CreaReport(PreView:Boolean);
begin
  //Abilitazione bande dei totali
  QRFoot2.Enabled:=A061FDettAssenze.chkTotIndividuali.Checked;
  QRFoot1.Enabled:=A061FDettAssenze.chkTotRaggrup.Checked;
  SummaryBand1.Enabled:=A061FDettAssenze.chkTotGenerali.Checked;
  //Settaggio dell'espressione di raggruppamento se specificato un dato di raggruppamento
  if CampoRagg <> '' then
  begin
    QRGroup1.Expression:='Gruppo';
    QRLRaggruppamento.Caption:=NomeCampo;
    QRGroup1.Enabled:=True;
  end
  else
  begin
    QRGroup1.Enabled:=False;
    QRFoot1.Enabled:=False;
  end;
  //Impostazione salto pagina individuale o sulla banda del raggruppamento
  QRGroup1.ForceNewPage:=False;
  QRGroup2.ForceNewPage:=False;
  if CampoRagg = '' then
    QRGroup2.ForceNewPage:=A061FDettAssenze.chkSaltoPagIndividuale.Checked
  else
  begin
    QRGroup1.ForceNewPage:=A061FDettAssenze.chkSaltoPagRaggrup.Checked or A061FDettAssenze.chkSaltoPagIndividuale.Checked;
    if A061FDettAssenze.chkSaltoPagIndividuale.Checked then
      QRGroup1.Expression:='Matricola';
  end;
  //Abilitazione dati individuali
  QRGroup2.Enabled:=A061FDettAssenze.chkDatiIndividuali.Checked;
  QRFoot2.Enabled:=QRFoot2.Enabled and A061FDettAssenze.chkDatiIndividuali.Checked;
  ChildBand1.Enabled:=A061FDettAssenze.chkDettGiorn.Checked or A061FDettAssenze.chkDettPer.Checked;
  dlblCognome.Enabled:=A061FDettAssenze.chkStampaNominativo.Checked;
  dlblBadge.Enabled:=A061FDettAssenze.chkStampaBadge.Checked;
  lblBadge.Enabled:=A061FDettAssenze.chkStampaBadge.Checked;
  dlblMatricola.Enabled:=A061FDettAssenze.chkStampaMatricola.Checked;
  lblMatricola.Enabled:=A061FDettAssenze.chkStampaMatricola.Checked;
  if not dlblCognome.Enabled then
  begin
    lblMatricola.Left:=dlblCognome.Left;
    dlblMatricola.Left:=lblMatricola.Left + 43;
  end
  else
  begin
    lblMatricola.Left:=364;
    dlblMatricola.Left:=408;
  end;
  if A061FDettAssenze.chkDettGiorn.Checked then
  begin
    QRLabel11.Caption:='Giorno';
    QRLabel12.Caption:='';
  end
  else
  begin
    QRLabel11.Caption:='Dal';
    QRLabel12.Caption:='Al';
  end;
  QRLabel17.Enabled:=A061FDettAssenze.chkSoloAssRegSucc.Checked;
  QRDBText8.Enabled:=A061FDettAssenze.chkSoloAssRegSucc.Checked;
  QRLabel16.Enabled:=A061FDettAssenze.chkRiduzioni.Checked;
  DRiduzioni.Enabled:=A061FDettAssenze.chkRiduzioni.Checked;
  bndLegendaFamiliari.Enabled:=A061FDettAssenze.chkTotFam.Checked and A061FDettAssenze.chkTotIndividuali.Checked;
  if (Trim(A061FDettAssenze.A061MW.DocumentoPDF) <> '') and (Trim(A061FDettAssenze.A061MW.DocumentoPDF) <> '<VUOTO>') then
  begin
      RepR.ShowProgress:=False;
      RepR.ExportToFilter(TQRPDFDocumentFilter.Create(A061FDettAssenze.A061MW.DocumentoPDF));
  end
  else if PreView then
    RepR.Preview
  else
    RepR.Print;
end;

//------------------------------------------------------------------------------
procedure TA061FStampa.RepRBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var i,xx,j:Integer;
begin
  ThousandSepOri:={$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator;
  if RepR.Exporting and (RepR.ExportFilter is TQRXLSFilter) then
      {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=#0;
  QRLEnte.Caption:=Parametri.DAzienda;
  if A061FDettAssenze.chkSoloAssRegSucc.Checked then
    QRLTitolo.Caption := 'Elenco assenze registrate dal ' + FormatDateTime('dd/mm/yyyy',DaRegStamp)+
                              ' al ' +FormatDateTime('dd/mm/yyyy',ARegStamp)
  else
    QRLTitolo.Caption := 'Elenco assenze dal ' + FormatDateTime('dd/mm/yyyy',DaData)+
                              ' al ' +FormatDateTime('dd/mm/yyyy',AData);
  qrlblMinuticont.Enabled:=A061FDettAssenze.chkConteggiGG.Checked;  //Lorena 31/08/2011
  qrlblInizio.Enabled:=A061FDettAssenze.chkPeriodoServizio.Checked;
  qrdbtxtInizio.Enabled:=A061FDettAssenze.chkPeriodoServizio.Checked;
  qrlblFine.Enabled:=A061FDettAssenze.chkPeriodoServizio.Checked;
  qrdbtxtFine.Enabled:=A061FDettAssenze.chkPeriodoServizio.Checked;
  with A061FDettAssenze.A061MW do
  begin
    for i:=1 to NumCausali do
    begin
      TotGen[i].Giorni:=0;
      TotGen[i].Minuti:=0;
      TotGen[i].MinutiCont:=0;
      TotGrup[i].Giorni:=0;
      TotGrup[i].Minuti:=0;
      TotGrup[i].MinutiCont:=0;
      TotInd[i].Giorni:=0;
      TotInd[i].Minuti:=0;
      TotInd[i].MinutiCont:=0;
      for j:=1 to 50 do  //Lorena 25/07/2005
      begin
        TotInd[i].Fam[j].Codice:='';
        TotInd[i].Fam[j].DataNas:=0;
        TotInd[i].Fam[j].GradoPar:='';
        TotInd[i].Fam[j].TotGG:=0;
        TotInd[i].Fam[j].TotMM:=0;
        TotInd[i].Fam[j].TotMMCont:=0;
      end;
    end;
    for xx:=Low(TotRid) to High(TotRid) do
    begin
      TotRid[xx].UM:='';
      for i:=1 to 6 do
      begin
        TotRid[xx].Fruito[i]:=0;
        TotRid[xx].Percent[i]:=0;
      end;
    end;
  end;
end;

procedure TA061FStampa.QRDBText5Print(sender: TObject; var Value: String);
begin
  with A061FDettAssenze.A061MW.TabellaStampa do
    if (FieldByName('Minuti').AsInteger) > 0 then
      Value:=R180MinutiOre(FieldByName('Minuti').AsInteger);
end;

procedure TA061FStampa.qrdbtxtMinutiContPrint(sender: TObject; var Value: string);
begin
  with A061FDettAssenze.A061MW.TabellaStampa do
    if (FieldByName('MinutiCont').AsInteger) > 0 then
      Value:=R180MinutiOre(FieldByName('MinutiCont').AsInteger);
end;

procedure TA061FStampa.QRBand1BeforePrint(Sender: TQRCustomBand;var PrintBand: Boolean);
var
  i,j,SalvaJ,Posiz:Integer;
  Trovato:Boolean;
  S:String;
begin
  //DETTAGLIO
  with A061FDettAssenze.A061MW do
  begin
    PrintBand:=A061FDettAssenze.chkDettGiorn.Checked or A061FDettAssenze.chkDettPer.Checked;
    i:=GetPosizioneCausale(RepR.DataSet.FieldByName('Causale').AsString);
    if i = -1 then exit;
    TotInd[i].MinutiCont:=TotInd[i].MinutiCont + RepR.DataSet.FieldByName('MinutiCont').AsInteger;
    TotGrup[i].MinutiCont:=TotGrup[i].MinutiCont + RepR.DataSet.FieldByName('MinutiCont').AsInteger;
    TotGen[i].MinutiCont:=TotGen[i].MinutiCont + RepR.DataSet.FieldByName('MinutiCont').AsInteger;
    if RepR.DataSet.FieldByName('Giorni').AsFloat <= 0 then
    begin
      TotInd[i].Minuti:=TotInd[i].Minuti + RepR.DataSet.FieldByName('Minuti').AsInteger;
      TotGrup[i].Minuti:=TotGrup[i].Minuti + RepR.DataSet.FieldByName('Minuti').AsInteger;
      TotGen[i].Minuti:=TotGen[i].Minuti + RepR.DataSet.FieldByName('Minuti').AsInteger;
    end
    else
    begin
      TotInd[i].Giorni:=TotInd[i].Giorni + RepR.DataSet.FieldByName('Giorni').AsFloat;
      TotGrup[i].Giorni:=TotGrup[i].Giorni + RepR.DataSet.FieldByName('Giorni').AsFloat;
      TotGen[i].Giorni:=TotGen[i].Giorni + RepR.DataSet.FieldByName('Giorni').AsFloat;
    end;
    Trovato:=False; //Lorena 26/07/2005
    Posiz:=Pos('^',RepR.DataSet.FieldByName('Causale').AsString);
    //Totali NON divisi per familiare ma divisi per coniuge
    if (not A061FDettAssenze.chkTotFam.Checked) and (A061FDettAssenze.chkConiuge.Checked) then
    begin
      if Posiz > 0 then
        S:=Copy(RepR.DataSet.FieldByName('Causale').AsString,1,5) + Copy(RepR.DataSet.FieldByName('Causale').AsString,Posiz,
             Length(RepR.DataSet.FieldByName('Causale').AsString) - Posiz + 1)
      else
        S:=Copy(RepR.DataSet.FieldByName('Causale').AsString,1,5);
      SalvaJ:=0;
      for j:=1 to 50 do
      begin
        if TotInd[i].Fam[j].Codice = S then
        begin
          TotInd[i].Fam[j].TotMMCont:=TotInd[i].Fam[j].TotMMCont + RepR.DataSet.FieldByName('MinutiCont').AsInteger;
          if RepR.DataSet.FieldByName('Giorni').AsFloat <= 0 then
            TotInd[i].Fam[j].TotMM:=TotInd[i].Fam[j].TotMM + RepR.DataSet.FieldByName('Minuti').AsInteger
          else
            TotInd[i].Fam[j].TotGG:=TotInd[i].Fam[j].TotGG + RepR.DataSet.FieldByName('Giorni').AsFloat;
          Trovato:=True;
        end
        else if Trim(TotInd[i].Fam[j].Codice) <> '' then
          SalvaJ:=j;
      end;
      if not Trovato then
      begin
        TotInd[i].Fam[SalvaJ+1].Codice:=S;
        TotInd[i].Fam[SalvaJ+1].DataNas:=RepR.DataSet.FieldByName('DataNas').AsDateTime;
        TotInd[i].Fam[SalvaJ+1].GradoPar:=RepR.DataSet.FieldByName('GradoPar').AsString;
        TotInd[i].Fam[SalvaJ+1].TotMMCont:=TotInd[i].Fam[SalvaJ+1].TotMMCont + RepR.DataSet.FieldByName('MinutiCont').AsInteger;
        if RepR.DataSet.FieldByName('Giorni').AsFloat <= 0 then
          TotInd[i].Fam[SalvaJ+1].TotMM:=TotInd[i].Fam[SalvaJ+1].TotMM + RepR.DataSet.FieldByName('Minuti').AsInteger
        else
          TotInd[i].Fam[SalvaJ+1].TotGG:=TotInd[i].Fam[SalvaJ+1].TotGG + RepR.DataSet.FieldByName('Giorni').AsFloat;
      end;
    end;
    //Totali divisi per familiare e/o per coniuge
    Trovato:=False; //Lorena 26/07/2005
    Posiz:=Pos('#',RepR.DataSet.FieldByName('Causale').AsString);
    if (A061FDettAssenze.chkTotFam.Checked) and (Posiz > 0) then
    begin
      S:=StringReplace(Copy(RepR.DataSet.FieldByName('Causale').AsString,Posiz,
           Length(RepR.DataSet.FieldByName('Causale').AsString) - Posiz + 1),'#','*',[]);
      SalvaJ:=0;
      for j:=1 to 50 do
      begin
        if TotInd[i].Fam[j].Codice = S then
        begin
          TotInd[i].Fam[j].TotMMCont:=TotInd[i].Fam[j].TotMMCont + RepR.DataSet.FieldByName('MinutiCont').AsInteger;
          if RepR.DataSet.FieldByName('Giorni').AsFloat <= 0 then
            TotInd[i].Fam[j].TotMM:=TotInd[i].Fam[j].TotMM + RepR.DataSet.FieldByName('Minuti').AsInteger
          else
            TotInd[i].Fam[j].TotGG:=TotInd[i].Fam[j].TotGG + RepR.DataSet.FieldByName('Giorni').AsFloat;
          Trovato:=True;
        end
        else if Trim(TotInd[i].Fam[j].Codice) <> '' then
          SalvaJ:=j;
      end;
      if not Trovato then
      begin
        TotInd[i].Fam[SalvaJ+1].Codice:=S;
        TotInd[i].Fam[SalvaJ+1].DataNas:=RepR.DataSet.FieldByName('DataNas').AsDateTime;
        TotInd[i].Fam[SalvaJ+1].GradoPar:=RepR.DataSet.FieldByName('GradoPar').AsString;
        TotInd[i].Fam[SalvaJ+1].TotMMCont:=TotInd[i].Fam[SalvaJ+1].TotMMCont + RepR.DataSet.FieldByName('MinutiCont').AsInteger;
        if RepR.DataSet.FieldByName('Giorni').AsFloat <= 0 then
          TotInd[i].Fam[SalvaJ+1].TotMM:=TotInd[i].Fam[SalvaJ+1].TotMM + RepR.DataSet.FieldByName('Minuti').AsInteger
        else
          TotInd[i].Fam[SalvaJ+1].TotGG:=TotInd[i].Fam[SalvaJ+1].TotGG + RepR.DataSet.FieldByName('Giorni').AsFloat;
      end;
    end;
    if A061FDettAssenze.chkRiduzioni.Checked then
      DRiduzioni.Caption:=CreaRiduzioni(i);
    qrdbTxtMinutiCont.Enabled:=A061FDettAssenze.chkConteggiGG.Checked;  //Lorena 31/08/2011
  end;
end;

procedure TA061FStampa.QRBTitoloBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if A061FDettAssenze.rgpValidate.ItemIndex = 0 then
    QRLTitolo.Caption:= QRLTitolo.Caption + ' da validare'
  else if A061FDettAssenze.rgpValidate.ItemIndex = 1 then
    QRLTitolo.Caption:= QRLTitolo.Caption + ' validate';
end;

function TA061FStampa.GetPosizioneCausale(S:String):Integer;
var
  i:Integer;
begin
  with A061FDettAssenze.A061MW do
  begin
    Result:= -1;
    for i:=1 to NumCausali do
      if Trim(S) = Trim(TotInd[i].Causale) then
      begin
        Result:=i;
        Break;
      end;
    if (Result = -1) and (Pos('#',S) > 0) then
    begin
      S:=Trim(Copy(S,1,Pos('#',S) - 1));
      for i:=1 to NumCausali do
        if S = Trim(TotInd[i].Causale) then
        begin
          Result:=i;
          Break;
        end;
    end;
    if (Result = -1) and (Pos('^',S) > 0) then
    begin
      S:=Trim(Copy(S,1,Pos('^',S) - 1));
      for i:=1 to NumCausali do
        if S = Trim(TotInd[i].Causale) then
        begin
          Result:=i;
          Break;
        end;
    end;
  end;
end;

function TA061FStampa.CreaRiduzioni(P:Integer):String;
var i:Integer;
    L:TStringList;
    V:Real;
    S,AssenzaRidotta:String;
begin
  with A061FDettAssenze.A061MW do
  begin
    Result:='';
    AssenzaRidotta:='N';
    L:=TStringList.Create;
    L.CommaText:=RepR.DataSet.FieldByName('Percent').AsString;
    for i:=0 to L.Count - 1 do
      TotRid[P].Percent[i + 1]:=StrToIntDef(L[i],0);
    L.Clear;
    S:=RepR.DataSet.FieldByName('Fruito').AsString;
    while Pos('>',S) > 0 do
    begin
      L.Add(Copy(S,2,Pos('>',S) - 2));
      S:=Copy(S,Pos('>',S) + 1,Length(S));
    end;
    //L.CommaText:=RepR.DataSet.FieldByName('Fruito').AsString;
    for i:=0 to L.Count - 1 do
    begin
      if AssenzaRidotta='S' then
        Break;
      if ((TotRid[P].Percent[i + 1]) < 100) and (StrToFloat(L[i]) > 0) then
        AssenzaRidotta:='S';
    end;
    TotRid[P].UM:=RepR.DataSet.FieldByName('UM').AsString;
    for i:=0 to 5 do
    begin
      if (not A061FDettAssenze.chkSoloRiduzioni.Checked) or (AssenzaRidotta= 'S') then
      begin
        V:=0;
        try
          V:=StrToFloat(L[i]);
        except
        end;
        if V > 0 then
        begin
          TotRid[P].Fruito[i + 1]:=TotRid[P].Fruito[i + 1] + V;
          if TotRid[P].UM = 'G' then
            Result:=Result + ' ' + Format('%5.1f %3d%%',[V,TotRid[P].Percent[i + 1]])
          else
            Result:=Result + ' ' + Format('%s %3d%%',[R180MinutiOre(Trunc(V)),TotRid[P].Percent[i + 1]]);
        end;
      end;
    end;
    L.Free;
  end;
end;

procedure TA061FStampa.FormCreate(Sender: TObject);
begin
  RepR.useQR5Justification:=True;
  RepR.DataSet:=A061FDettAssenze.A061MW.TabellaStampa;
  QRDBText2.DataSet:=A061FDettAssenze.A061MW.TabellaStampa;
  QRDBText3.DataSet:=A061FDettAssenze.A061MW.TabellaStampa;
  QRDBText4.DataSet:=A061FDettAssenze.A061MW.TabellaStampa;
  QRDBText5.DataSet:=A061FDettAssenze.A061MW.TabellaStampa;
  QRDBText6.DataSet:=A061FDettAssenze.A061MW.TabellaStampa;
  QRDBText7.DataSet:=A061FDettAssenze.A061MW.TabellaStampa;
  QRDBText8.DataSet:=A061FDettAssenze.A061MW.TabellaStampa;
  QRDBTGruppo.DataSet:=A061FDettAssenze.A061MW.TabellaStampa;
  dlblCognome.DataSet:=A061FDettAssenze.A061MW.TabellaStampa;
  dlblBadge.DataSet:=A061FDettAssenze.A061MW.TabellaStampa;
  dlblMatricola.DataSet:=A061FDettAssenze.A061MW.TabellaStampa;
  qrdbtxtMinutiCont.DataSet:=A061FDettAssenze.A061MW.TabellaStampa;
  qrdbtxtInizio.DataSet:=A061FDettAssenze.A061MW.TabellaStampa;
  qrdbtxtFine.DataSet:=A061FDettAssenze.A061MW.TabellaStampa;
end;

procedure TA061FStampa.QRFoot2BeforePrint(Sender: TQRCustomBand;var PrintBand: Boolean);
{Banda dei totali individuali}
var i,j,T2,T3:Integer;
    T1:Real;
    S,S1,S2,S3:String;
    Trovato:Boolean;

DebugGradoPar: String;
DebugDatanas: TDateTime;
begin
  with A061FDettAssenze.A061MW do
  begin
    QRMemo1.Lines.Clear;
    T1:=0;
    T2:=0;
    T3:=0;
    for i:=1 to NumCausali do
    begin
      //Totali NON divisi per familiare
      if not A061FDettAssenze.chkTotFam.Checked then
        if A061FDettAssenze.chkConiuge.Checked then  //Totali divisi per coniuge
        begin
          Trovato:=False;
          for j:=1 to 50 do
          begin
            if (TotInd[i].Fam[j].TotGG <> 0) or (TotInd[i].Fam[j].TotMM <> 0) then
            begin
              T1:=T1 + TotInd[i].Fam[j].TotGG;
              T2:=T2 + TotInd[i].Fam[j].TotMM;
              T3:=T3 + TotInd[i].Fam[j].TotMMCont;
              if TotInd[i].Fam[j].TotGG = 0 then S1:='' else S1:=FloatToStr(TotInd[i].Fam[j].TotGG);
              if TotInd[i].Fam[j].TotMM = 0 then S2:='' else S2:=R180MinutiOre(TotInd[i].Fam[j].TotMM);
              if TotInd[i].Fam[j].TotMMCont = 0 then S3:='' else S3:=R180MinutiOre(TotInd[i].Fam[j].TotMMCont);
              if A061FDettAssenze.chkConteggiGG.Checked then
                S:=Format('%-10s%-33.33s  GG:%5s  HH:%7s  Cont:%7s',
                  [Trim(TotInd[i].Fam[j].Codice),TotInd[i].Descrizione,S1,S2,S3])
              else
                S:=Format('%-10s%-33.33s  GG:%5s  HH:%7s',
                  [Trim(TotInd[i].Fam[j].Codice),TotInd[i].Descrizione,S1,S2]);
              QRMemo1.Lines.Add(S);
              Trovato:=True;
            end;
          end;
          if (not Trovato) and ((TotInd[i].Giorni <> 0) or (TotInd[i].Minuti <> 0)) then
          begin
            T1:=T1 + TotInd[i].Giorni;
            T2:=T2 + TotInd[i].Minuti;
            T3:=T3 + TotInd[i].MinutiCont;
            if TotInd[i].Giorni = 0 then S1:='' else S1:=FloatToStr(TotInd[i].Giorni);
            if TotInd[i].Minuti = 0 then S2:='' else S2:=R180MinutiOre(TotInd[i].Minuti);
            if TotInd[i].MinutiCont = 0 then S3:='' else S3:=R180MinutiOre(TotInd[i].MinutiCont);
            if A061FDettAssenze.chkConteggiGG.Checked then
              S:=Format('%-10s%-33.33s  GG:%5s  HH:%7s  Cont:%7s',[Trim(TotInd[i].Causale),TotInd[i].Descrizione,S1,S2,S3])
            else
              S:=Format('%-10s%-33.33s  GG:%5s  HH:%7s',[Trim(TotInd[i].Causale),TotInd[i].Descrizione,S1,S2]);
            QRMemo1.Lines.Add(S);
          end;
        end
        else
          if ((TotInd[i].Giorni <> 0) or (TotInd[i].Minuti <> 0)) then
          begin
            T1:=T1 + TotInd[i].Giorni;
            T2:=T2 + TotInd[i].Minuti;
            T3:=T3 + TotInd[i].MinutiCont;
            if TotInd[i].Giorni = 0 then S1:='' else S1:=FloatToStr(TotInd[i].Giorni);
            if TotInd[i].Minuti = 0 then S2:='' else S2:=R180MinutiOre(TotInd[i].Minuti);
            if TotInd[i].MinutiCont = 0 then S3:='' else S3:=R180MinutiOre(TotInd[i].MinutiCont);
            if A061FDettAssenze.chkConteggiGG.Checked then
              S:=Format('%-10s%-33.33s  GG:%5s  HH:%7s  Cont:%7s',[Trim(TotInd[i].Causale),TotInd[i].Descrizione,S1,S2,S3])
            else
              S:=Format('%-10s%-33.33s  GG:%5s  HH:%7s',[Trim(TotInd[i].Causale),TotInd[i].Descrizione,S1,S2]);
            QRMemo1.Lines.Add(S);
          end;
      //Totali divisi per familiare  e/o per coniuge
      if A061FDettAssenze.chkTotFam.Checked then   //Lorena 26/07/2005
      begin
        Trovato:=False;
        for j:=1 to 50 do
        begin
          if (TotInd[i].Fam[j].TotGG <> 0) or (TotInd[i].Fam[j].TotMM <> 0) then
          begin
            T1:=T1 + TotInd[i].Fam[j].TotGG;
            T2:=T2 + TotInd[i].Fam[j].TotMM;
            T3:=T3 + TotInd[i].Fam[j].TotMMCont;
            if TotInd[i].Fam[j].TotGG = 0 then S1:='' else S1:=FloatToStr(TotInd[i].Fam[j].TotGG);
            if TotInd[i].Fam[j].TotMM = 0 then S2:='' else S2:=R180MinutiOre(TotInd[i].Fam[j].TotMM);
            if TotInd[i].Fam[j].TotMMCont = 0 then S3:='' else S3:=R180MinutiOre(TotInd[i].Fam[j].TotMMCont);
            // debug.ini
            DebugGradoPar:=A061FDettAssenze.A061MW.TotInd[i].Fam[j].GradoPar;
            DebugDataNas:=A061FDettAssenze.A061MW.TotInd[i].Fam[j].DataNas;
            S:=DebugGradoPar + ' ' + Datetostr(debugdatanas);
            // debug.fine

            if A061FDettAssenze.chkConteggiGG.Checked then
              S:=Format('%-10s%-33.33s  GG:%5s  HH:%7s  Cont:%7s',
                [Trim(TotInd[i].Causale) + TotInd[i].Fam[j].Codice,Copy(TotInd[i].Descrizione,1,17) + ' (' + IfThen(TotInd[i].Fam[j].GradoPar <> '',TotInd[i].Fam[j].GradoPar + ':','') + DateToStr(TotInd[i].Fam[j].DataNas) + ')',S1,S2,S3])
            else
              S:=Format('%-10s%-33.33s  GG:%5s  HH:%7s',
                [Trim(TotInd[i].Causale) + TotInd[i].Fam[j].Codice,Copy(TotInd[i].Descrizione,1,17) + ' (' + IfThen(TotInd[i].Fam[j].GradoPar <> '',TotInd[i].Fam[j].GradoPar + ':','') + DateToStr(TotInd[i].Fam[j].DataNas) + ')',S1,S2]);
            QRMemo1.Lines.Add(S);
            Trovato:=True;
          end;
        end;
        if (not Trovato) and ((TotInd[i].Giorni <> 0) or (TotInd[i].Minuti <> 0)) then
        begin
          T1:=T1 + TotInd[i].Giorni;
          T2:=T2 + TotInd[i].Minuti;
          T3:=T3 + TotInd[i].MinutiCont;
          if TotInd[i].Giorni = 0 then S1:='' else S1:=FloatToStr(TotInd[i].Giorni);
          if TotInd[i].Minuti = 0 then S2:='' else S2:=R180MinutiOre(TotInd[i].Minuti);
          if TotInd[i].MinutiCont = 0 then S3:='' else S3:=R180MinutiOre(TotInd[i].MinutiCont);
          if A061FDettAssenze.chkConteggiGG.Checked then
            S:=Format('%-10s%-33.33s  GG:%5s  HH:%7s  Cont:%7s',[Trim(TotInd[i].Causale),TotInd[i].Descrizione,S1,S2,S3])
          else
            S:=Format('%-10s%-33.33s  GG:%5s  HH:%7s',[Trim(TotInd[i].Causale),TotInd[i].Descrizione,S1,S2]);
          QRMemo1.Lines.Add(S);
        end;
      end;
      if A061FDettAssenze.chkRiduzioni.Checked then
      begin
        S:=GetTotRiduzioni(i);
        if Trim(S) <> '' then
          QRMemo1.Lines.Add(S);
      end;
    end;
    if T1 = 0 then S1:='' else S1:=FloatToStr(T1);
    if T2 = 0 then S2:='' else S2:=R180MinutiOre(T2);
    if T3 = 0 then S3:='' else S3:=R180MinutiOre(T3);
    if A061FDettAssenze.chkConteggiGG.Checked then
      S:=Format('%44.44s GG:%5s  HH:%7s  Cont:%7s',['Totale',S1,S2,S3])
    else
      S:=Format('%44.44s GG:%5s  HH:%7s',['Totale',S1,S2]);
    QRMemo1.Lines.Add(S);
  end;
end;

function TA061FStampa.GetTotRiduzioni(P:Integer):String;
var
  i:Integer;
begin
  with A061FDettAssenze.A061MW do
  begin
    Result:='       ';
    for i:=1 to 6 do
    begin
      if TotRid[P].Fruito[i] > 0 then
        if TotRid[P].UM = 'G' then
          Result:=Result + Format(' %5.1f %3d%%',[TotRid[P].Fruito[i],TotRid[P].Percent[i]])
        else
          Result:=Result + Format(' %s %3d%%',[R180MinutiOre(Trunc(TotRid[P].Fruito[i])),TotRid[P].Percent[i]]);
    end;
  end;
end;

procedure TA061FStampa.QRFoot1BeforePrint(Sender: TQRCustomBand;var PrintBand: Boolean);
{Totali a livello di raggruppamento}
var
  i,T2,T3:Integer;
  T1:Real;
  S,S1,S2,S3:String;
begin
  with A061FDettAssenze.A061MW do
  begin
    QRMemo2.Lines.Clear;
    T1:=0;
    T2:=0;
    T3:=0;
    for i:=1 to NumCausali do
      if (TotGrup[i].Giorni <> 0) or (TotGrup[i].Minuti <> 0) then
      begin
        T1:=T1 + TotGrup[i].Giorni;
        T2:=T2 + TotGrup[i].Minuti;
        T3:=T3 + TotGrup[i].MinutiCont;
        if TotGrup[i].Giorni = 0 then S1:='' else S1:=FloatToStr(TotGrup[i].Giorni);
        if TotGrup[i].Minuti = 0 then S2:='' else S2:=R180MinutiOre(TotGrup[i].Minuti);
        if TotGrup[i].MinutiCont = 0 then S3:='' else S3:=R180MinutiOre(TotGrup[i].MinutiCont);
  //      S:=Format('%-8s  %-39s  GG:%5s  HH:%7s',[TotGrup[i].Causale,TotGrup[i].Descrizione,S1,S2]);
        if A061FDettAssenze.chkConteggiGG.Checked then
          S:=Format('%-8s  %-33.33s  GG:%5s  HH:%7s  Cont:%7s',[TotGrup[i].Causale,TotGrup[i].Descrizione,S1,S2,S3])
        else
          S:=Format('%-8s  %-33.33s  GG:%5s  HH:%7s',[TotGrup[i].Causale,TotGrup[i].Descrizione,S1,S2]);
        QRMemo2.Lines.Add(S);
      end;
    if T1 = 0 then S1:='' else S1:=FloatToStr(T1);
    if T2 = 0 then S2:='' else S2:=R180MinutiOre(T2);
    if T3 = 0 then S3:='' else S3:=R180MinutiOre(T3);
  //  S:=Format('%50s GG:%5s  HH:%7s',['Totale',S1,S2]);
    if A061FDettAssenze.chkConteggiGG.Checked then
      S:=Format('%44.44s GG:%5s  HH:%7s  Cont:%7s',['Totale',S1,S2,S3])
    else
      S:=Format('%44.44s GG:%5s  HH:%7s',['Totale',S1,S2]);
    QRMemo2.Lines.Add(S);
  end;
end;

procedure TA061FStampa.SummaryBand1BeforePrint(Sender: TQRCustomBand;var PrintBand: Boolean);
var i,T2,T3:Integer;
    T1:Real;
    S,S1,S2,S3:String;
begin
  with A061FDettAssenze.A061MW do
  begin
    QRMemo3.Lines.Clear;
    T1:=0;
    T2:=0;
    T3:=0;
    for i:=1 to NumCausali do
      if (TotGen[i].Giorni <> 0) or (TotGen[i].Minuti <> 0) then
      begin
        T1:=T1 + TotGen[i].Giorni;
        T2:=T2 + TotGen[i].Minuti;
        T3:=T3 + TotGen[i].MinutiCont;
        if TotGen[i].Giorni = 0 then S1:='' else S1:=FloatToStr(TotGen[i].Giorni);
        if TotGen[i].Minuti = 0 then S2:='' else S2:=R180MinutiOre(TotGen[i].Minuti);
        if TotGen[i].MinutiCont = 0 then S3:='' else S3:=R180MinutiOre(TotGen[i].MinutiCont);
  //      S:=Format('%-8s  %-39s  GG:%5s  HH:%7s',[TotGen[i].Causale,TotGen[i].Descrizione,S1,S2]);
        if A061FDettAssenze.chkConteggiGG.Checked then
          S:=Format('%-8s  %-33.33s  GG:%5s  HH:%7s  Cont:%7s',[TotGen[i].Causale,TotGen[i].Descrizione,S1,S2,S3])
        else
          S:=Format('%-8s  %-33.33s  GG:%5s  HH:%7s',[TotGen[i].Causale,TotGen[i].Descrizione,S1,S2]);
        QRMemo3.Lines.Add(S);
      end;
    QRMemo3.Lines.Add('');
    if T1 = 0 then S1:='' else S1:=FloatToStr(T1);
    if T2 = 0 then S2:='' else S2:=R180MinutiOre(T2);
    if T3 = 0 then S3:='' else S3:=R180MinutiOre(T3);
  //  S:=Format('%50s GG:%5s  HH:%7s',['Totale',S1,S2]);
    if A061FDettAssenze.chkConteggiGG.Checked then
      S:=Format('%44.44s GG:%5s  HH:%7s  Cont:%7s',['Totale',S1,S2,S3])
    else
      S:=Format('%44.44s GG:%5s  HH:%7s',['Totale',S1,S2]);
    QRMemo3.Lines.Add(S);
  end;
end;

procedure TA061FStampa.QRFoot2AfterPrint(Sender: TQRCustomBand;BandPrinted: Boolean);
{Azzero i totalizzatori di individuali}
var
  i,j,xx:Integer;
begin
  with A061FDettAssenze.A061MW do
  begin
    for i:=1 to NumCausali do
    begin
      TotInd[i].Giorni:=0;
      TotInd[i].Minuti:=0;
      TotInd[i].MinutiCont:=0;
      for j:=1 to 50 do
      begin
        TotInd[i].Fam[j].Codice:='';
        TotInd[i].Fam[j].DataNas:=0;
        TotInd[i].Fam[j].GradoPar:='';
        TotInd[i].Fam[j].TotGG:=0;
        TotInd[i].Fam[j].TotMM:=0;
        TotInd[i].Fam[j].TotMMCont:=0;
      end;
    end;
    for xx:=Low(TotRid) to High(TotRid) do
    begin
      TotRid[xx].UM:='';
      for i:=1 to 6 do
      begin
        TotRid[xx].Fruito[i]:=0;
        TotRid[xx].Percent[i]:=0;
      end;
    end;
  end;
end;

procedure TA061FStampa.QRFoot1AfterPrint(Sender: TQRCustomBand;BandPrinted: Boolean);
{Azzero i totalizzatori di gruppo}
var
  i:Integer;
begin
  with A061FDettAssenze.A061MW do
    for i:=1 to NumCausali do
    begin
      TotGrup[i].Giorni:=0;
      TotGrup[i].Minuti:=0;
      TotGrup[i].MinutiCont:=0;
    end;
end;

procedure TA061FStampa.RepRAfterPrint(Sender: TObject);
begin
  if {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator = #0 then {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=ThousandSepOri;
end;

procedure TA061FStampa.RepRAfterPreview(Sender: TObject);
begin
  if {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator = #0 then
    {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=ThousandSepOri;
end;

procedure TA061FStampa.QRLabel13Print(sender: TObject; var Value: String);
begin
  Value:=StringReplace((Trim(Copy(Value,1,5))+Copy(Value,6,Length(Value)-5)),'#','*',[]);
end;

end.
