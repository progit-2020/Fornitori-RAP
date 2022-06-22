unit A146UFotoDipendente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, ExtCtrls, StdCtrls, Db, Oracle, OracleData,
  A000UInterfaccia, A000UCostanti, A000USessione, Jpeg, Math, ExtDlgs, Mask, DBCtrls;

const
  FORMWIDTH = 475;
  FORMHEIGHT = 150;  

type
  TA146FFotoDipendente = class(TForm)
    ImageList: TImageList;
    ToolBar1: TToolBar;
    btnModifica: TToolButton;
    btnApri: TToolButton;
    btnSalva: TToolButton;
    btnAnnulla: TToolButton;
    Panel1: TPanel;
    lblTitolo: TLabel;
    Image1: TImage;
    StatusBar: TStatusBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    btnCancella: TToolButton;
    OpenPictureDialog: TOpenPictureDialog;
    pnlDaPath: TPanel;
    rgpRisorsa: TRadioGroup;
    edtPercorso: TDBEdit;
    procedure btnModificaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnApriClick(Sender: TObject);
    procedure btnSalvaClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure btnCancellaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure rgpRisorsaClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    OS:TOracleSession;
    JpegImage: TJpegImage;
    procedure ZoomUno;
    procedure CaricaImmagine;
    procedure TestoStatus;
    procedure InModifica(Modifica: Boolean);
    procedure SetRadioGroup;    
    { Private declarations }
  public
    { Public declarations }
    Progressivo:Integer;
    Matricola,Cognome,Nome:String;
  end;

var
  A146FFotoDipendente: TA146FFotoDipendente;

procedure OpenA146FotoDipendente(PProgressivo:Integer; PMatricola,PCognome,PNome:String);

implementation

uses A146UFotoDipendenteDtM;
{$R *.dfm}

procedure OpenA146FotoDipendente(PProgressivo:Integer; PMatricola,PCognome,PNome:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA146FotoDipendente') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A146FFotoDipendente:=TA146FFotoDipendente.Create(nil);
  A146FFotoDipendenteDtM:=TA146FFotoDipendenteDtM.Create(nil);
  with A146FFotoDipendente do
  try
    Progressivo:=PProgressivo;
    Matricola:=PMatricola;
    Cognome:=PCognome;
    Nome:=PNome;
    ToolBar1.Enabled:=not SolaLettura;
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A146FFotoDipendenteDtM.Free;
    Free;
  end;
end;

procedure TA146FFotoDipendente.SetRadioGroup;
begin
  with A146FFotoDipendenteDtM do
    if (selT032.Active) and (selT032.RecordCount > 0) then
    begin
      if Not selT032.FieldByName('FOTO').IsNull then
        rgpRisorsa.ItemIndex:=0
      else
        rgpRisorsa.ItemIndex:=1;
    end
    else
      rgpRisorsa.ItemIndex:=1;
end;

procedure TA146FFotoDipendente.InModifica(Modifica: Boolean);
begin
  if Modifica then
  begin
    btnModifica.Enabled:=False;
    btnApri.Enabled:=True;
    btnSalva.Enabled:=True;
    btnAnnulla.Enabled:=True;
    btnCancella.Enabled:=False;
  end
  else
  begin
    btnModifica.Enabled:=True;
    btnApri.Enabled:=False;
    btnSalva.Enabled:=False;
    btnAnnulla.Enabled:=False;
    btnCancella.Enabled:=True;
  end;
  rgpRisorsa.Enabled:=Modifica;
  edtPercorso.Enabled:=Modifica and (rgpRisorsa.ItemIndex = 1);
  btnCancella.Enabled:=Not Modifica and (A146FFotoDipendenteDtM.selT032.RecordCount > 0)
end;

procedure TA146FFotoDipendente.rgpRisorsaClick(Sender: TObject);
begin
  edtPercorso.Enabled:=rgpRisorsa.Enabled and (rgpRisorsa.ItemIndex = 1);
  CaricaImmagine;
end;

procedure TA146FFotoDipendente.TestoStatus;
begin
  if Image1.Picture.Width + Image1.Picture.Height > 0 then
    StatusBar.Panels[0].Text:='Risoluzione foto: ' + IntToStr(Image1.Picture.Width) + 'x' + IntToStr(Image1.Picture.Height)
  else
    StatusBar.Panels[0].Text:='';
end;

procedure TA146FFotoDipendente.btnSalvaClick(Sender: TObject);
begin
  with A146FFotoDipendenteDtM do
  begin
    if rgpRisorsa.ItemIndex = 0 then
    begin
      A146FFotoDipendenteDtM.selT032FOTO.Assign(Image1.Picture.Graphic);
      A146FFotoDipendenteDtM.selT032FILE_FOTO.Clear;
    end
    else if rgpRisorsa.ItemIndex = 1 then
    begin
      if (selT032FILE_FOTO.isNull) then
        Image1.Picture.Assign(nil)
      else
        A146FFotoDipendenteDtM.selT032FOTO.Clear;
    end;
    if selT032FILE_FOTO.IsNull and selT032FOTO.IsNull then
      selT032.Cancel
    else
      selT032.Post;
    CaricaImmagine;  
    InModifica(False);
    SetRadioGroup;
  end;
end;

procedure TA146FFotoDipendente.btnModificaClick(Sender: TObject);
begin
  InModifica(True);
  with A146FFotoDipendenteDtm do
    if selT032.RecordCount > 0 then
      selT032.Edit
    else
    begin
      selT032.Insert;
      selT032.FieldByName('Progressivo').AsInteger:=Progressivo;      
    end;
end;

procedure TA146FFotoDipendente.btnAnnullaClick(Sender: TObject);
begin
  if A146FFotoDipendenteDtM.selT032.State in [dsEdit,dsInsert] then
    A146FFotoDipendenteDtM.selT032.Cancel;
  CaricaImmagine;
  InModifica(False);
  SetRadioGroup;
end;

procedure TA146FFotoDipendente.btnApriClick(Sender: TObject);
begin
  if OpenPictureDialog.Execute then
  begin
    Image1.Picture.LoadFromFile(OpenPictureDialog.FileName);
    if rgpRisorsa.ItemIndex = 1 then
      with A146FFotoDipendenteDtM do
      begin
        selT032PROGRESSIVO.AsInteger:=Progressivo;
        selT032FILE_FOTO.AsString:=OpenPictureDialog.FileName;
      end;
    TestoStatus;
    ZoomUno;
  end;
end;

procedure TA146FFotoDipendente.btnCancellaClick(Sender: TObject);
begin
  if A146FFotoDipendenteDtM.selT032.RecordCount > 0 then
    if MessageDlg('Eliminare la foto del dipendente?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      A146FFotoDipendenteDtM.selT032.Delete;
      Image1.Picture.Assign(NIL);
      Self.Width:=FORMWIDTH;
      Self.Height:=FORMHEIGHT;
      Self.Left:=Trunc((Screen.WorkAreaWidth / 2) - (Self.Width / 2));
      Self.Top:=Trunc((Screen.WorkAreaHeight / 2) - (Self.Height / 2));
      btnCancella.Enabled:=False;
      StatusBar.Panels[0].Text:='';
    end;
end;

procedure TA146FFotoDipendente.CaricaImmagine;
begin
  //provo ad aprire il blob come bitmap, se c'è un errore nel tipo di formato
  //allora provo ad aprirlo come jpeg in un oggetto tJpegImage e se l'apertura
  //riesce allora assegno tale immagine all'oggetto Image1.
  with A146FFotoDipendenteDtM do
  begin
    btnCancella.Enabled:=False;
    if A146FFotoDipendenteDtM.selT032.RecordCount > 0 then
    begin
      try
        if (rgpRisorsa.ItemIndex = 0) and (Not selT032.FieldByName('FOTO').IsNull) then
          Image1.Picture.Assign(selT032FOTO)
        else if (rgpRisorsa.ItemIndex = 1) and (Not selT032.FieldByName('FILE_FOTO').IsNull) then
        begin
          Image1.Picture.LoadFromFile(selT032FILE_FOTO.AsString);
          edtPercorso.Text:=selT032FILE_FOTO.AsString;
        end
        else
          Image1.Picture.Assign(nil);
        btnCancella.Enabled:=btnModifica.Enabled;
        TestoStatus;
      except
        try
          JpegImage:=TJpegImage.Create;
          if (rgpRisorsa.ItemIndex = 0) and (Not selT032.FieldByName('FOTO').IsNull) then
            JpegImage.Assign(A146FFotoDipendenteDtM.selT032FOTO)
          else if (rgpRisorsa.ItemIndex = 1) and (Not selT032.FieldByName('FILE_FOTO').IsNull) then
          begin
            Image1.Picture.LoadFromFile(selT032FILE_FOTO.AsString);
            edtPercorso.Text:=selT032FILE_FOTO.AsString;
          end
          else
            Image1.Picture.Assign(nil);
          Image1.Picture.Assign(JpegImage);
          btnCancella.Enabled:=btnModifica.Enabled;
          TestoStatus;
        finally
          JpegImage.Destroy;
        end;
      end;
    end;
    ZoomUno;
  end;
end;

procedure TA146FFotoDipendente.FormActivate(Sender: TObject);
begin
  (*
  //Le seguenti assegnazioni servono solamente per testare la form
  Nome:='Marco';
  Cognome:='Di Mitro';
  Progressivo:=150;
  Matricola:='46855';
  Progressivo:=22213;*)

  if Progressivo <= 0 then
  begin
    lblTitolo.Caption:='Non è stato selezionato nessun dipendente';
    ToolBar1.Enabled:=False;
  end
  else
  begin
    lblTitolo.Caption:=Matricola + '    ' + Cognome + ' ' + Nome;
    A146FFotoDipendenteDtm.selT032.SetVariable('PROGRESSIVO',Progressivo);
    OS:=TOracleSession.create(NIL);
    OS.LogonDatabase:=SessioneOracle.LogonDataBase;
    OS.LogonUsername:=SessioneOracle.LogonUsername;
    OS.LogonPassword:=SessioneOracle.LogonPassword;
    OS.Preferences.UseOCI7:=False;
    OS.Logon;
    A146FFotoDipendenteDtM.selT032.Session:=OS;
    A146FFotoDipendenteDtM.selT032.Open;

    SetRadioGroup;
    CaricaImmagine;
  end;
end;

procedure TA146FFotoDipendente.ZoomUno;
var FormW, FormH: Integer;
begin
  FormW:=Self.Width - Image1.Width;
  FormH:=Self.Height - Image1.Height;
  if (Screen.WorkAreaWidth < Image1.Picture.Width + FormW) OR (Screen.WorkAreaHeight < Image1.Picture.Height + FormH) then
  begin
    //immagine troppo grande per essere contenuta nello schermo
    Self.Width:=Max(Screen.WorkAreaWidth, FORMWIDTH);
    Self.Height:=Max(Screen.WorkAreaHeight, FORMHEIGHT);
  end
  else
  begin
    //immagine visualizzabile per intero
    Self.Width:=Max(Image1.Picture.Width + FormW, FORMWIDTH);
    Self.Height:=Max(Image1.Picture.Height + Abs(FormH), FORMHEIGHT);
  end;
  Self.Left:=Trunc((Screen.WorkAreaWidth / 2) - (Self.Width / 2));
  Self.Top:=Trunc((Screen.WorkAreaHeight / 2) - (Self.Height/ 2));
end;

procedure TA146FFotoDipendente.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:=btnModifica.Enabled or SolaLettura;
end;

procedure TA146FFotoDipendente.FormDestroy(Sender: TObject);
begin
  OS.Free;
end;

procedure TA146FFotoDipendente.FormResize(Sender: TObject);
begin
  edtPercorso.Width:=A146FFotoDipendente.Width - edtPercorso.Left -15;
end;

end.
