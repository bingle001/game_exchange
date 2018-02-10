package com.greensock.plugins
{
    import com.greensock.*;

    public class QuaternionsPlugin extends TweenPlugin
    {
        protected var _target:Object;
        protected var _quaternions:Array;
        public static const API:Number = 1;
        static const _RAD2DEG:Number = 57.2958;

        public function QuaternionsPlugin()
        {
            this._quaternions = [];
            this.propName = "quaternions";
            this.overwriteProps = [];
            return;
        }// end function

        override public function onInitTween(param1:Object, param2, param3:TweenLite) : Boolean
        {
            var _loc_4:* = null;
            if (param2 == null)
            {
                return false;
            }
            for (_loc_4 in param2)
            {
                
                this.initQuaternion(param1[_loc_4], param2[_loc_4], _loc_4);
            }
            return true;
        }// end function

        public function initQuaternion(param1:Object, param2:Object, param3:String) : void
        {
            var _loc_4:* = NaN;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            _loc_5 = param1;
            _loc_6 = param2;
            _loc_7 = _loc_5.x;
            _loc_8 = _loc_6.x;
            _loc_9 = _loc_5.y;
            _loc_10 = _loc_6.y;
            _loc_11 = _loc_5.z;
            _loc_12 = _loc_6.z;
            _loc_13 = _loc_5.w;
            _loc_14 = _loc_6.w;
            _loc_4 = _loc_7 * _loc_8 + _loc_9 * _loc_10 + _loc_11 * _loc_12 + _loc_13 * _loc_14;
            if (_loc_4 < 0)
            {
                _loc_7 = _loc_7 * -1;
                _loc_9 = _loc_9 * -1;
                _loc_11 = _loc_11 * -1;
                _loc_13 = _loc_13 * -1;
                _loc_4 = _loc_4 * -1;
            }
            if ((_loc_4 + 1) < 1e-006)
            {
                _loc_10 = -_loc_9;
                _loc_8 = _loc_7;
                _loc_14 = -_loc_13;
                _loc_12 = _loc_11;
            }
            _loc_15 = Math.acos(_loc_4);
            this._quaternions[this._quaternions.length] = [_loc_5, param3, _loc_7, _loc_8, _loc_9, _loc_10, _loc_11, _loc_12, _loc_13, _loc_14, _loc_4, _loc_15, 1 / Math.sin(_loc_15)];
            this.overwriteProps[this.overwriteProps.length] = param3;
            return;
        }// end function

        override public function killProps(param1:Object) : void
        {
            var _loc_2:* = this._quaternions.length - 1;
            while (_loc_2 > -1)
            {
                
                if (param1[this._quaternions[_loc_2][1]] != undefined)
                {
                    this._quaternions.splice(_loc_2, 1);
                }
                _loc_2 = _loc_2 - 1;
            }
            super.killProps(param1);
            return;
        }// end function

        override public function set changeFactor(param1:Number) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            _loc_2 = this._quaternions.length - 1;
            while (_loc_2 > -1)
            {
                
                _loc_3 = this._quaternions[_loc_2];
                if ((_loc_3[10] + 1) > 1e-006)
                {
                    if (1 - _loc_3[10] >= 1e-006)
                    {
                        _loc_4 = Math.sin(_loc_3[11] * (1 - param1)) * _loc_3[12];
                        _loc_5 = Math.sin(_loc_3[11] * param1) * _loc_3[12];
                    }
                    else
                    {
                        _loc_4 = 1 - param1;
                        _loc_5 = param1;
                    }
                }
                else
                {
                    _loc_4 = Math.sin(Math.PI * (0.5 - param1));
                    _loc_5 = Math.sin(Math.PI * param1);
                }
                _loc_3[0].x = _loc_4 * _loc_3[2] + _loc_5 * _loc_3[3];
                _loc_3[0].y = _loc_4 * _loc_3[4] + _loc_5 * _loc_3[5];
                _loc_3[0].z = _loc_4 * _loc_3[6] + _loc_5 * _loc_3[7];
                _loc_3[0].w = _loc_4 * _loc_3[8] + _loc_5 * _loc_3[9];
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

    }
}
