unit A115UIterCondizValidita;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Grids,
  DBGrids,
  ExtCtrls,
  StdCtrls,
  Buttons,
  DB,
  A000UCostanti,
  A000USessione,
  A115UIterAutorizzativiDM,
  C180FunzioniGenerali;

type
  TA115FIterCondizValidita = class(TForm)
    dgrdGenerale: TDBGrid;
    dsrGenerale: TDataSource;
    pnlBottm: TPanel;
    btnConferma: TBitBtn;
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
  A115FIterCondizValidita: TA115FIterCondizValidita;

implementation

{$R *.dfm}

uses A115UIterAutorizzativi;

procedure TA115FIterCondizValidita.btnAnnullaClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TA115FIterCondizValidita.btnConfermaClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TA115FIterCondizValidita.dgrdGeneraleEditButtonClick(Sender: TObject);
begin
  A115FIterAutorizzativi.EditaCampoMemo(dgrdGenerale,dgrdGenerale.SelectedField.FieldName);
end;

procedure TA115FIterCondizValidita.FormShow(Sender: TObject);
var
  i, j:Integer;
begin
  with dgrdGenerale.DataSource do
  begin
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
        end
        else if DataSet.Fields[i].FieldName = 'LIVELLO' then
        begin
          for j:=-1 to A115FIterAutorizzativiDM.selI096.RecordCount do
          begin
            dgrdGenerale.Columns[dgrdGenerale.Columns.Count - 1].PickList.Add(j.ToString);
          end;
        end;
      end;
  end;
end;

end.
