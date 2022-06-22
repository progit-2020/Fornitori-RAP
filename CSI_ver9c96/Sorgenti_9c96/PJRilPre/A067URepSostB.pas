unit A067URepSostB;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, DBCtrls, StdCtrls, Mask, Buttons, ExtCtrls, C700USelezioneAnagrafe,
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi, A067URepSostBMW,
  Rp502Pro, C180FunzioniGenerali, SelAnagrafe, Menus, StrUtils,
  C005UDatiAnagrafici, Variants;

type
  TA067FRepSostB = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    EDaData: TMaskEdit;
    EAData: TMaskEdit;
    Label1: TLabel;
    ECausale: TDBLookupComboBox;
    StatusBar: TStatusBar;
    PB1: TProgressBar;
    BInserisci: TBitBtn;
    BitBtn2: TBitBtn;
    BElimina: TBitBtn;
    frmSelAnagrafe: TfrmSelAnagrafe;
    procedure ECausaleKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure BInserisciClick(Sender: TObject);
    procedure EDaDataExit(Sender: TObject);
    procedure TfrmSelAnagrafe1R003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    A067MW: TA067FRepSostBMW;
    R502ProDtM1:TR502ProDtM1;
  public
    { Public declarations }
  end;

var
  A067FRepSostB: TA067FRepSostB;

procedure OpenA067RepSostB(Prog:LongInt);

implementation

{$R *.DFM}

procedure OpenA067RepSostB(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA067RepSostB') of
    'N','R':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
  end;
  A067FRepSostB:=TA067FRepSostB.Create(nil);
  with A067FRepSostB do
    try
      C700Progressivo:=Prog;
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Free;
    end;
end;

procedure TA067FRepSostB.FormCreate(Sender: TObject);
begin
  A067MW:=TA067FRepSostBMW.Create(Self);
  inherited;
end;

procedure TA067FRepSostB.FormShow(Sender: TObject);
begin
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,0,False);
end;

procedure TA067FRepSostB.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
  A067MW.Free;
end;

procedure TA067FRepSostB.TfrmSelAnagrafe1R003DatianagraficiClick(Sender: TObject);
begin
  try
    C005DataVisualizzazione:=StrToDate(EAData.Text);
  except
    C005DataVisualizzazione:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA067FRepSostB.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  try
    C700DataLavoro:=StrToDate(EAData.Text);
  except
    C700DataLavoro:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA067FRepSostB.EDaDataExit(Sender: TObject);
var D:TDateTime;
    A,M,G:Word;
begin
  try
    D:=StrToDate(EDaData.Text);
    DecodeDate(D,A,M,G);
    try
      if D > StrToDate(EAData.Text) then
        EAData.Text:=FormatDateTime('dd/mm/yyyy',EncodeDate(A,M,R180GiorniMese(D)));
    except
      EAData.Text:=FormatDateTime('dd/mm/yyyy',EncodeDate(A,M,R180GiorniMese(D)));
    end;
  except
  end;
end;

procedure TA067FRepSostB.ECausaleKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA067FRepSostB.BInserisciClick(Sender: TObject);
var Inizio,Fine,Corrente:TDateTime;
    i:Integer;
begin
  try
    Inizio:=StrToDate(EDaData.Text);
    Fine:=StrToDate(EAData.Text);
  except
    raise Exception.Create(A000MSG_ERR_DATE_RIFERIMENTO);
  end;
  if Inizio > Fine then
    raise Exception.Create(A000MSG_ERR_DATE_INVERTITE);
  if ECausale.Text = '' then
    raise Exception.Create(A000MSG_A067_ERR_NO_CAUSALE);
  R502ProDtM1:=TR502ProDtM1.Create(nil);
  R502ProDtM1.PeriodoConteggi(Inizio,Fine);
  R180SetVariable(C700SelAnagrafe,'DataLavoro',Fine);
  with C700SelAnagrafe do
  begin
    Open;
    frmSelAnagrafe.NumRecords;
    PB1.Max:=RecordCount * Trunc(Fine - Inizio + 1);
    PB1.Position:=0;
    First;
    while not Eof do
    begin
      frmSelAnagrafe.VisualizzaDipendente;
      A067MW.ApriQ040(ECausale.Text,C700Progressivo,Inizio,Fine);
      Corrente:=Inizio;
      while Corrente <= Fine do
      begin
        PB1.StepBy(1);
        R502ProDtM1.Conteggi('Anomalie',FieldByName('Progressivo').AsInteger,Corrente);
        if R502ProDtM1.Blocca = 0 then
          //Controllo le anomalie di terzo livello
          for i:=1 to R502ProDtM1.n_anom3 do
            if R502ProDtM1.tanom3riscontrate[i].ta3puntdesc = 4 then
              A067MW.CorreggiAnomalia(IfThen(Sender = BInserisci,'I','E'),ECausale.Text,FieldByName('Progressivo').AsInteger,Corrente,R502ProDtM1.tanom3riscontrate[i].ta3timb);
        Corrente:=Corrente + 1;
      end;
      Next;
    end;
  end;
  FreeAndNil(R502ProDtM1);
  ShowMessage(A000MSG_MSG_ELABORAZIONE_TERMINATA);
  PB1.Position:=0;
end;

end.
