// GNURZ-DEMO
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

unit Unit1; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls, gnurz;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure Edit2Change(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: char);
    procedure Edit4Change(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: char);
    procedure Edit5Change(Sender: TObject);
    procedure Edit5KeyPress(Sender: TObject; var Key: char);
    procedure Edit7Change(Sender: TObject);
    procedure Edit7KeyPress(Sender: TObject; var Key: char);
    procedure Edit8Change(Sender: TObject);
    procedure Edit8KeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 
  GnurzObjekt: TGnurz;
  a, b: GNZTyp;
  c, d: GRaZTyp;

implementation

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  a := GnurzObjekt.StrToGNZTyp(Edit1.Text);
  b := GnurzObjekt.StrToGNZTyp(Edit2.Text);

  Edit3.Text:='';
  Button2.Enabled:=true;
  Button3.Enabled:=true;
  Button4.Enabled:=true;
  Button5.Enabled:=true;
  Button6.Enabled:=true;
  Button7.Enabled:=true;
  Button8.Enabled:=true;
end;

procedure TForm1.Button10Click(Sender: TObject);
var Ergebnis: GRazTyp;
    Vorzeichen: string;
begin
  Ergebnis := GnurzObjekt.GRaZadd(c,d);

  If Ergebnis.Negativ then Vorzeichen:='-' else Vorzeichen:='';
  Edit6.Text := Vorzeichen + GnurzObjekt.GNZTypToStr(Ergebnis.zaehler);
  Edit9.Text := GnurzObjekt.GNZTypToStr(Ergebnis.nenner);
end;

procedure TForm1.Button11Click(Sender: TObject);
var Ergebnis: GRazTyp;
    Vorzeichen: string;
begin
  Ergebnis := GnurzObjekt.GRaZsub(c,d);

  If Ergebnis.Negativ then Vorzeichen:='-' else Vorzeichen:='';
  Edit6.Text := Vorzeichen + GnurzObjekt.GNZTypToStr(Ergebnis.zaehler);
  Edit9.Text := GnurzObjekt.GNZTypToStr(Ergebnis.nenner);
end;

procedure TForm1.Button12Click(Sender: TObject);
var Ergebnis: GRazTyp;
    Vorzeichen: string;
begin
  Ergebnis := GnurzObjekt.GRaZmul(c,d);

  If Ergebnis.Negativ then Vorzeichen:='-' else Vorzeichen:='';
  Edit6.Text := Vorzeichen + GnurzObjekt.GNZTypToStr(Ergebnis.zaehler);
  Edit9.Text := GnurzObjekt.GNZTypToStr(Ergebnis.nenner);
end;

procedure TForm1.Button13Click(Sender: TObject);
var Ergebnis: GRazTyp;
    Vorzeichen: string;
begin
  Ergebnis := GnurzObjekt.GRaZdiv(c,d);

  If Ergebnis.Negativ then Vorzeichen:='-' else Vorzeichen:='';
  Edit6.Text := Vorzeichen + GnurzObjekt.GNZTypToStr(Ergebnis.zaehler);
  Edit9.Text := GnurzObjekt.GNZTypToStr(Ergebnis.nenner);
end;

procedure TForm1.Button14Click(Sender: TObject);
var Ergebnis: GRazTyp;
    Vorzeichen: string;
begin
  Ergebnis := GnurzObjekt.GRaZKuerzen(c);

  If Ergebnis.Negativ then Vorzeichen:='-' else Vorzeichen:='';
  Edit6.Text := Vorzeichen + GnurzObjekt.GNZTypToStr(Ergebnis.zaehler);
  Edit9.Text := GnurzObjekt.GNZTypToStr(Ergebnis.nenner);
end;

procedure TForm1.Button15Click(Sender: TObject);
var Ergebnis: GRazTyp;
    Vorzeichen: string;
begin
  Ergebnis := GnurzObjekt.GRaZKuerzen(d);

  If Ergebnis.Negativ then Vorzeichen:='-' else Vorzeichen:='';
  Edit6.Text := Vorzeichen + GnurzObjekt.GNZTypToStr(Ergebnis.zaehler);
  Edit9.Text := GnurzObjekt.GNZTypToStr(Ergebnis.nenner);
end;



procedure TForm1.Button2Click(Sender: TObject);
var Ergebnis: GNZTyp;
begin
  Ergebnis := GnurzObjekt.GNZadd(a,b);
  
  Edit3.Text := GnurzObjekt.GNZTypToStr(Ergebnis);
end;

procedure TForm1.Button3Click(Sender: TObject);
var Ergebnis: GNZTyp;
begin
  Ergebnis := GnurzObjekt.GNZsub(a,b);

  If GnurzObjekt.GetErrormodus=1
   then Edit3.Text := '-' + GnurzObjekt.GNZTypToStr(Ergebnis)
   else Edit3.Text := GnurzObjekt.GNZTypToStr(Ergebnis);
end;

procedure TForm1.Button4Click(Sender: TObject);
var Ergebnis: GNZTyp;
begin
  Ergebnis := GnurzObjekt.GNZmul(a,b);

  Edit3.Text := GnurzObjekt.GNZTypToStr(Ergebnis);
end;

procedure TForm1.Button5Click(Sender: TObject);
var Ergebnis: GNZTyp;
begin
  Ergebnis := GnurzObjekt.GNZdiv(a,b);

  Edit3.Text := GnurzObjekt.GNZTypToStr(Ergebnis);
end;

procedure TForm1.Button6Click(Sender: TObject);
var Ergebnis: GNZTyp;
begin
  Ergebnis := GnurzObjekt.GNZmod(a,b);

  Edit3.Text := GnurzObjekt.GNZTypToStr(Ergebnis);
end;

procedure TForm1.Button7Click(Sender: TObject);
var Ergebnis: GNZTyp;
begin
  Ergebnis := GnurzObjekt.GNZggt(a,b);

  Edit3.Text := GnurzObjekt.GNZTypToStr(Ergebnis);
end;

procedure TForm1.Button8Click(Sender: TObject);
var Ergebnis: GNZTyp;
begin
  Ergebnis   := GnurzObjekt.GNZkgv(a,b);

  Edit3.Text := GnurzObjekt.GNZTypToStr(Ergebnis);
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  c.zaehler  := GnurzObjekt.StrToGNZTyp(Edit4.Text);
  c.nenner   := GnurzObjekt.StrToGNZTyp(Edit7.Text);
  c.Negativ  := Checkbox1.Checked;
  d.zaehler  := GnurzObjekt.StrToGNZTyp(Edit5.Text);
  d.nenner := GnurzObjekt.StrToGNZTyp(Edit8.Text);
  d.Negativ  := Checkbox2.Checked;

  Edit6.Text:=''; Edit9.Text:='';
  Button10.Enabled:=true;
  Button11.Enabled:=true;
  Button12.Enabled:=true;
  Button13.Enabled:=true;
  Button14.Enabled:=true;
  Button15.Enabled:=true;
end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  Button10.Enabled:=false;
  Button11.Enabled:=false;
  Button12.Enabled:=false;
  Button13.Enabled:=false;
  Button14.Enabled:=false;
  Button15.Enabled:=false;
end;

procedure TForm1.CheckBox2Change(Sender: TObject);
begin
  Button10.Enabled:=false;
  Button11.Enabled:=false;
  Button12.Enabled:=false;
  Button13.Enabled:=false;
  Button14.Enabled:=false;
  Button15.Enabled:=false;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  Button2.Enabled:=false;
  Button3.Enabled:=false;
  Button4.Enabled:=false;
  Button5.Enabled:=false;
  Button6.Enabled:=false;
  Button7.Enabled:=false;
  Button8.Enabled:=false;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  If not((ord(Key)>=48)and(ord(Key)<=57)) then Key:=chr(0);
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
  Button2.Enabled:=false;
  Button3.Enabled:=false;
  Button4.Enabled:=false;
  Button5.Enabled:=false;
  Button6.Enabled:=false;
  Button7.Enabled:=false;
  Button8.Enabled:=false;
end;

procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: char);
begin
  If not((ord(Key)>=48)and(ord(Key)<=57)) then Key:=chr(0);
end;

procedure TForm1.Edit4Change(Sender: TObject);
begin
  Button10.Enabled:=false;
  Button11.Enabled:=false;
  Button12.Enabled:=false;
  Button13.Enabled:=false;
  Button14.Enabled:=false;
  Button15.Enabled:=false;
end;

procedure TForm1.Edit4KeyPress(Sender: TObject; var Key: char);
begin
  If not((ord(Key)>=48)and(ord(Key)<=57)) then Key:=chr(0);
end;

procedure TForm1.Edit5Change(Sender: TObject);
begin
  Button10.Enabled:=false;
  Button11.Enabled:=false;
  Button12.Enabled:=false;
  Button13.Enabled:=false;
  Button14.Enabled:=false;
  Button15.Enabled:=false;
end;

procedure TForm1.Edit5KeyPress(Sender: TObject; var Key: char);
begin
  If not((ord(Key)>=48)and(ord(Key)<=57)) then Key:=chr(0);
end;

procedure TForm1.Edit7Change(Sender: TObject);
begin
  Button10.Enabled:=false;
  Button11.Enabled:=false;
  Button12.Enabled:=false;
  Button13.Enabled:=false;
  Button14.Enabled:=false;
  Button15.Enabled:=false;
end;

procedure TForm1.Edit7KeyPress(Sender: TObject; var Key: char);
begin
  If not((ord(Key)>=48)and(ord(Key)<=57)) then Key:=chr(0);
end;

procedure TForm1.Edit8Change(Sender: TObject);
begin
  Button10.Enabled:=false;
  Button11.Enabled:=false;
  Button12.Enabled:=false;
  Button13.Enabled:=false;
  Button14.Enabled:=false;
  Button15.Enabled:=false;
end;

procedure TForm1.Edit8KeyPress(Sender: TObject; var Key: char);
begin
  If not((ord(Key)>=48)and(ord(Key)<=57)) then Key:=chr(0);
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  GnurzObjekt.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  GnurzObjekt := TGnurz.create;
end;

initialization
  {$I unit1.lrs}

end.

