unit A164UQuoteIncentivi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, ComCtrls,
  ToolWin, StdCtrls, Mask, DBCtrls, Buttons, Grids,
  DBGrids, ExtCtrls, A000UInterfaccia, A000UCostanti, A000USessione, A163UTipoQuote,
  Oracle, OracleData, A003UDataLavoroBis, C180FunzioniGenerali, System.Actions;

type
  TA164FQuoteIncentivi = class(TR004FGestStorico)
    Panel1: TPanel;
    lblDato2: TLabel;
    lblDato3: TLabel;
    lblDato1: TLabel;
    lblCodTipoQuota: TLabel;
    lblImporto: TLabel;
    dlblDato1: TDBText;
    dlblDato2: TDBText;
    dlblDato3: TDBText;
    dcmbDato1: TDBLookupComboBox;
    dcmbDato2: TDBLookupComboBox;
    dcmbDato3: TDBLookupComboBox;
    dcmbCodTipoQuota: TDBLookupComboBox;
    dedtImporto: TDBEdit;
    dgrdQuote: TDBGrid;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    dedtNumOre: TDBEdit;
    lblNumOre: TLabel;
    dedtPercIndividuale: TDBEdit;
    lblPercIndividuale: TLabel;
    dedtPercStrutturale: TDBEdit;
    lblPercStrutturale: TLabel;
    lblTipologia: TLabel;
    dlblAssenza: TDBText;
    dcmbAssenza: TDBLookupComboBox;
    Label5: TLabel;
    dchkSaldo: TDBCheckBox;
    dchkPartTime: TDBCheckBox;
    dedtPercentuale: TDBEdit;
    lblPercentuale: TLabel;
    dedtPenalizzazione: TDBEdit;
    lblPenalizzazione: TLabel;
    dedtValutStrutturale: TDBEdit;
    lblValutStrutturale: TLabel;
    lblImpNetto: TLabel;
    dlblTipoQuota: TDBText;
    dlblImpNetto: TDBText;
    sbtDecorrenzaFine: TSpeedButton;
    dedtDataFine: TDBEdit;
    Label3: TLabel;
    actAggGlobale: TAction;
    Aggiornamentoglobale1: TMenuItem;
    lblTipoStampa: TLabel;
    dcmbTipoStampa: TDBComboBox;
    procedure dcmbDato1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure TInserClick(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure dcmbCodTipoQuotaCloseUp(Sender: TObject);
    procedure dcmbCodTipoQuotaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dcmbDato1CloseUp(Sender: TObject);
    procedure dcmbDato2CloseUp(Sender: TObject);
    procedure dcmbDato3CloseUp(Sender: TObject);
    procedure dcmbDato3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dcmbDato2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dcmbDato1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dcmbAssenzaCloseUp(Sender: TObject);
    procedure dcmbAssenzaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure sbtDecorrenzaFineClick(Sender: TObject);
    procedure dedtImportoExit(Sender: TObject);
    procedure actAggGlobaleExecute(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure TModifClick(Sender: TObject);
    procedure dedtDecorrenzaExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A164FQuoteIncentivi: TA164FQuoteIncentivi;

  procedure OpenA164QuoteIncentivi;

implementation

uses A164UQuoteIncentiviDtM, A164UAggGlobale;

{$R *.dfm}

procedure OpenA164QuoteIncentivi;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA164QuoteIncentivi') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA164FQuoteIncentivi, A164FQuoteIncentivi);
  Application.CreateForm(TA164FQuoteIncentiviDtM, A164FQuoteIncentiviDtM);
  try
    Screen.Cursor:=crDefault;
    A164FQuoteIncentivi.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A164FQuoteIncentivi.Free;
    A164FQuoteIncentiviDtM.Free;
  end;
end;

procedure TA164FQuoteIncentivi.actAggGlobaleExecute(Sender: TObject);
var s:String;
begin
  inherited;
  s:=A164FQuoteIncentiviDtM.A164FQuoteIncentiviMW.selT765.FieldByName('CODICE').AsString;
  A164FQuoteIncentiviDtM.A164FQuoteIncentiviMW.selT765.First;
  OpenA164AggGlobale;
  A164FQuoteIncentiviDtM.A164FQuoteIncentiviMW.selT765.SearchRecord('CODICE',s,[srFromBeginning]);
  A164FQuoteIncentiviDtM.selT770.Refresh;
end;

procedure TA164FQuoteIncentivi.dcmbAssenzaCloseUp(Sender: TObject);
var txtAssenza:String;
begin
  inherited;
  if DButton.State in [dsEdit,dsInsert] then
    txtAssenza:=Trim(dcmbAssenza.Text)
  else
    txtAssenza:=A164FQuoteIncentiviDtM.selT770.FieldByName('CAUSALE').AsString.Trim;
  if (Sender <> nil) and (DButton.State in [dsEdit,dsInsert]) and (Trim(dcmbAssenza.Text) <> '') then
  begin
    A164FQuoteIncentiviDtM.selT770.FieldByName('CODTIPOQUOTA').AsString:='';
    dcmbCodTipoQuotaCloseUp(nil);
  end;
  dlblAssenza.Visible:=txtAssenza <> '';//Trim(dcmbAssenza.Text) <> '';
  dedtPercentuale.Enabled:=txtAssenza <> '';//Trim(dcmbAssenza.Text) <> '';
  lblPercentuale.Enabled:=txtAssenza <> '';//Trim(dcmbAssenza.Text) <> '';
  dchkSaldo.Enabled:=txtAssenza <> '';//Trim(dcmbAssenza.Text) <> '';
  dchkPartTime.Enabled:=txtAssenza <> '';//Trim(dcmbAssenza.Text) <> '';
end;

procedure TA164FQuoteIncentivi.dcmbAssenzaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  dcmbAssenzaCloseUp(dcmbAssenza);
end;

procedure TA164FQuoteIncentivi.dcmbCodTipoQuotaCloseUp(Sender: TObject);
var
  TipoQuota: String;
  txtTipoQuota: String;
begin
  inherited;
  if DButton.State in [dsEdit,dsInsert] then
    txtTipoQuota:=Trim(dcmbCodTipoQuota.Text)
  else
    txtTipoQuota:=A164FQuoteIncentiviDtM.selT770.FieldByName('CODTIPOQUOTA').AsString.Trim;
  dlblTipoQuota.Visible:=txtTipoQuota <> '';//Trim(dcmbCodTipoQuota.Text) <> '';
  lblTipologia.Visible:=txtTipoQuota <> '';//Trim(dcmbCodTipoQuota.Text) <> '';
  dedtNumOre.Enabled:=False;
  dedtPercIndividuale.Enabled:=False;
  dedtPercStrutturale.Enabled:=False;
  dedtValutStrutturale.Enabled:=False;
  lblImpNetto.Enabled:=False;
  dlblImpNetto.Enabled:=False;
  dedtPenalizzazione.Enabled:=False;
  lblImporto.Enabled:=False;
  lblTipoStampa.Enabled:=False;
  dcmbTipoStampa.Enabled:=False;
  with A164FQuoteIncentiviDtM do
  begin
    if (Sender <> nil) and (DButton.State in [dsEdit,dsInsert]) and (Trim(dcmbCodTipoQuota.Text) <> '') then
    begin
      selT770.FieldByName('PERCENTUALE').AsInteger:=100;
      selT770.FieldByName('PENALIZZAZIONE').AsString:='';
      selT770.FieldByName('CAUSALE').AsString:='';
      dlblAssenza.Visible:=False;
      dedtPercentuale.Enabled:=False;
      lblPercentuale.Enabled:=False;
      dchkSaldo.Enabled:=False;
      dchkPartTime.Enabled:=False;
    end;
    if txtTipoQuota <> '' then //Trim(dcmbCodTipoQuota.Text) <> '' then
    begin
      TipoQuota:=A164FQuoteIncentiviMW.getTipoQuotaByCod(txtTipoQuota);//A164FQuoteIncentiviMW.getTipoQuotaByCod(dCmbCodTipoQuota.Text);
      lblTipologia.Caption:=R180getCaptionTipologia(TipoQuota);

      dedtNumOre.Enabled:=TipoQuota = 'Q';
      dedtPercIndividuale.Enabled:=R180In(TipoQuota,['I','V','C']);
      dedtPercStrutturale.Enabled:=dedtPercIndividuale.Enabled;
      dedtValutStrutturale.Enabled:=dedtPercIndividuale.Enabled;
      dedtPenalizzazione.Enabled:=TipoQuota = 'P';
      dedtImporto.Enabled:=(TipoQuota <> 'P') and (selT770.FieldByName('PERCENTUALE').AsInteger = 100);
      dlblImpNetto.Enabled:=R180In(TipoQuota,['I','V','C','Q']);
      dcmbTipoStampa.Enabled:=TipoQuota = 'Q';
    end;
  end;
  lblNumOre.Enabled:=dedtNumOre.Enabled;
  lblPercIndividuale.Enabled:=dedtPercIndividuale.Enabled;
  lblPercStrutturale.Enabled:=dedtPercStrutturale.Enabled;
  lblValutStrutturale.Enabled:=dedtValutStrutturale.Enabled;
  lblPenalizzazione.Enabled:=dedtPenalizzazione.Enabled;
  lblImporto.Enabled:=dedtImporto.Enabled;
  lblImpNetto.Enabled:=dlblImpNetto.Enabled;
  lblTipoStampa.Enabled:=dcmbTipoStampa.Enabled;
end;

procedure TA164FQuoteIncentivi.dcmbCodTipoQuotaKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbCodTipoQuotaCloseUp(dcmbCodTipoQuota);
end;

procedure TA164FQuoteIncentivi.dcmbDato1CloseUp(Sender: TObject);
begin
  inherited;
  dlblDato1.Visible:=Trim(dcmbDato1.Text) <> '';
end;

procedure TA164FQuoteIncentivi.dcmbDato1KeyDown(Sender: TObject;
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

procedure TA164FQuoteIncentivi.dcmbDato1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  dcmbDato1CloseUp(nil);
end;

procedure TA164FQuoteIncentivi.dcmbDato2CloseUp(Sender: TObject);
begin
  inherited;
  dlblDato2.Visible:=Trim(dcmbDato2.Text) <> '';
end;

procedure TA164FQuoteIncentivi.dcmbDato2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  dcmbDato2CloseUp(nil);
end;

procedure TA164FQuoteIncentivi.dcmbDato3CloseUp(Sender: TObject);
begin
  inherited;
  dlblDato3.Visible:=Trim(dcmbDato3.Text) <> '';
end;

procedure TA164FQuoteIncentivi.dcmbDato3KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  dcmbDato3CloseUp(nil);
end;

procedure TA164FQuoteIncentivi.dedtDecorrenzaExit(Sender: TObject);
var sTmp: String;
begin
  inherited;
  with A164FQuoteIncentiviDtM do
  begin
    if selT770.State in [dsEdit,dsInsert] then
    begin
      A164FQuoteIncentiviMW.ImpostaDecorrenzaDatasetLookup;
      //reimposto campi per forzare reload del campo di lookup
      sTmp:=selT770.FieldByName('DATO1').AsString;
      selT770.FieldByName('DATO1').AsString:='';
      selT770.FieldByName('DATO1').AsString:=sTmp;
      sTmp:=selT770.FieldByName('DATO2').AsString;
      selT770.FieldByName('DATO2').AsString:='';
      selT770.FieldByName('DATO2').AsString:=sTmp;

      sTmp:=selT770.FieldByName('DATO3').AsString;
      selT770.FieldByName('DATO3').AsString:='';
      selT770.FieldByName('DATO3').AsString:=sTmp;

      sTmp:=selT770.FieldByName('CODTIPOQUOTA').AsString;
      selT770.FieldByName('CODTIPOQUOTA').AsString:='';
      selT770.FieldByName('CODTIPOQUOTA').AsString:=sTmp;
    end;
  end;
end;

procedure TA164FQuoteIncentivi.dedtImportoExit(Sender: TObject);
begin
  inherited;
  with A164FQuoteIncentiviDtM do
    selT770.FieldByName('IMPORTO').AsFloat:=R180Arrotonda(selT770.FieldByName('IMPORTO').AsFloat,0.00001,'P');
end;

procedure TA164FQuoteIncentivi.FormShow(Sender: TObject);
begin
  inherited;
  if Parametri.CampiRiferimento.C7_Dato1 <> '' then
  begin
    lblDato1.Caption:=R180Capitalize(Parametri.CampiRiferimento.C7_Dato1);
    dgrdQuote.Columns[0].Title.Caption:=lblDato1.Caption;
  end
  else
  begin
    lblDato1.Caption:='Dato 1 non definito';
    lblDato1.Enabled:=False;
    dcmbDato1.Enabled:=False;
    dgrdQuote.Columns[0].Visible:=False;
  end;

  if Parametri.CampiRiferimento.C7_Dato2 <> '' then
  begin
    lblDato2.Caption:=R180Capitalize(Parametri.CampiRiferimento.C7_Dato2);
    dgrdQuote.Columns[1].Title.Caption:=lblDato2.Caption;
  end
  else
  begin
    lblDato2.Caption:='Dato 2 non definito';
    lblDato2.Enabled:=False;
    dcmbDato2.Enabled:=False;
    dgrdQuote.Columns[1].Visible:=False;
  end;

  if Parametri.CampiRiferimento.C7_Dato3 <> '' then
  begin
    lblDato3.Caption:=R180Capitalize(Parametri.CampiRiferimento.C7_Dato3);
    dgrdQuote.Columns[2].Title.Caption:=lblDato3.Caption;
  end
  else
  begin
    lblDato3.Caption:='Dato 3 non definito';
    lblDato3.Enabled:=False;
    dcmbDato3.Enabled:=False;
    dgrdQuote.Columns[2].Visible:=False;
  end;

  VisioneCorrente1Click(nil);
end;

procedure TA164FQuoteIncentivi.Nuovoelemento1Click(Sender: TObject);
begin
  inherited;
  OpenA163TipoQuote;
end;

procedure TA164FQuoteIncentivi.sbtDecorrenzaFineClick(Sender: TObject);
begin
  inherited;
  with A164FQuoteIncentiviDtM do
  begin
    if selT770.FieldByName('DECORRENZA_FINE').IsNull then
      selT770.FieldByName('DECORRENZA_FINE').AsDateTime:=Parametri.DataLavoro;
    selT770.FieldByName('DECORRENZA_FINE').AsDateTime:=DataOut(selT770.FieldByName('DECORRENZA_FINE').AsDateTime,'Data fine','G');
  end;
end;

procedure TA164FQuoteIncentivi.Stampa1Click(Sender: TObject);
var Tab1,Tab2,Tab3, Cod1,Cod2,Cod3, Stor1,Stor2,Stor3:String;
begin
  if Parametri.CampiRiferimento.C7_Dato1 <> '' then
    A000GetTabella(Parametri.CampiRiferimento.C7_Dato1,Tab1,Cod1,Stor1);
  if Parametri.CampiRiferimento.C7_Dato2 <> '' then
    A000GetTabella(Parametri.CampiRiferimento.C7_Dato2,Tab2,Cod2,Stor2);
  if Parametri.CampiRiferimento.C7_Dato3 <> '' then
    A000GetTabella(Parametri.CampiRiferimento.C7_Dato3,Tab3,Cod3,Stor3);
  QueryStampa.Clear;
  QueryStampa.Add('SELECT T1.dato1, T1.dato2, T1.dato3, T1.codtipoquota, T1.decorrenza, T1.importo, T1.num_ore,');
  QueryStampa.Add('  T1.perc_individuale, T1.perc_strutturale, T1.percentuale, T1.considera_saldo, T1.sospendi_pt,');
  QueryStampa.Add('  T1.causale, T1.penalizzazione, T1.valut_strutturale, T1.decorrenza_fine, T1.TIPO_STAMPAQUANT,');
  QueryStampa.Add('  ROUND(T1.IMPORTO * (OREMINUTI(NVL(T1.NUM_ORE,''01.00'')) / 60) * T1.VALUT_STRUTTURALE / 100,5) TOTNETTO,');
  QueryStampa.Add(' T3.DESCRIZIONE DESCTIPOQUOTA,');
  QueryStampa.Add(' T2.DESCRIZIONE DESCCAUSALE');
  if Cod1 <> '' then
    QueryStampa.Add(' ,T4.DESCRIZIONE DESC1');
  if Cod2 <> '' then
    QueryStampa.Add(' ,T5.DESCRIZIONE DESC2');
  if Cod3 <> '' then
    QueryStampa.Add(' ,T6.DESCRIZIONE DESC3');
  QueryStampa.Add('  FROM T770_QUOTE T1, T265_CAUASSENZE T2, ');
  QueryStampa.Add('       (SELECT CODICE, DESCRIZIONE FROM T765_TIPOQUOTE T ');
  QueryStampa.Add('         WHERE DECORRENZA = (SELECT MAX(DECORRENZA) FROM T765_TIPOQUOTE WHERE CODICE = T.CODICE)) T3');
  if (Tab1 <> '') and (Tab1 <> 'T340_STORICO') then
    QueryStampa.Add(' , ' + Tab1 + ' T4');
  if (Tab2 <> '') and (Tab2 <> 'T340_STORICO') then
    QueryStampa.Add(' , ' + Tab2 + ' T5');
  if (Tab3 <> '') and (Tab3 <> 'T340_STORICO') then
    QueryStampa.Add(' , ' + Tab3 + ' T6');
  QueryStampa.Add(' WHERE T1.CAUSALE = T2.CODICE (+)');
  QueryStampa.Add('   AND T1.CODTIPOQUOTA = T3.CODICE (+)');
  if Cod1 <> '' then
    QueryStampa.Add('AND T1.DATO1 = T4.CODICE (+)');
  if Stor1 = 'S' then
    QueryStampa.Add('AND T1.DECORRENZA BETWEEN T4.DECORRENZA (+) AND T4.DECORRENZA_FINE (+)');
  if Cod2 <> '' then
    QueryStampa.Add('AND T1.DATO2 = T5.CODICE (+)');
  if Stor2 = 'S' then
    QueryStampa.Add('AND T1.DECORRENZA BETWEEN T5.DECORRENZA (+) AND T5.DECORRENZA_FINE (+)');
  if Cod3 <> '' then
    QueryStampa.Add('AND T1.DATO3 = T6.CODICE (+)');
  if Stor3 = 'S' then
    QueryStampa.Add('AND T1.DECORRENZA BETWEEN T6.DECORRENZA (+) AND T6.DECORRENZA_FINE (+)');
  QueryStampa.Add('ORDER BY T1.DATO1, T1.DATO2, T1.DATO3, T1.CODTIPOQUOTA, T1.CAUSALE, T1.DECORRENZA');
  NomiCampiR001.Clear;
  NomiCampiR001.Add('T1.DATO1');
  NomiCampiR001.Add('T1.DATO2');
  NomiCampiR001.Add('T1.DATO3');
  NomiCampiR001.Add('T1.CODTIPOQUOTA');
  NomiCampiR001.Add('T1.DECORRENZA');
  NomiCampiR001.Add('T1.IMPORTO');
  NomiCampiR001.Add('T1.NUM_ORE');
  NomiCampiR001.Add('T1.PERC_INDIVIDUALE');
  NomiCampiR001.Add('T1.PERC_STRUTTURALE');
  NomiCampiR001.Add('T1.PERCENTUALE');
  NomiCampiR001.Add('T1.CONSIDERA_SALDO');
  NomiCampiR001.Add('T1.SOSPENDI_PT');
  NomiCampiR001.Add('T1.CAUSALE');
  NomiCampiR001.Add('T1.PENALIZZAZIONE');
  NomiCampiR001.Add('T1.VALUT_STRUTTURALE');
  NomiCampiR001.Add('T1.DECORRENZA_FINE');
  NomiCampiR001.Add('T1.TIPO_STAMPAQUANT');
  NomiCampiR001.Add('ROUND(T1.IMPORTO * (OREMINUTI(NVL(T1.NUM_ORE,''01.00'')) / 60) * T1.VALUT_STRUTTURALE / 100,5)');
  NomiCampiR001.Add('T3.DESCRIZIONE');
  NomiCampiR001.Add('T2.DESCRIZIONE');
  if Cod1 <> '' then
    NomiCampiR001.Add('T4.DESCRIZIONE');
  if Cod2 <> '' then
    NomiCampiR001.Add('T5.DESCRIZIONE');
  if Cod3 <> '' then
    NomiCampiR001.Add('T6.DESCRIZIONE');
  inherited;
end;

procedure TA164FQuoteIncentivi.TAnnullaClick(Sender: TObject);
begin
  inherited;
  actRefresh.Execute;
end;

procedure TA164FQuoteIncentivi.TInserClick(Sender: TObject);
begin
  inherited;
  dCmbDato1.SetFocus;
end;

procedure TA164FQuoteIncentivi.TModifClick(Sender: TObject);
begin
  inherited;
  dcmbTipoStampa.Text:=dcmbTipoStampa.Items[StrToIntDef(A164FQuoteIncentiviDtM.selT770.FieldByName('TIPO_STAMPAQUANT').AsString,0)];
end;

procedure TA164FQuoteIncentivi.btnStoricizzaClick(Sender: TObject);
begin
  inherited;
  dedtDecorrenza.SetFocus;
end;

procedure TA164FQuoteIncentivi.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  lblImporto.Caption:=A164FQuoteIncentiviDtM.A164FQuoteIncentiviMW.getCaptionImporto;
end;

end.
