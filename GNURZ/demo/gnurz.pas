
// GNURZ - Arithmetik-Unit fuer (G)rosse (N)atuerliche (U)nd (R)ationale (Z)ahlen
// Version: 1.0.1

// (c) 2008-2009 by Alexander Staidl
// Kontakt: a.staidl(at)SPAMFILTERfreenet.de
// (bitte SPAMFILTER entfernen)

// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License or version 3.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

unit gnurz;

{$mode delphi}{$H+}
{$inline on}

interface
type
  GNZTyp = array of dword;                      // Grosse-Natuerliche-Zahlen-Typ; qword: 0..18466744073709551615
  GRaZTyp = record                              // Fuer Brueche... ...sollte klar sein.
    nenner, zaehler: GNZTyp;
    Negativ:boolean;                            // Negativ=true, falls die Zahl kleiner 0 ist.
  end;

  TGnurz = class
    private
      GNZ_GlobZahlenbasis:dword; //Die dem GNZTyp zugrundeliegende Zahlenbasis (Binaersystem=2, Dezimal=10, Hexadezimal=16, u.s.w.); Wird im constructor create festgelegt.
      GNZ_Karazubagrenze:dword;
      Errormodus:word;

      function GNZBasisDezToGlobB(Zahl:GNZTyp):GNZTyp;
      function GNZGlobBToBasisDez(Zahl:GNZTyp):GNZTyp;

    public
      constructor create;
      procedure ResetErrormodus;
      function GetErrormodus:word;
      function GetKarazubagrenze:dword;
      procedure SetKazarzbagrenze(Grenze:dword);     //Setzt die Karazuba-Grenze neu.
      function GetGlobZahlenbasis:dword;
      procedure SetGlobZahlenbasis(basis:dword);
      function StrToGNZTyp(Eingabe:string):GNZTyp;   //Wandelt eine natuerliche Zahl in string-Forum um in den Typ GNZTyp von Basis 10. Eingabe darf nur Zahlen enthalten.
      function GNZTypToStr(Eingabe:GNZTyp):string;   //"Umkehrfunktion" zu StrToGNZTypDez;
      function WordToGNZTyp(WZahl:dword):GNZTyp;
      function GNZTypToWord(ZahlGNZ:GNZTyp):dword;
      

      //Operationen: Natuerliche Zahlen
      function GNZadd(a,b:GNZTyp):GNZTyp; //Gibt die Summe a + b zurueck. Rechnet mit Grossen Natuerlichen Zahlen (GNZ); Zbasis=Zahlenbasis (Dezimalsystem:Zbasis=10)
      function GNZsub(Minuent,Subtrahend:GNZTyp):GNZTyp; // WICHTIG: Es muss Minuend>Subtrahend sein!; Rechnet Minuend-Subtrahend.
      function GNZmul(a,b:GNZTyp):GNZTyp;  //Gibt das Produkt a*b zurueck. Rechnet mit grossen natuerlichen Zahlen.
      function GNZmulword(a:dword;b:GNZTyp):GNZTyp; // Wie GNZmul, nur ist a vom Typ dword
      function GNZakleinerb(a,b:GNZTyp):boolean; inline; // Prueft, ob a kleiner ist als b
      function GNZagleichb(a,b:GNZTyp):boolean; inline; // Prueft, ob sich a und b gleichen.
      function GNZdiv(Divident, Divisor:GNZTyp):GNZTyp;  //dividiert Divident durch Divisor und gibt das Ergebnis zurueck
      function GNZmod(Divident, Divisor:GNZTyp):GNZTyp; //Gibt Divident mod Divisor zurueck
      function GNZggt(a,b:GNZTyp):GNZTyp; inline;  //Wie ggt, nur fuer grosse natuerliche Zahlen (GNZ)
      function GNZkgv(a,b:GNZTyp):GNZTyp; inline;  //Wie kgv, nur fuer GNZ
      function GNZistgerade(zahl:GNZTyp):boolean; inline; //Prueft, ob zahl mod 2 = 0
      function GNZPotenz(Basis,Exponent:GNZTyp):GNZTyp; //Gibt Zahl^Exponent zurueck. Nach einem im Internet gefundenen Algorithmus
      function GNZPotenzMod(Basis,Exponent,Modulo:GNZTyp):GNZTyp; //Rechnet Basis^Exponent mod Modulus.
      function GNZFakultaet(nFak:dword):GNZTyp;  // Gibt n! zurueck
      function GNZIstPrim(zahl:GNZTyp):boolean; //Wahr, wenn zahl Primzahl
      function GNZMillerRabin(zahl:GNZTyp; it:word):boolean; //Miller-Rabin Primzahltext. Wenn Zahl Test besteht: Mit Wahrscheinlichkeit (1/4)^it Primzahl.
      function GNZMRPrimdanach(zahl:GNZTyp; it:word):GNZTyp;  //Bestimmt die nach zahl nächste Primzahl.
      function GNZZufall(Obergrenze:GNZTyp):GNZTyp;  // Gibt eine Zufallszahl wieder, die kleiner ist als Obergrenze.
      function GNZeins:GNZTyp;                       // Gibt 1 zurueck
      function GNZnull:GNZTyp;                       // Gibt 0 zurueck
      
      //Operationen: Rationale Zahlen
      function GRaZKuerzen(Bruch:GRaZTyp):GRaZTyp;  //Kuerzt den Bruch
      function GRaZadd(a,b:GRazTyp):GRaZTyp;  //Rechnet a+b und kuerzt die Summe anschliessend
      function GRazsub(Minuent,Subtrahend:GRaZTyp):GRaZTyp;   //Es muss a>b sein!
      function GRaZmul(a,b:GRaZTyp):GRaZTyp;                 //Multipliziert die Brueche miteinander
      function GRaZdiv(Divident,Divisor:GRaZTyp):GRaZTyp;  //Dividiert durch Multiplikation mit dem Kehrwert
      function GRaZakleinerbBetrag(a,b:GRaZTyp):boolean;//Gibt true zurueck, wenn |a| < |b|
      function GRaZakleinerb(a,b:GRaZTyp):boolean;      //Gibt true zurueck, wenn a < b
      function GRaZagleichbBetrag(a,b:GRaZTyp):boolean; //Gibt true zurueck, wenn |a| = |b|
      function GRaZagleichb(a,b:GRaZTyp):boolean;       //Gibt true zurueck, wenn a = b
  end;


implementation

//private
function TGnurz.GNZBasisDezToGlobB(Zahl:GNZTyp):GNZTyp;
var Erg,BasisDez,ZwSpGNZ:GNZTyp;
    n:dword;
begin
  setlength(BasisDez,1);
  BasisDez[0]:=10;
  setlength(ZwSpGNZ,1);
  setlength(Erg,1);
  Erg[0]:=0;
  for n:=length(Zahl)-1 downto 0 do
  begin
    ZwSpGNZ[0]:=Zahl[n];
    Erg:=GNZadd(GNZmul(Erg,BasisDez),ZwSpGNZ);
  end;
  Result:=Erg;
end; // GNZBasisDezToGlobB


function TGnurz.GNZGlobBToBasisDez(Zahl:GNZTyp):GNZTyp;
var Erg,BasisDez,ZwSpGNZ:GNZTyp;
    n:dword;
begin
  setlength(BasisDez,1);
  BasisDez[0]:=10;
  ZwSpGNZ:=copy(Zahl);
  n:=0;
  repeat
    setlength(Erg,n+1);
    Erg[n]:=GNZmod(ZwSpGNZ,BasisDez)[0];
    ZwSpGNZ:=GNZdiv(ZwSpGNZ,BasisDez);
    inc(n);
  until (length(ZwSpGNZ)=1)and(ZwSpGNZ[0]=0);
  Result:=Erg;
end; // GNZGlobBToZielB


//public------------
constructor TGnurz.create;
begin
  inherited;
  Randomize;
  GNZ_GlobZahlenbasis:=2147483648;
  GNZ_Karazubagrenze:= 44;
  Errormodus:=0;                       //1=Minuent<Subtrachend; 2=Konvertierungsfehler; 3=Eingabe keine Zahl; 4=Division durch 0
end;


procedure TGnurz.ResetErrormodus;
begin
  Errormodus:=0;
end;

function TGnurz.GetErrormodus:word;
begin Result:=Errormodus end;


function TGnurz.GetKarazubagrenze:dword;
begin Result:=GNZ_Karazubagrenze end;


procedure TGnurz.SetKazarzbagrenze(Grenze:dword);
begin
  If (Grenze>0)and(Grenze<2147483648) then GNZ_Karazubagrenze:=Grenze;
end;


function TGnurz.GetGlobZahlenbasis:dword;
begin Result:=GNZ_GlobZahlenbasis end;


procedure TGnurz.SetGlobZahlenbasis(basis:dword);
begin
  If (basis>1)and(basis<=2147483648) then GNZ_GlobZahlenbasis:=basis;
end;


function TGnurz.StrToGNZTyp(Eingabe:string):GNZTyp;
var n, Ordnr, laenge:dword;
    Erg:GNZTyp;
begin
  laenge:=length(Eingabe);
  setlength(Erg,laenge);
  for n:= 1 to laenge do
  begin
    Ordnr:=ord(Eingabe[n]);
    if (Ordnr<58) and (Ordnr>47) then Erg[laenge-n]:=Ordnr-48 else Errormodus:=3;
  end;
  If Errormodus=0 then Result:=GNZBasisDezToGlobB(Erg) else
  begin
    setlength(Result,1); Result[0]:=1;
  end;
end;  //StrToGNZTypDez


function TGnurz.GNZTypToStr(Eingabe:GNZTyp):string;
var n:dword;
    Ausgabe:string;
begin
  Ausgabe:='';
  Eingabe:=GNZGlobBToBasisDez(Eingabe);
  for n:=1 to length(Eingabe) do Ausgabe:=Ausgabe + chr(Eingabe[length(Eingabe)-n]+48);
  Result:=Ausgabe;
end;  //GNZTypDezToStr


function TGnurz.WordToGNZTyp(WZahl:dword):GNZTyp;
var Erg:GNZTyp;
begin
  If GNZ_GlobZahlenbasis<2147483640 then Errormodus:=2;
  setlength(Erg,1);
  Erg[0]:=WZahl mod GNZ_GlobZahlenbasis;
  WZahl:=WZahl div GNZ_GlobZahlenbasis;
  If WZahl<>0 then
  begin
    setlength(Erg,2);
    Erg[1]:=WZahl;
  end;
  Result:=Erg;
  If Errormodus=2 then
  begin
    setlength(Result,1);
    Result[0]:=1;
  end;
end;

function TGnurz.GNZTypToWord(ZahlGNZ:GNZTyp):dword;
var laenge:dword;
    Erg:dword;
begin
  If GNZ_GlobZahlenbasis<2147483640 then Errormodus:=2;
  If length(ZahlGNZ)>2 then Errormodus:=2 else
  begin
    Erg:=ZahlGNZ[0];
  end;
  If (length(ZahlGNZ)=2)and(ZahlGNZ[1]=1) then Erg:=Erg+GNZ_GlobZahlenbasis;
  If (length(ZahlGNZ)=2)and(ZahlGNZ[1]>1) then Errormodus:=2;
  If Errormodus<>2 then Result:=Erg else Result:=1;
end;


// GNZ-Operationen (Rechnen mit Grosse Natuerlichen Zahlen)-------------------------------------------------------

function TGnurz.GNZadd(a,b:GNZTyp):GNZTyp;
var ZwSp: dword;
    n,aAnz,bAnz: dword;
    Erg: GNZTyp;
begin
  aAnz:=length(a); bAnz:=length(b);
  ZwSp:=0;
  If aAnz<bAnz then
  begin
    setlength(Erg,bAnz);
    for n:=0 to aAnz-1 do
    begin
      ZwSp:= ZwSp + a[n] + b[n];
      If ZwSp>=GNZ_GlobZahlenbasis then
      begin
        Erg[n]:= ZwSp-GNZ_GlobZahlenbasis;
        ZwSp:=1;
      end else
      begin
        Erg[n]:=ZwSp;
        ZwSp:=0;
      end;
    end; //for n:=0 to aAnz-1;
    for n:=aAnz to bAnz-1 do
    begin
      ZwSp:= ZwSp + b[n];
      If ZwSp>=GNZ_GlobZahlenbasis then
      begin
        Erg[n]:= ZwSp-GNZ_GlobZahlenbasis;
        ZwSp:=1;
      end else
      begin
        Erg[n]:=ZwSp;
        ZwSp:=0;
      end;
    end; //for n:=aAnz to bAnz-1;
    If ZwSp<>0 then
    begin
      setlength(Erg,bAnz+1);
      Erg[bAnz]:=ZwSp;
    end;
  end else  //if aAnz<bAnz
  begin
    setlength(Erg,aAnz);
    for n:=0 to bAnz-1 do
    begin
      ZwSp:= ZwSp + a[n] + b[n];
      If ZwSp>=GNZ_GlobZahlenbasis then
      begin
        Erg[n]:= ZwSp-GNZ_GlobZahlenbasis;
        ZwSp:=1;
      end else
      begin
        Erg[n]:=ZwSp;
        ZwSp:=0;
      end;
    end; //for n:=0 to bAnz-1;
    for n:=bAnz to aAnz-1 do
    begin
      ZwSp:= ZwSp + a[n];
      If ZwSp>=GNZ_GlobZahlenbasis then
      begin
        Erg[n]:= ZwSp-GNZ_GlobZahlenbasis;
        ZwSp:=1;
      end else
      begin
        Erg[n]:=ZwSp;
        ZwSp:=0;
      end;
    end; //for n:=aAnz to bAnz-1;
    If ZwSp<>0 then
    begin
      setlength(Erg,aAnz+1);
      Erg[aAnz]:=ZwSp;
    end;
  end; //if aAnz<bAnz else
  Result:=Erg;
end; // GNZadd


function TGnurz.GNZsub(Minuent,Subtrahend:GNZTyp):GNZTyp;
var ZwSp: dword;
    n,minn,maxn: dword;
    Erg,a,b: GNZTyp;
begin
  maxn:=length(Minuent); minn:=length(Subtrahend);
  If maxn<minn then
  begin
    n:=maxn; maxn:=minn; minn:=n;                //vertauscht minn mit maxn
    a:=Subtrahend; b:=Minuent;
    Errormodus:=1;
  end else a:=Minuent; b:=Subtrahend;            //hier ist kein copy() noetig, da a und b nicht veraendert werden.
  setlength(Erg,maxn);
  ZwSp:=0;

  for n:=0 to minn-1 do
  begin
    ZwSp:=ZwSp+b[n];
    If a[n]>=ZwSp then
    begin
      Erg[n]:=a[n] -ZwSp;
      ZwSp:=0;
    end else
    begin
      Erg[n]:=GNZ_GlobZahlenbasis - ZwSp + a[n];
      ZwSp:=1;
    end;
  end; //for n:=0 to minn-1;
  If maxn>minn then
  begin
    for n:=minn to maxn-1 do
    begin
      If a[n]>=ZwSp then
      begin
        Erg[n]:=a[n]-ZwSp;
        ZwSp:=0;
      end else
      begin
        Erg[n]:=GNZ_GlobZahlenbasis - ZwSp + a[n];
        ZwSp:=1;
      end;
    end; //for n:=minn-1 to maxn-1;
  end; // if maxn>minn
  n:=maxn-1;
  while (n>=1)and(Erg[n]=0) do
  begin
    dec(n);
  end; //while
  setlength(Erg,n+1);

  Result:=Erg;
end; //GNZsub


function TGnurz.GNZmul(a,b:GNZTyp):GNZTyp;

    function GNZmul4Karazuba(a,b:GNZTyp;aAnz,bAnz:dword):GnzTyp;
    var n,na,nb,Ergmaxzeiger,Ueberschlag:dword;
        ZwSp:qword;
        Erg,ZwErg:GNZTyp;
    begin
      setlength(Erg,aAnz+bAnz);                                     //Erg wird auf maximale Ausgangslaenge gesetzt
      Erg[0]:=0;
      ErgMaxZeiger:=0;                                              //Zeigt auf hoechste Erg-Stelle
      ZwSp:=0;
      If NOT (((aAnz=1)and(a[0]=0))or((bAnz=1)and(b[0]=0))) then
      for na:=0 to aAnz-1 do
      begin
        setlength(ZwErg,na+bAnz+1);
        for nb:=0 to bAnz-1 do
        begin
          ZwSp:=qword(a[na])*b[nb] + ZwSp;
          If ZwSp<GNZ_GlobZahlenbasis then
          begin
            ZwErg[na+nb]:=ZwSp;
            ZwSp:=0;
          end else
          begin
            ZwErg[na+nb]:=ZwSp mod GNZ_GlobZahlenbasis;
            ZwSp:=ZwSp div GNZ_GlobZahlenbasis;
          end; //if zwsp<Zbasis
        end; //for bAnz
        If ZwSp<>0 then
        begin
          ZwErg[na+bAnz]:=ZwSp;
          ZwSp:=0;
          //BEGINN Optimierter Additionsalgorithmus:
          If na=0 then
          begin
            for n:=0 to bAnz do Erg[n]:=ZwErg[n];
            ErgMaxZeiger:=bAnz;
          end else
          begin
            Ueberschlag:=0;
            for n := na to ErgMaxZeiger do
            begin
              Ueberschlag := Ueberschlag + Erg[n] + ZwErg[n];
              If Ueberschlag >= GNZ_GlobZahlenbasis then
              begin
                Erg[n] := Ueberschlag - GNZ_GlobZahlenbasis;
                Ueberschlag := 1;
              end else
              begin
                Erg[n] := Ueberschlag;
                Ueberschlag := 0;
              end;
            end; //for n:=na to ErgMaxZeiger do
            if ErgMaxZeiger<>na+bAnz then
            begin
              inc(ErgMaxZeiger);
              Ueberschlag := Ueberschlag + ZwErg[ErgMaxZeiger];
              If Ueberschlag >= GNZ_GlobZahlenbasis then
              begin
                Erg[ErgMaxZeiger] := Ueberschlag - GNZ_GlobZahlenbasis;
                Ueberschlag := 1;
              end else
              begin
                Erg[ErgMaxZeiger] := Ueberschlag;
                Ueberschlag := 0;
              end;
            end; // if ErgMaxZeiger<>na+bAnz
            if ErgMaxZeiger<>na+bAnz then                                //koennte auch in einer while-Schleife
            begin                                                        //geloest werden, die sich dann max.
              inc(ErgMaxZeiger);                                         //2x aufruft-->Langsam
              Ueberschlag := Ueberschlag + ZwErg[ErgMaxZeiger];
              If Ueberschlag >= GNZ_GlobZahlenbasis then
              begin
                Erg[ErgMaxZeiger] := Ueberschlag - GNZ_GlobZahlenbasis;
                Ueberschlag := 1;
              end else
              begin
                Erg[ErgMaxZeiger] := Ueberschlag;
                Ueberschlag := 0;
              end;
            end; // if ErgMaxZeiger<>na+bAnz
            If Ueberschlag=1 then
            begin
              inc(ErgMaxZeiger);
              Erg[ErgMaxZeiger]:=1;
            end;
          end; //if na=0 else
          //ENDE Optimierter Additionsalgorithmus
        end else
        begin
          //setlength(ZwErg,na+bAnz);
          //BEGINN Optimierter Additionsalgorithmus:
          If na=0 then
          begin
            for n:=0 to bAnz-1 do Erg[n]:=ZwErg[n];
            ErgMaxZeiger:=bAnz-1;
          end else
          begin
            Ueberschlag:=0;
            If ErgMaxZeiger <> 0 then
            for n := na to ErgMaxZeiger do
            begin
              Ueberschlag := Ueberschlag + Erg[n] + ZwErg[n];
              If Ueberschlag >= GNZ_GlobZahlenbasis then
              begin
                Erg[n] := Ueberschlag - GNZ_GlobZahlenbasis;
                Ueberschlag := 1;
              end else
              begin
                Erg[n] := Ueberschlag;
                Ueberschlag := 0;
              end;
            end; //for n:=na to ErgMaxZeiger do
            if ErgMaxZeiger<>na+bAnz then
            begin
              inc(ErgMaxZeiger);
              Ueberschlag := Ueberschlag + ZwErg[ErgMaxZeiger];
              If Ueberschlag >= GNZ_GlobZahlenbasis then
              begin
                Erg[ErgMaxZeiger] := Ueberschlag - GNZ_GlobZahlenbasis;
                Ueberschlag := 1;
              end else
              begin
                Erg[ErgMaxZeiger] := Ueberschlag;
                Ueberschlag := 0;
              end;
            end; // if ErgMaxZeiger<>na+bAnz
            if ErgMaxZeiger<>na+bAnz then                                //koennte auch in einer while-Schleife
            begin                                                        //geloest werden, die sich dann max.
              inc(ErgMaxZeiger);                                         //2x aufruft-->Langsam
              Ueberschlag := Ueberschlag + ZwErg[ErgMaxZeiger];
              If Ueberschlag >= GNZ_GlobZahlenbasis then
              begin
                Erg[ErgMaxZeiger] := Ueberschlag - GNZ_GlobZahlenbasis;
                Ueberschlag := 1;
              end else
              begin
                Erg[ErgMaxZeiger] := Ueberschlag;
                Ueberschlag := 0;
              end;
            end; // if ErgMaxZeiger<>na+bAnz
            If Ueberschlag=1 then
            begin
              inc(ErgMaxZeiger);
              Erg[ErgMaxZeiger]:=1;
            end;
          end; //if na=0 else
          //ENDE Optimierter Additionsalgorithmus
        end;

        //ZwErg[na]:=0;
      end; //for aAnz
      If Erg[aAnz+bAnz-1]=0 then setlength(Erg,aAnz+bAnz-1);
      Result:=Erg;
    end; //function GNZmul4Karazuba

    function GNZKarazuba(a,b:GNZTyp;aAnz,bAnz,Laenge:dword):GNZTyp; //Implementierung des Karazuba-Algorithmus. Laenge=2^n
    var p,q,r,s,u,v,vFaktor1,vFaktor2,w,ZwSpGNZ,Erg :GNZTyp;
        n,n2,pAnz,qAnz,rAnz,sAnz,vFaktor1Anz,vFaktor2Anz,Laengediv2,uAnz,ZwSpAnz :dword;
        ZwSp :qword;
        vPositiv :boolean;
    begin
      If Laenge<>1 then
      begin
        Laengediv2:=Laenge div 2;
        //Geschwindigkeitsoptimiert: (dafuer Aufwendig in der Wartung und fehleranfaellig)
        If aAnz>Laengediv2 then
        begin
          //Erhalten von p,q:
          pAnz:=aAnz-Laengediv2;
          setlength(p,pAnz);
          n2:=Laengediv2-1;
          while (a[n2]=0)and(n2<>0) do dec(n2);
          qAnz:=n2+1;
          setlength(q,qAnz);
          for n:=0 to n2 do q[n]:=a[n];
          for n:=Laengediv2 to aAnz-1 do p[n-Laengediv2]:=a[n];
          If bAnz>Laengediv2 then
          begin
            //Erhalten von r,s:
            rAnz:=bAnz-Laengediv2;
            setlength(r,rAnz);
            n2:=Laengediv2-1;
            while (b[n2]=0)and(n2<>0) do dec(n2);
            sAnz:=n2+1;
            setlength(s,sAnz);
            for n:=0 to n2 do s[n]:=b[n];
            for n:=Laengediv2 to bAnz-1 do r[n-Laengediv2]:=b[n];
            //Karazuba:                                                         <-1
            If (pAnz<GNZ_Karazubagrenze)or(rAnz<GNZ_Karazubagrenze) then u:=GNZmul4Karazuba(p,r,pAnz,rAnz)
             else u:=GNZKarazuba(p,r,pAnz,rAnz,Laengediv2);
            if GNZakleinerb(q,p)=true then
            begin
              vPositiv:=false;
              vFaktor1:=GNZSub(p,q);
            end else
            begin
              vPositiv:=true;
              vFaktor1:=GNZSub(q,p);
            end;
            if GNZakleinerb(s,r) then
            begin
              vPositiv:= not vPositiv;
              vFaktor2:=GNZsub(r,s);
            end else vFaktor2:=GNZsub(s,r);
            vFaktor1Anz := length(vFaktor1);
            vFaktor2Anz := length(vFaktor2);
            If (vFaktor1Anz<GNZ_Karazubagrenze)or(vFaktor2Anz<GNZ_Karazubagrenze)
             then v := GNZmul4Karazuba(vFaktor1,vFaktor2,vFaktor1Anz,vFaktor2Anz)
             else v := GNZKarazuba(vFaktor1,vFaktor2,vFaktor1Anz,vFaktor2Anz,Laengediv2);
            If (qAnz<GNZ_Karazubagrenze)or(sAnz<GNZ_Karazubagrenze) then w := GNZmul4Karazuba(q,s,qAnz,sAnz)
             else w := GNZKarazuba(q,s,qAnz,sAnz,Laengediv2);
            If vPositiv=true then ZwSpGNZ:=GNZsub(GNZadd(u,w),v) else ZwSpGNZ:=GNZadd(GNZadd(u,w),v);
            //Nun wird u mit GlobZahlensystem^(2*Laengediv2), ZwSpGNZ mit GlobZahlensystem^Laengediv2 per Shift multipliziert;
            uAnz:=length(u);
            setlength(u,uAnz+Laenge);
            for n:=uAnz-1 downto 0 do u[n+Laenge]:=u[n];
            for n:=0 to Laenge-1 do u[n]:=0;
            ZwSpAnz:=length(ZwSpGNZ);
            setlength(ZwSpGNZ,ZwSpAnz+Laengediv2);
            for n:=ZwSpAnz-1 downto 0 do ZwSpGNZ[n+Laengediv2]:=ZwSpGNZ[n];
            for n:=0 to Laengediv2-1 do ZwSpGNZ[n]:=0;
            //Ergebnis der Multiplikation:
            Erg:=GNZadd(u,GNZadd(ZwSpGNZ,w));
          end else
          begin
            //r=0,s=b:                                                          <-2
            //Karazuba:
            if GNZakleinerb(q,p)=true then
            begin
              vPositiv:=false;
              vFaktor1:=GNZSub(p,q);
            end else
            begin
              vPositiv:=true;
              vFaktor1:=GNZSub(q,p);
            end;
            //vFaktor2:=b; (da s=b und r=0)
            vFaktor1Anz:=length(vFaktor1);
            If (vFaktor1Anz<GNZ_Karazubagrenze)or(bAnz<GNZ_Karazubagrenze)
             then v := GNZmul4Karazuba(vFaktor1,b,vFaktor1Anz,bAnz)
             else v := GNZKarazuba(vFaktor1,b,vFaktor1Anz,bAnz,Laengediv2);
            If (qAnz<GNZ_Karazubagrenze)or(bAnz<GNZ_Karazubagrenze) then w := GNZmul4Karazuba(q,b,qAnz,bAnz)
             else w := GNZKarazuba(q,b,qAnz,bAnz,Laengediv2);
            If vPositiv=true then ZwSpGNZ:=GNZsub(w,v) else ZwSpGNZ:=GNZadd(w,v);
            //Nun wird ZwSpGNZ mit GlobZahlensystem^Laengediv2 per Shift multipliziert;
            ZwSpAnz:=length(ZwSpGNZ);
            setlength(ZwSpGNZ,ZwSpAnz+Laengediv2);
            for n:=ZwSpAnz-1 downto 0 do ZwSpGNZ[n+Laengediv2]:=ZwSpGNZ[n];
            for n:=0 to Laengediv2-1 do ZwSpGNZ[n]:=0;
            //Ergebnis der Multiplikation:
            Erg:=GNZadd(ZwSpGNZ,w);
          end; //if-else bAnz>Laengediv2, im Fall von aAnz>Laengediv2
        end else
        begin
          //p=0,q=a:;
          If bAnz>Laengediv2 then
          begin
            //Erhalten von r,s:
            setlength(r,bAnz-Laengediv2);
            n2:=Laengediv2-1;
            while (b[n2]=0)and(n2<>0) do dec(n2);
            sAnz:=n2+1;
            setlength(s,sAnz);
            for n:=0 to n2 do s[n]:=b[n];
            //setlength(s,Laengediv2);
            //for n:=0 to Laengediv2-1 do s[n]:=b[n];
            for n:=Laengediv2 to bAnz-1 do r[n-Laengediv2]:=b[n];
            //Karazuba:                                                         <-3
            vPositiv:=true;
            if GNZakleinerb(s,r) then
            begin
              vPositiv:= not vPositiv;
              vFaktor2:=GNZsub(r,s);
            end else vFaktor2:=GNZsub(s,r);
            vFaktor2Anz:=length(vFaktor2);
            If (aAnz<GNZ_Karazubagrenze)or(vFaktor2Anz<GNZ_Karazubagrenze)
             then v := GNZmul4Karazuba(a,vFaktor2,aAnz,vFaktor2Anz)
             else v := GNZKarazuba(a,vFaktor2,aAnz,vFaktor2Anz,Laengediv2);
            If (aAnz<GNZ_Karazubagrenze)or(sAnz<GNZ_Karazubagrenze) then w := GNZmul4Karazuba(a,s,aAnz,sAnz)
             else w := GNZKarazuba(a,s,aAnz,sAnz,Laengediv2);
            If vPositiv=true then ZwSpGNZ:=GNZsub(w,v) else ZwSpGNZ:=GNZadd(w,v);
            //Nun wird ZwSpGNZ mit GlobZahlensystem^Laengediv2 per Shift multipliziert;
            ZwSpAnz:=length(ZwSpGNZ);
            setlength(ZwSpGNZ,ZwSpAnz+Laengediv2);
            for n:=ZwSpAnz-1 downto 0 do ZwSpGNZ[n+Laengediv2]:=ZwSpGNZ[n];
            for n:=0 to Laengediv2-1 do ZwSpGNZ[n]:=0;
            //Ergebnis der Multiplikation:
            Erg:=GNZadd(ZwSpGNZ,w);
          end else
          begin
            //r=0,s=b,p=0,q=a
            //Karazuba:                                                         <-4
            If (aAnz<GNZ_Karazubagrenze)or(bAnz<GNZ_Karazubagrenze) then Erg := GNZmul4Karazuba(a,b,aAnz,bAnz)
             else Erg := GNZKarazuba(a,b,aAnz,bAnz,Laengediv2);
          end; //if-else bAnz>Laengediv2, im Fall aAnz<=Laengediv2;
        end; //if-else aAnz>Laengediv2;
      end else
      begin
        //Schneller Algorithmus zur Multiplikation zweier einstelliger Zahlen:
        ZwSp:=a[0]*qword(b[0]);
        If ZwSp<GNZ_GlobZahlenbasis then
        begin
          setlength(Erg,1);
          Erg[0]:=ZwSp;
        end else
        begin
          setlength(Erg,2);
          Erg[1]:=ZwSp div GNZ_GlobZahlenbasis;
          Erg[0]:=ZwSp mod GNZ_GlobZahlenbasis;
        end; //If ZwSp<GNZ_GlobZahlenbasis
      end; //if Laenge<>1 else
      Result:=Erg;
    end; //GNZKarazuba

var n,na,nb,aAnz,bAnz,Ueberschlag,ErgMaxZeiger: dword;
    ZwSp:qword;
    Erg,ZwErg: GNZTyp;
begin
  aAnz:=length(a); bAnz:=length(b);
  If (aAnz<GNZ_Karazubagrenze)or(bAnz<GNZ_Karazubagrenze) then
  begin
    setlength(Erg,aAnz+bAnz);                                     //Erg wird auf maximale Ausgangslaenge gesetzt
    Erg[0]:=0;
    ErgMaxZeiger:=0;                                              //Zeigt auf hoechste Erg-Stelle
    ZwSp:=0;
    If NOT (((aAnz=1)and(a[0]=0))or((bAnz=1)and(b[0]=0))) then
    begin
      for na:=0 to aAnz-1 do
      begin
        setlength(ZwErg,na+bAnz+1);
        for nb:=0 to bAnz-1 do
        begin
          ZwSp:=qword(a[na])*b[nb] + ZwSp;
          If ZwSp<GNZ_GlobZahlenbasis then
          begin
            ZwErg[na+nb]:=ZwSp;
            ZwSp:=0;
          end else
          begin
            ZwErg[na+nb]:=ZwSp mod GNZ_GlobZahlenbasis;
            ZwSp:=ZwSp div GNZ_GlobZahlenbasis;
          end; //if zwsp<Zbasis
        end; //for bAnz
        If ZwSp<>0 then
        begin
          ZwErg[na+bAnz]:=ZwSp;
          ZwSp:=0;
          //BEGINN Optimierter Additionsalgorithmus:
          If na=0 then
          begin
            for n:=0 to bAnz do Erg[n]:=ZwErg[n];
            ErgMaxZeiger:=bAnz;
          end else
          begin
            Ueberschlag:=0;
            for n := na to ErgMaxZeiger do
            begin
              Ueberschlag := Ueberschlag + Erg[n] + ZwErg[n];
              If Ueberschlag >= GNZ_GlobZahlenbasis then
              begin
                Erg[n] := Ueberschlag - GNZ_GlobZahlenbasis;
                Ueberschlag := 1;
              end else
              begin
                Erg[n] := Ueberschlag;
                Ueberschlag := 0;
              end;
            end; //for n:=na to ErgMaxZeiger do
            if ErgMaxZeiger<>na+bAnz then
            begin
              inc(ErgMaxZeiger);
              Ueberschlag := Ueberschlag + ZwErg[ErgMaxZeiger];
              If Ueberschlag >= GNZ_GlobZahlenbasis then
              begin
                Erg[ErgMaxZeiger] := Ueberschlag - GNZ_GlobZahlenbasis;
                Ueberschlag := 1;
              end else
              begin
                Erg[ErgMaxZeiger] := Ueberschlag;
                Ueberschlag := 0;
              end;
            end; // if ErgMaxZeiger<>na+bAnz
            if ErgMaxZeiger<>na+bAnz then                                //koennte auch in einer while-Schleife
            begin                                                        //geloest werden, die sich dann max.
              inc(ErgMaxZeiger);                                         //2x aufruft-->Langsam
              Ueberschlag := Ueberschlag + ZwErg[ErgMaxZeiger];
              If Ueberschlag >= GNZ_GlobZahlenbasis then
              begin
                Erg[ErgMaxZeiger] := Ueberschlag - GNZ_GlobZahlenbasis;
                Ueberschlag := 1;
              end else
              begin
                Erg[ErgMaxZeiger] := Ueberschlag;
                Ueberschlag := 0;
              end;
            end; // if ErgMaxZeiger<>na+bAnz
            If Ueberschlag=1 then
            begin
              inc(ErgMaxZeiger);
              Erg[ErgMaxZeiger]:=1;
            end;
          end; //if na=0 else
          //ENDE Optimierter Additionsalgorithmus
        end else
        begin
          //setlength(ZwErg,na+bAnz);
          //BEGINN Optimierter Additionsalgorithmus:
          If na=0 then
          begin
            for n:=0 to bAnz-1 do Erg[n]:=ZwErg[n];
            ErgMaxZeiger:=bAnz-1;
          end else
          begin
            Ueberschlag:=0;
            If ErgMaxZeiger <> 0 then
            for n := na to ErgMaxZeiger do
            begin
              Ueberschlag := Ueberschlag + Erg[n] + ZwErg[n];
              If Ueberschlag >= GNZ_GlobZahlenbasis then
              begin
                Erg[n] := Ueberschlag - GNZ_GlobZahlenbasis;
                Ueberschlag := 1;
              end else
              begin
                Erg[n] := Ueberschlag;
                Ueberschlag := 0;
              end;
            end; //for n:=na to ErgMaxZeiger do
            if ErgMaxZeiger<>na+bAnz then
            begin
              inc(ErgMaxZeiger);
              Ueberschlag := Ueberschlag + ZwErg[ErgMaxZeiger];
              If Ueberschlag >= GNZ_GlobZahlenbasis then
              begin
                Erg[ErgMaxZeiger] := Ueberschlag - GNZ_GlobZahlenbasis;
                Ueberschlag := 1;
              end else
              begin
                Erg[ErgMaxZeiger] := Ueberschlag;
                Ueberschlag := 0;
              end;
            end; // if ErgMaxZeiger<>na+bAnz
            if ErgMaxZeiger<>na+bAnz then                                //koennte auch in einer while-Schleife
            begin                                                        //geloest werden, die sich dann max.
              inc(ErgMaxZeiger);                                         //2x aufruft-->Langsam
              Ueberschlag := Ueberschlag + ZwErg[ErgMaxZeiger];
              If Ueberschlag >= GNZ_GlobZahlenbasis then
              begin
                Erg[ErgMaxZeiger] := Ueberschlag - GNZ_GlobZahlenbasis;
                Ueberschlag := 1;
              end else
              begin
                Erg[ErgMaxZeiger] := Ueberschlag;
                Ueberschlag := 0;
              end;
            end; // if ErgMaxZeiger<>na+bAnz
            If Ueberschlag=1 then
            begin
              inc(ErgMaxZeiger);
              Erg[ErgMaxZeiger]:=1;
            end;
          end; //if na=0 else
          //ENDE Optimierter Additionsalgorithmus
        end;

        //ZwErg[na]:=0;
      end; //for aAnz
      If Erg[aAnz+bAnz-1]=0 then setlength(Erg,aAnz+bAnz-1);
    end else  // nun: wenn a=0 oder b=0:
    begin
      setlength(Erg,1);
      Erg[0]:=0;
    end;
  end else     //if Karazuba
  begin
    If aAnz<bAnz then na:=bAnz else na:=aAnz;        //In na steht die Stellenanz. des laengsten.
    n:=2;
    while n<na do n:=n*2;
    Erg:=GNZKarazuba(a,b,aAnz,bAnz,n);
  end;

  Result:=Erg;
end; //GNZmul


function TGnurz.GNZmulword(a:dword;b:GNZtyp):GNZTyp;
var nb,bAnz,Ueberschlag: dword;
    ZwSp:qword;
    Erg: GNZTyp;
begin
  bAnz:=length(b);
  ZwSp:=0;
  setlength(Erg,bAnz+1);
  for nb:=0 to bAnz-1 do
  begin
    ZwSp:=qword(a)*b[nb] + ZwSp;
    If ZwSp<GNZ_GlobZahlenbasis then
    begin
      Erg[nb]:=ZwSp;
      ZwSp:=0;
    end else
    begin
      Erg[nb]:=ZwSp mod GNZ_GlobZahlenbasis;
      ZwSp:=ZwSp div GNZ_GlobZahlenbasis;                      //Ueberschlag
    end; //if zwsp<Zbasis
  end; //for bAnz
  If ZwSp<>0 then
  begin
    Erg[bAnz]:=ZwSp;
    ZwSp:=0;
  end else setlength(Erg,bAnz);
  Result:=Erg;
end; //GNZmulword


function TGnurz.GNZakleinerb(a,b:GNZTyp):boolean;
var n:dword;
    Erg: boolean;
begin
  If length(a)<>length(b) then
  begin
    if length(a)<length(b) then Erg:=true else Erg:=false;
  end else
  begin
    n:=length(a);
    repeat
      dec(n);
    until (a[n]<>b[n])or(n=0);
    If a[n]<b[n] then Erg:=true else Erg:=false;
  end;
  Result:=Erg;
end;


function TGnurz.GNZagleichb(a,b:GNZTyp):boolean;
var n:dword;
    Erg: boolean;
begin
  If length(a)<>length(b) then Erg:=false else
  begin
    n:=length(a);
    repeat
      dec(n);
    until (a[n]<>b[n])or(n=0);
    If a[n]=b[n] then Erg:=true else Erg:=false;
  end;
  Result:=Erg;
end;


function TGnurz.GNZdiv(Divident,Divisor:GNZTyp):GNZTyp;
var ZwSp,testt3:qword;
    LaengeDivident, LaengeDivisor, LaengeErg, n:dword;
    Faktor,uGrenze,testt,testt2,testt4,testt5:dword;
    n_dent, n_sor, n_erg:longint;
    Erg, ZwSpGNZ, ZwErgGNZ, Produkt: GNZTyp;
begin
  //testt2:=0;
  If GNZakleinerb(Divisor,Divident) then
  begin
    LaengeDivident:=length(Divident); LaengeDivisor:=length(Divisor);
    If LaengeDivisor=1 then
    begin
      If Divisor[0]=0 then
      begin
        //Division durch 0 - Erg muss dennoch definiert sein;
        Errormodus:=4;
        setlength(Erg,1);
        Erg[0]:=1;
      end else
      If LaengeDivident=1 then
      begin
        SetLength(Erg,1);
        Erg[0]:=Divident[0] div Divisor[0];
      end else  // LaengeDivident=1
      begin
        //Schulmethode: Schriftliche Division mit einziffrigem Divisor, geschwindigkeitsoptimiert.
        ZwSp:=0;
        n_dent:=LaengeDivident-1;                                 //zeigt auf hoechste Ziffer

        If Divident[n_dent]<Divisor[0] then
        begin
          setlength(Erg,n_dent);                                  //da n_dent=LaengeDivident-1
          ZwSp:=Divident[n_dent]*qword(GNZ_GlobZahlenbasis);
          dec(n_dent);                                            //im Folgenden wurde n_erg durch n_dent ersetzt, da ab hier beide gleiche Werte beinhalten
        end else setlength(Erg,LaengeDivident); //if Divident[n_dent]<Divisor[0] else

        while n_dent<>0 do
        begin
          ZwSp:=ZwSp + Divident[n_dent];
          Erg[n_dent]:=ZwSp div Divisor[0];
          ZwSp := (ZwSp mod Divisor[0])*qword(GNZ_GlobZahlenbasis);
          dec(n_dent);
        end;//while
        ZwSp:=ZwSp + Divident[0];
        Erg[0]:=ZwSp div Divisor[0];
        //ZwSp:=ZwSp mod Divisor[0]; <--- modulo
      end; //if LaengeDivident=1 else
    end else  //LaengeDivisor=1
    begin
      //Schulmethode: Schriftliche Division mit mehrziffrigem Divisor, geschwindigkeitsoptimiert.
      n:=0;
      repeat
        inc(n);
      until (Divident[LaengeDivident-n]<>Divisor[LaengeDivisor-n])or(n=LaengeDivisor);
      If Divident[LaengeDivident-n]<Divisor[LaengeDivisor-n] then
      begin
        LaengeErg:=LaengeDivident-LaengeDivisor;
        setlength(Erg,LaengeErg);
        setlength(ZwSpGNZ,LaengeDivisor+1);
        for n:=0 to LaengeDivisor do ZwSpGNZ[n]:=Divident[LaengeErg-1+n]; //da LaengeErg=LaengeDivident-LaengeDivisor (!)
      end else
      begin
        LaengeErg:=LaengeDivident-LaengeDivisor+1;
        setlength(Erg,LaengeErg);
        setlength(ZwSpGNZ,LaengeDivisor);
        for n:=0 to LaengeDivisor-1 do ZwSpGNZ[n]:=Divident[LaengeDivident-LaengeDivisor+n];
      end; //If Divident[LaengeDivident-n]<Divisor[LaengeDivisor-n] else
      n_erg:=LaengeErg-1; n_dent:=LaengeErg-2;  //Zeigen auf vorderste noch nicht verarbeitete Ziffer
      n_sor:=LaengeDivisor-1;                   //Zeigt auf 1. Ziffer des Divisors
      
      while n_dent<>-1 do
      begin
        If length(ZwSpGNZ)=LaengeDivisor then ZwSp:=ZwSpGNZ[n_sor]
         else ZwSp:=ZwSpGNZ[LaengeDivisor]*qword(GNZ_GlobZahlenbasis) + ZwSpGNZ[n_sor];
        //ANFANG Division des Zwischenergebnisses ZwSpGNZ
        uGrenze:= ZwSp div (Divisor[n_sor]+1);
        Faktor := 0;
        ZwErgGNZ:=copy(ZwSpGNZ);
        while uGrenze<>0 do
        begin
          Faktor:=Faktor+uGrenze;
          Produkt:=GNZmulword(uGrenze,Divisor);
          ZwErgGNZ:=GNZsub(ZwErgGNZ,Produkt);
          If length(ZwErgGNZ)>LaengeDivisor then ZwSp:=ZwErgGNZ[LaengeDivisor]*qword(GNZ_GlobZahlenbasis) + ZwErgGNZ[n_sor]
           else if length(ZwErgGNZ)<LaengeDivisor then ZwSp:=0
           else ZwSp:=ZwErgGNZ[n_sor];
          uGrenze:= ZwSp div (Divisor[n_sor]+1);
        end;
        If GNZakleinerb(ZwErgGNZ,Divisor)=false then Faktor:=Faktor+1;

        Produkt:=GNZmulword(Faktor,Divisor);
        Erg[n_erg]:=Faktor;
        dec(n_erg);
        //ENDE Division des Zwischenergebnisses ZwSpGNZ
        ZwSpGNZ:= GNZsub(ZwSpGNZ,Produkt);
        If (length(ZwSpGNZ)=1)and(ZwSpGNZ[0]=0) then                        //D.h. ZwSpGNZ=GNZnull
        begin
          while (n_dent<>-1)and(Divident[n_dent]=0) do
          begin
            Erg[n_erg]:=0;
            dec(n_erg);
            dec(n_dent);
          end;
          If n_dent<>-1 then
          begin
            Erg[n_erg]:=0;
            dec(n_erg);
            ZwSpGNZ[0]:=Divident[n_dent];
            dec(n_dent);
          end;
        end; // If ZwSpGNZ=GNZnull
        If n_dent <> -1 then
        begin
          setlength(ZwSpGNZ,length(ZwSpGNZ)+1);
          for n:=length(ZwSpGNZ)-2 downto 0 do ZwSpGNZ[n+1]:=ZwSpGNZ[n];     //Um 1 Stelle nach links verschieben
          ZwSpGNZ[0]:=Divident[n_dent];
          dec(n_dent);
        end; // if n_dent <> -1
        while (n_dent<>-1)and(GNZakleinerb(ZwSpGNZ,Divisor)=true) do
        begin
          Erg[n_erg]:=0;
          dec(n_erg);
          setlength(ZwSpGNZ,length(ZwSpGNZ)+1);
          for n:=length(ZwSpGNZ)-2 downto 0 do ZwSpGNZ[n+1]:=ZwSpGNZ[n];     //Um 1 Stelle nach links verschieben
          ZwSpGNZ[0]:=Divident[n_dent];
          dec(n_dent);
        end; //while (n_dent<>-1)and(GNZakleinerb(ZwSpGNZ,Divisor)=true)
      end; //while n_dent<>-1
      If GNZakleinerb(ZwSpGNZ,Divisor)=true then
      begin
        If n_erg<>-1 then Erg[n_erg]:=0
      end else
      begin
        If length(ZwSpGNZ)=LaengeDivisor then ZwSp:=ZwSpGNZ[n_sor]
         else ZwSp:=ZwSpGNZ[LaengeDivisor]*qword(GNZ_GlobZahlenbasis) + ZwSpGNZ[n_sor];
        //ANFANG Division des Zwischenergebnisses ZwSpGNZ
        uGrenze:= ZwSp div (Divisor[n_sor]+1);
        Faktor := 0;
        ZwErgGNZ:=copy(ZwSpGNZ);
        while uGrenze<>0 do
        begin
          Faktor:=Faktor+uGrenze;
          Produkt:=GNZmulword(uGrenze,Divisor);
          ZwErgGNZ:=GNZsub(ZwErgGNZ,Produkt);
          If length(ZwErgGNZ)>LaengeDivisor then ZwSp:=ZwErgGNZ[LaengeDivisor]*qword(GNZ_GlobZahlenbasis) + ZwErgGNZ[n_sor]
           else if length(ZwErgGNZ)<LaengeDivisor then ZwSp:=0
           else ZwSp:=ZwErgGNZ[n_sor];
          uGrenze:= ZwSp div (Divisor[n_sor]+1);
        end;
        If GNZakleinerb(ZwErgGNZ,Divisor)=false then Faktor:=Faktor+1;

        Produkt:=GNZmulword(Faktor,Divisor);
        Erg[n_erg]:=Faktor;
        dec(n_erg);
        //ENDE Division des Zwischenergebnisses ZwSpGNZ
      end; //If GNZakleinerb(ZwSpGNZ,Divisor) else
      //ZwSpGNZ:= GNZsub(ZwSpGNZ,Produkt); <--- modulo
    end; //if LaengeDivisor=1 else

  end else if GNZagleichb(Divisor,Divident) then
  begin
    setlength(Erg,1);
    Erg[0]:=1;
  end else
  begin
    setlength(Erg,1);
    Erg[0]:=0;
  end;
  Result:=Erg;
end; // GNZDiv


function TGnurz.GNZmod(Divident, Divisor:GNZTyp):GNZTyp;
//Result:= GNZsub(Divident,GNZmul(GNZdiv(Divident,Divisor),Divisor));
var ZwSp,testt3:qword;
    LaengeDivident, LaengeDivisor, LaengeErg, n:dword;
    Faktor,uGrenze:dword;
    n_dent, n_sor, n_erg:longint;
    Erg, ZwSpGNZ, ZwErgGNZ, Produkt: GNZTyp;
begin
  If GNZakleinerb(Divisor,Divident) then
  begin
    LaengeDivident:=length(Divident); LaengeDivisor:=length(Divisor);
    If LaengeDivisor=1 then
    begin
      If Divisor[0]=0 then
      begin
        Result:=copy(Divident);
      end else
      If LaengeDivident=1 then
      begin
        SetLength(Result,1);
        Result[0]:=Divident[0] mod Divisor[0];
      end else  // LaengeDivident=1
      begin
        //Schulmethode: Schriftliche Division mit einziffrigem Divisor, geschwindigkeitsoptimiert.
        ZwSp:=0;
        n_dent:=LaengeDivident-1;                                 //zeigt auf hoechste Ziffer

        If Divident[n_dent]<Divisor[0] then
        begin;                                  //da n_dent=LaengeDivident-1
          ZwSp:=Divident[n_dent]*qword(GNZ_GlobZahlenbasis);
          dec(n_dent);
        end; //if Divident[n_dent]<Divisor[0] else

        while n_dent<>0 do
        begin
          ZwSp:=ZwSp + Divident[n_dent];
          ZwSp := (ZwSp mod Divisor[0])*qword(GNZ_GlobZahlenbasis);
          dec(n_dent);
        end;//while
        ZwSp:=ZwSp + Divident[0];
        setlength(Result,1);
        Result[0]:=ZwSp mod Divisor[0]; //<--- modulo
      end; //if LaengeDivident=1 else
    end else  //LaengeDivisor=1
    begin
      //Schulmethode: Schriftliche Division mit mehrziffrigem Divisor, geschwindigkeitsoptimiert.
      n:=0;
      repeat
        inc(n);
      until (Divident[LaengeDivident-n]<>Divisor[LaengeDivisor-n])or(n=LaengeDivisor);
      If Divident[LaengeDivident-n]<Divisor[LaengeDivisor-n] then
      begin
        n_dent:=LaengeDivident-LaengeDivisor-2;
        setlength(ZwSpGNZ,LaengeDivisor+1);
        for n:=0 to LaengeDivisor do ZwSpGNZ[n]:=Divident[n_dent+1+n]; //da LaengeErg=LaengeDivident-LaengeDivisor (!)
      end else
      begin
        n_dent:=LaengeDivident-LaengeDivisor-1;
        setlength(ZwSpGNZ,LaengeDivisor);
        for n:=0 to LaengeDivisor-1 do ZwSpGNZ[n]:=Divident[LaengeDivident-LaengeDivisor+n];
      end; //If Divident[LaengeDivident-n]<Divisor[LaengeDivisor-n] else
      n_sor:=LaengeDivisor-1;                   //Zeigt auf 1. Ziffer des Divisors

      while n_dent<>-1 do
      begin
        If length(ZwSpGNZ)=LaengeDivisor then ZwSp:=ZwSpGNZ[n_sor]
         else ZwSp:=ZwSpGNZ[LaengeDivisor]*qword(GNZ_GlobZahlenbasis) + ZwSpGNZ[n_sor];
        //ANFANG Division des Zwischenergebnisses ZwSpGNZ
        uGrenze:= ZwSp div (Divisor[n_sor]+1);
        Faktor := 0;
        ZwErgGNZ:=copy(ZwSpGNZ);
        while uGrenze<>0 do
        begin
          Faktor:=Faktor+uGrenze;
          Produkt:=GNZmulword(uGrenze,Divisor);
          ZwErgGNZ:=GNZsub(ZwErgGNZ,Produkt);
          If length(ZwErgGNZ)>LaengeDivisor then ZwSp:=ZwErgGNZ[LaengeDivisor]*qword(GNZ_GlobZahlenbasis) + ZwErgGNZ[n_sor]
           else if length(ZwErgGNZ)<LaengeDivisor then ZwSp:=0
           else ZwSp:=ZwErgGNZ[n_sor];
          uGrenze:= ZwSp div (Divisor[n_sor]+1);
        end;
        If GNZakleinerb(ZwErgGNZ,Divisor)=false then Faktor:=Faktor+1;

        Produkt:=GNZmulword(Faktor,Divisor);
        //ENDE Division des Zwischenergebnisses ZwSpGNZ
        ZwSpGNZ:= GNZsub(ZwSpGNZ,Produkt);
        If (length(ZwSpGNZ)=1)and(ZwSpGNZ[0]=0) then                        //D.h. ZwSpGNZ=GNZnull
        begin
          while (n_dent<>-1)and(Divident[n_dent]=0) do
          begin
            dec(n_dent);
          end;
          If n_dent<>-1 then
          begin
            ZwSpGNZ[0]:=Divident[n_dent];
            dec(n_dent);
          end;
        end; // If ZwSpGNZ=GNZnull
        If n_dent <> -1 then
        begin
          setlength(ZwSpGNZ,length(ZwSpGNZ)+1);
          for n:=length(ZwSpGNZ)-2 downto 0 do ZwSpGNZ[n+1]:=ZwSpGNZ[n];     //Um 1 Stelle nach links verschieben
          ZwSpGNZ[0]:=Divident[n_dent];
          dec(n_dent);
        end; // if n_dent <> -1
        while (n_dent<>-1)and(GNZakleinerb(ZwSpGNZ,Divisor)=true) do
        begin
          setlength(ZwSpGNZ,length(ZwSpGNZ)+1);
          for n:=length(ZwSpGNZ)-2 downto 0 do ZwSpGNZ[n+1]:=ZwSpGNZ[n];     //Um 1 Stelle nach links verschieben
          ZwSpGNZ[0]:=Divident[n_dent];
          dec(n_dent);
        end; //while (n_dent<>-1)and(GNZakleinerb(ZwSpGNZ,Divisor)=true)
      end; //while n_dent<>-1
      If GNZakleinerb(ZwSpGNZ,Divisor)=true then
      begin
        //If n_erg<>-1 then Erg[n_erg]:=0
        Result:=ZwSpGNZ;
      end else
      begin
        If length(ZwSpGNZ)=LaengeDivisor then ZwSp:=ZwSpGNZ[n_sor]
         else ZwSp:=ZwSpGNZ[LaengeDivisor]*qword(GNZ_GlobZahlenbasis) + ZwSpGNZ[n_sor];
        //ANFANG Division des Zwischenergebnisses ZwSpGNZ
        uGrenze:= ZwSp div (Divisor[n_sor]+1);
        Faktor := 0;
        ZwErgGNZ:=copy(ZwSpGNZ);
        while uGrenze<>0 do
        begin
          Faktor:=Faktor+uGrenze;
          Produkt:=GNZmulword(uGrenze,Divisor);
          ZwErgGNZ:=GNZsub(ZwErgGNZ,Produkt);
          If length(ZwErgGNZ)>LaengeDivisor then ZwSp:=ZwErgGNZ[LaengeDivisor]*qword(GNZ_GlobZahlenbasis) + ZwErgGNZ[n_sor]
           else if length(ZwErgGNZ)<LaengeDivisor then ZwSp:=0
           else ZwSp:=ZwErgGNZ[n_sor];
          uGrenze:= ZwSp div (Divisor[n_sor]+1);
        end;
        If GNZakleinerb(ZwErgGNZ,Divisor)=false then Faktor:=Faktor+1;

        Produkt:=GNZmulword(Faktor,Divisor);
        //ENDE Division des Zwischenergebnisses ZwSpGNZ
        Result:= GNZsub(ZwSpGNZ,Produkt);
      end; //If GNZakleinerb(ZwSpGNZ,Divisor) else
    end; //if LaengeDivisor=1 else

  end else if GNZagleichb(Divisor,Divident) then
  begin
    setlength(Result,1);
    Result[0]:=0;
  end else
  begin
    Result:=copy(Divident);
  end;
end; //GNZmod


function TGnurz.GNZggt(a,b:GNZTyp):GNZTyp;   // Nach modernen Euklidischen Algorithmus
begin
  if (length(b)=1)and(b[0]=0) then Result:=a else Result:=GNZggt(b, GNZmod(a,b));
end;


function TGnurz.GNZkgv(a,b:GNZTyp):GNZTyp;   // über den ggT
begin
  GNZkgv:=GNZdiv(GNZmul(a,b),GNZggt(a,b));
end;


function TGnurz.GNZistgerade(zahl:GNZTyp):boolean;
var n, ugz:integer;
begin
  If GNZ_GlobZahlenbasis mod 2 = 0 then
  begin
    if zahl[0] mod 2 = 0 then Result:=true else Result:=false;
  end else
  begin
    ugz:=0;
    for n:=0 to length(zahl)-1 do
    begin
      if zahl[n] mod 2 <>0 then inc(ugz);
    end;
    if ugz mod 2 = 0 then Result:=true else Result:=false;
  end;
end; //GNZistgerade


function TGnurz.GNZPotenz(Basis,Exponent:GNZTyp):GNZTyp; //Algorithmus im Internet gefunden.
var z,e,Erg,eins,zwei:GNZTyp;
begin
  z:=copy(Basis);
  e:=copy(Exponent);
  setlength(eins,1);
  eins[0]:=1;
  Erg:=eins;
  zwei:=GNZadd(eins,eins);

  while not ((length(e)=1)and(e[0]=0)) do
  begin
    If GNZistgerade(e) then
    begin
      e:=GNZdiv(e,zwei);
      z:=GNZmul(z,z);
    end else
    begin
      e:=GNZsub(e,eins);
      Erg:=GNZmul(Erg,z);
    end;
  end; //while
  Result:=Erg;
end; //GNZPotenz


function TGnurz.GNZPotenzMod(Basis,Exponent,Modulo:GNZTyp):GNZTyp;
var z,e,Erg,eins,zwei:GNZTyp;
begin
  z:=copy(Basis);
  e:=copy(Exponent);
  setlength(eins,1);
  eins[0]:=1;
  Erg:=eins;
  zwei:=GNZadd(eins,eins);

  while not ((length(e)=1)and(e[0]=0)) do
  begin
    If GNZistgerade(e) then
    begin
      e:=GNZdiv(e,zwei);
      z:=GNZmul(z,z);
      z:=GNZmod(z,Modulo);
    end else
    begin
      e:=GNZsub(e,eins);
      Erg:=GNZmul(Erg,z);
      Erg:=GNZmod(Erg,Modulo);
    end;
  end; //while
  Result:=Erg;
end; // GNZPotenzMod


function TGnurz.GNZFakultaet(nFak:dword):GNZTyp;
var n:dword;
    Erg,ZwSpGNZ:GNZTyp;
begin
  setlength(Erg,1); Erg[0]:=1;
  setlength(ZwSpGNZ,1);
  for n:=2 to nFak do
  begin
    ZwSpGNZ[0]:=n;
    Erg:=GNZmul(ZwSpGNZ,Erg);
  end;
  Result:=Erg;
end; //GNZFakultaet

function TGnurz.GNZIstPrim(zahl:GNZTyp):boolean;
var Wurzk, Wurzkp1,GNZzwei,GNZn,ZwErg: GNZTyp;
    n,nbis:word;
    prim:boolean;
begin
  setlength(GNZzwei,1);                // GlobZahlenBasis muss >2 sein.
  GNZzwei[0]:=2;
  If (length(Zahl)>1)or(zahl[0]>4) then
  begin
    If GNZmod(zahl,GNZzwei)[0] = 0 then prim:=false else
    begin
      prim:=true;
      //Zunaechst wird die Wurzel von Zahl (ueber Newton-Verfahren) fuer den klassischen Primzahltest abgeschaetzt:
      nbis:=length(zahl) div 2;
      Wurzk:=GNZdiv(zahl,GNZzwei);
      for n:=0 to nbis do
      begin
        Wurzkp1:=GNZadd(Wurzk,GNZdiv(zahl,Wurzk));
        Wurzkp1:=GNZdiv(Wurzkp1,GNZzwei);
        Wurzk:=copy(Wurzkp1);
      end;
      //Klassischer Primzahltest:
      setlength(GNZn,1);
      GNZn[0]:=1;
      repeat
        GNZn:=GNZadd(GNZn,GNZzwei);
        ZwErg:=GNZmod(zahl,GNZn);
        if (length(ZwErg)=1)and(ZwErg[0]=0) then prim:=false;
      until (prim=false)or(GNZakleinerb(Wurzkp1,GNZn));
    end; //if
  end else prim:= (zahl[0]=2)or(zahl[0]=3);
  GNZIstPrim:=prim;
end; //GNZIstPrim


function TGnurz.GNZMillerRabin(Zahl:GNZTyp; it:word):boolean;
var eins,zwei,Zahlminus1,d,a,x:GNZTyp;
    n,n2,s,laengeam1:dword;
    bestanden,xgzm1:boolean;
begin
  setlength(eins,1);
  eins[0]:=1;
  zwei:=GNZadd(eins,eins);
  If GNZistgerade(Zahl) or (not GNZakleinerb(eins,Zahl)) or (it=0) then bestanden:=false else
  begin
    bestanden:=true;
    Zahlminus1:=GNZsub(Zahl,eins);
    //Berechnung von s und d durch Bedingung: (Zahl-1)=2^s*d mit d ungerade:
    d:=copy(Zahlminus1);
    s:=0;
    while GNZistgerade(d) do
    begin
      inc(s);
      d:=GNZdiv(d,zwei);
    end;
    //Test-Iterationen:
    n:=0;
    repeat
      //a zufaellig aus {2,...,Zahl-1} nehmen...:
      laengeam1:=length(Zahlminus1)-1;
      setlength(a,laengeam1+1);
      for n2:= laengeam1 downto 0 do
      begin
        a[n2]:=random(Zahlminus1[n2]+1);
        if (laengeam1=n2)and(a[n2]=0) then
        begin
          if laengeam1<>0 then
          begin
            setlength(a,laengeam1);
            dec(laengeam1);
          end;
        end; //if
      end; //for
      if (laengeam1=0)and(a[0]<2) then a[0]:=random(Zahlminus1[0]-2)+2;
      //Nun der eigentliche Test:
      x:=GNZPotenzMod(a,d,Zahl);
      If (GNZagleichb(x,eins)=false) and (GNZagleichb(x,Zahlminus1)=false) then
      begin
        n2:=0;
        repeat
          inc(n2);
          x:=GNZPotenzMod(x,zwei,Zahl);
          If ((length(x)=1)and(x[0]=1)) then bestanden:=false;
          xgzm1:=GNZagleichb(x,Zahlminus1);
        until (n2>=s-1)or xgzm1 or(bestanden=false);
        if xgzm1=false then bestanden:=false;
      end; //if
      inc(n);
    until (n=it)or(bestanden=false);
  end; //if
  Result:=bestanden;
end; // GNZMillerRabin


function TGnurz.GNZMRPrimdanach(zahl:GNZTyp; it:word):GNZTyp;
var eins,zwei:GNZTyp;
begin
  setlength(eins,1); eins[0]:=1;
  zwei:= GNZadd(eins,eins);
  If GNZistgerade(zahl) then Result:= GNZadd(zahl,eins) else Result:= GNZadd(zahl,zwei);
  while not GNZMillerRabin(Result,it) do Result:= GNZadd(Result,zwei);
end;  // GNZMRPrimdanach


function TGnurz.GNZZufall(Obergrenze:GNZTyp):GNZTyp;
var Erg:GNZTyp;
    n,laengeErgm1:Integer;
begin
  laengeErgm1:= length(Obergrenze)-1;
  setlength(Erg,laengeErgm1+1);
  for n:= laengeErgm1 downto 1 do
  begin
    Erg[n]:= random(Obergrenze[n]+1);
    if (laengeErgm1=n)and(Erg[n]=0) then
    begin
      setlength(Erg,laengeErgm1);
      dec(laengeErgm1);
    end; //if
  end; //for
  Erg[0]:= random(Obergrenze[0]);
  Result:=Erg;
end;  // GNZZufall

function TGnurz.GNZeins:GNZTyp;
var ZwSp:GNZTyp;
begin
  setlength(ZwSp,1);
  ZwSp[0]:=1;
  Result:=ZwSp;
end;  // GNZeins

function TGnurz.GNZnull:GNZTyp;
var ZwSp:GNZTyp;
begin
  setlength(ZwSp,1);
  ZwSp[0]:=0;
  Result:=ZwSp;
end;  // GNZnull


//GRaZ-Operatonen - Rechnen mit grossen Rationalen Zahlen  ---------------------------------------------------


function TGnurz.GRaZKuerzen(Bruch:GRaZTyp):GRaZTyp;
var ZwSpGNZ:GNZTyp;
begin
  //Eventuelles Kuerzen:
  If (length(Bruch.zaehler)=1)and(Bruch.zaehler[0]=0) then
  begin
    Result.zaehler :=GNZnull;
    Result.nenner  :=GNZeins;
    Result.Negativ :=false;
  end else
    begin
    ZwSpGNZ:=GNZggt(Bruch.nenner,Bruch.zaehler);
    If (length(ZwSpGNZ)=1)and(ZwSpGNZ[0]=1) then Result:=Bruch else
    begin
      Result.zaehler:=GNZdiv(Bruch.zaehler,ZwSpGNZ);
      Result.nenner:=GNZdiv(Bruch.nenner,ZwSpGNZ);
    end;
    Result.Negativ:=Bruch.Negativ;
  end;
end;  //GRaZKuerzen


function TGnurz.GRaZadd(a,b:GRaZTyp):GRaZTyp;
var ZwSpGNZ:GNZTyp;
    Erg:GRaZTyp;
begin
  ZwSpGNZ:=GNZkgv(a.nenner,b.nenner);     //Brueche auf einen Nenner bringen...
  If a.Negativ=b.Negativ then
  begin
    Erg.nenner:=ZwSpGNZ;
    Erg.zaehler:=GNZadd(GNZmul(a.zaehler,GNZdiv(ZwSpGNZ,a.nenner)),GNZmul(b.zaehler,GNZdiv(ZwSpGNZ,b.nenner)));
    Erg.Negativ:=a.Negativ;
  end else
  if GRaZakleinerbBetrag(a,b) then
  begin
    Erg.nenner:=ZwSpGNZ;
    Erg.zaehler:=GNZsub(GNZmul(b.zaehler,GNZdiv(ZwSpGNZ,b.nenner)),GNZmul(a.zaehler,GNZdiv(ZwSpGNZ,a.nenner))); //b-a
    Erg.Negativ:=b.Negativ;
  end else
  begin
    Erg.nenner:=ZwSpGNZ;
    Erg.zaehler:=GNZsub(GNZmul(a.zaehler,GNZdiv(ZwSpGNZ,a.nenner)),GNZmul(b.zaehler,GNZdiv(ZwSpGNZ,b.nenner))); //a-b
    Erg.Negativ:=a.Negativ;
    If (length(Erg.zaehler)=1)and(Erg.zaehler[0]=0) then
    begin
      Erg.nenner:=GNZeins;
      Erg.Negativ:=false;
    end;
  end;
  Result:=GRaZKuerzen(Erg);
end; //GRaZadd


function TGnurz.GRazsub(Minuent,Subtrahend:GRaZTyp):GRaZTyp;
begin
  Subtrahend.Negativ:=not Subtrahend.Negativ;
  Result:=GRaZadd(Minuent,Subtrahend);
end; //GRaZsub


function TGnurz.GRaZmul(a,b:GRaZTyp):GRaZTyp;
var Erg:GRaZTyp;
begin
  Erg.zaehler:=GNZmul(a.zaehler,b.zaehler);
  Erg.nenner:=GNZmul(a.nenner,b.nenner);
  Erg.Negativ:= a.Negativ xor b.Negativ;
  Result:=GRaZKuerzen(Erg);
end; //GRaZmul


function TGnurz.GRaZdiv(Divident,Divisor:GRaZTyp):GRaZTyp;
var Erg:GRaZTyp;
begin
  Erg.zaehler:=GNZmul(Divident.zaehler,Divisor.nenner);
  Erg.nenner:=GNZmul(Divident.nenner,Divisor.zaehler);
  Erg.Negativ:= Divident.Negativ xor Divisor.Negativ;
  Result:=GRaZKuerzen(Erg);
end; //GRaZdiv


function TGnurz.GRaZakleinerbBetrag(a,b:GRaZTyp):boolean;
var ZwSpGNZ:GNZTyp;
begin
  ZwSpGNZ:=GNZkgv(a.nenner,b.nenner);
  Result:=GNZakleinerb(GNZmul(a.zaehler,GNZdiv(ZwSpGNZ,a.nenner)),GNZmul(b.zaehler,GNZdiv(ZwSpGNZ,b.nenner)));
end; //GRaZakleinerbBetrag


function TGnurz.GRaZakleinerb(a,b:GRaZTyp):boolean;
var ZwSpGNZ:GNZTyp;
begin
  If (a.Negativ)and(not b.Negativ) then Result:=true else if (not a.Negativ)and(b.Negativ) then Result:=false
  else if (not a.Negativ)and(not b.Negativ) then
  begin
    ZwSpGNZ:=GNZkgv(a.nenner,b.nenner);
    Result:=GNZakleinerb(GNZmul(a.zaehler,GNZdiv(ZwSpGNZ,a.nenner)),GNZmul(b.zaehler,GNZdiv(ZwSpGNZ,b.nenner)));
  end else
  begin
    ZwSpGNZ:=GNZkgv(a.nenner,b.nenner);
    Result:=GNZakleinerb(GNZmul(b.zaehler,GNZdiv(ZwSpGNZ,b.nenner)),GNZmul(a.zaehler,GNZdiv(ZwSpGNZ,a.nenner)));
  end;
end; //GRaZakleinerb


function TGnurz.GRaZagleichbBetrag(a,b:GRaZTyp):boolean;
var ZwSpGNZ:GNZTyp;
begin
  ZwSpGNZ:=GNZkgv(a.nenner,b.nenner);
  Result:=GNZagleichb(GNZmul(a.zaehler,GNZdiv(ZwSpGNZ,a.nenner)),GNZmul(b.zaehler,GNZdiv(ZwSpGNZ,b.nenner)));
end; //GRaZagleichbBetrag


function TGnurz.GRaZagleichb(a,b:GRaZTyp):boolean;
var ZwSpGNZ:GNZTyp;
begin
  If a.Negativ=b.Negativ then
  begin
    ZwSpGNZ:=GNZkgv(a.nenner,b.nenner);
    Result:=GNZagleichb(GNZmul(a.zaehler,GNZdiv(ZwSpGNZ,a.nenner)),GNZmul(b.zaehler,GNZdiv(ZwSpGNZ,b.nenner)));
  end else Result:=false;
end; //GRaZagleichb 


end.

