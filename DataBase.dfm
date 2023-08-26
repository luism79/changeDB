inherited frmDataBase: TfrmDataBase
  BorderStyle = bsToolWindow
  Caption = 'Banco de dados...'
  ClientHeight = 162
  ClientWidth = 326
  KeyPreview = True
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  ExplicitWidth = 332
  ExplicitHeight = 191
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 326
    Height = 117
    ExplicitWidth = 326
    ExplicitHeight = 117
    object lblName: TLabel
      Left = 77
      Top = 37
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object Label1: TLabel
      Left = 21
      Top = 66
      Width = 83
      Height = 13
      Caption = 'Nome Secund'#225'rio'
    end
    object edtName: TEdit
      Left = 110
      Top = 35
      Width = 194
      Height = 19
      TabOrder = 0
      Text = 'edtName'
      OnChange = edtNameChange
      OnEnter = edtNameEnter
    end
    object edtSecName: TEdit
      Left = 110
      Top = 64
      Width = 194
      Height = 19
      TabOrder = 1
      Text = 'edtName'
    end
  end
  inherited pnlFooter: TPanel
    Top = 117
    Width = 326
    ExplicitTop = 117
    ExplicitWidth = 326
    object btnCancel: TBitBtn
      Left = 135
      Top = 10
      Width = 89
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancelar'
      ModalResult = 2
      TabOrder = 0
    end
    object btnConfirm: TBitBtn
      Left = 228
      Top = 10
      Width = 89
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Confirmar'
      Default = True
      TabOrder = 1
      OnClick = btnConfirmClick
    end
  end
end
