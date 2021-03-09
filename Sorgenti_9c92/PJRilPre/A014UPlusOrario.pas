unit A014UPlusOrario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, DBCtrls,
  Mask, L001Call, ActnList, ImgList, ToolWin, A000UCostanti, A000USessione,A000UInterfaccia, Variants, System.Actions;

type
  TA014FPlusOrario = class(TR001FGestTab)
    Panel2: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBRadioGroup2: TDBRadioGroup;
    Panel3: TPanel;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    DBEdit8: TDBEdit;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    Label10: TLabel;
    DBEdit10: TDBEdit;
    Label11: TLabel;
    DBEdit11: TDBEdit;
    Label12: TLabel;
    DBEdit12: TDBEdit;
    Label13: TLabel;
    DBEdit13: TDBEdit;
    Label14: TLabel;
    DBEdit14: TDBEdit;
    Label15: TLabel;
    DBEdit15: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    Label16: TLabel;
    Label17: TLabel;
    DBCheckBox2: TDBCheckBox;
    Label18: TLabel;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    Label19: TLabel;
    DBCheckBox9: TDBCheckBox;
    DBCheckBox10: TDBCheckBox;
    DBCheckBox11: TDBCheckBox;
    DBCheckBox12: TDBCheckBox;
    DBCheckBox13: TDBCheckBox;
    DBLookupComboBox1: TDBLookupComboBox;
    DBText1: TDBText;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    procedure DBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Nuovoelemento1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A014FPlusOrario: TA014FPlusOrario;

procedure OpenA014PlusOrario(Cod:String);

implementation

uses A014UPlusOrarioDtM1;

{$R *.DFM}

procedure OpenA014PlusOrario(Cod:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA014PlusOrario') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A014FPlusOrario:=TA014FPlusOrario.Create(nil);
  with A014FPlusOrario do
  try
    A014FPlusOrarioDtM1:=TA014FPlusOrarioDtM1.Create(nil);
    A014FPlusOrarioDtM1.T061.Locate('Codice',Cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A014FPlusOrarioDtM1.Free;
    Release;
  end;
end;

procedure TA014FPlusOrario.Nuovoelemento1Click(Sender: TObject);
{Richiamo la Dll per aggiungere un nuovo Codice PlusOrario}
var Griglia:TInserisciDLL;
    i:Byte;
begin
  with A014FPlusOrarioDtM1.T060 do
    begin
    Griglia.NomeTabella:='T060_PLUSORARIO';
    Griglia.Titolo:='Categorie di Plus Orario';
    for i:=0 to FieldCount -1 do
      begin
      Griglia.Display[i]:=Fields[i].DisplayLabel;
      Griglia.Size[i]:=Fields[i].DisplayWidth;
      end;
    Inserisci(Griglia,DBLookupComboBox1.Text);
    A014FPlusOrarioDtM1.T060.Refresh;
    end;
end;

procedure TA014FPlusOrario.DBLookupComboBox1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

end.
