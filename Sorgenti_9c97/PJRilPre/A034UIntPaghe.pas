unit A034UIntPaghe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, checklst, Db, Menus, Buttons, ExtCtrls, ComCtrls, R001UGESTTAB,
  Mask, DBCtrls, ActnList, ImgList, ToolWin, Grids, DBGrids, ControlloVociPaghe,
  A000UCostanti, A000USessione,A000UInterfaccia, Variants, System.Actions;

type
  TA034FIntPaghe = class(TR001FGestTab)
    Panel2: TPanel;
    DBText1: TDBText;
    lblInterfaccia: TLabel;
    DBText2: TDBText;
    DBGrid1: TDBGrid;
    btnParAvanzati: TBitBtn;
    procedure btnParAvanzatiClick(Sender: TObject);
    procedure TCancClick(Sender: TObject);
    procedure TModifClick(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure Copiada1Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  A034FIntPaghe: TA034FIntPaghe;

procedure OpenA034IntPaghe;

implementation

uses A034UIntPagheDTM1, A034UParametriAvanzati;

{$R *.DFM}

procedure OpenA034IntPaghe;
{Definizione interfaccia paghe da contratto}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA034IntPaghe') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA034FIntPaghe, A034FIntPaghe);
  Application.CreateForm(TA034FIntPagheDtM1, A034FIntPagheDtM1);
  try
    A034FIntPaghe.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A034FIntPagheDtM1.Free;
    A034FIntPaghe.Free;
  end;
end;

procedure TA034FIntPaghe.TCancClick(Sender: TObject);
begin
  if MessageDlg('Eliminare l''interfaccia corrente?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then exit;

  with A034FIntPagheDtm1 do
  begin
    selT190.ReadOnly:=False;
    selT190.BeforeDelete:=nil;
    A034FIntPagheMW.EliminaInterfaccia;
    selT190.ReadOnly:=True;
    selT190.BeforeDelete:=A034FIntPagheDtm1.selT190BeforeDeleteInsert;
  end;

end;

procedure TA034FIntPaghe.TModifClick(Sender: TObject);
begin
  A034FIntPagheDtm1.selT190.ReadOnly:=False;
  actRicerca.Enabled:=False;
  actPrimo.Enabled:=False;
  actPrecedente.Enabled:=False;
  actSuccessivo.Enabled:=False;
  actUltimo.Enabled:=False;
  actModifica.Enabled:=False;
  actCancella.Enabled:=False;
  actConferma.Enabled:=True;
  actAnnulla.Enabled:=True;
  btnParAvanzati.Enabled:=False;
end;

procedure TA034FIntPaghe.TRegisClick(Sender: TObject);
begin
  if A034FIntPagheDtm1.selT190.State = dsEdit then
    A034FIntPagheDtm1.selT190.Post;
  SessioneOracle.Commit;
  A034FIntPagheDtm1.selT190.ReadOnly:=True;
  actRicerca.Enabled:=True;
  actPrimo.Enabled:=True;
  actPrecedente.Enabled:=True;
  actSuccessivo.Enabled:=True;
  actUltimo.Enabled:=True;
  actModifica.Enabled:=True;
  actCancella.Enabled:=True;
  actConferma.Enabled:=False;
  actAnnulla.Enabled:=False;
  btnParAvanzati.Enabled:=True;
end;

procedure TA034FIntPaghe.TAnnullaClick(Sender: TObject);
begin
  SessioneOracle.Rollback;
  A034FIntPagheDtm1.selT190.ReadOnly:=True;
  A034FIntPagheDtm1.selT190.Refresh;
  actRicerca.Enabled:=True;
  actPrimo.Enabled:=True;
  actPrecedente.Enabled:=True;
  actSuccessivo.Enabled:=True;
  actUltimo.Enabled:=True;
  actModifica.Enabled:=True;
  actCancella.Enabled:=True;
  actConferma.Enabled:=False;
  actAnnulla.Enabled:=False;
  btnParAvanzati.Enabled:=True;
end;

procedure TA034FIntPaghe.Stampa1Click(Sender: TObject);
begin
  DButton.DataSet.DisableControls;
  DButton.DataSet:=A034FIntPagheDtM1.selT190;
  inherited;
  DButton.DataSet:=A034FIntPagheDtM1.A034FIntPagheMW.selC9ScaricoPaghe;
  DButton.DataSet.EnableControls;
end;

procedure TA034FIntPaghe.Copiada1Click(Sender: TObject);
begin
  DButton.DataSet.DisableControls;
  DButton.DataSet:=A034FIntPagheDtM1.selT190;
  A034FIntPagheDtM1.selT190.BeforePost:=nil;
  inherited;
  A034FIntPagheDtM1.selT190.BeforePost:=A034FIntPagheDtM1.selT190BeforePost;
  DButton.DataSet:=A034FIntPagheDtM1.A034FIntPagheMW.selC9ScaricoPaghe;
  DButton.DataSet.EnableControls;
end;

procedure TA034FIntPaghe.btnParAvanzatiClick(Sender: TObject);
begin
  inherited;
  //FreeAndNil(A034FIntPagheDtM1.selControlloVociPaghe);
  OpenA034ParametriAvanzati(A034FIntPagheDtM1.selT190.FieldByName('CODICE').AsString);
  try
    A034FIntPagheDtM1.A034FIntPagheMW.selControlloVociPaghe:=TControlloVociPaghe.Create(Self,'');
  except
  end;
end;

end.
