unit A008UIterCondizValidita;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, StdCtrls, Buttons, DB,
  A000UCostanti, A000USessione, A008UOperatoriDtm1, C180FunzioniGenerali;

type
  TA008FIterCondizValidita = class(TForm)
    pnlBottm: TPanel;
    dgrdGenerale: TDBGrid;
    btnConferma: TBitBtn;
    dsrGenerale: TDataSource;
    procedure dgrdGeneraleEditButtonClick(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A008FIterCondizValidita: TA008FIterCondizValidita;

implementation

uses A008UAziende;

{$R *.dfm}

procedure TA008FIterCondizValidita.btnAnnullaClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TA008FIterCondizValidita.btnConfermaClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TA008FIterCondizValidita.dgrdGeneraleEditButtonClick(Sender: TObject);
begin
  A008FAziende.EditaCampoMemo(dgrdGenerale,dgrdGenerale.SelectedField.FieldName);
end;

procedure TA008FIterCondizValidita.FormShow(Sender: TObject);
var i:Integer;
begin
  with dgrdGenerale.DataSource do
    for i:=0 to DataSet.FieldCount - 1 do
      if DataSet.Fields[i].Visible then
      begin
        dgrdGenerale.Columns.Add;
        dgrdGenerale.Columns[dgrdGenerale.Columns.Count - 1].FieldName:=DataSet.Fields[i].FieldName;
        if R180In(DataSet.Fields[i].FieldName,['EXPR_DATA','CONDIZ_VALIDITA','MESSAGGIO']) then
          dgrdGenerale.Columns[dgrdGenerale.Columns.Count - 1].ButtonStyle:=cbsEllipsis;
        if DataSet.Fields[i].FieldName = 'STATO' then
        begin
          dgrdGenerale.Columns[dgrdGenerale.Columns.Count - 1].PickList.Add('C');
          dgrdGenerale.Columns[dgrdGenerale.Columns.Count - 1].PickList.Add('A');
        end
        else if DataSet.Fields[i].FieldName = 'BLOCCANTE' then
        begin
          dgrdGenerale.Columns[dgrdGenerale.Columns.Count - 1].PickList.Add('S');
          dgrdGenerale.Columns[dgrdGenerale.Columns.Count - 1].PickList.Add('N');
        end;
      end;
end;

end.
