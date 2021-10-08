unit A148UProfiliImportazioneCertificatiINPS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, Actions, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  A148UProfiliImportazioneCertificatiINPSDtm, Grids, DBGrids, A000USessione,
  A000UMessaggi, C600USelAnagrafe, A000UInterfaccia;

type
  TA148FProfiliImportazioneCertificatiINPS = class(TR001FGestTab)
    dGridProfili: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure dGridProfiliEditButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    procedure AllineaDataSetDBGrid;
  public
    { Public declarations }
  end;

var
  A148FProfiliImportazioneCertificatiINPS: TA148FProfiliImportazioneCertificatiINPS;

  procedure OpenA148ProfiliImportazioneCertificatiINPS;

implementation

{$R *.dfm}

procedure OpenA148ProfiliImportazioneCertificatiINPS;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA148ProfiliImportazioneCertificatiINPS') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  try
    Application.CreateForm(TA148FProfiliImportazioneCertificatiINPS, A148FProfiliImportazioneCertificatiINPS);
    Application.CreateForm(TA148FProfiliImportazioneCertificatiINPSDtm, A148FProfiliImportazioneCertificatiINPSDtm);
    A148FProfiliImportazioneCertificatiINPS.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    Screen.Cursor:=crDefault;
    FreeAndNil(A148FProfiliImportazioneCertificatiINPS);
    FreeAndNil(A148FProfiliImportazioneCertificatiINPSDtm);
  end;
end;

procedure TA148FProfiliImportazioneCertificatiINPS.AllineaDataSetDBGrid;
var
  i:integer;
begin
  for i:=0 to dGridProfili.Columns.Count - 1 do
    dGridProfili.Columns[i].Visible:=A148FProfiliImportazioneCertificatiINPSDtm.selT269.FieldByName(dGridProfili.Columns[i].FieldName).Visible;
end;

procedure TA148FProfiliImportazioneCertificatiINPS.dGridProfiliEditButtonClick(Sender: TObject);
var
  S:String;
begin
  inherited;
  if Not (A148FProfiliImportazioneCertificatiINPSDtm.selT269.state in [dsInsert,dsEdit]) then
    Exit;
  C600frmSelAnagrafe.C600DataLavoro:=Parametri.DataLavoro;
  C600frmSelAnagrafe.C600DatiVisualizzati:='';
  C600frmSelAnagrafe.btnSelezioneClick(Sender);
  if C600frmSelAnagrafe.C600ModalResult = mrOK then
  begin
    S:=C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text.Trim;
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    A148FProfiliImportazioneCertificatiINPSDtm.selT269.FieldByName('FILTRO').AsString:=S;
  end;
end;

procedure TA148FProfiliImportazioneCertificatiINPS.FormDestroy(Sender: TObject);
begin
  inherited;
  C600frmSelAnagrafe.C600Distruzione;
end;

procedure TA148FProfiliImportazioneCertificatiINPS.FormShow(Sender: TObject);
begin
  inherited;
  AllineaDataSetDBGrid;
  C600frmSelAnagrafe:=TC600frmSelAnagrafe.Create(Self);
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  C600frmSelAnagrafe.C600DataLavoro:=Parametri.DataLavoro;
  C600frmSelAnagrafe.C600Progressivo:=0;
end;

end.
