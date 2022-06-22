unit C001StampaLib;

interface

uses Windows,CLasses,SysUtils, db, graphics, Printers,QuickRpt, QRPrntr, IniFiles, Variants,
     C180FunzioniGenerali,Dialogs;

const MaxNum = 800;
      MAXBANDEGROUP = 10;
      //DefWidth = 8;
      //DefHeight = 16;
      aTop = 0;
      aLeft = 1;
      aRight = 2;
      aBottom =3;
      aTopLine =4;
      aBaseLine =5;
      aLeftSide = 6;
      aRightSide =7;
      DefLeft = 7;
      DefTop = 10;
      DefHeightFooter = 10;
      ProporzioneBandExpanded = 0.37788385044;

type

  ReportTipo = (Elenco , Scheda , Gruppo);

  BandaTipo = (bNone, bDettaglio , bIntestazione , bGruppo);
               // bDettaglio->Banda di tipo dettaglio
               // bIntestazione->Banda di tipo ColumnHeader
               // bGruppo1..10 -> bande di tipo Group Header che verranno poi
               // annidate.

  OggettoTipo = ( QRIntestazione , QRCampo ); // QRIntestazione->QRLabel
                                              // QRCampo->QRDBText

  Rec_Stampa = record                  // definizione record contenete le caratteristiche
                 NomeOggetto:string;   // dei componenti da utilizzare nel report.
                 Tipo:OggettoTipo;
                 Caption:string;
                 DSource:TDataSource;
                 DField:string;
                 Banda:BandaTipo;
                 Height:integer;
                 Width:integer;
                 Left:integer;
                 Top:integer;
                 Font:TFont;
                 Color:TColor;
                 Trasp:boolean;
                 NumeroBandaGruppo:Integer;
                 Gruppo:Boolean;
                 SelGruppo:Boolean;
                 ElencoX:integer; // ultimo valore del Left dell'0ggetto in modalità elenco
                 ElencoY:integer; // ultimo valore del Top dell'0ggetto in modalità elenco
                 SchedaX:integer; // ultimo valore del Left dell'0ggetto in modalità scheda
                 SchedaY:integer; // ultimo valore del Top dell'0ggetto in modalità scheda
                 GruppoX:integer; // ultimo valore del Left dell'0ggetto in modalità gruppo
                 GruppoY:integer; // ultimo valore del Top dell'0ggetto in modalità gruppo
                 ElencoBanda,SchedaBanda,GruppoBanda:BandaTipo;
               end;

  TRec_Linea = record
     Altezza,Larghezza:Integer;
     Allineamento:Integer;
     Tratteggio:Integer;
     Enabled:Boolean;
  end;

  TRec_Campi = class                  // definizione record contenete le caratteristiche
      Nome:String;
      Intestazione:String;
      OldIntestazione:String;
      Da:String;
      OldDa:String;
      A:String;
      OldA:String;
      Selezionato:Boolean;
      OldSelezionato:Boolean;
      Ordinato:Boolean;
      OldOrdinato:Boolean;
      Ascendente:Boolean;
      OldAscendente:Boolean;
      Posizione:Integer;  // numero d' ordine del campo tra quelli scelti.
      OldPosizione:Integer;  // numero d' ordine del campo tra quelli scelti.
      CampoAnagrafico:Boolean;
      Gruppo:Boolean;
      OldGruppo:Boolean;
      SelGruppo:Boolean; //
      NumBanda:Integer; //
      Posi:Integer;
  end;

  ArrayStampa = array[1..MaxNum] of Rec_Stampa;


var VettStampa:ArrayStampa;
    ListaCampi:TList;
    RecCampi:TRec_Campi;
    //Modalità di stampa report (Elenco , Scheda , Gruppo)
    Modalita:ReportTipo;
    OrderLength:integer;
    ConfigAttiva:String = ('');
    TitoloStampa:String;
    NCAMPI:Integer = (0);  // numero campi selezionati
    NOGGETTI:Integer = (0); // numero oggetti creati
    StampaAnagrafico:Boolean = (False);
    StampaAnagraficoMisto:Boolean = (False);
    TipoGruppo:Integer;
    InterLineaAbilitata:Boolean;
    AltezzaInterLinea:Integer;
    LineaSup,LineaInf,LineaRec:TRec_Linea;
    PagineSeparate:Boolean;
    RiassegnaBandeGruppo:Boolean;
    FontGruppo:array[1..10] of TFont;
    OldFontGruppo:array[1..10] of TFont;
    UserBinCode,UserCollateCode:Integer;

procedure C001SettaQuickReport(QuickRep:TQuickRep);
procedure C001SettaCompositeReport(QuickRep:TQRCompositeReport);
procedure GetBinCollateCode;
procedure CreaListaCampi;
procedure PulisciListaCampi;
procedure DistruggiListaCampi;
procedure InizializzaLineeDiTratteggio;
function StampaGruppo:Boolean;

implementation

procedure CreaListaCampi;
begin
  ListaCampi:=TList.Create;
end;

procedure PulisciListaCampi;
var I:Integer;
begin
  for I:=ListaCampi.Count-1 downto 0 do
     begin
       RecCampi:=ListaCampi[I];
       RecCampi.Free;
       ListaCampi.Delete(I);
     end;
end;

procedure DistruggiListaCampi;
var I:Integer;
begin
  try
    for I:=ListaCampi.Count-1 downto 0 do
       begin
         RecCampi:=ListaCampi[I];
         RecCampi.Free;
         ListaCampi.Delete(I);
       end;
  except
  end;
  ListaCampi.Free;
end;

procedure C001SettaCompositeReport(QuickRep:TQRCompositeReport);
{Assegna le impostazioni della stampante alla stampante di TQRCompositeReport (ver. 2.0i)}
var
  ADevice,ADriver,APort:array [0..255] of Char;
  DevMode:PDeviceMode;
  DeviceHandle: THandle;
begin
  try
    QuickRep.PrinterSettings.PrinterIndex:=Printer.PrinterIndex;
    //Leggo le impostazioni per assegnarle al QuickReport
    Printer.GetPrinter(ADevice,ADriver,APort,DeviceHandle);
    if DeviceHandle = 0 then
    begin
      Printer.PrinterIndex:=Printer.PrinterIndex;
      Printer.GetPrinter(ADevice,ADriver,APort,DeviceHandle);
    end;
    if DeviceHandle = 0 then
      exit
    else
      DevMode:=GlobalLock(DeviceHandle);
    //Imposto la stampante selezionata
    //QuickRep.PrinterSettings.PrinterIndex:=Printer.PrinterIndex;
    //Imposto la pagina selezionata
    if DevMode^.dmPaperSize < 27 then
      QuickRep.PrinterSettings.PaperSize:=TQRPaperSize(DevMode^.dmPaperSize)
    else
      QuickRep.PrinterSettings.PaperSize:=Custom;
    GlobalUnlock(DeviceHandle);
  except
  end;
end;

procedure C001SettaQuickReport(QuickRep:TQuickRep);
{Assegna le impostazioni della stampante alla stampante di QuickReport (ver. 2.0i)}
var ADevice,ADriver,APort:array [0..255] of Char;
    DevMode:PDeviceMode;
    DeviceHandle: THandle;
begin
  try
    QuickRep.PrinterSettings.PrinterIndex:=Printer.PrinterIndex;
    //Leggo le impostazioni per assegnarle al QuickReport
    Printer.GetPrinter(ADevice,ADriver,APort,DeviceHandle);
    if DeviceHandle = 0 then
    begin
      Printer.PrinterIndex:=Printer.PrinterIndex;
      Printer.GetPrinter(ADevice,ADriver,APort,DeviceHandle);
    end;
    if DeviceHandle = 0 then
      exit
    else
      DevMode:=GlobalLock(DeviceHandle);
    //Imposto la stampante selezionata
    //QuickRep.PrinterSettings.PrinterIndex:=Printer.PrinterIndex;
    //Imposto la pagina selezionata
    if DevMode^.dmPaperSize < 27 then
      QuickRep.Page.PaperSize:=TQRPaperSize(DevMode^.dmPaperSize)
    else
      begin
      QuickRep.Page.Units:=MM;
      QuickRep.Page.PaperSize:=Custom;
      QuickRep.Page.Length:=DevMode^.dmPaperLength / 10;
      QuickRep.Page.Width:=DevMode^.dmPaperWidth / 10;
      end;
    GlobalUnlock(DeviceHandle);
    //Imposto l'orientamento selezionato
    QuickRep.Page.Orientation:=Printer.Orientation;
    QuickRep.PrinterSettings.PaperSize:=QuickRep.Page.PaperSize;
    QuickRep.PrinterSettings.Orientation:=QuickRep.Page.Orientation;
    //GetBinCollateCode;
    // Probabilmente è già stato impostato, ma per sicurezza lo settiamo di nuovo
    QuickRep.useQR5Justification:=True;
  except
  end;
end;

procedure GetBinCollateCode;
var
     hDevMode: THandle;
     Device,Driver,Port: array [0..1024] of Char;
     DevMode : PDevMode;
begin
  Printer.GetPrinter (Device,Driver,Port,hDevMode);
  UserBinCode:=-1;
  if hDevMode <> 0 then
  begin
        DevMode:=GlobalLock (hDevMode);
        // here we can catch members of DevMode
        UserBinCode:=DevMode^.DMDEFAULTSOURCE;
        UserCollateCode:=DevMode^.dmCollate;
        GlobalUnlock (hDevMode);
  end;
end;

procedure InizializzaLineeDiTratteggio;
begin
  if ConfigAttiva = '' then
    begin
      LineaRec.Altezza:=1;
      LineaRec.Larghezza:=718;  // larghezza delle bande
      LineaRec.Tratteggio:=0;
      LineaRec.Allineamento:=0;
      LineaRec.Enabled:=False;

      LineaSup.Altezza:=1;
      LineaSup.Larghezza:=718;  // larghezza delle bande
      LineaSup.Tratteggio:=0;
      LineaSup.Allineamento:=0;
      LineaSup.Enabled:=False;

      LineaInf.Altezza:=1;
      LineaInf.Larghezza:=718;  // larghezza delle bande
      LineaInf.Tratteggio:=0;
      LineaInf.Allineamento:=0;
      LineaInf.Enabled:=False;

      InterLineaAbilitata:=False;
      AltezzaInterLinea:=10;
    end;
end;

function StampaGruppo:Boolean;
var I:Integer;
begin
  Result:=False;
  for I:=0 to ListaCampi.Count-1 do
     begin
       if (TRec_Campi(ListaCampi[I]).Selezionato)and(TRec_Campi(ListaCampi[I]).Gruppo) then
         begin
           Result:=True;
           Break;
         end;
     end;
end;

end.
