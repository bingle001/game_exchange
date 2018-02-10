package defs
{
    import facade.*;
    import flash.net.*;
    import wcks.*;

    public class Def extends Object
    {
        public static var wck:WcksManager;
        public static var SEC:Number = 0.2;
        public static var worldGravityY:Number = 9.8;
        public static var carSpeed:Number = 1.2;
        public static var count:int = 0;
        public static var STOPJUMP:String = "stopjump";
        public static var PLAYJUMP:String = "playjump";
        public static var Static:String = "Static";
        public static var Animated:String = "Animated";
        public static var Dynamic:String = "Dynamic";
        public static var WIN:String = "win";
        public static var FAIL:String = "fail";
        public static var totalScore:int = 0;
        public static var curScore:int = 0;
        public static var _bossLives:int = 0;
        public static var curLevel:int = 1;
        public static var throwNum:int = 1;
        public static var totalGate:int = 20;
        public static var RED_GEM_SCORE:int = 10;
        public static var ORANGE_GEM_SCORE:int = 1;
        public static var BLUE_GEM_SCORE:int = 30;
        public static var QINGBAOSHI_GEM_SCORE:int = 40;
        public static var HONGBAOSHI_GEM_SCORE:int = 50;
        public static var jumpBoard_up_down_range:Number = 70;
        public static var jumpBoard_right_left_range:Number = 70;
        public static var jumpBoard_speed:Number = 2;
        public static var jumpHight:Number = -5;
        public static var scoreAr:Array = [];
        private static var _localData:SharedObject;

        public function Def()
        {
            return;
        }// end function

        public static function moreGame() : void
        {
            var _loc_1:* = StoneMan2.serviceHold;
            if (_loc_1)
            {
                _loc_1.showGameList();
            }
            return;
        }// end function

        public static function get localData() : SharedObject
        {
            if (_localData == null)
            {
                _localData = SharedObject.getLocal(StoneMan2.bgmusic);
            }
            return _localData;
        }// end function

        public static function save(param1:int, param2:int) : void
        {
            trace("save", param1);
            if (param1 >= throwNum)
            {
                throwNum = param1;
                if (throwNum > totalGate)
                {
                    throwNum = totalGate;
                }
                localData.data.throwNum = throwNum;
            }
            if (scoreAr[getGateId(param1)] == null)
            {
                scoreAr[getGateId(param1)] = param2;
            }
            else if (scoreAr[getGateId(param1)] < param2)
            {
                scoreAr[getGateId(param1)] = param2;
            }
            localData.data.str = getSaveStr();
            return;
        }// end function

        public static function getTotalScore(param1:int) : int
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            while (_loc_3 < param1)
            {
                
                _loc_2 = _loc_2 + parseInt(scoreAr[getGateId(param1)]);
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        private static function getSaveStr() : String
        {
            var _loc_1:* = "";
            var _loc_2:* = 0;
            while (_loc_2 < totalGate)
            {
                
                if (scoreAr[getGateId((_loc_2 + 1))] == null)
                {
                    _loc_1 = _loc_1 + "0_";
                }
                else
                {
                    _loc_1 = _loc_1 + (scoreAr[getGateId((_loc_2 + 1))] + "_");
                }
                _loc_2 = _loc_2 + 1;
            }
            _loc_1 = _loc_1.substr(0, (_loc_1.length - 1));
            return _loc_1;
        }// end function

        public static function getGateId(param1:int) : String
        {
            return "lv" + param1;
        }// end function

        public static function read() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            if (localData.data.throwNum)
            {
                throwNum = localData.data.throwNum;
            }
            else
            {
                throwNum = 1;
            }
            trace(throwNum);
            var _loc_1:* = localData.data.str;
            if (_loc_1 != null)
            {
                _loc_2 = _loc_1.split("_");
                _loc_3 = 0;
                while (_loc_3 < totalGate)
                {
                    
                    scoreAr[getGateId((_loc_3 + 1))] = _loc_2[_loc_3];
                    _loc_3 = _loc_3 + 1;
                }
            }
            return;
        }// end function

        public static function jumpEmpty() : void
        {
            Gfacade.instance().mainGame.container.gotoAndStop(1, "空");
            return;
        }// end function

    }
}
