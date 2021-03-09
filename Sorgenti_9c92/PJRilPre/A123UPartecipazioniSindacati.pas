unit A123UPartecipazioniSindacati;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, StdCtrls, DBCtrls, ExtCtrls, Mask, DB, Menus, Buttons,
  ComCtrls, A000UCostanti, A000USessione, A000UMessaggi, A000UInterfaccia, C001UFiltroTabelleDtM, C700USelezioneAnagrafe,
  C001UFiltroTabelle, C001UScegliCampi, A002UInterfacciaSt, C005UDatiAnagrafici,
  ActnList, ImgList, ToolWin, SelAnagrafe, Variants, Grids, DBGrids, A121UOrganizzSindacali,
  System.Actions;

type
  TA123FPartecipazioniSindacati = class(TR001FGestTab)
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    frmSelAnagrafe: TfrmSelAnagrafe;
    grdIscrizioni: TDBGrid;
    Visualizzazione1: TMenuItem;
    procedure DButtonStateChange(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure Visualizzazione1Click(Sender: TObject);
  private
    procedure CambiaProgressivo;
  public
    { Public declarations }
  end;

var
  A123FPartecipazioniSindacati: TA123FPartecipazioniSindacati;

procedure OpenA123PartecipazioniSindacati(Prog:LongInt);

implementation

uses A123UPartecipazioniSindacatiDtM, A123UVisualizzazione;

{$R *.DFM}
                     
procedure OpenA123PartecipazioniSindacati(Prog:LongInt);
{Iscrizione Sindacati}
begin
  if Prog <= 0 then
  begin
    ShowMessage(A000MSG_ERR_NO_DIP);
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA123PartecipazioniSindacati') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A123FPartecipazioniSindacati:=TA123FPartecipazioniSindacati.Create(nil);
  with A123FPartecipazioniSindacati do
    try
      C700Progressivo:=Prog;
      A123FPartecipazioniSindacatiDtM:=TA123FPartecipazioniSindacatiDtM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A123FPartecipazioniSindacatiDtM.Free;
      Free;
    end;
end;

procedure TA123FPartecipazioniSindacati.CambiaProgressivo;
begin
  with A123FPartecipazioniSindacatiDtM do
  begin
    selT247.Close;
    selT247.SetVariable('Progressivo',C700Progressivo);
    selT247.Open;
    NumRecords;
  end;
end;

procedure TA123FPartecipazioniSindacati.DButtonStateChange(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.Enabled:=DButton.State = dsBrowse;
  if DButton.State = dsEdit then
    A123FPartecipazioniSindacatiDtM.A123MW.CaricaSindacati;
end;

procedure TA123FPartecipazioniSindacati.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=Date;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA123FPartecipazioniSindacati.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA123FPartecipazioniSindacati.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A123FPartecipazioniSindacatiDtM.selT247;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME,CONTRATTO';
  C700DatiSelezionati:=C700CampiBase + ',''(Contr.''||T430CONTRATTO||'')'' CONTRATTO';
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A123FPartecipazioniSindacatiDtM.A123MW,SessioneOracle, StatusBar,2,True);
end;

procedure TA123FPartecipazioniSindacati.Nuovoelemento1Click(Sender: TObject);
begin
  inherited;
  OpenA121OrganizzSindacali(A123FPartecipazioniSindacatiDtM.selT247.FieldByName('COD_SINDACATO').AsString);
end;

procedure TA123FPartecipazioniSindacati.Visualizzazione1Click(Sender: TObject);
begin
  inherited;
  OpenA123Visualizzazione;
end;

end.
