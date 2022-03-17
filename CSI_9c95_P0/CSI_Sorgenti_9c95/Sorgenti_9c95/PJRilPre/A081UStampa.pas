unit A081UStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls,C180FunzioniGenerali, A000UCostanti, A000USessione,A000UInterfaccia, Variants,
  QRExport, QRWebFilt, QRPDFFilt;

type
  TTotale = record
    Causale,Descrizione:String;
    Giorni:Real;
    Minuti:Integer;
  end;

  TRiduz = record
    UM:String;
    Percent:array[1..6] of Integer;
    Fruito:array[1..6] of Real;
  end;

  TA081FStampa = class(TForm)
    RepR: TQuickRep;
    QRBTitolo: TQRBand;
    QRLEnte: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLRaggruppamento: TQRLabel;
    QRDBTGruppo: TQRDBText;
    QRBIntestazione: TQRBand;
    QRLTitolo: TQRLabel;
    QRFoot1: TQRBand;
    QRLabel4: TQRLabel;
    QRFoot3: TQRBand;
    QRLabel5: TQRLabel;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRBand1: TQRBand;
    QRDBTCognome: TQRDBText;
    QRDBTBadge: TQRDBText;
    QRDBText1: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel7: TQRLabel;
    QRDBText3: TQRDBText;
    QRFoot2: TQRBand;
    QRLabel8: TQRLabel;
    QRLabel3: TQRLabel;
    PFBand1: TQRBand;
    QRLabel9: TQRLabel;
    QRGroup1: TQRGroup;
    QRGroup2: TQRGroup;
    QRGroup3: TQRGroup;
    Tot1: TQRLabel;
    Tot2: TQRLabel;
    Tot3: TQRLabel;
    Tot4: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRLRaggruppamento1: TQRLabel;
    QRDBText5: TQRDBText;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    procedure RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRFoot3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRFoot2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRFoot1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PFBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
 private
    { Private declarations }
 public
    { Public declarations }
    CampoRagg : String;
    NomeCampo : String;
    DaData,AData : TDateTime;
    procedure CreaReport(PreView:Boolean);
  end;

var
  A081FStampa: TA081FStampa;
  TotData,TotGrup,TotCaus,TotGen: Integer;
  NumCausali:Integer;
implementation

uses A081UTimbCaus, A081UTimbCausDtM1;

{$R *.DFM}

//------------------------------------------------------------------------------
procedure TA081FStampa.CreaReport(PreView:Boolean);
begin
  TotData:=0;
  TotGrup:=0;
  TotCaus:=0;
  TotGen:=0;
  //Abilitazione bande dei totali
  PFBand1.Enabled:=A081FTimbCaus.chkTotGenerale.Checked;
  QRFoot1.Enabled:=A081FTimbCaus.chkTotRaggr.Checked;
  QRFoot2.Enabled:=A081FTimbCaus.chkTotCaus.Checked;
  QRFoot3.Enabled:=A081FTimbCaus.chkTotData.Checked;
  QRDBTCognome.Enabled:=A081FTimbCaus.chkStampaDett.Checked;
  QRDBTBadge.Enabled:=A081FTimbCaus.chkStampaDett.Checked;
  QRDBText1.Enabled:=A081FTimbCaus.chkStampaDett.Checked;
  QRDBText3.Enabled:=A081FTimbCaus.chkStampaDett.Checked;
  QRLabel3.Enabled:=A081FTimbCaus.chkStampaDett.Checked;
  if A081FTimbCaus.chkStampaDett.Checked then
     begin
     QRGroup3.Height:=16;
     QRBand1.Height:=16;
     end
  else
     begin
     QRGroup3.Height:=0;
     QRBand1.Height:=0;
     end;
  //Settaggio dell'espressione di raggruppamento se specificato un dato di raggruppamento
  if CampoRagg <> '' then
    begin
    QRGroup1.Expression := 'Gruppo';
    QRLRaggruppamento.Caption := NomeCampo;
    QRLRaggruppamento1.Caption := NomeCampo;
    QRGroup1.Enabled := True;
    end
  else
    begin
    QRGroup1.Enabled:=False;
    QRFoot1.Enabled:=False;
    end;
  //Impostazione salti pagina
  QRGroup1.ForceNewPage:=False;
  QRGroup2.ForceNewPage:=False;
  if CampoRagg = '' then
     QRGroup2.ForceNewPage:=A081FTimbCaus.chkSaltoCaus.Checked
  else
    QRGroup1.ForceNewPage:=A081FTimbCaus.chkSaltoRaggr.Checked;

  if (Trim(A081FTimbCaus.DocumentoPDF) <> '') and (Trim(A081FTimbCaus.DocumentoPDF) <> '<VUOTO>') and (Trim(A081FTimbCaus.TipoModulo) = 'COM')then
  begin
    RepR.ShowProgress:=False;
    RepR.ExportToFilter(TQRPDFDocumentFilter.Create(A081FTimbCaus.DocumentoPDF));
  end
  else if PreView then
    RepR.Preview
  else
    RepR.Print;
end;

//------------------------------------------------------------------------------
procedure TA081FStampa.RepRBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  QRLEnte.Caption:=Parametri.DAzienda;
  QRLTitolo.Caption := 'Elenco Timbrature Causalizzate dal ' + FormatDateTime('dd/mm/yyyy',DaData)+
                            ' al ' +FormatDateTime('dd/mm/yyyy',AData);
  with A081FTimbCaus do
  begin
    QRFoot3.Frame.DrawTop:=False;
    QRFoot2.Frame.DrawTop:=False;
    QRFoot1.Frame.DrawTop:=False;
    PFBand1.Frame.DrawTop:=False;
    if chkTotData.Checked and chkStampaDett.Checked then
      QRFoot3.Frame.DrawTop:=True
    else
      if chkTotCaus.Checked then
        QRFoot2.Frame.DrawTop:=True
      else
        if chkTotRaggr.Checked then
          QRFoot1.Frame.DrawTop:=True
        else
          if chkTotGenerale.Checked then
            PFBand1.Frame.DrawTop:=True;
  end;
end;

procedure TA081FStampa.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  TotData:=0;
  TotGrup:=0;
  TotCaus:=0;
end;

procedure TA081FStampa.QRGroup2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  TotData:=0;
  TotCaus:=0;
end;

procedure TA081FStampa.QRGroup3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  TotData:=0;
end;

procedure TA081FStampa.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inc(TotData);
  inc(TotGrup);
  inc(TotCaus);
  inc(TotGen);
end;

procedure TA081FStampa.QRFoot3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Tot1.Caption:=IntToStr(TotData);
end;

procedure TA081FStampa.QRFoot2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Tot2.Caption:=IntToStr(TotCaus);
end;

procedure TA081FStampa.QRFoot1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Tot3.Caption:=IntToStr(TotGrup);
end;

procedure TA081FStampa.FormCreate(Sender: TObject);
begin
  RepR.useQR5Justification:=True;
end;

procedure TA081FStampa.PFBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Tot4.Caption:=IntToStr(TotGen);
  TotGen:=0;
end;

end.
