unit A107UInsAssAutoRegole;

interface

uses R001UGESTTAB, StdCtrls, Mask, DBCtrls, Buttons, Controls, ExtCtrls,
  Classes, ActnList, ImgList, Dialogs, DB, Menus, ComCtrls, ToolWin, Windows,
  A000UInterfaccia, A000UMessaggi, A000USessione;

type
  TA107FInsAssAutoRegole = class(TR001FGestTab)
    Panel2: TPanel;
    DBRadioGroup1: TDBRadioGroup;
    lstCausali: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    btnAggiungi: TBitBtn;
    btnTogli: TBitBtn;
    dlstCausaliDisponibili: TDBLookupListBox;
    dchkGiorniVuoti: TDBCheckBox;
    dedtOreMax: TDBEdit;
    Label3: TLabel;
    dchkEliminaGiustificativi: TDBCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure lstCausaliDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lstCausaliDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure btnAggiungiClick(Sender: TObject);
    procedure btnTogliClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A107FInsAssAutoRegole: TA107FInsAssAutoRegole;

procedure OpenA107InsAssAutoRegole;

implementation

uses A107UInsAssAutoRegoleDtM;

{$R *.DFM}

procedure OpenA107InsAssAutoRegole;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA107InsAssAutoRegole') of
    'N':
        begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A107FInsAssAutoRegole:=TA107FInsAssAutoRegole.Create(nil);
  with A107FInsAssAutoRegole do
    try
      A107FInsAssAutoRegoleDtM:=TA107FInsAssAutoRegoleDtM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A107FInsAssAutoRegoleDtM.Free;
      Free;
    end;
end;

procedure TA107FInsAssAutoRegole.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A107FInsAssAutoRegoleDtM.selT045;
  dlstCausaliDisponibili.ListSource:=A107FInsAssAutoRegoleDtM.A107MW.dsrT265;
  inherited;
end;

procedure TA107FInsAssAutoRegole.FormShow(Sender: TObject);
begin
  inherited;
  lstCausali.Items.CommaText:=A107FInsAssAutoRegoleDtM.selT045.FieldByName('CAUSALI').AsString;
end;

procedure TA107FInsAssAutoRegole.DButtonStateChange(Sender: TObject);
begin
  inherited;
  btnAggiungi.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnTogli.Enabled:=DButton.State in [dsEdit,dsInsert];
  if DButton.State in [dsEdit,dsInsert] then
  begin
    lstCausali.OnDblClick:=btnTogliClick;
    lstCausali.OnDragDrop:=lstCausaliDragDrop;
    dlstCausaliDisponibili.OnDblClick:=btnAggiungiClick;
  end
  else
  begin
    lstCausali.OnDblClick:=nil;
    lstCausali.OnDragDrop:=nil;
    dlstCausaliDisponibili.OnDblClick:=nil;
  end;
end;

procedure TA107FInsAssAutoRegole.lstCausaliDragDrop(Sender, Source: TObject; X, Y: Integer);
var S:String;
    P1,P2:Integer;
    Point:Tpoint;
begin
  P1:=lstCausali.ItemIndex;
  if P1 = -1 then exit;
  S:=lstCausali.Items[P1];
  Point.X:=X;
  Point.Y:=Y;
  P2:=lstCausali.ItemAtPos(Point,False);
  lstCausali.Items.Delete(P1);
  if P2 > lstCausali.Items.Count then
    lstCausali.Items.Insert(P2 - 1,S)
  else
    lstCausali.Items.Insert(P2,S);
end;

procedure TA107FInsAssAutoRegole.lstCausaliDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=(Source = lstCausali) and (lstCausali.ItemIndex >= 0);
end;

procedure TA107FInsAssAutoRegole.btnAggiungiClick(Sender: TObject);
var Causale:String;
begin
  Causale:=dlstCausaliDisponibili.SelectedItem;
  if lstCausali.Items.IndexOf(Causale) = -1 then
    lstCausali.Items.Add(Causale);
  lstCausali.ItemIndex:=lstCausali.Items.IndexOf(Causale);
end;

procedure TA107FInsAssAutoRegole.btnTogliClick(Sender: TObject);
begin
  if lstCausali.ItemIndex >= 0 then
    lstCausali.Items.Delete(lstCausali.ItemIndex);
end;

end.
