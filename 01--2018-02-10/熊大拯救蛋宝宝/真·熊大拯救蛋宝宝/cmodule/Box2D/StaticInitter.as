package cmodule.Box2D
{

    public class StaticInitter extends Object
    {
        var ptr:int = 0;

        public function StaticInitter()
        {
            return;
        }// end function

        private function ST16int(param1:int, param2:int) : void
        {
            gworker.mstate._mw16(param1, param2);
            return;
        }// end function

        public function set ascii(param1:String) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            _loc_2 = param1.length;
            _loc_3 = 0;
            while (_loc_3 < _loc_2)
            {
                
                this.i8 = param1.charCodeAt(_loc_3);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function set asciz(param1:String) : void
        {
            this.ascii = param1;
            this.i8 = 0;
            return;
        }// end function

        public function start(param1:int) : void
        {
            this.ptr = param1;
            return;
        }// end function

        private function ST32int(param1:int, param2:int) : void
        {
            gworker.mstate._mw32(param1, param2);
            return;
        }// end function

        public function set i32(param1:uint) : void
        {
            this.ST32int(this.ptr, param1);
            this.ptr = this.ptr + 4;
            return;
        }// end function

        public function alloc(param1:int, param2:int) : int
        {
            var _loc_3:* = 0;
            if (!param2)
            {
                param2 = 1;
            }
            this.ptr = this.ptr ? (this.ptr) : (ds.length ? (ds.length) : (1024));
            this.ptr = this.ptr + param2 - 1 & ~(param2 - 1);
            _loc_3 = this.ptr;
            this.ptr = this.ptr + param1;
            ds.length = this.ptr;
            return _loc_3;
        }// end function

        public function set zero(param1:int) : void
        {
            while (param1--)
            {
                
                this.i8 = 0;
            }
            return;
        }// end function

        private function ST8int(param1:int, param2:int) : void
        {
            gworker.mstate._mw8(param1, param2);
            return;
        }// end function

        public function set i16(param1:uint) : void
        {
            this.ST16int(this.ptr, param1);
            this.ptr = this.ptr + 2;
            return;
        }// end function

        public function set i8(param1:uint) : void
        {
            this.ST8int(this.ptr, param1);
            (this.ptr + 1);
            return;
        }// end function

    }
}
