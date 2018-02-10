package cmodule.Box2D
{

    class CVoidTypemap extends CTypemap
    {

        function CVoidTypemap()
        {
            return;
        }// end function

        override public function fromReturnRegs(param1:Object)
        {
            return undefined;
        }// end function

        override public function toReturnRegs(param1:Object, param2, param3:int = 0) : void
        {
            return;
        }// end function

        override public function get typeSize() : int
        {
            return 0;
        }// end function

    }
}
