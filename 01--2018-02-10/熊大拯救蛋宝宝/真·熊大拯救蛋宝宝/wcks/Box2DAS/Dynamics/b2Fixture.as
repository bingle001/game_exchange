package wcks.Box2DAS.Dynamics
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import wcks.Box2DAS.Collision.*;
    import wcks.Box2DAS.Collision.Shapes.*;
    import wcks.Box2DAS.Common.*;
    import wcks.Box2DAS.Dynamics.Contacts.*;

    public class b2Fixture extends b2EventDispatcher
    {
        public var m_userData:Object;
        public var m_body:b2Body;
        public var m_shape:b2Shape;
        public var m_next:b2Fixture;
        public var m_bubbleContacts:Boolean = true;
        public var m_filter:b2Filter;

        public function b2Fixture(param1:b2Body, param2:b2FixtureDef = null, param3:IEventDispatcher = null)
        {
            super(param3);
            if (!param2)
            {
            }
            param2 = b2Def.fixture;
            _ptr = lib.b2Body_CreateFixture(this, param1._ptr, param2._ptr);
            this.m_filter = new b2Filter(_ptr + 36);
            this.m_body = param1;
            var _loc_4:* = getDefinitionByName(getQualifiedClassName(param2._shape)) as Class;
            this.m_shape = new _loc_4(mem._mr32(_ptr + 16));
            this.m_userData = param2.userData;
            this.m_next = param1.m_fixtureList;
            param1.m_fixtureList = this;
            return;
        }// end function

        public function Draw(param1:Graphics, param2:XF, param3:Number = 1) : void
        {
            this.m_shape.Draw(param1, param2, param3);
            return;
        }// end function

        override public function destroy() : void
        {
            var _loc_1:* = null;
            lib.b2Body_DestroyFixture(this.m_body._ptr, _ptr);
            if (this.m_body.m_fixtureList == this)
            {
                this.m_body.m_fixtureList = this.m_next;
            }
            else
            {
                _loc_1 = this.m_body.m_fixtureList;
                while (_loc_1.m_next != this)
                {
                    
                    _loc_1 = _loc_1.m_next;
                }
                _loc_1.m_next = this.m_next;
            }
            super.destroy();
            return;
        }// end function

        public function GetType() : int
        {
            return this.m_shape.GetType();
        }// end function

        public function GetShape() : b2Shape
        {
            return this.m_shape;
        }// end function

        public function IsSensor() : Boolean
        {
            return this.m_isSensor;
        }// end function

        public function SetSensor(param1:Boolean) : void
        {
            this.m_isSensor = param1;
            return;
        }// end function

        public function SetFilterData(param1:Object, param2:Boolean = true) : void
        {
            this.m_filter.filter = param1;
            if (param2)
            {
                this.Refilter();
            }
            return;
        }// end function

        public function Refilter() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (!this.m_body)
            {
                return;
            }
            var _loc_1:* = this.m_body.GetContactList();
            while (_loc_1)
            {
                
                _loc_2 = _loc_1.contact;
                _loc_3 = _loc_2.GetFixtureA();
                _loc_4 = _loc_2.GetFixtureB();
                if (_loc_3 != this)
                {
                }
                if (_loc_4 == this)
                {
                    _loc_2.FlagForFiltering();
                }
                _loc_1 = _loc_1.next;
            }
            return;
        }// end function

        public function GetFilterData() : Object
        {
            return this.m_filter.filter;
        }// end function

        public function GetBody() : b2Body
        {
            return this.m_body;
        }// end function

        public function GetNext() : b2Fixture
        {
            return this.m_next;
        }// end function

        public function GetUserData()
        {
            return this.m_userData;
        }// end function

        public function SetUserData(param1) : void
        {
            this.m_userData = param1;
            return;
        }// end function

        public function TestPoint(param1:V2) : Boolean
        {
            return this.m_shape.TestPoint(this.m_body.GetTransform(), param1);
        }// end function

        public function RayCast() : void
        {
            return;
        }// end function

        public function GetMassData() : b2MassData
        {
            return null;
        }// end function

        public function SetDensity(param1:Number) : void
        {
            this.m_density = param1;
            return;
        }// end function

        public function GetDensity() : Number
        {
            return this.m_density;
        }// end function

        public function GetFriction() : Number
        {
            return this.m_friction;
        }// end function

        public function SetFriction(param1:Number) : void
        {
            this.m_friction = param1;
            return;
        }// end function

        public function GetRestitution() : Number
        {
            return this.m_restitution;
        }// end function

        public function SetRestitution(param1:Number) : void
        {
            this.m_restitution = param1;
            return;
        }// end function

        public function GetDistance(param1:b2Fixture) : V2
        {
            var _loc_2:* = b2Def.distanceInput;
            var _loc_3:* = b2Def.distanceOutput;
            _loc_2.proxyA.Set(this.m_shape);
            _loc_2.proxyB.Set(param1.m_shape);
            _loc_2.transformA.xf = this.m_body.GetTransform();
            _loc_2.transformB.xf = param1.m_body.GetTransform();
            _loc_2.useRadii = true;
            b2Def.simplexCache.count = 0;
            b2Distance();
            return _loc_3.pointB.v2.subtract(_loc_3.pointA.v2);
        }// end function

        public function get m_reportBeginContact() : Boolean
        {
            return mem._mru8(_ptr + 0) == 1;
        }// end function

        public function set m_reportBeginContact(param1:Boolean) : void
        {
            mem._mw8(_ptr + 0, param1 ? (1) : (0));
            return;
        }// end function

        public function get m_reportEndContact() : Boolean
        {
            return mem._mru8((_ptr + 1)) == 1;
        }// end function

        public function set m_reportEndContact(param1:Boolean) : void
        {
            mem._mw8((_ptr + 1), param1 ? (1) : (0));
            return;
        }// end function

        public function get m_reportPreSolve() : Boolean
        {
            return mem._mru8(_ptr + 2) == 1;
        }// end function

        public function set m_reportPreSolve(param1:Boolean) : void
        {
            mem._mw8(_ptr + 2, param1 ? (1) : (0));
            return;
        }// end function

        public function get m_reportPostSolve() : Boolean
        {
            return mem._mru8(_ptr + 3) == 1;
        }// end function

        public function set m_reportPostSolve(param1:Boolean) : void
        {
            mem._mw8(_ptr + 3, param1 ? (1) : (0));
            return;
        }// end function

        public function get m_friction() : Number
        {
            return mem._mrf(_ptr + 20);
        }// end function

        public function set m_friction(param1:Number) : void
        {
            mem._mwf(_ptr + 20, param1);
            return;
        }// end function

        public function get m_restitution() : Number
        {
            return mem._mrf(_ptr + 24);
        }// end function

        public function set m_restitution(param1:Number) : void
        {
            mem._mwf(_ptr + 24, param1);
            return;
        }// end function

        public function get m_proxyId() : int
        {
            return mem._mr32(mem._mr32(_ptr + 28) + 24);
        }// end function

        public function set m_proxyId(param1:int) : void
        {
            mem._mw32(mem._mr32(_ptr + 28) + 24, param1);
            return;
        }// end function

        public function get m_aabb() : b2AABB
        {
            return new b2AABB(mem._mr32(_ptr + 28));
        }// end function

        public function get m_isSensor() : Boolean
        {
            return mem._mru8(_ptr + 42) == 1;
        }// end function

        public function set m_isSensor(param1:Boolean) : void
        {
            mem._mw8(_ptr + 42, param1 ? (1) : (0));
            return;
        }// end function

        public function get m_density() : Number
        {
            return mem._mrf(_ptr + 4);
        }// end function

        public function set m_density(param1:Number) : void
        {
            mem._mwf(_ptr + 4, param1);
            return;
        }// end function

        public function get m_conveyorBeltSpeed() : Number
        {
            return mem._mrf(_ptr + 48);
        }// end function

        public function set m_conveyorBeltSpeed(param1:Number) : void
        {
            mem._mwf(_ptr + 48, param1);
            return;
        }// end function

    }
}
