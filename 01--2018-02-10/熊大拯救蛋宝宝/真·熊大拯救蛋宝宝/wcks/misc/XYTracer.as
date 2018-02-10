package wcks.misc
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class XYTracer extends EventDispatcher
    {
        public var tolerance:Number = 10;
        public var loop:Boolean = false;
        public var loopTolerance:Number = 20;
        public var points:Array;
        public var tempPoints:Array;
        public var center:Point;
        public var circleTolerance:Number = 10;
        public var circle:Boolean;
        public var circleRadius:Number = 0;
        public var localTo:DisplayObject;
        public var source:XYSource;
        public static const TEMP_POINT:String = "onTempPoint";
        public static const PERM_POINT:String = "onPermPoint";
        public static const FINISHED:String = "onFinished";

        public function XYTracer(param1:XYSource = null, param2:Number = 5) : void
        {
            this.points = [];
            this.tempPoints = [];
            this.center = new Point();
            if (param1)
            {
                this.source = param1;
                Input.stage.addEventListener(Event.ENTER_FRAME, this.sourceUpdate, false, param2, true);
            }
            return;
        }// end function

        public function sourceUpdate(event:Event) : void
        {
            this.addPoint(this.source.point);
            return;
        }// end function

        public function addPoint(param1:Point, param2:Boolean = true) : Point
        {
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = NaN;
            if (this.localTo)
            {
            }
            if (param2)
            {
                param1 = this.localTo.globalToLocal(param1);
            }
            if (this.points.length == 0)
            {
                this.points.push(param1);
                dispatchEvent(new Event(PERM_POINT));
                this.center.x = param1.x;
                this.center.y = param1.y;
                return param1;
            }
            var _loc_3:* = this.tempPoints.length > 0 ? (this.tempPoints[(this.tempPoints.length - 1)]) : (this.points[(this.points.length - 1)]);
            if (_loc_3.x == param1.x)
            {
            }
            if (_loc_3.y == param1.y)
            {
                return null;
            }
            var _loc_4:* = this.points[(this.points.length - 1)];
            var _loc_5:* = param1.subtract(_loc_4);
            var _loc_6:* = _loc_5.length;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 1;
            while (_loc_10 < this.tempPoints.length)
            {
                
                _loc_11 = this.tempPoints[_loc_10];
                _loc_12 = _loc_4.subtract(_loc_11);
                _loc_13 = Math.abs((_loc_5.x * _loc_12.y - _loc_5.y * _loc_12.x) / _loc_6);
                if (_loc_13 > _loc_8)
                {
                    _loc_7 = _loc_11;
                    _loc_8 = _loc_13;
                    _loc_9 = _loc_10;
                }
                _loc_10 = _loc_10 + 1;
            }
            if (_loc_8 > this.tolerance)
            {
                this.tempPoints = this.tempPoints.slice((_loc_9 + 1));
                this.center.x = (this.center.x * this.points.length + _loc_7.x) / (this.points.length + 1);
                this.center.y = (this.center.y * this.points.length + _loc_7.y) / (this.points.length + 1);
                this.points.push(_loc_7);
                dispatchEvent(new Event(PERM_POINT));
                return _loc_7;
            }
            this.tempPoints.push(param1);
            dispatchEvent(new Event(TEMP_POINT));
            return null;
        }// end function

        public function finish() : Point
        {
            if (this.source)
            {
                Input.stage.removeEventListener(Event.ENTER_FRAME, this.sourceUpdate);
            }
            var _loc_1:* = this.tempPoints[(this.tempPoints.length - 1)];
            var _loc_2:* = null;
            if (_loc_1)
            {
                if (this.loop)
                {
                }
            }
            if (Point.distance(this.points[0], _loc_1) > this.loopTolerance)
            {
                _loc_2 = _loc_1;
                this.center.x = (this.center.x * this.points.length + _loc_1.x) / (this.points.length + 1);
                this.center.y = (this.center.y * this.points.length + _loc_1.y) / (this.points.length + 1);
                this.tempPoints = [];
                this.points.push(_loc_1);
                dispatchEvent(new Event(PERM_POINT));
            }
            this.circle = true;
            var _loc_3:* = [];
            this.circleRadius = 0;
            var _loc_4:* = 0;
            while (_loc_4 < this.points.length)
            {
                
                _loc_3.push(Point.distance(this.points[_loc_4], this.center));
                this.circleRadius = this.circleRadius + _loc_3[_loc_4];
                _loc_4 = _loc_4 + 1;
            }
            this.circleRadius = this.circleRadius / this.points.length;
            _loc_4 = 0;
            while (_loc_4 < this.points.length)
            {
                
                if (Math.abs(this.circleRadius - _loc_3[_loc_4]) > this.circleTolerance)
                {
                    this.circle = false;
                    break;
                }
                _loc_4 = _loc_4 + 1;
            }
            dispatchEvent(new Event(FINISHED));
            return _loc_2;
        }// end function

        public function get path() : GraphicsPath
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_1:* = new GraphicsPath();
            if (this.points.length > 0)
            {
                _loc_2 = this.points[0];
                _loc_1.moveTo(_loc_2.x, _loc_2.y);
                _loc_3 = 1;
                while (_loc_3 < this.points.length)
                {
                    
                    _loc_2 = this.points[_loc_3];
                    _loc_1.lineTo(_loc_2.x, _loc_2.y);
                    _loc_3 = _loc_3 + 1;
                }
                _loc_3 = 0;
                while (_loc_3 < this.tempPoints.length)
                {
                    
                    _loc_2 = this.tempPoints[_loc_3];
                    _loc_1.lineTo(_loc_2.x, _loc_2.y);
                    _loc_3 = _loc_3 + 1;
                }
            }
            return _loc_1;
        }// end function

    }
}
