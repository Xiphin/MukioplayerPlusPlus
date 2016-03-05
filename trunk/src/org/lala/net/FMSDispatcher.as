package org.lala.net
{
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	
	import org.lala.event.MukioEvent;
	import org.lala.event.EventBus;
	
	/**
	 * 有新弹幕
	 **/
	[Event(name="newCmtData", type="org.lala.event.MukioEvent")]
	public class FMSDispatcher extends EventDispatcher
	{
		protected var nc:NetConnection;
		protected var rnd:uint = 0;
		
		public function FMSDispatcher(url:String)
		{
			trace(url);
			nc = new NetConnection();
			nc.client = this;
			nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			nc.connect(url);
			//nc.connect("rtmfp://127.0.0.1:1935/RTD");
			
			rnd = Math.floor(Math.random() * 0x1000000);
		}
		
		public function sendData(data:Object):void
		{
			try
			{
				nc.call("dispatchData", null, data, rnd);
			} 
			catch(error:Error) 
			{
				trace(error.toString());
			}
		}
		
		public function onServerData(data:Object, r:uint):void
		{
			if(r !== rnd)
			{
				dispatchEvent(new MukioEvent("newCmtData", data));
			}
			trace(data);
			trace(r);
		}
		
		protected function netStatusHandler(event:NetStatusEvent):void
		{
			trace(event.info.code);			
		}
		
		public function close():void
		{
			
		}
	}
}