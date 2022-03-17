unit A170UGestioneGruppi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Spin, A000UCostanti, A000USessione, A000UInterfaccia,
  C004UParamForm, C013UCheckList, C180FunzioniGenerali, ComCtrls, OracleData,
  Oracle, DBCtrls, DB, A083UMsgElaborazioni, A169UCalcoloDTM, StrUtils, Mask, A003UDataLavoroBis,
  Grids, Math, A000UMessaggi, A170UGestioneGruppiMW, Generics.Collections;

type
  TA170FGestioneGruppi = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    btnEsegui: TBitBtn;
    btnAnomalie: TBitBtn;
    ProgressBar1: TProgressBar;
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    tabPesature: TTabSheet;
    tabSchedeQuant: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dtxtQuota1: TDBText;
    edtAnno1: TSpinEdit;
    edtGruppi1: TEdit;
    chkChiusura1: TCheckBox;
    chkApertura1: TCheckBox;
    chkAggiorna1: TCheckBox;
    dcmbQuota1: TDBLookupComboBox;
    btnGruppi1: TBitBtn;
    lblAnno2: TLabel;
    Label5: TLabel;
    lblGruppi2: TLabel;
    dtxtQuota2: TDBText;
    edtAnno2: TSpinEdit;
    edtGruppi2: TEdit;
    chkChiusura2: TCheckBox;
    chkApertura2: TCheckBox;
    dcmbQuota2: TDBLookupComboBox;
    btnGruppi2: TBitBtn;
    chkAggiorna2: TCheckBox;
    chkPassaggioAnno2: TCheckBox;
    lblDataRif2: TLabel;
    edtDataRif2: TMaskEdit;
    btnDataRif2: TBitBtn;
    gpbPagamenti2: TGroupBox;
    grdPagamenti: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkChiusura1Click(Sender: TObject);
    procedure chkApertura1Click(Sender: TObject);
    procedure chkAggiorna1Click(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnGruppi1Click(Sender: TObject);
    procedure edtAnno1Change(Sender: TObject);
    procedure dcmbQuota1CloseUp(Sender: TObject);
    procedure dcmbQuota1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAnomalieClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure dcmbQuota2CloseUp(Sender: TObject);
    procedure dcmbQuota2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGruppi2Click(Sender: TObject);
    procedure chkAggiorna2Click(Sender: TObject);
    procedure btnDataRif2Click(Sender: TObject);
    procedure grdPagamentiGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure edtAnno2Change(Sender: TObject);
  private
    { Private declarations }
    InterrompiElaborazione:Boolean;
    lstGruppi:TStringList;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ElaboraPesature;
    procedure ElaboraSchedeQuant;
    procedure AbilitazioniSchede;
    procedure AggiornamentoSchede;
    procedure PassaggioAnnoSchede;
  public
    { Public declarations }
  end;

var
  A170FGestioneGruppi: TA170FGestioneGruppi;

  procedure OpenA170GestioneGruppi;

implementation

uses A170UGestioneGruppiDtM;

{$R *.dfm}

procedure OpenA170GestioneGruppi;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA170GestioneGruppi') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A170FGestioneGruppi:=TA170FGestioneGruppi.Create(nil);
  A170FGestioneGruppiDtM:=TA170FGestioneGruppiDtM.Create(nil);
  try
    A170FGestioneGruppi.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A170FGestioneGruppiDtM.Free;
    A170FGestioneGruppi.Free;
  end;
end;

procedure TA170FGestioneGruppi.btnAnomalieClick(Sender: TObject);
begin
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A170','');
end;

procedure TA170FGestioneGruppi.btnDataRif2Click(Sender: TObject);
begin
  edtDataRif2.Text:=DateToStr(DataOut(PArametri.DataLavoro,'Data riferimento','G'));
end;

procedure TA170FGestioneGruppi.btnEseguiClick(Sender: TObject);
begin
  if PageControl1.ActivePage = tabPesature then
    ElaboraPesature
  else
    ElaboraSchedeQuant;
end;

procedure TA170FGestioneGruppi.ElaboraPesature;
var s:String;
  i:Integer;
begin
  if Trim(edtGruppi1.Text) = '' then
  begin
    edtGruppi1.SetFocus;
    raise Exception.Create(A000MSG_A170_ERR_GRUPPI_PESATURE);
  end;
  s:='';
  if chkChiusura1.Checked or chkApertura1.Checked then
  begin
    if chkChiusura1.Checked then
      s:=A000MSG_A170_DLG_FMT_CHIUSURA_PESATURE
    else if chkApertura1.Checked then
      s:=A000MSG_A170_DLG_FMT_RIAPERTURA_PESATURE;
    if R180MessageBox(Format(s,[edtAnno1.Text]),'DOMANDA') <> mrYes then
      Exit;
    A170FGestioneGruppiDtM.A170FGestioneGruppiMW.AperturaChiusuraPesature(StrToIntDef(edtAnno1.Text,0),dcmbQuota1.Text,edtGruppi1.Text,chkChiusura1.Checked);
    R180MessageBox('Elaborazione terminata','INFORMA');
  end
  else  //Aggiornamento gruppi
  begin
    if R180MessageBox(Format(A000MSG_A170_DLG_FMT_AGGIORNA_PESATURE,[edtAnno1.Text]),'DOMANDA') <> mrYes then
      Exit;
    lstGruppi:=TStringList.Create;
    lstGruppi.Clear;
    lstGruppi.CommaText:=edtGruppi1.Text;
    btnAnomalie.Enabled:=False;
    Screen.Cursor:=crHourGlass;
    A170FGestioneGruppi.KeyPreview:=True;
    RegistraMsg.IniziaMessaggio('A170');
    A170FGestioneGruppiDtM.A170FGestioneGruppiMW.InizioElaborazioneGruppiPesature;

    for i:=0 to lstGruppi.Count - 1 do
    begin
      StatusBar1.Panels[0].Text:='Aggiornamento gruppo ''' + lstGruppi.Strings[i] + ''' in corso...premere Esc per interrompere';
      StatusBar1.Repaint;
      if A170FGestioneGruppiDtM.A170FGestioneGruppiMW.VerificheElaborazioneGruppoPesature(StrToIntDef(edtAnno1.Text,0), dcmbQuota1.Text,lstGruppi.Strings[i]) then
      begin
        ProgressBar1.Max:=A170FGestioneGruppiDtM.A170FGestioneGruppiMW.selV430.RecordCount;
        ProgressBar1.Position:=0;
        A170FGestioneGruppiDtM.A170FGestioneGruppiMW.selV430.First;
        while not A170FGestioneGruppiDtM.A170FGestioneGruppiMW.selV430.Eof do
        begin
          Application.ProcessMessages;
          if InterrompiElaborazione then
          begin
            InterrompiElaborazione:=False;
            Screen.Cursor:=crDefault;
            ProgressBar1.Position:=0;
            StatusBar1.Panels[0].Text:='';
            raise exception.Create('Operazione interrotta dall''operatore.');
          end;
          ProgressBar1.StepBy(1);
          A170FGestioneGruppiDtM.A170FGestioneGruppiMW.ElaboraGruppoPesature;
          A170FGestioneGruppiDtM.A170FGestioneGruppiMW.selV430.Next;
        end;
      end;
    end;
    A170FGestioneGruppiDtM.A170FGestioneGruppiMW.FineElaborazioneGruppiPesature;
    FreeAndNil(lstGruppi);
    Screen.Cursor:=crDefault;
    StatusBar1.Panels[0].Text:='';
    ProgressBar1.Position:=0;
    A170FGestioneGruppi.KeyPreview:=False;
    btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
    if RegistraMsg.ContieneTipoA then
    begin
      if (R180MessageBox('Elaborazione terminata con anomalie. Si desidera visualizzarle?',DOMANDA) = mrYes) then
        btnAnomalieClick(nil);
    end
    else
      R180MessageBox('Elaborazione terminata',INFORMA);
  end;
end;

procedure TA170FGestioneGruppi.ElaboraSchedeQuant;
var s:String;
begin
  if (not chkPassaggioAnno2.Checked) and (Trim(edtGruppi2.Text) = '') then
  begin
    edtGruppi2.SetFocus;
    raise Exception.Create(A000MSG_A170_ERR_GRUPPI_SCHEDE);
  end;
  RegistraMsg.IniziaMessaggio('A170');
  btnAnomalie.Enabled:=False;
  if chkChiusura2.Checked or chkApertura2.Checked then
  begin
    s:='';
    if chkChiusura2.Checked then
      s:=A000MSG_A170_DLG_FMT_CHIUSURA_SCHEDE
    else if chkApertura2.Checked then
      s:=A000MSG_A170_DLG_FMT_RIAPERTURA_SCHEDE;

    if R180MessageBox(Format(s,[edtAnno2.Text]),'DOMANDA') <> mrYes then
      Exit;

    A170FGestioneGruppiDtM.A170FGestioneGruppiMW.AperturaChiusuraSchede(StrToIntDef(edtAnno2.Text,0),dcmbQuota2.Text,edtGruppi2.Text,chkChiusura2.Checked);
  end
  else if chkPassaggioAnno2.Checked then
  begin
    if R180MessageBox(Format(A000MSG_A170_DLG_FMT_PASSAGGIO_ANNO_SCHEDE,[IntToStr(StrToIntDef(edtAnno2.Text,0)-1),edtAnno2.Text,edtAnno2.Text]),'DOMANDA') <> mrYes then
      Exit;
    PassaggioAnnoSchede;
  end
  else  //Aggiornamento gruppi
  begin
    if R180MessageBox(Format(A000MSG_A170_DLG_FMT_AGGIORNA_SCHEDE,[edtAnno2.Text]),'DOMANDA') <> mrYes then
      Exit;
    Screen.Cursor:=crHourGlass;
    A170FGestioneGruppi.KeyPreview:=True;
    lstGruppi:=TStringList.Create;
    lstGruppi.Clear;
    lstGruppi.CommaText:=edtGruppi2.Text;
    AggiornamentoSchede;
    FreeAndNil(lstGruppi);
    Screen.Cursor:=crDefault;
    A170FGestioneGruppi.KeyPreview:=False;
  end;
  btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
  if RegistraMsg.ContieneTipoA then
  begin
    if (R180MessageBox('Elaborazione terminata con anomalie. Si desidera visualizzarle?',DOMANDA) = mrYes) then
      btnAnomalieClick(nil);
  end
  else
    R180MessageBox('Elaborazione terminata',INFORMA);
end;

procedure TA170FGestioneGruppi.AggiornamentoSchede;
var
  Tot:Real;
  TotOre,i:Integer;

begin
  for i:=0 to lstGruppi.Count - 1 do
  begin
    Tot:=0;
    TotOre:=0;
    StatusBar1.Panels[0].Text:='Aggiornamento gruppo ''' + lstGruppi.Strings[i] + ''' in corso...premere Esc per interrompere';
    StatusBar1.Repaint;
    if A170FGestioneGruppiDtM.A170FGestioneGruppiMW.VerificheElaborazioneGruppoSchede(StrToIntDef(edtAnno2.Text,0), dcmbQuota2.Text,lstGruppi.Strings[i])then
    begin
      ProgressBar1.Max:=A170FGestioneGruppiDtM.A170FGestioneGruppiMW.selV430ScInd.RecordCount;
      ProgressBar1.Position:=0;
      A170FGestioneGruppiDtM.A170FGestioneGruppiMW.selV430ScInd.First;
      while not A170FGestioneGruppiDtM.A170FGestioneGruppiMW.selV430ScInd.Eof do
      begin
        Application.ProcessMessages;
        if InterrompiElaborazione then
        begin
          InterrompiElaborazione:=False;
          Screen.Cursor:=crDefault;
          ProgressBar1.Position:=0;
          StatusBar1.Panels[0].Text:='';
          raise exception.Create('Operazione interrotta dall''operatore.');
        end;
        ProgressBar1.StepBy(1);
        A170FGestioneGruppiDtM.A170FGestioneGruppiMW.ElaboraGruppoSchede(Tot,TotOre);
        A170FGestioneGruppiDtM.A170FGestioneGruppiMW.selV430ScInd.Next;
      end;
      A170FGestioneGruppiDtM.A170FGestioneGruppiMW.ImpostaTotaleGruppoSchede(Tot,TotOre);
    end;
  end;
  StatusBar1.Panels[0].Text:='';
  ProgressBar1.Position:=0;
end;

procedure TA170FGestioneGruppi.PassaggioAnnoSchede;
var DataRif:TDateTime;
  InputString:String;
  NumGruppi: Integer;
  Pagamenti: TPagamenti;
  lstPagamenti: TList<TPagamenti>;
  i: Integer;
begin
  //Ribaltamento sul nuovo anno delle schede
  try
    DataRif:=StrToDate(edtDataRif2.Text);
  except
    raise Exception.Create(A000MSG_A170_ERR_DATA_RIF_SCHEDE);
  end;
  //Verificare che datarif sia compresa nel nuovo anno
  if R180Anno(DataRif) <> StrToIntDef(edtAnno2.Text,0) then
    raise Exception.Create(A000MSG_A170_ERR_ANNO_DATA_RIF_SCHEDE);
  //Verificare che la quota sia indicata
  if (Trim(dcmbQuota2.Text) = '') then
    raise Exception.Create(A000MSG_A170_ERR_TIPOLOGIA_QUOTA);
  //Verificare che il pagamento sia indicato
  if (IfThen(Trim(grdPagamenti.Cells[1,1]) = '.','',Trim(grdPagamenti.Cells[1,1])) = '') and
     (StrToFloatDef(Trim(grdPagamenti.Cells[1,2]),0) = 0) and
     (IfThen(Trim(grdPagamenti.Cells[2,1]) = '.','',Trim(grdPagamenti.Cells[2,1])) = '') and
     (StrToFloatDef(Trim(grdPagamenti.Cells[2,2]),0) = 0) and
     (IfThen(Trim(grdPagamenti.Cells[3,1]) = '.','',Trim(grdPagamenti.Cells[3,1])) = '') and
     (StrToFloatDef(Trim(grdPagamenti.Cells[3,2]),0) = 0) and
     (IfThen(Trim(grdPagamenti.Cells[4,1]) = '.','',Trim(grdPagamenti.Cells[4,1])) = '') and
     (StrToFloatDef(Trim(grdPagamenti.Cells[4,2]),0) = 0) and
     (IfThen(Trim(grdPagamenti.Cells[5,1]) = '.','',Trim(grdPagamenti.Cells[5,1])) = '') and
     (StrToFloatDef(Trim(grdPagamenti.Cells[5,2]),0) = 0) and
     (IfThen(Trim(grdPagamenti.Cells[6,1]) = '.','',Trim(grdPagamenti.Cells[6,1])) = '') and
     (StrToFloatDef(Trim(grdPagamenti.Cells[6,2]),0) = 0) and
     (IfThen(Trim(grdPagamenti.Cells[7,1]) = '.','',Trim(grdPagamenti.Cells[7,1])) = '') and
     (StrToFloatDef(Trim(grdPagamenti.Cells[7,2]),0) = 0) and
     (IfThen(Trim(grdPagamenti.Cells[8,1]) = '.','',Trim(grdPagamenti.Cells[8,1])) = '') and
     (StrToFloatDef(Trim(grdPagamenti.Cells[8,2]),0) = 0) and
     (IfThen(Trim(grdPagamenti.Cells[9,1]) = '.','',Trim(grdPagamenti.Cells[9,1])) = '') and
     (StrToFloatDef(Trim(grdPagamenti.Cells[9,2]),0) = 0) and
     (IfThen(Trim(grdPagamenti.Cells[10,1]) = '.','',Trim(grdPagamenti.Cells[10,1])) = '') and
     (StrToFloatDef(Trim(grdPagamenti.Cells[10,2]),0) = 0) and
     (IfThen(Trim(grdPagamenti.Cells[11,1]) = '.','',Trim(grdPagamenti.Cells[11,1])) = '') and
     (StrToFloatDef(Trim(grdPagamenti.Cells[11,2]),0) = 0) and
     (IfThen(Trim(grdPagamenti.Cells[12,1]) = '.','',Trim(grdPagamenti.Cells[12,1])) = '') and
     (StrToFloatDef(Trim(grdPagamenti.Cells[12,2]),0) = 0) then
    if R180MessageBox(A000MSG_A170_DLG_NO_MESE_PAGAMENTO,'DOMANDA') <> mrYes then
      Exit;
  with A170FGestioneGruppiDtM do
  begin
    NumGruppi:=A170FGestioneGruppiMW.VerificaGruppiApertiSchede(StrToIntDef(edtAnno2.Text,0),dcmbQuota2.Text);
    if NumGruppi > 0 then
    begin
      if R180MessageBox(Format(A000MSG_A170_DLG_FMT_GRUPPI_APERTI_SCHEDE,[IntToStr(NumGruppi),edtAnno2.Text]),'DOMANDA') <> mrYes then
        Exit;
      InputString:= InputBox('Conferma operazione', 'Indicare il numero di gruppi da sovrascrivere:', '0');
      if (InputString = '0') or (InputString <> IntToStr(NumGruppi)) then
        raise Exception.Create('Operazione annullata.');
    end;
    lstGruppi:=TStringList.Create;
    lstGruppi.Clear;

    lstPagamenti:=TList<TPagamenti>.Create();
    for i:=1 to 12 do
    begin
      pagamenti.max:=IfThen(Trim(grdPagamenti.Cells[i,1]) = '.','',grdPagamenti.Cells[i,1]);
      pagamenti.perc:=IfThen(Trim(grdPagamenti.Cells[i,2]) = '',0,StrToFloatDef(Trim(grdPagamenti.Cells[i,2]),-1));
      lstPagamenti.add(pagamenti);
    end;

    A170FGestioneGruppiMW.InizioElaborazionePassaggioAnno(StrToIntDef(edtAnno2.Text,0),dcmbQuota2.Text,DataRif,lstPagamenti,lstGruppi);
    FreeAndNil(lstPagamenti);
    // Riaggiornare tutti i gruppi creati
    AggiornamentoSchede;
    FreeAndNil(lstGruppi);
    A170FGestioneGruppiMW.FineElaborazionePassaggioAnno(StrToIntDef(edtAnno2.Text,0),dcmbQuota2.Text);
  end;
end;

procedure TA170FGestioneGruppi.btnGruppi1Click(Sender: TObject);
var
  ElencoValoriChecklist: TElencoValoriChecklist;
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  try
    ElencoValoriChecklist:=A170FGestioneGruppiDtM.A170FGestioneGruppiMW.ListGruppiPesature(StrToIntDef(edtAnno1.Text,0),dcmbQuota1.Text);
    clbListaDati.items.Clear;
    clbListaDati.items.assign(ElencoValoriChecklist.lstDescrizione);

    R180PutCheckList(edtGruppi1.Text,10,C013FCheckList.clbListaDati);
    if ShowModal = mrOK then
      edtGruppi1.Text:=R180GetCheckList(10,C013FCheckList.clbListaDati);
  finally
    FreeAndNil(ElencoValoriChecklist);
    Release;
  end;
end;

procedure TA170FGestioneGruppi.btnGruppi2Click(Sender: TObject);
var ElencoValoriChecklist: TElencoValoriChecklist;
begin
  C013FCheckList:=TC013FCheckList.Create(nil);

  with C013FCheckList do
  try
    ElencoValoriChecklist:=A170FGestioneGruppiDtM.A170FGestioneGruppiMW.ListGruppiSchede(StrToIntDef(edtAnno2.Text,0),dcmbQuota2.Text);
    clbListaDati.items.Clear;
    clbListaDati.items.assign(ElencoValoriChecklist.lstDescrizione);

    R180PutCheckList(edtGruppi2.Text,10,C013FCheckList.clbListaDati);
    if ShowModal = mrOK then
      edtGruppi2.Text:=R180GetCheckList(10,C013FCheckList.clbListaDati);
  finally
    FreeAndNil(ElencoValoriChecklist);
    Release;
  end;
end;

procedure TA170FGestioneGruppi.chkAggiorna1Click(Sender: TObject);
begin
  btnEsegui.Enabled:=not SolaLettura and (chkChiusura1.Checked or chkApertura1.Checked or chkAggiorna1.Checked);
  chkApertura1.Enabled:=not chkAggiorna1.Checked;
  if not chkApertura1.Enabled then
    chkApertura1.Checked:=False;
  chkChiusura1.Enabled:=not chkAggiorna1.Checked;
  if not chkChiusura1.Enabled then
    chkChiusura1.Checked:=False;
end;

procedure TA170FGestioneGruppi.AbilitazioniSchede;
begin
  btnEsegui.Enabled:=not SolaLettura and (chkChiusura2.Checked or chkApertura2.Checked or chkAggiorna2.Checked or chkPassaggioAnno2.Checked);
  chkAggiorna2.Enabled:=not chkChiusura2.Checked and not chkApertura2.Checked and not chkPassaggioAnno2.Checked;
  if not chkAggiorna2.Enabled then
    chkAggiorna2.Checked:=False;
  chkApertura2.Enabled:=not chkChiusura2.Checked and not chkAggiorna2.Checked and not chkPassaggioAnno2.Checked;
  if not chkApertura2.Enabled then
    chkApertura2.Checked:=False;
  chkChiusura2.Enabled:=not chkApertura2.Checked and not chkAggiorna2.Checked and not chkPassaggioAnno2.Checked;
  if not chkChiusura2.Enabled then
    chkChiusura2.Checked:=False;
  chkPassaggioAnno2.Enabled:=not chkApertura2.Checked and not chkAggiorna2.Checked and not chkChiusura2.Checked;
  if not chkPassaggioAnno2.Enabled then
    chkPassaggioAnno2.Checked:=False;
  lblGruppi2.Visible:=not chkPassaggioAnno2.Checked;
  edtGruppi2.Visible:=not chkPassaggioAnno2.Checked;
  btnGruppi2.Visible:=not chkPassaggioAnno2.Checked;
  if not edtGruppi2.Visible then
    edtGruppi2.Text:='';
  if chkPassaggioAnno2.Checked then
    lblAnno2.Caption:='Nuovo anno'
  else
    lblAnno2.Caption:='Anno elaborazione';
  lblDataRif2.Visible:=chkPassaggioAnno2.Checked;
  edtDataRif2.Visible:=chkPassaggioAnno2.Checked;
  btnDataRif2.Visible:=chkPassaggioAnno2.Checked;
  gpbPagamenti2.Visible:=chkPassaggioAnno2.Checked;
end;

procedure TA170FGestioneGruppi.chkAggiorna2Click(Sender: TObject);
begin
  AbilitazioniSchede;
end;

procedure TA170FGestioneGruppi.chkApertura1Click(Sender: TObject);
begin
  btnEsegui.Enabled:=not SolaLettura and (chkChiusura1.Checked or chkApertura1.Checked or chkAggiorna1.Checked);
  chkChiusura1.Enabled:=not chkApertura1.Checked;
  if not chkChiusura1.Enabled then
    chkChiusura1.Checked:=False;
  chkAggiorna1.Enabled:=not chkApertura1.Checked;
  if not chkAggiorna1.Enabled then
    chkAggiorna1.Checked:=False;
end;

procedure TA170FGestioneGruppi.chkChiusura1Click(Sender: TObject);
begin
  btnEsegui.Enabled:=not SolaLettura and (chkChiusura1.Checked or chkApertura1.Checked or chkAggiorna1.Checked);
  chkApertura1.Enabled:=not chkChiusura1.Checked;
  if not chkApertura1.Enabled then
    chkApertura1.Checked:=False;
  chkAggiorna1.Enabled:=not chkChiusura1.Checked;
  if not chkAggiorna1.Enabled then
    chkAggiorna1.Checked:=False;
end;

procedure TA170FGestioneGruppi.dcmbQuota1CloseUp(Sender: TObject);
begin
  dtxtQuota1.Visible:=Trim(dcmbQuota1.Text) <> '';
  edtGruppi1.Text:='';
end;

procedure TA170FGestioneGruppi.dcmbQuota1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  dcmbQuota1CloseUp(nil);
end;

procedure TA170FGestioneGruppi.dcmbQuota2CloseUp(Sender: TObject);
begin
  dtxtQuota2.Visible:=Trim(dcmbQuota2.Text) <> '';
  edtGruppi2.Text:='';
end;

procedure TA170FGestioneGruppi.dcmbQuota2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  dcmbQuota2CloseUp(nil);
end;

procedure TA170FGestioneGruppi.edtAnno1Change(Sender: TObject);
begin
  with A170FGestioneGruppiDtM.A170FGestioneGruppiMW do
  begin
    selT773Quote.Close;
    selT773Quote.SetVariable('ANNO',StrToIntDef(edtAnno1.Text,0));
    selT773Quote.Open;
  end;
  dcmbQuota1CloseUp(nil);
end;

procedure TA170FGestioneGruppi.edtAnno2Change(Sender: TObject);
begin
  edtGruppi2.Text:='';
end;

procedure TA170FGestioneGruppi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA170FGestioneGruppi.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    if R180MessageBox('Si desidera interrompere l''operazione?','DOMANDA') = mrYes then
      InterrompiElaborazione:=True;
  end;
end;

procedure TA170FGestioneGruppi.FormShow(Sender: TObject);
var
  i: Integer;
begin
  CreaC004(SessioneOracle,'A170',Parametri.ProgOper);
  GetParametriFunzione;
  InterrompiElaborazione:=False;
  tabPesature.TabVisible:=A000GetInibizioni('Funzione','OpenA169PesatureIndividuali') <> 'N';
  tabSchedeQuant.TabVisible:=A000GetInibizioni('Funzione','OpenA172SchedeQuantIndividuali') <> 'N';
  //METTERE VISIBILI PER TEST SINGOLO PROGETTO
  //tabPesature.TabVisible:=True;
  //tabSchedeQuant.TabVisible:=True;
  if (not tabPesature.TabVisible) and (not tabSchedeQuant.TabVisible) then
    R180MessageBox(A000MSG_A170_ERR_ABIL_PES_SCHEDE,'INFORMA');
  grdPagamenti.Cells[0,1]:='Max.ore';
  grdPagamenti.Cells[0,2]:='% ore';
  for i:=1 to 12 do
    grdPagamenti.Cells[i,0]:=R180NomeMese(i);

  for i:=1 to 12 do
    grdPagamenti.Cells[i,2]:='0';
end;

procedure TA170FGestioneGruppi.GetParametriFunzione;
begin
  edtAnno1.Text:=C004FParamForm.GetParametro('ANNO1',Copy(DateToStr(Parametri.DataLavoro),7,4));
  edtAnno1Change(nil);
  dcmbQuota1.KeyValue:=C004FParamForm.GetParametro('QUOTA1','');
  edtGruppi1.Text:=C004FParamForm.GetParametro('GRUPPI1','');
  edtAnno2.Text:=C004FParamForm.GetParametro('ANNO2',Copy(DateToStr(Parametri.DataLavoro),7,4));
  dcmbQuota2.KeyValue:=C004FParamForm.GetParametro('QUOTA2','');
  edtGruppi2.Text:=C004FParamForm.GetParametro('GRUPPI2','');
end;

procedure TA170FGestioneGruppi.grdPagamentiGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  if grdPagamenti.Enabled and (ARow = 1) then
    Value:='!990:00;1;_';
end;

procedure TA170FGestioneGruppi.PutParametriFunzione;
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('ANNO1',edtAnno1.Text);
  C004FParamForm.PutParametro('QUOTA1',VarToStr(dcmbQuota1.KeyValue));
  C004FParamForm.PutParametro('GRUPPI1',edtGruppi1.Text);
  C004FParamForm.PutParametro('ANNO2',edtAnno2.Text);
  C004FParamForm.PutParametro('QUOTA2',VarToStr(dcmbQuota2.KeyValue));
  C004FParamForm.PutParametro('GRUPPI2',edtGruppi2.Text);
  try SessioneOracle.Commit; except end;
end;

end.
