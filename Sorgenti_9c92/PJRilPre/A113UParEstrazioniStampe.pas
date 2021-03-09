unit A113UParEstrazioniStampe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  A000UCostanti, A000USessione, A000UInterfaccia, R001UGESTTAB, StdCtrls, ExtCtrls, ActnList, ImgList, Db, Menus, ComCtrls,
  ToolWin, DBCtrls, Buttons, Mask, Grids, DBGrids, Spin, SelAnagrafe, OracleData,
  A077UGeneratoreStampe, C013UCheckList, Variants, ToolbarFiglio, System.Actions;

type
  TA113FParEstrazioniStampe = class(TR001FGestTab)
    Panel2: TPanel;
    dRgpTipoSupporto: TDBRadioGroup;
    dEdtNome: TDBEdit;
    sbtNomeFile: TSpeedButton;
    Label1: TLabel;
    Label3: TLabel;
    SaveDialog1: TSaveDialog;
    lblProva: TLabel;
    GpbTracciato: TGroupBox;
    dGrdTracciato: TDBGrid;
    DbCmbCodiceStampa: TDBLookupComboBox;
    DBText1: TDBText;
    Label2: TLabel;
    DedtCodiceParam: TDBEdit;
    PopupMenu1: TPopupMenu;
    mnuNuovoElemento: TMenuItem;
    Label4: TLabel;
    DBEdit1: TDBEdit;
    SpeedButton1: TSpeedButton;
    frmToolbarFiglio: TfrmToolbarFiglio;
    procedure DbCmbCodiceStampaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sbtNomeFileClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure DButtonStateChange(Sender: TObject);
    procedure mnuNuovoElementoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dRgpTipoSupportoChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure dGrdTracciatoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    ListaUtenti:TStringList;
    //procedure ControllaDuplicati;
    //procedure ControlliFormali;
    procedure SettaUtenti(S:String);
    function GetUtenti:String;
  public
    { Public declarations }
  end;

var
  A113FParEstrazioniStampe: TA113FParEstrazioniStampe;
const sPc_StrutturaImpiego:string = 'STRUTTURA IMPIEGO';
const sPc_CodDipartimentoImpiego:string = 'DIPARTIMENTO IMPIEGO';
const sPc_DescDipartimentoImpiego:string = 'DESC.DIPART.IMPIEGO';
const sPc_UnitaOperativaImpiego:string = 'UNITA OPERATIVA';
const sPc_TotaleOreUOImpiego:string = 'ORE UNITA OPERATIVA';
const sPc_SommaRicorrenzeN:string = 'NON SOMMARE';
const sPc_SommaRicorrenzeS:string = 'SOMMA SEMPRE';
//const sPc_SommaRicorrenzeX:string = 'SOMMA SE TOT = 0';
const sPc_SommaRicorrenzeX:string = 'CUMULA STORICO';

procedure OpenA113ParEstrazioniStampe(Cod:String);

implementation

uses A113UParEstrazioniStampeDTM1;

{$R *.DFM}

procedure OpenA113ParEstrazioniStampe(Cod:String);
{Parametrizzazione file seq.}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA113ParEstrazioniStampe') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A113FParEstrazioniStampeDtM1:=TA113FParEstrazioniStampeDtM1.Create(nil);
  A113FParEstrazioniStampe:=TA113FParEstrazioniStampe.Create(nil);
  try
    A113FParEstrazioniStampeDtM1.Q930.Locate('CODICE_PAR',Cod,[]);
    A113FParEstrazioniStampe.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A113FParEstrazioniStampe.Free;
    A113FParEstrazioniStampeDtM1.Free;
  end;
end;

procedure TA113FParEstrazioniStampe.sbtNomeFileClick(Sender: TObject);
begin
  with A113FParEstrazioniStampeDtM1 do
  begin
    if (DButton.State in [dsEdit,dsInsert]) and (dRgpTipoSupporto.ItemIndex = 0)  then
    begin
      SaveDialog1.Title:='Scelta nome file di estrazione';
      SaveDialog1.DefaultExt := 'txt';
      SaveDialog1.Filter := 'Text files (*.txt)|*.txt|All files (*.*)|*.*';
      SaveDialog1.FilterIndex := 1;
      if not(Q930Nome_File.IsNull) then
        SaveDialog1.FileName:=Q930Nome_File.Value;
      if SaveDialog1.Execute then
        Q930Nome_File.Value:=SaveDialog1.FileName;
    end;
  end;
end;

procedure TA113FParEstrazioniStampe.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A113FParEstrazioniStampeDtM1.Q930;
  frmToolbarFiglio.TFDButton:=A113FParEstrazioniStampeDtM1.D931;
  SetLength(frmToolbarFiglio.lstLock,3);
  frmToolbarFiglio.lstLock[0]:=Panel1;
  frmToolbarFiglio.lstLock[1]:=File1;
  frmToolbarFiglio.lstLock[2]:=Strumenti1;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
  //Carico la lista degli utenti Oracle
  ListaUtenti:=TStringList.Create;
  with A113FParEstrazioniStampeDtM1 do
  begin
    if SelUser.Active then
    begin
      while not SelUser.Eof do
      begin
        ListaUtenti.Add(SelUser.Fields[0].asString);
        SelUser.Next;
      end;
    end;
  end;
end;

procedure TA113FParEstrazioniStampe.TRegisClick(Sender: TObject);
var
  MyState:TDataSetState;
begin
  MyState:=DButton.State;
  //Controllo sui campi
  with A113FParEstrazioniStampeDtM1 do
  begin
    if DButton.State in [dsInsert, dsEdit] then
    begin
      if Q930CODICE_PAR.AsString = '' then
      begin
        DedtCodiceParam.setFocus;
        raise Exception.Create('Indicare il codice della parametrizzazione');
      end;
      if Q930CODICE_STAMPA.AsString = '' then
      begin
        DbCmbCodiceStampa.setFocus;
        raise Exception.Create('Indicare il codice della stampa');
      end;
      if Q930CODICE_STAMPA.AsString = '' then
      begin
        DbCmbCodiceStampa.setFocus;
        raise Exception.Create('Indicare il codice della stampa');
      end;
      if Q930NOME_FILE.AsString = '' then
      begin
        dEdtNome.setFocus;
        if Q930TIPO_FILE.AsString = 'O' then
          raise Exception.Create('Indicare il nome della tabella oracle')
        else
          raise Exception.Create('Indicare il nome del file ascii');
      end;
    end;
    inherited;
    if MyState = dsInsert then
    begin
      //Popolo la tabella t931_tracciatoestrazionistampe
      frmToolbarFiglio.actTFModificaExecute(nil);
      //TPrimoGrigliaClick(TModifGriglia);
      while not Q911.Eof do
      begin
        Q931.Insert;
        Q931DATO.AsString:=Q911NOME.AsString;
        Q931SOMMA_RICORRENZE.AsString:=sPc_SommaRicorrenzeN;
        Q931.Post;
        Q911.Next;
      end;
    end;
  end;
end;

procedure TA113FParEstrazioniStampe.DButtonDataChange(Sender: TObject;
  Field: TField);
begin
  with A113FParEstrazioniStampeDtM1 do
  begin
    //Leggo il nome di tutti i campi della stampa selezionata
    if Q911.GetVariable('codicestampa') <> Q930CODICE_STAMPA.AsString then
    begin;
      Q911.Close;
      Q911.SetVariable('codicestampa', Q930CODICE_STAMPA.AsString);
      Q911.Open;
    end;
    if Q931.GetVariable('codicepar') <> Q930CODICE_PAR.AsString then
    begin
      Q931.Close;
      Q931.SetVariable('codicepar', Q930CODICE_PAR.AsString);
      Q931.Open;
    end;
  end;
end;

procedure TA113FParEstrazioniStampe.DButtonStateChange(Sender: TObject);
begin
  inherited;
  GpbTracciato.Enabled:=DButton.State = dsBrowse;
end;

procedure TA113FParEstrazioniStampe.mnuNuovoElementoClick(Sender: TObject);
begin
  inherited;
  A077UGeneratoreStampe.OpenA077GeneratoreStampe(0);
end;

procedure TA113FParEstrazioniStampe.FormActivate(Sender: TObject);
begin
  inherited;
  dGrdTracciato.Columns[3].PickList.Clear;
  dGrdTracciato.Columns[3].PickList.Add(sPc_StrutturaImpiego);
  dGrdTracciato.Columns[3].PickList.Add(sPc_CodDipartimentoImpiego);
  dGrdTracciato.Columns[3].PickList.Add(sPc_DescDipartimentoImpiego);
  dGrdTracciato.Columns[3].PickList.Add(sPc_UnitaOperativaImpiego);
  dGrdTracciato.Columns[3].PickList.Add(sPc_TotaleOreUOImpiego);
  dGrdTracciato.Columns[6].PickList.Clear;
  dGrdTracciato.Columns[6].PickList.Add(sPc_SommaRicorrenzeN);
  dGrdTracciato.Columns[6].PickList.Add(sPc_SommaRicorrenzeS);
  dGrdTracciato.Columns[6].PickList.Add(sPc_SommaRicorrenzeX);
end;

(*procedure TA113FParEstrazioniStampe.ControllaDuplicati;
begin
  with A113FParEstrazioniStampeDtM1 do
  begin
    //Verifico che non ci siano campi duplicati
    //STRUTTURA
    Q931.Filtered:=False;
    Q931.Filter:='TIPO = ''' + sPc_StrutturaImpiego + '''';
    Q931.Filtered:=True;
    if Q931.RecordCount > 1 then
    begin
      Q931.Filtered:=False;
      raise exception.Create('E'' consentito indicare un solo campo di tipo ' + sPc_StrutturaImpiego);
    end;
    //CODICE DIPARTIMENTO
    Q931.Filtered:=False;
    Q931.Filter:='TIPO = ''' + sPc_CodDipartimentoImpiego + '''';
    Q931.Filtered:=True;
    if Q931.RecordCount > 1 then
    begin
      Q931.Filtered:=False;
      raise exception.Create('E'' consentito indicare un solo campo di tipo ' + sPc_CodDipartimentoImpiego);
    end;
    //DESC DIPARTIMENTO
    Q931.Filtered:=False;
    Q931.Filter:='TIPO = ''' + sPc_DescDipartimentoImpiego + '''';
    Q931.Filtered:=True;
    if Q931.RecordCount > 1 then
    begin
      Q931.Filtered:=False;
      raise exception.Create('E'' consentito indicare un solo campo di tipo ' + sPc_DescDipartimentoImpiego);
    end;
    //UNITA' OPERATIVA
    Q931.Filtered:=False;
    Q931.Filter:='TIPO = ''' + sPc_UnitaOperativaImpiego + '''';
    Q931.Filtered:=True;
    if Q931.RecordCount > 1 then
    begin
      Q931.Filtered:=False;
      raise exception.Create('E'' consentito indicare un solo campo di tipo ' + sPc_UnitaOperativaImpiego);
    end;
    //TOTALE ORE UNITA' OPERATIVA
    Q931.Filtered:=False;
    Q931.Filter:='TIPO = ''' + sPc_TotaleOreUOImpiego + '''';
    Q931.Filtered:=True;
    if Q931.RecordCount > 1 then
    begin
      Q931.Filtered:=False;
      raise exception.Create('E'' consentito indicare un solo campo di tipo ' + sPc_TotaleOreUOImpiego);
    end;
   Q931.Filtered:=False;
  end;
end;*)

(*procedure TA113FParEstrazioniStampe.ControlliFormali;
begin
  with A113FParEstrazioniStampeDtM1 do
  begin
    Q911.Refresh;
    //CONTROLLO LA VALIDITA' DEI DATI IMPOSTATI
    Q931.First;
    while not Q931.Eof do
    begin
      Q911.SearchRecord('NOME',Q931DATO.AsString,[srFromBeGinning]);
      if Q911TIPO.AsInteger = 0 then //Tipo testo
      begin
        if Q931SOMMA_RICORRENZE.AsString <> sPc_SommaRicorrenzeN then
        begin
          Screen.Cursor:=crDefault;
          raise exception.Create('Generatore di stampe: il formato per il dato calcolato ''' + Q931.FieldByName('DATO').AsString + ''' è ''Testo''.' + #$A#$D + 'Il campo ''SOMMA RICORRENZE'' deve essere impostato a ''' + A113UParEstrazioniStampe.sPc_SommaRicorrenzeN + ''' per i campi testo.');
        end;
        if Q931FORMATO.AsString <> '' then
        begin
          Screen.Cursor:=crDefault;
          raise exception.Create('Generatore di stampe: il formato per il dato calcolato ''' + Q931.FieldByName('DATO').AsString + ''' è ''Testo''.' + #$A#$D + 'Il campo ''FORMATO VAL.NUM.'' non deve essere valorizzato per i campi testo.');
        end;
      end
      else if Q911TIPO.asInteger = 1 then //Tipo numero
      begin
        if Q931VARIAZIONI_MAX.AsInteger > 1 then
        begin
          Screen.Cursor:=crDefault;
          raise exception.Create('Generatore di stampe: il formato per il dato calcolato ''' + Q931.FieldByName('DATO').AsString + ''' è ''Numero''.' + #$A#$D + 'Il campo ''NUM.MAX.VARIZ.'' non deve essere valorizzato per i campi numerici.');
        end;
        if Q931SOMMA_RICORRENZE.AsString = sPc_SommaRicorrenzeN then
        begin
          Screen.Cursor:=crDefault;
          raise exception.Create('Generatore di stampe: il formato per il dato calcolato ''' + Q931.FieldByName('DATO').AsString + ''' è ''Numero''.' + #$A#$D + 'Il campo ''SOMMA RICORRENZE'' deve essere impostato con un valore diverso da ''' + A113UParEstrazioniStampe.sPc_SommaRicorrenzeN + ''' per i campi numerici.');
        end;
        if Q931FORMATO.AsString = '' then
        begin
          Screen.Cursor:=crDefault;
          raise exception.Create('Generatore di stampe: il formato per il dato calcolato ''' + Q931.FieldByName('DATO').AsString + ''' è ''Numero''.' + #$A#$D + 'Il campo ''FORMATO VAL.NUM.'' deve essere valorizzato per i campi numerici.');
        end
        else
        begin
          if ((Pos('D',UpperCase(Q931FORMATO.asString))=0) and
              (Pos('F',UpperCase(Q931FORMATO.asString))=0)) or
             (Pos('%',Q931FORMATO.asString)=0) then
          begin
            Screen.Cursor:=crDefault;
            raise exception.Create('Il valore assegnato nella colonna ''FORMATO VAL.NUM.'' per il DATO ' + Q931.FieldByName('DATO').AsString + ' non è corretto.');
          end;
        end;
      end
      else
      begin
        Screen.Cursor:=crDefault;
        raise exception.Create('Generatore di Stampe: il formato per il dato calcolato ''' + Q931.FieldByName('DATO').AsString + ''' deve essere numerico o alfanumerico.');
      end;
      Q931.Next;
    end;
  end;
end;*)

procedure TA113FParEstrazioniStampe.dRgpTipoSupportoChange(
  Sender: TObject);
begin
  inherited;
  if dRgpTipoSupporto.ItemIndex = 0 then
    label3.Caption:='Nome file ascii'
  else
    label3.Caption:='Nome tabella oracle';
end;

procedure TA113FParEstrazioniStampe.SpeedButton1Click(Sender: TObject);
begin
  if DButton.State in [dsInsert,dsEdit] then
  begin
    C013FCheckList:=TC013FCheckList.Create(nil);
    C013FCheckList.Caption:='Lista Utenti Oracle';
    with C013FCheckList do
    try
      clbListaDati.Items.Clear;
      clbListaDati.Items.Assign(ListaUtenti);
      SettaUtenti(DbEdit1.Text);
      if ShowModal = mrOK then
        DbEdit1.Text:=GetUtenti;
    finally
      Release;
    end;
  end;
end;

procedure TA113FParEstrazioniStampe.SettaUtenti(S:String);
var L:TStringList;
    i,P:Integer;
begin
  if Trim(S) = '' then
    exit;
  L:=TStringList.Create;
  try
    L.CommaText:=S;
    for i:=0 to L.Count - 1 do
    begin
      P:=C013FCheckList.clbListaDati.Items.IndexOf(L[i]);
      if P >= 0 then
        C013FCheckList.clbListaDati.Checked[P]:=True;
    end;
  finally
    L.Free;
  end;
end;

function TA113FParEstrazioniStampe.GetUtenti:String;
var i:Integer;
begin
  Result:='';
  with C013FCheckList.clbListaDati do
    for i:=0 to Items.Count - 1 do
    begin
      if Checked[i] then
      begin
        if Result <> '' then
         Result:=Result + ',';
        Result:=Result + Items[i];
      end;
    end;
end;

procedure TA113FParEstrazioniStampe.dGrdTracciatoKeyPress(Sender: TObject;
  var Key: Char);
begin
  with A113FParEstrazioniStampeDtM1 do
  begin
    if (dGrdTracciato.SelectedField = Q931SOMMA_RICORRENZE) or
       (dGrdTracciato.SelectedField = Q931TIPO) or
       (dGrdTracciato.SelectedField = Q931CHIAVE) then
      Key:=chr(0);
  end;
end;

procedure TA113FParEstrazioniStampe.DbCmbCodiceStampaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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

end.
