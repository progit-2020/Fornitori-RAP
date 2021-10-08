unit A092UStampaStorico;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, Spin ,C001StampaLib, C180FunzioniGenerali,A000UCostanti, A000USessione,A000UInterfaccia,
  Grids, DBGrids, ExtCtrls,DB,ComCtrls, checklst, Menus, StrUtils,
  A003UDataLavoroBis, C004UParamForm, QueryStorico, C006UStoriaDati,
  SelAnagrafe, C700USelezioneAnagrafe, C005UDatiAnagrafici, Variants;

type
  TA092FStampaStorico = class(TForm)
    BtnPrinterSetUp: TBitBtn;
    BtnPreView: TBitBtn;
    BtnClose: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    StatusBar: TStatusBar;
    ProgressBar: TProgressBar;
    ListaAnagra: TCheckListBox;
    Label1: TLabel;
    chkSaltoPagina: TCheckBox;
    BtnStampa: TBitBtn;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    BtnDaData: TBitBtn;
    LblDaData: TLabel;
    BtnAData: TBitBtn;
    LblAData: TLabel;
    rgpOrdinamento: TRadioGroup;
    chkVariazioni: TCheckBox;
    frmSelAnagrafe: TfrmSelAnagrafe;
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure BtnPreViewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListaAnagraMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListaAnagraMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BtnDaDataClick(Sender: TObject);
    procedure BtnADataClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
  Private
    ItemSort:Integer;
    procedure ScorriQueryAnagrafica;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ScriviStorico(i:Integer; RS:RecStoria);
    function  ControllaData(DataI,DataF : TDateTime) : Boolean;
  public
    DaData,AData:TDateTime;
    FlagStatus:Boolean;
    Stipendi:Boolean;
    DocumentoPDF,TipoModulo: string;
  end;

var
  A092FStampaStorico: TA092FStampaStorico;

procedure OpenA092StampaStorico(Prog:LongInt);

implementation

uses A092UStampa, UInputTime, A092UStampaStoricoDtM1;

{$R *.DFM}

procedure OpenA092StampaStorico(Prog:LongInt);
{Stampa movimentazione storica dei dati specificati}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA092StampaStorico') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
  end;
  A092FStampaStorico:=TA092FStampaStorico.Create(nil);
  with A092FStampaStorico do
    try
      C700Progressivo:=Prog;
      A092FStampaStoricoDtM1:=TA092FStampaStoricoDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A092FStampaStoricoDtM1.Free;
      Free;
    end;
end;

procedure TA092FStampaStorico.FormCreate(Sender: TObject);
begin
  TipoModulo:='CS';
  A092FStampa:=TA092FStampa.Create(nil);
  FlagStatus:=False;
end;

procedure TA092FStampaStorico.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'A092',Parametri.ProgOper);
  DaData:=Date;
  AData:=Date;
  LblDaData.Caption:=FormatDateTime('dd MMM yyyy',DaData);
  LblAData.Caption:=FormatDateTime('dd MMM yyyy',AData);
  ItemSort:=-1;
  ListaAnagra.Items.Clear;

  with A092FStampaStoricoDtM1.A092MW.Q010S do
    begin
    First;
    while not Eof do
      begin
      if (FieldByName('COLUMN_NAME').AsString <> 'PROGRESSIVO') and
         (FieldByName('COLUMN_NAME').AsString <> 'DATADECORRENZA') and
         (FieldByName('COLUMN_NAME').AsString <> 'DATAFINE') and
         (FieldByName('COLUMN_NAME').AsString <> 'DECORRENZA') and
         (FieldByName('COLUMN_NAME').AsString <> 'DECORRENZA_FINE') then
        ListaAnagra.Items.Add(FieldByName('NOME_LOGICO').AsString);
      Next;
      end;
    end;
  GetParametriFunzione;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataDal:=Parametri.DataLavoro;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,0,False);
  frmSelAnagrafe.SelezionePeriodica:=True;
end;

procedure TA092FStampaStorico.BtnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
    C001SettaQuickReport(A092FStampa.RepR);
end;

procedure TA092FStampaStorico.ScorriQueryAnagrafica;
var i,j,NV:Integer;
    S,SP430:String;
begin
  S:='';
  SP430:='';
  with A092FStampaStoricoDtM1.A092MW.Q010S do
    for i:=0 to ListaAnagra.Items.Count - 1 do
      if ListaAnagra.Checked[i] then
      begin
        if VarToStr(Lookup('NOME_LOGICO',ListaAnagra.Items[i],'TABLE_NAME')) = 'T430_STORICO' then
        begin
          if S <> '' then
            S:=S + ',';
          S:=S + VarToStr(Lookup('NOME_LOGICO',ListaAnagra.Items[i],'COLUMN_NAME'));
        end;
        if VarToStr(Lookup('NOME_LOGICO',ListaAnagra.Items[i],'TABLE_NAME')) = 'P430_ANAGRAFICO' then
        begin
          if SP430 <> '' then
            SP430:=SP430 + ',';
          SP430:=SP430 + VarToStr(Lookup('NOME_LOGICO',ListaAnagra.Items[i],'COLUMN_NAME'));
        end;
      end;
  with A092FStampaStoricoDtM1 do
  begin
    C006FStoriaDati:=TC006FStoriaDati.Create(nil);
    ProgressBar.Position:=0;
    ProgressBar.Max:=C700SelAnagrafe.RecordCount;
    C700SelAnagrafe.First;
    frmSelAnagrafe.ElaborazioneInterrompibile:=True;
    Self.Enabled:=False;
    try
    while not C700SelAnagrafe.EOF do
      begin
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar.StepBy(1);
      C006FStoriaDati.GetStoriaDato(C700Progressivo,S);
      for i:=0 to ListaAnagra.Items.Count - 1 do
        if ListaAnagra.Checked[i] then
        begin
          NV:=0;
          //Conto quanti movimenti ricadono all'interno del periodo richiesto
          for j:=0 to C006FStoriaDati.StoriaDipendente.Count - 1 do
            if RecStoria(C006FStoriaDati.StoriaDipendente[j]).NomeCampo = VarToStr(A092MW.Q010S.Lookup('NOME_LOGICO',ListaAnagra.Items[i],'COLUMN_NAME')) then
              if (RecStoria(C006FStoriaDati.StoriaDipendente[j]).Decorrenza <= AData) and
                 (RecStoria(C006FStoriaDati.StoriaDipendente[j]).Fine >= DaData) then
                inc(NV);
          //Caricamento dei dati nella tabella di stampa
          if (not chkVariazioni.Checked) or (NV > 1)
          or (VarToStr(A092MW.Q010S.Lookup('NOME_LOGICO',ListaAnagra.Items[i],'COLUMN_NAME')) = 'INIZIO')
          or (VarToStr(A092MW.Q010S.Lookup('NOME_LOGICO',ListaAnagra.Items[i],'COLUMN_NAME')) = 'FINE') then
            for j:=0 to C006FStoriaDati.StoriaDipendente.Count - 1 do
              if RecStoria(C006FStoriaDati.StoriaDipendente[j]).NomeCampo = VarToStr(A092MW.Q010S.Lookup('NOME_LOGICO',ListaAnagra.Items[i],'COLUMN_NAME')) then
                if (((not chkVariazioni.Checked) or (NV > 1)) and
                   (RecStoria(C006FStoriaDati.StoriaDipendente[j]).Decorrenza <= AData) and
                   (RecStoria(C006FStoriaDati.StoriaDipendente[j]).Fine >= DaData))
                or (chkVariazioni.Checked and (NV <= 1) and
                    (   (RecStoria(C006FStoriaDati.StoriaDipendente[j]).NomeCampo = 'FINE')
                     or (RecStoria(C006FStoriaDati.StoriaDipendente[j]).NomeCampo = 'INIZIO')) and
                    (RecStoria(C006FStoriaDati.StoriaDipendente[j]).Valore <> '') and
                    (StrToDate(RecStoria(C006FStoriaDati.StoriaDipendente[j]).Valore) <= AData) and
                    (StrToDate(RecStoria(C006FStoriaDati.StoriaDipendente[j]).Valore) >= DaData)) then
                  ScriviStorico(i,RecStoria(C006FStoriaDati.StoriaDipendente[j]));
        end;
//=============================
//SOLO SE APPLICATIVO = "PAGHE"
//=============================
        if Stipendi then
        begin
          C006FStoriaDati.GetStoriaDatoP430(C700Progressivo,SP430);
          for i:=0 to ListaAnagra.Items.Count - 1 do
            if ListaAnagra.Checked[i] then
            begin
              NV:=0;
              //Conto quanti movimenti ricadono all'interno del periodo richiesto
              for j:=0 to C006FStoriaDati.StoriaDipendente.Count - 1 do
                if RecStoria(C006FStoriaDati.StoriaDipendente[j]).NomeCampo = VarToStr(A092MW.Q010S.Lookup('NOME_LOGICO',ListaAnagra.Items[i],'COLUMN_NAME')) then
                  if (RecStoria(C006FStoriaDati.StoriaDipendente[j]).Decorrenza <= AData) and
                     (RecStoria(C006FStoriaDati.StoriaDipendente[j]).Fine >= DaData) then
                    inc(NV);
              //Caricamento dei dati nella tabella di stampa
              if (not chkVariazioni.Checked) or (NV > 1) then
                for j:=0 to C006FStoriaDati.StoriaDipendente.Count - 1 do
                  if RecStoria(C006FStoriaDati.StoriaDipendente[j]).NomeCampo = VarToStr(A092MW.Q010S.Lookup('NOME_LOGICO',ListaAnagra.Items[i],'COLUMN_NAME')) then
                    if (RecStoria(C006FStoriaDati.StoriaDipendente[j]).Decorrenza <= AData) and
                       (RecStoria(C006FStoriaDati.StoriaDipendente[j]).Fine >= DaData) then
                      ScriviStorico(i,RecStoria(C006FStoriaDati.StoriaDipendente[j]));
          end;
        end;
      C700SelAnagrafe.Next;
    end;
    finally
      frmSelAnagrafe.ElaborazioneInterrompibile:=False;
      Self.Enabled:=True;
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar.Position:=0;
      C006FStoriaDati.Free;
    end;
  end;
end;

procedure TA092FStampaStorico.BtnPreViewClick(Sender: TObject);
var i:integer;
    ok:boolean;
begin
  if FlagStatus then
    raise exception.Create('Stampa o Anteprima di stampa in corso');
  ok:=False;
  for i:=0 to ListaAnagra.Items.Count-1 do
    if ListaAnagra.Checked[i] then
      begin
      ok:=True;
      Break;
      end;
  if not Ok then
    raise Exception.Create('Nessun dato anagrafico selezionato.');
  A092FStampaStoricoDtM1.CreaTabellaStampa;
  if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DaData,AData) then
    C700SelAnagrafe.Close;
  C700SelAnagrafe.Open;
  frmSelAnagrafe.NumRecords;
  ScorriQueryAnagrafica;
  A092FStampa.CreaReport(Sender = BtnPreView);
  A092FStampaStoricoDtM1.TabellaStampa.Close
end;

procedure TA092FStampaStorico.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to ListaAnagra.Items.Count - 1 do
    ListaAnagra.Checked[i]:=True;
end;

procedure TA092FStampaStorico.Annullatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to ListaAnagra.Items.Count - 1 do
    ListaAnagra.Checked[i]:=False;
end;

procedure TA092FStampaStorico.GetParametriFunzione;
{Leggo i parametri della form}
var x,i:integer;
    svalore, snome, selemento:string;
begin
  chkSaltoPagina.Checked:=C004FParamForm.GetParametro('SALTOPAGINA','N') = 'S';
  chkVariazioni.Checked:=C004FParamForm.GetParametro('SOLOVARIAZIONI','N') = 'S';
  rgpOrdinamento.ItemIndex:=StrToInt(C004FParamForm.GetParametro('ORDINAMENTO','0'));
  x:=0;
  snome:='LISTAANAGRA';
  while VarToStr(C004FParamForm.GetParametro(snome + IntToStr(x),'')) <> '' do
  begin
    svalore:=C004FParamForm.GetParametro(snome + IntToStr(x),'');
    svalore:=svalore + IfThen(svalore = '','',',');
    while Pos(',',svalore) > 0 do
    begin
      selemento:=Trim(Copy(svalore,1,Pos(',',svalore) - 1));
      svalore:=Trim(Copy(svalore,Pos(',',svalore) + 1));
      for i:=0 to ListaAnagra.Items.Count - 1 do
      begin
        if VarToStr(A092FStampaStoricoDtM1.A092MW.Q010S.Lookup('NOME_LOGICO',ListaAnagra.Items[i],'COLUMN_NAME')) = selemento then
          ListaAnagra.Checked[i]:=true;
      end;
    end;
    inc(x);
  end;
end;

procedure TA092FStampaStorico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA092FStampaStorico.PutParametriFunzione;
{Scrivo i parametri della forma}
var i,x,y:integer;
    svalore,snome:string;
begin
  C004FParamForm.Cancella001;
  with A092FStampaStorico do
  begin
    if chkSaltoPagina.Checked then
      C004FParamForm.PutParametro('SALTOPAGINA','S')
    else
      C004FParamForm.PutParametro('SALTOPAGINA','N');
    if chkVariazioni.Checked then
      C004FParamForm.PutParametro('SOLOVARIAZIONI','S')
    else
      C004FParamForm.PutParametro('SOLOVARIAZIONI','N');
    C004FParamForm.PutParametro('ORDINAMENTO',IntToStr(rgpOrdinamento.ItemIndex));
    // salvo l'elenco dei campi di anagrafe selezionate
    x:=0; //contatore parametri causali
    y:=0; //contatore elementi per parametro
    svalore:='';
    snome:='LISTAANAGRA';
    For i:=0 to ListaAnagra.Items.Count - 1 do
    begin
      if ListaAnagra.Checked[i] then
      begin
        svalore:=svalore + IfThen(svalore = '','',',');
        svalore:=svalore + Trim(Format('%-30s',[VarToStr(A092FStampaStoricoDtM1.A092MW.Q010S.Lookup('NOME_LOGICO',ListaAnagra.Items[i],'COLUMN_NAME'))]));
        inc(y);
        if y = 3 then
        begin
          C004FParamForm.PutParametro(snome + IntToStr(x),svalore);
          inc(x);
          y:=0;
          svalore:='';
        end;
      end;
    end;
    C004FParamForm.PutParametro(snome + IntToStr(x),svalore);
  end;
  try SessioneOracle.Commit; except end;
end;

procedure TA092FStampaStorico.ListaAnagraMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ItemSort:=ListaAnagra.ItemIndex;
end;

procedure TA092FStampaStorico.ListaAnagraMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var C1,C2:Boolean;
begin
  if (ItemSort <> -1) and (ItemSort <> ListaAnagra.ItemIndex) then
    begin
    C1:=ListaAnagra.Checked[ItemSort];
    C2:=ListaAnagra.Checked[ListaAnagra.ItemIndex];
    ListaAnagra.Items.Exchange(ItemSort,ListaAnagra.ItemIndex);
    ListaAnagra.Checked[ItemSort]:=C2;
    ListaAnagra.Checked[ListaAnagra.ItemIndex]:=C1;
    end;
  ItemSort:= - 1;
end;

procedure TA092FStampaStorico.BtnDaDataClick(Sender: TObject);
begin
  DaData:=DataOut(DaData,'Dalla data:','G');
  LblDaData.Caption:=FormatDateTime('dd mmm yyyy',DaData);
  ControllaData(DaData,AData);
end;

procedure TA092FStampaStorico.BtnADataClick(Sender: TObject);
begin
  AData:=DataOut(AData,'Alla data:','G');
  LblAData.Caption:=FormatDateTime('dd mmm yyyy',AData);
  ControllaData(DaData,AData);
end;

function TA092FStampaStorico.ControllaData(DataI,DataF : TDateTime) : Boolean;
begin
  Result:=(DataI <= DataF);
  BtnStampa.Enabled:=Result;
  if not(Result) then
    MessageDlg('La data iniziale non puo''' +#13+
               'essere precedente a quella finale',mtWarning,[mbOK],0);
end;

procedure TA092FStampaStorico.ScriviStorico(i:Integer; RS:RecStoria);
begin
  with A092FStampaStoricoDtM1 do
    begin
    TabellaStampa.Insert;
    TabellaStampa.FieldByName('Progressivo').Value:=C700SelAnagrafe.FieldByName('PROGRESSIVO').Value;
    TabellaStampa.FieldByName('CognomeNome').Value:=C700SelAnagrafe.FieldByName('Cognome').AsString+' '+C700SelAnagrafe.FieldByName('Nome').AsString;
    TabellaStampa.FieldByName('Matricola').Value:=C700SelAnagrafe.FieldByName('Matricola').AsString;
    TabellaStampa.FieldByName('SeqCampo').Value:=i;
    TabellaStampa.FieldByName('DataDecorrenza').AsString:=RS.DataDec;
    if RS.DataFine = '31/12/3999' then
      TabellaStampa.FieldByName('DataFine').Value:='Corrente'
    else
      TabellaStampa.FieldByName('DataFine').Value:=RS.DataFine;
    TabellaStampa.FieldByName('Campo').AsString:=RS.TipoDato;
    TabellaStampa.FieldByName('Dato').AsString:=RS.Valore;
    TabellaStampa.FieldByName('Descrizione').AsString:=RS.Descrizione;
    TabellaStampa.Post;
    end;
end;

procedure TA092FStampaStorico.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=AData;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA092FStampaStorico.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  C700DataDal:=DaData;
  C700DataLavoro:=AData;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA092FStampaStorico.FormDestroy(Sender: TObject);
begin
  A092FStampa.Release;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

end.
