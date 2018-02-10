package cmodule.Box2D
{

    class CIntTypemap extends CTypemap
    {

        function CIntTypemap()
        {
            return;
        }// end function

        override public function fromC(param1:Array)
        {
            return int(param1[0]);
        }// end function

        override public function createC(param1, param2:int = 0) : Array
        {
            return [int(param1)];
        }// end function

    }
}
