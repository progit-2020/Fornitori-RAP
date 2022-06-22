unit W006UListaReperibili;

interface

uses
  Classes, IWTemplateProcessorHTML, IWForm, IWAppForm,
  IWCompLabel, IWHTMLControls, Controls, IWControl, IWApplication,
  SysUtils, IWCompButton, Oracle, OracleData, Graphics,
  C180FunzioniGenerali, R010UPaginaWeb, A000UInterfaccia, Variants,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWVCLBaseControl, IWBaseControl, IWCompEdit, IWBaseHTMLControl, IWHTMLTag,
  Forms, IWVCLBaseContainer, IWContainer,
  IWVCLComponent, A000USessione, Math, WC002UDatiAnagraficiFM, IWCompGrids,
  meIWLabel, meIWLink, meIWGrid, meIWEdit, meIWButton;

type
  TVettReperibili = record
    Progressivo,
    Matricola,
    Badge,
    Nome,
    Data,
    Turno,
    DescTurno,
    DatoLiberoCod,
    DatoLiberoDes: String;
  end;

  TW006FListaReperibili = class(TR010FPaginaWeb)
    btnEsegui: TmeIWButton;
    lblPeriodoDal: TmeIWLabel;
    edtDal: TmeIWEdit;
    lblPeriodoAl: TmeIWLabel;
    edtAl: TmeIWEdit;
    grdReperibili: TmeIWGrid;
    procedure btnEseguiClick(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure grdReperibiliRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure grdReperibiliCellClick(ASender: TObject; const ARow, AColumn: Integer);
    procedure grdReperibiliHTMLTag(ASender: TObject; ATag: TIWHTMLTag);
  private
    CampiAggiuntivi:TStringList;
    Dal,Al:TDateTime;
    selAnagrafe:TOracleDataSet;
    Tipologia: String;
    ColonneFisse: Integer;
    WC002FDatiAnagraficiFM: TWC002FDatiAnagraficiFM;
    procedure OrdinaselAnagrafe(Campo:String);
  protected
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  end;

const CAMPI_FISSI: Integer = 10;

implementation

{$R *.dfm}

procedure TW006FListaReperibili.IWAppFormCreate(Sender: TObject);
var S,Sort:String;
begin
  inherited;
  Tipologia:='R';
  ColonneFisse:=5 + IfThen(Parametri.CampiRiferimento.C3_DatoPianificabile <> '',1,0);
  CampiAggiuntivi:=TStringList.Create;
  CampiAggiuntivi.Sorted:=True;
  with WR000DM.cdsI010 do
  begin
    Open;
    First;
    while not Eof do
    begin
      if (not FieldByName('POSIZIONE').IsNull) and
         (FieldByName('POSIZIONE').AsInteger <> POSIZIONE_NULL) and
         (FieldByName('NOME_CAMPO').AsString <> 'MATRICOLA') and
         (FieldByName('NOME_CAMPO').AsString <> 'COGNOME') and
         (FieldByName('NOME_CAMPO').AsString <> 'NOME') and
         (FieldByName('NOME_CAMPO').AsString <> 'PROGRESSIVO') and
         (FieldByName('NOME_CAMPO').AsString <> 'T430PROGRESSIVO') and
         (FieldByName('NOME_CAMPO').AsString <> 'T430BADGE') then
        CampiAggiuntivi.Add(FieldByName('NOME_CAMPO').AsString);
      Next;
    end;
  end;
  CampiAggiuntivi.Sorted:=False;
  Dal:=Parametri.DataLavoro;
  Al:=Parametri.DataLavoro;
  edtDal.Text:=FormatDateTime('dd/mm/yyyy',Dal);
  edtAl.Text:=FormatDateTime('dd/mm/yyyy',Al);
  grdReperibili.Visible:=False;
  with WR000DM do
  begin
    selT350.Tag:=selT350.Tag + 1;
    selT350.Close;
    selT350.SetVariable('TIPOLOGIA',Tipologia);
    selT350.Open;
  end;
  selAnagrafe:=TOracleDataSet.Create(Self);
  selAnagrafe.Session:=WR000DM.selAnagrafe.Session;
  selAnagrafe.ReadBuffer:=500;
  S:=UpperCase(EliminaRitornoACapo(WR000DM.selAnagrafe.SubstitutedSQL));
  S:=Copy(S,Pos('WHERE',S),Length(S));
  Sort:='';
  if Pos('ORDER BY',S) > 0 then
  begin
    Sort:=Copy(S,Pos('ORDER BY',S),Length(S));
    S:=Copy(S,1,Pos('ORDER BY',S) - 1);
  end;
  S:=StringReplace(S,':DATALAVORO','T380.DATA',[rfReplaceAll]);
  S:=S + ' AND T380.PROGRESSIVO = T030.PROGRESSIVO AND T380.DATA BETWEEN :DAL AND :AL AND T380.TIPOLOGIA = :TIPOLOGIA';
  if Sort = '' then
    Sort:='ORDER BY '
  else
    Sort:=Sort + ',';
  Sort:=Sort + 'COGNOME,NOME,MATRICOLA,DATA';
  S:=S + ' ' + Sort;
  selAnagrafe.SQL.Add('SELECT T030.PROGRESSIVO,T030.MATRICOLA,T430BADGE,T030.COGNOME||'' '' ||T030.NOME NOME,' +
                      '       T380.DATA,T380.TURNO1,T380.TURNO2,T380.TURNO3,T380.DATOLIBERO,T380.TIPOLOGIA');
  if CampiAggiuntivi.Count > 0 then
    selAnagrafe.SQL.Add(',' + CampiAggiuntivi.CommaText);
  selAnagrafe.SQL.Add('FROM T030_ANAGRAFICO T030,T480_COMUNI T480,V430_STORICO V430,T380_PIANIFREPERIB T380');
  selAnagrafe.SQL.Add(S);
  selAnagrafe.DeclareVariable('DAL',otDate);
  selAnagrafe.DeclareVariable('AL',otDate);
  selAnagrafe.DeclareVariable('TIPOLOGIA',otString); // aggiunto come filtro

  btnEseguiClick(nil);
end;

procedure TW006FListaReperibili.RefreshPage;
begin
  btnEseguiClick(nil);
end;

procedure TW006FListaReperibili.btnEseguiClick(Sender: TObject);
var VettReperibili:array of TVettReperibili;
    x,nr:Integer;
    DatoLiberoHead: String;
  procedure AggiungiTurno(T:String);
  var Inizio,Fine:Integer;
    procedure ScriviTurno(I1,F1:Integer; D:TDateTime);
    var i:Integer;
    begin
      if D >= Dal then
      begin
        SetLength(VettReperibili,Length(VettReperibili) + 1);
        i:=High(VettReperibili);
        VettReperibili[i].Progressivo:=selAnagrafe.FieldByName('PROGRESSIVO').AsString;
        VettReperibili[i].Matricola:=selAnagrafe.FieldByName('MATRICOLA').AsString;
        VettReperibili[i].Badge:=selAnagrafe.FieldByName('T430BADGE').AsString;
        VettReperibili[i].Nome:=selAnagrafe.FieldByName('NOME').AsString;
        VettReperibili[i].Data:=DateToStr(D);
        VettReperibili[i].Turno:=T;
        VettReperibili[i].DescTurno:=Format('%s-%s',[R180MinutiOre(I1),R180MinutiOre(F1)]);
        if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
        begin
          VettReperibili[i].DatoLiberoCod:=selAnagrafe.FieldByName('DATOLIBERO').AsString;
          with WR000DM.selDatoLibero do
            if SearchRecord('CODICE',VettReperibili[i].DatoLiberoCod,[srFromBeginning]) then
              VettReperibili[i].DatoLiberoDes:=FieldByName('DESCRIZIONE').AsString
            else
              VettReperibili[i].DatoLiberoDes:='<NON DEFINITO>';
        end
        else
        begin
          VettReperibili[i].DatoLiberoCod:='';
          VettReperibili[i].DatoLiberoDes:='';
        end;
      end;
    end;
  begin
    if WR000DM.selT350.SearchRecord('CODICE',T,[srFromBeginning]) then
    begin
      selAnagrafe.FieldByName('DATA').AsDateTime;
      Inizio:=WR000DM.selT350.FieldByName('INIZIO').AsInteger;
      Fine:=WR000DM.selT350.FieldByName('FINE').AsInteger;
      if Inizio >= Fine then
      begin
        // turni a cavallo della mezzanotte
        ScriviTurno(Inizio,1440,selAnagrafe.FieldByName('DATA').AsDateTime);
        ScriviTurno(0,Fine,selAnagrafe.FieldByName('DATA').AsDateTime + 1);
      end
      else
        ScriviTurno(Inizio,Fine,selAnagrafe.FieldByName('DATA').AsDateTime);
    end;
  end;
begin
  Dal:=StrToDate(edtDal.Text);
  Al:=StrToDate(edtAl.Text);
  Tipologia:='R';
  //reperimento dato libero
  if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
  begin
    with WR000DM do
    begin
      DatoLiberoHead:=Copy(Parametri.CampiRiferimento.C3_DatoPianificabile,1,1) +
                      LowerCase(Copy(Parametri.CampiRiferimento.C3_DatoPianificabile,2,Length(Parametri.CampiRiferimento.C3_DatoPianificabile) - 1));
      // verifica esistenza dato libero e apre dataset corrispondente
      if A000LookupTabella(Parametri.CampiRiferimento.C3_DatoPianificabile,selDatoLibero) then
      begin
        with selDatoLibero do
        begin
          if VariableIndex('DECORRENZA') >= 0 then
            SetVariable('DECORRENZA',R180FineMese(Parametri.DataLavoro));
          Open;
        end;
      end;
    end;
  end;

  SetLength(VettReperibili,0);
  with selAnagrafe do
  begin
    SetVariable('DAL',Dal - 1);
    SetVariable('AL',Al);
    SetVariable('TIPOLOGIA','R');
    Close;
    Open;
    for x:=0 to CampiAggiuntivi.Count - 1 do
    begin
      FieldByName(CampiAggiuntivi[x]).Index:=StrToIntDef(VarToStr(WR000DM.cdsI010.Lookup('NOME_CAMPO',CampiAggiuntivi[x],'POSIZIONE')),0) + CAMPI_FISSI;
      FieldByName(CampiAggiuntivi[x]).DisplayLabel:=VarToStr(WR000DM.cdsI010.Lookup('NOME_CAMPO',CampiAggiuntivi[x],'NOME_LOGICO'));
    end;
    while not Eof do
    begin
      AggiungiTurno(FieldByName('TURNO1').AsString);
      AggiungiTurno(FieldByName('TURNO2').AsString);
      AggiungiTurno(FieldByName('TURNO3').AsString);
      Next;
    end;
  end;
  grdReperibili.RowCount:=Length(VettReperibili) + 1;
  grdReperibili.ColumnCount:=ColonneFisse + CampiAggiuntivi.Count;
  grdReperibili.Cell[0,0].Text:='Matricola';
  grdReperibili.Cell[0,1].Text:='Badge';
  grdReperibili.Cell[0,2].Text:='Nome';
  grdReperibili.Cell[0,3].Text:='Data';
  grdReperibili.Cell[0,4].Text:='Turno';
  if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
    grdReperibili.Cell[0,5].Text:=DatoLiberoHead;
  for x:=CAMPI_FISSI to selAnagrafe.Fields.Count - 1 do
    grdReperibili.Cell[0,x - CAMPI_FISSI + ColonneFisse].Text:=selAnagrafe.Fields[x].DisplayLabel;
  for x:=0 to grdReperibili.ColumnCount - 1 do
  begin
    grdReperibili.Cell[0,x].Clickable:=x <> 4;   // turno non cliccabile
    if grdReperibili.Cell[0,x].Clickable then
      grdReperibili.Cell[0,x].Css:='font_rosso';
  end;
  for nr:=0 to High(VettReperibili) do
  begin
    grdReperibili.Cell[nr + 1,0].Text:=VettReperibili[nr].Matricola;
    grdReperibili.Cell[nr + 1,1].Text:=VettReperibili[nr].Badge;
    grdReperibili.Cell[nr + 1,2].Text:=VettReperibili[nr].Nome;
    grdReperibili.Cell[nr + 1,2].Clickable:=True;
    grdReperibili.Cell[nr + 1,3].Text:=VettReperibili[nr].Data;
    grdReperibili.Cell[nr + 1,4].Text:=VettReperibili[nr].DescTurno;
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
      grdReperibili.Cell[nr + 1,5].Text:=VettReperibili[nr].DatoLiberoCod  + ' - ' +
                                         VettReperibili[nr].DatoLiberoDes;
    for x:=CAMPI_FISSI to selAnagrafe.Fields.Count - 1 do
      grdReperibili.Cell[nr + 1,x - CAMPI_FISSI + ColonneFisse].Text:=VartoStr(selAnagrafe.Lookup('PROGRESSIVO',VettReperibili[nr].Progressivo,selAnagrafe.Fields[x].FieldName));
  end;
  WR000DM.selDatoLibero.Close;
  grdReperibili.Visible:=True;
end;

procedure TW006FListaReperibili.IWAppFormRender(Sender: TObject);
begin
  inherited;
  edtDal.Text:=DateToStr(Dal);
  edtAl.Text:=DateToStr(Al);
end;

procedure TW006FListaReperibili.grdReperibiliRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  RenderCell(ACell,ARow,AColumn,True,True);
end;

procedure TW006FListaReperibili.grdReperibiliCellClick(ASender: TObject; const ARow, AColumn: Integer);
var
  Matricola:String;
begin
  if ARow = 0 then
    OrdinaselAnagrafe(UpperCase(grdReperibili.Cell[0,AColumn].Text))
  else
  begin
    Matricola:=grdReperibili.Cell[ARow,0].Text;
    WC002FDatiAnagraficiFM:=TWC002FDatiAnagraficiFM.Create(Self);
    WC002FDatiAnagraficiFM.ParMatricola:=Matricola;
    WC002FDatiAnagraficiFM.AllowClick:=True;
    WC002FDatiAnagraficiFM.VisualizzaScheda;
  end;
end;

procedure TW006FListaReperibili.OrdinaselAnagrafe(Campo:String);
var S:String;
    P:Integer;
begin
  if Campo = 'BADGE' then
    Campo:='T430BADGE'
  else if Campo = 'NOME' then
    Campo:='COGNOME,NOME,MATRICOLA'
  else if Campo = 'DATA' then
    Campo:='DATA,COGNOME,NOME,MATRICOLA'
  else if Campo <> 'MATRICOLA' then
    Campo:=VarToStr(WR000DM.cdsI010.Lookup('NOME_LOGICO',Campo,'NOME_CAMPO')) + ',COGNOME,NOME,MATRICOLA';
  S:=selAnagrafe.SQL.Text;
  P:=Pos('ORDER BY',S);
  if P > 0 then
    Delete(S,P,Length(S));
  S:=S + ' ORDER BY ' + Campo;
  selAnagrafe.SQL.Text:=S;
  btnEseguiClick(nil);
end;

procedure TW006FListaReperibili.grdReperibiliHTMLTag(ASender: TObject;
  ATag: TIWHTMLTag);
begin
  inherited;
  if ATag.Tag = 'a' then
  begin
    ATag.AddStringParam('class','menu');
  end;
end;

procedure TW006FListaReperibili.DistruggiOggetti;
begin
  if CampiAggiuntivi <> nil then
    FreeAndNil(CampiAggiuntivi);

  if selAnagrafe <> nil then
    FreeAndNil(selAnagrafe);

  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    R180CloseDataSetTag0(WR000DM.selT350);
  end;
end;

end.
