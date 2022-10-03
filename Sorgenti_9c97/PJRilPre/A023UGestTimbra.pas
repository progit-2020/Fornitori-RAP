unit A023UGestTimbra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBCtrls, OracleData, StdCtrls, Mask, ExtCtrls, Buttons, A023UTimbrature, Menus, R500Lin,
  Spin,Grids,C180FunzioniGenerali, A000UCostanti, A000USessione,A000UInterfaccia, A050UOrologi,
  A020UCausPresenze, A021UCausGiustif, Variants,
  A023UTimbratureDtM1,A023UTimbratureMW,A000UGestioneTimbraGiustMW;

type
  TA023FGestTimbra = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    ECausale: TDBLookupComboBox;
    Label2: TLabel;
    RadioGroup2: TRadioGroup;
    LCausale: TDBText;
    EOra: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    Label3: TLabel;
    LData: TLabel;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    EData: TSpinEdit;
    Label4: TLabel;
    DBLookupRilevatore: TDBLookupComboBox;
    lblDescOrologio: TLabel;
    procedure dcmbKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RadioGroup2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    DD,MM,YY : Word;
  public
    { Public declarations }
    Day,Col,MyTag:Byte;
    DataT : TDateTime;
  end;

var
  A023FGestTimbra: TA023FGestTimbra;

implementation


{$R *.DFM}

procedure TA023FGestTimbra.FormShow(Sender: TObject);
begin
  DecodeDate(DataT,YY,MM,DD);
  EData.MaxValue:=R180GiorniMese(DataT);
  EData.Value:=DD;
  with A023FTimbratureDtM1.A023FTimbratureMW do
  begin
    EOra.Enabled:=(A000FGestioneTimbraGiustMW.StatoTimb = stInserimento) or (Parametri.T100_Ora = 'S');
    DBLookupRilevatore.Enabled:=(A000FGestioneTimbraGiustMW.StatoTimb = stInserimento) or (Parametri.T100_Rilevatore = 'S');
    ECausale.Enabled:=(A000FGestioneTimbraGiustMW.StatoTimb = stInserimento) or (Parametri.T100_Causale = 'S');
    Q275.Filtered:=True;
    //Chiamata: 83085
    Q361.Filtered:=True;
    if Q361.SearchRecord('CODICE',Q100.FieldByName('Rilevatore').AsString,[srFromBeginning]) then
      lblDescOrologio.Caption:=Q361.FieldByName('DESCRIZIONE').AsString
    else
      lblDescOrologio.Caption:='';
  end;
end;

procedure TA023FGestTimbra.RadioGroup2Click(Sender: TObject);
{Cambio il collegamento alle causali}
begin
  with A023FTimbratureDtM1.A023FTimbratureMW do
    if RadioGroup2.ItemIndex = 0 then
      begin
      ECausale.ListSource:=D275;
      LCausale.DataSource:=D275;
      end
    else
      begin
      ECausale.ListSource:=D305;
      LCausale.DataSource:=D305;
      end;
end;

procedure TA023FGestTimbra.Nuovoelemento1Click(Sender: TObject);
{Richiamo form per inserimento causali}
begin
  if PopupMenu1.PopupComponent = DbLookupRilevatore then
    begin
    OpenA050Orologi(DbLookupRilevatore.Text);
    A023FTimbratureDtM1.A023FTimbratureMW.Q361.Close;
    A023FTimbratureDtM1.A023FTimbratureMW.Q361.Open;
    exit;
    end;
  case RadioGroup2.ItemIndex of
    0:begin
      OpenA020CausPresenze(ECausale.Text);
      A023FTimbratureDtM1.A023FTimbratureMW.Q275.Refresh;
      end;
    1:begin
      OpenA021CausGiustif(ECausale.Text);
      A023FTimbratureDtM1.A023FTimbratureMW.Q305.Refresh;
      end;
  end;
  //CARATTO 18/07/2013 A023FTimbrature.R502ProDtM1.Resetta;
  A023FTimbratureDtM1.A023FTimbratureMW.R502ProDtM1.Resetta;
  A023FTimbrature.SBConteggiClick(A023FTimbrature.SBConteggi);
end;

procedure TA023FGestTimbra.BitBtn1Click(Sender: TObject);
{Registrazione timbratura e eventuale gestione dei secondi se HH.mm sono uguali}
var I : Integer;
begin
  BitBtn1.SetFocus;
  if A023FTimbratureDtM1.A023FTimbratureMW.Q100.FieldByName('Ora').IsNull then exit;
  A023FTimbratureDtM1.A023FTimbratureMW.A000FGestioneTimbraGiustMW.EU:=#0;
  with A023FTimbratureDtM1.A023FTimbratureMW do
    //caratto 12/12/2013 - Utente: AOSTA_ASL Chiamata: 80051 - Il controllo se timbratura modificata lo deve fare solo in modifica
    if (A000FGestioneTimbraGiustMW.StatoTimb = stModifica) and
       (not A000FGestioneTimbraGiustMW.TimbraturaModificata(Day, Col)) then
    begin
      {Capita solo per le modifiche}
      Q100.Cancel;
      ModalResult:=mrCancel;
    end
    else
      if A000FGestioneTimbraGiustMW.StatoTimb = stInserimento then
      begin
        {Se inserimento aggiorno FTimbrature e mi posiziono
        su nuova timbratura}
        Day:=EData.Value;
        A000FGestioneTimbraGiustMW.EseguiInserisciTimbratura(EncodeDate(YY,MM,EData.Value));
        with A023FTimbrature do
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
          A000FGestioneTimbraGiustMW.EU:=Q100.FieldByName('Verso').AsString[1];
          Q100.Append;
          EOra.SetFocus;
        end;
      end
      else
      begin
        //A023FTimbratureDtM1.Q100.Post;
        if not VarIsNull(A000FGestioneTimbraGiustMW.FTimbrature[Day,Col].Ora) then
          ModalResult:=mrOk;
      end;
end;

procedure TA023FGestTimbra.BitBtn2Click(Sender: TObject);
{Uscita dalla finestra}
begin
  A023FTimbratureDtM1.A023FTimbratureMW.A000FGestioneTimbraGiustMW.EU:=#0;
  A023FTimbratureDtM1.A023FTimbratureMW.Q100.Cancel;
  ModalResult:=mrCancel;
end;

procedure TA023FGestTimbra.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  A023FTimbratureDtM1.A023FTimbratureMW.Q275.Filtered:=False;
  //Chiamata: 83085
  A023FTimbratureDtM1.A023FTimbratureMW.Q361.Filtered:=False;
end;

procedure TA023FGestTimbra.FormCreate(Sender: TObject);
begin
  ECausale.ListSource:=A023FTimbratureDtM1.A023FTimbratureMW.D275;
  LCausale.DataSource:=A023FTimbratureDtM1.A023FTimbratureMW.D275;
  EOra.DataSource:=A023FTimbratureDtM1.A023FTimbratureMW.D100;
  DBLookupRilevatore.ListSource:= A023FTimbratureDtM1.A023FTimbratureMW.D361;
  DBLookupRilevatore.DataSource:=A023FTimbratureDtM1.A023FTimbratureMW.D100;
  ECausale.DataSource:=A023FTimbratureDtM1.A023FTimbratureMW.D100;
  DBRadioGroup1.DataSource:=A023FTimbratureDtM1.A023FTimbratureMW.D100;
end;

procedure TA023FGestTimbra.dcmbKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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
