unit A058UTabellone;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, ExtCtrls, C180FunzioniGenerali, Printers, Variants, Math,
  StdCtrls, ComCtrls, QRExport, A000UInterfaccia, C700USelezioneAnagrafe,
  QRWebFilt, QRPDFFilt, USelI010;

type
  TA058FTabellone = class(TForm)
    QRep: TQuickRep;
    PageHeaderBand1: TQRBand;
    Intestazione: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRTitolo: TQRLabel;
    QRData: TQRLabel;
    Gruppo: TQRGroup;
    Dettaglio: TQRBand;
    PiedeLiquid: TQRBand;
    Piede3: TQRChildBand;
    QRBadge: TQRDBText;
    QRNome: TQRDBText;
    QROp: TQRDBText;
    Piede2: TQRChildBand;
    Piede4: TQRChildBand;
    QRNota: TQRLabel;
    QRDesc1: TQRLabel;
    QRDesc2: TQRLabel;
    QRMAssenze: TQRMemo;
    QRLAssenze: TQRLabel;
    QRLOrari: TQRLabel;
    QRMOrari: TQRMemo;
    Piede5: TQRChildBand;
    QRLTurno2: TQRLabel;
    QRLTurno3: TQRLabel;
    QRLTurno1: TQRLabel;
    QRLTurno4: TQRLabel;
    QRLTotaliTurno: TQRLabel;
    QRLMin: TQRLabel;
    QRLMax: TQRLabel;
    QRDBMin1: TQRDBText;
    QRDBMax1: TQRDBText;
    QRDBMin2: TQRDBText;
    QRDBMax2: TQRDBText;
    QRDBMax3: TQRDBText;
    QRDBMin3: TQRDBText;
    QRDBMax4: TQRDBText;
    QRDBMin4: TQRDBText;
    QrLblDebito: TQRLabel;
    QRLblAssegnato: TQRLabel;
    QRLblScostamento: TQRLabel;
    QRLblSituazione: TQRLabel;
    QrLblTotTurno1: TQRLabel;
    QrLblTotTurno2: TQRLabel;
    QrLblTotTurno3: TQRLabel;
    QrLblTotTurno4: TQRLabel;
    QRLblTemp: TQRLabel;
    IntestazioneCalendario: TQRChildBand;
    QRLBadge: TQRLabel;
    QRLNome: TQRLabel;
    QRLOp: TQRLabel;
    LblAssegnato: TQRLabel;
    LblDebito: TQRLabel;
    LblScostamento: TQRLabel;
    QrTotale: TQRLabel;
    QrTurno: TQRLabel;
    QRSquadra: TQRDBText;
    QRDSquadra: TQRDBText;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    PiedeTotOrario: TQRChildBand;
    QRLTotali: TQRLabel;
    QRMTotali: TQRMemo;
    qlblLiquid: TQRLabel;
    TotTotaliGG: TQRChildBand;
    qrLblTotGen: TQRLabel;
    QrLblDatoLibero: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure GruppoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DettaglioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Piede1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Piede2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Piede3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Piede5BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PageHeaderBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure QrLblTotTurno4Print(sender: TObject; var Value: string);
    procedure IntestazioneCalendarioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRLTurno4Print(sender: TObject; var Value: string);
    procedure PiedeLiquidBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure TotTotaliGGBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure MyInfoTimbOnPrint(sender: TObject;var Value: string);
  private
    { Private declarations }
    HCPiede5:Integer;
    procedure PutOrario(Ora:String);
    procedure PutAssenza(Ass:String);
    procedure CreaBande;
    procedure CreaDataIntestazione;
    procedure ScriviPiede(NDip:Integer);
  public
    { Public declarations }
    LAssenze,LOrari,LTotTurni:TStringList;
    TotaliTurni:Array[0..99,0..359] of Word;
    //PreviewAttiva:Boolean;
    procedure InizializzaStampa;
    procedure DistruggiOggetti99(inComp:TComponent);
  end;

var
  A058FTabellone: TA058FTabellone;

implementation

uses A058UPianifTurniDtM1, A058UPianifTurni;

{$R *.DFM}

procedure TA058FTabellone.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Self.Destroy;
end;

procedure TA058FTabellone.FormCreate(Sender: TObject);
begin
  QRep.useQR5Justification:=True;
  LAssenze:=TStringList.Create;
  LOrari:=TStringList.Create;
  LTotTurni:=TStringList.Create;
end;


procedure TA058FTabellone.InizializzaStampa;
{Proporziono il carattere e le dimensioni dei componenti in base alla larghezza
 della pagina e al numero di giorni da stampare}
var
  S,LC,HC,PosTurni:Integer;

  function ExistsNomeComp(Nome:String):Boolean;
  var
    i:integer;
  begin
    Result:=True;
    if Piede5.ComponentCount <= 0 then
    begin
      Result:=False;
      Exit;
    end;
    i:=0;
    while (i < Piede5.ComponentCount - 1) and
          (Piede5.Components[i].Name <> Nome) do
      inc(i);
    if (i >= Piede5.ComponentCount - 1) and
       (Piede5.Components[i].Name <> Nome) then
      Result:=False;
  end;

  procedure CreaMaxMinOper(InTotOpe:TArrTotOpe;NumTurno:string);
  var
    i:Integer;
  begin
    with A058FPianifTurniDtM1 do
    begin
      for i:=Low(InTotOpe) to High(InTotOpe) do
      begin
        with TQRLabel.Create(Piede5) do
        begin
          Parent:=Piede5;
          Name:='lbl' + InTotOpe[i].Operatore + NumTurno;
          HCPiede5:=HCPiede5 + HC;
          Top:=HCPiede5;
          Left:=QRLTurno1.Left;
          Caption:=InTotOpe[i].Operatore + ':';
          if InTotOpe[i].Min = '-' then
            Font.Color:=clRed
          else
            Font.Color:=clBlue;
          Tag:=99;
        end;
        with TQRLabel.Create(Piede5) do
        begin
          Top:=HCPiede5;
          Parent:=Piede5;
          Width:=QRDBMin1.Width;
          Alignment:=taRightJustify;
          Left:=QrLMin.Left;
          Caption:=InTotOpe[i].Min;
          if InTotOpe[i].Min = '-' then
            Font.Color:=clRed
          else
            Font.Color:=clBlue;
          Tag:=99;
        end;
        with TQRLabel.Create(Piede5) do
        begin
          Top:=HCPiede5;
          Parent:=Piede5;
          Width:=QRDBMax1.Width;
          Alignment:=taRightJustify;
          Left:=QrLMax.Left;
          Caption:=InTotOpe[i].Max;
          if InTotOpe[i].Max = '-' then
            Font.Color:=clRed
          else
            Font.Color:=clBlue;
          Tag:=99;
        end;
      end;
    end;
    HCPiede5:=HCPiede5 + HC;
  end;

begin
  S:=A058FPianifTurniDtM1.selT082.FieldByName('DIMENSIONE_FONT').AsInteger;
  //Limito la dimensione entro valori accettabili
  if S > 13 then
    S:=13;
  if S < 6 then
    S:=6;
  //Altezza di una riga
  HC:=S * 2 - 1;
  //Intestazione.Font.Size:=S;
  IntestazioneCalendario.Font.Size:=S;
  Dettaglio.Font.Size:=S;
  PiedeTotOrario.Font.Size:=S;
  PiedeLiquid.Font.Size:=S;
  Piede2.Font.Size:=S;
  Piede3.Font.Size:=S;
  Piede4.Font.Size:=S;
  Piede5.Font.Size:=S;
  TotTotaliGG.FontSize:=S;
  TotTotaliGG.Font.Size:=S;
  Intestazione.Font.Size:=S + 2;
  //Alberto 29/12/2006
  LC:=QRep.TextWidth(Dettaglio.Font,' ');
  if HC > 17 then HC:=17;
  //Dettaglio
  QRBadge.Height:=HC;
  QRBadge.Width:=LC * 8;  //Lung. Badge
  QRNome.Height:=HC * 2;
  with A058FPianifTurniDtm1 do
  begin
    //{*}QRNome.Left:=QRBadge.Width + LC;
    if (selT082.FieldByName('RIGHE_DIP').AsString = '2') or (selT082.FieldByName('RIGHE_NOME').AsString = 'N') then
      QRNome.Width:=LC * 20 //Lung. Nome
    else
      QRNome.Width:=LC * 10; //Lung. Nome
    //Posizionamento campo
    if (selT082.FieldByName('RIGHE_DIP').AsString = '2') or (selT082.FieldByName('RIGHE_NOME').AsString = 'N') then
      PosTurni:=QRBadge.Left + QRBadge.Width
    else
      PosTurni:=QRNome.Left + QRNome.Width;
    QRep.Top:=QRBadge.Top;
    QROp.Left:=PosTurni + (LC * 2);
    QROp.Width:=LC * 5 + 1;//Lung. 'Op.'
    if (selT082.FieldByName('RIGHE_DIP').AsString = '2') or (selT082.FieldByName('RIGHE_NOME').AsString = 'N') then
      PosTurni:=QRNome.Left + QRNome.Width + 50
    else
      PosTurni:=QROp.Left + QROp.Width;
    LblDebito.enabled:=(selT082.FieldByName('SALDI_ORE').AsString = 'S') and (selT082.FieldByName('RIGHE_DIP').AsString <> '2');
    LblAssegnato.enabled:=(selT082.FieldByName('SALDI_ORE').AsString = 'S') and (selT082.FieldByName('RIGHE_DIP').AsString <> '2');
    LblScostamento.enabled:=(selT082.FieldByName('SALDI_ORE').AsString = 'S') and (selT082.FieldByName('RIGHE_DIP').AsString <> '2');
    QRTotale.Enabled:=selT082.FieldByName('TOT_TURNI_MESE').AsString = 'S';
    if (selT082.FieldByName('RIGHE_DIP').AsString = '2') then
    begin
      if selT082.FieldByName('TOT_TURNI_MESE').AsString = 'S' then
        QrTotale.Caption:='Totale turni'
      else
        QrTotale.Caption:='Totale';
      if selT082.FieldByName('SALDI_ORE').AsString = 'S' then
        QRTurno.Caption:='Deb.Contr. \ Ass.'
      else
        QrTurno.Caption:='turni';
    end
    else
    begin
      QrTotale.Caption:='Totale';
      QrTurno.Caption:='turni';
    end;
    QRTurno.Enabled:=(selT082.FieldByName('TOT_TURNI_MESE').AsString = 'S') or ((selT082.FieldByName('RIGHE_DIP').AsString = '2') and (selT082.FieldByName('SALDI_ORE').AsString = 'S'));
    QrLblTotTurno1.Enabled:=selT082.FieldByName('TOT_TURNI_MESE').AsString = 'S';
    QrLblTotTurno2.Enabled:=((selT082.FieldByName('TOT_TURNI_MESE').AsString = 'S') and (selT082.FieldByName('RIGHE_DIP').AsString <> '2')) or ((A058FPianifTurniDtM1.selT082.FieldByName('RIGHE_DIP').AsString = '2') and (selT082.FieldByName('SALDI_ORE').AsString = 'S'));
    QrLblTotTurno3.Enabled:=(selT082.FieldByName('TOT_TURNI_MESE').AsString = 'S') and (selT082.FieldByName('RIGHE_DIP').AsString <> '2');
    QrLblTotTurno4.Enabled:=(selT082.FieldByName('TOT_TURNI_MESE').AsString = 'S') and (selT082.FieldByName('RIGHE_DIP').AsString <> '2');
    QRep.Page.LeftMargin:=selT082.FieldByName('MARGINE_SX').AsInteger;
    //nLeft:=QRNome.Left + QRNome.Width;
    QRLblDebito.enabled:=(selT082.FieldByName('SALDI_ORE').AsString = 'S') and (selT082.FieldByName('RIGHE_DIP').AsString <> '2');
    QRLblAssegnato.enabled:=(selT082.FieldByName('SALDI_ORE').AsString = 'S') and (selT082.FieldByName('RIGHE_DIP').AsString <> '2');
    QRLblScostamento.enabled:=(selT082.FieldByName('SALDI_ORE').AsString = 'S') and (selT082.FieldByName('RIGHE_DIP').AsString <> '2');
    if (selT082.FieldByName('SALDI_ORE').AsString = 'S') and (selT082.FieldByName('RIGHE_DIP').AsString <> '2') then
    begin
      //Imposto le etichette per visualizzare i saldi
      LblDebito.Height:=HC;
      LblDebito.Left:=PosTurni + (LC * 2);
      LblAssegnato.Height:=HC;
      LblAssegnato.Left:=PosTurni + (LC * 2);
      LblAssegnato.Top:=LblDebito.Top + HC - 1;
      LblScostamento.Height:=HC;
      LblScostamento.Left:=PosTurni + (LC * 2);
      LblScostamento.Top:=LblAssegnato.Top + HC - 1;
      //Imposto i campi per visualizzare i saldi
      QRLblDebito.Height:=HC;
      QRLblDebito.Left:=LblDebito.Left + trunc((LblDebito.Width - QRLblDebito.Width) / 2) + 1;
      QRLblDebito.Width:=LC * 6 + 1;
      QRLblAssegnato.Height:=HC;
      QRLblAssegnato.Left:=QRLblDebito.Left;
      QRLblAssegnato.Top:=LblAssegnato.Top;
      QRLblAssegnato.Width:=LC * 6 + 1;
      QRLblScostamento.Height:=HC;
      QRLblScostamento.Left:=QRLblDebito.Left;
      QRLblScostamento.Top:=LblScostamento.Top;
      QRLblScostamento.Width:=LC * 6 + 1;
      //Fine impostazione campi
    end
    else
    begin
      LblDebito.Left:=PosTurni;
      LblDebito.Width:=0;
      LblAssegnato.Width:=0;
      LblScostamento.Width:=0;
      QRLblDebito.Width:=0;
      QRLblAssegnato.Width:=0;
      QRLblScostamento.Width:=0;
    end;

    if (selT082.FieldByName('TOT_TURNI_MESE').AsString = 'S') or ((selT082.FieldByName('RIGHE_DIP').AsString = '2') and (selT082.FieldByName('SALDI_ORE').AsString = 'S')) then
    begin
      QRTurno.Top:=QRTotale.Top + HC - 1;
      QRLblTotTurno1.Height:=HC;
      QRLblTotTurno1.Left:=LblDebito.Left + LblDebito.Width + (LC * 2);
      QRLblTotTurno1.Width:=LC * IfThen((selT082.FieldByName('RIGHE_DIP').AsString = '2'),13,7) + 1;
      QRLblTotTurno2.Height:=HC;
      QRLblTotTurno2.Left:=QRLblTotTurno1.Left;
      QRLblTotTurno2.Width:=LC * IfThen((selT082.FieldByName('RIGHE_DIP').AsString = '2'),13,7) + 1;
      QRLblTotTurno2.Top:=QRLblTotTurno1.Top + HC - 1;
      QRLblTotTurno3.Height:=HC;
      QRLblTotTurno3.Left:=QRLblTotTurno2.Left;
      QRLblTotTurno3.Width:=LC * IfThen((selT082.FieldByName('RIGHE_DIP').AsString = '2'),13,7) + 1;
      QRLblTotTurno3.Top:=QRLblTotTurno2.Top + HC - 1;
      QRLblTotTurno4.Height:=HC;
      QRLblTotTurno4.Left:=QRLblTotTurno3.Left;
      QRLblTotTurno4.Width:=LC * IfThen((selT082.FieldByName('RIGHE_DIP').AsString = '2'),13,7) + 1;
      QRLblTotTurno4.Top:=QRLblTotTurno3.Top + HC - 1;
    end
    else
    begin
      QRLblTotTurno1.Left:=LblDebito.Left + LblDebito.Width;
      QRLblTotTurno1.Width:=0;
      QRLblTotTurno2.Width:=0;
      QRLblTotTurno3.Width:=0;
      QRLblTotTurno4.Width:=0;
    end;
  end;
  (*QROrari.Height:=HC;
  QROrari.Left:=QRLblTotTurno1.Left + QRLblTotTurno1.Width + (LC * 2);
  QRTurni.Height:=HC*2;
  QRTurni.Left:=QROrari.Left;
  QRTurni.Top:=QROrari.Top + HC - 1;*)
  //Dettaglio.Height:=(QROrari.Height * 4)+1; //QRTurni.Top + HC + 1;
  with A058FPianifTurniDtm1 do
  begin
    Dettaglio.Height:=(HC * IfThen((selT082.FieldByName('RIGHE_DIP').AsString = '2'),2,4)) + 1; //QRTurni.Top + HC + 1;
    if selT082.FieldByName('RIGHE_DIP').AsString = '3' then
      Dettaglio.Height:=Dettaglio.Height - QrLblTotTurno4.Height;
  end;
  //Intestazione
  QRLBadge.Left:=QRBadge.Left;
  QRLBadge.Height:=HC;
  QRLNome.Height:=HC;
  QRLNome.Left:=QRNome.Left;
  QRLNome.Top:=QRLBadge.Top + QRLBadge.Height;
  //QRLBadge.Left:=QRNome.Left - (LC * 6);
  QRLOp.Height:=HC;
  QRLOp.Left:=QROp.Left;
  QRTotale.Height:=HC;
  QRTotale.Left:=QRLblTotTurno1.Left;
  QRTurno.Height:=HC;
  QRTurno.Left:=QRLblTotTurno1.Left;
  if A058FPianifTurniDtm1.selT082.FieldByName('SALDI_ORE').AsString = 'N' then
    IntestazioneCalendario.Height:=(HC * 2) + 3
  else
    IntestazioneCalendario.Height:=(HC * 3) + 3;
  //Gruppo SQUADRA
  QRSquadra.Height:=(S + 2) * 2 - 1;
  QRSquadra.Width:=LC * 15;  //Lung. Cod.Squadra
  QRDSquadra.Height:=(S + 2) * 2 - 1;
  QRDSquadra.Left:=QRSquadra.Left + QRSquadra.Width + 3;
  Gruppo.Height:=0;
  Intestazione.Height:=QRSquadra.Top + QRSquadra.Height + 2;
  //Piede1
  QRLTotali.Height:=HC;
  QRLTotali.Width:=LC * 6;   //'Totali'
  QRMTotali.Height:=HC;
  //QRMTotali.Left:=QRTurni.Left - (LC * 9);
  QRMTotali.Left:=QRLblTotTurno1.Left + QRLblTotTurno1.Width + (LC * 2) - (LC * 9);
  PiedeTotOrario.Height:=QRLTotali.Top + HC + 2;
  //Piede2
  QRLOrari.Height:=HC;
  QRLOrari.Width:=LC * 9;   //Lung. 'Assenze: '
  QRMOrari.Height:=HC;
  QRMOrari.Left:=QRLOrari.Width + 1;
  Piede2.Height:=QRLOrari.Top + HC + 2;
  //Piede3
  QRLAssenze.Height:=HC;
  QRLAssenze.Width:=LC * 9;   //Lung. 'Assenze: '
  QRMAssenze.Height:=HC;
  QRMAssenze.Left:=QRLOrari.Width + 1;
  Piede3.Height:=QRLAssenze.Top + HC + 2;
  //Piede5
  HCPiede5:=HC;
  QRLTotaliTurno.Height:=HCPiede5;
  QRLMin.Height:=HCPiede5;
  QRLMin.Left:=QRLTotaliTurno.Left + QRLTotaliTurno.Width + LC;
  QRLMax.Height:=HCPiede5;
  QRLMax.Left:=QRLMin.Left + QRLMin.Width + LC;
  QRLTurno1.Height:=HCPiede5;
  QRLTurno1.Top:=QRLTotaliTurno.Top + HCPiede5;
  with A058FPianifTurniDtm1 do
  begin
    if selT082.FieldByName('TOT_OPE_TURNO').AsString = 'S' then
    begin
      CreaMaxMinOper(A058FPianifTurniDtM1.aTotaleTurni[0].TotOpe1,'1');
      QRLTurno2.Top:=HCPiede5;
    end
    else
      QRLTurno2.Top:=QRLTurno1.Top + HCPiede5;

    QRLTurno2.Height:=HCPiede5;
    if selT082.FieldByName('TOT_OPE_TURNO').AsString = 'S' then
    begin
      CreaMaxMinOper(A058FPianifTurniDtM1.aTotaleTurni[0].TotOpe2,'2');
      QRLTurno3.Top:=HCPiede5;
    end
    else
      QRLTurno3.Top:=QRLTurno2.Top + HCPiede5;

    QRLTurno3.Height:=HCPiede5;
    if selT082.FieldByName('TOT_OPE_TURNO').AsString = 'S' then
    begin
      CreaMaxMinOper(A058FPianifTurniDtM1.aTotaleTurni[0].TotOpe3,'3');
      QRLTurno4.Top:=HCPiede5;
    end
    else
      QRLTurno4.Top:=QRLTurno3.Top + HCPiede5;

    if A058FPianifTurniDtM1.selT082.FieldByName('RIGHE_DIP').AsString = '4' then
    begin
      QRLTurno4.Height:=HCPiede5;
      if selT082.FieldByName('TOT_OPE_TURNO').AsString = 'S' then
        CreaMaxMinOper(A058FPianifTurniDtM1.aTotaleTurni[0].TotOpe4,'4');
    end;
  end;

  QrDbMin1.Height:=HC;
  QrDbMin1.Left:=QrLMin.Left;
  QrDbMin1.Top:=QRLTurno1.Top;
  QrDbMin2.Height:=HC;
  QrDbMin2.Left:=QrLMin.Left;
  QrDbMin2.Top:=QRLTurno2.Top;
  QrDbMin3.Height:=HC;
  QrDbMin3.Left:=QrLMin.Left;
  QrDbMin3.Top:=QRLTurno3.Top;
  QrDbMin4.Enabled:=A058FPianifTurniDtM1.selT082.FieldByName('RIGHE_DIP').AsString = '4';
  if A058FPianifTurniDtM1.selT082.FieldByName('RIGHE_DIP').AsString = '4' then
  begin
    QrDbMin4.Height:=HC;
    QrDbMin4.Left:=QrLMin.Left;
    QrDbMin4.Top:=QRLTurno4.Top;
  end;
  QrDbMax1.Height:=HC;
  QrDbMax1.Left:=QrLMax.Left;
  QrDbMax1.Top:=QRLTurno1.Top;
  QrDbMax2.Height:=HC;
  QrDbMax2.Left:=QrLMax.Left;
  QrDbMax2.Top:=QRLTurno2.Top;
  QrDbMax3.Height:=HC;
  QrDbMax3.Left:=QrLMax.Left;
  QrDbMax3.Top:=QRLTurno3.Top;
  QrDbMax4.Enabled:=A058FPianifTurniDtM1.selT082.FieldByName('RIGHE_DIP').AsString = '4';
  if A058FPianifTurniDtM1.selT082.FieldByName('RIGHE_DIP').AsString = '4' then
  begin
    QrDbMax4.Height:=HC;
    QrDbMax4.Left:=QrLMax.Left;
    QrDbMax4.Top:=QRLTurno4.Top;
  end;
  Piede5.Height:=QRLTurno4.Top + QRLTurno4.Height + 1;
end;

procedure TA058FTabellone.GruppoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
  xx, yy:Integer;
  MyStrList:TStringList;
begin
  LAssenze.Clear;
  LOrari.Clear;
  QRMAssenze.Lines.Clear;
  QRMOrari.Lines.Clear;
  MyStrList:=TStringList.Create;
  try
    MyStrList.Assign(A058FTabellone.QRMOrari.Lines);
    MyStrList.Sorted:=False;
    A058FTabellone.QRMOrari.Lines.Assign(MyStrList);
  finally
    FreeAndNil(MyStrList);
  end;
  QRMTotali.Lines.Clear;
  LTotTurni.Clear;
  for xx:=Low(TotaliTurni) to High(TotaliTurni) do
    for yy:=0 to 359 do
      TotaliTurni[xx,yy]:=0;
end;

procedure TA058FTabellone.PutOrario(Ora:String);
{Scrivo la descrizione degli orari nel riepilogo}
var
  S,ST:String;
  i:Integer;
begin
  with A058FPianifTurniDtM1 do
    if (A058FTabellone.LOrari.IndexOf(Ora) = -1) and (Q020.Locate('Codice',Ora,[])) then
    begin
      A058FTabellone.LOrari.Add(Ora);
      S:=R180DimLung(Q020.FieldByName('Codice').AsString,6) + R180DimLung(Q020.FieldByName('Descrizione').AsString,41);
      A058FTabellone.QRMOrari.Lines.Add(S);
      i:=A058FTabellone.QRMOrari.Lines.Count - 1;
      Q020Turni.Close;
      Q020Turni.SetVariable('COD',Q020.FieldByName('Codice').AsString);
      Q020Turni.SetVariable('DATA',Q020.FieldByName('DECORRENZA').AsDateTime);
      Q020Turni.Open;
      while not Q020Turni.Eof do
      begin
        if Q020Turni.FieldByName('SIGLATURNI').AsString = '' then
          ST:='[' + Q020Turni.FieldByName('NumTurno').AsString + ']'
        else
          ST:='(' + Q020Turni.FieldByName('SIGLATURNI').AsString + ')';
        S:='  ' + ST + ' = ' + Q020Turni.FieldByName('Entrata').AsString + ' - ' + Q020Turni.FieldByName('Uscita').AsString;
        A058FTabellone.QRLblTemp.Caption:=A058FTabellone.QRMOrari.Lines[i] + S;
        if A058FTabellone.QRMOrari.Left + A058FTabellone.QRLblTemp.Width >= (A058FTabellone.Piede2.Width - 50) then
        begin
          //Creo una nuova riga...
          A058FTabellone.QRMOrari.Lines.Add(R180DimLung(Q020.FieldByName('Codice').AsString,6) + R180DimLung(Q020.FieldByName('Descrizione').AsString,41));
          i:=A058FTabellone.QRMOrari.Lines.Count - 1;
        end;
        A058FTabellone.QRMOrari.Lines[i]:=A058FTabellone.QRMOrari.Lines[i] + S;
        A058FTabellone.QRLblTemp.Caption:='';
        Q020Turni.Next;
      end;
    end;
end;

procedure TA058FTabellone.PutAssenza(Ass:String);
{Scrivo la descrizione delle assenze nel riepilogo}
var
  P:Integer;
  S:String;
begin
  with A058FPianifTurniDtM1.Q265 do
    if (A058FTabellone.LAssenze.IndexOf(Ass) = -1) and (Locate('Codice',Ass,[])) then
    begin
      A058FTabellone.LAssenze.Add(Ass);
      S:=R180DimLung(FieldByName('Codice').AsString,6) + R180DimLung(FieldByName('Descrizione').AsString,41);
      P:=A058FTabellone.QRMAssenze.Lines.Count;
      if P = 0 then
        A058FTabellone.QRMAssenze.Lines.Add(S)
      else
        if Length(A058FTabellone.QRMAssenze.Lines[P - 1]) > 50 then
          A058FTabellone.QRMAssenze.Lines.Add(S)
        else
          A058FTabellone.QRMAssenze.Lines[P - 1]:=A058FTabellone.QRMAssenze.Lines[P - 1] + S;
    end;
end;

procedure TA058FTabellone.ScriviPiede(NDip:Integer);
{Scrivo la descrizione degli orari e delle assenze sul piè di pagina}
var
  i:Integer;
  S:TStringList;
begin
  S:=TStringList.Create;
  with A058FPianifTurniDtM1.T058Stampa do
  begin
    if A058FPianifTurniDtM1.selT082.FieldByName('SALDI_ORE').AsString = 'S' then
    begin
      QrLblDebito.Caption:=Format('%7s',[R180MinutiOre(FieldByName('Debito').AsInteger)]);
      QRLblAssegnato.Caption:=Format('%7s',[R180MinutiOre(FieldByName('Assegnato').AsInteger)]);
      QRLblScostamento.Caption:=Format('%7s',[R180MinutiOre(FieldByName('Assegnato').AsInteger - FieldByName('Debito').AsInteger)]);
      if A058FPianifTurniDtM1.selT082.FieldByName('RIGHE_DIP').AsString = '2' then
        A058FTabellone.QrLblTotTurno2.Caption:=R180MinutiOre(FieldByName('Debito').AsInteger) + '\' + R180MinutiOre(FieldByName('Assegnato').AsInteger);
    end;
    if (A058FPianifTurniDtM1.selT082.FieldByName('TOT_TURNI_MESE').AsString = 'S') and
       (A058FPianifTurniDtM1.selT082.FieldByName('RIGHE_DIP').AsString = '2') then
    begin
      A058FTabellone.QrLblTotTurno1.Caption:=FieldByName('TotaleTurno1').AsString;
      A058FTabellone.QrLblTotTurno1.Caption:=A058FTabellone.QrLblTotTurno1.Caption + '  ' + FieldByName('TotaleTurno2').AsString;
      A058FTabellone.QrLblTotTurno1.Caption:=A058FTabellone.QrLblTotTurno1.Caption + '  ' + FieldByName('TotaleTurno3').AsString;
      A058FTabellone.QrLblTotTurno1.Caption:=A058FTabellone.QrLblTotTurno1.Caption + '  ' + FieldByName('TotaleTurno4').AsString;
    end
    else if A058FPianifTurniDtM1.selT082.FieldByName('TOT_TURNI_MESE').AsString = 'S' then
    begin
      A058FTabellone.QrLblTotTurno1.Caption:='1°T ' + Format('%3s',[FieldByName('TotaleTurno1').AsString]);
      A058FTabellone.QrLblTotTurno2.Caption:='2°T ' + Format('%3s',[FieldByName('TotaleTurno2').AsString]);
      A058FTabellone.QrLblTotTurno3.Caption:='3°T ' + Format('%3s',[FieldByName('TotaleTurno3').AsString]);
      A058FTabellone.QrLblTotTurno4.Caption:='4°T ' + Format('%3s',[FieldByName('TotaleTurno4').AsString]);
    end;
    with A058FPianifTurniDtM1 do
      for i:=0 to T058Stampa.FieldCount - 1 do
      begin
        if Pos('CodOrari',T058Stampa.Fields[i].FieldName) > 0  then
          PutOrario(T058Stampa.Fields[i].AsString);

        if Pos('CodAssenze',T058Stampa.Fields[i].FieldName) > 0  then
          PutAssenza(T058Stampa.Fields[i].AsString);
      end;
  end;
  FreeAndNil(S);
end;

procedure TA058FTabellone.DettaglioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  ScriviPiede(QRep.DataSet.FieldByName('Progressivo').AsInteger);
end;

procedure TA058FTabellone.Piede1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:=False;
end;

procedure TA058FTabellone.Piede2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
  L:TStringList;
begin
  if (A058FPianifTurniDtM1.selT082.FieldByName('DETT_ORARI').asString = 'N') then
  begin
    PrintBand:=False;
    exit;
  end;
  //Ordino il memo orari
  L:=TStringList.Create;
  try
    L.Assign(QRMOrari.Lines);
    L.Sorted:=True;
    QRMOrari.Lines.Assign(L);
  finally
    L.Free;
  end;
end;

procedure TA058FTabellone.Piede3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if A058FPianifTurniDtM1.selT082.FieldByName('ASSENZE').asString = 'N' then
  begin
    PrintBand:=False;
    exit;
  end;
end;

procedure TA058FTabellone.QRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  if A058FPianifTurniDtM1.selT082.FieldByName('TOT_OPE_TURNO').AsString = 'S' then
    DistruggiOggetti99(Piede5);
  if A058FPianifTurniDtM1.selT082.FieldByName('TOT_OPE_TURNO').AsString = 'S' then
    DistruggiOggetti99(TotTotaliGG);
  if A058FPianifTurniDtM1.selT082.FieldByName('TOT_OPE_TURNO').AsString = 'S' then
    DistruggiOggetti99(PiedeLiquid);
  DistruggiOggetti99(Piede5);
  InizializzaStampa; //Lorena
  CreaBande;
  //PreviewAttiva:=False;
end;

procedure TA058FTabellone.QrLblTotTurno4Print(sender: TObject;
  var Value: string);
begin
  if A058FPianifTurniDtM1.selT082.FieldByName('RIGHE_DIP').AsString <> '4' then
    Value:='';
end;

procedure TA058FTabellone.QRLTurno4Print(sender: TObject; var Value: string);
begin
  if A058FPianifTurniDtM1.selT082.FieldByName('RIGHE_DIP').AsString <> '4' then
    Value:='';
end;

procedure TA058FTabellone.TotTotaliGGBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if A058FPianifTurniDtM1.selT082.FieldByName('TOT_GENERALI').AsString = 'N' then
    PrintBand:=False;
end;

procedure TA058FTabellone.MyInfoTimbOnPrint(sender: TObject;var Value: string);
begin
  with TQRDBText(Sender) do
    if DataSet.FieldByName(DataField).AsInteger = 0 then
      Value:='';
end;

procedure TA058FTabellone.CreaBande;
{Genero l'intestazione}
var
  xQRShape1,xQRShape2,xQRShape3:TQRShape; //Lorena
  TxtTurno,TxtOrario,TxtTotTurno1,
  TxtTotTurno2,TxtTotTurno3,TxtTotTurno4,
  TxtTotOperatori,InfoTimb:TQRDBText;
  LblGiorni1,LblGiorni2:TQRLabel;
  nDep,i,TotLiquid, RiepMINTotale, RiepMAXTotale,
  RiepMINFSTotale, RiepMAXFSTotale:integer;
  Mn1,Mn2,Mn3,Mn4,Mx1,Mx2,Mx3,Mx4,nTop:Integer;
  nLeft,L:Real;

  procedure PrintTotaliCopertura;
  {************************************************************
  Stampa della somma dei totali dei 4 turni
  ************************************************************}
  var
    Totale:Integer;
  begin
    if A058FPianifTurniDtM1.selT082.FieldByName('TOT_GENERALI').AsString = 'S' then
    begin
      TotTotaliGG.Frame.DrawTop:=True;
      with TQRShape(TotTotaliGG.AddPrintable(TQRShape)).Create(TotTotaliGG) do
      begin
        Tag:=99;
        Shape:=qrsVertLine;
        Top:=0;
        Left:=Trunc(nLeft);
        Width:=1;
        Height:=TotTotaliGG.Height;
      end;
      with TQRLabel(TotTotaliGG.AddPrintable(TQRLabel)).Create(TotTotaliGG) do
      begin
        Parent:=TotTotaliGG;
        ParentFont:=True;
        Font:=TotTotaliGG.Font;
        Tag:=99;
        Top:=0;
        AutoSize:=True;
        Left:=Trunc(nLeft + 2);
        Totale:=0;
        Totale:=Totale + A058FPianifTurniDtm1.T058Stampa.FieldByName('TotGenTurno1_' + IntToStr(i)).AsInteger;
        Totale:=Totale + A058FPianifTurniDtm1.T058Stampa.FieldByName('TotGenTurno2_' + IntToStr(i)).AsInteger;
        Totale:=Totale + A058FPianifTurniDtm1.T058Stampa.FieldByName('TotGenTurno3_' + IntToStr(i)).AsInteger;
        if A058FPianifTurniDtM1.selT082.FieldByName('RIGHE_DIP').AsString = '4' then
          Totale:=Totale + A058FPianifTurniDtm1.T058Stampa.FieldByName('TotGenTurno4_' + IntToStr(i)).AsInteger;
        Caption:=IntToStr(Totale);
      end;
    end;
  end;

  procedure PrintTotaliGGOperatori(inTotali:TArrTotOpe;Turno:String);
  {************************************************************
  Creo, valorizzo e stampo le label dedicate alla stampa dei
  totali giornalieri suddivisi tra turni operatore.
  ************************************************************}
  var
    j,k:integer;
  begin
    with A058FPianifTurniDtM1 do
      for j:=Low(inTotali) to High(inTotali) do
      begin
        TxtTotOperatori:=TQRDBText(Piede5.AddPrintable(TQRDBText));
        TxtTotOperatori.Left:=Trunc(nLeft + 2);
        //Cerco la lbl di riferimento per assegnare il top
        for k:=0 to Piede5.ComponentCount - 1 do
          if Piede5.Components[k].Name = 'lbl' + inTotali[j].Operatore + Turno then
          begin
            TxtTotOperatori.Top:=TQRLabel(Piede5.Components[k]).Top;
            if nTop < (TQRLabel(Piede5.Components[k]).Top + TQRLabel(Piede5.Components[k]).Height) then
              nTop:=(TQRLabel(Piede5.Components[k]).Top + TQRLabel(Piede5.Components[k]).Height);
            Break;
          end;
        TxtTotOperatori.DataSet:=T058Stampa;
        TxtTotOperatori.DataField:='TotGenTurno' + Turno + '_' + IntToStr(i) + '_' + inTotali[j].Operatore;
        TxtTotOperatori.Tag:=99;
        TxtTotOperatori.Name:=TxtTotOperatori.DataField;
        TxtTotOperatori.Font.Color:=clBlue;
      end;
  end;

begin
  //Aggiorno le misure LC
  nDep:=A058FTabellone.ComponentCount - 1;
  i:=0;
  nLeft:=0;
  while i <= nDep do
  begin
    if A058FTabellone.Components[i].Tag = 99 then
    begin
      A058FTabellone.Components[i].Free;
      nDep:=nDep - 1;
    end
    else
      i:=i + 1;
  end;

  with A058FPianifTurniDtm1 do
    L:=QRep.TextWidth(Dettaglio.Font,R180Spaces('',selT082.FieldByName('GG_PAGINA').AsInteger * LungCella)) div selT082.FieldByName('GG_PAGINA').AsInteger;
  RiepMINTotale:=0;
  RiepMAXTotale:=0;
  RiepMINFSTotale:=0;
  RiepMAXFSTotale:=0;

  for i:=0 to Min(A058FPianifTurniDtm1.selT082.FieldByName('GG_PAGINA').AsInteger - 1,Trunc(A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio)) do
  begin
    if nLeft = 0 then
      nLeft:=QRLblTotTurno1.Left + QRLblTotTurno1.Width + (QRep.TextWidth(Dettaglio.Font,' ') * 2) - 1
    else
      nLeft:=nLeft + L;
    if A058FPianifTurniDtm1.selT082.FieldByName('SEPARATORE_COL').AsString = 'S' then  //Lorena
    begin
      //Separatore colonne di dettaglio
      xQRShape1:=TQRShape(Dettaglio.AddPrintable(TQRShape));
      xQRShape1.Shape:=qrsVertLine;
      xQRShape1.Height:=Dettaglio.Height;
      xQRShape1.Width:=1;
      xQRShape1.Left:=Trunc(nLeft);
      xQRShape1.Tag:=99;
      //Separatore colonne di piede5
      xQRShape2:=TQRShape(Piede5.AddPrintable(TQRShape));
      xQRShape2.Shape:=qrsVertLine;
      if A058FPianifTurniDtM1.selT082.FieldByName('TOT_OPE_TURNO').AsString = 'S' then
        xQRShape2.Height:=HCPiede5
      else
        xQRShape2.Height:=QRLTurno4.Top + QRLTurno4.Height + 1;
      xQRShape2.Width:=1;
      xQRShape2.Left:=Trunc(nLeft);
      xQRShape2.Tag:=99;
      //Separatore colonne di intestazione
      xQRShape3:=TQRShape(IntestazioneCalendario.AddPrintable(TQRShape));
      xQRShape3.Shape:=qrsVertLine;
      xQRShape3.Height:=IntestazioneCalendario.Height;
      xQRShape3.Width:=1;
      xQRShape3.Left:=Trunc(nLeft);
      xQRShape3.Tag:=99;
    end;

    LblGiorni1:=TQRLabel(IntestazioneCalendario.AddPrintable(TQRLabel));
    LblGiorni1.Left:=Trunc(nLeft + 2);
    LblGiorni1.Top:=1;
    LblGiorni1.Tag:=99;
    LblGiorni1.Caption:=' ';
    LblGiorni1.Name:='lblDD' + IntToStr(i);

    LblGiorni2:=TQRLabel(IntestazioneCalendario.AddPrintable(TQRLabel));
    LblGiorni2.Left:=Trunc(nLeft + 2);
    LblGiorni2.Top:=LblGiorni1.Top + LblGiorni1.Height;
    LblGiorni2.Tag:=99;
    LblGiorni2.Name:='lblGG' + IntToStr(i);

    TxtOrario:=TQRDBText(Dettaglio.AddPrintable(TQRDBText));
    TxtOrario.Left:=Trunc(nLeft + 2);
    TxtOrario.Top:=0;
    TxtOrario.Tag:=99;
    TxtOrario.DataSet:=A058FPianifTurniDtM1.T058Stampa;
    TxtOrario.DataField:='Orari' + IntToStr(i);
    if A058FPianifTurniDtM1.selT082.FieldByName('DETT_STAMPA').AsString = 'D' then
       TxtOrario.AutoSize:=True
    else
    begin
       TxtOrario.AutoSize:=False;
      TxtOrario.Width:=0;
    end;
    TxtTurno:=TQRDBText(Dettaglio.AddPrintable(TQRDBText));
    TxtTurno.Left:=Trunc(nLeft + 2);
    TxtTurno.Height:=Dettaglio.Height - TxtOrario.Height-2;
    TxtTurno.Top:=TxtOrario.Top + TxtOrario.Height;
    TxtTurno.Tag:=99;
    TxtTurno.DataSet:=A058FPianifTurniDtM1.T058Stampa;
    TxtTurno.DataField:='Turni' + IntToStr(i);
   {TxtTurno.Font.Size:=TxtTurno.Font.Size + IfThen((A058FPianifTurniDtM1.selT082.FieldByName('DETT_STAMPA').AsString = 'S') and
                                                   (A058FPianifTurniDtM1.selT082.FieldByName('RIGHE_DIP').AsString = '2'),2,0);}

    with TQRDBText(Dettaglio.AddPrintable(TQRDBText)).Create(Dettaglio) do
    begin
       DataSet:=A058FPianifTurniDtM1.T058Stampa;
       DataField:='NTIMBTURNO_' + IntToStr(i);
       Left:=Trunc(nLeft + (L / 3) * 2);
       ParentFont:=False;
       Font.Color:=clRed;
       Font.Size:=Dettaglio.Font.Size - 1;
       Top:=(Dettaglio.Height div 3) * 2;
       Tag:=99;
       OnPrint:=MyInfoTimbOnPrint;
    end;

    with A058FPianifTurniDtM1 do
    begin
      Mn1:=GetLimitiMAX_MIN(T058Stampa.FieldByName('DATAINIZIO').AsDateTime + i,1).Min;
      Mx1:=GetLimitiMAX_MIN(T058Stampa.FieldByName('DATAINIZIO').AsDateTime + i,1).Max;
      Mn2:=GetLimitiMAX_MIN(T058Stampa.FieldByName('DATAINIZIO').AsDateTime + i,2).Min;
      Mx2:=GetLimitiMAX_MIN(T058Stampa.FieldByName('DATAINIZIO').AsDateTime + i,2).Max;
      Mn3:=GetLimitiMAX_MIN(T058Stampa.FieldByName('DATAINIZIO').AsDateTime + i,3).Min;
      Mx3:=GetLimitiMAX_MIN(T058Stampa.FieldByName('DATAINIZIO').AsDateTime + i,3).Max;
      Mn4:=GetLimitiMAX_MIN(T058Stampa.FieldByName('DATAINIZIO').AsDateTime + i,4).Min;
      Mx4:=GetLimitiMAX_MIN(T058Stampa.FieldByName('DATAINIZIO').AsDateTime + i,4).Max;
      if i = 0 then
      begin
        RiepMINTotale:=Q600B.FieldByName('TOTMIN1').AsInteger + Q600B.FieldByName('TOTMIN2').AsInteger + Q600B.FieldByName('TOTMIN3').AsInteger;
        RiepMINFSTotale:=Q600B.FieldByName('FESMIN1').AsInteger + Q600B.FieldByName('FESMIN2').AsInteger + Q600B.FieldByName('FESMIN3').AsInteger;
        if A058FPianifTurniDtM1.selT082.FieldByName('RIGHE_DIP').AsString = '4' then
        begin
          RiepMINTotale:=RiepMINTotale + Q600B.FieldByName('TOTMIN4').AsInteger;
          RiepMINFSTotale:=RiepMINFSTotale + Q600B.FieldByName('FESMIN4').AsInteger;
        end;
        RiepMAXTotale:=Q600B.FieldByName('TOTMAX1').AsInteger + Q600B.FieldByName('TOTMAX2').AsInteger + Q600B.FieldByName('TOTMAX3').AsInteger;
        RiepMAXFSTotale:=Q600B.FieldByName('FESMAX1').AsInteger + Q600B.FieldByName('FESMAX2').AsInteger + Q600B.FieldByName('FESMAX3').AsInteger;
        if A058FPianifTurniDtM1.selT082.FieldByName('RIGHE_DIP').AsString = '4' then
        begin
          RiepMAXTotale:=RiepMAXTotale + Q600B.FieldByName('TOTMAX4').AsInteger;
          RiepMAXFSTotale:=RiepMAXFSTotale + Q600B.FieldByName('FESMAX4').AsInteger;
        end;
      end;

      TxtTotTurno1:=TQRDBText(Piede5.AddPrintable(TQRDBText));
      TxtTotTurno1.Left:=Trunc(nLeft + 2);
      TxtTotTurno1.Top:=QRLTurno1.Top;
      TxtTotTurno1.DataSet:=T058Stampa;
      TxtTotTurno1.DataField:='TotGenTurno1_' + IntToStr(i);
      TxtTotTurno1.Tag:=99;
      if (T058Stampa.FieldByName('TotGenTurno1_' + IntToStr(i)).AsInteger < Mn1) or
         (T058Stampa.FieldByName('TotGenTurno1_' + IntToStr(i)).AsInteger > Mx1) then
        TxtTotTurno1.Font.Style:=[fsBold]
      else
        TxtTotTurno1.Font.Style:=[];

      nTop:=TxtTotTurno1.Top + TxtTotTurno1.Height + 2;
      //Gestione copertura turno_1 suddiviso per operatori
      if A058FPianifTurniDtM1.selT082.FieldByName('TOT_OPE_TURNO').AsString = 'S' then
        PrintTotaliGGOperatori(aTotaleTurni[i].TotOpe1,'1');

      //Gestione stampa liquidabile dip.
      if A058FPianifTurniDtM1.selT082.FieldByName('TOT_LIQUIDABILE').AsString = 'S' then
      begin
        with TQRLabel(PiedeLiquid.AddPrintable(TQRLabel)).Create(nil) do
        begin
          Left:=Trunc(nLeft + 5);
          Font.Size:=PiedeLiquid.Font.Size - 1;
          Top:=5;
          AutoSize:=True;
          Caption:=R180MinutiOre(aTotaleTurni[i].TotOraLiquid);
          Tag:=99;
        end;

        if A058FPianifTurniDtM1.selT082.FieldByName('SEPARATORE_COL').AsString = 'S' then
          with TQRShape(PiedeLiquid.AddPrintable(TQRShape)).Create(nil) do
          begin
            Left:=Trunc(nLeft);
            Top:=0;
            Shape:=qrsVertLine;
            Height:=PiedeLiquid.Height;
            Width:=1;
            Tag:=99;
          end;

        if A058FPianifTurniDtM1.selT082.FieldByName('SEPARATORE_COL').AsString = 'S' then
          if (A058FPianifTurniDtM1.selT082.FieldByName('GG_PAGINA').AsInteger - 1) = i then
            with TQRShape(PiedeLiquid.AddPrintable(TQRShape)).Create(PiedeLiquid) do
            begin
              Parent:=PiedeLiquid;
              Left:=Trunc(nLeft + L);
              Top:=0;
              Shape:=qrsVertLine;
              Height:=PiedeLiquid.Height;
              Width:=1;
              Tag:=99;
            end;
      end;

      TxtTotTurno2:=TQRDBText(Piede5.AddPrintable(TQRDBText));
      TxtTotTurno2.Left:=Trunc(nLeft + 2);
      TxtTotTurno2.Top:=QRLTurno2.Top;;
      TxtTotTurno2.DataSet:=T058Stampa;
      TxtTotTurno2.DataField:='TotGenTurno2_' + IntToStr(i);
      TxtTotTurno2.Tag:=99;
      if (T058Stampa.FieldByName('TotGenTurno2_' + IntToStr(i)).AsInteger < Mn2) or
         (T058Stampa.FieldByName('TotGenTurno2_' + IntToStr(i)).AsInteger > Mx2) then
        TxtTotTurno2.Font.Style:=[fsBold]
      else
        TxtTotTurno2.Font.Style:=[];

      nTop:=nTop + 15 + 2;
      if A058FPianifTurniDtM1.selT082.FieldByName('TOT_OPE_TURNO').AsString = 'S' then
        PrintTotaliGGOperatori(aTotaleTurni[i].TotOpe2,'2');

      TxtTotTurno3:=TQRDBText(Piede5.AddPrintable(TQRDBText));
      TxtTotTurno3.Left:=Trunc(nLeft + 2);
      TxtTotTurno3.Top:=QRLTurno3.Top;
      TxtTotTurno3.DataSet:=T058Stampa;
      TxtTotTurno3.DataField:='TotGenTurno3_' + IntToStr(i);
      TxtTotTurno3.Tag:=99;
      if (T058Stampa.FieldByName('TotGenTurno3_' + IntToStr(i)).AsInteger < Mn3) or
         (T058Stampa.FieldByName('TotGenTurno3_' + IntToStr(i)).AsInteger > Mx3) then
        TxtTotTurno3.Font.Style:=[fsBold]
      else
        TxtTotTurno3.Font.Style:=[];

      nTop:=nTop + 15 + 2;
      if A058FPianifTurniDtM1.selT082.FieldByName('TOT_OPE_TURNO').AsString = 'S' then
        PrintTotaliGGOperatori(aTotaleTurni[i].TotOpe3,'3');

      if A058FPianifTurniDtM1.selT082.FieldByName('RIGHE_DIP').AsString = '4' then
      begin
        TxtTotTurno4:=TQRDBText(Piede5.AddPrintable(TQRDBText));
        TxtTotTurno4.Left:=Trunc(nLeft + 2);
        TxtTotTurno4.Top:=QRLTurno4.Top;
        TxtTotTurno4.DataSet:=T058Stampa;
        TxtTotTurno4.DataField:='TotGenTurno4_' + IntToStr(i);
        TxtTotTurno4.Tag:=99;
        if (T058Stampa.FieldByName('TotGenTurno4_' + IntToStr(i)).AsInteger < Mn4) or
           (T058Stampa.FieldByName('TotGenTurno4_' + IntToStr(i)).AsInteger > Mx4) then
          TxtTotTurno4.Font.Style:=[fsBold]
        else
          TxtTotTurno4.Font.Style:=[];

        if A058FPianifTurniDtM1.selT082.FieldByName('RIGHE_DIP').AsString = '4' then
        begin
          nTop:=nTop + 15 + 2;
          if A058FPianifTurniDtM1.selT082.FieldByName('TOT_OPE_TURNO').AsString = 'S' then
            PrintTotaliGGOperatori(aTotaleTurni[i].TotOpe4,'4');
        end;
      end;
      PrintTotaliCopertura;
      //Piede5.Height:=nTop + 16;
    end;
  end;

  {*****************************************
  Stampo il nome del dato libero selezionato
  ******************************************}
  with TSelI010.create(Self) do
    try
      Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO',
           'NOME_CAMPO = ''' + A058FPianifTurniDtM1.selT082.FieldByName('DATO_ANAGRAFICO').asString + '''',
           'NOME_LOGICO');
      qrlblDatoLibero.Caption:=FieldByName('NOME_LOGICO').asString;
    finally
      Free;
    end;
  qrlblDatoLibero.Left:=Trunc(nLeft + 5 + L);
  qrlblDatoLibero.Top:=1;
  qrlblDatoLibero.Font:=IntestazioneCalendario.Font;
  qrlblDatoLibero.Font.Size:=IntestazioneCalendario.Font.Size;

  {***************************************************
  Stampo il totale liquidabile del periodo selezionato
  ***************************************************}
  with TQRLabel(PiedeLiquid.AddPrintable(TQRLabel)).Create(PiedeLiquid) do
  begin
    Tag:=99;
    Top:=qlblLiquid.Top;
    TotLiquid:=0;
    for i:=Low(A058FPianifTurniDtM1.aTotaleTurni) to High(A058FPianifTurniDtM1.aTotaleTurni) do
      TotLiquid:=TotLiquid + A058FPianifTurniDtM1.aTotaleTurni[i].TotOraLiquid;
    Caption:='Tot: ' + R180MinutiOre(TotLiquid);
    Font:=PiedeLiquid.Font;
    Font.Size:=PiedeLiquid.Font.Size;
    Left:=9 * Font.Size;
  end;

  {*************************************************
  Stampo il totale mensile della copertura dei turni
  **************************************************}
  with TQRLabel(TotTotaliGG.AddPrintable(TQRLabel)).Create(TotTotaliGG) do
  begin
    Tag:=99;
    Parent:=TotTotaliGG;
    ParentFont:=True;
    Font:=qrLblTotGen.Font;
    Top:=qrLblTotGen.Top;
    AutoSize:=True;
    Left:=9 * Font.Size;
    Caption:='Tot: ' + IntToStr(RiepMINTotale);
    if RiepMINFSTotale > 0 then
      Caption:=Caption + '(' + IntToStr(RiepMINFSTotale) + ')';
    Caption:=Caption + ' - ' + IntToStr(RiepMAXTotale);
    if RiepMAXFSTotale > 0 then
      Caption:=Caption + '(' + IntToStr(RiepMAXFSTotale) + ')';
  end;

  {*******************************************
  Stampo il dato libero anagrafico selezionato
  ********************************************}
  if (Not A058FPianifTurniDtm1.selT082.FieldByName('DATO_ANAGRAFICO').isNull) and
     (Dettaglio.Width > Trunc(nLeft + L + 5)){Verifico se c'è spazio per stampare il dato altrimenti, non stampo nulla} then
    with TQRDBText(Dettaglio.AddPrintable(TQRDBText)).Create(Dettaglio) do
    begin
      Tag:=99;
      AutoSize:=False;
      AutoStretch:=True;
      Parent:=Dettaglio;
      ParentFont:=True;
      Font:=Dettaglio.Font;
      DataSet:=A058FPianifTurniDtM1.T058Stampa;
      DataField:='DatoAnag';
      WordWrap:=True;
      Left:=Trunc(nLeft + L + 5);
      Top:=QRLTurno1.Top;
      Width:=Dettaglio.Width - Trunc(nLeft + L + 5);
    end;

  if A058FPianifTurniDtm1.selT082.FieldByName('SEPARATORE_COL').AsString = 'S' then  //Lorena
  begin
    //Separatore colonne di intestazione
    xQRShape3:=TQRShape(IntestazioneCalendario.AddPrintable(TQRShape));
    xQRShape3.Shape:=qrsVertLine;
    xQRShape3.Height:=IntestazioneCalendario.Height;
    xQRShape3.Width:=1;
    xQRShape3.Left:=Trunc(nLeft + L);
    xQRShape3.Tag:=99;

    //Separatore colonne di dettaglio
    xQRShape1:=TQRShape(Dettaglio.AddPrintable(TQRShape));
    xQRShape1.Shape:=qrsVertLine;
    xQRShape1.Height:=Dettaglio.Height;
    xQRShape1.Width:=1;
    xQRShape1.Left:=Trunc(nLeft + L);
    xQRShape1.Tag:=99;
  end;

  //Separatore colonne di piede5
  {xQRShape2:=TQRShape(Piede5.AddPrintable(TQRShape));
  xQRShape2.Parent:=Piede5;
  xQRShape2.Shape:=qrsVertLine;
  xQRShape2.Height:=Piede5.Height;
  xQRShape2.Width:=1;
  xQRShape2.Left:=Trunc(nLeft + L);
  xQRShape2.Tag:=99;}
  Dettaglio.Frame.DrawBottom:=A058FPianifTurniDtM1.selT082.FieldByName('SEPARATORE_RIGHE').AsString = 'S';
end;

procedure TA058FTabellone.Piede5BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  with A058FPianifTurniDtm1 do
  begin
    if selT082.FieldByName('TOT_OPE_TURNO').AsString = 'S' then
      Piede5.Height:=HCPiede5
    else
      if A058FPianifTurniDtM1.selT082.FieldByName('RIGHE_DIP').AsString = '4' then
        Piede5.Height:=QRLTurno4.Top + QRLTurno4.Height + 1
      else
        Piede5.Height:=QRLTurno3.Top + QRLTurno3.Height + 1;
    if A058FPianifTurniDtM1.selT082.FieldByName('TOT_TURNO').AsString = 'N' then
    begin
      PrintBand:=False;
      exit;
    end;
  end;
end;

procedure TA058FTabellone.PiedeLiquidBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if A058FPianifTurniDtM1.selT082.FieldByName('TOT_LIQUIDABILE').AsString = 'N' then
    PrintBand:=False;
end;

procedure TA058FTabellone.PageHeaderBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRData.Caption:='dal ' + A058FPianifTurniDtM1.T058Stampa.FieldByName('DataInizio').AsString + ' al ' + A058FPianifTurniDtM1.T058Stampa.FieldByName('DataFine').AsString;
  QRLblSituazione.Caption:='';
  if A058FPianifTurniDtM1.selT082.FieldByName('TIPO_STAMPA').AsString = 'C' then
    QRLblSituazione.Caption:='(situazione consuntiva)'
  else
  begin
    if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
    begin
      if A058FPianifTurniDtm1.selT082.FieldByName('MODALITA_LAVORO').AsString = 'S' then
        QRLblSituazione.Caption:='(pianificazione operativa)'
      else
      begin
        if A058FPianifTurni.RgpTipo.ItemIndex = 0 then
          QRLblSituazione.Caption:='(pianificazione non operativa iniziale)'
        else
          QRLblSituazione.Caption:='(pianificazione non operativa corrente)'
      end;
    end;
  end;
end;

procedure TA058FTabellone.DistruggiOggetti99(InComp:TComponent);
var
  i,nDep:Integer;
begin
  nDep:=InComp.ComponentCount - 1;
  i:=0;
  while i <= nDep do
  begin
    if InComp.Components[i].Tag = 99 then
    begin
      InComp.Components[i].Free;
      nDep:=nDep-1;
    end
    else
      i:=i+1;
  end;
end;

procedure TA058FTabellone.FormDestroy(Sender: TObject);
begin
  LAssenze.Free;
  LOrari.Free;
  LTotTurni.Free;
  DistruggiOggetti99(A058FTabellone);
end;

procedure TA058FTabellone.IntestazioneCalendarioBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  CreaDataIntestazione;
end;

procedure TA058FTabellone.CreaDataIntestazione;
{Genero l'intestazione del calendario}
const
  Giorni:Array[1..7] of String = ('Do','Lu','Ma','Me','Gi','Ve','Sa');
var
  DataCorr:TDateTime;
  i:Integer;
begin
  for i:=0 to IntestazioneCalendario.ControlCount - 1 do
    if (IntestazioneCalendario.Controls[i].Tag = 99) and (IntestazioneCalendario.Controls[i] is TQRLabel) then
    begin
      (IntestazioneCalendario.Controls[i] as TQRLabel).Caption:='';
      DataCorr:=A058FPianifTurniDtM1.T058Stampa.FieldByName('DataInizio').AsDateTime +
                StrToIntDef(Copy((IntestazioneCalendario.Controls[i] as TQRLabel).Name,6,3),-1);
      if (DataCorr >= A058FPianifTurniDtM1.T058Stampa.FieldByName('DataInizio').AsDateTime) and
         (DataCorr <= A058FPianifTurniDtM1.T058Stampa.FieldByName('DataFine').AsDateTime) then
      begin
        if Copy((IntestazioneCalendario.Controls[i] as TQRLabel).Name,1,5) = 'lblDD' then
          (IntestazioneCalendario.Controls[i] as TQRLabel).Caption:=R180DimLung(FormatDateTime('dd',DataCorr),A058FPianifTurniDtm1.LungCella)
        else
          (IntestazioneCalendario.Controls[i] as TQRLabel).Caption:=Format('%-' + inttostr(A058FPianifTurniDtm1.LungCella) + 's',[Giorni[DayOfWeek(DataCorr)]]);
        with A058FPianifTurniDtm1.GetCalend, A058FPianifTurni do
        begin
          SetVariable('PROG',A058FPianifTurniDtM1.T058Stampa.FieldByName('Progressivo').AsInteger);
          SetVariable('D',DataCorr);
          Execute;
          if (VarToStr(GetVariable('F')) = 'S') or (DayOfWeek(DataCorr) = 1) then
          begin
            (IntestazioneCalendario.Controls[i] as TQRLabel).Font.Color:=clRed;
            (IntestazioneCalendario.Controls[i] as TQRLabel).Font.Style:=[fsBold,fsItalic];
          end
          else
          begin
            (IntestazioneCalendario.Controls[i] as TQRLabel).Font.Color:=clBlack;
            (IntestazioneCalendario.Controls[i] as TQRLabel).Font.Style:=[];
          end;
        end;
      end;
    end;
end;

end.
