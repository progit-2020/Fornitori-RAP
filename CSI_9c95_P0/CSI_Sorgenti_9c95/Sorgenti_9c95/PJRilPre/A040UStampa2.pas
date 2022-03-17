unit A040UStampa2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R002UQREP, QRPDFFilt, QRExport, QRWebFilt, QRCtrls, QuickRpt,
  QRPrntr, ExtCtrls, Printers, A000UInterfaccia, Math, DB,                       
  C001StampaLib, C180FunzioniGenerali;

type
  TA040FStampa2 = class(TR002FQRep)
    QRGroup1: TQRGroup;
    QRLRaggruppamento: TQRLabel;
    QRBDettaglio: TQRBand;
    QRBHeader: TQRBand;
    QRDBTRaggr: TQRDBText;
    ChildBand1: TQRChildBand;
    QRLRaggruppamentoChild: TQRLabel;
    QRDBTRaggrChild: TQRDBText;
    QRBLegendaDett: TQRChildBand;
    QRDBTCod2: TQRDBText;
    QRDBTCod1: TQRDBText;
    QRDBTDesc2: TQRDBText;
    QRDBTDesc1: TQRDBText;
    QRShape4: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRLineDettB: TQRShape;
    QRLPeriodo: TQRLabel;
    QRBTotali: TQRBand;
    QRBLegendaHead: TQRChildBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabelCod2: TQRLabel;
    QRLabelDesc2: TQRLabel;
    QRLineHeadB: TQRShape;
    QRLTitolo2: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape5: TQRShape;
    QRLTitolo1: TQRLabel;
    QRLineHeadT: TQRShape;
    procedure FormDestroy(Sender: TObject);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBHeaderBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure QRBLegendaDettAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRBLegendaHeadBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBLegendaDettBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRepAfterPreview(Sender: TObject);
    procedure QRepAfterPrint(Sender: TObject);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBDettaglioAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRGroup1AfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
    procedure QRDBTDettPrint(sender: TObject; var Value: string);
  private
    { Private declarations }
    ArrHead: array of TQRLabel;
    ArrLinesHead: array of TQRShape;
    ArrDett: array of TQRDBText;
    ArrLinesDett: array of TQRShape;
    ArrFoot: array of TQRDBText;
    ArrLinesFoot: array of TQRShape;
    Spazio: Integer;
    LastBandLegenda: TQRCustomBand;
    function  ContieneTag(Tag, T: Integer): Boolean;
    procedure CreaComponenti;
    procedure DistruggiComponenti;
    procedure RimuoviLegenda;
    function  CreaHeaderLabel(AOwner: TComponent; F: TField; x,y,w: Integer): TQRLabel;
    function  CreaSeparatore(AOwner: TComponent; Par: TWinControl; x: Integer): TQRShape;
    function  CreaDettText(AOwner: TComponent; DS: TDataset; F: TField; x, y, w: Integer): TQRDBText;
    function  CreaFooterText(AOwner: TComponent; DS: TDataset; F: TField; x, y, w: Integer): TQRDBText;
    procedure RipartizioneSpazio(SpazioTot,CampiStampati: Integer);
  public
    { Public declarations }
    TitoloStampa: String;
    AbilRaggr: Boolean;
    VisualizzaLegenda,VisualizzaTotali: Boolean;
    Riproporziona: String;  { Usare per distribuire lo spazio restante sulla width dei campi, anche se negativo
                              N  = nessuna riproporzione
                              P  = distribuisce lo spazio proporzionalmente alla width dei campi
                              P+ = come P ma solo se lo spazio restante è positivo
                              F  = distribuisce in modo fisso lo spazio
                              F+ = come F ma solo se lo spazio restante è positivo
                            }
    procedure CreaReport;
  end;

var
  A040FStampa2: TA040FStampa2;

const
  LEFT_INI: Integer = 5;
  TOP_INI: Integer = 4;
  SPAZIO_H: Integer = 4;
  HEIGHT_BAND_HEAD_INI: Integer = 40;
  HEIGHT_BAND_DETT_INI: Integer = 24;
  HEIGHT_FIELD_INI: Integer = 15;

implementation

uses A040UPianifRepDtM2;

{$R *.dfm}

procedure TA040FStampa2.FormCreate(Sender: TObject);
begin
  inherited;
  // inizializzazione variabili
  TitoloStampa:='';
  AbilRaggr:=False;
  VisualizzaLegenda:=False;
  VisualizzaTotali:=False;
  Riproporziona:='N';
end;

procedure TA040FStampa2.FormDestroy(Sender: TObject);
begin
  inherited;
  DistruggiComponenti;
end;

function TA040FStampa2.ContieneTag(Tag, T: Integer): Boolean;
begin
  Result:=((Tag and T) = T); // and bit a bit
end;

procedure TA040FStampa2.QRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var
  L,DatiLegenda: Integer;
begin
  inherited;
  // titolo stampa
  LEnte.Caption:=Parametri.RagioneSociale;
  LTitolo.Caption:=TitoloStampa;

  with A040FPianifRepDtM2 do
    if (DataInizio = R180InizioMese(DataInizio)) and
       (DataFine = R180FineMese(DataInizio)) then
      QRLPeriodo.Caption:='Mese di ' + R180NomeMese(R180Mese(DataInizio)) +
                          ' ' + IntToStr(R180Anno(DataInizio))
    else if DataInizio = DataFine then
      QRLPeriodo.Caption:='Giorno: ' + FormatDateTime('dd/mm/yyyy',DataInizio)
    else
      QRLPeriodo.Caption:='Periodo ' + FormatDateTime('dd/mm/yyyy',DataInizio) +
                          ' - ' + FormatDateTime('dd/mm/yyyy',DataFine);

  QRBTotali.Enabled:=(A040FPianifRepDtM2.TipoStampa = tsTabellone) and VisualizzaTotali;

  // legenda
  QRBLegendaHead.Enabled:=False;
  QRBLegendaDett.Enabled:=False;
  if VisualizzaLegenda then
  begin
    with A040FPianifRepDtM2.cdsLegenda do
    if RecordCount > 0 then
    begin
      First;
      QRBLegendaHead.Enabled:=True;
      QRBLegendaDett.Enabled:=True;

      // imposta visibilità dati
      DatiLegenda:=IfThen((FieldByName('CODTURNO').Visible) and (FieldByName('CODCAUS').Visible),2,1);

      // visualizza / nasconde parte dx legenda
      // titolo 2
      QRLTitolo2.Enabled:=(DatiLegenda = 2);
      QRLabelCod2.Enabled:=(DatiLegenda = 2);
      QRLabelDesc2.Enabled:=(DatiLegenda = 2);
      QRShape3.Enabled:=(DatiLegenda = 2);
      // dettaglio 2 (replicato utilizzando proprietà haschild = true)
      QRDBTCod2.Enabled:=(DatiLegenda = 2);
      QRDBTDesc2.Enabled:=(DatiLegenda = 2);
      QRShape4.Enabled:=(DatiLegenda = 2);
      // separatori orizzontali
      L:=IfThen(DatiLegenda = 2,700,350);
      QRLineHeadT.Width:=L;
      QRLineHeadB.Width:=L;
      QRLineDettB.Width:=L;

      if (DatiLegenda = 1) and
         (FieldByName('CODCAUS').Visible) then
      begin
        QRLTitolo1.Caption:='LEGENDA CAUSALI DI ASSENZA';
        QRDBTCod1.DataField:='CODCAUS';
        QRDBTDesc1.DataField:='DESCCAUS';
      end
      else
      begin
        QRLTitolo1.Caption:='LEGENDA TURNI';
        QRDBTCod1.DataField:='CODTURNO';
        QRDBTDesc1.DataField:='DESCTURNO';
      end;
    end;
  end;
end;

procedure TA040FStampa2.QRepAfterPreview(Sender: TObject);
begin
  inherited;
  if VisualizzaLegenda then
    RimuoviLegenda;
end;

procedure TA040FStampa2.QRepAfterPrint(Sender: TObject);
begin
  inherited;
  if VisualizzaLegenda then
    RimuoviLegenda;
end;

procedure TA040FStampa2.QRGroup1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  inherited;
  if VisualizzaLegenda then
  begin
    RimuoviLegenda;
    if A040FPianifRepDtM2.cdsLegenda.RecordCount > 0 then
      A040FPianifRepDtM2.cdsLegenda.First;
  end;
end;

procedure TA040FStampa2.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  QRDBTRaggr.Left:=QRLRaggruppamento.Left + QRLRaggruppamento.Width + 5;
end;

procedure TA040FStampa2.QRBHeaderBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
  i,altezza: Integer;
  h: Extended;
begin
  inherited;
  if Sender = QRBTotali then
    with A040FPianifRepDtM2 do
      if (TipoStampa = tsTabellone) and cdsTotPianif.Active and QRGroup1.Enabled then
        cdsTotPianif.Locate(NomeCampoRaggr,cdsPianif.FieldByName(NomeCampoRaggr).Value,[]);

  // ricalcola altezza banda
  if (Sender = QRBDettaglio) or (Sender = QRBTotali) then
    // imposta height di default
    Sender.Height:=HEIGHT_BAND_DETT_INI
  else if Sender = QRBHeader then
    // imposta height di default
    Sender.Height:=HEIGHT_BAND_HEAD_INI;

  Sender.ExpandedHeight(h);
  altezza:=Round(h * ProporzioneBandExpanded);
  Sender.Height:=altezza;

  // imposta l'altezza dei componenti pari all'altezza della banda
  for i:=0 to Sender.ControlCount - 1 do
  begin
    if Sender.Controls[i] is TQRLabel then
      TQRLabel(Sender.Controls[i]).Height:=altezza
    else if Sender.Controls[i] is TQRDBText then
      TQRDBText(Sender.Controls[i]).Height:=altezza
    else if Sender.Controls[i] is TQRShape then
    begin
      if TQRShape(Sender.Controls[i]).Shape = qrsVertLine then
        TQRShape(Sender.Controls[i]).Height:=altezza;
    end;
  end;
end;

// Creazione dinamica dei componenti
function TA040FStampa2.CreaHeaderLabel(AOwner: TComponent; F: TField; x,y,w: Integer): TQRLabel;
begin
  Result:=TQRLabel.Create(AOwner);
  with Result do
  begin
    Parent:=QRBHeader;
    Caption:=F.DisplayName;
    Left:=x;
    Top:=y;
    Height:=HEIGHT_FIELD_INI;
    Width:=w;
    AutoSize:=False;
    AutoStretch:=True;
    WordWrap:=True;
    Alignment:=taCenter;
    Font:=QRep.Font;
    Tag:=F.Tag;
    if ContieneTag(Tag,TAG_EVIDENZIA_FESTIVI) then
    begin
      Font.Style:=Font.Style + [fsBold];
      Font.Color:=clRed;
    end;
  end;
end;

function TA040FStampa2.CreaSeparatore(AOwner: TComponent; Par: TWinControl; x: Integer): TQRShape;
begin
  Result:=TQRShape.Create(AOwner);
  with Result do
  begin
    Parent:=Par;
    Enabled:=True;
    Shape:=qrsVertLine;
    Pen.Style:=psSolid;
    Left:=x;
    Top:=0;
    Width:=1;
    Height:=QRBHeader.Height;
  end;
end;

function TA040FStampa2.CreaDettText(AOwner: TComponent; DS: TDataset; F: TField; x, y, w: Integer): TQRDBText;
begin
  Result:=TQRDBText.Create(AOwner);
  with Result do
  begin
    Parent:=QRBDettaglio;
    DataSet:=DS;
    DataField:=F.FieldName;
    Alignment:=F.Alignment;
    Left:=x;
    Top:=y;
    Height:=HEIGHT_FIELD_INI;
    Width:=w;
    AutoSize:=False;
    AutoStretch:=True;
    WordWrap:=True;
    Font:=QRep.Font;
    Tag:=F.Tag;
    OnPrint:=QRDBTDettPrint;
  end;
end;

function TA040FStampa2.CreaFooterText(AOwner: TComponent; DS: TDataset; F: TField; x, y, w: Integer): TQRDBText;
begin
  Result:=TQRDBText.Create(AOwner);
  with Result do
  begin
    Parent:=QRBTotali;
    DataSet:=DS;
    DataField:=F.FieldName;
    Alignment:=F.Alignment;
    Left:=x;
    Top:=y;
    Height:=HEIGHT_FIELD_INI;
    Width:=w;
    AutoSize:=False;
    AutoStretch:=True;
    WordWrap:=False;
    Font:=QRep.Font;
    Tag:=F.Tag;
    OnPrint:=QRDBTDettPrint;
  end;
end;

procedure TA040FStampa2.QRDBTDettPrint(sender: TObject; var Value: string);
var
  N: String;
  Fest: Boolean;
begin
  inherited;

  N:=TQRDBText(Sender).DataField;
  if ContieneTag(TQRDBText(Sender).Tag,TAG_EVIDENZIA_FESTIVI) then
  begin
    Fest:=True;

    if (N = 'DATA') and (A040FPianifRepDtM2.IsFestivo(StrToDate(Value))) then //(DayOfWeek(StrToDate(Value)) = 1) then
      Fest:=True
    else if (N = 'DD') and
            (A040FPianifRepDtM2.IsFestivo(EncodeDate(R180Anno(A040FPianifRepDtM2.DataInizio),
                                                     R180Mese(A040FPianifRepDtM2.DataInizio),
                                                     StrToInt(Value)))) then
            {(DayOfWeek(EncodeDate(R180Anno(A040FPianifRepDtM2.DataInizio),
                                  R180Mese(A040FPianifRepDtM2.DataInizio),
                                  StrToInt(Value))) = 1) then
            }
      Fest:=True
    else if (N = 'GG') then // and (LowerCase(Copy(Value,1,3)) = 'dom') then
    begin
      Fest:=(A040FPianifRepDtM2.IsFestivo(EncodeDate(R180Anno(A040FPianifRepDtM2.DataInizio),
                                                     R180Mese(A040FPianifRepDtM2.DataInizio),
                                                     StrToInt(Copy(Value,5,MAXINT)))));
      Value:=Copy(Value,1,3);
    end
    else
      Fest:=False;

    // evidenzia il giorno festivo
    if Fest then
    begin
      TQRDBText(Sender).Font.Style:=Font.Style + [fsBold];
      TQRDBText(Sender).Font.Color:=clRed;
    end
    else
      TQRDBText(Sender).Font:=QRep.Font;
  end;

  //etichetta dei totali
  with A040FPianifRepDtM2 do
    if (TipoStampa = tsTabellone) and (TQRDBText(Sender).DataSet = cdsTotPianif) and (N = 'NOMINATIVO') then
      Value:=TQRDBText(Sender).DataSet.FieldByName(N).DisplayLabel;
end;

procedure TA040FStampa2.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  QRGroup1.Height:=0;
  QRDBTRaggrChild.Left:=QRLRaggruppamentoChild.Left + QRLRaggruppamentoChild.Width + 5;
end;

procedure TA040FStampa2.CreaComponenti;
var
  i,x,y,w,SpazioTot,CampiStampati: Integer;
begin
  // disalloca gli eventuali oggetti già creati
  DistruggiComponenti;
  
  CampiStampati:=0;
  Spazio:={QRep.TextWidth(QRBHeader.Font,'Z')}SPAZIO_H;
  x:=LEFT_INI;  // left di partenza
  y:=TOP_INI;   // top elementi

  // crea e imposta label e dbtext per la stampa
  with A040FPianifRepDtM2 do
  begin
    SetLength(ArrHead,cdsPianif.FieldCount);
    SetLength(ArrLinesHead,cdsPianif.FieldCount - 1);
    SetLength(ArrDett,cdsPianif.FieldCount);
    SetLength(ArrLinesDett,cdsPianif.FieldCount - 1);
    SetLength(ArrFoot,cdsPianif.FieldCount);
    SetLength(ArrLinesFoot,cdsPianif.FieldCount - 1);

    for i:=0 to cdsPianif.FieldCount - 1 do
    begin
      if cdsPianif.Fields[i].Tag = TAG_NO_PRINT then
        Continue;

      // determina width campo
      w:=QRep.TextWidth(QRep.Font,StringOfChar('Z',cdsPianif.Fields[i].DisplayWidth));

      // intestazione
      ArrHead[i]:=CreaHeaderLabel(Self,cdsPianif.Fields[i],x,y,w);
      if i < cdsPianif.FieldCount - 1 then
        ArrLinesHead[i]:=CreaSeparatore(Self,QRBHeader,x + w + 1);

      // dettaglio
      ArrDett[i]:=CreaDettText(Self,cdsPianif,cdsPianif.Fields[i],x,y,w);
      if i < cdsPianif.FieldCount - 1 then
        ArrLinesDett[i]:=CreaSeparatore(Self,QRBDettaglio,x + w + 1);

      // footer
      if cdsTotPianif.Active then
      //Cercare di non visualizzare il primo campo, quello del dato, oppure scritta totali, provare senza campo raggruppamento
      begin
        ArrFoot[i]:=CreaFooterText(Self,cdsTotPianif,cdsTotPianif.Fields[i],x,y,w);
        if i < cdsPianif.FieldCount - 1 then
          ArrLinesFoot[i]:=CreaSeparatore(Self,QRBTotali,x + w + 1);
      end;

      x:=x + w + Spazio;
      if not ContieneTag(cdsPianif.Fields[i].Tag,TAG_NO_RIPROPORZIONA) then
        CampiStampati:=CampiStampati + 1;
    end;

    // riposiziona i componenti orizzontalmente in base allo spazio occupato
    if Riproporziona <> 'N' then
    begin
      SpazioTot:=QRBHeader.Width - x + Spazio;
      RipartizioneSpazio(SpazioTot, CampiStampati);
    end;
  end; // ==> end with
end;

procedure TA040FStampa2.RipartizioneSpazio(SpazioTot,CampiStampati: Integer);
{ Distribuisce lo spazio vuoto rimanente sulla width dei campi in modo da
  ottenere un prospetto che utilizzi tutto lo spazio della pagina a disposizione.
  In base al parametro Riproporziona verrà redistribuito lo spazio.
  NOTA: gli array di head e di dettaglio hanno le stesse caratteristiche
}

var
  i, SommaWidth, ExtWidth, x, Resto: Integer;
  ArrExtWidth: array of Integer;
  Primo: Boolean;
begin
  if (Riproporziona <> 'F')  and (Riproporziona <> 'F+') and
     (Riproporziona <> 'P')  and (Riproporziona <> 'P+') then
    Exit;

  // se lo spazio è 0 termina subito
  if SpazioTot = 0 then
    Exit;

  // verifica se è possibile riproporzionare in negativo
  if SpazioTot < 0 then
    if (Riproporziona = 'F+') or
       (Riproporziona = 'P+') then
    Exit;

  // crea l'array contenente gli incrementi di width dei singoli campi
  SetLength(ArrExtWidth,Length(ArrHead));
  if (Riproporziona = 'P') or (Riproporziona = 'P+') then
  begin
    // somma le width dei campi da proporzionare
    SommaWidth:=0;
    for i:=0 to High(ArrHead) do
      if ArrHead[i] <> nil then
        if not ContieneTag(ArrHead[i].Tag,TAG_NO_RIPROPORZIONA) then
          SommaWidth:=SommaWidth + ArrHead[i].Width;

    // imposta l'incremento di width proporzionale per ogni campo
    for i:=0 to High(ArrHead) do
    begin
      ArrExtWidth[i]:=0;
      if ArrHead[i] <> nil then
        if not ContieneTag(ArrHead[i].Tag,TAG_NO_RIPROPORZIONA) then
          ArrExtWidth[i]:=(SpazioTot * ArrHead[i].Width) div SommaWidth
    end;

    // determina lo spazio rimanente
    Resto:=SpazioTot - SumInt(ArrExtWidth);
  end
  else
  begin
    // determina l'incremento di width fisso per ogni campo
    ExtWidth:=SpazioTot div CampiStampati;

    // imposta l'incremento di width per ogni campo
    for i:=0 to High(ArrHead) do
    begin
      ArrExtWidth[i]:=0;
      if ArrHead[i] <> nil then
        if not ContieneTag(ArrHead[i].Tag,TAG_NO_RIPROPORZIONA) then
          ArrExtWidth[i]:=ExtWidth;
    end;

    // determina lo spazio rimanente
    Resto:=SpazioTot mod CampiStampati;
  end;

  // distribuisce lo spazio rimanente in misura di 1 sui primi campi
  // (non si butta via nulla...)
  x:=0;
  for i:=0 to High(ArrHead) do
  begin
    if ArrHead[i] <> nil then
      if not ContieneTag(ArrHead[i].Tag,TAG_NO_RIPROPORZIONA) then
      begin
        x:=x + 1;
        if x <= Resto then
          ArrExtWidth[i]:=ArrExtWidth[i] + 1;
      end;
  end;

  // reimposta le proprietà left e width dei componenti:
  // label sulla band header e dbtext sulla band di dettaglio
  // NOTA: gli array di head e di dettaglio hanno le stesse caratteristiche
  Primo:=True;
  for i:=0 to High(ArrHead) do
  begin
    if ArrHead[i] <> nil then
    begin
      // sposta il campo in base al campo precedente
      if not Primo then
      begin
        ArrHead[i].Left:=ArrHead[i - 1].Left + ArrHead[i - 1].Width + Spazio;
        ArrDett[i].Left:=ArrDett[i - 1].Left + ArrDett[i - 1].Width + Spazio;
        if ArrFoot[i] <> nil then
          ArrFoot[i].Left:=ArrFoot[i - 1].Left + ArrFoot[i - 1].Width + Spazio;
      end;

      // aumenta width campo
      if not ContieneTag(ArrHead[i].Tag,TAG_NO_RIPROPORZIONA) then
      begin
        ArrHead[i].Width:=ArrHead[i].Width + ArrExtWidth[i];
        ArrDett[i].Width:=ArrDett[i].Width + ArrExtWidth[i];
        if ArrFoot[i] <> nil then
          ArrFoot[i].Width:=ArrFoot[i].Width + ArrExtWidth[i];
      end;

      // sposta linea separatrice vert.
      if i < High(ArrHead) then
      begin
        ArrLinesHead[i].Left:=ArrHead[i].Left + ArrHead[i].Width + 2;
        ArrLinesDett[i].Left:=ArrDett[i].Left + ArrDett[i].Width + 2;
        if ArrFoot[i] <> nil then
          ArrLinesFoot[i].Left:=ArrFoot[i].Left + ArrFoot[i].Width + 2;
      end;
      Primo:=False;
    end;
  end;
  SetLength(ArrExtWidth,0);
end;

procedure TA040FStampa2.DistruggiComponenti;
var
  i: Integer;
begin
  // rimuove vecchi riferimenti
  LastBandLegenda:=nil;

  // dealloca oggetti in array
  for i:=0 to High(ArrHead) do
    FreeAndNil(ArrHead[i]);
  for i:=0 to High(ArrLinesHead) do
    FreeAndNil(ArrLinesHead[i]);
  for i:=0 to High(ArrDett) do
    FreeAndNil(ArrDett[i]);
  for i:=0 to High(ArrLinesDett) do
    FreeAndNil(ArrLinesDett[i]);
  for i:=0 to High(ArrFoot) do
    FreeAndNil(ArrFoot[i]);
  for i:=0 to High(ArrLinesFoot) do
    FreeAndNil(ArrLinesFoot[i]);

  // dealloca array
  SetLength(ArrHead,0);
  SetLength(ArrLinesHead,0);
  SetLength(ArrDett,0);
  SetLength(ArrLinesDett,0);
  SetLength(ArrFoot,0);
  SetLength(ArrLinesFoot,0);
end;

procedure TA040FStampa2.CreaReport;
begin
  // gestione campo raggruppamento
  if AbilRaggr then
  begin
    ChildBand1.Enabled:=True;
    QRGroup1.Expression:=A040FPianifRepDtM2.NomeCampoRaggr;
    QRLRaggruppamento.Caption:=A040FPianifRepDtM2.NomeLogicoRaggr + ':';
    QRDBTRaggr.DataField:=A040FPianifRepDtM2.NomeCampoRaggr;
    QRLRaggruppamentoChild.Caption:=A040FPianifRepDtM2.NomeLogicoRaggr + ':';
    QRDBTRaggrChild.DataField:=A040FPianifRepDtM2.NomeCampoRaggr;
    QRGroup1.Enabled:=True;
  end
  else
  begin
    QRGroup1.Enabled:=False;
    ChildBand1.Enabled:=False;
  end;

  CreaComponenti;
end;

procedure TA040FStampa2.QRBDettaglioAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  inherited;
  QRGroup1.Height:=27;
end;

// Gestione legenda
procedure TA040FStampa2.QRBLegendaHeadBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  i: Integer;
begin
  inherited;

  // imposta proprietà dei separatori orizzontali
  QRLineHeadT.Top:=20;
  QRLineHeadB.Top:=Sender.Height - 1;

  // adatta altezza linee verticali
  for i:=0 to Sender.ControlCount - 1 do
  begin
    if Sender.Controls[i] is TQRShape then
      if TQRShape(Sender.Controls[i]).Shape = qrsVertLine then
      begin
        TQRShape(Sender.Controls[i]).Top:=QRLineHeadT.Top + 1;
        TQRShape(Sender.Controls[i]).Height:=Sender.Height - TQRShape(Sender.Controls[i]).Top;
      end;
  end;
end;

procedure TA040FStampa2.QRBLegendaDettBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  i,altezza: Integer;
  h: Extended;
begin
  inherited;

  // ricalcola altezza banda
  Sender.ExpandedHeight(h);
  altezza:=Round(h * ProporzioneBandExpanded);
  Sender.Height:=altezza;

  // adatta altezza linee verticali
  for i:=0 to Sender.ControlCount - 1 do
  begin
    if Sender.Controls[i] is TQRShape then
      if TQRShape(Sender.Controls[i]).Shape = qrsVertLine then
      begin
        TQRShape(Sender.Controls[i]).Top:=0;
        TQRShape(Sender.Controls[i]).Height:=altezza;
      end
      else if TQRShape(Sender.Controls[i]).Shape = qrsHorLine then
      begin
        // unica linea orizzontale è il separatore in basso
        TQRShape(Sender.Controls[i]).Top:=(altezza - 1);
      end;
  end;
end;

procedure TA040FStampa2.QRBLegendaDettAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
var
  i: Integer;
begin
  inherited;
  if VisualizzaLegenda then
  begin
    A040FPianifRepDtM2.cdsLegenda.Next;
    if not A040FPianifRepDtM2.cdsLegenda.Eof then
    begin
      Sender.HasChild:=True;
      Sender.ChildBand.BeforePrint:=QRBLegendaDettBeforePrint;
      Sender.ChildBand.AfterPrint:=QRBLegendaDettAfterPrint;
      Sender.ChildBand.Name:=Format('QRBLegendaDett_%.5d',[A040FPianifRepDtM2.cdsLegenda.RecNo]);
      // spostare tutti i componenti su Sender.ChildBand
      for i:=Sender.ControlCount - 1 downto 0 do
        Sender.Controls[i].Parent:=Sender.ChildBand;
      Sender.ChildBand.Height:=Sender.Height;

      LastBandLegenda:=Sender.ChildBand;
    end;
  end;
end;

procedure TA040FStampa2.RimuoviLegenda;
{ elimina le childband create per la legenda }
var
  QRCB: TQRCustomBand;
  i: Integer;
begin
  if LastBandLegenda <> nil then
  begin
    QRCB:=LastBandLegenda;
    while QRCB <> QRBLegendaDett do
    begin
      for i:=QRCB.ControlCount - 1 downto 0 do
        QRCB.Controls[i].Parent:=TQRChildBand(QRCB).ParentBand;
      QRCB:=TQRChildBand(QRCB).ParentBand;
      QRCB.HasChild:=False;
    end;
  end;
end;

end.
