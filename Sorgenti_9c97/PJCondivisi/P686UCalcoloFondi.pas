unit P686UCalcoloFondi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ExtCtrls, Buttons, Mask, C180FunzioniGenerali,
  A000UCostanti, A000USessione, A000UInterfaccia, C004UParamForm, A003UDataLavoroBis, ComCtrls,
  Menus, Oracle, OracleData;

type
  TP686FCalcoloFondi = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    clbFondi: TCheckListBox;
    edtDecorrenzaDa: TMaskEdit;
    edtDecorrenzaA: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnDecorrenzaDa: TBitBtn;
    btnDecorrenzaA: TBitBtn;
    rgpStatoCedolini: TRadioGroup;
    edtDataMonit: TMaskEdit;
    Label3: TLabel;
    btnDataMonit: TBitBtn;
    btnEsegui: TBitBtn;
    btnChiudi: TBitBtn;
    lblTabelle: TLabel;
    ProgressBar1: TProgressBar;
    StatusBar1: TStatusBar;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDecorrenzaDaClick(Sender: TObject);
    procedure btnDecorrenzaAClick(Sender: TObject);
    procedure btnDataMonitClick(Sender: TObject);
    procedure edtDecorrenzaDaExit(Sender: TObject);
    procedure edtDecorrenzaAExit(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
  private
    { Private declarations }
    Inizio,Fine:TDateTime;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure AggiornaListaFondi;
  public
    { Public declarations }
  end;

var
  P686FCalcoloFondi: TP686FCalcoloFondi;

  procedure OpenP686CalcoloFondi;

implementation

uses P686UCalcoloFondiDtM;

{$R *.dfm}

procedure OpenP686CalcoloFondi;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenP686CalcoloFondi') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TP686FCalcoloFondi,P686FCalcoloFondi);
  with P686FCalcoloFondi do
    try
      P686FCalcoloFondiDtM:=TP686FCalcoloFondiDtM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      P686FCalcoloFondiDtM.Free;
      Free;
    end;
end;

procedure TP686FCalcoloFondi.btnDataMonitClick(Sender: TObject);
begin
  edtDataMonit.Text:=DateToStr(DataOut(StrToDate(edtDataMonit.Text),'Data monitoraggio','G'));
end;

procedure TP686FCalcoloFondi.btnDecorrenzaAClick(Sender: TObject);
begin
  edtDecorrenzaA.Text:=DateToStr(DataOut(StrToDate(edtDecorrenzaA.Text),'Alla scadenza','G'));
end;

procedure TP686FCalcoloFondi.btnDecorrenzaDaClick(Sender: TObject);
begin
  edtDecorrenzaDa.Text:=DateToStr(DataOut(StrToDate(edtDecorrenzaDa.Text),'Dalla decorrenza','G'));
end;

procedure TP686FCalcoloFondi.btnEseguiClick(Sender: TObject);
var i:Integer;
  lstFondi:TStringList;
  TotImp:Real;
begin
  Inizio:=StrToDate(edtDecorrenzaDa.Text);
  Fine:=StrToDate(edtDecorrenzaA.Text);
  if Fine < Inizio then
  begin
    edtDecorrenzaDa.SetFocus;
    raise exception.Create('''Alla scadenza'' deve essere maggiore di ''Dalla decorrenza''!');
  end;
  lstFondi:=TStringList.Create;
  lstFondi.Clear;
  for i:=0 to clbFondi.Count - 1 do
  begin
    if clbFondi.Checked[i] then
      lstFondi.Add(Trim(Copy(clbFondi.Items[i],1,Pos('-',clbFondi.Items[i])-1)));
  end;
  if lstFondi.Count = 0 then
  begin
    clbFondi.SetFocus;
    raise exception.Create('Selezionare almeno un fondo da calcolare!');
  end;
  if R180MessageBox('Confermi l''elaborazione dei fondi selezionati? L''operazione potrebbe richiedere diversi minuti.','DOMANDA') <> mrYes then
    Exit;
  with P686FCalcoloFondiDtM do
  begin
    Screen.Cursor:=crHourGlass;
    selP690.Close; //Chiudo la tab.per forzare la cancellaz.in caso di ri-esecuz.
    selP500.Close;
    selP500.SetVariable('Anno',R180Anno(Fine));
    selP500.Open;
    selP050.Close;
    selP050.SetVariable('CODVALUTA',selP500.FieldByName('COD_VALUTA').AsString);
    selP050.SetVariable('DECORRENZA',Fine);
    selP050.Open;
    selP688Conta.SetVariable('COD','''' + StringReplace(lstFondi.CommaText,',',''',''',[rfReplaceAll]) + '''');
    selP688Conta.SetVariable('INIZIO',Inizio);
    selP688Conta.SetVariable('FINE',Fine);
    selP688Conta.Execute;
    ProgressBar1.Max:=StrToIntDef(VarToStr(selP688Conta.Field(0)),0);
    ProgressBar1.Position:=0;
    for i:=0 to lstFondi.Count - 1 do
    try
      StatusBar1.Panels[0].Text:='Elaborazione fondo ' + lstFondi.Strings[i] + ' in corso...';
      StatusBar1.Repaint;
      //ciclo su tutte le decorrenze di ogni fondo estratte da P688
      selP688.Close;
      selP688.SetVariable('COD',lstFondi.Strings[i]);
      selP688.SetVariable('INIZIO',Inizio);
      selP688.SetVariable('FINE',Fine);
      selP688.Open;
      while not selP688.Eof do
      begin
        ProgressBar1.StepBy(1);
        if (not selP690.Active) or
          (selP690.FieldByName('COD_FONDO').AsString <> selP688.FieldByName('COD_FONDO').AsString) or
          (selP690.FieldByName('DECORRENZA_DA').AsDateTime <> selP688.FieldByName('DECORRENZA_DA').AsDateTime) then
        begin
          selP690.Close;
          selP690.SetVariable('COD',selP688.FieldByName('COD_FONDO').AsString);
          selP690.SetVariable('DEC',selP688.FieldByName('DECORRENZA_DA').AsDateTime);
          selP690.Open;
          while not selP690.Eof do
            selP690.Delete;
        end;
        selP442.Close;
        case rgpStatoCedolini.ItemIndex of
          0:selP442.SetVariable('STATOCEDOLINI','''S''');
          1:selP442.SetVariable('STATOCEDOLINI','''S'',''N''');
          2:selP442.SetVariable('STATOCEDOLINI','''N''');
        end;
        selP442.SetVariable('DATAINIZIOCOMPETENZA',selP688.FieldByName('DECORRENZA_DA').AsDateTime);
        selP442.SetVariable('DATAFINECOMPETENZA',selP688.FieldByName('DECORRENZA_A').AsDateTime);
        selP442.SetVariable('ACCORPAMENTI',selP688.FieldByName('CODICI_ACCORPAMENTOVOCI').AsString);
        if Trim(selP688.FieldByName('FILTRO_DIPENDENTI').AsString) <> '' then
          selP442.SetVariable('FILTRODIPENDENTI',selP688.FieldByName('FILTRO_DIPENDENTI').AsString)
        else if Trim(selP688.FieldByName('FILTROP684').AsString) <> '' then
          selP442.SetVariable('FILTRODIPENDENTI',selP688.FieldByName('FILTROP684').AsString)
        else //Forzo condizione sempre vera
          selP442.SetVariable('FILTRODIPENDENTI','1 = 1');
        selP442.Open;
        TotImp:=0;
        while not selP442.Eof do
        begin
          selP690.Insert;
          selP690.FieldByName('COD_FONDO').AsString:=selP688.FieldByName('COD_FONDO').AsString;
          selP690.FieldByName('DECORRENZA_DA').AsDateTime:=selP688.FieldByName('DECORRENZA_DA').AsDateTime;
          selP690.FieldByName('CLASS_VOCE').AsString:='D';
          selP690.FieldByName('COD_VOCE_GEN').AsString:=selP688.FieldByName('COD_VOCE_GEN').AsString;
          selP690.FieldByName('COD_VOCE_DET').AsString:=selP688.FieldByName('COD_VOCE_DET').AsString;
          selP690.FieldByName('DATA_RETRIBUZIONE').AsDateTime:=selP442.FieldByName('DATA_RETRIBUZIONE').AsDateTime;
          selP690.FieldByName('COD_CONTRATTO').AsString:=selP442.FieldByName('COD_CONTRATTO').AsString;
          selP690.FieldByName('COD_VOCE').AsString:=selP442.FieldByName('COD_VOCE').AsString;
          selP690.FieldByName('IMPORTO').AsFloat:=selP442.FieldByName('IMPORTO').AsFloat;
          selP690.Post;
          TotImp:=TotImp + selP442.FieldByName('IMPORTO').AsFloat;
          selP442.Next;
        end;
        updP684.SetVariable('DTMONIT',StrToDate(edtDataMonit.Text));
        updP684.SetVariable('COD',selP688.FieldByName('COD_FONDO').AsString);
        updP684.SetVariable('DEC',selP688.FieldByName('DECORRENZA_DA').AsDateTime);
        updP684.Execute;
        if selP688.FieldByName('COD_ARROTONDAMENTO').AsString <> '' then
        begin
          if selP050.SearchRecord('Cod_Arrotondamento',selP688.FieldByName('COD_ARROTONDAMENTO').AsString,[srFromBeginning]) and
            (TotImp <> 0) then
            TotImp:=R180Arrotonda(TotImp,selP050.FieldByName('VALORE').AsFloat,selP050.FieldByName('TIPO').AsString);
        end;
        updP688.SetVariable('IMP',TotImp);
        updP688.SetVariable('COD',selP688.FieldByName('COD_FONDO').AsString);
        updP688.SetVariable('DEC',selP688.FieldByName('DECORRENZA_DA').AsDateTime);
        updP688.SetVariable('CODGEN',selP688.FieldByName('COD_VOCE_GEN').AsString);
        updP688.SetVariable('CODDET',selP688.FieldByName('COD_VOCE_DET').AsString);
        updP688.Execute;
        selP688.Next;
      end;
      SessioneOracle.Commit;
    except
      on E:exception do
      begin
        SessioneOracle.Rollback;
        Screen.Cursor:=crDefault;
        StatusBar1.Panels[0].Text:='';
        ProgressBar1.Position:=0;
        R180MessageBox('Elaborazione fallita:' + E.Message,'ERRORE');
      end;
    end;
  end;
  FreeAndNil(lstFondi);
  Screen.Cursor:=crDefault;
  StatusBar1.Panels[0].Text:='';
  ProgressBar1.Position:=0;
  R180MessageBox('Elaborazione terminata correttamente!','INFORMA');
end;

procedure TP686FCalcoloFondi.edtDecorrenzaAExit(Sender: TObject);
begin
  AggiornaListaFondi;
end;

procedure TP686FCalcoloFondi.edtDecorrenzaDaExit(Sender: TObject);
begin
  AggiornaListaFondi;
end;

procedure TP686FCalcoloFondi.AggiornaListaFondi;
begin
  with P686FCalcoloFondiDtM do
  begin
    if (StrToDate(edtDecorrenzaDa.Text) <> selP684.GetVariable('INIZIO')) or
       (StrToDate(edtDecorrenzaA.Text) <> selP684.GetVariable('FINE')) then
    begin
      clbFondi.Items.Clear;
      selP684.Close;
      selP684.SetVariable('INIZIO',StrToDate(edtDecorrenzaDa.Text));
      selP684.SetVariable('FINE',StrToDate(edtDecorrenzaA.Text));
      selP684.Open;
      while not selP684.Eof do
      begin
        clbFondi.Items.Add(selP684.FieldByName('COD_FONDO').AsString + ' - ' +
          selP684.FieldByName('DESCRIZIONE').AsString);
        selP684.Next;
      end;
    end;
  end;
end;

procedure TP686FCalcoloFondi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TP686FCalcoloFondi.FormCreate(Sender: TObject);
begin
  A000SettaVariabiliAmbiente;
end;

procedure TP686FCalcoloFondi.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'P686',Parametri.ProgOper);
  GetParametriFunzione;
  edtDataMonit.Text:=DateToStr(Parametri.DataLavoro);
  Inizio:=StrToDate(edtDecorrenzaDa.Text);
  Fine:=StrToDate(edtDecorrenzaA.Text);
  AggiornaListaFondi;
end;

procedure TP686FCalcoloFondi.GetParametriFunzione;
{Leggo i parametri della form}
begin
  edtDecorrenzaDa.Text:=C004FParamForm.GetParametro('DECORRENZA_DA','01/01/' + IntToStr(R180Anno(Parametri.DataLavoro)));
  edtDecorrenzaA.Text:=C004FParamForm.GetParametro('DECORRENZA_A','31/12/' + IntToStr(R180Anno(Parametri.DataLavoro)));
end;

procedure TP686FCalcoloFondi.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('DECORRENZA_DA',edtDecorrenzaDa.Text);
  C004FParamForm.PutParametro('DECORRENZA_A',edtDecorrenzaA.Text);
  try SessioneOracle.Commit; except end;
end;

procedure TP686FCalcoloFondi.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  clbFondi.SetFocus;
  for i:=0 to clbFondi.Items.Count - 1 do
    if Sender = SelezionaTutto1 then
      clbFondi.Checked[i]:=True
    else if Sender = DeselezionaTutto1 then
      clbFondi.Checked[i]:=False
    else if Sender = InvertiSelezione1 then
      clbFondi.Checked[i]:=not clbFondi.Checked[i];
end;

end.
