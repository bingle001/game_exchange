package 
{
    import StoneMan2.*;
    import com.greensock.easing.*;
    import com.greensock.layout.*;
    import com.greensock.plugins.*;
    import defs.*;
    import facade.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;
    import tcUtils.slider.*;
    import tcUtils.sound.*;

    public class StoneMan2 extends MovieClip
    {
        private var resourceClass:Class;
        public var container:MovieClip;
        public var inattion:Object;
        public var ull:String;
        public var tf:TextField;
        private var loader:Loader;
        public static var instance:StoneMan2;
        public static var _4399_function_gameList_id:String = "944c23f5e64a80647f8d0f3435f5c7a8";
        public static var serviceHold:Object = null;
        public static var bgmusic:String = "xcmkonglongdan";

        public function StoneMan2()
        {
            this.resourceClass = StoneMan2_resourceClass;
            instance = this;
            this.load();
            Def.read();
            Security.allowDomain("*");
            return;
        }// end function

        public function setHold(param1) : void
        {
            serviceHold = param1;
            return;
        }// end function

        public function getMovie(param1:String)
        {
            return this.container.getChildByName(param1);
        }// end function

        public function getClass(param1:String) : Class
        {
            if (this.loader != null)
            {
                return this.loader.contentLoaderInfo.applicationDomain.getDefinition(param1) as Class;
            }
            return this.loaderInfo.applicationDomain.getDefinition(param1) as Class;
        }// end function

        private function loadCs() : void
        {
            this.loaderInfo.addEventListener(Event.COMPLETE, this.onLoaderCom);
            return;
        }// end function

        private function load() : void
        {
            var _loc_1:* = new this.resourceClass() as MovieClip;
            this.loader = _loc_1.getChildAt(0) as Loader;
            this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoaderCom);
            return;
        }// end function

        private function onLoaderCom(event:Event) : void
        {
            event.target.removeEventListener(Event.COMPLETE, this.onLoaderCom);
            this.inattion = Base64;
            this.container = event.target.content as MovieClip;
            addChild(this.container);
            GameSound.instance.init(this.container);
            GameSound.instance.music = StoneMan2.bgmusic;
            var _loc_2:* = getDefinitionByName("flash.text.TextField") as Class;
            this.tf = new _loc_2;
            var _loc_3:* = new LocalConnection();
            var _loc_4:* = _loc_3.domain;
            this.ull = _loc_4;
            if (_loc_4.indexOf("4399") == -1)
            {
                this.tf.text = "本游戏侵犯作者版权，请到4399玩正版游戏";
            }
            var _loc_5:* = new AlignMode();
            var _loc_6:* = new Expo();
            var _loc_7:* = new ColorMatrixFilterPlugin();
            var _loc_8:* = new TransformMatrixPlugin();
            Gfacade.instance().startGame(this);
            var _loc_9:* = new SliderManager();
            return;
        }// end function

    }
}
