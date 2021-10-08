unit A091UAnnullaLiquidazione;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, C700USelezioneAnagrafe, C180FunzioniGenerali,
  Oracle, RegistrazioneLog, A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi;

type
  TA091FAnnullaLiquidazione = class(TForm)
    btnEsegui: TBitBtn;
    lblMessaggio: TLabel;
    GroupBox1: TGroupBox;
    chkLiquidazioni: TCheckBox;
    chkCompensazioni: TCheckBox;
    BitBtn1: TBitBtn;
    ProgressBar: TProgressBar;
    procedure FormShow(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure chkLiquidazioniClick(Sender: TObject);
  private
    { Private declarations }
    Data:TDateTime;
    procedure GetDataAnnullamento;
  public
    { Public declarations }
    DataLavoro:TDateTime;
    Causale:String;
  end;

var
  A091FAnnullaLiquidazione: TA091FAnnullaLiquidazione;

implementation

uses A029UBudgetDtM1, A091ULiquidPresenzeDtM1, OracleData, A091ULiquidPresenze;

{$R *.dfm}

procedure TA091FAnnullaLiquidazione.chkLiquidazioniClick(Sender: TObject);
begin
  GetDataAnnullamento;
end;

procedure TA091FAnnullaLiquidazione.FormShow(Sender: TObject);
begin
  A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.SelAnagrafe:=C700SelAnagrafe;
  GetDataAnnullamento;
end;

procedure TA091FAnnullaLiquidazione.GetDataAnnullamento;
begin
  Data:=A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.DataLiquidazioni(DataLavoro,Causale,chkLiquidazioni.Checked,chkCompensazioni.Checked);

  if Data = 0 then
  begin
    lblMessaggio.Caption:=A000MSG_A091_DLG_NO_LIQUIDAZIONI;
    btnEsegui.Enabled:=False;
  end
  else
  begin
    lblMessaggio.Caption:=Format(A000MSG_A091_DLG_FMT_ANNULLA_LIQ,[UpperCase(FormatDateTime('mmmm yyyy',Data))]);
    btnEsegui.Enabled:=True;
  end;
end;

procedure TA091FAnnullaLiquidazione.btnEseguiClick(Sender: TObject);
begin
  with A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW do
  begin
    RegistraMsg.IniziaMessaggio('A091');
    ProgressBar.Position:=0;
    ProgressBar.Max:=C700SelAnagrafe.RecordCount;
    C700SelAnagrafe.First;
    Screen.Cursor:=crHourGlass;
    ImpostaVarAnnulla(Data,Causale,chkLiquidazioni.Checked, chkCompensazioni.Checked );
    try
      while not C700SelAnagrafe.Eof do
      begin
        ProgressBar.StepIt;
        AnnullaLiquidazione(Data,Causale);
        C700SelAnagrafe.Next;
      end;
      //Calcolo il fruito e aggiorno il budget straordinario
      if Parametri.CampiRiferimento.C2_Facoltativo <> '' then
      begin
        A029FLiquidazione.A029FBudgetDtM1.PreparaAggiornaFruitoBudget(Data,'#LIQ#');
        SessioneOracle.Commit;
      end;
    finally
      Screen.Cursor:=crDefault;
      ProgressBar.Position:=0;
    end;
    R180MessageBox('Operazione terminata',INFORMA);
  end;
end;

end.
