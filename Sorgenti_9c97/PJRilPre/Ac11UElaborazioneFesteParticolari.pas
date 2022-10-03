unit Ac11UElaborazioneFesteParticolari;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Menus,
  Buttons, DBCtrls, StdCtrls, ExtCtrls, checklst, ComCtrls, Datasnap.DBClient,
  DB, OracleData, Variants, Mask, Spin, Math, StrUtils,
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi,
  A003UDataLavoroBis, A083UMsgElaborazioni, Ac11UElaborazioneFesteParticolariMW,
  C001StampaLib, C004UParamForm, C005UDatiAnagrafici, C180FunzioniGenerali,
  C700USelezioneAnagrafe, RegistrazioneLog, SelAnagrafe;

type
  TAc11FElaborazioneFesteParticolari = class(TForm)
    ProgressBar1: TProgressBar;
    StatusBar: TStatusBar;
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    btnEsegui: TBitBtn;
    btnAnomalie: TBitBtn;
    clbFeste: TCheckListBox;
    pmnFiltroDati: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    Label1: TLabel;
    sedtAnno: TSpinEdit;
    lblFeste: TLabel;
    Panel3: TPanel;
    chkGeneraDettA: TCheckBox;
    chkGeneraDettM: TCheckBox;
    chkApplicaScelte: TCheckBox;
    chkCancellaDettA: TCheckBox;
    chkControllaScelte: TCheckBox;
    btnInformazioni: TBitBtn;
    gbxDipObblTimb: TGroupBox;
    dcbxDatoDipObblTimb: TDBLookupComboBox;
    edtValoreDipObblTimb: TEdit;
    lblDatoDipObblTimb: TLabel;
    lblValoreDipObblTimb: TLabel;
    frmSelAnagrafe: TfrmSelAnagrafe;
    chkSvuotaScelte: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure sedtAnnoChange(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure chkGeneraDettAClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure dcbxDatoDipObblTimbKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
  private
    { Private declarations }
    wTipo,TestoStatusBar:String;
    wData:TDateTime;
    OldGeneraDettAChecked:Boolean;
    Ac11MW: TAc11FElaborazioneFesteParticolariMW;
    procedure GetParametriFunzione;
    procedure GetParametriFunzione2;
    procedure PutParametriFunzione;
    procedure RicaricaListaFesteSel;
    procedure RicaricaClbFeste;
    procedure CicloElaborazione;
    procedure IniziaProgressBar(nMax:Integer;FA:String);
    procedure AvanzaProgressBar;
  public
    procedure AbilitaComponenti;
    { Public declarations }
  end;

var
  Ac11FElaborazioneFesteParticolari: TAc11FElaborazioneFesteParticolari;

procedure OpenAc11FElaborazioneFesteParticolari(Prog:LongInt;Tipo:String;Data:TDateTime);

implementation

{$R *.DFM}

procedure OpenAc11FElaborazioneFesteParticolari(Prog:LongInt;Tipo:String;Data:TDateTime);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenAc11FElaborazioneFesteParticolari') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Ac11FElaborazioneFesteParticolari:=TAc11FElaborazioneFesteParticolari.Create(nil);
  with Ac11FElaborazioneFesteParticolari do
    try
      C700Progressivo:=Prog;
      wTipo:=Tipo;
      wData:=Data;
      Ac11MW.Anno:=R180Anno(Data);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Free;
    end;
end;

procedure TAc11FElaborazioneFesteParticolari.FormCreate(Sender: TObject);
begin
  Ac11MW:=TAc11FElaborazioneFesteParticolariMW.Create(nil);
  Ac11MW.evIniziaProgressBar:=IniziaProgressBar;
  Ac11MW.evAvanzaProgressBar:=AvanzaProgressBar;
end;

procedure TAc11FElaborazioneFesteParticolari.FormShow(Sender: TObject);
var i:Integer;
begin
  CreaC004(SessioneOracle,'Ac11',Parametri.ProgOper);
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(Ac11MW,SessioneOracle,StatusBar,0,False);
  if Ac11MW.Anno = 0 then
    Ac11MW.Anno:=R180Anno(Parametri.DataLavoro);
  sedtAnno.Value:=Ac11MW.Anno;
  btnAnomalie.Enabled:=False;
  btnInformazioni.Enabled:=False;
  Ac11MW.RecuperaFesteAnno;
  OldGeneraDettAChecked:=False;
  GetParametriFunzione;
  //Carico in clbFeste l'elenco delle festività appena recuperato, eventualmente selezionandole
  RicaricaClbFeste;
  //Seleziono le festività di clbFeste in base al salvataggio precedente
  GetParametriFunzione2;
  //Allineo la lista delle festività selezionate in base al clbFeste
  RicaricaListaFesteSel;
  //Se sono richiamato dall'esterno...
  if wTipo <> '' then
  begin
    //Cancello la lista delle festività selezionate
    for i:=0 to clbFeste.Items.Count - 1 do
      clbFeste.Checked[i]:=False;
    //Seleziono la festività richiamata
    if Ac11MW.selListaFeste.SearchRecord('TIPO_FESTIVITA;DATA_FESTIVITA',VarArrayOf([wTipo,wData]),[srFromBeginning]) then
      clbFeste.Checked[Ac11MW.selListaFeste.RecNo - 1]:=True;
    //Allineo la lista delle festività selezionate in base al clbFeste
    RicaricaListaFesteSel;
  end;
  AbilitaComponenti;
end;

procedure TAc11FElaborazioneFesteParticolari.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TAc11FElaborazioneFesteParticolari.FormDestroy(Sender: TObject);
begin
  Ac11MW.Free;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TAc11FElaborazioneFesteParticolari.GetParametriFunzione;
{Leggo i parametri della form}
begin
  chkGeneraDettA.Checked:=C004FParamForm.GetParametro('chkGeneraDettA','N') = 'S';
  chkGeneraDettM.Checked:=C004FParamForm.GetParametro('chkGeneraDettM','N') = 'S';
  chkCancellaDettA.Checked:=C004FParamForm.GetParametro('chkCancellaDettA','N') = 'S';
  chkApplicaScelte.Checked:=C004FParamForm.GetParametro('chkApplicaScelte','N') = 'S';
  chkControllaScelte.Checked:=C004FParamForm.GetParametro('chkControllaScelte','N') = 'S';
  chkSvuotaScelte.Checked:=C004FParamForm.GetParametro('chkSvuotaScelte','N') = 'S';
  dcbxDatoDipObblTimb.KeyValue:=C004FParamForm.GetParametro('dcbxDatoDipObblTimb','');
  edtValoreDipObblTimb.Text:=C004FParamForm.GetParametro('edtValoreDipObblTimb','');
end;

procedure TAc11FElaborazioneFesteParticolari.GetParametriFunzione2;
{Leggo i parametri della form}
var x,y,i:integer;
    e: boolean;
    sValore,sNome,sElemento:string;
begin
  //lettura date-tipi selezionati
  x:=0; //contatore di paramento
  sNome:='clbFeste';
  repeat
    //ciclo sui parametri clbFeste0,clbFeste1,ecc.
    sValore:=C004FParamForm.GetParametro(sNome + IntToStr(x),'');
    y:=0; //contatore di elementi nel parametro
    if sValore <> '' then
    begin
      repeat
        //ciclo sugli elementi nel parametro
        sElemento:=Copy(sValore,(y * 7) + 1,7);
        if sElemento <> '' then
        begin
          i:=0;
          e:=true;
          while (i < clbFeste.Items.Count) and (e) do
          begin
            if Copy(clbFeste.Items[i],1,7) = sElemento then
            begin
              clbFeste.Checked[i]:=true;
              e:=false;
            end
            (*else if Copy(clbFeste.Items[i],1,7) > sElemento then
              e:=false*);
            inc(i);
          end;
          inc(y);
        end;
      until sElemento = '';
      inc(x);
    end;
  until sValore = '';
end;

procedure TAc11FElaborazioneFesteParticolari.PutParametriFunzione;
{Scrivo i parametri della forma}
var i,x,y:integer;
    sValore,sNome:string;
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('chkGeneraDettA',IfThen(chkGeneraDettA.Checked,'S','N'));
  C004FParamForm.PutParametro('chkGeneraDettM',IfThen(chkGeneraDettM.Checked,'S','N'));
  C004FParamForm.PutParametro('chkCancellaDettA',IfThen(chkCancellaDettA.Checked,'S','N'));
  C004FParamForm.PutParametro('chkApplicaScelte',IfThen(chkApplicaScelte.Checked,'S','N'));
  C004FParamForm.PutParametro('chkControllaScelte',IfThen(chkControllaScelte.Checked,'S','N'));
  C004FParamForm.PutParametro('chkSvuotaScelte',IfThen(chkSvuotaScelte.Checked,'S','N'));
  C004FParamForm.PutParametro('dcbxDatoDipObblTimb',VarToStr(dcbxDatoDipObblTimb.KeyValue));
  C004FParamForm.PutParametro('edtValoreDipObblTimb',edtValoreDipObblTimb.Text);
  //salvo l'elenco di tipi-festività selezionati
  x:=0; //contatore parametri tipi-festività
  y:=0; //contatore elementi per parametro
  sValore:='';
  sNome:='clbFeste';
  for i:=1 to clbFeste.Items.Count do
    if clbFeste.Checked[i-1] then
    begin
       sValore:=sValore + Copy(clbFeste.Items[i-1],1,7);
       inc(y);
       if y = 90 then
       begin
          C004FParamForm.PutParametro(sNome + IntToStr(x),sValore);
          inc(x);
          y:=0;
          sValore:='';
       end;
    end;
  C004FParamForm.PutParametro(sNome + IntToStr(x),sValore);
  try SessioneOracle.Commit; except end;
end;

procedure TAc11FElaborazioneFesteParticolari.RicaricaListaFesteSel;
var i:Integer;
begin
  Ac11MW.ListaFesteSel.Clear;
  for i:=0 to clbFeste.Items.Count - 1 do
    if clbFeste.Checked[i] then
      Ac11MW.ListaFesteSel.Add(clbFeste.Items[i]);
end;

procedure TAc11FElaborazioneFesteParticolari.RicaricaClbFeste;
var i:Integer;
begin
  //Carico in clbFeste l'elenco delle festività appena recuperato
  clbFeste.Items.Clear;
  for i:=0 to Ac11MW.ListaFeste.Count - 1 do
    clbFeste.Items.Add(Ac11MW.ListaFeste[i]);
  //Seleziono le festività in clbFeste
  for i:=0 to clbFeste.Items.Count - 1 do
    clbFeste.Checked[i]:=Ac11MW.ListaFesteSel.IndexOf(clbFeste.Items[i]) >= 0;
end;

procedure TAc11FElaborazioneFesteParticolari.AbilitaComponenti;
begin
  chkCancellaDettA.Enabled:=not chkGeneraDettA.Checked and not chkApplicaScelte.Checked and not chkControllaScelte.Checked and not chkSvuotaScelte.Checked;
  if chkGeneraDettA.Checked then
    chkCancellaDettA.Checked:=True  //il ciclo di generazione comprende la cancellazione dei record A
  else if OldGeneraDettAChecked then
    chkCancellaDettA.Checked:=False;
  chkGeneraDettA.Enabled:=(not chkCancellaDettA.Checked or chkGeneraDettA.Checked) and not chkApplicaScelte.Checked and not chkControllaScelte.Checked and not chkSvuotaScelte.Checked;
  chkGeneraDettM.Enabled:=chkGeneraDettA.Checked;
  if not chkGeneraDettM.Enabled then
    chkGeneraDettM.Checked:=False;
  chkApplicaScelte.Enabled:=not chkGeneraDettA.Checked and not chkCancellaDettA.Checked and not chkControllaScelte.Checked and not chkSvuotaScelte.Checked;
  chkControllaScelte.Enabled:=not chkGeneraDettA.Checked and not chkCancellaDettA.Checked and not chkApplicaScelte.Checked and not chkSvuotaScelte.Checked;
  chkSvuotaScelte.Enabled:=not chkGeneraDettA.Checked and not chkCancellaDettA.Checked and not chkApplicaScelte.Checked and not chkControllaScelte.Checked;
  gbxDipObblTimb.Enabled:=chkApplicaScelte.Checked or chkControllaScelte.Checked;
  lblDatoDipObblTimb.Enabled:=gbxDipObblTimb.Enabled;
  dcbxDatoDipObblTimb.Enabled:=gbxDipObblTimb.Enabled;
  lblValoreDipObblTimb.Enabled:=gbxDipObblTimb.Enabled;
  edtValoreDipObblTimb.Enabled:=gbxDipObblTimb.Enabled;
  btnEsegui.Enabled:=chkGeneraDettA.Checked or chkCancellaDettA.Checked or chkApplicaScelte.Checked or chkControllaScelte.Checked or chkSvuotaScelte.Checked;
  OldGeneraDettAChecked:=chkGeneraDettA.Checked; //per sapere quando avrò deselezionato la generazione
end;

procedure TAc11FElaborazioneFesteParticolari.sedtAnnoChange(Sender: TObject);
var Data:TDateTime;
begin
  if Length(sedtAnno.Text) = 4 then
  begin
    try
      Data:=StrToDate('01/01/' + sedtAnno.Text);
      if Ac11MW.Anno <> sedtAnno.Value then
      begin
        Ac11MW.Anno:=sedtAnno.Value;
        RicaricaListaFesteSel;
        Ac11MW.RecuperaFesteAnno;
        RicaricaClbFeste;
      end;
    except
      sedtAnno.SetFocus;
    end;
  end
  else
  begin
    sedtAnno.SetFocus;
  end;
end;

procedure TAc11FElaborazioneFesteParticolari.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  with (pmnFiltroDati.PopupComponent as TCheckListBox) do
    for i:=0 to Items.Count - 1 do
      if Sender = SelezionaTutto1 then
        Checked[i]:=True
      else if Sender = DeselezionaTutto1 then
        Checked[i]:=False
      else if Sender = InvertiSelezione1 then
        Checked[i]:=not Checked[i];
end;

procedure TAc11FElaborazioneFesteParticolari.chkGeneraDettAClick(Sender: TObject);
begin
  AbilitaComponenti;
end;

procedure TAc11FElaborazioneFesteParticolari.dcbxDatoDipObblTimbKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TAc11FElaborazioneFesteParticolari.btnEseguiClick(Sender: TObject);
begin
  with Ac11MW do
  begin
    RicaricaListaFesteSel;
    bGeneraDettA:=chkGeneraDettA.Checked;
    bGeneraDettM:=chkGeneraDettM.Checked;
    bCancellaDettA:=chkCancellaDettA.Checked
                    and not chkGeneraDettA.Checked;//il ciclo di generazione comprende la cancellazione dei record A
    bApplicaScelte:=chkApplicaScelte.Checked;
    bControllaScelte:=chkControllaScelte.Checked;
    bSvuotaScelte:=chkSvuotaScelte.Checked;
    sDatoDipObblTimb:=VarToStr(dcbxDatoDipObblTimb.KeyValue);
    sValoreDipObblTimb:=Trim(edtValoreDipObblTimb.Text);
    ControlliGen;
  end;
  btnAnomalie.Enabled:=False;
  btnInformazioni.Enabled:=False;
  try
    Screen.Cursor:=crHourGlass;
    ProgressBar1.Position:=0;
    RegistraMsg.IniziaMessaggio('Ac11');
    StatusBar.Panels[0].Text:='Inizializzazioni...';
    StatusBar.Repaint;
    Ac11MW.Inizializzazioni;
    CicloElaborazione;
    StatusBar.Panels[0].Text:='Finalizzazioni...';
    StatusBar.Repaint;
    Ac11MW.Finalizzazioni;
    SessioneOracle.Commit;
  finally
    StatusBar.Panels[0].Text:='';
    StatusBar.Repaint;
    ProgressBar1.Position:=0;
    Screen.Cursor:=crDefault;
  end;
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  btnInformazioni.Enabled:=RegistraMsg.ContieneTipoI;
  if btnAnomalie.Enabled then
  begin
    if (R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,'DOMANDA') = mrYes) then
      btnAnomalieClick(btnAnomalie);
  end
  else if btnInformazioni.Enabled then
  begin
    if (R180MessageBox(A000MSG_DLG_ELAB_SEGNALAZIONI_VIS,'DOMANDA') = mrYes) then
      btnAnomalieClick(btnInformazioni);
  end
  else
    R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,'INFORMA') ;
end;

procedure TAc11FElaborazioneFesteParticolari.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  if Sender = btnAnomalie then
    OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'Ac11','A,B')
  else
    OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'Ac11','I');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(Ac11MW);
end;

procedure TAc11FElaborazioneFesteParticolari.CicloElaborazione;
var n:Integer;
begin
  with Ac11MW do
    for n:=0 to ListaFesteSel.Count - 1 do
    begin
      RecuperaFestaSel(ListaFesteSel[n]);
      if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DataFesta,DataFesta) then
        C700SelAnagrafe.Close;
      C700SelAnagrafe.Open;
      C700SelAnagrafe.First;
      if bGeneraDettA then
        GeneraDett
      else if bCancellaDettA then //il ciclo di generazione comprende la cancellazione dei record
        CancellaDett
      else if bApplicaScelte then
        ApplicaScelte
      else if bControllaScelte then
        ControllaScelte
      else if bSvuotaScelte then
        SvuotaScelte;
    end;
end;

procedure TAc11FElaborazioneFesteParticolari.IniziaProgressBar(nMax:Integer;FA:String);
begin
  ProgressBar1.Max:=nMax;
  ProgressBar1.Position:=0;
  StatusBar.Panels[0].Text:='Elaborazione in corso di ' + Ac11MW.DescFesta + ' del ' + DateToStr(Ac11MW.DataFesta);
  if FA <> '' then
    StatusBar.Panels[0].Text:=StatusBar.Panels[0].Text + ' (Filtro anagrafe ' + FA + ')';
  StatusBar.Panels[0].Text:=StatusBar.Panels[0].Text + '... ';
  TestoStatusBar:=StatusBar.Panels[0].Text;
  StatusBar.Repaint;
end;

procedure TAc11FElaborazioneFesteParticolari.AvanzaProgressBar;
begin
  ProgressBar1.StepBy(1);
  StatusBar.Panels[0].Text:=TestoStatusBar + '(' + IntToStr(ProgressBar1.Position) + '/' + IntToStr(ProgressBar1.Max) + ')';
  StatusBar.Repaint;
end;

procedure TAc11FElaborazioneFesteParticolari.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  C005DataVisualizzazione:=Parametri.DataLavoro;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TAc11FElaborazioneFesteParticolari.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataDal:=Parametri.DataLavoro;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

end.
