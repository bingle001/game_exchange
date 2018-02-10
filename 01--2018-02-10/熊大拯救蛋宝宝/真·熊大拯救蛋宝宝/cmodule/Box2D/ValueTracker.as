package cmodule.Box2D
{
    import flash.utils.*;

    class ValueTracker extends Object
    {
        private var snum:int = 1;
        private var val2rcv:Dictionary;
        private var id2key:Object;

        function ValueTracker()
        {
            this.val2rcv = new Dictionary();
            this.id2key = {};
            return;
        }// end function

        public function acquireId(param1:int) : int
        {
            var _loc_2:* = null;
            if (param1)
            {
                _loc_2 = this.id2key[param1];
                var _loc_3:* = this.val2rcv[_loc_2];
                var _loc_4:* = this.val2rcv[_loc_2].rc + 1;
                _loc_3.rc = _loc_4;
            }
            return param1;
        }// end function

        public function get(param1:int)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1)
            {
                _loc_2 = this.id2key[param1];
                _loc_3 = this.val2rcv[_loc_2];
                return _loc_3.value;
            }
            return undefined;
        }// end function

        public function release(param1:int)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1)
            {
                _loc_2 = this.id2key[param1];
                _loc_3 = this.val2rcv[_loc_2];
                if (_loc_3)
                {
                    var _loc_4:* = _loc_3;
                    _loc_4.rc = _loc_3.rc - 1;
                    if (!--_loc_3.rc)
                    {
                        delete this.id2key[param1];
                        delete this.val2rcv[_loc_2];
                    }
                    return _loc_3.value;
                }
                else
                {
                    log(1, "ValueTracker extra release!: " + param1);
                }
            }
            return undefined;
        }// end function

        public function acquire(param1) : int
        {
            var _loc_2:* = null;
            var _loc_3:* = undefined;
            var _loc_4:* = 0;
            if (typeof(param1) == "undefined")
            {
                return 0;
            }
            _loc_2 = Object(param1);
            if (_loc_2 instanceof QName)
            {
                _loc_2 = "*VT*QName*/" + _loc_2.toString();
            }
            _loc_3 = this.val2rcv[_loc_2];
            if (typeof(_loc_3) == "undefined")
            {
                do
                {
                    
                    var _loc_5:* = this;
                    var _loc_6:* = this.snum + 1;
                    _loc_5.snum = _loc_6;
                    if (this.snum)
                    {
                    }
                }while (typeof(this.id2key[this.snum]) != "undefined")
                _loc_4 = this.snum;
                this.val2rcv[_loc_2] = new RCValue(param1, _loc_4);
                this.id2key[_loc_4] = _loc_2;
            }
            else
            {
                _loc_4 = _loc_3.id;
                var _loc_5:* = this.val2rcv[_loc_2];
                var _loc_6:* = this.val2rcv[_loc_2].rc + 1;
                _loc_5.rc = _loc_6;
            }
            return _loc_4;
        }// end function

    }
}
