unit WA058UDettaglioTurnoFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWAppForm,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompListbox, meIWComboBox,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton,
  meIWButton, C190FunzioniGeneraliWeb, A058UPianifTurniDtm1;

type
  TWA058FDettaglioTurnoFM = class(TWR200FBaseFM)
    btnConferma: TmeIWButton;
    btnAnnulla: TmeIWButton;
    cmbTurno1: TmeIWComboBox;
    cmbTurnoEU1: TmeIWComboBox;
    cmbTurno2: TmeIWComboBox;
    cmbTurnoEU2: TmeIWComboBox;
    cmbOrario: TmeIWComboBox;
    cmbAss1: TmeIWComboBox;
    cmbAss2: TmeIWComboBox;
    procedure btnConfermaClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure cmbOrarioAsyncChange(Sender: TObject; EventParams: TStringList);
  private
    { Private declarations }
  public
    A058DettDM: TA058FPianifTurniDtm1;
    WA058TabFM: TFrame;
    IndDipendente, IndGiorno:Integer;
    FriendlyNameW030, CaptionTitolo:String;
    procedure VisualizzaScheda;
  end;

implementation

uses WR010UBase, WA058UTabelloneTurniFM, meIWLabel;

{$R *.dfm}

procedure TWA058FDettaglioTurnoFM.btnAnnullaClick(Sender: TObject);
begin
  Self.Free;
end;

procedure TWA058FDettaglioTurnoFM.btnConfermaClick(Sender: TObject);
begin
  with A058DettDM do
  begin
    Vista[IndDipendente].Giorni[IndGiorno].Ora:=Trim(copy(cmbOrario.Text,1,5));
    Vista[IndDipendente].Giorni[IndGiorno].T1:=cmbTurno1.Text;
    Vista[IndDipendente].Giorni[IndGiorno].SiglaT1:=(WA058TabFM as TWA058FTabelloneTurniFM).
                                                    GetTurni('SIGLATURNI',Vista[IndDipendente].Giorni[IndGiorno].Ora,
                                                                          Vista[IndDipendente].Giorni[IndGiorno].T1,
                                                                          Vista[IndDipendente].Giorni[IndGiorno].Data);
    Vista[IndDipendente].Giorni[IndGiorno].NumTurno1:=(WA058TabFM as TWA058FTabelloneTurniFM).
                                                      GetTurni('NUMTURNO',Vista[IndDipendente].Giorni[IndGiorno].Ora,
                                                                          Vista[IndDipendente].Giorni[IndGiorno].T1,
                                                                          Vista[IndDipendente].Giorni[IndGiorno].Data);
    Vista[IndDipendente].Giorni[IndGiorno].T1EU:=cmbTurnoEU1.Text;
    Vista[IndDipendente].Giorni[IndGiorno].T2:=cmbTurno2.Text;
    Vista[IndDipendente].Giorni[IndGiorno].SiglaT2:=(WA058TabFM as TWA058FTabelloneTurniFM).
                                                    GetTurni('SIGLATURNI',Vista[IndDipendente].Giorni[IndGiorno].Ora,
                                                                          Vista[IndDipendente].Giorni[IndGiorno].T2,
                                                                          Vista[IndDipendente].Giorni[IndGiorno].Data);
    Vista[IndDipendente].Giorni[IndGiorno].NumTurno2:=(WA058TabFM as TWA058FTabelloneTurniFM).
                                                      GetTurni('NUMTURNO',Vista[IndDipendente].Giorni[IndGiorno].Ora,
                                                                          Vista[IndDipendente].Giorni[IndGiorno].T2,
                                                                          Vista[IndDipendente].Giorni[IndGiorno].Data);
    Vista[IndDipendente].Giorni[IndGiorno].T2EU:=cmbTurnoEU2.Text;
    Vista[IndDipendente].Giorni[IndGiorno].Ass1:=Trim(copy(cmbAss1.Text,1,5));
    Vista[IndDipendente].Giorni[IndGiorno].Ass2:=Trim(copy(cmbAss2.Text,1,5));
    Vista[IndDipendente].Giorni[IndGiorno].Modificato:=True;
  end;
  with (WA058TabFM as TWA058FTabelloneTurniFM) do
  begin
    if grdTabellone.medpBrowse then
    begin
      ListaToCds;
      VisualizzaGriglia;
      btnSalva.Visible:=A058DettDM.Vista[IndDipendente].Giorni[IndGiorno].Modificato;
    end
    else
      WA058TrasformaComponenti(FriendlyNameW030,False);
  end;
  Self.Free;
end;

procedure TWA058FDettaglioTurnoFM.cmbOrarioAsyncChange(Sender: TObject;
  EventParams: TStringList);

    procedure CaricaTurno(cmbIN:TmeIWComboBox);
    var
      y:Integer;
      FiltroT021:string;
    begin
      with A058DettDM do
      begin
        //Combox Turno1
        cmbIN.RequireSelection:=True;
        FiltroT021:='(CODICE = ''' + Trim(copy(cmbOrario.Text,1,5)) + ''')';
        if Vista[IndDipendente].Giorni[IndGiorno].Data > 0 then
        begin
          FiltroT021:=FiltroT021 + ' AND (' + FloatToStr(Vista[IndDipendente].Giorni[IndGiorno].Data) + ' >= DECORRENZA)';
          FiltroT021:=FiltroT021 + ' AND (' + FloatToStr(Vista[IndDipendente].Giorni[IndGiorno].Data) + ' <= DECORRENZA_FINE)';
        end;
        QT021.Filter:=FiltroT021;
        QT021.Filtered:=True;
        cmbIN.Items.Clear;
        cmbIN.Items.Add('');
        for y:=0 to QT021.RecordCount do
          cmbIN.Items.Add(y.ToString);
        cmbIN.Css:=cmbIN.Css + ' width5chrImp fontcourierImp';
        QT021.Filtered:=False;
      end;
    end;

begin
  inherited;
  CaricaTurno(cmbTurno1);
  CaricaTurno(cmbTurno2);
end;

procedure TWA058FDettaglioTurnoFM.VisualizzaScheda;
begin
  (Self.Parent as TWR010FBase).VisualizzajQMessaggio(JQuery, Self.Width + 40, -1,EM2PIXEL * 50, CaptionTitolo, '#WA058_DettaglioTurno', False, True);
end;

end.
