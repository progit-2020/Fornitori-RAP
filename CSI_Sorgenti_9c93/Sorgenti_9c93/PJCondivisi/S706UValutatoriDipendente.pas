unit S706UValutatoriDipendente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, Grids, DBGrids, DBCtrls, StdCtrls, Mask, Buttons,
  ExtCtrls, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin, Oracle, OracleData,
  A000UCostanti, A000USessione, A000UInterfaccia, A003UDataLavoroBis,
  C180FunzioniGenerali, C700USelezioneAnagrafe, C013UCheckList, SelAnagrafe,
  System.Actions;

type
  TS706FValutatoriDipendente = class(TR001FGestTab)
    Panel2: TPanel;
    dGrdComponenti: TDBGrid;
    frmSelAnagrafe: TfrmSelAnagrafe;
    gbxVisMod: TGroupBox;
    lblDecorrenza: TLabel;
    dedtDecorrenza: TDBEdit;
    btnDecIniDB: TButton;
    lblFine: TLabel;
    dedtFine: TDBEdit;
    btnDecFinDB: TButton;
    lblMatricola: TLabel;
    dedtMatricola: TDBEdit;
    lblNominativo: TLabel;
    dedtNominativo: TDBEdit;
    gbxInsCanc: TGroupBox;
    Label1: TLabel;
    medtDecIni: TMaskEdit;
    btnDecIni: TButton;
    lblDipendenti: TLabel;
    edtDipendenti: TEdit;
    btnInsDipendenti: TBitBtn;
    btnCanDipendenti: TBitBtn;
    btnDipendenti: TButton;
    btnDecFin: TButton;
    medtDecFin: TMaskEdit;
    Label2: TLabel;
    procedure btnInsDipendentiClick(Sender: TObject);
    procedure btnDipendentiClick(Sender: TObject);
    procedure btnCanDipendentiClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure btnCalendarioClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure frmSelAnagrafebtnEreditaSelezioneClick(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaProgressivo;
    procedure ControllaDate(var DataInizio,DataFine:TDateTime);
  public
    { Public declarations }
    LungDato,LungDato2: Integer;
    procedure AbilitaAzioni;
    procedure NumRecords;
  end;

var
  S706FValutatoriDipendente: TS706FValutatoriDipendente;

procedure OpenS706FValutatoriDipendente(ProgVal,ProgDip:Integer;Data:TDateTime);

implementation

uses S706UValutatoriDipendenteDtM;

{$R *.dfm}

procedure OpenS706FValutatoriDipendente(ProgVal,ProgDip:Integer;Data:TDateTime);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenS706FValutatoriDipendente') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  C700Progressivo:=ProgVal;
  Application.CreateForm(TS706FValutatoriDipendente, S706FValutatoriDipendente);
  Application.CreateForm(TS706FValutatoriDipendenteDtM, S706FValutatoriDipendenteDtM);
  with S706FValutatoriDipendenteDtM do
    if selSG706.RecordCount > 0 then
      while selSG706.SearchRecord('PROGRESSIVO_VALUTATO',ProgDip,[]) do
        if  (Data >= selSG706.FieldByName('DECORRENZA').AsDateTime)
        and (Data <= selSG706.FieldByName('DECORRENZA_FINE').AsDateTime) then
          break;
  try
    Screen.Cursor:=crDefault;
    S706FValutatoriDipendente.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    S706FValutatoriDipendente.Free;
    S706FValutatoriDipendenteDtM.Free;
  end;
end;

procedure TS706FValutatoriDipendente.FormShow(Sender: TObject);
begin
  inherited;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,2,True);
  frmSelAnagrafe.SoloPersonaleInterno:=False;
  frmSelAnagrafe.sbarSelAnagrafe:=StatusBar;
  frmSelAnagrafe.NumRecords;
  frmSelAnagrafe.VisualizzaDipendente;
  AbilitaAzioni;
end;

procedure TS706FValutatoriDipendente.frmSelAnagrafebtnEreditaSelezioneClick(
  Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.btnEreditaSelezioneClick(Sender);

end;

procedure TS706FValutatoriDipendente.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.btnSelezioneClick(Sender);

end;

procedure TS706FValutatoriDipendente.btnDipendentiClick(Sender: TObject);
var 
  DataInizio,DataFine:TDateTime;
  Valore,Valore2: String;
begin
  inherited;
  ControllaDate(DataInizio,DataFine);
  with S706FValutatoriDipendenteDtM do
    if QSGruppoValutatore.LocDatoStorico(DataFine) then
    begin
      try
        Valore:=QSGruppoValutatore.FieldByName('T430' + Parametri.CampiRiferimento.C21_ValutazioniRsp1).AsString;
      except
        Valore:='';
      end;
      try
        Valore2:=QSGruppoValutatore.FieldByName('T430' + Parametri.CampiRiferimento.C21_ValutazioniRsp2).AsString;
      except
        Valore2:='';
      end;
    end
    else
    begin
      Valore:='';
      Valore2:='';
    end;
  C013FCheckList:=TC013FCheckList.Create(nil);
  with S706FValutatoriDipendenteDtM.selT430 do
  begin
    Close;
    //SetVariable('CAMPO','T430.' + Parametri.CampiRiferimento.C21_ValutazioniRsp1);
    if LungDato > 0 then
      SetVariable('CAMPO','T430.' + Parametri.CampiRiferimento.C21_ValutazioniRsp1)
    else
      SetVariable('CAMPO','NULL');
    SetVariable('DATO',Valore);
    if LungDato2 > 0 then
      SetVariable('CAMPO2','T430.' + Parametri.CampiRiferimento.C21_ValutazioniRsp2)
    else
      SetVariable('CAMPO2','NULL');
    SetVariable('DATO2',Valore2);
    SetVariable('DATAFINE',DataFine);
    Open;
    //Carico gli elementi
    First;
    while not Eof do
    begin
      C013FCheckList.clbListaDati.Items.Add(Format('%-8s %-*s %-*s %s',[FieldByName('MATRICOLA').AsString,LungDato,'- ' + FieldByName('CODICE').AsString,LungDato2,'- ' + FieldByName('CODICE2').AsString, '- ' + Trim(FieldByName('NOMINATIVO').asString)]));
      Next;
    end;
  end;
  R180PutCheckList(edtDipendenti.Text,8,C013FCheckList.clbListaDati);
  C013FCheckList.ShowModal;
  if C013FCheckList.ModalResult = mrOK then
    edtDipendenti.Text:=R180GetCheckList(8,C013FCheckList.clbListaDati);
end;

procedure TS706FValutatoriDipendente.btnInsDipendentiClick(Sender: TObject);
var ListaMatricole: TStringList;
  i: integer;
  DataInizio,DataFine:TDateTime;
begin
  inherited;
  if edtDipendenti.Text = '' then
    raise Exception.Create('Nessun dipendente in lista!');
  ControllaDate(DataInizio,DataFine);
  with S706FValutatoriDipendenteDtM do
  begin
    ListaMatricole:=TStringList.Create;
    ListaMatricole.CommaText:=edtDipendenti.Text;
    insSG706.SetVariable('PROGRESSIVO',C700Progressivo);
    insSG706.SetVariable('DECORRENZA',DataInizio);
    insSG706.SetVariable('DECORRENZA_FINE',DataFine);
    i:=0;
    while i <= ListaMatricole.Count - 1 do
    begin
      selSG706a.Close;
      selSG706a.SetVariable('PROG',StrToInt(VarToStr(selT030.Lookup('MATRICOLA',ListaMatricole.Strings[i],'PROGRESSIVO'))));
      selSG706a.SetVariable('DEC_INI',DataInizio);
      selSG706a.SetVariable('DEC_FIN',DataFine);
      selSG706a.Open;
      if selSG706a.RecordCount > 0 then
      begin
        ShowMessage('L''inserimento del dipendente ' + ListaMatricole.Strings[i] + ' ' + VarToStr(selT030.Lookup('MATRICOLA',ListaMatricole.Strings[i],'NOMINATIVO')) + ' non può essere effettuato in base ai parametri' + #13 +
                    'specificati, in quanto il periodo di riferimento interseca il seguente periodo già esistente:' + #13 +
                    'Valutatore: ' + selSG706a.FieldByName('MATRICOLA').AsString + ' ' + selSG706a.FieldByName('NOMINATIVO').AsString + #13 +
                    'Periodo: ' + selSG706a.FieldByName('DECORRENZA').AsString + ' - ' + selSG706a.FieldByName('DECORRENZA_FINE').AsString);
        i:=i + 1;
        Continue;
      end;
      insSG706.SetVariable('PROGRESSIVO_VALUTATO',StrToInt(VarToStr(selT030.Lookup('MATRICOLA',ListaMatricole.Strings[i],'PROGRESSIVO'))));
      try
        insSG706.Execute;
        SessioneOracle.Commit;
      except
        SessioneOracle.Rollback;
      end;
      i:=i + 1;
    end;
    ListaMatricole.Free;
    selSG706.Refresh;
  end;
  ShowMessage('Inserimento terminato!');
  AbilitaAzioni;
end;

procedure TS706FValutatoriDipendente.btnCalendarioClick(Sender: TObject);
var Data:TDateTime;
    Anno,Mese,Giorno:Word;
    StrData:String;
begin
  if Sender = btnDecIni then
    StrData:=medtDecIni.Text
  else if Sender = btnDecFin then
    StrData:=medtDecFin.Text
  else if Sender = btnDecIniDB then
    StrData:=S706FValutatoriDipendenteDtM.selSG706.FieldByName('DECORRENZA').AsString
  else if Sender = btnDecFinDB then
    StrData:=S706FValutatoriDipendenteDtM.selSG706.FieldByName('DECORRENZA_FINE').AsString;
  if (Trim(StrData) = '') or (StrData = '  /  /    ') then
    StrData:=FormatDateTime('dd/mm/yyyy',Now);
  Anno:=StrToInt(Copy(StrData,7,4));
  Mese:=StrToInt(Copy(StrData,4,2));
  Giorno:=StrToInt(Copy(StrData,1,2));
  Data:=EncodeDate(Anno,Mese,Giorno);
  Data:=DataOut(Data,'Data','G');
  StrData:=FormatDateTime('dd/mm/yyyy',Data);
  if Sender = btnDecIni then
    medtDecIni.Text:=StrData
  else if Sender = btnDecFin then
    medtDecFin.Text:=StrData
  else if Sender = btnDecIniDB then
    S706FValutatoriDipendenteDtM.selSG706.FieldByName('DECORRENZA').AsString:=StrData
  else if Sender = btnDecFinDB then
    S706FValutatoriDipendenteDtM.selSG706.FieldByName('DECORRENZA_FINE').AsString:=StrData;
end;

procedure TS706FValutatoriDipendente.btnCanDipendentiClick(Sender: TObject);
var ListaMatricole: TStringList;
  i: integer;
  DataInizio,DataFine:TDateTime;
begin
  inherited;
  if edtDipendenti.Text = '' then
    raise Exception.Create('Nessun dipendente in lista!');
  ControllaDate(DataInizio,DataFine);
  if R180MessageBox('Confermi la cancellazione dei dipendenti in lista per le date specificate?',DOMANDA) = mrNo then
    exit;
  with S706FValutatoriDipendenteDtM do
  begin
    ListaMatricole:=TStringList.Create;
    ListaMatricole.CommaText:=edtDipendenti.Text;
    delSG706.SetVariable('PROGRESSIVO',C700Progressivo);
    delSG706.SetVariable('DECORRENZA',DataInizio);
    delSG706.SetVariable('DECORRENZA_FINE',DataFine);
    i:=0;
    while i <= ListaMatricole.Count - 1 do
    begin
      delSG706.SetVariable('PROGRESSIVO_VALUTATO',StrToInt(VarToStr(selT030.Lookup('MATRICOLA',ListaMatricole.Strings[i],'PROGRESSIVO'))));
      delSG706.Execute;
      SessioneOracle.Commit;
      i:=i + 1;
    end;
    ListaMatricole.Free;
    selSG706.Refresh;
  end;
  ShowMessage('Cancellazione terminata!');
  AbilitaAzioni;
end;

procedure TS706FValutatoriDipendente.ControllaDate(var DataInizio,DataFine:TDateTime);
begin
  try
    DataInizio:=StrToDate(medtDecIni.Text);
  except
    raise Exception.Create('Impostare correttamente la data di decorrenza!');
  end;
  try
    DataFine:=StrToDate(medtDecFin.Text);
  except
    raise Exception.Create('Impostare correttamente la data di scadenza!');
  end;
  if DataInizio > DataFine then
    raise Exception.Create('Impostare correttamente le date di decorrenza e scadenza!');
end;

procedure TS706FValutatoriDipendente.CambiaProgressivo;
var
  CampiDaEstrarre: String;
begin
  if C700OldProgressivo <> C700Progressivo then
    with S706FValutatoriDipendenteDtM do
    begin
      //CampiDaEstrarre:='T430' + Parametri.CampiRiferimento.C21_ValutazioniRsp1;
      if LungDato > 0 then
        CampiDaEstrarre:='T430' + Parametri.CampiRiferimento.C21_ValutazioniRsp1;
      if LungDato2 > 0 then
        CampiDaEstrarre:=CampiDaEstrarre + ',T430' + Parametri.CampiRiferimento.C21_ValutazioniRsp2;
      QSGruppoValutatore.GetDatiStorici(CampiDaEstrarre,C700Progressivo,EncodeDate(1900,1,1),EncodeDate(3999,12,31));
      selSG706.Close;
      selSG706.SetVariable('PROGRESSIVO',C700Progressivo);
      selSG706.Open;
      NumRecords;
    end;
end;

procedure TS706FValutatoriDipendente.DButtonStateChange(Sender: TObject);
begin
  inherited;
  AbilitaAzioni;
end;

procedure TS706FValutatoriDipendente.AbilitaAzioni;
begin
  actInserisci.Visible:=False;
  actCancella.Visible:=False;
  actModifica.Enabled:=(S706FValutatoriDipendenteDtM.selSG706.RecordCount > 0) and (DButton.State in [dsBrowse]);
  btnDecIniDB.Enabled:=(S706FValutatoriDipendenteDtM.selSG706.RecordCount > 0) and not actModifica.Enabled;
  btnDecFinDB.Enabled:=(S706FValutatoriDipendenteDtM.selSG706.RecordCount > 0) and not actModifica.Enabled;
  btnInsDipendenti.Enabled:=(C700Progressivo > 0) and ((S706FValutatoriDipendenteDtM.selSG706.RecordCount = 0) or actModifica.Enabled);
  btnCanDipendenti.Enabled:=(S706FValutatoriDipendenteDtM.selSG706.RecordCount > 0) and actModifica.Enabled;
  btnDecIni.Enabled:=btnInsDipendenti.Enabled;
  medtDecIni.Enabled:=btnInsDipendenti.Enabled;
  btnDecFin.Enabled:=btnInsDipendenti.Enabled;
  medtDecFin.Enabled:=btnInsDipendenti.Enabled;
  btnDipendenti.Enabled:=btnInsDipendenti.Enabled;
  edtDipendenti.Enabled:=btnInsDipendenti.Enabled;
end;

procedure TS706FValutatoriDipendente.NumRecords;
begin
  inherited;
end;

end.
