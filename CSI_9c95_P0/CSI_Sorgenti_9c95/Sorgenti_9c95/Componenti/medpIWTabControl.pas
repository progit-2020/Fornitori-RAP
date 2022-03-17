unit medpIWTabControl;

interface

uses
  // ***************************************************************************** //
  // *** ATTENZIONE!!! NON UTILIZZARE CLASSI PROPRIE DI MONDOEDP NELLE USES!!! *** //
  // ***************************************************************************** //
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, Forms, IWColor, IWHTMLControls,
  IWCompGridCommon,
  IWRegion, meIWGrid, meIWLink, StrUtils, Contnrs;

type
  TmedpIWTabControl = class;

  TmedpTab = class(TPersistent)
  private
    FVisible,
    FLinkVisible,
    FSelected,
    FEnabled,
    FFiller: Boolean;
    FTabPageControl: TControl;
    FLink: TmeIWLink;
    FMyIndex: Integer;
    function  GetTabPageControl: TControl;
    procedure SetTabPageControl(Val: TControl);
    function  GetLink: TmeIWLink;
    procedure SetLink(Val: TmeIWLink);
    function  GetCaption: String;
    procedure SetCaption(Val: String);
    function  GetEnabled: Boolean;
    procedure SetEnabled(Val: Boolean);
    function  IsFiller: Boolean;
    function  GetMyIndex: Integer;
    procedure SetMyIndex(Val: Integer);
    function  GetSelectable: Boolean;
    function  GetSelected: Boolean;
    procedure SetSelected(Val: Boolean);
    function  GetVisible: Boolean;
    procedure SetVisible(Val: Boolean);
    function  GetLinkVisible: Boolean;
    procedure SetLinkVisible(Val: Boolean);
  public
    TabControlComponent: TmedpIWTabControl;
    constructor Create;
    property TabPageControl: TControl read GetTabPageControl write SetTabPageControl;
    property Link: TmeIWLink read GetLink write SetLink;
    property Caption: String read GetCaption write SetCaption;
    property Enabled: Boolean read GetEnabled write SetEnabled;
    property Filler: Boolean read IsFiller;
    property MyIndex: Integer read GetMyIndex write SetMyIndex;
    property Selectable: Boolean read GetSelectable;
    property Selected: Boolean read GetSelected write SetSelected;
    property Visible: Boolean read GetVisible write SetVisible;
    property LinkVisible: Boolean read GetLinkVisible write SetLinkVisible;
  end;

  TTabControlChanging = procedure(Sender: TObject; var AllowChange: Boolean) of object;
  TTabControlChange = procedure(Sender: TObject) of object;

  TmedpIWTabControl = class(TmeIWGrid)
  private
    FCssTabHeaders:String;
    FHasFiller: Boolean;
    FSelIndex: Integer;
    medpTabList: TObjectList;
    FOnTabControlChanging: TTabControlChanging;
    FOnTabControlChange: TTabControlChange;
    function  GetCssTabHeaders: String;
    function  GetHasFiller: Boolean;
    procedure SetHasFiller(const Val: Boolean);
    function  GetActiveTab: TControl;
    procedure SetActiveTab(TabPageControl: TControl); overload;
    procedure SetActiveTab(Index: Integer); overload;
    function  GetTab(Comp: TControl):TmedpTab; overload;
    function  GetTab(Index: Integer): TmedpTab; overload;
    function  GetIndex(Comp:TControl): Integer; overload;
    function  GetIndex(TabLink:TmeIWLink): Integer; overload;
    function  GetTabCount: Integer;
    procedure TabLinkClick(Sender: TObject);
    procedure UpdateTabControl;
    //function  GetVisible: Boolean;
    //procedure SetVisible(Val: Boolean);
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    function  AggiungiTab(const PCaption:String; PComp:TControl): Integer;
    function  EliminaTab(TabPageControl: TControl): Boolean; overload;
    function  EliminaTab(const c: Integer): Boolean; overload;
    function  TabByIndex(Index: Integer): TmedpTab;
    function  TabIndex: Integer;
    property  ActiveTab: TControl read GetActiveTab write SetActiveTab;
    property  ActiveTabIndex: Integer read FSelIndex write SetActiveTab;
    property  HasFiller: Boolean read GetHasFiller write SetHasFiller;
    property  TabCount: Integer read GetTabCount;
    property  Tabs[Comp: TControl]: TmedpTab read GetTab;
  published
    property CssTabHeaders: string read GetCssTabHeaders write FCssTabHeaders;
    property OnTabControlChanging: TTabControlChanging read FOnTabControlChanging write FOnTabControlChanging;
    property OnTabControlChange: TTabControlChange read FOnTabControlChange write FOnTabControlChange;
    //property Visible read GetHasFiller write SetHasFiller;
  end;

implementation

uses C190FunzioniGeneraliWeb;

// *** TmedpTab - componente di supporto *** //
constructor TmedpTab.Create;
begin
  FTabPageControl:=nil;
  FLink:=nil;
  FFiller:=False;
  FEnabled:=True;
  FVisible:=True;
  FSelected:=True;
end;

function TmedpTab.GetTabPageControl: TControl;
begin
  Result:=FTabPageControl;
end;

procedure TmedpTab.SetTabPageControl(Val: TControl);
begin
  FTabPageControl:=Val;
end;

function TmedpTab.GetLink: TmeIWLink;
begin
  Result:=FLink;
end;

procedure TmedpTab.SetLink(Val: TmeIWLink);
begin
  FLink:=Val;
end;

function TmedpTab.GetCaption: String;
begin
  Result:=FLink.Text;
end;

procedure TmedpTab.SetCaption(Val: String);
begin
  FLink.RawText:=Pos('<',Val) > 0; // tenta di valutare in modo veloce se sono presenti tag html
  FLink.Text:=Val;
end;

function TmedpTab.GetEnabled: Boolean;
begin
  Result:=FEnabled;
end;

procedure TmedpTab.SetEnabled(Val: Boolean);
var
  i: Integer;
  T: TmedpTab;
  Found: Boolean;
  OnTChanging: TTabControlChanging;
  OnTChange: TTabControlChange;
begin
  Link.Enabled:=Val;

  // se si sta disabilitando il tab seleziona il primo tab precedente o successivo possibile
  if (not Val) and (Selected) then
  begin
    Selected:=False;

    // ciclo sui tab precedenti
    Found:=False;
    for i:=MyIndex - 1 downto 0 do
    begin
      T:=TabControlComponent.TabByIndex(i);
      if T.Selectable then
      begin
        T.Selected:=True;
        //non deve scattare il tabchanging perchè non posso inibire il passaggio di tab
        //in quanto quello corrente viene disabilitato
        OnTChanging:=TabControlComponent.OnTabControlChanging;
        OnTChange:=TabControlComponent.OnTabControlChange;
        TabControlComponent.OnTabControlChanging:=nil;
        TabControlComponent.OnTabControlChange:=nil;
        TabControlComponent.ActiveTab:=T.TabPageControl;
        TabControlComponent.OnTabControlChanging:=OnTChanging;
        TabControlComponent.OnTabControlChange:=OnTChange;
        Found:=True;
        Break;
      end;
    end;
    // ciclo sui tab successivi
    if not Found then
    begin
      for i:=MyIndex + 1 to TabControlComponent.TabCount - 1 do
      begin
        T:=TabControlComponent.TabByIndex(i);
        if T.Selectable then
        begin
          T.Selected:=True;
          //non deve scattare il tabchanging perchè non posso inibire il passaggio di tab
          //in quanto quello corrente viene disabilitato
          OnTChanging:=TabControlComponent.OnTabControlChanging;
          OnTChange:=TabControlComponent.OnTabControlChange;
          TabControlComponent.OnTabControlChanging:=nil;
          TabControlComponent.OnTabControlChange:=nil;
          TabControlComponent.ActiveTab:=T.TabPageControl;
          TabControlComponent.OnTabControlChanging:=OnTChanging;
          TabControlComponent.OnTabControlChange:=OnTChange;
          Break;
        end;
      end;
    end;

  end;

  FEnabled:=Val;
end;

function TmedpTab.IsFiller: Boolean;
begin
  Result:=FFiller;
end;

function TmedpTab.GetMyIndex: Integer;
begin
  Result:=FMyIndex;
end;

procedure TmedpTab.SetMyIndex(Val: Integer);
begin
  FMyIndex:=Val;
end;

function TmedpTab.GetSelectable: Boolean;
begin
  Result:=(FLink.Css <> 'invisibile') and (FLink.Enabled);
end;

function TmedpTab.GetSelected: Boolean;
begin
  Result:=FSelected;
end;

procedure TmedpTab.SetSelected(Val: Boolean);
var
  i: Integer;
  T: TmedpTab;
begin
  if Val then
  begin
    if (not FEnabled) or
       (not Selectable) then
      Exit;

    // se Val è True, deseleziona l'eventuale tab già selezionato
    for i:=0 to TabControlComponent.TabCount - 1 do
    begin
      T:=TabControlComponent.TabByIndex(i);
      if T.Selected then
      begin
        T.Selected:=False;
        Break;
      end;
    end;
  end;

  // seleziona il tab
  TabPageControl.Visible:=Val;
  if Link.Css <> 'invisibile' then
    Link.Css:=TabControlComponent.CSSTabHeaders + IfThen(Val,' sel');

  FSelected:=Val;
end;

function TmedpTab.GetVisible: Boolean;
begin
  Result:=FVisible;
end;

procedure TmedpTab.SetVisible(Val: Boolean);
begin
  if Val = FVisible then
    Exit;

  FTabPageControl.Visible:=Val;
  FLink.Css:=IfThen(Val,TabControlComponent.CssTabHeaders,'invisibile');
  FVisible:=Val;
end;

function TmedpTab.GetLinkVisible: Boolean;
begin
  Result:=FLinkVisible;
end;

procedure TmedpTab.SetLinkVisible(Val: Boolean);
var i:Integer;
    T: TmedpTab;
    Found: Boolean;
    OnTChanging: TTabControlChanging;
    OnTChange: TTabControlChange;
begin
  FLink.Css:=IfThen(Val,TabControlComponent.CssTabHeaders,'invisibile');
  FLinkVisible:=Val;
  if Selected then
  begin
    if not FLinkVisible then
    begin
      // ciclo sui tab precedenti
      Found:=False;
      for i:=MyIndex - 1 downto 0 do
      begin
        T:=TabControlComponent.TabByIndex(i);
        if T.Selectable then
        begin
          T.Selected:=True;
          //non deve scattare il tabchanging perchè non posso inibire il passaggio di tab
          //in quanto quello corrente viene disabilitato
          OnTChanging:=TabControlComponent.OnTabControlChanging;
          OnTChange:=TabControlComponent.OnTabControlChange;
          TabControlComponent.OnTabControlChanging:=nil;
          TabControlComponent.OnTabControlChange:=nil;
          TabControlComponent.ActiveTab:=T.TabPageControl;
          TabControlComponent.OnTabControlChanging:=OnTChanging;
          TabControlComponent.OnTabControlChange:=OnTChange;
          Found:=True;
          Break;
        end;
      end;
      // ciclo sui tab successivi
      if not Found then
        for i:=MyIndex + 1 to TabControlComponent.TabCount - 1 do
        begin
          T:=TabControlComponent.TabByIndex(i);
          if T.Selectable then
          begin
            T.Selected:=True;
            //non deve scattare il tabchanging perchè non posso inibire il passaggio di tab
            //in quanto quello corrente viene disabilitato
            OnTChanging:=TabControlComponent.OnTabControlChanging;
            OnTChange:=TabControlComponent.OnTabControlChange;
            TabControlComponent.OnTabControlChanging:=nil;
            TabControlComponent.OnTabControlChange:=nil;
            TabControlComponent.ActiveTab:=T.TabPageControl;
            TabControlComponent.OnTabControlChanging:=OnTChanging;
            TabControlComponent.OnTabControlChange:=OnTChange;
            Break;
          end;
        end;
    end
    else
      FLink.Css:=FLink.Css + ' sel';
  end;
end;

// ***  TmedpIWTabControl *** //
constructor TmedpIWTabControl.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  with BorderColors do
  begin
    Color:=clWebWHITE;
    Dark:=clWebWHITE;
    Light:=clWebWHITE;
  end;
  BorderSize:=0;
  BorderStyle:=tfVoid;
  Caption:='';
  CellPadding:=0;
  CellSpacing:=0;
  Css:='gridTabControl';
  CssTabHeaders:='medpTabControl';
  Font.Enabled:=False;
  with StyleRenderOptions do
  begin
    RenderAbsolute:=False;
    RenderFont:=False;
    RenderPosition:=False;
    RenderSize:=False;
    RenderZIndex:=False;
	{ DONE : TEST IW 15 }
	RenderBorder:=False;
  end;
  UseFrame:=False;
  UseSize:=False;

  medpTabList:=TObjectList.Create;
  FSelIndex:=-1;
  HasFiller:=True; // default a True
end;

destructor TmedpIWTabControl.Destroy;
begin
  FreeAndNil(medpTabList);
  inherited Destroy;
end;

function TmedpIWTabControl.GetActiveTab: TControl;
begin
  Result:=nil;
  if FSelIndex <> -1 then
    try
      Result:=TmedpTab(medpTabList[FSelIndex]).TabPageControl;
    except
    end;
end;

procedure TmedpIWTabControl.SetActiveTab(TabPageControl:TControl);
// utilizzato per la property
begin
  SetActiveTab(GetIndex(TabPageControl));
end;

procedure TmedpIWTabControl.SetActiveTab(Index: Integer);
// utilizzato per il link
var
  i:Integer;
  Continua: Boolean;
begin
  // gestione evento OnChanging per prevenire il cambio di tab attivo
  if Assigned(OnTabControlChanging) then
  begin
    Continua:=True;
    OnTabControlChanging(Self,Continua);
    if not Continua then
      Exit;
  end;

  // deseleziona tutti i tab
  for i:=0 to medpTabList.Count - 1 do
  begin
    (medpTabList[i] as TmedpTab).Selected:=False;
  end;

  // seleziona il tab indicato
  (medpTabList[Index] as TmedpTab).Selected:=True;
  FSelIndex:=Index;

  // gestione evento OnChange dopo il cambio di tab
  if Assigned(OnTabControlChange) then
    OnTabControlChange(Self);
end;

function TmedpIWTabControl.GetCssTabHeaders: String;
begin
  if FCssTabHeaders = '' then
    Result:='' //'x'
  else
    Result:=FCssTabHeaders;
end;

function TmedpIWTabControl.GetHasFiller: Boolean;
begin
  Result:=FHasFiller;
end;

procedure TmedpIWTabControl.SetHasFiller(const Val: Boolean);
// aggiunge una cella per realizzare un filler che riempie la parte dx
begin
  if FHasFiller = Val then
    Exit;

  FHasFiller:=Val;
  UpdateTabControl;
end;

function TmedpIWTabControl.GetIndex(Comp:TControl):Integer;
var
  i: Integer;
begin
  Result:=-1;
  for i:=0 to medpTabList.Count - 1 do
  begin
    if (TmedpTab(medpTabList[i]).TabPageControl = Comp) then
    begin
      Result:=i;
      Break;
    end
  end;
end;

function TmedpIWTabControl.GetIndex(TabLink:TmeIWLink):Integer;
var
  i: Integer;
begin
  Result:=-1;
  for i:=0 to medpTabList.Count - 1 do
  begin
    if TmedpTab(medpTabList[i]).Link = TabLink then
    begin
      Result:=i;
      Break;
    end
  end;
end;

function TmedpIWTabControl.GetTabCount: Integer;
begin
  Result:=medpTabList.Count;
end;

function TmedpIWTabControl.GetTab(Comp:TControl):TmedpTab;
var
  i: Integer;
begin
  Result:=nil;
  for i:=0 to medpTabList.Count - 1 do
  begin
    if (TmedpTab(medpTabList[i]).TabPageControl = Comp) then
    begin
      Result:=TmedpTab(medpTabList[i]);
      Break;
    end
  end;
end;

function TmedpIWTabControl.GetTab(Index: Integer): TmedpTab;
begin
  if (Index < 0) or (Index >= medpTabList.Count) then
    Result:=nil
  else
    Result:=(medpTabList[Index] as TmedpTab);
end;

procedure TmedpIWTabControl.TabLinkClick(Sender: TObject);
begin
  SetActiveTab(GetIndex((Sender as TmeIWLink)));
end;

procedure TmedpIWTabControl.UpdateTabControl;
var
  c: Integer;
begin
  if medpTabList.Count > 0 then
  begin
    ColumnCount:=medpTabList.Count;
    for c:=0 to medpTabList.Count - 1 do
    begin
      Cell[0,c].Css:='align_bottom';
      Cell[0,c].Control:=(medpTabList[c] as TmedpTab).Link;
      Cell[0,c].Text:='';
    end;
  end;

  if HasFiller then
  begin
    if medpTabList.Count = 0 then
      c:=0
    else
      c:=ColumnCount;
    ColumnCount:=c + 1;
    Cell[0,c].Css:='medpTabControl filler align_bottom';
    Cell[0,c].Control:=nil;
  end;
end;

function TmedpIWTabControl.AggiungiTab(const PCaption:String; PComp:TControl): Integer;
var
  T: TmedpTab;
begin
  Result:=-1;
  // controllo parametri
  if (PCaption <> '') and (PComp = nil) then
    raise Exception.Create('medpIWTabControl: impossibile aggiungere un tab senza relativo componente');

  // se filler già presente non effettua operazioni
  if (HasFiller) and (PCaption = '') and (PComp = nil) then
    Exit;

  T:=TmedpTab.Create;
  if PComp <> nil then
  begin
    T.TabControlComponent:=Self;
    T.TabPageControl:=PComp; // region / frame contenente i componenti

    T.Link:=TmeIWLink.Create(Self); // collegamento
    with T.Link do
    begin
      //Massimo 03/01/2013
      Name:=C190CreaNomeComponente(Self.Name + 'Tab' + IntToStr(medpTabList.Count),Self.Owner);
      Text:=PCaption;
      Css:=CssTabHeaders;
      OnClick:=TabLinkClick;
      //Parent:=Self.Parent;
    end;
    // imposta proprietà di default
    T.Enabled:=True;
    T.Visible:=True;
    T.Selected:=True;
  end;
  Result:=medpTabList.Add(T);
  T.MyIndex:=Result;

  UpdateTabControl;
end;

function TmedpIWTabControl.EliminaTab(TabPageControl: TControl): Boolean;
// elimina il tab indicato dal componente e restituisce true/false
begin
  Result:=EliminaTab(GetIndex(TabPageControl));
end;

function TmedpIWTabControl.EliminaTab(const c: Integer): Boolean;
// elimina il tab indicato dal componente e restituisce true/false
begin
  Result:=False;
  if (c < 0) or (c >= medpTabList.Count) then
    Exit;

  //CARATTO 30/10/2012 Deve distruggere il componente usato come link
  FreeAndNil(GetTab(c).FLink);

  medpTabList.Delete(c);
  UpdateTabControl;
  Result:=True;
end;

function TmedpIWTabControl.TabByIndex(Index: Integer): TmedpTab;
begin
  Result:=GetTab(Index);
end;

function TmedpIWTabControl.TabIndex: Integer;
begin
  Result:=FSelIndex;
end;

end.
