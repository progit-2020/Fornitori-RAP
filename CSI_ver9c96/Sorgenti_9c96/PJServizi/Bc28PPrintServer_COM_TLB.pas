unit Bc28PPrintServer_COM_TLB;

// ************************************************************************ //
// WARNING
// -------
// The types declared in this file were generated from data read from a
// Type Library. If this type library is explicitly or indirectly (via
// another type library referring to this type library) re-imported, or the
// 'Refresh' command of the Type Library Editor activated while editing the
// Type Library, the contents of this file will be regenerated and all
// manual modifications will be lost.
// ************************************************************************ //

// $Rev: 52393 $
// File generated on 30/06/2015 14.54.51 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\SVN\CSI\CSI_Sviluppo\PJServizi\Bc28PPrintServer_COM (1)
// LIBID: {1AAD6340-2C9A-4F75-8F88-2558F81F9686}
// LCID: 0
// Helpfile:
// HelpString:
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
//   (2) v1.0 Midas, (midas.dll)
// SYS_KIND: SYS_WIN32
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, Midas, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleServer, Winapi.ActiveX;



// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  Bc28PPrintServer_COMMajorVersion = 1;
  Bc28PPrintServer_COMMinorVersion = 0;

  LIBID_Bc28PPrintServer_COM: TGUID = '{1AAD6340-2C9A-4F75-8F88-2558F81F9686}';

  IID_IBc28PrintServer: TGUID = '{5ECBE935-B434-4A45-9014-4ABC40C08E32}';
  CLASS_Bc28PrintServer: TGUID = '{0C94F43B-4783-4BA0-9128-297C40CEE7EF}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IBc28PrintServer = interface;
  IBc28PrintServerDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  Bc28PrintServer = IBc28PrintServer;


// *********************************************************************//
// Interface: IBc28PrintServer
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5ECBE935-B434-4A45-9014-4ABC40C08E32}
// *********************************************************************//
  IBc28PrintServer = interface(IAppServer)
    ['{5ECBE935-B434-4A45-9014-4ABC40C08E32}']
    procedure ProvaStampa(const NomeFile: WideString); safecall;
    procedure PrintA045(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA061(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA043(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA074(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA042(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA092(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA081(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA051(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA090(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA116(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA077(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA059(const FilePDF: WideString; const Operatore: WideString;
                        const Azienda: WideString; const DBServer: WideString;
                        const DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA068(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA058(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA105(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA104(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA047(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA167(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA145(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintS715(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant; var MessaggioAggiuntivo: OleVariant); safecall;
    procedure PrintAc04(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
  end;

// *********************************************************************//
// DispIntf:  IBc28PrintServerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5ECBE935-B434-4A45-9014-4ABC40C08E32}
// *********************************************************************//
  IBc28PrintServerDisp = dispinterface
    ['{5ECBE935-B434-4A45-9014-4ABC40C08E32}']
    procedure ProvaStampa(const NomeFile: WideString); dispid 301;
    procedure PrintA045(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 302;
    procedure PrintA061(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 303;
    procedure PrintA043(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 304;
    procedure PrintA074(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 305;
    procedure PrintA042(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 306;
    procedure PrintA092(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 307;
    procedure PrintA081(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 308;
    procedure PrintA051(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 309;
    procedure PrintA090(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 310;
    procedure PrintA116(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 311;
    procedure PrintA077(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 312;
    procedure PrintA059(const FilePDF: WideString; const Operatore: WideString;
                        const Azienda: WideString; const DBServer: WideString;
                        const DatiUtente: WideString; var DettaglioLog: OleVariant); dispid 314;
    procedure PrintA068(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 315;
    procedure PrintA058(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 316;
    procedure PrintA105(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 317;
    procedure PrintA104(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 318;
    procedure PrintA047(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 319;
    procedure PrintA167(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 320;
    procedure PrintA145(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 321;
    procedure PrintS715(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant; var MessaggioAggiuntivo: OleVariant); dispid 322;
    procedure PrintAc04(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 323;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: Integer;
                             out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer;
                           Options: Integer; const CommandText: WideString; var Params: OleVariant;
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer;
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString;
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// The Class CoBc28PrintServer provides a Create and CreateRemote method to
// create instances of the default interface IBc28PrintServer exposed by
// the CoClass Bc28PrintServer. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoBc28PrintServer = class
    class function Create: IBc28PrintServer;
    class function CreateRemote(const MachineName: string): IBc28PrintServer;
  end;

implementation

uses System.Win.ComObj;

class function CoBc28PrintServer.Create: IBc28PrintServer;
begin
  Result := CreateComObject(CLASS_Bc28PrintServer) as IBc28PrintServer;
end;

class function CoBc28PrintServer.CreateRemote(const MachineName: string): IBc28PrintServer;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Bc28PrintServer) as IBc28PrintServer;
end;

end.

