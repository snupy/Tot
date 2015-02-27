object MainForm: TMainForm
  Left = 192
  Top = 124
  AutoSize = True
  BorderStyle = bsDialog
  Caption = #1052#1072#1089#1090#1077#1088' '#1089#1082#1072#1085#1080#1088#1086#1074#1072#1085#1080#1103
  ClientHeight = 97
  ClientWidth = 459
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RzLabel1: TRzLabel
    Left = 0
    Top = 4
    Width = 91
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
  end
  object RzLabel2: TRzLabel
    Left = 248
    Top = 4
    Width = 86
    Height = 13
    Caption = #1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072':'
  end
  object RzLabel3: TRzLabel
    Left = 0
    Top = 28
    Width = 76
    Height = 13
    Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
  end
  object edDocNumber: TRzEdit
    Left = 94
    Top = 0
    Width = 137
    Height = 21
    TabOrder = 0
    OnChange = edDocNumberChange
  end
  object edDocDate: TRzDateTimeEdit
    Left = 338
    Top = 0
    Width = 121
    Height = 21
    EditType = etDate
    FrameStyle = fsNone
    TabOrder = 1
  end
  object cbDocType: TRzComboBox
    Left = 94
    Top = 24
    Width = 195
    Height = 21
    Style = csDropDownList
    Color = clInfoBk
    ItemHeight = 13
    TabOrder = 2
  end
  object RzCheckBox1: TRzCheckBox
    Left = 130
    Top = 52
    Width = 161
    Height = 17
    Action = acScannigPreview
    State = cbUnchecked
    TabOrder = 3
  end
  object RzBitBtn1: TRzBitBtn
    Left = 336
    Top = 72
    Width = 123
    Action = acScanImage
    Caption = #1057#1082#1072#1085#1080#1088#1086#1074#1072#1090#1100
    TabOrder = 4
  end
  object RzBitBtn2: TRzBitBtn
    Left = 0
    Top = 48
    Width = 113
    Action = acChangeScan
    Caption = #1042#1099#1073#1088#1072#1090#1100' '#1089#1082#1072#1085#1085#1077#1088
    TabOrder = 5
  end
  object RzBitBtn3: TRzBitBtn
    Left = 0
    Top = 72
    Width = 113
    Action = acPrinterSetup
    Caption = #1053#1072#1089#1090#1088#1086#1080#1090#1100' '#1087#1088#1080#1085#1090#1077#1088
    TabOrder = 6
  end
  object RzCheckBox2: TRzCheckBox
    Left = 130
    Top = 76
    Width = 161
    Height = 17
    Action = acAutoPrintScan
    State = cbUnchecked
    TabOrder = 7
  end
  object RzCheckBox3: TRzCheckBox
    Left = 298
    Top = 36
    Width = 161
    Height = 29
    Action = acDobleNumbersTest
    State = cbChecked
    TabOrder = 8
  end
  object ActionManager1: TActionManager
    Left = 8
    Top = 40
    StyleName = 'XP Style'
    object acScanImage: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = #1057#1082#1072#1085#1080#1088#1086#1074#1072#1090#1100
      Enabled = False
      Hint = #1057#1082#1072#1085#1080#1088#1086#1074#1072#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
      ShortCut = 116
      OnExecute = acScanImageExecute
    end
    object acScannigPreview: TAction
      Category = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1089#1082#1072#1085#1080#1088#1086#1074#1072#1085#1080#1103
      AutoCheck = True
      Caption = #1054#1090#1086#1073#1088#1072#1079#1080#1090#1100' '#1089#1082#1072#1085#1080#1088#1086#1074#1072#1085#1085#1086#1077
      OnExecute = acScannigPreviewExecute
    end
    object acChangeScan: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1089#1082#1072#1085#1085#1077#1088
      OnExecute = acChangeScanExecute
    end
    object acPrinterSetup: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = #1053#1072#1089#1090#1088#1086#1080#1090#1100' '#1087#1088#1080#1085#1090#1077#1088
      OnExecute = acPrinterSetupExecute
    end
    object acAutoPrintScan: TAction
      Category = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1089#1082#1072#1085#1080#1088#1086#1074#1072#1085#1080#1103
      AutoCheck = True
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1085#1072' '#1087#1077#1095#1072#1090#1100'...'
      OnExecute = acAutoPrintScanExecute
    end
    object acDobleNumbersTest: TAction
      Category = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1089#1082#1072#1085#1080#1088#1086#1074#1072#1085#1080#1103
      AutoCheck = True
      Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1100' '#1087#1088#1086#1074#1077#1088#1082#1091' '#1085#1072' '#1089#1086#1074#1087#1072#1076#1077#1085#1080#1077' '#1085#1086#1084#1077#1088#1086#1074
      Checked = True
      Hint = 
        #1042' '#1089#1083#1091#1095#1072#1077' '#1091#1089#1090#1072#1085#1086#1074#1082#1080' '#1092#1083#1072#1078#1082#1072' '#1089#1080#1089#1090#1077#1084#1072' '#1087#1088#1086#1080#1079#1074#1086#1076#1080#1090' '#1087#1088#1086#1074#1077#1088#1082#1091' '#1085#1072' '#1090#1086', '#1095#1090#1086 +
        ' '#1103#1074#1083#1103#1077#1090#1089#1103' '#1083#1080' '#1076#1072#1085#1085#1086#1077#13#1089#1082#1072#1085#1080#1088#1086#1074#1072#1085#1085#1086#1077' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1087#1086#1089#1083#1077#1076#1091#1102#1097#1080#1084#1080#13#1083#1080#1089#1090#1072 +
        #1084#1080' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1080#1083#1080' '#1078#1077' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100#13#1086#1096#1080#1073#1089#1103'. '#1042' '#1089#1083#1091#1095#1072#1077' '#1074#1099#1103#1074#1083#1077#1085#1080#1103' '#1089#1086#1074#1087 +
        #1072#1076#1077#1085#1080#1081#13#1089#1080#1089#1090#1077#1084#1072' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086' '#1089#1087#1088#1086#1089#1080#1090' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103'.'
      OnExecute = acDobleNumbersTestExecute
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 40
    Top = 40
  end
end
