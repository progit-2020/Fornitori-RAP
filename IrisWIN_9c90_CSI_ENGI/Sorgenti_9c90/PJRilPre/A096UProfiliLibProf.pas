unit A096UProfiliLibProf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, Db, Menus, Buttons, ExtCtrls, ComCtrls, Grids, DBGrids,
  StdCtrls, Mask, DBCtrls, RegistrazioneLog, ActnList, ImgList, C015UElencoValori,
  ToolWin, A000UCostanti, A000UMessaggi, A000USessione,A000UInterfaccia, Variants, ToolbarFiglio;

type
  TA096FProfiliLibProf = class(TR001FGestTab)
    pnlTestata: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DBGrid1: TDBGrid;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    frmToolbarFiglio: TfrmToolbarFiglio;
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure DBGrid1EditButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure AbilitaAzioni;
  public
    { Public declarations }
  end;

var
  A096FProfiliLibProf: TA096FProfiliLibProf;

procedure OpenA096ProfiliLibProf(Cod:String);

implementation

uses A096UProfiliLibProfDtM1;

{$R *.DFM}

procedure OpenA096ProfiliLibProf(Cod:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA096ProfiliLibProf') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A096FProfiliLibProf:=TA096FProfiliLibProf.Create(nil);
  A096FProfiliLibProfDtM1:=TA096FProfiliLibProfDtM1.Create(nil);
  A096FProfiliLibProfDtM1.Q310.Locate('Codice',Cod,[]);
  with A096FProfiliLibProf do
    try
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Free;
      A096FProfiliLibProfDtM1.Free;
    end;
end;

procedure TA096FProfiliLibProf.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A096FProfiliLibProfDtM1.Q310;
  inherited;
end;

procedure TA096FProfiliLibProf.FormShow(Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.TFDButton:=A096FProfiliLibProfDtM1.D311;
  frmToolbarFiglio.TFDBGrid:=DBGrid1;
  //Per gestire i pulsanti quando CachedUpdate:=False; (si considera lo state della singola riga invece che tutta l'operazione di inserimento/modifica)
  A096FProfiliLibProfDtM1.D311.OnStateChange:=frmToolbarFiglio.DButtonStateChange;
  SetLength(frmToolbarFiglio.lstLock,4);
  frmToolbarFiglio.lstLock[0]:=Panel1;
  frmToolbarFiglio.lstLock[1]:=File1;
  frmToolbarFiglio.lstLock[2]:=Strumenti1;
  frmToolbarFiglio.lstLock[3]:=pnlTestata;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
end;

procedure TA096FProfiliLibProf.DBGrid1EditButtonClick(Sender: TObject);
var  vCodice:Variant;
begin
  if (A096FProfiliLibProfDtM1.Q311.ReadOnly) or (A096FProfiliLibProfDtM1.Q311.State in [dsBrowse]) then
    exit;
  vCodice:=VarArrayOf([A096FProfiliLibProfDtM1.Q311.FieldByName('CAUSALE').asString]);
  OpenC015FElencoValori('','<A096> Selezione della causale',A096FProfiliLibProfDtM1.A096MW.Q275.Sql.Text,'CODICE',vCodice,A096FProfiliLibProfDtM1.A096MW.Q275,350);
  if not VarIsClear(vCodice) then
    A096FProfiliLibProfDtM1.Q311.FieldByName('CAUSALE').asString:=VarToStr(vCodice[0]);
end;

procedure TA096FProfiliLibProf.DButtonStateChange(Sender: TObject);
begin
  inherited;
  AbilitaAzioni;
end;

procedure TA096FProfiliLibProf.AbilitaAzioni;
begin
  if DButton.State in [dsInsert,dsEdit] then
  begin
    frmToolBarFiglio.actTFInserisci.Enabled:=False;
    frmToolBarFiglio.actTFModifica.Enabled:=False;
    frmToolBarFiglio.actTFCancella.Enabled:=False;
  end
  else
  begin
    frmToolBarFiglio.actTFInserisci.Enabled:=True;
    frmToolBarFiglio.actTFModifica.Enabled:=True;
    frmToolBarFiglio.actTFCancella.Enabled:=True;
  end;
end;

end.
