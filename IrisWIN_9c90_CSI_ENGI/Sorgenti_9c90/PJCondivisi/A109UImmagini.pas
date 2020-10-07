unit A109UImmagini;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, StdCtrls, Db, OracleData, Oracle, ExtDlgs, A000UCostanti, A000USessione, Variants,
  ComCtrls, ToolWin, ImgList, Jpeg, Math, A000UInterfaccia, C180FunzioniGenerali, A000UMessaggi,
  System.ImageList;

type
  TA109FImmagini = class(TForm)
    Image1: TImage;
    StatusBar: TStatusBar;
    ImageList: TImageList;
    OpenPictureDialog: TOpenPictureDialog;
    Panel2: TPanel;
    ToolBar1: TToolBar;
    btnModifica: TToolButton;
    ToolButton1: TToolButton;
    btnApri: TToolButton;
    btnSalva: TToolButton;
    btnAnnulla: TToolButton;
    ToolButton2: TToolButton;
    btnCancella: TToolButton;
    rbCartellino: TRadioButton;
    rbCartaServizi: TRadioButton;
    procedure btnModificaClick(Sender: TObject);
    procedure btnApriClick(Sender: TObject);
    procedure btnSalvaClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure btnCancellaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rbSceltaClick(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
  private
    { Private declarations }
    OS:TOracleSession;
    //JpegImage: TJpegImage;
    function  GetTipoImmagine: String;
    procedure ZoomUno;
    procedure CaricaImmagine;
    procedure TestoStatus;
    procedure InModifica(Modifica: Boolean);
  public
    { Public declarations }
  end;

var
  A109FImmagini: TA109FImmagini;

const
  WIDTH_NOIMAGE: Integer = 390;
  HEIGHT_NOIMAGE: Integer = 250;

procedure OpenA109Immagini;

implementation

uses A109UImmaginiDtM;

{$R *.DFM}

procedure OpenA109Immagini;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA109Immagini') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A109FImmagini:=TA109FImmagini.Create(nil);
  A109FImmaginiDtM:=TA109FImmaginiDtM.Create(nil);
  with A109FImmagini do
  try
    ToolBar1.Enabled:=not SolaLettura;
    Width:=WIDTH_NOIMAGE;
    Height:=HEIGHT_NOIMAGE;
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A109FImmaginiDtM.Free;
    Free;
  end;
end;

procedure TA109FImmagini.InModifica(Modifica: Boolean);
begin
  rbCartellino.Enabled:=not Modifica;
  rbCartaServizi.Enabled:=not Modifica;
  btnModifica.Enabled:=not Modifica;
  btnApri.Enabled:=Modifica;
  btnSalva.Enabled:=Modifica;
  btnAnnulla.Enabled:=Modifica;
  if Modifica then
    btnCancella.Enabled:=False
  else
    try
      btnCancella.Enabled:=(not Image1.Picture.Graphic.Empty);
    except
      btnCancella.Enabled:=False;
    end;
end;

procedure TA109FImmagini.rbSceltaClick(Sender: TObject);
{ Carica l'immagine corrispondente al tipo selezionato }
begin
  CaricaImmagine;
end;

procedure TA109FImmagini.TestoStatus;
{ Imposta il testo della statusbar }
begin
  try
    if Image1.Picture.Graphic.Empty then
      StatusBar.Panels[0].Text:='Nessuna immagine'
    else
    begin
      if Image1.Picture.Width + Image1.Picture.Height > 0 then
        StatusBar.Panels[0].Text:='Risoluzione immagine: ' + IntToStr(Image1.Picture.Width) + ' x ' + IntToStr(Image1.Picture.Height)
      else
        StatusBar.Panels[0].Text:='';
    end;
    StatusBar.Repaint;
  except
    StatusBar.Panels[0].Text:='Nessuna immagine';
    StatusBar.Repaint;
  end;
end;

function TA109FImmagini.GetTipoImmagine: String;
{ Determina il codice del tipo immagine in base al radiobutton selezionato }
begin
  Result:='';
  if rbCartellino.Checked then
    Result:='CARTELLINO'
  else if rbCartaServizi.Checked then
    Result:='CARTASERV';
end;

procedure TA109FImmagini.btnSalvaClick(Sender: TObject);
{ Salva l'immagine selezionata }
var
  TipoImg: String;
begin
  TipoImg:=GetTipoImmagine;
  
  with A109FImmaginiDtM.A109MW.selT004 do
  begin
    if SearchRecord('TIPO',TipoImg,[srFromBeginning]) then
      Delete;
    Append;
    FieldByName('TIPO').AsString:=TipoImg;
    A109FImmaginiDtM.A109MW.selT004IMMAGINE.Assign(Image1.Picture.Graphic);
    Post;
  end;
  InModifica(False);
end;

procedure TA109FImmagini.btnModificaClick(Sender: TObject);
begin
  InModifica(True);
end;

procedure TA109FImmagini.btnAnnullaClick(Sender: TObject);
begin
  CaricaImmagine;
  InModifica(False);
end;

procedure TA109FImmagini.btnApriClick(Sender: TObject);
{ Apre la finestra di dialogo di selezione dell'immagine }
var
  Tipo: String;
begin
  if rbCartellino.Checked then
    Tipo:=rbCartellino.Caption
  else if rbCartaServizi.Checked then
    Tipo:=rbCartaServizi.Caption;

  OpenPictureDialog.Title:='Seleziona immagine per ' +  LowerCase(Tipo);
  if OpenPictureDialog.Execute then
  begin
    try
      // Massimo 12/04/2013 forzato controllo sull'estensione per evitare upload di file
      // con estensione non valida
      if Pos('.BMP',UpperCase(OpenPictureDialog.FileName)) = 0 then
      begin
        R180MessageBox(A000MSG_A109_MSG_IMMAGINE_NON_VALIDA, ESCLAMA);
        Exit;
      end;
      Image1.Picture.LoadFromFile(OpenPictureDialog.FileName);
      TestoStatus;
      ZoomUno;
    except
      // niente jpg, perché non viene visualizzato correttamente
      R180MessageBox(A000MSG_A109_MSG_IMMAGINE_NON_VALIDA, ESCLAMA);
      Image1.Picture.Assign(nil);
      TestoStatus;
      Exit;
    end;
  end;
end;

procedure TA109FImmagini.btnCancellaClick(Sender: TObject);
{ Elimina l'associazione all'immagine corrente }
var
  TipoImg: String;
begin
  if A109FImmaginiDtM.A109MW.selT004.RecordCount > 0 then
    if R180MessageBox(A000MSG_A109_MSG_ELIMINA_IMG,DOMANDA) = mrYes then
    begin
      TipoImg:=GetTipoImmagine;

      if A109FImmaginiDtM.A109MW.selT004.SearchRecord('TIPO',TipoImg,[srFromBeginning]) then
       A109FImmaginiDtM.A109MW.selT004.Delete;
      Image1.Picture.Assign(nil);
      Self.Width:=WIDTH_NOIMAGE; // 170;
      Self.Height:=HEIGHT_NOIMAGE; //130;
      Self.Left:=Trunc((Screen.WorkAreaWidth / 2) - (Self.Width / 2));
      Self.Top:=Trunc((Screen.WorkAreaHeight / 2) - (Self.Height/ 2));
      btnCancella.Enabled:=False;
      TestoStatus;
    end;
end;

procedure TA109FImmagini.CaricaImmagine;
{ carica l'immagine nel controllo a video }
var
  TipoImg: String;
begin
  // provo ad aprire il blob come bitmap
  // errore se formato non è bitmap
  TipoImg:=GetTipoImmagine;

  if A109FImmaginiDtM.A109MW.selT004.SearchRecord('TIPO',TipoImg,[srFromBeginning]) then
  begin
    btnCancella.Enabled:=False;
    try
      Image1.Picture.Assign(A109FImmaginiDtM.A109MW.selT004IMMAGINE);
      btnCancella.Enabled:=True;
      TestoStatus;
    except
      // niente jpg, perché non viene visualizzato correttamente
      R180MessageBox(A000MSG_A109_MSG_IMMAGINE_NON_VALIDA, ESCLAMA);
      Image1.Picture.Assign(nil);
      TestoStatus;
      Exit;
    end;
    ZoomUno;
  end
  else
  begin
    Image1.Picture.Assign(nil);
    Self.Width:=WIDTH_NOIMAGE; //220;
    Self.Height:=HEIGHT_NOIMAGE; //130;
    Self.Left:=Trunc((Screen.WorkAreaWidth / 2) - (Self.Width / 2));
    Self.Top:=Trunc((Screen.WorkAreaHeight / 2) - (Self.Height/ 2));
    btnCancella.Enabled:=False;
    TestoStatus;
  end;
end;

procedure TA109FImmagini.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  Resize:=(NewWidth >= WIDTH_NOIMAGE);
end;

procedure TA109FImmagini.FormShow(Sender: TObject);
begin
  OS:=TOracleSession.create(NIL);
  OS.LogonDatabase:=SessioneOracle.LogonDataBase;
  OS.LogonUsername:=SessioneOracle.LogonUsername;
  OS.LogonPassword:=SessioneOracle.LogonPassword;
  OS.LogonDatabase:=SessioneOracle.LogonDataBase;
  OS.Preferences.UseOCI7:=False;
  OS.Logon;
  A109FImmaginiDtM.A109MW.selT004.Session:=OS;
  A109FImmaginiDtM.A109MW.selT004.Open;

  rbCartellino.OnClick:=nil;
  rbCartellino.Checked:=True;
  CaricaImmagine;
  rbCartellino.OnClick:=rbSceltaClick;
end;

procedure TA109FImmagini.FormDestroy(Sender: TObject);
begin
  A109FImmaginiDtM.A109MW.selT004.Close;
  OS.Free;
end;

procedure TA109FImmagini.ZoomUno;
var FormW, FormH: Integer;
begin
  FormW:=Self.Width - Image1.Width;
  FormH:=Self.Height - Image1.Height;
  if (Screen.WorkAreaWidth < Image1.Picture.Width + FormW) OR (Screen.WorkAreaHeight < Image1.Picture.Height + FormH) then
  begin
    //immagine troppo grande per essere contenuta nello schermo
    Self.Width:=Max(Screen.WorkAreaWidth, WIDTH_NOIMAGE {220});
    Self.Height:=Max(Screen.WorkAreaHeight, HEIGHT_NOIMAGE {100});
  end
  else
  begin
    //immagine visualizzabile per intero
    Self.Width:=Max(Image1.Picture.Width + FormW, WIDTH_NOIMAGE {220});
    Self.Height:=Max(Image1.Picture.Height + FormH, HEIGHT_NOIMAGE {100});
  end;
  Self.Left:=Trunc((Screen.WorkAreaWidth / 2) - (Self.Width / 2));
  Self.Top:=Trunc((Screen.WorkAreaHeight / 2) - (Self.Height/ 2));
end;

end.
