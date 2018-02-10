package tcUtils.sound.swfParser
{
    import flash.geom.*;
    import flash.utils.*;

    public class Data extends Object implements IDataInput
    {
        protected var _data:ByteArray;
        protected var _bitBuff:int;
        protected var _bitPos:int;

        public function Data(param1:ByteArray)
        {
            this._data = param1;
            this._data.endian = Endian.LITTLE_ENDIAN;
            this.synchBits();
            return;
        }// end function

        public function synchBits() : void
        {
            this._bitBuff = 0;
            this._bitPos = 0;
            return;
        }// end function

        public function readSBits(param1:uint) : int
        {
            var _loc_2:* = this.readUBits(param1);
            if ((_loc_2 & 1 << (param1 - 1)) != 0)
            {
                _loc_2 = _loc_2 | -1 << param1;
            }
            return _loc_2;
        }// end function

        public function readUBits(param1:uint) : uint
        {
            var _loc_4:* = 0;
            if (param1 == 0)
            {
                return 0;
            }
            var _loc_2:* = param1;
            var _loc_3:* = 0;
            if (this._bitPos == 0)
            {
                this._bitBuff = this._data.readUnsignedByte();
                this._bitPos = 8;
            }
            while (true)
            {
                
                _loc_4 = _loc_2 - this._bitPos;
                if (_loc_4 > 0)
                {
                    _loc_3 = _loc_3 | this._bitBuff << _loc_4;
                    _loc_2 = _loc_2 - this._bitPos;
                    this._bitBuff = this._data.readUnsignedByte();
                    this._bitPos = 8;
                    continue;
                }
                _loc_3 = _loc_3 | this._bitBuff >> -_loc_4;
                this._bitPos = this._bitPos - _loc_2;
                this._bitBuff = this._bitBuff & 255 >> 8 - this._bitPos;
                break;
            }
            return _loc_3;
        }// end function

        public function readBoolean() : Boolean
        {
            this.synchBits();
            return this._data.readBoolean();
        }// end function

        public function readByte() : int
        {
            this.synchBits();
            return this.readByte();
        }// end function

        public function readBytes(param1:ByteArray, param2:uint = 0, param3:uint = 0) : void
        {
            this.synchBits();
            this._data.readBytes(param1, param2, param3);
            return;
        }// end function

        public function readDouble() : Number
        {
            var _loc_1:* = new ByteArray();
            var _loc_2:* = new ByteArray();
            this._data.readBytes(_loc_1, 0, 8);
            _loc_2.length = 8;
            _loc_2[0] = _loc_1[3];
            _loc_2[1] = _loc_1[2];
            _loc_2[2] = _loc_1[1];
            _loc_2[3] = _loc_1[0];
            _loc_2[4] = _loc_1[7];
            _loc_2[5] = _loc_1[6];
            _loc_2[6] = _loc_1[5];
            _loc_2[7] = _loc_1[4];
            _loc_2.position = 0;
            return _loc_2.readDouble();
        }// end function

        public function readMatrix() : Matrix
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = 0;
            this.synchBits();
            if (this.readUBits(1) == 1)
            {
                _loc_7 = this.readUBits(5);
                _loc_1 = this.readSBits(_loc_7) / 65536;
                _loc_2 = this.readSBits(_loc_7) / 65536;
            }
            else
            {
                _loc_1 = 1;
                _loc_2 = 1;
            }
            if (this.readUBits(1) == 1)
            {
                _loc_7 = this.readUBits(5);
                _loc_3 = this.readSBits(_loc_7) / 65536;
                _loc_4 = this.readSBits(_loc_7) / 65536;
            }
            else
            {
                _loc_3 = 0;
                _loc_4 = 0;
            }
            _loc_7 = this.readUBits(5);
            _loc_5 = this.readSBits(_loc_7) * 0.05;
            _loc_6 = this.readSBits(_loc_7) * 0.05;
            return new Matrix(_loc_1, _loc_3, _loc_4, _loc_2, _loc_5, _loc_6);
        }// end function

        public function readRect() : Rectangle
        {
            var _loc_1:* = this.readUBits(5);
            var _loc_2:* = this.readSBits(_loc_1) * 0.05;
            var _loc_3:* = this.readSBits(_loc_1) * 0.05;
            var _loc_4:* = this.readSBits(_loc_1) * 0.05;
            var _loc_5:* = this.readSBits(_loc_1) * 0.05;
            this.synchBits();
            return new Rectangle(_loc_2, _loc_4, _loc_3 - _loc_2, _loc_5 - _loc_4);
        }// end function

        public function readFloat() : Number
        {
            this.synchBits();
            return this._data.readFloat();
        }// end function

        public function readInt() : int
        {
            this.synchBits();
            return this._data.readInt();
        }// end function

        public function readMultiByte(param1:uint, param2:String) : String
        {
            this.synchBits();
            return this._data.readMultiByte(param1, param2);
        }// end function

        public function readObject()
        {
            this.synchBits();
            return this._data.readObject();
        }// end function

        public function readShort() : int
        {
            this.synchBits();
            return this._data.readShort();
        }// end function

        public function readUnsignedByte() : uint
        {
            this.synchBits();
            return this._data.readUnsignedByte();
        }// end function

        public function readUnsignedInt() : uint
        {
            this.synchBits();
            return this._data.readUnsignedInt();
        }// end function

        public function readUnsignedShort() : uint
        {
            this.synchBits();
            return this._data.readUnsignedShort();
        }// end function

        public function readUTF() : String
        {
            this.synchBits();
            return this._data.readUTF();
        }// end function

        public function readUTFBytes(param1:uint) : String
        {
            this.synchBits();
            return this._data.readUTFBytes(param1);
        }// end function

        public function readString() : String
        {
            var _loc_1:* = 0;
            var _loc_2:* = new ByteArray();
            do
            {
                
                _loc_2.writeByte(_loc_1);
                var _loc_3:* = this.readUnsignedByte();
                _loc_1 = this.readUnsignedByte();
            }while (_loc_3 != 0)
            _loc_2.position = 0;
            return _loc_2.readMultiByte(_loc_2.length, "UTF-8");
        }// end function

        public function get data() : ByteArray
        {
            return this._data;
        }// end function

        public function set data(param1:ByteArray) : void
        {
            this._data = param1;
            this.synchBits();
            return;
        }// end function

        public function get position() : int
        {
            return this._data.position;
        }// end function

        public function set position(param1:int) : void
        {
            this._data.position = param1;
            return;
        }// end function

        public function get bytesAvailable() : uint
        {
            return this._data.bytesAvailable;
        }// end function

        public function get endian() : String
        {
            return this._data.endian;
        }// end function

        public function set endian(param1:String) : void
        {
            this._data.endian = param1;
            return;
        }// end function

        public function get objectEncoding() : uint
        {
            return this._data.objectEncoding;
        }// end function

        public function set objectEncoding(param1:uint) : void
        {
            this._data.objectEncoding = param1;
            return;
        }// end function

        public function get length() : uint
        {
            return this._data.length;
        }// end function

    }
}
