unit A145UEsenzioni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  Grids, DBGrids, ExtCtrls, StdCtrls, A000UCostanti, A000USessione, A000UInterfaccia,
  C180FunzioniGenerali, Buttons, C006UStoriaDip, System.Actions, A145UComVisiteFiscaliMW;

type
  TA145FEsenzioni = class(TR001FGestTab)
    Panel2: TPanel;
    dGrdEsenzioni: TDBGrid;
    rgpFiltro: TRadioGroup;
    PopupMenu3: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    MenuItem2: TMenuItem;
    Copia2: TMenuItem;
    CopiaInExcel: TMenuItem;
    BitBtn1: TBitBtn;
    Visualizzadettagliodipendente1: TMenuItem;
    N4: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rgpFiltroClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Copia2Click(Sender: TObject);
    procedure CopiaInExcelClick(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure Visualizzadettagliodipendente1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AggiornaElencoTipi;
  end;

var
  A145FEsenzioni: TA145FEsenzioni;

  procedure OpenA145Esenzioni;

implementation

uses A145UComunicazioneVisiteFiscaliDtM, A145UComunicazioneVisiteFiscali;

{$R *.dfm}

procedure OpenA145Esenzioni;
begin
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TA145FEsenzioni,A145FEsenzioni);
  try
    Screen.Cursor:=crDefault;
    A145FEsenzioni.ShowModal;
  finally
    A145FEsenzioni.Free;
  end;
end;

procedure TA145FEsenzioni.Copia2Click(Sender: TObject);
begin
  inherited;
  R180DBGridCopyToClipboard(dGrdEsenzioni,Sender = CopiaInExcel);
end;

procedure TA145FEsenzioni.CopiaInExcelClick(Sender: TObject);
begin
  inherited;
  R180DBGridCopyToClipboard(dGrdEsenzioni,Sender = CopiaInExcel);
end;

procedure TA145FEsenzioni.Deselezionatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dGrdEsenzioni,'N');
end;

procedure TA145FEsenzioni.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW.TabellaEsenzioni.Filtered:=False;
end;

procedure TA145FEsenzioni.FormShow(Sender: TObject);
begin
  inherited;
  A145FEsenzioni.Caption:='<A145> Gestione esenzioni al ' + DateToStr(A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.DataElaborazione);
  DButton.DataSet:=A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW.TabellaEsenzioni;
  rgpFiltro.ItemIndex:=0;
  rgpFiltroClick(nil);
  AggiornaElencoTipi;
end;

procedure TA145FEsenzioni.Invertiselezione1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dGrdEsenzioni,'C');
end;

procedure TA145FEsenzioni.AggiornaElencoTipi;
begin
  dgrdEsenzioni.Columns[7].PickList.Clear;
  with A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW.selT047Esenzioni do
  begin
    Close;
    Open;
    First;
    while not Eof do
    begin
      dgrdEsenzioni.Columns[7].PickList.Add(FieldByName('TIPO_ESENZIONE').AsString);
      Next;
    end;
  end;
end;

procedure TA145FEsenzioni.rgpFiltroClick(Sender: TObject);
begin
  inherited;
  with A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW do
  begin
    itemIndexFiltroEsenzioni:=rgpFiltro.ItemIndex;
    TabellaEsenzioni.Filtered:=False;
    TabellaEsenzioni.Filtered:=True;
  end;
  NumRecords;
end;

procedure TA145FEsenzioni.Selezionatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dGrdEsenzioni,'S');
end;

procedure TA145FEsenzioni.TRegisClick(Sender: TObject);
begin
  inherited;
  //Forzo il refresh della griglia
  rgpFiltroClick(nil);
end;

procedure TA145FEsenzioni.Visualizzadettagliodipendente1Click(Sender: TObject);
var i:Integer;
  GridSel: TGridRect;
  elencoStoriaDip: TArrayStoriaDip;
begin
  inherited;
  try
    C006FStoriaDip:=TC006FStoriaDip.Create(Application);
    with A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW do
    begin
      C006FStoriaDip.Caption:='Visualizzazione dettaglio periodi assenza di ' +
        TabellaEsenzioni.FieldByName('COGNOME').AsString + ' ' +
        TabellaEsenzioni.FieldByName('NOME').AsString + ' (MATR.' +
        TabellaEsenzioni.FieldByName('MATRICOLA').AsString + ')';
      elencoStoriaDip:=StoriaDipendente(TabellaEsenzioni.FieldByName('PROGRESSIVO').AsInteger);;
    end;

    with C006FStoriaDip do
    begin
      pmnuVaiADecorrenza.Items[0].Visible:=False;
      AbilitaMenu:=False;
      Grid.FixedCols:=0;
      Grid.ColWidths[0]:=70;
      Grid.Cells[1,0]:='Inizio';
      Grid.Cells[2,0]:='Fine';
      Grid.Cells[3,0]:='Giorni';
      Grid.ColWidths[3]:=50;
      Grid.Cells[4,0]:='Tipo esenzione';
      GridSel.Left:=0;
      GridSel.Top:=1;
      GridSel.Right:=6;
      GridSel.Bottom:=0;
      Grid.RowCount:=Length(elencoStoriaDip) + 1;
      for i:=Low(elencoStoriaDip) to High(elencoStoriaDip) do
      begin
        Grid.Cells[0,i + 1]:=elencoStoriaDip[i].Operazione;
        Grid.Cells[1,i + 1]:=elencoStoriaDip[i].Inizio;
        Grid.Cells[2,i + 1]:=elencoStoriaDip[i].Fine;
        Grid.Cells[3,i + 1]:=elencoStoriaDip[i].Giorni;
        Grid.Cells[4,i + 1]:=elencoStoriaDip[i].TipoEsenzione;
        if elencoStoriaDip[i].bottom then
          GridSel.Bottom:=GridSel.Bottom + 1;
      end;
      if GridSel.Bottom > 1 then
        Grid.Selection:=GridSel;
      ShowModal;
    end;
  finally
    FreeAndNil(C006FStoriaDip);
  end;

end;

end.
