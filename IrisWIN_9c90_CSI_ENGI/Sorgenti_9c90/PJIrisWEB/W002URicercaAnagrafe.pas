
unit W002URicercaAnagrafe;

interface

uses
  R010UPaginaWeb, WC501UMenuIrisWebFM,
  A000UInterfaccia, A000USessione,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, L021Call,
  SysUtils, Classes, Controls, Windows, IWHTMLControls,
  IWTemplateProcessorHTML, IWCompEdit, IWCompLabel, IWApplication,
  IWControl, IWCompListbox, IWCompMemo, IWBaseControl,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWVCLBaseControl, IWBaseHTMLControl, IWVCLBaseContainer,
  IWContainer, IWVCLComponent, Variants, Forms, Math, StrUtils,
  QueryStorico, meIWEdit, meIWComboBox, meIWRadioGroup, meIWLink, meIWMemo,
  meIWGrid, IWCompGrids, meIWLabel, W000UMessaggi, IWCompExtCtrls,
  meIWImageFile, IWCompButton, meIWButton;

type
  TGriglia = record
    Nome:String;
    Combo:Boolean;
    edtSort,edtValore,edtDa,edtA: TmeIWEdit;
    cmbValore,cmbDa,cmbA: TmeIWComboBox;
  end;

  TW002FRicercaAnagrafe = class(TR010FPaginaWeb)
    rgpTipoRicerca: TmeIWRadioGroup;
    lnkRicercaSalvata: TmeIWLink;
    cmbSelezioni: TmeIWComboBox;
    lnkSQLSalvato: TmeIWLink;
    lnkRicerca1: TmeIWLink;
    lnkRicerca2: TmeIWLink;
    lnkRicerca3: TmeIWLink;
    lnkRicerca4: TmeIWLink;
    grdRicerca: TmeIWGrid;
    memoSQL: TmeIWMemo;
    procedure grdRicercaCellClick(ASender: TObject; const ARow, AColumn: Integer);
    procedure btnRicercaTopClick(Sender: TObject);
    procedure grdRicercaRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure IWAppFormRender(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure rgpTipoRicercaClick(Sender: TObject);
  private
    Griglia: array of TGriglia;
    ComponentiRicercaCreati: Boolean;
    procedure CreaGriglia;
    procedure DistruggiGriglia;
    procedure RicercaChange;
    procedure CostruisciGrdRicerca;
    procedure GetSQLDaGrid;
    procedure GetSQLDaSelezione;
    procedure CaricaSelezioni;
    procedure EseguiPaginaIniziale(Pagina:String);
  protected
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    VisualizzaCessati: Boolean;
    TipoRicerca: String;
    function  InizializzaAccesso:Boolean; override;
    procedure OnTabChanging(var AllowChange: Boolean; var Conferma: String); override;
  end;

const
  MAX_CAMPI_RICERCA: Integer = 40;

implementation

{$R *.dfm}

uses W001UIrisWebDtM, W001ULogin, W002UAnagrafeElenco;

function TW002FRicercaAnagrafe.InizializzaAccesso:Boolean;
begin
  Result:=True;
  if not ComponentiRicercaCreati then
  begin
    Log('Traccia','W002R;InizializzaAccesso - inizio');
    CaricaSelezioni;
    CreaGriglia;
    TipoRicerca:='Semplice';
    RicercaChange;
    ComponentiRicercaCreati:=True;
    Log('Traccia','W002R;InizializzaAccesso - fine');
  end;
end;

procedure TW002FRicercaAnagrafe.RefreshPage;
begin
  InizializzaAccesso;
end;

procedure TW002FRicercaAnagrafe.IWAppFormCreate(Sender: TObject);
begin
  medpFissa:=True;
  inherited;
  ComponentiRicercaCreati:=False;
  VisualizzaCessati:=False;
end;

procedure TW002FRicercaAnagrafe.IWAppFormRender(Sender: TObject);
begin
  inherited;
  if WR000DM.AccessoDirettoValutatore <> 'N' then
    VisualizzaCessati:=True;

  if WR000DM.RefreshT003 then
    CaricaSelezioni;
end;

procedure TW002FRicercaAnagrafe.OnTabChanging(var AllowChange: Boolean;
  var Conferma: String);
begin
  // bugfix.ini
  // una volta posizionati su questa form, se non si effettua una ricerca
  // ma si passa su un altro tab della history,
  //  è necessario rimuovere il filtro sul clientdataset cdsI010
  WR000DM.cdsI010.Filtered:=False;
  // bugfix.fine
end;

procedure TW002FRicercaAnagrafe.CaricaSelezioni;
begin
  cmbSelezioni.Items.Clear;
  with WR000DM.seldistT003 do
  begin
    Close;
    Open;
    First;
    while not Eof do
    begin
      cmbSelezioni.Items.Add(FieldByName('NOME').AsString);
      Next;
    end;
    if RecordCount > 0 then     //Lorena 15/06/2006
      cmbSelezioni.ItemIndex:=0;
    CloseAll;
  end;
  WR000DM.RefreshT003:=False;
end;

procedure TW002FRicercaAnagrafe.CreaGriglia;
var
  i:Integer;
begin
  WR000DM.cdsI010.Filtered:=False;
  with WR000DM.cdsI010 do
  begin
    SetLength(Griglia,RecordCount);
    First;
    i:=0;
    while not Eof do
    begin
      Griglia[i].Nome:=FieldByName('NOME_LOGICO').AsString;
      Griglia[i].Combo:=False;
      Griglia[i].edtSort:=TmeIWEdit.Create(Self);
      Griglia[i].edtValore:=TmeIWEdit.Create(Self);
      Griglia[i].edtDa:=TmeIWEdit.Create(Self);
      Griglia[i].edtA:=TmeIWEdit.Create(Self);
      Griglia[i].cmbValore:=TmeIWComboBox.Create(Self);
      Griglia[i].cmbDa:=TmeIWComboBox.Create(Self);
      Griglia[i].cmbA:=TmeIWComboBox.Create(Self);

      Griglia[i].edtSort.Css:='input2';
      Griglia[i].edtValore.Css:='input_perc90';
      Griglia[i].edtDa.Css:='input_perc90';
      Griglia[i].edtA.Css:='input_perc90';
      Griglia[i].cmbValore.Css:='input_perc90';
      Griglia[i].cmbDa.Css:='input_perc90';
      Griglia[i].cmbA.Css:='input_perc90';

      Griglia[i].edtSort.Text:='';
      Griglia[i].edtValore.Text:='';
      Griglia[i].edtDa.Text:='';
      Griglia[i].edtA.Text:='';
      Griglia[i].edtValore.OnSubmit:=btnRicercaTopClick;

      inc(i);
      Next;
    end;
  end;
end;

procedure TW002FRicercaAnagrafe.DistruggiGriglia;
var
  i: Integer;
begin
  for i:=0 to High(Griglia) do
  begin
    FreeAndNil(Griglia[i].edtSort);
    FreeAndNil(Griglia[i].edtValore);
    FreeAndNil(Griglia[i].edtDa);
    FreeAndNil(Griglia[i].edtA);
    FreeAndNil(Griglia[i].cmbValore);
    FreeAndNil(Griglia[i].cmbDa);
    FreeAndNil(Griglia[i].cmbA);
  end;
  SetLength(Griglia,0);
end;

procedure TW002FRicercaAnagrafe.CostruisciGrdRicerca;
var
  i,j,k:Integer;
begin
  WR000DM.cdsI010.Filtered:=False;
  if TipoRicerca = 'Semplice' then
  begin
    // la ricerca semplice opera sui campi con RICERCA >= 0 e RICERCA not null
    // (i valori null del campo RICERCA sono sostituiti sul client dataset
    //  con la costante "RICERCA_NULL" )
    WR000DM.cdsI010.Filter:='(ACCESSO <> ''N'') and (RICERCA >= 0) and (RICERCA <> ' + IntToStr(RICERCA_NULL) + ')';
    WR000DM.cdsI010.Filtered:=True;
  end;
  grdRicerca.RowCount:=Min(WR000DM.cdsI010.RecordCount,MAX_CAMPI_RICERCA) + 1;
  grdRicerca.Cell[0,0].Text:='Ord.';
  grdRicerca.Cell[0,1].Text:='Dato';
  grdRicerca.Cell[0,2].Text:='Valore';
  grdRicerca.Cell[0,3].Text:='Da';
  grdRicerca.Cell[0,4].Text:='A';
  grdRicerca.Cell[0,0].Width:='5%';
  grdRicerca.Cell[0,1].Width:='20%';
  grdRicerca.Cell[0,2].Width:='25%';
  grdRicerca.Cell[0,3].Width:='25%';
  grdRicerca.Cell[0,4].Width:='25%';
  with WR000DM.cdsI010 do
  begin
    IndexName:='Ricerca';
    First;
    i:=1;
    while not Eof do
    begin
      // caption da layout anagrafico
      if FieldByName('CAPTION_LAYOUT').AsString <> '' then
        grdRicerca.Cell[i,1].Text:=FieldByName('CAPTION_LAYOUT').AsString
      else
        grdRicerca.Cell[i,1].Text:=FieldByName('NOME_LOGICO').AsString;
      grdRicerca.Cell[i,1].Hint:=FieldByName('NOME_LOGICO').AsString;
      grdRicerca.Cell[i,1].ShowHint:=False;
      grdRicerca.Cell[i,1].Clickable:=True;
      k:=-1;
      for j:=0 to High(Griglia) do
        if grdRicerca.Cell[i,1].Hint = Griglia[j].Nome then
        begin
          k:=j;
          Break;
        end;
      if k >= 0 then
      begin
        grdRicerca.Cell[i,0].Control:=Griglia[k].edtSort;
        if Griglia[k].Combo then
        begin
          grdRicerca.Cell[i,2].Control:=Griglia[k].cmbValore;
          grdRicerca.Cell[i,3].Control:=Griglia[k].cmbDa;
          grdRicerca.Cell[i,4].Control:=Griglia[k].cmbA;
        end
        else
        begin
          grdRicerca.Cell[i,2].Control:=Griglia[k].edtValore;
          grdRicerca.Cell[i,3].Control:=Griglia[k].edtDa;
          grdRicerca.Cell[i,4].Control:=Griglia[k].edtA;
        end;
        inc(i);
      end;
      if i > MAX_CAMPI_RICERCA then
        Break
      else
        Next;
    end;
  end;
end;

procedure TW002FRicercaAnagrafe.RicercaChange;
begin
  grdRicerca.Visible:=(TipoRicerca = 'Semplice') or (TipoRicerca = 'Avanzata');
  memoSQL.Visible:=(TipoRicerca = 'SQL_griglia') or (TipoRicerca = 'SQL_selezione');
  lnkSQLSalvato.Visible:=(TipoRicerca = 'Avanzata');
  if (TipoRicerca = 'Semplice') or (TipoRicerca = 'Avanzata') then
  begin
    CostruisciGrdRicerca;
  end
  else if (TipoRicerca = 'SQL_griglia') then
  begin
    GetSqlDaGrid;
    memoSQL.Lines.Assign(WR000DM.lstSQL);
  end
  else if (TipoRicerca = 'SQL_selezione') then
  begin
    GetSQLDaSelezione;
    memoSQL.Lines.Assign(WR000DM.lstSQL);
  end;
end;

procedure TW002FRicercaAnagrafe.rgpTipoRicercaClick(Sender: TObject);
begin
  inherited;

  if Sender = lnkSQLSalvato then
  begin
    rgpTipoRicerca.ItemIndex:=2;
    TipoRicerca:='SQL_selezione';
  end
  else
  begin
    case rgpTipoRicerca.ItemIndex of
      0: TipoRicerca:='Semplice';
      1: TipoRicerca:='Avanzata';
      2: TipoRicerca:='SQL_griglia';
    end;
  end;
  
  RicercaChange;
end;

procedure TW002FRicercaAnagrafe.grdRicercaCellClick(ASender: TObject; const ARow,
  AColumn: Integer);
var i,k:Integer;
begin
  k:=-1;
  for i:=0 to High(Griglia) do
    if Griglia[i].Nome = grdRicerca.Cell[ARow,1].Hint{Text} then
    begin
      k:=i;
      Break;
    end;
  if k = -1 then exit;
  if grdRicerca.Cell[ARow,2].Control is TIWEdit then
  begin
    Griglia[k].Combo:=True;
    grdRicerca.Cell[ARow,2].Control:=Griglia[k].cmbValore;
    grdRicerca.Cell[ARow,3].Control:=Griglia[k].cmbDa;
    grdRicerca.Cell[ARow,4].Control:=Griglia[k].cmbA;
  end
  else
  begin
    Griglia[k].Combo:=False;
    grdRicerca.Cell[ARow,2].Control:=Griglia[k].edtValore;
    grdRicerca.Cell[ARow,3].Control:=Griglia[k].edtDa;
    grdRicerca.Cell[ARow,4].Control:=Griglia[k].edtA;
    Griglia[k].edtValore.Text:=Griglia[k].cmbValore.Text;
    Griglia[k].edtDa.Text:=Griglia[k].cmbDa.Text;
    Griglia[k].edtA.Text:=Griglia[k].cmbA.Text;
  end;
  if grdRicerca.Cell[ARow,2].Control is TIWComboBox then
  with WR000DM.selDistAnagrafe do
  begin
    CloseAll;
    if Parametri.CampiRiferimento.C26_HintT030V430 <> '' then
      SQL.Text:=StringReplace(SQL.Text,'SELECT DISTINCT',Format('SELECT %s DISTINCT',[Parametri.CampiRiferimento.C26_HintT030V430]),[rfIgnoreCase]);
    SetVariable('DATALAVORO',Parametri.DataLavoro);
    SetVariable('CAMPO',VarToStr(WR000DM.cdsI010.Lookup('NOME_LOGICO',grdRicerca.Cell[ARow,1].Hint{Text},'NOME_CAMPO')));
    if Parametri.Inibizioni.Text <> '' then
      SetVariable('FILTRO',' AND ' + Parametri.Inibizioni.Text);
    Open;
    Griglia[k].cmbValore.Items.Clear;
    Griglia[k].cmbDa.Items.Clear;
    Griglia[k].cmbA.Items.Clear;
    Griglia[k].cmbValore.Items.Add('');
    Griglia[k].cmbDa.Items.Add('');
    Griglia[k].cmbA.Items.Add('');
    while not Eof do
    begin
      Griglia[k].cmbValore.Items.Add(Fields[0].AsString);
      Griglia[k].cmbDa.Items.Add(Fields[0].AsString);
      Griglia[k].cmbA.Items.Add(Fields[0].AsString);
      Next;
    end;
    Griglia[k].cmbValore.ItemIndex:=Max(0,Griglia[k].cmbValore.Items.IndexOf(Griglia[k].edtValore.Text));
    Griglia[k].cmbDa.ItemIndex:=Max(0,Griglia[k].cmbDa.Items.IndexOf(Griglia[k].edtDa.Text));
    Griglia[k].cmbA.ItemIndex:=Max(0,Griglia[k].cmbA.Items.IndexOf(Griglia[k].edtA.Text));
    CloseAll;
  end;
end;

procedure TW002FRicercaAnagrafe.GetSQLDaGrid;
var
  i,NumSort:Integer;
  Campo,V0,V1,V2,S,Sort:String;
  SortList: TStringList;
begin                         
  WR000DM.lstSQL.Clear;
  Sort:='';
  SortList:=TStringList.Create;
  try
    SortList.Sorted:=True;

    for i:=1 to grdRicerca.RowCount - 1 do
    begin
      if grdRicerca.Cell[i,2].Control is TIWEdit then
      begin
        V0:=Trim(TIWEdit(grdRicerca.Cell[i,2].Control).Text);
        V1:=Trim(TIWEdit(grdRicerca.Cell[i,3].Control).Text);
        V2:=Trim(TIWEdit(grdRicerca.Cell[i,4].Control).Text);
      end
      else
      begin
        V0:=Trim(TIWComboBox(grdRicerca.Cell[i,2].Control).Items[TIWComboBox(grdRicerca.Cell[i,2].Control).ItemIndex]);
        V1:=Trim(TIWComboBox(grdRicerca.Cell[i,3].Control).Items[TIWComboBox(grdRicerca.Cell[i,3].Control).ItemIndex]);
        V2:=Trim(TIWComboBox(grdRicerca.Cell[i,4].Control).Items[TIWComboBox(grdRicerca.Cell[i,4].Control).ItemIndex]);
      end;
      S:='';
      Campo:=VarToStr(WR000DM.cdsI010.Lookup('NOME_LOGICO',grdRicerca.Cell[i,1].Hint{Text},'NOME_CAMPO'));
      if Copy(Campo,1,4) <> 'T430' then
        if (Campo = 'CITTA') or (Campo = 'PROVINCIA') then
          Campo:='T480.' + Campo
        else
          Campo:='T030.' + Campo;

      // gestione campo
      if V0 <> '' then
      begin
        // valore fisso
        if Pos('%',V0) = 0 then
          S:=Format('%s = ''%s''',[Campo,AggiungiApice(V0)])
        else if V0 = '%' then
          S:=''
        else
          S:=Format('%s LIKE ''%s''',[Campo,AggiungiApice(V0)]);
      end
      else if (V1 <> '') and (V2 <> '') then
      begin
        // valori da - a
        if V1 = V2 then
        begin
          if Pos('%',V1) = 0 then
            S:=Format('%s = ''%s''',[Campo,AggiungiApice(V1)])
          else
            S:=Format('%s LIKE ''%s''',[Campo,AggiungiApice(V1)]);
        end
        else
          S:=Format('%s BETWEEN ''%s'' AND ''%s''',[Campo,AggiungiApice(V1),AggiungiApice(V2)]);
      end
      else if V1 <> '' then
      begin
        // valore da
        S:=Format('%s >= ''%s''',[Campo,AggiungiApice(V1)]);
      end
      else if V2 <> '' then
      begin
        // valore a
        S:=Format('%s <= ''%s''',[Campo,AggiungiApice(V2)]);
      end;
      if S <> '' then
        with WR000DM do
        begin
          if lstSQL.Count > 0 then
            lstSQL[lstSQL.Count - 1]:=lstSQL[lstSQL.Count - 1] + ' AND';
          lstSQL.Add(S);
        end;

      // gestione ordinamento
      NumSort:=StrToIntDef(TIWEdit(grdRicerca.Cell[i,0].Control).Text,-1);
      if NumSort >= 0 then
        SortList.Add(Format('%.4d%s',[NumSort,Campo]));
    end;
    // aggiunge parentesi iniziale e finale
    with WR000DM do
      if lstSQL.Count > 0 then
        begin
          lstSQL[0]:='(' + lstSQL[0];
          lstSQL[lstSQL.Count - 1]:=lstSQL[lstSQL.Count - 1] + ')';
        end;

    // ordinamento
    for i:=0 to SortList.Count - 1 do
      Sort:=Sort + Copy(SortList[i],5,Length(SortList[i]) - 4) + ',';
    if Sort <> '' then
    begin
      Sort:=Copy(Sort,1,Length(Sort) - 1);
      WR000DM.lstSQL.Add('ORDER BY ' + Sort);
    end;
  finally
    SortList.Free;
  end;
end;

procedure TW002FRicercaAnagrafe.GetSQLDaSelezione;
{ Compone la stringlist sql a partire dal nome della selezione attiva }
begin
  with WR000DM do
  begin
    lstSQL.Clear;
    if cmbSelezioni.Items.Count > 0 then  //Lorena 15/06/2006
    begin
      R180SetVariable(selT003,'NOME',cmbSelezioni.Items[cmbSelezioni.ItemIndex]);
      selT003.Open;
      while not selT003.Eof do
      begin
        lstSQL.Add(selT003.FieldByName('RIGA').AsString);
        selT003.Next;
      end;
      selT003.CloseAll;
    end;
  end;
end;

procedure TW002FRicercaAnagrafe.btnRicercaTopClick(Sender: TObject);
var
  FiltroAnagrafe,FiltroUtente,OrdinamUtente,FiltroInServizio,ErrMsg,LNotifica: String;
  PosOrderBy: Integer;
  W002: TW002FAnagrafeElenco;
begin
  ErrMsg:='';
  with WR000DM.selAnagrafe do
  begin
    // imposta il filtro anagrafe e il filtro per i cessati
    FiltroAnagrafe:=Parametri.Inibizioni.Text;
    FiltroInServizio:=IfThen(VisualizzaCessati,'',FILTRO_IN_SERVIZIO);

    // chiude il dataset anagrafico e imposta alcune variabili
    Close;
    SetVariable('DATALAVORO',Parametri.DataLavoro);
    SetVariable('FILTRO_IN_SERVIZIO',FiltroInServizio);

    // estrazione sql personalizzato
    (*if WR000DM.AccessoDirettoValutatore = 'N' then*)
    begin
      if Sender = lnkRicercaSalvata then
        GetSQLDaSelezione
      else
      begin
        if (TipoRicerca = 'SQL_griglia') or (TipoRicerca = 'SQL_selezione') then
          WR000DM.lstSQL.Assign(memoSQL.Lines)
        else
          GetSQLDaGrid;
      end;
    (*end
    else
    begin
      WR000DM.lstSQL.Clear;
      WR000DM.lstSQL.Add('(T030.PROGRESSIVO = -1)');*)
    end;

    // verifica il filtro anagrafe
    if FiltroAnagrafe <> '' then
    begin
      // IMPORTANTE: se nel filtro vengono usati campi della T030_ANAGRAFICO,
      // viene aggiunto l'alias "T030" per evitare problemi nelle join
      FiltroAnagrafe:=R180InserisciAliasT030(FiltroAnagrafe);
      SetVariable('FILTRO',' AND ' + FiltroAnagrafe);
      try
        //Open;
        FieldDefs.Update;
      except
        on E:Exception do
        begin
          ErrMsg:=Format(A000TraduzioneStringhe(A000MSG_W002_ERR_FMT_FILTRO_NON_ASSOCIATO),[Parametri.Operatore,E.Message]);
        end;
      end;
    end;

    // se la selezione è corretta aggiunge il filtro impostato dall'utente
    if ErrMsg = '' then
    begin
      OrdinamUtente:='ORDER BY COGNOME,NOME,MATRICOLA';
      if WR000DM.lstSQL.Count > 0 then
      begin
        FiltroUtente:=Trim(EliminaRitornoACapo(WR000DM.lstSQL.Text));
        PosOrderBy:=Pos('ORDER BY',UpperCase(FiltroUtente));
        if PosOrderBy > 0 then
        begin
          OrdinamUtente:=Trim(Copy(FiltroUtente,PosOrderBy,Length(FiltroUtente) - PosOrderBy + 1));
          FiltroUtente:=Trim(Copy(FiltroUtente,1,PosOrderBy - 1));
        end;
        FiltroAnagrafe:=FiltroAnagrafe +
                        IfThen((FiltroAnagrafe <> '') and (FiltroUtente <> ''),' AND ') +
                        FiltroUtente;
      end;
      if FiltroAnagrafe <> '' then
        FiltroAnagrafe:=' AND ' + FiltroAnagrafe;

      // IMPORTANTE: se nel filtro vengono usati campi della T030_ANAGRAFICO,
      // viene aggiunto l'alias "T030" per evitare problemi nelle join
      //FiltroAnagrafe:=R180InserisciAliasT030(FiltroAnagrafe);
      OrdinamUtente:=R180InserisciAliasT030(OrdinamUtente);

      // apertura dataset
      Close;
      ReadBuffer:=IfThen(Parametri.InibizioneIndividuale,2,100);
      SetVariable('FILTRO',Trim(FiltroAnagrafe + ' ' + OrdinamUtente));
      try
        Open;
        ReadBuffer:=RecordCount + 1; // aggiorna readbuffer per migliorare il recupero dati nei successivi refresh del dataset
      except
        on E:Exception do
        begin
          if Sender = lnkRicercaSalvata then
            ErrMsg:=Format(A000TraduzioneStringhe(A000MSG_W002_ERR_FMT_SELEZIONE_SBAGLIATA),[cmbSelezioni.Items[cmbSelezioni.ItemIndex],e.Message])
          else
            ErrMsg:=A000TraduzioneStringhe(A000MSG_W002_ERR_FMT_SELEZIONE_SBAGLIATA2);
          ErrMsg:=Format(ErrMsg,[E.Message]);
        end;
      end;
    end;

    // errore nel dataset di selezione -> viene aperto con filtro fittizio
    if ErrMsg <> '' then
    begin
      Close;
      SetVariable('FILTRO','AND T030.PROGRESSIVO < 0');
      Open;
    end;
  end;

  // salva filtro selezione e ordinamento
  WR000DM.FiltroRicerca:=FiltroInServizio + FiltroAnagrafe;
  WR000DM.OrdinamentoRicerca:=OrdinamUtente;
  Log('Traccia','RicercaAnagrafe: ' + WR000DM.TipoUtente + ' ' + Parametri.Operatore +
                ';Filtro complessivo: ' + WR000DM.FiltroRicerca +
                ';Filtro in servizio: ' + FiltroInServizio +
                ';Filtro anagrafe ' + IfThen(ErrMsg <> '','(ERRATO)') + ': ' + FiltroAnagrafe +
                ';OrdinamentoUtente: ' + OrdinamUtente);

  // se la funzione è richiamata dal login ed è attivo il login esterno
  // solleva immediatamente un'eccezione
  if (ErrMsg <> '') and
     (TipoRicerca = '') and
     (Sender is TW001FLogin) and
     ((Sender as TW001FLogin).LoginEsterno = 'S') then
    raise Exception.Create(ErrMsg);

  // distrugge tutte le form attive poiché la selezione anagrafica è cambiata
  WR000DM.History.FormReleaseAll;

  // crea form elenco anagrafe
  W002:=TW002FAnagrafeElenco(WR000DM.History.FormByTag(-2));
  if W002 = nil then
    W002:=TW002FAnagrafeElenco.Create(GGetWebApplicationThreadVar)
  else
  begin
    W002.RefreshPageAttivo:=True;
    W002.RefreshCompleto:=True;
  end;
  with W002 do
  begin
    if (WR000DM.TipoUtente = 'Supervisore') and
       (WR000DM.AccessoDirettoValutatore = 'N') then
    begin
      if (Sender = lnkRicercaSalvata) and (cmbSelezioni.Items.Count > 0) then  //Lorena 15/06/2006
        edtNomeRicerca.Text:=cmbSelezioni.Items[cmbSelezioni.ItemIndex];
      btnSalvaRicerca.Visible:=(Sender <> lnkRicercaSalvata) and (Parametri.C700_SalvaSelezioni <> 'N');
      AbilitazioneComponente(edtNomeRicerca,(Sender <> lnkRicercaSalvata));
      btnCancellaRicerca.Visible:=(Sender = lnkRicercaSalvata) and (Parametri.C700_SalvaSelezioni = 'S');
    end
    else  //Lorena 23/03/2004
    begin
      lnkIndietro.Visible:=not Parametri.InibizioneIndividuale;
      lblNomeRicerca.Visible:=False;
      edtNomeRicerca.Visible:=False;
      btnSalvaRicerca.Visible:=False;
      btnCancellaRicerca.Visible:=False;
    end;

    // nasconde "visualizza cessati" e "data di lavoro" per dipendente con inibizione individuale
    if (WR000DM.TipoUtente = 'Dipendente') and
       ((WR000DM.AccessoDirettoValutatore <> 'N') or
        (Parametri.InibizioneIndividuale)) then
    begin
      chkDipendentiCessati.Visible:=False;
      lblDataLavoro.Visible:=False;
      edtDataLavoro.Visible:=False;
      btnApplicaData.Visible:=False;
      lblNumRecord.Visible:=False;
      DipendenteSingolo:=True;
    end;
    if W002.RefreshPageAttivo then
      Show
    else
      OpenPage;
    with (WMenuFM as TWC501FMenuIrisWebFM) do
    begin
      if WR000DM.PaginaIniziale <> '' then
        EseguiPaginaIniziale(WR000DM.PaginaIniziale)
      else
      begin
        if WR000DM.AccessoDirettoValutatore = 'V' then
          actExecute(actSchedaValutazioni)
        else if WR000DM.AccessoDirettoValutatore = 'A' then
          actExecute(actSchedaAutovalutazioni)
        else if WR000DM.AccessoDirettoValutatore = 'Q' then
          actExecute(actSchedeQuantIndividuali);
      end;
    end;

    // visualizza errore selezione
    if ErrMsg <> '' then
    begin
      MessaggioStatus(ERRORE,ErrMsg);
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W002_ERR_SELEZIONE_ANAG_ERRATA));
    end;
  end;
end;

procedure TW002FRicercaAnagrafe.EseguiPaginaIniziale(Pagina:String);
var i:Integer;
begin
  if (WR000DM.PaginaSingola <> '') and (Pagina.ToUpper <> WR000DM.PaginaSingola.ToUpper) then
    exit;

  with (WMenuFM as TWC501FMenuIrisWebFM) do
  begin
    for i:=0 to ActionList.ActionCount - 1 do
      if L021SiglaByTag(ActionList.Actions[i].Tag).ToUpper = Pagina.ToUpper then
        if A000GetInibizioni('Tag',ActionList.Actions[i].Tag.ToString) <> 'N' then
        begin
          actExecute(ActionList.Actions[i]);
          Break;
        end;
  end;
end;

procedure TW002FRicercaAnagrafe.grdRicercaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  RenderCell(ACell,ARow,AColumn,True,True);
end;

procedure TW002FRicercaAnagrafe.DistruggiOggetti;
begin
  if GGetWebApplicationThreadVar <> nil then
  begin
    DistruggiGriglia;
  end;
end;

end.

