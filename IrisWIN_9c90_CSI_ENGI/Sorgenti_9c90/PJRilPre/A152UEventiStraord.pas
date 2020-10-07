unit A152UEventiStraord;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OracleData,
  A000UCostanti, A000USessione, R004UGestStorico, C013UCheckList, C180FunzioniGenerali,
  ActnList, ImgList, DB, Menus, StdCtrls, ComCtrls, checklst,
  ToolWin, Mask, DBCtrls, Buttons, Grids, DBGrids, ToolbarFiglio, System.Actions;

type
  TA152FEventiStraord = class(TR004FGestStorico)
    frmToolbarFiglio: TfrmToolbarFiglio;
    dgrdT722: TDBGrid;
    dgrdT723: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure dgrdT723EditButtonClick(Sender: TObject);
  private
    procedure CaricaPickList(Grid:TDBGrid;Index:Integer;DS:TOracleDataSet);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A152FEventiStraord: TA152FEventiStraord;

procedure OpenA152EventiStraord(Cod:String);

implementation

uses A152UEventiStraordDtM;

{$R *.dfm}

procedure OpenA152EventiStraord(Cod:String);
{Gestione Eventi straordinari}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA152EventiStraord') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A152FEventiStraord:=TA152FEventiStraord.Create(nil);
  with A152FEventiStraord do
    try
    A152FEventiStraordDtM:=TA152FEventiStraordDtM.Create(nil);
    A152FEventiStraordDtM.selT722.Locate('Codice',Cod,[]);
    ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A152FEventiStraordDtM.Free;
      Release;
    end;
end;

procedure TA152FEventiStraord.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A152FEventiStraordDtM.selT722;
  CaricaPickList(dgrdT722,R180GetColonnaDBGrid(dgrdT722,'CAUSALE_STR'),A152FEventiStraordDtM.selT275);
  CaricaPickList(dgrdT722,R180GetColonnaDBGrid(dgrdT722,'CAUSALE_STR_DOM'),A152FEventiStraordDtM.selT275);
  frmToolbarFiglio.TFDButton:=A152FEventiStraordDtM.dsrT723;
  frmToolbarFiglio.TFDBGrid:=dgrdT723;
  frmToolbarFiglio.tlbarFiglio.HandleNeeded;//necessario per XE3
  //Per gestire i pulsanti quando CachedUpdate:=False; (si considera lo state della singola riga invece che tutta l'operazione di inserimento/modifica)
  A152FEventiStraordDtM.dsrT723.OnStateChange:=frmToolbarFiglio.DButtonStateChange;
  SetLength(frmToolbarFiglio.lstLock,3);
  frmToolbarFiglio.lstLock[0]:=ToolBar1;
  frmToolbarFiglio.lstLock[1]:=File1;
  frmToolbarFiglio.lstLock[2]:=Strumenti1;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
end;

procedure TA152FEventiStraord.btnStoricizzaClick(Sender: TObject);
begin
  inherited;
  A152FEventiStraordDtM.selT722.FieldByName('ID').Clear;
end;

procedure TA152FEventiStraord.CaricaPickList(Grid:TDBGrid;Index:Integer;DS:TOracleDataSet);
begin
  Grid.Columns[Index].PickList.Clear;
  with DS do
  begin
    First;
    while not Eof do
    begin
      Grid.Columns[Index].PickList.Add(Format('%-5s - %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
end;

procedure TA152FEventiStraord.dgrdT723EditButtonClick(Sender: TObject);
var LungCodice:Integer;
  procedure CaricaListaServizi(clb:TCheckListBox);
  var Dal,Al,Filtro:String;
  begin
    with A152FEventiStraordDtM.selServizi do
    begin
      Dal:=A152FEventiStraordDtM.selT722.FieldByName('DECORRENZA').AsString;
      Al:=A152FEventiStraordDtM.selT722.FieldByName('DECORRENZA_FINE').AsString;
      Filtro:=Format(#13#10 + 'AND ''%s'' >= DATADECORRENZA AND ''%s'' <= DATAFINE AND ''%s'' >= INIZIO AND ''%s'' <= NVL(FINE,TO_DATE(''31123999'',''DDMMYYYY''))' + #13#10,[Al,Dal,Al,Dal]);
      SetVariable('FILTRO',Filtro);
      Open;
      LungCodice:=FieldByName('CODICE').Size;
      First;
      while not Eof do
      begin
        clb.Items.Add(Format('%-*s %s',[LungCodice,FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
        Next;
      end;
    end;
  end;
begin
  inherited;
  if not (dgrdT723.DataSource.State in [dsEdit,dsInsert]) then
    exit;
  if dgrdT723.SelectedField.FieldName = 'FILTRO_ANAGRAFE' then
    with A152FEventiStraordDtM do
    begin
      if A000LookupTabella(TORINO_COMUNE_STRUTT_EVENTI_STR,selServizi) then
        with TC013FCheckList.Create(nil) do
        try
          CaricaListaServizi(clbListaDati);
          R180PutCheckList(selT723.FieldByName('FILTRO_ANAGRAFE').AsString,LungCodice,clbListaDati);
          if ShowModal = mrOK then
            selT723.FieldByName('FILTRO_ANAGRAFE').AsString:=R180GetCheckList(LungCodice,clbListaDati);
        finally
          Release;
        end;
    end;
end;

end.
