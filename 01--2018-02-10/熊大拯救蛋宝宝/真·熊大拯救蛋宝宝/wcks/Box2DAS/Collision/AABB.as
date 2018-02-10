package wcks.Box2DAS.Collision
{
    import wcks.Box2DAS.Common.*;

    public class AABB extends Object
    {
        public var lowerBound:V2;
        public var upperBound:V2;

        public function AABB(param1:V2 = null, param2:V2 = null)
        {
            this.lowerBound = new V2();
            this.upperBound = new V2();
            if (param1)
            {
                this.lowerBound.xy(param1.x, param1.y);
            }
            if (param2)
            {
                this.upperBound.xy(param2.x, param2.y);
            }
            return;
        }// end function

        public function get width() : Number
        {
            return this.upperBound.x - this.lowerBound.x;
        }// end function

        public function get height() : Number
        {
            return this.upperBound.y - this.lowerBound.y;
        }// end function

        public function IsValid() : Boolean
        {
            var _loc_1:* = V2.subtract(this.upperBound, this.lowerBound);
            if (_loc_1.x > 0)
            {
            }
            return _loc_1.y > 0;
        }// end function

        public function getCenter() : V2
        {
            return V2.add(this.lowerBound, this.upperBound).divideN(2);
        }// end function

        public function GetExtents() : V2
        {
            return V2.subtract(this.upperBound, this.lowerBound).divideN(2);
        }// end function

        public function Combine(param1:AABB, param2:AABB) : void
        {
            this.lowerBound = V2.min(param1.lowerBound, param2.lowerBound);
            this.upperBound = V2.max(param1.upperBound, param2.upperBound);
            return;
        }// end function

        public function Contains(param1:AABB) : Boolean
        {
            if (this.lowerBound.x <= param1.lowerBound.x)
            {
            }
            if (this.lowerBound.y <= param1.lowerBound.y)
            {
            }
            if (param1.upperBound.x <= this.upperBound.x)
            {
            }
            return param1.upperBound.y <= this.upperBound.y;
        }// end function

        public function Expand(param1:Number) : void
        {
            this.lowerBound.subtractN(param1);
            this.upperBound.addN(param1);
            return;
        }// end function

        public function toString() : String
        {
            return "<AABB <" + this.lowerBound.x + ", " + this.lowerBound.y + ">, <" + this.upperBound.x + ", " + this.upperBound.y + ">>";
        }// end function

        public static function FromV2(param1:V2, param2:Number = 0.001, param3:Number = 0.001) : AABB
        {
            return new AABB(new V2(param1.x - param2, param1.y - param3), new V2(param1.x + param2, param1.y + param3));
        }// end function

    }
}
