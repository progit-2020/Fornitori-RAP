unit S715UStampaValutazioni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R002UQREP, QRPDFFilt, QRExport, QRWebFilt, QRCtrls, QuickRpt, QRPrntr, ExtCtrls,
  A000UInterfaccia, C180FunzioniGenerali, Oracle, OracleData, DB, Math, StrUtils;

type
  TS715FStampaValutazioni = class(TR002FQRep)
    bndDetailVuoto: TQRBand;
    bndElementi: TQRSubDetail;
    bndObiettiviPianificati: TQRChildBand;
    qlblTitoloObiettiviPianificati: TQRLabel;
    dlblObiettiviPianificati: TQRDBText;
    bndCommentiValutato: TQRChildBand;
    qlblTitoloCommentiValutato: TQRLabel;
    dlblCommentiValutato: TQRDBText;
    bndFirme: TQRChildBand;
    qlblFirma1: TQRLabel;
    shpFirma1: TQRShape;
    qlblFirma2: TQRLabel;
    shpFirma2: TQRShape;
    qlblFirma3: TQRLabel;
    shpFirma3: TQRShape;
    dlblCodItem: TQRDBText;
    dlblDescItem: TQRDBText;
    dlblValutabile: TQRDBText;
    dlblPunteggioPesato: TQRDBText;
    lnDescItem: TQRShape;
    lnValutabile: TQRShape;
    lnSogliaPunteggio: TQRShape;
    bndRotturaChiaveAnagrafica: TQRGroup;
    bndRotturaChiaveAree: TQRGroup;
    qlblTitoloCodItem: TQRLabel;
    qlblTitoloDescItem: TQRLabel;
    dlblCodArea: TQRDBText;
    dlblDescArea: TQRDBText;
    dlblPunteggioArea: TQRDBText;
    qlblTitoloValutabile: TQRLabel;
    qlblTitoloPunteggioPesato: TQRLabel;
    qlblTitoloCodArea: TQRLabel;
    qlblTitoloDescArea: TQRLabel;
    qlblTitoloPunteggioArea: TQRLabel;
    lnTitoloValutabile: TQRShape;
    lnDivTitoliAreeItem: TQRShape;
    lnTitoloPunteggioPesato: TQRShape;
    lnTitoloDescArea: TQRShape;
    lnTitoloPunteggioArea: TQRShape;
    bndIntestazione: TQRChildBand;
    dlblAnnoValutazione: TQRDBText;
    dlblMatrValutato: TQRDBText;
    dlblMatrValutatore: TQRDBText;
    dlblNomValutato: TQRDBText;
    dlblNomValutatore: TQRDBText;
    qlblTitoloAnnoValutazione: TQRLabel;
    qlblTitoloMatrValutato: TQRLabel;
    qlblTitoloMatrValutatore: TQRLabel;
    lnPFP: TQRShape;
    lnDivValutatoValutatore: TQRShape;
    bndProposteFormative: TQRChildBand;
    qlblTitoloProposteFormative: TQRLabel;
    dlblProposteFormative: TQRDBText;
    qlblTitoloPunteggioFinalePesato: TQRLabel;
    dlblPunteggioFinalePesato: TQRDBText;
    bndPunteggi: TQRChildBand;
    dlblLegendaPunteggi: TQRDBText;
    qlblTitoloLegendaPunteggi: TQRLabel;
    bndItemPersonalizzato: TQRChildBand;
    lblItemPersonalizzato: TQRLabel;
    qimgLogo: TQRImage;
    lnValutatoValutatore: TQRShape;
    bndAccettazioneValutato: TQRChildBand;
    qlblAccettazioneValutato: TQRLabel;
    qlblAccettazioneValutatoSiNo: TQRLabel;
    qlblTitoloSogliaPunteggio: TQRLabel;
    lnTitoloSogliaPunteggio: TQRShape;
    dlblSogliaPunteggio: TQRDBText;
    lnPunteggio: TQRShape;
    lnTitoloPercValutazione: TQRShape;
    qlblTitoloPercValutazione: TQRLabel;
    lnPercValutazione: TQRShape;
    dlblPercValutazione: TQRDBText;
    bndNoteIncentivo: TQRChildBand;
    dlblNoteIncentivo: TQRDBText;
    bndPunteggioFinalePesato: TQRChildBand;
    qlblTitoloPunteggioFinalePesato2: TQRLabel;
    dlblPunteggioFinalePesato2: TQRDBText;
    lblStato: TQRLabel;
    qlblFirma4: TQRLabel;
    shpFirma4: TQRShape;
    qlblFirma5: TQRLabel;
    shpFirma5: TQRShape;
    qlblFirma6: TQRLabel;
    shpFirma6: TQRShape;
    dlblPeriodoValutazione: TQRDBText;
    bndDatiAnagrafici: TQRChildBand;
    dlblDato3Valutato: TQRDBText;
    dlblDato2Valutato: TQRDBText;
    dlblDato4Valutato: TQRDBText;
    dlblDato5Valutato: TQRDBText;
    dlblDato6Valutato: TQRDBText;
    qlblTitoloDato3Valutato: TQRLabel;
    qlblTitoloDato2Valutato: TQRLabel;
    qlblTitoloDato4Valutato: TQRLabel;
    qlblTitoloDato5Valutato: TQRLabel;
    qlblTitoloDato6Valutato: TQRLabel;
    shpDivisore2: TQRShape;
    shpDivisore1: TQRShape;
    shpDivisore4: TQRShape;
    shpDivisore3: TQRShape;
    qlblTitoloDato1Valutato: TQRLabel;
    dlblDato1Valutato: TQRDBText;
    shpDivisore5: TQRShape;
    dlblFirma2: TQRDBText;
    dlblFirma1: TQRDBText;
    dlblFirma3: TQRDBText;
    dlblFirma4: TQRDBText;
    dlblFirma5: TQRDBText;
    dlblFirma6: TQRDBText;
    lnTitoloPercArea: TQRShape;
    qlblTitoloPercArea: TQRLabel;
    dlblPercArea: TQRDBText;
    qlblTitoloPunteggio: TQRLabel;
    lnTitoloPunteggio: TQRShape;
    dlblPunteggio: TQRDBText;
    lnPunteggioPesato: TQRShape;
    QRShape2: TQRShape;
    lnBottomElementi: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    lnTitoloCodArea: TQRShape;
    lnEndRotturaChiaveAree: TQRShape;
    lnCodItem: TQRShape;
    lnEndItem: TQRShape;
    bndRigaNera: TQRBand;
    bndValutazioniComplessive: TQRChildBand;
    qlblTitoloValutazioniComplessive: TQRLabel;
    dlblValutazioniComplessive: TQRDBText;
    lnRigaNera: TQRShape;
    lnTopRotturaChiaveAree: TQRShape;
    bndPresaVisione: TQRChildBand;
    dlblPresaVisione: TQRDBText;
    qlblTitoloPresaVisione: TQRLabel;
    bndNote: TQRChildBand;
    qlblTitoloNote: TQRLabel;
    dlblNote: TQRDBText;
    bndNotePunteggio: TQRChildBand;
    qlblTitoloNotePunteggio: TQRLabel;
    dlblNotePunteggio: TQRDBText;
    lnNotePunteggioSx: TQRShape;
    lnNotePunteggioDx: TQRShape;
    lnEndNotePunteggio: TQRShape;
    lnStartNotePunteggio: TQRShape;
    lnBottomNotePunteggio: TQRShape;
    shpDivisore6: TQRShape;
    dlblDataProtocollo: TQRDBText;
    qlblTitoloProtocollo: TQRLabel;
    dlblNumeroEAnnoProtocollo: TQRDBText;
    bndValutazioneIntermedia: TQRChildBand;
    qlblTitoloValutazioneIntermedia: TQRLabel;
    dlblValutazioneIntermedia: TQRDBText;
    procedure FormCreate(Sender: TObject);
    procedure QRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure TitoloBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndIntestazioneBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndRotturaChiaveAreeAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
    procedure bndElementiBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndValutazioneIntermediaBeforePrint(Sender: TQRCustomBand;var PrintBand: Boolean);
    procedure bndValutazioniComplessiveBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndObiettiviPianificatiBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndProposteFormativeBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndCommentiValutatoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndItemPersonalizzatoBeforePrint(Sender: TQRCustomBand;var PrintBand: Boolean);
    procedure bndNoteIncentivoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndPunteggioFinalePesatoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndAccettazioneValutatoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndFirmeBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndPunteggiBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndDatiAnagraficiBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndPresaVisioneBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndNoteBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndNotePunteggioBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    { Private declarations }
    svHTitolo,svHIntestazione,svHRotturaChiaveAree,svHElementi,svHNotePunteggio,LarghezzaColonna,
    svWDescArea,svWDescItem,svLPunteggio,svLSogliaPunteggio,svLPercValutazione,svLValutabile,svWNotePunteggio:Integer;
    PresenzaItemPersonalizzati,Fase1StampaDirigenzaConObiettivi,Fase2StampaDirigenzaConObiettivi:Boolean;
    H: Extended;
  public
    { Public declarations }
  end;

var
  S715FStampaValutazioni: TS715FStampaValutazioni;

const
  H1: Extended = 0.37788385044; //Valore fisso

implementation

{$R *.dfm}

uses
  S715UStampaValutazioniDtM, S715UDialogStampa;

procedure TS715FStampaValutazioni.FormCreate(Sender: TObject);
begin
  inherited;
  svHTitolo:=Titolo.Height;
  svHIntestazione:=bndIntestazione.Height;
  svHRotturaChiaveAree:=bndRotturaChiaveAree.Height;
  svHElementi:=bndElementi.Height;
  svHNotePunteggio:=bndNotePunteggio.Height;
  LarghezzaColonna:=lnDivTitoliAreeItem.Width - lnTitoloPunteggioPesato.Left;
  svWDescArea:=dlblDescArea.Width;
  svWDescItem:=dlblDescItem.Width;
  svLPunteggio:=dlblPunteggio.Left;
  svLSogliaPunteggio:=dlblSogliaPunteggio.Left;
  svLPercValutazione:=dlblPercValutazione.Left;
  svLValutabile:=dlblValutabile.Left;
  svWNotePunteggio:=dlblNotePunteggio.Width;
end;

procedure TS715FStampaValutazioni.QRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  inherited;
  bndDetailVuoto.Height:=0;
  bndRotturaChiaveAnagrafica.Height:=0;
  bndRigaNera.Height:=2;
  S715FStampaValutazioniDtM.CambioScheda:=False;
  bndIntestazione.Frame.Width:=IfThen(QRep.qrprinter.destination = qrdPrinter,1,2);
  bndDatiAnagrafici.Frame.Width:=bndIntestazione.Frame.Width;
  bndValutazioneIntermedia.Frame.Width:=bndIntestazione.Frame.Width;
  bndValutazioniComplessive.Frame.Width:=bndIntestazione.Frame.Width;
  bndObiettiviPianificati.Frame.Width:=bndIntestazione.Frame.Width;
  bndProposteFormative.Frame.Width:=bndIntestazione.Frame.Width;
  bndCommentiValutato.Frame.Width:=bndIntestazione.Frame.Width;
  bndNote.Frame.Width:=bndIntestazione.Frame.Width;
  lnValutatoValutatore.Pen.Width:=IfThen(QRep.qrprinter.destination = qrdPrinter,5,2);
  lnDivValutatoValutatore.Pen.Width:=lnValutatoValutatore.Pen.Width;
  lnPFP.Pen.Width:=lnValutatoValutatore.Pen.Width;
  shpDivisore1.Pen.Width:=lnValutatoValutatore.Pen.Width;
  shpDivisore2.Pen.Width:=lnValutatoValutatore.Pen.Width;
  shpDivisore3.Pen.Width:=lnValutatoValutatore.Pen.Width;
  shpDivisore4.Pen.Width:=lnValutatoValutatore.Pen.Width;
  shpDivisore5.Pen.Width:=lnValutatoValutatore.Pen.Width;
  lnTitoloDescArea.Pen.Width:=lnValutatoValutatore.Pen.Width;
  lnTitoloCodArea.Pen.Width:=lnValutatoValutatore.Pen.Width;
  lnTitoloPercArea.Pen.Width:=lnValutatoValutatore.Pen.Width;
  lnTitoloPunteggioArea.Pen.Width:=lnValutatoValutatore.Pen.Width;
  lnEndRotturaChiaveAree.Pen.Width:=lnValutatoValutatore.Pen.Width;
  lnDivTitoliAreeItem.Pen.Width:=lnValutatoValutatore.Pen.Width;
  dlblDescItem.Font.Size:=IfThen((QRep.qrprinter.destination = qrdPrinter) or QRep.Exporting,6,7);
  dlblDescItem.Top:=IfThen((QRep.qrprinter.destination = qrdPrinter) or QRep.Exporting,3,2);
  dlblDescItem.Height:=IfThen((QRep.qrprinter.destination = qrdPrinter) or QRep.Exporting,9,14);
  dlblNotePunteggio.Height:=IfThen((QRep.qrprinter.destination = qrdPrinter) or QRep.Exporting,9,10);
  dlblValutazioneIntermedia.Font.Size:=dlblDescItem.Font.Size;
  dlblValutazioniComplessive.Font.Size:=dlblDescItem.Font.Size;
  dlblObiettiviPianificati.Font.Size:=dlblDescItem.Font.Size;
  dlblProposteFormative.Font.Size:=dlblDescItem.Font.Size;
  dlblCommentiValutato.Font.Size:=dlblDescItem.Font.Size;
  dlblNote.Font.Size:=dlblDescItem.Font.Size;
  qlblTitoloPunteggioFinalePesato2.Font.Size:=dlblDescItem.Font.Size;
  qlblAccettazioneValutato.Font.Size:=dlblDescItem.Font.Size;
  dlblLegendaPunteggi.Font.Size:=dlblDescItem.Font.Size;
  dlblPresaVisione.Font.Size:=dlblDescItem.Font.Size;
end;

procedure TS715FStampaValutazioni.TitoloBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var OS8:TOracleSession;
    ODS:TOracleDataSet;
    EsisteFaseAssegnazionePreventivaObiettivi:Boolean;
    StampaAreaPerc,StampaAreaPunteggio,StampaItemValutabile,StampaItemPerc,StampaItemSoglia,StampaItemPunteggio,StampaItemPunteggioPesato:Boolean;
    LarghezzaMancante:Integer;
begin
  inherited;
  with S715FStampaValutazioniDtM do
    if CambioScheda then
    begin
      //Mi posiziono sul periodo storico corretto per prelevare le regole delle valutazioni
      RecuperaRegole(cdsStampaAnagrafico.FieldByName('DATARIF').AsDateTime,cdsStampaAnagrafico.FieldByName('PROG_VALUTATO').AsInteger,cdsStampaAnagrafico.FieldByName('CODREGOLA').AsString);
      PresenzaItemPersonalizzati:=VarToStr(cdsStampaElementi.Lookup('ITEM_PERSONALIZZATO','S','ITEM_PERSONALIZZATO')) = 'S';
      EsisteFaseAssegnazionePreventivaObiettivi:=selSG741.FieldByName('ASSEGN_PREVENTIVA_OBIETTIVI').AsString = 'S';
      Fase1StampaDirigenzaConObiettivi:=EsisteFaseAssegnazionePreventivaObiettivi and (cdsStampaAnagrafico.FieldByName('PUNTEGGI_ASSEGNATI').AsString = 'N');
      Fase2StampaDirigenzaConObiettivi:=EsisteFaseAssegnazionePreventivaObiettivi and (cdsStampaAnagrafico.FieldByName('PUNTEGGI_ASSEGNATI').AsString = 'S');
      CambioScheda:=False;
      //Campi di dettaglio: impostati qui per eseguire i controlli una volta sola per pagina
      StampaAreaPerc:=R180InConcat('1',selSG741.FieldByName('CAMPI_OPZIONALI_STAMPA').AsString);
      StampaAreaPunteggio:=R180InConcat('2',selSG741.FieldByName('CAMPI_OPZIONALI_STAMPA').AsString);
      StampaItemValutabile:=cdsStampaAnagrafico.FieldByName('VIS_COL_VALUTABILE').AsString = 'S';
      StampaItemPerc:=R180InConcat('3',selSG741.FieldByName('CAMPI_OPZIONALI_STAMPA').AsString);
      StampaItemSoglia:=cdsStampaAnagrafico.FieldByName('VIS_COL_SOGLIA_PUNTEGGIO').AsString = 'S';
      StampaItemPunteggio:=True;
      StampaItemPunteggioPesato:=R180InConcat('4',selSG741.FieldByName('CAMPI_OPZIONALI_STAMPA').AsString);
      //Resetto le dimensioni e le posizioni
      //Descrizione area
      dlblDescArea.Width:=svWDescArea;
      //Descrizione elemento
      dlblDescItem.Width:=svWDescItem;
      //Colonna Percentuale area / Punteggio elemento
      dlblPunteggio.Left:=svLPunteggio;
      lnPunteggio.Left:=svLPunteggio - 2;
      qlblTitoloPunteggio.Left:=svLPunteggio;
      lnTitoloPunteggio.Left:=svLPunteggio - 2;
      dlblPercArea.Left:=svLPunteggio;
      qlblTitoloPercArea.Left:=svLPunteggio;
      lnTitoloPercArea.Left:=svLPunteggio - 2;
      //Colonna Soglia elemento
      dlblSogliaPunteggio.Left:=svLSogliaPunteggio;
      lnSogliaPunteggio.Left:=svLSogliaPunteggio - 2;
      qlblTitoloSogliaPunteggio.Left:=svLSogliaPunteggio;
      lnTitoloSogliaPunteggio.Left:=svLSogliaPunteggio - 2;
      //Percentuale Soglia elemento
      dlblPercValutazione.Left:=svLPercValutazione;
      lnPercValutazione.Left:=svLPercValutazione - 2;
      qlblTitoloPercValutazione.Left:=svLPercValutazione;
      lnTitoloPercValutazione.Left:=svLPercValutazione - 2;
      //Elemento valutabile
      dlblValutabile.Left:=svLValutabile;
      lnValutabile.Left:=svLValutabile - 2;
      qlblTitoloValutabile.Left:=svLValutabile;
      lnTitoloValutabile.Left:=svLValutabile - 2;
      //Note punteggio
      dlblNotePunteggio.Width:=svWNotePunteggio;
      lnNotePunteggioDx.Left:=svLValutabile - 2;
      //Rottura chiave aree
      bndRotturaChiaveAree.Height:=svHRotturaChiaveAree;
      //Ricalcolo le dimensioni e le posizioni
      //Punteggio area
      qlblTitoloPunteggioArea.Enabled:=StampaAreaPunteggio;
      qlblTitoloPunteggioArea.Caption:=RecuperaEtichetta('PUNTEGGIO_AREA_S','U');
      dlblPunteggioArea.Enabled:=StampaAreaPunteggio;
      lnTitoloPunteggioArea.Enabled:=StampaAreaPunteggio;
      LarghezzaMancante:=0;
      //Percentuale area
      if not StampaAreaPunteggio then
        LarghezzaMancante:=LarghezzaMancante + LarghezzaColonna;
      qlblTitoloPercArea.Enabled:=StampaAreaPerc;
      qlblTitoloPercArea.Caption:=RecuperaEtichetta('PESO_AREA_S','U');
      qlblTitoloPercArea.Left:=qlblTitoloPercArea.Left + LarghezzaMancante;
      dlblPercArea.Enabled:=StampaAreaPerc;
      dlblPercArea.Left:=dlblPercArea.Left + LarghezzaMancante;
      lnTitoloPercArea.Enabled:=StampaAreaPerc;
      lnTitoloPercArea.Left:=lnTitoloPercArea.Left + LarghezzaMancante;
      //Descrizione area
      if not StampaAreaPerc then
        LarghezzaMancante:=LarghezzaMancante + LarghezzaColonna;
      qlblTitoloDescArea.Caption:=RecuperaEtichetta('DESCRIZIONE_AREA_S','U');
      dlblDescArea.Width:=dlblDescArea.Width + LarghezzaMancante;
      //Codice area
      qlblTitoloCodArea.Caption:=RecuperaEtichetta('CODICE_AREA_S','U');
      //Punteggio pesato elemento
      qlblTitoloPunteggioPesato.Enabled:=StampaItemPunteggioPesato;
      qlblTitoloPunteggioPesato.Caption:=RecuperaEtichetta('PUNTEGGIO_PESATO_ITEM_S','U');
      dlblPunteggioPesato.Enabled:=StampaItemPunteggioPesato;
      lnTitoloPunteggioPesato.Enabled:=StampaItemPunteggioPesato;
      lnPunteggioPesato.Enabled:=StampaItemPunteggioPesato;
      LarghezzaMancante:=0;
      //Punteggio elemento
      if not StampaItemPunteggioPesato then
        LarghezzaMancante:=LarghezzaMancante + LarghezzaColonna;
      qlblTitoloPunteggio.Enabled:=StampaItemPunteggio;
      qlblTitoloPunteggio.Caption:=RecuperaEtichetta('PUNTEGGIO_ITEM_S','U');
      qlblTitoloPunteggio.Left:=qlblTitoloPunteggio.Left + LarghezzaMancante;
      dlblPunteggio.Enabled:=StampaItemPunteggio;
      dlblPunteggio.Left:=dlblPunteggio.Left + LarghezzaMancante;
      lnTitoloPunteggio.Enabled:=StampaItemPunteggio;
      lnTitoloPunteggio.Left:=lnTitoloPunteggio.Left + LarghezzaMancante;
      lnPunteggio.Enabled:=StampaItemPunteggio;
      lnPunteggio.Left:=lnPunteggio.Left + LarghezzaMancante;
      //Soglia elemento
      if not StampaItemPunteggio then
        LarghezzaMancante:=LarghezzaMancante + LarghezzaColonna;
      qlblTitoloSogliaPunteggio.Enabled:=StampaItemSoglia;
      qlblTitoloSogliaPunteggio.Caption:=RecuperaEtichetta('SOGLIA_PUNTEGGIO_ITEM_S','U');
      qlblTitoloSogliaPunteggio.Left:=qlblTitoloSogliaPunteggio.Left + LarghezzaMancante;
      dlblSogliaPunteggio.Enabled:=StampaItemSoglia;
      dlblSogliaPunteggio.Left:=dlblSogliaPunteggio.Left + LarghezzaMancante;
      lnTitoloSogliaPunteggio.Enabled:=StampaItemSoglia;
      lnTitoloSogliaPunteggio.Left:=lnTitoloSogliaPunteggio.Left + LarghezzaMancante;
      lnSogliaPunteggio.Enabled:=StampaItemSoglia;
      lnSogliaPunteggio.Left:=lnSogliaPunteggio.Left + LarghezzaMancante;
      //Percentuale elemento
      if not StampaItemSoglia then
        LarghezzaMancante:=LarghezzaMancante + LarghezzaColonna;
      qlblTitoloPercValutazione.Enabled:=StampaItemPerc;
      qlblTitoloPercValutazione.Caption:=RecuperaEtichetta('PESO_ITEM_S','U');
      qlblTitoloPercValutazione.Left:=qlblTitoloPercValutazione.Left + LarghezzaMancante;
      dlblPercValutazione.Enabled:=StampaItemPerc;
      dlblPercValutazione.Left:=dlblPercValutazione.Left + LarghezzaMancante;
      lnTitoloPercValutazione.Enabled:=StampaItemPerc;
      lnTitoloPercValutazione.Left:=lnTitoloPercValutazione.Left + LarghezzaMancante;
      lnPercValutazione.Enabled:=StampaItemPerc;
      lnPercValutazione.Left:=lnPercValutazione.Left + LarghezzaMancante;
      //Elemento valutabile
      if not StampaItemPerc then
        LarghezzaMancante:=LarghezzaMancante + LarghezzaColonna;
      qlblTitoloValutabile.Enabled:=StampaItemValutabile;
      qlblTitoloValutabile.Caption:=RecuperaEtichetta('ITEM_VALUTABILE_S','U');
      qlblTitoloValutabile.Left:=qlblTitoloValutabile.Left + LarghezzaMancante;
      dlblValutabile.Enabled:=StampaItemValutabile;
      dlblValutabile.Left:=dlblValutabile.Left + LarghezzaMancante;
      lnTitoloValutabile.Enabled:=StampaItemValutabile;
      lnTitoloValutabile.Left:=lnTitoloValutabile.Left + LarghezzaMancante;
      lnValutabile.Enabled:=StampaItemValutabile;
      lnValutabile.Left:=lnValutabile.Left + LarghezzaMancante;
      //Descrizione elemento
      if not StampaItemValutabile then
        LarghezzaMancante:=LarghezzaMancante + LarghezzaColonna;
      qlblTitoloDescItem.Caption:=RecuperaEtichetta('DESCRIZIONE_ITEM_S','U');
      dlblDescItem.Width:=dlblDescItem.Width + LarghezzaMancante;
      //Note punteggio
      qlblTitoloNotePunteggio.Caption:=RecuperaEtichetta('NOTE_PUNTEGGIO_S','U') + ':';
      dlblNotePunteggio.Width:=dlblNotePunteggio.Width + LarghezzaMancante;
      lnNotePunteggioDx.Left:=lnNotePunteggioDx.Left + LarghezzaMancante;
      //Codice elemento
      qlblTitoloCodItem.Caption:=RecuperaEtichetta('CODICE_ITEM_S','U');
      //Titoli dettaglio
      if (RecuperaEtichetta('CODICE_ITEM_S') = '')
      and (RecuperaEtichetta('DESCRIZIONE_ITEM_S') = '')
      and (RecuperaEtichetta('ITEM_VALUTABILE_S') = '')
      and (RecuperaEtichetta('PESO_ITEM_S') = '')
      and (RecuperaEtichetta('SOGLIA_PUNTEGGIO_ITEM_S') = '')
      and (RecuperaEtichetta('PUNTEGGIO_ITEM_S') = '')
      and (RecuperaEtichetta('PUNTEGGIO_PESATO_ITEM_S') = '') then
        bndRotturaChiaveAree.Height:=lnDivTitoliAreeItem.Top + lnDivTitoliAreeItem.Height;
    end;

  Titolo.Height:=svHTitolo;
  with S715FStampaValutazioniDtM.cdsStampaAnagrafico do
  begin
    LTitolo.Caption:='Scheda di ' +
                     IfThen(FieldByName('TIPO_VALUTAZIONE').AsString = 'A','Autovalutazione','Valutazione') +
                     ' del ' + FormatDateTime('dd/mm/yyyy',FieldByName('DATA_COMPILAZIONE').AsDateTime);
    lblStato.Caption:=FieldByName('STATO_SCHEDA').AsString;
    qlblTitoloProtocollo.Enabled:=Trim(FieldByName('NumeroEAnno_Protocollo').AsString) <> '';
    dlblNumeroEAnnoProtocollo.Enabled:=Trim(FieldByName('NumeroEAnno_Protocollo').AsString) <> '';
    dlblDataProtocollo.Enabled:=Trim(FieldByName('NumeroEAnno_Protocollo').AsString) <> '';
  end;
  try
    begin
      OS8:=TOracleSession.Create(nil);
      ODS:=TOracleDataSet.Create(nil);
      qimgLogo.Width:=0;
      qimgLogo.Height:=0;
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
          with S715FStampaValutazioniDtM do
          begin
            qimgLogo.Width:=selSG741.FieldByName('LOGO_LARGHEZZA').AsInteger;
            qimgLogo.Height:=selSG741.FieldByName('LOGO_ALTEZZA').AsInteger;
            qimgLogo.Picture.BitMap.Assign(TBlobField(ODS.FieldByName('IMMAGINE')));
          end;
        ODS.Close;
        OS8.Logoff;
      finally
        FreeAndNil(ODS);
        FreeAndNil(OS8);
      end;
      TQRBand(qimgLogo.Parent).Height:=max(TQRBand(qimgLogo.Parent).Height,qimgLogo.Top + qimgLogo.Height);
    end;
  except
    qimgLogo.Enabled:=False;
  end;
end;

procedure TS715FStampaValutazioni.bndIntestazioneBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var i:Integer;
begin
  inherited;
  with S715FStampaValutazioniDtM do
  begin
    Sender.Height:=svHIntestazione;
    qlblTitoloAnnoValutazione.Caption:=RecuperaEtichetta('ANNO_VALUTAZIONE_S','U');
    dlblPeriodoValutazione.Enabled:=selSG741.FieldByName('STAMPA_PERIODO_VALUTAZIONE').AsString = 'S';
    qlblTitoloMatrValutato.Caption:=RecuperaEtichetta('VALUTATO_S','U');
    qlblTitoloMatrValutatore.Caption:=RecuperaEtichetta('VALUTATORE_S','U');
    lnValutatoValutatore.Height:=bndIntestazione.Height;
    for i:=2 to cdsStampaAnagrafico.FieldByName('N_VALUTATORI').AsInteger do
      lnValutatoValutatore.Height:=lnValutatoValutatore.Height + dlblMatrValutato.Height - 2;
    lnPFP.Height:=lnValutatoValutatore.Height;
    lnDivValutatoValutatore.Width:=lnPFP.Left - lnValutatoValutatore.Left;
    if (cdsStampaAnagrafico.FieldByName('CALCOLO_PFP').AsString = 'S')
    and not (Fase1StampaDirigenzaConObiettivi or Fase2StampaDirigenzaConObiettivi) then
    begin
      lnPFP.Enabled:=True;
      qlblTitoloPunteggioFinalePesato.Enabled:=True;
      qlblTitoloPunteggioFinalePesato.Caption:=RecuperaEtichetta('PUNTEGGIO_FINALE_SCHEDA_S','U');
      dlblPunteggioFinalePesato.Enabled:=True;
    end
    else
    begin
      lnPFP.Enabled:=False;
      qlblTitoloPunteggioFinalePesato.Enabled:=False;
      dlblPunteggioFinalePesato.Enabled:=False;
      lnDivValutatoValutatore.Width:=lnDivValutatoValutatore.Width + (bndIntestazione.Width - 1 - lnPFP.Left);
    end;
  end;
end;

procedure TS715FStampaValutazioni.bndDatiAnagraficiBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var TitoloDatoStampa1,TitoloDatoStampa2,TitoloDatoStampa3,TitoloDatoStampa4,TitoloDatoStampa5,TitoloDatoStampa6,Valore5:String;
begin
  inherited;
  with S715FStampaValutazioniDtM do
  begin
    TitoloDatoStampa1:=VarToStr(selI010.Lookup('NOME_CAMPO',selSG741.FieldByName('DATO_STAMPA_1').AsString,'NOME_LOGICO'));
    if selSG741.FieldByName('DESC_LUNGA_1').AsString = 'N' then
      TitoloDatoStampa2:=VarToStr(selI010.Lookup('NOME_CAMPO',selSG741.FieldByName('DATO_STAMPA_2').AsString,'NOME_LOGICO'));
    TitoloDatoStampa3:=VarToStr(selI010.Lookup('NOME_CAMPO',selSG741.FieldByName('DATO_STAMPA_3').AsString,'NOME_LOGICO'));
    if selSG741.FieldByName('DESC_LUNGA_3').AsString = 'N' then
      TitoloDatoStampa4:=VarToStr(selI010.Lookup('NOME_CAMPO',selSG741.FieldByName('DATO_STAMPA_4').AsString,'NOME_LOGICO'));
    TitoloDatoStampa5:=VarToStr(selI010.Lookup('NOME_CAMPO',selSG741.FieldByName('DATO_STAMPA_5').AsString,'NOME_LOGICO'));
    if selSG741.FieldByName('DESC_LUNGA_5').AsString = 'N' then
    TitoloDatoStampa6:=VarToStr(selI010.Lookup('NOME_CAMPO',selSG741.FieldByName('DATO_STAMPA_6').AsString,'NOME_LOGICO'));
    TitoloDatoStampa1:=StringReplace(TitoloDatoStampa1,OpzioneFirma6,IfThen(Fase1StampaDirigenzaConObiettivi or Fase2StampaDirigenzaConObiettivi,'',RecuperaEtichetta('FIRMA_6_S')),[rfReplaceAll]);
    TitoloDatoStampa2:=StringReplace(TitoloDatoStampa2,OpzioneFirma6,IfThen(Fase1StampaDirigenzaConObiettivi or Fase2StampaDirigenzaConObiettivi,'',RecuperaEtichetta('FIRMA_6_S')),[rfReplaceAll]);
    TitoloDatoStampa3:=StringReplace(TitoloDatoStampa3,OpzioneFirma6,IfThen(Fase1StampaDirigenzaConObiettivi or Fase2StampaDirigenzaConObiettivi,'',RecuperaEtichetta('FIRMA_6_S')),[rfReplaceAll]);
    TitoloDatoStampa4:=StringReplace(TitoloDatoStampa4,OpzioneFirma6,IfThen(Fase1StampaDirigenzaConObiettivi or Fase2StampaDirigenzaConObiettivi,'',RecuperaEtichetta('FIRMA_6_S')),[rfReplaceAll]);
    TitoloDatoStampa5:=StringReplace(TitoloDatoStampa5,OpzioneFirma6,IfThen(Fase1StampaDirigenzaConObiettivi or Fase2StampaDirigenzaConObiettivi,'',RecuperaEtichetta('FIRMA_6_S')),[rfReplaceAll]);
    TitoloDatoStampa6:=StringReplace(TitoloDatoStampa6,OpzioneFirma6,IfThen(Fase1StampaDirigenzaConObiettivi or Fase2StampaDirigenzaConObiettivi,'',RecuperaEtichetta('FIRMA_6_S')),[rfReplaceAll]);
    if (TitoloDatoStampa1 <> '')
    and (RecuperaEtichetta('DATO_STAMPA_1_S') <> '') then
      TitoloDatoStampa1:=RecuperaEtichetta('DATO_STAMPA_1_S');
    if (TitoloDatoStampa2 <> '')
    and (RecuperaEtichetta('DATO_STAMPA_2_S') <> '') then
      TitoloDatoStampa2:=RecuperaEtichetta('DATO_STAMPA_2_S');
    if (TitoloDatoStampa3 <> '')
    and (RecuperaEtichetta('DATO_STAMPA_3_S') <> '') then
      TitoloDatoStampa3:=RecuperaEtichetta('DATO_STAMPA_3_S');
    if (TitoloDatoStampa4 <> '')
    and (RecuperaEtichetta('DATO_STAMPA_4_S') <> '') then
      TitoloDatoStampa4:=RecuperaEtichetta('DATO_STAMPA_4_S');
    if (TitoloDatoStampa5 <> '')
    and (RecuperaEtichetta('DATO_STAMPA_5_S') <> '') then
      TitoloDatoStampa5:=RecuperaEtichetta('DATO_STAMPA_5_S');
    if (TitoloDatoStampa6 <> '')
    and (RecuperaEtichetta('DATO_STAMPA_6_S') <> '') then
      TitoloDatoStampa6:=RecuperaEtichetta('DATO_STAMPA_6_S');
  end;
  //Imposto l'altezza della banda di testata e i titoletti dei dati anagrafici del valutato
  Sender.Height:=85;
  shpDivisore2.Enabled:=True;
  shpDivisore4.Enabled:=True;
  shpDivisore6.Enabled:=True;
  if (TitoloDatoStampa6 = '') and (TitoloDatoStampa5 = '') then
  begin
    Sender.Height:=57;
    shpDivisore6.Enabled:=False;
    if (TitoloDatoStampa4 = '') and (TitoloDatoStampa3 = '') then
    begin
      Sender.Height:=29;
      shpDivisore4.Enabled:=False;
      if (TitoloDatoStampa2 = '') and (TitoloDatoStampa1 = '') then
      begin
        Sender.Height:=0;
        shpDivisore2.Enabled:=False;
      end;
    end;
  end;
  qlblTitoloDato1Valutato.Caption:=TitoloDatoStampa1;
  qlblTitoloDato2Valutato.Caption:=TitoloDatoStampa2;
  qlblTitoloDato3Valutato.Caption:=TitoloDatoStampa3;
  qlblTitoloDato4Valutato.Caption:=TitoloDatoStampa4;
  qlblTitoloDato5Valutato.Caption:=TitoloDatoStampa5;
  qlblTitoloDato6Valutato.Caption:=TitoloDatoStampa6;
  with S715FStampaValutazioniDtM.selSG741 do
  begin
    dlblDato1Valutato.Width:=IfThen(FieldByName('DESC_LUNGA_1').AsString = 'N',350,700);
    shpDivisore1.Enabled:=(FieldByName('DESC_LUNGA_1').AsString = 'N') and (Sender.Height >= 29);
    dlblDato2Valutato.Enabled:=shpDivisore1.Enabled;
    dlblDato3Valutato.Width:=IfThen(FieldByName('DESC_LUNGA_3').AsString = 'N',350,700);
    shpDivisore3.Enabled:=(FieldByName('DESC_LUNGA_3').AsString = 'N') and (Sender.Height >= 57);
    dlblDato4Valutato.Enabled:=shpDivisore3.Enabled;
    dlblDato5Valutato.Width:=IfThen(FieldByName('DESC_LUNGA_5').AsString = 'N',350,700);
    shpDivisore5.Enabled:=(FieldByName('DESC_LUNGA_5').AsString = 'N') and (Sender.Height >= 85);
    dlblDato6Valutato.Enabled:=shpDivisore5.Enabled;
  end;
  dlblDato5Valutato.Height:=dlblDato1Valutato.Height;
  Valore5:=S715FStampaValutazioniDtM.cdsStampaAnagrafico.FieldByName('DATO5_VALUTATO').AsString;
  while Pos(CRLF,Valore5) > 0 do
  begin
    dlblDato5Valutato.Height:=dlblDato5Valutato.Height + dlblDato1Valutato.Height - 2;
    Sender.Height:=Sender.Height + dlblDato1Valutato.Height - 2;
    Valore5:=Copy(Valore5,Pos(CRLF,Valore5) + 2);
  end;
  shpDivisore6.Top:=Sender.Height;
end;

procedure TS715FStampaValutazioni.bndRotturaChiaveAreeAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  inherited;
  //Riga di codice necessaria per non far ripetere (inspiegabilmente) il primo COD_AREA
  bndRotturaChiaveAree.Enabled:=False;
end;

procedure TS715FStampaValutazioni.bndElementiBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  bndElementi.Height:=svHElementi;
  inherited;
  //Riga di codice necessaria per non far ripetere (inspiegabilmente) il primo COD_AREA
  bndRotturaChiaveAree.Enabled:=True;
  //Gestione della lunghezza delle lineette verticali in base all'altezza della banda
  bndElementi.ExpandedHeight(H);
  lnDescItem.Height:=Round(H * H1);
  lnValutabile.Height:=lnDescItem.Height;
  lnPercValutazione.Height:=lnDescItem.Height;
  lnSogliaPunteggio.Height:=lnDescItem.Height;
  lnPunteggio.Height:=lnDescItem.Height;
  lnPunteggioPesato.Height:=lnDescItem.Height;
  lnCodItem.Height:=lnDescItem.Height;
  lnEndItem.Height:=lnDescItem.Height;
  lnBottomElementi.Top:=lnDescItem.Height - 1;
end;

procedure TS715FStampaValutazioni.bndValutazioneIntermediaBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  qlblTitoloValutazioneIntermedia.Caption:=S715FStampaValutazioniDtM.RecuperaEtichetta('VALUTAZIONE_INTERMEDIA_S','U');
  PrintBand:=Trim(S715FStampaValutazioniDtM.cdsStampaAnagrafico.FieldByName('VALUTAZIONE_INTERMEDIA').AsString) <> '';
end;

procedure TS715FStampaValutazioni.bndValutazioniComplessiveBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  qlblTitoloValutazioniComplessive.Caption:=S715FStampaValutazioniDtM.RecuperaEtichetta('VALUTAZIONI_COMPLESSIVE_S','U');
  PrintBand:=(Trim(S715FStampaValutazioniDtM.cdsStampaAnagrafico.FieldByName('VALUTAZIONI_COMPLESSIVE').AsString) <> '') and not Fase1StampaDirigenzaConObiettivi;
end;

procedure TS715FStampaValutazioni.bndObiettiviPianificatiBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  qlblTitoloObiettiviPianificati.Caption:=S715FStampaValutazioniDtM.RecuperaEtichetta('OBIETTIVI_PIANIFICATI_S','U');
  PrintBand:=Trim(S715FStampaValutazioniDtM.cdsStampaAnagrafico.FieldByName('OBIETTIVI_PIANIFICATI').AsString) <> '';
end;

procedure TS715FStampaValutazioni.bndProposteFormativeBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  qlblTitoloProposteFormative.Caption:=S715FStampaValutazioniDtM.RecuperaEtichetta('PROPOSTE_FORMATIVE_S','U');
  PrintBand:=Trim(S715FStampaValutazioniDtM.cdsStampaAnagrafico.FieldByName('PROPOSTE_FORMATIVE').AsString) <> '';
end;

procedure TS715FStampaValutazioni.bndCommentiValutatoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  qlblTitoloCommentiValutato.Caption:=S715FStampaValutazioniDtM.RecuperaEtichetta('COMMENTI_VALUTATO_S','U');
  PrintBand:=Trim(S715FStampaValutazioniDtM.cdsStampaAnagrafico.FieldByName('COMMENTI_VALUTATO').AsString) <> '';
end;

procedure TS715FStampaValutazioni.bndItemPersonalizzatoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  lblItemPersonalizzato.Caption:='(*) ' + S715FStampaValutazioniDtM.RecuperaEtichetta('ITEM_PERSONALIZZATO_S');
  PrintBand:=PresenzaItemPersonalizzati and (S715FStampaValutazioniDtM.RecuperaEtichetta('ITEM_PERSONALIZZATO_S') <> '');
end;

procedure TS715FStampaValutazioni.bndNoteBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  qlblTitoloNote.Caption:=S715FStampaValutazioniDtM.RecuperaEtichetta('NOTE_S','U');
  PrintBand:=Trim(S715FStampaValutazioniDtM.cdsStampaAnagrafico.FieldByName('NOTE').AsString) <> '';
end;

procedure TS715FStampaValutazioni.bndNoteIncentivoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  PrintBand:=Trim(S715FStampaValutazioniDtM.cdsStampaAnagrafico.FieldByName('NOTE_INCENTIVO').AsString) <> '';
end;

procedure TS715FStampaValutazioni.bndNotePunteggioBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  bndNotePunteggio.Height:=svHNotePunteggio;
  inherited;
  //Gestione della lunghezza delle lineette verticali in base all'altezza della banda
  bndNotePunteggio.ExpandedHeight(H);
  lnStartNotePunteggio.Height:=Round(H * H1);
  lnNotePunteggioSx.Height:=lnStartNotePunteggio.Height;
  lnNotePunteggioDx.Height:=lnStartNotePunteggio.Height;
  lnEndNotePunteggio.Height:=lnStartNotePunteggio.Height;
  lnBottomNotePunteggio.Top:=lnStartNotePunteggio.Height - 2;

  qlblTitoloNotePunteggio.Caption:=S715FStampaValutazioniDtM.RecuperaEtichetta('NOTE_PUNTEGGIO_S','U') + ': ';
  PrintBand:=Trim(S715FStampaValutazioniDtM.cdsStampaElementi.FieldByName('NOTE_PUNTEGGIO').AsString) <> '';
end;

procedure TS715FStampaValutazioni.bndPunteggioFinalePesatoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  qlblTitoloPunteggioFinalePesato2.Caption:=S715FStampaValutazioniDtM.RecuperaEtichetta('PUNTEGGIO_FINALE_SCHEDA_S','U') + ': ';
  PrintBand:=Fase2StampaDirigenzaConObiettivi;
end;

procedure TS715FStampaValutazioni.bndAccettazioneValutatoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  with S715FStampaValutazioniDtM do
  begin
    PrintBand:=(cdsStampaAnagrafico.FieldByName('TIPO_VALUTAZIONE').AsString = 'V') and (selSG741.FieldByName('ABILITA_ACCETTAZIONE_VALUTATO').AsString = 'S') and not Fase1StampaDirigenzaConObiettivi;
    qlblAccettazioneValutato.Caption:='Accettazione da parte del ' + RecuperaEtichetta('VALUTATO_S','L') + ':';
    qlblAccettazioneValutatoSiNo.Caption:=IfThen(cdsStampaAnagrafico.FieldByName('ACCETTAZIONE_VALUTATO').AsString = 'N','NO','SI');
  end;
end;

procedure TS715FStampaValutazioni.bndFirmeBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var NVariazioni:Integer;
    Firma4:Boolean;
begin
  inherited;
  //Controllo se ci sono state nell'anno variazioni che implicano il secondo valutatore
  NVariazioni:=0;
  with S715FStampaValutazioniDtM do
  begin
    if selSG741.FieldByName('DATO_VARIAZIONE_VALUTATORE').AsString <> '' then
    begin
      R180SetVariable(selT430a,'PROGRESSIVO',cdsStampaAnagrafico.FieldByName('PROG_VALUTATO').AsInteger);
      R180SetVariable(selT430a,'DATARIF',cdsStampaAnagrafico.FieldByName('DAL').AsDateTime);
      R180SetVariable(selT430a,'DATAINI',cdsStampaAnagrafico.FieldByName('AL').AsDateTime);
      R180SetVariable(selT430a,'DATO',IfThen(Copy(selSG741.FieldByName('DATO_VARIAZIONE_VALUTATORE').AsString,1,4) = 'T430',Copy(selSG741.FieldByName('DATO_VARIAZIONE_VALUTATORE').AsString,5),selSG741.FieldByName('DATO_VARIAZIONE_VALUTATORE').AsString));
      selT430a.Open;
      NVariazioni:=selT430a.FieldByName('N_VARIAZIONI').AsInteger;
    end;
    //Impostazione delle firme
    Sender.Height:=0;
    if (cdsStampaAnagrafico.FieldByName('FIRMA_1').AsString <> '')
    or (cdsStampaAnagrafico.FieldByName('FIRMA_2').AsString <> '')
    or (cdsStampaAnagrafico.FieldByName('FIRMA_3').AsString <> '') then
      Sender.Height:=41;
    Firma4:=(NVariazioni > 0) or ((selSG741.FieldByName('DATO_VARIAZIONE_VALUTATORE').AsString = '') and (cdsStampaAnagrafico.FieldByName('FIRMA_4').AsString <> ''));
    if Firma4
    or (cdsStampaAnagrafico.FieldByName('FIRMA_5').AsString <> '')
    or (cdsStampaAnagrafico.FieldByName('FIRMA_6').AsString <> '') then
      Sender.Height:=95;
    qlblFirma1.Enabled:=cdsStampaAnagrafico.FieldByName('FIRMA_1').AsString <> '';
    shpFirma1.Enabled:=cdsStampaAnagrafico.FieldByName('FIRMA_1').AsString <> '';
    qlblFirma2.Enabled:=cdsStampaAnagrafico.FieldByName('FIRMA_2').AsString <> '';
    shpFirma2.Enabled:=cdsStampaAnagrafico.FieldByName('FIRMA_2').AsString <> '';
    qlblFirma3.Enabled:=cdsStampaAnagrafico.FieldByName('FIRMA_3').AsString <> '';
    shpFirma3.Enabled:=cdsStampaAnagrafico.FieldByName('FIRMA_3').AsString <> '';
    qlblFirma4.Enabled:=Firma4;
    shpFirma4.Enabled:=Firma4;
    qlblFirma5.Enabled:=cdsStampaAnagrafico.FieldByName('FIRMA_5').AsString <> '';
    shpFirma5.Enabled:=cdsStampaAnagrafico.FieldByName('FIRMA_5').AsString <> '';
    qlblFirma6.Enabled:=cdsStampaAnagrafico.FieldByName('FIRMA_6').AsString <> '';
    shpFirma6.Enabled:=cdsStampaAnagrafico.FieldByName('FIRMA_6').AsString <> '';
  end;
end;

procedure TS715FStampaValutazioni.bndPunteggiBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  PrintBand:=S715FDialogStampa.chkLegendaPunteggi.Checked;
end;

procedure TS715FStampaValutazioni.bndPresaVisioneBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  PrintBand:=Trim(S715FStampaValutazioniDtM.cdsStampaAnagrafico.FieldByName('PRESA_VISIONE').AsString) <> '';
end;

end.
