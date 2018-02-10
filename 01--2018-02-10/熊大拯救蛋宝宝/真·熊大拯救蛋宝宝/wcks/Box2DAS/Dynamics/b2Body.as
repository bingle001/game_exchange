package wcks.Box2DAS.Dynamics
{
    import flash.utils.*;
    import wcks.Box2DAS.Collision.Shapes.*;
    import wcks.Box2DAS.Common.*;
    import wcks.Box2DAS.Controllers.*;
    import wcks.Box2DAS.Dynamics.Contacts.*;
    import wcks.Box2DAS.Dynamics.Joints.*;

    public class b2Body extends b2Base
    {
        public var m_controllers:Dictionary;
        public var m_userData:Object;
        public var m_next:b2Body;
        public var m_prev:b2Body;
        public var m_world:b2World;
        public var m_fixtureList:b2Fixture;
        public var m_xf:b2Transform;
        public var m_sweep:b2Sweep;
        public var m_linearVelocity:b2Vec2;
        public var m_force:b2Vec2;
        public static const e_islandFlag:int = 1;
        public static const e_awakeFlag:int = 2;
        public static const e_autoSleepFlag:int = 4;
        public static const e_bulletFlag:int = 8;
        public static const e_fixedRotationFlag:int = 16;
        public static const e_activeFlag:int = 32;
        public static const b2_staticBody:int = 0;
        public static const b2_kinematicBody:int = 1;
        public static const b2_dynamicBody:int = 2;

        public function b2Body(param1:b2World, param2:b2BodyDef = null)
        {
            this.m_controllers = new Dictionary();
            if (!param2)
            {
            }
            param2 = b2Def.body;
            _ptr = lib.b2World_CreateBody(this, param1._ptr, param2._ptr);
            this.m_xf = new b2Transform(_ptr + 12);
            this.m_sweep = new b2Sweep(_ptr + 36);
            this.m_linearVelocity = new b2Vec2(_ptr + 72);
            this.m_force = new b2Vec2(_ptr + 84);
            this.m_userData = param2.userData;
            this.m_next = param1.m_bodyList;
            if (this.m_next)
            {
                this.m_next.m_prev = this;
            }
            param1.m_bodyList = this;
            this.m_world = param1;
            return;
        }// end function

        public function IsStatic() : Boolean
        {
            return this.m_type == b2Body.b2_staticBody;
        }// end function

        public function IsDynamic() : Boolean
        {
            return this.m_type == b2Body.b2_dynamicBody;
        }// end function

        public function IsKinematic() : Boolean
        {
            return this.m_type == b2Body.b2_kinematicBody;
        }// end function

        public function SetType(param1:int) : void
        {
            lib.b2Body_SetType(_ptr, param1);
            return;
        }// end function

        public function GetType() : int
        {
            return this.m_type;
        }// end function

        override public function destroy() : void
        {
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_1:* = this.GetJointList();
            while (_loc_1)
            {
                
                _loc_4 = _loc_1.joint;
                this.m_world.SayGoodbyeJoint(_loc_4);
                _loc_4._ptr = 0;
                if (_loc_4.m_prev)
                {
                    _loc_4.m_prev.m_next = _loc_4.m_next;
                }
                if (_loc_4.m_next)
                {
                    _loc_4.m_next.m_prev = _loc_4.m_prev;
                }
                if (this.m_world.m_jointList == _loc_4)
                {
                    this.m_world.m_jointList = _loc_4.m_next;
                }
                _loc_1 = _loc_1.next;
            }
            var _loc_2:* = this.m_fixtureList;
            while (_loc_2)
            {
                
                this.m_world.SayGoodbyeFixture(_loc_2);
                _loc_2.m_shape._ptr = 0;
                _loc_2._ptr = 0;
                _loc_2 = _loc_2.m_next;
            }
            for (_loc_3 in this.m_controllers)
            {
                
                (_loc_3 as b2Controller).RemoveBody(this);
            }
            lib.b2World_DestroyBody(this.m_world._ptr, _ptr);
            if (this.m_prev)
            {
                this.m_prev.m_next = this.m_next;
            }
            else
            {
                this.m_world.m_bodyList = this.m_next;
            }
            if (this.m_next)
            {
                this.m_next.m_prev = this.m_prev;
            }
            super.destroy();
            return;
        }// end function

        public function CreateFixture(param1:b2FixtureDef) : b2Fixture
        {
            return new b2Fixture(this, param1);
        }// end function

        public function CreateFixtureShape(param1:b2Shape, param2:Number) : b2Fixture
        {
            var _loc_3:* = new b2FixtureDef();
            _loc_3.shape = param1;
            _loc_3.density = param2;
            return this.CreateFixture(_loc_3);
        }// end function

        public function DestroyFixture(param1:b2Fixture) : void
        {
            param1.destroy();
            return;
        }// end function

        public function SetTransform(param1:V2, param2:Number) : void
        {
            lib.b2Body_SetTransform(_ptr, param1.x, param1.y, param2);
            return;
        }// end function

        public function GetTransform() : XF
        {
            return this.m_xf.xf;
        }// end function

        public function GetPosition() : V2
        {
            return this.m_xf.position.v2;
        }// end function

        public function GetAngle() : Number
        {
            return this.m_sweep.a;
        }// end function

        public function GetWorldCenter() : V2
        {
            return this.m_sweep.c.v2;
        }// end function

        public function GetLocalCenter() : V2
        {
            return this.m_sweep.localCenter.v2;
        }// end function

        public function SetLinearVelocity(param1:V2) : void
        {
            this.m_linearVelocity.v2 = param1;
            return;
        }// end function

        public function GetLinearVelocity() : V2
        {
            return this.m_linearVelocity.v2;
        }// end function

        public function SetAngularVelocity(param1:Number) : void
        {
            this.m_angularVelocity = param1;
            return;
        }// end function

        public function GetAngularVelocity() : Number
        {
            return this.m_angularVelocity;
        }// end function

        public function ApplyForce(param1:V2, param2:V2) : void
        {
            this.SetAwake(true);
            this.m_force.x = this.m_force.x + param1.x;
            this.m_force.y = this.m_force.y + param1.y;
            this.m_torque = this.m_torque + V2.subtract(param2, this.m_sweep.c.v2).cross(param1);
            return;
        }// end function

        public function ApplyTorque(param1:Number) : void
        {
            this.SetAwake(true);
            this.m_torque = this.m_torque + param1;
            return;
        }// end function

        public function ApplyImpulse(param1:V2, param2:V2) : void
        {
            this.SetAwake(true);
            this.m_linearVelocity.x = this.m_linearVelocity.x + this.m_invMass * param1.x;
            this.m_linearVelocity.y = this.m_linearVelocity.y + this.m_invMass * param1.y;
            this.m_angularVelocity = this.m_angularVelocity + this.m_invI * V2.subtract(param2, this.m_sweep.c.v2).cross(param1);
            return;
        }// end function

        public function GetMass() : Number
        {
            return this.m_mass;
        }// end function

        public function GetInertia() : Number
        {
            return this.m_I;
        }// end function

        public function GetMassData(param1:b2MassData) : void
        {
            lib.b2Body_GetMassData(_ptr, param1._ptr);
            return;
        }// end function

        public function SetMassData(param1:b2MassData) : void
        {
            lib.b2Body_SetMassData(_ptr, param1._ptr);
            return;
        }// end function

        public function ResetMassData() : void
        {
            lib.b2Body_ResetMassData(_ptr);
            return;
        }// end function

        public function GetWorldPoint(param1:V2) : V2
        {
            return this.m_xf.xf.multiply(param1);
        }// end function

        public function GetWorldVector(param1:V2) : V2
        {
            return this.m_xf.R.m22.multiplyV(param1);
        }// end function

        public function GetLocalPoint(param1:V2) : V2
        {
            return this.m_xf.xf.multiplyT(param1);
        }// end function

        public function GetLocalVector(param1:V2) : V2
        {
            return this.m_xf.R.m22.multiplyVT(param1);
        }// end function

        public function GetLinearVelocityFromWorldPoint(param1:V2) : V2
        {
            return this.m_linearVelocity.v2.add(V2.crossNV(this.m_angularVelocity, V2.subtract(param1, this.m_sweep.c.v2)));
        }// end function

        public function GetLinearVelocityFromLocalPoint(param1:V2) : V2
        {
            return this.GetLinearVelocityFromWorldPoint(this.GetWorldPoint(param1));
        }// end function

        public function GetLinearDamping() : Number
        {
            return this.m_linearDamping;
        }// end function

        public function SetLinearDamping(param1:Number) : void
        {
            this.m_linearDamping = param1;
            return;
        }// end function

        public function GetAngularDamping() : Number
        {
            return this.m_angularDamping;
        }// end function

        public function SetAngularDamping(param1:Number) : void
        {
            this.m_angularDamping = param1;
            return;
        }// end function

        public function SetBullet(param1:Boolean) : void
        {
            if (param1)
            {
                this.m_flags = this.m_flags | e_bulletFlag;
            }
            else
            {
                this.m_flags = this.m_flags & ~e_bulletFlag;
            }
            return;
        }// end function

        public function IsBullet() : Boolean
        {
            return (this.m_flags & e_bulletFlag) == e_bulletFlag;
        }// end function

        public function SetSleepingAllowed(param1:Boolean) : void
        {
            if (param1)
            {
                this.m_flags = this.m_flags | e_autoSleepFlag;
            }
            else
            {
                this.m_flags = this.m_flags & ~e_autoSleepFlag;
                this.SetAwake(true);
            }
            return;
        }// end function

        public function IsSleepingAllowed() : Boolean
        {
            return (this.m_flags & e_autoSleepFlag) == e_autoSleepFlag;
        }// end function

        public function SetAwake(param1:Boolean) : void
        {
            if (param1)
            {
                this.m_flags = this.m_flags | e_awakeFlag;
                this.m_sleepTime = 0;
            }
            else
            {
                this.m_flags = this.m_flags & ~e_awakeFlag;
                this.m_sleepTime = 0;
                this.m_linearVelocity.x = 0;
                this.m_linearVelocity.y = 0;
                this.m_force.x = 0;
                this.m_force.y = 0;
                this.m_torque = 0;
            }
            return;
        }// end function

        public function IsAwake() : Boolean
        {
            return (this.m_flags & e_awakeFlag) == e_awakeFlag;
        }// end function

        public function SetActive(param1:Boolean) : void
        {
            lib.b2Body_SetActive(_ptr, param1);
            return;
        }// end function

        public function IsActive() : Boolean
        {
            return (this.m_flags & e_activeFlag) == e_activeFlag;
        }// end function

        public function SetFixedRotation(param1:Boolean) : void
        {
            if (param1)
            {
                this.m_flags = this.m_flags | e_fixedRotationFlag;
            }
            else
            {
                this.m_flags = this.m_flags & ~e_fixedRotationFlag;
            }
            this.ResetMassData();
            return;
        }// end function

        public function IsFixedRotation() : Boolean
        {
            return (this.m_flags & e_fixedRotationFlag) == e_fixedRotationFlag;
        }// end function

        public function GetFixtureList() : b2Fixture
        {
            return this.m_fixtureList;
        }// end function

        public function GetJointList() : b2JointEdge
        {
            var _loc_1:* = mem._mr32(_ptr + 116);
            return _loc_1 ? (new b2JointEdge(_loc_1)) : (null);
        }// end function

        public function GetContactList() : b2ContactEdge
        {
            var _loc_1:* = mem._mr32(_ptr + 120);
            return _loc_1 ? (new b2ContactEdge(_loc_1)) : (null);
        }// end function

        public function GetNext() : b2Body
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

        public function GetWorld() : b2World
        {
            return this.m_world;
        }// end function

        public function get m_flags() : int
        {
            return mem._mru16(_ptr + 4);
        }// end function

        public function set m_flags(param1:int) : void
        {
            mem._mw16(_ptr + 4, param1);
            return;
        }// end function

        public function get m_type() : int
        {
            return mem._mrs16(_ptr + 0);
        }// end function

        public function set m_type(param1:int) : void
        {
            mem._mw16(_ptr + 0, param1);
            return;
        }// end function

        public function get m_islandIndex() : int
        {
            return mem._mr32(_ptr + 8);
        }// end function

        public function set m_islandIndex(param1:int) : void
        {
            mem._mw32(_ptr + 8, param1);
            return;
        }// end function

        public function get m_angularVelocity() : Number
        {
            return mem._mrf(_ptr + 80);
        }// end function

        public function set m_angularVelocity(param1:Number) : void
        {
            mem._mwf(_ptr + 80, param1);
            return;
        }// end function

        public function get m_torque() : Number
        {
            return mem._mrf(_ptr + 92);
        }// end function

        public function set m_torque(param1:Number) : void
        {
            mem._mwf(_ptr + 92, param1);
            return;
        }// end function

        public function get m_fixtureCount() : int
        {
            return mem._mr32(_ptr + 112);
        }// end function

        public function set m_fixtureCount(param1:int) : void
        {
            mem._mw32(_ptr + 112, param1);
            return;
        }// end function

        public function get m_mass() : Number
        {
            return mem._mrf(_ptr + 124);
        }// end function

        public function set m_mass(param1:Number) : void
        {
            mem._mwf(_ptr + 124, param1);
            return;
        }// end function

        public function get m_invMass() : Number
        {
            return mem._mrf(_ptr + 128);
        }// end function

        public function set m_invMass(param1:Number) : void
        {
            mem._mwf(_ptr + 128, param1);
            return;
        }// end function

        public function get m_I() : Number
        {
            return mem._mrf(_ptr + 132);
        }// end function

        public function set m_I(param1:Number) : void
        {
            mem._mwf(_ptr + 132, param1);
            return;
        }// end function

        public function get m_invI() : Number
        {
            return mem._mrf(_ptr + 136);
        }// end function

        public function set m_invI(param1:Number) : void
        {
            mem._mwf(_ptr + 136, param1);
            return;
        }// end function

        public function get m_linearDamping() : Number
        {
            return mem._mrf(_ptr + 140);
        }// end function

        public function set m_linearDamping(param1:Number) : void
        {
            mem._mwf(_ptr + 140, param1);
            return;
        }// end function

        public function get m_angularDamping() : Number
        {
            return mem._mrf(_ptr + 144);
        }// end function

        public function set m_angularDamping(param1:Number) : void
        {
            mem._mwf(_ptr + 144, param1);
            return;
        }// end function

        public function get m_sleepTime() : Number
        {
            return mem._mrf(_ptr + 148);
        }// end function

        public function set m_sleepTime(param1:Number) : void
        {
            mem._mwf(_ptr + 148, param1);
            return;
        }// end function

    }
}
