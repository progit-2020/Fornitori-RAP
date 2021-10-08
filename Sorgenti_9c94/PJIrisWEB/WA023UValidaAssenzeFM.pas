unit WA023UValidaAssenzeFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Oracle, OracleData,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, meIWEdit, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton, IWAdvCheckGroup,meTIWAdvCheckGroup,
  A000UInterfaccia, A000UMessaggi, A023UTimbratureMW;

type
  TWA023FValidaAssenzeFM = class(TWR200FBaseFM)
    lblNominativo: TmeIWLabel;
    lblDataDa: TmeIWLabel;
    edtDataDa: TmeIWEdit;
    lblDataA: TmeIWLabel;
    edtDataA: TmeIWEdit;
    ChkLst: TmeTIWAdvCheckGroup;
    btnConferma: TmeIWButton;
    btnChiudi: TmeIWButton;
    procedure btnChiudiClick(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
  private
    DataDa,DataA:TDateTime;
    Caus:String;
    Prog:Integer;
  public
    A023MW: TA023FTimbratureMW;
    ElaborazioneEseguita:Boolean;
    procedure Visualizza(iProg:Integer;dDaData,dAData:TDateTime;sCaus:String);
  end;

implementation

uses WR010UBase;

{$R *.dfm}

procedure TWA023FValidaAssenzeFM.Visualizza(iProg:Integer;dDaData,dAData:TDateTime;sCaus:String);
begin
  DataDa:=dDaData;
  DataA:=dAData;
  Caus:=sCaus;
  Prog:=iProg;
  ElaborazioneEseguita:=False;

  with A023MW do
  begin
    OpenSelT030(Prog);
    lblNominativo.Caption:=selT030.FieldByName('NOMINATIVO').AsString;
  end;

  EdtDataDa.Text:=DateToStr(DataDa);
  EdtDataA.Text:=DateToStr(DataA);
  ChkLst.Items.CommaText:=Caus;
  if ChkLst.Items.Count = 1 then
    ChkLst.isChecked[0]:=True;

  (Self.Parent as TWR010FBase).VisualizzaJQMessaggio(jQuery,280,320,320, 'Validazione assenze','#wa023valassenze_container',False,True);
end;

procedure TWA023FValidaAssenzeFM.btnConfermaClick(Sender: TObject);
var i:integer;
begin
  try
    if StrToDate(EdtDataDa.Text) > StrToDate(EdtDataA.Text) then
      Abort;
  except
    Raise Exception.Create(A000MSG_ERR_DATE_INSERITE);
  end;
  for i:=0 to ChkLst.Items.Count - 1 do
    if ChkLst.isChecked[i] then
    begin
      A023MW.ValidaAssenza(StrToDate(EdtDataDa.Text),StrToDate(EdtDataA.Text),Prog,ChkLst.Items[i]);
      ElaborazioneEseguita:=True;
    end;
  if Assigned(btnChiudi.OnClick) then
    btnChiudi.OnClick(nil);
end;

procedure TWA023FValidaAssenzeFM.btnChiudiClick(Sender: TObject);
begin
  (*L'evento deve essere assegnato dal chiamante in modo da evitare il riferimento diretto a unit non generiche
    Vedi:
      TWA023FTimbrature.mnuValidaAssenzeClick
      TW005FCartellino.btnValidaAssenzeClick
   *)
end;

end.
