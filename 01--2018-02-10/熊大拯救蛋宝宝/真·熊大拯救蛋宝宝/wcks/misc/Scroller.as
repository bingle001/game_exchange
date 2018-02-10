package wcks.misc
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class Scroller extends Entity
    {
        public var focusOn:String = "";
        public var mouseNudgeX:Number = 0;
        public var mouseNudgeY:Number = 0;
        public var scrolling:Boolean = false;
        public var focus:DisplayObject = null;
        public var localPos:Point = null;
        public var pos:Point;
        public var rot:Number = 0;
        public var tFunc:Function;
        public var tFrames:int;
        public var tFramesTot:int;
        public var tPos:Point;
        public var tRot:Number;
        public var tMX:Number;
        public var tMY:Number;
        public var shake:Point;

        public function Scroller()
        {
            this.pos = new Point(0, 0);
            return;
        }// end function

        override public function create() : void
        {
            if (!this.focus)
            {
            }
            if (this.focusOn != "")
            {
                this.focus = Util.getDisplayObjectByPath(this, this.focusOn);
            }
            this.pos = globalToLocal(new Point(stage.stageWidth / 2, stage.stageHeight / 2));
            this.rot = rotation;
            super.create();
            if (this.scrolling)
            {
                listenWhileVisible(stage, Event.ENTER_FRAME, this.updateScroll, false, -9999);
            }
            return;
        }// end function

        public function updateScroll(event:Event = null) : void
        {
            var _loc_2:* = null;
            if (this.focus)
            {
                this.pos = Util.localizePoint(this, this.focus, this.localPos);
            }
            _loc_2 = this.pos.clone();
            this.rot = this.scrollRotation();
            var _loc_3:* = this.rot;
            if (this.tFunc != null)
            {
                var _loc_4:* = this;
                _loc_4.tFrames = this.tFrames + 1;
                if (++this.tFrames == this.tFramesTot)
                {
                    this.tFunc = null;
                }
                else
                {
                    _loc_3 = this.tFunc(this.tFrames, this.tRot, Util.findBetterAngleTarget(this.tRot, _loc_3) - this.tRot, this.tFramesTot);
                    _loc_2.x = this.tFunc(this.tFrames, this.tPos.x, _loc_2.x - this.tPos.x, this.tFramesTot);
                    _loc_2.y = this.tFunc(this.tFrames, this.tPos.y, _loc_2.y - this.tPos.y, this.tFramesTot);
                }
            }
            rotation = _loc_3;
            x = 0;
            y = 0;
            _loc_2 = localToGlobal(_loc_2);
            x = stage.stageWidth / 2 - _loc_2.x;
            y = stage.stageHeight / 2 - _loc_2.y;
            if (Input.mouseDetected)
            {
                x = x + (stage.stageWidth / 2 - Input.mousePos.x) * (this.tFunc != null ? (this.tFunc(this.tFrames, this.tMX, this.mouseNudgeX - this.tMX, this.tFramesTot)) : (this.mouseNudgeX));
                y = y + (stage.stageHeight / 2 - Input.mousePos.y) * (this.tFunc != null ? (this.tFunc(this.tFrames, this.tMY, this.mouseNudgeY - this.tMY, this.tFramesTot)) : (this.mouseNudgeY));
            }
            if (this.shake)
            {
                x = x + this.shake.x;
                y = y + this.shake.y;
                this.shake.normalize(this.shake.length * -0.5);
                if (this.shake.length < 1)
                {
                    this.shake = null;
                }
            }
            return;
        }// end function

        public function scrollRotation() : Number
        {
            return this.rot;
        }// end function

        public function startFocusTween(param1:uint = 30, param2:Function = null) : void
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            if (param2 == null)
            {
                param2 = Util.linearEase;
            }
            if (this.tFunc != null)
            {
                this.tRot = this.tFunc(this.tFrames, this.tRot, Util.findBetterAngleTarget(this.tRot, this.rot) - this.tRot, this.tFramesTot);
                _loc_3 = this.tFunc(this.tFrames, this.tPos.x, this.pos.x - this.tPos.x, this.tFramesTot);
                _loc_4 = this.tFunc(this.tFrames, this.tPos.y, this.pos.y - this.tPos.y, this.tFramesTot);
                this.tPos = new Point(_loc_3, _loc_4);
                this.tMX = this.tFunc(this.tFrames, this.tMX, this.mouseNudgeX - this.tMX, this.tFramesTot);
                this.tMY = this.tFunc(this.tFrames, this.tMY, this.mouseNudgeY - this.tMY, this.tFramesTot);
            }
            else
            {
                this.tPos = this.pos.clone();
                this.tRot = this.rot;
                this.tMX = this.mouseNudgeX;
                this.tMY = this.mouseNudgeY;
            }
            this.tFramesTot = param1;
            this.tFrames = 0;
            this.tFunc = param2;
            return;
        }// end function

    }
}
