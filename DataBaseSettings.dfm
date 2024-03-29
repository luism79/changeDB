inherited frmDataBaseSettings: TfrmDataBaseSettings
  BorderStyle = bsToolWindow
  Caption = 'Banco de Dados'
  ClientHeight = 247
  ClientWidth = 334
  FormStyle = fsStayOnTop
  KeyPreview = True
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  ExplicitWidth = 340
  ExplicitHeight = 276
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 334
    Height = 202
    ExplicitWidth = 334
    ExplicitHeight = 202
    object grpDataBase: TGroupBox
      AlignWithMargins = True
      Left = 8
      Top = 4
      Width = 318
      Height = 63
      Margins.Left = 8
      Margins.Top = 4
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alTop
      Caption = ' Nome '
      TabOrder = 0
      DesignSize = (
        318
        63)
      object edtDataBase: TEdit
        Left = 13
        Top = 26
        Width = 289
        Height = 19
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        Text = 'edtDataBase'
      end
    end
    object grpDBCon: TGroupBox
      AlignWithMargins = True
      Left = 8
      Top = 75
      Width = 318
      Height = 119
      Margins.Left = 8
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alClient
      Caption = ' DBCon '
      TabOrder = 1
      object Panel1: TPanel
        AlignWithMargins = True
        Left = 206
        Top = 19
        Width = 101
        Height = 89
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 10
        Align = alRight
        AutoSize = True
        BevelOuter = bvNone
        TabOrder = 0
        object btnAdd: TBitBtn
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 95
          Height = 25
          Hint = 'Adicionar DBCon'
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Adicionar...'
          Glyph.Data = {
            36060000424D3606000000000000360000002800000020000000100000000100
            18000000000000060000C40E0000C40E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE1E1E1CCCCCCCCCC
            CCCCCCCCE1E1E1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFE1E1E1CCCCCCCCCCCCCCCCCCE1E1E1FF00FFFF00FFF5F5F5
            D9D9D9CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC56B28C009E5E009D
            5D009E5E53B18CE1E1E1FF00FFF5F5F5D9D9D9CCCCCCCCCCCCCCCCCCCCCCCCCC
            CCCCCCCCCCCCCCCC9C9C9C7979797979797979799C9C9CE1E1E1E0E0E0C6C5C3
            B9B4ABB0AA9EAFA99DAEA89CAEA89CB0A89DBDABA24EA37B00A56700BA8577DF
            C400BA8600A66A53B18CE0E0E0C5C5C5B2B2B2A7A7A7A6A6A6A5A5A5A5A5A5A6
            A6A6AAAAAA8E8E8E808080969696CBCBCB9696968282829C9C9CBDB9B2B4AEA2
            C5BEB3D4CAC2E1D7CFE8DED6EFE4DDEEE1DAF6DBD800995300BF8A00BB82FFFF
            FF00BB8200C08C009E5EB8B8B8ABABABBBBBBBC9C9C9D6D6D6DDDDDDE3E3E3E0
            E0E0DDDDDD7373739A9A9A959595FFFFFF9595959B9B9B797979B1AB9FC8C1B6
            CFC7BFD6CCC5DCD3CAE4D9D2EBE0D9EADDD6F3D8D500965073E4CAFFFFFFFFFF
            FFFFFFFF77E5CC009C5CA8A8A8BEBEBEC5C5C5CBCBCBD1D1D1D8D8D8DFDFDFDC
            DCDCDADADA707070D0D0D0FFFFFFFFFFFFFFFFFFD1D1D1787878B0AB9EC7C0B6
            CDC4BBD3CAC2DAD1C8E2D7CFECE1DAE7DBD3F0D6D200954E00CA9400C78FFFFF
            FF00C88F00CC98009D5DA8A8A8BEBEBEC2C2C2C9C9C9CFCFCFD6D6D6E0E0E0DA
            DADAD8D8D86F6F6FA4A4A4A0A0A0FFFFFFA1A1A1A6A6A6797979B0AA9ECAC3B9
            EAE5DDF7F3EBFFFBF4FDFAF3FDF9F2FFFAF3FFFEFA68C49D00AB6A00D39C75ED
            D300D39E00AE7268C6A1A7A7A7C1C1C1E3E3E3F1F1F1F9F9F9F8F8F8F7F7F7F8
            F8F8FDFDFDAEAEAE858585ABABABD8D8D8ACACAC898989B1B1B1C1BDB6F9F3ED
            D8D1C9C2B8B0BFB6AEC5BAB2C8BEB5C6BBB3C5B8B1D7BEBB47A278009B54009A
            56009C5B68C6A1FF00FFBBBBBBF2F2F2CFCFCFB7B7B7B5B5B5B9B9B9BCBCBCBA
            BABAB7B7B7C0C0C08B8B8B757575757575777777B1B1B1FF00FFBBB7AFA39A8F
            BAB2A7CAC1B8DED5CCE5DBD3ECE1DAE8DED5E1D6CED2C4BDCAB6B0BA9F9ACDBB
            B7FF00FFFF00FFFF00FFB5B5B5989898B0B0B0BFBFBFD3D3D3DADADAE0E0E0DC
            DCDCD5D5D5C3C3C3B6B6B6A0A0A0BCBCBCFF00FFFF00FFFF00FFB1AB9FC9C2B9
            CFC7BFD5CCC4DCD3CAE3D9D1EADFD8E5DCD3DED4CCD8CFC6D3CAC1CFC4BDBAAC
            A2FF00FFFF00FFFF00FFA8A8A8C0C0C0C5C5C5CBCBCBD1D1D1D8D8D8DEDEDEDA
            DADAD3D3D3CDCDCDC8C8C8C3C3C3ABABABFF00FFFF00FFFF00FFB0AB9EC7C0B6
            CCC4BBD3C9C1DAD0C7E1D7CFEBE1DAE4D9D1DCD1C9D5CCC2CEC6BDCAC1B9B2AB
            9FFF00FFFF00FFFF00FFA8A8A8BEBEBEC2C2C2C8C8C8CECECED6D6D6E0E0E0D8
            D8D8D0D0D0CACACAC4C4C4C0C0C0A8A8A8FF00FFFF00FFFF00FFAFAA9DC8C1B7
            E8E3DBF5F0E8FDF8F2FCF8F1FBF7F0FCF7F1FCF8F1F6F0EAE9E2DBCAC2BAB0A9
            9DFF00FFFF00FFFF00FFA7A7A7BFBFBFE1E1E1EEEEEEF7F7F7F6F6F6F5F5F5F6
            F6F6F6F6F6EFEFEFE1E1E1C0C0C0A6A6A6FF00FFFF00FFFF00FFAEA89CFBF5EF
            EEE7DEE0D8CEDDD5CCDDD4CBDDD4CBDDD4CBDDD5CCE0D7CEEDE6DEFBF6EFAEA8
            9CFF00FFFF00FFFF00FFA5A5A5F4F4F4E5E5E5D6D6D6D3D3D3D2D2D2D2D2D2D2
            D2D2D3D3D3D5D5D5E4E4E4F4F4F4A5A5A5FF00FFFF00FFFF00FFAFA99DE1D8CE
            E1D7CEDFD6CCDFD5CBDFD5CBDFD5CBDFD5CBDFD5CBDFD6CCE1D7CEE1D8CEAFA9
            9DFF00FFFF00FFFF00FFA6A6A6D6D6D6D5D5D5D4D4D4D3D3D3D3D3D3D3D3D3D3
            D3D3D3D3D3D4D4D4D5D5D5D6D6D6A6A6A6FF00FFFF00FFFF00FFD0CDC5B6B0A4
            D6CFC4E6DED5EFE7DDEEE6DCEEE6DCEEE6DCEFE7DDE6DED5D6CFC4B6B0A4D0CD
            C5FF00FFFF00FFFF00FFCBCBCBADADADCCCCCCDCDCDCE5E5E5E4E4E4E4E4E4E4
            E4E4E5E5E5DCDCDCCCCCCCADADADCBCBCBFF00FFFF00FFFF00FFFF00FFEFEEEC
            C5C0B7AEA99CAEA89CAEA89CAEA89CAEA89CAEA89CAEA99CC5C0B7EFEEECFF00
            FFFF00FFFF00FFFF00FFFF00FFEEEEEEBEBEBEA6A6A6A5A5A5A5A5A5A5A5A5A5
            A5A5A5A5A5A6A6A6BEBEBEEEEEEEFF00FFFF00FFFF00FFFF00FF}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = btnAddClick
        end
        object btnRemove: TBitBtn
          AlignWithMargins = True
          Left = 3
          Top = 59
          Width = 95
          Height = 25
          Hint = 'Remover DBCon'
          Align = alTop
          Caption = 'Remover'
          Glyph.Data = {
            36060000424D3606000000000000360000002800000020000000100000000100
            18000000000000060000C40E0000C40E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE1E1E1CCCCCCCCCC
            CCCCCCCCE1E1E1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFE1E1E1CCCCCCCCCCCCCCCCCCE1E1E1FF00FFFF00FFF5F5F5
            D9D9D9CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC7280CF374DCC384D
            CB384DCC7482CCE1E1E1FF00FFF5F5F5D9D9D9CCCCCCCCCCCCCCCCCCCCCCCCCC
            CCCCCCCCCCCCCCCC969696717171707070717171969696E1E1E1E0E0E0C6C5C3
            B9B4ABB0AA9EAFA99DAEA89CAEA89CB0AA9CB9B1996C76B8324ED9375CF9375D
            FA385DF93852D77381CCE0E0E0C5C5C5B2B2B2A7A7A7A6A6A6A5A5A5A5A5A5A6
            A6A6ABABAB898989757575878787888888888888777777969696BDB9B2B4AEA2
            C5BEB3D4CAC2E1D7CFE8DED6EFE4DDEDE2D8F0E3CE213CCE3E62FC3B60FA3A5D
            F83C60FA4165FB344BCCB8B8B8ABABABBBBBBBC9C9C9D6D6D6DDDDDDE3E3E3E0
            E0E0DEDEDE6565658C8C8C8A8A8A8888888A8A8A8E8E8E6F6F6FB1AB9FC8C1B6
            CFC7BFD6CCC5DCD3CAE4D9D2EBE0D9E8DED4EEE0CA1F39CBA6B8FFFFFFFFFFFF
            FFFFFFFFA9BAFF3148CAA8A8A8BEBEBEC5C5C5CBCBCBD1D1D1D8D8D8DFDFDFDC
            DCDCDBDBDB626262CBCBCBFFFFFFFFFFFFFFFFFFCDCDCD6C6C6CB0AB9EC7C0B6
            CDC4BBD3CAC2DAD1C8E2D7CFECE1DAE7DBD1EBDDC91C37CA5875FE5775FE5473
            FD5776FE5D79FF334ACBA8A8A8BEBEBEC2C2C2C9C9C9CFCFCFD6D6D6E0E0E0D9
            D9D9D9D9D96060609B9B9B9B9B9B9999999B9B9B9E9E9E6E6E6EB0AA9ECAC3B9
            EAE5DDF7F3EBFFFBF4FDFAF3FDF9F2FFFAF3FFFFF38993DD3954DE6C86FF728A
            FF6F89FF465EDD8795E1A7A7A7C1C1C1E3E3E3F1F1F1F9F9F9F8F8F8F7F7F7F8
            F8F8FBFBFBA8A8A87A7A7AA7A7A7AAAAAAAAAAAA818181AAAAAAC1BDB6F9F3ED
            D8D1C9C2B8B0BFB6AEC5BAB2C8BEB5C6BCB3C4BAAFD1C5B26771BA233ED02942
            CE2F47CD8795E1FF00FFBBBBBBF2F2F2CFCFCFB7B7B7B5B5B5B9B9B9BCBCBCBA
            BABAB8B8B8C1C1C18686866767676969696D6D6DAAAAAAFF00FFBBB7AFA39A8F
            BAB2A7CAC1B8DED5CCE5DBD3ECE1DAE8DED5E1D7CED1C6BBC6BBAAB4A790C8C1
            AEFF00FFFF00FFFF00FFB5B5B5989898B0B0B0BFBFBFD3D3D3DADADAE0E0E0DC
            DCDCD5D5D5C4C4C4B7B7B7A2A2A2BCBCBCFF00FFFF00FFFF00FFB1AB9FC9C2B9
            CFC7BFD5CCC4DCD3CAE3D9D1EADFD8E5DCD3DED4CCD8CFC5D3CBC1CEC6BAB7B0
            9DFF00FFFF00FFFF00FFA8A8A8C0C0C0C5C5C5CBCBCBD1D1D1D8D8D8DEDEDEDA
            DADAD3D3D3CDCDCDC9C9C9C3C3C3ABABABFF00FFFF00FFFF00FFB0AB9EC7C0B6
            CCC4BBD3C9C1DAD0C7E1D7CFEBE1DAE4D9D1DCD1C9D5CCC2CEC6BDCAC1B9B1AB
            9EFF00FFFF00FFFF00FFA8A8A8BEBEBEC2C2C2C8C8C8CECECED6D6D6E0E0E0D8
            D8D8D0D0D0CACACAC4C4C4C0C0C0A8A8A8FF00FFFF00FFFF00FFAFAA9DC8C1B7
            E8E3DBF5F0E8FDF8F2FCF8F1FBF7F0FCF7F1FCF8F1F6F0EAE9E2DBCAC2BAAFA9
            9DFF00FFFF00FFFF00FFA7A7A7BFBFBFE1E1E1EEEEEEF7F7F7F6F6F6F5F5F5F6
            F6F6F6F6F6EFEFEFE1E1E1C0C0C0A6A6A6FF00FFFF00FFFF00FFAEA89CFBF5EF
            EEE7DEE0D8CEDDD5CCDDD4CBDDD4CBDDD4CBDDD5CCE0D7CEEDE6DEFBF6EFAEA8
            9CFF00FFFF00FFFF00FFA5A5A5F4F4F4E5E5E5D6D6D6D3D3D3D2D2D2D2D2D2D2
            D2D2D3D3D3D5D5D5E4E4E4F4F4F4A5A5A5FF00FFFF00FFFF00FFAFA99DE1D8CE
            E1D7CEDFD6CCDFD5CBDFD5CBDFD5CBDFD5CBDFD5CBDFD6CCE1D7CEE1D8CEAFA9
            9DFF00FFFF00FFFF00FFA6A6A6D6D6D6D5D5D5D4D4D4D3D3D3D3D3D3D3D3D3D3
            D3D3D3D3D3D4D4D4D5D5D5D6D6D6A6A6A6FF00FFFF00FFFF00FFD0CDC5B6B0A4
            D6CFC4E6DED5EFE7DDEEE6DCEEE6DCEEE6DCEFE7DDE6DED5D6CFC4B6B0A4D0CD
            C5FF00FFFF00FFFF00FFCBCBCBADADADCCCCCCDCDCDCE5E5E5E4E4E4E4E4E4E4
            E4E4E5E5E5DCDCDCCCCCCCADADADCBCBCBFF00FFFF00FFFF00FFFF00FFEFEEEC
            C5C0B7AEA99CAEA89CAEA89CAEA89CAEA89CAEA89CAEA99CC5C0B7EFEEECFF00
            FFFF00FFFF00FFFF00FFFF00FFEEEEEEBEBEBEA6A6A6A5A5A5A5A5A5A5A5A5A5
            A5A5A5A5A5A6A6A6BEBEBEEEEEEEFF00FFFF00FFFF00FFFF00FF}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = btnRemoveClick
        end
        object btnEdit: TBitBtn
          AlignWithMargins = True
          Left = 3
          Top = 31
          Width = 95
          Height = 25
          Hint = 'Alterar DBCon'
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Alterar...'
          Glyph.Data = {
            36060000424D3606000000000000360000002800000020000000100000000100
            18000000000000060000C40E0000C40E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFCCCCCCCCCCCCCCCCCCFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCCCCCCCC
            CCCCCCCCCCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFF5F5F5
            D9D9D9CCCCCCCCCCCCCCCCCC50677A4966845090D9CCCCCCDADADAF5F5F5FF00
            FFFF00FFFF00FFFF00FFFF00FFF5F5F5D9D9D9CCCCCCCCCCCCCCCCCC6A6A6A6C
            6C6C9F9F9FCCCCCCDADADAF5F5F5FF00FFFF00FFFF00FFFF00FFE0E0E0C6C5C3
            B9B4ABB0AA9EB0AA9DB8AD9C54809F7FA6B68ED5FF2D659BC7B9A9C8C6C3E0E0
            E0FF00FFFF00FFFF00FFE0E0E0C5C5C5B2B2B2A7A7A7A7A7A7A9A9A9848484A7
            A7A7DADADA6F6F6FB6B6B6C5C5C5E0E0E0FF00FFFF00FFFF00FFBDB9B2B4AEA2
            C5BEB3D4CAC2E2D8CFF2E1D539ABF289E5FF7FD3FF1099FF2D659BC8B6A0C1BB
            B2FF00FFFF00FFFF00FFB8B8B8ABABABBBBBBBC9C9C9D6D6D6DFDFDFB4B4B4E3
            E3E3D7D7D7A9A9A96F6F6FB1B1B1B9B9B9FF00FFFF00FFFF00FFB1AB9FC8C1B6
            CFC7BFD6CCC5DDD3CAE9DBD1FCE6D71F70C43EC4FF2AAAFF159BFF2E659BC4B3
            9EFF00FFFF00FFFF00FFA8A8A8BEBEBEC5C5C5CBCBCBD1D1D1DADADAE4E4E480
            8080C7C7C7B5B5B5AAAAAA6F6F6FAFAFAFFF00FFFF00FFFF00FFB0AB9EC7C0B6
            CDC4BBD3CAC2DAD1C8E3D8CFF3E4DAF9E1D02372C343C6FF2BABFF139BFF2A67
            A1CCCCCCFF00FFFF00FFA8A8A8BEBEBEC2C2C2C9C9C9CFCFCFD7D7D7E3E3E3DF
            DFDF828282C9C9C9B6B6B6AAAAAA727272CCCCCCFF00FFFF00FFB0AA9ECAC3B9
            EAE5DDF7F3EBFFFBF4FDFAF3FEFAF2FFFDF2FFFFF22574C641C7FF21ABFF83B0
            D77E7871CCCCCCFF00FFA7A7A7C1C1C1E3E3E3F1F1F1F9F9F9F8F8F8F8F8F8FA
            FAFAFBFBFB848484C9C9C9B5B5B5B7B7B7777777CCCCCCFF00FFC1BDB6F9F3ED
            D8D1C9C2B8B0BFB6AEC5BAB2C8BEB5C7BCB3C7BAAFD7C2B12176CCAEDBF19288
            80C1BFB8777C6ECCCCCCBBBBBBF2F2F2CFCFCFB7B7B7B5B5B5B9B9B9BCBCBCBB
            BBBBB8B8B8BFBFBF868686DDDDDD878787BDBDBD777777CCCCCCBBB7AFA39A8F
            BAB2A7CAC1B8DED5CCE5DBD3ECE1DAE8DED5E1D7CED3C5BAC7B8A9857F7AEAE8
            E5888C82BA7AB69869CAB5B5B5989898B0B0B0BFBFBFD3D3D3DADADAE0E0E0DC
            DCDCD5D5D5C3C3C3B5B5B57E7E7EE7E7E78989899393938B8B8BB1AB9FC9C2B9
            CFC7BFD5CCC4DCD3CAE3D9D1EADFD8E5DCD3DED4CCD9CFC5D3CBC1CFC6BB7F81
            7CE1B1E1CB96C6AE7DCEA8A8A8C0C0C0C5C5C5CBCBCBD1D1D1D8D8D8DEDEDEDA
            DADAD3D3D3CDCDCDC9C9C9C4C4C47F7F7FC5C5C5AAAAAA9B9B9BB0AB9EC7C0B6
            CCC4BBD3C9C1DAD0C7E1D7CFEBE1DAE4D9D1DCD1C9D5CCC2CFC7BDCAC3B8B0AE
            9AC187D7BE8AD3FF00FFA8A8A8BEBEBEC2C2C2C8C8C8CECECED6D6D6E0E0E0D8
            D8D8D0D0D0CACACAC5C5C5C0C0C0A8A8A8A5A5A5A6A6A6FF00FFAFAA9DC8C1B7
            E8E3DBF5F0E8FDF8F2FCF8F1FBF7F0FCF7F1FCF8F1F6F0EAE9E2DBC9C3B9AEAC
            99FF00FFFF00FFFF00FFA7A7A7BFBFBFE1E1E1EEEEEEF7F7F7F6F6F6F5F5F5F6
            F6F6F6F6F6EFEFEFE1E1E1C1C1C1A7A7A7FF00FFFF00FFFF00FFAEA89CFBF5EF
            EEE7DEE0D8CEDDD5CCDDD4CBDDD4CBDDD4CBDDD5CCE0D7CEEDE6DEFBF6EFAEAA
            9AFF00FFFF00FFFF00FFA5A5A5F4F4F4E5E5E5D6D6D6D3D3D3D2D2D2D2D2D2D2
            D2D2D3D3D3D5D5D5E4E4E4F4F4F4A6A6A6FF00FFFF00FFFF00FFAFA99DE1D8CE
            E1D7CEDFD6CCDFD5CBDFD5CBDFD5CBDFD5CBDFD5CBDFD6CCE1D7CEE1D8CEAFAA
            9DFF00FFFF00FFFF00FFA6A6A6D6D6D6D5D5D5D4D4D4D3D3D3D3D3D3D3D3D3D3
            D3D3D3D3D3D4D4D4D5D5D5D6D6D6A7A7A7FF00FFFF00FFFF00FFD0CDC5B6B0A4
            D6CFC4E6DED5EFE7DDEEE6DCEEE6DCEEE6DCEFE7DDE6DED5D6CFC4B6B0A4D0CD
            C5FF00FFFF00FFFF00FFCBCBCBADADADCCCCCCDCDCDCE5E5E5E4E4E4E4E4E4E4
            E4E4E5E5E5DCDCDCCCCCCCADADADCBCBCBFF00FFFF00FFFF00FFFF00FFEFEEEC
            C5C0B7AEA99CAEA89CAEA89CAEA89CAEA89CAEA89CAEA99CC5C0B7EFEEECFF00
            FFFF00FFFF00FFFF00FFFF00FFEEEEEEBEBEBEA6A6A6A5A5A5A5A5A5A5A5A5A5
            A5A5A5A5A5A6A6A6BEBEBEEEEEEEFF00FFFF00FFFF00FFFF00FF}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = btnEditClick
        end
      end
      object lstDBCon: TListBox
        AlignWithMargins = True
        Left = 11
        Top = 19
        Width = 185
        Height = 89
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 10
        Align = alClient
        ItemHeight = 13
        Items.Strings = (
          'Item 1'
          'Item 2')
        TabOrder = 1
        OnClick = lstDBConClick
      end
    end
  end
  inherited pnlFooter: TPanel
    Top = 202
    Width = 334
    ExplicitTop = 202
    ExplicitWidth = 334
    object btnCancel: TBitBtn
      Left = 144
      Top = 10
      Width = 89
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancelar'
      ModalResult = 2
      NumGlyphs = 2
      TabOrder = 0
    end
    object btnConfirm: TBitBtn
      Left = 237
      Top = 10
      Width = 89
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Confirmar'
      Default = True
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnConfirmClick
    end
  end
end
