unit WR200UBaseFM;

interface

uses
  SysUtils,
  WR300UBaseDM, {$IFDEF WEBPJ}WR302UGestTabellaDM,{$ENDIF}
  IWApplication, IWAppForm,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, Classes, Controls, Forms,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  IWCompJQueryWidget,
  medpIWDBGrid,meIWLabel,meIWDBEdit,meIWDBLabel,meIWDBRadioGroup,meIWDBComboBox,
  meIWDBLookupComboBox,meTIWDBAdvSpinEdit,meTIWDBDatePicker,meIWDBCheckBox,
  meTIWDBAdvRadioGroup,meIWLink,meIWMemo,meIWDBMemo,
  TypInfo,OracleData,DB;

type
  TWR200FBaseFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    TemplateProcessor: TIWTemplateProcessorHTML;
    JQuery: TIWJQueryWidget;
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure AbilitaComponentiRegion(Region : TIWRegion; DataSet : TOracleDataSet);
  public
    WR300DM:TWR300FBaseDM;
    {$IFDEF WEBPJ}WR302DM:TWR302FGestTabellaDM;{$ENDIF}
    procedure ReleaseOggetti; virtual; // eseguita in fase di destroy della form contenitore
  end;

implementation

{$IFDEF WEBPJ}uses WR100UBase, WR102UGestTabella;{$ENDIF}

{$R *.dfm}

procedure TWR200FBaseFM.IWFrameRegionCreate(Sender: TObject);
// imposta template e variabili per riferimenti rapidi
begin
  if Self.Owner <> nil then
  begin
    if Self.Owner is TIWAppForm then
    begin
      Self.Parent:=(Self.Owner as TIWAppForm);
      {$IFDEF WEBPJ}
      if Self.Parent is TWR102FGestTabella then
        WR302DM:=(Self.Parent as TWR102FGestTabella).WR302DM;
      {$ENDIF}
    end
    else if Self.Owner is TIWApplication then
    begin
      Self.Parent:=(GGetWebApplicationThreadVar.ActiveForm as TIWAppForm);
      {$IFDEF WEBPJ}
      if Self.Parent is TWR102FGestTabella then
        WR302DM:=(Self.Parent as TWR102FGestTabella).WR302DM;
      {$ENDIF}
    end
    else
    begin
      Self.Parent:=(GGetWebApplicationThreadVar.ActiveForm as TIWAppForm);
      {$IFDEF WEBPJ}
      if Self.Parent is TWR102FGestTabella then
        WR302DM:=(Self.Parent as TWR102FGestTabella).WR302DM;
      {$ENDIF}
    end;
  end;
end;

procedure TWR200FBaseFM.ReleaseOggetti;
// funzione richiamata in fase di destroy della form contenitore
begin
  // sovrascrivere
end;

procedure TWR200FBaseFM.AbilitaComponentiRegion(Region : TIWRegion;DataSet : TOracleDataSet);
var
  i : Integer;
  PropInfo: PPropInfo;
  ValCss: String;

begin
  for i:=0 to Region.ControlCount - 1 do
  begin
    if (Region.Controls[i] is TIWRegion) then
      AbilitaComponentiRegion(TIWRegion(Region.Controls[i]),DataSet)
    else if Region.Controls[i] is TmedpIWDBGrid then //la griglia si abilita/disabilita in autonomia
      Continue
    else if Region.Controls[i] is TmeIWLabel then //Etichette non hanno impostazioni
      Continue
    else if not (
       (Region.Controls[i] is TmeIWDBEdit) or
       (Region.Controls[i] is TmeIWDBLabel) or
       (Region.Controls[i] is TmeIWDBRadioGroup) or
       (Region.Controls[i] is TmeIWDBComboBox) or
       (Region.Controls[i] is TmeIWDBLookupComboBox) or
       (Region.Controls[i] is TmeTIWDBAdvSpinEdit) or
       (Region.Controls[i] is TmeTIWDBDatePicker) or
       (Region.Controls[i] is TmeIWDBCheckBox) or
       (Region.Controls[i] is TmeTIWDBAdvRadioGroup) or
       (Region.Controls[i] is TmeIWLink)) then
    begin
      //Se il componente ha la proprietà readOnly uso quella, altrimenti enabled
      PropInfo:=GetPropInfo(Region.Controls[i].ClassInfo, 'readonly');
      if Assigned(PropInfo) then
      begin
        SetPropValue(Region.Controls[i], 'readonly', DataSet.State = dsBrowse);
        //se imposta readonly rimuove disabled
        //se readOnly è false devo mantenere il valore di enabled perchè possibile abilitazione/disabilitazione da abilitacontrolli
        if DataSet.State = dsBrowse then
          Region.Controls[i].Enabled:=True;
      end
      else if (Region.Controls[i] is TmeIWMemo) or (Region.Controls[i] is TmeIWDBMemo) then  //Gestione Memo
      begin
        TmeIWMemo(Region.Controls[i]).Editable:=DataSet.State <> dsBrowse;
        //se editable è false rimuove disabled. Altrimenti deve mantenere il valore di enabled perchè possibile abilitazione/disabilitazione da abilitacontrolli
        if DataSet.State = dsBrowse then
          TmeIWMemo(Region.Controls[i]).Enabled:=True;
      end
      else
        Region.Controls[i].Enabled:=DataSet.State in [dsEdit,dsInsert];
    end
    else
    begin
      (*
       gestione css noDisabled per i componenti dataAware.Questa classe attiva il jQuery che rimuove la proprietà enabled per i componenti readOnly
        se in browse aggiungo noDisabled per vedere i campi readOnly.
        se non sono in browse rimuovo noDisabled perchè i componenti possono essere abilitati/disabilitati in base a logiche specifiche
      *)
      PropInfo:=GetPropInfo(Region.Controls[i].ClassInfo, 'css');
       if Assigned(PropInfo) then
       begin
          ValCss:=GetStrProp(Region.Controls[i],'css');
          if Dataset.State = dsBrowse then
          begin
            if Pos('noDisabled',ValCss) <=0 then
              SetStrProp(Region.Controls[i], 'css', ValCss + ' noDisabled');
          end
          else
            SetStrProp(Region.Controls[i], 'css', StringReplace(ValCss,' noDisabled','',[rfReplaceAll]));
        end;
    end;
  end;
end;

end.
