package tcUtils.sound.swfParser
{
    import flash.geom.*;
    import flash.utils.*;

    public class SWFParser extends Object
    {
        protected var _data:Data;
        protected var _version:uint;
        protected var _size:uint;
        protected var _rect:Rectangle;
        protected var _frameRate:uint;
        protected var _frames:uint;

        public function SWFParser(param1:ByteArray)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1)
            {
                param1.position = 0;
                _loc_2 = param1.readUTFBytes(3);
                this._version = param1.readUnsignedByte();
                this._size = param1.readUnsignedInt();
                this._data = new Data(param1);
                if (_loc_2 == "CWS")
                {
                    _loc_3 = new ByteArray();
                    this._data.readBytes(_loc_3);
                    _loc_3.position = 0;
                    _loc_3.uncompress();
                    _loc_3.position = 0;
                    this._data = new Data(_loc_3);
                }
                this._rect = this._data.readRect();
                this._frameRate = this._data.readUnsignedShort() >> 8;
                this._frames = this._data.readShort();
            }
            return;
        }// end function

        public function parseTags(param1, param2:Boolean, param3:uint = 0, param4:Data = null) : Array
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            if (param4 == null)
            {
                param4 = this._data;
            }
            var _loc_5:* = -1;
            var _loc_8:* = param4.position;
            var _loc_9:* = [];
            do
            {
                
                _loc_5 = param4.readUnsignedShort();
                _loc_6 = _loc_5 & 63;
                if (_loc_6 == 63)
                {
                    _loc_6 = param4.readUnsignedInt();
                }
                _loc_5 = _loc_5 >> 6;
                _loc_7 = param4.position;
                if (_loc_5 != param1)
                {
                }
                if (param1 is Array ? ((param1 as Array).indexOf(_loc_5) != -1) : (false))
                {
                    _loc_10 = new Tag(_loc_5, param4.position, _loc_6);
                    if (param2)
                    {
                        _loc_11 = new ByteArray();
                        param4.readBytes(_loc_11, 0, _loc_10.length);
                        _loc_11.position = 0;
                        _loc_10.data = new Data(_loc_11);
                    }
                    _loc_9.push(_loc_10);
                }
                if (param4.position == _loc_7)
                {
                    param4.position = param4.position + _loc_6;
                }
                if (param4.bytesAvailable)
                {
                }
            }while (_loc_5 != param3)
            param4.position = _loc_8;
            return _loc_9;
        }// end function

        public function get data() : Data
        {
            return this._data;
        }// end function

        public function get ver() : uint
        {
            return this._version;
        }// end function

        public function get size() : uint
        {
            return this._size;
        }// end function

        public function get rect() : Rectangle
        {
            return this._rect;
        }// end function

        public function get frameRate() : uint
        {
            return this._frameRate;
        }// end function

        public function get frames() : uint
        {
            return this._frames;
        }// end function

    }
}
