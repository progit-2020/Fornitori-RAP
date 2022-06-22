unit R600UVisAssenze;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Math, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids, Buttons, Variants, C180FunzioniGenerali, Menus,
  R600, System.StrUtils;

type

  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  TDatiVis = record
    pnlTop: Boolean;
    Label9: Boolean;
    LPeriodiRapporto: Boolean;
    Label6: Boolean;
    LCompArrotondata: Boolean;
    Label8: Boolean;
    LCompSoloFerie: Boolean;
    Label13: Boolean;
    LPartTime: Boolean;
    Label15: Boolean;
    LAbilAnagr: Boolean;
    Label10: Boolean;
    LDecurtazione: Boolean;
    pnlCumuloF: Boolean;
    pnlCodIntA: Boolean;
    pnlCompFinali: Boolean;
  end;

  TR600FVisAssenze = class(TForm)
    Grid1: TStringGrid;
    Panel2: TPanel;
    LNome: TLabel;
    LMatricola: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    Label1: TLabel;
    LCausale: TLabel;
    BitBtn1: TBitBtn;
    Label7: TLabel;
    lblPeriodoCumulo: TLabel;
    lblFamRif: TLabel;
    lblDataFamRif: TLabel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    StampaVideata1: TMenuItem;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Label3: TLabel;
    lblNumeroFruizioni: TLabel;
    btnAssCumulate: TBitBtn;
    btnPeriodiCumulati: TBitBtn;
    btnCambiaFineCumulo: TBitBtn;
    GroupBox1: TGroupBox;
    lblPartTime: TLabel;
    LFruizMinima: TLabel;
    lblFruizMinimaTitolo: TLabel;
    memoPartTime: TMemo;
    pnlLeft: TPanel;
    pnlTop: TPanel;
    Label2: TLabel;
    Label9: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label10: TLabel;
    LDecurtazione: TLabel;
    LAbilAnagr: TLabel;
    LPartTime: TLabel;
    LCompSoloFerie: TLabel;
    LCompArrotondata: TLabel;
    LPeriodiRapporto: TLabel;
    LCompTotale: TLabel;
    pnlCumuloF: TPanel;
    lblDescFruizMMInteri: TLabel;
    lblFruizMMInteri: TLabel;
    lblDescMaxIndividuale: TLabel;
    lblMaxIndividuale: TLabel;
    lblDescFruizMMContinuativi: TLabel;
    lblFruizMMContinuativi: TLabel;
    pnlCompFinali: TPanel;
    LCompFinale: TLabel;
    Label12: TLabel;
    lblDescGGNoLavVuoti: TLabel;
    lblGGNoLavVuoti: TLabel;
    pnlCodIntA: TPanel;
    lblFestePartic: TLabel;
    lblDescFestePartic: TLabel;
    btnRiepIndividuale: TBitBtn;
    procedure StampaVideata1Click(Sender: TObject);
    procedure Grid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure btnAssCumulateClick(Sender: TObject);
    procedure btnPeriodiCumulatiClick(Sender: TObject);
    procedure btnCambiaFineCumuloClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnRiepIndividualeClick(Sender: TObject);
  private
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
    DatiVis: TDatiVis;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
  public
    UnitaMisura,CodInt: String;
    TCumulo: Char;
    SwitchFineCumulo: Boolean;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
    R600DM: TR600DtM1;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
  end;

var
  R600FVisAssenze: TR600FVisAssenze;

implementation

uses R600UVisAssenzeCumulate;

{$R *.DFM}

procedure TR600FVisAssenze.btnCambiaFineCumuloClick(Sender: TObject);
begin
  SwitchFineCumulo:=True;
  Close;
end;

// TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
procedure TR600FVisAssenze.btnRiepIndividualeClick(Sender: TObject);
var
  r: Integer;
  LRiepIndividuale: Boolean;
  LRiepAss: TRiepilogoAssenze;
begin
  // determina il caso di riepilogo individuale / complessivo
  LRiepIndividuale:=btnRiepIndividuale.Tag = 0;

  try
    R600DM.SwitchRiepilogoConiuge(LRiepIndividuale,LRiepAss);
  except
    on E:Exception do
    begin
      // segnala errore e chiude la finestra di visualizzazione
      R180MessageBox(Format('Si è verificato un errore durante la visualizzazione del riepilogo individuale:'#13#10'%s',[E.Message]),ESCLAMA);
      ModalResult:=mrOk;
    end;
  end;

  // dati di variazione delle competenze
  LCompFinale.Caption:=LRiepAss.CompFinale;

  pnlTop.Visible:=(DatiVis.pnlTop) and (not LRiepIndividuale);
  Label9.Visible:=(DatiVis.Label9) and (not LRiepIndividuale);
  LPeriodiRapporto.Visible:=(DatiVis.LPeriodiRapporto) and (not LRiepIndividuale);
  Label6.Visible:=(DatiVis.Label6) and (not LRiepIndividuale);
  LCompArrotondata.Visible:=(DatiVis.LCompArrotondata) and (not LRiepIndividuale);
  Label8.Visible:=(DatiVis.Label8) and (not LRiepIndividuale);
  LCompSoloFerie.Visible:=(DatiVis.LCompSoloFerie) and (not LRiepIndividuale);
  Label13.Visible:=(DatiVis.Label13) and (not LRiepIndividuale);
  LPartTime.Visible:=(DatiVis.LPartTime) and (not LRiepIndividuale);
  Label15.Visible:=(DatiVis.Label15) and (not LRiepIndividuale);
  LAbilAnagr.Visible:=(DatiVis.LAbilAnagr) and (not LRiepIndividuale);
  Label10.Visible:=(DatiVis.Label10) and (not LRiepIndividuale);
  LDecurtazione.Visible:=(DatiVis.LDecurtazione) and (not LRiepIndividuale);
  // altri pannelli
  pnlCumuloF.Visible:=(DatiVis.pnlCumuloF) and (not LRiepIndividuale);
  pnlCodIntA.Visible:=(DatiVis.pnlCodIntA) and (not LRiepIndividuale);
  pnlCompFinali.Visible:=DatiVis.pnlCompFinali;

  // è necessario reimpostare l'ordine dei pannelli dall'alto
  // in quanto modificando la visibilità degli stessi non è più garantito
  if LRiepIndividuale then
    pnlCompFinali.Align:=alBottom
  else
    pnlCompFinali.Align:=alTop;
  DisableAlign;
  pnlTop.Top:=0;
  pnlCumuloF.Top:=pnlTop.Top + pnlTop.Height;
  pnlCodIntA.Top:=pnlCumuloF.Top + pnlCumuloF.Height;
  pnlCompFinali.Top:=pnlCodIntA.Top + pnlCodIntA.Height;
  EnableAlign;

  // tabella
  // dati della fascia 1
  // warning se il residuo individuale è maggiore di quello complessivo
  r:=1;
  Grid1.Cells[r,2]:=LRiepAss.CC;
  Grid1.Cells[r,4]:=LRiepAss.FC;
  Grid1.Cells[r,6]:=LRiepAss.RC;
  // totali (c'è solo la fascia 1)
  r:=7;
  Grid1.Cells[r,2]:=LRiepAss.CC;
  Grid1.Cells[r,4]:=LRiepAss.FC;
  Grid1.Cells[r,6]:=LRiepAss.RC;

  // modifica titolo form e caption del pulsante
  Self.Caption:=Format('<R600> Prospetto assenze%s',[IfThen(LRiepIndividuale,' (individuali)')]);
  btnRiepIndividuale.Caption:=IfThen(btnRiepIndividuale.Tag = 0,'Riepilogo complessivo','Riepilogo individuale');
  btnRiepIndividuale.Tag:=IfThen(btnRiepIndividuale.Tag = 0,1,0);
end;
// TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine

procedure TR600FVisAssenze.FormShow(Sender: TObject);
begin
  SwitchFineCumulo:=False;

  // visibilità informazioni per tipo cumulo "F"
  pnlCumuloF.Visible:=TCumulo = 'F';
  Height:=Height - IfThen(pnlCumuloF.Visible,0,pnlCumuloF.Height);

  // visibilità informazioni per codice interno "A" (ferie/congedo ordinario)
  pnlCodIntA.Visible:=CodInt = 'A';
  Height:=Height - IfThen(pnlCodIntA.Visible,0,pnlCodIntA.Height);

  with Grid1 do
  begin
    ColWidths[0]:=127;
    if UnitaMisura = 'G' then
      Cells[0,0]:='U.M.: Giorni'
    else
      Cells[0,0]:='U.M.: Ore';
    Cells[1,0]:='1°fascia';
    Cells[2,0]:='2°fascia';
    Cells[3,0]:='3°fascia';
    Cells[4,0]:='4°fascia';
    Cells[5,0]:='5°fascia';
    Cells[6,0]:='6°fascia';
    Cells[7,0]:='Totali';
    Cells[8,0]:='Totali(G)';
    Cells[0,1]:='Comp. precedente';
    Cells[0,2]:='Comp. corrente';
    Cells[0,3]:='Fruito precedente';
    Cells[0,4]:='Fruito corrente';
    Cells[0,5]:='Residuo precedente';   //Lorena 29/12/2005
    Cells[0,6]:='Residuo corrente';     //Lorena 29/12/2005
    Cells[0,7]:='Residuo totale';       //Lorena 29/12/2005
    Cells[0,8]:='Comp. parziali';
    Cells[0,9]:='Residuo parziale';
  end;

  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  // salva visibilità pannelli e label
  DatiVis.pnlTop:=pnlTop.Visible;
  DatiVis.Label9:=Label9.Visible;
  DatiVis.LPeriodiRapporto:=LPeriodiRapporto.Visible;
  DatiVis.Label6:=Label6.Visible;
  DatiVis.LCompArrotondata:=LCompArrotondata.Visible;
  DatiVis.Label8:=Label8.Visible;
  DatiVis.LCompSoloFerie:=LCompSoloFerie.Visible;
  DatiVis.Label13:=Label13.Visible;
  DatiVis.LPartTime:=LPartTime.Visible;
  DatiVis.Label15:=Label15.Visible;
  DatiVis.LAbilAnagr:=LAbilAnagr.Visible;
  DatiVis.Label10:=Label10.Visible;
  DatiVis.LDecurtazione:=LDecurtazione.Visible;
  DatiVis.pnlCumuloF:=pnlCumuloF.Visible;
  DatiVis.pnlCodIntA:=pnlCodIntA.Visible;
  DatiVis.pnlCompFinali:=pnlCompFinali.Visible;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
end;

procedure TR600FVisAssenze.btnAssCumulateClick(Sender: TObject);
// TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
var
  r, i, LWidth: Integer;
  LRiepIndividuale, LVisibile: Boolean;
// TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
begin
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  LRiepIndividuale:=btnRiepIndividuale.Tag = 1;
  R600FVisAssenzeCumulate.Caption:=Format('<R600> Assenze cumulate%s',
                                          [IfThen(LRiepIndividuale,' (individuali)')]);

  // nel caso di riepilogo individuale nasconde alcune colonne
  LWidth:=IfThen(LRiepIndividuale,-1,R600FVisAssenzeCumulate.StringGrid1.DefaultColWidth);
  for i in [6] do
    R600FVisAssenzeCumulate.StringGrid1.ColWidths[i]:=LWidth;

  // visualizza le righe in base al riepilogo individuale / collettivo
  // la riga dei totali (l'ultima) rimane invariata
  i:=1;
  for r:=1 to R600FVisAssenzeCumulate.StringGrid1.RowCount - 2 do
  begin
    LVisibile:=(not LRiepIndividuale) or (R600FVisAssenzeCumulate.StringGrid1.Cells[6,r] = '');
    R600FVisAssenzeCumulate.StringGrid1.RowHeights[r]:=IfThen(LVisibile,R600FVisAssenzeCumulate.StringGrid1.DefaultRowHeight,-1);
    R600FVisAssenzeCumulate.StringGrid1.Cells[0,r]:=IntToStr(i);
    if LVisibile then
      i:=i + 1;
  end;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
  R600FVisAssenzeCumulate.Show;
end;

procedure TR600FVisAssenze.btnPeriodiCumulatiClick(Sender: TObject);
// TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
var
  LRiepIndividuale, LVisibile: Boolean;
  r, i, LWidth: Integer;
// TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
begin
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  LRiepIndividuale:=btnRiepIndividuale.Tag = 1;
  R600FVisPeriodiCumulati.Caption:=Format('<R600> Periodi cumulati%s',
                                          [IfThen(LRiepIndividuale,' (individuali)')]);

  // nel caso di riepilogo individuale nasconde alcune colonne
  LWidth:=IfThen(LRiepIndividuale,-1,R600FVisPeriodiCumulati.StringGrid1.DefaultColWidth);
  for i in [4,6,7] do
    R600FVisPeriodiCumulati.StringGrid1.ColWidths[i]:=LWidth;

  // visualizza le righe in base al riepilogo individuale / collettivo
  i:=1;
  for r:=1 to R600FVisPeriodiCumulati.StringGrid1.RowCount - 1 do
  begin
    LVisibile:=(not LRiepIndividuale) or (R600FVisPeriodiCumulati.StringGrid1.Cells[4,r] = '');
    R600FVisPeriodiCumulati.StringGrid1.RowHeights[r]:=IfThen(LVisibile,R600FVisPeriodiCumulati.StringGrid1.DefaultRowHeight,-1);
    R600FVisPeriodiCumulati.StringGrid1.Cells[0,r]:=IntToStr(i);
    if LVisibile then
      i:=i + 1;
  end;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
  R600FVisPeriodiCumulati.Show;
end;

procedure TR600FVisAssenze.Grid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var s,s1,s2: String;
    L,p1,p2: Integer;
begin
  //Se Fruito A.C. < Fruiz.Anno Minima allora coloro in blu la riga del Fruito A.C.
  if ARow = 4 then  //Riga Fruito A.C.
  begin
    if Pos('.',LFruizMinima.Caption) > 0 then  //Ore
    begin
      if R180OreMinutiExt(Grid1.Cells[7,4]) < R180OreMinutiExt(LFruizMinima.Caption) then
      begin
        s:=Grid1.Cells[ACol,ARow];
        Grid1.Canvas.Font.Color:=clBlue;
        Grid1.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
      end;
    end
    else  //Giorni
    begin
      if StrToFloatDef(Grid1.Cells[7,4],0) < StrToFloatDef(LFruizMinima.Caption,0) then
      begin
        s:=Grid1.Cells[ACol,ARow];
        Grid1.Canvas.Font.Color:=clBlue;
        Grid1.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
      end;
    end;
  end;
  //Se Negativo allora coloro in rosso la cella
  if Pos('-',Grid1.Cells[ACol,ARow]) > 0 then
  begin
    s:=Grid1.Cells[ACol,ARow];
    Grid1.Canvas.Font.Color:=clRed;
    Grid1.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
  end;

  // evidenzia in rosso il testo (%d res.compl.)
  if (ARow = 6) and (ACol = 1) then
  begin
    s:=Grid1.Cells[ACol,ARow];
    if Pos('res.compl.)',s) > 0 then
    begin
      p1:=Pos('(',s);
      p2:=Pos(')',s);

      // res. individuale (colore normale)
      L:=Rect.Left + 2;
      s1:=s.Substring(0,p1 - 1);
      Grid1.Canvas.Font.Color:=clBlack;
      Grid1.Canvas.TextOut(L,Rect.Top + 3,s1);

      // res. complessivo (colore rosso)
      L:=L + Grid1.Canvas.TextWidth(S1);
      s2:=s.Substring(p1 - 1);
      Grid1.Canvas.Font.Color:=clRed;
      Grid1.Canvas.TextOut(L,Rect.Top + 3,s2);
    end;
  end;
end;

procedure TR600FVisAssenze.StampaVideata1Click(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    Self.Print;
end;

end.
