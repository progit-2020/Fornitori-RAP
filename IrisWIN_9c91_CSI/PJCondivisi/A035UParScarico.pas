unit A035UParScarico;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, Mask, StrUtils,
  DBCtrls, Grids, DBGrids, ActnList, ImgList, ToolWin, A000UCostanti, A000USessione,A000UInterfaccia, Variants;

type
  TA035FParScarico = class(TR001FGestTab)
    ScrollBox1: TScrollBox;
    GroupBox2: TGroupBox;
    OpenDialog1: TOpenDialog;
    edtCodice: TDBEdit;
    edtDescrizione: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    sbtNomeFile: TSpeedButton;
    SaveDialog1: TSaveDialog;
    edtNomeFile: TDBEdit;
    DBGrid1: TDBGrid;
    DBRadioGroup1: TDBRadioGroup;
    drgpFormatoOre: TDBRadioGroup;
    drgpPrecisione: TDBRadioGroup;
    Label3: TLabel;
    dedtNomeEnte: TDBEdit;
    Label4: TLabel;
    edtUtentePaghe: TDBEdit;
    dchkSalvataggioAutomatico: TDBCheckBox;
    dgrpSeparatoreDecimali: TDBRadioGroup;
    OpenDialog2: TOpenDialog;
    dchkRicreazioneAutomatica: TDBCheckBox;
    grpDataSuFile: TGroupBox;
    lblFormatoData: TLabel;
    dcmbFormatoData: TDBComboBox;
    dgrpTipoData: TDBRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure sbtNomeFileClick(Sender: TObject);
    procedure DBRadioGroup1Change(Sender: TObject);
    procedure drgpPrecisioneChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    VoceMenu: String;
  end;

var
  A035FParScarico: TA035FParScarico;
const
  cParPaghe:string='PAGHE';
  cParContab:string='CONTAB';

procedure OpenA035ParScarico(Cod:String; sVoceMenu:String);

implementation

uses A035UParScaricoDTM1;

{$R *.DFM}

procedure OpenA035ParScarico(Cod:String; sVoceMenu:String);
{Parametrizzazione file seq. di scarico alle paghe}
var
  sInibizioni:string;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  if sVoceMenu = cParPaghe then
    sInibizioni:='OpenA035ParScarico'
  else if sVoceMenu = cParContab then
    sInibizioni:='OpenA035FParContabilita'
  else
    sInibizioni:='';
  case A000GetInibizioni('Funzione',sInibizioni) of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A035FParScarico:=TA035FParScarico.Create(nil);
  A035FParScarico.VoceMenu:=sVoceMenu;
  with A035FParScarico do
  try
    A035FParScaricoDtM1:=TA035FParScaricoDtM1.Create(nil);
    A035FParScaricoDtM1.Q191.Locate('Codice',Cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A035FParScaricoDtM1.Free;
    Release;
  end;
end;

procedure TA035FParScarico.sbtNomeFileClick(Sender: TObject);
begin
  with A035FParScaricoDtM1 do
    begin
      if (Q191.CachedUpDates)and(Q191.State in [dsEdit,dsInsert]) then
        begin
          SaveDialog1.Title := 'Scelta nome file di scarico';
          if not(Q191NomeFile.IsNull) then
            SaveDialog1.FileName := Q191NomeFile.Value;
          if SaveDialog1.Execute then
            Q191NomeFile.Value := SaveDialog1.FileName;
        end;
    end;
end;

//------------------------------------------------------------------------------
procedure TA035FParScarico.DBRadioGroup1Change(Sender: TObject);
begin
  sbtNomeFile.Enabled:=DBRadioGroup1.ItemIndex = 0;
  edtUtentePaghe.Enabled:=DBRadioGroup1.ItemIndex = 1;
  dchkSalvataggioAutomatico.Enabled:=DBRadioGroup1.ItemIndex = 1;
  dchkRicreazioneAutomatica.Enabled:=DBRadioGroup1.ItemIndex = 1;
end;

procedure TA035FParScarico.drgpPrecisioneChange(Sender: TObject);
begin
  dgrpSeparatoreDecimali.Visible:=drgpPrecisione.ItemIndex = 2;
end;

procedure TA035FParScarico.FormActivate(Sender: TObject);
begin
  inherited;
  if VoceMenu = cParPaghe then
  begin
    A035FParScarico.Caption:='<A035> Regole scarico paghe';
    A035FParScarico.HelpContext:=35000;
    dchkSalvataggioAutomatico.Visible:=True;
    dchkRicreazioneAutomatica.Visible:=True;
    Label4.Caption:='Utente della procedura Paghe:';
    drgpFormatoOre.Visible:=True;
    dgrpTipoData.Visible:=True;
    DBGrid1.Columns[0].PickList.Clear;
    DBGrid1.Columns[0].PickList.Add('0 FILLER');
    DBGrid1.Columns[0].PickList.Add('1 ENTE');
    DBGrid1.Columns[0].PickList.Add('2 DATA');
    DBGrid1.Columns[0].PickList.Add('3 MATRICOLA');
    DBGrid1.Columns[0].PickList.Add('4 BADGE');
    DBGrid1.Columns[0].PickList.Add('5 COD.INTERNO');
    DBGrid1.Columns[0].PickList.Add('6 COD.PAGHE');
    DBGrid1.Columns[0].PickList.Add('7 SEGNO');
    DBGrid1.Columns[0].PickList.Add('8 VALORE');
    DBGrid1.Columns[0].PickList.Add('9 MISURA');
    DBGrid1.Columns[0].PickList.Add('A DA DATA');
    DBGrid1.Columns[0].PickList.Add('B A DATA');
    DBGrid1.Columns[0].PickList.Add('C RIFERIMENTO');
    DBGrid1.Columns[0].PickList.Add('D DA ORE');
    DBGrid1.Columns[0].PickList.Add('E A ORE');
    DBGrid1.Columns[0].PickList.Add('F DATA DI CASSA');
    DBGrid1.Columns[0].PickList.Add('G IMPORTO');
    DBGrid1.Columns[0].PickList.Add('H DATO ANAGRAFICO');
  end
  else if VoceMenu = cParContab then
  begin
    A035FParScarico.Caption:='<A035> Parametrizzazione scarico contabilità';
    A035FParScarico.HelpContext:=35100;
    dchkSalvataggioAutomatico.Visible:=False;
    dchkRicreazioneAutomatica.Visible:=False;
    Label4.Caption:='Utente della procedura Cont.:';
    drgpFormatoOre.Visible:=False;
    dgrpTipoData.Visible:=False;
    DBGrid1.Columns[0].PickList.Clear;
    DBGrid1.Columns[0].PickList.Add('0 FILLER');
    DBGrid1.Columns[0].PickList.Add('1 DATA ELABORAZIONE');
    DBGrid1.Columns[0].PickList.Add('2 TOTALE DARE');
    DBGrid1.Columns[0].PickList.Add('3 TOTALE AVERE');
    DBGrid1.Columns[0].PickList.Add('4 N. RIGHE DETT. D/A SU STESSA RIGA');
    DBGrid1.Columns[0].PickList.Add('5 N. RIGHE DETT. D/A SU DUE RIGHE');
    DBGrid1.Columns[0].PickList.Add('6 PROGRESSIVO RIGA');
    DBGrid1.Columns[0].PickList.Add('7 ID-CONTO');
    DBGrid1.Columns[0].PickList.Add('8 SEGNO IMPORTO');
    DBGrid1.Columns[0].PickList.Add('9 IMPORTO');
    DBGrid1.Columns[0].PickList.Add('A DARE_AVERE');
    DBGrid1.Columns[0].PickList.Add('B SEGNO IMP. DARE');
    DBGrid1.Columns[0].PickList.Add('C IMPORTO_DARE');
    DBGrid1.Columns[0].PickList.Add('D SEGNO IMP. AVERE');
    DBGrid1.Columns[0].PickList.Add('E IMPORTO_AVERE');
    DBGrid1.Columns[0].PickList.Add('F DATA ESPORTAZIONE');
    DBGrid1.Columns[0].PickList.Add('G DATA COMPETENZA');
    DBGrid1.Columns[0].PickList.Add('H DESCRIZIONE CONTO');
  end;
end;

procedure TA035FParScarico.FormCreate(Sender: TObject);
begin
  inherited;
  VoceMenu:=IfThen(VoceMenu <> '',VoceMenu,cParPaghe);
end;

begin
  Application.Title:='<A035> Parametrizzazione scarico paghe';
end.
