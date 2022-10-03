unit A145UStampaIndividuale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R002UQREP, QRPDFFilt, QRExport, QRWebFilt, QRCtrls, QuickRpt, ExtCtrls,
  A000UInterfaccia,DB,Oracle,OracleData,Math;

type
  TA145FStampaIndividuale = class(TR002FQRep)
    qimgLogo: TQRImage;
    QRDBText2: TQRDBText;
    QRBDettaglio: TQRBand;
    QRMemo1: TQRMemo;
    ChildBand1: TQRChildBand;
    QRDBTNomeCognome: TQRDBText;
    QRLPeriodoAssenza: TQRLabel;
    QRDBTDomicilio: TQRDBText;
    ChildBand2: TQRChildBand;
    QRMemo2: TQRMemo;
    QRLabel1: TQRLabel;
    ChildBand3: TQRChildBand;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRLProt: TQRLabel;
    QRLNumProt: TQRLabel;
    QRLLuogoData: TQRLabel;
    QRLabel2: TQRLabel;
    QRDBlbl: TQRDBText;
    ChildBand4: TQRChildBand;
    QRMemo3: TQRMemo;
    QRLblNote: TQRLabel;
    QRDBText6: TQRDBText;
    procedure QRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure QRLPeriodoAssenzaPrint(sender: TObject; var Value: string);
    procedure qlblSysDataPrint(sender: TObject; var Value: string);
    procedure ChildBand3BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ImpostaDataset;
    procedure CreaReport;
  end;

var
  A145FStampaIndividuale: TA145FStampaIndividuale;

implementation

{$R *.dfm}

uses A145UComunicazioneVisiteFiscali, A145UComunicazioneVisiteFiscaliDtM;

procedure TA145FStampaIndividuale.ChildBand3BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  PrintBand:=Not QRep.DataSet.FieldByName('NOTE').IsNull and A145FComunicazioneVisiteFiscali.chkNote.Checked;
end;

procedure TA145FStampaIndividuale.ImpostaDataset;
begin
  with A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW do
  begin
    QRep.DataSet:=TabellaStampa;
    QRDBText1.DataSet:=TabellaStampa;
    QRDBText2.DataSet:=TabellaStampa;
    QRDBText3.DataSet:=TabellaStampa;
    QRDBText4.DataSet:=TabellaStampa;
    QRDBText5.DataSet:=TabellaStampa;
    QRDBText6.DataSet:=TabellaStampa;
    QRDBTNomeCognome.DataSet:=TabellaStampa;
    QRDBTDomicilio.DataSet:=TabellaStampa;
    QRDBlbl.DataSet:=TabellaStampa;
  end;

end;

procedure TA145FStampaIndividuale.CreaReport;
begin
  // impostazione dati fissi
  with A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW do
  begin
    QRLProt.Enabled:=DatiElab.bNumProt;
    QRLNumProt.Enabled:=DatiElab.bNumProt;
    if DatiElab.bNumProt then
      QRLNumProt.Caption:=DatiElab.sNumProt;
    QRLLuogoData.Enabled:=DatiElab.bLuogo;
    if DatiElab.bLuogo then
      QRLLuogoData.Caption:=DatiElab.sLuogo + ', ' + DateToStr(DatiElab.DataElaborazione);
    QRMemo1.Lines.Text:=DatiElab.sDato1;
    QRMemo2.Lines.Text:=DatiElab.sDato2;
    QRMemo3.Lines.Text:=DatiElab.sFirma;
  end;
  Screen.Cursor:=crDefault;

  // avvia la stampa
  if (A145FComunicazioneVisiteFiscali.TipoModulo = 'COM') and (Trim(A145FComunicazioneVisiteFiscali.DocumentoPDF) <> '') and (Trim(A145FComunicazioneVisiteFiscali.DocumentoPDF) <> '<VUOTO>') then
  begin
    QRep.ShowProgress:=False;
    QRep.ExportToFilter(TQRPDFDocumentFilter.Create(A145FComunicazioneVisiteFiscali.DocumentoPDF));
  end
  else
  begin
    if A145FComunicazioneVisiteFiscali.Anteprima then
      QRep.Preview
    else
      QRep.Print;
  end;
end;

procedure TA145FStampaIndividuale.qlblSysDataPrint(sender: TObject; var Value: string);
begin
  inherited;
  Value:='';
end;

procedure TA145FStampaIndividuale.QRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
var
  ODS:TOracleDataSet;
  OS8:TOracleSession;
  L: Integer;
begin
  inherited;
  with A145FComunicazioneVisiteFiscali do begin
    // titolo
    LEnte.Caption:='';
    LTitolo.Caption:='';

    // gestione del logo
    Titolo.Height:=90;
    if chkLogo.Checked then
      L:=StrToIntDef(edtLogoLarg.Text,150)
    else
      L:=0;
    try
      qimgLogo.Enabled:=L > 0; // edtLarghezza.Text...
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
          if ODS.RecordCount = 1 then
            qimgLogo.Picture.BitMap.Assign(TBlobField(ODS.FieldByName('IMMAGINE')));
          ODS.Close;
          OS8.Logoff;
        finally
          FreeAndNil(ODS);
          FreeAndNil(OS8);
        end;
        qimgLogo.AutoSize:=False;
        qimgLogo.Stretch:=True;
        qimgLogo.Height:=Trunc(qimgLogo.Height * (L / qimgLogo.Width));
        qimgLogo.Width:=L;
        TQRBand(qimgLogo.Parent).Height:=max(TQRBand(qimgLogo.Parent).Height,qimgLogo.Top + qimgLogo.Height);
      end;
    except
      qimgLogo.Enabled:=False;
    end;
  end;

end;

procedure TA145FStampaIndividuale.QRLPeriodoAssenzaPrint(sender: TObject; var Value: string);
begin
  inherited;
  with QRep.Dataset do
  begin
    // due possibilità di visualizzazione, in base a inserimento normale / prolungamento
    // data_inizio - data_fine
    // data_inizio - nuova_data_fine (data_fine)
    Value:='in malattia dal giorno ' + FieldByName('DataInizioAssenza').AsString + ' al giorno ';
    if FieldByName('NuovaDataFine').IsNull then
      Value:=Value + FieldByName('DataFineAssenza').AsString
    else
      Value:=Value + FieldByName('NuovaDataFine').AsString +
             ' (' +  FieldByName('DataFineAssenza').AsString + ')';
  end;
end;

end.
