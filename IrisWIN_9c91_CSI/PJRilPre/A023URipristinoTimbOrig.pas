unit A023URipristinoTimbOrig;

interface

uses
  A023UTimbratureDtM1, A000UInterfaccia, C180FunzioniGenerali, StrUtils,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, Spin, Buttons;

type
  TA023FRipristinoTimbOrig = class(TForm)
    grpOperazioni: TGroupBox;
    chkRipristinaOrig: TCheckBox;
    chkCancManuali: TCheckBox;
    chkCancIterWeb: TCheckBox;
    grpPeriodo: TGroupBox;
    sedtDal: TSpinEdit;
    sedtAl: TSpinEdit;
    lblMese: TLabel;
    lblDal: TLabel;
    lblAl: TLabel;
    grpAttuale: TGroupBox;
    dgrdAttuale: TDBGrid;
    grpSimulazione: TGroupBox;
    dgrdSimulazione: TDBGrid;
    grpLegenda: TGroupBox;
    lblFlagI: TLabel;
    lblFlagM: TLabel;
    lblFlagC: TLabel;
    lblFlagO: TLabel;
    lblFlagCDesc: TLabel;
    lblFlagMDesc: TLabel;
    lblFlagIDesc: TLabel;
    lblFlagODesc: TLabel;
    btnConferma: TBitBtn;
    btnAnnulla: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sedtDalChange(Sender: TObject);
    procedure sedtAlChange(Sender: TObject);
    procedure chkRipristinaOrigClick(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    function  EsistonoOperazioniSelezionate: Boolean;
  public
    Progressivo: Integer;
    DataInizio, DataFine: TDateTime;
  end;

var
  A023FRipristinoTimbOrig: TA023FRipristinoTimbOrig;

implementation

{$R *.dfm}

procedure TA023FRipristinoTimbOrig.FormCreate(Sender: TObject);
begin
  A023FTimbratureDtM1.A023FTimbratureMW.CreaDataSetSimulazione;
  dgrdAttuale.DataSource:=A023FTimbratureDtM1.A023FTimbratureMW.dscT100Ripristino;
  dGrdSimulazione.DataSource:=A023FTimbratureDtM1.A023FTimbratureMW.dscT100RiprSim;
end;

procedure TA023FRipristinoTimbOrig.FormDestroy(Sender: TObject);
begin
  // chiude i dataset
  with A023FTimbratureDtM1.A023FTimbratureMW do
  begin
    cdsT100RiprSim.Close;
    selT100Ripristino.CloseAll;
  end;
end;

procedure TA023FRipristinoTimbOrig.FormShow(Sender: TObject);
// PRE: Prog, DataInizio e DataFine impostati e validi
begin
  A023FTimbratureDtM1.A023FTimbratureMW.AggiornaTabella(DataInizio, DataFine, EsistonoOperazioniSelezionate, chkRipristinaOrig.Checked, chkCancManuali.Checked, chkCancIterWeb.Checked);
end;

procedure TA023FRipristinoTimbOrig.sedtDalChange(Sender: TObject);
begin
  if sedtDal.Text <> '' then
  begin
    // imposta data inizio
    DataInizio:=R180InizioMese(DataInizio) + (sedtDal.Value - 1);

    // mantiene coerente il periodo
    if sedtDal.Value > sedtAl.Value then
    begin
      sedtAl.OnChange:=nil;
      sedtAl.Value:=sedtDal.Value;
      DataFine:=DataInizio;
      sedtAl.OnChange:=sedtAlChange;
    end;

    // aggiorna visualizzazione
    A023FTimbratureDtM1.A023FTimbratureMW.AggiornaTabella(DataInizio, DataFine, EsistonoOperazioniSelezionate, chkRipristinaOrig.Checked, chkCancManuali.Checked, chkCancIterWeb.Checked);
  end;
end;

procedure TA023FRipristinoTimbOrig.sedtAlChange(Sender: TObject);
begin
  if sedtAl.Text <> '' then
  begin
    // controllo aggiunto a causa della mancanza di controllo da parte del componente VCL
    // sulla digitazione manuale del campo
    if StrToIntDef(sedtAl.Text,0) > sedtAl.MaxValue then
    begin
      sedtAl.OnChange:=nil;
      sedtAl.Value:=sedtAl.MaxValue;
      sedtAl.OnChange:=sedtAlChange;
    end;

    // imposta data fine
    DataFine:=R180InizioMese(DataInizio) + (sedtAl.Value - 1);

    // mantiene coerente il periodo
    if sedtAl.Value < sedtDal.Value then
    begin
      sedtDal.OnChange:=nil;
      sedtDal.Value:=sedtAl.Value;
      DataInizio:=DataFine;
      sedtDal.OnChange:=sedtDalChange;
    end;

    // aggiorna visualizzazione
    A023FTimbratureDtM1.A023FTimbratureMW.AggiornaTabella(DataInizio, DataFine, EsistonoOperazioniSelezionate, chkRipristinaOrig.Checked, chkCancManuali.Checked, chkCancIterWeb.Checked);
  end;
end;

procedure TA023FRipristinoTimbOrig.chkRipristinaOrigClick(Sender: TObject);
begin
  A023FTimbratureDtM1.A023FTimbratureMW.SimulaRipristino(chkRipristinaOrig.Checked,chkCancManuali.checked,chkCancIterWeb.Checked);
end;

procedure TA023FRipristinoTimbOrig.btnConfermaClick(Sender: TObject);
// conferma le operazioni di ripristino selezionate
begin
  if EsistonoOperazioniSelezionate then
    A023FTimbratureDtM1.A023FTimbratureMW.EseguiRipristino(DataInizio,DataFine,chkRipristinaOrig.Checked,chkCancManuali.checked,chkCancIterWeb.Checked);
end;

function TA023FRipristinoTimbOrig.EsistonoOperazioniSelezionate: Boolean;
// determina se sono selezionate operazioni di simulazione
// restituisce
// - True:  se almeno un'operazione è selezionata
// - False: se nessuna operazione è selezionata
begin
  Result:=(chkRipristinaOrig.Checked) or (chkCancManuali.Checked) or (chkCancIterWeb.Checked);
end;


end.
