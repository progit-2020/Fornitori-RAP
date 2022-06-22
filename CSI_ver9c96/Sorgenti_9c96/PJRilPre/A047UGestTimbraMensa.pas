unit A047UGestTimbraMensa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, StdCtrls, Mask, ExtCtrls, Buttons, A047UTimbMensa, Menus, R500Lin,
  Spin,Grids,C180FunzioniGenerali, A050UOrologi, A021UCausGiustif, Variants,
  A047UTimbMensaMW,A000UGestioneTimbraGiustMW;

type
  TA047FGestTimbraMensa = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    ECausale: TDBLookupComboBox;
    Label2: TLabel;
    LCausale: TDBText;
    EOra: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    Label3: TLabel;
    DBLookUpRilevatore: TDBLookupComboBox;
    Label4: TLabel;
    EData: TSpinEdit;
    LData: TLabel;
    PopupMenu1: TPopupMenu;
    Eliminacausale1: TMenuItem;
    Nuovoelemento1: TMenuItem;
    procedure DBLookUpRilevatoreKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure Eliminacausale1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    DD,MM,YY : Word;
  public
    { Public declarations }
    Day,Col,MyTag:Byte;
    DataT : TDateTime;
  end;

var
  A047FGestTimbraMensa: TA047FGestTimbraMensa;

implementation

uses A047UTimbMensaDtM1;

{$R *.DFM}

procedure TA047FGestTimbraMensa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with A047FTimbMensaDtM1.A047FTimbMensaMW do
    //Chiamata: 83085
    QOrologi.Filtered:=False;
end;

procedure TA047FGestTimbraMensa.FormCreate(Sender: TObject);
begin
  with A047FTimbMensaDtM1.A047FTimbMensaMW do
  begin
    ECausale.ListSource:=D305;
    ECausale.DataSource:=D370;
    EOra.DataSource:=D370;
    DBRadioGroup1.DataSource:=D370;
    //Chiamata: 83085
    QOrologi.Filtered:=True;
    DBLookUpRilevatore.ListSource:=DOrologi;
    DBLookUpRilevatore.DataSource:=D370;
  end;
end;

procedure TA047FGestTimbraMensa.FormShow(Sender: TObject);
begin
  DecodeDate(DataT,YY,MM,DD);
  EData.MaxValue := R180GiorniMese(DataT);
  EData.Value := DD;
end;

procedure TA047FGestTimbraMensa.Nuovoelemento1Click(Sender: TObject);
{Richiamo form per inserimento causali}
begin
   if PopupMenu1.PopupComponent = DbLookupRilevatore then
   begin
     OPenA050Orologi(DbLookupRilevatore.Text);
     A047FTimbMensaDtM1.A047FTimbMensaMW.QOrologi.Close;
     A047FTimbMensaDtM1.A047FTimbMensaMW.QOrologi.Open;
   end
   else
   begin
     OpenA021CausGiustif(ECausale.Text);
     A047FTimbMensaDtM1.A047FTimbMensaMW.Q305.Refresh;
   end;
end;

procedure TA047FGestTimbraMensa.Eliminacausale1Click(Sender: TObject);
{Cancellazione causale}
begin
  (PopupMenu1.PopupComponent as TDBLookupComboBox).Field.Clear;
end;

procedure TA047FGestTimbraMensa.BitBtn1Click(Sender: TObject);
{Registrazione timbratura e eventuale gestione dei secondi se HH.mm sono uguali}
var
  I : Integer;
begin
  BitBtn1.SetFocus;
  if A047FTimbMensaDtM1.A047FTimbMensaMW.Q370.FieldByName('Ora').IsNull then exit;
  A047FTimbMensaDtM1.A047FTimbMensaMW.A000FGestioneTimbraGiustMW.EU:=#0;
  with A047FTimbMensaDtM1.A047FTimbMensaMW do
    if (A000FGestioneTimbraGiustMW.StatoTimb = stModifica) and
       (not A000FGestioneTimbraGiustMW.TimbraturaModificata(Day, Col)) then
    begin
      {Capita solo per le modifiche}
      Q370.Cancel;
      ModalResult:=mrCancel;
    end
    else
      if A000FGestioneTimbraGiustMW.StatoTimb = stInserimento then
        begin
        {Se inserimento aggiorno FTimbrature e mi posiziono
        su nuova timbratura}
        Day:=EData.Value;
        A000FGestioneTimbraGiustMW.EseguiInserisciTimbratura(EncodeDate(YY,MM,EData.Value));
        with A047FTimbMensa do
          for I:=0 to 5 do
          begin
            if Day=(Giorno+I) then
            begin
              FGriglie[I+1].Timbrat.ColCount:=A000FGestioneTimbraGiustMW.FNumTimbrature[Day]+1;
              TStringGrid(FGriglie[I+1].Timbrat).Repaint;
              Break;
            end;
          end;
        if A000FGestioneTimbraGiustMW.FNumTimbrature[Day] = MaxTimbrature then
          ModalResult:=mrOK
        else
          begin
          A047FTimbMensaDtM1.A047FTimbMensaMW.A000FGestioneTimbraGiustMW.EU:=Q370.FieldByName('Verso').AsString[1];
          Q370.Append;
          EOra.SetFocus;
          end;
        end
    else
      begin
      //A047FTimbMensaDtM1.Q370.Post;
      if not VarIsNull(A000FGestioneTimbraGiustMW.FTimbrature[Day,Col].Ora) then
        ModalResult:=mrOk;
      end;
end;

//------------------------------------------------------------------------------
procedure TA047FGestTimbraMensa.BitBtn2Click(Sender: TObject);
{Uscita dalla finestra}
begin
  A047FTimbMensaDtM1.A047FTimbMensaMW.A000FGestioneTimbraGiustMW.EU:=#0;
  A047FTimbMensaDtM1.A047FTimbMensaMW.Q370.Cancel;
  ModalResult:=mrCancel;
end;

procedure TA047FGestTimbraMensa.PopupMenu1Popup(Sender: TObject);
begin
  Eliminacausale1.Visible:=PopupMenu1.PopupComponent = ECausale;
end;

procedure TA047FGestTimbraMensa.DBLookUpRilevatoreKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      //if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then 
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

end.
