package wcks.Box2DAS.Common
{
    import flash.geom.*;

    public class V2 extends Object
    {
        public var x:Number;
        public var y:Number;

        public function V2(param1:Number = 0, param2:Number = 0)
        {
            this.x = param1;
            this.y = param2;
            return;
        }// end function

        public function toString() : String
        {
            return "<" + this.x + ", " + this.y + ">";
        }// end function

        public function toP() : Point
        {
            return new Point(this.x, this.y);
        }// end function

        public function clone() : V2
        {
            return new V2(this.x, this.y);
        }// end function

        public function copy(param1:V2) : V2
        {
            this.x = param1.x;
            this.y = param1.y;
            return this;
        }// end function

        public function equals(param1:V2) : Boolean
        {
            if (this.x == param1.x)
            {
            }
            return this.y == param1.y;
        }// end function

        public function zero() : V2
        {
            this.x = 0;
            this.y = 0;
            return this;
        }// end function

        public function isZero() : Boolean
        {
            if (this.x == 0)
            {
            }
            return this.y == 0;
        }// end function

        public function xy(param1:Number, param2:Number) : V2
        {
            this.x = param1;
            this.y = param2;
            return this;
        }// end function

        public function add(param1:V2) : V2
        {
            this.x = this.x + param1.x;
            this.y = this.y + param1.y;
            return this;
        }// end function

        public function subtract(param1:V2) : V2
        {
            this.x = this.x - param1.x;
            this.y = this.y - param1.y;
            return this;
        }// end function

        public function addN(param1:Number) : V2
        {
            this.x = this.x + param1;
            this.y = this.y + param1;
            return this;
        }// end function

        public function subtractN(param1:Number) : V2
        {
            this.x = this.x - param1;
            this.y = this.y - param1;
            return this;
        }// end function

        public function multiply(param1:V2) : V2
        {
            this.x = this.x * param1.x;
            this.y = this.y * param1.y;
            return this;
        }// end function

        public function multiplyN(param1:Number) : V2
        {
            this.x = this.x * param1;
            this.y = this.y * param1;
            return this;
        }// end function

        public function divide(param1:V2) : V2
        {
            this.x = this.x / param1.x;
            this.y = this.y / param1.y;
            return this;
        }// end function

        public function divideN(param1:Number) : V2
        {
            this.x = this.x / param1;
            this.y = this.y / param1;
            return this;
        }// end function

        public function length() : Number
        {
            return Math.sqrt(this.x * this.x + this.y * this.y);
        }// end function

        public function lengthSquared() : Number
        {
            return this.x * this.x + this.y * this.y;
        }// end function

        public function distance(param1:V2) : Number
        {
            return subtract(this, param1).length();
        }// end function

        public function distanceSquared(param1:V2) : Number
        {
            return subtract(this, param1).lengthSquared();
        }// end function

        public function normalize(param1:Number = 1) : V2
        {
            var _loc_2:* = this.length();
            this.x = this.x * (param1 / _loc_2);
            this.y = this.y * (param1 / _loc_2);
            return this;
        }// end function

        public function dot(param1:V2) : Number
        {
            return this.x * param1.x + this.y * param1.y;
        }// end function

        public function perpDot(param1:V2) : Number
        {
            return (-this.y) * param1.x + this.x * param1.y;
        }// end function

        public function winding(param1:V2, param2:V2) : Number
        {
            return subtract(param1, this).perpDot(subtract(param2, param1));
        }// end function

        public function cross(param1:V2) : Number
        {
            return this.x * param1.y - this.y * param1.x;
        }// end function

        public function rotate(param1:Number) : V2
        {
            var _loc_2:* = Math.cos(param1);
            var _loc_3:* = Math.sin(param1);
            this.xy(this.x * _loc_2 - this.y * _loc_3, this.x * _loc_3 + this.y * _loc_2);
            return this;
        }// end function

        public function abs() : V2
        {
            this.x = Math.abs(this.x);
            this.y = Math.abs(this.y);
            return this;
        }// end function

        public function angle() : Number
        {
            return Math.atan2(this.y, this.x);
        }// end function

        public function sign() : V2
        {
            this.x = this.x > 0 ? (1) : (this.x < 0 ? (-1) : (0));
            this.y = this.y > 0 ? (1) : (this.y < 0 ? (-1) : (0));
            return this;
        }// end function

        public function flip() : V2
        {
            return this.xy(this.y, this.x);
        }// end function

        public function cw90() : V2
        {
            return this.xy(this.y, -this.x);
        }// end function

        public function ccw90() : V2
        {
            return this.xy(-this.y, this.x);
        }// end function

        public function min(param1:V2) : V2
        {
            this.x = Math.min(this.x, param1.x);
            this.y = Math.min(this.y, param1.y);
            return this;
        }// end function

        public function max(param1:V2) : V2
        {
            this.x = Math.max(this.x, param1.x);
            this.y = Math.max(this.y, param1.y);
            return this;
        }// end function

        public function invert() : V2
        {
            return this.multiplyN(-1);
        }// end function

        public static function fromP(param1:Point) : V2
        {
            return new V2(param1.x, param1.y);
        }// end function

        public static function add(param1:V2, param2:V2) : V2
        {
            return new V2(param1.x + param2.x, param1.y + param2.y);
        }// end function

        public static function subtract(param1:V2, param2:V2) : V2
        {
            return new V2(param1.x - param2.x, param1.y - param2.y);
        }// end function

        public static function addN(param1:V2, param2:Number) : V2
        {
            return new V2(param1.x + param2, param1.y + param2);
        }// end function

        public static function subtractN(param1:V2, param2:Number) : V2
        {
            return new V2(param1.x - param2, param1.y - param2);
        }// end function

        public static function multiply(param1:V2, param2:V2) : V2
        {
            return new V2(param1.x * param2.x, param1.y * param2.y);
        }// end function

        public static function multiplyN(param1:V2, param2:Number) : V2
        {
            return new V2(param1.x * param2, param1.y * param2);
        }// end function

        public static function divide(param1:V2, param2:V2) : V2
        {
            return new V2(param1.x / param2.x, param1.y / param2.y);
        }// end function

        public static function divideN(param1:V2, param2:Number) : V2
        {
            return new V2(param1.x / param2, param1.y / param2);
        }// end function

        public static function normalize(param1:V2, param2:Number = 1) : V2
        {
            var _loc_3:* = param1.clone();
            _loc_3.normalize(param2);
            return _loc_3;
        }// end function

        public static function crossVN(param1:V2, param2:Number) : V2
        {
            return new V2(param2 * param1.y, (-param2) * param1.x);
        }// end function

        public static function crossNV(param1:Number, param2:V2) : V2
        {
            return new V2((-param1) * param2.y, param1 * param2.x);
        }// end function

        public static function rotate(param1:V2, param2:Number) : V2
        {
            return param1.clone().rotate(param2);
        }// end function

        public static function abs(param1:V2) : V2
        {
            return param1.clone().abs();
        }// end function

        public static function sign(param1:V2) : V2
        {
            return param1.clone().sign();
        }// end function

        public static function flip(param1:V2) : V2
        {
            return new V2(param1.y, param1.x);
        }// end function

        public static function cw90(param1:V2) : V2
        {
            return new V2(param1.y, -param1.x);
        }// end function

        public static function ccw90(param1:V2) : V2
        {
            return new V2(-param1.y, param1.x);
        }// end function

        public static function min(param1:V2, param2:V2) : V2
        {
            return param1.clone().min(param2);
        }// end function

        public static function max(param1:V2, param2:V2) : V2
        {
            return param1.clone().max(param2);
        }// end function

        public static function invert(param1:V2) : V2
        {
            return new V2(-param1.x, -param1.y);
        }// end function

    }
}
