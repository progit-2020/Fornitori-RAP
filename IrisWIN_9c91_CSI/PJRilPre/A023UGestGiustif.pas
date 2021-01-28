unit A023UGestGiustif;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DB, DBCtrls, ExtCtrls, Mask, Menus,
  A016UCausAssenze, A020UCausPresenze, OracleData, Variants,
  C180FunzioniGenerali, A000UInterfaccia, A000UMessaggi, Math, Oracle;

type
  // AOSTA_REGIONE - chiamata 85647.ini
  TDatiCausale = record
    Codice: String;
    VisitaFiscale: String;
  end;
  // AOSTA_REGIONE - chiamata 85647.fine

  TA023FGestGiustif = class(TForm)
    Label1: TLabel;
    LDaOre: TLabel;
    LAOre: TLabel;
    LCausale: TDBText;
    EDaOre: TMaskEdit;
    EAOre: TMaskEdit;
    RGTipoGiust: TRadioGroup;
    ECausale: TDBLookupComboBox;
    RGCausali: TRadioGroup;
    LData: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    Label4: TLabel;
    dcmbFamiliari: TDBLookupComboBox;
    rgpTipoMG: TRadioGroup;
    procedure dcmbKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RGCausaliClick(Sender: TObject);
    procedure RGTipoGiustClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure RefreshSelSG101;
    procedure dcmbFamiliariEnter(Sender: TObject);
    procedure ECausaleCloseUp(Sender: TObject);
    procedure ECausaleKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    // AOSTA_REGIONE - chiamata 85647.ini
    CausOrig: TDatiCausale;
    // AOSTA_REGIONE - chiamata 85647.fine
    Assenza:Boolean;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    GestioneTipoMezzaGiornata: Boolean;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    procedure AbilitaTipoFruizione;
  public
    DataGiust:TDateTime;
    Prog:Integer;
    TipoGiust:Char;
    sCausale:string;
    function GetCausale: String;
    function GetData: String;
  end;

var
  A023FGestGiustif: TA023FGestGiustif;

implementation

uses A023UTimbrature, A023UTimbratureDtM1;

{$R *.DFM}

procedure TA023FGestGiustif.FormCreate(Sender: TObject);
var
  Q: TOracleQuery;
begin
  LCausale.DataSource:=A023FTimbratureDtM1.A023FTimbratureMW.D265;
  ECausale.ListSource:=A023FTimbratureDtM1.A023FTimbratureMW.D265;
  Assenza:=True;
  TipoGiust:='I';
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  // visualizzazione e posizionamento del radiogroup tipo mezza giornata
  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=SessioneOracle;
    Q.ReadBuffer:=2;
    Q.SQL.Add('select sum(nvl(CSI_MAX_MGMAT,0) + nvl(CSI_MAX_MGPOM,0)) MAX_MG_TOT ');
    Q.SQL.Add('from   T265_CAUASSENZE ');
    Q.Execute;
    GestioneTipoMezzaGiornata:=Q.FieldAsInteger(0) > 0;
  finally
    FreeAndNil(Q);
  end;
  rgpTipoMG.Visible:=GestioneTipoMezzaGiornata;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
end;

procedure TA023FGestGiustif.RGCausaliClick(Sender: TObject);
{Abilito causali Presenza/Assenza a seconda della scelta}
begin
  if (RGCausali.ItemIndex = 0) and (Assenza) then
  begin
    RGTipoGiust.Items.Delete(0);
    RGTipoGiust.Items.Delete(0);
    ECausale.ListSource:=A023FTimbratureDtM1.A023FTimbratureMW.D275;
    LCausale.DataSource:=A023FTimbratureDtM1.A023FTimbratureMW.D275;
    dcmbFamiliari.KeyValue:=null;
    Assenza:=False;
  end;
  if (RGCausali.ItemIndex = 1) and (not Assenza) then
  begin
    RGTipoGiust.Items.Insert(0,'Mezza giornata');
    RGTipoGiust.Items.Insert(0,'Giornata');
    ECausale.ListSource:=A023FTimbratureDtM1.A023FTimbratureMW.D265;
    LCausale.DataSource:=A023FTimbratureDtM1.A023FTimbratureMW.D265;
    Assenza:=True;
  end;
  dcmbFamiliari.Enabled:=Assenza;
  RGTipoGiustClick(nil);
end;

procedure TA023FGestGiustif.RGTipoGiustClick(Sender: TObject);
{Abilito/disabilito DaOre-AOre}
begin
  if RGTipoGiust.ItemIndex = 0 then
  begin
    if RGTipoGiust.Items.Count = 4 then
      TipoGiust:='I'
    else
      TipoGiust:='N';
  end;
  if RGTipoGiust.ItemIndex = 1 then
  begin
    if RGTipoGiust.Items.Count = 4 then
      TipoGiust:='M'
    else
      TipoGiust:='D';
  end;
  if RGTipoGiust.ItemIndex = 2 then
    TipoGiust:='N';
  if RGTipoGiust.ItemIndex = 3 then
    TipoGiust:='D';
  EDaOre.Enabled:=TipoGiust in ['M','N','D'];
  EAOre.Enabled:=TipoGiust = 'D';
  LDaOre.Enabled:=EDaOre.Enabled;
  LAOre.Enabled:=EAOre.Enabled;

  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  AbilitaTipoFruizione;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
end;

procedure TA023FGestGiustif.Nuovoelemento1Click(Sender: TObject);
{Inserimento nuovo giustificativo presenza/assenza}
begin
  with A023FTimbratureDtM1 do
    case RGCausali.ItemIndex of
    0:begin
        OpenA020CausPresenze(ECausale.Text);
        A023FTimbratureMW.Q275.DisableControls;
        A023FTimbratureMW.Q275.Refresh;
        A023FTimbratureMW.Q275.EnableControls;
        end;
    1:begin
        OpenA016CausAssenze(ECausale.Text);
        A023FTimbratureMW.Q265.DisableControls;
        A023FTimbratureMW.Q265.Refresh;
        A023FTimbratureMW.Q265.EnableControls;
      end;
    end;
  (LCausale.DataSource.DataSet as TOracleDataSet).SearchRecord('CODICE',ECausale.Text,[srFromBeginning]);
  LCausale.Refresh;
  A023FTimbratureDtM1.A023FTimbratureMW.R502ProDtM1.Resetta;
  A023FTimbrature.SBConteggiClick(A023FTimbrature.SBConteggi);
end;

procedure TA023FGestGiustif.RefreshSelSG101;
var DN:TDateTime;
begin
  if not A023FTimbratureDtM1.A023FTimbratureMW.R600DtM1.selSG101.Active then
    Exit;
  if dcmbFamiliari.KeyValue = null then
    DN:=0
  else
    DN:=VarToDateTime(dcmbFamiliari.KeyValue);

  with A023FTimbratureDtM1.A023FTimbratureMW.R600DtM1 do
  begin
    selSG101.Filtered:=False;
    selSG101.Filtered:=True;
    if selSG101.RecordCount = 1 then
      dcmbFamiliari.KeyValue:=selSG101.FieldByName('DATA').Value
    else if selSG101.SearchRecord('DATA',DN,[srFromBeginning]) then
      dcmbFamiliari.KeyValue:=DN
    else
      dcmbFamiliari.KeyValue:=null;
  end;
end;

procedure TA023FGestGiustif.AbilitaTipoFruizione;
var
  i: Integer;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  LFruizMaxMattine, LFruizMaxPomeriggi: Integer;
  LCausStr: String;
  LAbilitaTipoMG: Boolean;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
begin
  if ECausale.KeyValue = null then
  begin
    // causale non selezionata
    for i:=0 to RGTipoGiust.ControlCount - 1 do
      with R180RadioGroupButton(RGTipoGiust,i) do
        Enabled:=False;
  end
  else
  begin
    // ciclo di abilitazione dei tipi fruizione
    if RGCausali.ItemIndex = 0 then
    begin
      // causali di presenza
      with A023FTimbratureDtM1.A023FTimbratureMW.Q275 do
      begin
        R180RadioGroupButton(RGTipoGiust,0).Enabled:=FieldByName('UM_INSERIMENTO_H').AsString = 'S';
        R180RadioGroupButton(RGTipoGiust,1).Enabled:=FieldByName('UM_INSERIMENTO_D').AsString = 'S';
      end;
    end
    else
    begin
      // causali di assenza
      with A023FTimbratureDtM1.A023FTimbratureMW.Q265 do
      begin
        R180RadioGroupButton(RGTipoGiust,0).Enabled:=FieldByName('UM_INSERIMENTO').AsString = 'S';
        R180RadioGroupButton(RGTipoGiust,1).Enabled:=FieldByName('UM_INSERIMENTO_MG').AsString = 'S';
        R180RadioGroupButton(RGTipoGiust,2).Enabled:=FieldByName('UM_INSERIMENTO_H').AsString = 'S';
        R180RadioGroupButton(RGTipoGiust,3).Enabled:=FieldByName('UM_INSERIMENTO_D').AsString = 'S';
      end;
    end;
  end;

  // verifica che l'item attualmente selezionato sia abilitato
  with R180RadioGroupButton(RGTipoGiust,RGTipoGiust.ItemIndex) do
  begin
    if Checked and (not Enabled) then
    begin
      // seleziona il primo radiobutton abilitato nell'ordine
      for i:=0 to RGTipoGiust.ControlCount - 1 do
        with R180RadioGroupButton(RGTipoGiust,i) do
          if Enabled then
          begin
            Checked:=True;
            Break;
          end;
    end;
  end;

  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  // abilitazione tipo mezza giornata
  if GestioneTipoMezzaGiornata then
  begin
    LAbilitaTipoMG:=(RGCausali.ItemIndex = 1) and (RGTipoGiust.ItemIndex = 1);
    if LAbilitaTipoMG then
    begin
      // giustificativo di assenza a mezza giornata
      // abilita l'indicazione della tipologia di mezza giornata
      // solo se la causale prevede fruizioni mattine + pomeriggi > 0
      if ECausale.KeyValue = null then
      begin
        LAbilitaTipoMG:=False;
      end
      else
      begin
        LCausStr:=VarToStr(ECausale.KeyValue);
        LFruizMaxMattine:=StrToIntDef(VarToStr(A023FTimbratureDtM1.A023FTimbratureMW.Q265.Lookup('CODICE',LCausStr,'CSI_MAX_MGMAT')),0);
        LFruizMaxPomeriggi:=StrToIntDef(VarToStr(A023FTimbratureDtM1.A023FTimbratureMW.Q265.Lookup('CODICE',LCausStr,'CSI_MAX_MGPOM')),0);
        LAbilitaTipoMG:=(LFruizMaxMattine + LFruizMaxPomeriggi) > 0;
      end;
    end;
    rgpTipoMG.Visible:=LAbilitaTipoMG;
  end;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
end;

procedure TA023FGestGiustif.BitBtn1Click(Sender: TObject);
var Msg, DaOre, AOre, VF: String;
{Confermo le modifiche}
begin
  // controllo indicazione causale
  if ECausale.Text = '' then
  begin
    ECausale.SetFocus;
    raise Exception.Create(A000MSG_A023_ERR_NO_CAUS);
  end;
  // AOSTA_REGIONE - chiamata 85647.ini
  // controlli per causale di assenza
  if RGCausali.ItemIndex = 1 then
  begin
    // se la causale originale NON ha la gestione visite fiscali
    // e quella modificata sì, si impedisca la modifica della causale
    if (CausOrig.VisitaFiscale = 'N') then
    begin
      if VarToStr(A023FTimbratureDtM1.A023FTimbratureMW.Q265.Lookup('CODICE',ECausale.KeyValue,'VISITA_FISCALE')) = 'S' then
        raise Exception.Create(A000TraduzioneStringhe(A000MSG_A023_ERR_MOD_VISITA_FISCALE_N_S));
    end;

    if (A023FTimbratureDtM1.A023FTimbratureMW.GetValStrT230(ECausale.KeyValue,'CAUSALI_CHECKCOMPETENZE',DataGiust) <> '') or
       (A023FTimbratureDtM1.A023FTimbratureMW.GetValStrT230(ECausale.KeyValue,'CAUSALE_FRUIZORE',DataGiust) <> '') or
       (A023FTimbratureDtM1.A023FTimbratureMW.GetValStrT230(ECausale.KeyValue,'CAUSALE_HMASSENZA',DataGiust) <> '')
    then
    begin
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_A023_ERR_NO_MOD_GIUST));
    end;
  end;
  // AOSTA_REGIONE - chiamata 85647.fine

  // controllo da ore / numero ore
  if RGTipoGiust.ItemIndex > (RGTipoGiust.Items.Count - 3) then
  begin
    try
      StrToTime(EDaOre.Text);
    except
      EDaOre.SetFocus;
      raise Exception.Create(A000MSG_A023_ERR_DAORE);
    end;
  end;
  // controllo a ore
  if RGTipoGiust.ItemIndex > (RGTipoGiust.Items.Count-2) then
  begin
    try
      StrToTime(EAOre.Text);
    except
      EAOre.SetFocus;
      raise Exception.Create(A000MSG_A023_ERR_AORE);
    end;
    if (StrToTime(EDaOre.Text) > StrToTime(EAOre.Text)) and (R180OreMinutiExt(EAOre.Text) <> 0) then
    begin
      EAOre.SetFocus;
      raise Exception.Create(A000MSG_A023_ERR_PERIODO);
    end;
  end;
  // controlli per familiare di riferimento
  if RGCausali.ItemIndex = 1 then
  begin
    with A023FTimbratureDtM1.A023FTimbratureMW.Q265 do
    begin
      SearchRecord('CODICE',ECausale.KeyValue,[srFromBeginning]);
      if (dcmbFamiliari.KeyValue <> Null) and
         (FieldByName('CUMULO_FAMILIARI').AsString = 'N') and
         (FieldByName('FRUIZIONE_FAMILIARI').AsString = 'N') then
        dcmbFamiliari.KeyValue:=null;
    end;
  end
  else
  begin
    A023FTimbratureDtM1.A023FTimbratureMW.Q275.SearchRecord('CODICE',ECausale.KeyValue,[srFromBeginning]);
    dcmbFamiliari.KeyValue:=null;
  end;

  DaOre:=EDaOre.Text;
  AOre:=EAOre.Text;
  Msg:=A023FTimbratureDtM1.A023FTimbratureMW.VerificaCausaleTipoGiust(RGCausali.ItemIndex,DataGiust, TipoGiust,VartoStr(ECausale.KeyValue),CausOrig.Codice,(dcmbFamiliari.KeyValue <> null), DaOre, AOre);
  if Msg <> '' then
    raise Exception.Create(Msg);
  EDaOre.Text:=DaOre;
  EAOre.Text:=AOre;
  sCausale:=ECausale.Text;
  ModalResult:=mrOk;
end;

procedure TA023FGestGiustif.FormClose(Sender: TObject;
  var Action: TCloseAction);
var sDep:string;
begin
  with A023FTimbratureDtM1 do
  begin
    sDep:=VarToStr(ECausale.KeyValue);
    A023FTimbratureMW.Q265.Filtered:=False;
    A023FTimbratureMW.Q275.Filtered:=False;
    ECausale.KeyValue:=sDep;
  end;
end;

procedure TA023FGestGiustif.FormShow(Sender: TObject);
var sDep:string;
begin
  // salva dati della causale originale
  // TORINO_ASLTO2 - 2013/044 - INT_TECN 4 - controllo inizio catena.ini
  CausOrig.Codice:=VarToStr(ECausale.KeyValue);
  // TORINO_ASLTO2.fine
  // AOSTA_REGIONE - chiamata 85647.ini
  // salva il valore del flag visita fiscale
  CausOrig.VisitaFiscale:=VarToStr(A023FTimbratureDtM1.A023FTimbratureMW.Q265.Lookup('CODICE',CausOrig.Codice,'VISITA_FISCALE'));
  // AOSTA_REGIONE - chiamata 85647.fine

  with A023FTimbratureDtM1 do
  begin
    sDep:=VarToStr(ECausale.KeyValue);
    A023FTimbratureMW.Q265.Filtered:=True;
    A023FTimbratureMW.Q275.Filtered:=True;
    ECausale.KeyValue:=sDep;
  end;
  AbilitaTipoFruizione;
end;

procedure TA023FGestGiustif.dcmbFamiliariEnter(Sender: TObject);
begin
  RefreshSelSG101;
end;

procedure TA023FGestGiustif.dcmbKeyDown(Sender: TObject; var Key: Word;
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

procedure TA023FGestGiustif.ECausaleCloseUp(Sender: TObject);
begin
  RefreshSelSG101;
  AbilitaTipoFruizione;
end;

procedure TA023FGestGiustif.ECausaleKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  RefreshSelSG101;
  AbilitaTipoFruizione;
end;

//usate da A023FTimbratureMW.selSG101FilterRecord
function TA023FGestGiustif.GetData: String;
begin
  Result:=LData.Caption;
end;

function TA023FGestGiustif.GetCausale: String;
begin
  Result:=Ecausale.Text;
end;

end.
