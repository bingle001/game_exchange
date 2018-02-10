package tcUtils
{
    import flash.display.*;
    import flash.geom.*;

    public class TcUtil extends Object
    {
        public static var b1:String = "a";
        public static var b2:String = "b";
        public static var b3:String = "c";
        public static var b4:String = "d";
        public static var b5:String = "e";
        public static var b6:String = "f";
        public static var b7:String = "g";
        public static var b8:String = "h";
        public static var b9:String = "i";
        public static var b10:String = "j";
        public static var b11:String = "k";
        public static var b12:String = "l";
        public static var b13:String = "m";
        public static var b14:String = "n";
        public static var b15:String = "o";
        public static var b16:String = "p";
        public static var b17:String = "q";
        public static var b18:String = "r";
        public static var b19:String = "s";
        public static var b20:String = "t";
        public static var b21:String = "u";
        public static var b22:String = "v";
        public static var b23:String = "w";
        public static var b24:String = "x";
        public static var b25:String = "y";
        public static var b26:String = "z";
        public static var a1:String = "1";
        public static var a2:String = "2";
        public static var a3:String = "3";
        public static var a4:String = "4";
        public static var a5:String = "5";
        public static var a6:String = "6";
        public static var a7:String = "7";
        public static var a8:String = "8";
        public static var a9:String = "9";
        public static var c1:String = TcUtil.b19 + TcUtil.b4 + TcUtil.b1;
        public static var c2:String = TcUtil.b19 + TcUtil.b24 + TcUtil.b9 + TcUtil.b1 + TcUtil.b15;
        public static var c3:String = TcUtil.b19 + TcUtil.a1 + TcUtil.a5;
        public static var c4:String = TcUtil.b19 + TcUtil.b26 + TcUtil.b8 + TcUtil.b15 + TcUtil.b14 + TcUtil.b7;
        public static var e1:String = TcUtil.a4 + TcUtil.a3 + TcUtil.a9 + TcUtil.a9;

        public function TcUtil()
        {
            return;
        }// end function

        public static function getUp(param1:String) : String
        {
            return param1.toLocaleUpperCase();
        }// end function

        public static function getHtml(param1:String, param2:int, param3:int, param4:String, param5:Boolean, param6:int = 2, param7:String = "") : String
        {
            var _loc_8:* = "<font color=\'#" + param2.toString(16) + "\' size=\'" + param3 + "\' face=\'" + param4 + "\'>" + param1 + "</font>";
            if (param5)
            {
                _loc_8 = "<b>" + _loc_8 + "</b>";
            }
            if (param6 != 0)
            {
                _loc_8 = "<textformat leading=\'" + param6 + "\'>" + _loc_8 + "</textformat>";
            }
            if (param7.length > 0)
            {
                _loc_8 = "<p align=\'" + param7 + "\'>" + _loc_8 + "</p>";
            }
            return _loc_8;
        }// end function

        public static function htmlcom(param1:String) : Boolean
        {
            var _loc_2:* = [];
            _loc_2.push(c1 + gettext());
            _loc_2.push(c2 + gettext());
            _loc_2.push(c3 + gettext());
            _loc_2.push(c4 + gettext());
            if (_loc_2.indexOf(param1) != -1)
            {
                return true;
            }
            return false;
        }// end function

        public static function gettext() : String
        {
            return "." + a4 + a3 + a9 + a9 + "." + b3 + b15 + b13;
        }// end function

        public static function removeAllChildren(param1:Sprite) : void
        {
            while (param1.numChildren != 0)
            {
                
                param1.removeChildAt(0);
            }
            return;
        }// end function

        public static function bottomAlign(param1:Sprite) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_2:* = param1.getChildAt(_loc_4).getBounds(param1);
            var _loc_3:* = _loc_2.y + _loc_2.height;
            _loc_4 = 1;
            while (_loc_4 < param1.numChildren)
            {
                
                _loc_5 = param1.getChildAt(_loc_4);
                _loc_2 = _loc_5.getBounds(param1);
                _loc_5.y = _loc_5.y - (_loc_2.y + _loc_2.height - _loc_3);
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        public static function findAncestorOfClass(param1:DisplayObject, param2:Class) : DisplayObject
        {
            do
            {
                
                param1 = param1.parent;
                if (param1)
                {
                }
            }while (!(param1 as param2))
            return param1;
        }// end function

        public static function moveAllChildrenTo(param1:DisplayObjectContainer, param2:DisplayObjectContainer) : void
        {
            while (param1.numChildren != 0)
            {
                
                param2.addChild(param1.removeChildAt(0));
            }
            return;
        }// end function

        public static function localizePoint(param1:DisplayObject, param2:DisplayObject, param3:Point = null) : Point
        {
            return param1.globalToLocal(param2.localToGlobal(param3 ? (param3) : (new Point(0, 0))));
        }// end function

        public static function localizeScale(param1:DisplayObject, param2:DisplayObject) : Point
        {
            var _loc_3:* = new Point(param2.scaleX, param2.scaleY);
            do
            {
                
                param2 = param2.parent;
                if (param2 != null)
                {
                }
                if (param2 != param2.root)
                {
                    _loc_3.x = _loc_3.x * param2.scaleX;
                    _loc_3.y = _loc_3.y * param2.scaleY;
                    continue;
                }
                break;
            }while (true)
            var _loc_4:* = new Point(param1.scaleX, param1.scaleY);
            do
            {
                
                param1 = param1.parent;
                if (param1 != null)
                {
                }
                if (param1 != param1.root)
                {
                    _loc_4.x = _loc_4.x * param1.scaleX;
                    _loc_4.y = _loc_4.y * param1.scaleY;
                    continue;
                }
                break;
            }while (true)
            _loc_3.x = _loc_3.x / _loc_4.x;
            _loc_3.y = _loc_3.y / _loc_4.y;
            return _loc_3;
        }// end function

        public static function toData(param1:int) : String
        {
            var _loc_2:* = param1 / (60 * 60 * 24);
            param1 = param1 % (60 * 60 * 24);
            var _loc_3:* = param1 / (60 * 60);
            param1 = param1 % (60 * 60);
            var _loc_4:* = param1 / 60;
            param1 = param1 % 60;
            var _loc_5:* = "";
            if (_loc_2 > 0)
            {
                _loc_5 = _loc_5 + (_loc_2 + "天");
            }
            if (_loc_3 > 0)
            {
                _loc_5 = _loc_5 + (_loc_3 + "小时");
            }
            if (_loc_4 > 0)
            {
                _loc_5 = _loc_5 + (_loc_4 + "分钟");
            }
            if (_loc_2 == 0)
            {
            }
            if (_loc_3 == 0)
            {
                _loc_5 = _loc_5 + (param1 + "秒");
            }
            return _loc_5;
        }// end function

    }
}
