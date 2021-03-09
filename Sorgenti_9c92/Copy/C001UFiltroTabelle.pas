unit C001UFiltroTabelle;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DB, DBGrids, ExtCtrls, Menus,
  A000UInterfaccia, A000UCostanti, A000USessione, ComCtrls, SelAnagrafe, C180FunzioniGenerali, Variants;

type
  TC001FFiltroTabelle = class(TForm)
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    BtnResettaIntervalli: TButton;
    BtnResettaOrdinamenti: TButton;
    btnOrdineCampiOld: TSpeedButton;
    BitBtnOK: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtnCarica: TBitBtn;
    BitBtnSalva: TBitBtn;
    MainMenu1: TMainMenu;
    Impostazionidistampa1: TMenuItem;
    Carica1: TMenuItem;
    Salva1: TMenuItem;
    StatusBar: TStatusBar;
    frmSelAnagrafe: TfrmSelAnagrafe;
    btnOrdineCampi: TBitBtn;
    btnStampa: TSpeedButton;
    btnStampante: TSpeedButton;
    PrintDialog1: TPrintDialog;
    procedure btnOrdineCampiOldClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1ColEnter(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnResettaIntervalliClick(Sender: TObject);
    procedure BtnResettaOrdinamentiClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Carica1Click(Sender: TObject);
    procedure BitBtnCaricaClick(Sender: TObject);
    procedure Salva1Click(Sender: TObject);
    procedure BitBtnSalvaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnEreditaSelezioneClick(Sender: TObject);
    procedure btnStampaClick(Sender: TObject);
    procedure btnStampanteClick(Sender: TObject);
  private
    { Private declarations }
    VarFont:TFont;
    procedure LeggiListaSettaggi;
    procedure SalvaSettaggiCampi;
    procedure GestisciOrdineCampi;
    Procedure GetFormatCurr(Field:TField);
  public
    { Public declarations }
    colonna,cicli:integer;
    Ordinamento:Boolean;
    VariazioneCampi:Boolean;
    DefaultFont:TFont;
    UpDateGrid,QueryState:boolean;
    IntestazioneQR,From_Sql,Where_Sql,Order_Sql:String;
    TipoDB:TDataBaseDrv;
    DataLavoro:TDateTime;
    procedure SettaCodInt(Value:String);
    procedure updatesql;
    procedure inizializzaScegliCampi;
    procedure AssegnaIntestazione;
    procedure OrdinaListaCampi;
    function EliminaSpaziInutili(Testo :String):String;
  end;

var
  NomeForm:String;
  C001FFiltroTabelle: TC001FFiltroTabelle;
procedure C001SetNomeForm(Value:String);
function C001GetNomeForm:String;

implementation

uses C001UFiltroTabelleDTM, C001UScegliCampi, C001UStampa,C001ULayoutStampa,
     C001USettings,C001USaveSettings,A002UInterfacciaSt, C001StampaLib,
     C001ULineSettings,C001UGroupSelection, C700USelezioneAnagrafe;

{$R *.DFM}

procedure C001SetNomeForm(Value:String);
begin
  NomeForm:=copy(Value,1,pos('F',Value)-1);
end;

function C001GetNomeForm:String;
begin
  Result:=NomeForm;
end;

procedure TC001FFiltroTabelle.FormCreate(Sender: TObject);
var I:Integer;
begin
  StampaAnagrafico:=False;
  StampaAnagraficoMisto:=False;
  for I:=1 to High(VettStampa) do
  begin
    VettStampa[I].Banda:=bNone;
    VettStampa[I].Caption:='';
    VettStampa[I].DField:='';
    VettStampa[I].DSource:=nil;
    VettStampa[I].ElencoBanda:=bNone;
    VettStampa[I].ElencoX:=0;
    VettStampa[I].ElencoY:=0;
    VettStampa[I].Font:=nil;
    VettStampa[I].Gruppo:=False;
    VettStampa[I].GruppoBanda:=bNone;
    VettStampa[I].GruppoX:=0;
    VettStampa[I].GruppoY:=0;
    VettStampa[I].Height:=0;
    VettStampa[I].Left:=0;
    VettStampa[I].NomeOggetto:='';
    VettStampa[I].NumeroBandaGruppo:=0;
    VettStampa[I].SchedaBanda:=bNone;
    VettStampa[I].SchedaX:=0;
    VettStampa[I].SchedaY:=0;
    VettStampa[I].SelGruppo:=False;
    VettStampa[I].Tipo:=QRIntestazione;
    VettStampa[I].Top:=0;
    VettStampa[I].Trasp:=False;
    VettStampa[I].Width:=0;
  end;
  CODINT:=C001GetNomeForm;
  ConfigAttiva:='';
// inizializzo variabili globali
  TitoloStampa:='Stampa ' + TitoloR001;
  VariazioneCampi:=True;
  TipoGruppo:=0;
  PagineSeparate:=False;
  RiassegnaBandeGruppo:=True;
//Ricordarsi di aggiungere un blocco try
  try
    CreaListaCampi;
    CreaListaSettaggi;
    VarFont:=TFont.Create;
    DefaultFont:=TFont.Create;
    for I:=1 to 10 do
    begin
      OldFontGruppo[I]:=TFont.Create;
      FontGruppo[I]:=TFont.Create;
    end;
  except
    ShowMessage('Errore di memoria. Il programma sarà terminato');
    Close;
  end;
  QueryState:=True;
  Modalita:=Elenco;
end;

procedure TC001FFiltroTabelle.FormShow(Sender: TObject);
begin
  frmSelAnagrafe.Visible:=StampaAnagrafico or StampaAnagraficoMisto;
  DBGrid1.DataSource:=C001FFiltroTabelleDTM.DataSource1;
end;

procedure TC001FFiltroTabelle.FormActivate(Sender: TObject);
begin
  C001FFiltroTabelleDTM.Inizializzazione;
  AssegnaIntestazione;
  if DBGrid1.SelectedField = nil then
    Colonna:=0
  else
    Colonna:=DBGrid1.SelectedIndex;
end;

// Tolgo gli spazi inutili all' interno della stringa.
function TC001FFiltroTabelle.EliminaSpaziInutili(Testo :String):String;
var I:Integer;
begin
  Testo:=Trim(Testo);
  //for I:=1 to Length(Testo) - 1 do
  I:=1;
  while I <= Length(Testo) - 1 do
  begin
    if (Testo[I] = ' ')and(Testo[I+1] = ' ') then
      Delete(Testo,I,1);
    inc(I);  
  end;
  Result:=Testo;
end;

procedure TC001FFiltroTabelle.GestisciOrdineCampi;
begin
  InizializzaScegliCampi;
  if querystate then
    UpdateSql;
  AssegnaIntestazione;
  //btnOrdineCampi.Down:=false;
  DBGrid1.SelectedIndex:=0;
  Colonna:=0;
end;

procedure TC001FFiltroTabelle.SettaCodInt(Value:String);
begin
  CODINT:=Value;
end;

procedure TC001FFiltroTabelle.btnStampaClick(Sender: TObject);
begin
  C001FStampa:=TC001FStampa.Create(nil);
  C001FLineSettings:=TC001FLineSettings.Create(nil);
  C001FGroupSelection:=TC001FGroupSelection.Create(nil);
  C001FLayoutStampa:=TC001FLayoutStampa.Create(nil);
  C001SettaQuickReport(C001FStampa.QRep);
  InizializzaLineeDiTratteggio;
  with C001FLayoutStampa do
  try
    C001FStampa.QrLblTitolo.Caption:=TitoloStampa;
    C001FLayoutStampa.ETitolo.Text:=TitoloStampa;
    C001FStampa.QrLblIntestazione.Caption:=IntestazioneQR;
    C001FLayoutStampa.FormShow(Self);    
    C001FLayoutStampa.BtnStampaClick(Self);
  finally
    Free;
    C001FStampa.Free;
    C001FLineSettings.Free;
    C001FGroupSelection.Free;
  end;
end;

procedure TC001FFiltroTabelle.btnStampanteClick(Sender: TObject);
begin
  PrintDialog1.Execute;
end;

procedure TC001FFiltroTabelle.SalvaSettaggiCampi;
var I:Integer;
    S:String;
begin
  // salvo tutti i campi del dataset, con le relative proprietà.
  EliminaElementi(CAMPOTAB);
  for I:=0 to ListaCampi.Count - 1 do
  begin
    RecCampi:=ListaCampi[I];
    S:=CAMPOTAB+';' + RecCampi.Nome;
    if RecCampi.Selezionato then
     S:= S + ';S'    // campo non selezionato
    else
     S:= S + ';N';   // campo selezionato
    if RecCampi.Da = '' then
     S:=S + ';%%%'   //  intervallo campo
    else
     S:=S + ';'+ RecCampi.da;  //  intervallo campo
    if RecCampi.A = '' then
     S:=S + ';%%%'   //  intervallo campo
    else
     S:=S + ';'+ RecCampi.a;  //  intervallo campo
    if RecCampi.Ordinato then
     if RecCampi.Ascendente then
       S:=S + ';OA'    // ordinamento Ascendente
     else
       S:=S + ';OD'    // ordinamento Discendente
    else
     S:=S + ';NO';      // non ordinato
    if RecCampi.Gruppo then
     S:=S + ';S'
    else
     S:=S + ';N';
    if RecCampi.SelGruppo then
     S:=S + ';S'
    else
     S:=S + ';N';
    S:=S + ';' + inttostr(RecCampi.NumBanda);  // numero banda di gruppo
    S:=S + ';' + inttostr(RecCampi.Posi);  // posiz. all' interno della banda di gruppo
    S:=S + ';' + RecCampi.Intestazione; // intestazione
    S:=S + ';' + inttostr(RecCampi.Posizione)+';'; // posizione
    ListaSettaggi.Add(S);
  end;
end;

procedure TC001FFiltroTabelle.LeggiListaSettaggi;
var I,J,IND,AppInt,Code:Integer;
    App,TipoStr,Campo,AppTitolo:String;
    NumOggetti,NumComp,NumeroBanda:Integer;
begin
  DistruggiListaCampi;
  CreaListaCampi;
  NumOggetti:=0;
  NCAMPI:=0;
  NOGGETTI:=0;
  NumeroBanda:=0;
  for I:=0 to ListaSettaggi.Count - 1 do
     begin
       TipoStr:=copy(ListaSettaggi[I],1,2);
       if TipoStr = (FONTBGRUPPO) then
         begin
           J:=1;
           inc(NumeroBanda,1);
           App:=copy(ListaSettaggi[I],4,Length(ListaSettaggi[I]));
           IND:=0;
           while (J <= Length(App)) do
             begin
               Campo:='';
               while (J <= Length(App))and(App[J] <> ';') do
                 begin
                   Campo:=Campo + App[J];
                   inc(J);
                 end;
               inc(J);
               inc(IND);
               case Ind of
                 1 :begin
                      Val(Campo,AppInt,Code);                   // Font.Color
                      if (Code = 0) then
                        try
                         FontGruppo[NumeroBanda].Color:=AppInt;
                        except
                         ;
                        end;
                    end;
                 2 :begin
                      Val(Campo,AppInt,Code);                   // Font.Height
                      if (Code = 0) then
                        FontGruppo[NumeroBanda].Height:=AppInt;
                    end;
                 3 :begin
                      Val(Campo,AppInt,Code);                   // Font.Size
                      if (Code = 0) then
                        FontGruppo[NumeroBanda].Size:=AppInt;
                    end;
                 4 :begin
                      FontGruppo[NumeroBanda].Name:=Campo;
                    end;
                 5 :begin
                      Val(Campo,AppInt,Code);                   // Font.Pitch
                      if Code = 0 then
                        try
                         FontGruppo[NumeroBanda].Pitch:=TFontPitch(AppInt);
                        except
                         ;
                        end;
                    end;
                 6 :begin
                      FontGruppo[NumeroBanda].Style:=StringToFontStyle(Campo);
                    end;
               end;
             end;
         end
       else
       if TipoStr = (CPAGINESEP) then
         begin
           J:=1;
           App:=copy(ListaSettaggi[I],4,Length(ListaSettaggi[I])-2);
           Campo:='';
           while (J <= Length(App))and(App[J] <> ';') do
             begin
               Campo:=Campo + App[J];
               inc(J);
             end;
           PagineSeparate:=(Campo = 'S');              // Pagine Separate
         end
       else

       if TipoStr = (NUMBANDEGRUPPO) then
         begin
           J:=1;
           App:=copy(ListaSettaggi[I],4,Length(ListaSettaggi[I])-2);
           Campo:='';
           while (J <= Length(App))and(App[J] <> ';') do
             begin
               Campo:=Campo + App[J];
               inc(J);
             end;
           Val(Campo,AppInt,Code);              // Tipo di gruppo
           if (Code = 0) then
               TipoGruppo:=AppInt;
         end
       else
       if TipoStr = (CBANDAAB) then
         begin
           J:=1;
           App:=copy(ListaSettaggi[I],4,Length(ListaSettaggi[I]));
           IND:=0;
           while (J <= Length(App)) do
             begin
               Campo:='';
               while (J <= Length(App))and(App[J] <> ';') do
                 begin
                   Campo:=Campo + App[J];
                   inc(J);
                 end;
               inc(J);
               inc(IND);
               case Ind of
                 1:InterLineaAbilitata:=(Campo = 'S');
                 2:begin
                       Val(Campo,AppInt,Code);    //   Altezza interlinea
                       if (Code = 0) then
                         AltezzaInterLinea:=AppInt;
                     end
               end
             end
         end
       else
       if (TipoStr = CLINEAREC)or(TipoStr = CLINEAINF)or(TipoStr = CLINEASUP) then
         begin
           J:=1;
           App:=copy(ListaSettaggi[I],4,Length(ListaSettaggi[I]));
           IND:=0;
           while (J <= Length(App)) do
             begin
               Campo:='';
               while (J <= Length(App))and(App[J] <> ';') do
                 begin
                   Campo:=Campo + App[J];
                   inc(J);
                 end;
               inc(J);
               inc(IND);
               case Ind of
                 1 :begin
                      Val(Campo,AppInt,Code);              // LineaRec.Altezza
                      if (Code = 0) then
                        begin
                          if TipoStr = CLINEAREC then
                            LineaRec.Altezza:=AppInt
                          else
                            if TipoStr = CLINEAINF then
                              LineaInf.Altezza:=AppInt
                            else
                              if TipoStr = CLINEASUP then
                                LineaSup.Altezza:=AppInt
                        end;
                    end;
                 2 :begin
                      Val(Campo,AppInt,Code);              // LineaRec.Larghezza
                      if (Code = 0) then
                        begin
                          if TipoStr = CLINEAREC then
                            LineaRec.Larghezza:=AppInt
                          else
                            if TipoStr = CLINEAINF then
                              LineaInf.Larghezza:=AppInt
                            else
                              if TipoStr = CLINEASUP then
                                LineaSup.Larghezza:=AppInt
                        end;
                    end;
                 3 :begin
                      Val(Campo,AppInt,Code);              // LineaRec.Allineamento
                      if (Code = 0) then
                        begin
                          if TipoStr = CLINEAREC then
                            LineaRec.Allineamento:=AppInt
                          else
                            if TipoStr = CLINEAINF then
                              LineaInf.Allineamento:=AppInt
                            else
                              if TipoStr = CLINEASUP then
                                LineaSup.Allineamento:=AppInt
                        end;
                    end;
                 4 :begin
                      Val(Campo,AppInt,Code);              // LineaRec.Tratteggio
                      if (Code = 0) then
                        begin
                          if TipoStr = CLINEAREC then
                            LineaRec.Tratteggio:=AppInt
                          else
                            if TipoStr = CLINEAINF then
                              LineaInf.Tratteggio:=AppInt
                            else
                              if TipoStr = CLINEASUP then
                                LineaSup.Tratteggio:=AppInt
                        end;
                    end;
                 5 :begin
                      if TipoStr = CLINEAREC then  // LineaRec.Enabled
                        LineaRec.Enabled:=(Campo = 'S')
                      else
                        if TipoStr = CLINEAINF then
                          LineaInf.Enabled:=(Campo = 'S')
                        else
                          if TipoStr = CLINEASUP then
                            LineaSup.Enabled:=(Campo = 'S');
                    end;
               end;
             end;
         end
       else
       if TipoStr = FONTDEF then
         begin
           J:=1;
           App:=copy(ListaSettaggi[I],4,Length(ListaSettaggi[I]));
           IND:=0;
           while (J <= Length(App)) do
             begin
               Campo:='';
               while (J <= Length(App))and(App[J] <> ';') do
                 begin
                   Campo:=Campo + App[J];
                   inc(J);
                 end;
               inc(J);
               inc(IND);
               case Ind of
                 1 :begin
                      Val(Campo,AppInt,Code);                   // Font.Color
                      if (Code = 0) then
                        try
                         DefaultFont.Color:=AppInt;
                        except
                         ;
                        end;
                    end;
                 2 :begin
                      Val(Campo,AppInt,Code);                   // Font.Height
                      if (Code = 0) then
                        DefaultFont.Height:=AppInt;
                    end;
                 3 :begin
                      Val(Campo,AppInt,Code);                   // Font.Size
                      if (Code = 0) then
                        DefaultFont.Size:=AppInt;
                    end;
                 4 :begin
                      DefaultFont.Name:=Campo;
                    end;
                 5 :begin
                      Val(Campo,AppInt,Code);                   // Font.Pitch
                      if Code = 0 then
                        try
                         DefaultFont.Pitch:=TFontPitch(AppInt);
                        except
                         ;
                        end;
                    end;
                 6 :begin
                      DefaultFont.Style:=StringToFontStyle(Campo);
                    end;
               end;
             end;
         end
       else
       if TipoStr = PARANAG then
         begin
           AppTitolo:=copy(ListaSettaggi[I],4,Length(ListaSettaggi[I]));
           Where_Sql:=copy(ListaSettaggi[I],4,pos(';',AppTitolo)-1);
           DividiWhereSql(Where_Sql,Where_Sql,Order_Sql);
         end
       else
       if TipoStr = CONSTSTAMPA then
         begin
           AppTitolo:=copy(ListaSettaggi[I],4,Length(ListaSettaggi[I]));
           TitoloStampa:=copy(ListaSettaggi[I],4,pos(';',AppTitolo)-1);
         end
       else
         if TipoStr = OGGETTO then
           begin
             J:=1;
             inc(NOggetti);
             inc(NumOggetti);
             App:=copy(ListaSettaggi[I],4,Length(ListaSettaggi[I]));
             IND:=0;
             //while (J <= Length(ListaSettaggi[I])) do
             while (J <= Length(App)) do
               begin
                 Campo:='';
                 //while (J <= Length(ListaSettaggi[I]))and(App[J] <> ';') do
                 while (J <= Length(App))and(App[J] <> ';') do
                   begin
                     Campo:=Campo + App[J];
                     inc(J);
                   end;
                 inc(J);
                 inc(IND);
                 case Ind of
                    1:begin
                          VettStampa[NumOggetti].NomeOggetto:=Campo; // nome oggetto
                        end;
                    2:begin
                          if Campo = 'QRLabel' then           // tipo oggetto
                            VettStampa[NumOggetti].Tipo:=(QRIntestazione)
                          else
                            if Campo = 'QRDBText' then
                              VettStampa[NumOggetti].Tipo:=(QRCampo);
                        end;
                    3:begin
                          VettStampa[NumOggetti].Caption:=Campo;    // caption
                        end;
                    4:begin
                          try
                            for NumComp:=0 to C001FFiltroTabelleDtM.ComponentCount - 1 do
                              if C001FFiltroTabelleDtM.Components[NumComp] is TDataSource then
                                if (C001FFiltroTabelleDtM.Components[NumComp] as TDataSource).Name = Campo then
                                  begin
                                  VettStampa[NumOggetti].DSource:=(C001FFiltroTabelleDtM.Components[NumComp] as TDataSource); // DSource
                                  Break;
                                  end;
                          except
                           ;
                          end;
                        end;
                    5:begin
                          try
                           VettStampa[NumOggetti].DField:=Campo; // DField
                          except
                          end;
                        end;
                    6:begin
                          if Campo = 'bNone' then             // Banda
                            VettStampa[NumOggetti].Banda:=(bNone)
                          else
                            if Campo = 'bDettaglio' then
                              VettStampa[NumOggetti].Banda:=(bDettaglio)
                            else
                              if Campo = 'bIntestazione' then
                                VettStampa[NumOggetti].Banda:=(bIntestazione)
                              else
                                if Campo = 'bGruppo' then
                                  VettStampa[NumOggetti].Banda:=(bGruppo);
                        end;
                    7:begin
                          Val(Campo,AppInt,Code);                    // Height
                          if Code = 0 then
                            VettStampa[NumOggetti].Height:=AppInt;
                        end;
                    8:begin
                          Val(Campo,AppInt,Code);                    // Width
                          if Code = 0 then
                            VettStampa[NumOggetti].Width:=AppInt;
                        end;
                    9:begin
                          Val(Campo,AppInt,Code);                    // Left
                          if Code = 0 then
                            VettStampa[NumOggetti].Left:=AppInt;
                        end;
                    10:begin
                          Val(Campo,AppInt,Code);                   // Top
                          if Code = 0 then
                            VettStampa[NumOggetti].Top:=AppInt;
                        end;
                    11:begin
                          Val(Campo,AppInt,Code);                   // Font.Color
                          if (Code = 0) then
                            try
                             VarFont.Color:=AppInt;
                             VettStampa[NumOggetti].Font:=VarFont;
                             //VettStampa[NumOggetti].Font.Color:=AppInt;
                            except
                             ;
                            end;
                        end;
                    12:begin
                          Val(Campo,AppInt,Code);                   // Font.Height
                          if (Code = 0) then
                            begin
                              VarFont.Height:=AppInt;
                              VettStampa[NumOggetti].Font:=VarFont;
                            end;
                            //VettStampa[NumOggetti].Font.Height:=AppInt;
                        end;
                    13:begin
                          Val(Campo,AppInt,Code);                   // Font.Size
                          if (Code = 0) then
                            begin
                              VarFont.Size:=AppInt;
                              VettStampa[NumOggetti].Font:=VarFont;
                            end;
                        end;
                    14:begin
                           VarFont.Name:=Campo;
                           VettStampa[NumOggetti].Font:=VarFont;
                        end;
                    15:begin
                          Val(Campo,AppInt,Code);                   // Font.Pitch
                          if Code = 0 then
                            try
                             VarFont.Pitch:=TFontPitch(AppInt);
                             VettStampa[NumOggetti].Font:=VarFont;
                            except
                             ;
                            end;
                        end;
                    16:begin
                           VettStampa[NumOggetti].Font.Style:=StringToFontStyle(Campo);
                        end;
                    17:begin
                          Val(Campo,AppInt,Code);                   // Color
                          if (Code = 0) then
                            try
                             VettStampa[NumOggetti].Color:=AppInt;
                            except
                             ;
                            end;
                        end;
                    18:begin
                          if Campo = 'S' then
                            VettStampa[NumOggetti].Trasp:=True    // Transparent
                          else
                            VettStampa[NumOggetti].Trasp:=False
                        end;
                    19:begin
                          Val(Campo,AppInt,Code);                   // elencoX
                          if Code = 0 then
                            VettStampa[NumOggetti].ElencoX:=AppInt;
                        end;
                    20:begin
                          Val(Campo,AppInt,Code);                   // elenco Y
                          if Code = 0 then
                            VettStampa[NumOggetti].ElencoY:=AppInt;
                        end;
                    21:begin
                          Val(Campo,AppInt,Code);                   // Scheda X
                          if Code = 0 then
                            VettStampa[NumOggetti].SchedaX:=AppInt;
                        end;
                    22:begin
                          Val(Campo,AppInt,Code);                   // Scheda Y
                          if Code = 0 then
                            VettStampa[NumOggetti].SchedaY:=AppInt;
                        end;
                    23:begin
                          if Campo = 'bNone' then             // Elenco Banda
                            VettStampa[NumOggetti].ElencoBanda:=(bNone)
                          else
                            if Campo = 'bDettaglio' then
                              VettStampa[NumOggetti].ElencoBanda:=(bDettaglio)
                            else
                              if Campo = 'bIntestazione' then
                                VettStampa[NumOggetti].ElencoBanda:=(bIntestazione);
                        end;
                    24:begin
                          if Campo = 'bNone' then             // Scheda Banda
                            VettStampa[NumOggetti].SchedaBanda:=(bNone)
                          else
                            begin
                              if Campo = 'bDettaglio' then
                                VettStampa[NumOggetti].SchedaBanda:=(bDettaglio)
                              else
                                begin
                                  if Campo = 'bIntestazione' then
                                    VettStampa[NumOggetti].SchedaBanda:=(bIntestazione);
                                end
                            end;
                         end;
                    25:begin
                           VettStampa[NumOggetti].Gruppo:=(Campo = 'S');
                         end;
                    26:begin
                           VettStampa[NumOggetti].SelGruppo:=(Campo = 'S');
                         end;
                    27:begin
                           Val(Campo,AppInt,Code);       // Numero banda di gruppo.
                           if Code = 0 then
                              VettStampa[NumOggetti].NumeroBandaGruppo:=AppInt;
                         end;
                 end;
               end;
           end
         else
           if TipoStr = CAMPOTAB then
           begin
             RecCampi:=TRec_Campi.Create;
             inc(NCampi);
             J:=1;
             App:=copy(ListaSettaggi[I],4,Length(ListaSettaggi[I]));
             IND:=0;
             //while (J <= Length(ListaSettaggi[I])) do
             while (J <= Length(App)) do
               begin
                 Campo:='';
                 //while (J <= Length(ListaSettaggi[I]))and(App[J] <> ';') do
                 while (J <= Length(App))and(App[J] <> ';') do
                   begin
                     Campo:=Campo + App[J];
                     inc(J);
                   end;
                 inc(J);
                 inc(IND);
                 case Ind of
                    1:RecCampi.Nome:=Campo;
                    2:begin
                          RecCampi.Selezionato:=(Campo = 'S');
                          RecCampi.OldSelezionato:=(Campo = 'S');
                        end;
                    3:begin
                          if Campo <> '%%%' then
                            begin
                              RecCampi.Da:=Campo;    // intervallo DA
                              RecCampi.OldDa:=Campo;    // intervallo DA
                            end
                          else
                            begin
                              RecCampi.Da:='';
                              RecCampi.OldDa:='';
                            end;
                        end;
                    4:begin
                          if Campo <> '%%%' then
                            begin
                              RecCampi.A:=Campo;    // intervallo A
                              RecCampi.OldA:=Campo;    // intervallo A
                            end
                          else
                            begin
                              RecCampi.A:='';
                              RecCampi.OldA:='';
                            end;
                        end;
                    5:begin
                          if Campo = 'OA' then
                            begin
                              RecCampi.Ordinato:=True;
                              RecCampi.Ascendente:=True;
                              RecCampi.OldOrdinato:=True;
                              RecCampi.OldAscendente:=True;
                            end
                          else
                            if Campo = 'OD' then
                              begin
                                RecCampi.Ordinato:=True;
                                RecCampi.Ascendente:=False;
                                RecCampi.OldOrdinato:=True;
                                RecCampi.OldAscendente:=False;
                              end
                            else
                              if Campo = 'NO' then
                                begin
                                  RecCampi.Ordinato:=False;
                                  RecCampi.Ascendente:=False;
                                  RecCampi.OldOrdinato:=False;
                                  RecCampi.OldAscendente:=False;
                                end
                        end;
                    6:begin
                          RecCampi.Gruppo:=(Campo='S');
                          RecCampi.OldGruppo:=(Campo='S');
                        end;
                    7:begin
                          RecCampi.SelGruppo:=(Campo='S');
                        end;
                    8:begin
                          Val(Campo,AppInt,Code);
                          if Code = 0 then
                            RecCampi.NumBanda:=AppInt;
                        end;
                    9:begin
                          Val(Campo,AppInt,Code);
                          if Code = 0 then
                            RecCampi.Posi:=AppInt;
                        end;
                    10:begin
                          RecCampi.Intestazione:=Campo;
                          RecCampi.OldIntestazione:=Campo;
                        end;
                    11:begin
                          RecCampi.Posizione:=strtoint(Campo);
                          RecCampi.OldPosizione:=strtoint(Campo);
                        end;
                 end;
               end;
             ListaCampi.Add(RecCampi);  /// controllare BBBBBBeneeneen !!!!!
           end
       else
       if TipoStr = CMODALITA then
         if Copy(ListaSettaggi[I],4,Length(ListaSettaggi[I])-3) = 'Elenco' then
           Modalita:=Elenco
         else
           Modalita:=Scheda;
     end;
end;

procedure TC001FFiltroTabelle.UpDateSql;
var I:Integer;
    Primo:Boolean;
    SQLDescStatement,SQLStatement,VecchiaData:String;
begin
  Primo:=True;
  SQLStatement:='';
  C001FFiltroTabelleDTM.query1.close;
  // SELECT
  for i:=0 to ListaCampi.Count-1 do
  begin
    RecCampi:=ListaCampi[I];
    if RecCampi.Selezionato then
    begin
      if primo then
      begin
        SQLStatement:='SELECT ' + C001FFiltroTabelleDTM.Query2.FieldByName(RecCampi.Nome).DisplayLabel;
        Primo:=False;
      end
      else
        SQLStatement:=SQLStatement + ' ,' + C001FFiltroTabelleDTM.Query2.FieldByName(RecCampi.Nome).DisplayLabel;
      if Pos(' ' + UpperCase(RecCampi.Nome) + ' ',UpperCase(C001FFiltroTabelleDTM.Query2.FieldByName(RecCampi.Nome).DisplayLabel) + ' ') = 0 then
        SQLStatement:=SQLStatement + ' ' + RecCampi.Nome;
    end;
  end;

  C001FFiltroTabelleDTM.Query1.Sql.Clear;
  if not(Primo) then
    C001FFiltroTabelleDTM.Query1.SQL.Add(SQLStatement);

  //FROM
  C001FFiltroTabelleDTM.Query1.SQL.add(FROM_SQL);
  SQLStatement:='';

  //WHERE
  Cicli:=ListaCampi.Count - 1;
  for I:=0 to Cicli do
  begin
    RecCampi:=ListaCampi[I];
    // Elemento:=I;
    if (RecCampi.Da <> '') then
    begin
      //Se campo data mi assicuro che sia nel formato dd/mm/yyyy
      VecchiaData:=RecCampi.Da;
      if (C001FFiltroTabelleDtM.Query2.FieldByName(RecCampi.Nome).DataType = ftDate) then
        RecCampi.Da:=FormatDateTime('dd/mm/yyyy',StrToDate(RecCampi.Da));
      if (C001FFiltroTabelleDtM.Query2.FieldByName(RecCampi.Nome).DataType = ftDateTime) then
        RecCampi.Da:=FormatDateTime('dd/mm/yyyy',StrToDateTime(RecCampi.Da));
      if (SQLStatement = '') (*and (Pos(' WHERE ',FROM_SQL) = 0)*) then
        SQLStatement:=(*'WHERE ' +*) C001FFiltroTabelleDTM.Query2.FieldByName(RecCampi.Nome).DisplayLabel
                      + ' >= ' + ' ''' + RecCampi.Da + ''' '
      else
        SQLStatement:='AND ' + C001FFiltroTabelleDTM.Query2.FieldByName(RecCampi.Nome).DisplayLabel
                      + ' >= ' + ' ''' + RecCampi.Da + ''' ';
      //Ripristino la vecchia data
      if C001FFiltroTabelleDtM.Query2.FieldByName(RecCampi.Nome).DataType in [ftDate,ftDateTime] then
        RecCampi.Da:=VecchiaData;
      if Copy(SQLStatement,1,4) <> 'AND ' then
      begin
        if Pos('GROUP BY',FROM_SQL) > 0 then
        begin
          if Pos('HAVING',FROM_SQL) > 0 then
            SQLStatement:='AND ' + SQLStatement
          else
            SQLStatement:='HAVING ' + SQLStatement
        end
        else if Pos(' WHERE ',FROM_SQL) > 0 then
          SQLStatement:='AND ' + SQLStatement
        else
          SQLStatement:='WHERE ' + SQLStatement;
      end;
      C001FFiltroTabelleDTM.Query1.Sql.Add(SQLStatement);
    end;
    if (RecCampi.A <> '')then
    begin
      VecchiaData:=RecCampi.A;
      //Se campo data mi assicuro che sia nel formato dd/mm/yyyy
      if (C001FFiltroTabelleDtM.Query2.FieldByName(RecCampi.Nome).DataType = ftDate) then
        RecCampi.A:=FormatDateTime('dd/mm/yyyy',StrToDate(RecCampi.A));
      if (C001FFiltroTabelleDtM.Query2.FieldByName(RecCampi.Nome).DataType = ftDateTime) then
        RecCampi.A:=FormatDateTime('dd/mm/yyyy',StrToDateTime(RecCampi.A));
      if (SQLStatement = '') (*and (Pos(' WHERE ',FROM_SQL) = 0)*) then
        SQLStatement:=(*'WHERE ' +*) C001FFiltroTabelleDTM.Query2.FieldByName(RecCampi.Nome).DisplayLabel
                      + ' <= ' + ' ''' + RecCampi.A + ''' '
      else
        SQLStatement:='AND '+ C001FFiltroTabelleDTM.Query2.FieldByName(RecCampi.Nome).DisplayLabel
                      + ' <= ' + ' ''' + RecCampi.A + ''' ';
      if C001FFiltroTabelleDtM.Query2.FieldByName(RecCampi.Nome).DataType in [ftDate,ftDateTime] then
        RecCampi.A:=VecchiaData;
      if Copy(SQLStatement,1,4) <> 'AND ' then
      begin
        if Pos('GROUP BY',FROM_SQL) > 0 then
        begin
          if Pos('HAVING',FROM_SQL) > 0 then
            SQLStatement:='AND ' + SQLStatement
          else
            SQLStatement:='HAVING ' + SQLStatement
        end
        else if Pos(' WHERE ',FROM_SQL) > 0 then
          SQLStatement:='AND ' + SQLStatement
        else
          SQLStatement:='WHERE ' + SQLStatement;
      end;
      c001FFiltroTabelleDTM.Query1.Sql.Add(SQLStatement);
    end;
  end;

  if (StampaAnagrafico) then
  begin
    if Trim(Where_Sql) <> '' then
      C001FFiltroTabelleDTM.Query1.Sql.Add(' AND ' + Where_Sql);
  end
  else if (StampaAnagraficoMisto) then
  begin
    if Trim(Where_Sql) <> '' then
      C001FFiltroTabelleDTM.Query1.Sql.Add(' AND ' + Where_Sql);
  end;

  SQLStatement:='';
  SQLDescStatement:='';
  for I:=0 to ListaCampi.Count - 1 do
  begin
    RecCampi:=ListaCampi[I];
    if (RecCampi.Selezionato) and (RecCampi.Ordinato) then
    begin
      if (RecCampi.Ascendente) and (SQLStatement <> '') then
        SQLStatement:=SQLStatement + ', ' + RecCampi.Nome ;
      if (not(RecCampi.Ascendente)) and (SQLStatement <> '') then
        SQLStatement:=SQLStatement + ', ' + RecCampi.Nome + ' DESC';
      if (RecCampi.Ascendente) and (SQLStatement = '') then
        SQLStatement:='ORDER BY ' + RecCampi.nome;
      if (not(RecCampi.Ascendente)) and (SqlStatement = '')then
        SQLStatement:='ORDER BY ' + RecCampi.nome + ' DESC';
    end;
  end;

  if (SQLStatement<>'') then
    C001FFiltroTabelleDTM.query1.SQL.Add(SQLStatement)
  else
  begin
    if StampaAnagraficoMisto then
      C001FFiltroTabelleDTM.query1.SQL.Add(' ' + OrderSql);
    if StampaAnagrafico then
      C001FFiltroTabelleDTM.Query1.Sql.Add(' ' + Order_Sql);
  end;
  if QueryState then
  begin
    Screen.Cursor:=crHourGlass;
    C001FFiltroTabelleDTM.Query1.Open;
    Screen.Cursor:=crDefault;
    StatusBar.Panels[0].Text:=Format('%d Records',[C001FFiltroTabelleDTM.Query1.RecordCount]);
  end;
end;

procedure TC001FFiltroTabelle.AssegnaIntestazione;
var I:integer;
    dLabel:string;
begin
  for i:=0 to DBGrid1.FieldCount-1 do
  begin
    dLabel:=C001FScegliCampi.GetIntestazione(DBGrid1.Fields[i].Fieldname);
    GetFormatCurr(DBGrid1.Fields[i]);
    if dLabel<>'' then
      DBGrid1.Fields[i].DisplayLabel:=dLabel;
    DbGrid1.Fields[i].DisplayWidth:=C001FFiltroTabelleDTM.Query2.FieldByName(DbGrid1.Fields[i].FieldName).DisplayWidth;
  end;
end;

Procedure TC001FFiltroTabelle.GetFormatCurr(Field:TField);
{Assegno le proprietà DisplayFormat e Currency al campo in oggetto}
begin
  //Riporto la proprietà Display format
  with C001FFiltroTabelleDTM.Query2 do
  case Field.DataType of
    ftDate:(Field as TDateField).DisplayFormat:=(FieldByName(Field.FieldName) as TDateField).DisplayFormat;
    ftDateTime:(Field as TDateTimeField).DisplayFormat:=(FieldByName(Field.FieldName) as TDateTimeField).DisplayFormat;
    ftInteger:(Field as TIntegerField).DisplayFormat:=(FieldByName(Field.FieldName) as TIntegerField).DisplayFormat;
    ftSmallint:(Field as TSmallintField).DisplayFormat:=(FieldByName(Field.FieldName) as TSmallintField).DisplayFormat;
    ftTime:(Field as TTimeField).DisplayFormat:=(FieldByName(Field.FieldName) as TTimeField).DisplayFormat;
    ftWord:(Field as TWordField).DisplayFormat:=(FieldByName(Field.FieldName) as TWordField).DisplayFormat;
    ftBCD:begin
          (Field as TBCDField).Currency:=(FieldByName(Field.FieldName) as TBCDField).Currency;
          (Field as TBCDField).DisplayFormat:=(FieldByName(Field.FieldName) as TBCDField).DisplayFormat;
          end;
    ftCurrency:begin
               (Field as TCurrencyField).DisplayFormat:=(FieldByName(Field.FieldName) as TCurrencyField).DisplayFormat;
               (Field as TCurrencyField).Currency:=(FieldByName(Field.FieldName) as TCurrencyField).Currency;
               end;
    ftFloat:begin
            (Field as TFloatField).DisplayFormat:=(FieldByName(Field.FieldName) as TFloatField).DisplayFormat;
            (Field as TFloatField).Currency:=(FieldByName(Field.FieldName) as TFloatField).Currency;
            end;
  end;
end;

procedure TC001FFiltroTabelle.btnOrdineCampiOldClick(Sender: TObject);
begin
  InizializzaScegliCampi;
  if C001FScegliCampi.ShowModal = mrOk then
  begin
    Ordinamento:=True;
    QueryState:=True;
    // VariazioneCampi:=True;
    RiassegnaBandeGruppo:=True;
  end
  else
  begin
    QueryState:=False;
    VariazioneCampi:=False;
  end;
  if QueryState then
    UpDateSql;
  AssegnaIntestazione;
  //btnOrdineCampi.Down:=false;
  DBGrid1.SelectedIndex:=0;
  Colonna:=0;
end;

function ConfrontaPosizioni(P1,P2:Pointer):Integer;
begin
  if TRec_Campi(P1).Selezionato > TRec_Campi(P2).Selezionato then
    Result:=1
  else
    if TRec_Campi(P1).Selezionato < TRec_Campi(P2).Selezionato then
      Result:=-1
    else
      if TRec_Campi(P1).Posizione > TRec_Campi(P2).Posizione then
        Result:=1
      else
        if TRec_Campi(P1).Posizione < TRec_Campi(P2).Posizione then
          Result:=-1
        else
          Result:=0;
end;

procedure TC001FFiltroTabelle.OrdinaListaCampi();
begin
  ListaCampi.Sort(ConfrontaPosizioni);
end;

procedure TC001FFiltroTabelle.InizializzaScegliCampi;
begin
  with C001FScegliCampi do
  begin
    CaricaListBox(ListBoxScelti,True,NCampi-1);
    CaricaListBox(ListBoxNonScelti,False,NCampi-1);
  end;
end;


procedure TC001FFiltroTabelle.DBGrid1ColEnter(Sender: TObject);
begin
  Colonna:=DBGrid1.SelectedIndex;
end;

procedure TC001FFiltroTabelle.BtnResettaIntervalliClick(Sender: TObject);
var I:Integer;
begin
  if (not(StampaAnagrafico)) and
     (not(StampaAnagraficoMisto)) then
  begin
    if R180MessageBox('Attenzione: tutti gli intervalli verranno resettati.' + #13#10 +
                      'Proseguire con l''operazione ?',DOMANDA) = mrYes then
    begin
      for I:=0 to ListaCampi.Count-1 do
      begin
        RecCampi:=ListaCampi[I];
        RecCampi.Da:='';
        RecCampi.A :='';
      end;
      if QueryState then
      begin
        UpDateSQL;
        AssegnaIntestazione;
      end;
    end;
  end;
end;

procedure TC001FFiltroTabelle.BtnResettaOrdinamentiClick(Sender: TObject);
var I:Integer;
begin
  if R180MessageBox('Attenzione: tutti gli ordinamenti verranno resettati.' + #13#10 +
                    'Proseguire con l''operazione ?',DOMANDA) = mrYes then
  begin
    for I:=0 to ListaCampi.Count-1 do
    begin
      RecCampi:=ListaCampi[I];
      RecCampi.Ordinato:=False;
      RecCampi.Ascendente:=False;
    end;
    if QueryState then
    begin
      UpdateSQL;
      AssegnaIntestazione;
    end;
  end;
end;

procedure TC001FFiltroTabelle.BitBtn3Click(Sender: TObject);
{Richiamo e creo la Form per disegnare la stampa}
begin
  C001FStampa:=TC001FStampa.Create(nil);
  C001FLineSettings:=TC001FLineSettings.Create(nil);
  C001FGroupSelection:=TC001FGroupSelection.Create(nil);
  C001FLayoutStampa:=TC001FLayoutStampa.Create(nil);
  C001SettaQuickReport(C001FStampa.QRep);
  InizializzaLineeDiTratteggio;
  with C001FLayoutStampa do
  try
    C001FStampa.QrLblTitolo.Caption:=TitoloStampa;
    C001FLayoutStampa.ETitolo.Text:=TitoloStampa;
    C001FStampa.QrLblIntestazione.Caption:=IntestazioneQR;
    ShowModal;
  finally
    Free;
    C001FStampa.Free;
    C001FLineSettings.Free;
    C001FGroupSelection.Free;
  end;
end;

procedure TC001FFiltroTabelle.FormClose(Sender: TObject;
  var Action: TCloseAction);
var I:Integer;
begin
  C001FScegliCampi.Close;
  DistruggiListaCampi;
  DistruggiListaSettaggi;
  VarFont.Free;
  DefaultFont.Free;
  for I:=1 to 10 do
  begin
    OldFontGruppo[I].Free;
    FontGruppo[I].Free;
  end;
end;

procedure TC001FFiltroTabelle.Carica1Click(Sender: TObject);
begin
  BitBtnCaricaClick(Self);
end;

procedure TC001FFiltroTabelle.BitBtnCaricaClick(Sender: TObject);
begin
  Application.CreateForm(TC001FSaveForm,C001FSaveForm);
  C001FSaveForm.SetOpenMode(1);
  if C001FSaveForm.ShowModal = mrOK then
  begin
    ConfigAttiva:=C001FSaveForm.StampaAttiva;
    Self.Caption:='<C001> Stampa tabelle - ' + ConfigAttiva;
    if StampaAnagraficoMisto then
    begin
      From_Sql:=EliminaSpaziInutili(EliminaRitornoACapo(From_Sql));
      Where_Sql:=EliminaSpaziInutili(Where_Sql);
      if Where_Sql <> '' then
        From_Sql:=EliminaWhereSql(From_Sql,'AND '+Where_Sql);
    end;
    RiassegnaBandeGruppo:=False;
    LeggiListaSettaggi;
    //VariazioneCampi:=False; // usata nella Form Layout di stampa.
    VariazioneCampi:=True;  //Alberto 26/10/2004
    QueryState:=True;
    UpDateSQL;
    AssegnaIntestazione;
  end;
end;

procedure TC001FFiltroTabelle.Salva1Click(Sender: TObject);
begin
  BitBtnSalvaClick(Self);
end;

procedure TC001FFiltroTabelle.BitBtnSalvaClick(Sender: TObject);
begin
  SalvaSettaggiCampi;
  SettaTitoloStampa(TitoloStampa);
  if StampaAnagrafico then
    SettaParametriAnagrafico(EliminaRitornoACapo(Where_Sql+' '+Order_Sql));
  if StampaAnagraficoMisto then
    SettaParametriAnagrafico(EliminaRitornoACapo(Where_Sql+' '+Order_Sql));
  SalvaDefaultFont(DefaultFont);
  SalvaLinea(CLINEAREC,LineaRec);
  SalvaLinea(CLINEASUP,LineaSup);
  SalvaLinea(CLINEAINF,LineaInf);
  SalvaBanda(CBANDAAB);
  SalvaModalita(CMODALITA);
  Application.CreateForm(TC001FSaveForm,C001FSaveForm);
  C001FSaveForm.SetOpenMode(0);
  C001FSaveForm.ShowModal;
end;

procedure TC001FFiltroTabelle.frmSelAnagrafebtnEreditaSelezioneClick(
  Sender: TObject);
begin
  frmSelAnagrafe.btnEreditaSelezioneClick(Sender);
  QueryState:=True;
  if StampaAnagrafico then
  begin
    AssegnaQuery(C700SrcAnagrafe);
    GestisciOrdineCampi;
  end
  else if StampaAnagraficoMisto then
  begin
    GestisciStampaMista(C700SrcAnagrafe,C700SelAnagrafe,False,nil);
    GestisciOrdineCampi;
  end;
end;

procedure TC001FFiltroTabelle.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.btnSelezioneClick(Sender);
  if frmSelAnagrafe.C700ModalResult <> mrOK then
    exit;
  QueryState:=True;
  if StampaAnagrafico then
  begin
    AssegnaQuery(C700SrcAnagrafe);
    GestisciOrdineCampi;
  end
  else if StampaAnagraficoMisto then
  begin
    GestisciStampaMista(C700SrcAnagrafe,C700SelAnagrafe,False,nil);
    GestisciOrdineCampi;
  end;
end;

procedure TC001FFiltroTabelle.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

end.

