package org.lala.utils
{
	
	public class YKParser extends Object
	{
		private var fileId:String;
		private var data:Object;
		private var type:String;
		private var key:String;
		
		public function YKParser(param1:Object, param2:String)
		{
			this.data = param1;
			this.type = param2;
			this.key = this.getKey(param1.key1, param1.key2);
			this.fileId = this.getFileId(param1["streamfileids"][this.type], param1["seed"]);
			return;
		}
		
		public function get KEY() : String
		{
			return this.key;
		}
		
		private function getKey(param1:String, param2:String) : String
		{
			var _loc_3:* = parseInt(param1, 16);
			_loc_3 = _loc_3 ^ 2774181285;
			return param2 + _loc_3.toString(16);
		}
		
		private function getFileId(param1:String, param2:String) : String
		{
			var _loc_8:int = 0;
			var _loc_3:* = this.getMixString(param2);
			var _loc_4:* = param1.split("*");
			var _loc_5:String = "";
			var _loc_6:* = _loc_4.length - 1;
			var _loc_7:int = 0;
			while (_loc_7 < _loc_6)
			{
				
				_loc_8 = parseInt(_loc_4[_loc_7]);
				_loc_5 = _loc_5 + _loc_3.charAt(_loc_8);
				_loc_7++;
			}
			return _loc_5;
		}
		
		public function get FILEID() : String
		{
			return this.fileId;
		}
		
		public function get TYPE() : String
		{
			return this.type;
		}
		
		private function getMixString(param1:String) : String
		{
			var _loc_7:int = 0;
			var _loc_8:String = null;
			var _loc_2:* = parseInt(param1);
			var _loc_3:String = "";
			var _loc_4:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ/\\:._-1234567890";
			var _loc_5:* = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ/\\:._-1234567890".length;
			var _loc_6:int = 0;
			while (_loc_6 < _loc_5)
			{
				
				_loc_2 = (_loc_2 * 211 + 30031) % 65536;
				_loc_7 = Math.floor(_loc_2 / 65536 * _loc_4.length);
				_loc_8 = _loc_4.charAt(_loc_7);
				_loc_3 = _loc_3 + _loc_8;
				_loc_4 = _loc_4.replace(_loc_8, "");
				_loc_6++;
			}
			return _loc_3;
		}
		
		public function getUrl(param1:int) : String
		{
			var _loc_2:* = param1.toString(16);
			if (_loc_2.length == 1)
			{
				_loc_2 = "0" + _loc_2;
				_loc_2 = _loc_2.toUpperCase();
			}
			return "http://f.youku.com/player/getFlvPath/sid/00_00/st/" + this.type + "/fileid/" + this.fileId.substr(0, 8) + _loc_2 + this.fileId.substr(10) + "?K=" + this.data.segs[this.type][param1].k;
		}
		
	}
}