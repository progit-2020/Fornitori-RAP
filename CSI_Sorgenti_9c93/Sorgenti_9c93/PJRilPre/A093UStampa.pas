unit A093UStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls, A000UCostanti, A000USessione,A000UInterfaccia, C700USelezioneAnagrafe,
  C180FunzioniGenerali, Variants, OracleData, QRExport, QRWebFilt, QRPDFFilt;

type
  TA093FStampa = class(TForm)
    RepR: TQuickRep;
    QRBTitolo: TQRBand;
    QRLEnte: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLTitolo: TQRLabel;
    QRBand1: TQRBand;
    QRDetail1: TQRBand;
    qrDettaglio: TQRChildBand;
    qrlblIntDato: TQRLabel;
    qrmemDettaglio: TQRMemo;
    QRBand2: TQRSubDetail;
    QRGroup1: TQRGroup;
    qrlblDato: TQRLabel;
    QRLabel1: TQRLabel;
    QRDBText1: TQRDBText;
    QRExpr1: TQRExpr;
    qrAnagrafico: TQRChildBand;
    qlblAnagrafico: TQRLabel;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    procedure RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrDettaglioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrAnagraficoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
private
    { Private declarations }
    QRLista:TList;
    RagLeft,DatLeft: Integer;
    procedure CreaCompVariabili;
    procedure DistruggiCompVariabili;
    function CalcolaLarghezza(i:Integer):Integer;
 public
    { Public declarations }
    procedure CreaReport(PreView:Boolean);
 end;

var
  A093FStampa: TA093FStampa;

  implementation

uses A093UOperazioniDtM1, A093UOperazioni;

{$R *.DFM}

procedure TA093FStampa.CreaReport(PreView: Boolean);
var i:integer;
    Campo:string;
begin
  A093FOperazioni.FlagStatus:=True;
  Campo:='';
  QRBand2.Enabled:=True;
  QRDetail1.Enabled:=A093FOperazioni.chkRicercaDipendenti.Checked and A093FOperazioni.chkDettaglio.Checked;
  QRDettaglio.Enabled:=A093FOperazioni.chkVisualizzaDettaglio.Checked;
  QRAnagrafico.Enabled:=A093FOperazioni.chkDipendenti.Checked and A093FOperazioni.chkDettaglio.Checked;
  QRDettaglio.Frame.DrawTop:=not QRAnagrafico.Enabled;
  if A093FOperazioni.chkRicercaDipendenti.Checked then
    RepR.DataSet:=C700SelAnagrafe
  else
    RepR.DataSet:=A093FOperazioniDtM1.Q000;
  QRDbText1.DataSet:=C700SelAnagrafe;
  with A093FOperazioni do
    for i:=0 to LBOrdine.Items.Count-1 do
      if LBOrdine.Checked[i] then
        Campo:=Campo + 'Q000.' + LbOrdine.Items[i] + '+';
  Campo:=Copy(Campo,1,Length(Campo)-1);
  QRGroup1.Expression:=Campo;
  QRGroup1.Enabled:=Campo <> '';
  QRDetail1.ForceNewPage:=False;
  QRGroup1.ForceNewPage:=False;
  QRBand2.ForceNewPage:=False;
  if A093FOperazioni.chkSaltoPagina.Checked then
    if QRDetail1.Enabled then
      QRDetail1.ForceNewPage:=True
    else if QRGroup1.Enabled then
      QRGroup1.ForceNewPage:=True
    else QRBand2.ForceNewPage:=True;
  CreaCompVariabili;
  if PreView then
    RepR.Preview
  else
    RepR.Print;
  DistruggiCompVariabili;
  A093FOperazioni.FlagStatus:=False;
end;

procedure TA093FStampa.RepRBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  with A093FOperazioni do
    begin
    QRLEnte.Caption:=Parametri.DAzienda;
    QRLTitolo.Caption := 'Stampa log delle operazioni dal ' +
                         FormatDateTime('dd/mm/yyyy',DallaData)+ ' al '+
                         FormatDateTime('dd/mm/yyyy',AllaData);
    end;
end;

procedure TA093FStampa.CreaCompVariabili;
var Etichetta:TQRLabel;
    Dato:TQRDBText;
    i:integer;
begin
  QRLista:=TList.Create;
  RagLeft:=0;
  DatLeft:=10;
  with A093FOperazioni do
    begin
    for i:=0 to LBOrdine.Items.Count-1 do
      begin
      Etichetta:=TQRLabel.Create(A093FStampa);
      Etichetta.Caption:=LBOrdine.Items[i];
      Etichetta.Autosize:=False;
      Etichetta.Top:=0;
      Etichetta.Width:=CalcolaLarghezza(i);
      Etichetta.Font.Name:='Courier New';
      Etichetta.Font.Size:=8;
      Etichetta.Height:=16;

      Dato:=TQRDBText.Create(A093FStampa);
      Dato.Autosize:=False;
      Dato.Width:=Etichetta.Width;
      Dato.Height:=16;
      Dato.Font.Name:='Courier New';
      Dato.Font.Size:=8;
      Dato.Font.Style:=[];
      Dato.DataField:=LBOrdine.Items[i];
      Dato.DataSet:=A093FOperazioniDtM1.Q000;

      if LBOrdine.Checked[i] then
        begin
        Etichetta.Parent:=QRGroup1;
        Dato.Parent:=QRGroup1;
        Etichetta.Font.Style:=[FsBold];
        Dato.Top:=16;
        Etichetta.Left:=RagLeft;
        Dato.Left:=RagLeft;
        RagLeft:=RagLeft+Etichetta.Width;
        end
      else
        begin
        Etichetta.Parent:=QRBand1;
        Dato.Parent:=QRBand2;
        Etichetta.Font.Style:=[];
        Dato.Top:=0;
        Etichetta.Left:=DatLeft;
        Dato.Left:=DatLeft;
        DatLeft:=DatLeft+Etichetta.Width;
        end;
      QRLista.Add(Etichetta);
      QRLista.Add(Dato);
      end;
    end;

  qrlblIntDato.Top:=0;
  qrlblIntDato.Left:=DatLeft;
  qrlblIntDato.Font.Name:='Courier New';
  qrlblIntDato.Font.Size:=8;
  qrlblIntDato.Font.Style:=[];
  qrlblDato.Top:=0;
  qrlblDato.Left:=DatLeft;
  qrlblDato.Font.Name:='Courier New';
  qrlblDato.Font.Size:=8;
  qrlblDato.Font.Style:=[];
  qrlblDato.Autosize:=True;
  qrmemDettaglio.Top:=0;
  qrmemDettaglio.Left:=DatLeft;
  qrmemDettaglio.Font.Name:='Courier New';
  qrmemDettaglio.Font.Size:=8;
  qrmemDettaglio.Font.Style:=[];
  qrmemDettaglio.Autosize:=True;
end;

procedure TA093FStampa.DistruggiCompVariabili;
var Oggetto:TObject;
begin
  while QRLista.Count>0 do
    begin
      Oggetto:=QRLista.Items[QRLista.Count-1];
      if Oggetto is TQRDBText then
        (Oggetto as TQRDBText).free
      else
        if Oggetto is TQRLabel then
          (Oggetto as TQRLabel).free;
      QRLista.Delete(QRLista.Count-1);
    end;
  QRLista.Free;
end;

procedure TA093FStampa.FormCreate(Sender: TObject);
begin
  RepR.useQR5Justification:=True;
end;

function TA093FStampa.CalcolaLarghezza(i:integer):integer;
begin
   if A093FOperazioni.LBordine.Items[i]='Data' then
     Result:=120
   else
     Result:=A093FOperazioniDtM1.Q000.FieldByName(A093FOperazioni.LBordine.Items[i]).DisplayWidth*6;
//     Result:=A093FOperazioniDtM1.Q000.FieldByName(A093FOperazioni.LBordine.Items[i]).DisplayWidth*7;
end;

procedure TA093FStampa.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:=True;
  if A093FOperazioni.chkDettaglio.Checked then
    with A093FOperazioniDtM1.Q000 do
      qrlblDato.Caption:=Format('%-20s %-25s %-25s',[Copy(FieldByName('COLONNA').AsString,1,20),Copy(FieldByName('VALORE_OLD').AsString,1,25),Copy(FieldByName('VALORE_NEW').AsString,1,25)])
  else
    qrlblDato.Caption:='';
end;

procedure TA093FStampa.qrDettaglioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var ValNew,ValOld:String;
begin
  PrintBand:=False;
  if True then
  begin
    qrmemDettaglio.Lines.Clear;
    with A093FOperazioniDtM1.Q001 do
    begin
      First;
      while not Eof do
      begin
        try
          ValNew:=Copy(FieldByName('VALORE_NEW').AsString,1,25);
          if (R180Anno(StrToDate(ValNew)) <= 1900) then
            ValNew:=FormatDateTime('hh.nn',StrToDateTime(FieldByName('VALORE_NEW').AsString));
        except
        end;
        try
          ValOld:=Copy(FieldByName('VALORE_OLD').AsString,1,25);
          if (R180Anno(StrToDate(ValOld)) <= 1900) then
            ValOld:=FormatDateTime('hh.nn',StrToDateTime(FieldByName('VALORE_OLD').AsString));
        except
        end;
        qrmemDettaglio.Lines.Add(Format('%-20s %-25s %-25s',[Copy(FieldByName('COLONNA').AsString,1,20),ValOld,ValNew]));
        Next;
      end;
    end;
    PrintBand:=qrmemDettaglio.Lines.Count >= 0;
  end;
end;

procedure TA093FStampa.QRDetail1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:=A093FOperazioniDtM1.Q000.RecordCount > 0;
  QRBand2.Enabled:=PrintBand;
  QRGroup1.Enabled:=PrintBand and (QRGroup1.Expression <> '');
  QRDettaglio.Enabled:=PrintBand and A093FOperazioni.chkVisualizzaDettaglio.Checked;
end;

procedure TA093FStampa.qrAnagraficoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qlblAnagrafico.Caption:='';
  with A093FOperazioniDtM1 do
    if Q000.FieldByName('COLONNA').AsString = 'PROGRESSIVO' then
    begin
      if not Q000.FieldByName('VALORE_OLD').IsNull then
        C700SelAnagrafe.SearchRecord('PROGRESSIVO',Q000.FieldByName('VALORE_OLD').AsString,[srFromBeginning])
      else
        C700SelAnagrafe.SearchRecord('PROGRESSIVO',Q000.FieldByName('VALORE_NEW').AsString,[srFromBeginning]);
      qlblAnagrafico.Caption:=Format('MATRICOLA: %-8s  %s %s',[C700SelAnagrafe.FieldByName('MATRICOLA').AsString,C700SelAnagrafe.FieldByName('COGNOME').AsString,C700SelAnagrafe.FieldByName('NOME').AsString]);
    end;
end;

end.
