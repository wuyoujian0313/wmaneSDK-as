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
			
		// API定义
		private static const LOGIN_FUNCTION_QQ:String = "login_function_qq";//qq登录授权
		private static const LOGIN_FUNCTION_WX:String = "login_function_wx";//微信登录授权
		private static const SHARING_FUNCTION_REGISTER:String = "registerShareSDKs";//注册多个分享平台（微信，QQ）
		private static const WXPAY_FUNCTION_REGISTER:String = "registerWXPaySDK";//注册微信支付sdk
		private static const ALIPAY_FUNCTION_REGISTER:String = "registerAlipaySDK";//注册支付宝sdk
		private static const WXPAY_FUNCTION:String = "wxpay";//微信支付
		private static const ALIPAY_FUNCTION:String = "alipay";//支付宝支付
		private static const ENCRYPT_FUNCTION:String = "encrypt_wm";//加密
		private static const DECRYPT_FUNCTION:String = "decrypt_wm";//解密
		private static const SHARING_FUNCTION_TEXT:String = "sharing_function_text";//分享文字
		private static const SHARING_FUNCTION_LINK:String = "sharing_function_link";//分享链接
		private static const SHARING_FUNCTION_IMAGE:String = "sharing_function_image";//分享图片
		private static const SHARING_FUNCTION_IMAGE_URL:String = "sharing_function_image_url";//分享图片链接
		private static const SHARING_FUNCTION_IS_INSTALLED:String = "sharing_function_is_installed";//判断分享app是否安装
		private static const PLAY_FUNCTION:String = "playAV";//播放网路的视频
		private static const PLAY_FUNCTION_LOCAL:String = "playAVForLocal";//播放本地视频
		
		public function wmaneSDK(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public static function get instance():wmaneSDK
		{
			if (!_instance)
			{
				_instance=new wmaneSDK();
					
				_extContext=ExtensionContext.createExtensionContext(APPSTRING, "");
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
		
		/*
		var jsonText:String = "{\"goodsDesc\":\"描述\",\"goodsName\":\"名称\",\"orderNo\":\"123321\",\"price\":\"12.0\",\"scheme\":\"alipay2018010401582123\"}";
		*/
		public function alipay(jsonText:String):void
		{
			_extContext.call(ALIPAY_FUNCTION,jsonText);
		}
		
		/*
		var jsonText:String = "{\"goodsDesc\":\"描述\",\"goodsName\":\"名称\",\"orderNo\":\"123321\",\"price\":\"12.0\",\"scheme\":\"wx2317aa2cd17ff337\"};
		*/
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