unit A039URegReperib;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, checklst, Db, Menus, Buttons, ExtCtrls, ComCtrls,
  R001UGESTTAB,C180FunzioniGenerali,Mask, DBCtrls, ActnList, ImgList,
  ToolWin, A000UCostanti, A000USessione,A000UInterfaccia, Variants,
  System.Actions;

type
  TA039FRegReperib = class(TR001FGestTab)
    Panel2: TPanel;
    DBECodice: TDBEdit;
    Label1: TLabel;
    DBEDescrizione: TDBEdit;
    DBEOraIni: TDBEdit;
    DBEOraFine: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    DBRdGrpTipoOre: TDBRadioGroup;
    DBRdGrpTipoTurno: TDBRadioGroup;
    Label4: TLabel;
    grpCampoRaggr: TGroupBox;
    Label5: TLabel;
    DBLookupCampiAnagra: TDBLookupComboBox;
    DBOreNonCaus: TDBCheckBox;
    Label6: TLabel;
    DBETolleranza: TDBEdit;
    Label7: TLabel;
    DBECompresenza: TDBEdit;
    dEdtTurnoIntero: TDBEdit;
    Durata: TLabel;
    grpVociPaghe: TGroupBox;
    dEdtVpTurno: TDBEdit;
    Label8: TLabel;
    dEdtVpOre: TDBEdit;
    dEdtVpMaggiorate: TDBEdit;
    dEdtVpNonMaggiorate: TDBEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    dchkDetrazMensa: TDBCheckBox;
    dbrgpTipologia: TDBRadioGroup;
    dedtOreMinIndennita: TDBEdit;
    lblOreMinIndennita: TLabel;
    DBEOreNormali: TDBEdit;
    grpLimiteMensile: TGroupBox;
    lblPianifMaxMese: TLabel;
    dedtPianifMaxMese: TDBEdit;
    dchkPianifMaxMeseTurniInteri: TDBCheckBox;
    dchkBloccaMaxMese: TDBCheckBox;
    dEdtGettoneChiamata: TDBEdit;
    Label12: TLabel;
    dEdtMaxMese: TDBEdit;
    lblMaxMese: TLabel;
    grpTollChiamata: TGroupBox;
    dedtTollChiamataInizio: TDBEdit;
    dedtTollChiamataFine: TDBEdit;
    lblTollChiamataInizio: TLabel;
    lblTollChiamataInizio2: TLabel;
    lblTollChiamataFine: TLabel;
    lblTollChiamataFine2: TLabel;
    procedure DBLookupCampiAnagraKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure DBRdGrpTipoOreChange(Sender: TObject);
    procedure DBRdGrpTipoTurnoChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBEditChange(Sender: TObject);
    procedure dbrgpTipologiaChange(Sender: TObject);
    procedure dedtPianifMaxMeseChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A039FRegReperib: TA039FRegReperib;

procedure OpenA039RegReperib(Cod:String);

implementation

uses A039URegReperibDTM1;

{$R *.DFM}

procedure OpenA039RegReperib(Cod:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA039RegReperib') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
 A039FRegReperib:=TA039FRegReperib.Create(nil);
  with A039FRegReperib do
  try
    A039FRegReperibDtM1:=TA039FRegReperibDtM1.Create(nil);
    A039FRegReperibDtM1.selT350.Locate('Codice',Cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A039FRegReperibDtM1.Free;
    Free;
  end;
end;

procedure TA039FRegReperib.DBRdGrpTipoOreChange(Sender: TObject);
begin
  case DBRdGrpTipoOre.ItemIndex of
    0,1:begin
          if DButton.State in [dsInsert,dsEdit] then
            A039FRegReperib.DBEOreNormali.Field.Clear;
          A039FRegReperib.DBEOreNormali.Enabled:=False;
        end;
    2:A039FRegReperib.DBEOreNormali.Enabled:=True;
  end;
end;

procedure TA039FRegReperib.DBRdGrpTipoTurnoChange(Sender: TObject);
var Abilitato:Boolean;
begin
  case DBRdGrpTipoTurno.ItemIndex of
    0:Abilitato:=False;
    1..2:Abilitato:=True;
  else
    Abilitato:=False;
  end;
  if (DButton.State in [dsEdit,dsInsert]) and (not Abilitato) then
  begin
    DBLookUpCampiAnagra.Field.Clear;
    DBLookUpCampiAnagra.KeyValue:=Null;
  end;
  if (DButton.State in [dsEdit,dsInsert]) and Abilitato then
    DBECompresenza.Field.Clear;
  label7.Enabled:=(dbrgpTipologia.ItemIndex = 0) and (not Abilitato);
  DBECompresenza.Enabled:=(dbrgpTipologia.ItemIndex = 0) and (not Abilitato);
  DBLookUpCampiAnagra.Enabled:=Abilitato;
end;

procedure TA039FRegReperib.dbrgpTipologiaChange(Sender: TObject);
begin
  inherited;
  Durata.Enabled:=dbrgpTipologia.ItemIndex = 0;
  dEdtTurnoIntero.Enabled:=dbrgpTipologia.ItemIndex = 0;
  DBRdGrpTipoOre.Enabled:=dbrgpTipologia.ItemIndex = 0;
  DBEOreNormali.Enabled:=(dbrgpTipologia.ItemIndex = 0) and (DBRdGrpTipoOre.ItemIndex = 2);
  DBRdGrpTipoTurno.Enabled:=dbrgpTipologia.ItemIndex = 0;
  grpVociPaghe.Enabled:=dbrgpTipologia.ItemIndex = 0;
  dEdtVpTurno.Enabled:=dbrgpTipologia.ItemIndex = 0;
  dEdtVpOre.Enabled:=dbrgpTipologia.ItemIndex = 0;
  dEdtVpMaggiorate.Enabled:=dbrgpTipologia.ItemIndex = 0;
  dEdtVpNonMaggiorate.Enabled:=dbrgpTipologia.ItemIndex = 0;
  dchkDetrazMensa.Enabled:=dbrgpTipologia.ItemIndex = 0;
  DBOreNonCaus.Enabled:=dbrgpTipologia.ItemIndex = 0;
  label5.Enabled:=dbrgpTipologia.ItemIndex = 0;
  label6.Enabled:=dbrgpTipologia.ItemIndex = 0;
  label7.Enabled:=dbrgpTipologia.ItemIndex = 0;
  label8.Enabled:=dbrgpTipologia.ItemIndex = 0;
  label9.Enabled:=dbrgpTipologia.ItemIndex = 0;
  label10.Enabled:=dbrgpTipologia.ItemIndex = 0;
  label11.Enabled:=dbrgpTipologia.ItemIndex = 0;
  DBETolleranza.Enabled:=dbrgpTipologia.ItemIndex = 0;
  DBECompresenza.Enabled:=dbrgpTipologia.ItemIndex = 0;
  grpCampoRaggr.Enabled:=dbrgpTipologia.ItemIndex = 0;
  DBLookupCampiAnagra.Enabled:=dbrgpTipologia.ItemIndex = 0;
  // daniloc.ini 24.03.2010
  dchkPianifMaxMeseTurniInteri.Enabled:=(dedtPianifMaxMese.Enabled) and
                                        (dedtPianifMaxMese.Text <> '');
  Label12.Enabled:=dbrgpTipologia.ItemIndex = 0;
  dEdtGettoneChiamata.Enabled:=dbrgpTipologia.ItemIndex = 0;
  lblMaxMese.Enabled:=dbrgpTipologia.ItemIndex = 0;
  dEdtMaxMese.Enabled:=dbrgpTipologia.ItemIndex = 0;
  // daniloc.fine
end;

procedure TA039FRegReperib.dedtPianifMaxMeseChange(Sender: TObject);
begin
  inherited;
  if TDBEdit(Sender).Text <> '' then
  begin
    dchkPianifMaxMeseTurniInteri.Enabled:=True;
    dchkBloccaMaxMese.Enabled:=True;
    if A039FREGREPERIBDTM1.selT350.FieldByName('PIANIF_MAX_MESE_TURNI_INTERI').IsNull then
      A039FREGREPERIBDTM1.selT350.FieldByName('PIANIF_MAX_MESE_TURNI_INTERI').AsString:='N';
  end
  else
  begin
    dchkPianifMaxMeseTurniInteri.Enabled:=False;
    dchkBloccaMaxMese.Enabled:=False;
    A039FREGREPERIBDTM1.selT350.FieldByName('PIANIF_MAX_MESE_TURNI_INTERI').Value:=null;
  end;
end;

procedure TA039FRegReperib.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A039FREGREPERIBDtM1.selT350;
  inherited;
end;

procedure TA039FRegReperib.FormShow(Sender: TObject);
begin
  inherited;
  DBLookupCampiAnagra.ListSource:=A039FREGREPERIBDTM1.A039MW.DCols;
end;

procedure TA039FRegReperib.DBEditChange(Sender: TObject);
begin
  if (DButton.State in [dsEdit,dsInsert]) and (Trim(TDBEdit(Sender).Text) = '.') then
    TDBEdit(Sender).Field.Clear;
end;

procedure TA039FRegReperib.DBLookupCampiAnagraKeyDown(Sender: TObject;var Key: Word; Shift: TShiftState);
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

end.
