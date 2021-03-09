unit C001UScegliCampi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DBCtrls,C001StampaLib,C001UFiltroTabelle, ComCtrls, DB, Variants,
  A000UInterfaccia;

type
  TC001FScegliCampi = class(TForm)
    Panel1: TPanel;
    LblNonSelezionati: TLabel;
    ListBoxNonScelti: TListBox;
    BtnRight: TButton;
    BtnAllRight: TButton;
    BtnAllLeft: TButton;
    BtnLeft: TButton;
    ListBoxScelti: TListBox;
    LblSelezionati: TLabel;
    Button5: TButton;
    Button6: TButton;
    Bevel1: TBevel;
    PageControl1: TPageControl;
    Intervallo: TTabSheet;
    LblCampoSelezionato: TLabel;
    LblSelezionaIntervallo: TLabel;
    LblDa: TLabel;
    LblA: TLabel;
    Ordinamento: TTabSheet;
    RdBtnAscendente: TRadioButton;
    RdBtnDiscendente: TRadioButton;
    LblCampoCorrente: TLabel;
    RdBtnOrdinato: TRadioButton;
    Intestazioni: TTabSheet;
    LblCorrenteCampo: TLabel;
    EdtIntestazione: TEdit;
    Label1: TLabel;
    CkBGruppo: TCheckBox;
    cmbIntervalloDa: TComboBox;
    cmbIntervalloA: TComboBox;
    procedure DBLookupComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnAllRightClick(Sender: TObject);
    procedure BtnAllLeftClick(Sender: TObject);
    procedure ListBoxSceltiClick(Sender: TObject);
    procedure BtnRightClick(Sender: TObject);
    procedure BtnLeftClick(Sender: TObject);
    procedure ListBoxSceltiMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBoxSceltiMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cmbIntervalloDaChange(Sender: TObject);
    procedure cmbIntervalloAChange(Sender: TObject);
    procedure ListBoxNonSceltiMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBoxNonSceltiClick(Sender: TObject);
    procedure RdBtnAscendenteClick(Sender: TObject);
    procedure RdBtnDiscendenteClick(Sender: TObject);
    procedure RdBtnOrdinatoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtIntestazioneChange(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure CkBGruppoClick(Sender: TObject);
    procedure EdtIntestazioneEnter(Sender: TObject);

  private
    { Private declarations }
    PrimoItem:integer;
    ActiveListBox:TListBox;
    CampoCorrente: string;
    procedure ScambiaSelezionati(List1,List2:TListBox);
    procedure ScambiaTutti(Btn2,Btn3:TButton;List1,List2:TListBox);
    procedure ClikkaLista(list1:tlistbox;btn1,btn2:Tbutton);
    procedure SalvaPrimoItem(lista:TListBox; x,y:integer);
    procedure MuoviItem(lista:TListBox; x,y:integer);
    procedure CreaQDistinct(Campo:String);
    function CampoAnagrafico(Campo : String) : Boolean;
    procedure AggiornaListaCampi;
    procedure RipristinaListaCampi;
    procedure AzzeraCampiGruppo(NumeroBanda : Integer);
  public
    { Public declarations }
    procedure CaricaListBox(ListBox:TListBox; Selezionato:Boolean; Max:Integer);
    procedure SettaOrdinamento(Campo : String;Ordi,Asce : Boolean);
    procedure SettaIntervallo(Campo,Da,A:String);
    procedure SettaIntestazione(Campo,Valore:String);

    function GetIntestazione(Campo : String) : String;
    function GetIntervallo(Campo : String;Da : Boolean) : String;
    function GetOrdinato(Campo : String) : Boolean;
    function GetAscendente(Campo : String) : Boolean;

    function CercaCampo(Campo : String) : TRec_Campi;
  end;

var
  C001FScegliCampi: TC001FScegliCampi;

implementation

uses C001UFiltroTabelleDTM,C001USettings;

{$R *.DFM}

procedure TC001FScegliCampi.CaricaListBox(ListBox:TListBox; Selezionato:Boolean; Max:Integer);
var I : Integer;
begin
  ListBox.Items.Clear;
  for I:=0 to Max do
     begin
       RecCampi:=ListaCampi[I];
       if RecCampi.Selezionato = Selezionato then
        ListBox.Items.Add(RecCampi.Nome);
     end;
end;

procedure TC001FScegliCampi.SettaOrdinamento(Campo : String;Ordi,Asce : Boolean);
var I : Integer;
begin
  for I:=0 to ListaCampi.Count - 1 do
     begin
       RecCampi:=ListaCampi[I];
       if RecCampi.Nome = Campo then
         begin
           RecCampi.Ordinato:=Ordi;
           RecCampi.Ascendente:=Asce;
           Break;
         end;
     end;
end;

procedure TC001FScegliCampi.SettaIntervallo(Campo,Da,A : String);
var I : Integer;
begin
  for I:=0 to ListaCampi.Count - 1 do
     begin
       RecCampi:=ListaCampi[I];
       if RecCampi.Nome = Campo then
         begin
           RecCampi.Da:=Da;
           RecCampi.A:=A;
           Break;
         end;
     end;
end;

procedure TC001FScegliCampi.SettaIntestazione(Campo,Valore : String);
var I : Integer;
begin
  for I:=0 to ListaCampi.Count - 1 do
     begin
       RecCampi:=ListaCampi[I];
       if RecCampi.Nome = Campo then
         begin
           RecCampi.Intestazione:=Valore;
           Break;
         end;
     end;
end;

function TC001FScegliCampi.GetIntervallo(Campo : String;Da : Boolean) : String;
var I : Integer;
begin
  Result:='';
  for I:=0 to ListaCampi.Count - 1 do
     begin
       RecCampi:=ListaCampi[I];
       if RecCampi.Nome = Campo then
         begin
           if Da then
             Result:=RecCampi.Da
           else
             Result:=RecCampi.A;
           Break;
         end;
     end;
end;

function TC001FScegliCampi.GetOrdinato(Campo : String) : Boolean;
var I : Integer;
begin
  Result:=False;
  for I:=0 to ListaCampi.Count - 1 do
     begin
       RecCampi:=ListaCampi[I];
       if RecCampi.Nome = Campo then
         begin
           Result:=RecCampi.Ordinato;
           Break;
         end;
     end;
end;

function TC001FScegliCampi.GetAscendente(Campo : String) : Boolean;
var I : Integer;
begin
  Result:=False;
  for I:=0 to ListaCampi.Count - 1 do
     begin
       RecCampi:=ListaCampi[I];
       if RecCampi.Nome = Campo then
         begin
           Result:=RecCampi.Ascendente;
           Break;
         end;
     end;
end;

function TC001FScegliCampi.GetIntestazione(Campo : String) : String;
var I : Integer;
begin
  Result:='';
  for I:=0 to ListaCampi.Count - 1 do
     begin
       RecCampi:=ListaCampi[I];
       if RecCampi.Nome = Campo then
         begin
           Result:=RecCampi.Intestazione;
           Break;
         end;
     end;
end;

function TC001FScegliCampi.CercaCampo(Campo : String) : TRec_Campi;
var I : Integer;
begin
  Result:=nil;
  for I:=0 to ListaCampi.Count - 1 do
     begin
       RecCampi:=ListaCampi[I];
       if RecCampi.Nome = Campo then
         begin
           Result:=ListaCampi[I];
           Break;
         end;
     end;
end;

procedure TC001FScegliCampi.AggiornaListaCampi;
var I : Integer;
begin
  for I:=0 to NCampi-1 do
     begin
       RecCampi:=ListaCampi[I];
       RecCampi.Selezionato:=(ListBoxScelti.Items.IndexOf(RecCampi.Nome) <> -1);
       RecCampi.OldSelezionato:=RecCampi.Selezionato;
       if RecCampi.Selezionato then
         RecCampi.Posizione:=ListBoxScelti.Items.IndexOf(RecCampi.Nome)
       else
         RecCampi.Posizione:=ListBoxNonScelti.Items.IndexOf(RecCampi.Nome);
       RecCampi.OldPosizione:=RecCampi.Posizione;
       RecCampi.OldDa:=RecCampi.Da;
       RecCampi.OldA:=RecCampi.A;
       RecCampi.OldOrdinato:=RecCampi.Ordinato;
       RecCampi.OldAscendente:=RecCampi.Ascendente;
       RecCampi.OldIntestazione:=RecCampi.Intestazione;
       if (RecCampi.OldGruppo = True)and(RecCampi.Gruppo=False) then
         begin
           if RecCampi.NumBanda >= 0 then
             begin
               AzzeraCampiGruppo(RecCampi.NumBanda);
//               RecCampi.SelGruppo:=False;
//               RecCampi.NumBanda:=-1;
//               RecCampi.Posi:=-1;
             end;
         end;
       RecCampi.OldGruppo:=RecCampi.Gruppo;
     end;
end;

procedure TC001FScegliCampi.RipristinaListaCampi;
var I : Integer;
begin
  for I:=0 to NCampi-1 do
     begin
       RecCampi:=ListaCampi[I];
       RecCampi.Selezionato:=RecCampi.OldSelezionato;
       RecCampi.Intestazione:=RecCampi.OldIntestazione;
       RecCampi.Da:=RecCampi.OldDa;
       RecCampi.A:=RecCampi.OldA;
       RecCampi.Ordinato:=RecCampi.OldOrdinato;
       RecCampi.Ascendente:=RecCampi.OldAscendente;
       RecCampi.Posizione:=RecCampi.OldPosizione;
       RecCampi.Gruppo:=RecCampi.OldGruppo;
     end;
end;

procedure TC001FScegliCampi.ScambiaSelezionati(List1,List2:TListBox);
var I : Integer;
    Elementi : Integer;
begin
  Elementi:= List1.Items.Count;
  if List1.Selcount < 1 then
    Showmessage('Nessun campo selezionato')
  else
    begin
      I:=0;
      while I <= (Elementi-1) do
        if List1.Selected[i] then
          begin
            if List2.Items.Indexof(List1.Items[I]) = (-1) then
              List2.Items.AddObject(List1.Items[I],List1.Items.Objects[I]);
            List1.Items.Delete(I);
            Elementi:=Elementi-1;
          end
        else
          I:=I+1;
    end;
  BtnRight.Enabled:=False;
  BtnAllRight.Enabled:=ListBoxNonScelti.Items.Count>0;
  BtnAllLeft.Enabled:=ListBoxScelti.Items.Count>0;
  BtnLeft.Enabled:=False;
end;

procedure TC001FScegliCampi.ScambiaTutti(Btn2,Btn3:TButton;List1,List2:TListBox);
var I:Integer;
begin
  for I:=1 to List1.Items.Count do
     List2.Items.AddObject(List1.Items[I-1],List1.Items.Objects[I-1]);
  Btn2.Enabled:=False;
  Btn3.Enabled:=True;
  List1.Items.Clear;
end;

procedure TC001FScegliCampi.ClikkaLista(list1:tlistbox;btn1,btn2:Tbutton);
begin
  Btn1.Enabled:=List1.Selcount>0;
  BtnAllRight.Enabled:=ListBoxNonScelti.Items.Count>0;
  BtnAllLeft.Enabled:=ListBoxScelti.Items.Count>0;
end;

procedure TC001FScegliCampi.SalvaPrimoItem(Lista:TListBox; X,Y:integer);
var Punto:TPoint;
begin
  Punto.X:=X;
  Punto.Y:=Y;
  if Lista.itematpos(punto,true)<>-1 then
    C001FScegliCampi.PrimoItem:=Lista.ItemAtPos(Punto,True);
end;

procedure TC001FScegliCampi.MuoviItem(lista:TListBox; x,y:integer);
var Punto:TPoint;
begin
  Punto.X:=X;
  Punto.Y:= Y;
  if (Lista.ItemAtPos(Punto,True)<>-1)and(Lista.ItemAtPos(Punto,True)<>C001FScegliCampi.PrimoItem) then
    Lista.Items.Move(C001FscegliCampi.PrimoItem,Lista.ItemAtPos(Punto,True));
end;

procedure TC001FScegliCampi.FormActivate(Sender: TObject);
begin
  ActiveListBox:=ListBoxNonScelti;
  CaricaListBox(ListBoxScelti,True,NCampi-1);
  CaricaListBox(ListBoxNonScelti,False,NCampi-1);
  if ListBoxScelti.Items.Count<0 then
    begin
      BtnAllRight.Enabled:=True;
      BtnAllLeft.Enabled:=False;
    end
  else
    begin
      BtnAllRight.Enabled:=False;
      BtnAllLeft.Enabled:=True;
    end;
  BtnRight.Enabled:=False;
  BtnLeft.Enabled:=False;
  BringToFront;
     //   Gestione Intervalli
  ListBoxNonScelti.ItemIndex:=-1;
  ListBoxScelti.ItemIndex:=-1;
  LblCampoSelezionato.caption:='';
  LblCampoCorrente.caption:='';
  cmbIntervalloDa.Text:='';
  cmbIntervalloA.Text:='';
  if StampaAnagrafico then
    begin
      //Ordinamento.TabVisible:=False;
      Intervallo.TabVisible:=False;
      PageControl1.ActivePage:=Intestazioni;
    end;
end;


procedure TC001FScegliCampi.FormDestroy(Sender: TObject);
begin
  C001FFiltroTabelle.Visible:=True;
end;

procedure TC001FScegliCampi.BtnAllRightClick(Sender: TObject);
begin
  ScambiaTutti(BtnAllRight,BtnAllLeft,ListBoxNonScelti,ListBoxScelti);
  C001FFiltroTabelle.VariazioneCampi:=True;
end;

procedure TC001FScegliCampi.BtnAllLeftClick(Sender: TObject);
begin
  ScambiaTutti(BtnAllLeft,BtnAllRight,ListBoxScelti,ListBoxNonScelti);
  C001FFiltroTabelle.VariazioneCampi:=True;
end;

procedure TC001FScegliCampi.ListBoxSceltiClick(Sender: TObject);
begin
  ClikkaLista(ListBoxScelti,BtnLeft,BtnAllLeft);
end;

procedure TC001FScegliCampi.ListBoxNonSceltiClick(Sender: TObject);
begin
  ClikkaLista(ListBoxNonScelti,BtnRight,BtnAllRight);
end;

procedure TC001FScegliCampi.BtnRightClick(Sender: TObject);
begin
  ScambiaSelezionati(ListBoxNonScelti,ListBoxScelti);
  C001FFiltroTabelle.VariazioneCampi:=True;
end;

procedure TC001FScegliCampi.BtnLeftClick(Sender: TObject);
begin
  RecCampi:=CercaCampo(CampoCorrente);
  if RecCampi <> nil then
    begin
      RecCampi.Intestazione:='';
      RecCampi.Da:='';
      RecCampi.A:='';
      RecCampi.Ordinato:=False;
      RecCampi.Ascendente:=False;
      RecCampi.Gruppo:=False;
    end;
  ScambiaSelezionati(ListBoxScelti,ListBoxNonScelti);
  CampoCorrente:='';
  RdBtnAscendente.Enabled:=False;
  RdBtnDiscendente.Enabled:=False;
  RdBtnOrdinato.Enabled:=False;
  CkBGruppo.Enabled:=False;
  LblCampoCorrente.Caption:='Campo Selezionato:';
  C001FFiltroTabelle.VariazioneCampi:=True;
end;

procedure TC001FScegliCampi.ListBoxSceltiMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     MuoviItem(C001FScegliCampi.ListBoxScelti,x,y);
end;

procedure TC001FScegliCampi.cmbIntervalloDaChange(Sender: TObject);
begin
  RecCampi:=CercaCampo(CampoCorrente);
  if (ActiveListBox.Items.Count > 0)and(RecCampi <> nil) then
    RecCampi.Da:=cmbIntervalloDa.Text;
end;

procedure TC001FScegliCampi.cmbIntervalloAChange(Sender: TObject);
begin
  RecCampi:=CercaCampo(CampoCorrente);
  if (ActiveListBox.Items.Count>0)and(RecCampi <> nil) then
    RecCampi.A:=cmbIntervalloA.Text;
end;

procedure TC001FScegliCampi.PageControl1Change(Sender: TObject);
{Se cambio la pagina su intervallo apro la Query}
begin
  if PageControl1.ActivePage = Intervallo then
    with C001FFiltroTabelleDtM.QDistinct do
      if PageControl1.ActivePage = Intervallo then
        if not Active then
          try
            Open;
          except
            Close;
          end;
end;

procedure TC001FScegliCampi.CreaQDistinct(Campo:String);
{Costruisco la frase SQL per estrarre i dati da visualizzare nel Range}
var FraseSQL,CampoApp:String;
begin
  if Pos(' ' + Campo + ' ',UpperCase(C001FFiltroTabelleDTM.Query2.FieldByName(Campo).DisplayLabel) + ' ') > 0 then
    CampoAPP:=C001FFiltroTabelleDTM.Query2.FieldByName(Campo).DisplayLabel
  else
    CampoAPP:=C001FFiltroTabelleDTM.Query2.FieldByName(Campo).DisplayLabel + ' ' + Campo;
  FraseSQL:='SELECT DISTINCT ' + CampoApp + ' ' + C001FFiltroTabelle.FROM_SQL + ' ORDER BY '  + Campo;
  with C001FFiltroTabelleDtM.QDistinct do
  begin
    if SQL.Count = 0 then
    begin
      Close;
      SQL.Clear;
      SQL.Add(FraseSQL);
    end
    else if SQL.Strings[0] <> FraseSQL then
    begin
      Close;
      SQL.Clear;
      SQL.Add(FraseSQL);
    end;
    cmbIntervalloDa.Items.Clear;
    cmbIntervalloA.Items.Clear;
    cmbIntervalloDa.Text:='';
    cmbIntervalloA.Text:='';
    Screen.Cursor:=crHourGlass;
    try
      Open;
      First;
      while not Eof do
      begin
        cmbIntervalloDa.Items.Add(Fields[0].AsString);
        cmbIntervalloA.Items.Add(Fields[0].AsString);
        Next;
      end;
    finally
      Screen.Cursor:=crDefault;
    end;
    (*
    if PageControl1.ActivePage = Intervallo then
      if not Active then
        try
          Screen.Cursor:=crHourGlass;
          Open;
          DBLkpCbBxDa.DataField:='LookupDa';
          DBLkpCbBxA.DataField:='LookupA';
          Screen.Cursor:=crDefault;
        except
          Screen.Cursor:=crDefault;
          Close;
        end;
    *)
  end;
end;

procedure TC001FScegliCampi.ListBoxNonSceltiMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if ListBoxNonScelti.Items.Count>0 then
       begin
         RecCampi:=CercaCampo(CampoCorrente);
         LblCampoSelezionato.Caption:='Campo Selezionato: '+chr(13)+ListBoxNonScelti.Items[ListBoxNonScelti.itemindex];
         CampoCorrente:=ListBoxNonScelti.Items[ListBoxNonScelti.itemindex];
         LblCorrenteCampo.caption:='Campo Selezionato: '+chr(13)+CampoCorrente;
         EdtIntestazione.Text:=GetIntestazione(CampoCorrente);
         CreaQDistinct(CampoCorrente);
         if RecCampi <> nil then
           begin
             cmbIntervalloDa.Text:=RecCampi.Da;
             cmbIntervalloA.Text:=RecCampi.A;
           end;
       end
    else
      begin
        CampoCorrente:='';
        LblCampoSelezionato.Caption:='Campo Selezionato:';
        LblCorrenteCampo.caption:='Campo Selezionato:';
        cmbIntervalloDa.Text:='';
        cmbIntervalloA.Text:='';
        RdBtnOrdinato.Checked:=true;
      end;
     EdtIntestazione.Text:=GetIntestazione(CampoCorrente);
     LblCampoCorrente.Caption:='Campo Selezionato:';
     ActiveListBox:=ListBoxNonScelti;
     RdBtnAscendente.Enabled:=false;
     RdBtnDiscendente.Enabled:=false;
     RdBtnOrdinato.Enabled:=false;
end;

function TC001FScegliCampi.CampoAnagrafico(Campo : String) : Boolean;
var App : String;
begin
  App:=C001FFiltroTabelleDtM.Query2.FieldByName(Campo).DisplayLabel;
  Result:=(pos('T030.',App)>0) or(pos('V430.',App)>0)or(pos('T480.',App)>0)
end;

procedure TC001FScegliCampi.ListBoxSceltiMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  CampoCorrente:= ListBoxScelti.Items[ListBoxScelti.ItemIndex];
  RdBtnAscendente.Enabled:=True;
  RdBtnDiscendente.Enabled:=True;
  RdBtnOrdinato.Enabled:=True;
  SalvaPrimoItem(C001FScegliCampi.ListBoxScelti,X,Y);
  RecCampi:=CercaCampo(CampoCorrente);
  if ListBoxScelti.Items.Count>0 then
    begin
      CampoCorrente:=ListBoxScelti.Items[ListBoxScelti.itemindex];
      LblCampoSelezionato.Caption:='Campo Selezionato: '+chr(13)+CampoCorrente;
      LblCampoCorrente.Caption:='Campo Selezionato: '+chr(13)+CampoCorrente;
      LblCorrenteCampo.caption:='Campo Selezionato: '+chr(13)+CampoCorrente;
      if ((StampaAnagraficoMisto)and(CampoAnagrafico(CampoCorrente)))or(StampaAnagrafico) then
        begin
          Intervallo.TabVisible:=False;
          PageControl1.ActivePage:=Ordinamento;
        end
      else
        begin
          Intervallo.TabVisible:=True;
        end;
      CreaQDistinct(CampoCorrente);
      if RecCampi.Ordinato then
        begin
          RdBtnAscendente.Checked:=RecCampi.Ascendente;
          RdBtnDiscendente.Checked:=not(RdBtnAscendente.Checked);
          CkBGruppo.Enabled:=True;
          CkBGruppo.Checked:=RecCampi.Gruppo;
        end
      else
        begin
          RdBtnOrdinato.Checked:=true;
          CkBGruppo.Enabled:=False;
        end;
      cmbIntervalloDa.Text:=RecCampi.Da;
      cmbIntervalloA.Text:=RecCampi.A;
    end
  else
    begin
      LblCampoSelezionato.Caption:='Campo Selezionato:';
      LblCampoCorrente.Caption:='Campo Selezionato:';
      LblCorrenteCampo.caption:='Campo Selezionato:';
      CampoCorrente:='';
      cmbIntervalloDa.Text:='';
      cmbIntervalloA.Text:='';
      RdBtnOrdinato.Checked:=true;
    end;
  EdtIntestazione.Text:=GetIntestazione(CampoCorrente);
  ActiveListBox:=ListBoxScelti;
end;


procedure TC001FScegliCampi.RdBtnAscendenteClick(Sender: TObject);
begin
  RecCampi:=CercaCampo(CampoCorrente);
  CkBGruppo.Enabled:=True;
  if RecCampi <> nil then
    begin
      RecCampi.Ordinato:=True;
      RecCampi.Ascendente:=True;
    end;
end;

procedure TC001FScegliCampi.RdBtnDiscendenteClick(Sender: TObject);
begin
  RecCampi:=CercaCampo(CampoCorrente);
  CkBGruppo.Enabled:=True;
  if RecCampi <> nil then
    begin
      RecCampi.Ordinato:=True;
      RecCampi.Ascendente:=False;
    end;
end;

procedure TC001FScegliCampi.RdBtnOrdinatoClick(Sender: TObject);
begin
  RecCampi:=CercaCampo(CampoCorrente);
  CkBGruppo.Checked:=False;
  CkBGruppo.Enabled:=False;
  if RecCampi <> nil then
    begin
      RecCampi.Ordinato:=False;
      RecCampi.Ascendente:=False;
      RecCampi.Gruppo:=False;
    end;
end;

procedure TC001FScegliCampi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     ListBoxNonScelti.ItemIndex:=-1;
     ListBoxScelti.ItemIndex:=-1;
     cmbIntervalloDa.Text:='';
     cmbIntervalloA.Text:='';
end;

procedure TC001FScegliCampi.AzzeraCampiGruppo(NumeroBanda : Integer);
var I:Integer;
begin
  for I:=0 to ListaCampi.Count-1 do
     begin
       RecCampi:=ListaCampi[I];
       if (RecCampi.NumBanda = NumeroBanda)or(NumeroBanda = -1) then
         begin
           RecCampi.SelGruppo:=False;
           RecCampi.Posi:=-1;
           RecCampi.NumBanda:=-1;
         end;
     end;
end;

procedure TC001FScegliCampi.EdtIntestazioneChange(Sender: TObject);
begin
  C001FScegliCampi.SettaIntestazione(CampoCorrente,EdtIntestazione.Text);
end;

procedure TC001FScegliCampi.EdtIntestazioneEnter(Sender: TObject);
begin
  C001FFiltroTabelle.VariazioneCampi:=True;
end;

procedure TC001FScegliCampi.Button5Click(Sender: TObject);
begin
  AggiornaListaCampi;
  C001FFiltroTabelle.OrdinaListaCampi;
  if not(StampaGruppo) then
    AzzeraCampiGruppo(-1);  // se non ci sono campi di gruppo azzero i possibili campi rimasti pendenti.
end;

procedure TC001FScegliCampi.Button6Click(Sender: TObject);
begin
  RipristinaListaCampi;
end;

procedure TC001FScegliCampi.CkBGruppoClick(Sender: TObject);
begin
  RecCampi:=CercaCampo(CampoCorrente);
  if RecCampi <> nil then
    begin
      RecCampi.Gruppo:=CkBGruppo.Checked;
    end;
  C001FFiltroTabelle.VariazioneCampi:=True;
end;

procedure TC001FScegliCampi.DBLookupComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then 
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

end.
