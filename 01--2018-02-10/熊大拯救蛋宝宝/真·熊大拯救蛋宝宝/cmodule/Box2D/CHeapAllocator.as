package cmodule.Box2D
{
    import cmodule.Box2D.*;

    class CHeapAllocator extends Object implements ICAllocator
    {
        private var pmalloc:Function;
        private var pfree:Function;

        function CHeapAllocator()
        {
            return;
        }// end function

        public function free(param1:int) : void
        {
            if (this.pfree == null)
            {
                this.pfree = new CProcTypemap(VoidType, [PtrType]).fromC([]);
            }
            this.pfree(param1);
            return;
        }// end function

        public function alloc(param1:int) : int
        {
            var _loc_2:* = 0;
            if (this.pmalloc == null)
            {
                this.pmalloc = new CProcTypemap(PtrType, [IntType]).fromC([]);
            }
            _loc_2 = this.pmalloc(param1);
            return _loc_2;
        }// end function

    }
}
