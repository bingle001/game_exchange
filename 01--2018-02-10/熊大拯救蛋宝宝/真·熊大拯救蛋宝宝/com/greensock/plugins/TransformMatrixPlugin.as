package com.greensock.plugins
{
    import com.greensock.*;
    import flash.geom.*;

    public class TransformMatrixPlugin extends TweenPlugin
    {
        protected var _transform:Transform;
        protected var _matrix:Matrix;
        protected var _txStart:Number;
        protected var _txChange:Number;
        protected var _tyStart:Number;
        protected var _tyChange:Number;
        protected var _aStart:Number;
        protected var _aChange:Number;
        protected var _bStart:Number;
        protected var _bChange:Number;
        protected var _cStart:Number;
        protected var _cChange:Number;
        protected var _dStart:Number;
        protected var _dChange:Number;
        protected var _angleChange:Number = 0;
        public static const API:Number = 1;
        private static const _DEG2RAD:Number = 0.0174533;

        public function TransformMatrixPlugin()
        {
            this.propName = "transformMatrix";
            this.overwriteProps = ["x", "y", "scaleX", "scaleY", "rotation", "transformMatrix", "transformAroundPoint", "transformAroundCenter", "shortRotation"];
            return;
        }// end function

        override public function onInitTween(param1:Object, param2, param3:TweenLite) : Boolean
        {
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            this._transform = param1.transform as Transform;
            this._matrix = this._transform.matrix;
            var _loc_4:* = this._matrix.clone();
            this._txStart = _loc_4.tx;
            this._tyStart = _loc_4.ty;
            this._aStart = _loc_4.a;
            this._bStart = _loc_4.b;
            this._cStart = _loc_4.c;
            this._dStart = _loc_4.d;
            if ("x" in param2)
            {
                this._txChange = typeof(param2.x) == "number" ? (param2.x - this._txStart) : (Number(param2.x));
            }
            else if ("tx" in param2)
            {
                this._txChange = param2.tx - this._txStart;
            }
            else
            {
                this._txChange = 0;
            }
            if ("y" in param2)
            {
                this._tyChange = typeof(param2.y) == "number" ? (param2.y - this._tyStart) : (Number(param2.y));
            }
            else if ("ty" in param2)
            {
                this._tyChange = param2.ty - this._tyStart;
            }
            else
            {
                this._tyChange = 0;
            }
            this._aChange = "a" in param2 ? (param2.a - this._aStart) : (0);
            this._bChange = "b" in param2 ? (param2.b - this._bStart) : (0);
            this._cChange = "c" in param2 ? (param2.c - this._cStart) : (0);
            this._dChange = "d" in param2 ? (param2.d - this._dStart) : (0);
            if (!("rotation" in param2))
            {
            }
            if (!("shortRotation" in param2))
            {
                if ("scale" in param2)
                {
                }
            }
            if (param2 is Matrix)
            {
            }
            if (!("scaleX" in param2))
            {
            }
            if (!("scaleY" in param2))
            {
            }
            if (!("skewX" in param2))
            {
            }
            if (!("skewY" in param2))
            {
            }
            if (!("skewX2" in param2))
            {
            }
            if ("skewY2" in param2)
            {
                _loc_7 = Math.sqrt(_loc_4.a * _loc_4.a + _loc_4.b * _loc_4.b);
                if (_loc_4.a < 0)
                {
                }
                if (_loc_4.d > 0)
                {
                    _loc_7 = -_loc_7;
                }
                _loc_8 = Math.sqrt(_loc_4.c * _loc_4.c + _loc_4.d * _loc_4.d);
                if (_loc_4.d < 0)
                {
                }
                if (_loc_4.a > 0)
                {
                    _loc_8 = -_loc_8;
                }
                _loc_9 = Math.atan2(_loc_4.b, _loc_4.a);
                if (_loc_4.a < 0)
                {
                }
                if (_loc_4.d >= 0)
                {
                    _loc_9 = _loc_9 + (_loc_9 <= 0 ? (Math.PI) : (-Math.PI));
                }
                _loc_10 = Math.atan2(-this._matrix.c, this._matrix.d) - _loc_9;
                _loc_11 = _loc_9;
                if ("shortRotation" in param2)
                {
                    _loc_13 = (param2.shortRotation * _DEG2RAD - _loc_9) % (Math.PI * 2);
                    if (_loc_13 > Math.PI)
                    {
                        _loc_13 = _loc_13 - Math.PI * 2;
                    }
                    else if (_loc_13 < -Math.PI)
                    {
                        _loc_13 = _loc_13 + Math.PI * 2;
                    }
                    _loc_11 = _loc_11 + _loc_13;
                }
                else if ("rotation" in param2)
                {
                    _loc_11 = typeof(param2.rotation) == "number" ? (param2.rotation * _DEG2RAD) : (Number(param2.rotation) * _DEG2RAD + _loc_9);
                }
                _loc_12 = "skewX" in param2 ? (typeof(param2.skewX) == "number" ? (Number(param2.skewX) * _DEG2RAD) : (Number(param2.skewX) * _DEG2RAD + _loc_10)) : (0);
                if ("skewY" in param2)
                {
                    _loc_14 = typeof(param2.skewY) == "number" ? (param2.skewY * _DEG2RAD) : (Number(param2.skewY) * _DEG2RAD - _loc_10);
                    _loc_11 = _loc_11 + (_loc_14 + _loc_10);
                    _loc_12 = _loc_12 - _loc_14;
                }
                if (_loc_11 != _loc_9)
                {
                    if (!("rotation" in param2))
                    {
                    }
                    if ("shortRotation" in param2)
                    {
                        this._angleChange = _loc_11 - _loc_9;
                        _loc_11 = _loc_9;
                    }
                    else
                    {
                        _loc_4.rotate(_loc_11 - _loc_9);
                    }
                }
                if ("scale" in param2)
                {
                    _loc_5 = Number(param2.scale) / _loc_7;
                    _loc_6 = Number(param2.scale) / _loc_8;
                    if (typeof(param2.scale) != "number")
                    {
                        _loc_5 = _loc_5 + 1;
                        _loc_6 = _loc_6 + 1;
                    }
                }
                else
                {
                    if ("scaleX" in param2)
                    {
                        _loc_5 = Number(param2.scaleX) / _loc_7;
                        if (typeof(param2.scaleX) != "number")
                        {
                            _loc_5 = _loc_5 + 1;
                        }
                    }
                    if ("scaleY" in param2)
                    {
                        _loc_6 = Number(param2.scaleY) / _loc_8;
                        if (typeof(param2.scaleY) != "number")
                        {
                            _loc_6 = _loc_6 + 1;
                        }
                    }
                }
                if (_loc_12 != _loc_10)
                {
                    _loc_4.c = (-_loc_8) * Math.sin(_loc_12 + _loc_11);
                    _loc_4.d = _loc_8 * Math.cos(_loc_12 + _loc_11);
                }
                if ("skewX2" in param2)
                {
                    if (typeof(param2.skewX2) == "number")
                    {
                        _loc_4.c = Math.tan(-param2.skewX2 * _DEG2RAD);
                    }
                    else
                    {
                        _loc_4.c = _loc_4.c + Math.tan(-Number(param2.skewX2) * _DEG2RAD);
                    }
                }
                if ("skewY2" in param2)
                {
                    if (typeof(param2.skewY2) == "number")
                    {
                        _loc_4.b = Math.tan(param2.skewY2 * _DEG2RAD);
                    }
                    else
                    {
                        _loc_4.b = _loc_4.b + Math.tan(Number(param2.skewY2) * _DEG2RAD);
                    }
                }
                if (!_loc_5)
                {
                }
                if (_loc_5 == 0)
                {
                    _loc_4.a = _loc_4.a * _loc_5;
                    _loc_4.b = _loc_4.b * _loc_5;
                }
                if (!_loc_6)
                {
                }
                if (_loc_6 == 0)
                {
                    _loc_4.c = _loc_4.c * _loc_6;
                    _loc_4.d = _loc_4.d * _loc_6;
                }
                this._aChange = _loc_4.a - this._aStart;
                this._bChange = _loc_4.b - this._bStart;
                this._cChange = _loc_4.c - this._cStart;
                this._dChange = _loc_4.d - this._dStart;
            }
            return true;
        }// end function

        override public function set changeFactor(param1:Number) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            this._matrix.a = this._aStart + param1 * this._aChange;
            this._matrix.b = this._bStart + param1 * this._bChange;
            this._matrix.c = this._cStart + param1 * this._cChange;
            this._matrix.d = this._dStart + param1 * this._dChange;
            if (this._angleChange)
            {
                _loc_2 = Math.cos(this._angleChange * param1);
                _loc_3 = Math.sin(this._angleChange * param1);
                _loc_4 = this._matrix.a;
                _loc_5 = this._matrix.c;
                this._matrix.a = _loc_4 * _loc_2 - this._matrix.b * _loc_3;
                this._matrix.b = _loc_4 * _loc_3 + this._matrix.b * _loc_2;
                this._matrix.c = _loc_5 * _loc_2 - this._matrix.d * _loc_3;
                this._matrix.d = _loc_5 * _loc_3 + this._matrix.d * _loc_2;
            }
            this._matrix.tx = this._txStart + param1 * this._txChange;
            this._matrix.ty = this._tyStart + param1 * this._tyChange;
            this._transform.matrix = this._matrix;
            return;
        }// end function

    }
}
