package cmodule.Box2D
{

    class CTypemap extends Object
    {
        public static var AS3ValType:CAS3ValTypemap;
        public static var DoubleType:CDoubleTypemap;
        public static var VoidType:CVoidTypemap;
        public static var DoubleRefType:CRefTypemap;
        public static var StrRefType:CRefTypemap;
        public static var IntRefType:CRefTypemap;
        public static var SizedStrType:CSizedStrUTF8Typemap;
        public static var IntType:CIntTypemap;
        public static var StrType:CStrUTF8Typemap;
        public static var PtrType:CPtrTypemap;
        public static var BufferType:CBufferTypemap;

        function CTypemap()
        {
            return;
        }// end function

        public function fromC(param1:Array)
        {
            return undefined;
        }// end function

        public function writeValue(param1:int, param2) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            _loc_3 = this.createC(param2);
            ds.position = param1;
            _loc_4 = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                ds.writeInt(_loc_3[_loc_4]);
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        public function readValue(param1:int)
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            _loc_2 = [];
            ds.position = param1;
            _loc_3 = 0;
            while (_loc_3 < this.typeSize)
            {
                
                _loc_2.push(ds.readInt());
                _loc_3 = _loc_3 + 1;
            }
            return this.fromC(_loc_2);
        }// end function

        public function get ptrLevel() : int
        {
            return 0;
        }// end function

        public function createC(param1, param2:int = 0) : Array
        {
            return null;
        }// end function

        public function fromReturnRegs(param1:Object)
        {
            var _loc_2:* = null;
            var _loc_3:* = undefined;
            _loc_2 = [param1.eax];
            _loc_3 = this.fromC(_loc_2);
            this.destroyC(_loc_2);
            return _loc_3;
        }// end function

        public function destroyC(param1:Array) : void
        {
            return;
        }// end function

        public function toReturnRegs(param1:Object, param2, param3:int = 0) : void
        {
            param1.eax = this.createC(param2, param3)[0];
            return;
        }// end function

        public function get typeSize() : int
        {
            return 4;
        }// end function

        public function getValueSize(param1) : int
        {
            return this.typeSize;
        }// end function

        public static function getTypeByName(param1:String) : CTypemap
        {
            return [param1];
        }// end function

        public static function getTypesByNames(param1:String) : Array
        {
            return getTypesByNameArray(param1.split(/\s*,\s*""\s*,\s*/));
        }// end function

        public static function getTypesByNameArray(param1:Array) : Array
        {
            var _loc_2:* = null;
            var _loc_3:* = undefined;
            _loc_2 = [];
            if (param1)
            {
                for each (_loc_3 in param1)
                {
                    
                    _loc_2.push(getTypeByName(_loc_3));
                }
            }
            return _loc_2;
        }// end function

    }
}
