package cmodule.Box2D
{

    class CAS3ValTypemap extends CTypemap
    {
        private var values:ValueTracker;

        function CAS3ValTypemap()
        {
            this.values = new ValueTracker();
            return;
        }// end function

        override public function fromC(param1:Array)
        {
            return this.values.get(param1[0]);
        }// end function

        override public function createC(param1, param2:int = 0) : Array
        {
            return [this.values.acquire(param1)];
        }// end function

        override public function destroyC(param1:Array) : void
        {
            this.values.release(param1[0]);
            return;
        }// end function

        public function get valueTracker() : ValueTracker
        {
            return this.values;
        }// end function

    }
}
