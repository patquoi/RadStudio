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
unit pavenum_f;
//-----------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------
uses
  IA,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ToolWin, ComCtrls, Buttons;
//-----------------------------------------------------------------------------
type
  TSaisiePaveNumerique  = (spnRien, spnPlaque1, spnPlaque2, spnPlaque3, spnPlaque4, spnPlaque5, spnPlaque6, spnCompteChiffre1, spnCompteChiffre2, spnCompteChiffre3);
  TElementPlaque        = (epIndefini, ep1, ep2, ep3, ep4, ep5, ep6, ep7, ep8, ep9, ep10, ep25, ep50, ep75, ep100);
  TTypeNombreSaisi      = (tnsPlaque, tnsCompte);
  TNbElementsPlaque     = array [TElementPlaque] of Integer;
  TStrElementPlaque     = array [TElementPlaque] of String;
  TElementsValeurPlaque = array [TValeurPlaque] of TElementPlaque;
  TFormPaveNumerique = class(TForm)
    SpeedButton0: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton25: TSpeedButton;
    SpeedButton50: TSpeedButton;
    SpeedButton75: TSpeedButton;
    SpeedButton100: TSpeedButton;
    SpeedButton999: TSpeedButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ControleExemplairesPlaque(const SpeedButton : TSpeedButton; const ElementPlaque : TElementPlaque);    procedure SpeedButtonClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    NbExemplairesPlaque : TNbElementsPlaque;
    DerniereSaisie : TSaisiePaveNumerique;
    procedure Prepare(const TypeNombreSaisi : TTypeNombreSaisi);
  public
  end;
//-----------------------------------------------------------------------------
var
  FormPaveNumerique: TFormPaveNumerique;
//-----------------------------------------------------------------------------
const
  NbMaxExemplairesPlaque : TNbElementsPlaque     = (0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1);
  stValeurElementPlaque  : TStrElementPlaque     = ('', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '25', '50', '75', '100');
  ElementValeurPlaque    : TElementsValeurPlaque = ( epIndefini, ep1, ep2, ep3, ep4, ep5, ep6, ep7, ep8, ep9,
                                                     ep10, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini,
                                                     epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, ep25, epIndefini, epIndefini, epIndefini, epIndefini,
                                                     epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini,
                                                     epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini,
                                                     ep50, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini,
                                                     epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini,
                                                     epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, ep75, epIndefini, epIndefini, epIndefini, epIndefini,
                                                     epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini,
                                                     epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini, epIndefini,
                                                     ep100);
//-----------------------------------------------------------------------------
implementation
//-----------------------------------------------------------------------------
uses main_f, tableau_f,
     StdCtrls;
//-----------------------------------------------------------------------------
{$R *.dfm}
//-----------------------------------------------------------------------------
procedure TFormPaveNumerique.FormHide(Sender: TObject);
begin
FormMain.MenuItemPaveNumerique.Checked:=False;
end;
//-----------------------------------------------------------------------------
procedure TFormPaveNumerique.Prepare(const TypeNombreSaisi : TTypeNombreSaisi);
var i : TElementPlaque;
begin
for i:=ep1 to ep100 do // On grise ou non les boutons plaques suivant les limitations d'exemplaires
 if not FormMain.MenuItemNombreLimiteExemplairesPlaques.Checked or
    (TypeNombreSaisi=tnsCompte) then
  (FindComponent(stSpeedButton+stValeurElementPlaque[i]) as TSpeedButton).Enabled:=True
 else
  (FindComponent(stSpeedButton+stValeurElementPlaque[i]) as TSpeedButton).Enabled:=(NbExemplairesPlaque[i]<NbMaxExemplairesPlaque[i]);
SpeedButton0.Visible:=(TypeNombreSaisi=tnsCompte);
SpeedButton10.Visible:=(TypeNombreSaisi=tnsPlaque);
SpeedButton25.Visible:=(TypeNombreSaisi=tnsPlaque);
SpeedButton50.Visible:=(TypeNombreSaisi=tnsPlaque);
SpeedButton75.Visible:=(TypeNombreSaisi=tnsPlaque);
SpeedButton100.Visible:=(TypeNombreSaisi=tnsPlaque);
end;
//-----------------------------------------------------------------------------
procedure TFormPaveNumerique.FormShow(Sender: TObject);
var i : TElementPlaque;
begin
// Suite des événements
FormMain.MenuItemPaveNumerique.Checked:=True;
// Fermeture du tableau
if FormTableau.Visible then FormTableau.Hide;
// Nettoyage des solutions trouvées (listes & arbres)
FormMain.NettoieAffichage;
with FormMain do
  begin
  Self.Left:=Left;
  Self.Top:= Top+Height-ClientHeight+ // Inclut bordure et menu
             ToolBar.Height+
             PanelNombres.Height;
  end;
DerniereSaisie:=spnRien;
// On initialise les compteurs de plaques utilisées
for i:=Low(TElementPlaque) to High(TElementPlaque) do
  NbExemplairesPlaque[i]:=0;
// On prépare l'affichage du pavé
Prepare(tnsPlaque);
end;
//-----------------------------------------------------------------------------
procedure TFormPaveNumerique.ControleExemplairesPlaque(const SpeedButton : TSpeedButton; const ElementPlaque : TElementPlaque);
begin
if not FormMain.MenuItemNombreLimiteExemplairesPlaques.Checked then Exit; // Paramètre non activé
Inc(NbExemplairesPlaque[ElementPlaque]);
if NbExemplairesPlaque[ElementPlaque]=NbMaxExemplairesPlaque[ElementPlaque] then
  SpeedButton.Enabled:=False;
end;
//-----------------------------------------------------------------------------
procedure TFormPaveNumerique.SpeedButtonClick(Sender: TObject);
var NumeroBouton   : Integer;
    stValeurPlaque : String;
begin
if DerniereSaisie=spnRien then FormMain.EffacePlaquesEtCompte;
NumeroBouton:=StrToInt(copy((Sender as TSpeedButton).Name,12, Length((Sender as TSpeedButton).Name)-11));
case NumeroBouton of
  0:   if DerniereSaisie<spnPlaque6 then
         Exit // Zéro non utilisable pour les plaques
       else
         if (FormMain.Label7.Caption='') or
            (FormMain.Label7.Caption='10') then
           Exit // Compte > 101 : DONC zéro interdit comme centaine et comme unité si 10 déjà entré !
         else
           FormMain.Label7.Caption:=FormMain.Label7.Caption+IntToStr(NumeroBouton);
  1..9:if DerniereSaisie<spnPlaque6 then
         begin
         (FormMain.FindComponent(stLabel+IntToStr(Ord(DerniereSaisie)+1)) as TLabel).Caption:=IntToStr(NumeroBouton);
         ControleExemplairesPlaque( Sender as TSpeedButton,
                                    ElementValeurPlaque[NumeroBouton]);
         end
       else
         FormMain.Label7.Caption:=FormMain.Label7.Caption+IntToStr(NumeroBouton);
  10..
  100: if DerniereSaisie<spnPlaque6 then
         begin
         (FormMain.FindComponent(stLabel+IntToStr(Ord(DerniereSaisie)+1)) as TLabel).Caption:=IntToStr(NumeroBouton);
         ControleExemplairesPlaque( Sender as TSpeedButton,
                                    ElementValeurPlaque[NumeroBouton]);
         end;
  999: if DerniereSaisie>spnRien then
         begin
         case DerniereSaisie of
           spnPlaque1..
           spnPlaque6:         begin
                               stValeurPlaque:=(FormMain.FindComponent( stLabel+IntToStr(Ord(DerniereSaisie))) as TLabel).Caption;
                               Dec(NbExemplairesPlaque[ElementValeurPlaque[StrToInt(stValeurPlaque)]]); // On décrémente le compteur d'éléments de plaque
                               (FindComponent(stSpeedButton+stValeurPlaque) as TSpeedButton).Enabled:=True; // Si le bouton de la dernière plaque a été grisé : ça le réactive
                               (FormMain.FindComponent(stLabel+IntToStr(Ord(DerniereSaisie))) as TLabel).Caption:=''; // On efface la dernière plaque
                               end;
           spnCompteChiffre1..
           spnCompteChiffre3:  FormMain.Label7.Caption:=copy(FormMain.Label7.Caption,1,Ord(DerniereSaisie)-Ord(spnCompteChiffre1));
         end{case of};
         Dec(DerniereSaisie);
         if DerniereSaisie=spnPlaque5 then Prepare(tnsPlaque);
         Exit;
         end
       else
         Exit;
end{case of};
if DerniereSaisie<spnCompteChiffre2 then
  begin
  if DerniereSaisie=spnPlaque5 then Prepare(tnsCompte);
  Inc(DerniereSaisie);
  end
else
  begin
  IA.Compte:=StrToInt(FormMain.Label7.Caption);
  if FormTableau.Visible then FormTableau.Repaint;
  ModalResult:=mrOk;
  end;
end;
//-----------------------------------------------------------------------------
procedure TFormPaveNumerique.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Key=#27 then ModalResult:=mrCancel;
end;
//-----------------------------------------------------------------------------
end.
