unit Ac04UStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StrUtils, Math,
  Dialogs, quickrpt, ExtCtrls, Qrctrls, Variants, QRExport, QRWebFilt, QRPDFFilt,
  QRPrntr, OracleData, Oracle, DB,
  A000UCostanti, A000UInterfaccia, A000USessione, C180FunzioniGenerali;

type
  TAc04FStampa = class(TForm)
    RepR: TQuickRep;
    QRBTitolo: TQRBand;
    QRLTitolo: TQRLabel;
    QRLEnte: TQRLabel;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    bndIntestazione: TQRGroup;
    bndTotali: TQRBand;
    bndColonne: TQRChildBand;
    qlblReportingPeriod: TQRLabel;
    qlblDescProgetto: TQRLabel;
    qlblCodProgetto: TQRLabel;
    qlblPartnerName: TQRLabel;
    qlblPartnerNumber: TQRLabel;
    qlblPeriodoStampa: TQRLabel;
    qlblNominativoDip: TQRLabel;
    qlblServizio: TQRLabel;
    qlblFunzione: TQRLabel;
    qlblNominativoResp: TQRLabel;
    dlblReportingPeriod: TQRDBText;
    dlblDescProgetto: TQRDBText;
    dlblCodProgetto: TQRDBText;
    dlblPartnerName: TQRDBText;
    dlblPartnerNumber: TQRDBText;
    dlblNominativoResp: TQRDBText;
    dlblPeriodoStampaDesc: TQRDBText;
    dlblNominativoDip: TQRDBText;
    dlblServizio: TQRDBText;
    dlblFunzione: TQRDBText;
    qlblGiorno: TQRLabel;
    qlblTotAttCod: TQRLabel;
    dlblDescProgetto2: TQRDBText;
    qlblTotGG: TQRLabel;
    qlblAssFestivita: TQRLabel;
    qlblAssAltre: TQRLabel;
    QRShape9: TQRShape;
    qshpColAttCod: TQRShape;
    qshpColProCod: TQRShape;
    qshpColTotAtt: TQRShape;
    QRShape4: TQRShape;
    qshpRigaDiv: TQRShape;
    qlblAltriProgetti: TQRLabel;
    bndDettGG: TQRSubDetail;
    dlblDescGiorno: TQRDBText;
    dlblGiorno: TQRDBText;
    dlblAttHH_1: TQRDBText;
    dlblAttHH_2: TQRDBText;
    dlblAttHH_3: TQRDBText;
    dlblAttHH_4: TQRDBText;
    dlblAttHH_5: TQRDBText;
    dlblAttHH_6: TQRDBText;
    dlblAttHH_7: TQRDBText;
    dlblAttHH_8: TQRDBText;
    dlblAttHH_9: TQRDBText;
    dlblTotAttGG: TQRDBText;
    dlblProHH_1: TQRDBText;
    dlblProHH_2: TQRDBText;
    dlblProHH_3: TQRDBText;
    dlblTotProGG: TQRDBText;
    dlblAssFestivita: TQRDBText;
    dlblAssAltre: TQRDBText;
    dlblTotGG: TQRDBText;
    QRShape27: TQRShape;
    qshpDetProCod: TQRShape;
    qshpDetTotAtt: TQRShape;
    QRShape30: TQRShape;
    QRShape31: TQRShape;
    QRShape35: TQRShape;
    bndFirme: TQRChildBand;
    qlblFirmaDip: TQRLabel;
    qlblFirmaResp: TQRLabel;
    dlblAttCod_1: TQRDBText;
    dlblAttCod_2: TQRDBText;
    dlblAttCod_3: TQRDBText;
    dlblAttCod_4: TQRDBText;
    dlblAttCod_5: TQRDBText;
    dlblAttCod_6: TQRDBText;
    dlblAttCod_7: TQRDBText;
    dlblAttCod_8: TQRDBText;
    dlblAttCod_9: TQRDBText;
    dlblAttTot_1: TQRDBText;
    dlblAttTot_2: TQRDBText;
    dlblAttTot_3: TQRDBText;
    dlblAttTot_4: TQRDBText;
    dlblAttTot_5: TQRDBText;
    dlblAttTot_6: TQRDBText;
    dlblAttTot_7: TQRDBText;
    dlblAttTot_8: TQRDBText;
    dlblAttTot_9: TQRDBText;
    QRShape11: TQRShape;
    qshpTotTotAtt: TQRShape;
    qlblTotMM: TQRLabel;
    qshpTotProCod: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape19: TQRShape;
    dlblTotAttMM: TQRDBText;
    dlblProCod_1: TQRDBText;
    dlblProCod_2: TQRDBText;
    dlblProCod_3: TQRDBText;
    dlblProTot_1: TQRDBText;
    dlblProTot_2: TQRDBText;
    dlblProTot_3: TQRDBText;
    dlblTotProMM: TQRDBText;
    dlblTotMM: TQRDBText;
    dlblAttHH_10: TQRDBText;
    dlblAttCod_10: TQRDBText;
    dlblAttTot_10: TQRDBText;
    qshpColNonRend: TQRShape;
    dlblNonRendHH: TQRDBText;
    dlblNonRendTot: TQRDBText;
    qshpDetNonRend: TQRShape;
    qshpTotNonRend: TQRShape;
    qshpColTotPro: TQRShape;
    qlblTotPro: TQRLabel;
    dlblProCod_4: TQRDBText;
    dlblProHH_4: TQRDBText;
    dlblProTot_4: TQRDBText;
    dlblProHH_5: TQRDBText;
    dlblProCod_5: TQRDBText;
    dlblProTot_5: TQRDBText;
    dlblAttCod_11: TQRDBText;
    dlblAttCod_12: TQRDBText;
    dlblAttHH_11: TQRDBText;
    dlblAttHH_12: TQRDBText;
    dlblAttTot_11: TQRDBText;
    dlblAttTot_12: TQRDBText;
    qlblGiustificaRitardoDip: TQRLabel;
    qlblGiustificaRitardoResp: TQRLabel;
    dlblNonRendCod: TQRDBText;
    qlblTipoTempo: TQRLabel;
    dlblTipoTempo: TQRDBText;
    qimgLogo: TQRImage;
    qlblCUP: TQRLabel;
    dlblCUP: TQRDBText;
    procedure dlblAttHH_1Print(sender: TObject; var Value: string);
    procedure bndIntestazioneAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
    procedure RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure bndDettGGBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure dlblGiornoPrint(sender: TObject; var Value: string);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RepRAfterPreview(Sender: TObject);
    procedure RepRAfterPrint(Sender: TObject);
  private
    { Private declarations }
    ThousandSepOri: Char;
    LeftIniMeseTitolo,LeftIniMeseValore,
    SizeProCod,TopProCod:Integer;
  public
    { Public declarations }
    procedure SettaDataset;
  end;

var
  Ac04FStampa: TAc04FStampa;

implementation

uses Ac04UStampaRendiProj,Ac04UStampaRendiProjDM;
{$R *.DFM}

//------------------------------------------------------------------------------
procedure TAc04FStampa.SettaDataset;
var i,n,nLeft:Integer;
begin
  with Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW do
  begin
    RepR.DataSet:=cdsStampaAnagrafico;
    bndDettGG.DataSet:=cdsStampaDettaglio;
    for i:=0 to Ac04FStampa.ComponentCount - 1 do
      if Ac04FStampa.Components[i] is TQRDBText then
        with TQRDBText(Ac04FStampa.Components[i]) do
          if Parent.Name = 'bndDettGG' then
            DataSet:=cdsStampaDettaglio
          else
            DataSet:=cdsStampaAnagrafico;

    //Posizionamento campi
    //Slot attività
    nLeft:=qshpColAttCod.Left + 2;
    for n:=1 to nAttMax do
    begin
      if n <= 12 then
      begin
        for i:=0 to Ac04FStampa.ComponentCount - 1 do
          if Ac04FStampa.Components[i] is TQRDBText then
            with TQRDBText(Ac04FStampa.Components[i]) do
              if (Pos('Att',Name) > 0)
              and (Copy(Name,Pos('_',Name) + 1) = IntToStr(n)) then
                Left:=nLeft;
      end
      else if n <= (12 + 5) then
      begin
        for i:=0 to Ac04FStampa.ComponentCount - 1 do
          if Ac04FStampa.Components[i] is TQRDBText then
            with TQRDBText(Ac04FStampa.Components[i]) do
              if (Pos('Pro',Name) > 0)
              and (Copy(Name,Pos('_',Name) + 1) = IntToStr(n - 12 + nProMax)) then
              begin
                Left:=nLeft;
                DataField:='ATT' + Copy(DataField,4,Pos('_',DataField) - 3) + IntToStr(n);
              end;
      end
      else
        for i:=0 to Ac04FStampa.ComponentCount - 1 do
          if Ac04FStampa.Components[i] is TQRDBText then
            with TQRDBText(Ac04FStampa.Components[i]) do
              if Pos('NonRend',Name) > 0 then
              begin
                Left:=nLeft;
                DataField:=IfThen(Pos('Cod',Name) > 0,'ATTCOD_18',IfThen(Pos('HH',Name) > 0,'ATTHH_18',IfThen(Pos('Tot',Name) > 0,'ATTTOT_18')));
              end;
      nLeft:=nLeft + 44;
    end;
    //Totale attività e divisori
    nLeft:=nLeft + 2;
    for i:=0 to Ac04FStampa.ComponentCount - 1 do
      if Ac04FStampa.Components[i] is TQRDBText then
      begin
        with TQRDBText(Ac04FStampa.Components[i]) do
          if Pos('TotAtt',Name) > 0 then
            Left:=nLeft;
      end
      else if Ac04FStampa.Components[i] is TQRShape then
      begin
        with TQRShape(Ac04FStampa.Components[i]) do
          if Pos('TotAtt',Name) > 0 then
            Left:=nLeft - 2
          else if Pos('ProCod',Name) > 0 then
          begin
            Left:=nLeft + 44;
            Enabled:=nProMax > 0;
          end;
      end;
    qlblTotAttCod.Left:=nLeft;
    nLeft:=nLeft + 44;
    //Slot progetti
    if nProMax > 0 then
    begin
      nLeft:=nLeft + 2;
      for n:=1 to nProMax do
      begin
        for i:=0 to Ac04FStampa.ComponentCount - 1 do
          if Ac04FStampa.Components[i] is TQRDBText then
            with TQRDBText(Ac04FStampa.Components[i]) do
              if (Pos('Pro',Name) > 0)
              and (Copy(Name,Pos('_',Name) + 1) = IntToStr(n)) then
              begin
                Left:=nLeft;
                DataField:='PRO' + IfThen(Pos('Cod',Name) > 0,'COD',IfThen(Pos('HH',Name) > 0,'HH',IfThen(Pos('Tot',Name) > 0,'TOT'))) + '_' + IntToStr(n);
              end;
        nLeft:=nLeft + 44;
      end;
    end;
    //Altre attività e divisori
    nLeft:=nLeft + 2;
    if nProMax > 0 then
    begin
      for i:=0 to Ac04FStampa.ComponentCount - 1 do
        if Ac04FStampa.Components[i] is TQRDBText then
          with TQRDBText(Ac04FStampa.Components[i]) do
            if Pos('NonRend',Name) > 0 then
            begin
              Left:=nLeft;
              DataField:=IfThen(Pos('Cod',Name) > 0,'NON_REND_COD',IfThen(Pos('HH',Name) > 0,'NON_REND_HH',IfThen(Pos('Tot',Name) > 0,'TOT_NON_REND')));
            end;
    end;
    for i:=0 to Ac04FStampa.ComponentCount - 1 do
      if Ac04FStampa.Components[i] is TQRShape then
        with TQRShape(Ac04FStampa.Components[i]) do
          if Pos('NonRend',Name) > 0 then
          begin
            Left:=nLeft - 2;
            Enabled:=nProMax > 0;
          end;
    qshpRigaDiv.Width:=IfThen(qshpColNonRend.Enabled,qshpColNonRend.Left,qshpColTotPro.Left) - qshpRigaDiv.Left + 1;
    if dlblNonRendCod.DataField = 'NON_REND_COD' then
    begin
      dlblNonRendCod.Top:=qlblAssFestivita.Top;
      dlblNonRendCod.Height:=qlblAssFestivita.Height;
      dlblNonRendCod.Font.Size:=qlblAssFestivita.Font.Size;
    end
    else
    begin
      dlblNonRendCod.Top:=dlblProCod_5.Top;
      dlblNonRendCod.Height:=dlblProCod_5.Height;
      dlblNonRendCod.Font.Size:=dlblProCod_5.Font.Size;
    end;
    dlblDescProgetto2.Left:=qshpColAttCod.Left + 1;
    dlblDescProgetto2.Width:=qshpColProCod.Left - qshpColAttCod.Left - 2;
    qlblAltriProgetti.Enabled:=nProMax > 0;
    qlblAltriProgetti.Caption:=IfThen(nProMax > 1,'OTHER projects','Proj');
    qlblAltriProgetti.Left:=((qshpColNonRend.Left - qshpColProCod.Left - qlblAltriProgetti.Width) div 2) + qshpColProCod.Left;
  end;
end;

procedure TAc04FStampa.bndDettGGBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  bndDettGG.Color:=clWhite;
  with Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW do
    if (cdsStampaDettaglio.FieldByName('DESC_GIORNO').AsString = 'Sat')
    or (cdsStampaDettaglio.FieldByName('DESC_GIORNO').AsString = 'Sun')
    or (cdsStampaDettaglio.FieldByName('ASS_FESTIVITA').AsString = 'X') then
      bndDettGG.Color:=clMenu;
end;

procedure TAc04FStampa.bndIntestazioneAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  with Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW do
  begin
    cdsStampaDettaglio.Filtered:=False;
    cdsStampaDettaglio.Filter:='(PROGRESSIVO = ' + cdsStampaAnagrafico.FieldByName('PROGRESSIVO').AsString + ') AND ' +
                                '(ID_T750 = ' + cdsStampaAnagrafico.FieldByName('ID_T750').AsString + ') AND ' +
                                '(PERIODO_STAMPA = ' + FloatToStr(cdsStampaAnagrafico.FieldByName('PERIODO_STAMPA').AsDateTime) + ')';
    cdsStampaDettaglio.Filtered:=True;
  end;
end;

procedure TAc04FStampa.dlblGiornoPrint(sender: TObject; var Value: string);
begin
  Value:=Copy(Value,1,2);
end;

procedure TAc04FStampa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator = #0 then
    {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=ThousandSepOri;
end;

procedure TAc04FStampa.FormCreate(Sender: TObject);
begin
  RepR.useQR5Justification:=True;
  ThousandSepOri:={$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator;
  LeftIniMeseTitolo:=qlblPeriodoStampa.Left;
  LeftIniMeseValore:=dlblPeriodoStampaDesc.Left;
  SizeProCod:=dlblProCod_1.Font.Size;
  TopProCod:=dlblProCod_1.Top;
end;

procedure TAc04FStampa.dlblAttHH_1Print(sender: TObject; var Value: string);
begin
  if Value <> '' then
    Value:=R180MinutiOre(StrToInt(Value));
end;

procedure TAc04FStampa.RepRAfterPreview(Sender: TObject);
begin
  if {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator = #0 then
    {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=ThousandSepOri;
end;

procedure TAc04FStampa.RepRAfterPrint(Sender: TObject);
begin
  if {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator = #0 then
    {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=ThousandSepOri;
end;

procedure TAc04FStampa.RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
var n,i:Integer;
    OS8:TOracleSession;
    ODS:TOracleDataSet;
begin
  if {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator <> #0 then
    ThousandSepOri:={$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator
  else
    {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=ThousandSepOri;
  if RepR.Exporting and (RepR.ExportFilter is TQRXLSFilter) then
      {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=#0;
  try
    qimgLogo.Enabled:=Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW.Logo;
    if qimgLogo.Enabled then
    begin
      qimgLogo.AutoSize:=True;
      qimgLogo.Stretch:=False;
      OS8:=TOracleSession.Create(nil);
      ODS:=TOracleDataSet.Create(nil);
      try
        OS8.Preferences.UseOCI7:=False;
        OS8.LogonDatabase:=SessioneOracle.LogonDatabase;
        OS8.LogonUsername:=SessioneOracle.LogonUsername;
        OS8.LogonPassword:=SessioneOracle.LogonPassword;
        OS8.Logon;
        ODS.Session:=OS8;
        ODS.SQL.Add('SELECT IMMAGINE FROM T004_IMMAGINI WHERE TIPO = ''CARTELLINO''');
        ODS.Open;
        qimgLogo.Picture.BitMap.Assign(TBlobField(ODS.FieldByName('IMMAGINE')));
        ODS.Close;
        OS8.Logoff;
      finally
        FreeAndNil(ODS);
        FreeAndNil(OS8);
      end;
      qimgLogo.AutoSize:=False;
      qimgLogo.Stretch:=True;
      if qimgLogo.Height > 62 then
      begin
        qimgLogo.Width:=Trunc((62 * qimgLogo.Width) / qimgLogo.Height);
        qimgLogo.Height:=62;
      end;
      TQRBand(qimgLogo.Parent).Height:=max(41,qimgLogo.Top + qimgLogo.Height);
    end;
  except
    qimgLogo.Enabled:=False;
  end;
  QRLEnte.Caption:=Parametri.DAzienda;
  with Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW do
  begin
    //ATTENZIONE: la proprietà Visible funziona bene nell'antemprima Win ma non nell'esportazione Web. Usare la proprietà Enabled, che funziona in entrambi i casi
    qlblCUP.Enabled:=CUP;
    dlblCUP.Enabled:=CUP;
    qlblTipoTempo.Enabled:=TipoTempo;
    dlblTipoTempo.Enabled:=TipoTempo;
    if TipoTempo then
    begin
      qlblPeriodoStampa.Left:=LeftIniMeseTitolo;
      dlblPeriodoStampaDesc.Left:=LeftIniMeseValore;
    end
    else
    begin
      qlblPeriodoStampa.Left:=qlblTipoTempo.Left;
      dlblPeriodoStampaDesc.Left:=dlblTipoTempo.Left;
    end;
    qlblGiustificaRitardoDip.Enabled:=SezGiustificaRitardi;
    qlblGiustificaRitardoResp.Enabled:=SezGiustificaRitardi;
    //Font codici dei progetti: in anteprima win uso il font normale, ma in esportazione web devo ridurlo perché i codici lunghi si sovrappongono
    for i:=0 to Ac04FStampa.ComponentCount - 1 do
      if Ac04FStampa.Components[i] is TQRDBText then
        with TQRDBText(Ac04FStampa.Components[i]) do
          if (Pos('ProCod',Name) > 0) then
          begin
            Font.Size:=SizeProCod;
            Top:=TopProCod;
            if (RepR.qrprinter.destination = qrdPrinter) or RepR.Exporting then
              for n:=1 to nProMax do
                if Copy(Name,Pos('_',Name) + 1) = IntToStr(n) then
                begin
                  Top:=Top + 1;
                  Font.Size:=Font.Size - 1;
                  Break;//passo al componente successivo
                end;
          end;
  end;
end;

end.
