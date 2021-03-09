unit A011UComuniProvinceRegioni;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Menus, Buttons,
  ExtCtrls, ComCtrls, StdCtrls, DBCtrls,  Mask, ImgList, ToolWin, ActnList, Grids, DBGrids,OracleData, Db,
  C180FUNZIONIGENERALI, A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi,
  A002UInterfacciaSt, L001Call, R001UGESTTAB, Variants, System.Actions;

type
  TA011FComuniProvinceRegioni = class(TR001FGestTab)
    pgcMain: TPageControl;
    tshComunali: TTabSheet;
    Panel3: TPanel;
    lblSelezionaComune: TLabel;
    L6: TLabel;
    lblProvincia: TLabel;
    lblCodice: TLabel;
    lblRegione: TLabel;
    dtxtD_Provincia: TDBText;
    dtxtD_Regione: TDBText;
    dcbxComune: TDBLookupComboBox;
    edtCodice: TDBEdit;
    edtCAP: TDBEdit;
    edtCitta: TDBEdit;
    pnlP442_CedolinoVoci: TPanel;
    dgrdListaComuni: TDBGrid;
    tshProvinciali: TTabSheet;
    Panel2: TPanel;
    lblSelezionaProvincia: TLabel;
    lblCodRegione: TLabel;
    lblCodProvincia: TLabel;
    dtxtD_Regione_1: TDBText;
    dcbxProvincia: TDBLookupComboBox;
    edtCodProvincia: TDBEdit;
    edtDescrizioneProvincia: TDBEdit;
    Panel6: TPanel;
    tshRegionali: TTabSheet;
    Panel7: TPanel;
    lblSelezionaRegione: TLabel;
    Label3: TLabel;
    dcbxRegione: TDBLookupComboBox;
    edtCodRegione1: TDBEdit;
    edtDescrizioneRegione: TDBEdit;
    Panel9: TPanel;
    rgpTipoSelezione: TRadioGroup;
    dcbxCodProvincia: TDBLookupComboBox;
    lblCodCatastale: TLabel;
    edtCodCatastale: TDBEdit;
    lblCitta: TLabel;
    dgrdListaProvince: TDBGrid;
    lblDescrizione: TLabel;
    Label1: TLabel;
    dgrdListaRegioni: TDBGrid;
    dcbxCodRegione: TDBLookupComboBox;
    lblCodIRPEF: TLabel;
    edtCodIRPEF: TDBEdit;
    dchkFiscale: TDBCheckBox;
    procedure dcmbKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rgpTipoSelezioneClick(Sender: TObject);
    procedure pgcMainChange(Sender: TObject);
    procedure CambiaDataSet;
    procedure DButtonStateChange(Sender: TObject);
    procedure pgcMainChanging(Sender: TObject; var AllowChange: Boolean);
    procedure TInserClick(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CodTabella,TipoTabella: String;
  end;

var
  A011FComuniProvinceRegioni: TA011FComuniProvinceRegioni;

procedure OpenA011ComuniProvinceRegioni(Cod,TipoArchivio:String);

implementation

uses A011UComuniProvinceRegioniDtM;

{$R *.DFM}

procedure OpenA011ComuniProvinceRegioni(Cod,TipoArchivio:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA011ComuniProvinceRegioni') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TA011FComuniProvinceRegioni, A011FComuniProvinceRegioni);
  A011FComuniProvinceRegioni.CodTabella:=Cod;
  A011FComuniProvinceRegioni.TipoTabella:=TipoArchivio;
  Application.CreateForm(TA011FComuniProvinceRegioniDtM, A011FComuniProvinceRegioniDtM);
  try
    Screen.Cursor:=crDefault;
    if Parametri.Applicazione = 'PAGHE' then
      A011FComuniProvinceRegioni.rgpTipoSelezione.ItemIndex:=1;
    A011FComuniProvinceRegioni.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A011FComuniProvinceRegioni.Free;
    A011FComuniProvinceRegioniDtM.Free;
  end;
end;

procedure TA011FComuniProvinceRegioni.FormActivate(Sender: TObject);
begin
  inherited;
  pgcmain.ActivePageIndex:=-1;
  with A011FComuniProvinceRegioniDtM do
  begin
    if TipoTabella = 'R' then
    begin
      pgcmain.ActivePageIndex:=2;
      CambiaDataSet;
      T482.SearchRecord('COD_REGIONE',CodTabella,[srFromBeginning]);
    end
    else if TipoTabella = 'P' then
    begin
      pgcmain.ActivePageIndex:=1;
      CambiaDataSet;
      T481.SearchRecord('COD_PROVINCIA',CodTabella,[srFromBeginning]);
    end
    else
    begin
      pgcmain.ActivePageIndex:=0;
      CambiaDataSet;
      T480.SearchRecord('CODICE',CodTabella,[srFromBeginning]);
    end;
  end;
end;

procedure TA011FComuniProvinceRegioni.FormClose(Sender: TObject;
  var Action: TCloseAction);
{Prima di chiudere controllo che non ci siano modifiche pendenti}
begin
  if not Panel1.Enabled then
    Action:=caNone
  else
  begin
    DButton.DataSet:=nil;
    inherited;
  end;
end;

procedure TA011FComuniProvinceRegioni.rgpTipoSelezioneClick(Sender: TObject);
var Cod,TipoSelezione: String;
begin
  Screen.Cursor:=crHourglass;
  with A011FComuniProvinceRegioniDtM do
  begin
    Cod:=T480.FieldByName('CODICE').AsString;
    if rgpTipoSelezione.ItemIndex = 0 then
      TipoSelezione:='R'
    else
      TipoSelezione:='T';
    if T480.GetVariable('TipoSelezione') <> TipoSelezione then
    begin
      T480.SetVariable('TipoSelezione',TipoSelezione);
      T480.Close;
      T480.Open;
      T480.SearchRecord('CODICE',Cod,[srFromBeginning]);
    end;
  end;
  Screen.Cursor:=crDefault;
  try
    NumRecords;
  except
  end;
end;

procedure TA011FComuniProvinceRegioni.pgcMainChange(Sender: TObject);
begin
  CambiaDataSet;
end;

procedure TA011FComuniProvinceRegioni.CambiaDataSet;
//Cambia l'assegnazione del DataSet al DButton per legare Comuni,Province,Regioni
begin
  with A011FComuniProvinceRegioniDtM do
  begin
    if pgcmain.ActivePageIndex = 0 then
    begin
      DButton.DataSet:=T480;
      dgrdListaComuni.SetFocus;
      NumRecords;
    end
    else if pgcmain.ActivePageIndex = 1 then
    begin
      DButton.DataSet:=T481;
      dgrdListaProvince.SetFocus;
      NumRecords;
    end
    else if pgcmain.ActivePageIndex = 2 then
    begin
      DButton.DataSet:=T482;
      dgrdListaRegioni.SetFocus;
      NumRecords;
    end;
    InizializzaDButton;
  end;
end;

procedure TA011FComuniProvinceRegioni.DButtonStateChange(Sender: TObject);
begin
  inherited;
  if pgcmain.ActivePageIndex = 0 then
  begin
    if (DButton.State in [dsEdit,dsInsert]) and (dgrdListaComuni.Focused) then
    try
      edtCodice.SetFocus;
    except
    end;
    dgrdListaComuni.Enabled:=DButton.State = dsBrowse;
    dcbxComune.Enabled:=DButton.State = dsBrowse;
    rgpTipoSelezione.Enabled:=DButton.State = dsBrowse;
  end
  else if pgcmain.ActivePageIndex = 1 then
  begin
    if (DButton.State in [dsEdit,dsInsert]) and (dgrdListaProvince.Focused) then
    try
      edtCodProvincia.SetFocus;
    except
    end;
    dgrdListaProvince.Enabled:=DButton.State = dsBrowse;
    dcbxProvincia.Enabled:=DButton.State = dsBrowse;
  end
  else if pgcmain.ActivePageIndex = 2 then
  begin
    if (DButton.State in [dsEdit,dsInsert]) and (dgrdListaRegioni.Focused) then
    try
      edtCodRegione1.SetFocus;
    except
    end;
    dgrdListaRegioni.Enabled:=DButton.State = dsBrowse;
    dcbxRegione.Enabled:=DButton.State = dsBrowse;
  end;
end;

procedure TA011FComuniProvinceRegioni.pgcMainChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange:=not (DButton.State in [dsInsert, dsEdit]);
end;

procedure TA011FComuniProvinceRegioni.TInserClick(Sender: TObject);
begin
  DButton.DataSet.Insert;
end;

procedure TA011FComuniProvinceRegioni.Stampa1Click(Sender: TObject);
begin
  QueryStampa.Clear;
  with A011FComuniProvinceRegioniDtM do
  begin
    case pgcmain.ActivePageIndex of
      0:QueryStampa.Add('SELECT * FROM T480_COMUNI');
      1:QueryStampa.Add(T481.SQL.Text);
      2:QueryStampa.Add(T482.SQL.Text);
    end;
  end;
  inherited;
end;

procedure TA011FComuniProvinceRegioni.dcmbKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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
