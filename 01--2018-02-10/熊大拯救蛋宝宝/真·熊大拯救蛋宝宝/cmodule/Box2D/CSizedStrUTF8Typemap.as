package cmodule.Box2D
{

    class CSizedStrUTF8Typemap extends CTypemap
    {

        function CSizedStrUTF8Typemap()
        {
            return;
        }// end function

        override public function fromC(param1:Array)
        {
            ds.position = param1[0];
            return ds.readUTFBytes(param1[1]);
        }// end function

        override public function get typeSize() : int
        {
            return 8;
        }// end function

    }
}
