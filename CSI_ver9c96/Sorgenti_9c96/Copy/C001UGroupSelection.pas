unit C001UGroupSelection;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Variants;

type
  TC001FGroupSelection = class(TForm)
    PnlDisponibili: TPanel;
    PnlScelti: TPanel;
    Panel3: TPanel;
    CmBBande: TComboBox;
    SpeedButton1: TSpeedButton;
    PnlButtons: TPanel;
    ListBoxScelti: TListBox;
    ListBoxDisponibili: TListBox;
    SpRemoveFromGroup: TSpeedButton;
    SpAddToGroup: TSpeedButton;
    BtnOK: TBitBtn;
    BtnCancel: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    FontDialog1: TFontDialog;
    procedure CmBBandeChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpAddToGroupClick(Sender: TObject);
    procedure SpRemoveFromGroupClick(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
  private
    { Private declarations }
    NumeroGroup : Integer;
    procedure CaricaListBoxScelti(NBanda : Integer);
    procedure CaricaListBoxDisponibili;
    procedure OrdinaListaCampi;
    procedure OrdinaListaCampiOrig;
    procedure OrdinamentoFinale;
    procedure CompattaPosizioni;
  public
    { Public declarations }
    procedure Inizializza;
  end;

var
  C001FGroupSelection: TC001FGroupSelection;

implementation
uses C001StampaLib,C001UScegliCampi;

{$R *.DFM}

//------------------------------------------------------------------------------
procedure TC001FGroupSelection.CaricaListBoxDisponibili;
var I : Integer;
begin
  OrdinaListaCampiOrig;
  ListBoxDisponibili.Items.Clear;
  for I:=0 to ListaCampi.Count-1 do
     begin
       RecCampi := ListaCampi[I];
       if RecCampi.Selezionato then
         begin
           if (RecCampi.SelGruppo = False) then
             ListBoxDisponibili.Items.Add(RecCampi.Nome);
         end;
     end;
end;

//------------------------------------------------------------------------------
procedure TC001FGroupSelection.CaricaListBoxScelti(NBanda : Integer);
var I : Integer;
begin
  OrdinaListaCampi;
  ListBoxScelti.Items.Clear;
  for I:=0 to ListaCampi.Count-1 do
     begin
       RecCampi := ListaCampi[I];
       if RecCampi.Selezionato then
         begin
           if (RecCampi.Gruppo)or(RecCampi.SelGruppo) then
             begin
               if (RecCampi.NumBanda=NBanda)  then
                 ListBoxScelti.Items.Add(RecCampi.Nome);
             end
         end;
     end;
end;


//------------------------------------------------------------------------------
function ConfrontaPosizioni(P1,P2 : Pointer) : Integer;
begin
  if TRec_Campi(P1).Gruppo < TRec_Campi(P2).Gruppo then
    Result := 1
  else
    if TRec_Campi(P1).Gruppo > TRec_Campi(P2).Gruppo then
      Result := -1
    else
      if TRec_Campi(P1).SelGruppo < TRec_Campi(P2).SelGruppo then
        Result := 1
      else
        if TRec_Campi(P1).SelGruppo > TRec_Campi(P2).SelGruppo then
          Result := -1
        else
          if TRec_Campi(P1).NumBanda > TRec_Campi(P2).NumBanda then
            Result := 1
          else
            if TRec_Campi(P1).NumBanda < TRec_Campi(P2).NumBanda then
              Result := -1
            else
              if TRec_Campi(P1).Posi > TRec_Campi(P2).Posi then
                Result := 1
              else
                if TRec_Campi(P1).Posi < TRec_Campi(P2).Posi then
                  Result := -1
                else
                  if TRec_Campi(P1).Posizione > TRec_Campi(P2).Posizione then
                    Result := 1
                  else
                    if TRec_Campi(P1).Posizione < TRec_Campi(P2).Posizione then
                      Result := -1
                    else
                      Result := 0;
end;

//------------------------------------------------------------------------------
function OrdinamentoUscita(P1,P2 : Pointer) : Integer;
begin
  if TRec_Campi(P1).Selezionato < TRec_Campi(P2).Selezionato then
    Result := 1
  else
    if TRec_Campi(P1).Selezionato > TRec_Campi(P2).Selezionato then
      Result := -1
    else
      if TRec_Campi(P1).SelGruppo < TRec_Campi(P2).SelGruppo then
        Result := 1
      else
        if TRec_Campi(P1).SelGruppo > TRec_Campi(P2).SelGruppo then
          Result := -1
        else
          if TRec_Campi(P1).NumBanda > TRec_Campi(P2).NumBanda then
            Result := 1
          else
            if TRec_Campi(P1).NumBanda < TRec_Campi(P2).NumBanda then
              Result := -1
            else
              if TRec_Campi(P1).Posi > TRec_Campi(P2).Posi then
                Result := 1
              else
                if TRec_Campi(P1).Posi < TRec_Campi(P2).Posi then
                  Result := -1
                else
                  if TRec_Campi(P1).Posizione > TRec_Campi(P2).Posizione then
                    Result := 1
                  else
                    if TRec_Campi(P1).Posizione < TRec_Campi(P2).Posizione then
                      Result := -1
                    else
                      Result := 0;
end;


//------------------------------------------------------------------------------
function ConfrontaPosizioniOrig(P1,P2 : Pointer) : Integer;
begin
  if TRec_Campi(P1).Posizione > TRec_Campi(P2).Posizione then
    Result := 1
  else
    if TRec_Campi(P1).Posizione < TRec_Campi(P2).Posizione then
      Result := -1
    else
      Result := 0;
end;

//------------------------------------------------------------------------------
procedure TC001FGroupSelection.OrdinaListaCampi;
begin
  ListaCampi.Sort(ConfrontaPosizioni);
end;

//------------------------------------------------------------------------------
procedure TC001FGroupSelection.OrdinaListaCampiOrig;
begin
  ListaCampi.Sort(ConfrontaPosizioniOrig);
end;

//------------------------------------------------------------------------------
procedure TC001FGroupSelection.OrdinamentoFinale;
begin
  ListaCampi.Sort(OrdinamentoUscita);
end;

//------------------------------------------------------------------------------
procedure TC001FGroupSelection.Inizializza;
var I : Integer;
begin
  for I:=0 to ListaCampi.Count -1 do
     begin
       RecCampi := ListaCampi[I];
       if (RecCampi.Selezionato)and(RecCampi.Gruppo) then
         RecCampi.SelGruppo := True;
     end;
  if TipoGruppo = 0 then
    NumeroGroup := 1
  else
    begin
      NumeroGroup := 0;
      for I:=1 to NOggetti do
         begin
           if VettStampa[I].NumeroBandaGruppo > NumeroGroup then
             NumeroGroup := VettStampa[I].NumeroBandaGruppo;
         end;
    end;
  CmBBande.Items.Clear;
  for I:= 1 to NumeroGroup do
     CmBBande.Items.Add('Banda n° ' + inttostr(I));
  CmBBande.ItemIndex := 0;
  CmBBandeChange(Self);
end;

//------------------------------------------------------------------------------
procedure TC001FGroupSelection.CmBBandeChange(Sender: TObject);
begin
  CaricaListBoxScelti(CmBBande.ItemIndex+1);
  CaricaListBoxDisponibili;
end;

//------------------------------------------------------------------------------
procedure TC001FGroupSelection.SpeedButton1Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(FontGruppo[CmBBande.ItemIndex+1]);
  if FontDialog1.Execute then
    FontGruppo[CmBBande.ItemIndex+1].Assign(FontDialog1.Font);
end;

//------------------------------------------------------------------------------
procedure TC001FGroupSelection.SpAddToGroupClick(Sender: TObject);
var A : Integer;
begin
  A := ListBoxDisponibili.ItemIndex;
  if A <> -1 then
    begin
      ListBoxScelti.Items.Add(ListBoxDisponibili.Items[A]);
      RecCampi := C001FScegliCampi.CercaCampo(ListBoxDisponibili.Items[A]);
      if RecCampi <> nil then
        begin
          RecCampi.SelGruppo := True;
          RecCampi.NumBanda := CmBBande.ItemIndex + 1;
          RecCampi.Posi := ListBoxScelti.Items.IndexOf(ListBoxDisponibili.Items[A]);
        end;
      ListBoxDisponibili.Items.Delete(A);
    end;
end;

//------------------------------------------------------------------------------
procedure TC001FGroupSelection.CompattaPosizioni;
var I : Integer;
begin
  for I:=0 to ListBoxScelti.Items.Count-1 do
     begin
       RecCampi := C001FScegliCampi.CercaCampo(ListBoxScelti.Items[I]);
       if RecCampi <> nil then
         begin
           RecCampi.Posi := I;
         end;
     end;
end;

//------------------------------------------------------------------------------
procedure TC001FGroupSelection.SpRemoveFromGroupClick(Sender: TObject);
var A : Integer;
begin
  A := ListBoxScelti.ItemIndex;
  if A <> -1 then
    begin
      RecCampi := C001FScegliCampi.CercaCampo(ListBoxScelti.Items[A]);
      if not(RecCampi.Gruppo) then
        begin
          RecCampi.SelGruppo := False;
          RecCampi.NumBanda := -1;
          RecCampi.Posi := -1;
          ListBoxScelti.Items.Delete(A);
          CompattaPosizioni;
          CaricaListBoxDisponibili; // ricarico la ListBoxDisponibili così i campi sono sempre nello stesso ordine
        end
      else
        MessageDlg('Impossibile eliminare questo campo.',mtWarning,[mbOK],0);
    end;
end;

//------------------------------------------------------------------------------
procedure TC001FGroupSelection.BtnOKClick(Sender: TObject);
var I,Posizione : Integer;
begin
  OrdinamentoFinale;
  Posizione := 0;
  for I:=0 to ListaCampi.Count-1 do
     begin
       RecCampi := ListaCampi[I];
       if RecCampi.Selezionato then
         begin
           RecCampi.Posizione := Posizione;
           inc(Posizione,1);
         end;
     end;
end;

//------------------------------------------------------------------------------
procedure TC001FGroupSelection.FormActivate(Sender: TObject);
var I : Integer;
begin
  for I:=1 to 10 do
    begin
      OldFontGruppo[I].Assign(FontGruppo[I]);
    end;
end;

//------------------------------------------------------------------------------
procedure TC001FGroupSelection.BtnCancelClick(Sender: TObject);
var I : Integer;
begin
  for I:=1 to 10 do
    begin
      FontGruppo[I].Assign(OldFontGruppo[I]);
    end;
end;

end.


