unit Ac01UProgettiRendiProj;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, StdCtrls, ComCtrls,
  ToolWin, Grids, DBGrids, DBCtrls, Buttons, Mask,
  C180FunzioniGenerali, A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi,
  A003UDataLavoroBis, Oracle, OracleData, ToolbarFiglio, Math, StrUtils,
  ExtCtrls, C013UCheckList, C015UElencoValori, System.Actions, C600USelAnagrafe;

type
  TAc01FProgettiRendiProj = class(TR004FGestStorico)
    pnlTestata: TPanel;
    lblProgetto: TLabel;
    lblDescrizione: TLabel;
    dedtProgetto: TDBEdit;
    dedtDescrizione: TDBEdit;
    dmemNote: TDBMemo;
    lblNote: TLabel;
    lblId: TLabel;
    dedtId: TDBEdit;
    lblOreMax: TLabel;
    dedtOreMax: TDBEdit;
    PageControl1: TPageControl;
    tshAttivita: TTabSheet;
    pnlDettAtt: TPanel;
    frmToolbarFiglioAtt: TfrmToolbarFiglio;
    tshDipendenti: TTabSheet;
    lblDecorrenzaFine: TLabel;
    dedtDecorrenzaFine: TDBEdit;
    pnlDettDip: TPanel;
    frmToolbarFiglioDip: TfrmToolbarFiglio;
    dgrdAttivita: TDBGrid;
    dgrdDipendenti: TDBGrid;
    lblTotOreAssegnato: TLabel;
    dedtTotOreAssegnato: TDBEdit;
    lblTotOreFruito: TLabel;
    dedtTotOreFruito: TDBEdit;
    pmnDip: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    tshTask: TTabSheet;
    pnlDettTas: TPanel;
    frmToolbarFiglioTas: TfrmToolbarFiglio;
    dgrdTask: TDBGrid;
    pnlRiepilogo: TPanel;
    lblTitRiepOreMax: TLabel;
    lblTitRiepTotOreMax: TLabel;
    lblTitRiepCod: TLabel;
    lblTitRiepDesc: TLabel;
    dedtRiepCod: TDBEdit;
    dedtRiepDesc: TDBEdit;
    dedtRiepOreMax: TDBEdit;
    dedtRiepTotOreMax: TDBEdit;
    dsrRiep: TDataSource;
    pmnTas: TPopupMenu;
    DuplicaTask: TMenuItem;
    N1: TMenuItem;
    DuplicaDipendente: TMenuItem;
    grpPeriodoChiusura: TGroupBox;
    lblChiusuraDal: TLabel;
    lblChiusuraAl: TLabel;
    dedtChiusuraDal: TDBEdit;
    dedtChiusuraAl: TDBEdit;
    btnChiusuraDal: TButton;
    btnChiusuraAl: TButton;
    dedtCauAssPresIncluse: TDBEdit;
    btnCauAssPresIncluse: TButton;
    lblCauAssPresIncluse: TLabel;
    pmnCau: TPopupMenu;
    RiportaCausali: TMenuItem;
    lblNominativoResp: TLabel;
    dedtNominativoResp: TDBEdit;
    lblReportingPeriod: TLabel;
    lblPartnerNumber: TLabel;
    dedtPartnerNumber: TDBEdit;
    btnReportingPeriod: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DButtonStateChange(Sender: TObject);
    procedure btnCauAssPresIncluseClick(Sender: TObject);
    procedure pmnCauPopup(Sender: TObject);
    procedure RiportaCausaliClick(Sender: TObject);
    procedure btnChiusuraDalClick(Sender: TObject);
    procedure dedtChiusuraDalDblClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure pmnTasPopup(Sender: TObject);
    procedure DuplicaTaskClick(Sender: TObject);
    procedure pmnDipPopup(Sender: TObject);
    procedure DuplicaDipendenteClick(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure frmToolbarFiglioAttactTFCancellaExecute(Sender: TObject);
    procedure frmToolbarFiglioAttactTFAnnullaExecute(Sender: TObject);
    procedure frmToolbarFiglioAttactTFConfermaExecute(Sender: TObject);
    procedure frmToolbarFiglioTasactTFCancellaExecute(Sender: TObject);
    procedure frmToolbarFiglioTasactTFAnnullaExecute(Sender: TObject);
    procedure frmToolbarFiglioTasactTFConfermaExecute(Sender: TObject);
    procedure frmToolbarFiglioDipactTFInserisciExecute(Sender: TObject);
    procedure frmToolbarFiglioDipactTFModificaExecute(Sender: TObject);
    procedure frmToolbarFiglioDipactTFCancellaExecute(Sender: TObject);
    procedure frmToolbarFiglioDipactTFAnnullaExecute(Sender: TObject);
    procedure frmToolbarFiglioDipactTFConfermaExecute(Sender: TObject);
    procedure frmToolbarFiglioAttactTFInserisciExecute(Sender: TObject);
    procedure frmToolbarFiglioAttactTFModificaExecute(Sender: TObject);
    procedure frmToolbarFiglioTasactTFInserisciExecute(Sender: TObject);
    procedure frmToolbarFiglioTasactTFModificaExecute(Sender: TObject);
    procedure dgrdDipendentiEditButtonClick(Sender: TObject);
    procedure btnReportingPeriodClick(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AbilitaComponenti;
    procedure AggiornaRiepilogo;
    procedure AggiornaColoreRiepilogo;
  end;

var
  Ac01FProgettiRendiProj: TAc01FProgettiRendiProj;

procedure OpenAc01FProgettiRendiProj;

implementation

uses Ac01UProgettiRendiProjDtM, Ac01UPropIndRendiProj, Ac01UReportingPeriodRendiProj, Ac02ULimitiRendiProj;

{$R *.dfm}

procedure OpenAc01FProgettiRendiProj;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenAc01FProgettiRendiProj') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TAc01FProgettiRendiProj, Ac01FProgettiRendiProj);
  Application.CreateForm(TAc01FProgettiRendiProjDtM, Ac01FProgettiRendiProjDtM);
  try
    Screen.Cursor:=crDefault;
    Ac01FProgettiRendiProj.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    Ac01FProgettiRendiProj.Free;
    Ac01FProgettiRendiProjDtM.Free;
  end;
end;

procedure TAc01FProgettiRendiProj.FormCreate(Sender: TObject);
begin
  inherited;
  TStringGrid(dgrdAttivita).Options:=TStringGrid(dgrdAttivita).Options-[goColMoving];
  TStringGrid(dgrdTask).Options:=TStringGrid(dgrdTask).Options-[goColMoving];
  TStringGrid(dgrdDipendenti).Options:=TStringGrid(dgrdDipendenti).Options-[goColMoving];
end;

procedure TAc01FProgettiRendiProj.FormShow(Sender: TObject);
var Cod:String;
begin
  inherited;
  PageControl1.TabIndex:=0;
  dsrRiep.DataSet:=Ac01FProgettiRendiProjDtM.Ac01MW.cdsRiep;
  //Attività
  dgrdAttivita.DataSource:=Ac01FProgettiRendiProjDtM.Ac01MW.dsrT751;
  frmToolbarFiglioAtt.TFDButton:=Ac01FProgettiRendiProjDtM.Ac01MW.dsrT751;
  frmToolbarFiglioAtt.TFDBGrid:=dgrdAttivita;
  frmToolbarFiglioAtt.RefreshDopoPost:=True;
  SetLength(frmToolbarFiglioAtt.lstLock,6);
  (*frmToolbarFiglioAtt.tlbarFiglio.HandleNeeded;//necessario per XE3
  //Per gestire i pulsanti quando CachedUpdate:=False; (si considera lo state della singola riga invece che tutta l'operazione di inserimento/modifica)
  Ac01FProgettiRendiProjDtM.Ac01MW.dsrT751.OnStateChange:=frmToolbarFiglioAtt.DButtonStateChange;*)
  frmToolbarFiglioAtt.lstLock[0]:=ToolBar1;
  frmToolbarFiglioAtt.lstLock[1]:=grbDecorrenza;
  frmToolbarFiglioAtt.lstLock[2]:=File1;
  frmToolbarFiglioAtt.lstLock[3]:=Strumenti1;
  //frmToolbarFiglioAtt.lstLock[4]:=frmToolbarFiglioTas;
  //frmToolbarFiglioAtt.lstLock[5]:=frmToolbarFiglioDip;
  frmToolbarFiglioAtt.lstLock[4]:=tshTask;
  frmToolbarFiglioAtt.lstLock[5]:=tshDipendenti;
  frmToolbarFiglioAtt.AbilitaAzioniTF(nil);
  //Task
  dgrdTask.DataSource:=Ac01FProgettiRendiProjDtM.Ac01MW.dsrT752;
  frmToolbarFiglioTas.TFDButton:=Ac01FProgettiRendiProjDtM.Ac01MW.dsrT752;
  frmToolbarFiglioTas.TFDBGrid:=dgrdTask;
  frmToolbarFiglioTas.RefreshDopoPost:=True;
  SetLength(frmToolbarFiglioTas.lstLock,6);
  (*frmToolbarFiglioTas.tlbarFiglio.HandleNeeded;//necessario per XE3
  //Per gestire i pulsanti quando CachedUpdate:=False; (si considera lo state della singola riga invece che tutta l'operazione di inserimento/modifica)
  Ac01FProgettiRendiProjDtM.Ac01MW.dsrT752.OnStateChange:=frmToolbarFiglioTas.DButtonStateChange;*)
  frmToolbarFiglioTas.lstLock[0]:=ToolBar1;
  frmToolbarFiglioTas.lstLock[1]:=grbDecorrenza;
  frmToolbarFiglioTas.lstLock[2]:=File1;
  frmToolbarFiglioTas.lstLock[3]:=Strumenti1;
  //frmToolbarFiglioTas.lstLock[4]:=frmToolbarFiglioAtt;
  //frmToolbarFiglioTas.lstLock[5]:=frmToolbarFiglioDip;
  frmToolbarFiglioTas.lstLock[4]:=tshAttivita;
  frmToolbarFiglioTas.lstLock[5]:=tshDipendenti;
  frmToolbarFiglioTas.AbilitaAzioniTF(nil);
  //Dipendenti
  dgrdDipendenti.DataSource:=Ac01FProgettiRendiProjDtM.Ac01MW.dsrT753;
  frmToolbarFiglioDip.TFDButton:=Ac01FProgettiRendiProjDtM.Ac01MW.dsrT753;
  frmToolbarFiglioDip.TFDBGrid:=dgrdDipendenti;
  frmToolbarFiglioDip.RefreshDopoPost:=True;
  SetLength(frmToolbarFiglioDip.lstLock,6);
  (*frmToolbarFiglioDip.tlbarFiglio.HandleNeeded;//necessario per XE3
  //Per gestire i pulsanti quando CachedUpdate:=False; (si considera lo state della singola riga invece che tutta l'operazione di inserimento/modifica)
  Ac01FProgettiRendiProjDtM.Ac01MW.dsrT753.OnStateChange:=frmToolbarFiglioDip.DButtonStateChange;*)
  frmToolbarFiglioDip.lstLock[0]:=ToolBar1;
  frmToolbarFiglioDip.lstLock[1]:=grbDecorrenza;
  frmToolbarFiglioDip.lstLock[2]:=File1;
  frmToolbarFiglioDip.lstLock[3]:=Strumenti1;
  //frmToolbarFiglioDip.lstLock[4]:=frmToolbarFiglioAtt;
  //frmToolbarFiglioDip.lstLock[5]:=frmToolbarFiglioTas;
  frmToolbarFiglioDip.lstLock[4]:=tshAttivita;
  frmToolbarFiglioDip.lstLock[5]:=tshTask;
  frmToolbarFiglioDip.AbilitaAzioniTF(nil);
  //Posizionamento sul periodo corrente
  with Ac01FProgettiRendiProjDtM.Ac01MW.selT750 do
  begin
    Cod:=FieldByName('CODICE').AsString;
    while (FieldByName('CODICE').AsString = Cod) and not Eof do
    begin
      if (Parametri.DataLavoro >= FieldByName('DECORRENZA').AsDateTime)
      and (Parametri.DataLavoro <= FieldByName('DECORRENZA_FINE').AsDateTime) then
        Break;
      Next;
    end;
    RefreshRecord;
  end;
  AbilitaComponenti;
end;

procedure TAc01FProgettiRendiProj.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if not ToolBar1.Enabled then
    Action:=caNone;
end;

procedure TAc01FProgettiRendiProj.DButtonStateChange(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TAc01FProgettiRendiProj.btnCauAssPresIncluseClick(Sender: TObject);
begin
  if DButton.State in [dsEdit,dsInsert] then
  begin
    C013FCheckList:=TC013FCheckList.Create(nil);
    try
      C013FCheckList.clbListaDati.Items.Clear;
      with Ac01FProgettiRendiProjDtM.Ac01MW.selCauIncluse do
      begin
        First;
        while not Eof do
        begin
          C013FCheckList.clbListaDati.Items.Add(Format('%-5s %-40s %-s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString,FieldByName('TIPO').AsString]));
          Next;
        end;
      end;
      R180PutCheckList(dedtCauAssPresIncluse.Field.AsString,5,C013FCheckList.clbListaDati);
      if C013FCheckList.ShowModal = mrOK then
        dedtCauAssPresIncluse.Field.AsString:=R180GetCheckList(5,C013FCheckList.clbListaDati);
    finally
      C013FCheckList.Free;
    end;
  end;
end;

procedure TAc01FProgettiRendiProj.pmnCauPopup(Sender: TObject);
begin
  RiportaCausali.Enabled:=(Ac01FProgettiRendiProjDtM.Ac01MW.selT750.RecordCount > 0)
                           and (DButton.State = dsBrowse)
                           and not frmToolbarFiglioAtt.actTFConferma.Enabled
                           and not frmToolbarFiglioTas.actTFConferma.Enabled
                           and not frmToolbarFiglioDip.actTFConferma.Enabled;
end;

procedure TAc01FProgettiRendiProj.RiportaCausaliClick(Sender: TObject);
begin
  inherited;
  with Ac01FProgettiRendiProjDtM.Ac01MW do
  begin
    RecuperaProgetti;
    C013FCheckList:=TC013FCheckList.Create(nil);
    with C013FCheckList do
    try
      while not selbT750.Eof do
      begin
        clbListaDati.Items.Add(Format('%-20s %-10s-%-10s %-100s %s',[selbT750.FieldByName('Codice').AsString,selbT750.FieldByName('Decorrenza').AsString,selbT750.FieldByName('Decorrenza_Fine').AsString,selbT750.FieldByName('Descrizione').AsString,selbT750.FieldByName('CauAssPres_Incluse').AsString]));
        selbT750.Next;
      end;
      R180PutCheckList(lstCodPro.CommaText,31,C013FCheckList.clbListaDati);
      if ShowModal = mrOK then
      begin
        lstCodPro.CommaText:=R180GetCheckList(31,C013FCheckList.clbListaDati);
        RiportaCausali;
      end;
    finally
      Release;
    end;
  end;
end;

procedure TAc01FProgettiRendiProj.TAnnullaClick(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TAc01FProgettiRendiProj.btnChiusuraDalClick(Sender: TObject);
var NomeCampo,Titolo:String;
begin
  NomeCampo:=IfThen((Sender as TButton).Name = 'btnChiusuraDal','CHIUSURA_DAL','CHIUSURA_AL');
  Titolo:=IfThen(NomeCampo = 'CHIUSURA_DAL','Data inizio periodo','Data fine periodo');
  with Ac01FProgettiRendiProjDtM.Ac01MW do
  begin
    if selT750.FieldByName(NomeCampo).IsNull then
    begin
      if NomeCampo = 'CHIUSURA_DAL' then
        selT750.FieldByName(NomeCampo).AsDateTime:=selT750.FieldByName('DECORRENZA').AsDateTime
      else
        selT750.FieldByName(NomeCampo).AsDateTime:=Parametri.DataLavoro;
    end;
    selT750.FieldByName(NomeCampo).AsDateTime:=DataOut(selT750.FieldByName(NomeCampo).AsDateTime,Titolo,'G');
  end;
end;

procedure TAc01FProgettiRendiProj.btnReportingPeriodClick(Sender: TObject);
var Ac01FReportingPeriodRendiProj:TAc01FReportingPeriodRendiProj;
begin
  Ac01FProgettiRendiProjDtM.Ac01MW.selT756.ReadOnly:=not (DButton.State in [dsEdit]);
  Ac01FProgettiRendiProjDtM.Ac01MW.selT756.Refresh;
  Ac01FReportingPeriodRendiProj:=TAc01FReportingPeriodRendiProj.Create(nil);
  try
    Ac01FReportingPeriodRendiProj.ShowModal;
  finally
    Ac01FReportingPeriodRendiProj.Free;
    btnReportingPeriod.Font.Color:=IfThen(Ac01FProgettiRendiProjDtM.Ac01MW.ControllaReportingPeriod <> '',clRed,clGreen);
  end;
end;

procedure TAc01FProgettiRendiProj.dedtChiusuraDalDblClick(Sender: TObject);
var NomeCampo:String;
begin
  NomeCampo:=IfThen((Sender as TDBEdit).Name = 'dedtChiusuraDal','CHIUSURA_DAL','CHIUSURA_AL');
  with Ac01FProgettiRendiProjDtM.Ac01MW do
    if selT750.FieldByName(NomeCampo).IsNull then
    begin
      if NomeCampo = 'CHIUSURA_DAL' then
        selT750.FieldByName(NomeCampo).AsDateTime:=selT750.FieldByName('DECORRENZA').AsDateTime
      else
        selT750.FieldByName(NomeCampo).AsDateTime:=selT750.FieldByName('DECORRENZA_FINE').AsDateTime;
    end;
end;

procedure TAc01FProgettiRendiProj.PageControl1Change(Sender: TObject);
begin
  AggiornaRiepilogo;
end;

procedure TAc01FProgettiRendiProj.pmnTasPopup(Sender: TObject);
begin
  DuplicaTask.Enabled:=(Ac01FProgettiRendiProjDtM.Ac01MW.selT752.RecordCount > 0) and not frmToolbarFiglioTas.actTFConferma.Enabled;
end;

procedure TAc01FProgettiRendiProj.DuplicaTaskClick(Sender: TObject);
begin
  inherited;
  with Ac01FProgettiRendiProjDtM.Ac01MW do
  begin
    RecuperaAttivita;
    C013FCheckList:=TC013FCheckList.Create(nil);
    with C013FCheckList do
    try
      while not selbT751.Eof do
      begin
        clbListaDati.Items.Add(Format('%-10s %-12s %s',[selbT751.FieldByName('Codice').AsString,'(' + selbT751.FieldByName('Ore_Inseribili').AsString + ')',selbT751.FieldByName('Descrizione').AsString]));
        selbT751.Next;
      end;
      R180PutCheckList(lstCodAtt.CommaText,10,C013FCheckList.clbListaDati);
      if ShowModal = mrOK then
      begin
        lstCodAtt.CommaText:=R180GetCheckList(10,C013FCheckList.clbListaDati);
        DuplicaTask;
      end;
    finally
      Release;
    end;
  end;
end;

procedure TAc01FProgettiRendiProj.pmnDipPopup(Sender: TObject);
begin
  DuplicaDipendente.Enabled:=(Ac01FProgettiRendiProjDtM.Ac01MW.selT753.RecordCount > 0) and not frmToolbarFiglioDip.actTFConferma.Enabled;
  Nuovoelemento1.Enabled:=(Ac01FProgettiRendiProjDtM.Ac01MW.selT753.RecordCount > 0) and not frmToolbarFiglioDip.actTFConferma.Enabled;
end;

procedure TAc01FProgettiRendiProj.DuplicaDipendenteClick(Sender: TObject);
begin
  inherited;
  with Ac01FProgettiRendiProjDtM.Ac01MW do
  begin
    RecuperaTask;
    C013FCheckList:=TC013FCheckList.Create(nil);
    with C013FCheckList do
    try
      while not selbT752.Eof do
      begin
        clbListaDati.Items.Add(Format('%-10s %-10s %-12s %s',[selbT752.FieldByName('C_Att').AsString,selbT752.FieldByName('C_Tas').AsString,'(' + selbT752.FieldByName('Ore_Inseribili').AsString + ')',selbT752.FieldByName('D_Tas').AsString]));
        selbT752.Next;
      end;
      R180PutCheckList(lstCodTas.CommaText,21,C013FCheckList.clbListaDati);
      if ShowModal = mrOK then
      begin
        lstCodTas.CommaText:=R180GetCheckList(21,C013FCheckList.clbListaDati);
        DuplicaDipendente;
      end;
    finally
      Release;
    end;
  end;
end;

procedure TAc01FProgettiRendiProj.Nuovoelemento1Click(Sender: TObject);
begin
  with Ac01FProgettiRendiProjDtM.Ac01MW.selT753 do
    OpenAc02FLimitiRendiProj(FieldByName('PROGRESSIVO').AsInteger,FieldByName('ID_T752').AsInteger,FieldByName('DECORRENZA').AsDateTime);
end;

procedure TAc01FProgettiRendiProj.frmToolbarFiglioAttactTFCancellaExecute(Sender: TObject);
begin
  frmToolbarFiglioAtt.actTFCancellaExecute(Sender);
  AbilitaComponenti;
end;

procedure TAc01FProgettiRendiProj.frmToolbarFiglioAttactTFAnnullaExecute(Sender: TObject);
begin
  frmToolbarFiglioAtt.actTFAnnullaExecute(Sender);
  AggiornaRiepilogo;
end;

procedure TAc01FProgettiRendiProj.frmToolbarFiglioAttactTFConfermaExecute(Sender: TObject);
begin
  frmToolbarFiglioAtt.actTFConfermaExecute(Sender);
  Ac01FProgettiRendiProjDtM.Ac01MW.selT751.Refresh;
  Ac01FProgettiRendiProjDtM.Ac01MW.selT752.Refresh;
  AbilitaComponenti;
end;

procedure TAc01FProgettiRendiProj.frmToolbarFiglioAttactTFInserisciExecute(Sender: TObject);
begin
  Ac01FProgettiRendiProjDtM.Ac01MW.CaricaListaCod(Ac01FProgettiRendiProjDtM.Ac01MW.selT751);
  frmToolbarFiglioAtt.actTFInserisciExecute(Sender);
end;

procedure TAc01FProgettiRendiProj.frmToolbarFiglioAttactTFModificaExecute(Sender: TObject);
begin
  Ac01FProgettiRendiProjDtM.Ac01MW.CaricaListaCod(Ac01FProgettiRendiProjDtM.Ac01MW.selT751);
  frmToolbarFiglioAtt.actTFModificaExecute(Sender);
end;

procedure TAc01FProgettiRendiProj.frmToolbarFiglioTasactTFCancellaExecute(Sender: TObject);
begin
  frmToolbarFiglioTas.actTFCancellaExecute(Sender);
  AbilitaComponenti;
end;

procedure TAc01FProgettiRendiProj.frmToolbarFiglioTasactTFAnnullaExecute(Sender: TObject);
begin
  frmToolbarFiglioTas.actTFAnnullaExecute(Sender);
  AggiornaRiepilogo;
end;

procedure TAc01FProgettiRendiProj.frmToolbarFiglioTasactTFConfermaExecute(Sender: TObject);
begin
  frmToolbarFiglioTas.actTFConfermaExecute(Sender);
  AbilitaComponenti;
end;

procedure TAc01FProgettiRendiProj.frmToolbarFiglioTasactTFInserisciExecute(Sender: TObject);
begin
  Ac01FProgettiRendiProjDtM.Ac01MW.CaricaListaCod(Ac01FProgettiRendiProjDtM.Ac01MW.selT752);
  frmToolbarFiglioTas.actTFInserisciExecute(Sender);
end;

procedure TAc01FProgettiRendiProj.frmToolbarFiglioTasactTFModificaExecute(Sender: TObject);
begin
  Ac01FProgettiRendiProjDtM.Ac01MW.CaricaListaCod(Ac01FProgettiRendiProjDtM.Ac01MW.selT752);
  frmToolbarFiglioTas.actTFModificaExecute(Sender);
end;

procedure TAc01FProgettiRendiProj.frmToolbarFiglioDipactTFInserisciExecute(Sender: TObject);
begin
  Ac01FProgettiRendiProjDtM.Ac01MW.CaricaDettDip;
  frmToolbarFiglioDip.actTFInserisciExecute(Sender);
end;

procedure TAc01FProgettiRendiProj.frmToolbarFiglioDipactTFModificaExecute(Sender: TObject);
begin
  Ac01FProgettiRendiProjDtM.Ac01MW.CaricaDettDip;
  frmToolbarFiglioDip.actTFModificaExecute(Sender);
end;

procedure TAc01FProgettiRendiProj.frmToolbarFiglioDipactTFCancellaExecute(Sender: TObject);
begin
  frmToolbarFiglioDip.actTFCancellaExecute(Sender);
  AbilitaComponenti;
end;

procedure TAc01FProgettiRendiProj.frmToolbarFiglioDipactTFAnnullaExecute(Sender: TObject);
begin
  frmToolbarFiglioDip.actTFAnnullaExecute(Sender);
  with Ac01FProgettiRendiProjDtM.Ac01MW do
    if selT754.UpdatesPending then
    begin
      SessioneOracle.CancelUpdates([selT754]);
      selT753.RefreshRecord;
    end;
  AggiornaRiepilogo;
end;

procedure TAc01FProgettiRendiProj.frmToolbarFiglioDipactTFConfermaExecute(Sender: TObject);
begin
  frmToolbarFiglioDip.actTFConfermaExecute(Sender);
  with Ac01FProgettiRendiProjDtM.Ac01MW do
    if selT754.UpdatesPending then
    begin
      SessioneOracle.ApplyUpdates([selT754],True);
      selT753.RefreshRecord;
    end;
  AbilitaComponenti;
end;

procedure TAc01FProgettiRendiProj.dgrdDipendentiEditButtonClick(Sender: TObject);
var Ac01FPropIndRendiProj:TAc01FPropIndRendiProj;
begin
  if not frmToolbarFiglioDip.actTFConferma.Enabled then
    exit;
  if Ac01FProgettiRendiProjDtM.Ac01MW.selT753.FieldByName('PROGRESSIVO').AsInteger = 0 then
    exit;
  Ac01FPropIndRendiProj:=TAc01FPropIndRendiProj.Create(nil);
  try
    Ac01FPropIndRendiProj.ShowModal;
  finally
    Ac01FPropIndRendiProj.Free;
  end;
end;

procedure TAc01FProgettiRendiProj.AbilitaComponenti;
begin
  with Ac01FProgettiRendiProjDtM.Ac01MW do
  begin
    if selT750.Active then
    begin
      if selT750.State = dsBrowse then
        selT750.RefreshRecord;
      btnReportingPeriod.Enabled:=Ac01FProgettiRendiProjDtM.Ac01MW.selT750.FieldByName('ID').AsInteger > 0;
      btnReportingPeriod.Font.Color:=IfThen(ControllaReportingPeriod <> '',clRed,clGreen);
      btnCauAssPresIncluse.Enabled:=DButton.State <> dsBrowse;
      btnChiusuraDal.Enabled:=DButton.State <> dsBrowse;
      btnChiusuraAl.Enabled:=DButton.State <> dsBrowse;
      pnlDettAtt.Enabled:=(DButton.State = dsBrowse) and (selT750.RecordCount > 0);
      if frmToolbarFiglioAtt.TFDButton <> nil then
        frmToolbarFiglioAtt.AbilitaAzioniTF(nil);
    end;
    if selT751.Active then
    begin
      if selT751.State = dsBrowse then
        selT751.RefreshRecord;
      pnlDettTas.Enabled:=(DButton.State = dsBrowse) and (selT751.RecordCount > 0);
      if frmToolbarFiglioTas.TFDButton <> nil then
        frmToolbarFiglioTas.AbilitaAzioniTF(nil);
    end;
    if selT752.Active then
    begin
      if selT752.State = dsBrowse then
        selT752.RefreshRecord;
      pnlDettDip.Enabled:=(DButton.State = dsBrowse) and (selT752.RecordCount > 0);
      if frmToolbarFiglioDip.TFDButton <> nil then
        frmToolbarFiglioDip.AbilitaAzioniTF(nil);
    end;
  end;
  AggiornaRiepilogo;
end;

procedure TAc01FProgettiRendiProj.AggiornaRiepilogo;
var ODSAgg,ODSMod:TOracleDataSet;
begin
  lblTitRiepCod.Caption:=IfThen(PageControl1.TabIndex = 0,'Progetto',IfThen(PageControl1.TabIndex = 1,'Attività','Attività/Task'));
  with Ac01FProgettiRendiProjDtM.Ac01MW do
    if PageControl1.TabIndex = 0 then
    begin
      ODSAgg:=selT750;
      ODSMod:=selT751;
    end
    else if PageControl1.TabIndex = 1 then
    begin
      ODSAgg:=selT751;
      ODSMod:=selT752;
    end
    else
    begin
      ODSAgg:=selT752;
      ODSMod:=selT753;
    end;
  with Ac01FProgettiRendiProjDtM.Ac01MW,cdsRiep do
  begin
    EmptyDataSet;
    Append;
    if ODSAgg.Active then
    begin
      FieldByName('CODICE').AsString:=ODSAgg.FieldByName('CODICE').AsString;
      if (ODSAgg = selT752) and not selT751.FieldByName('CODICE').IsNull then
        FieldByName('CODICE').AsString:=selT751.FieldByName('CODICE').AsString + '/' + FieldByName('CODICE').AsString;
      FieldByName('DESCRIZIONE').AsString:=ODSAgg.FieldByName('DESCRIZIONE').AsString;
      FieldByName('ORE_MAX').AsString:=Trim(ODSAgg.FieldByName('ORE_MAX').AsString);
      FieldByName('TOT_ORE_MAX').AsString:=Trim(ODSAgg.FieldByName('TOT_ORE_MAX').AsString);
    end;
    Post;
  end;
  AggiornaColoreRiepilogo;
  if ODSMod.Active and ODSMod.UpdatesPending then
    Ac01FProgettiRendiProjDtM.Ac01MW.ModificaRiepilogo(ODSMod);
end;

procedure TAc01FProgettiRendiProj.AggiornaColoreRiepilogo;
begin
  with Ac01FProgettiRendiProjDtM.Ac01MW.cdsRiep do
    dedtRiepTotOreMax.Font.Color:=IfThen(R180OreMinuti(FieldByName('TOT_ORE_MAX').AsString) > R180OreMinuti(FieldByName('ORE_MAX').AsString),clRed,
                                  IfThen(R180OreMinuti(FieldByName('TOT_ORE_MAX').AsString) = R180OreMinuti(FieldByName('ORE_MAX').AsString),clGreen,clWindowText));
end;

end.
