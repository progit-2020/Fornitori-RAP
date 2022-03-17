unit A145UStampaComunicazioneVisiteFiscali;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Contnrs, R002UQREP, QRPDFFilt, QRExport, QRWebFilt, QRCtrls, QuickRpt,
  ExtCtrls, StrUtils, Math,
  C001StampaLib, C180FunzioniGenerali;

type
  TA145FStampaComunicazioneVisiteFiscali = class(TR002FQRep)
    QRBDettaglio: TQRBand;
    QRDBTNomeCognome: TQRDBText;
    QRDBTPrognosi: TQRDBText;
    QRDBTNumAssenze: TQRDBText;
    QRDBTGiorniAssenza: TQRDBText;
    QRDBTOperazione: TQRDBText;
    QRCBDettaglio: TQRChildBand;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRLPeriodoAssenza: TQRLabel;
    QRGroupMedLegale: TQRGroup;
    QRDBText1: TQRDBText;
    QRDBTDataPrimaComunicazione: TQRDBText;
    QRLSuddivisionePeriodo: TQRLabel;
    QRLGiaComunicato: TQRLabel;
    QRBIntestazione: TQRChildBand;
    QRLGiaComunicatoLbl: TQRLabel;
    QRLNomeCognomeLbl: TQRLabel;
    QRLPeriodoAssenzaLbl: TQRLabel;
    QRLPrimaComunicazioneLbl: TQRLabel;
    QRLDomicilioLbl: TQRLabel;
    QRShape5: TQRShape;
    QRLTipoOperazioneLbl: TQRLabel;
    QRShape6: TQRShape;
    QRLPrognosiLbl: TQRLabel;
    QRLabel8: TQRLabel;
    QRShape7: TQRShape;
    QRLabel9: TQRLabel;
    QRShape17: TQRShape;
    QRLabel10: TQRLabel;
    QRShape8: TQRShape;
    QRDBTDomicilio: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRCBNote: TQRChildBand;
    QRDBNote: TQRDBText;
    QRlblNote: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRLabel5: TQRLabel;
    QRShapeDettSX: TQRShape;
    procedure QRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRDBTOperazionePrint(sender: TObject; var Value: string);
    procedure QRLPeriodoAssenzaPrint(sender: TObject; var Value: string);
    procedure QRLDataPrimaComunicazionePrint(sender: TObject;
      var Value: string);
    procedure QRLSuddivisionePeriodoPrint(sender: TObject; var Value: string);
    procedure QRLGiaComunicatoPrint(sender: TObject; var Value: string);
    procedure QRBDettaglioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRCBDettaglioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBTPrognosiPrint(sender: TObject; var Value: string);
    procedure QRCBNoteBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);

  private
    { Private declarations }
    lstObj:TObjectList;
    procedure ShiftADestra;
  public
    { Public declarations }
    procedure ImpostaDataset;
    procedure CreaReport;
    procedure DistruggiLstObj;
  end;

var
  A145FStampaComunicazioneVisiteFiscali: TA145FStampaComunicazioneVisiteFiscali;
const
  WIDTH_CAMPI_LIBERI:Integer = 115;     // valore ponderato per 3 campi di dettaglio
  SPAZIATURA_CAMPI_LIBERI:Integer = 7;  // agire con prudenza su questi valori

implementation

uses A145UComunicazioneVisiteFiscali, A145UComunicazioneVisiteFiscaliDtM;

{$R *.dfm}

procedure TA145FStampaComunicazioneVisiteFiscali.QRCBNoteBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:=Not QRep.DataSet.FieldByName('NOTE').IsNull and A145FComunicazioneVisiteFiscali.chkNote.Checked;
  inherited;
  QRlblNote.Left:=QRLNomeCognomeLbl.Left;
end;

procedure TA145FStampaComunicazioneVisiteFiscali.CreaReport;
var
  j:Integer;
  OperazioneNonUnica: Boolean;
  QRLDettaglioLbl:TQRLabel;
  QRDBTDettaglio:TQRDBText;
  InizioSx,LeftDinamico,Limite: Integer;
  SpazioLibero,SpaziaturaTot,SpazioDisp,WidthAutoAdattato,WidthCalcolato: Integer;
  NumCampiStampati: Integer;
  msg: String;
begin
  with A145FComunicazioneVisiteFiscali do
  begin
    // crea la lista di oggetti di stampa dinamici da deallocare al termine
    lstObj:=TObjectList.Create;
    try
      lstObj.OwnsObjects:=False;

      // tipo operazione (solo la cancellazione è unica, perché l'inserimento può essere normale / prolungato)
      OperazioneNonUnica:=(A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.Operazione <> 'C');
      QRLTipoOperazioneLbl.Enabled:=OperazioneNonUnica;
      QRDBTOperazione.Enabled:=OperazioneNonUnica;
      QRShape1.Enabled:=OperazioneNonUnica;
      QRShape5.Enabled:=OperazioneNonUnica;
      QRShape9.Enabled:=OperazioneNonUnica;

      // determina se visualizzare la colonna "Periodi già comunicati"
      QRLGiaComunicatoLbl.Enabled:=A145FComunicazioneVisiteFiscali.chkPeriodiComunicati.Checked;
      QRLGiaComunicato.Enabled:=A145FComunicazioneVisiteFiscali.chkPeriodiComunicati.Checked;

      if A145FComunicazioneVisiteFiscali.chkPeriodiComunicati.Checked then
        // visualizzata
        InizioSx:=QRLGiaComunicatoLbl.Left + QRLGiaComunicatoLbl.Width + SPAZIATURA_CAMPI_LIBERI
      else
        // non visualizzata
        InizioSx:=QRLGiaComunicatoLbl.Left;

      // determina il left dei campi in prima (o seconda) colonna
      QRLNomeCognomeLbl.Left:=InizioSx;
      QRLPeriodoAssenzaLbl.Left:=InizioSx;
      QRDBTNomeCognome.Left:=InizioSx;
      QRLPeriodoAssenza.Left:=InizioSx;
      //Gestione check: chkNote, chkStampaAssMal
      {*}ShiftADestra{*};
      // determina il left dei campi in seconda (o terza) colonna
      QRLPrimaComunicazioneLbl.Left:=InizioSx + QRLNomeCognomeLbl.Width + SPAZIATURA_CAMPI_LIBERI;
      QRLDomicilioLbl.Left:=InizioSx + QRLPeriodoAssenzaLbl.Width + SPAZIATURA_CAMPI_LIBERI;
      QRDBTDataPrimaComunicazione.Left:=InizioSx + QRDBTNomeCognome.Width + SPAZIATURA_CAMPI_LIBERI;
      QRDBTDomicilio.Left:=InizioSx + QRLPeriodoAssenza.Width + SPAZIATURA_CAMPI_LIBERI;

      // stabilisce il limite dx per i campi variabili e gestisce il width del campo domicilio
      Limite:=IfThen(OperazioneNonUnica,QRShape5.Left,QRShape6.Left);

      QRDBTDomicilio.Width:=IfThen(OperazioneNonUnica,QRShape9.Left,QRShape10.Left) - QRDBTDomicilio.Left - SPAZIATURA_CAMPI_LIBERI;

      // campi di dettaglio selezionati dall'utente
      if A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW.DatiElab.ListaDettaglio.Count > 0 then
      begin
        // impostazioni iniziali
        LeftDinamico:=QRDBTDataPrimaComunicazione.Left + QRDBTDataPrimaComunicazione.Width + SPAZIATURA_CAMPI_LIBERI;

        { tenta di ottimizzare lo sfruttamento dello spazio disponibile }
        // prova a dividere lo spazio libero in n aree, una per ogni campo anagrafico scelto
        SpazioLibero:=Limite-LeftDinamico-SPAZIATURA_CAMPI_LIBERI;
        SpaziaturaTot:=SPAZIATURA_CAMPI_LIBERI * (A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW.DatiElab.ListaDettaglio.Count - 1);
        SpazioDisp:=SpazioLibero - SpaziaturaTot;

        // calcola la larghezza maggiore applicabile ad ogni campo
        WidthAutoAdattato:=Trunc(SpazioDisp / A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW.DatiElab.ListaDettaglio.Count);

        // se la larghezza calcolata è maggiore di quella impostata inizialmente,
        // allora utilizza quella calcolata
        if WidthAutoAdattato > WIDTH_CAMPI_LIBERI then
        begin
          WidthCalcolato:=WidthAutoAdattato;
          NumCampiStampati:=A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW.DatiElab.ListaDettaglio.Count;
        end
        else
        begin
          WidthCalcolato:=WIDTH_CAMPI_LIBERI;
          NumCampiStampati:=Trunc(SpazioDisp / WidthCalcolato);
        end;

        // generazione della parte variabile
        for j:=0 to NumCampiStampati - 1 do
        begin
          // aggiunge una label dinamica nell'intestazione
          QRLDettaglioLbl:=TQRLabel(QRBIntestazione.AddPrintable(TQRLabel));
          with QRLDettaglioLbl do
          begin
            AutoSize:=False;
            AutoStretch:=False;
            Caption:=VarToStr(A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW.selI010.Lookup('NOME_CAMPO',A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW.DatiElab.ListaDettaglio.Strings[j],'NOME_LOGICO'));
            Left:=LeftDinamico;
            Top:=QRLNomeCognomeLbl.Top;
            Height:=QRLNomeCognomeLbl.Height;
            Width:=WidthCalcolato;
            Enabled:=True;
          end;

          // aggiunge un dbtext dinamico nel dettaglio
          QRDBTDettaglio:=TQRDBText(QRBDettaglio.AddPrintable(TQRDBText));
          with QRDBTDettaglio do
          begin
            AutoSize:=False;
            AutoStretch:=True;
            WordWrap:=True;
            DataSet:=A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW.TabellaStampa;
            DataField:='A_' + A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW.DatiElab.ListaDettaglio.Strings[j];
            Left:=LeftDinamico;
            Top:=QRDBTNomeCognome.Top;
            Height:=QRDBTNomeCognome.Height;
            Width:=WidthCalcolato;
            Enabled:=True;
          end;

          LeftDinamico:=LeftDinamico + WidthCalcolato + SPAZIATURA_CAMPI_LIBERI;

          lstOBJ.Add(QRLDettaglioLbl);
          lstOBJ.Add(QRDBTDettaglio);
        end;
      end;
    except
      Screen.Cursor:=crDefault;
      msg:='Si è verificato un errore durante l''elaborazione della stampa.';
      if TipoModulo = 'CS' then
        R180MessageBox(msg, INFORMA)
      else
        raise Exception.Create(msg);
      Exit;
    end;
  end; // =>with A145FComunicazioneVisiteFiscali

  Screen.Cursor:=crDefault;
  // avvia la stampa
  if (A145FComunicazioneVisiteFiscali.TipoModulo = 'COM') and (Trim(A145FComunicazioneVisiteFiscali.DocumentoPDF) <> '') and (Trim(A145FComunicazioneVisiteFiscali.DocumentoPDF) <> '<VUOTO>') then
  begin
    QRep.ShowProgress:=False;
    QRep.ExportToFilter(TQRPDFDocumentFilter.Create(A145FComunicazioneVisiteFiscali.DocumentoPDF));
  end
  else
  begin
    if A145FComunicazioneVisiteFiscali.Anteprima then
      QRep.Preview
    else
      QRep.Print;
  end;
end;

procedure TA145FStampaComunicazioneVisiteFiscali.QRBDettaglioBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  h: Extended;
  altezza: Integer;
begin
  inherited;
  QRBDettaglio.ExpandedHeight(h);
  altezza:=Round(h*ProporzioneBandExpanded);

  QRShape1.Height:=altezza;
  QRShape2.Height:=altezza;
  QRShape3.Height:=altezza;
  QRShape4.Height:=altezza;

  // se il tipo operazione è CAN, evidenzia la riga con il font grassettato
  if QRep.Dataset.FieldByName('Operazione').AsString = 'C' then
    QRBDettaglio.Font.Style:=[fsBold]
  else
    QRBDettaglio.Font.Style:=[];
end;

procedure TA145FStampaComunicazioneVisiteFiscali.ShiftADestra;
var ShiftCol1, ShiftCol2:Integer;
begin
  with A145FComunicazioneVisiteFiscali do
  begin
    //Gestione visibilià Label o Text
    //(Band)QRBIntestazione
    QRLabel8.Enabled:=chkStampaAssMal.Checked;
    QRLabel9.Enabled:=chkStampaAssMal.Checked;
    QRLabel10.Enabled:=chkStampaAssMal.Checked;
    QRShape7.Enabled:=chkStampaAssMal.Checked;
    QRShape8.Enabled:=chkStampaAssMal.Checked;
    QRShape17.Enabled:=chkStampaAssMal.Checked;
    //(Band)QRCBDettaglio
    QRShape11.Enabled:=chkStampaAssMal.Checked;
    QRShape12.Enabled:=chkStampaAssMal.Checked;
    //(Band)QRBDettaglio
    QRShape3.Enabled:=chkStampaAssMal.Checked;
    QRShape4.Enabled:=chkStampaAssMal.Checked;
    QRDBTNumAssenze.Enabled:=chkStampaAssMal.Checked;
    QRDBTGiorniAssenza.Enabled:=chkStampaAssMal.Checked;

    //Posizionamento Label e Text
    ShiftCol1:=913;
    ShiftCol2:=970;
    if chkStampaAssMal.Checked then
    begin
      ShiftCol1:=778;
      ShiftCol2:=829;
    end;
    QRShape5.Left:=ShiftCol1 - 5;
    QRLTipoOperazioneLbl.Left:=ShiftCol1;
    QRShape6.Left:=ShiftCol2 + 12;
    QRLPrognosiLbl.Left:=ShiftCol2 + 18 + IfThen(not chkStampaAssMal.Checked,-2);
    //------------------------------------
    QRShape1.Left:=ShiftCol1 - 5;
    QRDBTOperazione.Left:=ShiftCol1;
    QRShape2.Left:=ShiftCol2 + 12;
    QRDBTPrognosi.Left:=ShiftCol2 + 14;
    //------------------------------------
    QRShape9.Left:=ShiftCol1 - 5;
    QRShape10.Left:=ShiftCol2 + 12;
    QRLSuddivisionePeriodo.Left:=ShiftCol2 + 14;
    QRDBTDomicilio.Width:=QRShape9.Left - QRDBTDomicilio.Left - SPAZIATURA_CAMPI_LIBERI;
    QRDBTDataPrimaComunicazione.Left:=308;
    QRDBTDataPrimaComunicazione.Width:=90;
  end;
end;

procedure TA145FStampaComunicazioneVisiteFiscali.QRCBDettaglioBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  h: Extended;
  altezza: Integer;
  procedure DimensionaHShape(var InShape:TQRShape);
  begin
    InShape.Top:=0;
    InShape.Height:=QRCBDettaglio.Height;
  end;
begin
  inherited;
  QRCBDettaglio.Frame.DrawBottom:=A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.TabellaStampa.FieldByName('NOTE').IsNull;
  QRShapeDettSX.Enabled:=Not A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.TabellaStampa.FieldByName('NOTE').IsNull;
  QRShapeDettSX.Top:=QRCBDettaglio.Height - 2;
  QRShapeDettSX.Left:=QRShape9.Left;
  QRShapeDettSX.Width:=QRCBDettaglio.Width - QRShapeDettSX.Left;
  QRShapeDettSX.Height:=1;
  DimensionaHShape(QRShape9);
  DimensionaHShape(QRShape10);
  DimensionaHShape(QRShape11);
  DimensionaHShape(QRShape12);
//  QRDBNote.Left:=QRDBTDomicilio.Left;
  QRCBDettaglio.ExpandedHeight(h);
  altezza:=Round(h*ProporzioneBandExpanded);

  QRShape9.Height:=altezza;
  QRShape10.Height:=altezza;
  QRShape11.Height:=altezza;
  QRShape12.Height:=altezza;

  // se il tipo operazione è CAN, evidenzia la riga con il font grassettato
  if QRep.Dataset.FieldByName('Operazione').AsString = 'C' then
    QRCBDettaglio.Font.Style:=[fsBold]
  else
    QRCBDettaglio.Font.Style:=[];
end;

procedure TA145FStampaComunicazioneVisiteFiscali.QRDBTOperazionePrint(sender: TObject;
  var Value: string);
begin
  inherited;
  if Value = 'I' then
    Value:=IfThen(QRep.Dataset.FieldByName('NuovaDataFine').IsNull,'INS','PROL')
  else
    Value:='CAN';
end;

procedure TA145FStampaComunicazioneVisiteFiscali.QRDBTPrognosiPrint(sender: TObject; var Value: string);
begin
  inherited;
  if Value = '1' then
    Value:='';
end;

procedure TA145FStampaComunicazioneVisiteFiscali.QRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  inherited;
  with A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW do begin
    // titolo
    if datiElab.bAggiorna then
      LEnte.Caption:='COMUNICAZIONI VISITE FISCALI DEL ' + DateToStr(DatiElab.DataElaborazione)
    else
      LEnte.Caption:='COMUNICAZIONI VISITE FISCALI - STAMPA PROVVISORIA';

    // sottotitolo: in funzione dell'opzione scelta
    if DatiElab.bPeriodiComunicati then
      LTitolo.Caption:='ASSENZE NEL PERIODO DAL ' + DateToStr(DatiElab.DataDa) + ' AL ' + DateToStr(DatiElab.DataA)
    else if not datiElab.bAggiorna then
      LTitolo.Caption:='DATA DI ELABORAZIONE: ' + DateToStr(DatiElab.DataElaborazione)
    else
      LTitolo.Caption:='';
  end;
end;

procedure TA145FStampaComunicazioneVisiteFiscali.QRLDataPrimaComunicazionePrint(
  sender: TObject; var Value: string);
var Dato: String;
begin
  inherited;

  with QRep.DataSet do
  begin
    Dato:=FieldByName('DataPrimaComunicazione').AsString;
    if not FieldByName('NuovaDataFine').IsNull then
      Dato:=Dato + ' (' + FieldByName('DataFineAssenza').AsString + ')';
      
    Value:=Dato;
  end;
end;

procedure TA145FStampaComunicazioneVisiteFiscali.QRLGiaComunicatoPrint(sender: TObject;
  var Value: string);
var
  Comunicato1,ComunicatoProl: Boolean;
begin
  inherited;
  with QRep.DataSet do
  begin
    Comunicato1:=(FieldByName('NuovaDataFine').IsNull) and
                 (not FieldByName('DataPrimaComunicazione').IsNull);
    ComunicatoProl:=(not FieldByName('NuovaDataFine').IsNull) and
                    (not FieldByName('DataComunProlungamento').IsNull);

    Value:=IfThen((Comunicato1 or ComunicatoProl),'S','N');
  end;
end;

procedure TA145FStampaComunicazioneVisiteFiscali.QRLPeriodoAssenzaPrint(sender: TObject;
  var Value: string);
begin
  inherited;
  with QRep.Dataset do
  begin
    // due possibilità di visualizzazione, in base a inserimento normale / prolungamento
    // data_inizio - data_fine
    // data_inizio - nuova_data_fine (data_fine)
    Value:=FieldByName('DataInizioAssenza').AsString + ' - ';
    if FieldByName('NuovaDataFine').IsNull then
      Value:=Value + FieldByName('DataFineAssenza').AsString
    else
      Value:=Value + FieldByName('NuovaDataFine').AsString +
             ' (' +  FieldByName('DataFineAssenza').AsString + ')'; 
  end;
end;

procedure TA145FStampaComunicazioneVisiteFiscali.QRLSuddivisionePeriodoPrint(sender: TObject;
  var Value: string);
begin
  inherited;
  if (QRep.Dataset.FieldByName('Operazione').AsString = 'I') and
     (not QRep.Dataset.FieldByName('NuovaDataFine').IsNull) then
     Value:='(' + IntToStr(QRep.Dataset.FieldByName('PrognosiPrima').AsInteger) +
            '+' + IntToStr(QRep.Dataset.FieldByName('PrognosiProl').AsInteger) + ')'
  else
     Value:='';
end;

procedure TA145FStampaComunicazioneVisiteFiscali.ImpostaDataset;
begin
  with A145FComunicazioneVisiteFiscaliDtM.A145FComVisiteFiscaliMW do
  begin
    QRep.DataSet:=TabellaStampa;
    QRDBTNomeCognome.DataSet:=TabellaStampa;
    QRDBTPrognosi.DataSet:=TabellaStampa;
    QRDBTNumAssenze.DataSet:=TabellaStampa;
    QRDBTGiorniAssenza.DataSet:=TabellaStampa;
    QRDBTOperazione.DataSet:=TabellaStampa;
    QRDBTDataPrimaComunicazione.DataSet:=TabellaStampa;
    QRDBTDomicilio.DataSet:=TabellaStampa;
    QRDBText1.DataSet:=TabellaStampa;
    QRDBText2.DataSet:=TabellaStampa;
    QRDBText3.DataSet:=TabellaStampa;
    QRDBText4.DataSet:=TabellaStampa;
    QRDBText5.DataSet:=TabellaStampa;
    QRDBNote.DataSet:=TabellaStampa;
  end;
end;

procedure TA145FStampaComunicazioneVisiteFiscali.DistruggiLstObj;
var i:Integer;
begin
  for i:=lstOBJ.Count - 1 downto 0 do
    lstOBJ[i].Free;
  lstOBJ.Clear;
  FreeAndNil(lstOBJ);
end;

end.
