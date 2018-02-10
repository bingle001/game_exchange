package cmodule.Box2D
{

    class CBuffer extends Object
    {
        private var sizeVal:int;
        private var valCache:Object;
        private var allocator:ICAllocator;
        private var ptrVal:int;
        private static var ptr2Buffer:Object = {};

        function CBuffer(param1:int, param2:ICAllocator = null)
        {
            if (!param2)
            {
                param2 = new CHeapAllocator();
            }
            this.allocator = param2;
            this.sizeVal = param1;
            this.alloc();
            return;
        }// end function

        public function get size() : int
        {
            return this.sizeVal;
        }// end function

        public function set value(param1) : void
        {
            if (this.ptrVal)
            {
                this.setValue(param1);
            }
            else
            {
                this.valCache = param1;
            }
            return;
        }// end function

        public function free() : void
        {
            if (this.ptrVal)
            {
                this.valCache = this.computeValue();
                this.allocator.free(this.ptrVal);
                delete ptr2Buffer[this.ptrVal];
                this.ptrVal = 0;
            }
            return;
        }// end function

        public function get ptr() : int
        {
            return this.ptrVal;
        }// end function

        protected function setValue(param1) : void
        {
            return;
        }// end function

        public function get value()
        {
            return this.ptrVal ? (this.computeValue()) : (this.valCache);
        }// end function

        protected function computeValue()
        {
            return undefined;
        }// end function

        private function alloc() : void
        {
            if (!this.ptrVal)
            {
                this.ptrVal = this.allocator.alloc(this.sizeVal);
                ptr2Buffer[this.ptrVal] = this;
            }
            return;
        }// end function

        public function reset() : void
        {
            if (!this.ptrVal)
            {
                this.alloc();
                this.setValue(this.valCache);
            }
            return;
        }// end function

        public static function free(param1:int) : void
        {
            ptr2Buffer[param1].free();
            return;
        }// end function

    }
}
