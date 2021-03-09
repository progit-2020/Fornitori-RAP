unit A127UTurniPrestazioniAggiuntive;

interface

uses
  StdCtrls, DBCtrls, Mask, Controls, ExtCtrls, Classes, ActnList, ImgList,
  Dialogs, DB, Menus, ComCtrls, ToolWin, SysUtils, R001UGESTTAB,
  A000UMessaggi, A000USessione, System.Actions;

type
  TA127FTurniPrestazioniAggiuntive = class(TR001FGestTab)
    Panel2: TPanel;
    dedtCodice: TDBEdit;
    lblCodice: TLabel;
    dedtDescrizione: TDBEdit;
    dedtOraInizio: TDBEdit;
    dedtOraFine: TDBEdit;
    lblDescrizione: TLabel;
    lblOraInizio: TLabel;
    lblOraFine: TLabel;
    dChkControlloPartTime: TDBCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure DBEditChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A127FTurniPrestazioniAggiuntive: TA127FTurniPrestazioniAggiuntive;

procedure OpenA127TurniPrestazioniAggiuntive(Cod:String);

implementation

uses A127UTurniPrestazioniAggiuntiveDtm;

{$R *.DFM}

procedure OpenA127TurniPrestazioniAggiuntive(Cod:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA127TurniPrestazioniAggiuntive') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A127FTurniPrestazioniAggiuntive:=TA127FTurniPrestazioniAggiuntive.Create(nil);
  with A127FTurniPrestazioniAggiuntive do
    try
      A127FTurniPrestazioniAggiuntiveDtm:=TA127FTurniPrestazioniAggiuntiveDtm.Create(nil);
      A127FTurniPrestazioniAggiuntiveDtm.selT330.Locate('Codice',Cod,[]);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A127FTurniPrestazioniAggiuntiveDtm.Free;
      Free;
    end;
end;

procedure TA127FTurniPrestazioniAggiuntive.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A127FTurniPrestazioniAggiuntiveDtm.selT330;
  inherited;
end;

procedure TA127FTurniPrestazioniAggiuntive.DBEditChange(Sender: TObject);
begin
  if (DButton.State in [dsEdit,dsInsert]) and (Trim(TDBEdit(Sender).Text) = '.') then
    TDBEdit(Sender).Field.Clear;
end;

end.
