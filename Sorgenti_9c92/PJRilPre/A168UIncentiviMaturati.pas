unit A168UIncentiviMaturati;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  A000UCostanti, A000USessione, A000UInterfaccia, C700USelezioneAnagrafe, SelAnagrafe, Grids,
  DBGrids, StdCtrls, ExtCtrls, C004UParamForm, StrUtils, Buttons, C013UCheckList,
  C180FunzioniGenerali, System.Actions;

type
  TElencoDate = record
    Data:String;
    Colorata:Boolean;
  end;

  TA168FIncentiviMaturati = class(TR001FGestTab)
    dgrdMaturazioni: TDBGrid;
    frmSelAnagrafe: TfrmSelAnagrafe;
    gpbAbbattimenti: TGroupBox;
    dgrdAbbattimenti: TDBGrid;
    Panel2: TPanel;
    rgpVisualizzazione: TGroupBox;
    chkVisIntere: TCheckBox;
    chkVisProporzionate: TCheckBox;
    chkVisNette: TCheckBox;
    chkVisNetteRisp: TCheckBox;
    chkVisAssenze: TCheckBox;
    chkVisQuantitative: TCheckBox;
    Quote: TLabel;
    edtQuote: TEdit;
    btnQuote: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dgrdMaturazioniDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure chkVisIntereClick(Sender: TObject);
    procedure btnQuoteClick(Sender: TObject);
    procedure edtQuoteChange(Sender: TObject);
  private
    { Private declarations }
    ElencoDate:array of TElencoDate;
    procedure CambiaProgressivo;
    procedure Aggiorna;
    procedure CaricaElencoDate;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
  public
    { Public declarations }
  end;

var
  A168FIncentiviMaturati: TA168FIncentiviMaturati;

  procedure OpenA168IncentiviMaturati(Prog:LongInt);

implementation

uses A168UIncentiviMaturatiDtM;

{$R *.dfm}

procedure OpenA168IncentiviMaturati(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA168IncentiviMaturati') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A168FIncentiviMaturati:=TA168FIncentiviMaturati.Create(nil);
  with A168FIncentiviMaturati do
    try
      C700Progressivo:=Prog;
      A168FIncentiviMaturatiDtM:=TA168FIncentiviMaturatiDtM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A168FIncentiviMaturatiDtM.Free;
      Free;
    end;
end;

procedure TA168FIncentiviMaturati.dgrdMaturazioniDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var i:Integer;
begin
  inherited;
  if gdFixed in State then exit;
  //Ciclo su tabella
  for i:=0 to High(ElencoDate) do
    if (ElencoDate[i].Colorata) and
       (ElencoDate[i].Data = A168FIncentiviMaturatiDtM.selT762.FieldByName('ANNO').AsString + A168FIncentiviMaturatiDtM.selT762.FieldByName('MESE').AsString) then
    begin
      if gdSelected in State then
      begin
        dgrdMaturazioni.Canvas.Brush.Color:=clHighLight;
        dgrdMaturazioni.Canvas.Font.Color:=clWhite;
      end
      else
      begin
        dgrdMaturazioni.Canvas.Brush.Color:=$00FFFF80;
        dgrdMaturazioni.Canvas.Font.Color:=clWindowText;
      end;
      dgrdMaturazioni.DefaultDrawColumnCell(Rect,DataCol,Column,State);
      Break;
    end;
end;

procedure TA168FIncentiviMaturati.edtQuoteChange(Sender: TObject);
begin
  inherited;
  Aggiorna;
end;

procedure TA168FIncentiviMaturati.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA168FIncentiviMaturati.FormShow(Sender: TObject);
begin
  inherited;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A168FIncentiviMaturatiDtM.A168FIncentiviMaturatiMW,SessioneOracle,StatusBar,2,True);
  DButton.DataSet:=A168FIncentiviMaturatiDtM.selT762;
  CreaC004(SessioneOracle,'A168',Parametri.ProgOper);
  GetParametriFunzione;
end;

procedure TA168FIncentiviMaturati.GetParametriFunzione;
begin
  chkVisIntere.Checked:=C004FParamForm.GetParametro('INTERE','N') = 'S';
  chkVisProporzionate.Checked:=C004FParamForm.GetParametro('PROPORZIONATE','N') = 'S';
  chkVisNette.Checked:=C004FParamForm.GetParametro('NETTE','S') = 'S';
  chkVisNetteRisp.Checked:=C004FParamForm.GetParametro('NETTERISP','N') = 'S';
  chkVisQuantitative.Checked:=C004FParamForm.GetParametro('QUANTITATIVE','N') = 'S';
  chkVisAssenze.Checked:=C004FParamForm.GetParametro('ASSENZE','N') = 'S';
  edtQuote.Text:=C004FParamForm.GetParametro('QUOTE','');
end;

procedure TA168FIncentiviMaturati.PutParametriFunzione;
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('INTERE',IfThen(chkVisIntere.Checked,'S','N'));
  C004FParamForm.PutParametro('PROPORZIONATE',IfThen(chkVisProporzionate.Checked,'S','N'));
  C004FParamForm.PutParametro('NETTE',IfThen(chkVisNette.Checked,'S','N'));
  C004FParamForm.PutParametro('NETTERISP',IfThen(chkVisNetteRisp.Checked,'S','N'));
  C004FParamForm.PutParametro('QUANTITATIVE',IfThen(chkVisQuantitative.Checked,'S','N'));
  C004FParamForm.PutParametro('ASSENZE',IfThen(chkVisAssenze.Checked,'S','N'));
  C004FParamForm.PutParametro('QUOTE',edtQuote.Text);
  try SessioneOracle.Commit; except end;
end;

procedure TA168FIncentiviMaturati.btnQuoteClick(Sender: TObject);
begin
  inherited;
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  try
    with A168FIncentiviMaturatiDtM.A168FIncentiviMaturatiMW.selT765 do
    begin
      First;
      while not Eof do
      begin
        C013FCheckList.clbListaDati.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
        Next;
      end;
    end;
    R180PutCheckList(edtQuote.Text,5,C013FCheckList.clbListaDati);
    if ShowModal = mrOK then
      edtQuote.Text:=R180GetCheckList(5,C013FCheckList.clbListaDati);
  finally
    Release;
  end;
end;

procedure TA168FIncentiviMaturati.CambiaProgressivo;
begin
  if C700OldProgressivo <> C700Progressivo then
  begin
    Aggiorna;
    NumRecords;
  end;
end;

procedure TA168FIncentiviMaturati.Aggiorna;
var Filtro:String;
begin
  A168FIncentiviMaturatiDtM.A168FIncentiviMaturatiMW.bVisIntere:=chkVisIntere.Checked;
  A168FIncentiviMaturatiDtM.A168FIncentiviMaturatiMW.bVisProporzionate:=chkVisProporzionate.Checked;
  A168FIncentiviMaturatiDtM.A168FIncentiviMaturatiMW.bVisNette:=chkVisNette.Checked;
  A168FIncentiviMaturatiDtM.A168FIncentiviMaturatiMW.bVisNetteRisp:=chkVisNetteRisp.Checked;
  A168FIncentiviMaturatiDtM.A168FIncentiviMaturatiMW.bVisQuantitative:=chkVisQuantitative.Checked;
  A168FIncentiviMaturatiDtM.A168FIncentiviMaturatiMW.bVisAssenze:=chkVisAssenze.Checked;
  A168FIncentiviMaturatiDtM.A168FIncentiviMaturatiMW.sQuote:=edtQuote.Text;
  A168FIncentiviMaturatiDtM.A168FIncentiviMaturatiMW.sSource:='WIN'; //identificazione giro Windows
  A168FIncentiviMaturatiDtM.A168FIncentiviMaturatiMW.AggiornaB;

  CaricaElencoDate;
end;

procedure TA168FIncentiviMaturati.CaricaElencoDate;
var i:integer;
    Puntatore:TBookmark;
begin
  SetLength(ElencoDate,0);
  with A168FIncentiviMaturatiDtM.selT762 do
  begin
    DisableControls;
    Puntatore:=GetBookmark;
	{ TODO : TEST IW 15 }
	try
      First;
      i:=-1;
      while not Eof do
      begin
        if Length(ElencoDate) = 0 then
        begin
          inc(i);
          SetLength(ElencoDate,i + 1);
          ElencoDate[i].Data:=FieldByName('ANNO').AsString + FieldByName('MESE').AsString;
          ElencoDate[i].Colorata:=False;
        end
        else if ElencoDate[i].Data <> FieldByName('ANNO').AsString + FieldByName('MESE').AsString then
        begin
          inc(i);
          SetLength(ElencoDate,i + 1);
          ElencoDate[i].Data:=FieldByName('ANNO').AsString + FieldByName('MESE').AsString;
          ElencoDate[i].Colorata:=not ElencoDate[i - 1].Colorata;
        end;
        Next;
      end;
      GotoBookmark(Puntatore);
	finally
      FreeBookmark(Puntatore);
	end;
    EnableControls;
  end;
end;

procedure TA168FIncentiviMaturati.chkVisIntereClick(Sender: TObject);
begin
  inherited;
  Aggiorna;
end;

end.
