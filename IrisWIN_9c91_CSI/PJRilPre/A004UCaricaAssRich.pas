unit A004UCaricaAssRich;

interface

uses
  A004UGiustifAssPresMW,
  A004UGiustifAssPres, A083UMsgElaborazioni,
  A000UCostanti, A000USessione, A000UInterfaccia,
  C012UVisualizzaTesto, C180FunzioniGenerali, C700USelezioneAnagrafe,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, DBGrids, StdCtrls, Buttons,
  ExtCtrls, ActnList, ImgList, DB, ComCtrls, ToolWin,
  OracleData, Oracle, Math, StrUtils,
  R001UGESTTAB, Mask, System.Actions;

type
  TA004FCaricaAssRich = class(TR001FGestTab)
    Panel2: TPanel;
    btnImporta: TBitBtn;
    chkAnomalie: TCheckBox;
    btnVisualizzaLog: TBitBtn;
    dGrdAssenze: TDBGrid;
    PopupMenu1: TPopupMenu;
    Importaassenzacorrente1: TMenuItem;
    ProgressBar1: TProgressBar;
    grpPeriodo: TGroupBox;
    lblPeriodoDal: TLabel;
    edtPeriodoDal: TMaskEdit;
    lblPeriodoAl: TLabel;
    edtPeriodoAl: TMaskEdit;
    lblInizioDal: TLabel;
    edtInizioDal: TMaskEdit;
    lblInizioAl: TLabel;
    edtInizioAl: TMaskEdit;
    lblFineDal: TLabel;
    edtFineDal: TMaskEdit;
    lblFineAl: TLabel;
    edtFineAl: TMaskEdit;
    rgpModalita: TRadioGroup;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnImportaClick(Sender: TObject);
    procedure btnVisualizzaLogClick(Sender: TObject);
    procedure dGrdAssenzeEditButtonClick(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure rgpModalitaClick(Sender: TObject);
  private
    procedure AggiornaFiltroPeriodo;
  public
    A004MW: TA004FGiustifAssPresMW;
    procedure AggiornaProgresso;
  end;

var
  A004FCaricaAssRich: TA004FCaricaAssRich;
  procedure OpenA004CaricaAssRich(PA004MW: TA004FGiustifAssPresMW);

implementation

{$R *.dfm}

procedure OpenA004CaricaAssRich(PA004MW: TA004FGiustifAssPresMW);
begin
  if not Assigned(PA004MW) then
    raise Exception.Create('Indicare il datamodulo middleware per l''elaborazione!');

  try
    A004FCaricaAssRich:=TA004FCaricaAssRich.Create(nil);
    A004FCaricaAssRich.A004MW:=PA004MW; //***
    A004FCaricaAssRich.chkAnomalie.Checked:=A004FCaricaAssRich.A004MW.AnomalieInterattive;
    A004FCaricaAssRich.ShowModal;
    A004FCaricaAssRich.A004MW.AnomalieInterattive:=A004FCaricaAssRich.chkAnomalie.Checked;
  finally
    FreeAndNil(A004FCaricaAssRich);
  end;
end;

procedure TA004FCaricaAssRich.FormShow(Sender: TObject);
begin
  inherited;

  //Spostato dal Create
  // disattiva filtro dizionario su dataset per controlli assenze - 11.07.2011
  DButton.DataSet:=A004MW.selT050;

  A004MW.Q265.OnFilterRecord:=nil;
  A004MW.Q275.OnFilterRecord:=nil;
  if A004MW.Q265.Active then
    A004MW.Q265.Refresh;
  if A004MW.Q275.Active then
    A004MW.Q275.Refresh;

  C700MergeSelAnagrafe(A004MW.selT050,False);
  C700MergeSettaPeriodo(A004MW.selT050,Parametri.DataLavoro,Parametri.DataLavoro);
  A004MW.selT050.SetVariable('AZIENDA',Parametri.Azienda);
  A004MW.selT050.SetVariable('HINTT030V430',Parametri.CampiRiferimento.C26_HintT030V430);
  rgpModalitaClick(nil);
  A004MW.selT050.Close;
  A004MW.selT050.Open;
  AggiornaProgresso; // selT050_AfterOpen
end;

procedure TA004FCaricaAssRich.FormDestroy(Sender: TObject);
begin
  // disattiva filtro dizionario su dataset per controlli assenze - 11.07.2011
  A004MW.Q265.OnFilterRecord:=A004MW.FiltroDizionario;
  A004MW.Q275.OnFilterRecord:=A004MW.FiltroDizionario;

  A004MW.selT050.Close;
  inherited;
end;

procedure TA004FCaricaAssRich.rgpModalitaClick(Sender: TObject);
var
  Elab: String;
begin
  if rgpModalita.ItemIndex = 0 then
  begin
    // richieste nuove: cancella periodo intersezione
    edtPeriodoDal.Clear;
    edtPeriodoAl.Clear;
  end
  else
  begin
    // richieste già elaborate: imposta default per periodo di intersezione
    if edtPeriodoDal.Text = '  /  /    ' then
      edtPeriodoDal.Text:=FormatDateTime('dd/mm/yyyy',Date);
    if edtPeriodoAl.Text = '  /  /    ' then
      edtPeriodoAl.Text:=FormatDateTime('dd/mm/yyyy',Date);
  end;

  // pulisce periodo inizio - fine
  edtInizioDal.Clear;
  edtInizioAl.Clear;
  edtFineDal.Clear;
  edtFineAl.Clear;

  Elab:=IfThen(rgpModalita.ItemIndex = 0,'N','E');
  R180SetVariable(A004MW.selT050,'FILTRO_MODALITA',Format('and t050.elaborato = ''%s''',[Elab]));
  AggiornaFiltroPeriodo;
  A004MW.selT050.Open;
  AggiornaProgresso; // selT050_AfterOpen
end;

procedure TA004FCaricaAssRich.actRefreshExecute(Sender: TObject);
var
  ID: String;
begin
  AggiornaFiltroPeriodo;

  if A004MW.selT050.Active then
    inherited
  else
  begin
    ID:=A004MW.selT050.RowID;
    A004MW.selT050.Open;
    AggiornaProgresso; // selT050_AfterOpen
     if ID <> '' then
       A004MW.selT050.Locate('RowID',ID,[]);
  end;
end;

procedure TA004FCaricaAssRich.AggiornaFiltroPeriodo;
var
  IntersezDal,IntersezAl,
  InizioDal,InizioAl,
  FineDal,FineAl: TDateTime;
  IntersezPeriodo,InizioPeriodo,FinePeriodo,Periodo: String;
  function IsDataNulla(const PData: String): Boolean;
  begin
    Result:=(Trim(PData) = '') or (PData = '  /  /    ');
  end;
begin
  // periodo 1/3: intersezione dal - al
  if IsDataNulla(edtPeriodoDal.Text) and IsDataNulla(edtPeriodoAl.Text) then
  begin
    // periodo vuoto
    IntersezPeriodo:='';
  end
  else
  begin
    // una delle date è indicata
    if not TryStrToDate(edtPeriodoDal.Text,IntersezDal) then
      raise Exception.Create('Data inizio del periodo di intersezione non valida!');
    if not TryStrToDate(edtPeriodoAl.Text,IntersezAl) then
      raise Exception.Create('Data fine del periodo di intersezione non valida!');
    if IntersezDal > IntersezAl then
      raise Exception.Create('Il periodo di intersezione indicato non è valido!');
    IntersezPeriodo:=Format('and t050.al >= to_date(''%s'',''dd/mm/yyyy'') and t050.dal <= to_date(''%s'',''dd/mm/yyyy'')',[FormatDateTime('dd/mm/yyyy',IntersezDal),FormatDateTime('dd/mm/yyyy',IntersezAl)]);
  end;

  // periodo 2/3: inizio richieste
  if IsDataNulla(edtInizioDal.Text) and IsDataNulla(edtInizioAl.Text) then
  begin
    // periodo vuoto
    InizioPeriodo:='';
  end
  else
  begin
    // una delle date è indicata
    if not TryStrToDate(edtInizioDal.Text,InizioDal) then
      raise Exception.Create('Data di "Inizio dal" non valida!');
    if not TryStrToDate(edtInizioAl.Text,InizioAl) then
      raise Exception.Create('Data di "Inizio al" non valida!');
    if InizioDal > InizioAl then
      raise Exception.Create('Il periodo di inizio indicato non è valido!');
    InizioPeriodo:=Format('and t050.dal between to_date(''%s'',''dd/mm/yyyy'') and to_date(''%s'',''dd/mm/yyyy'')',[FormatDateTime('dd/mm/yyyy',InizioDal),FormatDateTime('dd/mm/yyyy',InizioAl)]);
  end;

  // periodo 3/3: fine richieste
  if IsDataNulla(edtFineDal.Text) and IsDataNulla(edtFineAl.Text) then
  begin
    // periodo vuoto
    FinePeriodo:='';
  end
  else
  begin
    // una delle date è indicata
    if not TryStrToDate(edtFineDal.Text,FineDal) then
      raise Exception.Create('Data di "Fine dal" non valida!');
    if not TryStrToDate(edtFineAl.Text,FineAl) then
      raise Exception.Create('Data di "Fine al" non valida!');
    if FineDal > FineAl then
      raise Exception.Create('Il periodo di fine indicato non è valido!');
    FinePeriodo:=Format('and t050.al between to_date(''%s'',''dd/mm/yyyy'') and to_date(''%s'',''dd/mm/yyyy'')',[FormatDateTime('dd/mm/yyyy',FineDal),FormatDateTime('dd/mm/yyyy',FineAl)]);
  end;

  // compone il filtro periodo complessivo
  Periodo:=Trim(IntersezPeriodo + ' ' + InizioPeriodo + ' ' + FinePeriodo);

  // la modalità rielaborazione richiede che sia specificato almeno un filtro
  if (rgpModalita.ItemIndex = 1) and (Periodo = '') then
    raise Exception.Create('E'' necessario specificare almeno un filtro sul periodo per la rielaborazione delle richieste');

  R180SetVariable(A004MW.selT050,'FILTRO_PERIODO',Periodo);
end;

procedure TA004FCaricaAssRich.AggiornaProgresso;
begin
  NumRecords;
  Self.Repaint;
end;

procedure TA004FCaricaAssRich.btnImportaClick(Sender: TObject);
var
  Singola,Ok: Boolean;
  Errore,Msg: String;
  NumScartate: Integer;
begin
  if A004MW.selT050.RecordCount = 0 then
  begin
    R180MessageBox('Nessuna richiesta da importare',INFORMA);
    Exit;
  end;

  // determina se l'importazione è singola oppure massiva
  Singola:=Sender <> btnImporta;
  if not Singola then
  begin
    // importazione completa
    if R180MessageBox('Confermi l''importazione di tutte le richieste visualizzate?',DOMANDA) <> mrYes then
      Exit;
  end;

  // avvio elaborazione
  Screen.Cursor:=crHourGlass;

  // per richiesta singola la progressbar non ha senso
  {
  if not Singola then
    A004FGiustifAssPresDtM1.ProgressBar:=ProgressBar1;
  }

  // acquisizione delle richieste di giustificativo su cartellino
  Errore:='';
  Ok:=A004MW.AcquisizioneRichiesteWeb(Singola,chkAnomalie.Checked,Errore,NumScartate,rgpModalita.ItemIndex = 0);

  // riapre il dataset delle richieste
  A004MW.selT050.Close;
  A004MW.selT050.Open;
  AggiornaProgresso; // selT050_AfterOpen

  // fine elaborazione
  Screen.Cursor:=crDefault;

  // messaggio di fine elaborazione
  if Ok then
  begin
    // elaborazione ok / warning
    if Errore = '' then
      Msg:='Elaborazione terminata correttamente'
    else if (Errore <> '') and Singola then
      Msg:='Elaborazione terminata con avvertimenti:' + #13#10 + Errore
    else if NumScartate > 0 then
    begin
      Msg:='Elaborazione terminata correttamente' + CRLF +
           'Alcune richieste non sono state considerate per i seguenti motivi:' + Errore;
    end;
    R180MessageBox(Msg,INFORMA);
  end
  else
  begin
    // anomalie durante elaborazione
    if R180MessageBox('Elaborazione terminata con errori.'#13#10'Si desidera visualizzarli?',DOMANDA) = mrYes then
      btnVisualizzaLogClick(nil);
  end;
end;

procedure TA004FCaricaAssRich.btnVisualizzaLogClick(Sender: TObject);
begin
  inherited;
  A004FGiustifAssPres.frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A004','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(A004MW.SessioneOracleA004);
  A004FGiustifAssPres.frmSelAnagrafe.RipristinaC00SelAnagrafe;
end;

procedure TA004FCaricaAssRich.dGrdAssenzeEditButtonClick(Sender: TObject);
var s:TStringList;
begin
  inherited;
  s:=TStringList.Create;
  try
    if dGrdAssenze.SelectedIndex = 12 then
    begin
      s.Text:=A004MW.GetNoteRichiesta(A004MW.selT050.FieldByName('ID').AsInteger);
      OpenC012VisualizzaTesto('Visualizzazione Note della Richiesta','',s);
    end;
  finally
    FreeAndNil(s);
  end;
end;

end.
