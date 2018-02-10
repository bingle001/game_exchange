package wcks.wck
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import wcks.Box2DAS.Common.*;
    import wcks.Box2DAS.Dynamics.*;
    import wcks.Box2DAS.Dynamics.Joints.*;
    import wcks.misc.*;

    public class Joint extends ScrollerChild
    {
        public var jointName:String;
        public var _collideConnected:Boolean = false;
        public var _lowerLimit:Number = 0;
        public var _upperLimit:Number = 0;
        public var _maxForce:Number = 0;
        public var _maxTorque:Number = 0;
        public var _motorSpeed:Number = 0;
        public var _enableLimit:Boolean = false;
        public var _enableMotor:Boolean = false;
        public var type:String = "None";
        public var axisX:Number = 0;
        public var axisY:Number = 0;
        public var _spring:Boolean = false;
        public var springConstant:Number = 0;
        public var springDamping:Number = 0;
        public var _frequencyHz:Number = 5;
        public var _dampingRatio:Number = 0.7;
        public var pulleyGearRatio:Number = 1;
        public var target1Name:String = "";
        public var target2Name:String = "";
        public var pulleyGearPartnerName:String = "";
        public var _gearCollideConnected:Boolean = false;
        public var connectorClassName:String = "";
        public var connectorThickness:Number = 2;
        public var connectorColor:uint = 8947848;
        public var tweened:Boolean = false;
        public var world:World;
        public var b2joint:b2Joint;
        public var target1Object:DisplayObject;
        public var bodyShape1:BodyShape;
        public var b2body1:b2Body;
        public var target2Object:DisplayObject;
        public var target2Joint:Joint;
        public var bodyShape2:BodyShape;
        public var b2body2:b2Body;
        public var pulleyGearPartner:Joint;
        public var b2gear:b2Joint;
        public var anchorPoint:Point;
        public var connector:Connector;

        public function Joint()
        {
            return;
        }// end function

        public function set collideConnected(param1:Boolean) : void
        {
            if (this.b2joint)
            {
                this.b2joint.m_collideConnected = param1;
            }
            else
            {
                this._collideConnected = param1;
            }
            return;
        }// end function

        public function get collideConnected() : Boolean
        {
            if (this.b2joint)
            {
                return this.b2joint.m_collideConnected;
            }
            return this._collideConnected;
        }// end function

        public function set lowerLimit(param1:Number) : void
        {
            if (this.b2joint)
            {
                this.b2joint.SetLowerLimit(param1);
            }
            else
            {
                this._lowerLimit = param1;
            }
            return;
        }// end function

        public function get lowerLimit() : Number
        {
            if (this.b2joint)
            {
                return this.b2joint.GetLowerLimit();
            }
            return this._lowerLimit;
        }// end function

        public function set upperLimit(param1:Number) : void
        {
            if (this.b2joint)
            {
                this.b2joint.SetUpperLimit(param1);
            }
            else
            {
                this._upperLimit = param1;
            }
            return;
        }// end function

        public function get upperLimit() : Number
        {
            if (this.b2joint)
            {
                return this.b2joint.GetUpperLimit();
            }
            return this._upperLimit;
        }// end function

        public function set maxForce(param1:Number) : void
        {
            if (this.b2joint)
            {
                this.b2joint.SetMaxMotorForce(param1);
            }
            else
            {
                this._maxForce = param1;
            }
            return;
        }// end function

        public function get maxForce() : Number
        {
            if (this.b2joint)
            {
                return this.b2joint.GetMaxMotorForce();
            }
            return this._maxForce;
        }// end function

        public function set maxTorque(param1:Number) : void
        {
            if (this.b2joint)
            {
                this.b2joint.SetMaxMotorTorque(param1);
            }
            else
            {
                this._maxTorque = param1;
            }
            return;
        }// end function

        public function get maxTorque() : Number
        {
            if (this.b2joint)
            {
                return this.b2joint.GetMaxMotorTorque();
            }
            return this._maxTorque;
        }// end function

        public function set motorSpeed(param1:Number) : void
        {
            if (this.b2joint)
            {
                this.b2joint.SetMotorSpeed(param1);
            }
            else
            {
                this._motorSpeed = param1;
            }
            return;
        }// end function

        public function get motorSpeed() : Number
        {
            if (this.b2joint)
            {
                return this.b2joint.GetMotorSpeed();
            }
            return this._motorSpeed;
        }// end function

        public function set enableLimit(param1:Boolean) : void
        {
            if (this.b2joint)
            {
                this.b2joint.EnableLimit(param1);
            }
            else
            {
                this._enableLimit = param1;
            }
            return;
        }// end function

        public function get enableLimit() : Boolean
        {
            if (this.b2joint)
            {
                return this.b2joint.IsLimitEnabled();
            }
            return this._enableLimit;
        }// end function

        public function set enableMotor(param1:Boolean) : void
        {
            if (this.b2joint)
            {
                this.b2joint.EnableMotor(param1);
            }
            else
            {
                this._enableMotor = param1;
            }
            return;
        }// end function

        public function get enableMotor() : Boolean
        {
            if (this.b2joint)
            {
                return this.b2joint.IsMotorEnabled();
            }
            return this._enableMotor;
        }// end function

        public function set spring(param1:Boolean) : void
        {
            if (param1 == this._spring)
            {
                return;
            }
            this._spring = param1;
            if (this.b2joint)
            {
                if (this._spring)
                {
                    this.createSpring();
                }
                else
                {
                    this.destroySpring();
                }
            }
            return;
        }// end function

        public function get spring() : Boolean
        {
            return this._spring;
        }// end function

        public function set frequencyHz(param1:Number) : void
        {
            if (this.b2joint)
            {
                this.b2joint.SetFrequency(param1);
            }
            else
            {
                this._frequencyHz = param1;
            }
            return;
        }// end function

        public function get frequencyHz() : Number
        {
            if (this.b2joint)
            {
                return this.b2joint.GetFrequency();
            }
            return this._frequencyHz;
        }// end function

        public function set dampingRatio(param1:Number) : void
        {
            if (this.b2joint)
            {
                this.b2joint.SetDampingRatio(param1);
            }
            else
            {
                this._dampingRatio = param1;
            }
            return;
        }// end function

        public function get dampingRatio() : Number
        {
            if (this.b2joint)
            {
                return this.b2joint.GetDampingRatio();
            }
            return this._dampingRatio;
        }// end function

        public function set gearCollideConnected(param1:Boolean) : void
        {
            if (this.b2gear)
            {
                this.b2gear.m_collideConnected = param1;
            }
            else
            {
                this._gearCollideConnected = param1;
            }
            return;
        }// end function

        public function get gearCollideConnected() : Boolean
        {
            if (this.b2gear)
            {
                return this.b2gear.m_collideConnected;
            }
            return this._gearCollideConnected;
        }// end function

        override public function create() : void
        {
            this.locateBodies();
            this.createAnchorPoint();
            this.createJoint();
            this.createConnector();
            if (this._spring)
            {
                this.createSpring();
            }
            super.create();
            return;
        }// end function

        override public function destroy() : void
        {
            if (this.world)
            {
            }
            if (this.world.created)
            {
            }
            if (!this.world.disabled)
            {
            }
            if (this.world.parent)
            {
                this.destroyConnector();
                this.destroyGearJoint();
                this.destroyJoint();
                if (this._spring)
                {
                    this.destroySpring();
                }
            }
            return;
        }// end function

        public function locateBodies() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            this.world = Util.findAncestorOfClass(this, World) as World;
            this.world.ensureCreated();
            var _loc_1:* = [];
            var _loc_2:* = 0;
            if (!this.target1Object)
            {
            }
            this.target1Object = this.bodyShape1;
            if (!this.target1Object)
            {
            }
            if (this.target1Name)
            {
                this.target1Object = Util.getDisplayObjectByPath(this.parent, this.target1Name, this.world);
                this.bodyShape1 = this.target1Object as BodyShape;
            }
            if (this.bodyShape1)
            {
                _loc_1.push(this.bodyShape1);
            }
            else
            {
                _loc_2 = 1;
            }
            if (this.type != "Mouse")
            {
                if (!this.target2Object)
                {
                }
                this.target2Object = this.bodyShape2;
                if (!this.target2Object)
                {
                }
                if (this.target2Name)
                {
                    this.target2Object = Util.getDisplayObjectByPath(this.parent, this.target2Name, this.world);
                    this.bodyShape2 = this.target2Object as BodyShape;
                    this.target2Joint = this.target2Object as Joint;
                }
                else
                {
                    if (!this.bodyShape2)
                    {
                    }
                    if (!this.target2Joint)
                    {
                        _loc_2 = _loc_2 + 1;
                    }
                }
            }
            if (_loc_2 > 0)
            {
                _loc_3 = Util.getObjectsUnderPointByClass(this.world, localToGlobal(new Point(0, 0)), BodyShape, _loc_2, _loc_1);
                _loc_4 = 0;
                while (_loc_4 < _loc_3.length)
                {
                    
                    if (this.bodyShape1)
                    {
                        this.bodyShape2 = _loc_3[_loc_4];
                        this.target2Object = this.bodyShape2;
                    }
                    else
                    {
                        this.bodyShape1 = _loc_3[_loc_4];
                        this.target1Object = this.bodyShape1;
                    }
                    _loc_4 = _loc_4 + 1;
                }
            }
            if (this.bodyShape1)
            {
                this.bodyShape1.ensureCreated();
                this.b2body1 = this.bodyShape1.b2body;
            }
            else
            {
                this.b2body1 = this.world.b2world.m_groundBody;
            }
            if (this.target2Joint)
            {
                this.target2Joint.ensureCreated();
                this.bodyShape2 = this.target2Joint.bodyShape1;
            }
            if (this.bodyShape2)
            {
                this.bodyShape2.ensureCreated();
                this.b2body2 = this.bodyShape2.b2body;
            }
            else
            {
                this.b2body2 = this.world.b2world.m_groundBody;
            }
            if (!this.target2Object)
            {
                this.target2Object = this;
            }
            if (!this.pulleyGearPartner)
            {
            }
            if (this.pulleyGearPartnerName)
            {
                this.pulleyGearPartner = Util.getDisplayObjectByPath(this.parent, this.pulleyGearPartnerName, this.world) as Joint;
            }
            if (this.pulleyGearPartner)
            {
                this.pulleyGearPartner.ensureCreated();
            }
            if (this.target1Object)
            {
                listenWhileVisible(this.target1Object, Event.REMOVED_FROM_STAGE, this.handleTargetRemoved);
            }
            if (this.target2Object)
            {
                listenWhileVisible(this.target2Object, Event.REMOVED_FROM_STAGE, this.handleTargetRemoved);
            }
            if (this.pulleyGearPartner)
            {
                listenWhileVisible(this.pulleyGearPartner, Event.REMOVED_FROM_STAGE, this.handleTargetRemoved);
                if (this.pulleyGearPartner.target2Object)
                {
                    listenWhileVisible(this.pulleyGearPartner.target2Object, Event.REMOVED_FROM_STAGE, this.handleTargetRemoved);
                }
            }
            return;
        }// end function

        public function handleTargetRemoved(event:Event) : void
        {
            if (this.world)
            {
            }
            if (this.world.created)
            {
                if (event.target == this.target1Object)
                {
                    remove();
                }
                else if (event.target == this.target2Object)
                {
                    this.destroyJoint();
                    this.destroyGearJoint();
                    this.destroyConnector();
                    if (this.type == "Pulley")
                    {
                        this.pulleyGearPartner.destroyConnector();
                    }
                }
                else
                {
                    if (event.target != this.pulleyGearPartner)
                    {
                        if (this.pulleyGearPartner)
                        {
                        }
                    }
                    if (event.target == this.pulleyGearPartner.target2Object)
                    {
                        if (this.type == "Pulley")
                        {
                            this.destroyJoint();
                            this.destroyConnector();
                        }
                        else
                        {
                            this.destroyGearJoint();
                        }
                    }
                }
            }
            return;
        }// end function

        public function createJoint() : void
        {
            if (this.b2body1 == this.b2body2)
            {
                return;
            }
            switch(this.type)
            {
                case "Distance":
                {
                    this.createDistanceJoint();
                    break;
                }
                case "Line":
                {
                    this.createLineJoint();
                    break;
                }
                case "Mouse":
                {
                    this.createMouseJoint();
                    break;
                }
                case "Prismatic":
                {
                    this.createPrismaticJoint();
                    if (this.pulleyGearPartner)
                    {
                        this.createGearJoint();
                    }
                    break;
                }
                case "Pulley":
                {
                    this.createPulleyJoint();
                    break;
                }
                case "Revolute":
                {
                    this.createRevoluteJoint();
                    if (this.pulleyGearPartner)
                    {
                        this.createGearJoint();
                    }
                    break;
                }
                case "Weld":
                {
                    this.createWeldJoint();
                    break;
                }
                case "Friction":
                {
                    this.createFrictionJoint();
                    break;
                }
                case "Rope":
                {
                    this.createRopeJoint();
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this.b2joint)
            {
                listenWhileVisible(this, GoodbyeJointEvent.GOODBYE_JOINT, this.handleGoodbyeJoint);
            }
            return;
        }// end function

        public function handleGoodbyeJoint(event:GoodbyeJointEvent) : void
        {
            if (event.joint == this.b2joint)
            {
                this.b2joint = null;
            }
            else if (event.joint == this.b2gear)
            {
                this.b2gear = null;
            }
            return;
        }// end function

        public function createAnchorPoint() : void
        {
            if (this.target1Object)
            {
                this.anchorPoint = Util.localizePoint(this.target1Object, this);
                if (!this.tweened)
                {
                    listenWhileVisible(this.world, StepEvent.STEP, this.updateAnchorPoint, false, -20);
                }
            }
            return;
        }// end function

        public function updateAnchorPoint(event:Event) : void
        {
            var _loc_2:* = Util.localizePoint(parent, this.target1Object, this.anchorPoint);
            x = _loc_2.x;
            y = _loc_2.y;
            return;
        }// end function

        public function destroyJoint() : void
        {
            if (this.b2joint)
            {
                this.world.doOutsideTimeStep(function () : void
            {
                if (b2joint)
                {
                    b2joint.destroy();
                    b2joint = null;
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

        public function destroyGearJoint() : void
        {
            if (this.b2gear)
            {
                this.world.doOutsideTimeStep(function () : void
            {
                if (b2gear)
                {
                    b2gear.destroy();
                    b2gear = null;
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

        public function initJointDef(param1:b2JointDef) : void
        {
            param1.collideConnected = this._collideConnected;
            param1.userData = this;
            return;
        }// end function

        public function createDistanceJoint() : void
        {
            this.initJointDef(b2Def.distanceJoint);
            b2Def.distanceJoint.frequencyHz = this._frequencyHz;
            b2Def.distanceJoint.dampingRatio = this._dampingRatio;
            var _loc_1:* = Util.localizePoint(this.world, this);
            var _loc_2:* = Util.localizePoint(this.world, this.target2Object);
            b2Def.distanceJoint.Initialize(this.b2body1, this.b2body2, new V2(_loc_1.x / this.world.scale, _loc_1.y / this.world.scale), new V2(_loc_2.x / this.world.scale, _loc_2.y / this.world.scale));
            this.b2joint = new b2DistanceJoint(this.world.b2world, b2Def.distanceJoint, this);
            return;
        }// end function

        public function createLineJoint() : void
        {
            var _loc_2:* = null;
            this.initJointDef(b2Def.lineJoint);
            b2Def.lineJoint.enableMotor = this._enableMotor;
            b2Def.lineJoint.maxMotorTorque = this._maxTorque;
            b2Def.lineJoint.motorSpeed = this._motorSpeed;
            b2Def.lineJoint.frequencyHz = this._frequencyHz;
            b2Def.lineJoint.dampingRatio = this._dampingRatio;
            var _loc_1:* = Util.localizePoint(this.world, this);
            var _loc_3:* = Util.localizePoint(this.world, this.target2Object);
            if (this.axisX == 0)
            {
            }
            if (this.axisY == 0)
            {
                _loc_2 = new V2(_loc_3.x - _loc_1.x, _loc_3.y - _loc_1.y);
            }
            else
            {
                _loc_2 = new V2(this.axisX, this.axisY);
            }
            _loc_2.normalize();
            b2Def.lineJoint.Initialize(this.b2body1, this.b2body2, new V2(_loc_3.x / this.world.scale, _loc_3.y / this.world.scale), _loc_2);
            this.b2joint = new b2LineJoint(this.world.b2world, b2Def.lineJoint, this);
            return;
        }// end function

        public function createMouseJoint() : void
        {
            this.initJointDef(b2Def.mouseJoint);
            b2Def.mouseJoint.frequencyHz = this._frequencyHz;
            b2Def.mouseJoint.dampingRatio = this._dampingRatio;
            b2Def.mouseJoint.maxForce = this._maxForce;
            b2Def.mouseJoint.Initialize(this.b2body1, V2.fromP(Util.localizePoint(this.world, this)).divideN(this.world.scale));
            this.b2joint = new b2MouseJoint(this.world.b2world, b2Def.mouseJoint, this);
            if (this.tweened)
            {
                listenWhileVisible(this.world, StepEvent.STEP, this.updateMouseJointTarget, false, 1);
            }
            return;
        }// end function

        public function updateMouseJointTarget(event:Event) : void
        {
            (this.b2joint as b2MouseJoint).SetTarget(V2.fromP(Util.localizePoint(this.world, this)).divideN(this.world.scale));
            return;
        }// end function

        public function createPrismaticJoint() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this.initJointDef(b2Def.prismaticJoint);
            b2Def.prismaticJoint.enableLimit = this._enableLimit;
            b2Def.prismaticJoint.lowerTranslation = this._lowerLimit;
            b2Def.prismaticJoint.upperTranslation = this._upperLimit;
            b2Def.prismaticJoint.enableMotor = this._enableMotor;
            b2Def.prismaticJoint.maxMotorForce = this._maxForce;
            b2Def.prismaticJoint.motorSpeed = this._motorSpeed;
            var _loc_1:* = Util.localizePoint(this.world, this);
            if (this.axisX == 0)
            {
            }
            if (this.axisY == 0)
            {
                _loc_3 = Util.localizePoint(this.world, this.target2Object);
                _loc_2 = new V2(_loc_3.x - _loc_1.x, _loc_3.y - _loc_1.y);
            }
            else
            {
                _loc_2 = new V2(this.axisX, this.axisY);
            }
            _loc_2.normalize();
            if (!this.b2body1.IsStatic())
            {
            }
            if (this.b2body2.IsStatic())
            {
                _loc_4 = this.b2body1;
                this.b2body1 = this.b2body2;
                this.b2body2 = _loc_4;
            }
            b2Def.prismaticJoint.Initialize(this.b2body1, this.b2body2, new V2(_loc_1.x / this.world.scale, _loc_1.y / this.world.scale), _loc_2);
            this.b2joint = new b2PrismaticJoint(this.world.b2world, b2Def.prismaticJoint, this);
            return;
        }// end function

        public function createPulleyJoint() : void
        {
            this.initJointDef(b2Def.pulleyJoint);
            b2Def.pulleyJoint.maxLengthA = this._lowerLimit;
            b2Def.pulleyJoint.maxLengthB = this._upperLimit;
            b2Def.pulleyJoint.ratio = this.pulleyGearRatio;
            var _loc_1:* = Util.localizePoint(this.world, this);
            var _loc_2:* = Util.localizePoint(this.world, this.pulleyGearPartner);
            var _loc_3:* = Util.localizePoint(this.world, this.target2Object);
            var _loc_4:* = Util.localizePoint(this.world, this.pulleyGearPartner.target2Object);
            b2Def.pulleyJoint.Initialize(this.b2body1, this.pulleyGearPartner.b2body1, new V2(_loc_3.x / this.world.scale, _loc_3.y / this.world.scale), new V2(_loc_4.x / this.world.scale, _loc_4.y / this.world.scale), new V2(_loc_1.x / this.world.scale, _loc_1.y / this.world.scale), new V2(_loc_2.x / this.world.scale, _loc_2.y / this.world.scale), this.pulleyGearRatio);
            this.b2joint = new b2PulleyJoint(this.world.b2world, b2Def.pulleyJoint, this);
            return;
        }// end function

        public function createRevoluteJoint() : void
        {
            var _loc_2:* = null;
            this.initJointDef(b2Def.revoluteJoint);
            b2Def.revoluteJoint.enableLimit = this._enableLimit;
            b2Def.revoluteJoint.lowerAngle = this._lowerLimit;
            b2Def.revoluteJoint.upperAngle = this._upperLimit;
            b2Def.revoluteJoint.enableMotor = this._enableMotor;
            b2Def.revoluteJoint.maxMotorTorque = this._maxTorque;
            b2Def.revoluteJoint.motorSpeed = this._motorSpeed;
            var _loc_1:* = Util.localizePoint(this.world, this);
            if (!this.b2body1.IsStatic())
            {
            }
            if (this.b2body2.IsStatic())
            {
                _loc_2 = this.b2body1;
                this.b2body1 = this.b2body2;
                this.b2body2 = _loc_2;
            }
            b2Def.revoluteJoint.Initialize(this.b2body1, this.b2body2, new V2(_loc_1.x / this.world.scale, _loc_1.y / this.world.scale));
            this.b2joint = new b2RevoluteJoint(this.world.b2world, b2Def.revoluteJoint, this);
            return;
        }// end function

        public function createWeldJoint() : void
        {
            this.initJointDef(b2Def.weldJoint);
            var _loc_1:* = Util.localizePoint(this.world, this);
            b2Def.weldJoint.Initialize(this.b2body1, this.b2body2, new V2(_loc_1.x / this.world.scale, _loc_1.y / this.world.scale));
            this.b2joint = new b2WeldJoint(this.world.b2world, b2Def.weldJoint, this);
            return;
        }// end function

        public function createFrictionJoint() : void
        {
            this.initJointDef(b2Def.frictionJoint);
            b2Def.frictionJoint.maxForce = this._maxForce;
            b2Def.frictionJoint.maxTorque = this._maxTorque;
            var _loc_1:* = Util.localizePoint(this.world, this);
            b2Def.frictionJoint.Initialize(this.b2body1, this.b2body2, new V2(_loc_1.x / this.world.scale, _loc_1.y / this.world.scale));
            this.b2joint = new b2FrictionJoint(this.world.b2world, b2Def.frictionJoint, this);
            return;
        }// end function

        public function createGearJoint() : void
        {
            this.initJointDef(b2Def.gearJoint);
            b2Def.gearJoint.collideConnected = this._gearCollideConnected;
            b2Def.gearJoint.Initialize(this.b2joint, this.pulleyGearPartner.b2joint, this.pulleyGearRatio);
            this.b2gear = new b2GearJoint(this.world.b2world, b2Def.gearJoint, this);
            return;
        }// end function

        public function createRopeJoint() : void
        {
            this.initJointDef(b2Def.ropeJoint);
            var _loc_1:* = Util.localizePoint(this.world, this);
            var _loc_2:* = Util.localizePoint(this.world, this.target2Object);
            b2Def.ropeJoint.Initialize(this.b2body1, this.b2body2, new V2(_loc_1.x / this.world.scale, _loc_1.y / this.world.scale), new V2(_loc_2.x / this.world.scale, _loc_2.y / this.world.scale));
            if (this._upperLimit != 0)
            {
                b2Def.ropeJoint.maxLength = this._upperLimit;
            }
            this.b2joint = new b2RopeJoint(this.world.b2world, b2Def.ropeJoint, this);
            return;
        }// end function

        public function createConnector() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this.target2Object)
            {
            }
            if (this.connectorClassName != "")
            {
                _loc_1 = getDefinitionByName(this.connectorClassName) as Class;
                this.connector = new _loc_1 as Connector;
                this.connector.from = this;
                this.connector.to = this.target2Object;
                _loc_2 = this.connector as ConnectorLine;
                if (_loc_2)
                {
                    _loc_2.color = this.connectorColor;
                    _loc_2.thickness = this.connectorThickness;
                }
                this.world.addChild(this.connector);
            }
            return;
        }// end function

        public function destroyConnector() : void
        {
            if (this.connector)
            {
                Util.remove(this.connector);
                this.connector = null;
            }
            return;
        }// end function

        public function createSpring() : void
        {
            listenWhileVisible(this.world, StepEvent.STEP, this.updateSpring);
            return;
        }// end function

        public function updateSpring(event:Event) : void
        {
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_2:* = this.b2joint as b2PrismaticJoint;
            var _loc_3:* = this.b2joint as b2LineJoint;
            var _loc_4:* = this.b2joint as b2RevoluteJoint;
            if (_loc_2)
            {
                _loc_5 = _loc_2.GetJointTranslation();
                _loc_2.SetMaxMotorForce(Math.abs(_loc_5 * this.springConstant + _loc_2.GetJointSpeed() * this.springDamping));
                _loc_2.SetMotorSpeed(_loc_5 > 0 ? (-100000) : (100000));
            }
            else if (_loc_4)
            {
                _loc_6 = _loc_4.GetJointAngle();
                _loc_4.SetMaxMotorTorque(Math.abs(_loc_6 * this.springConstant + _loc_4.GetJointSpeed() * this.springDamping));
                _loc_4.SetMotorSpeed(_loc_6 > 0 ? (-100000) : (100000));
            }
            else if (_loc_3)
            {
                _loc_7 = _loc_3.GetJointTranslation();
                _loc_3.SetMaxMotorForce(Math.abs(_loc_7 * this.springConstant + _loc_3.GetJointSpeed() * this.springDamping));
                _loc_3.SetMotorSpeed(_loc_7 > 0 ? (-100000) : (100000));
            }
            return;
        }// end function

        public function destroySpring() : void
        {
            stopListening(this.world, StepEvent.STEP, this.updateSpring);
            return;
        }// end function

    }
}
