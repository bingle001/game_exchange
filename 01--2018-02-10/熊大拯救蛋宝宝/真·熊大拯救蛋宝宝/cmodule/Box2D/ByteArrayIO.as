package cmodule.Box2D
{
    import flash.utils.*;

    class ByteArrayIO extends IO
    {
        public var byteArray:ByteArray;

        function ByteArrayIO()
        {
            return;
        }// end function

        override public function set size(param1:int) : void
        {
            if (!this.byteArray)
            {
                throw new AlchemyBlock();
            }
            this.byteArray.length = param1;
            return;
        }// end function

        override public function read(param1:int, param2:int) : int
        {
            var _loc_3:* = 0;
            if (!this.byteArray)
            {
                throw new AlchemyBlock();
            }
            _loc_3 = Math.min(param2, this.byteArray.bytesAvailable);
            if (_loc_3)
            {
                this.byteArray.readBytes(ds, param1, _loc_3);
            }
            return _loc_3;
        }// end function

        override public function get size() : int
        {
            if (!this.byteArray)
            {
                throw new AlchemyBlock();
            }
            return this.byteArray.length;
        }// end function

        override public function get position() : int
        {
            if (!this.byteArray)
            {
                throw new AlchemyBlock();
            }
            return this.byteArray.position;
        }// end function

        override public function set position(param1:int) : void
        {
            if (!this.byteArray)
            {
                throw new AlchemyBlock();
            }
            this.byteArray.position = param1;
            return;
        }// end function

        override public function write(param1:int, param2:int) : int
        {
            if (!this.byteArray)
            {
                throw new AlchemyBlock();
            }
            if (param2)
            {
                this.byteArray.writeBytes(ds, param1, param2);
            }
            return param2;
        }// end function

    }
}
