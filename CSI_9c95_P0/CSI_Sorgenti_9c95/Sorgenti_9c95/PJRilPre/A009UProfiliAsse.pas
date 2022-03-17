unit A009UProfiliAsse;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, Mask,
  DBCtrls, Grids, DBGrids, OracleData, L001Call, C180FunzioniGenerali,
  ActnList, ImgList, ToolWin, A000UCostanti, A000USessione,A000UInterfaccia, A017URaggrAsse, Variants,
  System.Actions, System.ImageList;

type
  TA009FProfiliAsse = class(TR001FGestTab)
    ScrollBox1: TScrollBox;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    DBGrid1: TDBGrid;
    pnlHeadTop: TPanel;
    grpFruizione: TGroupBox;
    Label14: TLabel;
    lblFruizMinimaDal: TLabel;
    dEdtFruizAnnoMinima: TDBEdit;
    dedtFruizMinimaDal: TDBEdit;
    pnlFruizioni: TPanel;
    lblFruizMaxNumGG: TLabel;
    dedtFruizMaxNumGG: TDBEdit;
    lblMaxFruizioneGiornInOre: TLabel;
    dedtMaxFruizioneGiornInOre: TDBEdit;
    Label12: TLabel;
    DBEdit14: TDBEdit;
    pnlHeadMiddle: TPanel;
    dRdgUMisura: TDBRadioGroup;
    drdgRapportiUniti: TDBRadioGroup;
    pnlCompetenze: TPanel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    dchkCompetenzePersonalizzate: TDBCheckBox;
    DBEdit3: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    Panel3: TPanel;
    GroupBox3: TGroupBox;
    DBRadioGroup3: TDBRadioGroup;
    DBCheckBox2: TDBCheckBox;
    DBComboBox1: TDBComboBox;
    GroupBox2: TGroupBox;
    lblArrCompetenzaInOre: TLabel;
    DBCheckBox1: TDBCheckBox;
    rgpTipoArrotondamento: TDBRadioGroup;
    dedtArrCompetenzaInOre: TDBEdit;
    pnlDatiProfilo: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    EProfilo: TDBLookupComboBox;
    Label2: TLabel;
    DBText1: TDBText;
    Label3: TLabel;
    ERaggruppamento: TDBLookupComboBox;
    DBText2: TDBText;
    procedure dEdtFruizAnnoMinimaExit(Sender: TObject);
    procedure EProfiloKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure dRdgUMisuraClick(Sender: TObject);
    procedure dRdgUMisuraChange(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBComboBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure DBComboBox1Change(Sender: TObject);
    procedure PulisciValore(Sender: TObject);
    procedure DBCheckBox1Click(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure DBRadioGroup3Click(Sender: TObject);
  private
    { Private declarations }
    AnnoOld:Integer;
    ProfOld:String;
    procedure AbilitaRgpTipoArrotondamento;
  public
    { Public declarations }
  end;

const D_Proporzione:array[0..4] of String =
      ('Nessuna proporzione',
       'Lavorato nel mese >= 16gg',
       'Lavorato nel mese > metà mese',
       'Lavorato nel mese >= 15gg',
       'Proporzione giornaliera'
       );

var
  A009FProfiliAsse: TA009FProfiliAsse;

procedure OpenA009ProfiliAsse(Cod:String);

implementation

uses A009UProfiliAsseDtM1;

{$R *.DFM}

procedure OpenA009ProfiliAsse(Cod:String);
{Gestione Profili Assenze}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA009ProfiliAsse') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA009FProfiliAsse, A009FProfiliAsse);
  Application.CreateForm(TA009FProfiliAsseDtM1, A009FProfiliAsseDtM1);
  try
    A009FProfiliAsseDtM1.selT262.SearchRecord('CodProfilo',Cod,[srFromBeginning]);
    A009FProfiliAsseDtM1.selT262.SearchRecord('CodProfilo;Anno',VarArrayOf([Cod,R180Anno(Parametri.DataLavoro)]),[srFromBeginning]);
    A009FProfiliAsse.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A009FProfiliAsse.Free;
    A009FProfiliAsseDtM1.Free;
  end;
end;

procedure TA009FProfiliAsse.Nuovoelemento1Click(Sender: TObject);
{Richiamo le Dll per aggiungere i Profili e i Raggruppamenti}
var Griglia:TInserisciDLL;
    i:Byte;
begin
  if PopupMenu1.PopupComponent = EProfilo then
    with A009FProfiliAsseDtM1.selT261 do
    begin
      Griglia.NomeTabella:='T261_DESCPROFASS';
      Griglia.Titolo:='Profili assenze annuali';
      for i:=0 to FieldCount -1 do
      begin
        Griglia.Display[i]:=Fields[i].DisplayLabel;
        Griglia.Size[i]:=Fields[i].DisplayWidth;
      end;
      Inserisci(Griglia,EProfilo.Text);
      A009FProfiliAsseDtM1.selT261.Refresh;
    end
  else
  begin
    OpenA017RaggrAsse(ERaggruppamento.Text);
    A009FProfiliAsseDtM1.Q260.Refresh;
  end;
end;

procedure TA009FProfiliAsse.dRdgUMisuraChange(Sender: TObject);
{Cambio la picture dei campi Competenze a seconda che si
lavori in Ore o in Giorni}
begin
  if DButton.State = dsBrowse then
    dRdgUMisuraClick(Sender);
end;

procedure TA009FProfiliAsse.dRdgUMisuraClick(Sender: TObject);
{Cambio la picture dei campi Competenze a seconda che si
lavori in Ore o in Giorni}
var i:Byte;
begin
  with A009FProfiliAsseDtM1.selT262 do
  begin
//    RadioValue:=dRdgUMisura.ItemIndex;
    for i:=1 to 6 do
      if dRdgUMisura.ItemIndex = 1 then  //Ore
        FieldByName('Competenza' + IntToStr(i)).EditMask:='!9990.00;1;_'
      else
        FieldByName('Competenza' + IntToStr(i)).EditMask:='!990,9;1;_';
    if dRdgUMisura.ItemIndex = 1 then
      FieldByName('FRUIZ_ANNO_MINIMA').EditMask:='!9990.00;1;_'
    else
      FieldByName('FRUIZ_ANNO_MINIMA').EditMask:='!990,9;1;_';
  end;
  DBCheckBox1.Enabled:=dRdgUMisura.ItemIndex = 0;
  lblArrCompetenzaInOre.Enabled:=dRdgUMisura.ItemIndex = 1;
  dedtArrCompetenzaInOre.Enabled:=dRdgUMisura.ItemIndex = 1;
  lblMaxFruizioneGiornInOre.Enabled:=dRdgUMisura.ItemIndex = 1;
  dedtMaxFruizioneGiornInOre.Enabled:=dRdgUMisura.ItemIndex = 1;
  dEdtFruizAnnoMinimaExit(nil);
  AbilitaRgpTipoArrotondamento;
end;

procedure TA009FProfiliAsse.AbilitaRgpTipoArrotondamento;
begin
  R180RadioGroupButton(TRadioGroup(rgpTipoArrotondamento),1).Enabled:=(DButton.State in [dsBrowse]) or (dRdgUMisura.ItemIndex = 0) and (not DBCheckBox1.Checked);
  if rgpTipoArrotondamento.Field = nil then exit;
  if (rgpTipoArrotondamento.Field.AsString = 'P') and
     ((dRdgUMisura.ItemIndex = 1) or (DBCheckBox1.Checked)) and
     //(not R180RadioGroupButton(TRadioGroup(rgpTipoArrotondamento),1).Enabled) and
     (DButton.State in [dsEdit,dsInsert]) then
    rgpTipoArrotondamento.Field.AsString:='F';
end;

procedure TA009FProfiliAsse.DButtonDataChange(Sender: TObject;
  Field: TField);
begin
  with A009FProfiliAsseDtM1 do
    begin
    if ((DButton.State = dsBrowse) and (Field = nil)) or
       ((DButton.State in [dsInsert,dsEdit]) and ((Field = selT262Anno) or (Field = selT262CodProfilo))) then
      if (selT262Anno.AsInteger <> AnnoOld) or (selT262CodProfilo.AsString <> ProfOld) then
        begin
        AnnoOld:=selT262Anno.AsInteger;
        ProfOld:=selT262CodProfilo.AsString;
        Q262.Close;
        Q262.SetVariable('Anno',selT262Anno.AsInteger);
        Q262.SetVariable('CodProfilo',selT262CodProfilo.AsString);
        Q262.Open;
        end;
    if (Field = nil) and (DButton.State = dsBrowse) then
      DBCheckBox2.Enabled:=(DBComboBox1.ItemIndex in [1,2,3]) and (DBRadioGroup3.ItemIndex <> 2);
    end;
end;

procedure TA009FProfiliAsse.DButtonStateChange(Sender: TObject);
begin
  inherited;
  AbilitaRgpTipoArrotondamento;
end;

procedure TA009FProfiliAsse.FormCreate(Sender: TObject);
begin
  inherited;
  AnnoOld:=0;
  ProfOld:='';
end;

procedure TA009FProfiliAsse.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A009FProfiliAsseDtM1.selT262;
  inherited;
end;

procedure TA009FProfiliAsse.DBComboBox1DrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,D_Proporzione[Index]);
end;

procedure TA009FProfiliAsse.DBRadioGroup3Click(Sender: TObject);
begin
  inherited;
  DBCheckBox2.Enabled:=(DBComboBox1.ItemIndex in [1,2,3]) and (DBRadioGroup3.ItemIndex <> 2);
  if (DButton.State in [dsEdit,dsInsert]) and (not DBCheckBox2.Enabled) then
    DBCheckBox2.Field.AsString:='N';
end;

procedure TA009FProfiliAsse.DBCheckBox1Click(Sender: TObject);
begin
  inherited;
  AbilitaRgpTipoArrotondamento;
end;

procedure TA009FProfiliAsse.DBComboBox1Change(Sender: TObject);
begin
  DBCheckBox2.Enabled:=(DBComboBox1.ItemIndex in [1,2,3]) and (DBRadioGroup3.ItemIndex <> 2);
  if (DButton.State in [dsEdit,dsInsert]) and (not DBCheckBox2.Enabled) then
    DBCheckBox2.Field.AsString:='N';
end;

procedure TA009FProfiliAsse.PulisciValore(Sender: TObject);
begin
  if not(DButton.State in [dsInsert,dsEdit]) then exit;
  if (Sender as TDBEdit).Text = '  .  ' then
    (Sender as TDBEdit).Field.Clear;
end;

procedure TA009FProfiliAsse.EProfiloKeyDown(Sender: TObject; var Key: Word;
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

procedure TA009FProfiliAsse.dEdtFruizAnnoMinimaExit(Sender: TObject);
begin
  inherited;
  lblFruizMinimaDal.Enabled:=(Trim(dEdtFruizAnnoMinima.Text) <> '.') and (Trim(dEdtFruizAnnoMinima.Text) <> ',');
  dedtFruizMinimaDal.Enabled:=lblFruizMinimaDal.Enabled;
  if (not dedtFruizMinimaDal.Enabled) and (DButton.State in [dsInsert,dsEdit]) then
    dedtFruizMinimaDal.Field.Clear;
end;

end.
