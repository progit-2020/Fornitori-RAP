unit A047UTimbMensa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TABELLE99, Menus, ComCtrls, QueryStorico, StdCtrls, ExtCtrls, Grids, Spin,
  DBCtrls, Buttons, C180FunzioniGenerali, A000UCostanti, A000USessione,A000UInterfaccia, DB, R500Lin,
  C700USelezioneAnagrafe, C005UDatiAnagrafici,  OracleData,
  SelAnagrafe, A046UTerMensa, Variants,  A047UTimbMensaMW,R300UAccessiMensaDtM,
  Generics.Collections,A000UGestioneTimbraGiustMW, A000UMessaggi;

type
  TNomiGiorni = array[1..7] of String[10];

  TGriglie = record
    Timbrat,Giustif,Accessi:TStringGrid;
    Giorno:TLabel;
    LPasti:TLabel;
  end;
  TA047FTimbMensa = class(TFrmTabelle99)
    Panel2: TPanel;
    EMese: TSpinEdit;
    Label3: TLabel;
    EAnno: TSpinEdit;
    Label4: TLabel;
    ScrollBox3: TScrollBox;
    LGiorno1: TLabel;
    GTimbrat1: TStringGrid;
    GGiustif1: TStringGrid;
    LGiorno2: TLabel;
    GTimbrat2: TStringGrid;
    GGiustif2: TStringGrid;
    LGiorno3: TLabel;
    GTimbrat3: TStringGrid;
    GGiustif3: TStringGrid;
    LGiorno4: TLabel;
    GTimbrat4: TStringGrid;
    GGiustif4: TStringGrid;
    LGiorno5: TLabel;
    GTimbrat5: TStringGrid;
    GGiustif5: TStringGrid;
    LGiorno6: TLabel;
    GTimbrat6: TStringGrid;
    GGiustif6: TStringGrid;
    BPrec: TBitBtn;
    BSucc: TBitBtn;
    Timbrature1: TMenuItem;
    Inserisci1: TMenuItem;
    Cancella1: TMenuItem;
    Modifica1: TMenuItem;
    SBConteggi: TSpeedButton;
    SpAnomalie: TSpeedButton;
    PopupMenu1: TPopupMenu;
    Inserisci3: TMenuItem;
    Modifica3: TMenuItem;
    Cancella2: TMenuItem;
    PConteggi: TPanel;
    LPasti1: TLabel;
    LPasti2: TLabel;
    LPasti3: TLabel;
    LPasti4: TLabel;
    LPasti5: TLabel;
    LPasti6: TLabel;
    SpStampa: TSpeedButton;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Panel3: TPanel;
    Label19: TLabel;
    Label18: TLabel;
    LblNumPasti: TLabel;
    Regolediconteggio1: TMenuItem;
    GAccessi1: TStringGrid;
    Label6: TLabel;
    GAccessi2: TStringGrid;
    GAccessi3: TStringGrid;
    GAccessi4: TStringGrid;
    GAccessi5: TStringGrid;
    GAccessi6: TStringGrid;
    PopupMenu3: TPopupMenu;
    Aggiungi1: TMenuItem;
    Elimina1: TMenuItem;
    frmSelAnagrafe: TfrmSelAnagrafe;
    N2: TMenuItem;
    Ripristinotimbratureoriginali1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure EMeseChange(Sender: TObject);
    procedure GTimbrat1DrawCell(Sender: TObject; Col, Row: Longint;
      Rect: TRect; State: TGridDrawState);
    procedure BPrecClick(Sender: TObject);
    procedure GestioneTimb(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GTimbrat1Enter(Sender: TObject);
    procedure GTimbrat1Exit(Sender: TObject);
    procedure GTimbrat1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SBConteggiClick(Sender: TObject);
    procedure SpAnomalieClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpStampaClick(Sender: TObject);
    procedure GestisciKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GestisciMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DoppioClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Regolediconteggio1Click(Sender: TObject);
    procedure Aggiungi1Click(Sender: TObject);
    procedure GAccessi1Enter(Sender: TObject);
    procedure Elimina1Click(Sender: TObject);
    procedure GAccessi1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure Ripristinotimbratureoriginali1Click(Sender: TObject);
  private
    { Private declarations }
    Mese,Anno:Word;
    DisegnaGriglie,AbilCont:Boolean;
    HintCausale:String;
    ShowOK:Boolean;
    SB,SN:String;
    procedure PulisciGriglia;
    procedure CaricaMese;
    procedure CaricaGriglie;
    procedure ColoraCella(Griglia:TStringGrid;Rect:TRect;Color:TColor);
    procedure IncorniciaCella(Griglia:TStringGrid;Rect:TRect);
    procedure Calendario(Data:TDateTime;LGiorno:TLabel);
    procedure InsTimbratura(Data:TDateTime;var Day:Byte;Col,MyTag:Byte);
    function CancTimbratura(Data:TDateTime;Day,Col:Byte):boolean;
    function ModTimbratura(Data:TDateTime;Day,Col:Byte):boolean;
    procedure Conteggi(Ind:Byte; Giorno:TDateTime);
    procedure CaricaGrdAccessi(GAccessi:TStringGrid; D:TDateTime);
    procedure CambiaProgressivo;
  public
    { Public declarations }
    DataCorr:TDateTime;
    FGriglie:Array [1..6] of TGriglie;
    LAnomalie:TStringList;  //Contiene la lista delle anomalie riscontrate
    LTimbMensa:TStringList;  //Contiene la lista delle timbrature di mensa
    LTimbPresenza:TStringList;  //Contiene la lista delle timbrature di presenza
    Giorno:Word;
  end;

const
  NomiGiorni: TNomiGiorni = ('Dom','Lun','Mar','Mer','Gio','Ven','Sab');
var
  A047FTimbMensa: TA047FTimbMensa;

procedure OpenA047TimbMensa(Prog:LongInt);

implementation

uses A047UTimbMensaDtM1,A047UGestTimbraMensa, A047UAnomMensa, A047UStampaTimbMensa, A047UDialogStampa,
  A047UStampaGiornaliera, A047UAccessoManuale, A023UCancTimbRiscaricate;

{$R *.DFM}

procedure OpenA047TimbMensa(Prog:LongInt);
begin
  if Prog <= 0 then
  begin
    ShowMessage('Nessun dipendente selezionato!');
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA047TimbMensa') of
    'N':
        begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A047FTimbMensa:=TA047FTimbMensa.Create(nil);
  with A047FTimbMensa do
    try
      C700Progressivo:=Prog;
      A047FTimbMensaDtM1:=TA047FTimbMensaDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A047FTimbMensaDtM1.Free;
      Free;
    end;
end;

procedure TA047FTimbMensa.FormCreate(Sender: TObject);
{Inizializzazioni}
var i:Byte;
begin
  inherited;
  AbilCont:=False;
  HintCausale:='';
  Application.HintPause:=100;
  DisegnaGriglie:=False;
  LAnomalie:=TStringList.Create;
  LTimbMensa:=TStringList.Create;
  LTimbPresenza:=TStringList.Create;
  FGriglie[1].Timbrat:=GTimbrat1;
  FGriglie[1].Accessi:=GAccessi1;
  FGriglie[1].Giustif:=GGiustif1;
  FGriglie[1].Giorno:=LGiorno1;
  FGriglie[1].LPasti:=LPasti1;
  FGriglie[2].Timbrat:=GTimbrat2;
  FGriglie[2].Accessi:=GAccessi2;
  FGriglie[2].Giustif:=GGiustif2;
  FGriglie[2].Giorno:=LGiorno2;
  FGriglie[2].LPasti:=LPasti2;
  FGriglie[3].Timbrat:=GTimbrat3;
  FGriglie[3].Accessi:=GAccessi3;
  FGriglie[3].Giustif:=GGiustif3;
  FGriglie[3].Giorno:=LGiorno3;
  FGriglie[3].LPasti:=LPasti3;
  FGriglie[4].Timbrat:=GTimbrat4;
  FGriglie[4].Accessi:=GAccessi4;
  FGriglie[4].Giustif:=GGiustif4;
  FGriglie[4].Giorno:=LGiorno4;
  FGriglie[4].LPasti:=LPasti4;
  FGriglie[5].Timbrat:=GTimbrat5;
  FGriglie[5].Accessi:=GAccessi5;
  FGriglie[5].Giustif:=GGiustif5;
  FGriglie[5].Giorno:=LGiorno5;
  FGriglie[5].LPasti:=LPasti5;
  FGriglie[6].Timbrat:=GTimbrat6;
  FGriglie[6].Accessi:=GAccessi6;
  FGriglie[6].Giustif:=GGiustif6;
  FGriglie[6].Giorno:=LGiorno6;
  FGriglie[6].LPasti:=LPasti6;
  for i:=1 to 6 do
    FGriglie[i].Timbrat.ColWidths[0]:=40;
  //Inibizioni Read-Only
  Inserisci1.Enabled:=not SolaLettura;
  Modifica1.Enabled:=not SolaLettura;
  Cancella1.Enabled:=not SolaLettura;
  Inserisci3.Enabled:=not SolaLettura;
  Modifica3.Enabled:=not SolaLettura;
  Cancella2.Enabled:=not SolaLettura;
  A047FStampaTimbMensa:=TA047FStampaTimbMensa.Create(nil);
  A047FStampaGiornaliera:=TA047FStampaGiornaliera.Create(nil);
  A047FDialogStampa:=TA047FDialogStampa.Create(nil);
end;

procedure TA047FTimbMensa.FormShow(Sender: TObject);
begin
  DataCorr:=Parametri.DataLavoro;
  DecodeDate(DataCorr,Anno,Mese,Giorno);
  Giorno:=1;
  EMese.Value:=Mese;
  EAnno.Value:=Anno;
  //CaricaMese;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A047FTimbMensaDtM1.A047FTimbMensaMW,SessioneOracle,StatusBar,1,True);
end;

procedure TA047FTimbMensa.EMeseChange(Sender: TObject);
{Carico i dati del mese corrente}
begin
  if Sender = Emese then
  begin
    if EMese.Value <> Mese then
    begin
      Mese:=EMese.Value;
      CaricaMese;
    end;
  end
  else
  begin
    if EAnno.Value <> Anno then
    begin
      Anno:=EAnno.Value;
      CaricaMese;
    end;
  end;
end;

procedure TA047FTimbMensa.BPrecClick(Sender: TObject);
{Scorre avanti/indietro di 6 giorni}
var Scorro:Boolean;
begin
  Scorro:=False;
  if Sender = BPrec then
    if Giorno > 1 then
    begin
    Scorro:=True;
    Giorno:=Giorno - 6;
    end;
  if (Sender = BSucc) then
    if Giorno < (A047FTimbMensaDtM1.A047FTimbMensaMW.MaxGiorni - 5) then
    begin
    Scorro:=True;
    Giorno:=Giorno + 6;
    end;
  if Scorro then CaricaGriglie;
end;

procedure TA047FTimbMensa.CaricaMese;
{Cambio i parametri alle query e carico i vettori Timbrature e Giustificativi
con i dati del mese}
begin
  PulisciGriglia;
  A047FTimbMensaDtM1.A047FTimbMensaMW.caricamese(EAnno.Value,EMese.Value,AbilCont);
  CaricaGriglie;
end;

procedure TA047FTimbMensa.PulisciGriglia;
{Pulisce le griglie quando si scorre o si cambia mese}
var LG,i,j:Byte;
begin
  for LG:=1 to 6 do
  begin
    with FGriglie[LG].Timbrat do
      if FGriglie[LG].Timbrat <> nil then
        for i:=0 to RowCount - 1 do
          for j:=0 to ColCount - 1 do
            Cells[i,j]:='';
    with FGriglie[LG].Giustif do
      if FGriglie[LG].Giustif <> nil then
        for i:=0 to RowCount - 1 do
          for j:=0 to ColCount - 1 do
            Cells[i,j]:='';
    with FGriglie[LG].Accessi do
      if FGriglie[LG].Accessi <> nil then
        for i:=0 to RowCount - 1 do
          for j:=0 to ColCount - 1 do
            Cells[i,j]:='';
  end;
end;

procedure TA047FTimbMensa.CaricaGriglie;
{Carica le 6 griglie con i dati contenuti nei vettori}
var G:Byte;
    Data:TDateTime;
begin
  DisegnaGriglie:=True;
  LAnomalie.Clear;
  for G:=Giorno to Giorno + 5 do
    begin
    if G > A047FTimbMensaDtM1.A047FTimbMensaMW.MaxGiorni then
      begin
      FGriglie[G-Giorno+1].Giorno.ParentColor:=True;
      FGriglie[G-Giorno+1].Giorno.Caption:='';
      FGriglie[G-Giorno+1].Timbrat.ColCount:=2;
      FGriglie[G-Giorno+1].Accessi.ColCount:=1;
      FGriglie[G-Giorno+1].Accessi.Cells[0,0]:='';
      FGriglie[G-Giorno+1].Accessi.Cells[0,1]:='';
      FGriglie[G-Giorno+1].Giustif.ColCount:=2;
      FGriglie[G-Giorno+1].LPasti.Caption:='';
      end
    else
      begin
      Data:=EncodeDate(EAnno.Value,EMese.Value,G);
      Calendario(Data,FGriglie[G-Giorno+1].Giorno);
      FGriglie[G-Giorno+1].Giorno.Caption:=NomiGiorni[DayOfWeek(Data)]+' '+IntToStr(G);
      FGriglie[G-Giorno+1].Timbrat.ColCount:=A047FTimbMensaDtM1.A047FTimbMensaMW.A000FGestioneTimbraGiustMW.FNumTimbrature[G]+2;
      FGriglie[G-Giorno+1].Giustif.ColCount:=A047FTimbMensaDtM1.A047FTimbMensaMW.A000FGestioneTimbraGiustMW.FNumGiustif[G]+1;
      CaricaGrdAccessi(FGriglie[G-Giorno+1].Accessi,Data);
      if AbilCont then
        Conteggi(G-Giorno+1,EncodeDate(EAnno.Value,EMese.Value,G));
      end;
    FGriglie[G-Giorno+1].Timbrat.Repaint;
    FGriglie[G-Giorno+1].Giustif.Repaint;
    end;
end;

procedure TA047FTimbMensa.CaricaGrdAccessi(GAccessi:TStringGrid; D:TDateTime);
var
  i,C,day,num:Integer;
  AccessiMensa: TAccessiMensa;
begin
  C:=GAccessi.Col;
  for i:=0 to GAccessi.ColCount - 1 do
  begin
    GAccessi.Cells[i,0]:='';
    GAccessi.Cells[i,1]:='';
  end;
  GAccessi.ColCount:=1;
  day:=R180Giorno(D);
  num:=A047FTimbMensaDtM1.A047FTimbMensaMW.FNumAccessi[day];
  if num > 0 then
    GAccessi.ColCount:=num + 1;

  for i:=0 to num - 1 do
  begin
    AccessiMensa:=A047FTimbMensaDtM1.A047FTimbMensaMW.FAccessi[day,i + 1];
    GAccessi.Cells[i,0]:=Format('%s=%s',[accessiMensa.PranzoCena,accessiMensa.Accessi.ToString]);
    GAccessi.Cells[i,1]:=Format('%s/%s',[accessiMensa.Causale,accessiMensa.Rilevatore]);
  end;

  if C <= GAccessi.ColCount then
    GAccessi.Col:=C;
end;

procedure TA047FTimbMensa.Calendario(Data:TDateTime;LGiorno:TLabel);
{Cerco le caratteristiche del giorno su Calendario Individ/Tabella
(Festivo/Lavorativo)}
begin
  LGiorno.ParentColor:=True; {Ripristino i colori iniziali}
  LGiorno.ParentFont:=True;
  with A047FTimbMensaDtM1.A047FTimbMensaMW do
    if Q012.Locate('Data',Data,[]) then
      {Calendario del dipendente}
      begin
      if Q012.FieldByName('Festivo').AsString = 'S' then
        LGiorno.Color:=clYellow; {Festivo}
      if Q012.FieldByName('Lavorativo').AsString = 'N' then
        LGiorno.Color:=clLime; {Non lavorativo}
      if (Q012.FieldByName('Festivo').AsString = 'S') and     {Festivo e }
         (Q012.FieldByName('Lavorativo').AsString = 'N') then {non lavorativo}
        LGiorno.Color:=clAqua;
      end
    else
     {Calendario in anagrafico}
      begin
      if not QSCalendario.LocDatoStorico(Data) then exit;
      Q011.Close;
      Q011.SetVariable('Codice',QSCalendario.FieldByName('T430CALENDARIO').AsString);
      Q011.SetVariable('DataInizio',Q012.GetVariable('DataInizio'));
      Q011.SetVariable('DataFine',Q012.GetVariable('DataFine'));
      Q011.Open;
      if Q011.Locate('Data',Data,[]) then
        begin
        if Q011.FieldByName('Festivo').AsString = 'S' then
          LGiorno.Color:=clYellow; {Festivo}
        if Q011.FieldByName('Lavorativo').AsString = 'N' then
          LGiorno.Color:=clLime; {Non lavorativo}
        if (Q011.FieldByName('Festivo').AsString = 'S') and     {Festivo e }
           (Q011.FieldByName('Lavorativo').AsString = 'N') then {non lavorativo}
          LGiorno.Color:=clAqua;
        end;
      end;
    if DayOfWeek(Data) = 1 then {Domenica}
      LGiorno.Font.Color:=clRed;
end;

procedure TA047FTimbMensa.GTimbrat1DrawCell(Sender: TObject; Col,
  Row: Longint; Rect: TRect; State: TGridDrawState);
{Coloro le celle delle timbrature e dei giustificativi}
var Timbrature:Boolean;
    Testo:String;
    Day:Byte;
    Griglia:TStringGrid;
procedure ColoraEU(Verso,Flag:String);
{Verde = Entrate; Azzurro = Uscite}
var Retng:TRect;
begin
  Retng:=Rect;
  Retng.Right:=Retng.Right-Round(Griglia.Canvas.TextWidth('999')*0.85);
  if Verso = 'E' then ColoraCella(Griglia,Retng,clLime)
  else ColoraCella(Griglia,Retng,clAqua);
end;
procedure ColoraTipoG(Tipo:String);
{Tutto Rosso = Intera giornata
 Metà rosso =  1/2 giornata}
var RetGius:TRect;
begin
  RetGius:=Rect;
  if Tipo = 'I' then ColoraCella(Griglia,Rect,clRed);
  if Tipo = 'M' then
    begin
    RetGius.Right:=(RetGius.Right - RetGius.Left) div 2;
    ColoraCella(Griglia,RetGius,clRed);
    end;
end;

function ColoreCausale(Causale:String):TColor;
{Rosso = Assenza; Verde = Presenza; Blu = Giustificativo}
begin
  Result:=clBlack;
  with A047FTimbMensaDtM1.A047FTimbMensaMW do
  begin
    if Q265.Locate('Codice',Causale,[]) then Result:=clRed
    else if Q275.Locate('Codice',Causale,[]) then Result:=clGreen
    else if Q305.Locate('Codice',Causale,[]) then Result:=clBlue;
  end;
end;
begin
  if not DisegnaGriglie then exit;
  Griglia:=Sender as TStringGrid;
  if State = [gdFixed] then
    begin
    if Row = 0 then Testo:='Ora' else Testo:='Causale';
    Griglia.Canvas.Brush.Style:=bsClear;
    Griglia.Canvas.TextRect(Rect,Rect.Left,Rect.Top,Testo);
    exit;
    end;
  if Griglia.Tag > 10 then
    begin
    Timbrature:=False;    {Giustificativi}
    Day:=Giorno+Griglia.Tag-11;  {Il giorno rappresentato dalla griglia}
    if Day <= A047FTimbMensaDtM1.A047FTimbMensaMW.MaxGiorni then
      if A047FTimbMensaDtM1.A047FTimbMensaMW.A000FGestioneTimbraGiustMW.FGiustificativi[Day,Col+1].Causale = '' then exit;
    end
  else
    begin
    Timbrature:=True;     {Timbrature}
    Day:=Giorno+Griglia.Tag-1;  {Il giorno rappresentato dalla griglia}
    if Day <= A047FTimbMensaDtM1.A047FTimbMensaMW.MaxGiorni then
      if A047FTimbMensaDtM1.A047FTimbMensaMW.A000FGestioneTimbraGiustMW.FTimbrature[Day,Col].Ora = null then exit;
    end;
  {Abblenco la cella}
  Griglia.Canvas.Brush.Style:=bsSolid;
  ColoraCella(Griglia,Rect,clWhite);
  with A047FTimbMensaDtM1.A047FTimbMensaMW do
  begin
    if Day > MaxGiorni then exit;
    Case Row of
      0:{Timbrature o Descr.Giustif}
        if Timbrature then
        begin
          if A000FGestioneTimbraGiustMW.FTimbrature[Day,Col].Flag='O' then
            Griglia.Canvas.Font.Color:=clRed
          else
            Griglia.Canvas.Font.Color:=clBlack;
          Testo:=' '+FormatDateTime('hh:mm',A000FGestioneTimbraGiustMW.FTimbrature[Day,Col].Ora);
          if Trim(A000FGestioneTimbraGiustMW.FTimbrature[Day,Col].Rilevatore) <> '' then
            Testo:=Testo+'  '+A000FGestioneTimbraGiustMW.FTimbrature[Day,Col].Rilevatore;
          ColoraEU(A000FGestioneTimbraGiustMW.FTimbrature[Day,Col].Verso,A000FGestioneTimbraGiustMW.FTimbrature[Day,Col].Flag);
        end
        else
        begin
          Griglia.Canvas.Font.Color:=clBlack;
          Testo:=A000FGestioneTimbraGiustMW.FormGiust(Day,Col+1); {Costruisco la descrizione del giustificativo}
          ColoraTipoG(A000FGestioneTimbraGiustMW.FGiustificativi[Day,Col+1].Tipo);
        end;
      1:{Causali}
        if Timbrature then
        begin
          Griglia.Canvas.Font.Color:=ColoreCausale(A000FGestioneTimbraGiustMW.FTimbrature[Day,Col].Causale);
          Testo:=' ' + A000FGestioneTimbraGiustMW.FTimbrature[Day,Col].Causale;
        end
        else
        begin
          Griglia.Canvas.Font.Color:=ColoreCausale(A000FGestioneTimbraGiustMW.FGiustificativi[Day,Col+1].Causale);
          Testo:=' ' + A000FGestioneTimbraGiustMW.FGiustificativi[Day,Col+1].Causale;
        end;
    end;
  end;
  {Scrive il testo nella griglia}
  Griglia.Canvas.Brush.Style:=bsClear;
  Griglia.Canvas.TextRect(Rect,Rect.Left,Rect.Top,Testo);
  Griglia.Canvas.Font.Color:=clGreen;
  if State = [gdSelected..gdFocused] then
    IncorniciaCella(Griglia,Rect);
end;

procedure TA047FTimbMensa.ColoraCella(Griglia:TStringGrid;Rect:TRect;Color:TColor);
{Colora la metà specificata della cella col colore specificato}
begin
  with Griglia.Canvas do
  begin
    Brush.Color:=Color;
    FillRect(Rect);
  end;
end;

procedure TA047FTimbMensa.IncorniciaCella(Griglia:TStringGrid;Rect:TRect);
{Incornicia }
begin
  with Griglia.Canvas do
  begin
    Brush.Style:=bsClear;
    Pen.Color:=clRed;
    Rectangle(Rect.Left+1,Rect.Top+1,Rect.Right-1,Rect.Bottom-1);
  end;
end;

procedure TA047FTimbMensa.GestioneTimb(Sender: TObject);
{Gestione Timbrature/Giustificativi}
var Griglia:TStringGrid;
    Day,Col:Byte;
    //Timbrature:boolean;
    Data:TDateTime;
begin
  if SolaLettura or (C700SelAnagrafe.RecordCount = 0) then
  begin
    ShowOK:=False;
    Exit;
  end
  else
    ShowOK:=True;
  {Mi posiziono sulla griglia corrente e sulla cella corrente}
  if not(ActiveControl is TStringGrid) then exit;
  Griglia:=ActiveControl as TStringGrid;
  if ((Sender as TMenuItem).Tag <=3) and (Griglia.Tag > 10) then exit;
  if ((Sender as TMenuItem).Tag >3) and (Griglia.Tag < 10) then exit;
  Col:=Griglia.Col;
  if Griglia.Tag > 10 then
  begin
    Col:=Col+1;
    Day:=Giorno+Griglia.Tag-11;  {Il giorno rappresentato dalla griglia}
  end
  else
    Day:=Giorno+Griglia.Tag-1;  {Il giorno rappresentato dalla griglia}
  with A047FTimbMensaDtM1.A047FTimbMensaMW do
  begin
    if Day > MaxGiorni then exit;
    Data:=StrToDate(IntToStr(Day)+'/'+IntToStr(EMese.Value)+'/'+IntToStr(EAnno.Value));
    //Norman 23/03/2007
    case (Sender as TMenuItem).Tag of
      1:
        if selDatiBloccati.DatoBloccato(C700Progressivo,R180InizioMese(Data),'T370') then
          raise Exception.Create(selDatiBloccati.MessaggioLog);
      2,3:
      begin
        if selDatiBloccati.DatoBloccato(C700Progressivo,R180InizioMese(Data),'T370') then
          raise Exception.Create(selDatiBloccati.MessaggioLog);
        //Chiamata: 83085
        if not A000FiltroDizionario('OROLOGI DI TIMBRATURA',A000FGestioneTimbraGiustMW.FTimbrature[Day,Col].Rilevatore) then
          raise Exception.Create(A000MSG_ERR_RILEVATORE_DIZIONARIO);
      end;
    end;
  end;
  with A047FTimbMensaDtM1.A047FTimbMensaMW do
    case (Sender as TMenuItem).Tag of
      1:begin
          InsTimbratura(Data,Day,Col,Griglia.Tag);
          Q370.Close;
          Q370.Open;
          //Caratto 01/04/2014 quando inserisco una timbratura spariva la colonan per inserirne una nuova. non ha mai funzionato
          Griglia.ColCount:=A000FGestioneTimbraGiustMW.FNumTimbrature[Day]+2;
          Griglia.Repaint;
        end;
      2:if CancTimbratura(Data,Day,Col) then
        begin
          Q370.Close;
          Q370.Open;
          Griglia.ColCount:=A000FGestioneTimbraGiustMW.FNumTimbrature[Day]+2;
          Griglia.Repaint;
        end;
      3:if ModTimbratura(Data,Day,Col) then
        begin
          Griglia.Repaint;
          Q370.Close;
          Q370.Open;
        end;
    end;
  if AbilCont then
    Conteggi(Griglia.Tag,Data);
end;

procedure TA047FTimbMensa.InsTimbratura(Data:TDateTime;var Day:Byte;Col,MyTag:Byte);
{Inserimento timbratura}
begin
  with A047FTimbMensaDtM1.A047FTimbMensaMW do
  begin
    if A000FGestioneTimbraGiustMW.FNumTimbrature[Day] = MaxTimbrature then exit;
    A000FGestioneTimbraGiustMW.StatoTimb:=stInserimento;
    Col:=A000FGestioneTimbraGiustMW.FNumTimbrature[Day]+1;
  end;
  A047FGestTimbraMensa:=TA047FGestTimbraMensa.Create(Application);
//  with A047FTimbMensaDtM1.A047FTimbMensaMW.Q370,A047FTimbMensaDtM1.A047FTimbMensaMW.A000FGestioneTimbraGiustMW.FTimbrature[Day,Col] do
  try
    A047FGestTimbraMensa.DataT:=Data;
    A047FGestTimbraMensa.LData.Caption:=FormatDateTime('mmmm yyyy',Data);
    A047FGestTimbraMensa.EData.ReadOnly:=False;
    A047FGestTimbraMensa.Day:=Day;
    A047FGestTimbraMensa.Col:=Col;
    A047FGestTimbraMensa.MyTag:=MyTag;
    A047FTimbMensaDtM1.A047FTimbMensaMW.Q370.Append;
    A047FGestTimbraMensa.ShowModal;
  finally
    if A047FTimbMensaDtM1.A047FTimbMensaMW.Q370.State in [dsEdit,dsInsert] then A047FTimbMensaDtM1.A047FTimbMensaMW.Q370.Cancel;
    SessioneOracle.Commit;
    Day:=A047FGestTimbraMensa.Day;
    A047FGestTimbraMensa.Release;
  end;
end;

function TA047FTimbMensa.CancTimbratura(Data:TDateTime;Day,Col:Byte):boolean;
{Cancellazione timbratura}
begin
  Result:=False;
  if Parametri.CancellaTimbrature <> 'S' then Exit;
  with A047FTimbMensaDtM1.A047FTimbMensaMW.Q370, A047FTimbMensaDtM1.A047FTimbMensaMW.A000FGestioneTimbraGiustMW.FTimbrature[Day,Col] do
  begin
    if Ora = null then exit;
    if Locate('Data;Ora;Verso;Flag',VarArrayOf([Data,Ora,Verso,Flag]),[]) then
    begin
      if MessageDlg('Confermi la cancellazione della timbratura?', mtConfirmation, [mbYes,mbNo], 0) = mrNo then exit;
      A047FTimbMensaDtM1.A047FTimbMensaMW.A000FGestioneTimbraGiustMW.EseguiCancellaTimbratura(Day,Col);
      Result:=True;
    end;
  end;
end;

function TA047FTimbMensa.ModTimbratura(Data:TDateTime;Day,Col:Byte):boolean;
{Modifica timbratura}
begin
  Result:=False;
  //with A047FTimbMensaDtM1,A047FTimbMensaDtM1.A047FTimbMensaMW.Q370,A047FTimbMensaDtM1.A047FTimbMensaMW.FTimbrature[Day,Col] do
  with A047FTimbMensaDtM1.A047FTimbMensaMW do
  begin
    if A000FGestioneTimbraGiustMW.FTimbrature[Day,Col].Ora = null then
    begin
      ShowOK:=False;
      Exit;
    end
    else
      ShowOK:=True;

    if not(Q370.Locate('Data;Ora;Verso;Flag',VarArrayOf([Data,A000FGestioneTimbraGiustMW.FTimbrature[Day,Col].Ora,A000FGestioneTimbraGiustMW.FTimbrature[Day,Col].Verso,A000FGestioneTimbraGiustMW.FTimbrature[Day,Col].Flag]),[])) then exit;
    A000FGestioneTimbraGiustMW.StatoTimb:=stModifica;
    Q370.Edit;
    A047FGestTimbraMensa:=TA047FGestTimbraMensa.Create(Application);
    A047FGestTimbraMensa.DataT:=Data;
    A047FGestTimbraMensa.LData.Caption:=FormatDateTime('mmmm yyyy',Data);
    A047FGestTimbraMensa.EData.ReadOnly:=True;
    A047FGestTimbraMensa.Day:=Day;
    A047FGestTimbraMensa.Col:=Col;
    try
      if A047FGestTimbraMensa.ShowModal = mrOk then
      begin
        A000FGestioneTimbraGiustMW.EseguiModificaTimbratura(Data,Day,Col);  //su MW
        Result:=True;
      end;
    finally
      if Q370.State in [dsEdit,dsInsert] then Q370.Cancel;
      A047FGestTimbraMensa.Release;
    end;
  end;
end;

procedure TA047FTimbMensa.GTimbrat1Enter(Sender: TObject);
{Disabilita i menu Timbrature/Giustificativi}
var Ind, Day:Byte;
begin
  if (Sender as TStringGrid).Tag < 10 then
    begin
    Day:=Giorno + (Sender as TStringGrid).Tag - 1;
    Timbrature1.Enabled:=True;
    end
  else
    Day:=Giorno + (Sender as TStringGrid).Tag - 11;
  //Indice dell'Array FGriglie
  Ind:=Day - Giorno + 1;
  if Day > A047FTimbMensaDtM1.A047FTimbMensaMW.MaxGiorni then exit;
  //Richiamo i conteggi
  if AbilCont then
    begin
    LAnomalie.Clear;
    Conteggi(Ind,EncodeDate(EAnno.Value,EMese.Value,Day));
    end;
end;

procedure TA047FTimbMensa.GTimbrat1Exit(Sender: TObject);
{Disabilita i menu Timbrature/Giustificativi}
begin
  if (Sender as TStringGrid).Tag < 10 then
    Timbrature1.Enabled:=False;
end;

procedure TA047FTimbMensa.GTimbrat1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
{Visualizza la descrizione della causale}
var Griglia:TStringGrid;
    Day,Row,Col:LongInt;
    NewCausale:String;
begin
  try
  Griglia:=(Sender as TStringGrid);
  Griglia.MouseToCell(X,Y,Col,Row);
  if Row <> 1 then exit;
  with A047FTimbMensaDtM1.A047FTimbMensaMW.A000FGestioneTimbraGiustMW do
  begin
    if Griglia.Tag > 10 then
    begin
      Day:=Giorno+Griglia.Tag-11;
      if FGiustificativi[Day,Col+1].Causale = '' then exit;
      NewCausale:=FGiustificativi[Day,Col+1].Causale
    end
    else
    begin
      if Col = 0 then exit;
      Day:=Giorno+Griglia.Tag - 1;  {Il giorno rappresentato dalla griglia}
      if FTimbrature[Day,Col].Causale = '' then exit;
      NewCausale:=FTimbrature[Day,Col].Causale
    end;
  end;
  if HintCausale = NewCausale then exit;
  HintCausale:=NewCausale;
  with A047FTimbMensaDtM1.A047FTimbMensaMW do
  begin
    StatusBar.Panels[2].Text:=DescrizioneCausale(NewCausale);
  end;
  Griglia.Hint:=StatusBar.Panels[2].Text;
  except
  NewCausale:='';
  HintCausale:='';
  StatusBar.Panels[2].Text:='';
  end;
end;

procedure TA047FTimbMensa.SBConteggiClick(Sender: TObject);
{Abilita/disabilita i conteggi in tempo reale}
var I,G:Byte;
begin
  with SBConteggi do
    begin
    PConteggi.Visible:=Down;
    LblNumPasti.Visible:=Down;
    if Down then
      begin
      AbilCont:=True;
      for i:=0 to PConteggi.ControlCount - 1 do
        (PConteggi.Controls[i] as TLabel).Caption:=#0;
      Hint:='Conteggi on';
      DisegnaGriglie:=True;
      LAnomalie.Clear;
      //A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.SettaPeriodo(EncodeDate(EAnno.Value,EMese.Value,Giorno),EncodeDate(EAnno.Value,EMese.Value,Giorno) + 5);
      A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.SettaPeriodo(EncodeDate(EAnno.Value,EMese.Value,1),R180FineMese(EncodeDate(EAnno.Value,EMese.Value,1)));
      for G:=Giorno to Giorno + 5 do
        if G > A047FTimbMensaDtM1.A047FTimbMensaMW.MaxGiorni then
          FGriglie[G-Giorno+1].LPasti.Caption:=''
        else
          Conteggi(G-Giorno+1,EncodeDate(EAnno.Value,EMese.Value,G));
      end
    else
      begin
      Hint:='Conteggi off';
      AbilCont:=False;
      end;
    end;
end;

procedure TA047FTimbMensa.Conteggi(Ind:Byte; Giorno:TDateTime);
{Calcola il numero di pasti giornalieri}
{Non tiene conto di Dipendete in malattia,ferie, ecc.}
var S:String;
    i:Integer;
    conteggiPasti:TConteggiPasti;
begin
  with A047FTimbMensaDtM1.A047FTimbMensaMW do
  begin
    conteggiPasti:=ConteggiGiorno(C700Progressivo,Giorno);
    S:=IntToStr(conteggiPasti.PastiCon);
    if conteggiPasti.PastiInt > 0 then
      S:=S + ' - ' + IntToStr(conteggiPasti.PastiInt);
    TLabel(FGriglie[Ind].LPasti).Caption:=S;
    for i:=0 to R300FAccessiMensaDtM.Anomalie.Count - 1 do
      LAnomalie.Add(R300FAccessiMensaDtM.Anomalie[i]);
  end;
end;

procedure TA047FTimbMensa.SpAnomalieClick(Sender: TObject);
begin
  A047FAnomMensa:=TA047FAnomMensa.Create(nil);
  with A047FAnomMensa do
    try
      Memo1.Lines.Clear;
      Memo1.Lines.Assign(LAnomalie);
      ShowModal;
    finally
      Release;
    end;
end;

procedure TA047FTimbMensa.CambiaProgressivo;
begin
  if A047FTimbMensaDtM1.A047FTimbMensaMW.SelAnagrafe = nil then
    Exit;

  if C700OldProgressivo <> C700Progressivo then
    CaricaMese;
end;

procedure TA047FTimbMensa.SpStampaClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  frmSelAnagrafe.OnCambiaProgressivo:=nil;
  A047FDialogStampa.SB:=SB;
  A047FDialogStampa.SN:=SN;
  A047FDialogStampa.DataI:=EncodeDate(Anno,Mese,01);
  A047FDialogStampa.DataF:=EncodeDate(Anno,Mese,R180GiorniMese(A047FDialogStampa.DataI));
  A047FDialogStampa.ShowModal;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.RipristinaC00SelAnagrafe;
end;

procedure TA047FTimbMensa.GestisciKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = vk_Delete)and(Shift=[])then
    begin
      GestioneTimb(Cancella2); // richiamo la procedura generale di gestione timbrature.
                               // In questo caso gestisco Cancellazione.
    end
  else
    if (Key = vk_F2)and(Shift=[]) then
      begin
          GestioneTimb(Modifica3); // richiamo la procedura generale di gestione timbrature.
                                  // In questo caso gestisco MODIFICA.
      end
    else
      if (Key = vk_Return)and(Shift=[]) then
        begin
         GestioneTimb(Inserisci3); // richiamo la procedura generale di gestione timbrature.
                                  // In questo caso gestisco INSERIMENTO.
        end
end;

procedure TA047FTimbMensa.GestisciMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Col,Row,Top,Left,Bottom,Right,I:Integer;
begin
  if Button = mbRight then
    begin
      Col:=TStringGrid(Sender).Col;
      Row:=TStringGrid(Sender).Row;
      Left:=0;
      Right:=0;
      for I:=0 to (TStringGrid(Sender).ColCount-1) do
         begin
           Right:=Right+TStringGrid(Sender).ColWidths[I];
           if (X > Left)and(X<=Right) then
             begin
               Col:=I;
               Break;
             end;
           Left:=Right;
         end;

      Top:=0;
      Bottom:=0;
      for I:=0 to TStringGrid(Sender).RowCount-1 do
         begin
           Bottom:=Bottom+TStringGrid(Sender).RowHeights[I];
           if (Y > Top)and(Y<=Bottom) then
             begin
               Row:=I;
               Break;
             end;
           Top:=Bottom;
         end;
      if (Col > 0)and(Col<>TStringGrid(Sender).Col) then
        TStringGrid(Sender).Col:=Col;
      if (Row<>TStringGrid(Sender).Row) then
        TStringGrid(Sender).Row:=Row;
    end;
end;

procedure TA047FTimbMensa.DoppioClick(Sender: TObject);
var
  Col,Day:Byte;
  Data:TDateTime;
  menuItem: TMenuItem;
begin
  if SolaLettura or (C700SelAnagrafe.RecordCount = 0) then
    exit;
  Col:=TStringGrid(Sender).Col;
  Day:=Giorno+TStringGrid(Sender).Tag-1;  {Il giorno rappresentato dalla griglia}
  if Day > A047FTimbMensaDtM1.A047FTimbMensaMW.MaxGiorni then exit;
  Data:=StrToDate(IntToStr(Day)+'/'+IntToStr(EMese.Value)+'/'+IntToStr(EAnno.Value));
  if A047FTimbMensaDtM1.A047FTimbMensaMW.selDatiBloccati.DatoBloccato(C700Progressivo,R180InizioMese(Data),'T370') then
    raise Exception.Create(A047FTimbMensaDtM1.A047FTimbMensaMW.selDatiBloccati.MessaggioLog);

  if Col <= A047FTimbMensaDtM1.A047FTimbMensaMW.A000FGestioneTimbraGiustMW.FNumTimbrature[Day] then
    menuItem:=Modifica1
  else
    menuItem:=Inserisci1;
  GestioneTimb(menuItem);
  if not ShowOK then
  begin
    InsTimbratura(Data,Day,Col,TStringGrid(Sender).Tag);
    A047FTimbMensaDtM1.A047FTimbMensaMW.Q370.Close;
    A047FTimbMensaDtM1.A047FTimbMensaMW.Q370.Open;
    //Caratto 01/04/2014 quando inserisco una timbratura spariva la colonan per inserirne una nuova. non ha mai funzionato
    TStringGrid(Sender).ColCount:=A047FTimbMensaDtM1.A047FTimbMensaMW.A000FGestioneTimbraGiustMW.FNumTimbrature[Day]+2;
    TStringGrid(Sender).Repaint;
  end;
end;

procedure TA047FTimbMensa.Regolediconteggio1Click(Sender: TObject);
begin
  OpenA046TerMensa;
  A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.Free;
  A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM:=TR300FAccessiMensaDtM.Create(nil);
end;

procedure TA047FTimbMensa.Aggiungi1Click(Sender: TObject);
var NP,Day,Separatore,Separatore2:Integer;
    Caus,PranzoCena,Msg:String;
    Data:TDateTime;
    AccessiMensa: TAccessiMensa;
begin
  if SolaLettura or (C700SelAnagrafe.RecordCount = 0) then exit;
  Day:=Giorno - 1 + PopupMenu3.PopupComponent.Tag;
  if Day > A047FTimbMensaDtM1.A047FTimbMensaMW.MaxGiorni then exit;
  Data:=EncodeDate(EAnno.Value,EMese.Value,Day);
  //Norman 23/03/2007
  with TStringGrid(PopupMenu3.PopupComponent) do
  begin
    Separatore:=Pos('=',Cells[Col,0]);
    NP:=StrToIntDef(Copy(Cells[Col,0],Separatore + 1,9),0) + 1;
    PranzoCena:=Copy(Cells[Col,0],1,Separatore - 1);
    Separatore2:=Pos('/',Cells[Col,1]);
    Caus:=Trim(Copy(Cells[Col,1],1,Separatore2 - 1));
  end;
  if not A047FTimbMensaDtM1.A047FTimbMensaMW.ModificaNumeroAccessi(Data, C700Progressivo,Caus,PranzoCena, NP) then
  begin
    A047FAccessoManuale:=TA047FAccessoManuale.Create(nil);
    try
      A047FAccessoManuale.Causale:='*';
      A047FAccessoManuale.Rilevatore:='';
      A047FAccessoManuale.PranzoCena:='P';
      if A047FAccessoManuale.ShowModal = mrOK then
      begin
        AccessiMensa.Causale:=A047FAccessoManuale.Causale;
        AccessiMensa.PranzoCena:=A047FAccessoManuale.PranzoCena;
        AccessiMensa.Rilevatore:=A047FAccessoManuale.Rilevatore;
        AccessiMensa.Accessi:=NP;
        Msg:=A047FTimbMensaDtM1.A047FTimbMensaMW.NuovoAccessoManuale(C700Progressivo,Data,AccessiMensa);
        if Msg <> '' then
          ShowMessage(Msg);
      end;
    finally
      A047FAccessoManuale.Free;
    end;
  end;
  //Caratto 09/04/2014 Ricarico le griglei per aggiornare anche conteggi. non ha mai funzionato
  //CaricaGrdAccessi(TStringGrid(PopupMenu3.PopupComponent),Data);
  CaricaGriglie;

end;

procedure TA047FTimbMensa.GAccessi1Enter(Sender: TObject);
begin
  Timbrature1.Enabled:=False;
end;

procedure TA047FTimbMensa.Elimina1Click(Sender: TObject);
var NP,Day,Separatore,Separatore2:Integer;
    Caus,PranzoCena:String;
    Data:TDateTime;
begin
  if SolaLettura then exit;
  Day:=Giorno - 1 + PopupMenu3.PopupComponent.Tag;
  if Day > A047FTimbMensaDtM1.A047FTimbMensaMW.MaxGiorni then exit;
  Data:=EncodeDate(EAnno.Value,EMese.Value,Day);
  with TStringGrid(PopupMenu3.PopupComponent) do
  begin
    Separatore:=Pos('=',Cells[Col,0]);
    NP:=StrToIntDef(Copy(Cells[Col,0],Separatore + 1,9),0) - 1;
    PranzoCena:=Copy(Cells[Col,0],1,Separatore - 1);
    Separatore2:=Pos('/',Cells[Col,1]);
    Caus:=Trim(Copy(Cells[Col,1],1,Separatore2 - 1));
  end;
  if Caus = '' then exit;
  A047FTimbMensaDtM1.A047FTimbMensaMW.ModificaNumeroAccessi(Data, C700Progressivo,Caus,PranzoCena, NP);
  //Caratto 09/04/2014 Ricarico le griglei per aggiornare anche conteggi. non ha mai funzionato
  //caricaGrdAccessi(TStringGrid(PopupMenu3.PopupComponent),Data);
  CaricaGriglie;
end;

procedure TA047FTimbMensa.GAccessi1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var Data:TDateTime;
begin
  //Norman 23/03/2007
  Data:=EncodeDate(EAnno.Value,EMese.Value,1);
  if A047FTimbMensaDtM1.A047FTimbMensaMW.selDatiBloccati.DatoBloccato(C700Progressivo,R180InizioMese(Data),'T375') then
    raise Exception.Create(A047FTimbMensaDtM1.A047FTimbMensaMW.selDatiBloccati.MessaggioLog);
  if Key = VK_ADD then
  begin
    PopupMenu3.PopupComponent:=TComponent(Sender);
    Aggiungi1Click(nil);
  end
  else if Key = VK_SUBTRACT then
  begin
    PopupMenu3.PopupComponent:=TComponent(Sender);
    Elimina1Click(nil);
  end;
end;

procedure TA047FTimbMensa.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  try
    C005DataVisualizzazione:=EncodeDate(EAnno.Value,EMese.Value,Giorno);
  except
    C005DataVisualizzazione:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA047FTimbMensa.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  try
    C700DataLavoro:=EncodeDate(EAnno.Value,EMese.Value,Giorno);
  except
    C700Datalavoro:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA047FTimbMensa.FormClose(Sender: TObject;
  var Action: TCloseAction);
{Chiude storici e conteggi }
begin
  LAnomalie.Free;
  LTimbMensa.Free;
  LTimbPresenza.Free;
end;

procedure TA047FTimbMensa.FormDestroy(Sender: TObject);
begin
  FreeAndNil(A047FStampaTimbMensa);
  FreeAndNil(A047FStampaGiornaliera);
  FreeAndNil(A047FDialogStampa);
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA047FTimbMensa.Ripristinotimbratureoriginali1Click(
  Sender: TObject);
{Ripristino timbrature originali nel periodo specificato}
var Day:Word;
begin
  if A047FTimbMensaDtM1.A047FTimbMensaMW.selDatiBloccati.DatoBloccato(C700Progressivo,EncodeDate(EAnno.Value,EMese.Value,1),'T370') then
    raise Exception.Create(A047FTimbMensaDtM1.A047FTimbMensaMW.selDatiBloccati.MessaggioLog);
  if ActiveControl is TStringGrid then
  begin
    Day:=(ActiveControl as TStringGrid).Tag;
    if Day > 10 then
      Dec(Day,10);
    Day:=Day + Giorno - 1;
  end
  else
    Day:=Giorno;
  //Finestra di dialogo per richiesta periodo
  A023FCancTimbRiscaricate:=TA023FCancTimbRiscaricate.Create(nil);
  with A023FCancTimbRiscaricate do
    try
      Caption:='Ripristino timbrature originali';
      chkTuttiDipendenti.Visible:=False;
      DataInizio:=EncodeDate(EAnno.Value,EMese.Value,Day);
      DataFine:=DataInizio;
      LblDaData.Caption:=FormatDateTime('mmmm yyyy',DataInizio);
      SBDaGG.MaxValue:=R180GiorniMese(DataInizio);
      SBAGG.MaxValue:=R180GiorniMese(DataInizio);
      SBDaGG.Value:=Day;
      SBAGG.Value:=Day;
      if ShowModal = mrOK then
      begin
        Screen.Cursor:=crHourGlass;
        A047FTimbMensaDtM1.A047FTimbMensaMW.EliminaTimbratureRiscaricate(C700Progressivo ,DataInizio, DataFine);
        CaricaMese;
      end;
    finally
      Screen.Cursor:=crDefault;
      Release;
    end;
end;

end.

