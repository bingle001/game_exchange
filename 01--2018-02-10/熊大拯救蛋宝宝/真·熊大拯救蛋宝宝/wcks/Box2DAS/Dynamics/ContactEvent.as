package wcks.Box2DAS.Dynamics
{
    import flash.events.*;
    import wcks.Box2DAS.Collision.*;
    import wcks.Box2DAS.Common.*;
    import wcks.Box2DAS.Dynamics.Contacts.*;

    public class ContactEvent extends Event
    {
        public var userData:Object;
        public var world:b2World;
        public var contact:b2Contact;
        public var fixture:b2Fixture;
        public var other:b2Fixture;
        public var relatedObject:Object;
        public var worldManifold:b2WorldManifold;
        public var worldManifoldTime:int;
        public var oldManifold:b2Manifold;
        public var impulses:b2ContactImpulse;
        public var bias:int;
        public static var BEGIN_CONTACT:String = "onBeginContact";
        public static var END_CONTACT:String = "onEndContact";
        public static var PRE_SOLVE:String = "onPreSolve";
        public static var POST_SOLVE:String = "onPostSolve";

        public function ContactEvent(param1:String, param2:b2Contact, param3:int, param4:b2Manifold = null, param5:b2ContactImpulse = null)
        {
            this.worldManifold = new b2WorldManifold();
            this.world = param2.m_fixtureA.m_body.m_world;
            this.contact = param2;
            this.bias = param3;
            this.oldManifold = param4;
            this.impulses = param5;
            if (param3 == 1)
            {
                this.fixture = param2.m_fixtureA;
                this.other = param2.m_fixtureB;
            }
            else
            {
                this.fixture = param2.m_fixtureB;
                this.other = param2.m_fixtureA;
            }
            this.relatedObject = this.other.m_userData;
            super(param1, this.fixture.m_bubbleContacts, true);
            return;
        }// end function

        override public function clone() : Event
        {
            return new ContactEvent(type, this.contact, this.bias, this.oldManifold, this.impulses);
        }// end function

        override public function preventDefault() : void
        {
            super.preventDefault();
            this.contact.SetEnabled(false);
            return;
        }// end function

        public function isSolid() : Boolean
        {
            return this.contact.IsSolid();
        }// end function

        public function get normal() : V2
        {
            return this.getWorldManifold().normal;
        }// end function

        public function get point() : V2
        {
            return this.getWorldManifold().GetPoint();
        }// end function

        public function get pointCount() : uint
        {
            return this.contact.m_manifold.pointCount;
        }// end function

        public function applyImpulse(param1:Number, param2:Number = 0) : void
        {
            var _loc_3:* = this.getWorldManifold();
            var _loc_4:* = this.other.m_body;
            var _loc_5:* = V2.multiplyN(_loc_3.normal, param1 + _loc_4.GetMass() * param2);
            _loc_4.ApplyImpulse(_loc_5, _loc_3.GetPoint());
            return;
        }// end function

        public function applyForce(param1:Number, param2:Number = 0, param3:Boolean = false) : void
        {
            var _loc_4:* = this.getWorldManifold();
            var _loc_5:* = this.other.m_body;
            var _loc_6:* = V2.multiplyN(_loc_4.normal, param1 + _loc_5.GetMass() * param2);
            _loc_5.ApplyForce(_loc_6, _loc_4.GetPoint());
            if (param3)
            {
                this.fixture.m_body.ApplyForce(_loc_6.multiplyN(-1), _loc_4.GetPoint());
            }
            return;
        }// end function

        public function getWorldManifold() : b2WorldManifold
        {
            if (!this.world.IsLocked())
            {
            }
            if (this.worldManifoldTime == this.world.stepTime)
            {
                return this.worldManifold;
            }
            this.worldManifoldTime = this.world.stepTime;
            this.worldManifold = new b2WorldManifold();
            this.contact.GetWorldManifold(this.worldManifold);
            if (this.worldManifold.normal)
            {
                this.worldManifold.normal.multiplyN(this.bias);
            }
            return this.worldManifold;
        }// end function

        public function update() : void
        {
            this.contact.Update();
            return;
        }// end function

    }
}
