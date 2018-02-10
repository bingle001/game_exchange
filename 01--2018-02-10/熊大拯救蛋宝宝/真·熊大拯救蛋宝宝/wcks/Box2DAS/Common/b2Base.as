package wcks.Box2DAS.Common
{
    import __AS3__.vec.*;
    import cmodule.Box2D.*;
    import flash.utils.*;

    public class b2Base extends Object
    {
        public var _ptr:Number;
        public static var loader:CLibInit;
        public static var lib:Object;
        public static var bytes:ByteArray;
        public static var mem:MemUser;
        public static var initialized:Boolean = false;

        public function b2Base()
        {
            return;
        }// end function

        public function destroy() : void
        {
            this._ptr = 0;
            return;
        }// end function

        public function get valid() : Boolean
        {
            return this._ptr != 0;
        }// end function

        public function writeVertices(param1:int, param2:Vector.<V2>) : void
        {
            bytes.position = param1;
            var _loc_3:* = param2.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                bytes.writeFloat(param2[_loc_4].x);
                bytes.writeFloat(param2[_loc_4].y);
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        public function readVertices(param1:int, param2:int) : Vector.<V2>
        {
            var _loc_3:* = new Vector.<V2>;
            bytes.position = param1;
            var _loc_4:* = 0;
            while (_loc_4 < param2)
            {
                
                _loc_3[_loc_4] = new V2(bytes.readFloat(), bytes.readFloat());
                _loc_4 = _loc_4 + 1;
            }
            return _loc_3;
        }// end function

        public static function initialize(param1:Boolean = true) : void
        {
            if (initialized)
            {
                return;
            }
            initialized = true;
            loader = new CLibInit();
            lib = loader.init();
            mem = new MemUser();
            bytes = gstate.ds;
            if (param1)
            {
                b2Def.initialize();
            }
            return;
        }// end function

        public static function goodbyeBox2D() : void
        {
            b2Def.destroy();
            bytes.length = 0;
            initialized = false;
            loader = null;
            lib = null;
            bytes = null;
            mem = null;
            return;
        }// end function

        public static function getArr() : Array
        {
            return arr;
        }// end function

        public static function deref(param1:int)
        {
            return vt.get(param1);
        }// end function

    }
}
