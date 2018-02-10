package com.greensock.plugins
{
    import com.greensock.*;
    import flash.display.*;
    import flash.geom.*;

    public class ScrollRectPlugin extends TweenPlugin
    {
        protected var _target:DisplayObject;
        protected var _rect:Rectangle;
        public static const API:Number = 1;

        public function ScrollRectPlugin()
        {
            this.propName = "scrollRect";
            this.overwriteProps = ["scrollRect"];
            return;
        }// end function

        override public function onInitTween(param1:Object, param2, param3:TweenLite) : Boolean
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (!(param1 is DisplayObject))
            {
                return false;
            }
            this._target = param1 as DisplayObject;
            if (this._target.scrollRect != null)
            {
                this._rect = this._target.scrollRect;
            }
            else
            {
                _loc_5 = this._target.getBounds(this._target);
                this._rect = new Rectangle(0, 0, _loc_5.width + _loc_5.x, _loc_5.height + _loc_5.y);
            }
            for (_loc_4 in param2)
            {
                
                addTween(this._rect, _loc_4, this._rect[_loc_4], param2[_loc_4], _loc_4);
            }
            return true;
        }// end function

        override public function set changeFactor(param1:Number) : void
        {
            updateTweens(param1);
            this._target.scrollRect = this._rect;
            return;
        }// end function

    }
}
