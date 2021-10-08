unit A066UValutaStr;

interface

uses
  A000UCostanti, A000USessione, A000UInterfaccia, RegistrazioneLog, A003UDataLavoroBis,
  C180FunzioniGenerali, StrUtils,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, StdCtrls, ComCtrls,
  ToolWin, Mask, Buttons, Grids, DBGrids, DBCtrls, Oracle, OracleData, ExtCtrls,
  System.Actions, A066UValutaStrMW;

type
  TA066FValutaStr = class(TR004FGestStorico)
    dgrdStraord: TDBGrid;
    BitBtn1: TBitBtn;
    pnlFiltri: TPanel;
    lblLivello: TLabel;
    dtxtLivello: TDBText;
    dcmbLivello: TDBLookupComboBox;
    lblCausale: TLabel;
    dtxtCausale: TDBText;
    dcmbCausale: TDBLookupComboBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dcmbLivelloClick(Sender: TObject);
    procedure dcmbCausaleClick(Sender: TObject);
    procedure dcmbLivelloKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    LungCod: Integer;
    procedure FiltraDati(const PLivello, PCausale: String);
  public
    //A066FValutaStrMW: TA066FValutaStrMW;
  end;

var
  A066FValutaStr: TA066FValutaStr;

procedure OpenA066ValutaStr;

implementation

uses A066UValutaStrDtM1, A066UDialog;

{$R *.dfm}

procedure OpenA066ValutaStr;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA066ValutaStr') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A066FValutaStr:=TA066FValutaStr.Create(nil);
  with A066FValutaStr do
  begin
    try
      A066FValutaStrDtM1:=TA066FValutaStrDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A066FValutaStrDtM1.Free;
      Free;
    end;
  end;
end;

procedure TA066FValutaStr.FormCreate(Sender: TObject);
begin
  inherited;
  LungCod:=0;
end;

procedure TA066FValutaStr.FormShow(Sender: TObject);
var
  CodList: TStringList;
  LivPickList,CausPickList: String;
  c: Integer;
begin
  DButton.Dataset:=A066FValutaStrDtM1.selT730;

  //dcmbMedLegale.ListSource:=A144FComuniMedLegaliDtm.A144FComuniMedLegaliMW.dscT485;
  dcmbLivello.ListSource:=A066FValutaStrDtM1.A066FValutaStrMW.dsrLivello;
  dcmbCausale.ListSource:=A066FValutaStrDtM1.A066FValutaStrMW.dsrT275;


  lblLivello.Caption:=R180Capitalize(StringReplace(Parametri.CampiRiferimento.C2_Livello,'_',' ',[rfReplaceAll]));
  if lblLivello.Caption = '' then
    exit;

  // imposta la picklist dei codici causale
  CodList:=TStringList.Create;
  try
    // lista livelli
    try
      CodList.Clear;

      //A066FValutaStrDtM1.selLivello.First;
      A066FValutaStrDtM1.A066FValutaStrMW.selLivello.First;

      //while not A066FValutaStrDtM1.selLivello.Eof do
      while not A066FValutaStrDtM1.A066FValutaStrMW.selLivello.Eof do
      begin
        //CodList.Add(A066FValutaStrDtM1.selLivello.FieldByName('CODICE').AsString);
        CodList.Add(A066FValutaStrDtM1.A066FValutaStrMW.selLivello.FieldByName('CODICE').AsString);
        //A066FValutaStrDtM1.selLivello.Next;
        A066FValutaStrDtM1.A066FValutaStrMW.selLivello.Next;
      end;
      LivPickList:=CodList.CommaText;

      c:=R180GetColonnaDBGrid(dgrdStraord,'LIVELLO');
      dgrdStraord.Columns.Items[c].PickList.BeginUpdate;
      dgrdStraord.Columns.Items[c].PickList.CommaText:=LivPickList;
      dgrdStraord.Columns.Items[c].PickList.EndUpdate;
    except
    end;

    // lista causali
    try
      CodList.Clear;
      //A066FValutaStrDtM1.selT275.First;
      A066FValutaStrDtM1.A066FValutaStrMW.selT275.First;
      //while not A066FValutaStrDtM1.selT275.Eof do
      while not A066FValutaStrDtM1.A066FValutaStrMW.selT275.Eof do
      begin
        //CodList.Add(A066FValutaStrDtM1.selT275.FieldByName('CODICE').AsString);
        CodList.Add(A066FValutaStrDtM1.A066FValutaStrMW.selT275.FieldByName('CODICE').AsString);
        //A066FValutaStrDtM1.selT275.Next;
        A066FValutaStrDtM1.A066FValutaStrMW.selT275.Next;
      end;
      CausPickList:=CodList.CommaText;

      c:=R180GetColonnaDBGrid(dgrdStraord,'CAUSALE');
      dgrdStraord.Columns.Items[c].PickList.BeginUpdate;
      dgrdStraord.Columns.Items[c].PickList.CommaText:=CausPickList;
      dgrdStraord.Columns.Items[c].PickList.EndUpdate;
    except
    end;
  finally
    FreeAndNil(CodList);
  end;
  inherited;
end;

procedure TA066FValutaStr.FiltraDati(const PLivello, PCausale: String);
// applica filtro lato client su dataset
var
  Filtro: String;
begin
  {
  A066FValutaStrDtM1.selT730.Filtered:=False;
  Filtro:='';

  A066FValutaStrDtM1.LivelloFiltro:=PLivello;
  if PLivello <> '' then
  begin
    Filtro:=Format('(LIVELLO = ''%s'')',[PLivello]);
  end;
  A066FValutaStrDtM1.CausaleFiltro:=PCausale;
  if PCausale <> '' then
  begin
    Filtro:=Filtro + IfThen(Filtro <> '',' and ') + Format('(CAUSALE = ''%s'')',[PCausale]);
  end;
  A066FValutaStrDtM1.selT730.Filter:=Filtro;
  A066FValutaStrDtM1.selT730.Filtered:=Filtro <> '';
  }
  A066FValutaStrDtM1.A066FValutaStrMW.FiltraDati(PLivello, PCausale);


end;

procedure TA066FValutaStr.dcmbCausaleClick(Sender: TObject);
begin
  FiltraDati(VarToStr(dcmbLivello.KeyValue),VarToStr(dcmbCausale.KeyValue));
end;

procedure TA066FValutaStr.dcmbLivelloClick(Sender: TObject);
begin
  FiltraDati(VarToStr(dcmbLivello.KeyValue),VarToStr(dcmbCausale.KeyValue));
end;

procedure TA066FValutaStr.dcmbLivelloKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
      begin
        (Sender as TDBLookupComboBox).Field.Dataset.FieldByName((Sender as TDBLookupComboBox).Field.KeyFields).Clear;
        (Sender as TDBLookupComboBox).Field.FocusControl;
      end
     else
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
  FiltraDati(VarToStr(dcmbLivello.KeyValue),VarToStr(dcmbCausale.KeyValue));
end;

procedure TA066FValutaStr.BitBtn1Click(Sender: TObject);
begin
  A066FDialog:=TA066FDialog.Create(nil);
  with A066FDialog do
  begin
    try
      DaLiv.Text:=VarToStr(dcmbLivello.KeyValue);
      ALiv.Text:=DaLiv.Text;
      //***DaLiv.Items.Assign(cmbLivello.Items);
      //***ALiv.Items.Assign(cmbLivello.Items);
      DaData.Text:=dedtDecorrenza.Text;
      AData.Text:=dedtDecorrenza.Text;
      ShowModal;
    finally
      Release;
    end;
  end;
end;

end.
