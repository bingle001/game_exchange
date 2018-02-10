package tcUtils
{

    public class TcArrayUtil extends Object
    {

        public function TcArrayUtil()
        {
            return;
        }// end function

        public static function concat(param1:Array, param2:Array) : Array
        {
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_3:* = new Array();
            for each (_loc_4 in param1)
            {
                
                _loc_3.push(_loc_4);
            }
            for each (_loc_5 in param2)
            {
                
                _loc_3.push(_loc_5);
            }
            return _loc_3;
        }// end function

        public static function getDifferentItems(param1:Array, param2:Array) : Array
        {
            var _loc_4:* = undefined;
            var _loc_3:* = new Array();
            for each (_loc_4 in param1)
            {
                
                if (param2.indexOf(_loc_4) == -1)
                {
                    _loc_3.push(_loc_4);
                }
            }
            return _loc_3;
        }// end function

        public static function splice(param1:Array, param2) : void
        {
            var _loc_3:* = param1.indexOf(param2);
            if (_loc_3 > -1)
            {
                param1.splice(_loc_3, 1);
            }
            return;
        }// end function

        public static function copyArray(param1:Array) : Array
        {
            var _loc_3:* = undefined;
            var _loc_2:* = [];
            for each (_loc_3 in param1)
            {
                
                if (_loc_3 is Array)
                {
                    _loc_2.push(copyArray(_loc_3));
                    continue;
                }
                _loc_2.push(_loc_3);
            }
            return _loc_2;
        }// end function

        public static function copyObject(param1:Object) : Object
        {
            var _loc_3:* = null;
            var _loc_2:* = [];
            for (_loc_3 in param1)
            {
                
                _loc_2[_loc_3] = param1[_loc_3];
            }
            return _loc_2;
        }// end function

        public static function checkRepeat(param1:Array) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            for each (_loc_2 in param1)
            {
                
                _loc_3 = 0;
                for each (_loc_4 in param1)
                {
                    
                    if (_loc_2 == _loc_4)
                    {
                        _loc_3 = _loc_3 + 1;
                    }
                }
                if (_loc_3 > 1)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public static function delArray(param1:Array) : void
        {
            if (param1 == null)
            {
                return;
            }
            var _loc_2:* = param1.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (param1[_loc_3] is Array)
                {
                    delArray(param1[_loc_3]);
                }
                param1[_loc_3] = null;
                _loc_3 = _loc_3 + 1;
            }
            param1 = null;
            return;
        }// end function

        public static function clearArray(param1:Array) : void
        {
            if (param1 == null)
            {
                return;
            }
            var _loc_2:* = param1.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (param1[_loc_3] is Array)
                {
                    clearArray(param1[_loc_3]);
                }
                param1[_loc_3] = null;
                delete param1[_loc_3];
                _loc_3 = _loc_3 + 1;
            }
            param1.length = 0;
            return;
        }// end function

        public static function delEmptyEle(param1:Array) : Array
        {
            if (!param1)
            {
                return null;
            }
            var _loc_2:* = 0;
            while (_loc_2 < param1.length)
            {
                
                if (!TcStr.equal(param1[_loc_2], ""))
                {
                    TcStr.equal(param1[_loc_2], "");
                }
                if (TcStr.equal(param1[_loc_2], " "))
                {
                    param1.splice(_loc_2, 1);
                    _loc_2 = _loc_2 - 1;
                }
                _loc_2 = _loc_2 + 1;
            }
            return param1;
        }// end function

        public static function echoAr(param1:Array, param2:String) : void
        {
            var _loc_3:* = undefined;
            trace(param2);
            for each (_loc_3 in param1)
            {
                
                if (_loc_3 is Array)
                {
                    echoAr(_loc_3, param2);
                    continue;
                }
                trace(_loc_3);
            }
            return;
        }// end function

    }
}
