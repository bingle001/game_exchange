package com.greensock.plugins
{
    import flash.utils.*;

    public class Base64 extends Object
    {
        private var _b64Chars:Array;
        private var _b64Lookup:Object;
        private var _linebreaks:Boolean;

        public function Base64()
        {
            this._b64Chars = new Array("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "+", "/");
            this._b64Lookup = this._buildB64Lookup();
            return;
        }// end function

        public function isWhitespace(param1:String) : Boolean
        {
            switch(param1)
            {
                case " ":
                case "\t":
                case "\r":
                case "\n":
                case "\f":
                {
                    return true;
                }
                default:
                {
                    return false;
                    break;
                }
            }
        }// end function

        public function Encode(param1:ByteArray, param2:Boolean = false) : String
        {
            this._linebreaks = param2;
            return this._encodeBytes(param1);
        }// end function

        public function deadca(param1:String) : ByteArray
        {
            return this._decodeSring(param1);
        }// end function

        private function _buildB64Lookup() : Object
        {
            var _loc_1:* = new Object();
            var _loc_2:* = 0;
            while (_loc_2 < this._b64Chars.length)
            {
                
                _loc_1[this._b64Chars[_loc_2]] = _loc_2;
                _loc_2 = _loc_2 + 1;
            }
            return _loc_1;
        }// end function

        private function _isBase64(param1:String) : Boolean
        {
            return this._b64Lookup[param1] != undefined;
        }// end function

        private function _encodeBytes(param1:ByteArray) : String
        {
            var _loc_3:* = 0;
            var _loc_5:* = null;
            var _loc_2:* = "";
            var _loc_4:* = 0;
            param1.position = 0;
            while (param1.position < param1.length)
            {
                
                _loc_3 = param1.bytesAvailable >= 3 ? (3) : (param1.bytesAvailable);
                _loc_5 = new ByteArray();
                param1.readBytes(_loc_5, 0, _loc_3);
                _loc_2 = _loc_2 + this._b64EncodeBuffer(_loc_5);
                _loc_4 = _loc_4 + 4;
                if (this._linebreaks)
                {
                }
                if (_loc_4 % 76 == 0)
                {
                    _loc_2 = _loc_2 + "\n";
                    _loc_4 = 0;
                }
            }
            return _loc_2.toString();
        }// end function

        private function _b64EncodeBuffer(param1:ByteArray) : String
        {
            var _loc_2:* = "";
            _loc_2 = _loc_2 + this._b64Chars[param1[0] >> 2];
            switch(param1.length)
            {
                case 1:
                {
                    _loc_2 = _loc_2 + this._b64Chars[param1[0] << 4 & 48];
                    _loc_2 = _loc_2 + "==";
                    break;
                }
                case 2:
                {
                    _loc_2 = _loc_2 + this._b64Chars[param1[0] << 4 & 48 | param1[1] >> 4];
                    _loc_2 = _loc_2 + this._b64Chars[param1[1] << 2 & 60];
                    _loc_2 = _loc_2 + "=";
                    break;
                }
                case 3:
                {
                    _loc_2 = _loc_2 + this._b64Chars[param1[0] << 4 & 48 | param1[1] >> 4];
                    _loc_2 = _loc_2 + this._b64Chars[param1[1] << 2 & 60 | param1[2] >> 6];
                    _loc_2 = _loc_2 + this._b64Chars[param1[2] & 63];
                    break;
                }
                default:
                {
                    trace("Base64 byteBuffer outOfRange");
                    break;
                }
            }
            return _loc_2.toString();
        }// end function

        private function _decodeSring(param1:String) : ByteArray
        {
            var _loc_7:* = null;
            var _loc_2:* = "" + param1;
            var _loc_3:* = new ByteArray();
            var _loc_4:* = "";
            var _loc_5:* = _loc_2.length;
            var _loc_6:* = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_7 = _loc_2.charAt(_loc_6);
                if (!this.isWhitespace(_loc_7))
                {
                    if (!this._isBase64(_loc_7))
                    {
                        this._isBase64(_loc_7);
                    }
                }
                if (_loc_7 == "=")
                {
                    _loc_4 = _loc_4 + _loc_7;
                    if (_loc_4.length == 4)
                    {
                        _loc_3.writeBytes(this._b64DecodeBuffer(_loc_4));
                        _loc_4 = "";
                    }
                }
                _loc_6 = _loc_6 + 1;
            }
            _loc_3.position = 0;
            return _loc_3;
        }// end function

        private function _b64DecodeBuffer(param1:String) : ByteArray
        {
            var _loc_2:* = new ByteArray();
            var _loc_3:* = this._b64Lookup[param1.charAt(0)];
            var _loc_4:* = this._b64Lookup[param1.charAt(1)];
            var _loc_5:* = this._b64Lookup[param1.charAt(2)];
            var _loc_6:* = this._b64Lookup[param1.charAt(3)];
            _loc_2.writeByte(_loc_3 << 2 | _loc_4 >> 4);
            if (param1.charAt(2) != "=")
            {
                _loc_2.writeByte(_loc_4 << 4 | _loc_5 >> 2);
            }
            if (param1.charAt(3) != "=")
            {
                _loc_2.writeByte(_loc_5 << 6 | _loc_6);
            }
            return _loc_2;
        }// end function

    }
}
