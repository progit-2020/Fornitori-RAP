unit C001UStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, C001StampaLib, Printers, Quickrpt, QrCtrls,QRPrntr,
  QRExport, Variants, QRPDFFilt;

type
  TC001FStampa = class(TForm)
    QRep: TQuickRep;
    QRBIntestazione: TQRBand;
    QRBDettaglio: TQRBand;
    QRBTitolo: TQRBand;
    QRSDDateTime: TQRSysData;
    QRSDPageno: TQRSysData;
    QRLblTitolo: TQRLabel;
    QRLblIntestazione: TQRLabel;
    QRBSpaziatura: TQRChildBand;
    QRSRecord: TQRShape;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRExcelFilter1: TQRExcelFilter;
    QRPDFFilter1: TQRPDFFilter;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure QRepAfterPreview(Sender: TObject);
    procedure QRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRepAfterPrint(Sender: TObject);
  private
    { Private declarations }
    VettExpr : array[1..MAXBANDEGROUP] of String;
    VettBande : array[1..10] of TQRGroup;
    VettBandeFooter : array[1..10] of TQRBand;
    VettQRShapeInf : array[1..10] of TQRShape;
    VettQRShapeSup : array[1..10] of TQRShape;
    BDettHeight:Integer;
    BIntHeight:Integer;
    VettHeight : array[1..10] of Integer;
    NBande : Integer;
    QRLista:TList;   // lista componenti del report creati
    ThousandSepOri: Char;
    procedure CreaQRDBText(RecStampa:Rec_Stampa);
    procedure CreaQRLabel(RecStampa:Rec_Stampa);
    procedure CreaQRLista;
    procedure SvuotaQRLista;
    function StampaGruppo(NumeroOggetti : Integer) : Boolean;
    function GetPen(Linea : TRec_Linea) : TPen;
    function GetLeft(Linea : TRec_Linea) : Real;
    procedure AssegnaParentFont(Padre : TQRGroup;Value : Boolean);
  public
    { Public declarations }
    procedure CreaReport(var Vett:ArrayStampa;num:integer);
    procedure Anteprima;
  end;

var
  C001FStampa: TC001FStampa;

implementation

{$R *.DFM}

uses C001UFiltroTabelleDtM, C001UFiltroTabelle;

procedure TC001FStampa.FormCreate(Sender: TObject);
begin
  QRep.useQR5Justification:=True;
  CreaQRLista;
  BDettHeight:=0;
  BIntHeight:=0;
end;

//------------------------------------------------------------------------------
// In base al numero del tratteggio calcolo lo Style e il Mode dell' oggetto TPen
function TC001FStampa.GetPen(Linea : TRec_Linea) : TPen;
begin
  Result := TPen.Create;
  Result.Color := clBlack;
  Result.Style := psSolid;
  Result.Mode := pmBlack;
  Result.Width := Linea.Altezza;
  case Linea.Tratteggio of
    0:begin
        Result.Style := psSolid;
        Result.Mode := pmBlack;
      end;
    1:begin
        Result.Style := psDash;
        Result.Mode := pmNotXor;
      end;
    2:begin
        Result.Style := psDash;
        Result.Mode := pmXor;
      end;
    3:begin
        Result.Style := psDashDot;
        Result.Mode := pmNotXor;
      end;
    4:begin
        Result.Style := psDashDot;
        Result.Mode := pmXor;
      end;
    5:begin
        Result.Style := psDashDotDot;
        Result.Mode := pmNotXor;
      end;
    6:begin
        Result.Style := psDashDotDot;
        Result.Mode :=  pmXor;
      end
  end;
end;

//------------------------------------------------------------------------------
// In base all' allineamento e alla larghezza calcolo la coordinata Left.
function TC001FStampa.GetLeft(Linea : TRec_Linea) : Real;
begin
  Result := (QRBTitolo.Size.Width - Linea.Larghezza)/2;
  case Linea.Allineamento of
    0:begin
        Result := (QRBTitolo.Size.Width - Linea.Larghezza)/2;
      end;
    1:Result := 0;
    2:begin
        Result := QRBTitolo.Size.Width - Linea.Larghezza;
      end;
  end;
end;

//------------------------------------------------------------------------------
// Funzione che scorre il vettore di stampa e controlla se ci sono dei campi
// di gruppo. Se ce ne sono carico la lista dei campi di gruppo.
function TC001FStampa.StampaGruppo(NumeroOggetti : Integer) : Boolean;
var I : Integer;
    App : String;
begin
  Result := False;
  NBande := 0;
  for I:=1 to NumeroOggetti do
     begin
       if (VettStampa[I].Gruppo) then
         begin
           Result := True;
           if (VettStampa[I].Tipo = qrCampo) then
             begin
               if TipoGruppo = 0 then
                 VettExpr[1] := VettExpr[1] + VettStampa[I].DSource.DataSet.Name + '.'+VettStampa[I].DField+' + '
               else
                 begin
                   inc(NBande);
                   if NBande <= MAXBANDEGROUP then
                     VettExpr[NBande] := VettStampa[I].DSource.DataSet.Name + '.'+VettStampa[I].DField;
                 end;
             end
         end;
     end;
  if (Tipogruppo = 0)and(Result) then
    begin
      NBande := 1;
      App := Trim(VettExpr[1]);
      if App[Length(App)] = '+' then
        Delete(App,Length(App),1);
      VettExpr[1] := App;
    end;
end;

//------------------------------------------------------------------------------
procedure TC001FStampa.AssegnaParentFont(Padre : TQRGroup;Value : Boolean);
var I : Integer;
begin
  for I:=0 to C001FStampa.ComponentCount-1 do
     begin
       if (C001FStampa.Components[I] is TQRLabel)or(C001FStampa.Components[I] is TQRDBText) then
         if TQRLabel(C001FStampa.Components[I]).Parent = Padre then
           TQRLabel(C001FStampa.Components[I]).ParentFont := Value;
     end;
end;

//------------------------------------------------------------------------------
procedure TC001FStampa.CreaReport(var Vett:ArrayStampa;Num:integer);
var i:integer;
    StampaBanda:Boolean;
    StampaGroup : Boolean;
begin
  QRep.Font.Assign(C001FFiltroTabelle.DefaultFont);
  BDettHeight:=0;
  BIntHeight:=0;
  for I:=1 to 10 do
     begin
       VettHeight[I] := 0;
       VettExpr[I] := '';
     end;
  SvuotaQRLista;
  StampaBanda:=false;
  StampaGroup := StampaGruppo(Num);
  if not(StampaGroup) then
    QRBDettaglio.ForceNewPage:=PagineSeparate; //Gestione pagine separate
  if StampaGroup then
    begin
      for I:=1 to NBande do
         begin
           VettBandeFooter[I] := TQRBand.Create(C001FStampa);
           VettBandeFooter[I].Parent := QRep;
           VettBandeFooter[I].BandType := rbGroupFooter;
           VettBandeFooter[I].Enabled := LineaInf.Enabled;
           VettBandeFooter[I].Height := DefHeightFooter;
           if LineaInf.Enabled then
             begin
               VettQRShapeInf[I] := TQRShape.Create(C001FStampa);
               VettQRShapeInf[I].Parent := VettBandeFooter[I];
               VettQRShapeInf[I].Enabled := True;
               VettQRShapeInf[I].Shape := qrsHorLine;
               VettQRShapeInf[I].Pen := GetPen(LineaInf);
               VettQRShapeInf[I].Size.Height := 2;
               VettQRShapeInf[I].Size.Left := GetLeft(LineaInf);
               VettQRShapeInf[I].Size.Width := LineaInf.Larghezza;
               VettQRShapeInf[I].Size.Top := (DefHeightFooter div 2);
             end;
           VettBande[I] := TQRGroup.Create(C001FStampa);
           VettBande[I].Parent := QRep;
           VettBande[I].Height := 0; // verranno ridimensionate successivamente.
           VettBande[I].Master := QRBTitolo;
           VettBande[I].Expression := VettExpr[I];
           VettBande[I].FooterBand := VettBandeFooter[I];
           VettBande[I].Enabled := True;
           if I = 1 then
             VettBande[I].ForceNewPage := PagineSeparate
           else
             VettBande[I].ForceNewPage := False;
         end;
    end;
  for I:=1 to Num do
    if Vett[i].banda <> bNone then
      begin
        if Vett[i].banda = bIntestazione then
          StampaBanda:=true;
        case Vett[i].Tipo of
          QRIntestazione:CreaQRLabel(Vett[i]);
          QRCampo:CreaQRDBText(Vett[i]);
        end;
      end;
  if StampaBanda then
    QRBIntestazione.Enabled:=True
  else
    QRBIntestazione.Enabled:=false;
  QRSRecord.Enabled:=False;
  if LineaRec.Enabled then
    begin
      QRBSpaziatura.ParentBand := QRBDettaglio;
      QRBSpaziatura.Enabled := True;
      QRSRecord.Enabled := True;
      QRSRecord.Shape := qrsHorLine;
      QRSRecord.Pen := GetPen(LineaRec);
      QRSRecord.Size.Height := 2;
      QRSRecord.Size.Left := GetLeft(LineaRec);
      QRSRecord.Size.Width := LineaRec.Larghezza;
      QRSRecord.Size.Top := (QRBSpaziatura.Height div 2);
    end;
  QRBDettaglio.Height:=BDettHeight;
  QRBIntestazione.Height:=BIntHeight;
  for I:=1 to NBande do
     begin
       VettBande[I].Height := VettHeight[I];
       if FontGruppo[I] <> nil then
         begin
           VettBande[I].Font := FontGruppo[I];
           AssegnaParentFont(VettBande[I],True);
         end;
       if LineaSup.Enabled then
         begin
           VettBande[I].Height := VettHeight[I]+DefHeightFooter;
           VettQRShapeSup[I] := TQRShape.Create(C001FStampa);
           VettQRShapeSup[I].Parent := VettBande[I];
           VettQRShapeSup[I].Enabled := True;
           VettQRShapeSup[I].Shape := qrsHorLine;
           VettQRShapeSup[I].Pen := GetPen(LineaSup);
           VettQRShapeSup[I].Size.Height := 2;
           VettQRShapeSup[I].Size.Left := GetLeft(LineaSup);
           VettQRShapeSup[I].Size.Width := LineaSup.Larghezza;
           VettQRShapeSup[I].Size.Top := VettBande[I].Height-5;
         end;
     end;
end;

procedure TC001FStampa.Anteprima;
begin
  QRep.preview;
end;

procedure TC001FStampa.CreaQRLabel(RecStampa:Rec_Stampa);
var Oggetto:TQRLabel;
begin
  Oggetto:=TQRLabel.Create(C001FStampa);
  Oggetto.Name:=RecStampa.NomeOggetto;
  Oggetto.Caption:=RecStampa.Caption;
  Oggetto.Autosize:=False;
  Oggetto.Left:=RecStampa.Left;
  Oggetto.Top:=RecStampa.Top;
  Oggetto.Width:=RecStampa.Width;
  Oggetto.Height:=RecStampa.Height;
  Oggetto.Transparent:=RecStampa.Trasp;
  Oggetto.Color:=RecStampa.Color;
  if RecStampa.Font <> nil then
     Oggetto.Font:=RecStampa.Font;
  if ((RecStampa.Gruppo) or (RecStampa.SelGruppo)) and (RecStampa.NumeroBandaGruppo >=0) then
    begin
      //Uso AutoSize per settare automaticamente l'altezza della Label
      Oggetto.Parent:=VettBande[RecStampa.NumeroBandaGruppo];
      if VettHeight[RecStampa.NumeroBandaGruppo] < Oggetto.Top + Oggetto.Height then
        VettHeight[RecStampa.NumeroBandaGruppo]:=Oggetto.Top+Oggetto.Height;
    end
  else
    begin
      case RecStampa.Banda of
        bIntestazione : Oggetto.Parent:=QRBIntestazione;
        bDettaglio : Oggetto.Parent:=QRBDettaglio;
      end;
      if BIntHeight < Oggetto.Top + Oggetto.Height then
         BIntHeight:=Oggetto.Top + Oggetto.Height;
    end;
  QRLista.Add(Oggetto);
end;

//------------------------------------------------------------------------------
procedure TC001FStampa.CreaQRDBText(RecStampa:Rec_Stampa);
var oggetto:TQRDBtext;
begin
  Oggetto:=TQRDBText.Create(C001FStampa);
  Oggetto.Name:=RecStampa.NomeOggetto;
  Oggetto.Autosize:=false;
  Oggetto.Left:=RecStampa.left;
  Oggetto.Top:=RecStampa.top;
  Oggetto.Width:=RecStampa.width;
  Oggetto.Height:=RecStampa.height;
  if RecStampa.Font <> nil then
     Oggetto.Font:=RecStampa.Font;
  if ((RecStampa.Gruppo) or (RecStampa.SelGruppo)) and (RecStampa.NumeroBandaGruppo >= 0) then
    begin
      Oggetto.AutoSize:=True;
      Oggetto.Parent:=VettBande[RecStampa.NumeroBandaGruppo];
      if VettHeight[RecStampa.NumeroBandaGruppo] < Oggetto.Top + Oggetto.Height then
        VettHeight[RecStampa.NumeroBandaGruppo]:=Oggetto.Top + Oggetto.Height;
    end
  else
    begin
      case RecStampa.Banda of
        bIntestazione : Oggetto.Parent:=QRBIntestazione;
        bDettaglio : Oggetto.Parent:=QRBDettaglio;
      end;
      if BDettHeight<Oggetto.Top+Oggetto.Height then
        BDettHeight:=Oggetto.Top+Oggetto.Height;
    end;
  Oggetto.DataSet:=RecStampa.DSource.DataSet;
  Oggetto.DataField:=RecStampa.DField;
  Oggetto.Transparent:=RecStampa.Trasp;
  Oggetto.Color:=RecStampa.Color;
  QRLista.Add(Oggetto);
end;
//------------------------------------------------------------------------------
procedure TC001FStampa.CreaQRLista;
begin
  QRLista:=TList.Create;
end;
//------------------------------------------------------------------------------
procedure TC001FStampa.SvuotaQRLista;
var Oggetto:TObject;
begin
  while QRLista.Count > 0 do
    begin
      Oggetto:=QRLista.Items[QRLista.Count-1];
      if Oggetto is TQRDBText then
        (Oggetto as TQRDBText).free
      else
        if Oggetto is TQRLabel then
          (Oggetto as TQRLabel).free;
      QRLista.Delete(QRLista.Count-1);
    end;
end;

procedure TC001FStampa.FormDestroy(Sender: TObject);
var i:Integer;
begin
  SvuotaQRLista;
  for I:= NBande downto 1 do
     begin
       if LineaInf.Enabled then
         TQRShape(VettQRShapeInf[I]).Free;
       if LineaSup.Enabled then
         TQRShape(VettQRShapeSup[I]).Free;
       TQRGroup(VettBande[I]).Free;
       TQRBand(VettBandeFooter[I]).Free;
     end;
  QRLista.Free;
end;

procedure TC001FStampa.QRepAfterPreview(Sender: TObject);
begin
  if {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator = #0 then
    {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=ThousandSepOri;
end;

procedure TC001FStampa.QRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  ThousandSepOri:={$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator;
  if QRep.Exporting then
    if QRep.ExportFilter is TQRXLSFilter then
      {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=#0;
end;

procedure TC001FStampa.QRepAfterPrint(Sender: TObject);
begin
  if {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator = #0 then
    {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=ThousandSepOri;
end;

end.
