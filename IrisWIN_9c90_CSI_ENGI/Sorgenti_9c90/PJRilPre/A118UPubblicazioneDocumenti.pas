unit A118UPubblicazioneDocumenti;

interface

uses
  A118UPubblicazioneDocumentiMW, A000UCostanti, A000USessione, A000UInterfaccia,
  C180FunzioniGenerali, Oracle,
  StrUtils, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  ExtCtrls, StdCtrls, Buttons, Mask, DBCtrls, Grids, DBGrids,
  FileCtrl, System.Actions;

type
  TA118FPubblicazioneDocumenti = class(TR001FGestTab)
    grpLivelli: TGroupBox;
    grpCampi: TGroupBox;
    pnlI200: TPanel;
    lblCodice: TLabel;
    dedtCodice: TDBEdit;
    lblDescrizione: TLabel;
    dedtDescrizione: TDBEdit;
    dedtFiltro: TDBEdit;
    lblFiltro: TLabel;
    btnCheckFiltro: TSpeedButton;
    Splitter1: TSplitter;
    dgrdLivelli: TDBGrid;
    dgrdCampi: TDBGrid;
    pnlTest: TPanel;
    btnTest: TSpeedButton;
    edtTest: TEdit;
    Label4: TLabel;
    lblRoot: TLabel;
    dedtRoot: TDBEdit;
    btnScegliRoot: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnCheckFiltroClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure dedtFiltroChange(Sender: TObject);
    procedure dgrdCampiExit(Sender: TObject);
    procedure dgrdLivelliExit(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure edtTestChange(Sender: TObject);
    procedure btnScegliRootClick(Sender: TObject);
  private
    function TestImpostazioni(const PStr: String; var RElencoValori, RErrMsg: String): Boolean;
  end;

var
  A118FPubblicazioneDocumenti: TA118FPubblicazioneDocumenti;

procedure OpenA118PubblicazioneDocumenti;

implementation

uses A118UPubblicazioneDocumentiDtM;

{$R *.dfm}

procedure OpenA118PubblicazioneDocumenti;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA118PubblicazioneDocumenti') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A118FPubblicazioneDocumenti:=TA118FPubblicazioneDocumenti.Create(nil);
  with A118FPubblicazioneDocumenti do
  try
    A118FPubblicazioneDocumentiDtM:=TA118FPubblicazioneDocumentiDtM.Create(nil);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A118FPubblicazioneDocumentiDtM.Free;
    Free;
  end;
end;

procedure TA118FPubblicazioneDocumenti.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A118FPubblicazioneDocumentiDtM.selI200;
end;

procedure TA118FPubblicazioneDocumenti.btnCheckFiltroClick(Sender: TObject);
var
  Err: String;
begin
  Err:='';
  if A118FPubblicazioneDocumentiDtM.A118MW.CheckFiltroDoc(dedtFiltro.Text,Err) then
    R180MessageBox('Il filtro di visualizzazione documento è sintatticamente corretto!',INFORMA)
  else
  begin
    if Err = '' then
      R180MessageBox('Il filtro di visualizzazione documento è sintatticamente corretto, ma non è possibile determinarne il risultato!',INFORMA)
    else
      R180MessageBox('Il filtro di visualizzazione documento è errato:'#13#10 + Err,ESCLAMA);
  end;
end;

procedure TA118FPubblicazioneDocumenti.btnScegliRootClick(Sender: TObject);
var
  NewDir: String;
begin
  if SelectDirectory('Selezione cartella base documenti','',NewDir) then
    dedtRoot.Field.AsString:=NewDir;
end;

procedure TA118FPubblicazioneDocumenti.btnTestClick(Sender: TObject);
var
  Err, ElencoValori, Msg: String;
  Ok: Boolean;
begin
  if Trim(edtTest.Text) = '' then
  begin
    R180MessageBox('Indicare il nome di file / directory da testare',INFORMA);
  end
  else
  begin
    Ok:=TestImpostazioni(edtTest.Text,ElencoValori,Err);
    if Ok then
      Msg:='Sintassi del nome OK!'
    else
      Msg:=Format('Sintassi del nome errata:'#13#10'%s',[Err]);
    Msg:=Format('%s'#13#10#13#10'Verificare i valori dei campi, ignorando il dato %s:'#13#10'%s',
                [Msg,VAR_FILLER,ElencoValori]);
    R180MessageBox(Msg,IfThen(Ok,INFORMA,ESCLAMA));
  end;
end;

procedure TA118FPubblicazioneDocumenti.DButtonStateChange(Sender: TObject);
begin
  inherited;
  dedtCodice.ReadOnly:=(DButton.State = dsEdit);
  btnScegliRoot.Enabled:=(DButton.State <> dsBrowse);
end;

procedure TA118FPubblicazioneDocumenti.dedtFiltroChange(Sender: TObject);
begin
  btnCheckFiltro.Enabled:=Trim(dedtFiltro.Text) <> '';
end;

procedure TA118FPubblicazioneDocumenti.dgrdCampiExit(Sender: TObject);
begin
  if dgrdCampi.DataSource.Dataset.State in [dsInsert,dsEdit] then
    dgrdCampi.DataSource.Dataset.Post;
end;

procedure TA118FPubblicazioneDocumenti.dgrdLivelliExit(Sender: TObject);
begin
  if dgrdLivelli.DataSource.Dataset.State in [dsInsert,dsEdit] then
    dgrdLivelli.DataSource.Dataset.Post;
end;

procedure TA118FPubblicazioneDocumenti.edtTestChange(Sender: TObject);
begin
  btnTest.Enabled:=Trim(edtTest.Text) <> '';
end;

function TA118FPubblicazioneDocumenti.TestImpostazioni(const PStr: String;
  var RElencoValori, RErrMsg: String): Boolean;
var
  Nome, Ext, Valore: String;
  Liv: Integer;
  IsLivelloFile: Boolean;
  LivObj: TLivello;
  A118MW: TA118FPubblicazioneDocumentiMW;
begin
  Result:=False;
  RErrMsg:='';
  RElencoValori:='';

  A118MW:=TA118FPubblicazioneDocumentiMW.Create(nil);
  try
    // aggiunge il livello alla struttura dati
    Liv:=A118FPubblicazioneDocumentiDtM.selI201.FieldByName('LIVELLO').AsInteger;
    IsLivelloFile:=not A118FPubblicazioneDocumentiDtM.selI201.FieldByName('EXT').IsNull;
    A118MW.AddLivello(Liv,
                      A118FPubblicazioneDocumentiDtM.selI201.FieldByName('NOME').AsString,
                      A118FPubblicazioneDocumentiDtM.selI201.FieldByName('EXT').AsString,
                      A118FPubblicazioneDocumentiDtM.selI201.FieldByName('SEPARATORE').AsString,
                      A118FPubblicazioneDocumentiDtM.selI201.FieldByName('FILTRO').AsString);

    // filtra la struttura dei campi sul livello attuale
    LivObj:=A118MW.Livello[0];
    A118FPubblicazioneDocumentiDtM.selI202.First;
    while not A118FPubblicazioneDocumentiDtM.selI202.Eof do
    begin
      Ext:=IfThen(IsLivelloFile,LivObj.ExtFile,'');
      LivObj.AddStrutturaCampo(A118FPubblicazioneDocumentiDtM.selI202.FieldByName('CAMPO').AsString,
                               A118FPubblicazioneDocumentiDtM.selI202.FieldByName('DAL').AsInteger,
                               A118FPubblicazioneDocumentiDtM.selI202.FieldByName('LUNG').AsInteger,
                               'N',Ext);
      A118FPubblicazioneDocumentiDtM.selI202.Next;
    end;
    A118FPubblicazioneDocumentiDtM.selI202.First;

    // salva il livello massimo delle directory
    if IsLivelloFile then
      A118MW.LivFile:=Liv
    else if Liv > A118MW.LivMaxDir then
      A118MW.LivMaxDir:=Liv;

    // verifica se il nome file rispecchia formalmente la struttura definita per il livello
    LivObj.NomeFile:=PStr;
    Result:=LivObj.MatchNome(ttFormale,RErrMsg);

    // visualizza i valori associati ai campi
    A118FPubblicazioneDocumentiDtM.selI202.DisableControls;
    A118FPubblicazioneDocumentiDtM.selI202.BeforePost:=nil;
    A118FPubblicazioneDocumentiDtM.selI202.First;
    while not A118FPubblicazioneDocumentiDtM.selI202.Eof do
    begin
      Nome:=A118FPubblicazioneDocumentiDtM.selI202.FieldByName('CAMPO').AsString.ToUpper;
      if A118MW.IsNomeVariabile(Nome) then
      begin
        Nome:=A118MW.RemovePrefissoVariabile(Nome);
        Valore:=LivObj.GetCampo(Nome).Valore;
      end
      else
        Valore:=Nome;
      RElencoValori:=RElencoValori + #13#10 + Format('%s = "%s"',[Nome,Valore]);
      A118FPubblicazioneDocumentiDtM.selI202.Next;
    end;
    // estensione
    if A118MW.LivFile > 0 then
    begin
      try
        RElencoValori:=RElencoValori + #13#10'---'#13#10 + Format('Estensione = "%s"',[LivObj.ExtFile]);
      except
      end;
    end;
    if RElencoValori <> '' then
      RElencoValori:=RElencoValori.Substring(Length(#13#10));
    A118FPubblicazioneDocumentiDtM.selI202.BeforePost:=A118FPubblicazioneDocumentiDtM.selI202BeforePost;
    A118FPubblicazioneDocumentiDtM.selI202.First;
    A118FPubblicazioneDocumentiDtM.selI202.EnableControls;
  finally
    FreeAndNil(A118MW);
  end;
end;

end.
