unit A002UAnagrafeGest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  A002UAnagrafeGestPadre, ActnList, ImgList, Menus, ComCtrls, ToolWin,
  DBCtrls, StdCtrls, ExtCtrls, Db, Mask,
  A007UProfiliOrari,A009UProfiliAsse,
  A012UCalendari,A014UPlusOrario,A016UCausAssenze,A018URaggrPres,
  A022UContratti,A024UIndPresenza,A053USquadre,
  A080UModConte,A084UTipoRapporto,A085UPartTime,A143UMedicineLegali,
  Variants, Buttons, System.Actions;

type
  TA002FAnagrafeGest = class(TA002FAnagrafeGestPadre)
    procedure NuovoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A002FAnagrafeGest: TA002FAnagrafeGest;

implementation

uses A002UAnagrafeVista, A002UAnagrafeDtM1;

{$R *.DFM}

procedure TA002FAnagrafeGest.NuovoClick(Sender: TObject);
begin
  case PopupMenu1.PopupComponent.Tag of
    2:if A002FAnagrafeVista.Squadre1.Enabled then
        OpenA053Squadre((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    3:OpenA022Contratti((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    4:OpenA014PlusOrario((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    5:OpenA012Calendari((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    6:OpenA024IndPresenza((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    7:OpenA007ProfiliOrari((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    8:OpenA009ProfiliAsse((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    9:OpenA016CausAssenze((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    10:OpenA018RaggrPres((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    11:OpenA080ModConte((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    12:OpenA084TipoRapporto((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    13:OpenA085PartTime((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    15:OpenA143MedicineLegali((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
  end;
  inherited;
end;

end.
