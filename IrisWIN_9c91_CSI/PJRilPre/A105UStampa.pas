unit A105UStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls,C180FunzioniGenerali, A000UCostanti, A000USessione,A000UInterfaccia, QRExport, Variants,
  QRWebFilt, QRPDFFilt;

type
  TTotale = record
    Causale,Descrizione:String;
    Giorni:Real;
    Minuti:Integer;
  end;

  TA105FStampa = class(TForm)
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
    QRLDatiAnagra: TQRLabel;
    QRLabel2: TQRLabel;
    QRDBTCognome: TQRDBText;
    QRDBTBadge: TQRDBText;
    QRDBText1: TQRDBText;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel11: TQRLabel;
    QRDBText8: TQRDBText;
    QRLabel17: TQRLabel;
    QRlblFlag: TQRLabel;
    QRdlblFlag: TQRDBText;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    procedure RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure QRDBText5Print(sender: TObject; var Value: String);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRFoot2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRFoot1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRFoot2AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRFoot1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function GetPosizioneCausale(S:String):Integer;
  public
    { Public declarations }
    DaData,AData:TDateTime;
    procedure CreaReport(PreView:Boolean);
  end;

var
  A105FStampa: TA105FStampa;
  NumCausali:Integer;
  TotInd:array[1..400] of TTotale;
  TotGrup:array[1..400] of TTotale;
  TotGen:array[1..400] of TTotale;

implementation

uses A105UStoricoGiustificativi;

{$R *.DFM}

procedure TA105FStampa.FormCreate(Sender: TObject);
begin
  RepR.useQR5Justification:=True;
  with A105FStoricoGiustificativi.A105MW do
  begin
    RepR.PrinterSettings.UseStandardprinter:=TipoModulo = 'COM';
    RepR.DataSet:=TabellaStampa;
    QRDBText1.DataSet:=TabellaStampa;
    QRDBText2.DataSet:=TabellaStampa;
    QRDBText3.DataSet:=TabellaStampa;
    QRDBText4.DataSet:=TabellaStampa;
    QRDBText5.DataSet:=TabellaStampa;
    QRDBText6.DataSet:=TabellaStampa;
    QRDBText7.DataSet:=TabellaStampa;
    QRDBText8.DataSet:=TabellaStampa;
    QRdlblFlag.DataSet:=TabellaStampa;
    QRDBTGruppo.DataSet:=TabellaStampa;
    QRDBTCognome.DataSet:=TabellaStampa;
    QRDBTBadge.DataSet:=TabellaStampa;
  end;
end;

//------------------------------------------------------------------------------
procedure TA105FStampa.CreaReport(PreView:Boolean);
begin
  //Abilitazione bande dei totali
  QRFoot2.Enabled:=A105FStoricoGiustificativi.chkTotaliIndividuali.Checked;
  QRFoot1.Enabled:=A105FStoricoGiustificativi.chkTotaliRaggr.Checked;
  SummaryBand1.Enabled:=A105FStoricoGiustificativi.chkTotaliGenerali.Checked;
  //Settaggio dell'espressione di raggruppamento se specificato un dato di raggruppamento
  if A105FStoricoGiustificativi.A105MW.CampoRagg <> '' then
    begin
    QRGroup1.Expression := 'Gruppo';
    QRLRaggruppamento.Caption := A105FStoricoGiustificativi.A105MW.NomeCampo;
    QRGroup1.Enabled := True;
    end
  else
    begin
    QRGroup1.Enabled:=False;
    QRFoot1.Enabled:=False;
    end;
  //Impostazione salto pagina individuale o sulla banda del raggruppamento
  QRGroup1.ForceNewPage:=False;
  QRGroup2.ForceNewPage:=False;
  if A105FStoricoGiustificativi.A105MW.CampoRagg = '' then
    QRGroup2.ForceNewPage:=A105FStoricoGiustificativi.chkSaltoPaginaIndividuale.Checked
  else
    begin
    QRGroup2.ForceNewPage:=A105FStoricoGiustificativi.chkSaltoPaginaIndividuale.Checked;
    QRGroup1.ForceNewPage:=A105FStoricoGiustificativi.chkSaltoPaginaRaggr.Checked;
    end;
  //Abilitazione dati individuali
  QRGroup2.Enabled:=A105FStoricoGiustificativi.chkDatiIndividuali.Checked;
  QRFoot2.Enabled:=QRFoot2.Enabled and A105FStoricoGiustificativi.chkDatiIndividuali.Checked;
  ChildBand1.Enabled:=A105FStoricoGiustificativi.chkDettaglioGiornaliero.Checked or A105FStoricoGiustificativi.chkDettaglioPeriodico.Checked;
  if A105FStoricoGiustificativi.chkDettaglioGiornaliero.Checked then
  begin
    QRLabel11.Caption:='Giorno';
    QRLabel12.Caption:='';
  end
  else
  begin
    QRLabel11.Caption:='Dal';
    QRLabel12.Caption:='Al';
  end;
  with A105FStoricoGiustificativi.A105MW do
    if (TipoModulo = 'COM') and (Trim(DocumentoPDF) <> '') and (Trim(DocumentoPDF) <> '<VUOTO>') then
    begin
      RepR.ShowProgress:=False;
      RepR.ExportToFilter(TQRPDFDocumentFilter.Create(DocumentoPDF));
    end
    else if Preview then
      RepR.Preview
    else
      RepR.Print;
end;

//------------------------------------------------------------------------------
procedure TA105FStampa.RepRBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var i:Integer;
begin
  QRLEnte.Caption:=Parametri.DAzienda;
  QRLTitolo.Caption := 'Elenco assenze dal ' + FormatDateTime('dd/mm/yyyy',DaData)+
                            ' al ' +FormatDateTime('dd/mm/yyyy',AData);
  for i:=1 to NumCausali do
  begin
    TotGen[i].Giorni:=0;
    TotGen[i].Minuti:=0;
    TotGrup[i].Giorni:=0;
    TotGrup[i].Minuti:=0;
    TotInd[i].Giorni:=0;
    TotInd[i].Minuti:=0;
  end;
end;

procedure TA105FStampa.QRDBText5Print(sender: TObject; var Value: String);
begin
  with A105FStoricoGiustificativi.A105MW.TabellaStampa do
    if (FieldByName('Minuti').AsInteger) > 0 then
      Value:=R180MinutiOre(FieldByName('Minuti').AsInteger);
end;

procedure TA105FStampa.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var i:Integer;
begin
  i:=GetPosizioneCausale(RepR.DataSet.FieldByName('Causale').AsString);
  if i = -1 then exit;
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
  //Non stampo il dettaglio se non richiesto
  PrintBand:=((A105FStoricoGiustificativi.chkDettaglioGiornaliero.Checked or A105FStoricoGiustificativi.chkDettaglioPeriodico.Checked) and (A105FStoricoGiustificativi.chkDatiIndividuali.Checked));
end;

function TA105FStampa.GetPosizioneCausale(S:String):Integer;
var i:Integer;
begin
  Result:= -1;
  for i:=1 to NumCausali do
    if Trim(S) = Trim(TotInd[i].Causale) then
    begin
      Result:=i;
      Break;
    end;
  if (Result = -1) and (Copy(S,Length(S) - 1,1) = '*') then
  begin
    S:=Trim(Copy(S,1,Length(S) - 2));
    for i:=1 to NumCausali do
      if S = Trim(TotInd[i].Causale) then
      begin
        Result:=i;
        Break;
      end;
  end;
end;

procedure TA105FStampa.QRFoot2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
{Banda dei totali individuali}
var i,T2:Integer;
    T1:Real;
    S,S1,S2:String;
begin
  QRMemo1.Lines.Clear;
  T1:=0;
  T2:=0;
  for i:=1 to NumCausali do
    if (TotInd[i].Giorni <> 0) or (TotInd[i].Minuti <> 0) then
    begin
      T1:=T1 + TotInd[i].Giorni;
      T2:=T2 + TotInd[i].Minuti;
      if TotInd[i].Giorni = 0 then S1:='' else S1:=FloatToStr(TotInd[i].Giorni);
      if TotInd[i].Minuti = 0 then S2:='' else S2:=R180MinutiOre(TotInd[i].Minuti);
      S:=Format('%-6s  %-39s  GG:%5s  HH:%7s',[TotInd[i].Causale,TotInd[i].Descrizione,S1,S2]);
      QRMemo1.Lines.Add(S);
    end;
  if T1 = 0 then S1:='' else S1:=FloatToStr(T1);
  if T2 = 0 then S2:='' else S2:=R180MinutiOre(T2);
  S:=Format('%48s GG:%5s  HH:%7s',['Totale',S1,S2]);
//  S:=Format('%48s GG:%5s  HH:%7s',['Totale',S1,S2]);
  QRMemo1.Lines.Add(S);
end;

procedure TA105FStampa.QRFoot1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
{Totali a livello di raggruppamento}
var i,T2:Integer;
    T1:Real;
    S,S1,S2:String;
begin
  QRMemo2.Lines.Clear;
  T1:=0;
  T2:=0;
  for i:=1 to NumCausali do
    if (TotGrup[i].Giorni <> 0) or (TotGrup[i].Minuti <> 0) then
      begin
      T1:=T1 + TotGrup[i].Giorni;
      T2:=T2 + TotGrup[i].Minuti;
      if TotGrup[i].Giorni = 0 then S1:='' else S1:=FloatToStr(TotGrup[i].Giorni);
      if TotGrup[i].Minuti = 0 then S2:='' else S2:=R180MinutiOre(TotGrup[i].Minuti);
      S:=Format('%-6s  %-39s  GG:%5s  HH:%7s',[TotGrup[i].Causale,TotGrup[i].Descrizione,S1,S2]);
      QRMemo2.Lines.Add(S);
      end;
  if T1 = 0 then S1:='' else S1:=FloatToStr(T1);
  if T2 = 0 then S2:='' else S2:=R180MinutiOre(T2);
  S:=Format('%48s GG:%5s  HH:%7s',['Totale',S1,S2]);
  QRMemo2.Lines.Add(S);
end;

procedure TA105FStampa.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var i,T2:Integer;
    T1:Real;
    S,S1,S2:String;
begin
  QRMemo3.Lines.Clear;
  T1:=0;
  T2:=0;
  for i:=1 to NumCausali do
    if (TotGen[i].Giorni <> 0) or (TotGen[i].Minuti <> 0) then
      begin
      T1:=T1 + TotGen[i].Giorni;
      T2:=T2 + TotGen[i].Minuti;
      if TotGen[i].Giorni = 0 then S1:='' else S1:=FloatToStr(TotGen[i].Giorni);
      if TotGen[i].Minuti = 0 then S2:='' else S2:=R180MinutiOre(TotGen[i].Minuti);
      S:=Format('%-6s  %-39s  GG:%5s  HH:%7s',[TotGen[i].Causale,TotGen[i].Descrizione,S1,S2]);
      QRMemo3.Lines.Add(S);
      end;
  QRMemo3.Lines.Add('');
  if T1 = 0 then S1:='' else S1:=FloatToStr(T1);
  if T2 = 0 then S2:='' else S2:=R180MinutiOre(T2);
  S:=Format('%48s GG:%5s  HH:%7s',['Totale',S1,S2]);
  QRMemo3.Lines.Add(S);
end;

procedure TA105FStampa.QRFoot2AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
{Azzero i totalizzatori di individuali}
var i:Integer;
begin
  for i:=1 to NumCausali do
    begin
    TotInd[i].Giorni:=0;
    TotInd[i].Minuti:=0;
    end;
end;

procedure TA105FStampa.QRFoot1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
{Azzero i totalizzatori di gruppo}
var i:Integer;
begin
  for i:=1 to NumCausali do
    begin
    TotGrup[i].Giorni:=0;
    TotGrup[i].Minuti:=0;
    end;
end;

end.
