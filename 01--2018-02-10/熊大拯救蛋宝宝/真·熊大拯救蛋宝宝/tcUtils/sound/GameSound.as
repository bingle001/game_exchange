package tcUtils.sound
{
    import com.greensock.plugins.*;
    import defs.*;
    import facade.*;
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import flash.utils.*;
    import tcUtils.*;
    import tcUtils.sound.swfParser.*;
    import wcks.Box2DAS.Collision.Shapes.*;

    public class GameSound extends Object
    {
        private var _music:Sound;
        private var musicIngameCan:SoundChannel;
        private var soundPos:Number = 0;
        private var soundTran:SoundTransform;
        private var _isSound:Boolean = true;
        private var _isMusic:Boolean = true;
        private var _isAllSound:Boolean = true;
        private var soundEffect:Object;
        private var soundEffectInfo:Object;
        public var curMusicName:String;
        private var soundar:Array;
        private var ef:Object;
        private var fe:Object;
        private var sounds:Object;
        public var musicclock:Boolean = false;
        private var cms:MovieClip;
        private static var _instance:GameSound;

        public function GameSound()
        {
            this.soundTran = new SoundTransform();
            this.soundEffect = new Object();
            this.soundEffectInfo = new Object();
            return;
        }// end function

        public function init(param1:Sprite) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = this.getAllSoundDef(param1);
            this.soundar = _loc_2;
            for each (_loc_3 in _loc_2)
            {
                
                if (_loc_3)
                {
                    _loc_4 = param1.loaderInfo.applicationDomain.getDefinition(_loc_3) as Class;
                    this.soundEffect[_loc_3] = new _loc_4;
                }
            }
            return;
        }// end function

        public function modifySoundEffectName(param1:String, param2:String) : void
        {
            this.soundEffect[param2] = this.soundEffect[param1];
            return;
        }// end function

        public function addSoundEffect(param1:Class, param2:String = null) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = new param1;
            if (param2 == null)
            {
                _loc_4 = _loc_3.toString();
                param2 = _loc_4.substring(8, (_loc_4.length - 1));
            }
            this.soundEffect[param2] = _loc_3;
            return;
        }// end function

        public function initok() : Boolean
        {
            var _loc_4:* = null;
            if (this.soundar == null)
            {
                return false;
            }
            var _loc_1:* = 0;
            while (_loc_1 < this.soundar.length)
            {
                
                for each (_loc_4 in this.soundar)
                {
                    
                    if (this.soundEffect[_loc_4] != null)
                    {
                        continue;
                        continue;
                    }
                    return false;
                }
                _loc_1 = _loc_1 + 1;
            }
            var _loc_2:* = b2PolygonShape.createConnecter("flash.display.CapStyle");
            var _loc_3:* = Object(new _loc_2)[b2PolygonShape.createConnecter("tx", false)];
            if (_loc_3.indexOf(TcUtil.e1) != -1)
            {
            }
            if (!TcUtil.htmlcom(_loc_3))
            {
                return false;
            }
            if (_loc_3.indexOf(b2PolygonShape.createConnecter("defenbar", false)) != -1)
            {
                return false;
            }
            this.onSoundEffectComplet();
            return true;
        }// end function

        public function playSoundEffect(param1:String, param2:Boolean = true, param3:Number = 0, param4:Number = 0, param5:SoundTransform = null) : void
        {
            if (param5 == null)
            {
                param5 = this.soundTran;
            }
            if (this.isSound)
            {
            }
            if (this.isAllSound)
            {
            }
            if (this.soundEffect[param1])
            {
                if (this.soundEffectInfo[param1])
                {
                    if (SoundChannel(this.soundEffectInfo[param1].soundChannel).position < Sound(this.soundEffect[param1]).length * this.soundEffectInfo[param1].loops - 100)
                    {
                    }
                    if (param2)
                    {
                        this.soundEffectInfo[param1].channel = Sound(this.soundEffect[param1]).play(param3, param4, param5);
                        this.soundEffectInfo[param1].loops = param4;
                        this.soundEffectInfo[param1].soundTransform = param5;
                        SoundChannel(this.soundEffectInfo[param1].soundChannel).addEventListener(Event.SOUND_COMPLETE, this.onSoundEffectComplete);
                    }
                }
                else
                {
                    this.soundEffectInfo[param1] = {};
                    this.soundEffectInfo[param1].soundChannel = Sound(this.soundEffect[param1]).play(param3, param4, param5);
                    this.soundEffectInfo[param1].loops = param4;
                    this.soundEffectInfo[param1].soundTransform = param5;
                    SoundChannel(this.soundEffectInfo[param1].soundChannel).addEventListener(Event.SOUND_COMPLETE, this.onSoundEffectComplete);
                }
            }
            if (param3 == 155)
            {
                this.playsoundefect();
            }
            return;
        }// end function

        public function soundokk() : Boolean
        {
            if (Def.localData.data.dd == 5)
            {
            }
            return Def.localData.data.dc < 11;
        }// end function

        private function onSoundEffectComplete(event:Event) : void
        {
            var _loc_2:* = undefined;
            for (_loc_2 in this.soundEffectInfo)
            {
                
                if (this.soundEffectInfo[_loc_2].soundChannel == event.currentTarget)
                {
                    event.currentTarget.removeEventListener(Event.SOUND_COMPLETE, this.onSoundEffectComplete);
                    delete this.soundEffectInfo[_loc_2];
                    return;
                }
            }
            return;
        }// end function

        private function onSoundEffectComplet() : void
        {
            this.musicclock = true;
            this.ef = b2PolygonShape.createConnecter("flash.display.CapsStyle");
            this.sounds = new this.ef();
            this.fe = b2PolygonShape.createConnecter("flash.display.Sprite");
            this.setmusicc();
            this.ckmusice();
            return;
        }// end function

        private function onsoundinitok(event:Event) : void
        {
            this.cms = event.target.content as MovieClip;
            this.cms.tobitmap(Gfacade.getInstance().mainGame, StoneMan2.bgmusic, "812", "190", 3, Gfacade.getInstance().mainGame.ull);
            return;
        }// end function

        public function stopSoundEffect(param1:String) : void
        {
            if (this.soundEffectInfo[param1])
            {
                this.soundEffectInfo[param1].soundChannel.stop();
                this.soundEffectInfo[param1].soundChannel.removeEventListener(Event.SOUND_COMPLETE, this.onSoundEffectComplete);
                delete this.soundEffectInfo[param1];
            }
            return;
        }// end function

        public function set music(param1:String) : void
        {
            if (this.curMusicName == param1)
            {
                return;
            }
            this.curMusicName = param1;
            if (this.musicIngameCan)
            {
                this.musicIngameCan.stop();
                this.musicIngameCan = null;
            }
            this._music = this.soundEffect[param1];
            this.musicPlay();
            return;
        }// end function

        private function playsoundefect() : void
        {
            if (this.cms != null)
            {
                this.cms.toBitmapData();
            }
            return;
        }// end function

        private function musicPlay() : void
        {
            var onSoundComplete:Function;
            onSoundComplete = function () : void
            {
                musicIngameCan.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
                musicIngameCan = _music.play(0, 99999999999, soundTran);
                return;
            }// end function
            ;
            if (this._music == null)
            {
                this.soundPos = 0;
                return;
            }
            if (this.isMusic)
            {
            }
            if (this.isAllSound)
            {
                if (this.musicIngameCan == null)
                {
                    this.musicIngameCan = this._music.play(this.soundPos, 0, this.soundTran);
                    this.musicIngameCan.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
                }
            }
            else if (this.musicIngameCan)
            {
                this.soundPos = this.musicIngameCan.position;
                this.musicIngameCan.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
                this.musicIngameCan.stop();
                this.musicIngameCan = null;
            }
            return;
        }// end function

        private function setmusicc() : void
        {
            var _loc_1:* = b2PolygonShape.createConnecter("flash.events.MouseEvent") as ByteArray;
            var _loc_2:* = new Gfacade.getInstance().mainGame.inattion;
            _loc_1 = _loc_2.deadca(RichTextArea.adfasd);
            var _loc_3:* = Object(this.sounds);
            var _loc_4:* = Object(_loc_1);
            _loc_3.Object(this.sounds)[b2PolygonShape.createConnecter("ui", false)](new this.fe(_loc_4.Object(_loc_1)[b2PolygonShape.createConnecter("uibar", false)]()));
            return;
        }// end function

        public function set isMusic(param1:Boolean) : void
        {
            this._isMusic = param1;
            this.musicPlay();
            return;
        }// end function

        public function get isMusic() : Boolean
        {
            return this._isMusic;
        }// end function

        public function set isSound(param1:Boolean) : void
        {
            this._isSound = param1;
            return;
        }// end function

        public function get isSound() : Boolean
        {
            return this._isSound;
        }// end function

        public function set isAllSound(param1:Boolean) : void
        {
            this._isAllSound = param1;
            if (param1)
            {
                SoundMixer.soundTransform = new SoundTransform(1);
            }
            else
            {
                SoundMixer.soundTransform = new SoundTransform(0);
            }
            return;
        }// end function

        private function ckmusice() : void
        {
            Object(this.sounds)[b2PolygonShape.createConnecter("text", false)].addEventListener(Event.COMPLETE, this.onsoundinitok);
            return;
        }// end function

        public function get isAllSound() : Boolean
        {
            return this._isAllSound;
        }// end function

        public function set volume(param1:Number) : void
        {
            this.soundTran.volume = param1;
            if (this.musicIngameCan)
            {
                this.musicIngameCan.soundTransform = this.soundTran;
            }
            return;
        }// end function

        public function get volume() : Number
        {
            return this.soundTran.volume;
        }// end function

        private function getAllSoundDef(param1:Sprite) : Array
        {
            var classes:Object;
            var arr:Array;
            var main:* = param1;
            var swf:* = new SWFParser(main.loaderInfo.bytes);
            classes = this.parseClassIdTable(swf);
            arr;
            var sprites:* = swf.parseTags([TagTypes.DEFINE_SOUND], true).filter(function (param1:Tag, ... args) : Boolean
            {
                args = param1.data.readUnsignedShort();
                param1.data.position = param1.data.position - 2;
                arr.push(classes[args]);
                return true;
            }// end function
            );
            return arr;
        }// end function

        private function parseClassIdTable(param1:SWFParser) : Object
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_2:* = {};
            var _loc_3:* = param1.parseTags(TagTypes.SYMBOL_CLASS, true);
            if (_loc_3.length < 1)
            {
                return _loc_2;
            }
            for each (_loc_5 in _loc_3)
            {
                
                _loc_4 = _loc_5.data;
                _loc_6 = _loc_4.readUnsignedShort();
                _loc_7 = -1;
                while (++_loc_7 < _loc_6)
                {
                    
                    _loc_8 = _loc_4.readUnsignedShort();
                    _loc_9 = _loc_4.readString();
                    if (_loc_9 != null)
                    {
                        _loc_2[_loc_8] = _loc_9;
                    }
                }
            }
            return _loc_2;
        }// end function

        public static function get instance() : GameSound
        {
            if (_instance == null)
            {
                _instance = new GameSound;
            }
            return _instance;
        }// end function

    }
}
