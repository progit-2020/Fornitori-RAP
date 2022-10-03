unit A037UScaricoPaghe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, Mask, ExtCtrls, A000UCostanti, A000USessione,A000UInterfaccia,
  C700USelezioneAnagrafe,  DBCtrls,QueryStorico,C180FunzioniGenerali,
  A035UParScarico, Menus, C004UParamForm, Oracle, OracleData, DB,
  C005UDatiAnagrafici, RegistrazioneLog,  A003UDataLavoroBis,
  SelAnagrafe, ActnList, ImgList, ToolWin, Variants, C012UVisualizzaTesto,
  A083UMsgElaborazioni,A000UMessaggi, System.Actions;

type
  TA037FScaricoPaghe = class(TForm)
    EnBBScarica: TBitBtn;
    StatusBar: TStatusBar;
    SpeedButton1: TSpeedButton;
    DBLookupParPaghe: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    EdtData: TEdit;
    Label4: TLabel;
    EdtNomeFile: TEdit;
    BitBtn1: TBitBtn;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    btnDataCassa: TSpeedButton;
    Label3: TLabel;
    EDataFile: TEdit;
    ProgressBar1: TProgressBar;
    MainMenu1: TMainMenu;
    Opzioni1: TMenuItem;
    SpeedButton4: TSpeedButton;
    Label5: TLabel;
    EdtDataInd: TEdit;
    Conguagli: TCheckBox;
    Salvataggio1: TMenuItem;
    Ripristino1: TMenuItem;
    N2: TMenuItem;
    Filtro1: TMenuItem;
    rgpTipoScrittura: TRadioGroup;
    frmSelAnagrafe: TfrmSelAnagrafe;
    Label6: TLabel;
    edtUltimaDataCassa: TEdit;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ActionList1: TActionList;
    ImageList1: TImageList;
    actSalvataggio: TAction;
    actRipristino: TAction;
    actVisualizzaScarico: TAction;
    actVisualizzaAnomalie: TAction;
    actFiltroCodInterni: TAction;
    ToolButton10: TToolButton;
    actEsci: TAction;
    N3: TMenuItem;
    Esci1: TMenuItem;
    actEseguiScarico: TAction;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    N4: TMenuItem;
    Visualizzascarico1: TMenuItem;
    Visualizzaanomalie1: TMenuItem;
    N5: TMenuItem;
    Eliminaultimadatadicassa1: TMenuItem;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    actFiltroVoci: TAction;
    Filtrovoci1: TMenuItem;
    cmbSel: TComboBox;
    ToolButton4: TToolButton;
    actFiltro: TAction;
    actFiltro1: TMenuItem;
    actEliminaFiltro: TAction;
    ToolButton5: TToolButton;
    Eliminafiltro1: TMenuItem;
    procedure actFiltroVociClick(Sender: TObject);
    procedure EdtDataChange(Sender: TObject);
    procedure DBLookupParPagheKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actScaricaClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure DBLookupParPagheCloseUp(Sender: TObject);
    procedure DBLookupParPagheExit(Sender: TObject);
    procedure DBLookupParPagheKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actVisualizzaScaricoClick(Sender: TObject);
    procedure actVisualizzaAnomalieClick(Sender: TObject);
    procedure actEsciClick(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure btnDataCassaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton4Click(Sender: TObject);
    procedure actSalvataggioClick(Sender: TObject);
    procedure actRipristinoClick(Sender: TObject);
    procedure actFiltroCodInterniClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure EliminaDataCassaClick(Sender: TObject);
    procedure CmbSelChange(Sender: TObject);
    procedure actFiltroExecute(Sender: TObject);
    procedure actEliminaFiltroExecute(Sender: TObject);
  private
    { Private declarations }
    Lung:Integer;
    Anomalie: Boolean;
    AnomalieAbilitate:Boolean;
    DipInSer:TDipendenteInServizio;
    CurrAA:Word;
    CurrMM:Word;
    CurrGG:Word;
    F: TextFile;
    procedure CaricaListaSelezioni;
    procedure ControllaDisponibilitaBilancio;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
  public
    { Public declarations }
    DataScarico,Data,DataIndietro,DataFile,DataCassa:TDateTime;
    FileSeq,AggiornaT195:Boolean;
    function VoceAbilitata(Campo:String):Boolean;
    function VoceDisabilitata(Voce_paghe_cedolino:String):Boolean;
    (*Caratto 13/02/2013 procedura mai usata
    procedure AbilitaCodInterno(CodInterno:String);
    *)
    procedure StampaAnomalie;
    procedure SetAnomalieAbilitate(Value:Boolean);
    procedure GestisciNomeFile;
    procedure ScorriQueryVista;
  end;

var
  A037FScaricoPaghe: TA037FScaricoPaghe;

const
  LENGHT_VOCIPAGHE: Integer = 10;
  LENGTH_CODINTERNI: Integer = 4;

procedure OpenA037ScaricoPaghe(Prog:LongInt);
procedure OpenA037ScaricoBuoni(ParScarico,PC700SQL:String; PDataScarico:TDateTime; SelezionePeriodica,SoloPersonaleInterno:Boolean);

implementation

uses A037UScaricoPagheDtM1,A037UFiltroCodInterni,A037UFiltroVoci;

{$R *.DFM}

procedure OpenA037ScaricoPaghe(Prog:LongInt);
{Scarico dati mensili alle paghe su file sequenziale}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA037ScaricoPaghe') of
    'N','R':
        begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
  end;
  A037FScaricoPaghe:=TA037FScaricoPaghe.Create(nil);
  with A037FScaricoPaghe do
    try
      C700Progressivo:=Prog;
      A037FScaricoPagheDtM1:=TA037FScaricoPagheDtM1.Create(nil);
      //procedure controllo voce abilitata/disabilitata
      A037FScaricoPagheDtM1.A037FScaricoPagheMW.VoceAbilitata:=VoceAbilitata;
      A037FScaricoPagheDtM1.A037FScaricoPagheMW.VoceDisabilitata:=VoceDisabilitata;
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A037FScaricoPagheDtM1.Free;
      Free;
    end;
end;

procedure OpenA037ScaricoBuoni(ParScarico,PC700SQL:String; PDataScarico:TDateTime; SelezionePeriodica,SoloPersonaleInterno:Boolean);
{Scarico dati mensili alle paghe su file sequenziale}
var
  i:Integer;
  Codice: String;
begin
  SolaLetturaOriginale:=SolaLettura;
  A037FScaricoPaghe:=TA037FScaricoPaghe.Create(nil);
  with A037FScaricoPaghe do
    try
      A037FScaricoPagheDtM1:=TA037FScaricoPagheDtM1.Create(nil);
      //procedure controllo voce abilitata/disabilitata
      A037FScaricoPagheDtM1.A037FScaricoPagheMW.VoceAbilitata:=VoceAbilitata;
      A037FScaricoPagheDtM1.A037FScaricoPagheMW.VoceDisabilitata:=VoceDisabilitata;

      AggiornaT195:=False;
      A037FScaricoPaghe.FormShow(nil);
      A037FScaricoPaghe.DBLookupParPaghe.KeyValue:=ParScarico;
      A037FScaricoPaghe.DBLookupParPagheExit(nil);
      A037FScaricoPaghe.Data:=R180InizioMese(PDataScarico);
      A037FScaricoPaghe.DataScarico:=R180InizioMese(PDataScarico);
      DataIndietro:=R180InizioMese(PDataScarico);
      A037FScaricoPaghe.CurrAA:=R180Anno(PDataScarico);
      A037FScaricoPaghe.CurrMM:=R180Mese(PDataScarico);
      A037FScaricoPaghe.Conguagli.Checked:=False;
      (*A037FScaricoPaghe.frmSelAnagrafe.SelezionePeriodica:=SelezionePeriodica;
      A037FScaricoPaghe.frmSelAnagrafe.SoloPersonaleInterno:=SoloPersonaleInterno;
      A037FScaricoPaghe.frmSelAnagrafe.OldSelAnagrafe.Text:=PC700SQL;
      A037FScaricoPaghe.frmSelAnagrafe.RipristinaC00SelAnagrafe;*)
      A037FScaricoPaghe.frmSelAnagrafe.btnEreditaSelezioneClick(nil);
      with A037FFiltroCodInterni do
        for i:=0 to lstFiltroCodInterni.Items.Count - 1 do
        begin
          Codice:=Trim(Copy(lstFiltroCodInterni.Items[i],1,LENGTH_CODINTERNI));
          lstFiltroCodInterni.Checked[i]:=(Codice = '215') or (Codice = '225');
        end;
      with A037FFiltroVoci do
        for i:=0 to lstFiltroVoci.Items.Count - 1 do
          lstFiltroVoci.Checked[i]:=True;
      A037FScaricoPaghe.actScaricaClick(nil);
    finally
      SolaLettura:=SolaLetturaOriginale;
      A037FScaricoPagheDtM1.Free;
      Free;
    end;
end;

function TA037FScaricoPaghe.VoceDisabilitata(Voce_paghe_cedolino:String):Boolean;
//Norman 25/10/2006: cerco ',xxx,' in ',selezione,'
var selezione:String;
begin
  selezione:=',' + R180GetCheckList(LENGHT_VOCIPAGHE,A037FFiltroVoci.lstFiltroVoci) + ',';
  Voce_paghe_cedolino:=',' + Trim(Voce_paghe_cedolino) + ',';
  result:=Pos(Voce_paghe_cedolino,selezione) = 0;
end;

procedure TA037FScaricoPaghe.FormCreate(Sender: TObject);
begin
  Anomalie:=False;
  FileSeq:=True;
  AggiornaT195:=True;
  SetAnomalieAbilitate(False);
  if Parametri.DataLavoro > 0 then
    Data:=Parametri.DataLavoro
  else
    Data:=Date;
  DecodeDate(Data,CurrAA,CurrMM,CurrGG);
  Data:=EncodeDate(CurrAA,CurrMM, 1);
  DataIndietro:=Data;
  //ListaAnomalie:=TStringList.Create;
end;

procedure TA037FScaricoPaghe.CaricaListaSelezioni;
begin
  with A037FScaricoPagheDTM1.A037FScaricoPagheMW do
  begin
    selCodiciScaricoT196.Open;
    CmbSel.Items.Clear;
    while Not(selCodiciScaricoT196.Eof) do
    begin
      CmbSel.Items.Add(selCodiciScaricoT196.FieldByName('CODICE').AsString);
      selCodiciScaricoT196.Next;
    end;
    selCodiciScaricoT196.Close;
  end;
end;

procedure TA037FScaricoPaghe.CmbSelChange(Sender: TObject);
var i:Integer;
begin
  if cmbSel.Text = '' then
  begin
    A037FFiltroCodInterni.Selezionatutto1.Click;
    A037FFiltroVoci.Selezionatutto1.Click;
    Exit;
  end;
  with A037FScaricoPagheDtM1.A037FScaricoPagheMW do
  begin
    selT196.Close;
    selT196.setVariable('CODICE',Trim(CmbSel.Text));
    selT196.Open;
    if selT196.RecordCount = 0 then
      exit;
    A037FFiltroCodInterni.Annullatutto1.Click;
    A037FFiltroVoci.Annullatutto1.Click;
    with A037FFiltroCodInterni do
      for i:=0 to lstFiltroCodInterni.Items.Count-1 do
        lstFiltroCodInterni.Checked[i]:=selT196.SearchRecord('TIPO;CODVOCE',VarArrayOf(['I',Trim(Copy(lstFiltroCodInterni.Items[i],1,LENGTH_CODINTERNI))]),[srFromBeginning]);
    with A037FFiltroVoci do
      for i:=0 to lstFiltroVoci.Items.Count - 1 do
        lstFiltroVoci.Checked[i]:=selT196.SearchRecord('TIPO;CODVOCE',VarArrayOf(['V',Trim(Copy(lstFiltroVoci.Items[i],1,LENGHT_VOCIPAGHE))]),[srFromBeginning]);
  end;
end;

procedure TA037FScaricoPaghe.FormShow(Sender: TObject);
begin
  EdtData.Text:=FormatDateTime('mmmm yyyy',Data);
  EdtDataInd.Text:=FormatDateTime('mmmm yyyy',Data);
  A037FFiltroCodInterni:=TA037FFiltroCodInterni.Create(nil);
  A037FFiltroVoci:=TA037FFiltroVoci.Create(nil);
  CreaC004(SessioneOracle,'A037',Parametri.ProgOper);
  GetParametriFunzione;
  if CmbSel.Text <> '' then
    CmbSelChange(nil);
  GestisciNomeFile;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase + ',CODFISCALE,T430CONTRATTO';
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A037FScaricoPagheDtM1.A037FScaricoPagheMW,SessioneOracle,StatusBar,0,False);
  frmSelAnagrafe.SelezionePeriodica:=True;
  rgpTipoScrittura.Enabled:=Parametri.A037_RicreaScaricoPaghe = 'S';
  if Parametri.A037_RicreaScaricoPaghe <> 'S' then
    rgpTipoScrittura.itemIndex:=1;
  Eliminaultimadatadicassa1.Enabled:=(Parametri.A037_EliminaDataCassa = 'S') and (A037FScaricoPagheDtM1.A037FScaricoPagheMW.selT199.RecordCount = 0);
  btnDataCassa.Enabled:=A037FScaricoPagheDtM1.A037FScaricoPagheMW.selT199.RecordCount = 0;
  //procedure controllo voce abilitata/disabilitata
  A037FScaricoPagheDtM1.A037FScaricoPagheMW.VoceAbilitata:=VoceAbilitata;
  A037FScaricoPagheDtM1.A037FScaricoPagheMW.VoceDisabilitata:=VoceDisabilitata;

  CaricaListaSelezioni;
end;

procedure TA037FScaricoPaghe.SetAnomalieAbilitate(Value:Boolean);
begin
  AnomalieAbilitate:=Value;
  actVisualizzaAnomalie.Enabled:=Value;
end;

procedure TA037FScaricoPaghe.GestisciNomeFile;
begin
  with A037FScaricoPagheDtM1.A037FScaricoPagheMW do
  begin
    FileSeq:=selT191.FieldByName('TipoFile').AsString = 'F';
    if EdtNomeFile.Text <> GetNomeFile(DataScarico,DataFile) then
    begin
      EdtNomeFile.Text:=GetNomeFile(DataScarico,DataFile);
      SetAnomalieAbilitate(False);
    end;
  end;
end;
(*Caratto 13/02/2013 procedura mai usata
procedure TA037FScaricoPaghe.AbilitaCodInterno(CodInterno:String);
var i:Integer;
begin
  with A037FFiltroCodInterni do
    for i:=0 to lstFiltroCodInterni.Items.Count - 1 do
      if Trim(Copy(lstFiltroCodInterni.Items[i],1,LENGTH_CODINTERNI)) = CodInterno then
      begin
        lstFiltroCodInterni.Checked[i]:=True;
        Break;
      end;
end;
*)

function TA037FScaricoPaghe.VoceAbilitata(Campo:String):Boolean;
var i:Integer;
begin
  with A037FScaricoPagheDtM1.A037FScaricoPagheMW do
    Result:=selT190.SearchRecord('CodInterno;Flag',VarArrayOf([Campo,'S']),[srFromBeginning]);
  if Result then
    with A037FFiltroCodInterni do
    begin
      for i:=0 to lstFiltroCodInterni.Items.Count - 1 do
        if Trim(Copy(lstFiltroCodInterni.Items[i],1,LENGTH_CODINTERNI)) = Campo then
        begin
          Result:=lstFiltroCodInterni.Checked[i];
          Break;
        end;
    end;
end;

procedure TA037FScaricoPaghe.StampaAnomalie;
begin
  Anomalie:=True;
end;

procedure TA037FScaricoPaghe.ScorriQueryVista;
var DataStr: String;
    EsisteImporto:Boolean;
begin
  EsisteImporto:=A037FScaricoPagheDtM1.A037FScaricoPagheMW.VerificaEsisteImporto;
  with A037FScaricoPagheDtM1.A037FScaricoPagheMW do
  try
    if frmSelAnagrafe.SettaPeriodoSelAnagrafe(R180InizioMese(DataIndietro),R180FineMese(Data)) then
      C700SelAnagrafe.Close;
    C700SelAnagrafe.Open;
    StatusBar.Panels[0].Text:=IntToStr(C700SelAnagrafe.RecordCount) + ' Anagrafiche';
    ProgressBar1.Position:=0;
    ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
    C700SelAnagrafe.First;
    DataStr:=FormatDateTime('dd/mm/yy',Data);
    DipInSer:=TDipendenteInServizio.Create(nil);
    DipInSer.Session:=SessioneOracle;
    frmSelAnagrafe.ElaborazioneInterrompibile:=True;
    A037FScaricoPaghe.Enabled:=False;
    //Massimo 23/07/2013 l'abbinamento è già fatto in creaSelAnagrafe
    //SelAnagrafe:=C700SelAnagrafe;
    while not(C700SelAnagrafe.EOF) do
    begin
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar1.Position:=ProgressBar1.Position + 1;
      ElaboraDipendente(Data, DataFile, DataIndietro, DataCassa, CurrMM, CurrAA, DipInSer,
                        AggiornaT195,Conguagli.Checked,EsisteImporto,FileSeq,rgpTipoScrittura.ItemIndex = 1,
                        F);
      C700SelAnagrafe.Next;
    end;
    SessioneOracle.Commit;
  except
    on E: Exception do
    begin
      SessioneOracle.Rollback;
      ShowMessage(E.Message);
    end;
  end;
  DipInSer.Free;
  ProgressBar1.Position:=0;
  frmSelAnagrafe.ElaborazioneInterrompibile:=False;
  A037FScaricoPaghe.Enabled:=True;  //riabilita la form
  frmSelAnagrafe.VisualizzaDipendente; //Rivisualizza il dipendente
end;

procedure TA037FScaricoPaghe.ControllaDisponibilitaBilancio;
{Se sono attive voci legate allo straordinario si fa il controllo sulla T710 che non ci siano situazioni anomale}
var ScaricoVociBilancio:Boolean;
    i:Integer;
begin
  ScaricoVociBilancio:=False;
  with A037FFiltroCodInterni do
  begin
    for i:=0 to lstFiltroCodInterni.Items.Count - 1 do
      if R180In(Trim(Copy(lstFiltroCodInterni.Items[i],1,LENGTH_CODINTERNI)),A037FScaricoPagheDtM1.A037FScaricoPagheMW.VociStraordinario) then
        if lstFiltroCodInterni.Checked[i] then
        begin
          ScaricoVociBilancio:=True;
          Break;
        end;
  end;
  if ScaricoVociBilancio then
    if not A037FScaricoPagheDtM1.A037FScaricoPagheMW.DisponibilitaBilancio then
      raise Exception.Create(A000MSG_A037_ERR_BILANCIO);
end;

procedure TA037FScaricoPaghe.actScaricaClick(Sender: TObject);
var App,Path,MsgFiltroScarico,S:String;
    Prosegui:Boolean;
    D:TDateTime;
begin
  ControllaDisponibilitaBilancio;  //Controllo per Torino_Comune: non ci devono essere situazioni anomale sulla T710
  if DataIndietro > Data then
    raise Exception.Create(Format(A000MSG_ERR_FMT_PERIODO_NON_CORRETTO,[FormatDateTime('mmmm yyyy',DataIndietro) + ' - ' + FormatDateTime('mmmm yyyy',Data)]));
  if A037FFiltroVoci.lstFiltroVoci.Count = 0 then
    raise Exception.Create(A000MSG_A037_ERR_NO_VOCI);
  if cmbSel.Text <> '' then
    MsgFiltroScarico:=Format(A000MSG_A037_DLG_FMT_SCARICO_FILTRO,[cmbSel.Text]) + #13#10;
  DataCassa:=R180InizioMese(DataFile);

  with A037FScaricoPagheDtM1.A037FScaricoPagheMW.selMaxDataCassa do
  try
    Close;
    Open;
    D:=Fields[0].AsDateTime;
  finally
    Close;
  end;

  if DataCassa < D then
    raise Exception.Create(Format(A000MSG_A037_ERR_FMT_DATA_CASSA_ANTE,[UpperCase(FormatDateTime('mmmm yyyy',D))]));
  if DataCassa < Data then
    if AggiornaT195 and (MessageDlg(Format(A000MSG_A037_DLG_FMT_DATA_ANTE_SCARICO,[FormatDateTime('mmmm yyyy',D),FormatDateTime('mmmm yyyy',Data)]),mtConfirmation,[mbYes,mbNo],0) <> mrYes) then
      exit;
  if DataCassa = D then
  begin
    if AggiornaT195 and
      (MessageDlg(MsgFiltroScarico +
                  A000MSG_A037_DLG_SCARICO_GIA_PRESENTE,
                  mtConfirmation,[mbNo,mbYes],0) <> mrYes) then
      exit;
  end
  else if AggiornaT195 and (MessageDlg(MsgFiltroScarico + A000MSG_A037_DLG_ESEGUIRE_SCARICO,mtConfirmation,[mbNo,mbYes],0) <> mrYes) then
    exit;
  try
    App:=DBLookUpParPaghe.KeyValue;
  except
    App:='';
  end;
  if App <> '' then
  begin
    //Flag per File Sequenziale /Tabella Oracle
    FileSeq:=A037FScaricoPagheDtM1.A037FScaricoPagheMW.selT191.FieldByName('TipoFile').AsString = 'F';
    if FileSeq then
    begin
      //CONTROLLO ESISTENZA DIRECTORY E SUA EVENTUALE CREAZIONE
      Path:=R180EstraiPercorsoFile(EdtNomeFile.Text);
      if Length(Path) > 0 then
      begin
        if not(DirectoryExists(Path)) then
          if R180MessageBox(Format(A000MSG_A037_DLG_FMT_CREA_DIR,[Path]), 'DOMANDA') = mrYes then
          begin
            if not CreateDir(Path) then
              if not ForceDirectories(Path) then
                raise Exception.Create('Impossibile creare la directory ''' + Path + '''. Impossibile proseguire!');
          end
          else
            raise Exception.Create(Format(A000MSG_A037_DLG_FMT_PATH_INESISTENTE,[Path]));
      end;
      Prosegui:=A037FScaricoPagheDtM1.A037FScaricoPagheMW.ApriFileSequenziale(EdtNomeFile.Text,rgpTipoScrittura.ItemIndex = 1, F);
    end
    else
    begin
      S:=A037FScaricoPagheDtM1.A037FScaricoPagheMW.VerificaTabella(EdtNomeFile.Text,rgpTipoScrittura.ItemIndex = 0);
      Prosegui:=True;
      if (S <> '') and (MessageDlg(S,mtConfirmation,[mbYes,mbNo],0) <> mrYes) then
        Prosegui:=False;

      if Prosegui then
        Prosegui:=A037FScaricoPagheDtM1.A037FScaricoPagheMW.ImpostaTabella(EdtNomeFile.Text,rgpTipoScrittura.ItemIndex = 0);
    end;
    if Prosegui then
    begin
      Screen.Cursor:=crHourGlass;
      //Apro i conteggi
      A037FScaricoPagheDtM1.A037FScaricoPagheMW.InizializzaConteggi;
      Lung:=A037FScaricoPagheDtM1.A037FScaricoPagheMW.LeggiParametri;
      //ListaAnomalie.Clear;
      RegistraMsg.IniziaMessaggio('A037');
      ScorriQueryVista;
      A037FScaricoPagheDtM1.A037FScaricoPagheMW.DistruggiConteggi;
      if AggiornaT195 then
      begin
        //if (ListaAnomalie.Count > 0) then
        if (RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB) then
        begin
          SetAnomalieAbilitate(True);
          R180MessageBox('Sono state riscontrate delle anomalie.',INFORMA);
          actVisualizzaAnomalieClick(Self);
        end
        else
          R180MessageBox('Non sono state riscontrate anomalie' + #13#10 +
                         'durante lo scarico paghe',INFORMA);
      end;
      if FileSeq then
        CloseFile(F);
      A037FScaricoPagheDtM1.GetUltimaDataCassa(False);
    end
    else
      R180MessageBox('Elaborazione interrotta',ERRORE);
    Screen.Cursor:=crDefault
  end
  else
    R180MessageBox(A000MSG_A037_ERR_NO_PARAMETRIZZAZIONE,ESCLAMA);
end;

procedure TA037FScaricoPaghe.SpeedButton1Click(Sender: TObject);
var GG,MM,AA:Word;
begin
  if EdtData.Text = '' then
    Data:=DataOut(Date,'Mese da scaricare','M')
  else
    Data:=DataOut(Data,'Mese da scaricare','M');
  EdtData.Text:=FormatDateTime('mmmm yyyy',Data);
  DecodeDate(Data,AA,MM,GG);
  Data:=EncodeDate(AA,MM,1);
  DataScarico:=Data;
  DecodeDate(Data,CurrAA,CurrMM,GG); // assegnazione variabili globali.
  if DataIndietro > Data then
  begin
    DataIndietro:=Data;
    EdtDataInd.Text:=FormatDateTime('mmmm yyyy',DataIndietro);
  end;
end;

procedure TA037FScaricoPaghe.SpeedButton4Click(Sender: TObject);
var A,M,G:Word;
begin
  if EdtDataInd.Text = '' then
    DataIndietro:=DataOut(Date,'Primo mese da scaricare','M')
  else
    DataIndietro:= DataOut(DataIndietro,'Primo mese da scaricare','M');
  EdtDataInd.Text:=FormatDateTime('mmmm yyyy',DataIndietro);
  DecodeDate(DataIndietro,A,M,G);
  DataIndietro:=EncodeDate(A,M,1);
end;

procedure TA037FScaricoPaghe.DBLookupParPagheCloseUp(Sender: TObject);
begin
  GestisciNomeFile;
end;

procedure TA037FScaricoPaghe.DBLookupParPagheExit(Sender: TObject);
begin
  GestisciNomeFile;
end;

procedure TA037FScaricoPaghe.DBLookupParPagheKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  GestisciNomeFile;
end;

procedure TA037FScaricoPaghe.actVisualizzaScaricoClick(Sender: TObject);
var
  lst:TStringList;
begin
  if FileSeq then
    OpenC012VisualizzaTesto('<A037> Scarico dati paghe',EdtNomeFile.Text,nil,'Scarico dati paghe di ' + FormatDateTime('mmmm',Data) + ' ' + IntToStr(CurrAA))
  else
  begin
    lst:=A037FScaricoPagheDtM1.A037FScaricoPagheMW.LeggiScaricoDaTabella(EdtNomeFile.Text);
    OpenC012VisualizzaTesto('<A037> Scarico dati paghe','',lst,'Scarico dati paghe di ' + FormatDateTime('mmmm',Data) + ' ' + IntToStr(CurrAA));
    lst.Free;
  end;
end;

procedure TA037FScaricoPaghe.actVisualizzaAnomalieClick(Sender: TObject);
begin
  //OpenC012VisualizzaTesto('<A037> Anomalie riscontrate nello scarico paghe di ' + FormatDateTime('mmmm',Data) + ' ' + IntToStr(CurrAA),'',ListaAnomalie);
  
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A037','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A037FScaricoPagheDtM1.A037FScaricoPagheMW);
end;

procedure TA037FScaricoPaghe.actEliminaFiltroExecute(Sender: TObject);
begin
  if Trim(cmbSel.Text) = '' then exit;
  if MessageDlg(Format(A000MSG_A037_DLG_FMT_ELIMINA_FILTRO,[cmbSel.Text]),mtConfirmation,[mbYes,mbNo],0) <> mrYes then exit;
  A037FScaricoPagheDtM1.A037FScaricoPagheMW.EliminaFiltroScaricoPaghe(Trim(cmbSel.Text));
  cmbSel.Text:='';
  CmbSelChange(nil);
  CaricaListaSelezioni;
end;

procedure TA037FScaricoPaghe.actEsciClick(Sender: TObject);
begin
  Close;
end;

procedure TA037FScaricoPaghe.Nuovoelemento1Click(Sender: TObject);
{Richiamo parametrizzazione scarico paghe}
begin
  OpenA035ParScarico(A037FScaricoPagheDtM1.A037FScaricoPagheMW.selT191.FieldByName('Codice').AsString,'PAGHE');
  with A037FScaricoPagheDtM1.A037FScaricoPagheMW.selT191 do
  begin
    DisableControls;
    Refresh;
    EnableControls;
  end;
end;

procedure TA037FScaricoPaghe.btnDataCassaClick(Sender: TObject);
var LocalData:TDateTime;
    GG,MM,AA:Word;
begin
  LocalData:=DataFile;
  if EDataFile.Text = '' then
    DataFile:= DataOut(Now,'Data di cassa','G')
  else
    DataFile:= DataOut(LocalData,'Data di cassa','G');
  EDataFile.Text:=FormatDateTime('dd/mm/yyyy',DataFile);
  DecodeDate(DataFile,AA,MM,GG);
  DataFile:=EncodeDate(AA,MM,1);
  DataCassa:=DataFile;
  GestisciNomeFile;
end;

procedure TA037FScaricoPaghe.GetParametriFunzione;
{Leggo i parametri della form}
begin
  DbLookupParPaghe.KeyValue:=C004FParamForm.GetParametro('PARPAGHE',DbLookupParPaghe.Text);
  if DbLookupParPaghe.Text = '' then
    DbLookupParPaghe.KeyValue:=null;
  CmbSel.Text:=C004FParamForm.GetParametro('FILTROVOCI','');
  rgpTipoScrittura.ItemIndex:=StrToInt(C004FParamForm.GetParametro('TIPOSCRITTURA','0'));
end;

procedure TA037FScaricoPaghe.PutParametriFunzione;
{Scrivo i parametri della form}
var Str:String;
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('PARPAGHE',VarToStr(A037FScaricopaghe.DbLookupParPaghe.KeyValue));
  C004FParamForm.PutParametro('TIPOSCRITTURA',IntToStr(rgpTipoScrittura.ItemIndex));
  with A037FScaricoPagheDtM1.A037FScaricoPagheMW do
  begin
    str:=Trim(CmbSel.Text);
    selCountCodiciT196.Close;
    selCountCodiciT196.setVariable('CODICE', str);
    selCountCodiciT196.Open;
    if selCountCodiciT196.FieldByName('NUMREC').AsInteger > 0 then
      C004FParamForm.PutParametro('FILTROVOCI',str);
    selCountCodiciT196.Close;
  end;
  try SessioneOracle.Commit; except end;
end;

procedure TA037FScaricoPaghe.actSalvataggioClick(Sender: TObject);
var S:String;
begin
  S:=A037FScaricoPagheDtM1.A037FScaricoPagheMW.MessaggioSalvataggio;
  if MessageDlg(S, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Abort;
  Screen.Cursor:=crHourGlass;
  A037FScaricoPagheDtM1.A037FScaricoPagheMW.SalvataggioScarico;
  Screen.Cursor:=crDefault;
end;

procedure TA037FScaricoPaghe.actRipristinoClick(Sender: TObject);
var
  S:String;
begin
  with A037FScaricoPagheDtM1.A037FScaricoPagheMW do
  begin
    S:=MessaggioRipristina;
    if MessageDlg(S, mtConfirmation, [mbNo, mbYes], 0) <> mrYes then
      Abort;
    Screen.Cursor:=crHourGlass;
    RipristinoVociPaghe.Execute;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA037FScaricoPaghe.actFiltroCodInterniClick(Sender: TObject);
begin
  A037FFiltroCodInterni.ShowModal;
end;

procedure TA037FScaricoPaghe.actFiltroExecute(Sender: TObject);
var i:Integer;
    Nome:String;
    lstSalvaCodiciInterni,lstSalvaFiltroVoci: TStringList;
begin
  with A037FScaricoPagheDtm1.A037FScaricoPagheMW do
  begin
    Screen.Cursor:=crHourGlass;
    Nome:=Trim(CmbSel.Text);
    selT196.Close;
    selT196.setVariable('CODICE', Nome);
    selT196.Open;
    if selT196.RecordCount > 0 then
    begin
      if R180MessageBox(A000MSG_A037_DLG_SOVRASCRIVERE_FILTRO,DOMANDA) = mrYes then
        EliminaFiltroScaricoPaghe(Nome)
      else
      begin
        Screen.Cursor:=crDefault;
        Exit;
      end;
    end;

    lstSalvaCodiciInterni:=TStringList.Create();
    lstSalvaFiltroVoci:=TStringList.Create();
    try
      with A037FFiltroCodInterni do
      begin
        for i:=0 to lstFiltroCodInterni.Items.Count - 1 do
          if (lstFiltroCodInterni.Checked[i]) and (Trim(lstFiltroCodInterni.Items[i]) <> '') then
            lstSalvaCodiciInterni.add(Trim(Copy(lstFiltroCodInterni.Items[i],1,LENGTH_CODINTERNI)));
      end;

      with A037FFiltroVoci do
      begin
        for i:=0 to lstFiltroVoci.Items.Count - 1 do
          if (lstFiltroVoci.Checked[i]) and (Trim(lstFiltroVoci.Items[i]) <> '') then
            lstSalvaFiltroVoci.add(Trim(Copy(lstFiltroVoci.Items[i],1,LENGHT_VOCIPAGHE)));
      end;
      SalvaFiltroScaricoPaghe(Nome,lstSalvaCodiciInterni,lstSalvaFiltroVoci);
    finally
      FreeAndNil(lstSalvaCodiciInterni);
      FreeAndNil(lstSalvaFiltroVoci);
    end;

    Screen.Cursor:=crDefault;
    CaricaListaSelezioni;
  end;
end;

procedure TA037FScaricoPaghe.actFiltroVociClick(Sender: TObject);
begin
  A037FFiltroVoci.ShowModal;
end;

procedure TA037FScaricoPaghe.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=Data;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA037FScaricoPaghe.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  C700DataDal:=R180InizioMese(DataIndietro);
  C700DataLavoro:=R180FineMese(Data);
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA037FScaricoPaghe.EliminaDataCassaClick(Sender: TObject);
var S:String;
begin
  S:=A037FScaricoPagheDtM1.A037FScaricoPagheMW.MessaggioEliminaDataCassa;
  //if MessageDlg(S, mtConfirmation, [mbNo, mbYes], 0) <> mrYes then
  if R180MessageBox(S,DOMANDA) <> IDYES then
    Abort
  else
  begin
    A037FScaricoPagheDtM1.A037FScaricoPagheMW.EliminaUltimaDataCassa;
    A037FScaricoPagheDtM1.GetUltimaDataCassa(True);
  end;
end;

procedure TA037FScaricoPaghe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA037FScaricoPaghe.FormDestroy(Sender: TObject);
begin
  //ListaAnomalie.Free;
  try
    A037FFiltroCodInterni.Release;
  except
  end;
  try
    A037FFiltroVoci.Release;
  except
  end;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA037FScaricoPaghe.DBLookupParPagheKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA037FScaricoPaghe.EdtDataChange(Sender: TObject);
begin
  DataScarico:=Data;
  try
    GestisciNomeFile;
  except
  end;
end;

end.
