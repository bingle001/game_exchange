package wcks.Box2DAS.Collision.Shapes
{
    import flash.display.*;
    import wcks.Box2DAS.Collision.*;
    import wcks.Box2DAS.Common.*;
    import wcks.Box2DAS.Dynamics.*;

    public class b2Shape extends b2Base
    {
        public static const e_unknown:int = -1;
        public static const e_circle:int = 0;
        public static const e_edge:int = 1;
        public static const e_polygon:int = 2;
        public static const e_loop:int = 3;
        public static const e_typeCount:int = 4;

        public function b2Shape()
        {
            return;
        }// end function

        public function GetType() : int
        {
            return this.m_type;
        }// end function

        public function create(param1:b2Body, param2:b2FixtureDef = null) : b2Fixture
        {
            if (!param2)
            {
            }
            param2 = b2Def.fixture;
            param2.shape = this;
            return new b2Fixture(param1, param2);
        }// end function

        public function Draw(param1:Graphics, param2:XF, param3:Number = 1, param4:Object = null) : void
        {
            return;
        }// end function

        public function TestPoint(param1:XF, param2:V2) : Boolean
        {
            return false;
        }// end function

        public function RayCast(param1, param2, param3:XF) : Boolean
        {
            return false;
        }// end function

        public function ComputeAABB(param1:AABB, param2:XF) : void
        {
            return;
        }// end function

        public function ComputeMass(param1:b2MassData, param2:Number) : void
        {
            return;
        }// end function

        public function ComputeSubmergedArea(param1:V2, param2:Number, param3:XF, param4:V2) : Number
        {
            return 0;
        }// end function

        public function get m_type() : int
        {
            return mem._mrs8(_ptr + 4);
        }// end function

        public function set m_type(param1:int) : void
        {
            mem._mw8(_ptr + 4, param1);
            return;
        }// end function

        public function get m_radius() : Number
        {
            return mem._mrf(_ptr + 8);
        }// end function

        public function set m_radius(param1:Number) : void
        {
            mem._mwf(_ptr + 8, param1);
            return;
        }// end function

        public function get m_area() : Number
        {
            return mem._mrf(_ptr + 12);
        }// end function

        public function set m_area(param1:Number) : void
        {
            mem._mwf(_ptr + 12, param1);
            return;
        }// end function

    }
}
