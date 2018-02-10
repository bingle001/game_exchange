package cmodule.Box2D
{
    import flash.utils.*;

    class CDoubleTypemap extends CTypemap
    {
        private var scratch:ByteArray;

        function CDoubleTypemap()
        {
            this.scratch = new ByteArray();
            this.scratch.length = 8;
            this.scratch.endian = "littleEndian";
            return;
        }// end function

        override public function fromReturnRegs(param1:Object)
        {
            return param1.st0;
        }// end function

        override public function toReturnRegs(param1:Object, param2, param3:int = 0) : void
        {
            param1.st0 = param2;
            return;
        }// end function

        override public function createC(param1, param2:int = 0) : Array
        {
            this.scratch.position = 0;
            this.scratch.writeDouble(param1);
            this.scratch.position = 0;
            return [this.scratch.readInt(), this.scratch.readInt()];
        }// end function

        override public function fromC(param1:Array)
        {
            this.scratch.position = 0;
            this.scratch.writeInt(param1[0]);
            this.scratch.writeInt(param1[1]);
            this.scratch.position = 0;
            return this.scratch.readDouble();
        }// end function

        override public function get typeSize() : int
        {
            return 8;
        }// end function

    }
}
