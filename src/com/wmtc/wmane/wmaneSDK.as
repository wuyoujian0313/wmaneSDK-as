package com.wmtc.wmane
{
	import flash.desktop.NativeApplication;
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.InvokeEvent;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	public class wmaneSDK extends EventDispatcher
	{
		private static var _instance:wmaneSDK;
		private static var _extContext:ExtensionContext;
		private static var APPSTRING:String = 'com.wmtc.wmane';
		
		private static const LOGIN_FUNCTION_QQ:String = "login_function_qq";
		private static const LOGIN_FUNCTION_WX:String = "login_function_wx";
		private static const SHARING_FUNCTION_REGISTER:String = "registerShareSDKs";
		private static const WXPAY_FUNCTION_REGISTER:String = "registerWXPaySDK";
		private static const ALIPAY_FUNCTION_REGISTER:String = "registerAlipaySDK";
		private static const WXPAY_FUNCTION:String = "wxpay";
		private static const ALIPAY_FUNCTION:String = "alipay";
		private static const ENCRYPT_FUNCTION:String = "encrypt_wm";
		private static const DECRYPT_FUNCTION:String = "decrypt_wm";
		private static const SHARING_FUNCTION_TEXT:String = "sharing_function_text";
		private static const SHARING_FUNCTION_LINK:String = "sharing_function_link";
		private static const SHARING_FUNCTION_IMAGE:String = "sharing_function_image";
		private static const SHARING_FUNCTION_IMAGE_URL:String = "sharing_function_image_url";
		private static const SHARING_FUNCTION_IS_INSTALLED:String = "sharing_function_is_installed";
		private static const PLAY_FUNCTION:String = "playAV";
		private static const PLAY_FUNCTION_LOCAL:String = "playAVForLocal";
		
		public function wmaneSDK(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public static function get instance():wmaneSDK
		{
			if (!_instance)
			{
				_instance=new wmaneSDK();
					
				_extContext=ExtensionContext.createExtensionContext(APPSTRING, null);
				if (!_extContext)
				{
					trace("ERROR - Extension context is null. Please check if extension.xml is setup correctly.");
				}
				else
				{
					_extContext.addEventListener(StatusEvent.STATUS, _instance.statusHandler);
					NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE,_instance.systemInvoke);
				}
			}
			return _instance;
		}
		
		protected function systemInvoke(event:InvokeEvent):void
		{
			if(event.arguments.length>0){
				var url:String = event.arguments[0] as String;
			}
		}
		
		protected function statusHandler(event:StatusEvent):void
		{
			dispatchEvent(event);
		}
		
		public function login_wx():void
		{
			_extContext.call(LOGIN_FUNCTION_WX);
		}

		public function login_qq():void
		{
			_extContext.call(LOGIN_FUNCTION_QQ);
		}
		
		public function registerWXPaySDK(appId:String,appSecret:String,partner:String):void
		{
			_extContext.call(WXPAY_FUNCTION_REGISTER,appId,appSecret,partner);
		}
		
		public function registerAliPaySDK(appId:String,appSecret:String):void
		{
			_extContext.call(ALIPAY_FUNCTION_REGISTER,appId,appSecret);
		}
		
		public function alipay(orderString:String):void
		{
			_extContext.call(ALIPAY_FUNCTION,orderString);
		}
		
		public function wxpay(jsonText:String):void
		{
			_extContext.call(WXPAY_FUNCTION,jsonText);
		}
		
		public function encrypt_wm(text:String):void
		{
			_extContext.call(ENCRYPT_FUNCTION,text);
		}
		
		public function decrypt_wm(text:String):void
		{
			_extContext.call(DECRYPT_FUNCTION,text);
		}
		
		/*
		// platform = 0，微信 ； = 1 QQ
		// 北汽高级维修
		var jsonText:String = "[{\"appId\":\"wx828ddb181a65570c\",\"appSecret\":\"d2f36fee5809ea6d1909ff56e29f1e83\",\"platform\":0},{\"appId\":\"1106131684\",\"appSecret\":\"7kuxHSwsLybdLQ5O\",\"platform\":1}]";
		
		// 北汽维护
		var jsonText:String = "[{\"appId\":\"wx78bf5210b6ebf466\",\"appSecret\":\"d2f36fee5809ea6d1909ff56e29f1e83\",\"platform\":0},{\"appId\":\"1106347438\",\"appSecret\":\"NT66deIQ4RNl5gDA\",\"platform\":1}]";
		
		// 北汽电机知识
		var jsonText:String = "[{\"appId\":\"wxf74876d011fb1356\",\"appSecret\":\"fedba484c5f88fc3398eee6bda007dce\",\"platform\":0},{\"appId\":\"1106060269\",\"appSecret\":\"OR7B2A2kRZC6riPH\",\"platform\":1}]";
		
		// 百树习字
		var jsonText:String = "[{\"appId\":\"wx2317aa2cd17ff337\",\"appSecret\":\"31c0e1af0baae6fb14717a7428b6e343\",\"platform\":0},{\"appId\":\"1106827023\",\"appSecret\":\"Xa546RrBUxSol9VN\",\"platform\":1}]";		
		*/
		
		public function registerShareSDKs(jsonText:String):void
		{
			_extContext.call(SHARING_FUNCTION_REGISTER,jsonText);
		}
		
		public function sendTextContent(text:String):void
		{
			_extContext.call(SHARING_FUNCTION_TEXT,text);
		}
	
		public function sendLinkContent(title:String, text:String, url:String):void
		{
			_extContext.call(SHARING_FUNCTION_LINK,title, text, url);
		}
	
		public function sendImageContent(image:BitmapData):void
		{
			_extContext.call(SHARING_FUNCTION_IMAGE, image);
		}
	
		public function sendImageContentByUrl(imageUrl:String):void{
			_extContext.call(SHARING_FUNCTION_IMAGE_URL, imageUrl);
		}
		
		public function isInstalled():Boolean
		{
			return _extContext.call(SHARING_FUNCTION_IS_INSTALLED);
		}

		public function playAV(text:String):void
		{
			_extContext.call(PLAY_FUNCTION,text);
		}
		
		public function playAVForLocal(text:String):void
		{
			_extContext.call(PLAY_FUNCTION_LOCAL,text);
		}
	}
}