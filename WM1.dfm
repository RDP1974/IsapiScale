object WM: TWM
  Actions = <
    item
      Enabled = False
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WebModule1DefaultHandlerAction
    end
    item
      MethodType = mtGet
      Name = 'serial'
      PathInfo = '/serial'
      OnAction = WMmonoAction
    end
    item
      MethodType = mtGet
      Name = 'scale'
      PathInfo = '/scale'
      OnAction = WMscaleAction
    end>
  BeforeDispatch = WebModuleBeforeDispatch
  Height = 592
  Width = 1000
  PixelsPerInch = 216
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\MySQL845\libmysql.dll'
    Left = 160
    Top = 56
  end
end
