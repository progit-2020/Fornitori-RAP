unit A091UStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, quickrpt, ExtCtrls, Qrctrls, A000UCostanti, A000USessione,A000UInterfaccia, C180FunzioniGenerali, Variants,
  QRExport, QRWebFilt, QRPDFFilt;

type
  TA091FStampa = class(TForm)
    RepR: TQuickRep;
    QRBTitolo: TQRBand;
    QRLTitolo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRBand1: TQRBand;
    QRGroup1:TQRGroup;
    QRBIntestazione: TQRBand;
    QRDBTCognomeNome: TQRDBText;
    QRLabel1: TQRLabel;
    QRLEnte: TQRLabel;
    QRFoot1: TQRBand;
    QRLTot1: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRBand2: TQRBand;
    QRLabel10: TQRLabel;
    QRLLiquidabile: TQRLabel;
    QRLRiporto: TQRLabel;
    QRLLiquidato: TQRLabel;
    QRLLiquidabile1: TQRLabel;
    QRLRiporto1: TQRLabel;
    QRLLiquidato1: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel22: TQRLabel;
    QRLResiduo1: TQRLabel;
    QRLResiduo: TQRLabel;
    QRDBText8: TQRDBText;
    QRLabel24: TQRLabel;
    DatiDettaglio: TQRLabel;
    NomiDettaglio: TQRLabel;
    QRMemo1: TQRMemo;
    ChildBand1: TQRChildBand;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLCompensabile1: TQRLabel;
    QRLCompensabile: TQRLabel;
    Anomalia: TQRLabel;
    QRLabel15: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBText7: TQRDBText;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    procedure RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRFoot1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Liquidabile,Liquidabile1,Liquidabile2: Integer;
    Liquidato,Liquidato1,Liquidato2: Integer;
    Residuo,Residuo1,Residuo2: Integer;
    Compensabile,Compensabile1,Compensabile2: Integer;
    Riporto,Riporto1,Riporto2: Integer;
  public
    { Public declarations }
    procedure SettaDataset;
    procedure CreaReport(Preview:Boolean);
  end;

var
  A091FStampa: TA091FStampa;

implementation

uses A091ULiquidPresenze,A091ULiquidPresenzeDtM1;
{$R *.DFM}

//------------------------------------------------------------------------------
procedure TA091FStampa.CreaReport(Preview:Boolean);
begin
  if PreView then
    RepR.Preview
  else
    RepR.Print;
end;

procedure TA091FStampa.RepRBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  QRLEnte.Caption:=Parametri.DAzienda;
//  QRLTitolo.Caption:=A091FLiquidPresenze.DBText1.Field.AsString;
  QRLTitolo.Caption:='Riepilogo ore causalizzate di ' +
                      R180NomeMese(A091FLiquidPresenze.SEMese.Value) + ' ' +IntToStr(A091FLiquidPresenze.SEAnno.Value);
  if A091FLiquidPresenze.chkAggiornamento.Checked then
    QRLTitolo.Caption:=QRLTitolo.Caption + ' con Liquidazione Automatica';
  Liquidabile:=0;
  Liquidabile1:=0;
  Liquidabile2:=0;
  Liquidato:=0;
  Liquidato1:=0;
  Liquidato2:=0;
  Residuo:=0;
  Residuo1:=0;
  Residuo2:=0;
  Compensabile:=0;
  Compensabile1:=0;
  Compensabile2:=0;
  Riporto:=0;
  Riporto1:=0;
  Riporto2:=0;
end;

procedure TA091FStampa.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var i:Integer;
    S,NC,D_NC:String;
begin
  QRMemo1.Lines.Clear;
  with A091FLiquidPresenze,A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW do
    for i:=0 to INomeCampo.Count - 1 do
      begin
      NC:=INomeCampo[i];
      D_NC:=NC;
      Insert('D_',D_NC,5);
      S:=Format('%s: %s %s',[INomeLogico[i],TabellaStampa.FieldByName(NC).AsString,TabellaStampa.FieldByName(D_NC).AsString]);
      QRMemo1.Lines.Add(S);
      end;
  Liquidabile1:=0;
  Liquidato1:=0;
  Residuo1:=0;
  Compensabile1:=0;
  Riporto1:=0;
end;

procedure TA091FStampa.FormCreate(Sender: TObject);
begin
  RepR.useQR5Justification:=True;
end;

procedure TA091FStampa.QRBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
  var Comodo: Integer;
begin
  with A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.TabellaStampa do
    begin
    Comodo:=R180OreMinutiExt(FieldByName('Liquidabile').AsString);
    Inc(Liquidabile,Comodo);
    Inc(Liquidabile1,Comodo);
    Comodo:=R180OreMinutiExt(FieldByName('Liquidato').AsString);
    Inc(Liquidato,Comodo);
    Inc(Liquidato1,Comodo);
    Comodo:=R180OreMinutiExt(FieldByName('Residuo').AsString);
    Inc(Residuo,Comodo);
    Inc(Residuo1,Comodo);
    Comodo:=R180OreMinutiExt(FieldByName('Compensabile').AsString);
    Inc(Compensabile,Comodo);
    Inc(Compensabile1,Comodo);
    Comodo:=R180OreMinutiExt(FieldByName('Riporto').AsString);
    Inc(Riporto,Comodo);
    Inc(Riporto1,Comodo);
  end;
end;

procedure TA091FStampa.QRFoot1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRLLiquidabile1.Caption:=R180MinutiOre(Liquidabile1);
  QRLLiquidato1.Caption:=R180MinutiOre(Liquidato1);
  QRLResiduo1.Caption:=R180MinutiOre(Residuo1);
  QRLCompensabile1.Caption:=R180MinutiOre(Compensabile1);
  QRLRiporto1.Caption:=R180MinutiOre(Riporto1);
end;

procedure TA091FStampa.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRLLiquidabile.Caption:=R180MinutiOre(Liquidabile);
  QRLLiquidato.Caption:=R180MinutiOre(Liquidato);
  QRLResiduo.Caption:=R180MinutiOre(Residuo);
  QRLCompensabile.Caption:=R180MinutiOre(Compensabile);
  QRLRiporto.Caption:=R180MinutiOre(Riporto);
end;
procedure TA091FStampa.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var i,L:Integer;
begin
  DatiDettaglio.Caption:='';
  with A091FLiquidPresenze,A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW do
    for i:=0 to DNomeCampo.Count - 1 do
      begin
      if i > 0 then
        DatiDettaglio.Caption:=DatiDettaglio.Caption + ' ';
      if Length(DNomeLogico[i]) > TabellaStampa.FieldByName(DNomeCampo[i]).Size then
        L:=Length(DNomeLogico[i])
      else
        L:=TabellaStampa.FieldByName(DNomeCampo[i]).Size;
      DatiDettaglio.Caption:=DatiDettaglio.Caption + Format('%-*s',[L,TabellaStampa.FieldByName(DNomeCampo[i]).AsString]);
      end;
end;

procedure TA091FStampa.SettaDataset;
begin
  with A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW do
  begin
    RepR.DataSet:=TabellaStampa;
    QRDBTCognomeNome.DataSet:=TabellaStampa;
    QRDBText1.DataSet:=TabellaStampa;
    QRDBText2.DataSet:=TabellaStampa;
    QRDBText3.DataSet:=TabellaStampa;
    QRDBText4.DataSet:=TabellaStampa;
    QRDBText5.DataSet:=TabellaStampa;
    QRDBText6.DataSet:=TabellaStampa;
    QRDBText7.DataSet:=TabellaStampa;
    QRDBText8.DataSet:=TabellaStampa;
  end;
end;
end.
