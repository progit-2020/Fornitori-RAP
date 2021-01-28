unit A024UIndPresenza;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, Menus, Buttons, ExtCtrls, ComCtrls, DBCtrls, StdCtrls,
  Mask, Grids, DBGrids, ActnList, ImgList, ToolWin, A000UCostanti, A000USessione,A000UInterfaccia, Variants;

type
  TA024FIndPresenza = class(TR001FGestTab)
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DBGrid1: TDBGrid;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    Regoleindennit1: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure TCancClick(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A024FIndPresenza: TA024FIndPresenza;

procedure OpenA024IndPresenza(Cod:String);

implementation

uses A024UIndPresenzaDtM1, A024URegoleIndennita;

{$R *.DFM}

procedure OpenA024IndPresenza(Cod:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA024IndPresenza') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A024FIndPresenza:=TA024FIndPresenza.Create(nil);
  with A024FIndPresenza do
    try
      A024FIndPresenzaDtM1:=TA024FIndPresenzaDtM1.Create(nil);
      DButton.DataSet:=A024FIndPresenzaDtM1.Q163;
      DButton.DataSet.Locate('Codice',Cod,[]);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A024FIndPresenzaDtM1.Free;
      Release;
    end;
end;

procedure TA024FIndPresenza.FormCreate(Sender: TObject);
begin
  inherited;
  DBGrid1.ReadOnly:=SolaLettura;
end;

procedure TA024FIndPresenza.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A024FIndPresenzaDtM1.Q163;
  inherited;
end;

procedure TA024FIndPresenza.TCancClick(Sender: TObject);
begin
  inherited;
  NumRecords;
end;

procedure TA024FIndPresenza.Stampa1Click(Sender: TObject);
begin
  QueryStampa.Clear;  //Lorena 12/07/2005
  QueryStampa.Add('SELECT');
  QueryStampa.Add('  T163.CODICE, T163.DESCRIZIONE, T162.CODICE, T162.DESCRIZIONE ');
  QueryStampa.Add('FROM T163_CODICIINDENNITA T163, T160_PROFILIINDENNITA T160, T162_INDENNITA T162');
  QueryStampa.Add('WHERE T163.CODICE = T160.CODICE (+) AND T160.INDENNITA = T162.CODICE (+)');
  NomiCampiR001.Clear;
  NomiCampiR001.Add('T163.CODICE');
  NomiCampiR001.Add('T163.DESCRIZIONE');
  NomiCampiR001.Add('T162.CODICE');
  NomiCampiR001.Add('T162.DESCRIZIONE');
  inherited;
end;

procedure TA024FIndPresenza.Nuovoelemento1Click(Sender: TObject);
begin
  A024FRegoleIndennita:=TA024FRegoleIndennita.Create(nil);
  with A024FIndPresenzaDtM1 do
    Q162.Locate('CODICE',Q160.FieldByName('INDENNITA').AsString,[]);
  with A024FRegoleIndennita do
    try
      ShowModal;
    finally
      Free;
    end;
end;

end.
