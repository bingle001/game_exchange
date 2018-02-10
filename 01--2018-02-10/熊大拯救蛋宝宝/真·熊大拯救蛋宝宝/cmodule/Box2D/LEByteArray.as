package cmodule.Box2D
{
    import flash.utils.*;

    class LEByteArray extends ByteArray
    {

        function LEByteArray()
        {
            super.endian = "littleEndian";
            return;
        }// end function

        override public function set endian(param1:String) : void
        {
            throw "LEByteArray endian set attempted";
        }// end function

    }
}
