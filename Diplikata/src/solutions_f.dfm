object FormSolutions: TFormSolutions
  Left = 0
  Top = 0
  Caption = 'Plusieurs solutions possibles'
  ClientHeight = 406
  ClientWidth = 390
  Color = clBtnFace
  Constraints.MinWidth = 224
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabelPresentation: TLabel
    Left = 0
    Top = 0
    Width = 390
    Height = 13
    Align = alTop
    Alignment = taCenter
    Layout = tlCenter
    WordWrap = True
    ExplicitWidth = 3
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 387
    Width = 390
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object ListBox: TListBox
    Left = 0
    Top = 13
    Width = 390
    Height = 374
    Align = alClient
    ItemHeight = 13
    TabOrder = 1
    OnClick = ListBoxClick
    OnDblClick = ListBoxDblClick
  end
end
