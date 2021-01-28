unit A167UStampaIncentivi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R002UQREP, QRPDFFilt, QRExport, QRWebFilt, QRCtrls, QuickRpt,
  ExtCtrls, A000UCostanti, A000USessione, A000UInterfaccia, Math, C180FunzioniGenerali;

type
  TElencoTotali = record
    CodTipoQuota,DescTipoQuota:String;
    Intera,Proporzionata,Netta,NettaRisp,Risparmio,NoRisparmio:Real;
  end;

  TA167FStampaIncentivi = class(TR002FQRep)
    QRBDettaglio: TQRBand;
    QRtxtPartTime: TQRDBText;
    qrtxtBadge: TQRDBText;
    qrtxtIncentivi1: TQRDBText;
    qrtxtIncentivi4: TQRDBText;
    qrTxtMatricola: TQRDBText;
    qrTxtNome: TQRDBText;
    qrtxtIncentivi2: TQRDBText;
    qrtxtIncentivi5: TQRDBText;
    qrtxtIncentivi3: TQRDBText;
    qrtxtIncentivi6: TQRDBText;
    qrtxtData: TQRDBText;
    qrbTotali: TQRBand;
    QRLabel3: TQRLabel;
    QRShape1: TQRShape;
    qrbRaggruppamento: TQRGroup;
    qrtxtRaggruppamento: TQRDBText;
    qrbFineRaggruppamento: TQRBand;
    qrlblTotRaggr: TQRLabel;
    QRDBText1: TQRDBText;
    QRBTotIndividuali: TQRBand;
    QRLabel7: TQRLabel;
    QRMemTotIndividuali: TQRMemo;
    QRBIntestazione: TQRGroup;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    qrlblData: TQRLabel;
    qrlblPartTime: TQRLabel;
    QRLabel6: TQRLabel;
    qrlblIncentivi1: TQRLabel;
    qrlblIncentivi2: TQRLabel;
    qrlblIncentivi4: TQRLabel;
    qrlblIncentivi5: TQRLabel;
    qrlblIncentivi6: TQRLabel;
    qrlblIncentivi3: TQRLabel;
    QRMemTotRaggr: TQRMemo;
    QRMemTotGen: TQRMemo;
    procedure QRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qrtxtIncentivi1Print(sender: TObject; var Value: string);
    procedure QRBDettaglioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbFineRaggruppamentoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbRaggruppamentoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbTotIndividualiBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrtxtDataPrint(sender: TObject; var Value: string);
    procedure qrbTotaliBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBIntestazioneAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRBIntestazioneBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    Dec,OldMese:String;
    OldProg,OldProgTot:Integer;
    StampaIntestazione:Boolean;
    TotInd: array of TElencoTotali;
    TotRaggr: array of TElencoTotali;
    TotGen: array of TElencoTotali;
  public
    { Public declarations }
    Valuta:String;
  end;

var
  A167FStampaIncentivi: TA167FStampaIncentivi;

implementation

uses A167URegistraIncentivi, A167URegistraIncentiviDtM;

{$R *.dfm}

procedure TA167FStampaIncentivi.qrbFineRaggruppamentoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var i:Integer;
  s:String;
begin
  inherited;
  qrlblTotRaggr.Caption:='Totale ' + QRep.Dataset.FieldByName('Raggruppamento').AsString + ':';
  QRMemTotRaggr.Lines.Clear;
  for i:=Low(TotRaggr) to High(TotRaggr) do
  begin
    s:=Format('%-20s',[Copy(TotRaggr[i].DescTipoQuota,1,20)]);
    if qrTxtIncentivi1.Enabled then
    begin
      if TotRaggr[i].Intera <> 0 then
      begin
        if R180IndexOf(A167FRegistraIncentivi.lstColonne,'6',1) >= 0 then
          s:=s + ' ' + Format('%10s',[R180MinutiOre(Trunc(TotRaggr[i].Intera))])
        else
          s:=s + ' ' + Format('%10.' + Dec + 'f',[TotRaggr[i].Intera]);
      end
      else
        s:=s + ' ' + Format('%10s',['0   ']);
    end
    else
      s:=s + ' ' + Format('%10s',[' ']);
    if qrTxtIncentivi2.Enabled then
    begin
      if TotRaggr[i].Proporzionata <> 0 then
        s:=s + ' ' + Format('%10.' + Dec + 'f',[TotRaggr[i].Proporzionata])
      else
        s:=s + ' ' + Format('%10s',['0   ']);
    end
    else
      s:=s + ' ' + Format('%10s',[' ']);
    if qrTxtIncentivi3.Enabled then
    begin
      if TotRaggr[i].Netta <> 0 then
        s:=s + ' ' + Format('%10.' + Dec + 'f',[TotRaggr[i].Netta])
      else
        s:=s + ' ' + Format('%10s',['0   ']);
    end
    else
      s:=s + ' ' + Format('%10s',[' ']);
    if qrTxtIncentivi4.Enabled then
    begin
      if TotRaggr[i].NettaRisp <> 0 then
        s:=s + ' ' + Format('%10.' + Dec + 'f',[TotRaggr[i].NettaRisp])
      else
        s:=s + ' ' + Format('%10s',['0   ']);
    end
    else
      s:=s + ' ' + Format('%10s',[' ']);
    if qrTxtIncentivi5.Enabled then
    begin
      if TotRaggr[i].Risparmio <> 0 then
        s:=s + ' ' + Format('%10.' + Dec + 'f',[TotRaggr[i].Risparmio])
      else
        s:=s + ' ' + Format('%10s',['0   ']);
    end
    else
      s:=s + ' ' + Format('%10s',[' ']);
    if qrTxtIncentivi6.Enabled then
    begin
      if TotRaggr[i].NoRisparmio <> 0 then
        s:=s + ' ' + Format('%10.' + Dec + 'f',[TotRaggr[i].NoRisparmio])
      else
        s:=s + ' ' + Format('%10s',['0   ']);
    end
    else
      s:=s + ' ' + Format('%10s',[' ']);
    QRMemTotRaggr.Lines.Add(s);
  end;
end;

procedure TA167FStampaIncentivi.QRBIntestazioneAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  inherited;
  StampaIntestazione:=False;
end;

procedure TA167FStampaIncentivi.QRBIntestazioneBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  PrintBand:=StampaIntestazione;
end;

procedure TA167FStampaIncentivi.qrbRaggruppamentoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  SetLength(TotRaggr,0);
end;

procedure TA167FStampaIncentivi.QRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
var i:Integer;
begin
  inherited;
  LEnte.Caption:=Parametri.Azienda;
  LTitolo.Caption:='Elaborazione da ' + A167FregistraIncentivi.edtDaData.Text + ' a ' + A167FregistraIncentivi.edtAData.Text + ': ' + A167FRegistraIncentivi.cmbTipoCalcolo.Items[A167FRegistraIncentivi.cmbTipoCalcolo.ItemIndex];
  Dec:='0';
  if FloatToStr(A167FRegistraIncentivi.Decimali) = '0,1' then
    Dec:='1'
  else if FloatToStr(A167FRegistraIncentivi.Decimali) = '0,01' then
    Dec:='2'
  else if FloatToStr(A167FRegistraIncentivi.Decimali) = '0,001' then
    Dec:='3';
  SetLength(TotGen,0);
  QRep.Dataset.First;
  OldProg:=0;
  OldMese:='';
  OldProgTot:=QRep.DataSet.FieldByName('PROGRESSIVO').AsInteger;
  for i:=0 to QrbDettaglio.ControlCount - 1 do
    TqrDbText(QrbDettaglio.Controls[i]).DataSet:=QRep.Dataset;
  for i:=0 to QrbRaggruppamento.ControlCount - 1 do
    TqrDbText(QrbRaggruppamento.Controls[i]).DataSet:=QRep.Dataset;
  with A167FRegistraIncentivi do
  begin
    StampaIntestazione:=True;
    qrbIntestazione.Expression:=QRep.Dataset.Name + '.Progressivo';
    qrbRaggruppamento.Enabled:=Trim(dcmbCampoAnag.Text) <> '';
    qrbFineRaggruppamento.Enabled:=Trim(dcmbCampoAnag.Text) <> '';
    if qrbRaggruppamento.Enabled then
    begin
      qrbRaggruppamento.Expression:=QRep.Dataset.Name + '.Raggruppamento';
      qrbRaggruppamento.ForceNewPage:=chkSaltoPagina.Checked;
    end;
    qrbTotIndividuali.Enabled:=chkDettaglio.Checked;
    qrLblData.Enabled:=chkDettaglio.Checked;
    qrTxtData.Enabled:=chkDettaglio.Checked;

    qrlblIncentivi1.Enabled:=(R180IndexOf(lstColonne,'0',1) >= 0) or (R180IndexOf(lstColonne,'6',1) >= 0);
    qrTxtIncentivi1.Enabled:=(R180IndexOf(lstColonne,'0',1) >= 0) or (R180IndexOf(lstColonne,'6',1) >= 0);
    qrlblIncentivi2.Enabled:=(R180IndexOf(lstColonne,'1',1) >= 0) or (R180IndexOf(lstColonne,'6',1) >= 0);
    qrTxtIncentivi2.Enabled:=(R180IndexOf(lstColonne,'1',1) >= 0) or (R180IndexOf(lstColonne,'6',1) >= 0);
    qrlblIncentivi3.Enabled:=R180IndexOf(lstColonne,'2',1) >= 0;
    qrTxtIncentivi3.Enabled:=R180IndexOf(lstColonne,'2',1) >= 0;
    qrlblIncentivi4.Enabled:=R180IndexOf(lstColonne,'3',1) >= 0;
    qrTxtIncentivi4.Enabled:=R180IndexOf(lstColonne,'3',1) >= 0;
    qrlblIncentivi5.Enabled:=R180IndexOf(lstColonne,'4',1) >= 0;
    qrTxtIncentivi5.Enabled:=R180IndexOf(lstColonne,'4',1) >= 0;
    qrlblIncentivi6.Enabled:=R180IndexOf(lstColonne,'5',1) >= 0;
    qrTxtIncentivi6.Enabled:=R180IndexOf(lstColonne,'5',1) >= 0;
    if R180IndexOf(lstColonne,'6',1) >= 0 then
    begin
      qrlblIncentivi1.Caption:='Numero ore';
      qrlblIncentivi2.Caption:='Importo';
    end;
  end;
end;

procedure TA167FStampaIncentivi.qrbTotaliBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var i:Integer;
  s:String;
begin
  inherited;
  QRMemTotGen.Lines.Clear;
  for i:=Low(TotGen) to High(TotGen) do
  begin
    s:=Format('%-20s',[Copy(TotGen[i].DescTipoQuota,1,20)]);
    if qrTxtIncentivi1.Enabled then
    begin
      if TotGen[i].Intera <> 0 then
      begin
        if R180IndexOf(A167FRegistraIncentivi.lstColonne,'6',1) >= 0 then
          s:=s + ' ' + Format('%10s',[R180MinutiOre(Trunc(TotGen[i].Intera))])
        else
          s:=s + ' ' + Format('%10.' + Dec + 'f',[TotGen[i].Intera]);
      end
      else
        s:=s + ' ' + Format('%10s',['0   ']);
    end
    else
      s:=s + ' ' + Format('%10s',[' ']);
    if qrTxtIncentivi2.Enabled then
    begin
      if TotGen[i].Proporzionata <> 0 then
        s:=s + ' ' + Format('%10.' + Dec + 'f',[TotGen[i].Proporzionata])
      else
        s:=s + ' ' + Format('%10s',['0   ']);
    end
    else
      s:=s + ' ' + Format('%10s',[' ']);
    if qrTxtIncentivi3.Enabled then
    begin
      if TotGen[i].Netta <> 0 then
        s:=s + ' ' + Format('%10.' + Dec + 'f',[TotGen[i].Netta])
      else
        s:=s + ' ' + Format('%10s',['0   ']);
    end
    else
      s:=s + ' ' + Format('%10s',[' ']);
    if qrTxtIncentivi4.Enabled then
    begin
      if TotGen[i].NettaRisp <> 0 then
        s:=s + ' ' + Format('%10.' + Dec + 'f',[TotGen[i].NettaRisp])
      else
        s:=s + ' ' + Format('%10s',['0   ']);
    end
    else
      s:=s + ' ' + Format('%10s',[' ']);
    if qrTxtIncentivi5.Enabled then
    begin
      if TotGen[i].Risparmio <> 0 then
        s:=s + ' ' + Format('%10.' + Dec + 'f',[TotGen[i].Risparmio])
      else
        s:=s + ' ' + Format('%10s',['0   ']);
    end
    else
      s:=s + ' ' + Format('%10s',[' ']);
    if qrTxtIncentivi6.Enabled then
    begin
      if TotGen[i].NoRisparmio <> 0 then
        s:=s + ' ' + Format('%10.' + Dec + 'f',[TotGen[i].NoRisparmio])
      else
        s:=s + ' ' + Format('%10s',['0   ']);
    end
    else
      s:=s + ' ' + Format('%10s',[' ']);
    QRMemTotGen.Lines.Add(s);
  end;
end;

procedure TA167FStampaIncentivi.qrbTotIndividualiBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var i:Integer;
  s:String;
begin
  inherited;
  QRMemTotIndividuali.Lines.Clear;
  for i:=Low(TotInd) to High(TotInd) do
  begin
    s:=Format('%-20s',[Copy(TotInd[i].DescTipoQuota,1,20)]);
    if qrTxtIncentivi1.Enabled then
    begin
      if TotInd[i].Intera <> 0 then
      begin
        if R180IndexOf(A167FRegistraIncentivi.lstColonne,'6',1) >= 0 then
          s:=s + ' ' + Format('%10s',[R180MinutiOre(Trunc(TotInd[i].Intera))])
        else
          s:=s + ' ' + Format('%10.' + Dec + 'f',[TotInd[i].Intera]);
      end
      else
        s:=s + ' ' + Format('%10s',['0   ']);
    end
    else
      s:=s + ' ' + Format('%10s',[' ']);
    if qrTxtIncentivi2.Enabled then
    begin
      if TotInd[i].Proporzionata <> 0 then
        s:=s + ' ' + Format('%10.' + Dec + 'f',[TotInd[i].Proporzionata])
      else
        s:=s + ' ' + Format('%10s',['0   ']);
    end
    else
      s:=s + ' ' + Format('%10s',[' ']);
    if qrTxtIncentivi3.Enabled then
    begin
      if TotInd[i].Netta <> 0 then
        s:=s + ' ' + Format('%10.' + Dec + 'f',[TotInd[i].Netta])
      else
        s:=s + ' ' + Format('%10s',['0   ']);
    end
    else
      s:=s + ' ' + Format('%10s',[' ']);
    if qrTxtIncentivi4.Enabled then
    begin
      if TotInd[i].NettaRisp <> 0 then
        s:=s + ' ' + Format('%10.' + Dec + 'f',[TotInd[i].NettaRisp])
      else
        s:=s + ' ' + Format('%10s',['0   ']);
    end
    else
      s:=s + ' ' + Format('%10s',[' ']);
    if qrTxtIncentivi5.Enabled then
    begin
      if TotInd[i].Risparmio <> 0 then
        s:=s + ' ' + Format('%10.' + Dec + 'f',[TotInd[i].Risparmio])
      else
        s:=s + ' ' + Format('%10s',['0   ']);
    end
    else
      s:=s + ' ' + Format('%10s',[' ']);
    if qrTxtIncentivi6.Enabled then
    begin
      if TotInd[i].NoRisparmio <> 0 then
        s:=s + ' ' + Format('%10.' + Dec + 'f',[TotInd[i].NoRisparmio])
      else
        s:=s + ' ' + Format('%10s',['0   ']);
    end
    else
      s:=s + ' ' + Format('%10s',[' ']);
    QRMemTotIndividuali.Lines.Add(s);
  end;

  QRep.Dataset.Next;
  if not QRep.Dataset.Eof then
  begin
    PrintBand:=OldProgTot <> QRep.Dataset.FieldByName('PROGRESSIVO').AsInteger;
    OldProgTot:=QRep.DataSet.FieldByName('PROGRESSIVO').AsInteger;
    QRep.Dataset.Prior;
  end;
end;

procedure TA167FStampaIncentivi.QRBDettaglioBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var i:Integer;
  Trovato:Boolean;
begin
  inherited;
  if QRep.DataSet.FieldByName('PROGRESSIVO').AsInteger <> OldProg then
    SetLength(TotInd,0);
  qrTxtBadge.Enabled:=QRep.DataSet.FieldByName('PROGRESSIVO').AsInteger <> OldProg;
  qrTxtMatricola.Enabled:=QRep.DataSet.FieldByName('PROGRESSIVO').AsInteger <> OldProg;
  qrTxtNome.Enabled:=QRep.DataSet.FieldByName('PROGRESSIVO').AsInteger <> OldProg;
  qrTxtData.Enabled:=QRep.DataSet.FieldByName('MESE').AsString <> OldMese;
  OldProg:=QRep.DataSet.FieldByName('PROGRESSIVO').AsInteger;
  OldMese:=QRep.DataSet.FieldByName('MESE').AsString;

  //Totalizzazioni individuali
  Trovato:=False;
  for i:=Low(TotInd) to High(TotInd) do
    if TotInd[i].CodTipoQuota = QRep.DataSet.FieldByName('CodTipoQuota').AsString then
    begin
      Trovato:=True;
      TotInd[i].Intera:=TotInd[i].Intera + QRep.DataSet.FieldByName('QuotaIntera').AsFloat;
      TotInd[i].Proporzionata:=TotInd[i].Proporzionata + QRep.DataSet.FieldByName('QuotaProporzionata').AsFloat;
      TotInd[i].Netta:=TotInd[i].Netta + QRep.DataSet.FieldByName('QuotaNetta').AsFloat;
      TotInd[i].NettaRisp:=TotInd[i].NettaRisp + QRep.DataSet.FieldByName('QuotaNettaRisp').AsFloat;
      TotInd[i].Risparmio:=TotInd[i].Risparmio + QRep.DataSet.FieldByName('AbbRispIncentivi').AsFloat;
      TotInd[i].NoRisparmio:=TotInd[i].NoRisparmio + QRep.DataSet.FieldByName('AbbNoRispIncentivi').AsFloat;
    end;
  if not Trovato then
  begin
    SetLength(TotInd,Length(TotInd) + 1);
    TotInd[High(TotInd)].CodTipoQuota:=QRep.DataSet.FieldByName('CodTipoQuota').AsString;
    TotInd[High(TotInd)].DescTipoQuota:=QRep.DataSet.FieldByName('DescTipoQuota').AsString;
    TotInd[High(TotInd)].Intera:=QRep.DataSet.FieldByName('QuotaIntera').AsFloat;
    TotInd[High(TotInd)].Proporzionata:=QRep.DataSet.FieldByName('QuotaProporzionata').AsFloat;
    TotInd[High(TotInd)].Netta:=QRep.DataSet.FieldByName('QuotaNetta').AsFloat;
    TotInd[High(TotInd)].NettaRisp:=QRep.DataSet.FieldByName('QuotaNettaRisp').AsFloat;
    TotInd[High(TotInd)].Risparmio:=QRep.DataSet.FieldByName('AbbRispIncentivi').AsFloat;
    TotInd[High(TotInd)].NoRisparmio:=QRep.DataSet.FieldByName('AbbNoRispIncentivi').AsFloat;
  end;
  //Totalizzazioni raggruppamento
  Trovato:=False;
  for i:=Low(TotRaggr) to High(TotRaggr) do
    if ((R180IndexOf(A167FRegistraIncentivi.lstColonne,'6',1) >= 0) and
        (TotRaggr[i].CodTipoQuota = QRep.DataSet.FieldByName('CodTipoQuota').AsString + '#' +
                                  QRep.DataSet.FieldByName('QuotaProporzionata').AsString)) or
       ((R180IndexOf(A167FRegistraIncentivi.lstColonne,'6',1) < 0) and
        (TotRaggr[i].CodTipoQuota = QRep.DataSet.FieldByName('CodTipoQuota').AsString)) then
    begin
      Trovato:=True;
      TotRaggr[i].Intera:=TotRaggr[i].Intera + QRep.DataSet.FieldByName('QuotaIntera').AsFloat;
      if (R180IndexOf(A167FRegistraIncentivi.lstColonne,'6',1) >= 0) then
        TotRaggr[i].Proporzionata:=QRep.DataSet.FieldByName('QuotaProporzionata').AsFloat
      else
        TotRaggr[i].Proporzionata:=TotRaggr[i].Proporzionata + QRep.DataSet.FieldByName('QuotaProporzionata').AsFloat;
      TotRaggr[i].Netta:=TotRaggr[i].Netta + QRep.DataSet.FieldByName('QuotaNetta').AsFloat;
      TotRaggr[i].NettaRisp:=TotRaggr[i].NettaRisp + QRep.DataSet.FieldByName('QuotaNettaRisp').AsFloat;
      TotRaggr[i].Risparmio:=TotRaggr[i].Risparmio + QRep.DataSet.FieldByName('AbbRispIncentivi').AsFloat;
      TotRaggr[i].NoRisparmio:=TotRaggr[i].NoRisparmio + QRep.DataSet.FieldByName('AbbNoRispIncentivi').AsFloat;
    end;
  if not Trovato then
  begin
    SetLength(TotRaggr,Length(TotRaggr) + 1);
    if R180IndexOf(A167FRegistraIncentivi.lstColonne,'6',1) >= 0 then
      TotRaggr[High(TotRaggr)].CodTipoQuota:=QRep.DataSet.FieldByName('CodTipoQuota').AsString + '#' +
                                             QRep.DataSet.FieldByName('QuotaProporzionata').AsString
    else
      TotRaggr[High(TotRaggr)].CodTipoQuota:=QRep.DataSet.FieldByName('CodTipoQuota').AsString;
    TotRaggr[High(TotRaggr)].DescTipoQuota:=QRep.DataSet.FieldByName('DescTipoQuota').AsString;
    TotRaggr[High(TotRaggr)].Intera:=QRep.DataSet.FieldByName('QuotaIntera').AsFloat;
    TotRaggr[High(TotRaggr)].Proporzionata:=QRep.DataSet.FieldByName('QuotaProporzionata').AsFloat;
    TotRaggr[High(TotRaggr)].Netta:=QRep.DataSet.FieldByName('QuotaNetta').AsFloat;
    TotRaggr[High(TotRaggr)].NettaRisp:=QRep.DataSet.FieldByName('QuotaNettaRisp').AsFloat;
    TotRaggr[High(TotRaggr)].Risparmio:=QRep.DataSet.FieldByName('AbbRispIncentivi').AsFloat;
    TotRaggr[High(TotRaggr)].NoRisparmio:=QRep.DataSet.FieldByName('AbbNoRispIncentivi').AsFloat;
  end;
  //Totalizzazioni generali
  Trovato:=False;
  for i:=Low(TotGen) to High(TotGen) do
    if ((R180IndexOf(A167FRegistraIncentivi.lstColonne,'6',1) >= 0) and
        (TotGen[i].CodTipoQuota = QRep.DataSet.FieldByName('CodTipoQuota').AsString + '#' +
                                  QRep.DataSet.FieldByName('QuotaProporzionata').AsString)) or
       ((R180IndexOf(A167FRegistraIncentivi.lstColonne,'6',1) < 0) and
        (TotGen[i].CodTipoQuota = QRep.DataSet.FieldByName('CodTipoQuota').AsString)) then
    begin
      Trovato:=True;
      TotGen[i].Intera:=TotGen[i].Intera + QRep.DataSet.FieldByName('QuotaIntera').AsFloat;
      if (R180IndexOf(A167FRegistraIncentivi.lstColonne,'6',1) >= 0) then
        TotGen[i].Proporzionata:=QRep.DataSet.FieldByName('QuotaProporzionata').AsFloat
      else
        TotGen[i].Proporzionata:=TotGen[i].Proporzionata + QRep.DataSet.FieldByName('QuotaProporzionata').AsFloat;
      TotGen[i].Netta:=TotGen[i].Netta + QRep.DataSet.FieldByName('QuotaNetta').AsFloat;
      TotGen[i].NettaRisp:=TotGen[i].NettaRisp + QRep.DataSet.FieldByName('QuotaNettaRisp').AsFloat;
      TotGen[i].Risparmio:=TotGen[i].Risparmio + QRep.DataSet.FieldByName('AbbRispIncentivi').AsFloat;
      TotGen[i].NoRisparmio:=TotGen[i].NoRisparmio + QRep.DataSet.FieldByName('AbbNoRispIncentivi').AsFloat;
    end;
  if not Trovato then
  begin
    SetLength(TotGen,Length(TotGen) + 1);
    if R180IndexOf(A167FRegistraIncentivi.lstColonne,'6',1) >= 0 then
      TotGen[High(TotGen)].CodTipoQuota:=QRep.DataSet.FieldByName('CodTipoQuota').AsString + '#' +
                                         QRep.DataSet.FieldByName('QuotaProporzionata').AsString
    else
      TotGen[High(TotGen)].CodTipoQuota:=QRep.DataSet.FieldByName('CodTipoQuota').AsString;
    TotGen[High(TotGen)].DescTipoQuota:=QRep.DataSet.FieldByName('DescTipoQuota').AsString;
    TotGen[High(TotGen)].Intera:=QRep.DataSet.FieldByName('QuotaIntera').AsFloat;
    TotGen[High(TotGen)].Proporzionata:=QRep.DataSet.FieldByName('QuotaProporzionata').AsFloat;
    TotGen[High(TotGen)].Netta:=QRep.DataSet.FieldByName('QuotaNetta').AsFloat;
    TotGen[High(TotGen)].NettaRisp:=QRep.DataSet.FieldByName('QuotaNettaRisp').AsFloat;
    TotGen[High(TotGen)].Risparmio:=QRep.DataSet.FieldByName('AbbRispIncentivi').AsFloat;
    TotGen[High(TotGen)].NoRisparmio:=QRep.DataSet.FieldByName('AbbNoRispIncentivi').AsFloat;
  end;
end;

procedure TA167FStampaIncentivi.qrtxtDataPrint(sender: TObject;
  var Value: string);
begin
  inherited;
  Value:=R180NomeMese(StrToIntDef(Value,0));
end;

procedure TA167FStampaIncentivi.qrtxtIncentivi1Print(sender: TObject; var Value: string);
begin
  inherited;
  if StrToFloatDef(Value,0) = 0 then
    Value:='     0    '
  else
  begin
    if (R180IndexOf(A167FRegistraIncentivi.lstColonne,'6',1) >= 0) and (Sender = qrtxtIncentivi1) then
      Value:=Format('%9s',[R180MinutiOre(StrToIntDef(Value,0))])
    else
      Value:=Format('%9.' + Dec + 'f',[StrToFloatDef(Value,0)]);
    if (A167FRegistraIncentivi.rgpTipoDati.ItemIndex = 0) and
       (QRep.DataSet.FieldByName('Var' + TQRDbText(Sender).DataField).AsString = 'S') then
      Value:=Value + '*'
    else
      Value:=Value + ' ';
  end;
end;

end.
