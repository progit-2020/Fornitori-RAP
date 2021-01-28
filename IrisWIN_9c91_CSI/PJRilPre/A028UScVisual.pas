unit A028UScVisual;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, StrUtils, ComCtrls, Grids,  C180FunzioniGenerali, Variants,
  DB, DBGrids, DBClient, ExtCtrls, Menus, R500Lin;

type
  TA028FSCVisual = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    LAnomalia1: TLabel;
    LNumTimb: TLabel;
    GNumTimb: TStringGrid;
    LNumGiusDaA: TLabel;
    GGiusDaA: TStringGrid;
    LNumGiusOre: TLabel;
    GGiusNumOre: TStringGrid;
    LMezzaAss: TLabel;
    LGiorniAss: TLabel;
    LValGiornoAss: TLabel;
    LNumTimbNom: TLabel;
    GTimbNom: TStringGrid;
    GEntrate: TStringGrid;
    LEntrate: TLabel;
    GUscite: TStringGrid;
    LUscite: TLabel;
    TabSheet4: TTabSheet;
    GAnomalie2: TStringGrid;
    GAnomalie3: TStringGrid;
    LMGCaus: TLabel;
    LGGCaus: TLabel;
    GAssenze: TStringGrid;
    GPresenze: TStringGrid;
    LFasce: TLabel;
    GFasce: TStringGrid;
    grdTimbratureCon: TStringGrid;
    Label4: TLabel;
    TabSheet5: TTabSheet;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    GTimbMensa: TStringGrid;
    GFascePaghe: TStringGrid;
    grdRilevatori: TStringGrid;
    grdGettoni: TStringGrid;
    grdStaccoMensa: TStringGrid;
    ppMnu: TPopupMenu;
    Cerca1: TMenuItem;
    pnlHeadAnomalie3: TPanel;
    splAnomalie2: TSplitter;
    pnlHeadAnomalie2: TPanel;
    splAnomalie3: TSplitter;
    pnlHeadPresenze: TPanel;
    splPresenze: TSplitter;
    pnlHeadAssenze: TPanel;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Cerca1Click(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    RicVal:String;
    procedure x000a;
    procedure x000b;
    procedure x000c;
    procedure x000d;
    procedure x000e;
    procedure RicercaValore(InRicerca:String);
  public
    { Public declarations }
  end;

var
  A028FSCVisual: TA028FSCVisual;

implementation

uses A028USc;

{$R *.DFM}

procedure TA028FSCVisual.RicercaValore(InRicerca:String);
begin
  if Trim(InRicerca) = '' then
    Exit;
  while Not(A028FSc.A028FScMW.cdsConteggi.Eof) and (pos(LowerCase(InRicerca),
                                      LowerCase(DBGrid1.SelectedField.AsString)) <= 0) do
    A028FSc.A028FScMW.cdsConteggi.Next;
  if A028FSc.A028FScMW.cdsConteggi.Eof and (pos(LowerCase(InRicerca),
                              LowerCase(DBGrid1.SelectedField.AsString)) <= 0) then
  begin
    R180MessageBox('La ricerca non ha prodotto risultati per il valore "' + RicVal + '".',ESCLAMA);
    A028FSc.A028FScMW.cdsConteggi.First;
  end;
end;

procedure TA028FSCVisual.Cerca1Click(Sender: TObject);
begin
  if InputQuery('Cerca','Ricerca per "' + DBGrid1.SelectedField.FieldName + '"',RicVal) then
  begin
    A028FSc.A028FScMW.cdsConteggi.First;
    RicercaValore(RicVal);
  end;
end;

procedure TA028FSCVisual.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if pos('*** ', A028FSc.A028FScMW.cdsConteggi.FieldByName('DATO').AsString ) > 0 then
  begin
    if gdSelected in State then
      TDBGrid(Sender).Canvas.Font.Color:=clBlack;
    TDBGrid(Sender).Canvas.Brush.Color:=clAqua;
    TDBGrid(Sender).defaultdrawcolumncell(rect,datacol,column,state);
  end;
end;

procedure TA028FSCVisual.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 114 then
  begin
    if Not A028FSc.A028FScMW.cdsConteggi.Eof then
      A028FSc.A028FScMW.cdsConteggi.Next;
    RicercaValore(RicVal);
  end;
end;

procedure TA028FSCVisual.FormShow(Sender: TObject);
begin
  DBGrid1.DataSource:=A028FSc.A028FScMW.dsrConteggi;
  A028FSc.A028FScMW.InzializzaCdsConteggi;
  x000a;
  x000b;
  x000c;
  x000d;
  x000e;
  A028FSc.A028FScMW.cdsConteggi.First;
end;

procedure TA028FSCVisual.x000a;
var i:Byte;
begin
  with A028FSC.A028FScMW do
  begin
    Caption:='Data conteggio:' + DateToStr(R502ProDtM1.DataCon);
    LAnomalia1.Caption:=GetAnomalia;
    LAnomalia1.Visible:=LAnomalia1.Caption <> '';

    LNumTimb.Caption:='Timbrature dip:     ' + IntToStr(R502ProDtM1.n_timbrdip);
    GNumTimb.ColCount:=R502ProDtM1.n_timbrdip;
    for i:=1 to R502ProDtM1.n_timbrdip do
    begin
      GNumTimb.Cells[i - 1,0]:=R180MinutiOre(R502ProDtM1.ttimbraturedip[i].tminutid_e);
      GNumTimb.Cells[i - 1,1]:=R180MinutiOre(R502ProDtM1.ttimbraturedip[i].tminutid_u);
      GNumTimb.Cells[i - 1,2]:=IntToStr(R502ProDtM1.ttimbraturedip[i].tpuntnomin);
    end;
    //_________
    grdTimbratureCon.ColCount:=R502ProDtM1.n_timbrcon;
    for i:=1 to R502ProDtM1.n_timbrcon do
    begin
      grdTimbratureCon.Cells[i - 1,0]:=R180MinutiOre(R502ProDtM1.ttimbraturecon[i].tminutic_e);
      grdTimbratureCon.Cells[i - 1,1]:=R180MinutiOre(R502ProDtM1.ttimbraturecon[i].tminutic_u);
      grdTimbratureCon.Cells[i - 1,2]:=IntToStr(R502ProDtM1.ttimbraturecon[i].tpuntatore);
      if R502ProDtM1.ttimbraturecon[i].tinclcaus <> #0 then
        grdTimbratureCon.Cells[i - 1,2]:=grdTimbratureCon.Cells[i - 1,2] + '(' + R502ProDtM1.ttimbraturecon[i].tinclcaus + ')';
    end;
    //_________
    LNumTimbNom.Caption:='Timbrature nominali: '  + IntToStr(R502ProDtM1.n_timbrnom);
    GTimbNom.ColCount:=R502ProDtM1.n_timbrnom;
    for i:=1 to R502ProDtM1.n_timbrnom do
    begin
      GTimbNom.Cells[i - 1,0]:=R180MinutiOre(R502ProDtM1.TTimbratureNom[i].tminutin_e);
      GTimbNom.Cells[i - 1,1]:=IntToStr(R502ProDtM1.TTimbratureNom[i].tpuntre);
      GTimbNom.Cells[i - 1,2]:=R180MinutiOre(R502ProDtM1.TTimbratureNom[i].tminutin_u);
      GTimbNom.Cells[i - 1,3]:=IntToStr(R502ProDtM1.TTimbratureNom[i].tpuntru);
    end;
    //_________
    LNumGiusDaA.Caption:='Giust. da - a: ' + IntToStr(R502ProDtM1.n_giusdaa);
    GGiusDaA.ColCount:=R502ProDtM1.n_giusdaa;
    for i:=1 to R502ProDtM1.n_giusdaa do
    begin
      GGiusDaA.Cells[i - 1,0]:=R180MinutiOre(R502ProDtM1.tgius_dallealle[i].tminutida);
      GGiusDaA.Cells[i - 1,1]:=R180MinutiOre(R502ProDtM1.tgius_dallealle[i].tminutia);
      GGiusDaA.Cells[i - 1,2]:=R502ProDtM1.tgius_dallealle[i].tcausdaa;
    end;
    //_________
    LNumGiusOre.Caption:='Giust. num. ore: ' + IntToStr(R502ProDtM1.n_giusore);
    GGiusNumOre.ColCount:=R502ProDtM1.n_giusore;
    for i:=1 to R502ProDtM1.n_giusore do
    begin
      GGiusNumOre.Cells[i - 1,0]:=R180MinutiOre(R502ProDtM1.tgius_min[i].tmin);
      GGiusNumOre.Cells[i - 1,1]:=R502ProDtM1.tgius_min[i].tcausore;
    end;
    //_________
    LMezzaAss.Caption:='Mezza gg assenza: ' + IntToStr(R502ProDtM1.n_giusmga);
    LMGCaus.Caption:=getCausMgAss;
    LGiorniAss.Caption:='gg assenza: ' + IntToStr(R502ProDtM1.n_giusgga);
    LGGCaus.Caption:=getCausGGAss;
    //Caratto 25/09/2013 Resettare? LValGiornoAss.Caption:=''
    LValGiornoAss.Caption:='';
    if (R502ProDtM1.n_giusmga > 0) or (R502ProDtM1.n_giusgga > 0) then
      LValGiornoAss.Caption:='Val. gg assenza: ' + R180MinutiOre(R502ProDtM1.valggass);
    //_________
    LFasce.Caption:=GetDescFasce;

    GFasce.Cells[0,0]:='Codice';
    GFasce.Cells[1,0]:='%';
    GFasce.Cells[2,0]:='Dalle';
    GFasce.Cells[3,0]:='Alle';
    GFasce.Cells[5,0]:='Ore lav.';
    GFasce.Cells[6,0]:='Ore str.';
    GFasce.RowCount:=R502ProDtM1.n_fasce + 1;
    for i:=1 to R502ProDtM1.n_fasce do
    begin
      GFasce.Cells[0,i]:=R502ProDtM1.tfasceorarie[i].tcodfasc;
      GFasce.Cells[1,i]:=IntToStr(R502ProDtM1.tfasceorarie[i].tpercfasc);
      GFasce.Cells[2,i]:=R180MinutiOre(R502ProDtM1.tfasceorarie[i].tiniz1fasc) + '-' + R180MinutiOre(R502ProDtM1.tfasceorarie[i].tfine1fasc);
      GFasce.Cells[3,i]:=R180MinutiOre(R502ProDtM1.tfasceorarie[i].tiniz2fasc) + '-' + R180MinutiOre(R502ProDtM1.tfasceorarie[i].tfine2fasc);
      GFasce.Cells[4,i]:='(' + IntToStr(R502ProDtM1.tfasceorarie[i].ttipofasc) + ')';
      GFasce.Cells[5,i]:=R180MinutiOre(R502ProDtM1.tminlav[i]);
      GFasce.Cells[6,i]:=R180MinutiOre(R502ProDtM1.tminstrgio[i]);
    end;
  end;
end;
//________________________________________________________________
procedure TA028FSCVisual.x000b;
var i:Byte;
begin
  with A028FSC.A028FScMW.R502ProDtM1 do
    begin
    LEntrate.Caption:='___ ENTRATE complete dipendente ___' + IntToStr(n_timbrdip);
    GEntrate.Cells[0,0]:='hhmm';
    GEntrate.Cells[0,1]:='Rilevatore';
    GEntrate.Cells[0,2]:='Causale';
    GEntrate.Cells[0,3]:='Tipo/Raggrupp.';
    GEntrate.Cells[0,4]:='Cont./Ripart. ';
    GEntrate.Cells[0,5]:='Incl./Riepil. ';
    GEntrate.Cells[0,6]:='Arrotondamento';
    GEntrate.Cells[0,7]:='Minuti in piu'' ';
    GEntrate.Cells[0,8]:='Abilitazione  ';
    GEntrate.Cells[0,9]:='Arrotondata   ';
    LUscite.Caption:='___ USCITE complete dipendente ___';
    GUscite.Cells[0,0]:='hhmm';
    GUscite.Cells[0,1]:='Rilevatore';
    GUscite.Cells[0,2]:='Causale';
    GUscite.Cells[0,3]:='Tipo/Raggrupp.';
    GUscite.Cells[0,4]:='Cont./Ripart. ';
    GUscite.Cells[0,5]:='Incl./Riepil. ';
    GUscite.Cells[0,6]:='Arrotondamento';
    GUscite.Cells[0,7]:='Minuti in piu'' ';
    GUscite.Cells[0,8]:='Abilitazione  ';
    GUscite.Cells[0,9]:='Arrotondata   ';
    GEntrate.ColCount:=n_timbrdip + 1;
    GUscite.ColCount:=n_timbrdip + 1;
    for i:=1 to n_timbrdip do
      with TTimbratureDip[i] do
      begin
        GEntrate.Cells[i,0]:=R180MinutiOre(tminutid_e);
        GEntrate.Cells[i,1]:=trilev_e;
        GEntrate.Cells[i,2]:=tcausale_e.tcaus;
        GEntrate.Cells[i,3]:=tcausale_e.tcaustip + ' ' + tcausale_e.tcausrag;
        GEntrate.Cells[i,4]:=tcausale_e.tcauscon + ' ' + tcausale_e.tcausrip;
        GEntrate.Cells[i,5]:=tcausale_e.tcausioe + ' ' + tcausale_e.tcausrpl;
        GEntrate.Cells[i,6]:=IntToStr(tcausale_e.tcausarr);
        GEntrate.Cells[i,7]:=R180MinutiOre(tcausale_e.tcauspiu);
        GEntrate.Cells[i,8]:=tcausale_e.tcausabi;
        GEntrate.Cells[i,9]:=tflagarr_e;
        GUscite.Cells[i,0]:=R180MinutiOre(tminutid_u);
        GUscite.Cells[i,1]:=trilev_u;
        GUscite.Cells[i,2]:=tcausale_u.tcaus;
        GUscite.Cells[i,3]:=tcausale_u.tcaustip + ' ' + tcausale_u.tcausrag;
        GUscite.Cells[i,4]:=tcausale_u.tcauscon + ' ' + tcausale_u.tcausrip;
        GUscite.Cells[i,5]:=tcausale_u.tcausioe + ' ' + tcausale_u.tcausrpl;
        GUscite.Cells[i,6]:=IntToStr(tcausale_u.tcausarr);
        GUscite.Cells[i,7]:=R180MinutiOre(tcausale_u.tcauspiu);
        GUscite.Cells[i,8]:=tcausale_u.tcausabi;
        GUscite.Cells[i,9]:=tflagarr_u;
      end;
    end;
end;
//_________
procedure TA028FSCVisual.x000c;
var i:Integer;
begin
  with A028FSC.A028FScMW.R502ProDtM1 do
  begin
    A028FSC.A028FScMW.CaricaCdsConteggi;

    //Caratto 26/09/2013. se più di un elemento impostava rowcount errato
    grdStaccoMensa.RowCount:=1;
    if High(TimbratureMensa) >= 0 then
      grdStaccoMensa.RowCount:=High(TimbratureMensa) + 1;

    for i:=0 to High(TimbratureMensa) do
    begin
      grdStaccoMensa.Cells[0,i]:=R180MinutiOre(TimbratureMensa[i].I);
      grdStaccoMensa.Cells[1,i]:=R180MinutiOre(TimbratureMensa[i].F);
    end;
    (* Caratto 26/09/2013 duplicato inutile
    if Q370.Locate('Data',DataCon,[]) then
      while not Q370.Eof do
      begin
        if Q370.FieldByName('Data').AsDateTime <> DataCon then
          Break;
        GTimbMensa.Cells[0,GTimbMensa.RowCount - 1]:=FormatDateTime('hh.nn',Q370.FieldByName('Ora').AsDateTime);
        GTimbMensa.RowCount:=GTimbMensa.RowCount + 1;
        Q370.Next;
      end;
    *)
    //
    GTimbMensa.RowCount:=1;
    if Q370.Locate('Data',DataCon,[]) then
      while not Q370.Eof do
      begin
        if Q370.FieldByName('Data').AsDateTime <> DataCon then
          Break;
        GTimbMensa.Cells[0,GTimbMensa.RowCount - 1]:=FormatDateTime('hh.nn',Q370.FieldByName('Ora').AsDateTime);
        GTimbMensa.RowCount:=GTimbMensa.RowCount + 1;
        Q370.Next;
      end;
    GTimbMensa.RowCount:=GTimbMensa.RowCount - 1;
    //
    for i:=0 to High(FascePaghe276) do
    begin
      if FascePaghe276[i].VocePaghe <> '' then
      begin
        GFascePaghe.RowCount:=i + 1;
        GFascePaghe.Cells[0,i]:=FascePaghe276[i].VocePaghe;
        GFascePaghe.Cells[1,i]:=R180MinutiOre(FascePaghe276[i].Ore);
      end
      else
        Break;
    end;
    grdRilevatori.RowCount:=Length(trieprilev);
    grdRilevatori.ColCount:=2;
    for i:=0 to grdRilevatori.ColCount - 1 do grdRilevatori.Cells[i,0]:='';
    grdRilevatori.FixedCols:=1;
    for i:=0 to High(trieprilev) do
    begin
      grdRilevatori.Cells[0,i]:=trieprilev[i].rilevatore;
      grdRilevatori.Cells[1,i]:=R180MinutiOre(trieprilev[i].tminprestot);
    end;
    grdGettoni.RowCount:=Length(Gettoni);
    grdGettoni.ColCount:=2;
    for i:=0 to grdGettoni.ColCount - 1 do grdGettoni.Cells[i,0]:='';
    grdGettoni.FixedCols:=1;
    for i:=0 to High(Gettoni) do
    begin
      grdGettoni.Cells[0,i]:=Gettoni[i].Causale;
      grdGettoni.Cells[1,i]:=R180MinutiOre(Gettoni[i].Minuti);
    end;
  end;
end;
//_________
procedure TA028FSCVisual.x000d;
var i:Integer;
begin
  with A028FSC.A028FScMW.R502ProDtM1 do
  begin
  pnlHeadAnomalie2.Caption:='Anomalie 2° livello: ' + Length(tanom2riscontrate).ToString;
  GAnomalie2.RowCount:=n_anom2 + 1;
  for i:=0 to High(tanom2riscontrate) do
  begin
    if tdescanom2[tanom2riscontrate[i].ta2puntdesc].F = 1 then
      GAnomalie2.Cells[0,i]:=tanom2riscontrate[i].ta2caus;
    GAnomalie2.Cells[1,i]:=tdescanom2[tanom2riscontrate[i].ta2puntdesc].D;
  end;
  //_________
  pnlHeadAnomalie3.Caption:='Anomalie 3° livello: ' + Length(tanom3riscontrate).ToString;
  GAnomalie3.RowCount:=n_anom3 + 1;
  for i:=0 to High(tanom3riscontrate) do
  begin
    GAnomalie3.Cells[0,i]:=R180MinutiOre(tanom3riscontrate[i].ta3timb);
    GAnomalie3.Cells[1,i]:=tdescanom3[tanom3riscontrate[i].ta3puntdesc].D;
  end;
  end;
end;
//_________
procedure TA028FSCVisual.x000e;
var i,icom:Byte;
begin
  with A028FSC.A028FScMW.R502ProDtM1 do
  begin
  pnlHeadPresenze.Caption:='Riepilogo presenze: ' + IntToStr(n_rieppres);
  GPresenze.RowCount:=n_rieppres + 1;
  GPresenze.ColCount:=n_fasce + 2;
  GPresenze.Cells[0,0]:='Caus.';
  GPresenze.Cells[1,0]:='Raggr.';
  //display 'Caus.  Raggr.'    line rig position 1.
  for i:=1 to n_fasce do
    GPresenze.Cells[i + 1,0]:='F.' + tfasceorarie[i].tcodfasc;
  for i:=1 to n_rieppres do
    begin
    GPresenze.Cells[0,i]:=triepgiuspres[i].tcauspres;
    GPresenze.Cells[1,i]:=triepgiuspres[i].traggpres;
    for icom:=1 to n_fasce do
      GPresenze.Cells[icom + 1,i]:=R180MinutiOre(triepgiuspres[i].tminpres[icom]);
    end;
  //_________
  pnlHeadAssenze.Caption:='Riepilogo assenze: ' + IntToStr(n_riepasse);
  GAssenze.RowCount:=n_riepasse + 1;
  GAssenze.Cells[0,0]:='Caus.';
  GAssenze.Cells[1,0]:='Ragg.';
  GAssenze.Cells[2,0]:='GG';
  GAssenze.Cells[3,0]:='MG';
  GAssenze.Cells[4,0]:='hhmm';
  GAssenze.Cells[5,0]:='hhmm val.';
  GAssenze.Cells[6,0]:='hhmm comp.';
  GAssenze.Cells[7,0]:='hhmm ass.';
  GAssenze.Cells[8,0]:='hhmm rese';
  for i:=1 to n_riepasse do
    begin
    GAssenze.Cells[0,i]:=triepgiusasse[i].tcausasse;
    GAssenze.Cells[1,i]:=triepgiusasse[i].traggasse;
    GAssenze.Cells[2,i]:=IntToStr(triepgiusasse[i].tggasse);
    GAssenze.Cells[3,i]:=IntToStr(triepgiusasse[i].tmezggasse);
    GAssenze.Cells[4,i]:=R180MinutiOre(triepgiusasse[i].tminasse);
    GAssenze.Cells[5,i]:=R180MinutiOre(triepgiusasse[i].tminvalasse);
    GAssenze.Cells[6,i]:=R180MinutiOre(triepgiusasse[i].tminvalcompasse);
    GAssenze.Cells[7,i]:=R180MinutiOre(triepgiusasse[i].thhmmasse);
    GAssenze.Cells[8,i]:=R180MinutiOre(triepgiusasse[i].tminresasse);
    if triepgiusasse[i].tfiniretr = 1 then
      GAssenze.Cells[8,i]:='Ininf.fini ret.';
    end;
  end;
end;

end.