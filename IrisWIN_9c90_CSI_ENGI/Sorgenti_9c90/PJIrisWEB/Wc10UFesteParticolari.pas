unit Wc10UFesteParticolari;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Oracle, OracleData, StrUtils,
  A000USessione, A000UInterfaccia, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  R012UWebAnagrafico, Wc10UFesteParticolariDM, W000UMessaggi,
  Data.DB, medpIWMultiColumnComboBox, meIWComboBox,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, meIWRegion, IWCompGrids, meIWGrid,
  medpIWTabControl, IWCompEdit, meIWEdit, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompLabel, meIWLabel, IWCompButton, meIWButton, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  IWApplication;

const
  NRIGHEBLOCCATE = 1;
  NCOLONNEBLOCCATE = 5;

type
  TWc10FFesteParticolari = class(TR012FWebAnagrafico)
    lblPeriodoDal: TmeIWLabel;
    edtPeriodoDal: TmeIWEdit;
    lblPeriodoAl: TmeIWLabel;
    edtPeriodoAl: TmeIWEdit;
    lblPeriodo: TmeIWLabel;
    tabFesteParticolari: TmedpIWTabControl;
    Wc10ProspettoRG: TmeIWRegion;
    grdProspetto: TmedpIWDBGrid;
    tpProspetto: TIWTemplateProcessorHTML;
    DLista: TDataSource;
    btnConfermaProspetto: TmeIWButton;
    btnEsegui: TmeIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdProspettoAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdProspettoRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnConfermaProspettoClick(Sender: TObject);
  private
    { Private declarations }
    Dal,Al:TDateTime;
    Wc10DM: TWc10FFesteParticolariDM;
    procedure ElaboraProspetto;
    procedure CaricaLista;
    procedure VisualizzaGriglia;
  public
    procedure DistruggiOggetti; override;
    procedure GetDipendentiDisponibili(Data:TDateTime); override;
    procedure VisualizzaDipendenteCorrente; override;
  public
    function InizializzaAccesso:Boolean; override;
  end;

var
  Wc10FFesteParticolari: TWc10FFesteParticolari;

implementation

{$R *.dfm}

function TWc10FFesteParticolari.InizializzaAccesso:Boolean;
begin
  Result:=True;
  GetDipendentiDisponibili(Parametri.DataLavoro);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  if ElementoTuttiDip
  and selAnagrafeW.Active
  and (selAnagrafeW.RecordCount > 1) then
    cmbDipendentiDisponibili.ItemIndex:=0;
  VisualizzaDipendenteCorrente;
end;

procedure TWc10FFesteParticolari.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  AddScrollBarManager('divscrollable');
  Wc10DM:=TWc10FFesteParticolariDM.Create(Self);
  // inizializzazione dati
  Dal:=EncodeDate(R180Anno(Parametri.DataLavoro),1,1);
  Al:=EncodeDate(R180Anno(Parametri.DataLavoro),12,31);
  edtPeriodoDal.Text:=DateToStr(Dal);
  edtPeriodoAl.Text:=DateToStr(Al);

  btnConfermaProspetto.Visible:=not SolaLettura;

  tabFesteParticolari.AggiungiTab(A000TraduzioneStringhe('Prospetto'), Wc10ProspettoRG);
  tabFesteParticolari.ActiveTab:=Wc10ProspettoRG;
  tabFesteParticolari.TabByIndex(0).LinkVisible:=False;

  grdProspetto.medpPaginazione:=False;
  grdProspetto.medpDataSet:=Wc10DM.cdsLista;
  grdProspetto.medpTestoNoRecord:='Nessun record';
end;

procedure TWc10FFesteParticolari.GetDipendentiDisponibili(Data:TDateTime);
begin
  ElementoTuttiDip:=True;
  inherited;
end;

procedure TWc10FFesteParticolari.DistruggiOggetti;
begin
  FreeAndNil(Wc10DM);
end;

procedure TWc10FFesteParticolari.VisualizzaDipendenteCorrente;
var FiltroAnag:String;
begin
  inherited;
  // data iniziale
  if not TryStrToDate(edtPeriodoDal.Text,Dal) then
  begin
    MsgBox.MessageBox(A000MSG_Wc10_ERR_DATA_INIZIO,INFORMA);
    Exit;
  end;
  // data finale
  if not TryStrToDate(edtPeriodoAl.Text,Al) then
  begin
    MsgBox.MessageBox(A000MSG_Wc10_ERR_DATA_FINE,INFORMA);
    Exit;
  end;
  // controllo consecutività periodo
  if Dal > Al then
  begin
    MsgBox.MessageBox(A000MSG_Wc10_ERR_PERIODO,INFORMA);
    Exit;
  end;
  // filtro in base alla selezione anagrafica
  FiltroAnag:=IfThen(TuttiDipSelezionato,
                     selAnagrafeW.SubstitutedSQL,
                     'select ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsString + ' progressivo from DUAL'
                     );
  if Wc10DM.selC010.VariableIndex('DATALAVORO') > -1 then
    Wc10DM.selC010.DeleteVariable('DATALAVORO');
  if Pos(':DATALAVORO',UpperCase(FiltroAnag)) > 0 then
  begin
    Wc10DM.selC010.DeclareVariable('DATALAVORO',otDate);
    R180SetVariable(Wc10DM.selC010,'DATALAVORO',Parametri.DataLavoro);
  end;
  // inizializzazione variabili
  R180SetVariable(Wc10DM.selC010,'DAL',Dal);
  R180SetVariable(Wc10DM.selC010,'AL',Al);
  R180SetVariable(Wc10DM.selC010,'SELANAGRAFE_SQL',FiltroAnag);
  // apertura dataset delle festività particolari
  Wc10DM.selC010.Open;
  ElaboraProspetto;
end;

procedure TWc10FFesteParticolari.ElaboraProspetto;
begin
  CaricaLista;
  VisualizzaGriglia;
end;

procedure TWc10FFesteParticolari.btnEseguiClick(Sender: TObject);
begin
  VisualizzaDipendenteCorrente;
end;

procedure TWc10FFesteParticolari.CaricaLista;
var NomeCampo:String;
begin
  with Wc10DM do
  begin
    //Creo e popolo il dataset delle festività particolari
    cdsListaGG.Close;
    cdsListaGG.FieldDefs.Clear;
    cdsListaGG.FieldDefs.Add('DATA',ftDate,0,False);
    cdsListaGG.FieldDefs.Add('TIPO',ftString,1,False);
    cdsListaGG.CreateDataSet;
    cdsListaGG.LogChanges:=False;
    cdsListaGG.IndexDefs.Clear;
    cdsListaGG.IndexDefs.Add('Ricerca',('DATA'),[]);
    cdsListaGG.IndexName:='Ricerca';
    with selC010 do
    begin
      First;
      while not Eof do
      begin
        if not cdsListaGG.Locate('DATA;TIPO',VarArrayOf([FieldByName('DATA_FESTIVITA').AsDateTime,FieldByName('TIPO_FESTIVITA').AsString]),[]) then
        begin
          cdsListaGG.Append;
          cdsListaGG.FieldByName('DATA').AsDateTime:=FieldByName('DATA_FESTIVITA').AsDateTime;
          cdsListaGG.FieldByName('TIPO').AsString:=FieldByName('TIPO_FESTIVITA').AsString;
          cdsListaGG.Post;
        end;
        Next;
      end;
    end;
    //Creo e popolo il dataset del prospetto
    cdsLista.Close;
    cdsLista.FieldDefs.Clear;
    cdsLista.FieldDefs.Add('PROGRESSIVO',ftInteger,0,False);
    cdsLista.FieldDefs.Add('MATRICOLA',ftString,8,False);
    cdsLista.FieldDefs.Add('COGNOME',ftString,30,False);
    cdsLista.FieldDefs.Add('NOME',ftString,30,False);
    cdsLista.FieldDefs.Add('NOMINATIVO',ftString,61,False);
    cdsListaGG.First;
    while not cdsListaGG.Eof do
    begin
      cdsLista.FieldDefs.Add(FormatDateTime('yyyymmdd',cdsListaGG.FieldByName('DATA').AsDateTime) + '-' + cdsListaGG.FieldByName('TIPO').AsString,ftString,1,False);
      cdsListaGG.Next;
    end;
    cdsLista.CreateDataSet;
    cdsLista.LogChanges:=False;
    cdsLista.IndexDefs.Clear;
    cdsLista.IndexDefs.Add('Ricerca',('COGNOME;NOME;MATRICOLA'),[]);
    cdsLista.IndexName:='Ricerca';
    with selC010 do
    begin
      First;
      while not Eof do
      begin
        if not cdsLista.Locate('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger,[]) then
        begin
          cdsLista.Append;
          cdsLista.FieldByName('PROGRESSIVO').AsInteger:=FieldByName('PROGRESSIVO').AsInteger;
          cdsLista.FieldByName('MATRICOLA').AsString:=VarToStr(selAnagrafeW.Lookup('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger,'MATRICOLA'));
          cdsLista.FieldByName('COGNOME').AsString:=VarToStr(selAnagrafeW.Lookup('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger,'COGNOME'));
          cdsLista.FieldByName('NOME').AsString:=VarToStr(selAnagrafeW.Lookup('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger,'NOME'));
          cdsLista.FieldByName('NOMINATIVO').AsString:=cdsLista.FieldByName('COGNOME').AsString + ' ' + cdsLista.FieldByName('NOME').AsString;
          cdsLista.Post;
        end;
        if cdsLista.FieldByName('PROGRESSIVO').AsInteger <> FieldByName('PROGRESSIVO').AsInteger then
          cdsLista.Locate('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger,[]);
        cdsLista.Edit;
        NomeCampo:=FormatDateTime('yyyymmdd',FieldByName('DATA_FESTIVITA').AsDateTime) + '-' + FieldByName('TIPO_FESTIVITA').AsString;
        //Se c'è scelta_definitiva o è presente la causale sostitutiva o il dipendente non ha scelto e non può (più) scegliere, vincolo la scelta
        if FieldByName('SCELTA_DEFINITIVA').IsNull then
        begin
          if FieldByName('ESISTE_CAUS_SOST').AsString = 'S' then
            //Forzo sempre il comportamento in caso di causale sostitutiva
            cdsLista.FieldByName(NomeCampo).AsString:=FieldByName('COMP_CAUSSOST').AsString
          else
          begin
            //Se il dipendente non ha scelto perché non può scegliere, applico il comportamento predefinito
            cdsLista.FieldByName(NomeCampo).AsString:=FieldByName('SCELTA_EFFETTUATA').AsString;
            if FieldByName('SCELTA_EFFETTUATA').IsNull //in caso di flag_scelta = L, potrei aver scelto con flag_scelta_rip = S e poi essere diventato di riposo con flag_scelta_rip = N: ormai conta la scelta effettuata
            and (FieldByName('FLAG_SCELTA_RIP').AsString = 'N') then
              cdsLista.FieldByName(NomeCampo).AsString:=FieldByName('COMP_NOSCELTA').AsString;
          end;
        end
        else
          cdsLista.FieldByName(NomeCampo).AsString:=FieldByName('SCELTA_DEFINITIVA').AsString;
        cdsLista.Post;
        Next;
      end;
    end;
  end;
end;

procedure TWc10FFesteParticolari.VisualizzaGriglia;
var i,k:Integer;
    Data:TDateTime;
    CTF,DTF:String;
begin
  with Wc10DM do
  begin
    grdProspetto.Caption:='Prospetto scelta festività ' + C190PeriodoStr(Dal,Al);
    grdProspetto.Summary:=grdProspetto.Caption;
    if cdsLista.RecordCount > 0 then
    begin
      // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
      grdProspetto.medpRighePagina:=GetRighePaginaTabella;
      // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
    end;
    grdProspetto.medpCreaCDS;
    grdProspetto.medpEliminaColonne;
    for i:=0 to cdsLista.FieldDefs.Count - 1 do
      if R180In(cdsLista.FieldDefs[i].Name,['PROGRESSIVO','MATRICOLA','COGNOME','NOME','NOMINATIVO']) then
      begin
        grdProspetto.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,IfThen(cdsLista.FieldDefs[i].Name = 'MATRICOLA','Matricola',
                                                                    IfThen(cdsLista.FieldDefs[i].Name = 'NOMINATIVO','Nominativo',
                                                                    cdsLista.FieldDefs[i].Name)),
                                         '',nil);
        if R180In(cdsLista.FieldDefs[i].Name,['PROGRESSIVO','COGNOME','NOME']) then
          grdProspetto.medpColonna(cdsLista.FieldDefs[i].Name).Visible:=False
        else
          grdProspetto.medpColonna(cdsLista.FieldDefs[i].Name).Visible:=TuttiDipSelezionato;
      end
      else
      begin
        Data:=EncodeDate(StrToInt(Copy(cdsLista.FieldDefs[i].Name,1,4)),StrToInt(Copy(cdsLista.FieldDefs[i].Name,5,2)),StrToInt(Copy(cdsLista.FieldDefs[i].Name,7,2)));
        CTF:=Copy(cdsLista.FieldDefs[i].Name,10,1);
        for k:=0 to High(D_TipoFesta) do
          if D_TipoFesta[k].Value = CTF then
          begin
            DTF:=D_TipoFesta[k].Item;
            Break;
          end;
        grdProspetto.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,FormatDateTime('dd/mm/yyyy',Data) + '-' + DTF,'',nil);
      end;
  end;
  grdProspetto.medpInizializzaCompGriglia;
  grdProspetto.medpCaricaCDS;
end;

procedure TWc10FFesteParticolari.grdProspettoAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var i,j,k,Progressivo:Integer;
    Data:TDateTime;
    Tipo,SP,CSP,DSP:String;
begin
  inherited;
  //Gestione delle combo per la scelta
  for i:=0 to High(grdProspetto.medpCompGriglia) do
    for j:=0 to High(grdProspetto.medpCompGriglia[i].CompColonne) do
      if j >= NCOLONNEBLOCCATE then
        with Wc10DM do
        begin
          Data:=EncodeDate(StrToInt(Copy(grdProspetto.medpColonna(j).DataField,1,4)),StrToInt(Copy(grdProspetto.medpColonna(j).DataField,5,2)),StrToInt(Copy(grdProspetto.medpColonna(j).DataField,7,2)));
          Tipo:=Copy(grdProspetto.medpColonna(j).DataField,10,1);
          Progressivo:=StrToInt(grdProspetto.medpValoreColonna(i,'PROGRESSIVO'));
          //Se c'è scelta_definitiva o non posso (più) scegliere o c'è causale di sostituzione non creo il componente
          if selC010.Locate('PROGRESSIVO;DATA_FESTIVITA;TIPO_FESTIVITA;SCELTA_DEFINITIVA;FLAG_SCELTA_RIP;ESISTE_CAUS_SOST',VarArrayOf([Progressivo,Data,Tipo,'','S','N']),[]) then
          begin
            grdProspetto.medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'21','','','','',False);
            grdProspetto.medpCreaComponenteGenerico(i,j,grdProspetto.Componenti);
            with (grdProspetto.medpCompCella(i,j,0) as TmeIWComboBox) do
            begin
              ItemsHaveValues:=True;
              SP:=selC010.FieldByName('SCELTE_POSSIBILI').AsString + ',';
              while Pos(',',SP) > 0 do
              begin
                CSP:=Copy(SP,1,Pos(',',SP) - 1);
                DSP:='';
                for k:=0 to High(D_Scelte) do
                  if D_Scelte[k].Value = CSP then
                  begin
                    DSP:=D_Scelte[k].Item;
                    Break;
                  end;
                Items.Add(Format('%s=%s',[DSP,CSP]));
                SP:=Copy(SP,Pos(',',SP) + 1);
              end;
              NoSelectionText:='';
              ItemIndex:=R180IndexFromValue(Items,grdProspetto.medpValoreColonna(i,FormatDateTime('yyyymmdd',Data) + '-' + Tipo));
              FriendlyName:=DateToStr(Data) + '-' + Tipo + ';' + IntToStr(Progressivo);
              Tag:=Trunc(Data);
              NonEditableAsLabel:=False;
              Enabled:=not SolaLettura and
                       (   selC010.FieldByName('INIZIO_SCELTA').IsNull
                        or (    (Trunc(R180SysDate(SessioneOracle)) >= selC010.FieldByName('INIZIO_SCELTA').AsDateTime)
                            and (Trunc(R180SysDate(SessioneOracle)) <= selC010.FieldByName('FINE_SCELTA').AsDateTime)));
            end;
          end;
        end;
end;

procedure TWc10FFesteParticolari.grdProspettoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var r,c,i:Integer;
    Data:TDateTime;
    Spaziatura,sData,TF,CTF,DTF,SP,CSP,DSP:String;
  function GetData(const S:String):String;
  begin
    Result:=FormatDateTime('dddd',StrToDate(S)) + '<br>';
    if R180Anno(Dal) = R180Anno(Al) then
    begin
      if R180Mese(Dal) = R180Mese(Al) then
      begin
        //Spaziatura:=DupeString('&nbsp;',MaxLenCaus + 1);
        Result:=Result + Spaziatura + Copy(S,1,2) + Spaziatura;
      end
      else
        Result:=Result + Copy(S,1,5)
    end
    else
      Result:=Result + FormatDateTime('dd/mm/yy',StrToDate(S));
  end;
begin
  inherited;
  if not grdProspetto.medpRenderCell(ACell, ARow, AColumn, True, True, False) then
    Exit;
  r:=ARow - 1;
  c:=grdProspetto.medpNumColonna(AColumn);
  if c >= NCOLONNEBLOCCATE then
    with Wc10DM do
    begin
      if ARow = 0 then
      begin
        sData:=Copy(ACell.Text,1,10);
        TF:=Copy(ACell.Text,12);
        ACell.RawText:=True;
        ACell.Text:=GetData(sData) + '<br>' + TF;
      end
      else
      begin
        Data:=EncodeDate(StrToInt(Copy(grdProspetto.medpColonna(c).DataField,1,4)),StrToInt(Copy(grdProspetto.medpColonna(c).DataField,5,2)),StrToInt(Copy(grdProspetto.medpColonna(c).DataField,7,2)));
        CTF:=Copy(grdProspetto.medpColonna(c).DataField,10);
        DTF:='';
        for i:=0 to High(D_TipoFesta) do
          if D_TipoFesta[i].Value = CTF then
          begin
            DTF:=D_TipoFesta[i].Item;
            Break;
          end;
        ACell.Css:=ACell.Css + ' align_center';
        ACell.Hint:=Format('Data: %s<br>Tipo: %s',[DateToStr(Data),DTF]);
        if TuttiDipSelezionato then
          ACell.Hint:=ACell.Hint + Format('<br>Dipendente: %s %s',[grdProspetto.medpValoreColonna(r,'MATRICOLA'),grdProspetto.medpValoreColonna(r,'NOMINATIVO')]);
        if selC010.Locate('PROGRESSIVO;DATA_FESTIVITA;TIPO_FESTIVITA',VarArrayOf([grdProspetto.medpValoreColonna(r,'PROGRESSIVO'),Data,CTF]),[]) then
        begin
          if not selC010.FieldByName('INIZIO_SCELTA').IsNull then
            ACell.Hint:=ACell.Hint + Format('<br>Periodo scelta: %s-%s',[selC010.FieldByName('INIZIO_SCELTA').AsString,selC010.FieldByName('FINE_SCELTA').AsString]);
          if not selC010.FieldByName('SCELTE_POSSIBILI').IsNull then
          begin
            ACell.Hint:=ACell.Hint + '<br>Scelte possibili:';
            SP:=selC010.FieldByName('SCELTE_POSSIBILI').AsString + ',';
            while Pos(',',SP) > 0 do
            begin
              CSP:=Copy(SP,1,Pos(',',SP) - 1);
              DSP:='';
              for i:=0 to High(D_Scelte) do
                if D_Scelte[i].Value = CSP then
                begin
                  DSP:=D_Scelte[i].Item;
                  if CSP = selC010.FieldByName('COMP_NOSCELTA').AsString then
                    DSP:=DSP + ' (predefinita)';
                  Break;
                end;
              ACell.Hint:=ACell.Hint + Format('<br>- %s',[DSP]);
              SP:=Copy(SP,Pos(',',SP) + 1);
            end;
          end
          else
          begin
            ACell.Hint:=ACell.Hint + '<br>Scelta obbligata:';
            CSP:=selC010.FieldByName('COMP_NOSCELTA').AsString;
            DSP:='';
            for i:=0 to High(D_Scelte) do
              if D_Scelte[i].Value = CSP then
              begin
                DSP:=D_Scelte[i].Item;
                Break;
              end;
            ACell.Hint:=ACell.Hint + Format('<br>- %s',[DSP]);
          end;
          if not selC010.FieldByName('SCELTA_EFFETTUATA').IsNull
          and (selC010.FieldByName('SCELTA_EFFETTUATA').AsString <> ACell.Text) then
          begin
            ACell.Hint:=ACell.Hint + '<br>Scelta effettuata:';
            CSP:=selC010.FieldByName('SCELTA_EFFETTUATA').AsString;
            DSP:='';
            for i:=0 to High(D_Scelte) do
              if D_Scelte[i].Value = CSP then
              begin
                DSP:=D_Scelte[i].Item;
                Break;
              end;
            ACell.Hint:=ACell.Hint + Format('<br>- %s',[DSP]);
          end;
        end;
        if (Length(grdProspetto.medpCompGriglia) > 0) then
          if grdProspetto.medpCompGriglia[r].CompColonne[c] <> nil then
          begin
            ACell.Control:=grdProspetto.medpCompGriglia[r].CompColonne[c];
            ACell.Text:='';
          end;
        if ACell.Text <> '' then
        begin
          CSP:=ACell.Text;
          DSP:='';
          for i:=0 to High(D_Scelte) do
            if D_Scelte[i].Value = CSP then
            begin
              DSP:=D_Scelte[i].Item;
              Break;
            end;
          ACell.Text:=DSP;
        end;
      end;
    end;
  if ACell.Hint <> '' then
    ACell.Css:=ACell.Css + ' tooltipHtml';
end;

procedure TWc10FFesteParticolari.btnConfermaProspettoClick(Sender: TObject);
var i,j,Progressivo:Integer;
    Data:TDateTime;
    Tipo,OldScelta,NewScelta:String;
    OperazioneEseguita:Boolean;
begin
  inherited;
  OperazioneEseguita:=False;
  for i:=0 to High(grdProspetto.medpCompGriglia) do
    for j:=0 to High(grdProspetto.medpCompGriglia[i].CompColonne) do
      if j >= NCOLONNEBLOCCATE then
        if grdProspetto.medpCompCella(i,j,0) <> nil then
          if (grdProspetto.medpCompCella(i,j,0) as TmeIWComboBox).Enabled then
            with Wc10DM do
            begin
              Data:=EncodeDate(StrToInt(Copy(grdProspetto.medpColonna(j).DataField,1,4)),StrToInt(Copy(grdProspetto.medpColonna(j).DataField,5,2)),StrToInt(Copy(grdProspetto.medpColonna(j).DataField,7,2)));
              Tipo:=Copy(grdProspetto.medpColonna(j).DataField,10,1);
              Progressivo:=StrToInt(grdProspetto.medpValoreColonna(i,'PROGRESSIVO'));
              if selC010.Locate('PROGRESSIVO;DATA_FESTIVITA;TIPO_FESTIVITA;FLAG_SCELTA_RIP',VarArrayOf([Progressivo,Data,Tipo,'S']),[]) then
              begin
                OldScelta:=selC010.FieldByName('SCELTA_EFFETTUATA').AsString;
                NewScelta:=(grdProspetto.medpCompCella(i,j,0) as TmeIWComboBox).Items.ValueFromIndex[(grdProspetto.medpCompCella(i,j,0) as TmeIWComboBox).ItemIndex];
                if (OldScelta <> NewScelta) or selC010.FieldByName('DATA_SCELTA').IsNull then
                begin
                  selC010.Edit;
                  if (OldScelta <> NewScelta) then
                    selC010.FieldByName('SCELTA_EFFETTUATA').AsString:=NewScelta;
                  selC010.FieldByName('DATA_SCELTA').AsDateTime:=R180Sysdate(SessioneOracle);
                  selC010.Post;
                  updCSI010.SetVariable('DATA_FESTIVITA',Data);
                  updCSI010.SetVariable('TIPO_FESTIVITA',Tipo);
                  updCSI010.SetVariable('PROGRESSIVO',Progressivo);
                  updCSI010.SetVariable('SCELTA_EFFETTUATA',selC010.FieldByName('SCELTA_EFFETTUATA').AsString);
                  updCSI010.SetVariable('DATA_SCELTA',selC010.FieldByName('DATA_SCELTA').AsDateTime);
                  updCSI010.Execute;
                  SessioneOracle.Commit;
                  OperazioneEseguita:=True;
                end;
              end;
            end;
  VisualizzaDipendenteCorrente;
  if OperazioneEseguita then
    GGetWebApplicationThreadVar.ShowMessage(A000MSG_Wc10_MSG_SCELTA_REGISTRATA)
  else
    GGetWebApplicationThreadVar.ShowMessage(A000MSG_Wc10_MSG_NESSUNA_OPERAZIONE);
end;

end.
