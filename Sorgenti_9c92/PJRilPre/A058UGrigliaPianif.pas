unit A058UGrigliaPianif;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, ExtCtrls, C180FunzioniGenerali, Menus, StdCtrls, Buttons,
  ComCtrls, DB, RegistrazioneLog, OracleData, Oracle,
  C700USelezioneAnagrafe, A000UCostanti, A000USessione,A000UInterfaccia, A000UMessaggi, R600,
  Variants, DatiBloccati, A004UGiustifAssPres, A040UPianifRep, C001StampaLib, A083UMsgElaborazioni,
  StrUtils, Math, Ac09UIndFunzione;

const
  ALTEZZA_RIGA = 15;

type
  TA058FGrigliaPianif = class(TForm)
    Panel1: TPanel;
    GVista: TStringGrid;
    BRegistrazione: TBitBtn;
    BitBtn3: TBitBtn;
    PopupMenu1: TPopupMenu;
    Modifica1: TMenuItem;
    PGVista: TProgressBar;
    BCancellazione: TBitBtn;
    btnAnteprima: TBitBtn;
    Panel2: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    Shape2: TShape;
    Label2: TLabel;
    Shape3: TShape;
    Label3: TLabel;
    Shape4: TShape;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    btnAnomalie: TBitBtn;
    BOperativa: TBitBtn;
    LblModificaRapida: TLabel;
    N1: TMenuItem;
    Visualizzadebito1: TMenuItem;
    Visualizzacopertura1: TMenuItem;
    Visualizzaturni: TMenuItem;
    Visualizzaassenze: TMenuItem;
    CompetenzeResiduiassenza1: TMenuItem;
    Visualizzadettaglioorariogiornaliero1: TMenuItem;
    N2: TMenuItem;
    VisualizzaRiposiFestivi: TMenuItem;
    Visualizzalimititipologieprofessionali1: TMenuItem;
    BtnVerificaTurni: TBitBtn;
    VisualizzaCoperturaSquadre1: TMenuItem;
    LblOPerazioni: TLabel;
    Copiapianificazione1: TMenuItem;
    InsCancGiust1: TMenuItem;
    ValidaCausale1: TMenuItem;
    VisualizzaAssenze1: TMenuItem;
    N3: TMenuItem;
    Visualizzacolonnabadge1: TMenuItem;
    Visualizzazionesintetica1: TMenuItem;
    Reperibilit1: TMenuItem;
    Indennitdifunzione1: TMenuItem;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnVerificaTurniClick(Sender: TObject);
    procedure Visualizzalimititipologieprofessionali1Click(Sender: TObject);
    procedure VisualizzaRiposiFestiviClick(Sender: TObject);
    procedure GVistaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure GVistaClick(Sender: TObject);
    procedure Visualizzadettaglioorariogiornaliero1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GVistaDrawCell(Sender: TObject; Col, Row: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure GVistaMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Modifica1Click(Sender: TObject);
    procedure BRegistrazioneClick(Sender: TObject);
    procedure BCancellazioneClick(Sender: TObject);
    procedure btnAnteprimaClick(Sender: TObject);
    procedure GVistaKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure GVistaSelectCell(Sender: TObject; Col, Row: Integer;
      var CanSelect: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAnomalieClick(Sender: TObject);
    procedure BOperativaClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Visualizzadebito1Click(Sender: TObject);
    procedure Visualizzacopertura1Click(Sender: TObject);
    procedure VisualizzaturniClick(Sender: TObject);
    procedure VisualizzaassenzeClick(Sender: TObject);
    procedure CompetenzeResiduiassenza1Click(Sender: TObject);
    procedure VisualizzaCoperturaSquadre1Click(Sender: TObject);
    procedure GVistaDblClick(Sender: TObject);
    procedure Copiapianificazione1Click(Sender: TObject);
    procedure InsCancGiust1Click(Sender: TObject);
    procedure ValidaCausale1Click(Sender: TObject);
    procedure VisualizzaAssenze1Click(Sender: TObject);
    procedure Visualizzacolonnabadge1Click(Sender: TObject);
    procedure Visualizzazionesintetica1Click(Sender: TObject);
    procedure GVistaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Reperibilit1Click(Sender: TObject);
    procedure Indennitdifunzione1Click(Sender: TObject);
  private
    { Private declarations }
    FastGiust,TastoPremuto:String;
    AssenzeAbilitate,ReperibilitaAbilitata,RiposiFestiviCalcolati:Boolean;
    procedure LeggiValoriCella;
  public
    { Public declarations }
    DatoModificato:Boolean;
    nRigheBloccate:integer;
    nColonneBloccate:integer;
  end;

var
  A058FGrigliaPianif: TA058FGrigliaPianif;

implementation

uses A058UPianifTurni, A058UModPianif, A058UPianifTurniDtM1,
     A058UDettaglioGiornata, A058UDettaglioTipiOperatori,
     A058UCoperturaSquadra,A058UCopiaPianificazione, A058UTabellone,
     A058UValidaAssenze, A058UStampaAssenze;

{$R *.DFM}

procedure TA058FGrigliaPianif.FormCreate(Sender: TObject);
var
  AbilitaA058:Boolean;
begin
  nRigheBloccate:=2;
  nColonneBloccate:=6;
  FreeAndNil(A058FDettaglioGiornata);
  FreeAndNil(A058FDettaglioTipiOperatori);

  try
    A058FPianifTurniDtM1.selT530.Open;
    if A058FPianifTurniDtM1.selT530.RecordCount = 0 then
      if Not A058FPianifTurni.bVisualizzaSintetica then
      begin
        GVista.DefaultColWidth:=80;
        GVista.Font.Size:=8;
      end
      else
      begin
        GVista.DefaultColWidth:=57;
        GVista.Font.Size:=8;
      end
    else
    begin
      GVista.DefaultColWidth:=100;
      GVista.Font.Size:=8;
    end;
  except
  end;
  LblModificaRapida.Caption:='';
  GVista.RowHeights[0]:=30;
  GVista.ColWidths[0]:=-1;
  GVista.RowHeights[1]:=-1;
  GVista.ColWidths[1]:=80;
  GVista.ColWidths[2]:=-1;
  GVista.ColWidths[3]:=-1;
  GVista.ColWidths[4]:=-1;
  GVista.ColWidths[5]:=-1;
  GVista.Cells[0,0]:='Badge';
  GVista.Cells[1,0]:='Nome';
  GVista.Cells[2,0]:='Situazione ore';
  GVista.Cells[3,0]:='Tot.turni';
  GVista.Cells[4,0]:='Caus. Fat/Res';
  DatoModificato:=False;
  RiposiFestiviCalcolati:=False;

  if A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
  begin
    BRegistrazione.Enabled:=Parametri.A058_PianifOperativa <> 'N';
    BCancellazione.Enabled:=Parametri.A058_PianifOperativa = 'S';
    SpeedButton1.Enabled:=Parametri.A058_PianifOperativa <> 'N';
  end
  else if A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'N' then
  begin
    BRegistrazione.Enabled:=Parametri.A058_PianifNonOperativa <> 'N';
    BCancellazione.Enabled:=Parametri.A058_PianifNonOperativa = 'S';
    BOperativa.Enabled:=(Parametri.A058_PianifOperativa <> 'N') and (Parametri.A058_PianifNonOperativa <> 'N');
    SpeedButton1.Enabled:=Parametri.A058_PianifNonOperativa <> 'N';
  end;
  //PIANIFICAZIONE PROGRESSIVA
  if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
  begin
    //PIANIFICAZIONE OPERATIVA
    with A058FPianifTurniDtm1 do
    begin
      if (A058FPianifTurni.RgpTipo.ItemIndex = 0) and (selT082.FieldByName('GENERAZIONE').AsString = 'N') or
         (A058FPianifTurni.RgpTipo.ItemIndex = 0) and (selT082.FieldByName('INIZIALE').AsString = 'N') or
         (A058FPianifTurni.RgpTipo.ItemIndex = 1) and (selT082.FieldByName('CORRENTE').AsString = 'N') then
      begin
        BRegistrazione.Enabled:=False;
        SpeedButton1.Enabled:=False;
        BCancellazione.Enabled:=False;
      end;
      //BOperativa.Visible:=(selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') and (selT082.FieldByName('GENERAZIONE').AsString = 'S');
      BOperativa.Visible:=(selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') and (A058FPianifTurni.RgpTipo.ItemIndex = 1) and
                          (selT082.FieldByName('RENDI_OPERATIVA').AsString = 'S');
    end;

    {if A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
    begin
      if not A058FPianifTurniDtm1.NuovaPianif then
      begin
        BRegistrazione.Enabled:=False;
        SpeedButton1.Enabled:=False;
      end;
    end;
    //PIANIFICAZIONE NON OPERATIVA
    //INIZIALE - non si può modificare... si può solo vedere
    if A058FPianifTurni.RgpTipo.ItemIndex = 0 then
    begin
      BRegistrazione.Enabled:=False;
      BCancellazione.Enabled:=False;
      SpeedButton1.Enabled:=False;
    end
    else
    //CORRENTE - si può solo registrare o rendere operativa
    begin
      BOperativa.Visible:=True;
      BCancellazione.Enabled:=False;
    end}
  end
  else if SolaLettura then
  begin
    BRegistrazione.Enabled:=False;
    BCancellazione.Enabled:=False;
    SpeedButton1.Enabled:=False;
    BOperativa.Visible:=False;
  end;

//btnAnomalie.Enabled:=False;
  AbilitaA058:=SolaLettura;
  AssenzeAbilitate:=A000GetInibizioni('Funzione','OpenA004GiustifAssPres') = 'S';
  //SolaLettura:=AbilitaA058;

  //AbilitaA058:=SolaLettura;
  ReperibilitaAbilitata:=A000GetInibizioni('Funzione','OpenA040PianifRep') = 'S';
  SolaLettura:=AbilitaA058;
end;

procedure TA058FGrigliaPianif.GVistaDblClick(Sender: TObject);
var Ind:integer;
    ParData:TDateTime;
begin
  try
    Ind:=GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
    ParData:=StrToDate(GVista.Cells[GVista.Col,0]);
    OpenA058CoperturaSquadra(Ind,ParData);
  except
    Abort;
  end;
end;

procedure TA058FGrigliaPianif.GVistaDrawCell(Sender: TObject; Col,
  Row: Integer; Rect: TRect; State: TGridDrawState);
{Disegno della griglia con colori differenti a seconda del tipo di pianificazione}
var
  ColVistaGiorni,xx1,xx2:Integer;
  Rect2,Rect3,Rect4,Rect5, RectRep:TRect;
  A1,A2,sDep,sDep2,MaxMinFormat:String;
  dDataCella:TDateTime;
begin
  if Col < 1 then
    exit;
  with A058FPianifTurni, A058FPianifTurniDtM1 do
  begin
    if Row = 0 then
    begin
      if Col = 0 then
        exit;
      if Col = 1 then
      begin
        //Scrivo su due righe la dicitura "cognome/nome"
        Rect2:=Rect;
        Rect2.Top:=Rect.Top + ((Rect.Bottom - Rect.Top) div 2);
        //Scrivo "cognome" prima riga
        GVista.Canvas.TextRect(Rect,Rect.Left,Rect.Top,'Cognome');
        //Scrivo "nome" nella seconda riga...
        GVista.Canvas.TextRect(Rect2,Rect2.Left+1,Rect2.Top-2,'Nome');
        exit;
      end
      else if Col = 2 then
      begin
        //Scrivo su due righe la dicitura "Situazione ore"
        Rect2:=Rect;
        Rect2.Top:=Rect.Top + ((Rect.Bottom - Rect.Top) div 2);
        //Scrivo "situazione" prima riga
        GVista.Canvas.TextRect(Rect,Rect.Left,Rect.Top,'Situazione');
        //Scrivo "ore" nella seconda riga...
        GVista.Canvas.TextRect(Rect2,Rect2.Left+1,Rect2.Top-2,'ore');
        exit;
      end
      else if Col = 3 then
      begin
        //Scrivo su due righe la dicitura "Tot.turni"
        Rect2:=Rect;
        Rect2.Top:=Rect.Top + ((Rect.Bottom - Rect.Top) div 2);
        //Scrivo "Tot." prima riga
        GVista.Canvas.TextRect(Rect,Rect.Left,Rect.Top,'Tot.');
        //Scrivo "turni" nella seconda riga...
        GVista.Canvas.TextRect(Rect2,Rect2.Left+1,Rect2.Top-2,'turni');
        exit;
      end
      else if Col = 4 then
      begin
        //Scrivo su due righe la dicitura "Riepil.Assenze"
        Rect2:=Rect;
        Rect2.Top:=Rect.Top + ((Rect.Bottom - Rect.Top) div 2);
        //Scrivo "Riepil.Assenze" prima riga
        GVista.Canvas.TextRect(Rect,Rect.Left,Rect.Top,'Riepil.Assenze');
        //Scrivo "Caus. Fat/Res" nella seconda riga...
        GVista.Canvas.TextRect(Rect2,Rect2.Left+1,Rect2.Top-2,'Caus. Fat./Res.');
        exit;
      end
      else if Col = 5 then
      begin
        //Scrivo su due righe la dicitura "Riposi/Festiv.lavorate"
        Rect2:=Rect;
        Rect2.Top:=Rect.Top + ((Rect.Bottom - Rect.Top) div 2);
        //Scrivo "Riposi" prima riga
        GVista.Canvas.TextRect(Rect,Rect.Left,Rect.Top,'Rip./Fest.lav.');
        //Scrivo "Fest.lav" nella seconda riga...
        //GVista.Canvas.TextRect(Rect2,Rect2.Left+1,Rect2.Top-2,'al ' + DateTostr(R180FineMese(A058FPianifTurniDtm1.DataInizio-1)));
        exit;
      end;
      Rect2:=Rect;
      Rect2.Top:=Rect.Top + ((Rect.Bottom - Rect.Top) div 2);
      //Se il giorno è festivo lo coloro di rosso (leggo il calendario del primo dipendente)
      dDataCella:=StrToDate(GVista.Cells[col,row]);
      with GetCalend do
      begin
        SetVariable('PROG',Vista[0].Prog);
        SetVariable('D',dDataCella);
        Execute;
        if (VarToStr(GetVariable('F')) = 'S') or (DayOfWeek(dDataCella) = 1) then
          GVista.Canvas.Font.Color:=clRed;
      end;
      //Scrivo la data nella prima riga
      sDep2:=GetTipoGiornoServizio(dDataCella);
      if sDep2 <> '' then
        sDep2:='(' + sDep2 + ')';
      sDep2:=GVista.Cells[col,row] + sDep2;
      GVista.Canvas.TextRect(Rect,Rect.Left,Rect.Top,ifThen(Not bVisualizzaSintetica,'  ','') + sDep2);
      //Scrivo il nome del giorno nella seconda riga... centrandolo...
      sDep:=R180NomeGiorno(dDataCella);
      if bVisualizzaSintetica then
        sDep:=copy(sDep,1,3);
      //sDep:=UpperCase(Copy(sDep,1,1)) + Copy(sDep,2,length(sDep));
      sDep:=Format('%' + IntToStr(Length(sDep)+Round((Length(sDep2) + ifThen(Not bVisualizzaSintetica,2,0) - Length(sDep))/2)) + 's%',[sDep]);
      GVista.Canvas.TextRect(Rect2,Rect2.Left+1,Rect2.Top-2,sDep);
      exit;
    end
    else if Row = 1 then
    begin
      if Col < nColonneBloccate then
        exit;
      Rect2:=Rect;
      Rect2.Top:=Rect.Top + ((Rect.Bottom - Rect.Top) div 6) * 2;
      //Rect2.Top:=Rect.Top + ALTEZZA_RIGA;
      Rect3:=Rect;
      Rect3.Top:=Rect2.Top + (Rect.Bottom - Rect.Top) div 6;
      //Rect3.Top:=Rect2.Top + (ALTEZZA_RIGA div 2);
      Rect4:=Rect;
      Rect4.Top:=Rect3.Top + (Rect.Bottom - Rect.Top) div 6;
      //Rect4.Top:=Rect3.Top + (ALTEZZA_RIGA div 2);
      Rect5:=Rect;
      Rect5.Top:=Rect4.Top + (Rect.Bottom - Rect.Top) div 6;
      //Rect5.Top:=Rect4.Top + (ALTEZZA_RIGA div 2);
      //Scrivo l'intestazione nella prima riga... (MIN/ASS/MAX)
      if Not bVisualizzaSintetica then
        GVista.Canvas.TextRect(Rect,Rect.Left,Rect.Top, Format('%3s%',['MIN']) + ' ' + Format('%3s%',['ASS']) + ' ' + Format('%3s%',['MAX']))
      else
        GVista.Canvas.TextRect(Rect,Rect.Left,Rect.Top, Format('%2s%',['mn']) + ' ' + Format('%2s%',['As']) + ' ' + Format('%2s%',['MX']));
      if Q600B.RecordCount > 0 then
      begin
        if Not bVisualizzaSintetica then
          MaxMinFormat:='%3d%'
        else
          MaxMinFormat:='%2d%';
        //Scrivo il minimo/assegnato/massimo per il turno numero 1
        if aTotaleTurni[Col - nColonneBloccate].Turno1 < GetLimitiMAX_MIN(StrToDate(GVista.Cells[col,0]),1).Min then
          GVista.Canvas.Font.Color:=ClRed
        else
          GVista.Canvas.Font.Color:=ClBlack;
        GVista.Canvas.TextRect(Rect2,Rect2.Left+1,Rect2.Top-2, Format(MaxMinFormat,[GetLimitiMAX_MIN(StrToDate(GVista.Cells[col,0]),1).Min]) + ' ' +
                                                               Format(MaxMinFormat,[aTotaleTurni[Col - nColonneBloccate].Turno1]) + ' ' +
                                                               Format(MaxMinFormat,[GetLimitiMAX_MIN(StrToDate(GVista.Cells[col,0]),1).Max]));
        //Scrivo il minimo/assegnato/massimo per il turno numero 2
        if aTotaleTurni[Col - nColonneBloccate].Turno2 < GetLimitiMAX_MIN(StrToDate(GVista.Cells[col,0]),2).Min then
          GVista.Canvas.Font.Color:=ClRed
        else
          GVista.Canvas.Font.Color:=ClBlack;
        GVista.Canvas.TextRect(Rect3,Rect3.Left+1,Rect3.Top-2, Format(MaxMinFormat,[GetLimitiMAX_MIN(StrToDate(GVista.Cells[col,0]),2).Min]) + ' ' +
                                                               Format(MaxMinFormat,[aTotaleTurni[Col - nColonneBloccate].Turno2]) + ' ' +
                                                               Format(MaxMinFormat,[GetLimitiMAX_MIN(StrToDate(GVista.Cells[col,0]),2).Max]));
        //Scrivo il minimo/assegnato/massimo per il turno numero 3
        if aTotaleTurni[Col - nColonneBloccate].Turno3 < GetLimitiMAX_MIN(StrToDate(GVista.Cells[col,0]),3).Min then
          GVista.Canvas.Font.Color:=ClRed
        else
          GVista.Canvas.Font.Color:=ClBlack;
        GVista.Canvas.TextRect(Rect4,Rect4.Left+1,Rect4.Top-2, Format(MaxMinFormat,[GetLimitiMAX_MIN(StrToDate(GVista.Cells[col,0]),3).Min]) + ' ' +
                                                               Format(MaxMinFormat,[aTotaleTurni[Col - nColonneBloccate].Turno3]) + ' ' +
                                                               Format(MaxMinFormat,[GetLimitiMAX_MIN(StrToDate(GVista.Cells[col,0]),3).Max]));
        //Scrivo il minimo/assegnato/massimo per il turno numero 4
        if aTotaleTurni[Col - nColonneBloccate].Turno4 < GetLimitiMAX_MIN(StrToDate(GVista.Cells[col,0]),4).Min then
          GVista.Canvas.Font.Color:=ClRed
        else
          GVista.Canvas.Font.Color:=ClBlack;
        GVista.Canvas.TextRect(Rect5,Rect5.Left+1,Rect5.Top-2, Format(MaxMinFormat,[GetLimitiMAX_MIN(StrToDate(GVista.Cells[col,0]),4).Min]) + ' ' +
                                                               Format(MaxMinFormat,[aTotaleTurni[Col - nColonneBloccate].Turno4]) + ' ' +
                                                               Format(MaxMinFormat,[GetLimitiMAX_MIN(StrToDate(GVista.Cells[col,0]),4).Max]));
      end
      else
      begin
        //Scrivo il minimo/assegnato/massimo per il turno numero 1
        GVista.Canvas.TextRect(Rect2,Rect2.Left+1,Rect2.Top-2, Format('%3s%',[' ']) + ' ' + Format('%3d%',[aTotaleTurni[Col - nColonneBloccate].Turno1]) + ' ' + Format('%3s%',[' ']));
        //Scrivo il minimo/assegnato/massimo per il turno numero 2
        GVista.Canvas.TextRect(Rect3,Rect3.Left+1,Rect3.Top-2, Format('%3s%',[' ']) + ' ' + Format('%3d%',[aTotaleTurni[Col - nColonneBloccate].Turno2]) + ' ' + Format('%3s%',[' ']));
        //Scrivo il minimo/assegnato/massimo per il turno numero 3
        GVista.Canvas.TextRect(Rect4,Rect4.Left+1,Rect4.Top-2, Format('%3s%',[' ']) + ' ' + Format('%3d%',[aTotaleTurni[Col - nColonneBloccate].Turno3]) + ' ' + Format('%3s%',[' ']));
        //Scrivo il minimo/assegnato/massimo per il turno numero 4
        GVista.Canvas.TextRect(Rect5,Rect5.Left+1,Rect5.Top-2, Format('%3s%',[' ']) + ' ' + Format('%3d%',[aTotaleTurni[Col - nColonneBloccate].Turno4]) + ' ' + Format('%3s%',[' ']));
      end;
      exit;
    end
    else if Col = 1 then //Inserisco il cognome ed il nome su due righe...
    begin
      Rect2:=Rect;
      //Rect2.Top:=Rect.Top + (Rect.Bottom - Rect.Top) div 3;
      Rect2.Top:=Rect.Top + ALTEZZA_RIGA;
      Rect3:=Rect;
      //Rect3.Top:=Rect2.Top + (Rect.Bottom - Rect.Top) div 3;
      Rect3.Top:=Rect2.Top + ALTEZZA_RIGA;
      GVista.Canvas.TextRect(Rect,Rect.Left,Rect.Top,Vista[Row - nRigheBloccate].Cognome);
      GVista.Canvas.TextRect(Rect2,Rect2.Left,Rect2.Top,Vista[Row - nRigheBloccate].Nome);
      GVista.Canvas.TextRect(Rect3,Rect3.Left,Rect3.Top,Vista[Row - nRigheBloccate].TipoOpe);
      exit; 
    end
    else if Col = 2 then //Inserisco il debito/assegnato/scostamento su 3 righe...
    begin
      Rect2:=Rect;
      Rect2.Top:=Rect.Top + ALTEZZA_RIGA;//(Rect.Bottom - Rect.Top) div 3;
      Rect3:=Rect;
      Rect3.Top:=Rect2.Top + ALTEZZA_RIGA;//(Rect.Bottom - Rect.Top) div 3;
      with Vista[Row - nRigheBloccate] do
      begin
        //Scrivo il debito nella prima riga
        GVista.Canvas.TextRect(Rect,Rect.Left,Rect.Top, Format('%-8s%-7s',['Deb.con.',R180MinutiOre(Debito)]));
        //Scrivo l'assegnato nella seconda riga
        GVista.Canvas.TextRect(Rect2,Rect2.Left,Rect2.Top, Format('%-8s%-7s',['Pianif.',R180MinutiOre(Assegnato)]));
        //Scrivo lo scostamento nella terza riga
        GVista.Canvas.TextRect(Rect3,Rect3.Left,Rect3.Top, Format('%-8s%-7s',['Scost.',R180MinutiOre(Assegnato - Debito)]));
      end;
      exit;
    end
    else if Col = 3 then //Inserisco il totale dei turni fatti da ogni dipendente nel periodo
    begin
      Rect2:=Rect;
      Rect2.Top:=Rect.Top + ((Rect.Bottom - Rect.Top) div 4);
      Rect3:=Rect;
      Rect3.Top:=Rect2.Top + (Rect.Bottom - Rect.Top) div 4;
      Rect4:=Rect;
      Rect4.Top:=Rect3.Top + (Rect.Bottom - Rect.Top) div 4;
      //Scrivo il primo turno sulla prima riga
      GVista.Canvas.TextRect(Rect,Rect.Left,Rect.Top, '1°T ' + Format('%3d%',[Vista[Row - nRigheBloccate].TotaleTurniMese.Turno1]));
      //Scrivo il secondo turno sulla seconda riga
      GVista.Canvas.TextRect(Rect2,Rect2.Left,Rect2.Top-2, '2°T ' + Format('%3d%',[Vista[Row - nRigheBloccate].TotaleTurniMese.Turno2]));
      //Scrivo il terzo turno sulla terza riga
      GVista.Canvas.TextRect(Rect3,Rect3.Left,Rect3.Top-2, '3°T ' + Format('%3d%',[Vista[Row - nRigheBloccate].TotaleTurniMese.Turno3]));
      //Scrivo il quarto turno sulla quarta riga
      GVista.Canvas.TextRect(Rect4,Rect4.Left,Rect4.Top-2, '4°T ' + Format('%3d%',[Vista[Row - nRigheBloccate].TotaleTurniMese.Turno4]));
      exit;
    end
    else if Col = 4 then //Inserisco il fatto/residuo di ferie/malattia/recuperi
    begin
      //DA GESTIRE PER PESCARA: PER ADESSO LASCIATO IN SOSPESO
      exit;
    end
    else if Col = 5 then //Inserisco i riposi/festività lavorate fatte da inizio anno al mese precedente la pianificazione
    begin
      Rect2:=Rect;
      Rect2.Top:=Rect.Top + ALTEZZA_RIGA;//((Rect.Bottom - Rect.Top) div 3);
      Rect3:=Rect;
      Rect3.Top:=Rect2.Top + ALTEZZA_RIGA;//(Rect.Bottom - Rect.Top) div 3;
      GVista.Canvas.TextRect(Rect,Rect.Left,Rect.Top,'Riposi   :' + Format('%3s',[IntToStr(Vista[Row - nRigheBloccate].RiposiPrec)]));
      sDep:= FormatDateTime('mm/yy',DataInizio - 1);
      if (R180Mese(DataInizio) = 1) and (R180Giorno(DataInizio) = 1) then
        sDep2:= '12/' + Copy(IntToStr(R180Anno(DataInizio) - 2),3,2)
      else
        sDep2:= '12/' + Copy(IntToStr(R180Anno(DataInizio) - 1),3,2);
      sDep:='F.l.' + sDep + ':' + Format('%3s',[IntToStr(Vista[Row - nRigheBloccate].FestiviLavMesePrec)]);
      GVista.Canvas.TextRect(Rect2,Rect2.Left+1,Rect2.Top-2,sDep);
      sDep2:='F.l.' + sDep2 + ':' + Format('%3s',[IntToStr(Vista[Row - nRigheBloccate].FestiviLavAnnoPrec)]);
      GVista.Canvas.TextRect(Rect3,Rect3.Left+1,Rect3.Top-2,sDep2);
      exit;
    end;
    Rect2:=Rect;
    //Rect2.Top:=Rect.Top + (Rect.Bottom - Rect.Top) div 3;
    Rect2.Top:=Rect.Top + ALTEZZA_RIGA;
    Rect3:=Rect;
    //Rect3.Top:=Rect2.Top + (Rect.Bottom - Rect.Top) div 3;
    Rect3.Top:=Rect2.Top + ALTEZZA_RIGA;
    Rect3.Bottom:=Rect3.Top + ALTEZZA_RIGA;
    Rect4:=Rect;
    Rect4.Top:=Rect3.Top + ALTEZZA_RIGA;
    ColVistaGiorni:=Col - nColonneBloccate + OffsetVista;  //Alberto 18/06/2007
    if (Vista[Row - nRigheBloccate].Giorni[ColVistaGiorni].Flag = 'M') then
    //Pianificazione manuale già esistente (Giallo)
    begin
      GVista.Canvas.Brush.Color:=$0080FFFF;//clYellow;
      GVista.Canvas.FillRect(Rect);
    end
    else if Vista[Row - nRigheBloccate].Giorni[ColVistaGiorni].Flag = 'O' then
    //Pianificazione da turnazione (Verde)
    begin
      GVista.Canvas.Brush.Color:=$0069E473;//clLime;
      GVista.Canvas.FillRect(Rect);
    end
    else if Vista[Row - nRigheBloccate].Giorni[ColVistaGiorni].Flag = 'CS' then
    //Pianificazione da cambio squadra (Azzurro)
    begin
      GVista.Canvas.Brush.Color:=clAqua;
      GVista.Canvas.FillRect(Rect);
    end;
    if Not(gdFixed in State) and (gdFocused in State) then
    begin
      GVista.Canvas.Brush.Color:=clHighLight;
      GVista.Canvas.Font.Color:=clWhite;
    end;
    //Riposo pianificato o assenza
    if (Trim(Vista[Row - nRigheBloccate].Giorni[ColVistaGiorni].T1) = '0') or
       (Trim(Vista[Row - nRigheBloccate].Giorni[ColVistaGiorni].T1) = '') or
       (Vista[Row - nRigheBloccate].Giorni[ColVistaGiorni].Ass1Modif=False) or
       (Trim(Vista[Row - nRigheBloccate].Giorni[ColVistaGiorni].Ass1) <> '') or
       (Trim(Vista[Row - nRigheBloccate].Giorni[ColVistaGiorni].Ass2) <> '') or
       ((Trim(Vista[Row - nRigheBloccate].Giorni[ColVistaGiorni].T1) = ' M') and
       ((Trim(Vista[Row - nRigheBloccate].Giorni[ColVistaGiorni].Ass1) <> '') or
       (Trim(Vista[Row - nRigheBloccate].Giorni[ColVistaGiorni].Ass2) <> ''))) then
//       ((Trim(TGiorno(TDipendente(Vista[Row - nRigheBloccate]).Giorni[ColVistaGiorni]).T1) = 'A') and
//        (TGiorno(TDipendente(Vista[Row - nRigheBloccate]).Giorni[ColVistaGiorni]).Ass1Modif=False)) then
    begin
      GVista.Canvas.Brush.Color:=clWhite;
      GVista.Canvas.FillRect(Rect);
    end;
    //Gestisco la scrittura su 3 righe:   T1 (Sigla Turno) Orario
    //                                    T2 (Sigla Turno) Orario
    //                                    Assenz1    Assenz2
    if Vista[Row - nRigheBloccate].Giorni[ColVistaGiorni].Modificato then
      GVista.Canvas.Font.Color:=clRed
    else
      GVista.Canvas.Font.Color:=clBlack;
    if Not(gdFixed in State) and (gdFocused in State) then
    begin
      GVista.Canvas.Brush.Color:=clHighLight;
      GVista.Canvas.Font.Color:=clWhite;
    end;
    with Vista[Row - nRigheBloccate].Giorni[ColVistaGiorni] do
    begin
      //Scrivo il primo turno nella prima riga
      if trim(T1) <> '' then
        if Not bVisualizzaSintetica then
          GVista.Canvas.TextRect(Rect,Rect.Left,Rect.Top, Format('%-2s%-1s%-3s%s',[T1, T1EU, SiglaT1, R180DimLung(Ora,5)]))
        else if (Trim(Ass1) = '') and (Trim(Ass2) = '') then
          GVista.Canvas.TextRect(Rect,Rect.Left,Rect.Top, Format('%-2s%-1s%-3s',[T1, T1EU, SiglaT1]));
      //Scrivo il secondo turno nella seconda riga
      if trim(T2) <> '' then
        if Not bVisualizzaSintetica then
          GVista.Canvas.TextRect(Rect2,Rect2.Left,Rect2.Top,Format('%-2s%-1s%-3s%s',[T2, T2EU, SiglaT2, R180DimLung(Ora,5)]))
        else if (Trim(Ass1) = '') and (Trim(Ass2) = '') then
          GVista.Canvas.TextRect(Rect2,Rect2.Left,Rect2.Top,Format('%-2s%-1s%-3s',[T2, T2EU, SiglaT2]));
      //Scrivo le assenze nella terza riga
      A1:=Ass1;
      A2:=Ass2;
      GVista.Canvas.TextRect(Rect3,Rect3.Left,Rect3.Top, Format('%-5s',[A1]) + ' ' + Format('%-5s',[A2]));
      if Vista[Row - nRigheBloccate].Giorni[ColVistaGiorni].VAss = 'S' then
      begin
        Rect.Top:=Rect.top + (((Rect.Bottom - Rect.top) div 4) * 2);
        GVista.Canvas.Brush.Color:=clAqua;
        GVista.Canvas.FillRect(Rect);
        GVista.Canvas.TextRect(Rect,Rect.Left,Rect.Top, Format('%-5s',[A1]) + ' ' + Format('%-5s',[A2]));
      end;
      //Assenze ad ore/mezze giornate, dalla quarta riga in poi
      if AssOre <> '' then
      begin
        xx1:=1;
        xx2:=Pos(#13,Copy(AssOre,xx1,Length(AssOre)));
        if xx2 = 0 then
          xx2:=Length(AssOre) + 1;
        while xx1 < xx2 do
        begin
          GVista.Canvas.Brush.Color:=$00DCB9FF;  //Rosa
          GVista.Canvas.FillRect(Rect4);
          GVista.Canvas.TextRect(Rect4,Rect4.Left,Rect4.Top, Copy(AssOre,xx1,xx2 - xx1));
          Rect4.Top:=Rect4.Top + ALTEZZA_RIGA;
          xx1:=xx2 + 1;
          xx2:=Pos(#13,Copy(AssOre,xx1,Length(AssOre)));
          if xx2 = 0 then
            xx2:=Length(AssOre) + 1;
        end;
      end;
    end;
    if Vista[Row - nRigheBloccate].Giorni[ColVistaGiorni].TurnRep <> '' then
    begin
      //Se presente evidenzio il turno di reperibilità
      RectRep:=Rect;
      GVista.Canvas.Brush.Color:=clBlue;
      GVista.Canvas.Font.Color:=clYellow;
      RectRep.Top:=RectRep.Top + GVista.RowHeights[Row] - 15;
      RectRep.Left:=RectRep.Left + GVista.ColWidths[Col] - 15;
      GVista.Canvas.FillRect(RectRep);
      GVista.Canvas.TextRect(RectRep, RectRep.Left + 3, RectRep.Top, 'R');
    end;
  end;
end;

procedure TA058FGrigliaPianif.GVistaMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
{Gestisco la selezione della cella col tasto destro del mouse}
var R,C:Integer;
begin
  if Button = mbRight then
  begin
    GVista.MouseToCell(X,Y,C,R);
    Modifica1.Visible:=(R >= nRigheBloccate) and (C >= nColonneBloccate);
    CopiaPianificazione1.Visible:=(R >= nRigheBloccate);
    if (R < nRigheBloccate) or (C < nColonneBloccate) then exit;
    GVista.Row:=R;
    GVista.Col:=C;
  end;
end;

procedure TA058FGrigliaPianif.Modifica1Click(Sender: TObject);
{Finestra di dialogo per modificare i dati della pianificazione}
var i,j,xx:Integer;
    O,A1,A2:String;
    D,DCorr:TDateTime;
    Giorno:TGiorno;
  function GiornoSignificativo(Caus:String):Boolean;
  var GS:String;
  begin
    GS:=VarToStr(A058FPianifTurniDtM1.Q265.Lookup('CODICE',Caus,'GSIGNIFIC'));
    Result:=False;
    if GS = '' then
      exit;
    if (GS = 'GT') and (Trim(A058FPianifTurniDtm1.Vista[i].Giorni[xx].T1) = '0') then
      exit;
    if (GS = 'GL') and (DayOfWeek(DCorr) in [1,7]) then
      exit;
    if (GS = 'G6') and (DayOfWeek(DCorr) in [1]) then
      exit;
    Result:=True;
  end;
begin
  if A058FDettaglioGiornata <> nil then
    FreeAndNil(A058FDettaglioGiornata);
  if FastGiust <> '' then
  begin
    R180MessageBox('Per accedere alla maschera di modifica è necessario disattivare la modalità ''Modifica rapida''', ESCLAMA);
    exit;
  end;
  LeggiValoriCella;
  i:=GVista.Row - nRigheBloccate;
  j:=GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
  D:=A058FPianifTurniDtm1.DataInizio + j;
  with A058FPianifTurniDtm1 do
  begin
    O:=Vista[i].Giorni[j].Ora;
    A1:=Vista[i].Giorni[j].Ass1;
    A2:=Vista[i].Giorni[j].Ass2;
    Q021.Filter:='';
    Q021.Filtered:=False;
    Q021.SetVariable('DECORRENZA',D);
    Q021.Close;
    Q021.Open;
    Q020.Filtered:=True;
  end;
  A058FModPianif:=TA058FModPianif.Create(nil);
  with A058FModPianif, A058FPianifTurniDtm1 do
    try
      //Se c'è la possibilità di inserire una causale come nuova filtro i dataset
      Q265.Filtered:=A1 = '';
      Q265B.Filtered:=A2 = '';

      //Preparo i dati
      {Se il dato non è nel filtro dizionario, ne impedisco la modifica, altrimenti
       filtro il contenuto della combobox orari}
      if (not A000FiltroDizionario('MODELLI ORARIO',O)) and (not O.IsEmpty)  then
      begin
        Q020.Filtered:=False;
        EOrario.Enabled:=False;
      end
      else
      begin
        Q020.Filtered:=True;
        EOrario.Enabled:=True;
      end;
      EOrario.KeyValue:=O;

      DBText1.Visible:=O <> '';
      EAssenza1.KeyValue:=A1;
      DBText2.Visible:=A1 <> '';
      EAssenza2.KeyValue:=A2;
      DBText3.Visible:=A2 <> '';
      T1:=Trim(Vista[i].Giorni[j].T1);
      T2:=Trim(Vista[i].Giorni[j].T2);
      SiglaT1:=Trim(Vista[i].Giorni[j].SiglaT1);
      SiglaT2:=Trim(Vista[i].Giorni[j].SiglaT2);
      NTurno1:=Trim(Vista[i].Giorni[j].NumTurno1);
      NTurno2:=Trim(Vista[i].Giorni[j].NumTurno2);
      T1EU:=Vista[i].Giorni[j].T1EU;
      T2EU:=Vista[i].Giorni[j].T2EU;
      Assenza1:=Vista[i].Giorni[j].Ass1;
      EAssenza1.Enabled:=A000FiltroDizionario('CAUSALI ASSENZA',Assenza1) and
                         Vista[i].Giorni[j].Ass1Modif;
      Assenza2:=Vista[i].Giorni[j].Ass2;
      EAssenza2.Enabled:=A000FiltroDizionario('CAUSALI ASSENZA',Assenza2) and
                         Vista[i].Giorni[j].Ass2Modif;
      edtDaData.Enabled:=A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'N';
      edtAData.Enabled:=A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'N';
      edtDaData.Text:=DateToStr(DataInizio + j);
      edtAData.Text:=DateToStr(DataInizio + j);

      if ShowModal = mrOK then
        with A058FPianifTurniDtm1, A058FPianifTurni do
        begin
          CmbTurno1.Text:=Trim(CmbTurno1.Text);
          CmbTurno2.Text:=Trim(CmbTurno2.Text);
          if (CmbTurno1EU.Text <> '') and
             ((CmbTurno1.Text = '') or (CmbTurno1.Text < '1') or (CmbTurno1.Text > '99')) then
            CmbTurno1EU.Text:='';
          if (CmbTurno2EU.Text <> '') and
             ((CmbTurno2.Text = '') or (CmbTurno2.Text < '1') or (CmbTurno2.Text > '99')) then
            CmbTurno2EU.Text:='';
          //Modifico i dati in Vista e GVista
          Vista[i].Giorni[j].T1:=Format('%2s',[CmbTurno1.Text]);
          Vista[i].Giorni[j].T2:=Format('%2s',[CmbTurno2.Text]);
          Vista[i].Giorni[j].Ora:=EOrario.Text;
          //Leggo la sigla dei turni
          Giorno:=Vista[i].Giorni[j];
          GetDatiTurno(Giorno);
          Vista[i].Giorni[j].SiglaT1:=Giorno.SiglaT1;
          Vista[i].Giorni[j].SiglaT2:=Giorno.SiglaT2;
          Vista[i].Giorni[j].NumTurno1:=Giorno.NumTurno1;
          //Fine lettura sigla dei turni
          Vista[i].Giorni[j].T1EU:=CmbTurno1EU.Text;
          Vista[i].Giorni[j].T2EU:=CmbTurno2EU.Text;
          if (Trim(Vista[i].Giorni[j].T1) = '') and (EOrario.Text <> '') then
            Vista[i].Giorni[j].T1:=' M';
          if A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
            with Vista[i].Giorni[j] do
            begin
              //Se è specificato solo l'orario senza turni imposto il turno a 'M'
              //if (Trim(T1) = '') and (EOrario.Text <> '') then T1:=' M';
              ValorGior:='';
              (*case rgpValorizzazioneGiornaliera.ItemIndex of
                0:ValorGior:='';
                1:ValorGior:='A';
                2:ValorGior:='B';
                3:ValorGior:='C';
                4:ValorGior:='D';
                5:ValorGior:='E';
              end;*)
              Ass1:=EAssenza1.Text;
              Ass2:=EAssenza2.Text;
              if Ass1 = '' then
              //Prima assenza nulla e seconda assenza valida
              begin
                Ass1:=EAssenza2.Text;
                Ass2:='';
              end;
              //Se le 2 assenze sono uguali elimino la seconda
              if Ass1 = Ass2 then Ass2:='';
              //Se è specificata solo l'assenza imposto il turno ad 'A'
              if (Trim(T1) = '') and (Ass1 <> '') then
                T1:=' A';
              //if (Trim(T1) < '1') or (Trim(T1) > '99') then
              //  T1EU:='';
              //if (Trim(T2) < '1') or (Trim(T2) > '99') then
              //  T2EU:='';
              //Se è pianificato il turno ma manca l'orario lo ricerco nello storico
              if (EOrario.Text = '') and (Trim(T1) <> '') then
                Ora:=A058FPianifTurniDtM1.GetOrarioStorico(D,Vista[i].Prog);
              GVista.Cells[GVista.Col,GVista.Row]:=
              Format('%-2s%-3s%-1s%-2s%-3s%-1s%s',[T1, SiglaT1, T1EU,
                                                   T2, SiglaT2, T2EU,
                                                   R180DimLung(Ora,5)]);
              if Giorno.T1 <> '' then
                Vista[i].Giorni[j].Flag:='M';
            end
          else
          begin
            DCorr:=StrToDate(edtDaData.Text);
            while DCorr <= StrToDate(edtAData.Text) do
            begin
              if (DCorr >= DataInizio) and (DCorr <= DataFine) then
              begin
                xx:=Trunc(DCorr - DataInizio);
                with Vista[i].Giorni[xx] do
                begin
                  if (EAssenza1.Text = '') or GiornoSignificativo(EAssenza1.Text) then
                  begin
                    if Ass1 <> EAssenza1.Text then
                      Modificato:=True;
                    Ass1:=EAssenza1.Text;
                  end;
                  if (EAssenza2.Text = '') or GiornoSignificativo(EAssenza2.Text) then
                  begin
                    if Ass2 <> EAssenza2.Text then
                      Modificato:=True;
                    Ass2:=EAssenza2.Text;
                  end;
                  if Ass1 = '' then
                  //Prima assenza nulla e seconda assenza valida
                  begin
                    Ass1:=EAssenza2.Text;
                    Ass2:='';
                  end;
                  //Se le 2 assenze sono uguali elimino la seconda
                  if Ass1 = Ass2 then Ass2:='';
                  //Se è specificata solo l'assenza imposto il turno ad 'A'
                  if (Trim(T1) = '') and (Ass1 <> '') then
                    T1:=' A';
                end
              end;
              DCorr:=DCorr + 1;
            end;
          end;
          with Vista[i].Giorni[j] do
          begin
            if (Trim(T1) < '1') or (Trim(T1) > '99') then
              T1EU:='';
            if (Trim(T2) < '1') or (Trim(T2) > '99') then
              T2EU:='';
            if (EOrario.Text = '') and (Trim(T1) <> '') then
              Ora:=A058FPianifTurniDtM1.GetOrarioStorico(D,Vista[i].Prog);
            if Giorno.T1 <> '' then
              Vista[i].Giorni[j].Flag:='M';
            GVista.Cells[GVista.Col,GVista.Row]:=
              Format('%-2s%-3s%-1s%-2s%-3s%-1s%s',[T1, SiglaT1, T1EU,
                                                   T2, SiglaT2, T2EU,
                                                   R180DimLung(Ora,5)]);
            if (xValoreOrigine.T1<>T1) or (xValoreOrigine.T2<>T2) or
               (xValoreOrigine.SiglaT1<>SiglaT1) or (xValoreOrigine.SiglaT2<>SiglaT2) or
               (xValoreOrigine.T1EU<>T1EU) or (xValoreOrigine.T2EU<>T2EU) or
               (xValoreOrigine.Ora<>Ora) or (xValoreOrigine.ValorGior<>ValorGior) or
               (xValoreOrigine.Ass1<>Ass1) or (xValoreOrigine.Ass2<>Ass2) or
               (xValoreOrigine.Flag<>Flag) or (xValoreOrigine.Squadra<>Squadra) or
               (xValoreOrigine.DSquadra<>DSquadra) or
               (xValoreOrigine.Oper<>Oper) then
            begin
              Modificato:=True; //Setto il flag che indica che la cella è stata modificata
              DatoModificato:=True;
            end;
          end;
          A058FPianifTurniDtM1.ConteggiGiornalieri(DataInizio + j,i,j);
          A058FPianifTurniDtm1.DebitoDipendente(i,0,Trunc(A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio));
          AggiornaContatoriTurni(i,j);
          GVista.Repaint;
        end;
    finally
      Release;
      A058FPianifTurniDtM1.Q265.Filtered:=False;
      A058FPianifTurniDtM1.Q265B.Filtered:=False;
      A058FPianifTurniDtM1.Q020.Filtered:=False;
    end;
end;

procedure TA058FGrigliaPianif.BRegistrazioneClick(Sender: TObject);
{Pianificazione operativa}
var
  i:integer;
begin
  if A058FDettaglioGiornata <> nil then
    FreeAndNil(A058FDettaglioGiornata);
  if (Parametri.CampiRiferimento.C11_PianifOrariProg = 'S') and (A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') then
    if R180MessageBox(A000MSG_A058_DLG_REG_PIANIF, DOMANDA) <> mrYes then
      exit;
  //btnAnomalie.Enabled:=False;
  //selDatiBloccati.FileLog:='';
  RegistraMsg.IniziaMessaggio('A058');
  PGVista.Position:=0;
  with A058FPianifTurniDtm1 do
  begin
    PGVista.Max:=Vista.Count;
    GeneraIniCorr:=A058FPianifTurni.chkIniCorr.Checked;
    //Scorro Vista (elenco dipendenti)
    for i:=0 to Vista.Count - 1 do
    begin
      PGVista.Position:=PGVista.Position + 1;
      EseguiPianificazione(i);
    end;
    PckTurno.CopiaTurnazione;
  end;
  //btnAnomalie.Enabled:=selDatiBloccati.FileLog <> '';
  PGVista.Position:=0;
  DatoModificato:=False;
end;

procedure TA058FGrigliaPianif.BCancellazioneClick(Sender: TObject);
var i:Integer;
begin
  if A058FDettaglioGiornata <> nil then
    FreeAndNil(A058FDettaglioGiornata);
  if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
  begin
    if R180MessageBox(A000MSG_A058_DLG_CANC_PIANIF_PROG, DOMANDA) <> mrYES then
      exit;
  end
  else
  begin
    if R180MessageBox(A000MSG_A058_DLG_CANC_PIANIF, DOMANDA) <> mrYes then
      exit;
  end;
//  btnAnomalie.Enabled:=False;
  //selDatiBloccati.FileLog:='';
  RegistraMsg.IniziaMessaggio('A058');
  PGVista.Position:=0;
  with A058FPianifTurniDtm1 do
  begin
    PGVista.Max:=Vista.Count;
    //Scorro Vista (elenco dipendenti)
    for i:=0 to Vista.Count - 1 do
    begin
      PGVista.Position:=PGVista.Position + 1;
      CancellaPianificazione(Vista[i].Prog);
    end;
  end;
//  btnAnomalie.Enabled:=selDatiBloccati.FileLog <> '';
  PGVista.Position:=0;
  Close;
end;

procedure TA058FGrigliaPianif.btnAnteprimaClick(Sender: TObject);
{Richiamo finestra di dialogo per stampa tabellone turni}
begin
  If A058FDettaglioGiornata <> nil then
    FreeAndNil(A058FDettaglioGiornata);
  A058FPianifTurni.Anteprima_Stampa(True);
end;

procedure TA058FGrigliaPianif.GVistaKeyPress(Sender: TObject; var Key: Char);
var
  i,j:Integer;
  D:TDateTime;
  Giorno:TGiorno;
  bSoloOrario:boolean;
begin
  if FastGiust = '' then
    exit;
  i:=GVista.Row - nRigheBloccate;
  j:=GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
  bSoloOrario:=False;
  Key:=UpCase(Key);
  D:=A058FPianifTurniDtm1.DataInizio + j;
  TastoPremuto:=Trim(TastoPremuto);
  with A058FPianifTurniDtm1 do
  begin
    with Vista[i].Giorni[j] do
    begin
      if Ord(Key) in [VK_ESCAPE] then
      begin
        T1:=xValoreOrigine.T1;
        T2:=xValoreOrigine.T2;
        SiglaT1:=xValoreOrigine.SiglaT1;
        NumTurno1:=xValoreOrigine.NumTurno1;
        SiglaT2:=xValoreOrigine.SiglaT2;
        NumTurno2:=xValoreOrigine.NumTurno2;
        T1EU:=xValoreOrigine.T1EU;
        T2EU:=xValoreOrigine.T2EU;
        Ora:=xValoreOrigine.Ora;
        ValorGior:=xValoreOrigine.ValorGior;
        Ass1:=xValoreOrigine.Ass1;
        Ass2:=xValoreOrigine.Ass2;
        Flag:=xValoreOrigine.Flag;
        Squadra:=xValoreOrigine.Squadra;
        DSquadra:=xValoreOrigine.DSquadra;
        Oper:=xValoreOrigine.Oper;
        Modificato:=xValoreOrigine.Modificato;
        Key:=#0;
        ConteggiGiornalieri(A058FPianifTurniDtm1.DataInizio + j,i,j);
        DebitoDipendente(i,0,Trunc(A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio));
        AggiornaContatoriTurni(i,j);
        GVista.Repaint;
        exit;
      end;
      if Ord(Key) in [VK_BACK] then
      begin
        TastoPremuto:=Copy(TastoPremuto,1,Length(TastoPremuto) - 1);
        Key:=#0;
        if Trim(T1) = ' M' then
          bSoloOrario:=True;
      end;
      if Copy(FastGiust,1,1) = 'T' then
      begin
        if (Key <> #0) and
           ((StrToIntDef(Key,-1) < 0) or (StrToIntDef(Key,-1) > 99)) and
           ((Key <> 'E') and (Key <> 'U')) then
           exit;
        if (Length(TastoPremuto)>=3) and
           (Key in ['0'..'9']) then
          TastoPremuto:='  ' + Copy(TastoPremuto,3,1)
        else if (Pos('E',TastoPremuto)=0) and
           (Pos('U',TastoPremuto)=0) and
           (Key in ['0'..'9']) and
           (Length(TastoPremuto)>=2) then
          TastoPremuto:='';
      end
      else if (Copy(FastGiust,1,1) = 'A')
           or (Copy(FastGiust,1,1) = 'O') then
      begin
        if (Key <> #0) and (not (Key in ['A'..'Z','a'..'z','0'..'9',#0])) then
          exit;
        if Length(TastoPremuto) >= 5 then
          TastoPremuto:='';
      end;
      if (Key <> #0) then
      begin
        if Copy(FastGiust,1,1) = 'T' then
        begin
          if ((Key = 'E')or(Key = 'U')) then
          begin
            if Pos('E',TastoPremuto)>0 then
              TastoPremuto:=StringReplace(TastoPremuto,'E',Key,[rfReplaceAll])
            else if Pos('U',TastoPremuto)>0 then
              TastoPremuto:=StringReplace(TastoPremuto,'U',Key,[rfReplaceAll])
            else if trim(TastoPremuto) <> '' then
              TastoPremuto:=TastoPremuto + Key;
          end
          else if Length(TastoPremuto) = 1 then
            TastoPremuto:=TastoPremuto + Key
          else
            TastoPremuto:=Copy(TastoPremuto,1,1) + Key + Copy(TastoPremuto,Length(TastoPremuto),1);
        end
        else if (Copy(FastGiust,1,1) = 'A') or (Copy(FastGiust,1,1) = 'O') then
          TastoPremuto:=TastoPremuto + Key;
      end;

      if FastGiust = 'T1' then
      begin
        if (Key = #0) and (trim(TastoPremuto) = '') then
        begin
          T1:='  ';
          T1EU:=' ';
        end
        else
          if (Key in ['E','U']) then
            T1EU:=Key
          else
          begin
            if Trim(Ora) <> '' then
            begin
              A058FPianifTurniDtM1.RefreshQ021(A058FPianifTurniDtm1.DataInizio + GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista);
              A058FPianifTurniDtM1.Q021.Filter:='CODICE = ''' + Ora + '''';
              A058FPianifTurniDtM1.Q021.Filtered:=True;
              if StrToIntDef(Copy(TastoPremuto,1,2),999) <= A058FPianifTurniDtM1.Q021.RecordCount then
                T1:=Format('%2s',[Copy(TastoPremuto,1,2)])
              else if StrToIntDef(Copy(Key,1,2),999) <= A058FPianifTurniDtM1.Q021.RecordCount then
                T1:=Format('%2s',[Copy(Key,1,2)])
            end
            else
              T1:=Format('%2s',[Copy(TastoPremuto,1,2)]);
            if (Pos('E',TastoPremuto) = 0) and (Pos('U',TastoPremuto) = 0) then
              T1EU:=' ';
          end;
      end
      else if (FastGiust = 'T2') and (Trim(T1) <> '') then
      begin
        if (Key = #0) and (Trim(TastoPremuto) = '') then
        begin
          T2:='  ';
          T2EU:=' '
        end
        else
          if (Key in ['E','U']) then
            T2EU:=Key
          else
          begin
            T2:=Format('%2s',[Copy(TastoPremuto,1,2)]);
            if (Pos('E',TastoPremuto)=0) and (Pos('U',TastoPremuto)=0) then
              T2EU:=' ';
          end;
      end
      else if FastGiust = 'A1' then
      begin
        if Ass1Modif=False then
          Key:=#0
        else if (Key = #0) and (Trim(TastoPremuto) = '') then
          Ass1:=''
        else
        begin
          //Se la causale non esiste non devo far scrivere nulla
          A058FPianifTurniDtM1.Q265.Filtered:=True;
          if A058FPianifTurniDtM1.Q265.Locate('Codice',TastoPremuto,[loCaseInsensitive,loPartialKey]) then
            Ass1:=A058FPianifTurniDtM1.Q265.FieldByName('CODICE').AsString
          else
          begin
            TastoPremuto:=Copy(TastoPremuto,1,Length(TastoPremuto)-1);
            if A058FPianifTurniDtM1.Q265.Locate('Codice',TastoPremuto,[loCaseInsensitive,loPartialKey]) then
              Ass1:=A058FPianifTurniDtM1.Q265.FieldByName('CODICE').AsString;
            Key:=#0;
          end;
          A058FPianifTurniDtM1.Q265.Filtered:=False;
        end;
      end
      else if FastGiust = 'A2' then
      begin
        if Ass2Modif=False then
          Key:=#0
        else if (Key = #0) and (Trim(TastoPremuto) = '') then
          Ass2:=''
        else
        begin
          //Se la causale non esiste non devo far scrivere nulla
          A058FPianifTurniDtM1.Q265.Filtered:=True;
          if A058FPianifTurniDtM1.Q265.Locate('Codice',TastoPremuto,[loCaseInsensitive,loPartialKey]) then
            Ass2:=A058FPianifTurniDtM1.Q265.FieldByName('CODICE').AsString
          else
          begin
            TastoPremuto:=Copy(TastoPremuto,1,Length(TastoPremuto)-1);
            if A058FPianifTurniDtM1.Q265.Locate('Codice',TastoPremuto,[loCaseInsensitive,loPartialKey]) then
              Ass2:=A058FPianifTurniDtM1.Q265.FieldByName('CODICE').AsString;
            Key:=#0;
          end;
          A058FPianifTurniDtM1.Q265.Filtered:=False;
        end
      end
      else if FastGiust = 'O' then
      begin
        if (Key = #0) and (Trim(TastoPremuto) = '') then
        begin
          if bSoloOrario then
            T1:='';
          Ora:='';
        end
        else
        begin
          //Lello
          //Se la causale non esiste non devo far scrivere nulla
          A058FPianifTurniDtM1.Q020.Filtered:=True;
          if A058FPianifTurniDtM1.Q020.Locate('Codice',TastoPremuto,[loCaseInsensitive,loPartialKey]) then
            Ora:=A058FPianifTurniDtM1.Q020.FieldByName('CODICE').AsString
          else
          begin
            TastoPremuto:=Copy(TastoPremuto,1,Length(TastoPremuto)-1);
            if A058FPianifTurniDtM1.Q020.Locate('Codice',TastoPremuto,[loCaseInsensitive,loPartialKey]) then
              Ora:=A058FPianifTurniDtM1.Q020.FieldByName('CODICE').AsString;
            Key:=#0;
          end;
          A058FPianifTurniDtM1.Q020.Filtered:=False;
        end;
      end;
      //Lello
//      If (FastGiust <> '') and (Key<>#0) then
//        Modificato:=True; //Setto il flag che indica che la cella è stata modificata
      if ((Trim(T1) = '') or (Trim(T1) = 'A')) and (Trim(T2) <> '') then
      begin
        T1:=T2;
        T2:='';
        FastGiust:='T1';
        LblModificaRapida.Caption:='Modifica rapida ''PRIMO TURNO''';
      end;
      if (Trim(Ass1) = '') and (Trim(Ass2) <> '') then
      begin
        Ass1:=Ass2;
        Ass2:='';
        if FastGiust='A2' then
        begin
          FastGiust:='A1';
          LblModificaRapida.Caption:='Modifica rapida ''PRIMA ASSENZA''';
        end;
      end;
      if (Trim(Ass1) <> '') and (Trim(T1)='') then
        T1:=' A';
      if (Trim(Ora) <> '') and ((Trim(T1) = '') or (Trim(T1) = ' M')) and (bSoloOrario=False) then
        if Trim(T2)<>'' then
        begin
          T1:=T2;
          T2:='';
        end
        else if Trim(Ass1)<>'' then
          T1:=' A'
        else
          T1:=' M';
      if (Trim(T1) = 'A') and Ass1Modif and (Trim(Ass1) = '') then
        T1:=' M';
      if (Trim(T1) = '') and (Ora <> '') then
      begin
        T1:='';
        Ora:='';
        TastoPremuto:='';
      end;
      if (Trim(T1) < '1') or (Trim(T1) > '99') then
        T1EU:='';
      //Se è pianificato il turno ma manca l'orario lo ricerco nello storico
      if (Trim(Ora) = '') and (Trim(T1) <> '') then
        Ora:=A058FPianifTurniDtM1.GetOrarioStorico(D,Vista[i].Prog);
      //Leggo la sigla dei turni
      Giorno:=Vista[i].Giorni[j];
      Vista[i].Giorni[j].T1:=Giorno.T1;
      Vista[i].Giorni[j].T2:=Giorno.T2;
      Vista[i].Giorni[j].T1EU:=Trim(Giorno.T1EU);
      Vista[i].Giorni[j].T2EU:=Trim(Giorno.T2EU);
      Vista[i].Giorni[j].Ora:=Giorno.Ora;
      GetDatiTurno(Giorno);
      Vista[i].Giorni[j].Ass1:=Giorno.Ass1;
      Vista[i].Giorni[j].Ass2:=Giorno.Ass2;
      Vista[i].Giorni[j].SiglaT1:=Giorno.SiglaT1;
      Vista[i].Giorni[j].SiglaT2:=Giorno.SiglaT2;
      Vista[i].Giorni[j].NumTurno1:=Giorno.NumTurno1;
      Vista[i].Giorni[j].NumTurno2:=Giorno.NumTurno2;
      //Setto il flag che indica che la cella è stata modificata
      //TGiorno(TDipendente(Vista[i]).Giorni[j]).Modificato:=True;
      if Giorno.T1<>'' then
        Vista[i].Giorni[j].Flag:='M';
      with Vista[i].Giorni[j] do
      begin
        if (xValoreOrigine.T1<>T1) or
           (xValoreOrigine.T2<>T2) or
           (xValoreOrigine.SiglaT1<>SiglaT1) or
           (xValoreOrigine.SiglaT2<>SiglaT2) or
           (xValoreOrigine.T1EU<>T1EU) or
           (xValoreOrigine.T2EU<>T2EU) or
           (xValoreOrigine.Ora<>Ora) or
           (xValoreOrigine.ValorGior<>ValorGior) or
           (xValoreOrigine.Ass1<>Ass1) or
           (xValoreOrigine.Ass2<>Ass2) or
           (xValoreOrigine.Flag<>Flag) or
           (xValoreOrigine.Squadra<>Squadra) or
           (xValoreOrigine.DSquadra<>DSquadra) or
           (xValoreOrigine.Oper<>Oper) then
        begin
          Modificato:=True; //Setto il flag che indica che la cella è stata modificat
          DatoModificato:=True;
        end;
      end;
      //Fine lettura sigla dei turni
      //GVista.Cells[j + 5,i + 2]:=Format('%-2s%-3s%-1s%s',[T1, SiglaT1, T1EU,R180DimLung(Ora,5)]);
      ConteggiGiornalieri(A058FPianifTurniDtm1.DataInizio + j,i,j);
      DebitoDipendente(i,0,Trunc(A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio));
      AggiornaContatoriTurni(i,j);
    end;
    GVista.Repaint;
  end;
end;

procedure TA058FGrigliaPianif.GVistaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  InChar:Char;
begin
  if (ssCtrl in Shift) and (FastGiust = 'T1') then
  begin
    InChar:=Chr(Key);
    TastoPremuto:='';
    FastGiust:='T2';
    GVistaKeyPress(nil,InChar);
    FastGiust:='T1';
  end;
end;

procedure TA058FGrigliaPianif.SpeedButton1Click(Sender: TObject);
begin
  if SpeedButton1.Down then
  begin
    GVista.OnKeyPress:=GVistaKeyPress;
    SpeedButton1.Hint:='Premere ''Ctrl'' + ''T'' per pianificare il Primo Turno' + #$A#$D +
                       'Premere ''Ctrl'' + ''Numero'' per pianificare il Secondo Turno' + #$A#$D +
                       'Premere ''Ctrl'' + ''A'' per pianificare la Prima Assenza' + #$A#$D +
                       'Premere ''Ctrl'' + ''O'' per pianificare l''orario';
    FastGiust:='T1';
    LblModificaRapida.Caption:='Modifica rapida ''PRIMO TURNO''';
  end
  else
  begin
    GVista.OnKeyPress:=nil;
    SpeedButton1.Hint:='Modifica rapida';
    FastGiust:='';
    LblModificaRapida.Caption:='';
    TastoPremuto:='';
  end;
end;

procedure TA058FGrigliaPianif.GVistaSelectCell(Sender: TObject; Col,Row: Integer; var CanSelect: Boolean);
var i,j:integer;
begin
  TastoPremuto:='';
  i:=Row - nRigheBloccate;
  j:=Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
  with A058FPianifTurniDtm1 do
  begin
    //Salvo i dati della cella appena selezionata in una struttura di appoggio
    with Vista[i].Giorni[j] do
    begin
      xValoreOrigine.T1:=T1;
      xValoreOrigine.T2:=T2;
      xValoreOrigine.SiglaT1:=SiglaT1;
      xValoreOrigine.NumTurno1:=NumTurno1;
      xValoreOrigine.SiglaT2:=SiglaT2;
      xValoreOrigine.NumTurno2:=NumTurno2;
      xValoreOrigine.T1EU:=T1EU;
      xValoreOrigine.T2EU:=T2EU;
      xValoreOrigine.ValorGior:=ValorGior;
      xValoreOrigine.Ora:=Ora;
      xValoreOrigine.Ass1:=Ass1;
      xValoreOrigine.Ass2:=Ass2;
      xValoreOrigine.Flag:=Flag;
      xValoreOrigine.Squadra:=Squadra;
      xValoreOrigine.DSquadra:=DSquadra;
      xValoreOrigine.Oper:=Oper;
      xValoreOrigine.Modificato:=Modificato;
    end;
  end;
end;

procedure TA058FGrigliaPianif.InsCancGiust1Click(Sender: TObject);
var PData, PCausale:String;
    PProg,IGiorno:Integer;
begin
  with A058FPianifTurniDtm1 do
  begin
    PProg:=GVista.Row - nRigheBloccate;
    PData:=DateToStr(StrToDate(GVista.Cells[GVista.Col,0]));
    IGiorno:=Trunc(StrToDate(PData) - A058FPianifTurniDtm1.DataInizio);

    PCausale:=Vista[PProg].Giorni[IGiorno].Ass1;
    if PCausale = '' then
        PCausale:=Vista[PProg].Giorni[IGiorno].Ass2;

    A058FPianifTurni.frmSelAnagrafe.SalvaC00SelAnagrafe;
    C700Distruzione;
    OpenA004GiustifAssPres(Vista[PProg].Prog,PData,'','','','',PCausale,0,True);
    C700DatiSelezionati:=C700CampiBase;
    C700Creazione(SessioneOracle);
    C700OldProgressivo:=-1;
    A058FPianifTurni.frmSelAnagrafe.RipristinaC00SelAnagrafe;

    RefreshAssenze(A058FPianifTurniDtm1.DataInizio,A058FPianifTurniDtm1.DataFine);
    ConteggiGiornalieri(StrToDate(GVista.Cells[GVista.Col,0]),PProg,IGiorno);
    DebitoDipendente(PProg,A058FPianifTurniDtm1.OffsetVista,
                     A058FPianifTurniDtm1.OffsetVista + Trunc(A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio));
    GVista.Repaint;
  end;
end;

procedure TA058FGrigliaPianif.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  A058FPianifTurniDtM1.AnomaliePianif:=False;
  
  if A058FDettaglioGiornata <> nil then
    FreeAndNil(A058FDettaglioGiornata);
  if DatoModificato then
    if Application.MessageBox('Le modifiche apportate non sono state salvate!' + #13 +
       'Uscire comunque?' ,'',MB_YESNO) = IDNO then
      Action:=caNone;
end;

procedure TA058FGrigliaPianif.btnAnomalieClick(Sender: TObject);
var
  i,j,NGiorni:Integer;
begin
  if A058FDettaglioGiornata <> nil then
    FreeAndNil(A058FDettaglioGiornata);
  {A058FPianifTurni.frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A058','A,B');
  C700DatiSelezionati:=C700TuttiCampi;
  C700Creazione(SessioneOracle);
  A058FPianifTurni.frmSelAnagrafe.RipristinaC00SelAnagrafe;
  A058FPianifTurniDtM1.SelAnagrafeA058:=C700SelAnagrafe;}
  //if Not A058FPianifTurniDtM1.AnomaliePianif then
  //begin
  Self.Cursor:=crHourGlass;
  Self.Enabled:=False;
  GVista.OnDrawCell:=nil;
  try
    A058FPianifTurniDtM1.VerificaPianificazione(A058FPianifTurniDtm1.DataInizio,A058FPianifTurniDtm1.DataFine,'S');
  finally
    GVista.OnDrawCell:=GVistaDrawCell;
    Self.Enabled:=True;
    Self.Cursor:=crDefault;
  end;
  A058FPianifTurni.frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A058','A,B');
  C700DatiSelezionati:=C700TuttiCampi;
  C700Creazione(SessioneOracle);
  A058FPianifTurni.frmSelAnagrafe.RipristinaC00SelAnagrafe;
  A058FPianifTurniDtM1.SelAnagrafeA058:=C700SelAnagrafe;

  // Per effettuare il controllo delle anomalie la vista è stata cancellata.
  // Se necessario devo rieffettuare i calcoli relativi ai riposi e ai saldi
  RiposiFestiviCalcolati:=False; // Indico che è necessario ripetere il calcolo dei riposi
  Screen.Cursor:=crHourGlass;
  try
    if (A058FPianifTurni.bVisualizzaRiposiFestivi) then
    begin
      // Ricalcolo se richiesto, se no ci penserà VisualizzaRiposiFestiviClick()
      // quando e se l'utente mostrerà la relativa colonna della griglia
      LblOPerazioni.Caption:='Ricalcolo riposi/festivi lavorati al mese precedente...';
      Application.ProcessMessages;
      A058FPianifTurniDtm1.CalcolaRiposiFestivi;
      RiposiFestiviCalcolati:=True;
    end;
    if A058FPianifTurniDtm1.ConteggiaDebito then
    begin
      LblOPerazioni.Caption:='Ricalcolo saldi orari...';
      Application.ProcessMessages;
      NGiorni:=Trunc(A058FPianifTurniDtM1.DataFine - A058FPianifTurniDtM1.DataInizio);
      for i:=0 to A058FPianifTurniDtM1.Vista.Count - 1 do
      begin
        for j:=0 to NGiorni do
          A058FPianifTurniDtM1.ConteggiGiornalieri(A058FPianifTurniDtM1.DataInizio + j,i,A058FPianifTurniDtm1.OffsetVista + j);
        A058FPianifTurniDtM1.DebitoDipendente(i,A058FPianifTurniDtm1.OffsetVista,A058FPianifTurniDtm1.OffsetVista + NGiorni);
      end;
    end;
  finally
    LblOPerazioni.Caption:='';
    Screen.Cursor:=crDefault;
  end;

  //end;
end;

procedure TA058FGrigliaPianif.BOperativaClick(Sender: TObject);
var i:Integer;
begin
  If A058FDettaglioGiornata <> nil then
    FreeAndNil(A058FDettaglioGiornata);
  if DatoModificato then
    raise exception.Create(A000MSG_A058_ERR_REGISTRA_MODIFICHE);
  if R180MessageBox(A000MSG_A058_DLG_RENDI_OPERATIVA, DOMANDA) <> mrYes then
    exit;
  PGVista.Position:=0;
  with A058FPianifTurniDtm1 do
  begin
    PGVista.Max:=Vista.Count;
    //Scorro Vista (elenco dipendenti)
    for i:=0 to Vista.Count - 1 do
    begin
      PGVista.Position:=PGVista.Position + 1;
      RendiOperativa(i);
    end;
  end;
  PGVista.Position:=0;
end;

procedure TA058FGrigliaPianif.PopupMenu1Popup(Sender: TObject);
var
  Ind, PProg:Integer;
begin
  VisualizzaRiposiFestivi.Caption:= 'Visualizza colonna riposi/fest.lav. da inizio anno';
  Modifica1.Enabled:=BRegistrazione.Enabled;
  CopiaPianificazione1.Enabled:=BRegistrazione.Enabled;
  Ind:=GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
  PProg:=GVista.Row - nRigheBloccate;
  ValidaCausale1.Enabled:=(A058FPianifTurniDtm1.Vista[PProg].Giorni[Ind].VAss = 'S') and (Parametri.T040_Validazione = 'S');
  InsCancGiust1.Enabled:=AssenzeAbilitate and ((A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') or A058FPianifTurniDtM1.AssenzeOperative);
  Indennitdifunzione1.Visible:=Trim(Parametri.CampiRiferimento.C3_Indennita_Funzione) <> '';
end;

procedure TA058FGrigliaPianif.Reperibilit1Click(Sender: TObject);
var
  PData:TDateTime;
  PProg,IGiorno:Integer;
begin
  with A058FPianifTurniDtm1 do
  begin
    PProg:=GVista.Row - nRigheBloccate;
    PData:=StrToDate(GVista.Cells[GVista.Col,0]);
    //IGiorno:=Trunc(PData - A058FPianifTurniDtm1.DataInizio);

    A058FPianifTurni.frmSelAnagrafe.SalvaC00SelAnagrafe;
    C700Distruzione;
    //OpenA040PianifRep(Vista[PProg].Prog,PData,'','','',PCausale,0,True);
    OpenA040PianifRep(Vista[PProg].Prog,'REPERIB',PData);
    C700DatiSelezionati:=C700CampiBase;
    C700Creazione(SessioneOracle);
    C700OldProgressivo:=-1;
    A058FPianifTurni.frmSelAnagrafe.RipristinaC00SelAnagrafe;
    A058FPianifTurniDtM1.RefreshReperibilità;
    (*RefreshAssenze(A058FPianifTurniDtm1.DataInizio,A058FPianifTurniDtm1.DataFine);
    ConteggiGiornalieri(StrToDate(GVista.Cells[GVista.Col,0]),PProg,IGiorno);
    DebitoDipendente(PProg,A058FPianifTurniDtm1.OffsetVista,
                     A058FPianifTurniDtm1.OffsetVista + Trunc(A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio));*)
    //Scorrere Vista[].Giorni[] e aggiornare TurnRep da selT380 refreshato per ogni progressivo
    //A058FPianifTurniDtm1.selT380.Refresh;
    GVista.Repaint;
  end;
end;

procedure TA058FGrigliaPianif.Indennitdifunzione1Click(Sender: TObject);
var PProg:Integer;
begin
  with A058FPianifTurniDtm1 do
  begin
    PProg:=GVista.Row - nRigheBloccate;
    A058FPianifTurni.frmSelAnagrafe.SalvaC00SelAnagrafe;
    C700Distruzione;
    OpenAc09IndFunzione(Vista[PProg].Prog,A058FPianifTurniDtm1.DataInizio,A058FPianifTurniDtm1.DataFine);
    C700DatiSelezionati:=C700CampiBase;
    C700Creazione(SessioneOracle);
    C700OldProgressivo:=-1;
    A058FPianifTurni.frmSelAnagrafe.RipristinaC00SelAnagrafe;
    GVista.Repaint;
  end;
end;

procedure TA058FGrigliaPianif.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if FastGiust <> '' then
  begin
    if (ssCtrl in Shift) and (Key = 84) then  //Se premo il tasto "T" cambio la pianificazione dei turni
    begin
      TastoPremuto:='';
      (*if FastGiust = 'T1' then
      begin
        FastGiust:='T2';
        LblModificaRapida.Caption:='Modifica rapida ''SECONDO TURNO''';
      end
      else*)
      begin
        FastGiust:='T1';
        LblModificaRapida.Caption:='Modifica rapida ''PRIMO TURNO''';
      end;
    end
    else if (ssCtrl in Shift) and (Key = 65) and (AssenzeAbilitate) then  //Se premo il tasto "A" cambio la pianificazione delle ASSENZE
    begin
      TastoPremuto:='';
      (*if FastGiust = 'A1' then
      begin
        FastGiust:='A2';
        LblModificaRapida.Caption:='Modifica rapida ''SECONDA ASSENZA''';
      end
      else*)
      begin
        FastGiust:='A1';
        LblModificaRapida.Caption:='Modifica rapida ''PRIMA ASSENZA''';
      end;
    end
    else if (ssCtrl in Shift) and (Key = 79) then  //Se premo il tasto "O" cambio la pianificazione degli ORARI
    begin
      TastoPremuto:='';
      if FastGiust <> 'O' then
      begin
        FastGiust:='O';
        LblModificaRapida.Caption:='Modifica rapida ''ORARIO''';
      end;
    end
  end;
end;

procedure TA058FGrigliaPianif.Visualizzadebito1Click(Sender: TObject);
var i,j:Integer;
    NGiorni:Integer;
begin
  //Alberto (Pescara)
  with A058FPianifTurniDtm1, A058FPianifTurni do
  if not(Visualizzadebito1.Checked) and not(ConteggiaDebito) then
    begin
      Screen.Cursor:=crHourGlass;
      ConteggiaDebito:=True;
      NGiorni:=Trunc(DataFine - DataInizio);
      for i:=0 to Vista.Count - 1 do
      begin
        for j:=0 to NGiorni do
          A058FPianifTurniDtM1.ConteggiGiornalieri(DataInizio + j,i,A058FPianifTurniDtm1.OffsetVista + j);
        DebitoDipendente(i,A058FPianifTurniDtm1.OffsetVista,A058FPianifTurniDtm1.OffsetVista + NGiorni);
      end;
      Screen.Cursor:=crDefault;
    end;
  if Visualizzadebito1.Checked then
    GVista.ColWidths[2]:=-1
  else
    GVista.ColWidths[2]:=110;
  Visualizzadebito1.Checked:=not Visualizzadebito1.Checked;
  A058FPianifTurni.bVisualizzaCompetenze:=Visualizzadebito1.Checked;
end;

procedure TA058FGrigliaPianif.Visualizzacolonnabadge1Click(Sender: TObject);
begin
  if Visualizzacolonnabadge1.Checked then
    GVista.ColWidths[0]:=-1
  else
    GVista.ColWidths[0]:=40;
  Visualizzacolonnabadge1.Checked:=not Visualizzacolonnabadge1.Checked;
  A058FPianifTurni.bVisualizzaBadge:=Visualizzacolonnabadge1.Checked;
end;

procedure TA058FGrigliaPianif.Visualizzacopertura1Click(Sender: TObject);
begin
  if Visualizzacopertura1.Checked then
    GVista.RowHeights[1]:=-1
  else
    GVista.RowHeights[1]:=60;
  Visualizzacopertura1.Checked:=not Visualizzacopertura1.Checked;
  A058FPianifTurni.bVisualizzaCoperura:=Visualizzacopertura1.Checked;
end;

procedure TA058FGrigliaPianif.VisualizzaCoperturaSquadre1Click(Sender: TObject);
var Ind:integer;
    ParData:TDateTime;
begin
  try
    Ind:=GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
    ParData:=StrToDate(GVista.Cells[GVista.Col,0]);
    OpenA058CoperturaSquadra(Ind,ParData);
  except
    Abort;
  end;
end;

procedure TA058FGrigliaPianif.VisualizzaturniClick(Sender: TObject);
begin
  if Visualizzaturni.Checked then
    GVista.ColWidths[3]:=-1
  else
    GVista.ColWidths[3]:=50;
  Visualizzaturni.Checked:=not Visualizzaturni.Checked;
  A058FPianifTurni.bVisualizzaTurni:=Visualizzaturni.Checked;
end;

procedure TA058FGrigliaPianif.Visualizzazionesintetica1Click(Sender: TObject);
begin
  Visualizzazionesintetica1.Checked:=not Visualizzazionesintetica1.Checked;
  A058FPianifTurni.bVisualizzaSintetica:=Visualizzazionesintetica1.Checked;
  if A058FPianifTurniDtM1.selT530.RecordCount = 0 then
    if Not Visualizzazionesintetica1.Checked then
    begin
      GVista.DefaultColWidth:=80;
      GVista.Font.Size:=8;
    end
    else
    begin
      GVista.DefaultColWidth:=57;
      GVista.Font.Size:=8;
    end
  else
  begin
    GVista.DefaultColWidth:=100;
    GVista.Font.Size:=8;
  end;
  //Ridefinizione delle colonne nascoste, perchè dopo il ridimensionamento della larghezza di default
  //tornano a dimensione originale
  GVista.ColWidths[1]:=80;
  if Not Visualizzadebito1.Checked then
    GVista.ColWidths[3]:=-1
  else
    GVista.ColWidths[3]:=50;
  if Not Visualizzadebito1.Checked then
    GVista.ColWidths[2]:=-1
  else
    GVista.ColWidths[2]:=110;
  if Not Visualizzaassenze.Checked then
    GVista.ColWidths[4]:=-1
  else
    GVista.ColWidths[4]:=110;
  if Not VisualizzaRiposiFestivi.Checked then
    GVista.ColWidths[5]:=-1
  else
    GVista.ColWidths[5]:=95;
  if Not Visualizzacolonnabadge1.Checked then
    GVista.ColWidths[0]:=-1
  else
    GVista.ColWidths[0]:=40;
  GVista.Repaint;
end;

procedure TA058FGrigliaPianif.ValidaCausale1Click(Sender: TObject);
var DataDa, DataA:TDateTime;
    Ind,PProg:Integer;
    Caus1, Caus2:String;
begin
  try
    Ind:=GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
    PProg:=GVista.Row - nRigheBloccate;
    DataDa:=StrToDate(GVista.Cells[GVista.Col,0]);
    DataA:=DataDa;
    if Ind >= 0 then
    begin
      Caus1:=A058FPianifTurniDtm1.Vista[PProg].Giorni[Ind].Ass1;
      Caus2:=A058FPianifTurniDtm1.Vista[PProg].Giorni[Ind].Ass2;
    end;
    if (A058FPianifTurniDtm1.Vista[PProg].Giorni[Ind].VAss = 'S') and
       (Ind >= 0) and (PProg >= 0) then
      OpenA058ValidaAssenze(PProg,DataDa,DataA,Caus1,Caus2);
    A058FPianifTurniDtM1.RefreshAssenze(A058FPianifTurniDtm1.DataInizio,A058FPianifTurniDtm1.DataFine);
    GVista.Repaint;
  except
    Abort;
  end;
end;

procedure TA058FGrigliaPianif.VisualizzaAssenze1Click(Sender: TObject);
begin
  A058FStampaAssenze:=TA058FStampaAssenze.Create(nil);
  try
    C001SettaQuickReport(A058FStampaAssenze.QRep);
    A058FPianifTurniDtM1.CreaTabStampaAss;
    A058FPianifTurniDtM1.CaricaTabStampaAss;
    A058FStampaAssenze.LEnte.Caption:=Parametri.RagioneSociale;
    A058FStampaAssenze.LTitolo.Caption:='Stampa assenze non validate';
    A058FStampaAssenze.QRep.Preview;
  finally
    A058FStampaAssenze.Free;
  end;
end;

procedure TA058FGrigliaPianif.VisualizzaassenzeClick(Sender: TObject);
begin
  if Visualizzaassenze.Checked then
    GVista.ColWidths[4]:=-1
  else
    GVista.ColWidths[4]:=110;
  Visualizzaassenze.Checked:=not Visualizzaassenze.Checked;
  A058FPianifTurni.bVisualizzaAssenze:=Visualizzaassenze.Checked;
end;

procedure TA058FGrigliaPianif.VisualizzaRiposiFestiviClick(Sender: TObject);
begin
  if VisualizzaRiposiFestivi.Checked then
    GVista.ColWidths[5]:=-1
  else
    GVista.ColWidths[5]:=95;
  VisualizzaRiposiFestivi.Checked:=not VisualizzaRiposiFestivi.Checked;
  A058FPianifTurni.bVisualizzaRiposiFestivi:=VisualizzaRiposiFestivi.Checked;
  if (A058FPianifTurni.bVisualizzaRiposiFestivi) and (not RiposiFestiviCalcolati) then
  begin
    // Se devo visualizzare la colonna e non ho mai calcolato i riposi e i festivi lavorati, lancio
    // il calcolo. I dati non cambiano mai, quindi è sufficiente elaborarli una volta sola.
    A058FPianifTurniDtm1.CalcolaRiposiFestivi;
    RiposiFestiviCalcolati:=True;
  end;
end;

procedure TA058FGrigliaPianif.CompetenzeResiduiassenza1Click(Sender: TObject);
{Visualizzazione Competenze/Residui della causale specificata}
var Data:TDateTime;
    i,j:Integer;
    Giustif:TGiustificativo;
    R600DtM1:TR600DtM1;
begin
  with A058FPianifTurniDtm1 do
  begin
    i:=GVista.Row - nRigheBloccate;
    j:=GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
    if Vista[i].Giorni[j].Ass1 = '' then
    begin
      R180MessageBox('Nessun giustificativo di assenza trovato nel giorno corrente.',ESCLAMA);
      exit;
    end;
    Data:=A058FPianifTurniDtm1.DataInizio + j;
    Giustif.Modo:='I';
    Giustif.Causale:=Vista[i].Giorni[j].Ass1;//'FERIE';
    Giustif.DaOre:='';
    Giustif.AOre:='';
    R600DtM1:=TR600Dtm1.Create(Self);
    R600DtM1.VisualizzaAssenze(Vista[i].Prog,Data,Giustif);
    FreeAndNil(R600DtM1);
  end;
end;

procedure TA058FGrigliaPianif.Copiapianificazione1Click(Sender: TObject);
var
  DI,DF:TDate;
  ProgSorgente,ProgDestinazione:Integer;
  GVistaDrawCellEvent:TDrawCellEvent;
  procedure EseguiCopiaPianificazione(Progressivo1,Progressivo2:Integer;
                                      DataInizio,DataFine:TDate;
                                      CopiaAncheTurnazione:Boolean);
  var i1,i2,i:Integer;
  begin
    i1:=-1;
    i2:=-1;
    //Inizializzazione variabili di copia
    if CopiaAncheTurnazione then
      A058FPianifTurniDtm1.PckTurno.SetVariabiliCopiaTurnazione(Progressivo1,Progressivo2,DataInizio,DataFine);
    for i:=0 to A058FPianifTurniDtm1.Vista.Count - 1 do
    begin
      if A058FPianifTurniDtm1.Vista[i].Prog = Progressivo1 then
        i1:=i;
      if A058FPianifTurniDtm1.Vista[i].Prog = Progressivo2 then
        i2:=i;
      if (i1 >= 0) and (i2 >= 0) then
        Break;
    end;
    if (i1 >= 0) and (i2 >= 0) then
    begin
      DatoModificato:=True;
      for i:=0 to Trunc(A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio) do
      begin
        if (A058FPianifTurniDtm1.DataInizio + i >= DataInizio) and ((A058FPianifTurniDtm1.DataInizio + i <= DataFine)) then
        begin
          A058FPianifTurniDtm1.Vista[i2].Giorni[i].T1:=A058FPianifTurniDtm1.Vista[i1].Giorni[i].T1;
          A058FPianifTurniDtm1.Vista[i2].Giorni[i].T2:=A058FPianifTurniDtm1.Vista[i1].Giorni[i].T2;
          A058FPianifTurniDtm1.Vista[i2].Giorni[i].SiglaT1:=A058FPianifTurniDtm1.Vista[i1].Giorni[i].SiglaT1;
          A058FPianifTurniDtm1.Vista[i2].Giorni[i].SiglaT2:=A058FPianifTurniDtm1.Vista[i1].Giorni[i].SiglaT2;
          A058FPianifTurniDtm1.Vista[i2].Giorni[i].NumTurno1:=A058FPianifTurniDtm1.Vista[i1].Giorni[i].NumTurno1;
          A058FPianifTurniDtm1.Vista[i2].Giorni[i].NumTurno2:=A058FPianifTurniDtm1.Vista[i1].Giorni[i].NumTurno2;
          A058FPianifTurniDtm1.Vista[i2].Giorni[i].T1EU:=A058FPianifTurniDtm1.Vista[i1].Giorni[i].T1EU;
          A058FPianifTurniDtm1.Vista[i2].Giorni[i].T2EU:=A058FPianifTurniDtm1.Vista[i1].Giorni[i].T2EU;
          A058FPianifTurniDtm1.Vista[i2].Giorni[i].Ora:=A058FPianifTurniDtm1.Vista[i1].Giorni[i].Ora;
          A058FPianifTurniDtm1.Vista[i2].Giorni[i].Modificato:=True;
          A058FPianifTurniDtM1.ConteggiGiornalieri(A058FPianifTurniDtm1.DataInizio + i,i2,i);
          A058FPianifTurniDtm1.DebitoDipendente(i2,0,Trunc(A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio));
          A058FPianifTurniDtm1.AggiornaContatoriTurni(i2,i);
        end;
      end;
    end;
  end;
begin
  DI:=0;
  DF:=0;
  ProgSorgente:=0;
  ProgDestinazione:=0;
  A058FCopiaPianificazione:=TA058FCopiaPianificazione.Create(nil);
  with A058FCopiaPianificazione, A058FPianifTurniDtm1 do
  try
    cdsAnagrafiche.Edit;
    cdsAnagrafiche.FieldByName('PROGRESSIVO1').AsInteger:=Vista[GVista.Row - nRigheBloccate].Prog;
    cdsAnagrafiche.FieldByName('PROGRESSIVO2').AsInteger:=Vista[GVista.Row - nRigheBloccate].Prog;
    cdsAnagrafiche.Post;
    edtDaData.Text:=DateToStr(A058FPianifTurniDtm1.DataInizio);
    edtAData.Text:=DateToStr(A058FPianifTurniDtm1.DataFine);
    if (ShowModal = mrOK) then
    begin
      DI:=StrToDate(edtDaData.Text);
      DF:=StrToDate(edtAData.Text);
      if (rdbSingoloDip.Checked) then
      begin
        // Copia singolo dipendente
        if (cdsAnagrafiche.FieldByName('PROGRESSIVO1').AsInteger <> cdsAnagrafiche.FieldByName('PROGRESSIVO2').AsInteger) then
          EseguiCopiaPianificazione(cdsAnagrafiche.FieldByName('PROGRESSIVO1').AsInteger,
                                    cdsAnagrafiche.FieldByName('PROGRESSIVO2').AsInteger,
                                    DI,DF,chkRendiDefinitive.Checked);
      end
      else
      begin
        // Copia da singolo dipendente a tutti gli altri della selezione corrente
        Screen.Cursor:=crHourGlass;
        PGVista.Max:=C700SelAnagrafe.RecordCount - 1;
        PGVista.Position:=0;
        LblOPerazioni.Caption:='';
        GVistaDrawCellEvent:=GVista.OnDrawCell;
        GVista.OnDrawCell:=nil; // se viene ridisegnata di continuo la griglia l'operazione rallenta molto
        try
          ProgSorgente:=cdsAnagrafiche.FieldByName('PROGRESSIVO1').AsInteger;
          C700SelAnagrafe.First;
          while not C700SelAnagrafe.Eof do
          begin
            ProgDestinazione:=C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
            if ProgSorgente <> ProgDestinazione then
            begin
              LblOPerazioni.Caption:=Format(A000MSG_A058_MSG_FMT_COPIA_IN_CORSO,
                                            [C700SelAnagrafe.FieldByName('COGNOME').AsString + ' ' + C700SelAnagrafe.FieldByName('NOME').AsString]);
              Application.ProcessMessages;
              EseguiCopiaPianificazione(ProgSorgente,
                                        ProgDestinazione,
                                        DI,DF,False);
              PGVista.StepIt;
              Application.ProcessMessages;
            end;
            C700SelAnagrafe.Next;
          end;
          C700SelAnagrafe.First;
        finally
          LblOPerazioni.Caption:='';
          PGVista.Position:=0;
          Screen.Cursor:=crDefault;
          GVista.OnDrawCell:=GVistaDrawCellEvent;
          GVista.Repaint;
        end;
      end;
    end;
  finally
    Release;
  end;
end;

procedure TA058FGrigliaPianif.Visualizzadettaglioorariogiornaliero1Click(Sender: TObject);
begin
  if A058FDettaglioGiornata <> nil then
    exit;
  A058FDettaglioGiornata:=TA058FDettaglioGiornata.Create(nil);
  GVistaClick(nil);
  A058FDettaglioGiornata.Show;
end;

procedure TA058FGrigliaPianif.GVistaClick(Sender: TObject);
var i,j:Integer;
    O:String;
    D:TDateTime;
begin
  i:=GVista.Row - nRigheBloccate;
  j:=GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
  D:=A058FPianifTurniDtm1.DataInizio + j;
  with A058FPianifTurniDtm1 do
  begin
    O:=Vista[i].Giorni[j].Ora;
    if A058FDettaglioGiornata <> nil then
    begin
      Q021.Filter:='CODICE = ''' + O + '''';
      Q021.Filtered:=True;
      RefreshQ021(D);
      begin
        if O <> '' then
          A058FDettaglioGiornata.Caption:='Dettaglio orario ''' + O + ''''
        else
          A058FDettaglioGiornata.Caption:='Nessun orario pianificato';
      end;
    end;
  end;
end;

procedure TA058FGrigliaPianif.FormShow(Sender: TObject);
var bCanSelect:boolean;
begin
  bCanSelect:=True;
  //BtnVerificaTurni.Visible:=False;
  GVistaSelectCell(nil,nColonneBloccate,nRigheBloccate,bCanSelect);
  if A058FPianifTurni.bVisualizzaCoperura then
    Visualizzacopertura1Click(nil);
  if A058FPianifTurni.bVisualizzaCompetenze then
    Visualizzadebito1Click(nil);
  if A058FPianifTurni.bVisualizzaTurni then
    VisualizzaturniClick(nil);
  if A058FPianifTurni.bVisualizzaRiposiFestivi then
    VisualizzaRiposiFestiviClick(nil);
  if A058FPianifTurni.bVisualizzaBadge then
    Visualizzacolonnabadge1Click(nil);
  if A058FPianifTurni.bVisualizzaSintetica then
    Visualizzazionesintetica1Click(nil);
end;

procedure TA058FGrigliaPianif.GVistaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if FastGiust = '' then
    exit;
  LeggiValoriCella;
end;

procedure TA058FGrigliaPianif.LeggiValoriCella;
var
  i,j:Integer;
begin
  i:=GVista.Row - nRigheBloccate;
  j:=GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
  with A058FPianifTurniDtm1 do
  begin
    with Vista[i].Giorni[j] do
    begin
      //Leggo i valori presenti nella cella
      sNumTurno1:=NumTurno1;
      sNumTurno2:=NumTurno2;
      sT1EU:=T1EU;
      sT2EU:=T2EU;
      sAss1:=Ass1;
      sAss2:=Ass2;
    end;
  end;
end;

procedure TA058FGrigliaPianif.Visualizzalimititipologieprofessionali1Click(
  Sender: TObject);
begin
  If A058FDettaglioTipiOperatori <> nil then
    exit;
  A058FDettaglioTipiOperatori:=TA058FDettaglioTipiOperatori.Create(nil);
  with A058FDettaglioTipiOperatori do
    A058FDettaglioTipiOperatori.Show;
end;

procedure TA058FGrigliaPianif.BtnVerificaTurniClick(Sender: TObject);
var i,j:Integer;
begin
  //DataCorr va tra DataInizio e DataFine
  //DataInizioAnno
  //TGiorno(TDipendente(Vista[Dip].Giorno[Trunc(DataCorr - DataInizioAnno)]).Ore
  //btnAnomalie.Enabled:=False;
  Self.Enabled:=False;
  //Self.KeyPreview:=True;
  GVista.OnDrawCell:=nil;
  Self.OnKeyPress:=FormKeyPress;

  GVista.Enabled:=False;
  try
    A058FPianifTurniDtM1.VerificaPianificazione(A058FPianifTurniDtm1.DataInizio,A058FPianifTurniDtm1.DataFine,'N');
  finally
    GVista.Enabled:=True;
  end;

  //Self.KeyPreview:=False;
  Self.Enabled:=True;
  Self.OnKeyPress:=nil;
  GVista.OnDrawCell:=GVistaDrawCell;
  LblOPerazioni.Caption:='';
  GVista.Repaint;
  //A058FPianifTurni.NuovaPianif:=True;
  if A058FPianifTurniDtM1.AnomaliePianif then
  //btnAnomalie.Enabled:=True;
  A058FPianifTurniDtm1.ConteggiaDebito:=False;
  if Visualizzadebito1.Checked then
    Visualizzadebito1Click(nil);

//===========================================================
//AGGIORNAMENTO MAX/MIN GIORNALIERI DOPO L'ELABORAZIONE TURNI
//===========================================================
  LblOPerazioni.Caption:='Ricalcolo dei massimi, minimi e indennità di turno.';
  Application.ProcessMessages;

  if (GVista.RowHeights[1] > 0) or (GVista.ColWidths[3] > 0) then
    with A058FPianifTurniDtm1 do
    begin
      SetLength(aTotaleTurni,0);
      for i:=0 to Vista.Count -1 do
      begin
        if High(aTotaleTurni) <= 0 then
          SetLength(aTotaleTurni, Vista[0].Giorni.Count);
        Vista[i].TotaleTurniMese.Turno1:=0;
        Vista[i].TotaleTurniMese.Turno2:=0;
        Vista[i].TotaleTurniMese.Turno3:=0;
        Vista[i].TotaleTurniMese.Turno4:=0;
        for j:=A058FPianifTurniDtm1.OffsetVista to (GVista.ColCount + A058FPianifTurniDtm1.OffsetVista - nColonneBloccate - 1) do
        begin
          //A058FPianifTurni.AggiornaTotaleTurni(i);
          if (Vista[i].Giorni[j].T1EU <> 'U') and (Vista[i].Giorni[j].Ass1 = '') then
            if Vista[i].Giorni[j].NumTurno1 = '1' then
            begin
              inc(aTotaleTurni[j - A058FPianifTurniDtm1.OffsetVista].Turno1);
              inc(Vista[i].TotaleTurniMese.Turno1);
            end else if Vista[i].Giorni[j].NumTurno1 = '2' then
            begin
              inc(aTotaleTurni[j - A058FPianifTurniDtm1.OffsetVista].Turno2);
              inc(Vista[i].TotaleTurniMese.Turno2);
            end else if Vista[i].Giorni[j].NumTurno1 = '3' then
            begin
              inc(aTotaleTurni[j - A058FPianifTurniDtm1.OffsetVista].Turno3);
              inc(Vista[i].TotaleTurniMese.Turno3);
            end else if Vista[i].Giorni[j].NumTurno1 = '4' then
            begin
              inc(aTotaleTurni[j - A058FPianifTurniDtm1.OffsetVista].Turno4);
              inc(Vista[i].TotaleTurniMese.Turno4);
            end;
          if (Vista[i].Giorni[j].T2EU <> 'U') and (Vista[i].Giorni[j].Ass2 = '') then
            if Vista[i].Giorni[j].NumTurno2 = '1' then
            begin
              inc(aTotaleTurni[j - A058FPianifTurniDtm1.OffsetVista].Turno1);
              inc(Vista[i].TotaleTurniMese.Turno1);
            end else if Vista[i].Giorni[j].NumTurno2 = '2' then
            begin
              inc(aTotaleTurni[j - A058FPianifTurniDtm1.OffsetVista].Turno2);
              inc(Vista[i].TotaleTurniMese.Turno2);
            end else if Vista[i].Giorni[j].NumTurno2 = '3' then
            begin
              inc(aTotaleTurni[j - A058FPianifTurniDtm1.OffsetVista].Turno3);
              inc(Vista[i].TotaleTurniMese.Turno3);
            end else if Vista[i].Giorni[j].NumTurno2 = '4' then
            begin
              inc(aTotaleTurni[j - A058FPianifTurniDtm1.OffsetVista].Turno4);
              inc(Vista[i].TotaleTurniMese.Turno4);
            end;
        end;
      end;
      GVista.Repaint;
    end;
  LblOPerazioni.Caption:='';
  DatoModificato:=True;
//=================================================================
end;

procedure TA058FGrigliaPianif.FormKeyPress(Sender: TObject; var Key: Char);
begin
  //ESC funziona solo se ho cliccato su Verifica Turni
  if (Key = #27) and (not Self.Enabled) then
    if MessageDlg('Interrompere l''elaborazione?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
      A058FPianifTurniDtM1.ElaborazioneInterrotta:=True;
end;

end.


