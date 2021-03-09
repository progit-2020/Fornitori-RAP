unit meIWRegion;

interface

uses
  SysUtils, Classes, Controls, Forms, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWRegion,
  IWDsnPaint, IWDsnPaintHandlers,
  IWCompLabel,IWCompGrids,IWCompExtCtrls,IWCompListBox,IWCompCheckBox,IWCompEdit,IWCompMemo;

type
  TmeIWRegion = class(TIWRegion)
  private
    procedure AbilitazioneComponente(Componente:TIWCustomControl; Abilita:Boolean);
    procedure AbilitazioneComponenti(Abilita:Boolean);
  protected
    { Protected declarations }
  public
    procedure medpAbilitaComponenti;
    procedure medpDisabilitaComponenti;
  published
    { Published declarations }
  end;

implementation

procedure TmeIWRegion.AbilitazioneComponente(Componente:TIWCustomControl; Abilita:Boolean);
// abilita / disabilita il componente specificato
var
  r,c:Integer;
begin
  if Componente is TIWLabel then
  begin
    // label: nessun cambiamento
    Exit;
  end
  else if Componente is TIWGrid then
  begin
    // grid: ciclo sui componenti relativi
    for r:=0 to TIWGrid(Componente).RowCount - 1 do
      for c:=0 to TIWGrid(Componente).ColumnCount - 1 do
      begin
        if not Abilita then
          TIWGrid(Componente).Cell[r,c].Clickable:=False;
        if TIWGrid(Componente).Cell[r,c].Control <> nil then
          AbilitazioneComponente(TIWGrid(Componente).Cell[r,c].Control,Abilita);
      end;
  end
  else if Componente is TIWRadioGroup then
  begin
    // radio group
    TIWRadioGroup(Componente).Editable:=Abilita;
    TIWRadioGroup(Componente).Enabled:=Abilita;
  end
  else if Componente is TIWComboBox then
  begin
    // combobox
    TIWComboBox(Componente).Enabled:=Abilita;
  end
  else if Componente is TIWCheckBox then
  begin
    // checkbox
    TIWCheckBox(Componente).Editable:=Abilita;
    TIWCheckBox(Componente).Enabled:=Abilita;
  end
  else if Componente is TIWEdit then
  begin
    // edit
    TIWEdit(Componente).Editable:=Abilita;
    TIWEdit(Componente).Enabled:=Abilita;
  end
  else if Componente is TIWMemo then
  begin
    // memo
    TIWMemo(Componente).Editable:=Abilita;
    TIWMemo(Componente).Enabled:=Abilita;
  end
  else
  begin
    // altro tipo di componente
    Componente.Enabled:=Abilita;
  end;
end;

procedure TmeIWRegion.AbilitazioneComponenti(Abilita:Boolean);
var
  i:Integer;
begin
  for i:=0 to Self.ControlCount - 1 do
    if (Controls[i] is TIWCustomControl) then
      AbilitazioneComponente(TIWCustomControl(Controls[i]),Abilita);
end;

procedure TmeIWRegion.medpAbilitaComponenti;
begin
  AbilitazioneComponenti(True);
end;

procedure TmeIWRegion.medpDisabilitaComponenti;
begin
  AbilitazioneComponenti(False);
end;


initialization

end.
