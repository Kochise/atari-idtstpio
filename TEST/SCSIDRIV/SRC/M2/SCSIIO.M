IMPLEMENTATION MODULE ScsiIO;
(****************************************************************************
 *
 * Scsi-Input/Output auf midlevel-Ebene
 *
 * (c) 1990-1992 Helge Schulz
 * (c) 1990-1993 Steffen Engel
 *
 * $Source: E:\HM2\LIB\se\rcs\scsiio.m,v $
 *
 * $Revision: 1.10 $
 *
 * $Author: S_Engel $
 *
 * $Date: 1996/02/03 19:34:10 $
 *
 * $State: Exp $
 *
 *****************************************************************************
 * History:
 *
 * $Log: scsiio.m,v $
 * Revision 1.10  1996/02/03  19:34:10  S_Engel
 * Kleine Anpassungen
 *
 * Revision 1.9  1995/10/30  17:44:48  S_Engel
 * *** empty log message ***
 *
 * Revision 1.8  1995/05/11  15:24:38  S_Engel
 * virtuelles RAM: Daten werden kopiert.
 *
 * Revision 1.7  1995/04/04  15:10:14  S_Engel
 * Grunds�tzlich Verwendung externer SCSI-Routinen
 *
 * Revision 1.6  1995/03/08  03:19:44  S_Engel
 * InquireDev und InquireSCSI korrekt mit langem Ergebnis
 *
 * Revision 1.5  1995/02/25  23:23:34  S_Engel
 * BugFix: InquireSCSI verwendete Adresse der Pufferadre�variablen.
 *
 * Revision 1.4  1995/02/10  14:02:02  S_Engel
 * In und Out als Prozedurvariablen, damit man sich davor
 * einklinken kann.
 *
 * Revision 1.3  1995/02/10  12:38:46  S_Engel
 * Anpassungen an aktuellen SCSI-Treiber
 *
 * Revision 1.2  1995/02/07  23:59:48  S_Engel
 * Umstellung auf handleorientierte SCSI-Routinen
 *
 * Revision 1.1  1995/01/01  19:14:54  S_Engel
 * Initial revision
 *
 *
 *  30.09.93 Kompatibilit�t mit virtuellem RAM fertiggestellt
 *  08.09.93 Endg�ltige Umstellung auf den Betrieb mit FRB. ScsiIO geht autark mit dem FRB um, und sollte auch mit virtuellem RAM klarkommen.
 *  10.01.93 Falcon-Routinen eingebaut (SE)
 *  15.10.92 BHDI f�r den Gebrauch mit Alien eingebaut (SE)
 *  08.10.92 Fehlermeldung OnlyTT eingebaut (Cookie-Check) (SE)
 *  05.10.92 Cache-Clear installiert, TT anscheinend jetzt stabil
 *  29.04.92 TT-Unterst�tzung installiert (SE)
 *  13.04.92 SetScsiAdr setzt LastCmd auf 0
 *  30.12.91 MaxScsiAdr auf 7 erh�ht f�r modifizierte Adapter
 *  21.07.91 Auszeitprozedurvariablen
 *  19.07.91 Anpassung an Compiler-Version 4.1
 *  30.11.90 Aufteilung von StopDiscMotor in Break- und StopDisc
 *  28.11.90 Konstante DevDiscTimeout und DiscWaitTime
 *  02.10.90 Prozedur StopDiscMotor
 *
 *****************************************************************************)


 (*$S- $V- $T- *)

(* Systemabh�ngiges *)
(* IMPLEMENTATION F�R  >>> H�nisch-Modula-2 <<< *)
(*                                              *)
(* Durchgef�hrt von Steffen Engel               *)
(*                                              *)
(*$S-   Stack-Checks                            *)
(*$I-   keine Variablen-Initialisierung         *)
(*$V-   keine arithmetischen Kontrollen         *)
(*$T-   kein Bereichstest                       *)
(*$Y-   keine Laufzeittests auf RETURN und CASE *)
(*                                              *)
(*----------------------------------------------*)

(*$R2+ D2/A2 sichern        *)
(*$K+  Aufrufer r�umt Stack *)



IMPORT SYSTEM, System;

(* Standard HM2-Libs *)
FROM SYSTEM IMPORT ADR, BYTE, ADDRESS, WORD, CAST, TSIZE, LOAD, STORE, CODE;
IMPORT Cookie, Block, void;
IMPORT Str;

(* Magic-Lib *)
IMPORT MagicDOS;

(* Eigene Libs *)
IMPORT Err;

(* Projektlibs *)
IMPORT ScsiDefs;


  (* String f�r WHAT - leider ein bi�chen HM2-spezifisches *)
  CONST What = '@(#) ScsiIO, compiled '
               + CHR(SYSTEM.DATE DIV 1000000H DIV 10 + 48)
               + CHR(SYSTEM.DATE DIV 1000000H MOD 10 + 48) + '.'
               + CHR(SYSTEM.DATE DIV 10000H MOD 100H DIV 10 MOD 10 + 48)
               + CHR(SYSTEM.DATE DIV 10000H MOD 100H MOD 10 + 48) + '.'
               + CHR(SYSTEM.DATE MOD 10000H DIV 10 MOD 10 + 48)
               + CHR(SYSTEM.DATE MOD 10000H MOD 10 + 48)
               + '  (c) S. Engel';

CONST ForeignXFRB = FALSE;      (* Soll ein globaler FRB benutzt werden, falls vorhanden? *)

   (*------ Deklarationsteil *)


(* Alles f�r den XFRB *)

TYPE  tXFRB = RECORD
                version : SHORTINT;            (* Version des XFRB-cookies, $0101 = 1.00 *)
                xflock  : POINTER TO SHORTINT;  (* extended flock, Semaphore *)
                buffer  : ADDRESS;             (* Adresse eines Puffers im ST-RAM, mindestens 64 KByte *)
                size    : LONGINT;             (* Puffergr��e *)
                next    : POINTER TO tXFRB;    (* Zeiger auf weitere Struktur *)
              END;
VAR   XFRB            : POINTER TO tXFRB;
      HasVirtualRAM   : BOOLEAN;

CONST
  Debug = FALSE;

<*$?Debug:
PROCEDURE ShowErr(Cmd: ScsiDefs.tpSCSICmd);



























*>

PROCEDURE MyIn(Parms : ScsiDefs.tpSCSICmd): LONGINT;








































PROCEDURE MyOut(Parms : ScsiDefs.tpSCSICmd): LONGINT;























PROCEDURE InquireSCSI(    what : SHORTINT;












PROCEDURE InquireBus (    what     : SHORTINT;













PROCEDURE CheckDev(     BusNo : SHORTINT;













PROCEDURE RescanBus(BusNo : SHORTINT) : LONGINT;










PROCEDURE Open(     Bus : SHORTINT;














PROCEDURE Close(handle : ScsiDefs.tHandle) : LONGINT;











PROCEDURE Error(handle : ScsiDefs.tHandle; rwflag, error : SHORTINT) : LONGINT;












PROCEDURE CheckVirtual;


























PROCEDURE Init;

































BEGIN
  In := MyIn;
  Out := MyOut;

  XFRB := NIL;
  Init;
END ScsiIO.