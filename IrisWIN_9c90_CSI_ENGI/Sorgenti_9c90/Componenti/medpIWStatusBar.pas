unit medpIWStatusBar;

interface

uses
  SysUtils, Classes, Controls, Math, IWVCLBaseControl, IWBaseControl,
  IWAppForm, IWBaseHTMLControl, IWControl, meIWGrid, StrUtils;

type

  TmedpStatusBarComponent = class(TPersistent)
  private
    FHeader: string;
    FValue: string;
    FHeaderCss: string;
    FValueCss: string;
    Owner: TIWCustomControl;
    NomeElemento: string;
    IndexHeaderCell: integer;
    IndexValueCell: integer;
    procedure SetHeader(const Value: string);
    procedure SetValue(const Value: string);
    function  GetHeaderCss: String;
    procedure SetHeaderCss(const Value: string);
    function  GetValueCss: String;
    procedure SetValueCss(const Value: string);
  public
    constructor Create(AOwner: TIWCustomControl);
  published
    property Header: string read FHeader write SetHeader;
    property Value: string read FValue write SetValue;
    property HeaderCss: string read GetHeaderCss write SetHeaderCss;
    property ValueCss: string read GetValueCss write SetValueCss;
  end;

  TmedpIWStatusBar = class(TmeIWGrid)
  private
    FSeparatorCss:string;
    medpStatusBarComponents: array of TmedpStatusBarComponent;
  protected
    { Protected declarations }
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure AggiungiElemento(Elemento: string);
    procedure EliminaElementi;
    procedure CreaStatusBar;
    function StatusBarComponent(ComponentName: string) : TmedpStatusBarComponent;
  published
    property SeparatorCss: string read FSeparatorCss write FSeparatorCss;
  end;

implementation

constructor TmedpStatusBarComponent.Create(AOwner: TIWCustomControl);
begin
  inherited Create;
  Owner:=AOwner;
  IndexHeaderCell:=-1;
  IndexValueCell:=-1;
end;

procedure TmedpStatusBarComponent.SetHeader(const Value: string);
begin
  FHeader:=Value;
  if IndexHeaderCell <> -1 then
  begin
    TmedpIWStatusBar(Owner).Cell[0,IndexHeaderCell].Text:=Value;
    TmedpIWStatusBar(Owner).Cell[0,IndexHeaderCell].Css:=IfThen(FHeader <> '',HeaderCss,'invisibile');
  end;
end;

procedure TmedpStatusBarComponent.SetValue(const Value: string);
begin
  FValue:=Value;
  if IndexValueCell <> -1 then
  begin
    TmedpIWStatusBar(Owner).Cell[0,IndexValueCell].Text:=Value;
  end;
end;

function TmedpStatusBarComponent.GetHeaderCss: String;
begin
  if FHeaderCss = '' then
    Result:='x'
  else
    Result:=FHeaderCss;
end;

procedure TmedpStatusBarComponent.SetHeaderCss(const Value: string);
begin
  FHeaderCss:=Value;
  if IndexHeaderCell <> -1 then
    TmedpIWStatusBar(Owner).Cell[0,IndexHeaderCell].Css:=Value;
end;

function TmedpStatusBarComponent.GetValueCss: String;
begin
  if FValueCss = '' then
    Result:='x'
  else
    Result:=FValueCss;
end;

procedure TmedpStatusBarComponent.SetValueCss(const Value: string);
begin
  FValueCss:=Value;
  if IndexValueCell <> -1 then
    TmedpIWStatusBar(Owner).Cell[0,IndexValueCell].Css:=Value;
end;

constructor TmedpIWStatusBar.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  BorderSize:=0;
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
  Caption:='';
  Css:='medpStatusBar';
  Parent:=TIWAppForm(AOwner);
  SeparatorCSS:='medpStatusBarSep';
  SetLength(medpStatusBarComponents,0);
end;

procedure TmedpIWStatusBar.CreaStatusBar;
var
  i:Integer;
begin
  RowCount:=1;
  ColumnCount:=1;

  for i:=0 to High(medpStatusBarComponents) do
  begin
    // header
    ColumnCount:=ColumnCount + IfThen(ColumnCount = 1,0,1);
    Cell[0,ColumnCount - 1].Text:=medpStatusBarComponents[i].Header;
    Cell[0,ColumnCount - 1].Css:=medpStatusBarComponents[i].HeaderCss;
    medpStatusBarComponents[i].IndexHeaderCell:=ColumnCount - 1;
    if medpStatusBarComponents[i].Header = '' then
      Cell[0,ColumnCount - 1].Css:='invisibile';

    // valore
    ColumnCount:=ColumnCount+1;
    Cell[0,ColumnCount - 1].Text:=medpStatusBarComponents[i].Value;
    Cell[0,ColumnCount - 1].Css:=medpStatusBarComponents[i].ValueCss;
    medpStatusBarComponents[i].IndexValueCell:=ColumnCount-1;

    // separatore
    ColumnCount:=ColumnCount + 1;
    Cell[0,ColumnCount - 1].Css:=SeparatorCss;
  end;
  ColumnCount:=ColumnCount - 1; //eliminazione ultimo separatore
end;

procedure TmedpIWStatusBar.AggiungiElemento(Elemento: string);
begin
  SetLength(medpStatusBarComponents, Length(medpStatusBarComponents) + 1);
  medpStatusBarComponents[High(medpStatusBarComponents)]:=TmedpStatusBarComponent.Create(Self);
  medpStatusBarComponents[High(medpStatusBarComponents)].NomeElemento:=Elemento;
end;

procedure TmedpIWStatusBar.EliminaElementi;
var
  i:integer;
begin
  for i:=0 to High(medpStatusBarComponents) do
    FreeAndNil(medpStatusBarComponents[i]);
  SetLength(medpStatusBarComponents, 0);
end;

function TmedpIWStatusBar.StatusBarComponent(ComponentName: string):TmedpStatusBarComponent;
var
  i:integer;
begin
  Result:=nil;
  for i:=0 to High(medpStatusBarComponents) do
    if UpperCase(medpStatusBarComponents[i].NomeElemento) = UpperCase(ComponentName) then
    begin
      Result:=medpStatusBarComponents[i];
      break;
    end;
end;

destructor TmedpIWStatusBar.Destroy;
begin
  EliminaElementi;
  inherited Destroy;
end;

end.
