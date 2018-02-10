package com.greensock.plugins
{
    import com.greensock.*;

    public class ScalePlugin extends TweenPlugin
    {
        protected var _target:Object;
        protected var _startX:Number;
        protected var _changeX:Number;
        protected var _startY:Number;
        protected var _changeY:Number;
        public static const API:Number = 1;

        public function ScalePlugin()
        {
            this.propName = "scale";
            this.overwriteProps = ["scaleX", "scaleY", "width", "height"];
            return;
        }// end function

        override public function onInitTween(param1:Object, param2, param3:TweenLite) : Boolean
        {
            if (!param1.hasOwnProperty("scaleX"))
            {
                return false;
            }
            this._target = param1;
            this._startX = this._target.scaleX;
            this._startY = this._target.scaleY;
            if (typeof(param2) == "number")
            {
                this._changeX = param2 - this._startX;
                this._changeY = param2 - this._startY;
            }
            else
            {
                var _loc_4:* = Number(param2);
                this._changeY = Number(param2);
                this._changeX = _loc_4;
            }
            return true;
        }// end function

        override public function killProps(param1:Object) : void
        {
            var _loc_2:* = this.overwriteProps.length;
            while (_loc_2--)
            {
                
                if (this.overwriteProps[_loc_2] in param1)
                {
                    this.overwriteProps = [];
                    return;
                }
            }
            return;
        }// end function

        override public function set changeFactor(param1:Number) : void
        {
            this._target.scaleX = this._startX + param1 * this._changeX;
            this._target.scaleY = this._startY + param1 * this._changeY;
            return;
        }// end function

    }
}
