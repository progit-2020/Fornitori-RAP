unit A176UGestioneIterAutorizzativi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Data.DB, OracleData,
  C180FunzioniGenerali, A000UCostanti, A000USessione;

type
  TA176FGestioneIterAutorizzativi = class(TForm)
    pnlOpzioni: TPanel;
    rgpAzioni: TRadioGroup;
    dGrdDettIter: TDBGrid;
    rgpAutorizzaNega: TRadioGroup;
    pnlEsegui: TPanel;
    lblLivello: TLabel;
    chkEliminaDato: TCheckBox;
    cmbLivello: TComboBox;
    btnEsegui: TBitBtn;
    lblStruttura: TLabel;
    edtStruttura: TEdit;
    lblNuovaStruttura: TLabel;
    cmbNuovaStruttura: TComboBox;
    procedure btnEseguiClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rgpAzioniClick(Sender: TObject);
  private
    { Private declarations }
    procedure CaricaCmbLivelli(Azione:string);
    procedure AbilitazioneComponenti(Azione:string);
  public
    { Public declarations }
  end;

implementation

uses
  A176URiepilogoIterAutorizzativiMW, A176URiepilogoIterAutorizzativiDM;

{$R *.dfm}

procedure TA176FGestioneIterAutorizzativi.btnEseguiClick(Sender: TObject);
var
  TipoAzioneRichiesta, EsitoElaboraborazione, MsgConfermaElaborazione:string;
  locT850Id:Integer;
begin
  TipoAzioneRichiesta:=rgpAzioni.Items[rgpAzioni.ItemIndex].ToLower;
  //Costruzione messaggio di conferma
  if TipoAzioneRichiesta = A176AZIONE_APPLICA_AUT then
  begin
    if rgpAutorizzaNega.Items[rgpAutorizzaNega.ItemIndex].ToLower = A176AUTORIZZA then
    begin
      MsgConfermaElaborazione:=Format('Vuoi autorizzare la richiesta fino al livello %s?',[cmbLivello.Items[cmbLivello.ItemIndex]]);
    end
    else
    begin
      MsgConfermaElaborazione:=Format('Vuoi negare la richiesta fino al livello %s?',[cmbLivello.Items[cmbLivello.ItemIndex]]);
    end;
  end
  else if TipoAzioneRichiesta = A176AZIONE_ANNULLA_AUT then
  begin
    MsgConfermaElaborazione:=Format('Vuoi annullare l''autorizzazione fino al livello %s?',[cmbLivello.Items[cmbLivello.ItemIndex]]);
  end
  else if TipoAzioneRichiesta = A176AZIONE_CANCELLA_RICH then
  begin
    MsgConfermaElaborazione:='Vuoi cancellare la richiesta?';
  end
  else if TipoAzioneRichiesta = A176AZIONE_CAMBIA_STRUTT then
  begin
    MsgConfermaElaborazione:='Vuoi modificare la struttura assegnando quella selezionata?';
  end;
  if R180MessageBox(MsgConfermaElaborazione,DOMANDA) = mrNo then
  begin
    Exit;
  end;

  EsitoElaboraborazione:='';
  if TipoAzioneRichiesta = A176AZIONE_ANNULLA_AUT then
  begin
    EsitoElaboraborazione:=A176FRiepilogoIterAutorizzativiDM.A176MW.ResetRichiesta(cmbLivello.Items[cmbLivello.ItemIndex].ToInteger,
                                                                                   chkEliminaDato.Checked);
  end
  else if TipoAzioneRichiesta = A176AZIONE_CANCELLA_RICH then
  begin
    EsitoElaboraborazione:=A176FRiepilogoIterAutorizzativiDM.A176MW.CancellaRichiesta(chkEliminaDato.Checked);
  end
  else if TipoAzioneRichiesta = A176AZIONE_APPLICA_AUT then
  begin
    EsitoElaboraborazione:=A176FRiepilogoIterAutorizzativiDM.A176MW.ForzaRichiesta(cmbLivello.Items[cmbLivello.ItemIndex].ToInteger,
                                                                                   (rgpAutorizzaNega.Items[rgpAutorizzaNega.ItemIndex].ToLower = A176AUTORIZZA));
  end
  else if TipoAzioneRichiesta = A176AZIONE_CAMBIA_STRUTT then
  begin
    EsitoElaboraborazione:=A176FRiepilogoIterAutorizzativiDM.A176MW.CambiaStruttura(edtStruttura.Text,cmbNuovaStruttura.Text);
    edtStruttura.Text:=A176FRiepilogoIterAutorizzativiDM.A176MW.C018.CodIter;
  end;
  //Refresh dei dati post-elaborazione
  locT850Id:=A176FRiepilogoIterAutorizzativiDM.A176MW.DataSetAttivo.FieldByName('T850ID').AsInteger;
  A176FRiepilogoIterAutorizzativiDM.A176MW.C018.selT851.Refresh;
  A176FRiepilogoIterAutorizzativiDM.A176MW.DataSetAttivo.Refresh;
  A176FRiepilogoIterAutorizzativiDM.A176MW.DataSetAttivo.SearchRecord('T850ID',locT850Id,[srFromBeginning]);
  //Gestione esito - anomalia
  if not EsitoElaboraborazione.IsEmpty then
  begin
    R180MessageBox(Format('ERRORE:' + #13#10 + '"%s"!',[EsitoElaboraborazione]) ,ERRORE);
  end
  else
  begin
    R180MessageBox('Elaborazione terminata correttamente.',INFORMA);
  end;
  //Gestione abilitazioni componenti post elaborazione
  AbilitazioneComponenti(TipoAzioneRichiesta);
  CaricaCmbLivelli(TipoAzioneRichiesta);
  //Abilito il bottone d'elaborazione solo se ci sono livelli disponibili per l'elaborazione
  btnEsegui.Enabled:=(cmbLivello.Items.Count > 0) or (TipoAzioneRichiesta = A176AZIONE_CAMBIA_STRUTT);
end;

procedure TA176FGestioneIterAutorizzativi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  A176FRiepilogoIterAutorizzativiDM.A176MW.C018.selT851.Close;
end;

procedure TA176FGestioneIterAutorizzativi.CaricaCmbLivelli(Azione:string);
begin
  cmbLivello.Items.Assign(A176FRiepilogoIterAutorizzativiDM.A176MW.CaricaCmbLivelliA176MW(Azione));
  cmbLivello.ItemIndex:=0;
end;

procedure TA176FGestioneIterAutorizzativi.AbilitazioneComponenti(Azione:string);
var
  AbilitaCancellazione:Boolean;
begin
  Azione:=Azione.ToLower;
  //Condizioni di abilitazione cancallazione dati su DataBase
  //Missioni
  AbilitaCancellazione:=(A176FRiepilogoIterAutorizzativiDM.A176MW.C018.Iter = ITER_MISSIONI) and (A176FRiepilogoIterAutorizzativiDM.A176MW.DataSetAttivo.FieldByName('T850STATO').AsString.ToUpper = 'S');
  //Giustificativi
  AbilitaCancellazione:=AbilitaCancellazione or (A176FRiepilogoIterAutorizzativiDM.A176MW.C018.Iter = ITER_GIUSTIF) and (A176FRiepilogoIterAutorizzativiDM.A176MW.DataSetAttivo.FieldByName('T050ELABORATO').AsString.ToUpper <> 'N');
  //Timbrature
  AbilitaCancellazione:=AbilitaCancellazione or (A176FRiepilogoIterAutorizzativiDM.A176MW.C018.Iter = ITER_TIMBR) and (A176FRiepilogoIterAutorizzativiDM.A176MW.DataSetAttivo.FieldByName('T105ELABORATO').AsString.ToUpper <> 'N');
  //(Disabilito per forzatura)
  AbilitaCancellazione:=AbilitaCancellazione and (not R180In(Azione,[A176AZIONE_APPLICA_AUT,A176AZIONE_CAMBIA_STRUTT]));
  chkEliminaDato.Enabled:=AbilitaCancellazione;
  rgpAutorizzaNega.Visible:=Azione = A176AZIONE_APPLICA_AUT;
  chkEliminaDato.Visible:=AbilitaCancellazione;
  cmbLivello.Visible:=not R180In(Azione,[A176AZIONE_CANCELLA_RICH,A176AZIONE_CAMBIA_STRUTT]);
  lblLivello.Visible:=not R180In(Azione,[A176AZIONE_CANCELLA_RICH,A176AZIONE_CAMBIA_STRUTT]);

  lblStruttura.Visible:=Azione = A176AZIONE_CAMBIA_STRUTT;
  edtStruttura.Visible:=lblStruttura.Visible;
  lblNuovaStruttura.Visible:=lblStruttura.Visible;
  cmbNuovaStruttura.Visible:=lblStruttura.Visible;
end;

procedure TA176FGestioneIterAutorizzativi.FormShow(Sender: TObject);
begin
  //Assegnazione dataset struttura IterAutorizzativi C018.selT851
  A176FRiepilogoIterAutorizzativiDM.A176MW.dsrT851DettIter.DataSet:=A176FRiepilogoIterAutorizzativiDM.A176MW.C018.selT851;
  //Filtro dataset C018.selT851 per i livelli > 0
  A176FRiepilogoIterAutorizzativiDM.A176MW.SetC018selT851;
  //Caricamento ComBox livelli
  CaricaCmbLivelli(rgpAzioni.Items[rgpAzioni.ItemIndex]);

  edtStruttura.Text:=A176FRiepilogoIterAutorizzativiDM.A176MW.C018.CodIter;
  cmbNuovaStruttura.Items.Clear;
  with A176FRiepilogoIterAutorizzativiDM.A176MW.selI095 do
  begin
    Open;
    First;
    while not Eof do
    begin
      cmbNuovaStruttura.Items.Add(FieldByName('COD_ITER').AsString);
      Next;
    end;
  end;
  cmbNuovaStruttura.ItemIndex:=cmbNuovaStruttura.Items.IndexOf(edtStruttura.Text);

  //Abilito il check di eliminazione dato DB, solo se la richiesta è stato precedentemente autorizzata
  chkEliminaDato.Enabled:=A176FRiepilogoIterAutorizzativiDM.A176MW.C018.selT851.FieldByName('STATO').AsString.ToUpper = 'SI';
  //Abilito il bottone d'elaborazione solo se ci sono livelli disponibili per l'elaborazione
  btnEsegui.Enabled:=cmbLivello.Items.Count > 0;
  //Visibile solo se siamo in forza IterAutorizzativo
  AbilitazioneComponenti(rgpAzioni.Items[rgpAzioni.ItemIndex]);
  pnlOpzioni.Enabled:=(A000GetInibizioni('Funzione','OpenA176RiepilogoIterAutorizzativi') = 'S') or (DebugHook <> 0);
end;

procedure TA176FGestioneIterAutorizzativi.rgpAzioniClick(Sender: TObject);
begin
  //Filtro dataset C018.selT851 per i livelli > 0
  A176FRiepilogoIterAutorizzativiDM.A176MW.SetC018selT851;
  CaricaCmbLivelli(rgpAzioni.Items[rgpAzioni.ItemIndex]);
  chkEliminaDato.Enabled:=A176FRiepilogoIterAutorizzativiDM.A176MW.C018.selT851.FieldByName('STATO').AsString.ToUpper = 'SI';
  btnEsegui.Enabled:=(cmbLivello.Items.Count > 0) or (rgpAzioni.Items[rgpAzioni.ItemIndex].ToLower = A176AZIONE_CANCELLA_RICH);
  //Cambio struttura abilitato solo se non esistono livelli obbligatori già con autorizzazione assegnata
  if rgpAzioni.Items[rgpAzioni.ItemIndex].ToLower = A176AZIONE_CAMBIA_STRUTT then
  begin
    btnEsegui.Enabled:=(VarToStr(A176FRiepilogoIterAutorizzativiDM.A176MW.C018.selT851.Lookup('OBBLIGATORIO;STATO',VarArrayOf(['S','No']),'STATO')).ToUpper = '') and
                       (VarToStr(A176FRiepilogoIterAutorizzativiDM.A176MW.C018.selT851.Lookup('OBBLIGATORIO;STATO',VarArrayOf(['S','Si']),'STATO')).ToUpper = '');
    cmbNuovaStruttura.Enabled:=btnEsegui.Enabled;
  end;
  AbilitazioneComponenti(rgpAzioni.Items[rgpAzioni.ItemIndex]);
end;

end.
