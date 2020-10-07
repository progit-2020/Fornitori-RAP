unit A100UImpRimborsiIter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin, Grids, DBGrids,
  A000UInterfaccia, OracleData, System.UITypes,
  C005UDatiAnagrafici, C180FunzioniGenerali, C700USelezioneAnagrafe,
  R001UGESTTAB, ExtCtrls, StdCtrls, DBCtrls, Mask, Buttons, System.Actions;

type
  TA100FImpRimborsiIter = class(TR001FGestTab)
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    DBEdit8: TDBEdit;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    Label19: TLabel;
    DBEdit19: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    lblSedeLavoro: TLabel;
    lblComuneRes: TLabel;
    btnAccediCartellino: TToolButton;
    actCartellinoInterattivo: TAction;
    btn1: TToolButton;
    btnCartellinoInterattivo: TToolButton;
    dedtSedeLavoro: TDBEdit;
    dedtComuneRes: TDBEdit;
    tabInfoDettaglio: TPageControl;
    tbsDatiLiberi: TTabSheet;
    tbsMezzi: TTabSheet;
    tbsDettaglioGG: TTabSheet;
    dgrdMotivazioni: TDBGrid;
    dgrdMezzi: TDBGrid;
    dgrdDettaglioGG: TDBGrid;
    dedtComuneDom: TDBEdit;
    lblComuneDom: TLabel;
    spl1: TSplitter;
    pnl1: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit18: TDBEdit;
    DBMemo1: TDBMemo;
    DBComboBox1: TDBComboBox;
    btnSalvaModifiche: TBitBtn;
    btnAnnullaModifiche: TBitBtn;
    btnConfermaRimborsi: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSalvaModificheClick(Sender: TObject);
    procedure btnAnnullaModificheClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure btnConfermaRimborsiClick(Sender: TObject);
    procedure actCartellinoInterattivoExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A100FImpRimborsiIter: TA100FImpRimborsiIter;

implementation

uses A100UMissioniDtM, A100UMISSIONI, A023UTimbrature;

{$R *.dfm}

procedure TA100FImpRimborsiIter.actCartellinoInterattivoExecute(
  Sender: TObject);
begin
  inherited;
  A100FMissioni.frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  //BugFix: Utente: CUNEO_ASLCN1 Chiamata: 82071
  OpenA023Timbrature(A100FMISSIONIdtm.selM150.FieldByName('PROGRESSIVO').AsInteger,A100FMISSIONIdtm.selM150.FieldByName('DATADA').AsDateTime);
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  A100FMissioni.frmSelAnagrafe.RipristinaC00SelAnagrafe(A100FMISSIONIDTM.A100FMissioniMW);
end;

procedure TA100FImpRimborsiIter.btnAnnullaModificheClick(Sender: TObject);
begin
  inherited;
  A100FMissioniDtM.selM150.CancelUpdates;
  btnSalvaModifiche.Enabled:=False;
  btnAnnullaModifiche.Enabled:=False;
  A100FMissioniDtM.selM150.Refresh;
end;

procedure TA100FImpRimborsiIter.btnConfermaRimborsiClick(Sender: TObject);
begin
  inherited;
  A100FMissioniDtM.A100FImpRimborsiIterMW.ConfermaTuttiRimborsi;
end;

procedure TA100FImpRimborsiIter.btnSalvaModificheClick(Sender: TObject);
begin
  inherited;
  SessioneOracle.ApplyUpdates([A100FMissioniDtM.selM150],True);
  btnSalvaModifiche.Enabled:=False;
  btnAnnullaModifiche.Enabled:=False;
  A100FMissioniDtM.selM150.Refresh;
end;

procedure TA100FImpRimborsiIter.DButtonStateChange(Sender: TObject);
begin
  inherited;
  btnSalvaModifiche.Enabled:=TOracleDataSet(DButton.DataSet).UpdatesPending;
  btnAnnullaModifiche.Enabled:=TOracleDataSet(DButton.DataSet).UpdatesPending;
end;

procedure TA100FImpRimborsiIter.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if A100FMissioniDtM.selM150.UpdatesPending then
    case MessageDlg('Attenzione!' + #13#10 +
                    'Sono state apportate delle modifiche senza confermarle.' + #13#10 +
                    'Salvare le modifiche?',
                    mtConfirmation,[mbYes,mbNo,mbCancel],0,mbCancel) of
      mrYes:SessioneOracle.ApplyUpdates([A100FMissioniDtM.selM150],True);
      mrNo:A100FMissioniDtM.selM150.CancelUpdates;
      mrCancel:Action:=caNone;
    end;
end;

procedure TA100FImpRimborsiIter.FormCreate(Sender: TObject);
begin
  inherited;

  // CUNEO_ASLCN1 - commessa: 2013/107 SVILUPPO#1.ini
  // gestione del percorso
  A100FMissioniDtM.A100FMissioniMW.SelM041.Close;
  A100FMissioniDtM.A100FMissioniMW.SelM041.ClearVariables;
  A100FMissioniDtM.A100FMissioniMW.SelM041.Open;
  // CUNEO_ASLCN1 - commessa: 2013/107 SVILUPPO#1.fine

  dgrdMotivazioni.DataSource:=A100FMissioniDtM.A100FImpRimborsiIterMW.dsrM175;
  dgrdMezzi.DataSource:=A100FMissioniDtM.A100FImpRimborsiIterMW.dsrM170;
  // CUNEO_ASLCN1 - chiamata 88143.ini
  dgrdDettaglioGG.DataSource:=A100FMissioniDtM.A100FImpRimborsiIterMW.dsrM143;
  // CUNEO_ASLCN1 - chiamata 88143.fine

  //Caratto 06/03/2014 reset delle varibili dei dataset delle griglie
  //se entro con dei valori, poi riaccedo senza dipendenti rimanevano con i vecchi valori
  A100FMissioniDtM.A100FImpRimborsiIterMW.ResetDatasetFigli;

  A100FMissioniDtM.selM150.Close;
  C700MergeSelAnagrafe(A100FMissioniDtM.selM150);
  C700MergeSettaPeriodo(A100FMissioniDtM.selM150,Parametri.DataLavoro,Parametri.DataLavoro);
  A100FMissioniDtM.selM150.Open;
  DButton.DataSet:=A100FMissioniDtM.selM150;
end;

procedure TA100FImpRimborsiIter.Stampa1Click(Sender: TObject);
begin
  QueryStampa.Clear;
  QueryStampa.Add('select');
  QueryStampa.Add('  T3.TIPO_RICHIESTA,');
  QueryStampa.Add('  T6.COGNOME||'' ''||T6.NOME NOMINATIVO,');
  QueryStampa.Add('  T6.MATRICOLA,');
  QueryStampa.Add('  T1.ID,');
  QueryStampa.Add('  T1.PROTOCOLLO,');
  QueryStampa.Add('  decode(T1.FLAG_DESTINAZIONE,''R'',''Italia'',''I'',''Italia'',''Estero'') DESTINAZIONE,');
  QueryStampa.Add('  T1.FLAG_ISPETTIVA,');
  // CUNEO_ASLCN1 - commessa: 2013/107 SVILUPPO#1.ini
  // gestione del percorso
  //QueryStampa.Add('  T1.LOCALITA,');
  QueryStampa.Add('  T1.PARTENZA,');
  QueryStampa.Add('  T1.DESTINAZIONE,');
  QueryStampa.Add('  T1.RIENTRO,');
  // CUNEO_ASLCN1 - commessa: 2013/107 SVILUPPO#1.fine
  QueryStampa.Add('  T1.DATADA,');
  QueryStampa.Add('  T1.DATAA,');
  QueryStampa.Add('  T1.ORADA,');
  QueryStampa.Add('  T1.ORAA,');
  QueryStampa.Add('  T2.CODICE,');
  QueryStampa.Add('  T2.INDENNITA_KM,');
  QueryStampa.Add('  decode(T2.INDENNITA_KM,''S'',T5.DESCRIZIONE,T4.DESCRIZIONE) DESCRIZIONE,');
  QueryStampa.Add('  T2.KMPERCORSI,');
  QueryStampa.Add('  T2.KMPERCORSI_VARIATO,');
  QueryStampa.Add('  T2.RIMBORSO,');
  QueryStampa.Add('  T2.COD_VALUTA,');
  QueryStampa.Add('  T2.RIMBORSO_VARIATO,');
  QueryStampa.Add('  T2.STATO,');
  QueryStampa.Add('  T2.NOTE');
  QueryStampa.Add('from');
  QueryStampa.Add('  M140_RICHIESTE_MISSIONI T1, M150_RICHIESTE_RIMBORSI T2, T850_ITER_RICHIESTE T3,');
  QueryStampa.Add('  M020_TIPIRIMBORSI T4, M021_TIPIINDENNITAKM T5,');
  QueryStampa.Add('  T030_ANAGRAFICO T6');
  QueryStampa.Add('where T6.PROGRESSIVO = T1.PROGRESSIVO');
  QueryStampa.Add('and T3.ITER = ''M140''');
  QueryStampa.Add('and T3.ID = T1.ID');
  QueryStampa.Add('and T3.TIPO_RICHIESTA = ''5''');
  QueryStampa.Add('and T2.ID = T1.ID');
  QueryStampa.Add('and T2.STATO = ''A''');
  QueryStampa.Add('and T4.CODICE(+) = T2.CODICE');
  QueryStampa.Add('and T5.CODICE(+) = T2.CODICE');
  QueryStampa.Add('and trunc(sysdate) between T5.DECORRENZA(+) and T5.DECORRENZA_FINE(+)');
  QueryStampa.Add('order by T1.DATAA,T1.PROTOCOLLO');

  NomiCampiR001.Add('T3.TIPO_RICHIESTA');
  NomiCampiR001.Add('T6.COGNOME||'' ''||T6.NOME NOMINATIVO');
  NomiCampiR001.Add('T6.MATRICOLA');
  NomiCampiR001.Add('T1.ID');
  NomiCampiR001.Add('T1.PROTOCOLLO');
  NomiCampiR001.Add('decode(T1.FLAG_DESTINAZIONE,''R'',''Italia'',''I'',''Italia'',''Estero'') DESTINAZIONE');
  NomiCampiR001.Add('T1.FLAG_ISPETTIVA');
  // CUNEO_ASLCN1 - commessa: 2013/107 SVILUPPO#1.ini
  // gestione del percorso
  //NomiCampiR001.Add('T1.LOCALITA');
  NomiCampiR001.Add('T1.PARTENZA');
  NomiCampiR001.Add('T1.DESTINAZIONE');
  NomiCampiR001.Add('T1.RIENTRO');
  // CUNEO_ASLCN1 - commessa: 2013/107 SVILUPPO#1.fine
  NomiCampiR001.Add('T1.DATADA');
  NomiCampiR001.Add('T1.DATAA');
  NomiCampiR001.Add('T1.ORADA');
  NomiCampiR001.Add('T1.ORAA');
  NomiCampiR001.Add('T2.CODICE');
  NomiCampiR001.Add('T2.INDENNITA_KM');
  NomiCampiR001.Add('decode(T2.INDENNITA_KM,''S'',T5.DESCRIZIONE,T4.DESCRIZIONE) DESCRIZIONE');
  NomiCampiR001.Add('T2.KMPERCORSI');
  NomiCampiR001.Add('T2.KMPERCORSI_VARIATO');
  NomiCampiR001.Add('T2.RIMBORSO');
  NomiCampiR001.Add('T2.COD_VALUTA');
  NomiCampiR001.Add('T2.RIMBORSO_VARIATO');
  NomiCampiR001.Add('T2.STATO');
  NomiCampiR001.Add('T2.NOTE');
  inherited;
end;

end.
