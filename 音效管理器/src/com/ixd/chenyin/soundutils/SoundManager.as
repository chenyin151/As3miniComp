package com.ixd.chenyin.soundutils
{
	import com.ixd.chenyin.events.SoundEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import events.GameEvent;
	
	import gs.plugins.VolumePlugin;
	
	
	/**
	 * 音效播放
	 * @author chenyin
	 */
	public class SoundManager extends EventDispatcher
	{
		static private var _instance:SoundManager;
		private var _paths:Vector.<Object>;
		private var _loader:URLLoader;
		private var _isLoaded:Boolean;
		private var _soundChannel:SoundChannel;
		private var _sound:Sound;
		private var _sounds:Dictionary;
		private var _count:int;
		private var _oSoundName:String;
		private var _name:String;
		private var _playType:int;
		private var _loop:int;
		static public var canPlay:Boolean = true;
		private var _soundChannels:Object;
		
		public function SoundManager($interClass:InterClass) 
		{
			if (!$interClass) throw new Error("请从getInstance初始化");
			_sounds = new Dictionary();
			_soundChannels = new Object();
		}
		
		static public function getInstance():SoundManager
		{
			if (_instance == null)_instance = new SoundManager(new InterClass);
			return _instance;
		}
		
		/**
		 * 设置播放音乐的列表
		 */
		public function set path($paths:Vector.<Object>):void
		{
			_paths = $paths;
		}
		
		public function startLoad():void
		{
			for (var i:int = 0; i < _paths.length; i++ )
			{
				trace("vvv", _paths[i] )
				_sound = new Sound();
				_sound.addEventListener(Event.COMPLETE, loaded);
				_sound.load(new URLRequest(_paths[i].music));
				_sounds[_paths[i].name] = _sound;
			}
		}
		
		private function loaded(e:Event):void 
		{
			_count++;
			if (_count == _paths.length)
			{
				trace("音频加载完毕！");
				_isLoaded = true;
				dispatchEvent(new SoundEvent(SoundEvent.SOUND_LOADED));
			}
		}
		
		/**
		 *
		 * 开始播放指定的音乐
		 * @param	$name		音乐的名称
		 * @param 	$loop		音乐循环次数
		 * @param 	$playType	音乐的播放模式，0代表覆盖播放，1代表叠加播放
		 * 
		 */		
		public function play($name:String,$playType:int = 0,$loop = 1000):void
		{
			trace("play");
			_playType = $playType;
			_loop = $loop;
			_name = $name;
			trace("OS",_oSoundName,$name)
			if(_oSoundName == $name)
				return;
			if (_isLoaded)
			{
				playMusic();
			}
			else
			{
				if(!this.hasEventListener(SoundEvent.SOUND_LOADED))
					this.addEventListener(SoundEvent.SOUND_LOADED,soundLoaded);
			}
		}
		
		private function playMusic():void
		{
//			if(_playType == 0)
//				_oSoundName = _name;
//			if (_soundChannel && _playType == 0)
//			{
//				_soundChannel.stop();
//				_soundChannel.stop();
//				SoundMixer.stopAll();
//				if()
//			}
			
			for each(var scData:SCData in _soundChannels)
			{
				if(scData.type == 0)
					scData.sc.stop();
			}
			_soundChannel = _sounds[_name].play(0,_loop);
			_soundChannels[_name] = new SCData(_playType,_soundChannel);
			
		}
		
		private function soundLoaded(e:SoundEvent):void
		{
			// TODO Auto-generated method stub
			playMusic();
		}
		
		/**
		 * 停止播放音乐
		 */
		public function stop($name:String):void
		{
//			_soundChannel.stop;
			_soundChannels[$name].sc.stop();
		}
		
		public function stopAll():void
		{
			SoundMixer.stopAll();
//			for(var sc:soun)
//			_soundChannels = undefined;
		}
		
	}
	
	
}

internal class InterClass { };