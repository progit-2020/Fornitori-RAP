unit A023UAllTimbUguali;

interface

uses
  A000UCostanti, A000UMessaggi, A023UTimbratureDtM1, A023UAllTimbMW, A000UInterfaccia, C180FunzioniGenerali,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.Buttons, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.Menus, Data.DB;

type
  TA023FAllTimbUguali = class(TForm)
    grpTimbrature: TGroupBox;
    dgrdTimbUguali: TDBGrid;
    ActionList1: TActionList;
    actScambiaTimb: TAction;
    pmnAzioniTabella: TPopupMenu;
    mnuScambiaTimbrature: TMenuItem;
    pnlTop: TPanel;
    grpPeriodo: TGroupBox;
    lblMese: TLabel;
    lblDal: TLabel;
    lblAl: TLabel;
    sedtDal: TSpinEdit;
    sedtAl: TSpinEdit;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure sedtDalChange(Sender: TObject);
    procedure sedtAlChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actScambiaTimbExecute(Sender: TObject);
  private
    A023FAllTimbMW: TA023FAllTimbMW;
  public
    DatiAnag: TDatiAnag;
    DataInizio, DataFine: TDateTime;
    ScambiManualiEffettuati: Boolean;
    procedure AggiornaVistaTimbrature(const PDatiAnag: TDatiAnag; const PDataInizio,
      PDataFine: TDateTime);
  end;

var
  A023FAllTimbUguali: TA023FAllTimbUguali;

implementation

{$R *.dfm}

procedure TA023FAllTimbUguali.FormCreate(Sender: TObject);
begin
  A023FAllTimbMW:=TA023FAllTimbMW.Create(nil);
  A023FAllTimbMW.Q100.Session:=SessioneOracle;
  A023FAllTimbMW.Q100Upd.Session:=SessioneOracle;

  dgrdTimbUguali.DataSource:=A023FAllTimbMW.dsrT100;

  ScambiManualiEffettuati:=False;
end;

procedure TA023FAllTimbUguali.FormDestroy(Sender: TObject);
begin
  FreeAndNil(A023FAllTimbMW);
end;

procedure TA023FAllTimbUguali.sedtDalChange(Sender: TObject);
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
    AggiornaVistaTimbrature(DatiAnag,DataInizio,DataFine);
  end;
end;

procedure TA023FAllTimbUguali.sedtAlChange(Sender: TObject);
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
    AggiornaVistaTimbrature(DatiAnag,DataInizio,DataFine);
  end;
end;

procedure TA023FAllTimbUguali.AggiornaVistaTimbrature(const PDatiAnag: TDatiAnag;
  const PDataInizio, PDataFine: TDateTime);
begin
  DatiAnag:=PDatiAnag;
  DataInizio:=PDataInizio;
  DataFine:=PDataFine;

  // aggiorna dataset timbrature
  A023FAllTimbMW.LeggiTimbratureUguali(PDatiAnag,PDataInizio,PDataFine,True);
end;

procedure TA023FAllTimbUguali.actScambiaTimbExecute(Sender: TObject);
var
  T1, T2: TTimbratura;
  BM: TBookMark;
  OraNew: TDateTime;
begin
  // legge gli estremi della coppia di timbrature selezionate per scambiarle
  with A023FAllTimbMW.cdsT100 do
  begin
    if not Active then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_A023_ERR_COMANDO_ALLTIMB));

    if RecordCount = 0 then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_A023_ERR_NO_TIMB_DA_SCAMBIARE));


    T1:=A023FAllTimbMW.Timbratura(FieldByName('DATA').AsDateTime,
                                  FieldByName('ORA1').AsDateTime,
                                  FieldByName('VERSO1').AsString,
                                  FieldByName('FLAG1').AsString,
                                  FieldByName('CAUSALE1').AsString,
                                  FieldByName('ROWID1').AsString);
    T2:=A023FAllTimbMW.Timbratura(FieldByName('DATA').AsDateTime,
                                  FieldByName('ORA2').AsDateTime,
                                  FieldByName('VERSO2').AsString,
                                  FieldByName('FLAG2').AsString,
                                  FieldByName('CAUSALE2').AsString,
                                  FieldByName('ROWID2').AsString);
  end;

  // salva il bookmark
  BM:=A023FAllTimbMW.cdsT100.GetBookmark;
  try
    // effettua lo scambio delle timbrature
    OraNew:=A023FAllTimbMW.ScambiaTimbrature(T1,T2,False);

    // se lo scambio è avvenuto aggiorna la visualizzazione
    if OraNew <> DATE_NULL then
    begin
      ScambiManualiEffettuati:=True;
      AggiornaVistaTimbrature(DatiAnag,DataInizio,DataFine);
    end
    else
      R180MessageBox('Non è stato possibile effettuare lo scambio delle timbrature selezionate!',INFORMA);

    // ripristina il bookmark
    if A023FAllTimbMW.cdsT100.BookmarkValid(BM) then
      A023FAllTimbMW.cdsT100.GotoBookmark(BM);
  finally
    A023FAllTimbMW.cdsT100.FreeBookmark(BM);
  end;
end;

end.
