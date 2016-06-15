package com.ixd.chenyin.soundutils
{
	import flash.media.SoundChannel;

	/**
	 * @author:chenyin
	 * @E-mail: [email=chenyin151@163.com]chenyin151@163.com[/email]
	 * 创建时间：2016-6-7 下午5:46:36
	 * 
	 */
	public class SCData
	{
		public var type:int;
		public var sc:SoundChannel
		
		public function SCData($type:int,$sc:SoundChannel)
		{
			type = $type;
			sc = $sc;
		}
	}
}