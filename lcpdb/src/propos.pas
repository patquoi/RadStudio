(******************************************************************************
LE COMPTE POUR DE BON - Atelier de recherche de calculs de comptes à trouver

Copyright (C) 2005 Patrice FOUQUET

Ce programme est un logiciel libre ; vous pouvez le redistribuer et/ou le
modifier conformément aux dispositions de la Licence Publique Générale GNU,
telle que publiée par la Free Software Foundation ; version 2 de la licence,
ou encore toute version ultérieure.

Ce programme est distribué dans l'espoir qu'il sera utile,
mais SANS AUCUNE GARANTIE ; sans même la garantie implicite de COMMERCIALISATION
ou D'ADAPTATION A UN OBJET PARTICULIER. Pour plus de détail,
voir la Licence Publique Générale GNU.

Vous devez avoir reçu un exemplaire de la Licence Publique Générale GNU en même
temps que ce programme ; si ce n'est pas le cas,
écrivez à la Free Software Foundation Inc.,
675 Mass Ave, Cambridge, MA 02139, Etats-Unis.

Pour toutes informations:
mailto:patquoi@free.fr
http://patquoi.free.fr

-------------------------------------------------------------------------------

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
******************************************************************************)
unit propos_f;
//-----------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ToolWin, ComCtrls, ShellApi, StdCtrls;
//-----------------------------------------------------------------------------
type
  TFormAPropos = class(TForm)
    Image: TImage;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    Shape: TShape;
    Timer: TTimer;
    PaintBox: TPaintBox;
    LabelSite: TLabel;
    LabelMel: TLabel;
    TimerAffichage: TTimer;
    LabelComptissibon1: TLabel;
    LabelComptissibon2: TLabel;
    LabelComptissibon3: TLabel;
    LabelComptissibon4: TLabel;
    procedure LabelComptissibon4Click(Sender: TObject);
    procedure LabelComptissibon3Click(Sender: TObject);
    procedure LabelComptissibon2Click(Sender: TObject); // v1.1
    procedure TimerAffichageTimer(Sender: TObject);
    procedure LabelMelClick(Sender: TObject);
    procedure LabelSiteClick(Sender: TObject);
    procedure PaintBoxClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    procedure DetermineVersion;
  public
    { Déclarations publiques }
  end;
//-----------------------------------------------------------------------------
var
  FormAPropos: TFormAPropos;
//-----------------------------------------------------------------------------
implementation
//-----------------------------------------------------------------------------
uses tableau_f;
//-----------------------------------------------------------------------------
{$R *.dfm}
//-----------------------------------------------------------------------------
procedure TFormAPropos.DetermineVersion;
var
  VerInfoSize, VerValueSize, ParametreInutilise: DWord;
  VerInfo: Pointer;
  VerValue: PVSFixedFileInfo;
begin
VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), ParametreInutilise);
if VerInfoSize <> 0 then
  begin
  {On alloue de la mémoire pour un pointeur sur les info de version : }
  GetMem(VerInfo, VerInfoSize);
  {On récupère ces informations : }
  GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  {On traite les informations ainsi récupérées : }
  with VerValue^ do
    begin
    ToolButton1.Tag:=(dwFileVersionMS shr 16) mod 10;
    ToolButton2.Tag:=(dwFileVersionMS and $FFFF) mod 10;
    ToolButton3.Tag:=(dwFileVersionLS shr 16) mod 10;
    end;
  FreeMem(VerInfo, VerInfoSize);
  Timer.Enabled:=True; // Défile les numéros pour arriver à la version
  end
else
  raise EAccessViolation.Create('Aucune information de version incluse.');
end;
//-----------------------------------------------------------------------------
procedure TFormAPropos.FormKeyPress(Sender: TObject; var Key: Char);
begin
Close;
end;
//-----------------------------------------------------------------------------
procedure TFormAPropos.FormClick(Sender: TObject);
begin
Close;
end;
//-----------------------------------------------------------------------------
procedure TFormAPropos.FormShow(Sender: TObject);
begin
DetermineVersion
end;
//-----------------------------------------------------------------------------
procedure TFormAPropos.TimerTimer(Sender: TObject);
var i : Integer;
begin
Randomize;
if AlphaBlend then
  begin
  AlphaBlendValue:=AlphaBlendValue+3;
  if AlphaBlendValue=255 then
    begin
    Timer.Interval:=100;
    AlphaBlend:=False;
    end;
  Exit;
  end;
for i:=1 to 3 do
  with FindComponent('ToolButton'+IntToStr(i)) as TToolButton do
    if ImageIndex<10+Tag then
      begin
      ImageIndex:=ImageIndex+1;
      Exit
      end;
Timer.Enabled:=False;
TimerAffichage.Enabled:=True; // v1.1
end;
//-----------------------------------------------------------------------------
procedure TFormAPropos.PaintBoxClick(Sender: TObject);
begin
ShellExecute(0, 'Open', 'licence.txt', Nil, pChar(ExtractFilePath(Application.ExeName)), SW_SHOWNORMAL);
ShellExecute(0, 'Open', 'license.txt', Nil, pChar(ExtractFilePath(Application.ExeName)), SW_SHOWNORMAL);
end;
//-----------------------------------------------------------------------------
procedure TFormAPropos.LabelSiteClick(Sender: TObject);
begin
ShellExecute(0, 'Open', PChar(LabelSite.Caption), nil, nil, SW_SHOWNORMAL);
end;
//-----------------------------------------------------------------------------
procedure TFormAPropos.LabelMelClick(Sender: TObject);
begin
ShellExecute(0, 'Open', PChar('mailto:'+LabelMel.Caption+'?subject=Le Compte Pour De Bon'), nil, nil, SW_SHOWNORMAL);
end;
//-----------------------------------------------------------------------------
procedure TFormAPropos.TimerAffichageTimer(Sender: TObject); // v1.1
begin
with TimerAffichage do
  begin
  Tag:=Tag xor 1;
  if Tag=1 then
    begin
    Enabled:=False;
    Self.Close;
    end
  end
end;
//-----------------------------------------------------------------------------
procedure TFormAPropos.LabelComptissibon2Click(Sender: TObject);
begin // v1.2.4
ShellExecute(0, 'Open', 'http://appstore.com/comptissibon', nil, nil, SW_SHOWNORMAL);
end;

procedure TFormAPropos.LabelComptissibon3Click(Sender: TObject);
begin
ShellExecute(0, 'Open', 'https://play.google.com/store/apps/details?id=com.patquoi.Comptissibon', nil, nil, SW_SHOWNORMAL);
end;

procedure TFormAPropos.LabelComptissibon4Click(Sender: TObject);
begin
ShellExecute(0, 'Open', 'http://www.amazon.fr/gp/mas/dl/android?p=com.patquoi.Comptissibon', nil, nil, SW_SHOWNORMAL);
end;

end.
