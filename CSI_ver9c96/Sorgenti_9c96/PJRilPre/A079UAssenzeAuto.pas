unit A079UAssenzeAuto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, C001StampaLib, C180FunzioniGenerali,
  A000UCostanti, A000USessione, A000UInterfaccia,
  ExtCtrls,DB,checklst, ComCtrls, C700USelezioneAnagrafe,
  Mask, SelAnagrafe, Menus, A003UDataLavoroBis, C005UDatiAnagrafici, Variants,
  A079UAssenzeAutoMW, A000UMessaggi;

type
  TA079FAssenzeAuto = class(TForm)
    BtnEsegui: TBitBtn;
    BtnClose: TBitBtn;
    ProgressBar1: TProgressBar;
    StatusBar: TStatusBar;
    EDal: TMaskEdit;
    Label1: TLabel;
    EAl: TMaskEdit;
    Label2: TLabel;
    frmSelAnagrafe: TfrmSelAnagrafe;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnEseguiClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
  private
    { Private declarations }
    A079MW:TA079FAssenzeAutoMW;
    procedure ScorriQueryAnagrafica;
  public
    { Public declarations }
  end;

var
  A079FAssenzeAuto: TA079FAssenzeAuto;

procedure OpenA079AssenzeAuto(Prog:LongInt);

implementation

{$R *.DFM}

procedure OpenA079AssenzeAuto(Prog:LongInt);
{Gestione inserimento automatico assenze}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA079AssenzeAuto') of
    'N','R':begin
              ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
              Exit;
            end;
  end;
  A079FAssenzeAuto:=TA079FAssenzeAuto.Create(nil);
  with A079FAssenzeAuto do
    try
      C700Progressivo:=Prog;
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Free;
    end;
end;

procedure TA079FAssenzeAuto.FormCreate(Sender: TObject);
begin
  A079MW:=TA079FAssenzeAutoMW.Create(Self);
  inherited;
end;

procedure TA079FAssenzeAuto.FormShow(Sender: TObject);
begin
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A079MW,SessioneOracle,StatusBar,0,False);
end;

procedure TA079FAssenzeAuto.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA079FAssenzeAuto.BtnEseguiClick(Sender: TObject);
begin
  A079MW.ControllaDate(EDal.Text,EAl.Text);
  ScorriQueryAnagrafica;
end;

procedure TA079FAssenzeAuto.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  try
    C005DataVisualizzazione:=StrToDate(EAl.Text);
  except
    C005DataVisualizzazione:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA079FAssenzeAuto.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  try
    C700DataLavoro:=StrToDate(EAl.Text);
  except
    C700DataLavoro:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA079FAssenzeAuto.ScorriQueryAnagrafica;
begin
  R180SetVariable(C700SelAnagrafe,'DATALAVORO',A079MW.AData);
  C700SelAnagrafe.Open;
  frmSelAnagrafe.NumRecords;
  C700SelAnagrafe.First;
  ProgressBar1.Position:=0;
  ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
  frmSelAnagrafe.ElaborazioneInterrompibile:=True;
  Self.Enabled:=False;
  try
    while not C700SelAnagrafe.EOF do
    begin
      try
        A079MW.InserimentoAutomaticoAssenze;
        C700SelAnagrafe.Next;
      except
      end;
      ProgressBar1.StepBy(1);
    end;
  finally
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    Self.Enabled:=True;
    frmSelAnagrafe.VisualizzaDipendente;
    ProgressBar1.Position:=0;
  end;
  ShowMessage(A000MSG_MSG_ELABORAZIONE_TERMINATA);
end;

end.
