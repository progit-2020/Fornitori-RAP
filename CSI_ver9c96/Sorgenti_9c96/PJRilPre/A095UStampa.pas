unit A095UStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, quickrpt, ExtCtrls, Qrctrls, A000UCostanti, A000USessione,A000UInterfaccia,C180FunzioniGenerali, Variants,
  QRExport, QRWebFilt, QRPDFFilt;

type
  TA095FStampa = class(TForm)
    RepR: TQuickRep;
    QRBTitolo: TQRBand;
    QRLTitolo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRBand1: TQRBand;
    QRGroup1:TQRGroup;
    QRDBTNome: TQRDBText;
    QRBIntestazione: TQRBand;
    QRDBTCognome: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLEnte: TQRLabel;
    QRFoot1: TQRBand;
    QRLTot1: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRBand2: TQRBand;
    QRLabel10: TQRLabel;
    QRLTFuori: TQRLabel;
    QRLTPagati: TQRLabel;
    QRLTResi: TQRLabel;
    QRLTliqi: TQRLabel;
    QRLTFuori1: TQRLabel;
    QRLTPagati1: TQRLabel;
    QRLTliqi1: TQRLabel;
    QRLTResi1: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLTStra1: TQRLabel;
    QRLTStra: TQRLabel;
    QRDBText8: TQRDBText;
    QRLabel24: TQRLabel;
    DatiDettaglio: TQRLabel;
    NomiDettaglio: TQRLabel;
    QRMemo1: TQRMemo;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    Anomalia: TQRLabel;
    QRDBText2: TQRDBText;
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
    Fuo,Fuo1,Fuo2: Integer;
    Pag,Pag1,Pag2: Integer;
    Liq,Liq1,Liq2: Integer;
    Res,Res1,Res2: Integer;
    Str,Str1,Str2: Integer;
  public
    { Public declarations }
    procedure CreaReport(Preview:Boolean);
    procedure SettaDataset;
  end;

var
  A095FStampa: TA095FStampa;

implementation

uses A095UStRiasStr,A095UStRiasStrDtM1;
{$R *.DFM}

//------------------------------------------------------------------------------
procedure TA095FStampa.CreaReport(Preview:Boolean);
begin
  if PreView then
    RepR.Preview
  else
    RepR.Print;
end;

procedure TA095FStampa.RepRBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  QRLEnte.Caption:=Parametri.DAzienda;
  QRLTitolo.Caption:='Stampa Riassuntiva Straordinari del mese di ' +
                      R180NomeMese(A095FStRiasStr.SEMese.Value) + ' ' +IntToStr(A095FStRiasStr.SEAnno.Value);
  if A095FStRiasStr.chkLiquidazione.Checked then
    QRLTitolo.Caption:=QRLTitolo.Caption + ' con Liquidazione Automatica';
  Fuo:=0;
  Fuo1:=0;
  Fuo2:=0;
  Pag:=0;
  Pag1:=0;
  Pag2:=0;
  Liq:=0;
  Liq1:=0;
  Liq2:=0;
  Res:=0;
  Res1:=0;
  Res2:=0;
  Str:=0;
  Str1:=0;
  Str2:=0;
end;

procedure TA095FStampa.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var i:Integer;
    S,NC,D_NC:String;
begin
  QRMemo1.Lines.Clear;
  with A095FStRiasStrDtM1.A095FStRiasStrMW do
  begin
    for i:=0 to INomeCampo.Count - 1 do
    begin
      NC:=INomeCampo[i];
      D_NC:=NC;
      Insert('D_',D_NC,5);
      S:=Format('%s: %s %s',[INomeLogico[i],TabellaStampa.FieldByName(NC).AsString,TabellaStampa.FieldByName(D_NC).AsString]);
      QRMemo1.Lines.Add(S);
    end;
  end;
  Fuo1:=0;
  Pag1:=0;
  Liq1:=0;
  Res1:=0;
  Str1:=0;
end;

procedure TA095FStampa.FormCreate(Sender: TObject);
begin
  RepR.useQR5Justification:=True;
end;

procedure TA095FStampa.QRBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
  var Comodo: Integer;
begin
  with A095FStRiasStrDtM1.A095FStRiasStrMW.TabellaStampa do
  begin
    Comodo:=R180OreMinutiExt(FieldByName('TotStrF').AsString);
    Inc(Fuo,Comodo);
    Inc(Fuo1,Comodo);
    Comodo:=R180OreMinutiExt(FieldByName('StrPag').AsString);
    Inc(Pag,Comodo);
    Inc(Pag1,Comodo);
    Comodo:=R180OreMinutiExt(FieldByName('StrIn').AsString);
    Inc(Liq,Comodo);
    Inc(Liq1,Comodo);
    Comodo:=R180OreMinutiExt(FieldByName('EccRes').AsString);
    Inc(Res,Comodo);
    Inc(Res1,Comodo);
    Comodo:=R180OreMinutiExt(FieldByName('StrLiq').AsString);
    Inc(Str,Comodo);
    Inc(Str1,Comodo);
  end;
end;

procedure TA095FStampa.QRFoot1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRLTFuori1.Caption:=R180MinutiOre(Fuo1);
  QRLTPagati1.Caption:=R180MinutiOre(Pag1);
  QRLTLiqi1.Caption:=R180MinutiOre(Liq1);
  QRLTResi1.Caption:=R180MinutiOre(Res1);
  QRLTStra1.Caption:=R180MinutiOre(Str1);
end;

procedure TA095FStampa.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRLTFuori.Caption:=R180MinutiOre(Fuo);
  QRLTPagati.Caption:=R180MinutiOre(Pag);
  QRLTLiqi.Caption:=R180MinutiOre(Liq);
  QRLTResi.Caption:=R180MinutiOre(Res);
  QRLTStra.Caption:=R180MinutiOre(Str);
end;

procedure TA095FStampa.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var i,L:Integer;
begin
  DatiDettaglio.Caption:='';
  with A095FStRiasStrDtM1.A095FStRiasStrMW do
  begin
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
end;

procedure TA095FStampa.SettaDataset;
begin
  with A095FStRiasStrDtM1.A095FStRiasStrMW do
  begin
    RepR.DataSet:=TabellaStampa;
    QRDBTNome.DataSet:=TabellaStampa;
    QRDBTCognome.DataSet:=TabellaStampa;
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
