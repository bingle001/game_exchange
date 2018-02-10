package wcks.misc
{
    import flash.events.*;
    import flash.geom.*;

    public class Parallax extends Entity
    {
        public var factorX:Number = 0.5;
        private var _rateX:Number = 0.5;
        private var _rateY:Number = 0.5;
        public var factorY:Number = 0.5;
        public var parentInitPos:Point;
        public var initPos:Point;
        public var offset:Point;

        public function Parallax()
        {
            return;
        }// end function

        public function get rateY() : Number
        {
            return this._rateY;
        }// end function

        public function set rateY(param1:Number) : void
        {
            this._rateY = param1;
            if (param1 >= 0)
            {
                this.factorY = 1 - param1;
            }
            else
            {
                this.factorY = -1 - param1;
            }
            return;
        }// end function

        public function get rateX() : Number
        {
            return this._rateX;
        }// end function

        public function set rateX(param1:Number) : void
        {
            this._rateX = param1;
            if (param1 >= 0)
            {
                this.factorX = 1 - param1;
            }
            else
            {
                this.factorX = -1 - param1;
            }
            return;
        }// end function

        override public function create() : void
        {
            this.offset = new Point(x, y);
            this.initPos = parent.localToGlobal(new Point(0, 0));
            this.parentInitPos = new Point(parent.x, parent.y);
            listenWhileVisible(stage, Event.ENTER_FRAME, this.update, false, -99999);
            return;
        }// end function

        public function update(event:Event) : void
        {
            var _loc_2:* = null;
            _loc_2 = parent.globalToLocal(this.initPos);
            x = _loc_2.x * this.factorX + this.offset.x;
            y = _loc_2.y * this.factorY + this.offset.y;
            return;
        }// end function

    }
}
