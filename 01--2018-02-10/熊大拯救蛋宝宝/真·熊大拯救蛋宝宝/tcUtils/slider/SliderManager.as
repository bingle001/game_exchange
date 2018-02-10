package tcUtils.slider
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class SliderManager extends Object
    {
        private var dic:Dictionary;
        private var curTarget:DisplayObject;
        private var curTargetXY:Number;
        private var preTime:int = 0;
        private static var _instance:SliderManager;

        public function SliderManager()
        {
            this.dic = new Dictionary();
            return;
        }// end function

        public function registerHorizontal(param1:DisplayObject, param2:Sprite, param3:Rectangle, param4:int, param5:int = 0, param6:int = 0, param7:int = 1, param8:DisplayObject = null, param9:DisplayObject = null, param10:DisplayObject = null, param11:int = 100, param12:int = 1, param13:Boolean = true, param14:Function = null, param15:Array = null) : void
        {
            var _loc_16:* = null;
            var _loc_17:* = null;
            if (this.dic[param1])
            {
                this.unregister(param1);
            }
            _loc_16 = new SliderType(true);
            this.dic[param1] = _loc_16;
            _loc_16.block = param1;
            _loc_16.moveSp = param2;
            _loc_17 = _loc_16.maskSp;
            _loc_17.graphics.beginFill(0, 0.5);
            _loc_17.graphics.drawRect(0, 0, param3.width, param3.height);
            _loc_17.graphics.endFill();
            _loc_17.x = param3.x;
            _loc_17.y = param3.y;
            param2.parent.addChild(_loc_17);
            _loc_16.maskSp = _loc_17;
            _loc_16.moveSp.mask = _loc_17;
            _loc_16.blockMoveRange = param4;
            _loc_16.moveDisPerTime = param7;
            _loc_16.upEdgeDis = param5;
            _loc_16.downEdgeDis = param6;
            var _loc_18:* = param1.getBounds(param1.parent);
            _loc_16.startXY = _loc_18.x;
            _loc_16.fun = param14;
            _loc_16.isBlockChange = param13;
            if (param1 is Sprite)
            {
                Sprite(param1).buttonMode = true;
            }
            _loc_16.upArrow = param8;
            if (param8)
            {
                if (param8 is Sprite)
                {
                    Sprite(param8).buttonMode = true;
                }
                this.dic[param8] = _loc_16;
                param8.addEventListener(MouseEvent.MOUSE_DOWN, this.onArrowDown);
            }
            _loc_16.downArrow = param9;
            if (param9)
            {
                if (param9 is Sprite)
                {
                    Sprite(param9).buttonMode = true;
                }
                this.dic[param9] = _loc_16;
                param9.addEventListener(MouseEvent.MOUSE_DOWN, this.onArrowDown);
            }
            _loc_16.clickObject = param10;
            if (param10)
            {
                this.dic[param10] = _loc_16;
                param10.addEventListener(MouseEvent.CLICK, this.onDownArrowClick);
            }
            _loc_16.arrowMoveIntervalSpeed = param12;
            _loc_16.arrowMoveIntervalTime = param11;
            this.reset(param1, true);
            param1.addEventListener(MouseEvent.MOUSE_DOWN, this.onDown);
            return;
        }// end function

        public function registerVertical(param1:DisplayObject, param2:Sprite, param3:Rectangle, param4:int, param5:int = 0, param6:int = 0, param7:int = 1, param8:DisplayObject = null, param9:DisplayObject = null, param10:DisplayObject = null, param11:int = 100, param12:int = 1, param13:Boolean = true, param14:Function = null, param15:Array = null) : void
        {
            var _loc_16:* = null;
            if (this.dic[param1])
            {
                this.unregister(param1);
            }
            _loc_16 = new SliderType(false);
            this.dic[param1] = _loc_16;
            _loc_16.block = param1;
            _loc_16.moveSp = param2;
            var _loc_17:* = _loc_16.maskSp;
            _loc_17.graphics.beginFill(0, 0.3);
            _loc_17.graphics.drawRect(0, 0, param3.width, param3.height);
            _loc_17.graphics.endFill();
            _loc_17.x = param3.x;
            _loc_17.y = param3.y;
            param2.parent.addChild(_loc_17);
            _loc_16.maskSp = _loc_17;
            _loc_16.moveSp.mask = _loc_17;
            _loc_16.blockMoveRange = param4;
            _loc_16.moveDisPerTime = param7;
            _loc_16.upEdgeDis = param5;
            _loc_16.downEdgeDis = param6;
            var _loc_18:* = param1.getBounds(param1.parent);
            _loc_16.startXY = _loc_18.y;
            _loc_16.fun = param14;
            _loc_16.isBlockChange = param13;
            if (param1 is Sprite)
            {
                Sprite(param1).buttonMode = true;
            }
            _loc_16.upArrow = param8;
            if (param8)
            {
                if (param8 is Sprite)
                {
                    Sprite(param8).buttonMode = true;
                }
                this.dic[param8] = _loc_16;
                param8.addEventListener(MouseEvent.MOUSE_DOWN, this.onArrowDown);
            }
            _loc_16.downArrow = param9;
            if (param9)
            {
                if (param9 is Sprite)
                {
                    Sprite(param9).buttonMode = true;
                }
                this.dic[param9] = _loc_16;
                param9.addEventListener(MouseEvent.MOUSE_DOWN, this.onArrowDown);
            }
            _loc_16.clickObject = param10;
            if (param10)
            {
                this.dic[param10] = _loc_16;
                param10.addEventListener(MouseEvent.CLICK, this.onDownArrowClick);
            }
            _loc_16.arrowMoveIntervalSpeed = param12;
            _loc_16.arrowMoveIntervalTime = param11;
            this.reset(param1, true);
            param1.addEventListener(MouseEvent.MOUSE_DOWN, this.onDown);
            return;
        }// end function

        public function reset(param1:DisplayObject, param2:Boolean = false) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_3:* = param1.x;
            var _loc_4:* = param1.y;
            var _loc_5:* = this.dic[param1];
            if (_loc_5.moveSp.width == 0)
            {
            }
            if (_loc_5.moveSp.height == 0)
            {
                _loc_6 = new Rectangle(_loc_5.moveSp.x, _loc_5.moveSp.y);
            }
            else
            {
                _loc_6 = _loc_5.moveSp.getBounds(_loc_5.moveSp.parent);
            }
            if (_loc_5.isHorizontal)
            {
                _loc_6.x = _loc_6.x - _loc_5.upEdgeDis;
                _loc_6.width = _loc_6.width + (_loc_5.upEdgeDis + _loc_5.downEdgeDis);
                _loc_5.moveSpRec = _loc_6;
                _loc_5.moveSpDis = _loc_5.moveSp.x - _loc_6.x;
                _loc_6.x = _loc_5.maskSp.x;
                if (_loc_6.width <= _loc_5.maskSp.width)
                {
                    param1.visible = false;
                    if (_loc_5.upArrow)
                    {
                        _loc_5.upArrow.visible = false;
                    }
                    if (_loc_5.downArrow)
                    {
                        _loc_5.downArrow.visible = false;
                    }
                }
                else
                {
                    param1.visible = true;
                    if (_loc_5.upArrow)
                    {
                        _loc_5.upArrow.visible = true;
                    }
                    if (_loc_5.downArrow)
                    {
                        _loc_5.downArrow.visible = true;
                    }
                    if (_loc_5.isBlockChange)
                    {
                        param1.width = _loc_5.blockMoveRange * _loc_5.maskSp.width / _loc_6.width;
                    }
                }
                _loc_7 = param1.getBounds(param1.parent);
                param1.x = _loc_5.startXY + param1.x - _loc_7.x;
                _loc_5.dragRec = new Rectangle(param1.x, param1.y, _loc_5.blockMoveRange - param1.width, 0);
                _loc_5.moveRate = (_loc_5.moveSpRec.width - _loc_5.maskSp.width) / _loc_5.dragRec.width;
            }
            else
            {
                _loc_6.y = _loc_6.y - _loc_5.upEdgeDis;
                _loc_6.height = _loc_6.height + (_loc_5.upEdgeDis + _loc_5.downEdgeDis);
                _loc_5.moveSpRec = _loc_6;
                _loc_5.moveSpDis = _loc_5.moveSp.y - _loc_6.y;
                _loc_6.y = _loc_5.maskSp.y;
                if (_loc_6.height <= _loc_5.maskSp.height)
                {
                    param1.visible = false;
                    if (_loc_5.upArrow)
                    {
                        _loc_5.upArrow.visible = false;
                    }
                    if (_loc_5.downArrow)
                    {
                        _loc_5.downArrow.visible = false;
                    }
                }
                else
                {
                    param1.visible = true;
                    if (_loc_5.upArrow)
                    {
                        _loc_5.upArrow.visible = true;
                    }
                    if (_loc_5.downArrow)
                    {
                        _loc_5.downArrow.visible = true;
                    }
                    if (_loc_5.isBlockChange)
                    {
                        param1.height = _loc_5.blockMoveRange * _loc_5.maskSp.height / _loc_6.height;
                    }
                }
                _loc_7 = param1.getBounds(param1.parent);
                param1.y = _loc_5.startXY + param1.y - _loc_7.y;
                _loc_5.dragRec = new Rectangle(param1.x, param1.y, 0, _loc_5.blockMoveRange - param1.height);
                _loc_5.moveRate = (_loc_5.moveSpRec.height - _loc_5.maskSp.height) / _loc_5.dragRec.height;
            }
            if (param2 == false)
            {
            }
            if (param1.visible)
            {
                if (_loc_5.isHorizontal)
                {
                    this.updataBlockXy(param1, _loc_3);
                }
                else
                {
                    this.updataBlockXy(param1, _loc_4);
                }
            }
            this.updataForBlock(param1);
            if (_loc_5.fun != null)
            {
                _loc_5.fun();
            }
            return;
        }// end function

        public function getScale(param1:DisplayObject) : Number
        {
            var _loc_2:* = this.dic[param1];
            return _loc_2.scale;
        }// end function

        public function updataForBlock(param1:DisplayObject) : void
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_2:* = this.dic[param1];
            if (_loc_2.isHorizontal)
            {
                _loc_3 = _loc_2.block.x - _loc_2.dragRec.x;
                if (_loc_3 < 0)
                {
                    _loc_3 = 0;
                }
                _loc_4 = _loc_3 * _loc_2.moveRate;
                _loc_4 = int(_loc_4 / _loc_2.moveDisPerTime + 0.1) * _loc_2.moveDisPerTime;
                _loc_2.moveSpRec.x = _loc_2.maskSp.x - _loc_4;
                trace(_loc_4, "水平");
                _loc_2.moveSp.x = _loc_2.moveSpRec.x + _loc_2.moveSpDis;
                _loc_2.scale = _loc_3 / _loc_2.dragRec.width;
            }
            else
            {
                _loc_3 = _loc_2.block.y - _loc_2.dragRec.y;
                if (_loc_3 < 0)
                {
                    _loc_3 = 0;
                }
                _loc_4 = _loc_3 * _loc_2.moveRate;
                _loc_4 = int(_loc_4 / _loc_2.moveDisPerTime + 0.1) * _loc_2.moveDisPerTime;
                _loc_5 = _loc_2.moveSpRec.y;
                _loc_2.moveSpRec.y = _loc_2.maskSp.y - _loc_4;
                _loc_2.moveSp.y = _loc_2.moveSpRec.y + _loc_2.moveSpDis;
                _loc_2.scale = _loc_3 / _loc_2.dragRec.height;
            }
            return;
        }// end function

        public function unregister(param1:DisplayObject) : void
        {
            param1.removeEventListener(MouseEvent.MOUSE_DOWN, this.onDown);
            if (param1.stage)
            {
                param1.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onUp);
            }
            param1.removeEventListener(Event.ENTER_FRAME, this.onEnter);
            var _loc_2:* = this.dic[param1];
            if (_loc_2)
            {
                if (_loc_2.maskSp.parent)
                {
                    _loc_2.maskSp.parent.removeChild(_loc_2.maskSp);
                }
                if (_loc_2.upArrow)
                {
                    _loc_2.upArrow.removeEventListener(MouseEvent.MOUSE_DOWN, this.onArrowDown);
                    delete this.dic[_loc_2.upArrow];
                }
                if (_loc_2.downArrow)
                {
                    _loc_2.downArrow.removeEventListener(MouseEvent.MOUSE_DOWN, this.onArrowDown);
                    delete this.dic[_loc_2.downArrow];
                }
                if (_loc_2.clickObject)
                {
                    _loc_2.clickObject.removeEventListener(MouseEvent.CLICK, this.onDownArrowClick);
                    delete this.dic[_loc_2.clickObject];
                }
                delete this.dic[param1];
            }
            return;
        }// end function

        public function getBlockObj(param1:DisplayObject) : SliderType
        {
            return this.dic[param1];
        }// end function

        private function onDown(event:Event) : void
        {
            var _loc_2:* = event.currentTarget as Sprite;
            var _loc_3:* = this.dic[_loc_2];
            this.curTarget = _loc_2;
            if (_loc_3.isHorizontal)
            {
                this.curTargetXY = _loc_2.x - _loc_2.parent.mouseX;
            }
            else
            {
                this.curTargetXY = _loc_2.y - _loc_2.parent.mouseY;
            }
            _loc_2.removeEventListener(MouseEvent.MOUSE_DOWN, this.onDown);
            _loc_2.stage.addEventListener(MouseEvent.MOUSE_UP, this.onUp);
            _loc_2.addEventListener(Event.ENTER_FRAME, this.onEnter);
            return;
        }// end function

        private function onEnter(event:Event) : void
        {
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_2:* = event.currentTarget as DisplayObject;
            var _loc_3:* = this.dic[_loc_2];
            if (_loc_3.isHorizontal)
            {
                _loc_4 = _loc_2.parent.mouseX + this.curTargetXY;
                this.updataBlockXy(_loc_2, _loc_4);
            }
            else
            {
                _loc_5 = _loc_2.parent.mouseY + this.curTargetXY;
                this.updataBlockXy(_loc_2, _loc_5);
            }
            return;
        }// end function

        private function onUp(event:Event) : void
        {
            trace("onUP");
            var _loc_2:* = this.curTarget;
            _loc_2.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onUp);
            _loc_2.removeEventListener(Event.ENTER_FRAME, this.onEnter);
            _loc_2.addEventListener(MouseEvent.MOUSE_DOWN, this.onDown);
            return;
        }// end function

        private function onArrowDown(event:MouseEvent) : void
        {
            this.curTarget = event.currentTarget as DisplayObject;
            var _loc_2:* = this.dic[this.curTarget];
            this.preTime = 0;
            this.curTarget.removeEventListener(MouseEvent.MOUSE_DOWN, this.onArrowDown);
            this.curTarget.stage.addEventListener(MouseEvent.MOUSE_UP, this.onArrowUp);
            this.curTarget.addEventListener(Event.ENTER_FRAME, this.onArrowEnterFrame);
            return;
        }// end function

        private function onArrowUp(event:MouseEvent) : void
        {
            this.curTarget.addEventListener(MouseEvent.MOUSE_DOWN, this.onArrowDown);
            this.curTarget.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onArrowUp);
            this.curTarget.removeEventListener(Event.ENTER_FRAME, this.onArrowEnterFrame);
            return;
        }// end function

        private function onArrowEnterFrame(event:Event) : void
        {
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_2:* = event.currentTarget as DisplayObject;
            var _loc_3:* = this.dic[_loc_2];
            if (getTimer() - this.preTime < _loc_3.arrowMoveIntervalTime)
            {
                return;
            }
            this.preTime = getTimer();
            var _loc_4:* = _loc_3.block;
            if (_loc_3.isHorizontal)
            {
                if (_loc_2 == _loc_3.upArrow)
                {
                    _loc_5 = _loc_4.x - _loc_3.arrowMoveIntervalSpeed / _loc_3.moveRate;
                    _loc_5 = Math.floor(_loc_5);
                }
                else if (_loc_2 == _loc_3.downArrow)
                {
                    _loc_5 = _loc_4.x + _loc_3.arrowMoveIntervalSpeed / _loc_3.moveRate;
                    _loc_5 = Math.ceil(_loc_5);
                }
                this.updataBlockXy(_loc_4, _loc_5);
            }
            else
            {
                if (_loc_2 == _loc_3.upArrow)
                {
                    _loc_6 = _loc_4.y - _loc_3.arrowMoveIntervalSpeed / _loc_3.moveRate;
                    _loc_6 = Math.floor(_loc_6);
                }
                else if (_loc_2 == _loc_3.downArrow)
                {
                    _loc_6 = _loc_4.y + _loc_3.arrowMoveIntervalSpeed / _loc_3.moveRate;
                    _loc_6 = Math.ceil(_loc_6);
                }
                this.updataBlockXy(_loc_4, _loc_6);
            }
            return;
        }// end function

        private function onDownArrowClick(event:MouseEvent) : void
        {
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_2:* = event.currentTarget as DisplayObject;
            var _loc_3:* = this.dic[_loc_2];
            var _loc_4:* = _loc_3.block;
            if (!_loc_4.visible)
            {
                return;
            }
            var _loc_5:* = _loc_4.getBounds(_loc_4.parent);
            var _loc_6:* = _loc_3.upArrow.getRect(_loc_4.parent);
            var _loc_7:* = _loc_3.downArrow.getRect(_loc_4.parent);
            if (_loc_3.isHorizontal)
            {
                if (_loc_4.parent.mouseY >= _loc_5.y)
                {
                }
                if (_loc_4.parent.mouseY <= _loc_5.y + _loc_5.height)
                {
                }
                if (_loc_4.parent.mouseX > _loc_6.x + _loc_6.width)
                {
                }
                if (_loc_4.parent.mouseX < _loc_7.x)
                {
                    _loc_8 = _loc_4.parent.mouseX - _loc_5.width * 0.5 + (_loc_4.x - _loc_5.x);
                    this.updataBlockXy(_loc_4, _loc_8);
                }
            }
            else
            {
                if (_loc_4.parent.mouseX >= _loc_5.x)
                {
                }
                if (_loc_4.parent.mouseX <= _loc_5.x + _loc_5.width)
                {
                }
                if (_loc_4.parent.mouseY > _loc_6.y + _loc_6.height)
                {
                }
                if (_loc_4.parent.mouseY < _loc_7.y)
                {
                    _loc_9 = _loc_4.parent.mouseY - _loc_5.height * 0.5 + (_loc_4.y - _loc_5.y);
                    this.updataBlockXy(_loc_4, _loc_9);
                }
            }
            return;
        }// end function

        public function updataBlockXy(param1:DisplayObject, param2:Number) : void
        {
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_3:* = this.dic[param1];
            if (_loc_3.isHorizontal)
            {
                _loc_4 = param2;
                if (_loc_4 < _loc_3.dragRec.x)
                {
                    param1.x = _loc_3.dragRec.x;
                }
                else if (_loc_4 > _loc_3.dragRec.x + _loc_3.dragRec.width)
                {
                    param1.x = _loc_3.dragRec.width + _loc_3.dragRec.x;
                }
                else
                {
                    param1.x = _loc_4;
                }
            }
            else
            {
                _loc_5 = param2;
                if (_loc_5 < _loc_3.dragRec.y)
                {
                    param1.y = _loc_3.dragRec.y;
                }
                else if (_loc_5 > _loc_3.dragRec.y + _loc_3.dragRec.height)
                {
                    param1.y = _loc_3.dragRec.height + _loc_3.dragRec.y;
                }
                else
                {
                    param1.y = _loc_5;
                }
            }
            this.updataForBlock(param1);
            if (_loc_3.fun != null)
            {
                _loc_3.fun();
            }
            return;
        }// end function

        public static function get instance() : SliderManager
        {
            if (_instance == null)
            {
                _instance = new SliderManager;
            }
            return _instance;
        }// end function

    }
}

import flash.display.*;

import flash.events.*;

import flash.geom.*;

import flash.utils.*;

class SliderType extends Object
{
    public var maskSp:Sprite;
    public var moveSp:Sprite;
    public var blockMoveRange:int;
    public var moveDisPerTime:int;
    public var upEdgeDis:int;
    public var downEdgeDis:int;
    public var startXY:int;
    public var fun:Function;
    public var block:DisplayObject;
    public var moveSpRec:Rectangle;
    public var moveSpDis:Number;
    public var isHorizontal:Boolean;
    public var isBlockChange:Boolean;
    public var dragRec:Rectangle;
    public var moveRate:Number;
    public var scale:Number;
    public var upArrow:DisplayObject;
    public var downArrow:DisplayObject;
    public var clickObject:DisplayObject;
    public var arrowMoveIntervalTime:int;
    public var arrowMoveIntervalSpeed:int;

    function SliderType(param1:Boolean) : void
    {
        this.maskSp = new Sprite();
        this.isHorizontal = param1;
        return;
    }// end function

}

