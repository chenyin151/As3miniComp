package com.ixd.chenyin.events
{
	import flash.events.Event;
	
	/**
	 * @author:chenyin
	 * @E-mail: [email=chenyin151@163.com]chenyin151@163.com[/email]
	 * 创建时间：2016-6-15 下午5:09:55
	 * 背景音效事件类
	 */
	public class SoundEvent extends Event
	{
		/**
		 * 音频加载完毕 
		 */		
		static public const SOUND_LOADED:String = "soundLoaded";
		public function SoundEvent($type:String, $bubbles:Boolean=false, $cancelable:Boolean=false)
		{
			super($type, $bubbles, $cancelable);
		}
	}
}