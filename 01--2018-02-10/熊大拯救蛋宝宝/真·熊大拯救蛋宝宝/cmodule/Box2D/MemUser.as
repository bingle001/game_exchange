package cmodule.Box2D
{

    public class MemUser extends Object
    {

        public function MemUser()
        {
            return;
        }// end function

        final public function _mrd(param1:int) : Number
        {
            ds.position = param1;
            return ds.readDouble();
        }// end function

        final public function _mrf(param1:int) : Number
        {
            ds.position = param1;
            return ds.readFloat();
        }// end function

        final public function _mr32(param1:int) : int
        {
            ds.position = param1;
            return ds.readInt();
        }// end function

        final public function _mru8(param1:int) : int
        {
            ds.position = param1;
            return ds.readUnsignedByte();
        }// end function

        final public function _mw32(param1:int, param2:int) : void
        {
            ds.position = param1;
            ds.writeInt(param2);
            return;
        }// end function

        final public function _mrs8(param1:int) : int
        {
            ds.position = param1;
            return ds.readByte();
        }// end function

        final public function _mw16(param1:int, param2:int) : void
        {
            ds.position = param1;
            ds.writeShort(param2);
            return;
        }// end function

        final public function _mw8(param1:int, param2:int) : void
        {
            ds.position = param1;
            ds.writeByte(param2);
            return;
        }// end function

        final public function _mrs16(param1:int) : int
        {
            ds.position = param1;
            return ds.readShort();
        }// end function

        final public function _mru16(param1:int) : int
        {
            ds.position = param1;
            return ds.readUnsignedShort();
        }// end function

        final public function _mwd(param1:int, param2:Number) : void
        {
            ds.position = param1;
            ds.writeDouble(param2);
            return;
        }// end function

        final public function _mwf(param1:int, param2:Number) : void
        {
            ds.position = param1;
            ds.writeFloat(param2);
            return;
        }// end function

    }
}
