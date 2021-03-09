// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : Z:\Sviluppo\_AlbertoA069\BilancioWs.xml
//  >Import : Z:\Sviluppo\_AlbertoA069\BilancioWs.xml>0
// Encoding : UTF-8
// Version  : 1.0
// (19/11/2012 17.10.44 - - $Rev: 25127 $)
// ************************************************************************ //

unit A069UCSIBilancioWs;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_NLBL = $0004;
  IS_UNQL = $0008;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"[Gbl]

  estremiCdR           = class;                 { "http://ws.service.business.bilsrvcp.csi.it/"[GblCplx] }
  ente                 = class;                 { "http://ws.service.business.bilsrvcp.csi.it/"[GblCplx] }
  intervento           = class;                 { "http://ws.service.business.bilsrvcp.csi.it/"[GblCplx] }
  servizio             = class;                 { "http://ws.service.business.bilsrvcp.csi.it/"[GblCplx] }
  ueb                  = class;                 { "http://ws.service.business.bilsrvcp.csi.it/"[GblCplx] }
  voceEconomica        = class;                 { "http://ws.service.business.bilsrvcp.csi.it/"[GblCplx] }
  estremiCapitoloSpesa = class;                 { "http://ws.service.business.bilsrvcp.csi.it/"[GblCplx] }
  estremiCapitoloUscita = class;                { "http://ws.service.business.bilsrvcp.csi.it/"[GblCplx] }
  assessorato          = class;                 { "http://ws.service.business.bilsrvcp.csi.it/"[GblCplx] }
  settore              = class;                 { "http://ws.service.business.bilsrvcp.csi.it/"[GblCplx] }
  centroDiCosto        = class;                 { "http://ws.service.business.bilsrvcp.csi.it/"[GblCplx] }
  importiUEBSpesa      = class;                 { "http://ws.service.business.bilsrvcp.csi.it/"[GblCplx] }
  ServiceSystemException = class;               { "http://ws.service.business.bilsrvcp.csi.it/"[GblCplx] }
  BusinessException    = class;                 { "http://ws.service.business.bilsrvcp.csi.it/"[GblCplx] }
  ServiceSystemException2 = class;              { "http://ws.service.business.bilsrvcp.csi.it/"[Flt][GblElm] }
  BusinessException2   = class;                 { "http://ws.service.business.bilsrvcp.csi.it/"[Flt][GblElm] }
  capitoloUscita       = class;                 { "http://ws.service.business.bilsrvcp.csi.it/"[GblCplx] }
  return               = class;                 { "http://ws.service.business.bilsrvcp.csi.it/"[Alias] }
  funzione             = class;                 { "http://ws.service.business.bilsrvcp.csi.it/"[GblCplx] }
  titoloUscita         = class;                 { "http://ws.service.business.bilsrvcp.csi.it/"[GblCplx] }



  // ************************************************************************ //
  // XML       : estremiCdR, global, <complexType>
  // Namespace : http://ws.service.business.bilsrvcp.csi.it/
  // ************************************************************************ //
  estremiCdR = class(TRemotable)
  private
    FannoCreazione: string;
    FannoCreazione_Specified: boolean;
    FcentroResp: string;
    FcentroResp_Specified: boolean;
    Fdescrizione: string;
    Fdescrizione_Specified: boolean;
    procedure SetannoCreazione(Index: Integer; const Astring: string);
    function  annoCreazione_Specified(Index: Integer): boolean;
    procedure SetcentroResp(Index: Integer; const Astring: string);
    function  centroResp_Specified(Index: Integer): boolean;
    procedure Setdescrizione(Index: Integer; const Astring: string);
    function  descrizione_Specified(Index: Integer): boolean;
  published
    property annoCreazione: string  Index (IS_OPTN or IS_UNQL) read FannoCreazione write SetannoCreazione stored annoCreazione_Specified;
    property centroResp:    string  Index (IS_OPTN or IS_UNQL) read FcentroResp write SetcentroResp stored centroResp_Specified;
    property descrizione:   string  Index (IS_OPTN or IS_UNQL) read Fdescrizione write Setdescrizione stored descrizione_Specified;
  end;



  // ************************************************************************ //
  // XML       : ente, global, <complexType>
  // Namespace : http://ws.service.business.bilsrvcp.csi.it/
  // ************************************************************************ //
  ente = class(TRemotable)
  private
    FcodAzienda: Integer;
    FdescrizioneCodAzienda: string;
    FdescrizioneCodAzienda_Specified: boolean;
    procedure SetdescrizioneCodAzienda(Index: Integer; const Astring: string);
    function  descrizioneCodAzienda_Specified(Index: Integer): boolean;
  published
    property codAzienda:            Integer  Index (IS_UNQL) read FcodAzienda write FcodAzienda;
    property descrizioneCodAzienda: string   Index (IS_OPTN or IS_UNQL) read FdescrizioneCodAzienda write SetdescrizioneCodAzienda stored descrizioneCodAzienda_Specified;
  end;



  // ************************************************************************ //
  // XML       : intervento, global, <complexType>
  // Namespace : http://ws.service.business.bilsrvcp.csi.it/
  // ************************************************************************ //
  intervento = class(TRemotable)
  private
    Fcodice: string;
    Fcodice_Specified: boolean;
    Fdescrizione: string;
    Fdescrizione_Specified: boolean;
    Ftitolo: titoloUscita;
    Ftitolo_Specified: boolean;
    procedure Setcodice(Index: Integer; const Astring: string);
    function  codice_Specified(Index: Integer): boolean;
    procedure Setdescrizione(Index: Integer; const Astring: string);
    function  descrizione_Specified(Index: Integer): boolean;
    procedure Settitolo(Index: Integer; const AtitoloUscita: titoloUscita);
    function  titolo_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property codice:      string        Index (IS_OPTN or IS_UNQL) read Fcodice write Setcodice stored codice_Specified;
    property descrizione: string        Index (IS_OPTN or IS_UNQL) read Fdescrizione write Setdescrizione stored descrizione_Specified;
    property titolo:      titoloUscita  Index (IS_OPTN or IS_UNQL) read Ftitolo write Settitolo stored titolo_Specified;
  end;



  // ************************************************************************ //
  // XML       : servizio, global, <complexType>
  // Namespace : http://ws.service.business.bilsrvcp.csi.it/
  // ************************************************************************ //
  servizio = class(TRemotable)
  private
    Fcodice: string;
    Fcodice_Specified: boolean;
    Fdescrizione: string;
    Fdescrizione_Specified: boolean;
    Fflrag: string;
    Fflrag_Specified: boolean;
    Ffunzione: funzione;
    Ffunzione_Specified: boolean;
    Fresponsabile: string;
    Fresponsabile_Specified: boolean;
    Ftipo: string;
    Ftipo_Specified: boolean;
    procedure Setcodice(Index: Integer; const Astring: string);
    function  codice_Specified(Index: Integer): boolean;
    procedure Setdescrizione(Index: Integer; const Astring: string);
    function  descrizione_Specified(Index: Integer): boolean;
    procedure Setflrag(Index: Integer; const Astring: string);
    function  flrag_Specified(Index: Integer): boolean;
    procedure Setfunzione(Index: Integer; const Afunzione: funzione);
    function  funzione_Specified(Index: Integer): boolean;
    procedure Setresponsabile(Index: Integer; const Astring: string);
    function  responsabile_Specified(Index: Integer): boolean;
    procedure Settipo(Index: Integer; const Astring: string);
    function  tipo_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property codice:       string    Index (IS_OPTN or IS_UNQL) read Fcodice write Setcodice stored codice_Specified;
    property descrizione:  string    Index (IS_OPTN or IS_UNQL) read Fdescrizione write Setdescrizione stored descrizione_Specified;
    property flrag:        string    Index (IS_OPTN or IS_UNQL) read Fflrag write Setflrag stored flrag_Specified;
    property funzione:     funzione  Index (IS_OPTN or IS_UNQL) read Ffunzione write Setfunzione stored funzione_Specified;
    property responsabile: string    Index (IS_OPTN or IS_UNQL) read Fresponsabile write Setresponsabile stored responsabile_Specified;
    property tipo:         string    Index (IS_OPTN or IS_UNQL) read Ftipo write Settipo stored tipo_Specified;
  end;



  // ************************************************************************ //
  // XML       : ueb, global, <complexType>
  // Namespace : http://ws.service.business.bilsrvcp.csi.it/
  // ************************************************************************ //
  ueb = class(TRemotable)
  private
    FallegatoConsuntivo: string;
    FallegatoConsuntivo_Specified: boolean;
    FallegatoPreventivo: string;
    FallegatoPreventivo_Specified: boolean;
    Farea: string;
    Farea_Specified: boolean;
    Fassessorato: assessorato;
    Fassessorato_Specified: boolean;
    Fcdc: centroDiCosto;
    Fcdc_Specified: boolean;
    FcdcEntrataCollegato: settore;
    FcdcEntrataCollegato_Specified: boolean;
    Fcoel: string;
    Fcoel_Specified: boolean;
    FcoelEntrataCollegato: string;
    FcoelEntrataCollegato_Specified: boolean;
    FdataAgg: TXSDateTime;
    FdataAgg_Specified: boolean;
    FdataIns: TXSDateTime;
    FdataIns_Specified: boolean;
    FdescriAllegatoConsuntivo: string;
    FdescriAllegatoConsuntivo_Specified: boolean;
    FdescriAllegatoPreventivo: string;
    FdescriAllegatoPreventivo_Specified: boolean;
    FdescriArea: string;
    FdescriArea_Specified: boolean;
    FdescriCoel: string;
    FdescriCoel_Specified: boolean;
    FdescriTipoFin: string;
    FdescriTipoFin_Specified: boolean;
    FimpegnatoEsercizioChiuso: string;
    FimpegnatoEsercizioChiuso_Specified: boolean;
    FnumeroArticolo: Integer;
    FnumeroArticoloEntrataCollegato: Integer;
    FnumeroCapitolo: Integer;
    FnumeroCapitoloEntrataCollegato: Integer;
    FstanziamentoAnnoPrec: string;
    FstanziamentoAnnoPrec_Specified: boolean;
    FstanziamentoAttuale: string;
    FstanziamentoAttuale_Specified: boolean;
    FtipoFin: string;
    FtipoFin_Specified: boolean;
    FtipoFinEntrataCollegato: string;
    FtipoFinEntrataCollegato_Specified: boolean;
    FutenteAgg: string;
    FutenteAgg_Specified: boolean;
    FutenteIns: string;
    FutenteIns_Specified: boolean;
    procedure SetallegatoConsuntivo(Index: Integer; const Astring: string);
    function  allegatoConsuntivo_Specified(Index: Integer): boolean;
    procedure SetallegatoPreventivo(Index: Integer; const Astring: string);
    function  allegatoPreventivo_Specified(Index: Integer): boolean;
    procedure Setarea(Index: Integer; const Astring: string);
    function  area_Specified(Index: Integer): boolean;
    procedure Setassessorato(Index: Integer; const Aassessorato: assessorato);
    function  assessorato_Specified(Index: Integer): boolean;
    procedure Setcdc(Index: Integer; const AcentroDiCosto: centroDiCosto);
    function  cdc_Specified(Index: Integer): boolean;
    procedure SetcdcEntrataCollegato(Index: Integer; const Asettore: settore);
    function  cdcEntrataCollegato_Specified(Index: Integer): boolean;
    procedure Setcoel(Index: Integer; const Astring: string);
    function  coel_Specified(Index: Integer): boolean;
    procedure SetcoelEntrataCollegato(Index: Integer; const Astring: string);
    function  coelEntrataCollegato_Specified(Index: Integer): boolean;
    procedure SetdataAgg(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  dataAgg_Specified(Index: Integer): boolean;
    procedure SetdataIns(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  dataIns_Specified(Index: Integer): boolean;
    procedure SetdescriAllegatoConsuntivo(Index: Integer; const Astring: string);
    function  descriAllegatoConsuntivo_Specified(Index: Integer): boolean;
    procedure SetdescriAllegatoPreventivo(Index: Integer; const Astring: string);
    function  descriAllegatoPreventivo_Specified(Index: Integer): boolean;
    procedure SetdescriArea(Index: Integer; const Astring: string);
    function  descriArea_Specified(Index: Integer): boolean;
    procedure SetdescriCoel(Index: Integer; const Astring: string);
    function  descriCoel_Specified(Index: Integer): boolean;
    procedure SetdescriTipoFin(Index: Integer; const Astring: string);
    function  descriTipoFin_Specified(Index: Integer): boolean;
    procedure SetimpegnatoEsercizioChiuso(Index: Integer; const Astring: string);
    function  impegnatoEsercizioChiuso_Specified(Index: Integer): boolean;
    procedure SetstanziamentoAnnoPrec(Index: Integer; const Astring: string);
    function  stanziamentoAnnoPrec_Specified(Index: Integer): boolean;
    procedure SetstanziamentoAttuale(Index: Integer; const Astring: string);
    function  stanziamentoAttuale_Specified(Index: Integer): boolean;
    procedure SettipoFin(Index: Integer; const Astring: string);
    function  tipoFin_Specified(Index: Integer): boolean;
    procedure SettipoFinEntrataCollegato(Index: Integer; const Astring: string);
    function  tipoFinEntrataCollegato_Specified(Index: Integer): boolean;
    procedure SetutenteAgg(Index: Integer; const Astring: string);
    function  utenteAgg_Specified(Index: Integer): boolean;
    procedure SetutenteIns(Index: Integer; const Astring: string);
    function  utenteIns_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property allegatoConsuntivo:             string         Index (IS_OPTN or IS_UNQL) read FallegatoConsuntivo write SetallegatoConsuntivo stored allegatoConsuntivo_Specified;
    property allegatoPreventivo:             string         Index (IS_OPTN or IS_UNQL) read FallegatoPreventivo write SetallegatoPreventivo stored allegatoPreventivo_Specified;
    property area:                           string         Index (IS_OPTN or IS_UNQL) read Farea write Setarea stored area_Specified;
    property assessorato:                    assessorato    Index (IS_OPTN or IS_UNQL) read Fassessorato write Setassessorato stored assessorato_Specified;
    property cdc:                            centroDiCosto  Index (IS_OPTN or IS_UNQL) read Fcdc write Setcdc stored cdc_Specified;
    property cdcEntrataCollegato:            settore        Index (IS_OPTN or IS_UNQL) read FcdcEntrataCollegato write SetcdcEntrataCollegato stored cdcEntrataCollegato_Specified;
    property coel:                           string         Index (IS_OPTN or IS_UNQL) read Fcoel write Setcoel stored coel_Specified;
    property coelEntrataCollegato:           string         Index (IS_OPTN or IS_UNQL) read FcoelEntrataCollegato write SetcoelEntrataCollegato stored coelEntrataCollegato_Specified;
    property dataAgg:                        TXSDateTime    Index (IS_OPTN or IS_UNQL) read FdataAgg write SetdataAgg stored dataAgg_Specified;
    property dataIns:                        TXSDateTime    Index (IS_OPTN or IS_UNQL) read FdataIns write SetdataIns stored dataIns_Specified;
    property descriAllegatoConsuntivo:       string         Index (IS_OPTN or IS_UNQL) read FdescriAllegatoConsuntivo write SetdescriAllegatoConsuntivo stored descriAllegatoConsuntivo_Specified;
    property descriAllegatoPreventivo:       string         Index (IS_OPTN or IS_UNQL) read FdescriAllegatoPreventivo write SetdescriAllegatoPreventivo stored descriAllegatoPreventivo_Specified;
    property descriArea:                     string         Index (IS_OPTN or IS_UNQL) read FdescriArea write SetdescriArea stored descriArea_Specified;
    property descriCoel:                     string         Index (IS_OPTN or IS_UNQL) read FdescriCoel write SetdescriCoel stored descriCoel_Specified;
    property descriTipoFin:                  string         Index (IS_OPTN or IS_UNQL) read FdescriTipoFin write SetdescriTipoFin stored descriTipoFin_Specified;
    property impegnatoEsercizioChiuso:       string         Index (IS_OPTN or IS_UNQL) read FimpegnatoEsercizioChiuso write SetimpegnatoEsercizioChiuso stored impegnatoEsercizioChiuso_Specified;
    property numeroArticolo:                 Integer        Index (IS_UNQL) read FnumeroArticolo write FnumeroArticolo;
    property numeroArticoloEntrataCollegato: Integer        Index (IS_UNQL) read FnumeroArticoloEntrataCollegato write FnumeroArticoloEntrataCollegato;
    property numeroCapitolo:                 Integer        Index (IS_UNQL) read FnumeroCapitolo write FnumeroCapitolo;
    property numeroCapitoloEntrataCollegato: Integer        Index (IS_UNQL) read FnumeroCapitoloEntrataCollegato write FnumeroCapitoloEntrataCollegato;
    property stanziamentoAnnoPrec:           string         Index (IS_OPTN or IS_UNQL) read FstanziamentoAnnoPrec write SetstanziamentoAnnoPrec stored stanziamentoAnnoPrec_Specified;
    property stanziamentoAttuale:            string         Index (IS_OPTN or IS_UNQL) read FstanziamentoAttuale write SetstanziamentoAttuale stored stanziamentoAttuale_Specified;
    property tipoFin:                        string         Index (IS_OPTN or IS_UNQL) read FtipoFin write SettipoFin stored tipoFin_Specified;
    property tipoFinEntrataCollegato:        string         Index (IS_OPTN or IS_UNQL) read FtipoFinEntrataCollegato write SettipoFinEntrataCollegato stored tipoFinEntrataCollegato_Specified;
    property utenteAgg:                      string         Index (IS_OPTN or IS_UNQL) read FutenteAgg write SetutenteAgg stored utenteAgg_Specified;
    property utenteIns:                      string         Index (IS_OPTN or IS_UNQL) read FutenteIns write SetutenteIns stored utenteIns_Specified;
  end;



  // ************************************************************************ //
  // XML       : voceEconomica, global, <complexType>
  // Namespace : http://ws.service.business.bilsrvcp.csi.it/
  // ************************************************************************ //
  voceEconomica = class(TRemotable)
  private
    FdescrizioneVoceEco: string;
    FdescrizioneVoceEco_Specified: boolean;
    FvoceEco: string;
    FvoceEco_Specified: boolean;
    procedure SetdescrizioneVoceEco(Index: Integer; const Astring: string);
    function  descrizioneVoceEco_Specified(Index: Integer): boolean;
    procedure SetvoceEco(Index: Integer; const Astring: string);
    function  voceEco_Specified(Index: Integer): boolean;
  published
    property descrizioneVoceEco: string  Index (IS_OPTN or IS_UNQL) read FdescrizioneVoceEco write SetdescrizioneVoceEco stored descrizioneVoceEco_Specified;
    property voceEco:            string  Index (IS_OPTN or IS_UNQL) read FvoceEco write SetvoceEco stored voceEco_Specified;
  end;



  // ************************************************************************ //
  // XML       : estremiCapitoloSpesa, global, <complexType>
  // Namespace : http://ws.service.business.bilsrvcp.csi.it/
  // ************************************************************************ //
  estremiCapitoloSpesa = class(TRemotable)
  private
    Fanno: string;
    Fanno_Specified: boolean;
    Fnumero: Integer;
    procedure Setanno(Index: Integer; const Astring: string);
    function  anno_Specified(Index: Integer): boolean;
  published
    property anno:   string   Index (IS_OPTN or IS_UNQL) read Fanno write Setanno stored anno_Specified;
    property numero: Integer  Index (IS_UNQL) read Fnumero write Fnumero;
  end;



  // ************************************************************************ //
  // XML       : estremiCapitoloUscita, global, <complexType>
  // Namespace : http://ws.service.business.bilsrvcp.csi.it/
  // ************************************************************************ //
  estremiCapitoloUscita = class(estremiCapitoloSpesa)
  private
    FnumeroArticolo: Integer;
  published
    property numeroArticolo: Integer  Index (IS_UNQL) read FnumeroArticolo write FnumeroArticolo;
  end;



  // ************************************************************************ //
  // XML       : assessorato, global, <complexType>
  // Namespace : http://ws.service.business.bilsrvcp.csi.it/
  // ************************************************************************ //
  assessorato = class(TRemotable)
  private
    Fcodice: string;
    Fcodice_Specified: boolean;
    Fdescrizione: string;
    Fdescrizione_Specified: boolean;
    procedure Setcodice(Index: Integer; const Astring: string);
    function  codice_Specified(Index: Integer): boolean;
    procedure Setdescrizione(Index: Integer; const Astring: string);
    function  descrizione_Specified(Index: Integer): boolean;
  published
    property codice:      string  Index (IS_OPTN or IS_UNQL) read Fcodice write Setcodice stored codice_Specified;
    property descrizione: string  Index (IS_OPTN or IS_UNQL) read Fdescrizione write Setdescrizione stored descrizione_Specified;
  end;



  // ************************************************************************ //
  // XML       : settore, global, <complexType>
  // Namespace : http://ws.service.business.bilsrvcp.csi.it/
  // ************************************************************************ //
  settore = class(TRemotable)
  private
    Fcdc: string;
    Fcdc_Specified: boolean;
    FtipoCdc: string;
    FtipoCdc_Specified: boolean;
    procedure Setcdc(Index: Integer; const Astring: string);
    function  cdc_Specified(Index: Integer): boolean;
    procedure SettipoCdc(Index: Integer; const Astring: string);
    function  tipoCdc_Specified(Index: Integer): boolean;
  published
    property cdc:     string  Index (IS_OPTN or IS_UNQL) read Fcdc write Setcdc stored cdc_Specified;
    property tipoCdc: string  Index (IS_OPTN or IS_UNQL) read FtipoCdc write SettipoCdc stored tipoCdc_Specified;
  end;



  // ************************************************************************ //
  // XML       : centroDiCosto, global, <complexType>
  // Namespace : http://ws.service.business.bilsrvcp.csi.it/
  // ************************************************************************ //
  centroDiCosto = class(settore)
  private
    FannoCreazione: string;
    FannoCreazione_Specified: boolean;
    Fassessorato: assessorato;
    Fassessorato_Specified: boolean;
    Fcdr: estremiCdR;
    Fcdr_Specified: boolean;
    FcodAzienda: Integer;
    FdescrizioneCdc: string;
    FdescrizioneCdc_Specified: boolean;
    FdescrizioneTipoCdc: string;
    FdescrizioneTipoCdc_Specified: boolean;
    FdescrzioneCodAzienda: string;
    FdescrzioneCodAzienda_Specified: boolean;
    Fente: ente;
    Fente_Specified: boolean;
    FresponsabileCdc: string;
    FresponsabileCdc_Specified: boolean;
    procedure SetannoCreazione(Index: Integer; const Astring: string);
    function  annoCreazione_Specified(Index: Integer): boolean;
    procedure Setassessorato(Index: Integer; const Aassessorato: assessorato);
    function  assessorato_Specified(Index: Integer): boolean;
    procedure Setcdr(Index: Integer; const AestremiCdR: estremiCdR);
    function  cdr_Specified(Index: Integer): boolean;
    procedure SetdescrizioneCdc(Index: Integer; const Astring: string);
    function  descrizioneCdc_Specified(Index: Integer): boolean;
    procedure SetdescrizioneTipoCdc(Index: Integer; const Astring: string);
    function  descrizioneTipoCdc_Specified(Index: Integer): boolean;
    procedure SetdescrzioneCodAzienda(Index: Integer; const Astring: string);
    function  descrzioneCodAzienda_Specified(Index: Integer): boolean;
    procedure Setente(Index: Integer; const Aente: ente);
    function  ente_Specified(Index: Integer): boolean;
    procedure SetresponsabileCdc(Index: Integer; const Astring: string);
    function  responsabileCdc_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property annoCreazione:        string       Index (IS_OPTN or IS_UNQL) read FannoCreazione write SetannoCreazione stored annoCreazione_Specified;
    property assessorato:          assessorato  Index (IS_OPTN or IS_UNQL) read Fassessorato write Setassessorato stored assessorato_Specified;
    property cdr:                  estremiCdR   Index (IS_OPTN or IS_UNQL) read Fcdr write Setcdr stored cdr_Specified;
    property codAzienda:           Integer      Index (IS_UNQL) read FcodAzienda write FcodAzienda;
    property descrizioneCdc:       string       Index (IS_OPTN or IS_UNQL) read FdescrizioneCdc write SetdescrizioneCdc stored descrizioneCdc_Specified;
    property descrizioneTipoCdc:   string       Index (IS_OPTN or IS_UNQL) read FdescrizioneTipoCdc write SetdescrizioneTipoCdc stored descrizioneTipoCdc_Specified;
    property descrzioneCodAzienda: string       Index (IS_OPTN or IS_UNQL) read FdescrzioneCodAzienda write SetdescrzioneCodAzienda stored descrzioneCodAzienda_Specified;
    property ente:                 ente         Index (IS_OPTN or IS_UNQL) read Fente write Setente stored ente_Specified;
    property responsabileCdc:      string       Index (IS_OPTN or IS_UNQL) read FresponsabileCdc write SetresponsabileCdc stored responsabileCdc_Specified;
  end;



  // ************************************************************************ //
  // XML       : importiUEBSpesa, global, <complexType>
  // Namespace : http://ws.service.business.bilsrvcp.csi.it/
  // ************************************************************************ //
  importiUEBSpesa = class(TRemotable)
  private
    FimportoDisponibile: string;
    FimportoDisponibile_Specified: boolean;
    FimportoEmesso: string;
    FimportoEmesso_Specified: boolean;
    FimportoImpegnatoDefinitivo: string;
    FimportoImpegnatoDefinitivo_Specified: boolean;
    FimportoImpegnatoProvvisorio: string;
    FimportoImpegnatoProvvisorio_Specified: boolean;
    FimportoPagato: string;
    FimportoPagato_Specified: boolean;
    FimportoPreimpegnato: string;
    FimportoPreimpegnato_Specified: boolean;
    FstanziamentoAnnoPrecedente: string;
    FstanziamentoAnnoPrecedente_Specified: boolean;
    FstanziamentoAttualeDefinitivo: string;
    FstanziamentoAttualeDefinitivo_Specified: boolean;
    FstanziamentoInizialeResiduo: string;
    FstanziamentoInizialeResiduo_Specified: boolean;
    FvariazioniBilancioDefinitive: string;
    FvariazioniBilancioDefinitive_Specified: boolean;
    FvariazioniBilancioProvvisorie: string;
    FvariazioniBilancioProvvisorie_Specified: boolean;
    procedure SetimportoDisponibile(Index: Integer; const Astring: string);
    function  importoDisponibile_Specified(Index: Integer): boolean;
    procedure SetimportoEmesso(Index: Integer; const Astring: string);
    function  importoEmesso_Specified(Index: Integer): boolean;
    procedure SetimportoImpegnatoDefinitivo(Index: Integer; const Astring: string);
    function  importoImpegnatoDefinitivo_Specified(Index: Integer): boolean;
    procedure SetimportoImpegnatoProvvisorio(Index: Integer; const Astring: string);
    function  importoImpegnatoProvvisorio_Specified(Index: Integer): boolean;
    procedure SetimportoPagato(Index: Integer; const Astring: string);
    function  importoPagato_Specified(Index: Integer): boolean;
    procedure SetimportoPreimpegnato(Index: Integer; const Astring: string);
    function  importoPreimpegnato_Specified(Index: Integer): boolean;
    procedure SetstanziamentoAnnoPrecedente(Index: Integer; const Astring: string);
    function  stanziamentoAnnoPrecedente_Specified(Index: Integer): boolean;
    procedure SetstanziamentoAttualeDefinitivo(Index: Integer; const Astring: string);
    function  stanziamentoAttualeDefinitivo_Specified(Index: Integer): boolean;
    procedure SetstanziamentoInizialeResiduo(Index: Integer; const Astring: string);
    function  stanziamentoInizialeResiduo_Specified(Index: Integer): boolean;
    procedure SetvariazioniBilancioDefinitive(Index: Integer; const Astring: string);
    function  variazioniBilancioDefinitive_Specified(Index: Integer): boolean;
    procedure SetvariazioniBilancioProvvisorie(Index: Integer; const Astring: string);
    function  variazioniBilancioProvvisorie_Specified(Index: Integer): boolean;
  published
    property importoDisponibile:            string  Index (IS_OPTN or IS_UNQL) read FimportoDisponibile write SetimportoDisponibile stored importoDisponibile_Specified;
    property importoEmesso:                 string  Index (IS_OPTN or IS_UNQL) read FimportoEmesso write SetimportoEmesso stored importoEmesso_Specified;
    property importoImpegnatoDefinitivo:    string  Index (IS_OPTN or IS_UNQL) read FimportoImpegnatoDefinitivo write SetimportoImpegnatoDefinitivo stored importoImpegnatoDefinitivo_Specified;
    property importoImpegnatoProvvisorio:   string  Index (IS_OPTN or IS_UNQL) read FimportoImpegnatoProvvisorio write SetimportoImpegnatoProvvisorio stored importoImpegnatoProvvisorio_Specified;
    property importoPagato:                 string  Index (IS_OPTN or IS_UNQL) read FimportoPagato write SetimportoPagato stored importoPagato_Specified;
    property importoPreimpegnato:           string  Index (IS_OPTN or IS_UNQL) read FimportoPreimpegnato write SetimportoPreimpegnato stored importoPreimpegnato_Specified;
    property stanziamentoAnnoPrecedente:    string  Index (IS_OPTN or IS_UNQL) read FstanziamentoAnnoPrecedente write SetstanziamentoAnnoPrecedente stored stanziamentoAnnoPrecedente_Specified;
    property stanziamentoAttualeDefinitivo: string  Index (IS_OPTN or IS_UNQL) read FstanziamentoAttualeDefinitivo write SetstanziamentoAttualeDefinitivo stored stanziamentoAttualeDefinitivo_Specified;
    property stanziamentoInizialeResiduo:   string  Index (IS_OPTN or IS_UNQL) read FstanziamentoInizialeResiduo write SetstanziamentoInizialeResiduo stored stanziamentoInizialeResiduo_Specified;
    property variazioniBilancioDefinitive:  string  Index (IS_OPTN or IS_UNQL) read FvariazioniBilancioDefinitive write SetvariazioniBilancioDefinitive stored variazioniBilancioDefinitive_Specified;
    property variazioniBilancioProvvisorie: string  Index (IS_OPTN or IS_UNQL) read FvariazioniBilancioProvvisorie write SetvariazioniBilancioProvvisorie stored variazioniBilancioProvvisorie_Specified;
  end;



  // ************************************************************************ //
  // XML       : ServiceSystemException, global, <complexType>
  // Namespace : http://ws.service.business.bilsrvcp.csi.it/
  // ************************************************************************ //
  ServiceSystemException = class(TRemotable)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : BusinessException, global, <complexType>
  // Namespace : http://ws.service.business.bilsrvcp.csi.it/
  // ************************************************************************ //
  BusinessException = class(TRemotable)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ServiceSystemException, global, <element>
  // Namespace : http://ws.service.business.bilsrvcp.csi.it/
  // Info      : Fault
  // Base Types: ServiceSystemException
  // ************************************************************************ //
  ServiceSystemException2 = class(ERemotableException)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : BusinessException, global, <element>
  // Namespace : http://ws.service.business.bilsrvcp.csi.it/
  // Info      : Fault
  // Base Types: BusinessException
  // ************************************************************************ //
  BusinessException2 = class(ERemotableException)
  private
  published
  end;

  Array_Of_ueb = array of ueb;                  { "http://ws.service.business.bilsrvcp.csi.it/"[GblUbnd] }


  // ************************************************************************ //
  // XML       : capitoloUscita, global, <complexType>
  // Namespace : http://ws.service.business.bilsrvcp.csi.it/
  // ************************************************************************ //
  capitoloUscita = class(estremiCapitoloUscita)
  private
    FallegatoConsuntivo: string;
    FallegatoConsuntivo_Specified: boolean;
    FallegatoPreventivo: string;
    FallegatoPreventivo_Specified: boolean;
    FannoEsercizio: string;
    FannoEsercizio_Specified: boolean;
    FcdrAssegnatarioPeg: estremiCdR;
    FcdrAssegnatarioPeg_Specified: boolean;
    FcdrAssegnatarioSpesa: estremiCdR;
    FcdrAssegnatarioSpesa_Specified: boolean;
    FcodIstat: string;
    FcodIstat_Specified: boolean;
    FcodPattoStabilita: string;
    FcodPattoStabilita_Specified: boolean;
    FcodRaggruppamento: string;
    FcodRaggruppamento_Specified: boolean;
    FcodiceGestionale: string;
    FcodiceGestionale_Specified: boolean;
    FcontoVincolato: Integer;
    FdataAgg: TXSDateTime;
    FdataAgg_Specified: boolean;
    FdataIns: TXSDateTime;
    FdataIns_Specified: boolean;
    FdescriAllegatoConsuntivo: string;
    FdescriAllegatoConsuntivo_Specified: boolean;
    FdescriAllegatoPreventivo: string;
    FdescriAllegatoPreventivo_Specified: boolean;
    FdescriArticolo: string;
    FdescriArticolo_Specified: boolean;
    FdescriCapitolo: string;
    FdescriCapitolo_Specified: boolean;
    FdescriCodPattoStabilita: string;
    FdescriCodPattoStabilita_Specified: boolean;
    FdescriCodRaggruppamento: string;
    FdescriCodRaggruppamento_Specified: boolean;
    FdescriCodiceGestionale: string;
    FdescriCodiceGestionale_Specified: boolean;
    FdescriContoVincolato: string;
    FdescriContoVincolato_Specified: boolean;
    FdescriProgetto: string;
    FdescriProgetto_Specified: boolean;
    FdescriProgramma: string;
    FdescriProgramma_Specified: boolean;
    Fente: ente;
    Fente_Specified: boolean;
    Ffunzione: funzione;
    Ffunzione_Specified: boolean;
    FfunzioniDelegateRegione: string;
    FfunzioniDelegateRegione_Specified: boolean;
    FimpegnatoEsercChiuso: string;
    FimpegnatoEsercChiuso_Specified: boolean;
    Fintervento: intervento;
    Fintervento_Specified: boolean;
    FnroArtEntrataCollegato: Integer;
    FnroCapEntrataCollegato: Integer;
    Fprogetto: string;
    Fprogetto_Specified: boolean;
    Fprogramma: string;
    Fprogramma_Specified: boolean;
    FrilevanzaIVA: string;
    FrilevanzaIVA_Specified: boolean;
    Fservizio: servizio;
    Fservizio_Specified: boolean;
    FstanzAttuale: string;
    FstanzAttuale_Specified: boolean;
    FstanziamentoAnnoPrec: string;
    FstanziamentoAnnoPrec_Specified: boolean;
    FtipoSpesa: string;
    FtipoSpesa_Specified: boolean;
    Ftitolo: titoloUscita;
    Ftitolo_Specified: boolean;
    FtrasferimentiOrganismiComunitari: string;
    FtrasferimentiOrganismiComunitari_Specified: boolean;
    Fueb: Array_Of_ueb;
    Fueb_Specified: boolean;
    FutenteAgg: string;
    FutenteAgg_Specified: boolean;
    FutenteIns: string;
    FutenteIns_Specified: boolean;
    FvoceEconomica: voceEconomica;
    FvoceEconomica_Specified: boolean;
    procedure SetallegatoConsuntivo(Index: Integer; const Astring: string);
    function  allegatoConsuntivo_Specified(Index: Integer): boolean;
    procedure SetallegatoPreventivo(Index: Integer; const Astring: string);
    function  allegatoPreventivo_Specified(Index: Integer): boolean;
    procedure SetannoEsercizio(Index: Integer; const Astring: string);
    function  annoEsercizio_Specified(Index: Integer): boolean;
    procedure SetcdrAssegnatarioPeg(Index: Integer; const AestremiCdR: estremiCdR);
    function  cdrAssegnatarioPeg_Specified(Index: Integer): boolean;
    procedure SetcdrAssegnatarioSpesa(Index: Integer; const AestremiCdR: estremiCdR);
    function  cdrAssegnatarioSpesa_Specified(Index: Integer): boolean;
    procedure SetcodIstat(Index: Integer; const Astring: string);
    function  codIstat_Specified(Index: Integer): boolean;
    procedure SetcodPattoStabilita(Index: Integer; const Astring: string);
    function  codPattoStabilita_Specified(Index: Integer): boolean;
    procedure SetcodRaggruppamento(Index: Integer; const Astring: string);
    function  codRaggruppamento_Specified(Index: Integer): boolean;
    procedure SetcodiceGestionale(Index: Integer; const Astring: string);
    function  codiceGestionale_Specified(Index: Integer): boolean;
    procedure SetdataAgg(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  dataAgg_Specified(Index: Integer): boolean;
    procedure SetdataIns(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  dataIns_Specified(Index: Integer): boolean;
    procedure SetdescriAllegatoConsuntivo(Index: Integer; const Astring: string);
    function  descriAllegatoConsuntivo_Specified(Index: Integer): boolean;
    procedure SetdescriAllegatoPreventivo(Index: Integer; const Astring: string);
    function  descriAllegatoPreventivo_Specified(Index: Integer): boolean;
    procedure SetdescriArticolo(Index: Integer; const Astring: string);
    function  descriArticolo_Specified(Index: Integer): boolean;
    procedure SetdescriCapitolo(Index: Integer; const Astring: string);
    function  descriCapitolo_Specified(Index: Integer): boolean;
    procedure SetdescriCodPattoStabilita(Index: Integer; const Astring: string);
    function  descriCodPattoStabilita_Specified(Index: Integer): boolean;
    procedure SetdescriCodRaggruppamento(Index: Integer; const Astring: string);
    function  descriCodRaggruppamento_Specified(Index: Integer): boolean;
    procedure SetdescriCodiceGestionale(Index: Integer; const Astring: string);
    function  descriCodiceGestionale_Specified(Index: Integer): boolean;
    procedure SetdescriContoVincolato(Index: Integer; const Astring: string);
    function  descriContoVincolato_Specified(Index: Integer): boolean;
    procedure SetdescriProgetto(Index: Integer; const Astring: string);
    function  descriProgetto_Specified(Index: Integer): boolean;
    procedure SetdescriProgramma(Index: Integer; const Astring: string);
    function  descriProgramma_Specified(Index: Integer): boolean;
    procedure Setente(Index: Integer; const Aente: ente);
    function  ente_Specified(Index: Integer): boolean;
    procedure Setfunzione(Index: Integer; const Afunzione: funzione);
    function  funzione_Specified(Index: Integer): boolean;
    procedure SetfunzioniDelegateRegione(Index: Integer; const Astring: string);
    function  funzioniDelegateRegione_Specified(Index: Integer): boolean;
    procedure SetimpegnatoEsercChiuso(Index: Integer; const Astring: string);
    function  impegnatoEsercChiuso_Specified(Index: Integer): boolean;
    procedure Setintervento(Index: Integer; const Aintervento: intervento);
    function  intervento_Specified(Index: Integer): boolean;
    procedure Setprogetto(Index: Integer; const Astring: string);
    function  progetto_Specified(Index: Integer): boolean;
    procedure Setprogramma(Index: Integer; const Astring: string);
    function  programma_Specified(Index: Integer): boolean;
    procedure SetrilevanzaIVA(Index: Integer; const Astring: string);
    function  rilevanzaIVA_Specified(Index: Integer): boolean;
    procedure Setservizio(Index: Integer; const Aservizio: servizio);
    function  servizio_Specified(Index: Integer): boolean;
    procedure SetstanzAttuale(Index: Integer; const Astring: string);
    function  stanzAttuale_Specified(Index: Integer): boolean;
    procedure SetstanziamentoAnnoPrec(Index: Integer; const Astring: string);
    function  stanziamentoAnnoPrec_Specified(Index: Integer): boolean;
    procedure SettipoSpesa(Index: Integer; const Astring: string);
    function  tipoSpesa_Specified(Index: Integer): boolean;
    procedure Settitolo(Index: Integer; const AtitoloUscita: titoloUscita);
    function  titolo_Specified(Index: Integer): boolean;
    procedure SettrasferimentiOrganismiComunitari(Index: Integer; const Astring: string);
    function  trasferimentiOrganismiComunitari_Specified(Index: Integer): boolean;
    procedure Setueb(Index: Integer; const AArray_Of_ueb: Array_Of_ueb);
    function  ueb_Specified(Index: Integer): boolean;
    procedure SetutenteAgg(Index: Integer; const Astring: string);
    function  utenteAgg_Specified(Index: Integer): boolean;
    procedure SetutenteIns(Index: Integer; const Astring: string);
    function  utenteIns_Specified(Index: Integer): boolean;
    procedure SetvoceEconomica(Index: Integer; const AvoceEconomica: voceEconomica);
    function  voceEconomica_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property allegatoConsuntivo:               string         Index (IS_OPTN or IS_UNQL) read FallegatoConsuntivo write SetallegatoConsuntivo stored allegatoConsuntivo_Specified;
    property allegatoPreventivo:               string         Index (IS_OPTN or IS_UNQL) read FallegatoPreventivo write SetallegatoPreventivo stored allegatoPreventivo_Specified;
    property annoEsercizio:                    string         Index (IS_OPTN or IS_UNQL) read FannoEsercizio write SetannoEsercizio stored annoEsercizio_Specified;
    property cdrAssegnatarioPeg:               estremiCdR     Index (IS_OPTN or IS_UNQL) read FcdrAssegnatarioPeg write SetcdrAssegnatarioPeg stored cdrAssegnatarioPeg_Specified;
    property cdrAssegnatarioSpesa:             estremiCdR     Index (IS_OPTN or IS_UNQL) read FcdrAssegnatarioSpesa write SetcdrAssegnatarioSpesa stored cdrAssegnatarioSpesa_Specified;
    property codIstat:                         string         Index (IS_OPTN or IS_UNQL) read FcodIstat write SetcodIstat stored codIstat_Specified;
    property codPattoStabilita:                string         Index (IS_OPTN or IS_UNQL) read FcodPattoStabilita write SetcodPattoStabilita stored codPattoStabilita_Specified;
    property codRaggruppamento:                string         Index (IS_OPTN or IS_UNQL) read FcodRaggruppamento write SetcodRaggruppamento stored codRaggruppamento_Specified;
    property codiceGestionale:                 string         Index (IS_OPTN or IS_UNQL) read FcodiceGestionale write SetcodiceGestionale stored codiceGestionale_Specified;
    property contoVincolato:                   Integer        Index (IS_UNQL) read FcontoVincolato write FcontoVincolato;
    property dataAgg:                          TXSDateTime    Index (IS_OPTN or IS_UNQL) read FdataAgg write SetdataAgg stored dataAgg_Specified;
    property dataIns:                          TXSDateTime    Index (IS_OPTN or IS_UNQL) read FdataIns write SetdataIns stored dataIns_Specified;
    property descriAllegatoConsuntivo:         string         Index (IS_OPTN or IS_UNQL) read FdescriAllegatoConsuntivo write SetdescriAllegatoConsuntivo stored descriAllegatoConsuntivo_Specified;
    property descriAllegatoPreventivo:         string         Index (IS_OPTN or IS_UNQL) read FdescriAllegatoPreventivo write SetdescriAllegatoPreventivo stored descriAllegatoPreventivo_Specified;
    property descriArticolo:                   string         Index (IS_OPTN or IS_UNQL) read FdescriArticolo write SetdescriArticolo stored descriArticolo_Specified;
    property descriCapitolo:                   string         Index (IS_OPTN or IS_UNQL) read FdescriCapitolo write SetdescriCapitolo stored descriCapitolo_Specified;
    property descriCodPattoStabilita:          string         Index (IS_OPTN or IS_UNQL) read FdescriCodPattoStabilita write SetdescriCodPattoStabilita stored descriCodPattoStabilita_Specified;
    property descriCodRaggruppamento:          string         Index (IS_OPTN or IS_UNQL) read FdescriCodRaggruppamento write SetdescriCodRaggruppamento stored descriCodRaggruppamento_Specified;
    property descriCodiceGestionale:           string         Index (IS_OPTN or IS_UNQL) read FdescriCodiceGestionale write SetdescriCodiceGestionale stored descriCodiceGestionale_Specified;
    property descriContoVincolato:             string         Index (IS_OPTN or IS_UNQL) read FdescriContoVincolato write SetdescriContoVincolato stored descriContoVincolato_Specified;
    property descriProgetto:                   string         Index (IS_OPTN or IS_UNQL) read FdescriProgetto write SetdescriProgetto stored descriProgetto_Specified;
    property descriProgramma:                  string         Index (IS_OPTN or IS_UNQL) read FdescriProgramma write SetdescriProgramma stored descriProgramma_Specified;
    property ente:                             ente           Index (IS_OPTN or IS_UNQL) read Fente write Setente stored ente_Specified;
    property funzione:                         funzione       Index (IS_OPTN or IS_UNQL) read Ffunzione write Setfunzione stored funzione_Specified;
    property funzioniDelegateRegione:          string         Index (IS_OPTN or IS_UNQL) read FfunzioniDelegateRegione write SetfunzioniDelegateRegione stored funzioniDelegateRegione_Specified;
    property impegnatoEsercChiuso:             string         Index (IS_OPTN or IS_UNQL) read FimpegnatoEsercChiuso write SetimpegnatoEsercChiuso stored impegnatoEsercChiuso_Specified;
    property intervento:                       intervento     Index (IS_OPTN or IS_UNQL) read Fintervento write Setintervento stored intervento_Specified;
    property nroArtEntrataCollegato:           Integer        Index (IS_UNQL) read FnroArtEntrataCollegato write FnroArtEntrataCollegato;
    property nroCapEntrataCollegato:           Integer        Index (IS_UNQL) read FnroCapEntrataCollegato write FnroCapEntrataCollegato;
    property progetto:                         string         Index (IS_OPTN or IS_UNQL) read Fprogetto write Setprogetto stored progetto_Specified;
    property programma:                        string         Index (IS_OPTN or IS_UNQL) read Fprogramma write Setprogramma stored programma_Specified;
    property rilevanzaIVA:                     string         Index (IS_OPTN or IS_UNQL) read FrilevanzaIVA write SetrilevanzaIVA stored rilevanzaIVA_Specified;
    property servizio:                         servizio       Index (IS_OPTN or IS_UNQL) read Fservizio write Setservizio stored servizio_Specified;
    property stanzAttuale:                     string         Index (IS_OPTN or IS_UNQL) read FstanzAttuale write SetstanzAttuale stored stanzAttuale_Specified;
    property stanziamentoAnnoPrec:             string         Index (IS_OPTN or IS_UNQL) read FstanziamentoAnnoPrec write SetstanziamentoAnnoPrec stored stanziamentoAnnoPrec_Specified;
    property tipoSpesa:                        string         Index (IS_OPTN or IS_UNQL) read FtipoSpesa write SettipoSpesa stored tipoSpesa_Specified;
    property titolo:                           titoloUscita   Index (IS_OPTN or IS_UNQL) read Ftitolo write Settitolo stored titolo_Specified;
    property trasferimentiOrganismiComunitari: string         Index (IS_OPTN or IS_UNQL) read FtrasferimentiOrganismiComunitari write SettrasferimentiOrganismiComunitari stored trasferimentiOrganismiComunitari_Specified;
    property ueb:                              Array_Of_ueb   Index (IS_OPTN or IS_UNBD or IS_NLBL or IS_UNQL) read Fueb write Setueb stored ueb_Specified;
    property utenteAgg:                        string         Index (IS_OPTN or IS_UNQL) read FutenteAgg write SetutenteAgg stored utenteAgg_Specified;
    property utenteIns:                        string         Index (IS_OPTN or IS_UNQL) read FutenteIns write SetutenteIns stored utenteIns_Specified;
    property voceEconomica:                    voceEconomica  Index (IS_OPTN or IS_UNQL) read FvoceEconomica write SetvoceEconomica stored voceEconomica_Specified;
  end;



  // ************************************************************************ //
  // XML       : return, alias
  // Namespace : http://ws.service.business.bilsrvcp.csi.it/
  // ************************************************************************ //
  return = class(capitoloUscita)
  private
  published
  end;

  Array_Of_servizio = array of servizio;        { "http://ws.service.business.bilsrvcp.csi.it/"[GblUbnd] }


  // ************************************************************************ //
  // XML       : funzione, global, <complexType>
  // Namespace : http://ws.service.business.bilsrvcp.csi.it/
  // ************************************************************************ //
  funzione = class(TRemotable)
  private
    Fcodice: string;
    Fcodice_Specified: boolean;
    Fdescrizione: string;
    Fdescrizione_Specified: boolean;
    Fente: ente;
    Fente_Specified: boolean;
    Fservizio: Array_Of_servizio;
    Fservizio_Specified: boolean;
    procedure Setcodice(Index: Integer; const Astring: string);
    function  codice_Specified(Index: Integer): boolean;
    procedure Setdescrizione(Index: Integer; const Astring: string);
    function  descrizione_Specified(Index: Integer): boolean;
    procedure Setente(Index: Integer; const Aente: ente);
    function  ente_Specified(Index: Integer): boolean;
    procedure Setservizio(Index: Integer; const AArray_Of_servizio: Array_Of_servizio);
    function  servizio_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property codice:      string             Index (IS_OPTN or IS_UNQL) read Fcodice write Setcodice stored codice_Specified;
    property descrizione: string             Index (IS_OPTN or IS_UNQL) read Fdescrizione write Setdescrizione stored descrizione_Specified;
    property ente:        ente               Index (IS_OPTN or IS_UNQL) read Fente write Setente stored ente_Specified;
    property servizio:    Array_Of_servizio  Index (IS_OPTN or IS_UNBD or IS_NLBL or IS_UNQL) read Fservizio write Setservizio stored servizio_Specified;
  end;

  Array_Of_intervento = array of intervento;    { "http://ws.service.business.bilsrvcp.csi.it/"[GblUbnd] }


  // ************************************************************************ //
  // XML       : titoloUscita, global, <complexType>
  // Namespace : http://ws.service.business.bilsrvcp.csi.it/
  // ************************************************************************ //
  titoloUscita = class(TRemotable)
  private
    Fcodice: string;
    Fcodice_Specified: boolean;
    Fdescrizione: string;
    Fdescrizione_Specified: boolean;
    Fente: ente;
    Fente_Specified: boolean;
    Finterventi: Array_Of_intervento;
    Finterventi_Specified: boolean;
    procedure Setcodice(Index: Integer; const Astring: string);
    function  codice_Specified(Index: Integer): boolean;
    procedure Setdescrizione(Index: Integer; const Astring: string);
    function  descrizione_Specified(Index: Integer): boolean;
    procedure Setente(Index: Integer; const Aente: ente);
    function  ente_Specified(Index: Integer): boolean;
    procedure Setinterventi(Index: Integer; const AArray_Of_intervento: Array_Of_intervento);
    function  interventi_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property codice:      string               Index (IS_OPTN or IS_UNQL) read Fcodice write Setcodice stored codice_Specified;
    property descrizione: string               Index (IS_OPTN or IS_UNQL) read Fdescrizione write Setdescrizione stored descrizione_Specified;
    property ente:        ente                 Index (IS_OPTN or IS_UNQL) read Fente write Setente stored ente_Specified;
    property interventi:  Array_Of_intervento  Index (IS_OPTN or IS_UNBD or IS_NLBL or IS_UNQL) read Finterventi write Setinterventi stored interventi_Specified;
  end;

  Array_Of_capitoloUscita = array of capitoloUscita;   { "http://ws.service.business.bilsrvcp.csi.it/"[GblUbnd] }

  // ************************************************************************ //
  // Namespace : http://ws.service.business.bilsrvcp.csi.it/
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : BilancioWsObjectServiceSoapBinding
  // service   : BilancioWsObjectService
  // port      : BilancioWsObjectPort
  // URL       : http://dev-jboss43cp09-436.self.csi.it:54610/bilsrvws/BilancioWs/BilancioWs
  // ************************************************************************ //
  BilancioInterface = interface(IInvokable)
  ['{A179C182-02C7-EA5B-70EA-33014F0FB618}']
    function  getCapitoliUscita(const codiceAzienda: Integer; const annoEsercizio: string; const annoCapitolo: string): Array_Of_capitoloUscita; stdcall;
    function  getCapCdcUscitaDatiRiepilogo(const codiceAzienda: Integer; const annoEsercizio: string; const annoCapitolo: string; const numeroCapitolo: Integer; const numeroArticolo: Integer; const cdc: string;
                                           const coel: string; const tipoFinanziamento: string): importiUEBSpesa; stdcall;
  end;

function GetBilancioInterface(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): BilancioInterface;


implementation
  uses SysUtils;

function GetBilancioInterface(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): BilancioInterface;
const
  //defWSDL = 'http://dev-jboss43cp09-436.self.csi.it:54610/bilsrvws/BilancioWs/BilancioWs?wsdl';
  //defURL  = (sviluppo) 'http://dev-jboss43cp09-436.self.csi.it:54610/bilsrvws/BilancioWs/BilancioWs';
  //defURL  = (collaudo) 'http://coll-applogic.comune.torino.it/bilsrvws/BilancioWs/BilancioWs
  //defURL  = (produzione) 'http://applogic.comune.torino.it/bilsrvws/BilancioWs/BilancioWs
  defSvc  = 'BilancioWsObjectService';
  defPrt  = 'BilancioWsObjectPort';
var
  RIO: THTTPRIO;
  URL,defWSDL,defURL:String;
begin
  URL:=Addr;
  defWSDL:=URL + '?wsdl';
  defURL:=URL;

  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as BilancioInterface);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


procedure estremiCdR.SetannoCreazione(Index: Integer; const Astring: string);
begin
  FannoCreazione := Astring;
  FannoCreazione_Specified := True;
end;

function estremiCdR.annoCreazione_Specified(Index: Integer): boolean;
begin
  Result := FannoCreazione_Specified;
end;

procedure estremiCdR.SetcentroResp(Index: Integer; const Astring: string);
begin
  FcentroResp := Astring;
  FcentroResp_Specified := True;
end;

function estremiCdR.centroResp_Specified(Index: Integer): boolean;
begin
  Result := FcentroResp_Specified;
end;

procedure estremiCdR.Setdescrizione(Index: Integer; const Astring: string);
begin
  Fdescrizione := Astring;
  Fdescrizione_Specified := True;
end;

function estremiCdR.descrizione_Specified(Index: Integer): boolean;
begin
  Result := Fdescrizione_Specified;
end;

procedure ente.SetdescrizioneCodAzienda(Index: Integer; const Astring: string);
begin
  FdescrizioneCodAzienda := Astring;
  FdescrizioneCodAzienda_Specified := True;
end;

function ente.descrizioneCodAzienda_Specified(Index: Integer): boolean;
begin
  Result := FdescrizioneCodAzienda_Specified;
end;

destructor intervento.Destroy;
begin
  SysUtils.FreeAndNil(Ftitolo);
  inherited Destroy;
end;

procedure intervento.Setcodice(Index: Integer; const Astring: string);
begin
  Fcodice := Astring;
  Fcodice_Specified := True;
end;

function intervento.codice_Specified(Index: Integer): boolean;
begin
  Result := Fcodice_Specified;
end;

procedure intervento.Setdescrizione(Index: Integer; const Astring: string);
begin
  Fdescrizione := Astring;
  Fdescrizione_Specified := True;
end;

function intervento.descrizione_Specified(Index: Integer): boolean;
begin
  Result := Fdescrizione_Specified;
end;

procedure intervento.Settitolo(Index: Integer; const AtitoloUscita: titoloUscita);
begin
  Ftitolo := AtitoloUscita;
  Ftitolo_Specified := True;
end;

function intervento.titolo_Specified(Index: Integer): boolean;
begin
  Result := Ftitolo_Specified;
end;

destructor servizio.Destroy;
begin
  SysUtils.FreeAndNil(Ffunzione);
  inherited Destroy;
end;

procedure servizio.Setcodice(Index: Integer; const Astring: string);
begin
  Fcodice := Astring;
  Fcodice_Specified := True;
end;

function servizio.codice_Specified(Index: Integer): boolean;
begin
  Result := Fcodice_Specified;
end;

procedure servizio.Setdescrizione(Index: Integer; const Astring: string);
begin
  Fdescrizione := Astring;
  Fdescrizione_Specified := True;
end;

function servizio.descrizione_Specified(Index: Integer): boolean;
begin
  Result := Fdescrizione_Specified;
end;

procedure servizio.Setflrag(Index: Integer; const Astring: string);
begin
  Fflrag := Astring;
  Fflrag_Specified := True;
end;

function servizio.flrag_Specified(Index: Integer): boolean;
begin
  Result := Fflrag_Specified;
end;

procedure servizio.Setfunzione(Index: Integer; const Afunzione: funzione);
begin
  Ffunzione := Afunzione;
  Ffunzione_Specified := True;
end;

function servizio.funzione_Specified(Index: Integer): boolean;
begin
  Result := Ffunzione_Specified;
end;

procedure servizio.Setresponsabile(Index: Integer; const Astring: string);
begin
  Fresponsabile := Astring;
  Fresponsabile_Specified := True;
end;

function servizio.responsabile_Specified(Index: Integer): boolean;
begin
  Result := Fresponsabile_Specified;
end;

procedure servizio.Settipo(Index: Integer; const Astring: string);
begin
  Ftipo := Astring;
  Ftipo_Specified := True;
end;

function servizio.tipo_Specified(Index: Integer): boolean;
begin
  Result := Ftipo_Specified;
end;

destructor ueb.Destroy;
begin
  SysUtils.FreeAndNil(Fassessorato);
  SysUtils.FreeAndNil(Fcdc);
  SysUtils.FreeAndNil(FcdcEntrataCollegato);
  SysUtils.FreeAndNil(FdataAgg);
  SysUtils.FreeAndNil(FdataIns);
  inherited Destroy;
end;

procedure ueb.SetallegatoConsuntivo(Index: Integer; const Astring: string);
begin
  FallegatoConsuntivo := Astring;
  FallegatoConsuntivo_Specified := True;
end;

function ueb.allegatoConsuntivo_Specified(Index: Integer): boolean;
begin
  Result := FallegatoConsuntivo_Specified;
end;

procedure ueb.SetallegatoPreventivo(Index: Integer; const Astring: string);
begin
  FallegatoPreventivo := Astring;
  FallegatoPreventivo_Specified := True;
end;

function ueb.allegatoPreventivo_Specified(Index: Integer): boolean;
begin
  Result := FallegatoPreventivo_Specified;
end;

procedure ueb.Setarea(Index: Integer; const Astring: string);
begin
  Farea := Astring;
  Farea_Specified := True;
end;

function ueb.area_Specified(Index: Integer): boolean;
begin
  Result := Farea_Specified;
end;

procedure ueb.Setassessorato(Index: Integer; const Aassessorato: assessorato);
begin
  Fassessorato := Aassessorato;
  Fassessorato_Specified := True;
end;

function ueb.assessorato_Specified(Index: Integer): boolean;
begin
  Result := Fassessorato_Specified;
end;

procedure ueb.Setcdc(Index: Integer; const AcentroDiCosto: centroDiCosto);
begin
  Fcdc := AcentroDiCosto;
  Fcdc_Specified := True;
end;

function ueb.cdc_Specified(Index: Integer): boolean;
begin
  Result := Fcdc_Specified;
end;

procedure ueb.SetcdcEntrataCollegato(Index: Integer; const Asettore: settore);
begin
  FcdcEntrataCollegato := Asettore;
  FcdcEntrataCollegato_Specified := True;
end;

function ueb.cdcEntrataCollegato_Specified(Index: Integer): boolean;
begin
  Result := FcdcEntrataCollegato_Specified;
end;

procedure ueb.Setcoel(Index: Integer; const Astring: string);
begin
  Fcoel := Astring;
  Fcoel_Specified := True;
end;

function ueb.coel_Specified(Index: Integer): boolean;
begin
  Result := Fcoel_Specified;
end;

procedure ueb.SetcoelEntrataCollegato(Index: Integer; const Astring: string);
begin
  FcoelEntrataCollegato := Astring;
  FcoelEntrataCollegato_Specified := True;
end;

function ueb.coelEntrataCollegato_Specified(Index: Integer): boolean;
begin
  Result := FcoelEntrataCollegato_Specified;
end;

procedure ueb.SetdataAgg(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FdataAgg := ATXSDateTime;
  FdataAgg_Specified := True;
end;

function ueb.dataAgg_Specified(Index: Integer): boolean;
begin
  Result := FdataAgg_Specified;
end;

procedure ueb.SetdataIns(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FdataIns := ATXSDateTime;
  FdataIns_Specified := True;
end;

function ueb.dataIns_Specified(Index: Integer): boolean;
begin
  Result := FdataIns_Specified;
end;

procedure ueb.SetdescriAllegatoConsuntivo(Index: Integer; const Astring: string);
begin
  FdescriAllegatoConsuntivo := Astring;
  FdescriAllegatoConsuntivo_Specified := True;
end;

function ueb.descriAllegatoConsuntivo_Specified(Index: Integer): boolean;
begin
  Result := FdescriAllegatoConsuntivo_Specified;
end;

procedure ueb.SetdescriAllegatoPreventivo(Index: Integer; const Astring: string);
begin
  FdescriAllegatoPreventivo := Astring;
  FdescriAllegatoPreventivo_Specified := True;
end;

function ueb.descriAllegatoPreventivo_Specified(Index: Integer): boolean;
begin
  Result := FdescriAllegatoPreventivo_Specified;
end;

procedure ueb.SetdescriArea(Index: Integer; const Astring: string);
begin
  FdescriArea := Astring;
  FdescriArea_Specified := True;
end;

function ueb.descriArea_Specified(Index: Integer): boolean;
begin
  Result := FdescriArea_Specified;
end;

procedure ueb.SetdescriCoel(Index: Integer; const Astring: string);
begin
  FdescriCoel := Astring;
  FdescriCoel_Specified := True;
end;

function ueb.descriCoel_Specified(Index: Integer): boolean;
begin
  Result := FdescriCoel_Specified;
end;

procedure ueb.SetdescriTipoFin(Index: Integer; const Astring: string);
begin
  FdescriTipoFin := Astring;
  FdescriTipoFin_Specified := True;
end;

function ueb.descriTipoFin_Specified(Index: Integer): boolean;
begin
  Result := FdescriTipoFin_Specified;
end;

procedure ueb.SetimpegnatoEsercizioChiuso(Index: Integer; const Astring: string);
begin
  FimpegnatoEsercizioChiuso := Astring;
  FimpegnatoEsercizioChiuso_Specified := True;
end;

function ueb.impegnatoEsercizioChiuso_Specified(Index: Integer): boolean;
begin
  Result := FimpegnatoEsercizioChiuso_Specified;
end;

procedure ueb.SetstanziamentoAnnoPrec(Index: Integer; const Astring: string);
begin
  FstanziamentoAnnoPrec := Astring;
  FstanziamentoAnnoPrec_Specified := True;
end;

function ueb.stanziamentoAnnoPrec_Specified(Index: Integer): boolean;
begin
  Result := FstanziamentoAnnoPrec_Specified;
end;

procedure ueb.SetstanziamentoAttuale(Index: Integer; const Astring: string);
begin
  FstanziamentoAttuale := Astring;
  FstanziamentoAttuale_Specified := True;
end;

function ueb.stanziamentoAttuale_Specified(Index: Integer): boolean;
begin
  Result := FstanziamentoAttuale_Specified;
end;

procedure ueb.SettipoFin(Index: Integer; const Astring: string);
begin
  FtipoFin := Astring;
  FtipoFin_Specified := True;
end;

function ueb.tipoFin_Specified(Index: Integer): boolean;
begin
  Result := FtipoFin_Specified;
end;

procedure ueb.SettipoFinEntrataCollegato(Index: Integer; const Astring: string);
begin
  FtipoFinEntrataCollegato := Astring;
  FtipoFinEntrataCollegato_Specified := True;
end;

function ueb.tipoFinEntrataCollegato_Specified(Index: Integer): boolean;
begin
  Result := FtipoFinEntrataCollegato_Specified;
end;

procedure ueb.SetutenteAgg(Index: Integer; const Astring: string);
begin
  FutenteAgg := Astring;
  FutenteAgg_Specified := True;
end;

function ueb.utenteAgg_Specified(Index: Integer): boolean;
begin
  Result := FutenteAgg_Specified;
end;

procedure ueb.SetutenteIns(Index: Integer; const Astring: string);
begin
  FutenteIns := Astring;
  FutenteIns_Specified := True;
end;

function ueb.utenteIns_Specified(Index: Integer): boolean;
begin
  Result := FutenteIns_Specified;
end;

procedure voceEconomica.SetdescrizioneVoceEco(Index: Integer; const Astring: string);
begin
  FdescrizioneVoceEco := Astring;
  FdescrizioneVoceEco_Specified := True;
end;

function voceEconomica.descrizioneVoceEco_Specified(Index: Integer): boolean;
begin
  Result := FdescrizioneVoceEco_Specified;
end;

procedure voceEconomica.SetvoceEco(Index: Integer; const Astring: string);
begin
  FvoceEco := Astring;
  FvoceEco_Specified := True;
end;

function voceEconomica.voceEco_Specified(Index: Integer): boolean;
begin
  Result := FvoceEco_Specified;
end;

procedure estremiCapitoloSpesa.Setanno(Index: Integer; const Astring: string);
begin
  Fanno := Astring;
  Fanno_Specified := True;
end;

function estremiCapitoloSpesa.anno_Specified(Index: Integer): boolean;
begin
  Result := Fanno_Specified;
end;

procedure assessorato.Setcodice(Index: Integer; const Astring: string);
begin
  Fcodice := Astring;
  Fcodice_Specified := True;
end;

function assessorato.codice_Specified(Index: Integer): boolean;
begin
  Result := Fcodice_Specified;
end;

procedure assessorato.Setdescrizione(Index: Integer; const Astring: string);
begin
  Fdescrizione := Astring;
  Fdescrizione_Specified := True;
end;

function assessorato.descrizione_Specified(Index: Integer): boolean;
begin
  Result := Fdescrizione_Specified;
end;

procedure settore.Setcdc(Index: Integer; const Astring: string);
begin
  Fcdc := Astring;
  Fcdc_Specified := True;
end;

function settore.cdc_Specified(Index: Integer): boolean;
begin
  Result := Fcdc_Specified;
end;

procedure settore.SettipoCdc(Index: Integer; const Astring: string);
begin
  FtipoCdc := Astring;
  FtipoCdc_Specified := True;
end;

function settore.tipoCdc_Specified(Index: Integer): boolean;
begin
  Result := FtipoCdc_Specified;
end;

destructor centroDiCosto.Destroy;
begin
  SysUtils.FreeAndNil(Fassessorato);
  SysUtils.FreeAndNil(Fcdr);
  SysUtils.FreeAndNil(Fente);
  inherited Destroy;
end;

procedure centroDiCosto.SetannoCreazione(Index: Integer; const Astring: string);
begin
  FannoCreazione := Astring;
  FannoCreazione_Specified := True;
end;

function centroDiCosto.annoCreazione_Specified(Index: Integer): boolean;
begin
  Result := FannoCreazione_Specified;
end;

procedure centroDiCosto.Setassessorato(Index: Integer; const Aassessorato: assessorato);
begin
  Fassessorato := Aassessorato;
  Fassessorato_Specified := True;
end;

function centroDiCosto.assessorato_Specified(Index: Integer): boolean;
begin
  Result := Fassessorato_Specified;
end;

procedure centroDiCosto.Setcdr(Index: Integer; const AestremiCdR: estremiCdR);
begin
  Fcdr := AestremiCdR;
  Fcdr_Specified := True;
end;

function centroDiCosto.cdr_Specified(Index: Integer): boolean;
begin
  Result := Fcdr_Specified;
end;

procedure centroDiCosto.SetdescrizioneCdc(Index: Integer; const Astring: string);
begin
  FdescrizioneCdc := Astring;
  FdescrizioneCdc_Specified := True;
end;

function centroDiCosto.descrizioneCdc_Specified(Index: Integer): boolean;
begin
  Result := FdescrizioneCdc_Specified;
end;

procedure centroDiCosto.SetdescrizioneTipoCdc(Index: Integer; const Astring: string);
begin
  FdescrizioneTipoCdc := Astring;
  FdescrizioneTipoCdc_Specified := True;
end;

function centroDiCosto.descrizioneTipoCdc_Specified(Index: Integer): boolean;
begin
  Result := FdescrizioneTipoCdc_Specified;
end;

procedure centroDiCosto.SetdescrzioneCodAzienda(Index: Integer; const Astring: string);
begin
  FdescrzioneCodAzienda := Astring;
  FdescrzioneCodAzienda_Specified := True;
end;

function centroDiCosto.descrzioneCodAzienda_Specified(Index: Integer): boolean;
begin
  Result := FdescrzioneCodAzienda_Specified;
end;

procedure centroDiCosto.Setente(Index: Integer; const Aente: ente);
begin
  Fente := Aente;
  Fente_Specified := True;
end;

function centroDiCosto.ente_Specified(Index: Integer): boolean;
begin
  Result := Fente_Specified;
end;

procedure centroDiCosto.SetresponsabileCdc(Index: Integer; const Astring: string);
begin
  FresponsabileCdc := Astring;
  FresponsabileCdc_Specified := True;
end;

function centroDiCosto.responsabileCdc_Specified(Index: Integer): boolean;
begin
  Result := FresponsabileCdc_Specified;
end;

procedure importiUEBSpesa.SetimportoDisponibile(Index: Integer; const Astring: string);
begin
  FimportoDisponibile := Astring;
  FimportoDisponibile_Specified := True;
end;

function importiUEBSpesa.importoDisponibile_Specified(Index: Integer): boolean;
begin
  Result := FimportoDisponibile_Specified;
end;

procedure importiUEBSpesa.SetimportoEmesso(Index: Integer; const Astring: string);
begin
  FimportoEmesso := Astring;
  FimportoEmesso_Specified := True;
end;

function importiUEBSpesa.importoEmesso_Specified(Index: Integer): boolean;
begin
  Result := FimportoEmesso_Specified;
end;

procedure importiUEBSpesa.SetimportoImpegnatoDefinitivo(Index: Integer; const Astring: string);
begin
  FimportoImpegnatoDefinitivo := Astring;
  FimportoImpegnatoDefinitivo_Specified := True;
end;

function importiUEBSpesa.importoImpegnatoDefinitivo_Specified(Index: Integer): boolean;
begin
  Result := FimportoImpegnatoDefinitivo_Specified;
end;

procedure importiUEBSpesa.SetimportoImpegnatoProvvisorio(Index: Integer; const Astring: string);
begin
  FimportoImpegnatoProvvisorio := Astring;
  FimportoImpegnatoProvvisorio_Specified := True;
end;

function importiUEBSpesa.importoImpegnatoProvvisorio_Specified(Index: Integer): boolean;
begin
  Result := FimportoImpegnatoProvvisorio_Specified;
end;

procedure importiUEBSpesa.SetimportoPagato(Index: Integer; const Astring: string);
begin
  FimportoPagato := Astring;
  FimportoPagato_Specified := True;
end;

function importiUEBSpesa.importoPagato_Specified(Index: Integer): boolean;
begin
  Result := FimportoPagato_Specified;
end;

procedure importiUEBSpesa.SetimportoPreimpegnato(Index: Integer; const Astring: string);
begin
  FimportoPreimpegnato := Astring;
  FimportoPreimpegnato_Specified := True;
end;

function importiUEBSpesa.importoPreimpegnato_Specified(Index: Integer): boolean;
begin
  Result := FimportoPreimpegnato_Specified;
end;

procedure importiUEBSpesa.SetstanziamentoAnnoPrecedente(Index: Integer; const Astring: string);
begin
  FstanziamentoAnnoPrecedente := Astring;
  FstanziamentoAnnoPrecedente_Specified := True;
end;

function importiUEBSpesa.stanziamentoAnnoPrecedente_Specified(Index: Integer): boolean;
begin
  Result := FstanziamentoAnnoPrecedente_Specified;
end;

procedure importiUEBSpesa.SetstanziamentoAttualeDefinitivo(Index: Integer; const Astring: string);
begin
  FstanziamentoAttualeDefinitivo := Astring;
  FstanziamentoAttualeDefinitivo_Specified := True;
end;

function importiUEBSpesa.stanziamentoAttualeDefinitivo_Specified(Index: Integer): boolean;
begin
  Result := FstanziamentoAttualeDefinitivo_Specified;
end;

procedure importiUEBSpesa.SetstanziamentoInizialeResiduo(Index: Integer; const Astring: string);
begin
  FstanziamentoInizialeResiduo := Astring;
  FstanziamentoInizialeResiduo_Specified := True;
end;

function importiUEBSpesa.stanziamentoInizialeResiduo_Specified(Index: Integer): boolean;
begin
  Result := FstanziamentoInizialeResiduo_Specified;
end;

procedure importiUEBSpesa.SetvariazioniBilancioDefinitive(Index: Integer; const Astring: string);
begin
  FvariazioniBilancioDefinitive := Astring;
  FvariazioniBilancioDefinitive_Specified := True;
end;

function importiUEBSpesa.variazioniBilancioDefinitive_Specified(Index: Integer): boolean;
begin
  Result := FvariazioniBilancioDefinitive_Specified;
end;

procedure importiUEBSpesa.SetvariazioniBilancioProvvisorie(Index: Integer; const Astring: string);
begin
  FvariazioniBilancioProvvisorie := Astring;
  FvariazioniBilancioProvvisorie_Specified := True;
end;

function importiUEBSpesa.variazioniBilancioProvvisorie_Specified(Index: Integer): boolean;
begin
  Result := FvariazioniBilancioProvvisorie_Specified;
end;

destructor capitoloUscita.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fueb)-1 do
    SysUtils.FreeAndNil(Fueb[I]);
  System.SetLength(Fueb, 0);
  SysUtils.FreeAndNil(FcdrAssegnatarioPeg);
  SysUtils.FreeAndNil(FcdrAssegnatarioSpesa);
  SysUtils.FreeAndNil(FdataAgg);
  SysUtils.FreeAndNil(FdataIns);
  SysUtils.FreeAndNil(Fente);
  SysUtils.FreeAndNil(Ffunzione);
  SysUtils.FreeAndNil(Fintervento);
  SysUtils.FreeAndNil(Fservizio);
  SysUtils.FreeAndNil(Ftitolo);
  SysUtils.FreeAndNil(FvoceEconomica);
  inherited Destroy;
end;

procedure capitoloUscita.SetallegatoConsuntivo(Index: Integer; const Astring: string);
begin
  FallegatoConsuntivo := Astring;
  FallegatoConsuntivo_Specified := True;
end;

function capitoloUscita.allegatoConsuntivo_Specified(Index: Integer): boolean;
begin
  Result := FallegatoConsuntivo_Specified;
end;

procedure capitoloUscita.SetallegatoPreventivo(Index: Integer; const Astring: string);
begin
  FallegatoPreventivo := Astring;
  FallegatoPreventivo_Specified := True;
end;

function capitoloUscita.allegatoPreventivo_Specified(Index: Integer): boolean;
begin
  Result := FallegatoPreventivo_Specified;
end;

procedure capitoloUscita.SetannoEsercizio(Index: Integer; const Astring: string);
begin
  FannoEsercizio := Astring;
  FannoEsercizio_Specified := True;
end;

function capitoloUscita.annoEsercizio_Specified(Index: Integer): boolean;
begin
  Result := FannoEsercizio_Specified;
end;

procedure capitoloUscita.SetcdrAssegnatarioPeg(Index: Integer; const AestremiCdR: estremiCdR);
begin
  FcdrAssegnatarioPeg := AestremiCdR;
  FcdrAssegnatarioPeg_Specified := True;
end;

function capitoloUscita.cdrAssegnatarioPeg_Specified(Index: Integer): boolean;
begin
  Result := FcdrAssegnatarioPeg_Specified;
end;

procedure capitoloUscita.SetcdrAssegnatarioSpesa(Index: Integer; const AestremiCdR: estremiCdR);
begin
  FcdrAssegnatarioSpesa := AestremiCdR;
  FcdrAssegnatarioSpesa_Specified := True;
end;

function capitoloUscita.cdrAssegnatarioSpesa_Specified(Index: Integer): boolean;
begin
  Result := FcdrAssegnatarioSpesa_Specified;
end;

procedure capitoloUscita.SetcodIstat(Index: Integer; const Astring: string);
begin
  FcodIstat := Astring;
  FcodIstat_Specified := True;
end;

function capitoloUscita.codIstat_Specified(Index: Integer): boolean;
begin
  Result := FcodIstat_Specified;
end;

procedure capitoloUscita.SetcodPattoStabilita(Index: Integer; const Astring: string);
begin
  FcodPattoStabilita := Astring;
  FcodPattoStabilita_Specified := True;
end;

function capitoloUscita.codPattoStabilita_Specified(Index: Integer): boolean;
begin
  Result := FcodPattoStabilita_Specified;
end;

procedure capitoloUscita.SetcodRaggruppamento(Index: Integer; const Astring: string);
begin
  FcodRaggruppamento := Astring;
  FcodRaggruppamento_Specified := True;
end;

function capitoloUscita.codRaggruppamento_Specified(Index: Integer): boolean;
begin
  Result := FcodRaggruppamento_Specified;
end;

procedure capitoloUscita.SetcodiceGestionale(Index: Integer; const Astring: string);
begin
  FcodiceGestionale := Astring;
  FcodiceGestionale_Specified := True;
end;

function capitoloUscita.codiceGestionale_Specified(Index: Integer): boolean;
begin
  Result := FcodiceGestionale_Specified;
end;

procedure capitoloUscita.SetdataAgg(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FdataAgg := ATXSDateTime;
  FdataAgg_Specified := True;
end;

function capitoloUscita.dataAgg_Specified(Index: Integer): boolean;
begin
  Result := FdataAgg_Specified;
end;

procedure capitoloUscita.SetdataIns(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FdataIns := ATXSDateTime;
  FdataIns_Specified := True;
end;

function capitoloUscita.dataIns_Specified(Index: Integer): boolean;
begin
  Result := FdataIns_Specified;
end;

procedure capitoloUscita.SetdescriAllegatoConsuntivo(Index: Integer; const Astring: string);
begin
  FdescriAllegatoConsuntivo := Astring;
  FdescriAllegatoConsuntivo_Specified := True;
end;

function capitoloUscita.descriAllegatoConsuntivo_Specified(Index: Integer): boolean;
begin
  Result := FdescriAllegatoConsuntivo_Specified;
end;

procedure capitoloUscita.SetdescriAllegatoPreventivo(Index: Integer; const Astring: string);
begin
  FdescriAllegatoPreventivo := Astring;
  FdescriAllegatoPreventivo_Specified := True;
end;

function capitoloUscita.descriAllegatoPreventivo_Specified(Index: Integer): boolean;
begin
  Result := FdescriAllegatoPreventivo_Specified;
end;

procedure capitoloUscita.SetdescriArticolo(Index: Integer; const Astring: string);
begin
  FdescriArticolo := Astring;
  FdescriArticolo_Specified := True;
end;

function capitoloUscita.descriArticolo_Specified(Index: Integer): boolean;
begin
  Result := FdescriArticolo_Specified;
end;

procedure capitoloUscita.SetdescriCapitolo(Index: Integer; const Astring: string);
begin
  FdescriCapitolo := Astring;
  FdescriCapitolo_Specified := True;
end;

function capitoloUscita.descriCapitolo_Specified(Index: Integer): boolean;
begin
  Result := FdescriCapitolo_Specified;
end;

procedure capitoloUscita.SetdescriCodPattoStabilita(Index: Integer; const Astring: string);
begin
  FdescriCodPattoStabilita := Astring;
  FdescriCodPattoStabilita_Specified := True;
end;

function capitoloUscita.descriCodPattoStabilita_Specified(Index: Integer): boolean;
begin
  Result := FdescriCodPattoStabilita_Specified;
end;

procedure capitoloUscita.SetdescriCodRaggruppamento(Index: Integer; const Astring: string);
begin
  FdescriCodRaggruppamento := Astring;
  FdescriCodRaggruppamento_Specified := True;
end;

function capitoloUscita.descriCodRaggruppamento_Specified(Index: Integer): boolean;
begin
  Result := FdescriCodRaggruppamento_Specified;
end;

procedure capitoloUscita.SetdescriCodiceGestionale(Index: Integer; const Astring: string);
begin
  FdescriCodiceGestionale := Astring;
  FdescriCodiceGestionale_Specified := True;
end;

function capitoloUscita.descriCodiceGestionale_Specified(Index: Integer): boolean;
begin
  Result := FdescriCodiceGestionale_Specified;
end;

procedure capitoloUscita.SetdescriContoVincolato(Index: Integer; const Astring: string);
begin
  FdescriContoVincolato := Astring;
  FdescriContoVincolato_Specified := True;
end;

function capitoloUscita.descriContoVincolato_Specified(Index: Integer): boolean;
begin
  Result := FdescriContoVincolato_Specified;
end;

procedure capitoloUscita.SetdescriProgetto(Index: Integer; const Astring: string);
begin
  FdescriProgetto := Astring;
  FdescriProgetto_Specified := True;
end;

function capitoloUscita.descriProgetto_Specified(Index: Integer): boolean;
begin
  Result := FdescriProgetto_Specified;
end;

procedure capitoloUscita.SetdescriProgramma(Index: Integer; const Astring: string);
begin
  FdescriProgramma := Astring;
  FdescriProgramma_Specified := True;
end;

function capitoloUscita.descriProgramma_Specified(Index: Integer): boolean;
begin
  Result := FdescriProgramma_Specified;
end;

procedure capitoloUscita.Setente(Index: Integer; const Aente: ente);
begin
  Fente := Aente;
  Fente_Specified := True;
end;

function capitoloUscita.ente_Specified(Index: Integer): boolean;
begin
  Result := Fente_Specified;
end;

procedure capitoloUscita.Setfunzione(Index: Integer; const Afunzione: funzione);
begin
  Ffunzione := Afunzione;
  Ffunzione_Specified := True;
end;

function capitoloUscita.funzione_Specified(Index: Integer): boolean;
begin
  Result := Ffunzione_Specified;
end;

procedure capitoloUscita.SetfunzioniDelegateRegione(Index: Integer; const Astring: string);
begin
  FfunzioniDelegateRegione := Astring;
  FfunzioniDelegateRegione_Specified := True;
end;

function capitoloUscita.funzioniDelegateRegione_Specified(Index: Integer): boolean;
begin
  Result := FfunzioniDelegateRegione_Specified;
end;

procedure capitoloUscita.SetimpegnatoEsercChiuso(Index: Integer; const Astring: string);
begin
  FimpegnatoEsercChiuso := Astring;
  FimpegnatoEsercChiuso_Specified := True;
end;

function capitoloUscita.impegnatoEsercChiuso_Specified(Index: Integer): boolean;
begin
  Result := FimpegnatoEsercChiuso_Specified;
end;

procedure capitoloUscita.Setintervento(Index: Integer; const Aintervento: intervento);
begin
  Fintervento := Aintervento;
  Fintervento_Specified := True;
end;

function capitoloUscita.intervento_Specified(Index: Integer): boolean;
begin
  Result := Fintervento_Specified;
end;

procedure capitoloUscita.Setprogetto(Index: Integer; const Astring: string);
begin
  Fprogetto := Astring;
  Fprogetto_Specified := True;
end;

function capitoloUscita.progetto_Specified(Index: Integer): boolean;
begin
  Result := Fprogetto_Specified;
end;

procedure capitoloUscita.Setprogramma(Index: Integer; const Astring: string);
begin
  Fprogramma := Astring;
  Fprogramma_Specified := True;
end;

function capitoloUscita.programma_Specified(Index: Integer): boolean;
begin
  Result := Fprogramma_Specified;
end;

procedure capitoloUscita.SetrilevanzaIVA(Index: Integer; const Astring: string);
begin
  FrilevanzaIVA := Astring;
  FrilevanzaIVA_Specified := True;
end;

function capitoloUscita.rilevanzaIVA_Specified(Index: Integer): boolean;
begin
  Result := FrilevanzaIVA_Specified;
end;

procedure capitoloUscita.Setservizio(Index: Integer; const Aservizio: servizio);
begin
  Fservizio := Aservizio;
  Fservizio_Specified := True;
end;

function capitoloUscita.servizio_Specified(Index: Integer): boolean;
begin
  Result := Fservizio_Specified;
end;

procedure capitoloUscita.SetstanzAttuale(Index: Integer; const Astring: string);
begin
  FstanzAttuale := Astring;
  FstanzAttuale_Specified := True;
end;

function capitoloUscita.stanzAttuale_Specified(Index: Integer): boolean;
begin
  Result := FstanzAttuale_Specified;
end;

procedure capitoloUscita.SetstanziamentoAnnoPrec(Index: Integer; const Astring: string);
begin
  FstanziamentoAnnoPrec := Astring;
  FstanziamentoAnnoPrec_Specified := True;
end;

function capitoloUscita.stanziamentoAnnoPrec_Specified(Index: Integer): boolean;
begin
  Result := FstanziamentoAnnoPrec_Specified;
end;

procedure capitoloUscita.SettipoSpesa(Index: Integer; const Astring: string);
begin
  FtipoSpesa := Astring;
  FtipoSpesa_Specified := True;
end;

function capitoloUscita.tipoSpesa_Specified(Index: Integer): boolean;
begin
  Result := FtipoSpesa_Specified;
end;

procedure capitoloUscita.Settitolo(Index: Integer; const AtitoloUscita: titoloUscita);
begin
  Ftitolo := AtitoloUscita;
  Ftitolo_Specified := True;
end;

function capitoloUscita.titolo_Specified(Index: Integer): boolean;
begin
  Result := Ftitolo_Specified;
end;

procedure capitoloUscita.SettrasferimentiOrganismiComunitari(Index: Integer; const Astring: string);
begin
  FtrasferimentiOrganismiComunitari := Astring;
  FtrasferimentiOrganismiComunitari_Specified := True;
end;

function capitoloUscita.trasferimentiOrganismiComunitari_Specified(Index: Integer): boolean;
begin
  Result := FtrasferimentiOrganismiComunitari_Specified;
end;

procedure capitoloUscita.Setueb(Index: Integer; const AArray_Of_ueb: Array_Of_ueb);
begin
  Fueb := AArray_Of_ueb;
  Fueb_Specified := True;
end;

function capitoloUscita.ueb_Specified(Index: Integer): boolean;
begin
  Result := Fueb_Specified;
end;

procedure capitoloUscita.SetutenteAgg(Index: Integer; const Astring: string);
begin
  FutenteAgg := Astring;
  FutenteAgg_Specified := True;
end;

function capitoloUscita.utenteAgg_Specified(Index: Integer): boolean;
begin
  Result := FutenteAgg_Specified;
end;

procedure capitoloUscita.SetutenteIns(Index: Integer; const Astring: string);
begin
  FutenteIns := Astring;
  FutenteIns_Specified := True;
end;

function capitoloUscita.utenteIns_Specified(Index: Integer): boolean;
begin
  Result := FutenteIns_Specified;
end;

procedure capitoloUscita.SetvoceEconomica(Index: Integer; const AvoceEconomica: voceEconomica);
begin
  FvoceEconomica := AvoceEconomica;
  FvoceEconomica_Specified := True;
end;

function capitoloUscita.voceEconomica_Specified(Index: Integer): boolean;
begin
  Result := FvoceEconomica_Specified;
end;

destructor funzione.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fservizio)-1 do
    SysUtils.FreeAndNil(Fservizio[I]);
  System.SetLength(Fservizio, 0);
  SysUtils.FreeAndNil(Fente);
  inherited Destroy;
end;

procedure funzione.Setcodice(Index: Integer; const Astring: string);
begin
  Fcodice := Astring;
  Fcodice_Specified := True;
end;

function funzione.codice_Specified(Index: Integer): boolean;
begin
  Result := Fcodice_Specified;
end;

procedure funzione.Setdescrizione(Index: Integer; const Astring: string);
begin
  Fdescrizione := Astring;
  Fdescrizione_Specified := True;
end;

function funzione.descrizione_Specified(Index: Integer): boolean;
begin
  Result := Fdescrizione_Specified;
end;

procedure funzione.Setente(Index: Integer; const Aente: ente);
begin
  Fente := Aente;
  Fente_Specified := True;
end;

function funzione.ente_Specified(Index: Integer): boolean;
begin
  Result := Fente_Specified;
end;

procedure funzione.Setservizio(Index: Integer; const AArray_Of_servizio: Array_Of_servizio);
begin
  Fservizio := AArray_Of_servizio;
  Fservizio_Specified := True;
end;

function funzione.servizio_Specified(Index: Integer): boolean;
begin
  Result := Fservizio_Specified;
end;

destructor titoloUscita.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Finterventi)-1 do
    SysUtils.FreeAndNil(Finterventi[I]);
  System.SetLength(Finterventi, 0);
  SysUtils.FreeAndNil(Fente);
  inherited Destroy;
end;

procedure titoloUscita.Setcodice(Index: Integer; const Astring: string);
begin
  Fcodice := Astring;
  Fcodice_Specified := True;
end;

function titoloUscita.codice_Specified(Index: Integer): boolean;
begin
  Result := Fcodice_Specified;
end;

procedure titoloUscita.Setdescrizione(Index: Integer; const Astring: string);
begin
  Fdescrizione := Astring;
  Fdescrizione_Specified := True;
end;

function titoloUscita.descrizione_Specified(Index: Integer): boolean;
begin
  Result := Fdescrizione_Specified;
end;

procedure titoloUscita.Setente(Index: Integer; const Aente: ente);
begin
  Fente := Aente;
  Fente_Specified := True;
end;

function titoloUscita.ente_Specified(Index: Integer): boolean;
begin
  Result := Fente_Specified;
end;

procedure titoloUscita.Setinterventi(Index: Integer; const AArray_Of_intervento: Array_Of_intervento);
begin
  Finterventi := AArray_Of_intervento;
  Finterventi_Specified := True;
end;

function titoloUscita.interventi_Specified(Index: Integer): boolean;
begin
  Result := Finterventi_Specified;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(BilancioInterface), 'http://ws.service.business.bilsrvcp.csi.it/', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(BilancioInterface), '');
  //InvRegistry.RegisterInvokeOptions(TypeInfo(BilancioInterface), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(BilancioInterface), ioDefault);
  RemClassRegistry.RegisterXSClass(estremiCdR, 'http://ws.service.business.bilsrvcp.csi.it/', 'estremiCdR');
  RemClassRegistry.RegisterXSClass(ente, 'http://ws.service.business.bilsrvcp.csi.it/', 'ente');
  RemClassRegistry.RegisterXSClass(intervento, 'http://ws.service.business.bilsrvcp.csi.it/', 'intervento');
  RemClassRegistry.RegisterXSClass(servizio, 'http://ws.service.business.bilsrvcp.csi.it/', 'servizio');
  RemClassRegistry.RegisterXSClass(ueb, 'http://ws.service.business.bilsrvcp.csi.it/', 'ueb');
  RemClassRegistry.RegisterXSClass(voceEconomica, 'http://ws.service.business.bilsrvcp.csi.it/', 'voceEconomica');
  RemClassRegistry.RegisterXSClass(estremiCapitoloSpesa, 'http://ws.service.business.bilsrvcp.csi.it/', 'estremiCapitoloSpesa');
  RemClassRegistry.RegisterXSClass(estremiCapitoloUscita, 'http://ws.service.business.bilsrvcp.csi.it/', 'estremiCapitoloUscita');
  RemClassRegistry.RegisterXSClass(assessorato, 'http://ws.service.business.bilsrvcp.csi.it/', 'assessorato');
  RemClassRegistry.RegisterXSClass(settore, 'http://ws.service.business.bilsrvcp.csi.it/', 'settore');
  RemClassRegistry.RegisterXSClass(centroDiCosto, 'http://ws.service.business.bilsrvcp.csi.it/', 'centroDiCosto');
  RemClassRegistry.RegisterXSClass(importiUEBSpesa, 'http://ws.service.business.bilsrvcp.csi.it/', 'importiUEBSpesa');
  RemClassRegistry.RegisterXSClass(ServiceSystemException, 'http://ws.service.business.bilsrvcp.csi.it/', 'ServiceSystemException');
  RemClassRegistry.RegisterXSClass(BusinessException, 'http://ws.service.business.bilsrvcp.csi.it/', 'BusinessException');
  RemClassRegistry.RegisterXSClass(ServiceSystemException2, 'http://ws.service.business.bilsrvcp.csi.it/', 'ServiceSystemException2', 'ServiceSystemException');
  RemClassRegistry.RegisterXSClass(BusinessException2, 'http://ws.service.business.bilsrvcp.csi.it/', 'BusinessException2', 'BusinessException');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_ueb), 'http://ws.service.business.bilsrvcp.csi.it/', 'Array_Of_ueb');
  RemClassRegistry.RegisterXSClass(capitoloUscita, 'http://ws.service.business.bilsrvcp.csi.it/', 'capitoloUscita');
  RemClassRegistry.RegisterXSClass(return, 'http://ws.service.business.bilsrvcp.csi.it/', 'return');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_servizio), 'http://ws.service.business.bilsrvcp.csi.it/', 'Array_Of_servizio');
  RemClassRegistry.RegisterXSClass(funzione, 'http://ws.service.business.bilsrvcp.csi.it/', 'funzione');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_intervento), 'http://ws.service.business.bilsrvcp.csi.it/', 'Array_Of_intervento');
  RemClassRegistry.RegisterXSClass(titoloUscita, 'http://ws.service.business.bilsrvcp.csi.it/', 'titoloUscita');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_capitoloUscita), 'http://ws.service.business.bilsrvcp.csi.it/', 'Array_Of_capitoloUscita');
  RemClassRegistry.RegisterSerializeOptions(TypeInfo(Array_Of_capitoloUscita), [xoInlineArrays]);

end.