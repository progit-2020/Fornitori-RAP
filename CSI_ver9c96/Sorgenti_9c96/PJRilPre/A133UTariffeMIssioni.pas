unit A133UTariffeMissioni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, StdCtrls, ComCtrls,
  ToolWin, Mask, DBCtrls, Buttons, ExtCtrls, Grids, DBGrids, A000UCostanti, A000USessione, A000UInterfaccia,
  ToolbarFiglio, System.Actions;

type
  TA133FTariffeMissioni = class(TR004FGestStorico)
    Panel1: TPanel;
    lblCodContratto: TLabel;
    dlblDTrasferta: TDBText;
    lblCodPosizioneEconomica: TLabel;
    lblDescrizione: TLabel;
    lblCodLivello: TLabel;
    dcbxCodice: TDBLookupComboBox;
    dedtIndGiornaliera: TDBEdit;
    dedtDescrizione: TDBEdit;
    dedtCodTariffa: TDBEdit;
    pnlComuniGriglia: TPanel;
    dgrdEsenzioni: TDBGrid;
    GroupBox1: TGroupBox;
    dEdtCodVoceEsente: TDBEdit;
    lblCategoriaEconomica: TLabel;
    Label1: TLabel;
    dEdtCodVoceAssog: TDBEdit;
    frmToolbarFiglio: TfrmToolbarFiglio;
    procedure dcbxCodiceKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Stampa1Click(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure TCopiaSuGrigliaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    ProgDip:Integer;
    { Public declarations }
  end;

var
  A133FTariffeMissioni: TA133FTariffeMissioni;

  procedure OpenA133TariffeMissioni(Prog:Integer);

implementation

{$R *.dfm}

uses A133UTariffeMissioniDtM;

procedure OpenA133TariffeMissioni(Prog:Integer);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA133TariffeMissioni') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A133FTariffeMissioni:=TA133FTariffeMissioni.Create(nil);
  with A133FTariffeMissioni do
  try
    ProgDip:=Prog;

    A133FTariffeMissioniDtM:=TA133FTariffeMissioniDtM.Create(nil);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    FreeAndNil(A133FTariffeMissioniDtM);
    FreeAndNil(A133FTariffeMissioni);
  end;
end;

procedure TA133FTariffeMissioni.TCopiaSuGrigliaClick(Sender: TObject);
var QuotaEsente,CoeffMaggiorazione,PercRiduzione: Real;
    CodRiduzione, Descrizione: String;
begin
  with A133FTariffeMissioniDtM.A133FTariffeMissioniMW do
  begin
    if dsrM066.DataSet = nil then exit;
    if dsrM066.State <> dsBrowse then exit;
    if dsrM066.DataSet.RecordCount < 1 then exit;
    CodRiduzione:=selM066.FieldByName('COD_RIDUZIONE').AsString;
    Descrizione:=selM066.FieldByName('DESCRIZIONE').AsString;
    PercRiduzione:=selM066.FieldByName('PERC_RIDUZIONE').AsFloat;
    QuotaEsente:=selM066.FieldByName('QUOTA_ESENTE').AsFloat;
    CoeffMaggiorazione:=selM066.FieldByName('COEFF_MAGGIORAZIONE').AsFloat;
    frmToolbarFiglio.actTFInserisciExecute(frmToolbarFiglio.actTFInserisci);
    selM066.Insert;
    selM066.FieldByName('COD_RIDUZIONE').AsString:=CodRiduzione;
    selM066.FieldByName('DESCRIZIONE').AsString:=Descrizione;
    selM066.FieldByName('PERC_RIDUZIONE').AsFloat:=PercRiduzione;
    selM066.FieldByName('QUOTA_ESENTE').AsFloat:=QuotaEsente;
    selM066.FieldByName('COEFF_MAGGIORAZIONE').AsFloat:=CoeffMaggiorazione;
  end;
end;

procedure TA133FTariffeMissioni.TInserClick(Sender: TObject);
begin
  inherited;
  dedtDecorrenza.Text:='01/01/1900';
end;

procedure TA133FTariffeMissioni.Stampa1Click(Sender: TObject);
begin
  QueryStampa.Clear;
  QueryStampa.Add('SELECT M065.CODICE,M065.COD_TARIFFA,M065.DECORRENZA,M065.DESCRIZIONE,M065.IND_GIORNALIERA,M065.VOCEPAGHE_ESENTE,');
  QueryStampa.Add('M065.VOCEPAGHE_ASSOG,M066.COD_RIDUZIONE,M066.DESCRIZIONE,M066.PERC_RIDUZIONE,M066.QUOTA_ESENTE,M066.COEFF_MAGGIORAZIONE');
  QueryStampa.Add('FROM M065_TARIFFE_INDENNITA M065, M066_RIDUZIONI M066');
  QueryStampa.Add('WHERE M065.CODICE = M066.CODICE AND M065.COD_TARIFFA=M066.COD_TARIFFA AND M065.DECORRENZA=M066.DECORRENZA');
  QueryStampa.Add('ORDER BY M065.CODICE, M065.COD_TARIFFA, M065.DECORRENZA');
  NomiCampiR001.Clear;
  NomiCampiR001.Add('M065.CODICE');
  NomiCampiR001.Add('M065.COD_TARIFFA');
  NomiCampiR001.Add('M065.DECORRENZA');
  NomiCampiR001.Add('M065.DESCRIZIONE');
  NomiCampiR001.Add('M065.IND_GIORNALIERA');
  NomiCampiR001.Add('M065.VOCEPAGHE_ESENTE');
  NomiCampiR001.Add('M065.VOCEPAGHE_ASSOG');
  NomiCampiR001.Add('M066.COD_RIDUZIONE');
  NomiCampiR001.Add('M066.DESCRIZIONE');
  NomiCampiR001.Add('M066.PERC_RIDUZIONE');
  NomiCampiR001.Add('M066.QUOTA_ESENTE');
  NomiCampiR001.Add('M066.COEFF_MAGGIORAZIONE');
  inherited;
end;

procedure TA133FTariffeMissioni.dcbxCodiceKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA133FTariffeMissioni.FormShow(Sender: TObject);
begin
  inherited;
  dcbxCodice.ListSource:=A133FTariffeMissioniDtM.A133FTariffeMissioniMW.DSource;
  dgrdEsenzioni.DataSource:=A133FTariffeMissioniDtM.A133FTariffeMissioniMW.dsrM066;
  frmToolbarFiglio.TFDButton:=A133FTariffeMissioniDtM.A133FTariffeMissioniMW.dsrM066;
  frmToolbarFiglio.TFDBGrid:=dgrdEsenzioni;
  SetLength(frmToolbarFiglio.lstLock,3);
  frmToolbarFiglio.lstLock[0]:=Toolbar1;
  frmToolbarFiglio.lstLock[1]:=File1;
  frmToolbarFiglio.lstLock[2]:=Strumenti1;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
end;

end.
