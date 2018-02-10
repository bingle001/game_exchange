package wcks.wck
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import wcks.Box2DAS.Common.*;
    import wcks.Box2DAS.Dynamics.*;
    import wcks.Box2DAS.Dynamics.Joints.*;
    import wcks.gravity.*;
    import wcks.misc.*;

    public class World extends Scroller
    {
        public var scale:Number = 60;
        public var timeStep:Number = 0.05;
        public var velocityIterations:int = 10;
        public var positionIterations:int = 10;
        public var gravityX:Number = 0;
        public var gravityY:Number = 10;
        public var allowSleep:Boolean = true;
        public var allowDragging:Boolean = true;
        public var paused:Boolean = false;
        public var orientToGravity:Boolean = false;
        public var debugDraw:Boolean = false;
        public var outsideTS:Array;
        public var baseGravity:V2;
        public var b2world:b2World;
        public var customGravity:Gravity;
        public var debug:b2DebugDraw;
        public var kDrag:Object;
        public var dragMethod:String = "Mouse";
        public var dragJoint:Joint;
        public static var dragJointClass:Class = Joint;
        public static var dragJointStrength:Number = 100;
        public static var dragJointMassFactor:Number = 200;

        public function World()
        {
            this.outsideTS = [];
            return;
        }// end function

        override public function create() : void
        {
            this.baseGravity = new V2(this.gravityX, this.gravityY);
            this.b2world = new b2World(new V2(0, 0), this.allowSleep, this);
            listenWhileVisible(stage, Event.ENTER_FRAME, this.step);
            listenWhileVisible(this, StepEvent.STEP, this.applyGravityToWorld, false, 10);
            super.create();
            if (this.debugDraw)
            {
                this.debug = new b2DebugDraw(this.b2world, this.scale);
                this.debug.alpha = 0.6;
                addChild(this.debug);
            }
            listenWhileVisible(this, MouseEvent.MOUSE_DOWN, this.handleDragStart);
            return;
        }// end function

        public function handleDragStart(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = Util.findAncestorOfClass(event.target as DisplayObject, BodyShape, true) as BodyShape;
            if (_loc_2)
            {
            }
            if (_loc_2.b2body)
            {
            }
            if (this.allowDragging)
            {
                if (this.dragMethod == "Mouse")
                {
                }
                if (_loc_2.b2body.IsDynamic())
                {
                    this.createDragJoint(_loc_2);
                }
                else if (this.dragMethod == "Kinematic")
                {
                    _loc_2.listenWhileVisible(stage, Event.ENTER_FRAME, this.handleDragStep, false, 1000);
                    _loc_2.listenWhileVisible(stage, Input.MOUSE_UP_OR_LOST, this.handleDragStop);
                    _loc_3 = Input.mousePositionIn(this);
                    _loc_4 = Util.localizePoint(this, _loc_2.body);
                    _loc_2 = _loc_2.body;
                    this.kDrag = {body:_loc_2, type:_loc_2.type, autoSleep:_loc_2.autoSleep, offset:_loc_3.subtract(_loc_4)};
                    _loc_2.type = "Animated";
                    _loc_2.awake = true;
                    _loc_2.autoSleep = false;
                }
            }
            return;
        }// end function

        public function createDragJoint(param1:BodyShape) : void
        {
            param1.body.awake = true;
            param1.listenWhileVisible(stage, Event.ENTER_FRAME, this.handleDragStep, false, 1000);
            param1.listenWhileVisible(stage, Input.MOUSE_UP_OR_LOST, this.handleDragStop);
            this.dragJoint = new dragJointClass() as Joint;
            this.dragJoint.maxForce = dragJointStrength + param1.b2body.m_mass * dragJointMassFactor;
            this.dragJoint.frequencyHz = 999999;
            this.dragJoint.dampingRatio = 0;
            this.dragJoint.collideConnected = true;
            this.dragJoint.type = "Mouse";
            var _loc_2:* = Input.mousePositionIn(this);
            this.dragJoint.x = _loc_2.x;
            this.dragJoint.y = _loc_2.y;
            this.dragJoint.bodyShape1 = param1.body;
            addChild(this.dragJoint);
            return;
        }// end function

        public function handleDragStep(event:Event) : void
        {
            if (this.dragJoint)
            {
                (this.dragJoint.b2joint as b2MouseJoint).SetTarget(V2.fromP(Input.mousePositionIn(this)).divideN(this.scale));
            }
            else
            {
                this.kDrag.body.setPos(Input.mousePositionIn(this).subtract(this.kDrag.offset));
            }
            return;
        }// end function

        public function handleDragStop(event:Event) : void
        {
            if (stage)
            {
                stopListening(stage, Event.ENTER_FRAME, this.handleDragStep);
                stopListening(stage, Input.MOUSE_UP_OR_LOST, this.handleDragStop);
            }
            if (this.dragJoint)
            {
                this.dragJoint.remove();
            }
            else
            {
                this.kDrag.body.type = this.kDrag.type;
                this.kDrag.body.autoSleep = this.kDrag.autoSleep;
                this.kDrag = null;
            }
            return;
        }// end function

        override public function destroy() : void
        {
            this.doOutsideTimeStep(function () : void
            {
                b2world.destroy();
                b2world = null;
                return;
            }// end function
            );
            return;
        }// end function

        public function step(event:Event = null) : void
        {
            if (this.paused)
            {
                return;
            }
            this.b2world.Step(this.timeStep, this.velocityIterations, this.positionIterations);
            var _loc_2:* = 0;
            while (_loc_2 < this.outsideTS.length)
            {
                
                this.outsideTS[_loc_2][0].apply(null, this.outsideTS[_loc_2][1]);
                _loc_2 = _loc_2 + 1;
            }
            this.outsideTS = [];
            if (this.debug)
            {
                this.debug.Draw();
                addChild(this.debug);
            }
            return;
        }// end function

        public function applyGravityToWorld(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_4:* = null;
            if (this.paused)
            {
                return;
            }
            var _loc_3:* = this.b2world.m_bodyList;
            while (_loc_3)
            {
                
                _loc_2 = _loc_3.m_userData as BodyShape;
                if (_loc_3.IsAwake())
                {
                    _loc_3.IsAwake();
                }
                if (_loc_3.IsDynamic())
                {
                    _loc_4 = this.getGravityFor(_loc_3.GetWorldCenter(), _loc_3, _loc_2);
                    if (_loc_2)
                    {
                    }
                    if (_loc_2.applyGravity)
                    {
                        _loc_3.m_linearVelocity.x = _loc_3.m_linearVelocity.x + this.timeStep * _loc_4.x;
                        _loc_3.m_linearVelocity.y = _loc_3.m_linearVelocity.y + this.timeStep * _loc_4.y;
                    }
                    if (_loc_2)
                    {
                        _loc_2.gravity = _loc_4;
                    }
                }
                _loc_3 = _loc_3.GetNext();
            }
            return;
        }// end function

        public function getGravityFor(param1:V2, param2:b2Body = null, param3:BodyShape = null) : V2
        {
            var _loc_4:* = null;
            if (param3)
            {
            }
            if (param3.customGravity)
            {
                _loc_4 = param3.customGravity.gravity(param1, param2, param3);
            }
            else if (this.customGravity)
            {
                _loc_4 = this.customGravity.gravity(param1, param2, param3);
            }
            else
            {
                _loc_4 = this.baseGravity.clone();
            }
            if (param3)
            {
            }
            if (param3.gravityMod)
            {
                param3.modifyGravity(_loc_4);
            }
            return _loc_4;
        }// end function

        public function doOutsideTimeStep(param1:Function, ... args) : void
        {
            if (this.b2world.IsLocked())
            {
                this.outsideTS.push([param1, args]);
            }
            else
            {
                param1.apply(null, args);
            }
            return;
        }// end function

        public function setDebug() : void
        {
            if (this.debugDraw == false)
            {
                this.debugDraw = true;
                this.debug = new b2DebugDraw(this.b2world, this.scale);
                this.debug.alpha = 0.5;
                addChild(this.debug);
            }
            else
            {
                this.debugDraw = false;
                if (this.debug)
                {
                }
                if (this.debug.parent)
                {
                    removeChild(this.debug);
                    this.debug = null;
                }
            }
            return;
        }// end function

        override public function scrollRotation() : Number
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this.orientToGravity)
            {
                _loc_1 = focus as BodyShape;
                _loc_2 = this.getGravityFor(V2.fromP(pos).divideN(this.scale), _loc_1 ? (_loc_1.b2body) : (null), _loc_1);
                return Math.atan2(_loc_2.y, -_loc_2.x) * Util.R2D - 90;
            }
            return rot;
        }// end function

    }
}
