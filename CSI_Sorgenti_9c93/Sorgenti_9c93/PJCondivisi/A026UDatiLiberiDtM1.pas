unit A026UDatiLiberiDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, RegistrazioneLog, OracleData, Oracle, Variants,
  A000UCostanti, A000USessione, A000UInterfaccia, A026UDatiLiberiMW,
  C180FunzioniGenerali, USelI010,A000UMessaggi;

type
  TA026FDatiLIberiDtM1 = class(TDataModule)
    D500: TDataSource;
    I500: TOracleDataSet;
    I500NomeCampo: TStringField;
    I500Progressivo: TFloatField;
    I500TABELLA: TStringField;
    I500LUNGHEZZA: TFloatField;
    Q500: TOracleDataSet;
    Q500Tipo: TOracleDataSet;
    selT033: TOracleDataSet;
    I500FORMATO: TStringField;
    I500STORICO: TStringField;
    I500LUNG_DESC: TFloatField;
    I500SCADENZA: TStringField;
    procedure I500NewRecord(DataSet: TDataSet);
    procedure I500BeforePost(DataSet: TDataSet);
    procedure BDEI500NomeCampoValidate(Sender: TField);
    procedure A026FDatiLIberiDtM1Create(Sender: TObject);
    procedure I500BeforeDelete(DataSet: TDataSet);
    procedure I500AfterDelete(DataSet: TDataSet);
    procedure A026FDatiLIberiDtM1Destroy(Sender: TObject);
    procedure I500AfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    TSLavoro,TSIndici:String;
    procedure ScriviStatusBar(S:String);
    procedure ResettaProgressBar;
    procedure IncrementaProgressBar;
    procedure MaxProgressBar(i:Integer);
  public
    { Public declarations }
    Ricostruzione:Boolean;
    A026FDatiLiberiMW:TA026FDatiLiberiMW;
  end;

var
  A026FDatiLIberiDtM1: TA026FDatiLIberiDtM1;

implementation

uses A026UDatiLiberi;

{$R *.DFM}

procedure TA026FDatiLIberiDtM1.A026FDatiLIberiDtM1Create(Sender: TObject);
var i:Integer;
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
    begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
    if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
    end;
  I500.Open;
  TSLavoro:=Parametri.TSLavoro;
  TSIndici:=Parametri.TSIndici;
  Ricostruzione:=False;
  A026FDatiLiberiMW:=TA026FDatiLiberiMW.Create(nil);
  A026FDatiLiberiMW.ScriviStatusBar:=ScriviStatusBar;
  A026FDatiLiberiMW.ResettaProgressBar:=ResettaProgressBar;
  A026FDatiLiberiMW.IncrementaProgressBar:=IncrementaProgressBar;
  A026FDatiLiberiMW.MaxProgressBar:=MaxProgressBar;
  A026FDatiLiberiMW.DS:=I500;
end;

procedure TA026FDatiLIberiDtM1.I500NewRecord(DataSet: TDataSet);
{Imposto i dati di default}
begin
  I500.FieldByName('Tabella').AsString:='S';
  I500.FieldByName('Formato').AsString:='S';
  I500.FieldByName('STORICO').AsString:='N';
  I500.FieldByName('SCADENZA').AsString:='N';
end;

procedure TA026FDatiLIberiDtM1.BDEI500NomeCampoValidate(Sender: TField);
{Controllo che il nome del campo sia un identificatore valido}
begin
  if not IsValidIdent(Sender.AsString) then
    raise Exception.Create('Il nome dato contiene caratteri non permessi: correggere!');
  A026FDatiLiberiMW.VerificaNomeCampoAnagrafico;
end;

procedure TA026FDatiLIberiDtM1.I500BeforePost(DataSet: TDataSet);
{Aggiungo campo nuovo su T430_Storico e creo la tabella corrispondente}
begin
  A026FDatiLiberiMW.A026Decorrenza:=A026FDatiLiberi.edtDecorrenza.Text;
  A026FDatiLiberiMW.A026NomePagina:=A026FDatiLiberi.cbxNOMEPAGINA.Text;
  if I500.FieldByName('LUNGHEZZA').AsInteger < 1 then //Lorena 17/05/2005
    raise Exception.Create('E'' richiesta la dimensione del dato!');
  if Trim(A026FDatiLiberi.cbxNOMEPAGINA.Text) = '' then
    raise Exception.Create('E'' richiesto il Nome Pagina!');
  //Se sto modificando i collegamenti eseguo una procedura a parte
  A026FDatiLiberiMW.selT033B.Close;
  A026FDatiLiberiMW.selT033B.SetVariable('CampoDb',I500NomeCampo.AsString);
  A026FDatiLiberiMW.selT033B.Open;
  //Se il campo non è tabellare annullo la lunghezza della descrizione
  if I500.FieldByName('TABELLA').AsString = 'N' then
    I500.FieldByName('LUNG_DESC').AsInteger:=0
  else
    if I500.FieldByName('LUNG_DESC').AsInteger <= 0 then
      raise Exception.Create('La dimensione della descrizione del dato deve essere maggiore di zero');
  //Modifica dei dati
  if I500.State = dsEdit then
  begin
    if I500.FieldByName('Tabella').medpOldValue <> I500.FieldByName('Tabella').Value then
      A026FDatiLiberiMW.ModificaTabellare(I500.FieldByName('NOMECAMPO').AsString,I500.FieldByName('Tabella').AsString);
    if (I500.FieldByName('Formato').AsString = 'S') and
       (I500.FieldByName('Lunghezza').medpOldValue <> I500.FieldByName('Lunghezza').Value) then
    begin
      if I500.FieldByName('Lunghezza').medpOldValue > I500.FieldByName('Lunghezza').Value then
        if MessageDlg(A000MSG_A026_DLG_DIMINIZ,mtConfirmation,[mbYes,mbNo],0) = mrNo then
          Abort;
      A026FDatiLiberiMW.ModificaColonna(I500.FieldByName('NOMECAMPO').AsString,I500.FieldByName('Lunghezza').AsInteger)
    end;
    if (I500.FieldByName('TABELLA').AsString = 'S') and
       (I500.FieldByName('LUNG_DESC').medpOldValue <> I500.FieldByName('LUNG_DESC').Value) then
    begin
      if I500.FieldByName('LUNG_DESC').medpOldValue > I500.FieldByName('LUNG_DESC').Value then
        if MessageDlg(A000MSG_A026_DLG_DIMINIZ_DESC,mtConfirmation,[mbYes,mbNo],0) = mrNo then
          Abort;
      A026FDatiLiberiMW.ModificaLungDesc;
    end;
    A026FDatiLiberiMW.ModificaPagina;
    if A026FDatiLiberiMW.ModificaLinkStorico then
    begin
      SessioneOracle.Commit;
      RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
      Exit;
    end
    else
    begin
      SessioneOracle.Rollback;
      raise Exception.Create('Modifiche fallite!');
    end;
  end;
  //Dimensione del nuovo dato
  if MessageDlg('Confermi l''inserimento di questo nuovo dato anagrafico?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
    Abort;
  A026FDatiLiberiMW.InserisciDatoLibero;
  RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA026FDatiLiberiDtM1.ScriviStatusBar(S:String);
begin
  A026FDatiLiberi.StatusBar.Panels[2].Text:=S;
  A026FDatiLiberi.StatusBar.Refresh;
end;

procedure TA026FDatiLIberiDtM1.I500BeforeDelete(DataSet: TDataSet);
{Cancellazione dato libero}
begin
  try
    A026FDatiLiberiMW.selI091.SetVariable('AZIENDA',Parametri.Azienda);
    A026FDatiLiberiMW.selI091.Open;
  except
  end;
  if A026FDatiLiberiMW.selI091.Active and A026FDatiLiberiMW.selI091.SearchRecord('DATO',I500.FieldByName('NomeCampo').AsString,[srFromBeginning]) then
    if MessageDlg(Format(A000MSG_A026_DLG_FMT_CANCELLA,[A026FDatiLiberiMW.selI091.FieldByName('TIPO').AsString]),
                  mtConfirmation,[mbYes,mbNo],0) <> mrYes then
      Abort;
  if MessageDlg(A000MSG_A026_DLG_CANCELLA,
                mtConfirmation,[mbYes,mbNo],0) <> mrYes then
    Abort;

  Screen.Cursor:=crHourGlass;
  try
    A026FDatiLiberiMW.EliminaDatoLibero;
    RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  finally
    ScriviStatusBar('');
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA026FDatiLIberiDtM1.I500AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  A026FDatiLiberiMW.CostruisciV430;
  A026FDatiLiberi.Close;
  Ricostruzione:=True;
  R180MessageBox('Cancellazione avvenuta correttamente',INFORMA);
end;

procedure TA026FDatiLIberiDtM1.I500AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  A026FDatiLiberiMW.CostruisciV430;
  Ricostruzione:=True;
end;

procedure TA026FDatiLIberiDtM1.ResettaProgressBar;
begin
  A026FDatiLiberi.ProgressBar1.Position:=0;
end;

procedure TA026FDatiLIberiDtM1.IncrementaProgressBar;
begin
  A026FDatiLiberi.ProgressBar1.StepBy(1);
end;

procedure TA026FDatiLIberiDtM1.MaxProgressBar(i:Integer);
begin
  A026FDatiLiberi.ProgressBar1.Max:=i;
end;

procedure TA026FDatiLIberiDtM1.A026FDatiLIberiDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  FreeAndNil(A026FDatiLiberiMW);
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

end.
