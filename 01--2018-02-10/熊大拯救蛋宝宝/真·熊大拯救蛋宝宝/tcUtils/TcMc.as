package tcUtils
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class TcMc extends Sprite
    {
        private static var _instance:TcMc;
        public static const PLAYOK:String = "TcMcPlayOk";
        public static const PLAYOK2:String = "TcMcPlayOk2";
        public static const PLAYBACKOK:String = "TcMcPlayBackOk";

        public function TcMc()
        {
            return;
        }// end function

        public static function isEmpty(param1:MovieClip) : Boolean
        {
            return !param1;
        }// end function

        public static function gotoNextFrame(param1:MovieClip) : void
        {
            param1.gotoAndStop((param1.currentFrame + 1));
            return;
        }// end function

        public static function gotoPreFrame(param1:MovieClip) : void
        {
            param1.gotoAndStop((param1.currentFrame - 1));
            return;
        }// end function

        public static function localizePoint(param1:DisplayObject, param2:DisplayObject, param3:Point = null) : Point
        {
            return param1.globalToLocal(param2.localToGlobal(param3 ? (param3) : (new Point(0, 0))));
        }// end function

        public static function toBitMap(param1:MovieClip) : Bitmap
        {
            var _loc_2:* = new BitmapData(param1.width, param1.height);
            var _loc_3:* = param1.getRect(param1);
            var _loc_4:* = new Matrix(1, 0, 0, 1, -_loc_3.x, -_loc_3.y);
            _loc_2.draw(param1, _loc_4, null, null, null, true);
            var _loc_5:* = new Bitmap(_loc_2);
            return _loc_5;
        }// end function

        public static function getMcName2(param1:MovieClip) : String
        {
            var _loc_2:* = param1.toString();
            _loc_2 = _loc_2.substring(8, (_loc_2.length - 1));
            return _loc_2;
        }// end function

        public static function playBack(param1:MovieClip, param2:int = 0) : void
        {
            var onFrame:Function;
            var mc:* = param1;
            var endNum:* = param2;
            onFrame = function (event:Event) : void
            {
                mc.gotoAndStop((mc.currentFrame - 1));
                if (mc.currentFrame == endNum)
                {
                    getInstance().removeEventListener(Event.ENTER_FRAME, onFrame);
                    getInstance().dispatchEvent(new Event(PLAYBACKOK));
                }
                return;
            }// end function
            ;
            if (endNum == 0)
            {
                endNum;
            }
            getInstance().addEventListener(Event.ENTER_FRAME, onFrame);
            return;
        }// end function

        public static function play(param1:MovieClip) : void
        {
            var onFrame:Function;
            var mc:* = param1;
            onFrame = function (event:Event) : void
            {
                mc.gotoAndStop((mc.currentFrame + 1));
                if (mc.currentFrame == mc.totalFrames)
                {
                    getInstance().removeEventListener(Event.ENTER_FRAME, onFrame);
                    getInstance().dispatchEvent(new Event(PLAYOK));
                }
                return;
            }// end function
            ;
            getInstance().addEventListener(Event.ENTER_FRAME, onFrame);
            return;
        }// end function

        public static function play2(param1:MovieClip) : void
        {
            var onFrame:Function;
            var mc:* = param1;
            onFrame = function (event:Event) : void
            {
                mc.gotoAndStop((mc.currentFrame + 1));
                if (mc.currentFrame == mc.totalFrames)
                {
                    getInstance().removeEventListener(Event.ENTER_FRAME, onFrame);
                    getInstance().dispatchEvent(new Event(PLAYOK2));
                }
                return;
            }// end function
            ;
            getInstance().addEventListener(Event.ENTER_FRAME, onFrame);
            return;
        }// end function

        public static function removeMc(param1:MovieClip) : void
        {
            if (param1)
            {
            }
            if (param1.parent)
            {
                param1.parent.removeChild(param1);
            }
            param1 = null;
            return;
        }// end function

        public static function getInstance() : TcMc
        {
            if (_instance == null)
            {
                _instance = new TcMc;
            }
            return _instance;
        }// end function

    }
}
