unit A077PCOMServer_TLB;

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
// File generated on 07/01/2014 18.36.31 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\SVN\Sviluppo\PJRilPre\A077PCOMServer (1)
// LIBID: {2B20A3DC-9631-429B-9F5E-C9B3710E227A}
// LCID: 0
// Helpfile:
// HelpString: A077PCOMServer Library
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
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
  A077PCOMServerMajorVersion = 1;
  A077PCOMServerMinorVersion = 0;

  LIBID_A077PCOMServer: TGUID = '{2B20A3DC-9631-429B-9F5E-C9B3710E227A}';

  IID_IA077COMServer: TGUID = '{B0B3DC45-BABE-4020-AECA-47CFA47697B1}';
  CLASS_A077COMServer: TGUID = '{D1FA98B6-6C13-4F6F-B862-E55B7A6FD1EA}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IA077COMServer = interface;
  IA077COMServerDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  A077COMServer = IA077COMServer;


// *********************************************************************//
// Interface: IA077COMServer
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B0B3DC45-BABE-4020-AECA-47CFA47697B1}
// *********************************************************************//
  IA077COMServer = interface(IAppServer)
    ['{B0B3DC45-BABE-4020-AECA-47CFA47697B1}']
    procedure CreaStampa(const SelezioneAnagrafica: WideString; const CodiceStampa: WideString;
                         const FilePDF: WideString; const StandardPrinter: WideString;
                         const Operatore: WideString; const Azienda: WideString;
                         const Applicazione: WideString; const DBServer: WideString;
                         Dal: TDateTime; Al: TDateTime; var DettaglioLog: OleVariant); safecall;
  end;

// *********************************************************************//
// DispIntf:  IA077COMServerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B0B3DC45-BABE-4020-AECA-47CFA47697B1}
// *********************************************************************//
  IA077COMServerDisp = dispinterface
    ['{B0B3DC45-BABE-4020-AECA-47CFA47697B1}']
    procedure CreaStampa(const SelezioneAnagrafica: WideString; const CodiceStampa: WideString;
                         const FilePDF: WideString; const StandardPrinter: WideString;
                         const Operatore: WideString; const Azienda: WideString;
                         const Applicazione: WideString; const DBServer: WideString;
                         Dal: TDateTime; Al: TDateTime; var DettaglioLog: OleVariant); dispid 301;
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
// The Class CoA077COMServer provides a Create and CreateRemote method to
// create instances of the default interface IA077COMServer exposed by
// the CoClass A077COMServer. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoA077COMServer = class
    class function Create: IA077COMServer;
    class function CreateRemote(const MachineName: string): IA077COMServer;
  end;

implementation

uses System.Win.ComObj;

class function CoA077COMServer.Create: IA077COMServer;
begin
  Result := CreateComObject(CLASS_A077COMServer) as IA077COMServer;
end;

class function CoA077COMServer.CreateRemote(const MachineName: string): IA077COMServer;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_A077COMServer) as IA077COMServer;
end;

end.

