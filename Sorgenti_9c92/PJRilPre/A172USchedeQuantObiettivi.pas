unit A172USchedeQuantObiettivi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, SelAnagrafe, ActnList, ImgList, DB, Menus, ComCtrls,
  ToolWin, A000UInterfaccia, A000UCostanti, A000USessione, StdCtrls, Mask,
  DBCtrls, C700USelezioneAnagrafe, C180FunzioniGenerali, System.Actions;

type
  TA172FSchedeQuantObiettivi = class(TR001FGestTab)
    frmSelAnagrafe: TfrmSelAnagrafe;
    dedtPeso1: TDBEdit;
    lblPeso1: TLabel;
    lblObiettivo1: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    dedtPeso2: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    dedtPeso3: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    dedtPeso4: TDBEdit;
    Label7: TLabel;
    dedtAnno: TDBEdit;
    Label8: TLabel;
    edtTipoStampa: TEdit;
    dmemObiettivo1: TDBMemo;
    dmemObiettivo2: TDBMemo;
    dmemObiettivo3: TDBMemo;
    dmemObiettivo4: TDBMemo;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TRegisClick(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
  private
    { Private declarations }
    Anno:Integer;
    procedure CambiaProgressivo;
  public
    { Public declarations }
  end;

var
  A172FSchedeQuantObiettivi: TA172FSchedeQuantObiettivi;

  procedure OpenA172SchedeQuantObiettivi(AnnoRif,Prog:Integer);

implementation

uses A172USchedeQuantIndividualiDtM;

{$R *.dfm}

procedure OpenA172SchedeQuantObiettivi(AnnoRif,Prog:Integer);
begin
(*  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA172SchedeQuantIndividuali') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;*)
  C700Progressivo:=Prog;
  Application.CreateForm(TA172FSchedeQuantObiettivi, A172FSchedeQuantObiettivi);
  try
    A172FSchedeQuantObiettivi.Anno:=AnnoRif;
    A172FSchedeQuantObiettivi.ShowModal;
  finally
//    SolaLettura:=SolaLetturaOriginale;
    A172FSchedeQuantObiettivi.Free;
  end;
end;

procedure TA172FSchedeQuantObiettivi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA172FSchedeQuantObiettivi.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.selSG715;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase + ',T430' + Parametri.CampiRiferimento.C7_Dato1 + ',T430' + Parametri.CampiRiferimento.C7_Dato2 +
                                       ',T430' + Parametri.CampiRiferimento.C7_Dato3;
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,2,True);
end;

procedure TA172FSchedeQuantObiettivi.TAnnullaClick(Sender: TObject);
begin
  inherited;
  actInserisci.Enabled:=A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.selSG715.RecordCount <= 0;
end;

procedure TA172FSchedeQuantObiettivi.TRegisClick(Sender: TObject);
begin
  inherited;
  actInserisci.Enabled:=A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.selSG715.RecordCount <= 0;
end;

procedure TA172FSchedeQuantObiettivi.CambiaProgressivo;
var Dato1,Dato2,Dato3,TipoStampaQuant: String;
begin
  A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.ImpostaSelSG715(Anno,C700Progressivo);
  Dato1:=C700SelAnagrafe.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato1).AsString;
  Dato2:=C700SelAnagrafe.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato2).AsString;
  Dato3:=C700SelAnagrafe.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato3).AsString;
  TipoStampaQuant:=A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.getTipoStampaQuant(Dato1,Dato2,Dato3);
  edtTipoStampa.Text:='';
  if TipoStampaQuant = '1' then
    edtTipoStampa.Text:='1 - Scheda posizionati sanitari'
  else if TipoStampaQuant = '2' then
    edtTipoStampa.Text:='2 - Scheda posizionati amm./tecnici';
  actInserisci.Enabled:=(edtTipoStampa.Text <> '') and (A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.selSG715.RecordCount <= 0);
  actModifica.Enabled:=edtTipoStampa.Text <> '';
  actCancella.Enabled:=edtTipoStampa.Text <> '';

  NumRecords;
end;

end.
