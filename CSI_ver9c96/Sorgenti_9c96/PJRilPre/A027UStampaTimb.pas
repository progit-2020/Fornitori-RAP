unit A027UStampaTimb;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, (*Forms,*) (*Dialogs,*)
  ComCtrls, Variants, StdCtrls, ExtCtrls, DB, Math,
  quickrpt, Qrctrls, QRExport, QRPDFFilt, QRWebFilt, OracleData, Oracle,
  A000UInterfaccia, A000UCostanti, A000USessione, A027UCostanti, C180FunzioniGenerali, (*C700USelezioneAnagrafe,*)
  R400UCartellinoDtM, R600, StrUtils;

type
  TA027VisualizzaDipendente = procedure of object;

  TA027StampaTimb = class(TQuickRep)
    //QRep: TQuickRep;
    QRBDett: TQRBand;
    QRSDet1: TQRSubDetail;
    QRBInt3: TQRBand;
    TotaliDett: TQRBand;
    QRSDet: TQRSubDetail;
    QRShape2: TQRShape;
    Riepilogo: TQRChildBand;
    Riepilogo2: TQRChildBand;
    Riepilogo3: TQRChildBand;
    Intestazione: TQRChildBand;
    QRLMese: TQRLabel;
    QRLNow: TQRLabel;
    LAzienda: TQRLabel;
    RETimb: TRichEdit;
    RTTimb: TQRRichText;
    ShapeDett: TQRShape;
    Riepilogo4: TQRChildBand;
    QRMemo8: TQRMemo;
    QRMemo9: TQRMemo;
    QRMemo10: TQRMemo;
    QRMemo12: TQRMemo;
    QRMemo1: TQRMemo;
    QRMemo2: TQRMemo;
    QRMemo3: TQRMemo;
    QRMemo4: TQRMemo;
    QRMemo5: TQRMemo;
    QRMemo6: TQRMemo;
    QRMemo7: TQRMemo;
    QRMemo11: TQRMemo;
    QRLabel11: TQRLabel;
    QRLDebTot: TQRLabel;
    QRLrese: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLSaldoMese: TQRLabel;
    QRLSaldoAnno: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel22: TQRLabel;
    QRLIdnInt: TQRLabel;
    QRLEccComp: TQRLabel;
    QRLabel24: TQRLabel;
    QRLIdnRid: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel23: TQRLabel;
    QRLMat: TQRLabel;
    QRLturno: TQRLabel;
    QRLResidua: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel15: TQRLabel;
    QRLEccMese: TQRLabel;
    QRLEccAnno: TQRLabel;
    QRLStrAnno: TQRLabel;
    QRLResEcc: TQRLabel;
    QRLStrMese: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLSaldoAnnoCorr: TQRLabel;
    QRLabel4: TQRLabel;
    QRLSaldoAnnoPrec: TQRLabel;
    QRLabel8: TQRLabel;
    QRMemo13: TQRMemo;
    QMTimb: TQRMemo;
    TotSettimana: TQRChildBand;
    QRLabel1: TQRLabel;
    OreRese: TQRLabel;
    QRLabel7: TQRLabel;
    DebitoSet: TQRLabel;
    QRLabel10: TQRLabel;
    SaldoSet: TQRLabel;
    QRMemo14: TQRMemo;
    QRMemo15: TQRMemo;
    QRMemo16: TQRMemo;
    QRMemo17: TQRMemo;
    QRMemo18: TQRMemo;
    QRMemo19: TQRMemo;
    QRMemo20: TQRMemo;
    QRMemo21: TQRMemo;
    QRMemo22: TQRMemo;
    QRMemo23: TQRMemo;
    QRMemo24: TQRMemo;
    QRMemo25: TQRMemo;
    QRMemo26: TQRMemo;
    QRMemo27: TQRMemo;
    QRMemo28: TQRMemo;
    QRMemo29: TQRMemo;
    QRMemo30: TQRMemo;
    QRMemo31: TQRMemo;
    QRMemo32: TQRMemo;
    QRMemo33: TQRMemo;
    QRMemo34: TQRMemo;
    qlblNumPaginaMan: TQRLabel;
    qlblNumPaginaAuto: TQRSysData;
    qimgLogo: TQRImage;
    QRMemo35: TQRMemo;
    QRMemo36: TQRMemo;
    bndGruppoFileSeq: TQRGroup;
    QRLabel5: TQRLabel;
    lblStrappoPagina: TQRLabel;
    memoBanner: TQRMemo;
    QRSysData1: TQRSysData;
    QRPDFFilter1: TQRPDFFilter;
    QRTextFilter1: TQRTextFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    QRRTFFilter1: TQRRTFFilter;
    qrbIntestazionePagina: TQRBand;
    qrbIntestazionePaginaChild: TQRChildBand;
    Riepilogo5: TQRChildBand;
    QRMemo37: TQRMemo;
    QRMemo38: TQRMemo;
    QRMemo39: TQRMemo;
    QRMemo40: TQRMemo;
    procedure QRSDetBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRepAfterPreview(Sender: TObject);
    procedure QRSDet1NeedData(Sender: TObject; var MoreData: Boolean);
    procedure QRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure QRSDetNeedData(Sender: TObject; var MoreData: Boolean);
    procedure QRBDettBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure RiepilogoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Riepilogo2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Riepilogo3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSDet1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure TotaliDettBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure TotSettimanaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRepStartPage(Sender: TCustomQuickRep);
    procedure QRepAfterPrint(Sender: TObject);
    procedure QRLMesePrint(sender: TObject; var Value: String);
    procedure bndGruppoFileSeqBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepEndPage(Sender: TCustomQuickRep);
    procedure Riepilogo5BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Riepilogo4BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRSDetAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
  private
    { Private declarations }
    (*Cur,*)DaGG,AGG:integer;
    MCorr,MStampa,AStampa,ACorr:word;
    ThousandSepOri: Char;
    ParCartellinoOld:String;
    //IsPaginaParita: Boolean;  // (non utilizzata al momento) indica se la pagina in stampa è quella di parità
    function GetHeight(X:TQRLabel):Integer;
    procedure SetTimbrature(S:String);
    procedure StampaDettaglio(Da,A:integer);
    procedure GetFont(Lista:TStringList; Sender:String; Banda:TQRCustomBand);
    procedure GetLabels(Lista:TStringList; Sender:String; Banda:TQRCustomBand);
    //function GetPosDett(X:Integer):Integer;
    procedure LeggiParametrizzazione(Cod:String);
    procedure ImpostaStampa;
    procedure QRIntestazioneOnPrint(Sender: TObject; var Value: String);
    procedure AbilitazioniExportFilter;
  public
    { Public declarations }
    ListaFasce,ListaShape:TList;
    Anno1,Anno2,Mese1,Mese2,Giorno1,Giorno2:Word;
    HAssenze,HPresenze:Word;
    PrimoPassaggio:Boolean;
    DatiIntestazione,CampiBase,AggSchedaRiep,ParCartellinoFisso:String;
    NumPaginaChecked,IgnoraAnomalieStampa,ParametrizzazioniTipoCar,IntestazioneRipetuta:Boolean;
    Cur,NumPaginaManuale,NumPaginaValue:Integer;
    R400FCartellinoDtM:TR400FCartellinoDtM;
    A027VisualizzaDipendente:TA027VisualizzaDipendente;
    procedure DistruggiIntestazione;
    procedure DistruggiRiepilogo;
    procedure DistruggiListe;
    procedure AllineaRiepilogo4;
    procedure GestHeightQRBInt3;
    procedure GestSeparaDati;
    procedure LeggiIntestazione;
    constructor Create(AOwner: TComponent); override;
  end;

//var A027StampaTimb: TA027StampaTimb;

implementation

uses A027UcarMen;

{$R *.DFM}

constructor TA027StampaTimb.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Self.useQR5Justification:=True;
end;

procedure TA027StampaTimb.LeggiIntestazione;
{Leggo i dati parametrizzati creando i controlli QuickReport appropriati
col font richiesto}
var ListaSettaggi:TStringlist;
begin
  DistruggiRiepilogo;
  DistruggiIntestazione;
  //DistruggiListe;
  RTTimb.Enabled:=False;
  QMTimb.Enabled:=False;
  TotaliDett.Enabled:=False;
  Riepilogo2.Enabled:=False;
  Riepilogo3.Enabled:=False;
  Riepilogo4.Enabled:=False;
  // daniloc.ini - gestione pagina di parità
  Riepilogo5.Enabled:=(A027FCarMen.chkPaginaParita.Checked);
  //IsPaginaParita:=False;
  // daniloc.fine
  ListaSettaggi:=TStringList.Create;
  ListaFasce.Clear;
  with R400FCartellinoDtM do
    try
      SetLength(VetDatiLiberiSQL,0);
      ShapeDett.Enabled:=Q950Int.FieldByName('SeparaRighe').AsString = 'S';
      ListaSettaggi.Clear;
      selT951.Close;
      selT951.SetVariable('Codice',Q950Int.FieldByName('CODICE').AsString);
      selT951.Open;
      while not selT951.Eof do
      begin
        ListaSettaggi.Add(Trim(selT951.FieldByName('RIGA').AsString));
        selT951.Next;
      end;
      selT951.Close;
      //configurazione Intestazione
      GetFont(ListaSettaggi,'Intestazione',Intestazione);
      GetLabels(ListaSettaggi,'Intestazione',Intestazione);
      //configurazione Dettaglio
      GetFont(ListaSettaggi,'Dettaglio',QRBInt3);
      QRSDet1.Font.Assign(QRBInt3.Font);
      RETimb.Lines.Clear;
      QMTimb.Lines.Clear;
      //A027StampaTimb.RTTimb.Lines.Clear;
      TotSettimana.Font.Assign(QRBInt3.Font);
      TotaliDett.Font.Assign(QRBInt3.Font);
      GetLabels(ListaSettaggi,'Dettaglio',QRBInt3);
      //configurazione Riepilogo
      GetFont(ListaSettaggi,'Riepilogo',Riepilogo);
      Riepilogo2.Font.Assign(Riepilogo.Font);
      Riepilogo3.Font.Assign(Riepilogo.Font);
      Riepilogo4.Font.Assign(Riepilogo.Font);
      CalcoloCompetenze:=False;
      GetLabels(ListaSettaggi,'Riepilogo',Riepilogo);
      Riepilogo2.Height:=HAssenze + 1;
      Riepilogo3.Height:=HPresenze + 1;
      AllineaRiepilogo4;
    finally
      ListaSettaggi.Free;
    end;
end;

procedure TA027StampaTimb.GetFont(Lista:TStringList; Sender:String; Banda:TQRCustomBand);
var i:Integer;
    S,App,Suff:String;
begin
  if Sender = 'Intestazione' then
    Suff:=''
  else
    Suff:=Sender;
  //Impostazioni del Font
  i:=Lista.IndexOf(Format('[FONT%s]',[Suff]));
  if i = -1 then
    begin
    //ShowMessage(Sender + ':Il font non è leggibile.');
    exit;
    end;
  S:=Lista[i + 1];
  //Leggo il colore del Font
  if not R180Getvalore(S,'[C]','[F]',App) then
    begin//ShowMessage(Sender + ':Il font non è completo (Colore)')
    end
  else
    Banda.Font.Color:=StrToInt(App);
  //Leggo il nome del Font
  if not R180Getvalore(S,'[F]','[S]',App) then
    begin//ShowMessage(Sender + ':Il font non è completo (Nome)')
    end
  else
    Banda.Font.Name:=App;
  //Leggo il Size del Font
  if not R180Getvalore(S,'[S]','[ST]',App) then
    begin//ShowMessage(Sender + ':Il font non è completo (Dimensione)')
    end
  else
    Banda.Font.Size:=StrToInt(App);
  //Leggo lo Style del Font
  if not R180Getvalore(S,'[ST]','',App) then
    begin//ShowMessage(Sender + ':Il font non è completo (Stile)')
    end
  else
    Banda.Font.Style:=R180GetFontStyle(App);
end;
//*************************************************\\
//--------- CREAZIONE DATI PARAMETRICI ------------\\
//*************************************************\\
procedure TA027StampaTimb.GetLabels(Lista:TStringList; Sender:String; Banda:TQRCustomBand);
var i,j,i2,MaxTop,MaxTop2,LunCapt:Integer;
    S,Nome,Capt,X,Y,H,W,Suff,Posiz:String;
    //Creo Label di intestazione + DBLabel collegata al dato anagrafico (per intestazione)
    procedure CreaLab_DBLab;(*1*)
    begin
    if Trim(Capt) <> '' then
      //Creo la caption se è specificata
      with TQRLabel(Banda.AddPrintable(TQrLabel)) do
      begin
        AutoSize:=True;
        Caption:=Capt;
        LunCapt:=Width;
        AutoSize:=False;
        Top:=StrToInt(Y);
        Left:=StrToInt(X);
        Height:=StrToInt(H);
        if (Top + Height) > MaxTop then
          MaxTop:=(Top + Height);
        Tag:=StrToInt(Posiz);
      end;
    //Creo il DbText collegato a C700SelAnagrafe
    with TQRDbText(Banda.AddPrintable(TQrDbText)) do
    begin
      AutoSize:=False;
      Top:=StrToInt(Y);
      Left:=StrToInt(X) + LunCapt;
      Height:=StrToInt(H);
      Width:=StrToInt(W) - LunCapt;
      DataSet:=Self.DataSet;//C700SelAnagrafe;
      DataField:=Nome;
      if (Top + Height) > MaxTop then
        MaxTop:=(Top + Height);
      OnPrint:=QRIntestazioneOnPrint;
    end;
    if Pos(Nome,CampiBase) = 0 then
      DatiIntestazione:=DatiIntestazione + ',' + Nome;
    end;//Fine CreaLab_DBLab
    //**********************
    //Creo i dati di dettaglio
    procedure CreaLab_Dett;(*2*)
    var QRLbl:TQRLabel;
    begin
    if Trim(Capt) <> '' then
      //Creo la label di intestazione in QRBInt3
      begin
      QRLbl:=TQRLabel(Banda.AddPrintable(TQrLabel));
        with QRLbl do
          begin
          AutoSize:=False;
          Top:=StrToInt(Y);
          Left:=StrToInt(X);
          Height:=StrToInt(H);
          Width:=StrToInt(W);
          Caption:=Capt;
          Hint:=Capt;  //Memorizzo la caption per i dati con fasce (Eccedenze)
          Tag:=StrToInt(Posiz);
          Alignment:=DatiDett[A027GetPosDett(Tag)].A;
          if DatiDett[A027GetPosDett(Tag)].F then
            begin
            ListaFasce.Add(QRLbl);
            Height:=Height * 2;
            end;
          if (Top + Height) > MaxTop then
            MaxTop:=(Top + Height);
          end;
      end;
    //Creo la label contenente il valore
    with TQRLabel(QRSDet1.AddPrintable(TQrLabel)) do
      begin
      AutoSize:=False;
      Top:=StrToInt(Y);
      Left:=StrToInt(X);
      Height:=StrToInt(H);
      Width:=StrToInt(W);
      Tag:=StrToInt(Posiz);
      WordWrap:=DatiDett[A027GetPosDett(Tag)].WW;
      Alignment:=DatiDett[A027GetPosDett(Tag)].A;
      AutoStretch:=Tag = C_LPR;
      Hint:=H;
      Caption:='';
      if (Top + Height) > MaxTop2 then
        MaxTop2:=Top + Height;
      //Se campo con TOTALI abilito la banda e creo la label
      if Tag in C_TOTALI_SI then
        begin
        TotaliDett.Enabled:=True;
        with TQRLabel(TotaliDett.AddPrintable(TQrLabel)) do
          begin
          AutoSize:=False;
          Top:=StrToInt(Y) + 2;
          Left:=StrToInt(X);
          Height:=StrToInt(H);
          Width:=StrToInt(W);
          Tag:=StrToInt(Posiz);
          Alignment:=DatiDett[A027GetPosDett(Tag)].A;
          Caption:='';
          end;
        end;
      end;
    end;//Fine CreaLab_Dett
    //**********************
    //Gestione timbrature
    procedure CreaLab_Timb;(*3*)
    begin
    if Trim(Capt) <> '' then
      //Creo la label di intestazione in QRBInt3
      with TQRLabel(Banda.AddPrintable(TQrLabel)) do
        begin
        AutoSize:=False;
        Top:=StrToInt(Y);
        Left:=StrToInt(X);
        Height:=StrToInt(H);
        Width:=StrToInt(W);
        Caption:=Capt;
        Hint:=Capt;  //Memorizzo la caption per i dati con fasce (Eccedenze)
        Tag:=StrToInt(Posiz);
        Alignment:=DatiDett[A027GetPosDett(Tag)].A;
        if (Top + Height) > MaxTop then
          MaxTop:=(Top + Height);
        end;
    //Imposto il RichText
    with RTTimb do
      begin
      Enabled:=True;
      Top:=StrToInt(Y);
      Left:=StrToInt(X);
      Height:=StrToInt(H);
      Width:=StrToInt(W);
      Tag:=StrToInt(Posiz);
      Alignment:=DatiDett[A027GetPosDett(Tag)].A;
      Hint:=H;
      QMTimb.Enabled:=True;
      QMTimb.Top:=StrToInt(Y);
      QMTimb.Left:=StrToInt(X);
      QMTimb.Height:=StrToInt(H);
      QMTimb.Width:=StrToInt(W);
      QMTimb.Tag:=StrToInt(Posiz);
      QMTimb.Alignment:=DatiDett[A027GetPosDett(Tag)].A;
      QMTimb.Hint:=H;
      case Tag of
        C_TI1:R400FCartellinoDtM.LungTimb:=6;
        C_TI2:R400FCartellinoDtM.LungTimb:=7;
        C_TI3:R400FCartellinoDtM.LungTimb:=8;
        C_TI4:R400FCartellinoDtM.LungTimb:=12;
        C_TI5:R400FCartellinoDtM.LungTimb:=9;
        C_TI6:R400FCartellinoDtM.LungTimb:=10;
        C_TI7:R400FCartellinoDtM.LungTimb:=11;
        C_TI8:R400FCartellinoDtM.LungTimb:=15;
      end;
      if Trim(R400FCartellinoDtM.Q950Int.FieldByName('Anomalia').AsString) <> '' then
        inc(R400FCartellinoDtM.LungTimb,1);
      if (Top + Height) > MaxTop2 then
        MaxTop2:=Top + Height;
      end;
    end;//Fine CreaLab_Timb
    //*********************
    //Creo 2 Label su riepilogo - per dato libero 2 (2000) creo solo la caption
    procedure CreaLab_Riep;(*7*)
    begin
    if (Trim(Capt) <> '') and (StrToInt(Posiz) <> 2001) then
      //Creo la caption se è specificata
      with TQRLabel(Banda.AddPrintable(TQrLabel)) do
        begin
        AutoSize:=True;
        Caption:=Capt;
        LunCapt:=Self.TextWidth(Riepilogo.Font,Caption);
        AutoSize:=False;
        Top:=StrToInt(Y);
        Left:=StrToInt(X);
        Height:=StrToInt(H);
        if (Top + Height) > MaxTop then
          MaxTop:=(Top + Height);
        Tag:=0;
        end;
    //Creo la label contenente il valore
    if StrToInt(Posiz) <> 2000 then
      begin
      with TQRLabel(Banda.AddPrintable(TQrLabel)) do
        begin
        AutoSize:=False;
        Top:=StrToInt(Y);
        Left:=StrToInt(X) + LunCapt;
        Height:=StrToInt(H);
        if StrToInt(W) >= LunCapt then
          Width:=StrToInt(W) - LunCapt
        else
          Width:=0;
        if (StrToInt(Posiz) = 21) or (StrToInt(Posiz) = 23) then
          Alignment:=taLeftJustify
        else
          Alignment:=taRightJustify;
        Tag:=StrToInt(Posiz);
        if StrToInt(Posiz) = 2001 then
          Tag:=R400FCartellinoDtM.GetTagDatoLiberoSQL('RIEP',Capt);
        if (Top + Height) > MaxTop then
          MaxTop:=(Top + Height);
        end;
      end;
    end;//Fine CreaLab_Riep
    //*********************
    //Creazione label su Riepilogo4 (Dato libero descrittivo)
    procedure CreaLabel;(*8*)
    begin
      with TQRLabel(Banda.AddPrintable(TQrLabel)) do
        begin
        Banda.Enabled:=True;
        AutoSize:=True;
        Hint:=Capt;
        Top:=StrToInt(Y);
        Left:=StrToInt(X);
        if Copy(Capt.ToUpper,1,7) <> 'SELECT ' then
          Tag:=StrToInt(Posiz)
        else
          Tag:=R400FCartellinoDtM.GetTagDatoLiberoSQL('FOOTER',Capt);
        if (Top + Height + 4) > Banda.Height then
          Banda.Height:=Top + Height + 4;
        Caption:=Capt;
        end;
    end;//Fine CreaLabel
    //******************
    //Impostazione QRMemo su Riepilogo2 (Child) per riepilogo assenze
    procedure CreaLabelChild;(*9*)
    var NL:Integer;
    begin
      with Riepilogo2 do
        begin
        Enabled:=True;
        for NL:=0 to ControlCount - 1 do
          if Controls[NL].Tag = StrToInt(Posiz) then
            with TQRMemo(Controls[NL]) do
              begin
              //Devo calcolare le competenze assenze solo se sono inclusi
              //i campi che lo richiedono
              //if (Tag >= 903) and (Tag <= 907) then
              if R180In(Tag,[903,904,905,906,907,909,910,911,912,913,914,915,916,917]) then
                R400FCartellinoDtM.CalcoloCompetenze:=True;
              Enabled:=True;
              AutoSize:=False;
              Lines.Clear;
              Hint:=Capt;
              Top:=0;
              Left:=StrToInt(X);
              Width:=StrToInt(W);
              Height:=StrToInt(H);
              if HAssenze < Height then
                HAssenze:=Height;
              Break;
              end;
        end;
    end;//Fine CreaLabelChild
    //***********************
    //Impostazione QRMemo su Riepilogo3 (Child) per riepilogo presenze
    procedure CreaLabelChildPres;(*10*)
    var NL:Integer;
    begin
      with Riepilogo3 do
        begin
        Enabled:=True;
        for NL:=0 to ControlCount - 1 do
          if Controls[NL].Tag = StrToInt(Posiz) then
            with TQRMemo(Controls[NL]) do
              begin
              Enabled:=True;
              AutoSize:=False;
              Lines.Clear;
              Hint:=Capt;
              Top:=0;
              Left:=StrToInt(X);
              Width:=StrToInt(W);
              Height:=StrToInt(H);
              if HPresenze < Height then
                HPresenze:=Height + 1;
              Break;
              end;
        end;
    end;//Fine CreaLabelChildPres
    //***************************
begin
  if Sender = 'Intestazione' then
    begin
    Suff:='';
    DatiIntestazione:='';
    end
  else
    Suff:=Sender;
  //Impostazioni delle Labels
  MaxTop:=0;
  MaxTop2:=0;
  HAssenze:=0;
  HPresenze:=0;
  i:=Lista.IndexOf(Format('[LABELS%s]',[Suff]));
  if i = -1 then
    begin
    //ShowMessage(Sender + ':Le labels non sono leggibili.');
    Exit;
    end;
  //Cerco la fine delle impostazioni del gruppo (Intestazione/Dettaglio/Riepilogo)
  i2:=Lista.IndexOf('[FONTDettaglio]');
  if i2 < i then
    begin
    i2:=Lista.IndexOf('[FONTRiepilogo]');
    if i2 < i then
      i2:=Lista.Count;
    end;
  for j:=i + 1 to i2 - 1 do
    begin
    S:=Lista[j];
    //Leggo il Nome della labels
    if not R180Getvalore(S,'[N]','[C]',Nome) then
      begin
      //ShowMessage(Sender + ':La label non è completa (Nome)');
      Continue;
      end;
    if not R180Getvalore(S,'[C]','[T]',Capt) then
      begin
      //ShowMessage(Sender + ':La label non è completa (Caption)');
      Continue;
      end;
    if not R180Getvalore(S,'[T]','[L]',Y) then
      begin
      //ShowMessage(Sender + ':La label non è completa (Top)');
      Continue;
      end;
    if not R180Getvalore(S,'[L]','[H]',X) then
      begin
      //ShowMessage(Sender + ':La label non è completa (Left)');
      Continue;
      end;
    if not R180Getvalore(S,'[H]','[W]',H) then
      begin
      //ShowMessage(Sender + ':La label non è completa (Altezza)');
      Continue;
      end;
    if not R180Getvalore(S,'[W]','[G]',W) then
      begin
      //ShowMessage(Sender + ':La label non è completa (Larghezza)');
      Continue;
      end;
    if not R180Getvalore(S,'[G]','',Posiz) then
      Posiz:='0';
    LunCapt:=0;
    //Creazione labels per intestazione
    if Sender = 'Intestazione' then
      CreaLab_DBLab;
    //Creazione labels per dettaglio
    if Sender = 'Dettaglio' then
      case StrToInt(Posiz) of
        C_TI1..C_TI8:CreaLab_Timb;
      else
        CreaLab_Dett;
      end;
    //Creazione label per il riepilogo
    if Sender = 'Riepilogo' then
      case StrToInt(Posiz) of
        0..899,2000,2001://Dati riepilogativi + Dato libero 2 + Dato libero SQL
          begin
          Banda:=Riepilogo;
          CreaLab_Riep;
          end;
        901..949://Riepilogo assenze
          CreaLabelChild;
        951..999://Riepilogo presenze
          CreaLabelChildPres;
        1000://Dato libero
          begin
          Banda:=Riepilogo4;
          CreaLabel;
          end;
      end;
    end;
  if Sender = 'Intestazione' then
    Intestazione.Height:=MaxTop;
  if Sender = 'Dettaglio' then
    begin
    QRBInt3.Height:=MaxTop + 2;
    QRSDet1.Height:=MaxTop2 + 2;
    TotaliDett.Height:=MaxTop2 + 2;
    //Registro l'altezza della banda di dettaglio per gestire timbr. & giustif.
    QRSDet1.Tag:=QRSDet1.Height;
    QRShape2.Top:=QRBInt3.Height - 2;
    GestHeightQRBInt3;
    for j:=0 to ListaShape.Count - 1 do
      TQRShape(ListaShape[j]).Enabled:=False;
    if R400FCartellinoDtM.Q950Int.FieldByName('SeparaDati').AsString = 'S' then
      GestSeparaDati;
    end;
  if Sender = 'Riepilogo' then
    Riepilogo.Height:=MaxTop;
end;

procedure TA027StampaTimb.GestHeightQRBInt3;
var i:Integer;
begin
  for i:=0 to QRBInt3.ControlCount - 1 do
    if QRBInt3.Controls[i].Tag <> 0 then
      TQRLabel(QRBInt3.Controls[i]).Height:=QRBInt3.Height - 2;
end;

procedure TA027StampaTimb.GestSeparaDati;
var i,j:Integer;
begin
  j:=0;
  for i:=0 to QRSDet1.ControlCount - 1 do
    if QRSDet1.Controls[i].Tag > 0 then
    begin
      TQRShape(ListaShape[j]).Enabled:=True;
      TQRShape(ListaShape[j]).Left:=QRSDet1.Controls[i].Left + QRSDet1.Controls[i].Width + 1;
      TQRLabel(QRSDet1.Controls[i]).Transparent:=True;
      inc(j);
    end;
end;

procedure TA027StampaTimb.QRIntestazioneOnPrint(Sender: TObject; var Value: String);
begin
  try
    if (Sender is TQRDbText) and (A027FCarMen.DatiStorici.Active) then
      if A027FCarMen.DatiStorici.FindField(TQRDbText(Sender).DataField) <> nil then
        Value:=A027FCarMen.DatiStorici.FieldByName(TQRDbText(Sender).DataField).AsString;
  except
  end;
end;

procedure TA027StampaTimb.QRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  MCorr:=Mese1;
  ACorr:=Anno1;
  MStampa:=MCorr;
  AStampa:=ACorr;

  //salto pagina per dipendente
  QRSDet.ForceNewColumn:=True; //QR5 (Delphi XE4)
  {$IF CompilerVersion >= 31}
  QRSDet.ForceNewColumn:=False;//QR6 (Delphi 10.2)
  {$ENDIF}

  QrShape2.Width:=QRBInt3.Width;
  ShapeDett.Width:=QRSDet1.Width;
  RETimb.Lines.Clear;
  ParCartellinoOld:=ParCartellinoFisso;
  qrbIntestazionePagina.Enabled:=IntestazioneRipetuta;
  qrbIntestazionePaginaChild.Enabled:=IntestazioneRipetuta;
  if PrimoPassaggio then
    PrimoPassaggio:=False
  else
  begin
    R400FCartellinoDtM.AggiornamentoScheda:=False;
    Self.DataSet.First;
  end;
  if NumPaginaChecked then
    NumPaginaManuale:=NumPaginaValue
  else
    NumPaginaManuale:=1;
  ThousandSepOri:={$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator;
  AbilitazioniExportFilter;
end;

procedure TA027StampaTimb.AbilitazioniExportFilter;
begin
  if not Self.Exporting then
  begin
    RTTimb.Enabled:=RTTimb.Enabled and (not R400FCartellinoDtM.StampaFileTesto);
    QMTimb.Enabled:=QMTimb.Enabled and R400FCartellinoDtM.StampaFileTesto;
  end
  else
  begin
    if Self.ExportFilter is TQRXLSFilter then
      {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=#0;
    if (Self.ExportFilter is TQRRTFExportFilter) or
       (Self.ExportFilter is TQRAsciiExportFilter) or
       (Self.ExportFilter is TQRXLSFilter ) then
    begin
      RTTimb.Enabled:=False;
      QMTimb.Enabled:=True;
    end
    else
    begin
      RTTimb.Enabled:=False;
      QMTimb.Enabled:=True;
    end;
  end;
end;

procedure TA027StampaTimb.QRepStartPage(Sender: TCustomQuickRep);
var i:Integer;
    S:String;
begin
  inc(NumPaginaManuale);
  qlblNumPaginaMan.Caption:=IntToStr(NumPaginaManuale);

  // daniloc.ini - gestione pagina di parità
  //IsPaginaParita:=IsPaginaParita and (PageNumber mod 2 = 0);
  //qrbIntestazionePagina.Enabled:=IntestazioneRipetuta and (not IsPaginaParita);
  //qrbIntestazionePaginaChild.Enabled:=IntestazioneRipetuta and (not IsPaginaParita);
  // daniloc.fine

  if qrbIntestazionePagina.Enabled then
  begin
    qrbIntestazionePagina.Height:=QRSDet.Height;
    qrbIntestazionePaginaChild.Height:=Intestazione.Height;
    for i:=QRSDet.ControlCount - 1 downto 0 do
      QRSDet.Controls[i].Parent:=qrbIntestazionePagina;
    for i:=Intestazione.ControlCount - 1 downto 0 do
      Intestazione.Controls[i].Parent:=qrbIntestazionePaginaChild;
    QRSDet.Height:=0;
    Intestazione.Height:=0;
    //codice di QRSDetBeforePrint
    QRLNow.Caption:=FormatDateTime(R400FCartellinoDtM.Q950Int.FieldByName('DATA_STAMPA').AsString,Now);
    //S:=FormatDateTime('mmmm yyyy',EncodeDate(AStampa,MStampa,1));
    S:=UpperCase(R180NomeMese(MStampa)) + ' ' + IntToStr(AStampa);
    S:=S + AggSchedaRiep;
    QRLMese.Caption:='RILEVAZIONE DEL MESE DI ' + S;
  end;
end;

procedure TA027StampaTimb.QRBDettBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  MCorr:=Mese1;
  MStampa:=MCorr;
  ACorr:=Anno1;
  AStampa:=ACorr;
end;

procedure TA027StampaTimb.QRSDetNeedData(Sender: TObject;
  var MoreData: Boolean);
var i,xx,yy,w:Integer;
    QRLbl:TQRLabel;
    ParCartellino:String;
    ParametrizzazioneCambiata: Boolean;
begin
  ParametrizzazioneCambiata:=False;
  if ((ACorr < Anno2) and (MCorr <= 12)) or ((ACorr = Anno2) and (MCorr <= Mese2)) then
    with Self.DataSet do
    begin
      try
        repeat
          for xx:=1 to MaxRighe do for yy:=1 to MaxColonne do R400FCartellinoDtM.MatDettStampa[xx,yy]:='';
          for i:=1 to High(R400FCartellinoDtM.VetDomenica) do R400FCartellinoDtM.VetDomenica[i]:= -1;
          for xx:=Low(R400FCartellinoDtM.TotSett) to High(R400FCartellinoDtM.TotSett) do
          begin
            R400FCartellinoDtM.TotSett[xx].Debito:='';
            R400FCartellinoDtM.TotSett[xx].OreRese:='';
            R400FCartellinoDtM.TotSett[xx].Saldo:='';
          end;
          R400FCartellinoDtM.NumGiorniCartolina:=0;
          R400FCartellinoDtM.StrFasceStampa:='';
          //Se devo ciclare per più mesi allora calcolo il numero di
          //giorni di ciascun mese
          if (Mese1 <> Mese2) or (Anno1 <> Anno2) then
            Giorno2:=R180GiorniMese(EncodeDate(ACorr,MCorr,1));
          if @A027VisualizzaDipendente <> nil then
            A027VisualizzaDipendente;
          R400FCartellinoDtM.ParametrizzazioniTipoCar:=ParametrizzazioniTipoCar;
          if ParametrizzazioniTipoCar then
          begin
            R400FCartellinoDtM.CercaParametrizzazione(Self.DataSet.FieldByName('PROGRESSIVO').AsInteger,R180FineMese(EncodeDate(ACorr,MCorr,1)));
            ParCartellino:=R400FCartellinoDtM.ParStampaCartellino;
            if (ParCartellino = '') or not A000FiltroDizionario('PARAMETRIZZAZIONI CARTELLINO',ParCartellino) then
              ParCartellino:=ParCartellinoFisso;
            {Il problema sembra crearsi all'interno di questo blocco di codice o in conseguenza}
            if ParCartellino <> ParCartellinoOld then
            begin
              ParCartellinoOld:=ParCartellino;
              LeggiParametrizzazione(ParCartellino);
              ParametrizzazioneCambiata:=True;
            end;
          end;

          if ParametrizzazioneCambiata then
          begin
            ImpostaStampa;
            R400FCartellinoDtM.GetDatiLiberiSQL;
            AbilitazioniExportFilter;
            Self.PrepareComponents;  //Per refreshare i componenti dell'intestazione
          end;

          R400FCartellinoDtM.CartolinaDipendente(Self.DataSet.FieldByName('PROGRESSIVO').AsInteger,ACorr,MCorr,Giorno1,Giorno2);
          if (R400FCartellinoDtM.DipInser1 = 'no') or   //LORENA 28/07/2004
             (R400FCartellinoDtM.AnomaliaBloccante and (not IgnoraAnomalieStampa)) then
          begin
            inc(MCorr);
            if MCorr > 12 then
            begin
              inc(ACorr);
              MCorr:=1;
            end;
          end;
        until (R400FCartellinoDtM.DipInSer1 = 'si') or (ACorr > Anno2) or ((ACorr = Anno2) and (MCorr > Mese2));
//        if R400FCartellinoDtM.DipInSer1 = 'no' then  LORENA 28/07/2004
        if (R400FCartellinoDtM.DipInSer1 = 'no') or  //LORENA 28/07/2004
           (R400FCartellinoDtM.AnomaliaBloccante and (not IgnoraAnomalieStampa)) then
        begin
          // forza rilettura parametrizzazione alla prossima esecuzione - daniloc. 16.02.2011
          if ParametrizzazioneCambiata then
            ParCartellinoOld:='';
          // forza rilettura.fine
          MoreData:=False;
          exit;
        end;
        MStampa:=MCorr;
        AStampa:=ACorr;
        //Bruno 20/08/2009: Lettura dati anagrafici storici da stampare sull'intestazione (vedi evento QRIntestazioneOnPrint)
        if (Anno1 <> Anno2) or (Mese1 <> Mese2) then
        begin
          try
            A027FCarMen.DatiStorici.GetDatiStorici(Copy(DatiIntestazione,2,Length(DatiIntestazione)),Self.DataSet.FieldByName('PROGRESSIVO').AsInteger,EncodeDate(AStampa,MStampa,1),R180FineMese(EncodeDate(AStampa,MStampa,1)));
            A027FCarMen.DatiStorici.LocDatoStorico(R180FineMese(EncodeDate(AStampa, MStampa, 1)));
          except
            on E: Exception do
              RegistraMsg.InserisciMessaggio('A',Format('Param. stampa %s: errore in lettura dati intestazione (%s) [data di rif. %s]',
                                                 [IfThen(ParametrizzazioniTipoCar,R400FCartellinoDtM.ParStampaCartellino,A027FCarMen.NomeStampa.Text),
                                                  DatiIntestazione,
                                                  DateToStr(R180FineMese(EncodeDate(AStampa, MStampa, 1)))]),
                                                  Parametri.Azienda,Self.DataSet.FieldByName('PROGRESSIVO').AsInteger);
          end;
        end;
        if FALSE AND ParametrizzazioneCambiata then
        begin
          ImpostaStampa;
          R400FCartellinoDtM.GetDatiLiberiSQL;
          AbilitazioniExportFilter;
          Self.PrepareComponents;  //Per refreshare i componenti dell'intestazione
        end;
        //Scrivo sulla 2° riga la descrizione delle fasce
        for i:=0 to ListaFasce.Count - 1 do
        begin
          QRLbl:=TQRLabel(ListaFasce[i]);
          w:=QRLbl.Width;
          QRLbl.Caption:=QRLbl.Hint;
          while Self.TextWidth(QRLbl.Font,QRLbl.Caption) <= w do
            QRLbl.Caption:=QRLbl.Caption + ' ';
          QrLbl.Caption:=Copy(QRLbl.Caption,1,Length(QRLbl.Caption) - 1);
          QRLbl.Caption:=QRLbl.Caption + R400FCartellinoDtM.StrFasceStampa;
        end;
        StampaDettaglio(1,R400FCartellinoDtM.NumGiorniCartolina);
      except
        //Log
        on E: Exception do
          RegistraMsg.InserisciMessaggio('A',Format('Param. stampa %s: errore in fase di stampa [data di rif. %s]',
                                                 [IfThen(ParametrizzazioniTipoCar,R400FCartellinoDtM.ParStampaCartellino,A027FCarMen.NomeStampa.Text),
                                                  DateToStr(R180FineMese(EncodeDate(AStampa, MStampa, 1)))]),
                                                 Parametri.Azienda,Self.DataSet.FieldByName('PROGRESSIVO').AsInteger);
      end;
      inc(MCorr);
      if MCorr > 12 then
      begin
        inc(ACorr);
        MCorr:=1;
      end;
      MoreData:=True;
    end
  else
    MoreData:=False;
end;

procedure TA027StampaTimb.QuickRepEndPage(Sender: TCustomQuickRep);
var i:Integer;
begin
  if qrbIntestazionePagina.Enabled then
  begin
    QRSDet.Height:=qrbIntestazionePagina.Height;
    Intestazione.Height:=qrbIntestazionePaginaChild.Height;
    for i:=qrbIntestazionePagina.ControlCount - 1 downto 0 do
      qrbIntestazionePagina.Controls[i].Parent:=QRSDet;
    for i:=qrbIntestazionePaginaChild.ControlCount - 1 downto 0 do
      qrbIntestazionePaginaChild.Controls[i].Parent:=Intestazione;
  end;
end;

procedure TA027StampaTimb.LeggiParametrizzazione(Cod:String);
begin
  with R400FCartellinoDtM.Q950Int do
  begin
    Close;
    SetVariable('Codice',Cod);
    Open;
    (*if FieldByName('ORIENTAMENTO').AsString = 'V' then
      Page.Orientation:=poPortrait
    else if FieldByName('ORIENTAMENTO').AsString = 'O' then
      Page.Orientation:=poLandScape;*)
  end;
end;

procedure TA027StampaTimb.ImpostaStampa;
var I,LarghezzaIntestazione:Integer;
    OS8:TOracleSession;
    ODS:TOracleDataSet;
begin
  LeggiIntestazione;
  (*if DatiIntestazione <> '' then
    if Pos(DatiIntestazione,C700SelAnagrafe.SQL.Text) = 0 then
    begin
      S:=C700SelAnagrafe.SQL.Text;
      I:=Pos('FROM',S);
      if I > 0 then
        Insert(A027StampaTimb.DatiIntestazione + ' ',S,I);
      C700SelAnagrafe.Close;
      C700SelAnagrafe.SQL.Text:=S;
      C700SelAnagrafe.Open;
    end;*)
  //RTTimb.Enabled:=True;
  //QMTimb.Enabled:=False;
  LAzienda.AutoSize:=True;
  LAzienda.AutoStretch:=False;
  LAzienda.Caption:=Parametri.RagioneSociale;
  QRLMese.Top:=LAzienda.Top + LAzienda.Height + 1;
  LarghezzaIntestazione:=QRSDet.Width;
  try
    qimgLogo.Enabled:=(R400FCartellinoDtM.Q950Int.FieldByName('LOGO_LARGHEZZA').AsInteger > 0) and (R400FCartellinoDtM.selT004.FieldByName('NUM').AsInteger > 0);
    if (R400FCartellinoDtM.Q950Int.FieldByName('LOGO_LARGHEZZA').AsInteger > 0) and (R400FCartellinoDtM.selT004.FieldByName('NUM').AsInteger > 0) then
    begin
      dec(LarghezzaIntestazione,R400FCartellinoDtM.Q950Int.FieldByName('LOGO_LARGHEZZA').AsInteger * 2);
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
      qimgLogo.Height:=Trunc(qimgLogo.Height * (R400FCartellinoDtM.Q950Int.FieldByName('LOGO_LARGHEZZA').AsInteger / qimgLogo.Width));
      qimgLogo.Width:=R400FCartellinoDtM.Q950Int.FieldByName('LOGO_LARGHEZZA').AsInteger;
      TQRBand(qimgLogo.Parent).Height:=max(TQRBand(qimgLogo.Parent).Height,qimgLogo.Top + qimgLogo.Height);
    end;
  except
    qimgLogo.Enabled:=False;
  end;
  if LAzienda.Width > LarghezzaIntestazione then
  begin
    LAzienda.AutoSize:=False;
    LAzienda.AutoStretch:=True;
    LAzienda.Width:=LarghezzaIntestazione - 4;
    QRLMese.Top:=LAzienda.Top + (LAzienda.Height * 2) + 1;
  end;
  //Caricamento tag dei dati di dettaglio per formattazione dei dati nella R400
  R400FCartellinoDtM.lstDettaglio.Clear;
  for i:=0 to QRSDet1.ControlCount - 1 do
    R400FCartellinoDtM.lstDettaglio.Add(IntToStr(QRSDet1.Controls[i].Tag));
  //Caricamento tag dei dati di riepilogo per ottimizzazione delle query nella R400
  R400FCartellinoDtM.lstRiepilogo.Clear;
  for i:=0 to Riepilogo.ControlCount - 1 do
    R400FCartellinoDtM.lstRiepilogo.Add(IntToStr(Riepilogo.Controls[i].Tag));
  LAzienda.Enabled:=R400FCartellinoDtM.Q950Int.FieldByName('RAGIONE_SOCIALE').AsString = 'S';
  (*if R400FCartellinoDtM.Q950Int.FieldByName('MARGINE_SUP').IsNull then
  begin
    //Margine standard
    Page.Units:=MM;
    Page.TopMargin:=5;
  end
  else
  begin
    //Margine personalizzato (stampa Inail)
    Page.Units:=MM;
    Page.TopMargin:=R400FCartellinoDtM.Q950Int.FieldByName('MARGINE_SUP').AsInteger;
  end;*)
end;

procedure TA027StampaTimb.QRSDetBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var S:String;
begin
  QRLNow.Caption:=FormatDateTime(R400FCartellinoDtM.Q950Int.FieldByName('DATA_STAMPA').AsString,Now);
  //S:=FormatDateTime('mmmm yyyy',EncodeDate(AStampa,MStampa,1));
  S:=UpperCase(R180NomeMese(MStampa)) + ' ' + IntToStr(AStampa);
  S:=S + AggSchedaRiep;
  QRLMese.Caption:='RILEVAZIONE DEL MESE DI ' + S;
end;

procedure TA027StampaTimb.StampaDettaglio(Da,A:integer);
begin
  DaGG:=Da;
  AGG:=A;
  Cur:=DaGG;
end;

procedure TA027StampaTimb.QRSDet1NeedData(Sender: TObject;
  var MoreData: Boolean);
var i,T:integer;
function PutAnomalie(Anomalie:String):String;
  {Scrittura delle anomalie in RETimb}
  var Num:Integer;
  begin
    Result:='0';
    Num:=0;
    while Pos(#13,Anomalie) > 0 do
    begin
      inc(Num);
      RETimb.Lines.Add(Copy(Anomalie,1,Pos(#13,Anomalie) - 1));
      Anomalie:=Copy(Anomalie,Pos(#13,Anomalie) + 1,Length(Anomalie));
    end;
    if Anomalie <> '' then
    begin
      inc(Num);
      RETimb.Lines.Add(Anomalie);
    end;
    Result:=IntToStr(Num);
  end;
begin
  if Cur <= AGG then
  begin
    //Ripristino l'altezza originale della banda di dettaglio
    QRSDet1.Height:=QRSDet1.Tag;
    for i:=0 to QRSDet1.ControlCount - 1 do
    begin
      T:=QRSDet1.Controls[i].Tag;
      //Controlli QRLabel
      if QRSDet1.Controls[i] is TQRLabel then
        TQRLabel(QRSDet1.Controls[i]).Caption:=R400FCartellinoDtM.MatDettStampa[Cur,T];
      //RichEdit (Timbrature)
      if QRSDet1.Controls[i] is TQRRichText then
        if (QRSDet1.Controls[i] as TQRRichText).Enabled then
        begin
          SetTimbrature(R400FCartellinoDtM.MatDettStampa[Cur,T]);
          //Inserimento delle eventuali anomalie sul dato timbrature
          if Trim(R400FCartellinoDtM.MatDettStampa[Cur,C_ANM]) <> '' then
            RETimb.Hint:=PutAnomalie(R400FCartellinoDtM.MatDettStampa[Cur,C_ANM])
          else
            RETimb.Hint:='';
        end;
      if QRSDet1.Controls[i] is TQRMemo then
        if (QRSDet1.Controls[i] as TQRMemo).Enabled then
        begin
          SetTimbrature(R400FCartellinoDtM.MatDettStampa[Cur,T]);
          //Inserimento delle eventuali anomalie sul dato timbrature
          if Trim(R400FCartellinoDtM.MatDettStampa[Cur,C_ANM]) <> '' then
            RETimb.Hint:=PutAnomalie(R400FCartellinoDtM.MatDettStampa[Cur,C_ANM])
          else
            RETimb.Hint:='';
        end;
      //Dimensionamento timbrature di presenza
      if QRSDet1.Controls[i].Tag in [C_TI1..C_TI8] then
      begin
        RTTimb.Height:=StrToIntDef(RTTimb.Hint,1) * RETimb.Lines.Count;
        QMTimb.Lines.Assign(RETimb.Lines);
        QMTimb.Height:=RTTimb.Height;
        if (QRSDet1.Height + 1) <= RTTimb.Height then
          QRSDet1.Height:=RTTimb.Height + 2;
      end;
      //Dimensionamento giustificativi/timbrature mensa ecc..
      if QRSDet1.Controls[i].Tag in [C_GI1..C_GI2,C_TM1] then
      begin
        TQRLabel(QRSDet1.Controls[i]).Height:=GetHeight(TQRLabel(QRSDet1.Controls[i]));
        if (QRSDet1.Height + 1) <= TQRLabel(QRSDet1.Controls[i]).Height then
          QRSDet1.Height:=TQRLabel(QRSDet1.Controls[i]).Height + 2;
      end;
    end;
    ShapeDett.Top:=QRSDet1.Height - 2;
    MoreData:=True;
    Cur:=Cur+1;
  end
  else
  begin
    MoreData:=False;
    Cur:=DaGG;
  end;
end;

procedure TA027StampaTimb.QRSDetAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  //Salto pagine per dipendente
  //in QR6 (Delphi 10.2), la prima volta deve essere False, ma poi deve essere True
  QRSDet.ForceNewColumn:=True;
end;

procedure TA027StampaTimb.SetTimbrature(S:String);
{Scrive le timbrature nel controllo TRichEdit collegato al TRichText}
var Da,Lung,i:Integer;
    Timb:String;
  function CalcolaLunghezza(S:String):Integer;
  var x:Integer;
  begin
    Result:=0;
    for x:=1 to Length(S) do
      Result:=Result + Self.TextWidth(QRSDet1.Font,S[x]);
  end;
begin
  RETimb.Lines.Clear;
  Lung:=R400FCartellinoDtM.LungTimb - 1;
  Timb:='';
  for i:=1 to ((Length(S) + 1) div R400FCartellinoDtM.LungTimb) do
  begin
    Da:=(i-1) * R400FCartellinoDtM.LungTimb + 1;
    //if CalcolaLunghezza(Timb + ' ' + Copy(S,Da,Lung)) > RTTimb.Width then
    if Self.TextWidth(QRSDet1.Font,Timb + ' ' + Copy(S,Da,Lung)) > RTTimb.Width then
    begin
      RETimb.Lines.Add(Timb);
      Timb:='';
    end;
    if Timb <> '' then Timb:=Timb + ' ';
    Timb:=Timb + Copy(S,Da,Lung);
  end;
  if Timb <> '' then
    RETimb.Lines.Add(Timb);
end;

procedure TA027StampaTimb.QRSDet1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var S,Timb:String;
    x,y,i,Da:Integer;
begin
  PrintBand:=True;
  //Dimensionamento dei separatori verticali
  for i:= 0 to ListaShape.Count - 1 do
    TQRShape(ListaShape.Items[i]).Height:=QRSDet1.Height;
  //Evidenziazione dei giorni festivi/non lavorativi
  if (R400FCartellinoDtM.EsisteDato(C_GG1)) and
     (R400FCartellinoDtM.Q950Int.FieldByName('Grassetto').AsString = 'S') then
    begin
    for i:=0 to QRSDet1.ControlCount - 1 do
      if QRSDet1.Controls[i].Tag = C_GG1 then
        begin
        S:=TQRLabel(QRSDet1.Controls[i]).Caption;
        if Pos('*',S) > 0 then
          TQRLabel(QRSDet1.Controls[i]).Font.Style:=[fsBold]
        else
          TQRLabel(QRSDet1.Controls[i]).Font.Style:=[];
        Break;
        end;
    end;
  TotSettimana.Enabled:=(R400FCartellinoDtM.VetDomenica[Cur-1] > -1) and (R400FCartellinoDtM.c03_tipocart = 'S');
  //Evidenziazione delle timbrature manuali
  if not RTTimb.Enabled then exit;
  S:=RETimb.Lines.Text;
  RETimb.SelStart:=1;
  RETimb.SelLength:=Length(S);
  RETimb.SelAttributes.Style:=[];
  y:=0;
  for i:=0 to RETimb.Lines.Count - 1 do
    begin
    if (RETimb.Hint <> '') and (i >= RETimb.Lines.Count - StrToIntDef(RETimb.Hint,1)) then
      Break;
    Timb:=RETimb.Lines[i];
    for x:=1 to ((Length(Timb) + 1) div R400FCartellinoDtM.LungTimb) do
      begin
      Da:=y + (x-1) * R400FCartellinoDtM.LungTimb;
      RETimb.SelStart:=Da;
      RETimb.SelLength:=R400FCartellinoDtM.LungTimb - 1;
      RETimb.SelAttributes.Style:=[];
      if (S[Da + 1] = 'e') or (S[Da + 1] = 'u') then
        //Timbratura manuale
        RETimb.SelAttributes.Style:=[fsBold]
      else
        RETimb.SelAttributes.Style:=[];
      end;
    y:=y + Length(Timb) + 2;
    end;
end;

procedure TA027StampaTimb.TotSettimanaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  OreRese.Caption:=R400FCartellinoDtM.TotSett[R400FCartellinoDtM.VetDomenica[Cur-1]].OreRese;
  DebitoSet.Caption:=R400FCartellinoDtM.TotSett[R400FCartellinoDtM.VetDomenica[Cur-1]].Debito;
  SaldoSet.Caption:=R400FCartellinoDtM.TotSett[R400FCartellinoDtM.VetDomenica[Cur-1]].Saldo;
end;

function TA027StampaTimb.GetHeight(X:TQRLabel):Integer;
{Proporziono l'altezza del controllo in base al testo contenuto}
var
  W:Integer;
  i,Tot: Integer;
  LstRighe: TStringList;
begin
  {originale
  W:=Trunc(Self.TextWidth(X.Font,X.Caption) / X.Width) + 1;
  Result:=StrToIntDef(X.Hint,1) * W;
  }

  // nuova gestione
  if Pos(#13,X.Caption) = 0 then
  begin
    // gestione riga unica (nessun CR nella caption)
    W:=Trunc(Self.TextWidth(X.Font,X.Caption) / X.Width) + 1;
    Result:=StrToIntDef(X.Hint,1) * W;
  end
  else
  begin
    // gestione multiriga (CR presenti nella caption)
    Tot:=0;
    LstRighe:=TStringList.Create;
    try
      // spezza il contenuto in più righe separate da CR
      R180Tokenize(LstRighe,X.Caption,#13);
      for i:=0 to LstRighe.Count - 1 do
      begin
        W:=Trunc(Self.TextWidth(X.Font,LstRighe[i]) / X.Width) + 1;
        Tot:=Tot + StrToIntDef(X.Hint,1) * W;
      end;
      Result:=Tot;
    finally
      FreeAndNil(LstRighe);
    end;
  end;
end;

procedure TA027StampaTimb.RiepilogoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var i:Integer;
begin
  for i:=0 to Riepilogo.ControlCount - 1 do
    with TQRLabel(Riepilogo.Controls[i]) do
      if Tag > 0 then
        if Tag < 2001 then
          Caption:=R400FCartellinoDtM.VetRiepStampa[Tag]
        else
          Caption:=R400FCartellinoDtM.VetDatiLiberiSQL[Tag - 2001].Dato;
end;

procedure TA027StampaTimb.Riepilogo2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var x,NA,AssSkip,AssTotali:Integer;
    G:TGiustificativo;
    NumFamiliari:Word;
  procedure RiepilogaAssenze(RifDataNas:Boolean; DataNas:TDateTime);
  var i:Integer;
      CodCausale,DescCausale,UM:String;
      Quantita,OreRese:Real;
  begin
    CodCausale:=G.Causale;
    DescCausale:=Trim(R400FCartellinoDtM.trpassemes[NA].tdescassemes);
    if RifDataNas then
    begin
      R400FCartellinoDtM.R600DtM1.GetQuantitaAssenze(Self.DataSet.FieldByName('PROGRESSIVO').AsInteger,R400FCartellinoDtM.DataDa,R400FCartellinoDtM.DataA,DataNas,G,UM,Quantita,OreRese);
      CodCausale:=CodCausale + '*' + R400FCartellinoDtM.R600DtM1.RiferimentoDataNascita.IDFamiliare;
      DescCausale:=R400FCartellinoDtM.R600DtM1.RiferimentoDataNascita.IDFamiliare + '*' + DescCausale;
    end;
    //Calcolo competenze o unità di misura
    if (not RifDataNas) and ((not R400FCartellinoDtM.trpassemes[NA].tCompetenze) or (not R400FCartellinoDtM.CalcoloCompetenze)) then
      //Non devo calcolare le competenze: leggo solo l'unità di misura
      R400FCartellinoDtM.R600DtM1.GetQuantitaAssenze(Self.DataSet.FieldByName('PROGRESSIVO').AsInteger,R400FCartellinoDtM.InizioAssenze,R400FCartellinoDtM.FineAssenze,DataNas,G,UM,Quantita,OreRese) //Lorena 20/12/2005
    else if R400FCartellinoDtM.trpassemes[NA].tCompetenze then
    //Calcolo le competenze se non le ho già calcolate
    begin
      if not R400FCartellinoDtM.trpassemes[NA].tCalcolato then
      begin
        if not RifDataNas then  //Lorena 20/12/2005
          R400FCartellinoDtM.R600DtM1.GetQuantitaAssenze(Self.DataSet.FieldByName('PROGRESSIVO').AsInteger,R400FCartellinoDtM.InizioAssenze,R400FCartellinoDtM.FineAssenze,DataNas,G,UM,Quantita,OreRese); //Lorena 20/12/2005
        R400FCartellinoDtM.R600DtM1.GetAssenze(Self.DataSet.FieldByName('PROGRESSIVO').AsInteger,R400FCartellinoDtM.FineAssenze,R400FCartellinoDtM.FineAssenze,DataNas,G);
        UM:=R400FCartellinoDtM.R600DtM1.UMisura;
        R400FCartellinoDtM.trpassemes[NA].tCalcolato:=True and (not RifDataNas);
        if (R400FCartellinoDtM.R600DtM1.TipoCumulo <> 'H') and
           (R400FCartellinoDtM.R600DtM1.ValCompCorr = 0) and
           (R400FCartellinoDtM.R600DtM1.ValCompPrec = 0) and
           (R400FCartellinoDtM.R600DtM1.ValFruitoTot = 0) then
        begin
        // Giorgio + Alberto 12/2019 aggiunto ricalcolo saldi per causali assenza passando come data di riferimento
        // il "FineMese" della data di "InizioAssenze" solo se assenze a cavallo di anno
        // (anno "FineAssenze" differisce da anno "InizioAssenze")
        // NB. la casistica può verificarsi solo per "cartellino settimanale"
          if R180Anno(R400FCartellinoDtM.FineAssenze) <> R180Anno(R400FCartellinoDtM.InizioAssenze) then
          begin
            R400FCartellinoDtM.R600DtM1.GetAssenze(Self.DataSet.FieldByName('PROGRESSIVO').AsInteger,R180FineMese(R400FCartellinoDtM.InizioAssenze),R180FineMese(R400FCartellinoDtM.InizioAssenze),DataNas,G);
            UM:=R400FCartellinoDtM.R600DtM1.UMisura;
            //R400FCartellinoDtM.trpassemes[NA].tCalcolato:=True and (not RifDataNas);
            if (R400FCartellinoDtM.R600DtM1.TipoCumulo <> 'H') and
               (R400FCartellinoDtM.R600DtM1.ValCompCorr = 0) and
               (R400FCartellinoDtM.R600DtM1.ValCompPrec = 0) and
               (R400FCartellinoDtM.R600DtM1.ValFruitoTot = 0) then
            begin
              inc(AssSkip);
              exit;
            end;
          end
          else
        // Giorgio + Alberto 12/2019 - Fine inserimento
          begin
            inc(AssSkip);
            exit;
          end;
        end;
      end;
    end
    else if RifDataNas and (Quantita = 0) then
    begin
      inc(AssSkip);
      exit;
    end;
    if UM = 'O' then UM:='H';
(*    if not RifDataNas then  //Lorena 20/12/2005
      if UM = 'G' then
        Quantita:=R400FCartellinoDtM.trpassemes[NA].tggassemes + (R400FCartellinoDtM.trpassemes[NA].tmgassemes / 2)
      else
        Quantita:=R400FCartellinoDtM.trpassemes[NA].tmintotassemes;//R400FCartellinoDtM.trpassemes[NA].tminvalassemes;*)
    //Scorrimento dati da valorizzare
    for i:=0 to Riepilogo2.ControlCount - 1 do
      if Riepilogo2.Controls[i].Enabled then
        case Riepilogo2.Controls[i].Tag of
          //Codice assenza
          901:with TQRMemo(Riepilogo2.Controls[i]) do
                Lines.Add(Format('%-7s(%s)',[CodCausale,UM]));
          //Fatto nel mese
          902:with TQRMemo(Riepilogo2.Controls[i]) do
                if UM = 'G' then
                  Lines.Add(FloatToStr(Quantita))
                else
                  Lines.Add(R180MinutiOre(Trunc(Quantita)));
          //Competenze complessive
          903:with TQRMemo(Riepilogo2.Controls[i]) do
                if not R400FCartellinoDtM.trpassemes[NA].tCompetenze then Lines.Add('')
                else Lines.Add(R400FCartellinoDtM.R600DtM1.GetCompTot);
          //Competenze anno precedente
          904:with TQRMemo(Riepilogo2.Controls[i]) do
                if not R400FCartellinoDtM.trpassemes[NA].tCompetenze then Lines.Add('')
                else Lines.Add(R400FCartellinoDtM.R600DtM1.GetCompPrec);
          //Competenze anno corrente
          905:with TQRMemo(Riepilogo2.Controls[i]) do
                if not R400FCartellinoDtM.trpassemes[NA].tCompetenze then Lines.Add('')
                else Lines.Add(R400FCartellinoDtM.R600DtM1.GetCompCorr);
          //Assenze fruite
          906:with TQRMemo(Riepilogo2.Controls[i]) do
                if not R400FCartellinoDtM.trpassemes[NA].tCompetenze then Lines.Add('')
                else Lines.Add(R400FCartellinoDtM.R600DtM1.GetFruitoTot);
          //Assenze residue
          907:with TQRMemo(Riepilogo2.Controls[i]) do
                if not R400FCartellinoDtM.trpassemes[NA].tCompetenze then Lines.Add('')
                else Lines.Add(R400FCartellinoDtM.R600DtM1.GetResiduo);
          916:with TQRMemo(Riepilogo2.Controls[i]) do
                if not R400FCartellinoDtM.trpassemes[NA].tCompetenze then Lines.Add('')
                else Lines.Add(R400FCartellinoDtM.R600DtM1.GetResiduoPrec);
          917:with TQRMemo(Riepilogo2.Controls[i]) do
                if not R400FCartellinoDtM.trpassemes[NA].tCompetenze then Lines.Add('')
                else Lines.Add(R400FCartellinoDtM.R600DtM1.GetResiduoCorr);
          //Descrizione assenza
          908:with TQRMemo(Riepilogo2.Controls[i]) do
                Lines.Add(Format('%s(%s)',[Copy(DescCausale,1,Width div Self.TextWidth(Font,'A') - 3),UM]));
          //Assenze fruite anno precedente
          909:with TQRMemo(Riepilogo2.Controls[i]) do
                if not R400FCartellinoDtM.trpassemes[NA].tCompetenze then Lines.Add('')
                else Lines.Add(R400FCartellinoDtM.R600DtM1.GetFruitoPrec);
          //Assenze fruite anno corrente
          910:with TQRMemo(Riepilogo2.Controls[i]) do
                if not R400FCartellinoDtM.trpassemes[NA].tCompetenze then Lines.Add('')
                else Lines.Add(R400FCartellinoDtM.R600DtM1.GetFruitoCorr);
          //Competenze totali in giorni
          911:with TQRMemo(Riepilogo2.Controls[i]) do
              if not R400FCartellinoDtM.trpassemes[NA].tCompetenze then Lines.Add('')
              else
              begin
                if UM = 'G' then
                  Lines.Add(R400FCartellinoDtM.R600DtM1.GetCompTot)
                else
                  try
                    //Lines.Add(Format('%.2f',[R180OreMinutiExt(R400FCartellinoDtM.R600DtM1.GetCompTot)/R400FCartellinoDtM.R600DtM1.ValenzaGiornaliera]));
                    Lines.Add(Format('%.2f',[R400FCartellinoDtM.R600DtM1.TrasformaOre2Giorni(R180OreMinutiExt(R400FCartellinoDtM.R600DtM1.GetCompTot))]));
                  except
                    Lines.Add('0');
                  end;
              end;
          //Fruito totali in giorni
          912:with TQRMemo(Riepilogo2.Controls[i]) do
              if not R400FCartellinoDtM.trpassemes[NA].tCompetenze then Lines.Add('')
              else
              begin
                if UM = 'G' then
                  Lines.Add(R400FCartellinoDtM.R600DtM1.GetFruitoTot)
                else
                  try
                    //Lines.Add(Format('%.2f',[R180OreMinutiExt(R400FCartellinoDtM.R600DtM1.GetFruitoTot)/R400FCartellinoDtM.R600DtM1.ValenzaGiornaliera]));
                    Lines.Add(Format('%.2f',[R400FCartellinoDtM.R600DtM1.TrasformaOre2Giorni(R180OreMinutiExt(R400FCartellinoDtM.R600DtM1.GetFruitoTot))]));
                  except
                    Lines.Add('0');
                  end;
              end;
          //Competenze totali in giorni
          913:with TQRMemo(Riepilogo2.Controls[i]) do
              if not R400FCartellinoDtM.trpassemes[NA].tCompetenze then Lines.Add('')
              else
              begin
                if UM = 'G' then
                  Lines.Add(R400FCartellinoDtM.R600DtM1.GetResiduo)
                else
                  try
                    //Lines.Add(Format('%.2f',[R180OreMinutiExt(R400FCartellinoDtM.R600DtM1.GetResiduo)/R400FCartellinoDtM.R600DtM1.ValenzaGiornaliera]));
                    Lines.Add(Format('%.2f',[R400FCartellinoDtM.R600DtM1.TrasformaOre2Giorni(R180OreMinutiExt(R400FCartellinoDtM.R600DtM1.GetResiduo))]));
                  except
                    Lines.Add('0');
                  end;
              end;
          //Competenze parziali al mese in elaborazione
          914:with TQRMemo(Riepilogo2.Controls[i]) do
                if not R400FCartellinoDtM.trpassemes[NA].tCompetenze then Lines.Add('')
                else Lines.Add(R400FCartellinoDtM.R600DtM1.GetCompParz);
          //Residuo parziale
          915:with TQRMemo(Riepilogo2.Controls[i]) do
                if not R400FCartellinoDtM.trpassemes[NA].tCompetenze then Lines.Add('')
                else Lines.Add(R400FCartellinoDtM.R600DtM1.GetResiduoParz);
        end;
  end;
begin
  //Svuoto i campi memo e scrivo la caption
  for x:=0 to Riepilogo2.ControlCount - 1 do
    if Riepilogo2.Controls[x].Enabled then
      with TQRMemo(Riepilogo2.Controls[x]) do
      begin
        Lines.Clear;
        Lines.Add(Hint);
      end;
  AssSkip:=0;
  AssTotali:=0;
  //Scorrimento riepilogo assenze
  for NA:=1 to R400FCartellinoDtM.n_rpassemes do
  begin
    G.Inserimento:=False;
    G.Modo:='I';
    G.Causale:=R400FCartellinoDtM.trpassemes[NA].tcsassemes;
    if R180CarattereDef(VarToStr(R400FCartellinoDtM.Q265Riep.Lookup('Codice',G.Causale,'Cumulo_Familiari')),1,'N') in ['S','D'] then
      with R400FCartellinoDtM.R600DtM1.selT040DataNas do
      begin
        Close;
        SetVariable('Progressivo',Self.DataSet.FieldByName('PROGRESSIVO').AsInteger);
        SetVariable('Causale',G.Causale);
        SetVariable('Data1',EncodeDate(1900,1,1));
        SetVariable('Data2',R400FCartellinoDtM.DataA);
        Open;
        NumFamiliari:=0;
        while not Eof do
        begin
          inc(NumFamiliari);
          if NumFamiliari > 1 then
            inc(AssTotali);
          RiepilogaAssenze(True,FieldByName('DataNas').AsDateTime);
          Next;
        end;
      end
    else
      RiepilogaAssenze(False,Date);
  end;
  AssTotali:=R400FCartellinoDtM.n_rpassemes + AssTotali - AssSkip;
  for x:=0 to Riepilogo2.ControlCount - 1 do
    TQRMemo(Riepilogo2.Controls[x]).Height:=(AssTotali + 1) * Self.TextHeight(Riepilogo2.Font,'A');
  Riepilogo2.Height:=(AssTotali + 1) * Self.TextHeight(Riepilogo2.Font,'A') + 1;
  PrintBand:=AssTotali > 0;
end;

procedure TA027StampaTimb.Riepilogo3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var i,j,NA,Tot,k,CausStampate:Integer;
    S:String;
    TipoLiq:Char;
begin
  //Svuoto i campi memo e scrivo la caption
  for i:=0 to Riepilogo3.ControlCount - 1 do
    if Riepilogo3.Controls[i].Enabled then
      with TQRMemo(Riepilogo3.Controls[i]) do
        begin
        Lines.Clear;
        Lines.Add(Hint);
        end;
  //Lettura voci paghe abilitate su interfaccia paghe per la liquidazione delle causali di presenza
  R400FCartellinoDtM.selT190.Close;
  for i:=0 to Riepilogo3.ControlCount - 1 do
    if (Riepilogo3.Controls[i].Enabled) and (Riepilogo3.Controls[i].Tag >= 960) and (Riepilogo3.Controls[i].Tag <= 963) then
    begin
      with R400FCartellinoDtM do
      begin
        if selT190.VariableIndex('PROGRESSIVO') >= 0 then
          selT190.SetVariable('PROGRESSIVO',Self.DataSet.FieldByName('PROGRESSIVO').AsInteger);
        if selT190.VariableIndex('DATA') >= 0 then
          selT190.SetVariable('DATA',DataA);
        selT190.Open;
      end;
      Break;
    end;
  //Scorrimento riepilogo presenze
  CausStampate:=0;
  for NA:=1 to R400FCartellinoDtM.n_rppresmes do
    //Scorrimento dati da valorizzare
    begin
    if not R400FCartellinoDtM.Q275Riep.Locate('Codice',R400FCartellinoDtM.trppresmes[NA].tcspresmes,[]) then
      Continue;
    if R400FCartellinoDtM.Q275Riep.FieldByName('Stampe').AsString = 'B' then
      Continue;
    if Pos(',' + R400FCartellinoDtM.trppresmes[NA].tcspresmes + ',',',' + R400FCartellinoDtM.Q950Int.FieldByName('CAUPRES_ESCLUSE').AsString + ',') > 0 then
      Continue;
    if not A000FiltroDizionario('CAUSALI SUL CARTELLINO',R400FCartellinoDtM.trppresmes[NA].tcspresmes) then
      Continue;
    inc(CausStampate);
    k:=R400FCartellinoDtM.R450DtM1.IndiceRiepPres(R400FCartellinoDtM.trppresmes[NA].tcspresmes);
    TipoLiq:='N';
    with R400FCartellinoDtM do
      if selT190.Active then
      begin
        if (Q275Riep.FieldByName('VOCEPAGHE').AsString = 'S') and (Q275Riep.FieldByName('VOCEPAGHELIQ').AsString = 'S') then
        begin
          (*if selT190.Locate('CODINTERNO','230',[]) or (not selT190.Locate('CODINTERNO','160',[])) then
            TipoLiq:='R'
          else
            TipoLiq:='L';*)
          if selT190.Locate('CODINTERNO','160',[]) or (not selT190.Locate('CODINTERNO','230',[])) then
            TipoLiq:='L'
          else
            TipoLiq:='R';
        end
        else if Q275Riep.FieldByName('VOCEPAGHE').AsString = 'S' then
          TipoLiq:='R'
        else if Q275Riep.FieldByName('VOCEPAGHELIQ').AsString = 'S' then
          TipoLiq:='L'
      end;
    for i:=0 to Riepilogo3.ControlCount - 1 do
      if Riepilogo3.Controls[i].Enabled then
        case Riepilogo3.Controls[i].Tag of
          //Codice presenza
          951:with TQRMemo(Riepilogo3.Controls[i]) do
                Lines.Add(R400FCartellinoDtM.trppresmes[NA].tcspresmes);
          //Descrizione presenza
          952:with TQRMemo(Riepilogo3.Controls[i]) do
                Lines.Add(Copy(Trim(R400FCartellinoDtM.trppresmes[NA].tdescpresmes),1,Width div Self.TextWidth(Font,'A')));
          //Fatto nel mese in fasce
          953:with TQRMemo(Riepilogo3.Controls[i]) do
                begin
                S:='';
                for j:=1 to R400FCartellinoDtM.R450DtM1.NFasceMese do
                   S:=S + Format('%7s',[R180MinutiOre(R400FCartellinoDtM.trppresmes[NA].tminpresmes[j])]);
                Lines.Add(Trim(S));
                end;
          //Fatto nel mese in totale
          954:with TQRMemo(Riepilogo3.Controls[i]) do
                begin
                Tot:=0;
                for j:=1 to R400FCartellinoDtM.R450DtM1.NFasceMese do
                   inc(Tot,R400FCartellinoDtM.trppresmes[NA].tminpresmes[j]);
                Lines.Add(R180MinutiOre(Tot));
                end;
          //Sigla presenza
          955:with TQRMemo(Riepilogo3.Controls[i]) do
                Lines.Add(R400FCartellinoDtM.trppresmes[NA].tsiglapresmes);
          //Fatto da inizio anno in fasce
          956:with TQRMemo(Riepilogo3.Controls[i]) do
                begin
                S:='';
                for j:=1 to R400FCartellinoDtM.R450DtM1.NFasceMese do
                   S:=S + Format('%7s',[R180MinutiOre(R400FCartellinoDtM.R450DtM1.RiepPres[k].OreRese[j])]);
                Lines.Add(Trim(S));
                end;
          //Fatto da inizio anno totale
          957:with TQRMemo(Riepilogo3.Controls[i]) do
                begin
                Tot:=0;
                for j:=1 to R400FCartellinoDtM.R450DtM1.NFasceMese do
                   inc(Tot,R400FCartellinoDtM.R450DtM1.RiepPres[k].OreRese[j]);
                Lines.Add(R180MinutiOre(Tot));
                end;
          //Liquidabile (da inizio anno) in fasce
          958:with TQRMemo(Riepilogo3.Controls[i]) do
                begin
                S:='';
                for j:=1 to R400FCartellinoDtM.R450DtM1.NFasceMese do
                   S:=S + Format('%7s',[R180MinutiOre(R400FCartellinoDtM.R450DtM1.RiepPres[k].Liquidabile[j])]);
                Lines.Add(Trim(S));
                end;
          //Liquidabile (da inizio anno) totale
          959:with TQRMemo(Riepilogo3.Controls[i]) do
                begin
                Tot:=0;
                for j:=1 to R400FCartellinoDtM.R450DtM1.NFasceMese do
                   inc(Tot,R400FCartellinoDtM.R450DtM1.RiepPres[k].Liquidabile[j]);
                Lines.Add(R180MinutiOre(Tot));
                end;
          //Liquidato in fasce
          960:with TQRMemo(Riepilogo3.Controls[i]) do
                begin
                S:='';
                for j:=1 to R400FCartellinoDtM.R450DtM1.NFasceMese do
                  if TipoLiq = 'R' then
                     S:=S + Format('%7s',[R180MinutiOre(R400FCartellinoDtM.trppresmes[NA].tminpresmes[j])])
                  else if TipoLiq = 'L' then
                     S:=S + Format('%7s',[R180MinutiOre(R400FCartellinoDtM.R450DtM1.RiepPres[k].LiquidatoMese[j])]);
                Lines.Add(Trim(S));
                end;
          //Liquidato totale
          961:with TQRMemo(Riepilogo3.Controls[i]) do
                begin
                Tot:=0;
                for j:=1 to R400FCartellinoDtM.R450DtM1.NFasceMese do
                  if TipoLiq = 'R' then
                    inc(Tot,R400FCartellinoDtM.trppresmes[NA].tminpresmes[j])
                  else if TipoLiq = 'L' then
                    inc(Tot,R400FCartellinoDtM.R450DtM1.RiepPres[k].LiquidatoMese[j]);
                Lines.Add(R180MinutiOre(Tot));
                end;
          //Liquidato annuo in fasce
          962:with TQRMemo(Riepilogo3.Controls[i]) do
                begin
                S:='';
                for j:=1 to R400FCartellinoDtM.R450DtM1.NFasceMese do
                  if TipoLiq = 'R' then
                    S:=S + Format('%7s',[R180MinutiOre(R400FCartellinoDtM.R450DtM1.RiepPres[k].OreRese[j])])
                  else if TipoLiq = 'L' then
                    S:=S + Format('%7s',[R180MinutiOre(R400FCartellinoDtM.R450DtM1.RiepPres[k].Liquidato[j])]);
                Lines.Add(Trim(S));
                end;
          //Liquidato annuo totale
          963:with TQRMemo(Riepilogo3.Controls[i]) do
                begin
                Tot:=0;
                for j:=1 to R400FCartellinoDtM.R450DtM1.NFasceMese do
                  if TipoLiq = 'R' then
                    inc(Tot,R400FCartellinoDtM.R450DtM1.RiepPres[k].OreRese[j])
                  else if TipoLiq = 'L' then
                    inc(Tot,R400FCartellinoDtM.R450DtM1.RiepPres[k].Liquidato[j]);
                Lines.Add(R180MinutiOre(Tot));
                end;
          //Residuo (da inizio anno) in fasce
          964:with TQRMemo(Riepilogo3.Controls[i]) do
                begin
                S:='';
                for j:=1 to R400FCartellinoDtM.R450DtM1.NFasceMese do
                   S:=S + Format('%7s',[R180MinutiOre(R400FCartellinoDtM.R450DtM1.RiepPres[k].Residuo[j])]);
                Lines.Add(Trim(S));
                end;
          //Residuo (da inizio anno) totale
          965:with TQRMemo(Riepilogo3.Controls[i]) do
                begin
                Tot:=0;
                for j:=1 to R400FCartellinoDtM.R450DtM1.NFasceMese do
                   inc(Tot,R400FCartellinoDtM.R450DtM1.RiepPres[k].Residuo[j]);
                Lines.Add(R180MinutiOre(Tot));
                end;
          //Compensabile registrato
          966:with TQRMemo(Riepilogo3.Controls[i]) do
                Lines.Add(R180MinutiOre(R400FCartellinoDtM.R450DtM1.RiepPres[k].CompensabileMese));
          //Compensabile effettivo
          967:with TQRMemo(Riepilogo3.Controls[i]) do
                Lines.Add(R180MinutiOre(R400FCartellinoDtM.R450DtM1.RiepPres[k].CompensabileMeseEff));
          //Compensabile annuo registrato
          968:with TQRMemo(Riepilogo3.Controls[i]) do
                Lines.Add(R180MinutiOre(R400FCartellinoDtM.R450DtM1.RiepPres[k].CompensabileAnno));
          //Compensabile annuo effettivo
          969:with TQRMemo(Riepilogo3.Controls[i]) do
                Lines.Add(R180MinutiOre(R400FCartellinoDtM.R450DtM1.RiepPres[k].CompensabileAnnoEff));
          //recupero mese da assenza
          970:with TQRMemo(Riepilogo3.Controls[i]) do
                Lines.Add(R180MinutiOre(R400FCartellinoDtM.R450DtM1.RiepPres[k].RecuperoMese));
          //recupero annuo da assenza
          971:with TQRMemo(Riepilogo3.Controls[i]) do
                Lines.Add(R180MinutiOre(R400FCartellinoDtM.R450DtM1.RiepPres[k].RecuperoAnno));
          //Ore perse (nel mese) in fasce
          972:with TQRMemo(Riepilogo3.Controls[i]) do
                begin
                S:='';
                for j:=1 to R400FCartellinoDtM.R450DtM1.NFasceMese do
                   S:=S + Format('%7s',[R180MinutiOre(R400FCartellinoDtM.R450DtM1.RiepPres[k].Abbattimento[j])]);
                Lines.Add(Trim(S));
                end;
          //Ore perse (nel mese) totale
          973:with TQRMemo(Riepilogo3.Controls[i]) do
                begin
                Tot:=0;
                for j:=1 to R400FCartellinoDtM.R450DtM1.NFasceMese do
                   inc(Tot,R400FCartellinoDtM.R450DtM1.RiepPres[k].Abbattimento[j]);
                Lines.Add(R180MinutiOre(Tot));
                end;
        end;
      end;
  for i:=0 to Riepilogo3.ControlCount - 1 do
    TQRMemo(Riepilogo3.Controls[i]).Height:=(CausStampate + 1) * Self.TextHeight(Riepilogo3.Font,'A');
  Riepilogo3.Height:=(CausStampate + 1) * Self.TextHeight(Riepilogo3.Font,'A') + 1;
  PrintBand:=CausStampate > 0;
end;

procedure TA027StampaTimb.Riepilogo4BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var i:Integer;
begin
  for i:=0 to Sender.ControlCount - 1 do
    with TQRLabel(Sender.Controls[i]) do
      if Tag > 1000 then
        Caption:=R400FCartellinoDtM.VetDatiLiberiSQL[Tag - 1001].Dato;
end;

procedure TA027StampaTimb.AllineaRiepilogo4;
{Sposto i dati liberi all'inizio della banda poichè, leggendo dal gruppo di
 riepilogo, le coordinate sono riferite a tutti i dati riepilogativi (Riepilogo)}
var i,Min:Integer;
begin
  if not Riepilogo4.Enabled then exit;
  Min:=9999;
  for i:=0 to Riepilogo4.ControlCount - 1 do
    if TQRLabel(Riepilogo4.Controls[i]).Top < Min then
      Min:=TQRLabel(Riepilogo4.Controls[i]).Top;
  for i:=0 to Riepilogo4.ControlCount - 1 do
    TQRLabel(Riepilogo4.Controls[i]).Top:=TQRLabel(Riepilogo4.Controls[i]).Top - Min + 4;
  Riepilogo4.Height:=Riepilogo4.Height - Min + 4;
end;

procedure TA027StampaTimb.Riepilogo5BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  //daniloc.ini - gestione pagina di parità
  PrintBand:=(A027FCarMen.chkPaginaParita.Checked) and
             (Sender.ParentReport.PageNumber mod 2 <> 0);
  //IsPaginaParita:=PrintBand;
  // daniloc.fine
end;

procedure TA027StampaTimb.QRepAfterPreview(Sender: TObject);
begin
  if {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator = #0 then
    {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=ThousandSepOri;
end;

procedure TA027StampaTimb.DistruggiListe;
begin
  while ListaShape.Count > 0 do
  begin
    TQRShape(ListaShape.Items[ListaShape.Count-1]).Free;
    ListaShape.Delete(ListaShape.Count-1);
  end;
end;

procedure TA027StampaTimb.DistruggiIntestazione;
{Elimino i controlli creati a run-time dalle bande}
var i:Integer;
    Temp:TControl;
begin
  //INTESTAZIONE CARTOLINA
  for i:=Intestazione.ControlCount - 1 downto 0 do
    begin
    Temp:=Intestazione.Controls[i];
    Intestazione.RemoveControl(Temp);
    Temp.Free;
    end;
  //INTESTAZIONE COLONNE DI DETTAGLIO
  for i:=QRBInt3.ControlCount - 1 downto 0 do
    begin
    if QRBInt3.Controls[i].Tag = 0 then
      //Non elimino il QRShape di divisione
      Continue;
    Temp:=QRBInt3.Controls[i];
    QRBInt3.RemoveControl(Temp);
    Temp.Free;
    end;
  //DETTAGLIO
  for i:=QRSDet1.ControlCount - 1 downto 0 do
    begin
    if QRSDet1.Controls[i] is TQRLabel then
      begin
      Temp:=QRSDet1.Controls[i];
      QRSDet1.RemoveControl(Temp);
      Temp.Free;
      end;
    end;
  //TOTALI DI DETTAGLIO
  for i:=TotaliDett.ControlCount - 1 downto 0 do
    begin
    Temp:=TotaliDett.Controls[i];
    TotaliDett.RemoveControl(Temp);
    Temp.Free;
    end;
  //RIEPILOGO
  for i:=Riepilogo.ControlCount - 1 downto 0 do
    begin
    Temp:=Riepilogo.Controls[i];
    Riepilogo.RemoveControl(Temp);
    Temp.Free;
    end;
  //DATI LIBERI SUL PIEDE DELLA CARTOLINA
  for i:=Riepilogo4.ControlCount - 1 downto 0 do
    begin
    Temp:=Riepilogo4.Controls[i];
    Riepilogo4.RemoveControl(Temp);
    Temp.Free;
    end;
end;

procedure TA027StampaTimb.DistruggiRiepilogo;
{Resetto le proprietà dei controlli TQRMemo}
var i:Integer;
begin
  //Dati riepilogativi
  for i:=Riepilogo2.ControlCount - 1 downto 0 do
    begin
    (Riepilogo2.Controls[i] as TQRMemo).Enabled:=False;
    (Riepilogo2.Controls[i] as TQRMemo).AutoStretch:=False;
    end;
  //Riepilogo presenze
  for i:=Riepilogo3.ControlCount - 1 downto 0 do
    begin
    (Riepilogo3.Controls[i] as TQRMemo).Enabled:=False;
    (Riepilogo3.Controls[i] as TQRMemo).AutoStretch:=False;
    end;
end;

procedure TA027StampaTimb.TotaliDettBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
{Stampa dei totali del dettaglio}
var i,j:Integer;
    S1:String;
begin
  for i:=0 to TotaliDett.ControlCount - 1 do
    with TQRLabel(TotaliDett.Controls[i]) do
      case Tag of
        //Ore lavorate
        C_HL2:if R400FCartellinoDtM.RiepTotLav = 0 then
                Caption:=''
              else
                Caption:=R180MinutiOre(R400FCartellinoDtM.RiepTotLav);
        //Ore lorde
        C_HH2:if R400FCartellinoDtM.RiepOreLorde = 0 then
                Caption:=''
              else
                Caption:=R180MinutiOre(R400FCartellinoDtM.RiepOreLorde);
        //Ore lavorate in fasce
        C_LF2:begin
              Caption:='';
              for j:=1 to R400FCartellinoDtM.R450DtM1.NFasceMese do
                 begin
                 if R400FCartellinoDtM.totminlavmes[j] = 0 then S1:='     '
                 else S1:=R180MinutiOre(R400FCartellinoDtM.totminlavmes[j]);
                 if j > 1 then
                   Caption:=Caption + ' ';
                 Caption:=Caption + S1;
                 end;
              end;
        //Scostamento
        C_SC2:if R400FCartellinoDtM.RiepScost = 0 then
                Caption:=''
              else
                Caption:=R180MinutiOre(R400FCartellinoDtM.RiepScost);
        //Scostamento negativo
        C_SN2:if R400FCartellinoDtM.RiepScostNeg = 0 then
                Caption:=''
              else
                Caption:=R180MinutiOre(R400FCartellinoDtM.RiepScostNeg);
        //Scostamento positivo
        C_SP2:if R400FCartellinoDtM.RiepScostPos = 0 then
                Caption:=''
              else
                Caption:=R180MinutiOre(R400FCartellinoDtM.RiepScostPos);
        //Eccedenza solo compensabile
        C_CM2:if R400FCartellinoDtM.RiepCompGG = 0 then
                Caption:=''
              else
                Caption:=R180MinutiOre(R400FCartellinoDtM.RiepCompGG);
        //Eccedenza solo compensabile + negativo
        C_CMNG2:if R400FCartellinoDtM.RiepCompNegGG = 0 then
                  Caption:=''
                else
                  Caption:=R180MinutiOre(R400FCartellinoDtM.RiepCompNegGG);
        //Debito giornaliero
        C_DG2:if R400FCartellinoDtM.RiepDebitoGG = 0 then
                Caption:=''
              else
                Caption:=R180MinutiOre(R400FCartellinoDtM.RiepDebitoGG);
        //Eccedenze
        C_EC2:begin
              Caption:='';
              for j:=1 to R400FCartellinoDtM.R450DtM1.NFasceMese do
                 begin
                 if R400FCartellinoDtM.totStrfascia[j] = 0 then S1:='     '
                 else S1:=R180MinutiOre(R400FCartellinoDtM.totstrfascia[j]);
                 if j > 1 then
                   Caption:=Caption + ' ';
                 Caption:=Caption + S1;
                 end;
              end;
        //Ind.turno in fasce
        C_IT2:begin
              Caption:='';
              for j:=1 to R400FCartellinoDtM.R450DtM1.NFasceMese do
                 begin
                 if R400FCartellinoDtM.tindturfasmes[j] = 0 then S1:='     '
                 else S1:=R180MinutiOre(R400FCartellinoDtM.tindturfasmes[j]);
                 if j > 1 then
                   Caption:=Caption + ' ';
                 Caption:=Caption + S1;
                 end;
              end;
        //Ore escluse dalle normali
        C_ESC2:if R400FCartellinoDtM.RiepMinLavEsc = 0 then
                Caption:=''
              else
                Caption:=R180MinutiOre(R400FCartellinoDtM.RiepMinLavEsc);
        //Prolungamento inibito
        C_PRI2:if R400FCartellinoDtM.RiepProlInib = 0 then
                Caption:=''
              else
                Caption:=R180MinutiOre(R400FCartellinoDtM.RiepProlInib);
        //Prolungamento non causalizzato
        C_PRN2:if R400FCartellinoDtM.RiepProlNonCaus = 0 then
                Caption:=''
              else
                Caption:=R180MinutiOre(R400FCartellinoDtM.RiepProlNonCaus);
        //Prolungamento non conteggiato
        C_PRT2:if R400FCartellinoDtM.RiepProlNonCont = 0 then
                Caption:=''
              else
                Caption:=R180MinutiOre(R400FCartellinoDtM.RiepProlNonCont);
        //Detrazione pausa mensa
        C_PM2:if R400FCartellinoDtM.RiepPauMenDet = 0 then
                Caption:=''
              else
                Caption:=R180MinutiOre(R400FCartellinoDtM.RiepPauMenDet);
        //Ore in prolungamento in uscita non causalizzate
        C_PRU2:if R400FCartellinoDtM.RiepProlNonCausUscita = 0 then
                Caption:=''
              else
                Caption:=R180MinutiOre(R400FCartellinoDtM.RiepProlNonCausUscita);
        C_PINT2:if R400FCartellinoDtM.RiepPastiInt = 0 then
                Caption:=''
              else
                Caption:=IntToStr(R400FCartellinoDtM.RiepPastiInt);
        C_PCONV2:if R400FCartellinoDtM.RiepPastiConv = 0 then
                Caption:=''
              else
                Caption:=IntToStr(R400FCartellinoDtM.RiepPastiConv);
        C_FENNG2:if R400FCartellinoDtM.RiepFeNNG = 0 then
                Caption:=''
              else
                Caption:=IntToStr(R400FCartellinoDtM.RiepFeNNG);
        //Ore causalizzate
        C_CAU2:if R400FCartellinoDtM.RiepMinLavCau = 0 then
                Caption:=''
              else
                Caption:=R180MinutiOre(R400FCartellinoDtM.RiepMinLavCau);
        //Ind.presenza
        C_INDP2:if R400FCartellinoDtM.RiepIndPres = 0 then
                  Caption:=''
                else
                  Caption:=FloatToStr(R400FCartellinoDtM.RiepIndPres);
        //Ind.festiva
        C_INDF2:if R400FCartellinoDtM.RiepIndFest = 0 then
                  Caption:=''
                else
                  Caption:=FloatToStr(R400FCartellinoDtM.RiepIndFest);
        //Ind.notturna
        C_INDN2:if R400FCartellinoDtM.RiepIndNot = 0 then
                  Caption:=''
                else
                  Caption:=R180MinutiOre(R400FCartellinoDtM.RiepIndNot);
        //Num.notti
        C_NUMN2:if R400FCartellinoDtM.RiepNumNot = 0 then
                  Caption:=''
                else
                  Caption:=IntToStr(R400FCartellinoDtM.RiepNumNot);
      end;
end;

procedure TA027StampaTimb.QRepAfterPrint(Sender: TObject);
begin
  if {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator = #0 then
    {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=ThousandSepOri;
end;

procedure TA027StampaTimb.QRLMesePrint(Sender: TObject; var Value: String);
begin
  if not R400FCartellinoDtM.AggiornamentoEseguito then
    Value:=StringReplace(Value,AggSchedaRiep,'',[rfIgnoreCase]);
end;

procedure TA027StampaTimb.bndGruppoFileSeqBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
{Gestione del banner per Genova_Comune (CSI)}
var i:Integer;
begin
  with R400FCartellinoDtM do
  try
    QRLabel5.Caption:='Stampa del<@>';
    memoBanner.Lines.Clear;
    PG_Stampa_Banner_MondoEDP.SetVariable('STRINGA1',StringReplace(bndGruppoFileSeq.Expression,'T430','',[]));
    PG_Stampa_Banner_MondoEDP.SetVariable('STRINGA2',Self.DataSet.FieldByName(bndGruppoFileSeq.Expression).AsString);
    PG_Stampa_Banner_MondoEDP.Execute;
    selTAB_BANNER_OUT.Close;
    selTAB_BANNER_OUT.Open;
    for i:=1 to 25 do
      memoBanner.Lines.Add('');
    memoBanner.Lines.Add(lblStrappoPagina.Caption);
    for i:=1 to 2 do
      memoBanner.Lines.Add('');
    while not selTAB_BANNER_OUT.Eof do
    begin
      memoBanner.Lines.Add(selTAB_BANNER_OUT.FieldByName('STRINGA').AsString);
      selTAB_BANNER_OUT.Next;
    end;
    selTAB_BANNER_OUT.Close;
  except
  end;
end;

end.
