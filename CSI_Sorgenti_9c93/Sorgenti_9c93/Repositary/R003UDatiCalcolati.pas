unit R003UDatiCalcolati;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, ActnList, ImgList, Db, Menus, ComCtrls, ToolWin, Grids,
  DBGrids, StdCtrls, DBCtrls, Mask, C180FunzioniGenerali, ExtCtrls, Variants,
  C012UVisualizzaTesto, System.Actions;

type
  TR003FDatiCalcolati = class(TR001FGestTab)
    dmemoEspressione: TDBMemo;
    Panel2: TPanel;
    Label1: TLabel;
    dcmbSerbatoi: TDBComboBox;
    Label6: TLabel;
    dcmbStampa: TDBComboBox;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBRadioGroup1: TDBRadioGroup;
    Label3: TLabel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    Panel4: TPanel;
    Panel5: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    lstDatiDisponibili: TListBox;
    lstFunzioniDisponibili: TListBox;
    Splitter2: TSplitter;
    PopupMenu1: TPopupMenu;
    Ordinealfabetico1: TMenuItem;
    PopupMenu2: TPopupMenu;
    VisualizzaCodice1: TMenuItem;
    actFiltroInutilizzati: TAction;
    actFiltroInutilizzati1: TMenuItem;
    procedure dcmbSerbatoiDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure dcmbSerbatoiChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lstDatiDisponibiliDblClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure lstFunzioniDisponibiliDblClick(Sender: TObject);
    procedure Ordinealfabetico1Click(Sender: TObject);
    procedure VisualizzaCodice1Click(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure actFiltroInutilizzatiExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  R003FDatiCalcolati: TR003FDatiCalcolati;

implementation

uses R003UGeneratoreStampeDtM;

{$R *.DFM}

procedure TR003FDatiCalcolati.dcmbSerbatoiDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,IntToStr(R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.Serbatoi[Index].X) + ' - ' + R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.Serbatoi[Index].Nome);
end;

procedure TR003FDatiCalcolati.dcmbSerbatoiChange(Sender: TObject);
var i,P:Integer;
begin
  if dcmbSerbatoi.ItemIndex = -1 then exit;
  lstDatiDisponibili.Items.Assign(R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.Serbatoi[dcmbSerbatoi.ItemIndex].lst);
  for i:=lstDatiDisponibili.Items.Count - 1 downto 0 do
  begin
    P:=R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.GetDato(lstDatiDisponibili.Items[i],False);
    if R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.Dati[P].Calcolato then
      lstDatiDisponibili.Items.Delete(i);
  end;
end;

procedure TR003FDatiCalcolati.FormShow(Sender: TObject);
begin
  DButton.DataSet:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.selT909;
  lstFunzioniDisponibili.Items.Assign(R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.lstFunzioniSQL);
  dcmbStampa.Items.Clear;
  with R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.selT910Codice do
  begin
    Close;
    Open;
    while not Eof do
    begin
      dcmbStampa.Items.Add(FieldByName('CODICE').AsString);
      Next;
    end;
    Close;
  end;
  dcmbSerbatoiChange(nil);
end;

procedure TR003FDatiCalcolati.lstDatiDisponibiliDblClick(Sender: TObject);
var S:String;
    i:Integer;
begin
  if DButton.State in [dsEdit,dsInsert] then
  begin
    S:=dmemoEspressione.Field.AsString;
    i:=dmemoEspressione.SelStart + 1;
    Insert(Identificatore(lstDatiDisponibili.Items[lstDatiDisponibili.ItemIndex]),S,i);
    dmemoEspressione.Field.AsString:=S;
    dmemoEspressione.SetFocus;
    dmemoEspressione.SelStart:=i - 1 + Length(Identificatore(lstDatiDisponibili.Items[lstDatiDisponibili.ItemIndex]));
    dmemoEspressione.SelLength:=0;
  end;
end;

procedure TR003FDatiCalcolati.DButtonStateChange(Sender: TObject);
begin
  inherited;
  dcmbSerbatoi.Enabled:=DButton.State in [dsInsert,dsEdit];
end;

procedure TR003FDatiCalcolati.DButtonDataChange(Sender: TObject;
  Field: TField);
begin
  if (Field = nil) or (Field = R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.selT909.FieldByName('ID_SERBATOIO')) then
    dcmbSerbatoiChange(nil);
end;

procedure TR003FDatiCalcolati.lstFunzioniDisponibiliDblClick(Sender: TObject);
var S:String;
    i:Integer;
begin
  if DButton.State in [dsEdit,dsInsert] then
  begin
    S:=dmemoEspressione.Field.AsString;
    i:=dmemoEspressione.SelStart + 1;
    Insert(lstFunzioniDisponibili.Items[lstFunzioniDisponibili.ItemIndex],S,i);
    dmemoEspressione.Field.AsString:=S;
    dmemoEspressione.SetFocus;
    dmemoEspressione.SelStart:=i  - 1 + Length(lstFunzioniDisponibili.Items[lstFunzioniDisponibili.ItemIndex]);
    dmemoEspressione.SelLength:=0;
  end;
end;

procedure TR003FDatiCalcolati.Ordinealfabetico1Click(Sender: TObject);
begin
  Ordinealfabetico1.Checked:=not Ordinealfabetico1.Checked;
  lstDatiDisponibili.Sorted:=Ordinealfabetico1.Checked;
  if not lstDatiDisponibili.Sorted then
    dcmbSerbatoiChange(nil);
end;

procedure TR003FDatiCalcolati.VisualizzaCodice1Click(Sender: TObject);
var lst:TStringList;
begin
  try
    lst:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.getCodiceFunzione(lstFunzioniDisponibili.Items[lstFunzioniDisponibili.ItemIndex]);
    OpenC012VisualizzaTesto('Function ' + lstFunzioniDisponibili.Items[lstFunzioniDisponibili.ItemIndex],'',lst);
  finally
    lst.Free;
  end;
end;

procedure TR003FDatiCalcolati.PopupMenu2Popup(Sender: TObject);
begin
  VisualizzaCodice1.Enabled:=lstFunzioniDisponibili.ItemIndex >= 0;
end;

procedure TR003FDatiCalcolati.actFiltroInutilizzatiExecute(Sender: TObject);
var Filtro:String;
begin
  actFiltroInutilizzati.Checked:=not actFiltroInutilizzati.Checked;

  with R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW do
  begin
    setFiltroInutilizzati(selT909,actFiltroInutilizzati.Checked);
  end;
  NumRecords;
end;

procedure TR003FDatiCalcolati.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.selT909.SetVariable('FILTRO',null);
  R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.selT909.Close;
  R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.selT909.Open;
end;

end.
