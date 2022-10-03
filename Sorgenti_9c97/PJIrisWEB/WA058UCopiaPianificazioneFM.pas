unit WA058UCopiaPianificazioneFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,OracleData,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompButton, meIWButton,
  IWCompEdit, meIWEdit, medpIWMultiColumnComboBox, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, Data.DB,
  Datasnap.DBClient, C190FunzioniGeneraliWeb, A058UPianifTurniDtm1;

type
  TWA058FCopiaPianificazioneFM = class(TWR200FBaseFM)
    lblDip1: TmeIWLabel;
    lblDip2: TmeIWLabel;
    cmbDescrDip1: TMedpIWMultiColumnComboBox;
    LblDescrDip1: TmeIWLabel;
    cmbDescrDip2: TMedpIWMultiColumnComboBox;
    LblDescrDip2: TmeIWLabel;
    lblDataDa: TmeIWLabel;
    edtDataDa: TmeIWEdit;
    lblDataA: TmeIWLabel;
    edtDataA: TmeIWEdit;
    btnConferma: TmeIWButton;
    btnAnnulla: TmeIWButton;
    procedure cmbDescrDip2AsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure btnAnnullaClick(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
  private
    { Private declarations }
  public
    WA058SelAnagrafe :TOracleDataSEt;
    A058DettDM: TA058FPianifTurniDtm1;
    WA058TabFM: TFrame;
    FriendlyNameW030:String;
    CurrProg: String;
    procedure Visualizza;
    procedure AggiornaLabel;
  end;

implementation

uses WR010UBase, WA058UTabelloneTurniFM;

{$R *.dfm}

procedure TWA058FCopiaPianificazioneFM.cmbDescrDip2AsyncChange(Sender: TObject;EventParams: TStringList; Index: Integer; Value: string);
begin
  AggiornaLabel;
end;

procedure TWA058FCopiaPianificazioneFM.AggiornaLabel;
begin
  LblDescrDip1.Text:='';
  LblDescrDip2.Text:='';

  if Trim(cmbDescrDip1.Text) <> '' then
    LblDescrDip1.Text:=
      VarToStr(WA058SelAnagrafe.Lookup('PROGRESSIVO',cmbDescrDip1.Items[cmbDescrDip1.ItemIndex].RowData[4],'COGNOME')) + ' ' +
      VarToStr(WA058SelAnagrafe.Lookup('PROGRESSIVO',cmbDescrDip1.Items[cmbDescrDip1.ItemIndex].RowData[4],'NOME'));
  if Trim(cmbDescrDip2.Text) <> '' then
    LblDescrDip2.Text:=
      VarToStr(WA058SelAnagrafe.Lookup('PROGRESSIVO',cmbDescrDip2.Items[cmbDescrDip2.ItemIndex].RowData[4],'COGNOME')) + ' ' +
      VarToStr(WA058SelAnagrafe.Lookup('PROGRESSIVO',cmbDescrDip2.Items[cmbDescrDip2.ItemIndex].RowData[4],'NOME'));
end;

procedure TWA058FCopiaPianificazioneFM.Visualizza;
begin
  with WA058SelAnagrafe do
  begin
    First;
    while not Eof do
    begin
      cmbDescrDip1.AddRow(FieldByName('MATRICOLA').AsString+';'+FieldByName('T430BADGE').AsString+';'+FieldByName('COGNOME').AsString+';'+FieldByName('NOME').AsString+';'+FieldByName('PROGRESSIVO').AsString);
      cmbDescrDip2.AddRow(FieldByName('MATRICOLA').AsString+';'+FieldByName('T430BADGE').AsString+';'+FieldByName('COGNOME').AsString+';'+FieldByName('NOME').AsString+';'+FieldByName('PROGRESSIVO').AsString);
      Next;
    end;
  end;
  cmbDescrDip1.Text:=VarToStr(WA058SelAnagrafe.Lookup('PROGRESSIVO',CurrProg,'MATRICOLA'));
  cmbDescrDip2.Text:=VarToStr(WA058SelAnagrafe.Lookup('PROGRESSIVO',CurrProg,'MATRICOLA'));
  AggiornaLabel;
  (Self.Parent as TWR010FBase).VisualizzajQMessaggio(JQuery, Self.Width + 40, -1,EM2PIXEL * 50, 'Copia della pianificazione', '#WA058_CopiaPianif', False, True);
end;

procedure TWA058FCopiaPianificazioneFM.btnAnnullaClick(Sender: TObject);
begin
  Self.Free;
end;

procedure TWA058FCopiaPianificazioneFM.btnConfermaClick(Sender: TObject);
var progressivo1, progressivo2: Integer;
    i1,i2,i:Integer;
    D1,D2:TDateTime;
begin
  if StrToDate(edtDataDa.Text) > StrToDate(edtDataA.Text) then
    raise Exception.Create('Il periodo indicato non è valido!');
  if (Trim(cmbDescrDip1.Text) = '') or (Trim(cmbDescrDip2.Text) = '') then
    raise Exception.Create('Non hai indicato un dipendente!');

  progressivo1:=StrToInt(cmbDescrDip1.Items[cmbDescrDip1.ItemIndex].RowData[4]);
  progressivo2:=StrToInt(cmbDescrDip2.Items[cmbDescrDip2.ItemIndex].RowData[4]);

  with A058DettDM do
    if progressivo1 <> progressivo2 then
    begin
      i1:=-1;
      i2:=-1;
      D1:=StrToDate(edtDataDa.Text);
      D2:=StrToDate(edtDataA.Text);
      for i:=0 to Vista.Count - 1 do
      begin
        if TDipendente(Vista[i]).Prog = progressivo1 then
          i1:=i;
        if TDipendente(Vista[i]).Prog = progressivo2 then
          i2:=i;
        if (i1 >= 0) and (i2 >= 0) then
          Break;
      end;
      if (i1 >= 0) and (i2 >= 0) then
      begin
        //DatoModificato:=True;
        for i:=0 to Trunc(DataFine - DataInizio) do
        begin
          if (DataInizio + i >= D1) and ((DataInizio + i <= D2)) then
          begin
            TGiorno(TDipendente(Vista[i2]).Giorni[i]).T1:=TGiorno(TDipendente(Vista[i1]).Giorni[i]).T1;
            TGiorno(TDipendente(Vista[i2]).Giorni[i]).T2:=TGiorno(TDipendente(Vista[i1]).Giorni[i]).T2;
            TGiorno(TDipendente(Vista[i2]).Giorni[i]).SiglaT1:=TGiorno(TDipendente(Vista[i1]).Giorni[i]).SiglaT1;
            TGiorno(TDipendente(Vista[i2]).Giorni[i]).SiglaT2:=TGiorno(TDipendente(Vista[i1]).Giorni[i]).SiglaT2;
            TGiorno(TDipendente(Vista[i2]).Giorni[i]).NumTurno1:=TGiorno(TDipendente(Vista[i1]).Giorni[i]).NumTurno1;
            TGiorno(TDipendente(Vista[i2]).Giorni[i]).NumTurno2:=TGiorno(TDipendente(Vista[i1]).Giorni[i]).NumTurno2;
            TGiorno(TDipendente(Vista[i2]).Giorni[i]).T1EU:=TGiorno(TDipendente(Vista[i1]).Giorni[i]).T1EU;
            TGiorno(TDipendente(Vista[i2]).Giorni[i]).T2EU:=TGiorno(TDipendente(Vista[i1]).Giorni[i]).T2EU;
            TGiorno(TDipendente(Vista[i2]).Giorni[i]).Ora:=TGiorno(TDipendente(Vista[i1]).Giorni[i]).Ora;
            TGiorno(TDipendente(Vista[i2]).Giorni[i]).Modificato:=True;
            ConteggiGiornalieri(DataInizio + i,i2,i);
            DebitoDipendente(i2,0,Trunc(DataFine - DataInizio));
            AggiornaContatoriTurni(i2,i);
          end;
        end;
      end;
      with (WA058TabFM as TWA058FTabelloneTurniFM) do
      begin
        //WA058TrasformaComponenti(FriendlyNameW030,False);
        ListaToCds;
        VisualizzaGriglia;
        grdTabellone.medpBrowse:=True;
        A058OPerazione:='C';
        Abilitazioni;
        btnSalva.Visible:=True;
      end;
    end;
  Self.Free;
end;

end.
