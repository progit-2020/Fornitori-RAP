unit A074UStampaBuoni;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls,C180FunzioniGenerali, QRExport, Variants,
  QRWebFilt, QRPDFFilt;

type
  TTotale = record
    M,V,A:Integer;
  end;

  TA074FStampaBuoni = class(TForm)
    RepR: TQuickRep;
    QRBTitolo: TQRBand;
    QRLTitolo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRBDettaglio: TQRBand;
    QRBIntestazione: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    QRLAzienda: TQRLabel;
    LPeriodo: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel3: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText6: TQRDBText;
    QRBand1: TQRBand;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    LAnomalia: TQRLabel;
    QRLabel8: TQRLabel;
    QRBand2: TQRBand;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRGroup2: TQRGroup;
    LRagg: TQRLabel;
    QRDBText7: TQRDBText;
    QRGroup1: TQRGroup;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText5: TQRDBText;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    SummaryBand1: TQRBand;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    procedure QRBDettaglioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText3Print(sender: TObject; var Value: string);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    TotBuoni:array[1..3] of TTotale;
    TotTicket:array[1..3] of TTotale;
  public
    { Public declarations }
    DataI,DataF:TDateTime;
    procedure CreaReport;
  end;

var
  A074FStampaBuoni: TA074FStampaBuoni;

implementation

uses A074URiepilogoBuoni, A074URiepilogoBuoniDtM1, R350UCalcoloBuoniDtM;

{$R *.DFM}

procedure TA074FStampaBuoni.CreaReport;
begin
  RepR.Preview;
end;

procedure TA074FStampaBuoni.RepRBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  TotBuoni[3].M:=0;
  TotTicket[3].M:=0;
  TotBuoni[3].V:=0;
  TotTicket[3].V:=0;
  TotBuoni[3].A:=0;
  TotTicket[3].A:=0;
end;

procedure TA074FStampaBuoni.QRGroup2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  TotBuoni[2].M:=0;
  TotTicket[2].M:=0;
  TotBuoni[2].V:=0;
  TotTicket[2].V:=0;
  TotBuoni[2].A:=0;
  TotTicket[2].A:=0;
end;

procedure TA074FStampaBuoni.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  TotBuoni[1].M:=0;
  TotTicket[1].M:=0;
end;

procedure TA074FStampaBuoni.QRBDettaglioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var i:Byte;
begin
  PrintBand:=A074FRiepilogoBuoni.ChkDettaglio.Checked and A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.TabellaStampa.FieldByName('Stampa').AsBoolean;
  for i:=1 to 3 do
  begin
    inc(TotBuoni[i].M, A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.TabellaStampa.FieldByName('Buoni').AsInteger);
    inc(TotTicket[i].M, A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.TabellaStampa.FieldByName('Ticket').AsInteger);
  end;
  LAnomalia.Caption:=A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.TabellaStampa.FieldByName('Anomalia').AsString;
end;

procedure TA074FStampaBuoni.QRDBText3Print(sender: TObject; var Value: string);
begin
  with A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM do
    if TabellaStampa.FieldByName('MANUALE').AsString = 'S' then
      Value:='Variazione(' + R180NomeMese(R180Mese(TabellaStampa.FieldByName('DATA').AsDateTime)) + ')';
end;

procedure TA074FStampaBuoni.FormCreate(Sender: TObject);
begin
  RepR.useQR5Justification:=True;
end;

procedure TA074FStampaBuoni.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var A1,A2,M1,M2,G:Word;
    i,j,VarBuoni,VarTicket,VB,VT:Integer;
    AcqBuoni,AcqTicket:Integer;
    Segno:String;
begin
  DecodeDate(DataI,A1,M1,G);
  DecodeDate(DataF,A2,M2,G);
  j:=M1;
  VarBuoni:=0;
  VarTicket:=0;
  for i:=A1 to A2 do
    while True do
    begin
      A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.GetVariazioni(RepR.DataSet.FieldByName('PROGRESSIVO').AsInteger,i,j,VB,VT);
      inc(VarBuoni,VB);
      inc(VarTicket,VT);
      if (i = A2) and (j = M2) then
        Break;
      inc(j);
      if j = 13 then
      begin
        j:=1;
        Break;
      end;
    end;
  inc(TotBuoni[2].V,VarBuoni);
  inc(TotTicket[2].V,VarTicket);
  inc(TotBuoni[3].V,VarBuoni);
  inc(TotTicket[3].V,VarTicket);
  QRLabel6.Caption:=IntToStr(TotBuoni[1].M);
  QRLabel7.Caption:=IntToStr(TotTicket[1].M);
  if VarBuoni <> 0 then
  begin
    Segno:='';
    if VarBuoni > 0 then
      Segno:='+';
    QRLabel6.Caption:=QRLabel6.Caption + Format('(%s%d)',[Segno,VarBuoni]);
  end;
  if VarTicket <> 0 then
  begin
    Segno:='';
    if VarTicket > 0 then
      Segno:='+';
    QRLabel7.Caption:=QRLabel7.Caption + Format('(%s%d)',[Segno,VarTicket]);
  end;
  if A074FRiepilogoBuoni.ChkAcquisto.Checked then
  begin
    with A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.Q690 do
    begin
      SetVariable('PROGRESSIVO',RepR.DataSet.FieldByName('PROGRESSIVO').AsInteger);
      if A074FRiepilogoBuoni.ChkInizioAnno.Checked then
        SetVariable('DATA1',StrToDate(FormatDateTime('01/01/yyyy',DataI)))
      else
        SetVariable('DATA1',DataI);
      SetVariable('DATA2',DataF);
      Execute;
      AcqBuoni:=StrToIntDef(VarToStr(GetVariable('BUONI')),0);
      AcqTicket:=StrToIntDef(VarToStr(GetVariable('TICKET')),0);
      if A074FRiepilogoBuoni.ChkInizioAnno.Checked then
      begin
        A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.Q692.Close;
        A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.Q692.SetVariable('Progressivo',RepR.DataSet.FieldByName('PROGRESSIVO').AsInteger);
        A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.Q692.SetVariable('Data',DataF);
        A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.Q692.Open;
        if A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.Q692.RecordCount > 0 then
        begin
          inc(AcqBuoni,A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.Q692.FieldByName('BuoniPasto').AsInteger);
          inc(AcqTicket,A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.Q692.FieldByName('Ticket').AsInteger);
        end;
      end;
      QRLabel12.Caption:=IntToStr(AcqBuoni);
      QRLabel13.Caption:=IntToStr(AcqTicket);
      QRLabel25.Caption:=IntToStr(AcqBuoni - (TotBuoni[1].M + VarBuoni));
      QRLabel28.Caption:=IntToStr(AcqTicket - (TotTicket[1].M + VarTicket));
      inc(TotBuoni[2].A,AcqBuoni);
      inc(TotTicket[2].A,AcqTicket);
      inc(TotBuoni[3].A,AcqBuoni);
      inc(TotTicket[3].A,AcqTicket);
      Close;
    end;
  end;
end;

procedure TA074FStampaBuoni.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var Segno:String;
begin
  QRLabel9.Caption:=IntToStr(TotBuoni[2].M);
  QRLabel10.Caption:=IntToStr(TotTicket[2].M);
  if TotBuoni[2].V <> 0 then
  begin
    Segno:='';
    if TotBuoni[2].V > 0 then
      Segno:='+';
    QRLabel9.Caption:=QRLabel9.Caption + Format('(%s%d)',[Segno,TotBuoni[2].V]);
  end;
  if TotTicket[2].V <> 0 then
  begin
    Segno:='';
    if TotTicket[2].V > 0 then
      Segno:='+';
    QRLabel10.Caption:=QRLabel10.Caption + Format('(%s%d)',[Segno,TotTicket[2].V]);
  end;
  QRLabel14.Caption:=IntToStr(TotBuoni[2].A);
  QRLabel15.Caption:=IntToStr(TotTicket[2].A);
  QRLabel26.Caption:=IntToStr(TotBuoni[2].A - (TotBuoni[2].M + TotBuoni[2].V));
  QRLabel29.Caption:=IntToStr(TotTicket[2].A - (TotTicket[2].M + TotTicket[2].V));
end;

procedure TA074FStampaBuoni.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var Segno:String;
begin
  QRLabel17.Caption:=IntToStr(TotBuoni[3].M);
  QRLabel18.Caption:=IntToStr(TotTicket[3].M);
  if TotBuoni[3].V <> 0 then
  begin
    Segno:='';
    if TotBuoni[3].V > 0 then
      Segno:='+';
    QRLabel17.Caption:=QRLabel17.Caption + Format('(%s%d)',[Segno,TotBuoni[3].V]);
  end;
  if TotTicket[3].V <> 0 then
  begin
    Segno:='';
    if TotTicket[3].V > 0 then
      Segno:='+';
    QRLabel18.Caption:=QRLabel18.Caption + Format('(%s%d)',[Segno,TotTicket[3].V]);
  end;
  QRLabel19.Caption:=IntToStr(TotBuoni[3].A);
  QRLabel20.Caption:=IntToStr(TotTicket[3].A);
  QRLabel27.Caption:=IntToStr(TotBuoni[3].A - (TotBuoni[3].M + TotBuoni[3].V));
  QRLabel30.Caption:=IntToStr(TotTicket[3].A - (TotTicket[3].M + TotTicket[3].V));
end;

end.
