unit R010UPaginaWeb;

interface

uses
  WR010UBase, WC501UMenuIrisWebFM,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, IWApplication,
  A000UInterfaccia, A000UCostanti, A000USessione, L021Call, Forms,
  StrUtils, OracleData, IWCompEdit, IWCompListBox, IWCompCheckbox,
  IWCompGrids, IWDBGrids, Menus, IWCompButton, IWCompMemo,
  meIWLink, IWCompLabel, meIWLabel, meIWImageFile, IW.Browser.InternetExplorer,
  SysUtils, Variants, Classes, ActnList, IWCompExtCtrls,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, Controls, IWGlobal, meIWButton,
  Vcl.Graphics, meIWImage;

type
  TParametriForm = record
    Progressivo: Integer;
    Dal,
    Al,
    DataFiltro: TDateTime;
    Tooltip,
    Chiamante,
    Matricola,
    CaptionIndietro,
    Causale:String;
    Completa,Singolo:Boolean;
  end;

  TR010FPaginaWeb = class(TWR010FBase)
    lblCommentoCorrente: TmeIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure TemplateProcessorUnknownTag(const AName: string; var VValue: string);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
  private
    procedure CreaIconeMenu;
    procedure DistruggiIconeMenu;
  protected
    IconeMenuArr: array of TmeIWImageFile;
    Responsabile: Boolean;
    procedure GestioneMenu; override;
    procedure NascondiMenu; override;
    function  GetInfoDebug: String; override;
    function  GetNomeFunzione: String; override;
    function  GetProgressivo: Integer; override;
    procedure AbilitazioneComponente(Componente:TIWCustomControl; Abilita:Boolean);
  public
    ParametriForm: TParametriForm;
    OldTag,
    OldArrInd: Integer;
    OldNewForm: Boolean;
    procedure SetParam(const Chiave, Valore: String); override;
    function  IsLoginForm: Boolean; override;
    procedure MessaggioStatus(const PTipo,PTesto,PTestoPopup: String; const PDurataPopup: Integer = 5000; const PDurataTesto: Integer = -1); override;
  end;

implementation

{$R *.dfm}

uses W001UIrisWebDtM, W001ULogin;

procedure TR010FPaginaWeb.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  lblCommentoCorrente.Caption:='';

  // inizializzazione parametri
  ParametriForm.Progressivo:=-1;
  ParametriForm.Matricola:='';
  ParametriForm.Tooltip:='';
  ParametriForm.Dal:=0;
  ParametriForm.Al:=0;
  ParametriForm.DataFiltro:=0;
  ParametriForm.Chiamante:='';
  ParametriForm.CaptionIndietro:='';
  ParametriForm.Completa:=False;
  ParametriForm.Singolo:=False;
  ParametriForm.Causale:='';
end;

procedure TR010FPaginaWeb.IWAppFormDestroy(Sender: TObject);
begin
  try DistruggiIconeMenu; except end;
  inherited;
end;

procedure TR010FPaginaWeb.IWAppFormRender(Sender: TObject);
var
  LImgW026Rich, LImgW026Aut: TmeIWImageFile;
  i: Integer;
begin
  inherited;

  // disabilita icona di accesso rapido "autorizzazione ecced. giornaliere"
  // in base a parametro aziendale C90_W026TipoRichiesta
  // cfr. WC501UMenuIrisWebFM.actExecute
  if Parametri.CampiRiferimento.C90_W026TipoRichiesta = 'A' then
  begin
    LImgW026Rich:=nil;
    LImgW026Aut:=nil;
    for i:=Low(IconeMenuArr) to High(IconeMenuArr) do
    begin
      case IconeMenuArr[i].Tag of
        432: LImgW026Rich:=IconeMenuArr[i];
        433: LImgW026Aut:=IconeMenuArr[i];
      end;
    end;

    // nasconde l'icona di autorizzazione ecced. gg.
    // e modifica il tooltip dell'icona di richiesta
    if (LImgW026Rich <> nil) and
       (LImgW026Rich.Visible) and
       (LImgW026Aut <> nil) and
       (LImgW026Aut.Visible) then
    begin
      LImgW026Aut.Visible:=False;
      LImgW026Rich.Hint:=LImgW026Aut.Hint;
    end;
  end;
end;

procedure TR010FPaginaWeb.SetParam(const Chiave, Valore: String);
var
  Par: String;
begin
  inherited SetParam(Chiave,Valore);

  // gestione parametri speciali
  Par:=UpperCase(Chiave);

  if Par = 'PROGRESSIVO' then
    ParametriForm.Progressivo:=StrToInt(Valore)
  else if Par = 'MATRICOLA' then
    ParametriForm.Matricola:=Valore
  else if Par = 'DAL' then
    ParametriForm.Dal:=StrToDate(Valore)
  else if Par = 'AL' then
    ParametriForm.Al:=StrToDate(Valore)
  else if Par = 'SINGOLO' then
    ParametriForm.Singolo:=StrToBool(Valore)
  else if Par = 'DATA_FILTRO' then
    ParametriForm.DataFiltro:=StrToDate(Valore)
  else if Par = 'CAPTION_INDIETRO' then
    ParametriForm.CaptionIndietro:=Valore
  else if Par = 'COMPLETA' then
    ParametriForm.Completa:=StrToBool(Valore)
  else if Par = 'CHIAMANTE' then
    ParametriForm.Chiamante:=Valore
  else if Par = 'CAUSALE' then
    ParametriForm.Causale:=Valore;
end;

procedure TR010FPaginaWeb.CreaIconeMenu;
// creazione delle icone di accesso rapido per il menu
// la visibilità delle icone è determinata in WR010UBase.AbilitaFunzioni
var
  i, x, f: Integer;
  UrlImg, Code, FunzDesc: String;
  TmpMenu: TWC501FMenuIrisWebFM;
  Azione: TAction;
  ImgList: TStringList;
  FunzAbil: Boolean;
begin
  // PRE: Length(IconeMenuArr) = 0;

  // esce subito se il menu non è creato
  if IsLoginForm or (not Assigned(WMenuFM)) then
    Exit;

  // ciclo su ActionList per riportare le icone
  ImgList:=TStringList.Create;
  TmpMenu:=(WMenuFM as TWC501FMenuIrisWebFM);
  for i:=0 to TmpMenu.ActionList.ActionCount - 1 do
  begin
    UrlImg:='';
    Azione:=(TmpMenu.ActionList.Actions[i] as TAction);
    FunzAbil:=False;
    for f:=0 to High(Parametri.AbilitazioniFunzioni) do
      if Parametri.AbilitazioniFunzioni[f].Tag = Azione.Tag then
      begin
        FunzAbil:=(Parametri.AbilitazioniFunzioni[f].Inibizione = 'S') or (Parametri.AbilitazioniFunzioni[f].Inibizione = 'R');
        FunzDesc:=Azione.Caption;
        if FunzAbil and
           (WR000DM <> nil) and
           (WR000DM.TipoUtente = 'Supervisore') and
           ((Pos('Autorizzazione',FunzDesc) = 1) or
            (FunzDesc = 'Validazione cartellino')) then
          FunzAbil:=False;
        Break;
      end;
    if (Azione.ImageIndex > -1) and FunzAbil then
    begin
      // crea una nuova icona e la aggiunge all'array
      x:=Length(IconeMenuArr);
      SetLength(IconeMenuArr,x + 1);

      IconeMenuArr[x]:=TmeIWImageFile.Create(Self);
      IconeMenuArr[x].Name:=Format('imgIcona%.2d',[x + 1]);
      IconeMenuArr[x].Parent:=Self;
      IconeMenuArr[x].AltText:=Azione.Caption;
      IconeMenuArr[x].Cacheable:=True;
      IconeMenuArr[x].Css:='icona_sez3';
      IconeMenuArr[x].Hint:=Azione.Hint;
      { DONE : TEST IW 15 OK }
      //UrlImg:=gSC.CacheURL + TmpMenu.IWImageList.ExtractImageToCache(Azione.ImageIndex); // v. IWCompMenu.pas
      UrlImg:=TmpMenu.IWImageList.ExtractImageToCache(Azione.ImageIndex); // v. IWCompMenu.pas
      // aggiunge l'url alla lista per il preload
      ImgList.Add(UrlImg);
      IconeMenuArr[x].ImageFile.URL:=UrlImg;
      IconeMenuArr[x].Tag:=Azione.Tag;
      IconeMenuArr[x].OnClick:=TmpMenu.actExecute;
    end;
  end;

  // utilizza una funzione js per precaricare le immagini
  if ImgList.Count > 0 then
  begin
    Code:='try { ' +
          '  preloadImgVar("%s"); ' +
          '} ' +
          'catch(err) {} ';
    Code:=Format(Code,[ImgList.CommaText]);
    AddToInitProc(Code);
  end;
  FreeAndNil(ImgList);
end;

procedure TR010FPaginaWeb.DistruggiIconeMenu;
// distruzione icone di accesso rapido per il menu
var
  i: Integer;
begin
  for i:=Low(IconeMenuArr) to High(IconeMenuArr) do
    try FreeAndNil(IconeMenuArr[i]); except end;

  SetLength(IconeMenuArr,0);
end;

procedure TR010FPaginaWeb.NascondiMenu;
var
  i: Integer;
begin
  inherited;

  // icone di accesso rapido
  for i:=Low(IconeMenuArr) to High(IconeMenuArr) do
    try IconeMenuArr[i].Visible:=False except end;
end;

function TR010FPaginaWeb.IsLoginForm: Boolean;
begin
  Result:=medpCodiceForm = 'W001';
end;

procedure TR010FPaginaWeb.GestioneMenu;
// viene richiamata nella WR010UBase
  function IsMenuVisibile:Boolean;
  // determina se il menu deve essere visualizzato
  begin
    Result:=False;

    // menu nascosto se form di login / progetto X001
    if IsLoginForm or (medpCodiceForm = 'X001') then
    begin
      Log('Traccia','Menu principale nascosto: form ' + medpCodiceForm);
      Exit;
    end;

    // menu nascosto se "Elenco anagrafe" non è presente nella history
    if WR000DM.History.FormByTag(-2) = nil then
    begin
      Log('Traccia','Menu principale nascosto: "Elenco anagrafe" non presente nella history - form ' + medpCodiceForm);
      Exit;
    end;

    // menu nascosto se pagina singola
    if (WR000DM.PaginaSingola <> '') and (WR000DM.PaginaSingola = WR000DM.PaginaIniziale) then
    begin
      Log('Traccia','Menu principale nascosto: Pagina singola ' + WR000DM.PaginaSingola);
      Exit;
    end;

    // il menu è visualizzabile
    Result:=True;
  end;
begin
  // form di login -> menu non creato
  if IsLoginForm then
    Exit;

  // se necessario, crea il menu
  if WMenuFM = nil then
  begin
    WMenuFM:=TWC501FMenuIrisWebFM.Create(Self);
    TraduzioneElementi(WMenuFM);
  end;

  // icone di accesso rapido
  if Length(IconeMenuArr) = 0 then
    CreaIconeMenu;

  if not IsMenuVisibile then
  begin
    NascondiMenu;
    Exit;
  end;
end;

procedure TR010FPaginaWeb.TemplateProcessorUnknownTag(const AName: string; var VValue: string);
begin
  if (WR000DM = nil) or (WR000DM.lstCompInvisibili = nil) then
    Exit;

  if WR000DM.lstCompInvisibili.IndexOf(Format('<%s>',[UpperCase(AName)])) >= 0 then
    Exit;

  inherited TemplateProcessorUnknownTag(AName,VValue);
end;

function TR010FPaginaWeb.GetInfoDebug: String;
var
  Info: String;
  i: Integer;
  DsAperti: Boolean;
begin
  Info:='[ Data e ora webserver ]' + CRLF + FormatDateTime('dd/mm/yyyy hhhh.mm.ss',Now) + CRLF + CRLF;
  try
    if WR000DM = nil then
      Exit;

    // parametri utente
    Info:=Info + '[ Dati utente ]' + CRLF;
    if IsLoginForm then
      Info:=Info + 'Utente non loggato' + CRLF
    else
      Info:=Info + 'TipoUtente: ' + WR000DM.TipoUtente + CRLF +
            'Responsabile: ' + IfThen(WR000DM.Responsabile,'S','N') + CRLF +
            'Inibizione individuale: ' + IfThen(Parametri.InibizioneIndividuale,'S','N') + CRLF +
            'AccessoDirettoValutatore: ' + WR000DM.AccessoDirettoValutatore + CRLF;

    // parametri aziendali
    Info:=Info + CRLF + '[ Parametri generici ]' + CRLF +
          'Num. righe tabella: ' + IfThen(Parametri.CampiRiferimento.C90_WebRighePag = '','-',Parametri.CampiRiferimento.C90_WebRighePag) + CRLF +
          'LogoutUrl: ' + IfThen(WR000DM.LogoutUrl = '','-',WR000DM.LogoutUrl) + CRLF;

    // form array
    if WR000DM.History <> nil then
    begin
      Info:=Info + Format('FormArray num. elem: %d'#13#10'GGetWebApplicationThreadVar.ActiveFormCount: %d',
                          [WR000DM.History.Count,GGetWebApplicationThreadVar.ActiveFormCount]) + CRLF;
    end;

    // parametri form
    Info:=Info + CRLF +
          '[ Parametri form ]' + CRLF +
          'Chiamante: ' + IfThen(ParametriForm.Chiamante = '','-',ParametriForm.Chiamante) + CRLF +
          'Progressivo: ' + IfThen(ParametriForm.Progressivo < 0,'-',IntToStr(ParametriForm.Progressivo)) + CRLF +
          'Dal: ' + IfThen(ParametriForm.Dal = 0,'-',DateToStr(ParametriForm.Dal)) + ' / ' +
          'Al: ' + IfThen(ParametriForm.Al = 0,'-',DateToStr(ParametriForm.Al)) + CRLF +
          'DataFiltro: ' + IfThen(ParametriForm.DataFiltro = 0,'-',DateToStr(ParametriForm.DataFiltro)) + CRLF +
          'Matricola: ' + IfThen(ParametriForm.Matricola = '','-',ParametriForm.Matricola) + CRLF;

    // dataset anagrafico
    Info:=Info + CRLF + '[ Dataset anagrafico ]' + CRLF;
    with WR000DM.cdsI010 do
    begin
      if Active then
        Info:=Info + Format('cdsI010.Filtered: %s'#13#10'cdsI010.RecordCount: %d',
                            [IfThen(Filtered,'True','False'),
                             RecordCount]) + CRLF
      else
        Info:=Info + 'cdsI010.Active: False' + CRLF;
    end;

    // database
    DsAperti:=False;
    Info:=Info + CRLF + '[ Dataset condivisi aperti ]' + CRLF;
    for i:=0 to WR000DM.ComponentCount - 1 do
    begin
      if WR000DM.Components[i] is TOracleDataSet then
      begin
        with (WR000DM.Components[i] as TOracleDataSet) do
        begin
          if Active then
          begin
            Info:=Info + Format('%s: Tag = %d Recordcount = %d',
                         [Name,Tag,RecordCount]) + CRLF;
            DsAperti:=True;
          end;
        end
      end;
    end;
    if not DsAperti then
      Info:=Info + 'Nessun dataset' + CRLF;

    // filtro dipendenti
    {
    Info:=Info + CRLF + '[ Selezione anagrafica principale ]' + CRLF;
    if IsLoginForm then
      Info:=Info + 'Nessuna selezione'
    else
      Info:=Info + 'FiltroRicerca:' + CRLF + WR000DM.FiltroRicerca + CRLF +
            'OrdinamentoRicerca:' + CRLF + WR000DM.OrdinamentoRicerca;
    }
  except
    on E: Exception do
      Log('Errore','Errore durante lettura informazioni debug',E);
  end;

  Result:=Info;
end;

function TR010FPaginaWeb.GetNomeFunzione: String;
var
  x: Integer;
begin
  // gestione casi particolari
  Result:='';

  // traduzione in lingua inglese
  //if (Parametri.CampiRiferimento.C1_CedoliniConValuta = 'S') and
  if (Parametri.CampiRiferimento.C90_Lingua <> '') and
     (WR000DM.cdsI015.Active) then
  begin
    // filtro del clientdataset sui componenti della maschera attuale + comp. ereditati
    with WR000DM do
    begin
      cdsI015.Filtered:=False;
      cdsI015.Filter:=Format('(MASCHERA = ''%s'') and (COMPONENTE = ''Title'')',[medpNomeForm]);
      cdsI015.Filtered:=True;
      if cdsI015.RecordCount > 0 then
      begin
        // verifica caption del tipo "(W000) Titolo form"
        x:=Pos(')',cdsI015.FieldByName('CAPTION').AsString);
        if x = 0 then
          Result:=cdsI015.FieldByName('CAPTION').AsString
        else
          Result:=Copy(cdsI015.FieldByName('CAPTION').AsString,x + 2,MaxInt);
      end;
    end;
  end;

  // nessuna traduzione per l'elemento: gestione normale
  if Result = '' then
  begin
    if (Tag = 432) and
       (Parametri.CampiRiferimento.C90_W026TipoRichiesta = 'A') then
    begin
      // caso particolare delle eccedenze giornaliere
      Result:='Autorizzazione ecced. giornaliere';
    end
    else
    begin
      Result:=inherited GetNomeFunzione;
    end;
  end;
end;

function TR010FPaginaWeb.GetProgressivo: Integer;
begin
  Result:=-1;
  if WR000DM <> nil then
    if WR000DM.cdsAnagrafe.Active then
      Result:=WR000DM.cdsAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;


procedure TR010FPaginaWeb.AbilitazioneComponente(Componente:TIWCustomControl; Abilita:Boolean);
// abilita / disabilita il componente specificato
var
  r,c:Integer;
begin
  if Componente is TIWCustomLabel then
  begin
    // label: simula abilitazione via css (cfr. meIWLabel)
    with TIWCustomLabel(Componente) do
    begin
      Enabled:=Abilita;
    end;
  end
  else if Componente is TIWGrid then
  begin
    // grid: ciclo sui componenti relativi
    with Componente as TIWGrid do
    begin
      for r:=0 to RowCount - 1 do
      begin
        for c:=0 to ColumnCount - 1 do
        begin
          if not Abilita then
            Cell[r,c].Clickable:=False;
          if Assigned(Cell[r,c].Control) then
            AbilitazioneComponente(Cell[r,c].Control,Abilita);
        end;
      end;
    end;
  end
  else if Componente is TIWRadioGroup then
  begin
    // radio group
    with TIWRadioGroup(Componente) do
    begin
      Editable:=Abilita;
      Enabled:=Abilita;
    end;
  end
  else if Componente is TIWCustomComboBox then
  begin
    // combobox
    with (Componente as TIWCustomComboBox) do
    begin
      Enabled:=Abilita;
    end;
  end
  else if Componente is TIWCustomCheckBox then
  begin
    // checkbox
    with (Componente as TIWCustomCheckBox) do
    begin
      Editable:=Abilita;
      Enabled:=Abilita;
    end;
  end
  else if Componente is TIWCustomEdit then
  begin
    // edit
    with (Componente as TIWCustomEdit) do
    begin
      Editable:=Abilita;
      Enabled:=Abilita;
    end;
  end
  else if Componente is TIWCustomMemo then
  begin
    // memo
    with (Componente as TIWCustomMemo) do
    begin
      Editable:=Abilita;
      Enabled:=Abilita;
    end;
  end
  else
  begin
    // altro tipo di componente
    Componente.Enabled:=Abilita;
  end;
end;

procedure TR010FPaginaWeb.MessaggioStatus(const PTipo,PTesto, PTestoPopup: String; const PDurataPopup: Integer = 5000; const PDurataTesto: Integer = -1);
var
  Stile,S,SPop,TestoJS,TestoJSPopup,
  ObjName,DurataTestoStr: String;
const
  // costanti di tempo per effetti - valori espressi in millisecondi
  HIGHLIGHT_TIME      = 1200; // durata evidenziazione testo
  FADE_IN_TIME_TESTO  = 1200; // durata dissolvenza in entrata del testo
  FADE_IN_TIME_POPUP  = 1500; // durata dissolvenza in entrata del popup
  FADE_OUT_TIME_TESTO = 1500; // durata dissolvenza in uscita del testo
  FADE_OUT_TIME_POPUP = 4000; // ms per effetto di dissolvenza in uscita del popup
begin
  // determina stile messaggio in base al tipo
  if PTipo = INFORMA then
    Stile:='informazione'
  else if PTipo = ESCLAMA then
    Stile:='esclamazione'
  else if PTipo = ERRORE then
    Stile:='segnalazione'
  else
    raise Exception.Create('Parametri errati per la funzione TR010FPaginaWeb.MessaggioStatus');

  lblCommentoCorrente.Css:=Stile;
  if not jQAlert.Enabled then
  begin
    // visualizzazione messaggio statico
    lblCommentoCorrente.Caption:=PTesto;
    lblCommentoCorrente.Hint:=PTestoPopup;
  end
  else
  begin
    // visualizzazione messaggio con effetti jquery
    // rimuove e sostituisce caratteri pericolosi dal testo per visualizzazione via javascript
    if PTesto = '' then
      TestoJS:=''
    else
      TestoJS:=C190EscapeJS(PTesto);
    if PTestoPopup = '' then
      TestoJSPopup:=''
    else
      TestoJSPopup:=C190EscapeJS(PTestoPopup);

    // prepara codice javascript
    jqAlert.OnReady.Clear;
    ObjName:=lblCommentoCorrente.HTMLName;

    // testo messaggio
    S:='$("#int_sez4").hide().attr("class","%s"); ' +
       '$("#%s").text("%s"); ' +
       '$("#int_sez4").animate({opacity: "toggle", height: "toggle"},%d).delay(1000).effect("highlight",%d)%s';

    if PDurataTesto > 0 then
      DurataTestoStr:=Format('.delay(%d).effect("highlight",%d).hide("slide",{direction: "up"},%d)',[PDurataTesto,HIGHLIGHT_TIME,FADE_OUT_TIME_TESTO])
    else
      DurataTestoStr:='';
    S:=Format(S,[Stile,ObjName,TestoJS,FADE_IN_TIME_TESTO,HIGHLIGHT_TIME,DurataTestoStr]);

    // testo del popup a scomparsa (elemento div in primo piano)
    if (TestoJSPopup <> '') and (PDurataPopup > 0) then
    begin
      if PTipo = ERRORE then
        TestoJSPopup:='Attenzione! Si è verificato il seguente errore:\r\n' + TestoJSPopup;

      if GetBrowser is TInternetExplorer then
        SPop:='$("#avviso").attr("class","").attr("class","%s")'
      else
        SPop:='$("#avviso").attr("class","").addClass("%s")';
      SPop:=SPop + '.hide().text("%s").fadeIn(%d)' +
                   '.delay(%d).effect("transfer",{to: "#int_sez4",className: "ui-effects-transfer"},1000)' +
                   '.fadeOut(100,function(){ %s' +
                   '});';
      S:=Format(Spop,[Stile,TestoJSPopup,FADE_IN_TIME_POPUP,PDurataPopup,S]);
      jqAlert.OnReady.Add(S);
    end
    else
    begin
      jqAlert.OnReady.Add(S);
    end;
  end;
end;


end.
