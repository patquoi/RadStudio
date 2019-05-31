unit main_f;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.Layouts, FMX.ListBox;

type
  TFormMain = class(TForm)
    StatusBar: TStatusBar;
    StatusLabel: TLabel;
    Edit: TEdit;
    ButtonTirage: TButton;
    ButtonFiltre: TButton;
    ButtonAnagrammes: TButton;
    ListBox: TListBox;
    procedure ButtonFiltreOuTirageClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.fmx}

uses StrUtils, anagrammes, dico, tirages;

procedure TFormMain.ButtonFiltreOuTirageClick(Sender: TObject);
var stFiltre0,
    stFiltreCrt,
    stMot             : String;
    i, iMot, iTirage,
    NbJokers,
    NbMotsTrv         : Integer;
    JokerSvt,
    EstTirage,
    MontreAnagrammes  : Boolean;
    AnagrammeCrt      : TAnagrammes;

procedure AjouteResultat;
var stTirageTrie : String;
begin
if EstTirage then
  begin // Tirage
  stTirageTrie:=TirageMot(stFiltreCrt);
  iTirage:=IndexTirage(stTirageTrie);
  if iTirage>-1 then
    begin
    AnagrammeCrt:=ResTir[iTirage];
    MontreAnagrammes:=(ButtonAnagrammes.IsPressed and (AnagrammeCrt.NbAnagrammes>1));
    repeat
      stMot:=Dictionnaire[AnagrammeCrt.iDico]+IfThen(MontreAnagrammes,'*','');
      if ListBox.Items.IndexOf(stMot)=-1 then
        begin
        ListBox.Items.Add(stMot);
        Inc(NbMotsTrv);
        end;
      if AnagrammeCrt.Svt<>nil then
        AnagrammeCrt:=AnagrammeCrt.Svt;
    until AnagrammeCrt.Svt=nil;
    end;
  end
else // Filtre
  begin
  iMot:=IndexDico(stFiltreCrt);
  if iMot>-1 then
    begin
    stMot:=Dictionnaire[iMot];
    if ListBox.Items.IndexOf(stMot)=-1 then
      begin
      ListBox.Items.Add(stMot);
      Inc(NbMotsTrv)
      end
    end
  end
end{AjouteResultat};

begin
EstTirage:=((Sender as TButton).Tag=1);
ListBox.Sorted:=not EstTirage; // On ne trie pas si tirage car on a pas les anagrammes ensemble :^(
ListBox.Items.Clear;
stFiltre0:=Edit.Text;
stFiltreCrt:=Edit.Text;
// On compte les jokers
NbJokers:=0; NbMotsTrv:=0;
for i := 1 to Length(stFiltre0) do
  if stFiltre0[i]='?' then
    Inc(NbJokers);
if NbJokers=0 then
  AjouteResultat
else
  begin
  JokerSvt:=False;
  while not JokerSvt do
    begin
    JokerSvt:=True; // On incrémente le dernier joker...
    for i:=Length(stFiltreCrt) downto 1 do
      if stFiltre0[i]='?' then
        if stFiltreCrt[i]='?' then
          begin
          stFiltreCrt[i]:='A';
          if JokerSvt then
            JokerSvt:=False;
          end
        else
          if JokerSvt then
            if stFiltreCrt[i]='Z' then
              begin
              JokerSvt:=True;
              stFiltreCrt[i]:='A'
              end
            else
              begin
              JokerSvt:=False;
              stFiltreCrt[i]:=Chr(Succ(Ord(stFiltreCrt[i])));
              end;
    // stFiltreCrt ne contient plus de jokers...
    AjouteResultat
    end;
  end;
  if EstTirage then
    case NbMotsTrv of
      0: StatusLabel.Text:=Format('Résultat : Aucun mot trouvé avec le tirage "%s".', [stFiltre0]);
      1: StatusLabel.Text:=Format('Résultat : Un seul mot trouvé avec le tirage "%s".', [stFiltre0]);
    else
      StatusLabel.Text:=Format('Résultat : %d mots trouvés avec le tirage "%s".', [NbMotsTrv, stFiltre0]);
    end
  else
    if NbJokers>0 then
      case NbMotsTrv of
        0: StatusLabel.Text:=Format('Résultat : Aucun mot trouvé avec le filtre "%s".', [stFiltre0]);
        1: StatusLabel.Text:=Format('Résultat : Un seul mot trouvé avec le filtre "%s".', [stFiltre0]);
      else
        StatusLabel.Text:=Format('Résultat : %d mots trouvés avec le filtre "%s".', [NbMotsTrv, stFiltre0]);
      end
    else
      if NbMotsTrv=0 then
        StatusLabel.Text:=Format('Résultat : Le mot "%s" n''est PAS VALIDE.', [stFiltre0])
      else
        StatusLabel.Text:=Format('Résultat : Le mot "%s" est VALIDE.', [stFiltre0]);
end;

end.
