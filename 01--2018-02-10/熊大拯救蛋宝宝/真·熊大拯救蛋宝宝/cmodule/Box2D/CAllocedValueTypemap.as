package cmodule.Box2D
{

    class CAllocedValueTypemap extends CTypemap
    {
        private var allocator:ICAllocator;

        function CAllocedValueTypemap(param1:ICAllocator)
        {
            this.allocator = param1;
            return;
        }// end function

        override public function fromC(param1:Array)
        {
            return readValue(param1[0]);
        }// end function

        protected function alloc(param1) : int
        {
            return this.allocator.cmodule.Box2D:ICAllocator::alloc(getValueSize(param1));
        }// end function

        override public function createC(param1, param2:int = 0) : Array
        {
            if (!param2)
            {
                param2 = this.alloc(param1);
            }
            writeValue(param2, param1);
            return [param2];
        }// end function

        override public function destroyC(param1:Array) : void
        {
            this.free(param1[0]);
            return;
        }// end function

        protected function free(param1:int) : void
        {
            return this.allocator.cmodule.Box2D:ICAllocator::free(param1);
        }// end function

    }
}
