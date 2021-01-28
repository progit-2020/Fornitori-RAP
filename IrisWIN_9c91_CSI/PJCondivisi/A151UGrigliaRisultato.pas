unit A151UGrigliaRisultato;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, StdCtrls, Buttons, DBGrids, C180FunzioniGenerali,
  Menus, Printers, Oracle, OracleData, DB, Math, Clipbrd;

type
  TA151FGrigliaRisultato = class(TForm)
    Panel1: TPanel;
    dgrdRisultato: TDBGrid;
    BitBtn1: TBitBtn;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    N2: TMenuItem;
    Copia2: TMenuItem;
    CopiaInExcel: TMenuItem;
    btnSelezionaTutto: TBitBtn;
    btnCopia: TBitBtn;
    btnStampa: TBitBtn;
    btnStampante: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    btnEsportaXML: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure dgrdRisultatoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure CopiaInExcelClick(Sender: TObject);
    procedure btnEsportaXMLClick(Sender: TObject);
    procedure btnSelezionaTuttoClick(Sender: TObject);
    procedure btnCopiaClick(Sender: TObject);
    procedure btnStampanteClick(Sender: TObject);
    procedure btnStampaClick(Sender: TObject);
  private
    { Private declarations }
    IndL104,IndDip,IndData:Integer;
  public
    { Public declarations }
  end;

var
  A151FGrigliaRisultato: TA151FGrigliaRisultato;

  procedure OpenA151GrigliaRisultato;

implementation

uses A151UAssenteismoDtM, A151UAssenteismo, A151UEsportaXml;

{$R *.dfm}

procedure OpenA151GrigliaRisultato;
begin
  A151FGrigliaRisultato:=TA151FGrigliaRisultato.Create(nil);
  with A151FGrigliaRisultato do
  try
    Screen.Cursor:=crHourGlass;
    ShowModal;
    Screen.Cursor:=crDefault;
  finally
    Free;
  end;
end;

procedure TA151FGrigliaRisultato.FormShow(Sender: TObject);
begin
  with A151FAssenteismoDtM.A151MW do
  begin
    dgrdRisultato.DataSource:=dsrRisultato;
    A151FGrigliaRisultato.WindowState:=wsMaximized;
    btnEsportaXML.Visible:=EsportaTassiAss or EsportaLegge104;
    if btnEsportaXML.Visible then
    begin
      if EsportaTassiAss then
        btnEsportaXML.Caption:='Esporta tassi assenza in .XML'
      else if EsportaLegge104 then
        btnEsportaXML.Caption:='Invio legge 104/1992 tramite WS';
    end;

    iAss:=A151FAssenteismo.drdgAssenze.ItemIndex;
    iNumDipPeriodo:=A151FAssenteismo.drdgNumDipPeriodo.ItemIndex;
    sDaData:=A151FAssenteismo.frmInputPeriodo.edtInizio.Text;
    sAData:=A151FAssenteismo.frmInputPeriodo.edtFine.Text;
    ImpostaColonneGriglia;
  end;
end;

procedure TA151FGrigliaRisultato.dgrdRisultatoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if not A151FAssenteismoDtM.A151MW.cdsRisultato.Active then
    Exit;
  if A151FAssenteismo.cmbEsportaXML.ItemIndex <> 1 then
    Exit;
  if gdFixed in State then exit;
  if (gdSelected in State) or (TDBGrid(Sender).SelectedRows.CurrentRowSelected) then
  begin
    TDBGrid(Sender).Canvas.Brush.Color:=clHighLight;
    TDBGrid(Sender).Canvas.Font.Color:=clWhite;
  end
  else
  begin
    //Evidenzio le colonne del dipendente
    if Column.FieldName = 'COGNOME' then
      IndDip:=Column.Field.Index;
    //Evidenzio le colonne del giustificativo
    if Column.FieldName = 'DATAGIUSTIF' then
      IndData:=Column.Field.Index;
    //Evidenzio le colonne tipiche della legge 104
    if Column.FieldName = 'TIPO_DISABILITA' then
      IndL104:=Column.Field.Index;
    if ((IndL104 > 0) and (Column.Field.Index >= IndL104)) or
       ((IndDip > 0) and (Column.Field.Index >= IndDip) and (Column.Field.Index <= IndDip + 3)) or
       ((IndData > 0) and (Column.Field.Index >= IndData) and (Column.Field.Index <= IndData + 1)) then
      TDBGrid(Sender).Canvas.Brush.Color:=$00FFFF80
    else
      TDBGrid(Sender).Canvas.Brush.Color:=clWhite;
  end;
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TA151FGrigliaRisultato.Selezionatutto1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdRisultato,'S');
end;

procedure TA151FGrigliaRisultato.Deselezionatutto1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dGrdRisultato,'N');
end;

procedure TA151FGrigliaRisultato.Invertiselezione1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdRisultato,'C');
end;

procedure TA151FGrigliaRisultato.CopiaInExcelClick(Sender: TObject);
begin
  btnCopiaClick(nil);
end;

procedure TA151FGrigliaRisultato.btnEsportaXMLClick(Sender: TObject);
begin
  OpenA151EsportaXml;
end;

procedure TA151FGrigliaRisultato.btnSelezionaTuttoClick(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdRisultato,'S');
end;

procedure TA151FGrigliaRisultato.btnCopiaClick(Sender: TObject);
var
  S:String;
  i:Integer;

  function RimuoviSpazzi(InStrToClear:string):string;
  {Rimuove gli spazzi della campo GRUPPO_DESC tra il ";" e il valore}
  var
    i:Integer;
    StartToDelete:Boolean;
  begin
    Result:=Trim(InStrToClear);
    StartToDelete:=False;
    for i:=Length(Result) downto 1 do
    begin
      if Copy(Result,i,1) = ';' then
        StartToDelete:=True
      else
      begin
        if StartToDelete and (copy(Result,i,1) = ' ') then
          Delete(Result,i,1)
        else
          StartToDelete:=False;
      end;
    end;
  end;

begin
  with dgrdRisultato.DataSource.DataSet do
  begin
    if not Active then
      exit;
    S:='';
    Clipboard.Clear;
    DisableControls;
    Screen.Cursor:=crHourGlass;
    First;
    try
      if not EOF then
      begin
        for i:=0 to FieldCount - 1 do
          if Fields[i].Visible then
            S:=S + Fields[i].DisplayLabel + #9;
        S:=S + #13#10;
      end;
      while not EOF do
      begin
        if dgrdRisultato.SelectedRows.CurrentRowSelected then
        begin
          for i:=0 to FieldCount - 1 do
            if Fields[i].Visible then
            begin
              if Fields[i].FieldName = 'GRUPPO_DESC' then
                S:=S + RimuoviSpazzi(Fields[i].AsString) + #9
              else
                S:=S + Fields[i].AsString + #9
            end;
          S:=S + #13#10;
        end;
        Next;
      end;
    finally
      First;
      EnableControls;
      Screen.Cursor:=crDefault;
    end;
  end;
  Clipboard.AsText:=S;
end;

procedure TA151FGrigliaRisultato.btnStampanteClick(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure TA151FGrigliaRisultato.btnStampaClick(Sender: TObject);
var F:TextFile;
    S,Intestazione:String;
    i,HP,HR,HCorr:Integer;
    procedure SaltoPagina;
    begin
      writeln(F,'');
      writeln(F,'Statistica Assenteismo-Forza Lavoro IrisWIN (Pag. ' + IntToStr(Printer.PageNumber)+ ')');
      writeln(F,'');
      writeln(F,Intestazione);
      writeln(F,'');
      HCorr:=HR * 5;
    end;
begin
  AssignPrn(F);
  Rewrite(F);
  Printer.Canvas.Font.Name:='Courier New';
  Printer.Canvas.Font.Size:=7;
  HP:=Printer.PageHeight;
  HR:=Printer.Canvas.TextHeight(' ');
  with A151FAssenteismoDtM.A151MW.cdsRisultato do
  begin
    First;
    DisableControls;
    S:='';
    for i:=0 to FieldCount - 1 do
      if Fields[i].Visible then
        S:=S + Format('%-*s',[30, Copy(Fields[i].DisplayLabel,1,30)]);
    Intestazione:=S;
    SaltoPagina;
    while not Eof do
    begin
      S:='';
      if HCorr >= (HP - HR*8) then
      begin
        while Printer.PageNumber < 2 do
          writeln(F,'');
        SaltoPagina;
      end;
      for i:=0 to FieldCount - 1 do
        if Fields[i].Visible then
          S:=S + Format('%-*s',[30, Copy(Fields[i].AsString,1,30)]);
      writeln(F,S);
      inc(HCorr,HR);
      Next;
    end;
    First;
    EnableControls;
  end;
  CloseFile(F);
end;

end.
