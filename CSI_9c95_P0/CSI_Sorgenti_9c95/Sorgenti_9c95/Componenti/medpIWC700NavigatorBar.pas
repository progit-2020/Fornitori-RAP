unit medpIWC700NavigatorBar;

interface

uses
  SysUtils, Classes, Controls, StrUtils, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompGrids, meIWGrid, meIWImageFile, ActnList,
  Db, OracleData, meIWDBLabel,
  A000UInterfaccia, WC700USelezioneAnagrafeDM, WC700USelezioneAnagrafeFM,
  System.Actions, WC003URicercaDatiFM;

type
  Tproc = procedure of object;
  TprocSender = procedure(Sender: TObject) of object;

  TmedpIWC700NavigatorBar = class(TmeIWGrid)
  private
    ActionList: TActionList;
    FAttivaBrowse: Boolean;
    FAttivaEredita: Boolean;
    FAttivaLabel: Boolean;
    FSelezioneDaEreditare: TC700SelAnagrafeBridge;
    FEreditaSelezioneSpecifica: Boolean;
    FInibisciColoreFont: Boolean;
    procedure CreaNavigatorBar;
    procedure CreaActionList;
    procedure CreaWC700;
    procedure grdC700NavigatorBarRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure SetAttivaBrowse(const Value: Boolean);
    procedure setSelezioneDaEreditare(const Value: TC700SelAnagrafeBridge);
    procedure C700NavBarClick(Sender: TObject);
    procedure SetAttivaEredita(const Value: Boolean);
    procedure SetAttivaLabel(const Value: Boolean);
    procedure CercaResultEvent;
  protected
    { Protected declarations }
  public
    Impostazioni:Tproc;
    AggiornaAnagr:Tproc;
    CambioProgressivoEvent:TprocSender;
    AperturaSelezioneEvent:TprocSender;
    WC700DM:TWC700FSelezioneAnagrafeDM;
    WC700FM:TWC700FSelezioneAnagrafeFM;
    ImpostaProgressivoCorrente,
    SelezioneVuota: Boolean;
    selAnagrafe:TOracleDataSet;
    constructor Create(AOwner:TComponent); override;
    procedure AggiornaToolBar(ToolBarGrid:TIWGrid;ActionList:TActionList);
    procedure AbilitaToolbar(Abilita: Boolean); virtual;
    procedure actSelezioneAnagraficheExecute(Sender: TObject);
    procedure actC700EreditaSelezioneExecute(Sender: TObject);
    procedure actC700CercaExecute(Sender: TObject);
    procedure actC700PrimoExecute(Sender: TObject);
    procedure actC700PrecedenteExecute(Sender: TObject);
    procedure actC700SuccessivoExecute(Sender: TObject);
    procedure actC700UltimoExecute(Sender: TObject);
    procedure AggiornaGrdToolBar;
    procedure CreaSelezioneIniziale(SettaImpostazioni: Boolean);
    procedure AddToActionList(Action: TAction);
    property SelezioneDaEreditare:TC700SelAnagrafeBridge read FSelezioneDaEreditare write setSelezioneDaEreditare;
    property AttivaEredita: Boolean read FAttivaEredita write SetAttivaEredita;
    property InibisciColoreFont: Boolean read FInibisciColoreFont write FInibisciColoreFont;
    procedure SelezionaProgressivo(Progressivo: Integer);
  published
    property AttivaBrowse: Boolean read FAttivaBrowse write SetAttivaBrowse;
    property AttivaLabel: Boolean read FAttivaLabel write SetAttivaLabel;
  end;

implementation

uses C190FunzioniGeneraliWeb;

constructor TmedpIWC700NavigatorBar.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  //UseFrame:=False; // default
  //UseSize:=False; // default
  Name:='grdC700NavigatorBar';
  Caption:='';
  Css:='medpToolBar';
  if Owner is TWinControl then
    Parent:=(Owner as TWinControl);
  FAttivaBrowse:=False; // default iniziale
  FAttivaEredita:=True; // default iniziale
  FAttivaLabel:=True;   // default iniziale
  FInibisciColoreFont:=False;
  ImpostaProgressivoCorrente:=True;
  SelezioneVuota:=True;
  CreaActionList;
  CreaWC700;
  CreaNavigatorBar;
  AttivaBrowse:=True;
  OnRenderCell:=grdC700NavigatorBarRenderCell;
  FEreditaSelezioneSpecifica:=False;

end;

procedure TmedpIWC700NavigatorBar.grdC700NavigatorBarRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
var
  DataInizioRap,
  DataFineRap: TDateTime;
begin
  if ACell.Control = nil then
    exit;

  if Pos('medpFontSelAnagrafe',ACell.Control.Css) > 0 then
  begin
    ACell.Control.Css:='medpFontSelAnagrafe';
    if InibisciColoreFont then //visualizza sempre in nero. usato quando vi sono elaborazionei
    begin
      ACell.Control.Css:=ACell.Control.Css + 'font_neroImp';
      Exit;
    end;
    //Cella contenente dati dipendente selezionato
    with selAnagrafe do
    begin
      if (WC700FM.C700DipendentiCessatiVal) and
         (State <> dsInactive) and
         (RecordCount > 0) then
      begin
        DataFineRap:=FieldByName('T430FINE').AsDateTime;
        if DataFineRap = 0 then
          DataFineRap:=EncodeDate(3999,12,31);
        DataInizioRap:=FieldByName('T430INIZIO').AsDateTime;
        if DataInizioRap = 0 then
          DataInizioRap:=EncodeDate(1899,12,30);
          //Caratto 08/04/2013 Controllo cessato in base a dataLavoro impostata sulla WC700
//        if ( (DataInizioRap > Parametri.DataLavoro) or (DataFineRap < Parametri.DataLavoro) )then
          if ( (DataInizioRap > WC700FM.C700DataLavoro) or (DataFineRap < WC700FM.C700DataLavoro) )then
          ACell.Control.Css:=ACell.Control.Css + ' font_rossoImp';
      end;
    end;
  end;
end;

procedure TmedpIWC700NavigatorBar.CreaActionList;
var
  Action1, Action2, Action3, Action4, Action5,
  Action6, Action7, Action8, Action9, Action10,
  Action11:TAction;
begin
  ActionList:=TActionList.Create(Self);

  Action1:=TAction.Create(Self);
  Action1.Caption:='btnC700SelezioneAnagrafe';
  Action1.Category:='Selezione';
  Action1.Hint:='Selezione anagrafiche';
  Action1.Name:='actC700SelezioneAnagrafiche';
  Action1.Tag:=1;
  Action1.OnExecute:=actSelezioneAnagraficheExecute;
  Action1.ActionList:=ActionList;

  Action2:=TAction.Create(Self);
  Action2.Caption:='btnC700Aggiorna';
  Action2.Category:='Selezione';
  Action2.Hint:='Eredita selezione';
  Action2.Name:='actC700EreditaSelezione';
  Action2.Tag:=2;
  Action2.OnExecute:=actC700EreditaSelezioneExecute;
  Action2.ActionList:=ActionList;

  Action3:=TAction.Create(Self);
  Action3.Caption:='btnC700Cerca';
  Action3.Category:='Cerca';
  Action3.Hint:='Ricerca';
  Action3.Name:='actC700Cerca';
  Action3.Tag:=3;
  Action3.OnExecute:=actC700CercaExecute;
  Action3.ActionList:=ActionList;

  Action4:=TAction.Create(Self);
  Action4.Caption:='btnC700Primo';
  Action4.Category:='Navigazione';
  Action4.Hint:='Primo';
  Action4.Name:='actC700Primo';
  Action4.Tag:=4;
  Action4.OnExecute:=actC700PrimoExecute;
  Action4.ActionList:=ActionList;

  Action5:=TAction.Create(Self);
  Action5.Caption:='btnC700Precedente';
  Action5.Category:='Navigazione';
  Action5.Hint:='Precedente';
  Action5.Name:='actC700Precedente';
  Action5.Tag:=5;
  Action5.OnExecute:=actC700PrecedenteExecute;
  Action5.ActionList:=ActionList;

  Action6:=TAction.Create(Self);
  Action6.Caption:='btnC700Successivo';
  Action6.Category:='Navigazione';
  Action6.Hint:='Successivo';
  Action6.Name:='actC700Successivo';
  Action6.Tag:=6;
  Action6.OnExecute:=actC700SuccessivoExecute;
  Action6.ActionList:=ActionList;

  Action7:=TAction.Create(Self);
  Action7.Caption:='btnC700Ultimo';
  Action7.Category:='Navigazione';
  Action7.Hint:='Ultimo';
  Action7.Name:='actC700Ultimo';
  Action7.Tag:=7;
  Action7.OnExecute:=actC700UltimoExecute;
  Action7.ActionList:=ActionList;

  Action8:=TAction.Create(Self);
  Action8.Category:='Progressivo';
  Action8.Name:='actC700Progressivo';
  Action8.Tag:=1001;
  Action8.ActionList:=ActionList;

  Action9:=TAction.Create(Self);
  Action9.Category:='Matricola';
  Action9.Name:='actC700Matricola';
  Action9.Tag:=1002;
  Action9.ActionList:=ActionList;

  Action10:=TAction.Create(Self);
  Action10.Category:='Cognome';
  Action10.Name:='actC700Cognome';
  Action10.Tag:=1003;
  Action10.ActionList:=ActionList;

  Action11:=TAction.Create(Self);
  Action11.Category:='Nome';
  Action11.Name:='actC700Nome';
  Action11.Tag:=1004;
  Action11.ActionList:=ActionList;

end;

procedure TmedpIWC700NavigatorBar.AddToActionList(Action: TAction);
begin
  Action.ActionList:=ActionList;
  CreaNavigatorBar;
  AggiornaToolBar(Self,ActionList);
end;

procedure TmedpIWC700NavigatorBar.AggiornaGrdToolBar;
begin
  AggiornaToolBar(Self,ActionList);
end;

procedure TmedpIWC700NavigatorBar.AggiornaToolBar(ToolBarGrid:TIWGrid;ActionList:TActionList);
// Imposta le proprietà Visible e Enabled dei pulsanti legati alle Action delle ToolBar
var
  i, k:Integer;
  PrecCategory,NomeFile: String;
  img: TmeIWImageFile;
  act: TAction;
begin
  if ActionList.ActionCount > 0 then
    PrecCategory:=(ActionList.Actions[0] as TAction).Category;

  k:=0;
  for i:=0 to ActionList.ActionCount - 1 do
  begin
    if PrecCategory <> (ActionList.Actions[i] as TAction).Category  then
    begin
      k:=k + 1;
      PrecCategory:=(ActionList.Actions[i] as TAction).Category;
    end;
    if k > ToolBarGrid.ColumnCount - 1 then
      Break;

    //img:=TmeIWImageFile(ToolBarGrid.Cell[0,k].Control);
    act:=(ActionList.Actions[i] as TAction);

    ToolBarGrid.Cell[0,k].Visible:=act.Visible;
    //if act.Tag < 1000 then
    if ToolBarGrid.Cell[0,k].Control is TmeIWImageFile then
    begin
      if act.Visible then
      begin
        img:=(ToolBarGrid.Cell[0,k].Control as TmeIWImageFile);
        img.Hint:=act.Hint;
        img.Enabled:=act.Enabled;
        NomeFile:=act.Caption + IfThen(not act.Enabled,'_Disabled') + IfThen(act.Checked,'_Checked');
        img.ImageFile.FileName:=Format('img/%s.png',[NomeFile]);
      end;
    end
    else
    begin
      if ToolBarGrid.Cell[0,k].Control <> nil then
        (ToolBarGrid.Cell[0,k].Control as TIWCustomControl).Enabled:=act.Enabled;
    end;
    k:=k + 1;
  end;
end;

procedure TmedpIWC700NavigatorBar.C700NavBarClick(Sender: TObject);
begin
  (ActionList.Actions[TmeIWImageFile(Sender).Tag] as TAction).Execute;
end;

procedure TmedpIWC700NavigatorBar.actSelezioneAnagraficheExecute(Sender: TObject);
begin
  if Assigned(AperturaSelezioneEvent) then
    AperturaSelezioneEvent(Self);
  WC700FM.Visible:=True;
  WC700FM.Visualizza;
end;

procedure TmedpIWC700NavigatorBar.actC700EreditaSelezioneExecute(Sender: TObject);
begin
  inherited;
  //Se specificata una selezione eredita da questa, altrimenti da WA001
  if FEreditaSelezioneSpecifica then
    WC700FM.EreditaSelezione(FSelezioneDaEreditare)
  else if WR000DM.C700NavigatorBarMain <> nil then
    WC700FM.EreditaSelezione(TmedpIWC700NavigatorBar(WR000DM.C700NavigatorBarMain).WC700FM.C700SelAnagrafeBridge);
end;

procedure TmedpIWC700NavigatorBar.CercaResultEvent;
begin
  if Assigned(AggiornaAnagr) then
    AggiornaAnagr;
  if Assigned(CambioProgressivoEvent) then
    CambioProgressivoEvent(Self);
end;

procedure TmedpIWC700NavigatorBar.actC700CercaExecute(Sender: TObject);
begin
  with TWC003FRicercaDatiFM.Create(Self.Owner) do
  begin
    rgpTipologia.Visible:=False;
    SearchGrid:=nil;
    SearchDataset:=selAnagrafe;
    ResultEvent:=CercaResultEvent;
    Visualizza;
  end;
end;

procedure TmedpIWC700NavigatorBar.actC700PrimoExecute(Sender: TObject);
begin
  selAnagrafe.First;
  if Assigned(AggiornaAnagr) then
    AggiornaAnagr;
  if Assigned(CambioProgressivoEvent) then
    CambioProgressivoEvent(Sender);
end;

procedure TmedpIWC700NavigatorBar.actC700PrecedenteExecute(Sender: TObject);
begin
  selAnagrafe.Prior;
  if Assigned(AggiornaAnagr) then
    AggiornaAnagr;
  if Assigned(CambioProgressivoEvent) then
    CambioProgressivoEvent(Sender);
end;

procedure TmedpIWC700NavigatorBar.actC700SuccessivoExecute(Sender: TObject);
begin
  selAnagrafe.Next;
  if Assigned(AggiornaAnagr) then
    AggiornaAnagr;
  if Assigned(CambioProgressivoEvent) then
    CambioProgressivoEvent(Sender);
end;

procedure TmedpIWC700NavigatorBar.actC700UltimoExecute(Sender: TObject);
begin
  selAnagrafe.Last;
  if Assigned(AggiornaAnagr) then
    AggiornaAnagr;
  if Assigned(CambioProgressivoEvent) then
    CambioProgressivoEvent(Sender);
end;

procedure TmedpIWC700NavigatorBar.SetAttivaBrowse(const Value: Boolean);
begin
  if FAttivaBrowse <> Value then
  begin
    FAttivaBrowse:=Value;
    (ActionList.Actions[2] as TAction).Visible:=AttivaBrowse; // actC700Cerca
    (ActionList.Actions[3] as TAction).Visible:=AttivaBrowse; // actC700Primo
    (ActionList.Actions[4] as TAction).Visible:=AttivaBrowse; // actC700Precedente
    (ActionList.Actions[5] as TAction).Visible:=AttivaBrowse; // actC700Successivo
    (ActionList.Actions[6] as TAction).Visible:=AttivaBrowse; // actC700Ultimo
    if ColumnCount > 0 then
      AggiornaToolBar(Self, ActionList);
  end;
end;

procedure TmedpIWC700NavigatorBar.SetAttivaEredita(const Value: Boolean);
begin
  if FAttivaEredita <> Value then
  begin
    FAttivaEredita:=Value;
    (ActionList.Actions[1] as TAction).Visible:=FAttivaEredita;
    if ColumnCount > 0 then
      AggiornaToolBar(Self,ActionList);
  end;
end;

procedure TmedpIWC700NavigatorBar.SetAttivaLabel(const Value: Boolean);
begin
  if FAttivaLabel <> Value then
  begin
    FAttivaLabel:=Value;
    ShowEmptyCells:=FAttivaLabel;
    (ActionList.Actions[7] as TAction).Visible:=FAttivaLabel;  // progressivo
    (ActionList.Actions[8] as TAction).Visible:=FAttivaLabel;  // matricola
    (ActionList.Actions[9] as TAction).Visible:=FAttivaLabel;  // cognome
    (ActionList.Actions[10] as TAction).Visible:=FAttivaLabel; // nome
    if ColumnCount > 0 then
      AggiornaToolBar(Self,ActionList);
  end;
end;

procedure TmedpIWC700NavigatorBar.AbilitaToolbar(Abilita: Boolean);
var i: Byte;
begin
  for i:=0 to ActionList.ActionCount - 1 do
    (ActionList.Actions[i] as TAction).Enabled:=Abilita;
  AggiornaToolBar(Self,ActionList);
end;

procedure TmedpIWC700NavigatorBar.CreaNavigatorBar;
var
  i, k:Integer;
  PrecCategory: String;
begin
  RowCount:=1;
  if ActionList.ActionCount > 0 then
    PrecCategory:=(ActionList.Actions[0] as TAction).Category;
  ColumnCount:=ActionList.ActionCount;

  k:=0;
  for i:=0 to ActionList.ActionCount - 1 do
  begin
    if PrecCategory <> (ActionList.Actions[i] as TAction).Category  then
    begin
      Cell[0,k].Text:='';
      Cell[0,k].Css:='x';
      k:=k + 1;
      ColumnCount:=ColumnCount + 1;
      PrecCategory:=(ActionList.Actions[i] as TAction).Category;
    end;

    Cell[0,k].Visible:=(ActionList.Actions[i] as TAction).Visible;
    Cell[0,k].Text:='';
    Cell[0,k].Css:='x';
    if (ActionList.Actions[i] as TAction).Name = 'actC700Progressivo' then
    begin
      Cell[0,k].Control:=TmeIWDBLabel.Create(Self.Owner);
      with (Cell[0,k].Control as TmeIWDBLabel) do
      begin
	    { DONE : TEST IW 15 }
        //DontSubmitFiles:=True;
        DataField:='Progressivo';
        DataSource:=WC700DM.dscAnagrafe;
        Css:='medpFontSelAnagrafe';
      end;
    end
    else if (ActionList.Actions[i] as TAction).Name = 'actC700Matricola' then
    begin
      Cell[0,k].Control:=TmeIWDBLabel.Create(Self.Owner);
      with (Cell[0,k].Control as TmeIWDBLabel) do
      begin
        { DONE : TEST IW 15 }
        //DontSubmitFiles:=True;
        DataField:='Matricola';
        DataSource:=WC700DM.dscAnagrafe;
        Css:='medpFontSelAnagrafe';
      end;
    end
    else if (ActionList.Actions[i] as TAction).Name = 'actC700Cognome' then
    begin
      Cell[0,k].Control:=TmeIWDBLabel.Create(Self.Owner);
      with (Cell[0,k].Control as TmeIWDBLabel) do
      begin
        { DONE : TEST IW 15 }
        //DontSubmitFiles:=True;
        DataField:='Cognome';
        DataSource:=WC700DM.dscAnagrafe;
        Css:='medpFontSelAnagrafe';
      end;
    end
    else if (ActionList.Actions[i] as TAction).Name = 'actC700Nome' then
    begin
      Cell[0,k].Control:=TmeIWDBLabel.Create(Self.Owner);
      with (Cell[0,k].Control as TmeIWDBLabel) do
      begin
        { DONE : TEST IW 15 }
        //DontSubmitFiles:=True;
        DataField:='Nome';
        DataSource:=WC700DM.dscAnagrafe;
        Css:='medpFontSelAnagrafe';
      end;
    end
    else
    begin
      Cell[0,k].Control:=TmeIWImageFile.Create(Self.Owner);
      with (Cell[0,k].Control as TmeIWImageFile) do
      begin
        //Name:=C190CreaNomeComponente(Name,Owner);
        OnClick:=C700NavBarClick;
        Tag:=i;
        { DONE : TEST IW 15 }
        //DontSubmitFiles:=True;
        RenderSize:=False;
        Font.Enabled:=False;
        UseSize:=False;
        with StyleRenderOptions do
        begin
          RenderAbsolute:=False;
          RenderFont:=False;
          RenderPosition:=False;
          RenderSize:=False;
          RenderStatus:=True;
          RenderVisibility:=True;
          RenderZIndex:=False;
        end;
      end;
    end;

    k:=k + 1;
  end;

  AggiornaToolBar(Self, ActionList);
end;

procedure TmedpIWC700NavigatorBar.CreaWC700;
begin
  WC700DM:=TWC700FSelezioneAnagrafeDM.Create(Self.Owner);
  WC700FM:=TWC700FSelezioneAnagrafeFM.Create(Self.Owner);
  WC700FM.WC700NavigatorBar:=Self;
  WC700FM.WC700DM:=WC700DM;
  WC700FM.Parent:=Parent;
  WC700FM.Visible:=False;
  //settaggio default
  WC700FM.C700SelezionePeriodica:=False;
  WC700FM.C700PersonaleInterno:=False;
  WC700FM.C700DipendentiCessati:=True;
  WC700FM.C700DipendentiCessatiVal:=True;
  //Caratto 0/10/204 per default date impostate con datalavoro
  WC700FM.C700DataLavoro:=Parametri.DataLavoro;
  WC700FM.C700DataDal:=Parametri.DataLavoro;
  selAnagrafe:=WC700DM.selAnagrafe;
  //CreaSelezioneIniziale(True);
end;

procedure TmedpIWC700NavigatorBar.CreaSelezioneIniziale(SettaImpostazioni: Boolean);
var
  ProgressivoCorrente: Integer;
begin
  //Caratto 18/12/2012 Imposto progressivo con il valore corrente di WA001
  //se ImpostaProgressivoCorrente = True parte con selezionato il dipendente corrente su WA001
  //Se è False, valuta WR100SelezioneVuotaWC700 per verificare se partire con selezione nulla oppure con selezione del filtro anagrafe
  if ImpostaProgressivoCorrente then
  begin
    //Caratto 18/12/2012 Progressivo reperito da selezione iniziale
    if WR000DM.C700NavigatorBarMain <> nil then
      ProgressivoCorrente:=TmedpIWC700NavigatorBar(WR000DM.C700NavigatorBarMain).selAnagrafe.FieldByName('PROGRESSIVO').AsInteger
    //ProgressivoCorrente:=TWR100FBase(WR000DM.History.FormByTag(0)).WC700DM.SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger
    else //caratto 04/01/2013 se progetto singolo (non esiste WA001) imposta a 0
      ProgressivoCorrente:=0;
    WC700FM.C700Progressivo:=ProgressivoCorrente;
    //Massimo 22/05/2013 Se impostato un progressivo deve eseguire actConferma per poter selezionare
    //correttamente i campi. In Impostazioni si può cambiare C700DatiSelezionati e quindi deve essere
    //rieseguita la selezione (Es WA075. aggiunge campo RAPPORTI_UNITI)
    SelezioneVuota:=ProgressivoCorrente = 0;
  end
  else if SelezioneVuota then //caratto 10/01/2013 . se WR100SelezioneVuotaWC700 True parte con selezione vuota, altrimenti con filtro anagarafe dell'utente
  begin
    WC700FM.C700Progressivo:=0;
    //Caratto 21/02/2014
    //sul conferma vengono cambiati i displaylabel dei campi predefiniti.
    //Con selezione vuota non viene fatto perciò lo richiamo esplicitamente
    WC700FM.ImpostazioniCampiSelAnagrafe;
  end;

  //Impostazioni specifiche (es campi selezionati, selezione periodica, dipendenti cessati, personale esterno)
  if SettaImpostazioni and Assigned(Impostazioni) then
    Impostazioni;
  (*
  //Caratto 20/03/2013. impostando C700Progressivo viene impostata la selezione iniziale
  //rieseguento actConferma si perderebbe il caso di partenza con progressivo = 0
//  if (not ImpostaProgressivoCorrente) and (not SelezioneVuota) then
  *)
  //Massimo 22/05/2013 se progressivo valido (<> 0) si esegue selezione altrimenti non si deve eseguire
  if (not SelezioneVuota) then
    WC700FM.actConfermaExecute(nil);
end;

procedure TmedpIWC700NavigatorBar.setSelezioneDaEreditare(const Value: TC700SelAnagrafeBridge);
begin
  FSelezioneDaEreditare:=Value;
  FEreditaSelezioneSpecifica:=True;
end;

procedure TmedpIWC700NavigatorBar.SelezionaProgressivo(Progressivo: Integer);
begin
  selAnagrafe.Locate('Progressivo',Progressivo,[]);
end;
end.
