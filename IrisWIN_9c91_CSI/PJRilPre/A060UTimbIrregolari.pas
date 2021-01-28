unit A060UTimbIrregolari;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, StdCtrls, Menus, Buttons, Grids, DBGrids, Printers,
  A000UCostanti, A000USessione,A000UInterfaccia,A000UMessaggi, C180FunzioniGenerali, ComCtrls, A003UDataLavoroBis, Variants,
  RegistrazioneLog;

type
  TA060FTimbIrregolari = class(TForm)
    ScrollBox1: TScrollBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    LAzienda: TLabel;
    Label3: TLabel;
    LBadge: TLabel;
    LblDaData: TLabel;
    LblAData: TLabel;
    BtnDaData: TBitBtn;
    BtnAData: TBitBtn;
    DBGrid1: TDBGrid;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    btnCancella: TBitBtn;
    StatusBar1: TStatusBar;
    cmbABadge: TComboBox;
    cmbDaBadge: TComboBox;
    lblDalBadge: TLabel;
    lblAlBadge: TLabel;
    btnRefresh: TBitBtn;
    lblDaChiave: TLabel;
    cmbDaChiave: TComboBox;
    lblAChiave: TLabel;
    cmbAChiave: TComboBox;
    lblAScarico: TLabel;
    lblDaScarico: TLabel;
    cmbDaScarico: TComboBox;
    cmbAScarico: TComboBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure BtnDaDataClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancellaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cmbDaBadgeChange(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmbDaChiaveChange(Sender: TObject);
    procedure cmbAChiaveChange(Sender: TObject);
    procedure cmbDaBadgeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbDaScaricoChange(Sender: TObject);
    procedure cmbAScaricoChange(Sender: TObject);
  private
    procedure AggiornaRisultati;
    procedure RepaintAzienda(PAzienda:String);
    procedure RepaintBadgeChiave(PBadgeChiave:String);
    procedure RepaintStatusBar(Text:String);
    procedure CaricaComboBox;
  public
    DaData,AData:TDateTime;
  end;

var
  A060FTimbIrregolari: TA060FTimbIrregolari;

procedure OpenA060TimbIrregolari;

implementation

uses A060UTimbIrregolariDtM1;

{$R *.DFM}

procedure OpenA060TimbIrregolari;
{Ripristino timbrature irregolari}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA060TimbIrregolari') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A060FTimbIrregolari:=TA060FTimbIrregolari.Create(nil);
  try
    A060FTimbIrregolariDtM1:=TA060FTimbIrregolariDtM1.Create(nil);
    A060FTimbIrregolari.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    FreeAndNil(A060FTimbIrregolariDtM1);
    FreeAndNil(A060FTimbIrregolari);
  end;
end;

procedure TA060FTimbIrregolari.BitBtn1Click(Sender: TObject);
{Nome file di appoggio = TIaammgg.IRR}
var Msg:String;
begin
  if DaData > AData then
    raise Exception.Create(A000MSG_ERR_PERIODO_ERRATO);
  Screen.Cursor:=crHourGlass;
  A060FTimbIrregolariDtM1.A060MW.DaData:=DaData;
  A060FTimbIrregolariDtM1.A060MW.AData:=AData;
  with A060FTimbIrregolariDtM1.A060MW do
  begin
    DaBadge:=cmbDaBadge.Text;
    ABadge:=cmbABadge.Text;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
    DaChiave:=cmbDaChiave.Text;
    AChiave:=cmbAChiave.Text;
    DaScarico:=cmbDaScarico.Text;
    AScarico:=cmbAScarico.Text;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
    GrdRisultatiVisibile:=(DbGrid1 <> nil) and (DbGrid1.Visible);
    Msg:=Scarico;
    if Msg <> '' then
      ShowMessage(Msg);
  end;
  Screen.Cursor:=crDefault;
end;

procedure TA060FTimbIrregolari.BtnDaDataClick(Sender: TObject);
begin
  if Sender = BtnDaData then
  begin
    DaData:=DataOut(DaData,'Inizio timbr.irreg.:','G');
    LblDaData.Caption:=FormatDateTime('dd mmm yyyy',DaData);
    if DaData <> A060FTimbIrregolariDtM1.A060MW.QI101.GetVariable('Data1') then
    begin
      A060FTimbIrregolariDtM1.A060MW.QI101.SetVariable('Data1',DaData);
      A060FTimbIrregolariDtM1.A060MW.QI101.Close;
    end;
  end
  else
  begin
    AData:=DataOut(AData,'Fine timbr.irreg.:','G');
    LblAData.Caption:=FormatDateTime('dd mmm yyyy',AData);
    if AData <> A060FTimbIrregolariDtM1.A060MW.QI101.GetVariable('Data2') then
    begin
      A060FTimbIrregolariDtM1.A060MW.QI101.SetVariable('Data2',AData);
      A060FTimbIrregolariDtM1.A060MW.QI101.Close;
    end;
  end;
  A060FTimbIrregolariDtM1.A060MW.QI101.Open;
  CaricaComboBox;
end;

procedure TA060FTimbIrregolari.FormCreate(Sender: TObject);
begin
  DaData:=R180InizioMese(Parametri.DataLavoro);
  AData:=R180FineMese(Parametri.DataLavoro);
  LblDaData.Caption:=FormatDateTime('dd mmm yyyy',DaData);
  LblAData.Caption:=FormatDateTime('dd mmm yyyy',AData);
  BitBtn1.Enabled:=not SolaLettura;
  btnCancella.Enabled:=not SolaLettura;
end;

procedure TA060FTimbIrregolari.FormShow(Sender: TObject);
begin
  A060FTimbIrregolariDtM1.A060MW.RepaintAzienda:=RepaintAzienda;
  A060FTimbIrregolariDtM1.A060MW.RepaintBadge:=RepaintBadgeChiave;
  A060FTimbIrregolariDtM1.A060MW.RepaintStatusBar:=RepaintStatusBar;
end;

procedure TA060FTimbIrregolari.RepaintAzienda(PAzienda: String);
begin
  LAzienda.Caption:=PAzienda;
  LAzienda.Repaint;
end;

procedure TA060FTimbIrregolari.RepaintBadgeChiave(PBadgeChiave: String);
begin
  LBadge.Caption:=PBadgeChiave;
  LBadge.RePaint;
end;

procedure TA060FTimbIrregolari.RepaintStatusBar(Text: String);
begin
  {"(StatusBar1 <> nil)" il controllo serve nel caso in cui il progetto venga
  lanciato da Delphi}
  if StatusBar1 <> nil then
    StatusBar1.SimpleText:=Text;
end;

procedure TA060FTimbIrregolari.FormActivate(Sender: TObject);
begin
  DaData:=R180InizioMese(Parametri.DataLavoro);
  AData:=R180FineMese(Parametri.DataLavoro);
  LblDaData.Caption:=FormatDateTime('dd MMM yyyy',DaData);
  LblAData.Caption:=FormatDateTime('dd MMM yyyy',AData);
  CaricaComboBox;
  AggiornaRisultati;
end;

procedure TA060FTimbIrregolari.CaricaComboBox;
var
  // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
  //tmpLista:TStringList;
  tmpListaBadge,
  tmpListaChiavi,
  tmpListaScarico: TStringList;
  // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
begin
  try
    A060FTimbIrregolariDtM1.A060MW.DaData:=DaData;
    A060FTimbIrregolariDtM1.A060MW.AData:=AData;
    tmpListaBadge:=A060FTimbIrregolariDtM1.A060MW.CaricaListaBadge;
    cmbDaBadge.Items:=tmpListaBadge;
    cmbABadge.Items:=tmpListaBadge;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
    // i valori di badge da/a sono impostati vuoti
    {
    if cmbDaBadge.Text = '' then
      cmbDaBadge.Text:='0';
    if cmbABadge.Text = '' then
      cmbABadge.Text:='999999999999999';
    }
    // lista delle chiavi alternative al badge
    tmpListaChiavi:=A060FTimbIrregolariDtM1.A060MW.CaricaListaChiavi;
    cmbDaChiave.Items:=tmpListaChiavi;
    cmbAChiave.Items:=tmpListaChiavi;
    // lista delle parametrizzazioni di scarico
    tmpListaScarico:=A060FTimbIrregolariDtM1.A060MW.CaricaListaParamScarico;
    cmbDaScarico.Items:=tmpListaScarico;
    cmbAScarico.Items:=tmpListaScarico;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
  finally
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
    {
    if tmpLista <> nil then
      FreeAndNil(tmpLista);
    }
    if tmpListaScarico <> nil then
      FreeAndNil(tmpListaScarico);
    if tmpListaScarico <> nil then
      FreeAndNil(tmpListaScarico);
    if tmpListaScarico <> nil then
      FreeAndNil(tmpListaScarico);
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
  end;
end;

procedure TA060FTimbIrregolari.btnCancellaClick(Sender: TObject);
var Msg:String;
begin
  if R180MessageBox(Format(A000MSG_A060_DLG_FMT_ELIMINA_TIMBRATURE,[DateToStr(DaData),DateToStr(AData)]),DOMANDA) = mrYes then
  begin
    A060FTimbIrregolariDtM1.A060MW.DaData:=DaData;
    A060FTimbIrregolariDtM1.A060MW.AData:=AData;
    A060FTimbIrregolariDtM1.A060MW.DaBadge:=cmbDaBadge.Text;
    A060FTimbIrregolariDtM1.A060MW.ABadge:=cmbABadge.Text;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
    A060FTimbIrregolariDtM1.A060MW.DaChiave:=cmbDaChiave.Text;
    A060FTimbIrregolariDtM1.A060MW.AChiave:=cmbAChiave.Text;
    A060FTimbIrregolariDtM1.A060MW.DaScarico:=cmbDaScarico.Text;
    A060FTimbIrregolariDtM1.A060MW.AScarico:=cmbAScarico.Text;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
    Msg:=A060FTimbIrregolariDtM1.A060MW.CancellaTimbrature;
    if Msg <> '' then
      ShowMessage(Msg);
  end;
end;

procedure TA060FTimbIrregolari.cmbDaBadgeChange(Sender: TObject);
begin
  AggiornaRisultati;
end;

procedure TA060FTimbIrregolari.cmbDaBadgeKeyPress(Sender: TObject;
  var Key: Char);
begin
  // accetta solo cifre (0..9) e backspace (#8)
  if not (Key in ['0'..'9',#8]) then
    Key:=#0;
end;

// AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
procedure TA060FTimbIrregolari.cmbDaChiaveChange(Sender: TObject);
begin
  AggiornaRisultati;
end;

procedure TA060FTimbIrregolari.cmbAChiaveChange(Sender: TObject);
begin
  AggiornaRisultati;
end;

procedure TA060FTimbIrregolari.cmbDaScaricoChange(Sender: TObject);
begin
  AggiornaRisultati;
end;

procedure TA060FTimbIrregolari.cmbAScaricoChange(Sender: TObject);
begin
  AggiornaRisultati;
end;
// AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine

procedure TA060FTimbIrregolari.btnRefreshClick(Sender: TObject);
begin
  AggiornaRisultati;
end;

procedure TA060FTimbIrregolari.BitBtn4Click(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure TA060FTimbIrregolari.BitBtn5Click(Sender: TObject);
var
  H,NR:Integer;
  S:String;
  procedure Intestazione;
  begin
    Printer.Canvas.TextOut(5,H,DateToStr(Date));
    Printer.Canvas.TextOut(5,H*3,'Elenco timbrature irregolari dal ' + LblDaData.Caption + ' al ' + LblAData.Caption);
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
    // modifica intestazione per includere il dato Chiave
    //Printer.Canvas.TextOut(5,H*5,'Data       Badge           Ed. Verso Ora   Causale Rilevatore Param. scarico       Aziende');
    Printer.Canvas.TextOut(5,H*5,Format('%-10s %-15s %-3s %-20s %-5s %-5s %-7s %-6s %-20s %s',
                                        ['Data','Badge','Ed.','Chiave','Verso','Ora','Causale','Rilev.','Param. scarico','Aziende']));
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
    NR:=7;
  end;
begin
  if A060FTimbIrregolariDtM1.A060MW.QI101.RecordCount = 0 then
    raise Exception.Create('Nessuna timbratura da stampare!');
  Printer.Canvas.Font.Name:='Courier New';
  Printer.Canvas.Font.Size:=8;
  H:=Printer.Canvas.TextHeight('Z');
  Printer.BeginDoc;
  Intestazione;
  with A060FTimbIrregolariDtM1.A060MW.QI101 do
    begin
    DisableControls;
    First;
    while not Eof do
    begin
      if (NR * H) >= (Printer.PageHeight - H) then
      begin
        Printer.NewPage;
        Intestazione;
      end;
      S:=FormatDateTime('dd/mm/yyyy',FieldByName('Data').AsDateTime);
      S:=Format('%s %-15s',[S,FieldByName('Badge').AsString]);
      S:=Format('%s %-3s',[S,FieldByName('EdBadge').AsString]);
      // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
      // espone in stampa il dato chiave
      S:=Format('%s %-20s',[S,FieldByName('Chiave').AsString]);
      // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
      S:=Format('%s %5s %5s',[S,FieldByName('Verso').AsString,FormatDateTime('hh.nn',FieldByName('Ora').AsDateTime)]);
      S:=Format('%s %-7s %-6s',[S,FieldByName('Causale').AsString,FieldByName('Rilev').AsString]);
      S:=Format('%s %-20s',[S,FieldByName('Scarico').AsString]);
      S:=Format('%s %s',[S,Trim(FieldByName('Aziende').AsString)]);
      Printer.Canvas.TextOut(5,H * NR,S);
      inc(NR);
      Next;
    end;
    First;
    EnableControls;
  end;
  Printer.EndDoc;
end;

procedure TA060FTimbIrregolari.AggiornaRisultati;
begin
  A060FTimbIrregolariDtM1.A060MW.DaData:=DaData;
  A060FTimbIrregolariDtM1.A060MW.AData:=AData;
  with A060FTimbIrregolariDtM1.A060MW do
  begin
    DaBadge:=cmbDaBadge.Text;
    ABadge:=cmbABadge.Text;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
    DaChiave:=cmbDaChiave.Text;
    AChiave:=cmbAChiave.Text;
    DaScarico:=cmbDaScarico.Text;
    AScarico:=cmbAScarico.Text;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
    CaricaTimbrature;
  end;
end;

end.
