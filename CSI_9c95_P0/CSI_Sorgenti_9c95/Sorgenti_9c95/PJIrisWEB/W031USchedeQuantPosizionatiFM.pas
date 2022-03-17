unit W031USchedeQuantPosizionatiFM;

interface

uses
  SysUtils, Classes, Controls, Forms, IWAppForm, OracleData,
  R010UPAGINAWEB,
  A000UCostanti, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  IWVCLBaseContainer, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWCompButton, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompLabel, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWTypes,
  IWCompEdit, IWDBStdCtrls, meIWDBEdit, meIWButton, meIWLabel,
  IWCompJQueryWidget;

type
  TW031FSchedeQuantPosizionatiFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    jQSchedeQuantPosizionati: TIWJQueryWidget;
    IWTemplateProcessorFrame: TIWTemplateProcessorHTML;
    dedtObiettivo1: TmeIWDBEdit;
    dedtObiettivo2: TmeIWDBEdit;
    dedtObiettivo3: TmeIWDBEdit;
    dedtObiettivo4: TmeIWDBEdit;
    dedtPeso4: TmeIWDBEdit;
    dedtPeso3: TmeIWDBEdit;
    dedtPeso2: TmeIWDBEdit;
    dedtPeso1: TmeIWDBEdit;
    btnChiudi: TmeIWButton;
    btnModifica: TmeIWButton;
    btnConferma: TmeIWButton;
    btnAnnulla: TmeIWButton;
    btnStampa: TmeIWButton;
    lblMessaggi: TmeIWLabel;
    lblTotale: TmeIWLabel;
    lblObiettivo1: TmeIWLabel;
    lblObiettivo2: TmeIWLabel;
    lblObiettivo3: TmeIWLabel;
    lblObiettivo4: TmeIWLabel;
    lblPeso1: TmeIWLabel;
    lblPeso2: TmeIWLabel;
    lblPeso3: TmeIWLabel;
    lblPeso4: TmeIWLabel;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
    procedure btnModificaClick(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure btnStampaClick(Sender: TObject);
  private
    { Private declarations }
  public
    Abilitazione,TipoScheda,Dip,Firmato:String;
    Anno,Prog:Integer;
    procedure Visualizza;
  end;

implementation

uses W031USchedeQuantIndividuali;

{$R *.dfm}

procedure TW031FSchedeQuantPosizionatiFM.btnAnnullaClick(Sender: TObject);
begin
  lblMessaggi.Visible:=False;
  TW031FSchedeQuantIndividuali(Self.Parent).selSG715.Cancel;
  btnModifica.Visible:=True;
  btnStampa.Visible:=True;
  btnConferma.Visible:=False;
  btnAnnulla.Visible:=False;
  btnChiudi.Enabled:=True;
end;

procedure TW031FSchedeQuantPosizionatiFM.btnChiudiClick(Sender: TObject);
begin
  Free;
end;

procedure TW031FSchedeQuantPosizionatiFM.btnConfermaClick(Sender: TObject);
var Tot:Real;
begin
  lblMessaggi.Visible:=False;
  if ((TW031FSchedeQuantIndividuali(Self.Parent).selSG715.FieldByName('PESO1').AsFloat <> 0) and
      (Trim(TW031FSchedeQuantIndividuali(Self.Parent).selSG715.FieldByName('OBIETTIVO1').AsString) = '')) or
     ((TW031FSchedeQuantIndividuali(Self.Parent).selSG715.FieldByName('PESO2').AsFloat <> 0) and
      (Trim(TW031FSchedeQuantIndividuali(Self.Parent).selSG715.FieldByName('OBIETTIVO2').AsString) = ''))  or
     ((TW031FSchedeQuantIndividuali(Self.Parent).selSG715.FieldByName('PESO3').AsFloat <> 0) and
      (Trim(TW031FSchedeQuantIndividuali(Self.Parent).selSG715.FieldByName('OBIETTIVO3').AsString) = '')) then
  begin
    lblMessaggi.Caption:='Specificare la descrizione dell''obiettivo!';
    lblMessaggi.Visible:=True;
    Exit;
  end;
  if ((TW031FSchedeQuantIndividuali(Self.Parent).selSG715.FieldByName('PESO1').AsFloat = 0) and
      (Trim(TW031FSchedeQuantIndividuali(Self.Parent).selSG715.FieldByName('OBIETTIVO1').AsString) <> '')) or
     ((TW031FSchedeQuantIndividuali(Self.Parent).selSG715.FieldByName('PESO2').AsFloat = 0) and
      (Trim(TW031FSchedeQuantIndividuali(Self.Parent).selSG715.FieldByName('OBIETTIVO2').AsString) <> ''))  or
     ((TW031FSchedeQuantIndividuali(Self.Parent).selSG715.FieldByName('PESO3').AsFloat = 0) and
      (Trim(TW031FSchedeQuantIndividuali(Self.Parent).selSG715.FieldByName('OBIETTIVO3').AsString) <> '')) then
  begin
    lblMessaggi.Caption:='Specificare il peso dell''obiettivo!';
    lblMessaggi.Visible:=True;
    Exit;
  end;
  if TW031FSchedeQuantIndividuali(Self.Parent).selSG715.FieldByName('PESO4').AsFloat < 40 then
  begin
    lblMessaggi.Caption:='Il peso dell''obiettivo 4 non può essere inferiore a 40!';
    lblMessaggi.Visible:=True;
    Exit;
  end;
  Tot:=TW031FSchedeQuantIndividuali(Self.Parent).selSG715.FieldByName('PESO1').AsFloat +
       TW031FSchedeQuantIndividuali(Self.Parent).selSG715.FieldByName('PESO2').AsFloat +
       TW031FSchedeQuantIndividuali(Self.Parent).selSG715.FieldByName('PESO3').AsFloat +
       TW031FSchedeQuantIndividuali(Self.Parent).selSG715.FieldByName('PESO4').AsFloat;
  if Tot <> 100 then
  begin
    lblMessaggi.Caption:='La somma totale dei pesi è ' + FloatToStr(Tot) + ' ma non può essere diversa da 100!';
    lblMessaggi.Visible:=True;
    Exit;
  end;
  try
    TW031FSchedeQuantIndividuali(Self.Parent).selSG715.Post;
    TW031FSchedeQuantIndividuali(Self.Parent).selSG715.Session.Commit;
  except
    on E:Exception do
    begin
      TW031FSchedeQuantIndividuali(Self.Parent).selSG715.Session.Rollback;
      lblMessaggi.Caption:='Variazione della scheda fallita!' + CRLF + 'Motivo: ' + E.Message;
      lblMessaggi.Visible:=True;
    end;
  end;
  btnModifica.Visible:=True;
  btnStampa.Visible:=True;
  btnConferma.Visible:=False;
  btnAnnulla.Visible:=False;
  btnChiudi.Enabled:=True;
end;

procedure TW031FSchedeQuantPosizionatiFM.btnModificaClick(Sender: TObject);
begin
  lblMessaggi.Visible:=False;
  btnModifica.Visible:=False;
  btnStampa.Visible:=False;
  btnConferma.Visible:=True;
  btnAnnulla.Visible:=True;
  btnChiudi.Enabled:=False;
  TW031FSchedeQuantIndividuali(Self.Parent).selSG715.Edit;
  dedtObiettivo4.Enabled:=False;
end;

procedure TW031FSchedeQuantPosizionatiFM.btnStampaClick(Sender: TObject);
var s:String;
begin
  lblMessaggi.Visible:=False;
  if Firmato = 'NO' then
  begin
    if Abilitazione = 'S' then
    begin
      s:='Attenzione: vuoi stampare la scheda DEFINITIVA per la firma del dipendente? ' +
         'La scheda definitiva verrà chiusa e non sarà più possibile modificarla.';
      TR010FPaginaWeb(Self.Parent).Messaggio('Conferma scheda definitiva',s,TW031FSchedeQuantIndividuali(Self.Parent).actStampaDef,TW031FSchedeQuantIndividuali(Self.Parent).actStampaProvv);
    end
    else
      TW031FSchedeQuantIndividuali(Self.Parent).actStampaProvv;
  end
  else
    TW031FSchedeQuantIndividuali(Self.Parent).actStampaDef;
end;

procedure TW031FSchedeQuantPosizionatiFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=TIWAppForm(Self.Owner);
end;

procedure TW031FSchedeQuantPosizionatiFM.Visualizza;
begin
  btnModifica.Visible:=(Abilitazione = 'S') and (Firmato = 'NO') and (TipoScheda = '2');
  btnConferma.Visible:=False;
  btnAnnulla.Visible:=False;
  dedtObiettivo1.DataSource:=TW031FSchedeQuantIndividuali(Self.Parent).dsrSG715;
  dedtObiettivo2.DataSource:=TW031FSchedeQuantIndividuali(Self.Parent).dsrSG715;
  dedtObiettivo3.DataSource:=TW031FSchedeQuantIndividuali(Self.Parent).dsrSG715;
  dedtObiettivo4.DataSource:=TW031FSchedeQuantIndividuali(Self.Parent).dsrSG715;
  dedtPeso1.DataSource:=TW031FSchedeQuantIndividuali(Self.Parent).dsrSG715;
  dedtPeso2.DataSource:=TW031FSchedeQuantIndividuali(Self.Parent).dsrSG715;
  dedtPeso3.DataSource:=TW031FSchedeQuantIndividuali(Self.Parent).dsrSG715;
  dedtPeso4.DataSource:=TW031FSchedeQuantIndividuali(Self.Parent).dsrSG715;

  TR010FPaginaWeb(Self.Parent).VisualizzajQMessaggio(jQSchedeQuantPosizionati, Self.Width + 25, -1,EM2PIXEL * 50, Dip, '#' + Name, False, True);
end;

end.