unit W002UAnagrafeScheda;

interface

uses
  R010UPaginaWeb, A000UMessaggi,
  Db, SysUtils, Graphics,
  IWHTMLControls, IWForm, IWAppForm, IWApplication,
  IWTemplateProcessorHTML, IWCompLabel, IWControl,
  Classes, Controls, Variants, Forms,
  IWVCLBaseContainer, IWContainer,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWVCLComponent,
  StrUtils, ActnList, WC002UStoriaDipendenteFM, IWCompGrids,
  meIWLabel, meIWLink, meIWGrid, IWCompExtCtrls, meIWImageFile, IWCompButton,
  meIWButton;

type
   TW002FAnagrafeScheda = class(TR010FPaginaWeb)
    lblDipendente: TmeIWLabel;
    grdSchedaAnagrafica: TmeIWGrid;
    procedure grdSchedaAnagraficaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdSchedaAnagraficaCellClick(ASender: TObject; const ARow, AColumn: Integer);
  private
    Matricola:String;
    Progressivo:Integer;
    WC002FStoriaDipendenteFM:TWC002FStoriaDipendenteFM;
    procedure CaricaScheda;
  protected
    function  GetInfoFunzione: String; override;
    procedure DistruggiOggetti; override;
  public
    SchedaCompleta:Boolean;
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

uses A000UInterfaccia;

function TW002FAnagrafeScheda.InizializzaAccesso:Boolean;
var MOld:String;
begin
  Result:=True;
  MOld:=WR000DM.cdsAnagrafe.FieldByName('MATRICOLA').AsString;
  if WR000DM.cdsAnagrafe.Locate('MATRICOLA',ParametriForm.Matricola,[]) then
  begin
    Matricola:=WR000DM.cdsAnagrafe.FieldByName('MATRICOLA').AsString;
    Progressivo:=WR000DM.cdsAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    ParametriForm.Progressivo:=Progressivo;
    SchedaCompleta:=ParametriForm.Completa;

    CaricaScheda;
    WR000DM.cdsAnagrafe.Locate('MATRICOLA',MOld,[]);
  end;
end;

procedure TW002FAnagrafeScheda.CaricaScheda;
var i,Row,c:Integer;
begin
  lblDipendente.Caption:=Format('%s %s - %s %s - %s %s',[
    WR000DM.cdsAnagrafe.FieldByName('COGNOME').AsString,
    WR000DM.cdsAnagrafe.FieldByName('NOME').AsString,
    A000TraduzioneStringhe('MATRICOLA'),
    WR000DM.cdsAnagrafe.FieldByName('MATRICOLA').AsString,
    A000TraduzioneStringhe('BADGE'),
    WR000DM.cdsAnagrafe.FieldByName('T430BADGE').AsString
    ]);

  WR000DM.GetDatiAnagrafici(Row, SchedaCompleta);

  grdSchedaAnagrafica.ColumnCount:=2;
  if DebugHook<> 0 then
    grdSchedaAnagrafica.ColumnCount:=grdSchedaAnagrafica.ColumnCount + 3;
  grdSchedaAnagrafica.RowCount:=Row + 1;

  // intestazione
  c:=0;
  grdSchedaAnagrafica.Cell[0,c].Text:='Dato';
  inc(c);
  grdSchedaAnagrafica.Cell[0,c].Text:='Valore';
  if DebugHook <> 0 then
  begin
    inc(c);
    grdSchedaAnagrafica.Cell[0,c].Text:='(**) Nome pagina';
    inc(c);
    grdSchedaAnagrafica.Cell[0,c].Text:='(**) Top';
    inc(c);
    grdSchedaAnagrafica.Cell[0,c].Text:='(**) Left';
  end;

  // popolamento tabella
  for i:=0 to Row - 1 do
  begin
    // dato
    c:=0;
    grdSchedaAnagrafica.Cell[i + 1,c].Text:=WR000DM.CampoArr[i].DisplayLabel;
    grdSchedaAnagrafica.Cell[i + 1,c].Clickable:=WR000DM.CampoArr[i].Clickable;
    // valore
    inc(c);
    grdSchedaAnagrafica.Cell[i + 1,c].Text:=WR000DM.CampoArr[i].AsString +
                                            IfThen(WR000DM.CampoArr[i].HasDesc,' (' + WR000DM.CampoArr[i].DescAsString + ')');
    if DebugHook <> 0 then
    begin
      // nome pagina
      inc(c);
      grdSchedaAnagrafica.Cell[i + 1,c].Text:=WR000DM.CampoArr[i].NomePagina;
      // top
      inc(c);
      grdSchedaAnagrafica.Cell[i + 1,c].Text:=WR000DM.CampoArr[i].Top.ToString;
      // left
      inc(c);
      grdSchedaAnagrafica.Cell[i + 1,c].Text:=WR000DM.CampoArr[i].Left.ToString;
    end;
  end;
end;

procedure TW002FAnagrafeScheda.grdSchedaAnagraficaRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  RenderCell(ACell,ARow,AColumn,True,True);
end;

procedure TW002FAnagrafeScheda.grdSchedaAnagraficaCellClick(ASender: TObject; const ARow,
  AColumn: Integer);
var
  Dato:string;
begin
  Dato:=StringReplace(WR000DM.CampoArr[ARow - 1].FieldName,'T430','',[]);
  WC002FStoriaDipendenteFM:=TWC002FStoriaDipendenteFM.Create(Self);
  WC002FStoriaDipendenteFM.VisualizzaScheda(Matricola,Dato,Progressivo);
end;

function TW002FAnagrafeScheda.GetInfoFunzione: String;
begin
  Result:='';
  try
    if (WR000DM <> nil) and
       (WR000DM.cdsAnagrafe <> nil) then
    begin
      if not WR000DM.cdsAnagrafe.Active then
        Result:='' // dataset non pronto
      else if WR000DM.cdsAnagrafe.RecordCount = 0 then
        Result:=A000TraduzioneStringhe(A000MSG_MSG_NESSUN_DIP)
      else
      begin
        Result:=Format('%s: %s<br>%s: %s %s',
                       [A000TraduzioneStringhe(A000MSG_MSG_MATRICOLA),
                        WR000DM.cdsAnagrafe.FieldByName('MATRICOLA').AsString,
                        A000TraduzioneStringhe(A000MSG_MSG_NOMINATIVO),
                        WR000DM.cdsAnagrafe.FieldByName('COGNOME').AsString,
                        WR000DM.cdsAnagrafe.FieldByName('NOME').AsString]);
      end;
    end;
  except
  end;
end;

procedure TW002FAnagrafeScheda.DistruggiOggetti;
begin
  if GGetWebApplicationThreadVar.Data <> nil then
  begin
    SetLength(WR000DM.CampoArr,0);
  end;
end;

end.
