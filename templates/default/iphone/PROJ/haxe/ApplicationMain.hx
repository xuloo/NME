class ApplicationMain
{
	
	public static function main()
	{
		nme.Lib.setPackage("::APP_COMPANY::", "::APP_FILE::", "::APP_PACKAGE::", "::APP_VERSION::");
		::if (sslCaCert != "")::
		nme.net.URLLoader.initialize(nme.installer.Assets.getResourceName("::sslCaCert::"));
		::end::
		
		nme.display.Stage.shouldRotateInterface = function(orientation:Int):Bool
		{
			::if (WIN_ORIENTATION == "portrait")::
			if (orientation == nme.display.Stage.OrientationPortrait || orientation == nme.display.Stage.OrientationPortraitUpsideDown)
			{
				return true;
			}
			return false;
			::elseif (WIN_ORIENTATION == "landscape")::
			if (orientation == nme.display.Stage.OrientationLandscapeLeft || orientation == nme.display.Stage.OrientationLandscapeRight)
			{
				return true;
			}
			return false;
			::else::
			return true;
			::end::
		}
		
		nme.Lib.create(function()
			{
				if (::WIN_WIDTH:: == 0 && ::WIN_HEIGHT:: == 0)
				{
					nme.Lib.current.stage.align = nme.display.StageAlign.TOP_LEFT;
					nme.Lib.current.stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
				}
				
				// Need to wait for resize for the stage size to reflect properly
				
				nme.Lib.current.stage.addEventListener (nme.events.Event.RESIZE, initialize);
			},
			::WIN_WIDTH::, ::WIN_HEIGHT::,
			::WIN_FPS::,
			::WIN_BACKGROUND::,
			(::WIN_HARDWARE:: ? nme.Lib.HARDWARE : 0) |
			(::WIN_SHADERS:: ? nme.Lib.ALLOW_SHADERS : 0) |
			(::WIN_RESIZABLE:: ? nme.Lib.RESIZABLE : 0) |
			(::WIN_ANTIALIASING:: == 4 ? nme.Lib.HW_AA_HIRES : 0) |
			(::WIN_ANTIALIASING:: == 2 ? nme.Lib.HW_AA : 0),
			"::APP_TITLE::"
		);
		
	}
	
	
	private static function initialize (event:nme.events.Event):Void
	{
		nme.Lib.current.stage.removeEventListener (nme.events.Event.RESIZE, initialize);
		
		var hasMain = false;
				
		for (methodName in Type.getClassFields(::APP_MAIN::))
		{
			if (methodName == "main")
			{
				hasMain = true;
				break;
			}
		}
		
		if (hasMain)
		{
			Reflect.callMethod (::APP_MAIN::, Reflect.field (::APP_MAIN::, "main"), []);
		}
		else
		{
			nme.Lib.current.addChild(cast (Type.createInstance(::APP_MAIN::, []), nme.display.DisplayObject));	
		}
	}
	
	
	public static function getAsset(inName:String):Dynamic
	{
		::foreach assets::
		if (inName == "::id::")
		{
			::if (type == "image")::
			return nme.Assets.getBitmapData ("::id::");
			::elseif (type == "sound")::
			return nme.Assets.getSound ("::id::");
			::elseif (type == "music")::
			return nme.Assets.getSound ("::id::");
			::elseif (type == "font")::
			return nme.Assets.getFont ("::id::");
			::elseif (type == "text")::
			return nme.Assets.getText ("::id::");
			::else::
			return nme.Assets.getBytes ("::id::");
			::end::
		}
		::end::
		return null;
	}
	
}