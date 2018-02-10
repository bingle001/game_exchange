package wcks.wck
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import wcks.Box2DAS.Collision.Shapes.*;
    import wcks.Box2DAS.Common.*;
    import wcks.Box2DAS.Dynamics.*;
    import wcks.gravity.*;
    import wcks.misc.*;

    public class BodyShape extends ScrollerChild
    {
        public var tname:String;
        public var _linearVelocity:V2;
        public var _angularVelocity:Number = 0;
        public var _linearDamping:Number = 0;
        public var _angularDamping:Number = 0;
        public var _autoSleep:Boolean = true;
        public var _awake:Boolean = true;
        public var _fixedRotation:Boolean = false;
        public var _bullet:Boolean = false;
        public var _type:String = "Dynamic";
        public var _tweened:Boolean = false;
        public var _active:Boolean = true;
        public var _inertiaScale:Number = 1;
        public var _friction:Number = 0.2;
        public var _restitution:Number = 0;
        public var _density:Number = 1;
        public var _categoryBits:int = 1;
        public var _maskBits:int = 65535;
        public var _groupIndex:int = 0;
        public var _isSensor:Boolean = false;
        public var _reportBeginContact:Boolean = false;
        public var _reportEndContact:Boolean = false;
        public var _reportPreSolve:Boolean = false;
        public var _reportPostSolve:Boolean = false;
        public var _bubbleContacts:Boolean = true;
        public var _conveyorBeltSpeed:Number = 0;
        public var isGround:Boolean = false;
        public var applyGravity:Boolean = true;
        public var gravityMod:Boolean = false;
        public var gravityScale:Number = 1;
        public var gravityAngle:Number = 0;
        public var allowDragging:Boolean = true;
        public var isGuideShape:Boolean = false;
        public var customGravityName:String = "";
        public var world:World = null;
        public var selfBody:Boolean = false;
        public var body:BodyShape = null;
        public var b2body:b2Body = null;
        public var b2fixtures:Vector.<b2Fixture> = null;
        public var matrix:Matrix = null;
        public var gravity:V2;
        public var customGravity:Gravity = null;
        public var bufferedShapes:Array;

        public function BodyShape()
        {
            this._linearVelocity = new V2(0, 0);
            this.bufferedShapes = [];
            return;
        }// end function

        public function set linearVelocityX(param1:Number) : void
        {
            if (this.b2body)
            {
                this.b2body.m_linearVelocity.x = param1;
            }
            else
            {
                this._linearVelocity.x = param1;
            }
            return;
        }// end function

        public function get linearVelocityX() : Number
        {
            if (this.b2body)
            {
                return this.b2body.m_linearVelocity.x;
            }
            return this._linearVelocity.x;
        }// end function

        public function set linearVelocityY(param1:Number) : void
        {
            if (this.b2body)
            {
                this.b2body.m_linearVelocity.y = param1;
            }
            else
            {
                this._linearVelocity.y = param1;
            }
            return;
        }// end function

        public function get linearVelocityY() : Number
        {
            if (this.b2body)
            {
                return this.b2body.m_linearVelocity.y;
            }
            return this._linearVelocity.y;
        }// end function

        public function set linearVelocity(param1:V2) : void
        {
            if (this.b2body)
            {
                this.b2body.SetLinearVelocity(param1);
            }
            else
            {
                this._linearVelocity.copy(param1);
            }
            return;
        }// end function

        public function get linearVelocity() : V2
        {
            if (this.b2body)
            {
                return this.b2body.GetLinearVelocity();
            }
            return this._linearVelocity;
        }// end function

        public function set angularVelocity(param1:Number) : void
        {
            if (this.b2body)
            {
                this.b2body.SetAngularVelocity(param1);
            }
            else
            {
                this._angularVelocity = param1;
            }
            return;
        }// end function

        public function get angularVelocity() : Number
        {
            if (this.b2body)
            {
                return this.b2body.GetAngularVelocity();
            }
            return this._angularVelocity;
        }// end function

        public function set linearDamping(param1:Number) : void
        {
            if (this.b2body)
            {
                this.b2body.SetLinearDamping(param1);
            }
            else
            {
                this._linearDamping = param1;
            }
            return;
        }// end function

        public function get linearDamping() : Number
        {
            if (this.b2body)
            {
                return this.b2body.GetLinearDamping();
            }
            return this._linearDamping;
        }// end function

        public function set angularDamping(param1:Number) : void
        {
            if (this.b2body)
            {
                this.b2body.SetAngularDamping(param1);
            }
            else
            {
                this._angularDamping = param1;
            }
            return;
        }// end function

        public function get angularDamping() : Number
        {
            if (this.b2body)
            {
                return this.b2body.GetAngularDamping();
            }
            return this._angularDamping;
        }// end function

        public function set autoSleep(param1:Boolean) : void
        {
            if (this.b2body)
            {
                this.b2body.SetSleepingAllowed(param1);
            }
            else
            {
                this._autoSleep = param1;
            }
            return;
        }// end function

        public function get autoSleep() : Boolean
        {
            if (this.b2body)
            {
                return this.b2body.IsSleepingAllowed();
            }
            return this._autoSleep;
        }// end function

        public function set awake(param1:Boolean) : void
        {
            if (this.b2body)
            {
                this.b2body.SetAwake(param1);
            }
            else
            {
                this._awake = param1;
            }
            return;
        }// end function

        public function get awake() : Boolean
        {
            if (this.b2body)
            {
                return this.b2body.IsAwake();
            }
            return this._awake;
        }// end function

        public function set fixedRotation(param1:Boolean) : void
        {
            if (this.b2body)
            {
                this.b2body.SetFixedRotation(param1);
            }
            else
            {
                this._fixedRotation = param1;
            }
            return;
        }// end function

        public function get fixedRotation() : Boolean
        {
            if (this.b2body)
            {
                return this.b2body.IsFixedRotation();
            }
            return this._fixedRotation;
        }// end function

        public function set bullet(param1:Boolean) : void
        {
            if (this.b2body)
            {
                this.b2body.SetBullet(param1);
            }
            else
            {
                this._bullet = param1;
            }
            return;
        }// end function

        public function get bullet() : Boolean
        {
            if (this.b2body)
            {
                return this.b2body.IsBullet();
            }
            return this._bullet;
        }// end function

        public function set type(param1:String) : void
        {
            if (this._tweened)
            {
                param1 = "Animated";
            }
            if (this.b2body)
            {
            }
            if (this.selfBody)
            {
                this.b2body.SetType(typeStringToInt(param1));
                this._type = param1;
                this.setUpdateMethod();
            }
            else
            {
                this._type = param1;
            }
            return;
        }// end function

        public function get type() : String
        {
            return this._type;
        }// end function

        public function set tweened(param1:Boolean) : void
        {
            this._tweened = param1;
            this.type = "Animated";
            return;
        }// end function

        public function get tweened() : Boolean
        {
            return this._tweened;
        }// end function

        public function set active(param1:Boolean) : void
        {
            if (this.b2body)
            {
                this.b2body.SetActive(param1);
            }
            else
            {
                this._active = param1;
            }
            return;
        }// end function

        public function get active() : Boolean
        {
            if (this.b2body)
            {
                return this.b2body.IsActive();
            }
            return this._active;
        }// end function

        public function set inertiaScale(param1:Number) : void
        {
            this._inertiaScale = param1;
            return;
        }// end function

        public function get inertiaScale() : Number
        {
            return this._inertiaScale;
        }// end function

        public function set friction(param1:Number) : void
        {
            var _loc_2:* = 0;
            if (this.b2fixtures)
            {
                _loc_2 = 0;
                while (_loc_2 < this.b2fixtures.length)
                {
                    
                    this.b2fixtures[_loc_2].SetFriction(param1);
                    _loc_2 = _loc_2 + 1;
                }
            }
            else
            {
                this._friction = param1;
            }
            return;
        }// end function

        public function setFriction2(param1:Number, param2:int) : void
        {
            this.b2fixtures[param2].SetFriction(param1);
            return;
        }// end function

        public function get friction() : Number
        {
            if (this.b2fixtures)
            {
            }
            if (this.b2fixtures.length > 0)
            {
                return this.b2fixtures[0].GetFriction();
            }
            return this._friction;
        }// end function

        public function set restitution(param1:Number) : void
        {
            var _loc_2:* = 0;
            if (this.b2fixtures)
            {
                _loc_2 = 0;
                while (_loc_2 < this.b2fixtures.length)
                {
                    
                    this.b2fixtures[_loc_2].SetRestitution(param1);
                    _loc_2 = _loc_2 + 1;
                }
            }
            else
            {
                this._restitution = param1;
            }
            return;
        }// end function

        public function get restitution() : Number
        {
            if (this.b2fixtures)
            {
            }
            if (this.b2fixtures.length > 0)
            {
                return this.b2fixtures[0].GetRestitution();
            }
            return this._restitution;
        }// end function

        public function set density(param1:Number) : void
        {
            var _loc_2:* = 0;
            if (this.b2fixtures)
            {
                _loc_2 = 0;
                while (_loc_2 < this.b2fixtures.length)
                {
                    
                    this.b2fixtures[_loc_2].SetDensity(param1);
                    _loc_2 = _loc_2 + 1;
                }
            }
            else
            {
                this._density = param1;
            }
            return;
        }// end function

        public function get density() : Number
        {
            if (this.b2fixtures)
            {
            }
            if (this.b2fixtures.length > 0)
            {
                return this.b2fixtures[0].GetDensity();
            }
            return this._density;
        }// end function

        public function set categoryBits(param1) : void
        {
            var _loc_2:* = 0;
            param1 = param1 is String ? (parseInt(param1)) : (param1);
            if (this.b2fixtures)
            {
            }
            if (this.b2fixtures.length > 0)
            {
                _loc_2 = 0;
                while (_loc_2 < this.b2fixtures.length)
                {
                    
                    this.b2fixtures[_loc_2].m_filter.categoryBits = param1;
                    this.b2fixtures[_loc_2].Refilter();
                    _loc_2 = _loc_2 + 1;
                }
            }
            else
            {
                this._categoryBits = param1;
            }
            return;
        }// end function

        public function get categoryBits() : int
        {
            if (this.b2fixtures)
            {
            }
            if (this.b2fixtures.length > 0)
            {
                return this.b2fixtures[0].m_filter.categoryBits;
            }
            return this._categoryBits;
        }// end function

        public function set maskBits(param1) : void
        {
            var _loc_2:* = 0;
            param1 = param1 is String ? (parseInt(param1)) : (param1);
            if (this.b2fixtures)
            {
            }
            if (this.b2fixtures.length > 0)
            {
                _loc_2 = 0;
                while (_loc_2 < this.b2fixtures.length)
                {
                    
                    this.b2fixtures[_loc_2].m_filter.maskBits = param1;
                    this.b2fixtures[_loc_2].Refilter();
                    _loc_2 = _loc_2 + 1;
                }
            }
            else
            {
                this._maskBits = param1;
            }
            return;
        }// end function

        public function get maskBits() : int
        {
            if (this.b2fixtures)
            {
            }
            if (this.b2fixtures.length > 0)
            {
                return this.b2fixtures[0].m_filter.maskBits;
            }
            return this._maskBits;
        }// end function

        public function set groupIndex(param1:int) : void
        {
            this._groupIndex = param1;
            return;
        }// end function

        public function get groupIndex() : int
        {
            return this._groupIndex;
        }// end function

        public function set isSensor(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            if (this.b2fixtures)
            {
                _loc_2 = 0;
                while (_loc_2 < this.b2fixtures.length)
                {
                    
                    this.b2fixtures[_loc_2].SetSensor(param1);
                    _loc_2 = _loc_2 + 1;
                }
            }
            else
            {
                this._isSensor = param1;
            }
            return;
        }// end function

        public function get isSensor() : Boolean
        {
            if (this.b2fixtures)
            {
            }
            if (this.b2fixtures.length > 0)
            {
                return this.b2fixtures[0].IsSensor();
            }
            return this._isSensor;
        }// end function

        public function set reportBeginContact(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            if (this.b2fixtures)
            {
                _loc_2 = 0;
                while (_loc_2 < this.b2fixtures.length)
                {
                    
                    this.b2fixtures[_loc_2].m_reportBeginContact = param1;
                    _loc_2 = _loc_2 + 1;
                }
            }
            else
            {
                this._reportBeginContact = param1;
            }
            return;
        }// end function

        public function get reportBeginContact() : Boolean
        {
            if (this.b2fixtures)
            {
            }
            if (this.b2fixtures.length > 0)
            {
                return this.b2fixtures[0].m_reportBeginContact;
            }
            return this._reportBeginContact;
        }// end function

        public function set reportEndContact(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            if (this.b2fixtures)
            {
                _loc_2 = 0;
                while (_loc_2 < this.b2fixtures.length)
                {
                    
                    this.b2fixtures[_loc_2].m_reportEndContact = param1;
                    _loc_2 = _loc_2 + 1;
                }
            }
            else
            {
                this._reportEndContact = param1;
            }
            return;
        }// end function

        public function get reportEndContact() : Boolean
        {
            if (this.b2fixtures)
            {
            }
            if (this.b2fixtures.length > 0)
            {
                return this.b2fixtures[0].m_reportEndContact;
            }
            return this._reportEndContact;
        }// end function

        public function set reportPreSolve(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            if (this.b2fixtures)
            {
                _loc_2 = 0;
                while (_loc_2 < this.b2fixtures.length)
                {
                    
                    this.b2fixtures[_loc_2].m_reportPreSolve = param1;
                    _loc_2 = _loc_2 + 1;
                }
            }
            else
            {
                this._reportPreSolve = param1;
            }
            return;
        }// end function

        public function get reportPreSolve() : Boolean
        {
            if (this.b2fixtures)
            {
            }
            if (this.b2fixtures.length > 0)
            {
                return this.b2fixtures[0].m_reportPreSolve;
            }
            return this._reportPreSolve;
        }// end function

        public function set reportPostSolve(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            if (this.b2fixtures)
            {
                _loc_2 = 0;
                while (_loc_2 < this.b2fixtures.length)
                {
                    
                    this.b2fixtures[_loc_2].m_reportPostSolve = param1;
                    _loc_2 = _loc_2 + 1;
                }
            }
            else
            {
                this._reportPostSolve = param1;
            }
            return;
        }// end function

        public function get reportPostSolve() : Boolean
        {
            if (this.b2fixtures)
            {
            }
            if (this.b2fixtures.length > 0)
            {
                return this.b2fixtures[0].m_reportPostSolve;
            }
            return this._reportPostSolve;
        }// end function

        public function set bubbleContacts(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            if (this.b2fixtures)
            {
                _loc_2 = 0;
                while (_loc_2 < this.b2fixtures.length)
                {
                    
                    this.b2fixtures[_loc_2].m_bubbleContacts = param1;
                    _loc_2 = _loc_2 + 1;
                }
            }
            else
            {
                this._bubbleContacts = param1;
            }
            return;
        }// end function

        public function get bubbleContacts() : Boolean
        {
            if (this.b2fixtures)
            {
            }
            if (this.b2fixtures.length > 0)
            {
                return this.b2fixtures[0].m_bubbleContacts;
            }
            return this._bubbleContacts;
        }// end function

        public function set conveyorBeltSpeed(param1:Number) : void
        {
            var _loc_2:* = 0;
            if (this.b2fixtures)
            {
                _loc_2 = 0;
                while (_loc_2 < this.b2fixtures.length)
                {
                    
                    this.b2fixtures[_loc_2].m_conveyorBeltSpeed = param1;
                    _loc_2 = _loc_2 + 1;
                }
            }
            else
            {
                this._conveyorBeltSpeed = param1;
            }
            return;
        }// end function

        public function get conveyorBeltSpeed() : Number
        {
            if (this.b2fixtures)
            {
            }
            if (this.b2fixtures.length > 0)
            {
                return this.b2fixtures[0].m_conveyorBeltSpeed;
            }
            return this._conveyorBeltSpeed;
        }// end function

        public function shape(param1:Function, ... args) : void
        {
            if (this.b2body)
            {
                param1.apply(this, args);
            }
            this.bufferedShapes.push([param1, args]);
            return;
        }// end function

        public function createBufferedShapes() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < this.bufferedShapes.length)
            {
                
                this.bufferedShapes[_loc_1][0].apply(this, this.bufferedShapes[_loc_1][1]);
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        public function shapes() : void
        {
            return;
        }// end function

        public function box(param1:Number = 0, param2:Number = 0, param3:V2 = null, param4:Number = 0) : b2Fixture
        {
            var _loc_8:* = null;
            if (!param3)
            {
            }
            param3 = new V2();
            if (param1 != 0)
            {
            }
            if (param2 == 0)
            {
                _loc_8 = Util.bounds(this);
                if (param1 == 0)
                {
                    param1 = _loc_8.width;
                }
                if (param2 == 0)
                {
                    param2 = _loc_8.height;
                }
            }
            var _loc_5:* = param1 / 2;
            var _loc_6:* = param2 / 2;
            var _loc_7:* = this.Vector.<V2>([new V2(-_loc_5, -_loc_6), new V2(_loc_5, -_loc_6), new V2(_loc_5, _loc_6), new V2(-_loc_5, _loc_6)]);
            this.orientVertices(_loc_7, param3, param4);
            return this.polygon(_loc_7);
        }// end function

        public function circle(param1:Number = 0, param2:V2 = null) : b2Fixture
        {
            var _loc_5:* = null;
            if (!param2)
            {
            }
            param2 = new V2();
            if (param1 == 0)
            {
                _loc_5 = Util.bounds(this);
                param1 = _loc_5.width / 2;
            }
            var _loc_3:* = param2.clone();
            var _loc_4:* = this.Vector.<V2>([_loc_3, new V2(_loc_3.x + param1, _loc_3.y)]);
            this.transformVertices(_loc_4);
            b2Def.circle.m_radius = _loc_4[0].distance(_loc_4[1]);
            b2Def.circle.m_p.x = _loc_4[0].x;
            b2Def.circle.m_p.y = _loc_4[0].y;
            this.initFixtureDef();
            b2Def.fixture.shape = b2Def.circle;
            return this.createFixture();
        }// end function

        public function oval(param1:Number = 0, param2:Number = 0, param3:V2 = null, param4:uint = 0, param5:Number = 4, param6:Number = 0) : Array
        {
            var _loc_17:* = null;
            var _loc_18:* = NaN;
            var _loc_19:* = null;
            var _loc_20:* = 0;
            var _loc_21:* = 0;
            var _loc_22:* = NaN;
            if (!param3)
            {
            }
            param3 = new V2();
            if (param1 == 0)
            {
                _loc_17 = Util.bounds(this);
                param1 = _loc_17.width;
                param2 = _loc_17.height;
            }
            var _loc_7:* = param1 / 2;
            var _loc_8:* = param2 / 2;
            var _loc_9:* = Util.localizePoint(this.world, this, new Point(_loc_7, 0));
            var _loc_10:* = Util.localizePoint(this.world, this, new Point(0, _loc_8));
            var _loc_11:* = Util.localizePoint(this.world, this);
            var _loc_12:* = Point.distance(_loc_9, _loc_11);
            var _loc_13:* = Point.distance(_loc_10, _loc_11);
            var _loc_14:* = Math.abs(_loc_12 - _loc_13);
            if (_loc_14 < 2)
            {
                return [this.circle(_loc_7, param3)];
            }
            if (param4 == 0)
            {
                _loc_18 = Point.distance(_loc_9, _loc_10);
                param4 = Math.round(_loc_18 / this.world.scale * param5);
            }
            var _loc_15:* = [];
            param4 = Math.max(param4, 12);
            var _loc_16:* = 1;
            while (_loc_16 < param4)
            {
                
                _loc_19 = this.Vector.<V2>([new V2(_loc_7, 0)]);
                _loc_20 = Math.min(_loc_16 + 6, (param4 - 1));
                _loc_21 = _loc_16;
                while (_loc_21 <= _loc_20)
                {
                    
                    _loc_22 = _loc_21 / param4 * Math.PI * 2;
                    _loc_19.push(new V2(_loc_7 * Math.cos(_loc_22), _loc_8 * Math.sin(_loc_22)));
                    _loc_21 = _loc_21 + 1;
                }
                this.orientVertices(_loc_19, param3, param6);
                _loc_15.push(this.polygon(_loc_19));
                _loc_16 = _loc_16 + 6;
            }
            return _loc_15;
        }// end function

        public function polyN(param1:uint = 5, param2:Number = 0, param3:V2 = null, param4:Number = 0) : b2Fixture
        {
            if (!param3)
            {
            }
            param3 = new V2();
            if (param2 == 0)
            {
                param2 = Util.bounds(this).top;
            }
            var _loc_5:* = new Vector.<V2>;
            var _loc_6:* = 0;
            while (_loc_6 < param1)
            {
                
                _loc_5.push(new V2(0, param2).rotate(_loc_6 / param1 * Math.PI * 2));
                _loc_6 = _loc_6 + 1;
            }
            this.orientVertices(_loc_5, param3, param4);
            return this.polygon(_loc_5);
        }// end function

        public function arc(param1:Number = 360, param2:uint = 0, param3:Number = 0, param4:V2 = null, param5:Number = 0, param6:Number = 4) : Array
        {
            var _loc_10:* = NaN;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            if (!param4)
            {
            }
            param4 = new V2();
            if (param3 == 0)
            {
                param3 = Util.bounds(this).top;
            }
            if (param2 == 0)
            {
                _loc_10 = Point.distance(Util.localizePoint(this.world, this, new Point(param3, 0)), Util.localizePoint(this.world, this, new Point(0, param3)));
                param2 = Math.round(_loc_10 / this.world.scale * param6);
            }
            param2 = Math.max(param2, 12);
            var _loc_7:* = Util.D2R * param1;
            var _loc_8:* = [];
            var _loc_9:* = 0;
            while (_loc_9 < param2)
            {
                
                _loc_11 = this.Vector.<V2>([new V2()]);
                _loc_12 = Math.min(_loc_9 + 4, param2);
                _loc_13 = _loc_9;
                while (_loc_13 <= _loc_12)
                {
                    
                    _loc_11.push(new V2(0, param3).rotate(_loc_13 / param2 * _loc_7));
                    _loc_13 = _loc_13 + 1;
                }
                this.orientVertices(_loc_11, param4, param5);
                _loc_8.push(this.polygon(_loc_11));
                _loc_9 = _loc_9 + 4;
            }
            return _loc_8;
        }// end function

        public function edgeArc(param1:Number = 360, param2:uint = 0, param3:Number = 0, param4:V2 = null, param5:Number = 0, param6:Number = 8) : Array
        {
            var _loc_10:* = NaN;
            if (!param4)
            {
            }
            param4 = new V2();
            if (param3 == 0)
            {
                param3 = Util.bounds(this).top;
            }
            if (param2 == 0)
            {
                _loc_10 = Point.distance(Util.localizePoint(this.world, this, new Point(param3, 0)), Util.localizePoint(this.world, this, new Point(0, param3)));
                param2 = Math.round(_loc_10 / this.world.scale * param6);
            }
            var _loc_7:* = Util.D2R * param1;
            var _loc_8:* = new Vector.<V2>;
            var _loc_9:* = 0;
            while (_loc_9 <= param2)
            {
                
                _loc_8.push(new V2(0, param3).rotate(_loc_9 / param2 * _loc_7));
                _loc_9 = _loc_9 + 1;
            }
            this.orientVertices(_loc_8, param4, param5);
            return this.edges(_loc_8);
        }// end function

        public function lineArc(param1:Number = 360, param2:uint = 0, param3:Number = 0, param4:V2 = null, param5:Number = 0, param6:Number = 8) : Array
        {
            var _loc_11:* = NaN;
            if (!param4)
            {
            }
            param4 = new V2();
            if (param3 == 0)
            {
                param3 = Util.bounds(this).top;
            }
            if (param2 == 0)
            {
                _loc_11 = Point.distance(Util.localizePoint(this.world, this, new Point(param3, 0)), Util.localizePoint(this.world, this, new Point(0, param3)));
                param2 = Math.round(_loc_11 / this.world.scale * param6);
            }
            var _loc_7:* = Util.D2R * param1;
            var _loc_8:* = [];
            var _loc_9:* = this.Vector.<V2>([new V2(0, param3)]);
            var _loc_10:* = 0;
            while (_loc_10 < param2)
            {
                
                _loc_9[1] = new V2(0, param3).rotate((_loc_10 + 1) / param2 * _loc_7);
                this.orientVertices(_loc_9, param4, param5);
                _loc_8.push(this.line(_loc_9[0], _loc_9[1]));
                _loc_9[0].x = _loc_9[1].x;
                _loc_9[0].y = _loc_9[1].y;
                _loc_10 = _loc_10 + 1;
            }
            return _loc_8;
        }// end function

        public function triangle(param1:Number = 0, param2:Number = 0, param3:V2 = null, param4:Number = 0) : b2Fixture
        {
            var _loc_8:* = null;
            if (!param3)
            {
            }
            param3 = new V2();
            if (param1 != 0)
            {
            }
            if (param2 == 0)
            {
                _loc_8 = Util.bounds(this);
                if (param1 == 0)
                {
                    param1 = _loc_8.width;
                }
                if (param2 == 0)
                {
                    param2 = _loc_8.height;
                }
            }
            var _loc_5:* = param1 / 2;
            var _loc_6:* = param2 / 2;
            var _loc_7:* = this.Vector.<V2>([new V2(-_loc_5, -_loc_6), new V2(_loc_5, _loc_6), new V2(-_loc_5, _loc_6)]);
            this.orientVertices(_loc_7, param3, param4);
            return this.polygon(_loc_7);
        }// end function

        public function line(param1:V2 = null, param2:V2 = null) : b2Fixture
        {
            var _loc_3:* = null;
            if (param1)
            {
            }
            if (!param2)
            {
                _loc_3 = Util.bounds(this);
                if (!param1)
                {
                }
                param1 = new V2(0, _loc_3.top);
                if (!param2)
                {
                }
                param2 = new V2(0, _loc_3.bottom);
            }
            return this.polygon(this.Vector.<V2>([param1, param2]));
        }// end function

        public function edge(param1:V2 = null, param2:V2 = null) : b2Fixture
        {
            var _loc_4:* = null;
            if (param1)
            {
            }
            if (!param2)
            {
                _loc_4 = Util.bounds(this);
                if (!param1)
                {
                }
                param1 = new V2(0, _loc_4.top);
                if (!param2)
                {
                }
                param2 = new V2(0, _loc_4.bottom);
            }
            var _loc_3:* = this.edges(this.Vector.<V2>([param1, param2]));
            return _loc_3[0];
        }// end function

        public function poly(param1:Array) : b2Fixture
        {
            var _loc_2:* = new Vector.<V2>;
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_2.push(new V2(param1[_loc_3][0], param1[_loc_3][1]));
                _loc_3 = _loc_3 + 1;
            }
            return this.polygon(_loc_2);
        }// end function

        public function polys(param1:Array) : Array
        {
            var _loc_2:* = [];
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_2.push(this.poly(param1[_loc_3]));
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        public function decomposedPoly(param1:Vector.<Number>) : Array
        {
            var _loc_2:* = 0;
            while (_loc_2 < param1.length)
            {
                
                param1[_loc_2] = param1[_loc_2] / this.world.scale;
                _loc_2 = _loc_2 + 1;
            }
            var _loc_3:* = b2PolygonShape.Decompose(param1);
            this.initFixtureDef();
            var _loc_4:* = [];
            _loc_2 = 0;
            while (_loc_2 < _loc_3.length)
            {
                
                b2Def.fixture.shape = _loc_3[_loc_2];
                _loc_4.push(this.createFixture());
                _loc_3[_loc_2].destroy();
                _loc_2 = _loc_2 + 1;
            }
            return _loc_4;
        }// end function

        public function polygon(param1:Vector.<V2>) : b2Fixture
        {
            this.transformVertices(param1);
            b2PolygonShape.EnsureCorrectVertexDirection(param1);
            b2Def.polygon.Set(param1);
            this.initFixtureDef();
            b2Def.fixture.shape = b2Def.polygon;
            return this.createFixture();
        }// end function

        public function edges(param1:Vector.<V2>) : Array
        {
            this.transformVertices(param1);
            this.initFixtureDef();
            b2Def.fixture.shape = b2Def.edge;
            var _loc_2:* = [];
            var _loc_3:* = 1;
            while (_loc_3 < param1.length)
            {
                
                b2Def.edge.m_vertex1.v2 = param1[(_loc_3 - 1)];
                b2Def.edge.m_vertex2.v2 = param1[_loc_3];
                b2Def.edge.m_hasVertex0 = _loc_3 > 1;
                b2Def.edge.m_hasVertex3 = (_loc_3 + 1) < param1.length;
                b2Def.edge.m_vertex0.v2 = b2Def.edge.m_hasVertex0 ? (param1[_loc_3 - 2]) : (new V2());
                b2Def.edge.m_vertex3.v2 = b2Def.edge.m_hasVertex3 ? (param1[(_loc_3 + 1)]) : (new V2());
                _loc_2.push(this.createFixture());
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        public function initFixtureDef() : void
        {
            var _loc_1:* = this.findGuideOwner();
            b2Def.fixture.friction = _loc_1._friction;
            b2Def.fixture.restitution = _loc_1._restitution;
            b2Def.fixture.density = _loc_1._density;
            b2Def.fixture.filter.categoryBits = _loc_1._categoryBits;
            b2Def.fixture.filter.maskBits = _loc_1._maskBits;
            b2Def.fixture.filter.groupIndex = _loc_1._groupIndex;
            b2Def.fixture.isSensor = _loc_1._isSensor;
            b2Def.fixture.userData = _loc_1;
            return;
        }// end function

        public function findGuideOwner() : BodyShape
        {
            var _loc_2:* = null;
            var _loc_1:* = this;
            while (_loc_1)
            {
                
                _loc_2 = _loc_1 as BodyShape;
                if (_loc_2)
                {
                }
                if (!_loc_2.isGuideShape)
                {
                    return _loc_2;
                }
                _loc_1 = _loc_1.parent;
            }
            return this;
        }// end function

        public function createFixture() : b2Fixture
        {
            var _loc_1:* = this.findGuideOwner();
            var _loc_2:* = new b2Fixture(this.b2body, b2Def.fixture, _loc_1);
            _loc_1.b2fixtures.push(_loc_2);
            _loc_2.m_reportBeginContact = _loc_1._reportBeginContact;
            _loc_2.m_reportEndContact = _loc_1._reportEndContact;
            _loc_2.m_reportPreSolve = _loc_1._reportPreSolve;
            _loc_2.m_reportPostSolve = _loc_1._reportPostSolve;
            _loc_2.m_conveyorBeltSpeed = _loc_1._conveyorBeltSpeed;
            _loc_2.m_bubbleContacts = _loc_1._bubbleContacts;
            return _loc_2;
        }// end function

        public function orientVertices(param1:Vector.<V2>, param2:V2 = null, param3:Number = 0) : void
        {
            var _loc_4:* = 0;
            if (!param2)
            {
            }
            param2 = new V2();
            if (param3 == 0)
            {
            }
            if (param2.x == 0)
            {
            }
            if (param2.y != 0)
            {
                _loc_4 = 0;
                while (_loc_4 < param1.length)
                {
                    
                    param1[_loc_4].rotate(Util.D2R * param3).add(param2);
                    _loc_4 = _loc_4 + 1;
                }
            }
            return;
        }// end function

        public function transformVertices(param1:Vector.<V2>) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < param1.length)
            {
                
                param1[_loc_2] = this.transformVertex(param1[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function transformVertex(param1:V2) : V2
        {
            var _loc_2:* = this.matrix.transformPoint(param1.toP());
            return new V2(_loc_2.x / this.world.scale, _loc_2.y / this.world.scale);
        }// end function

        override public function create() : void
        {
            this.world = Util.findAncestorOfClass(this, World) as World;
            if (this.world)
            {
            }
            if (this.world.disabled)
            {
                return;
            }
            this.world.ensureCreated();
            if (this.customGravityName != "")
            {
                this.customGravity = Util.getDisplayObjectByPath(this.world, this.customGravityName, this.world) as Gravity;
            }
            if (this.isGround)
            {
                this.world.doOutsideTimeStep(this.createShapes);
            }
            else
            {
                if (this.type != "Kinematic")
                {
                }
                if (this.type == "Animated")
                {
                    this.world.doOutsideTimeStep(this.createBody);
                }
                else
                {
                    this.body = Util.findAncestorOfClass(this, BodyShape) as BodyShape;
                    if (this.body)
                    {
                        if (!this.body.disabled)
                        {
                            this.body.ensureCreated();
                            if (this.body.world == this.world)
                            {
                                this.body = this.body.body;
                                this.world.doOutsideTimeStep(this.createShapes);
                            }
                            else
                            {
                                this.world.doOutsideTimeStep(this.createBody);
                            }
                        }
                    }
                    else if (this.world)
                    {
                        this.world.doOutsideTimeStep(this.createBody);
                    }
                }
            }
            super.create();
            return;
        }// end function

        override public function destroy() : void
        {
            this.customGravity = null;
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
                if (this.selfBody)
                {
                    this.destroyBody();
                }
                else
                {
                    if (this.body)
                    {
                    }
                    if (!this.body.disabled)
                    {
                        if (!this.body.created)
                        {
                        }
                    }
                    if (this.body.isGround)
                    {
                        this.destroyShapes();
                    }
                }
                this.world.doOutsideTimeStep(function () : void
            {
                b2body = null;
                b2fixtures = null;
                world = null;
                return;
            }// end function
            );
            }
            else
            {
                this.b2body = null;
                this.b2fixtures = null;
                this.world = null;
            }
            return;
        }// end function

        public function createBody() : void
        {
            this.selfBody = true;
            this.body = this;
            this.matrix = Util.localizeMatrix(this.world, this);
            b2Def.body.position.x = this.matrix.tx / this.world.scale;
            b2Def.body.position.y = this.matrix.ty / this.world.scale;
            b2Def.body.angle = Math.atan2(this.matrix.b, this.matrix.a);
            b2Def.body.linearVelocity.x = this._linearVelocity.x;
            b2Def.body.linearVelocity.y = this._linearVelocity.y;
            b2Def.body.angularVelocity = this._angularVelocity;
            b2Def.body.linearDamping = this._linearDamping;
            b2Def.body.angularDamping = this._angularDamping;
            b2Def.body.allowSleep = this._autoSleep;
            b2Def.body.awake = this._awake;
            b2Def.body.fixedRotation = this._fixedRotation;
            b2Def.body.bullet = this._bullet;
            b2Def.body.type = typeStringToInt(this._type);
            b2Def.body.active = this._active;
            b2Def.body.inertiaScale = this._inertiaScale;
            b2Def.body.userData = this;
            this.b2body = new b2Body(this.world.b2world, b2Def.body);
            this.matrix.tx = 0;
            this.matrix.ty = 0;
            var _loc_1:* = Math.atan2(-this.matrix.c, this.matrix.d) - Math.atan2(this.matrix.b, this.matrix.a);
            var _loc_2:* = Math.sqrt(this.matrix.c * this.matrix.c + this.matrix.d * this.matrix.d);
            this.matrix.c = (-_loc_2) * Math.sin(_loc_1);
            this.matrix.d = _loc_2 * Math.cos(_loc_1);
            this.matrix.a = Math.sqrt(this.matrix.a * this.matrix.a + this.matrix.b * this.matrix.b);
            this.matrix.b = 0;
            this.b2fixtures = new Vector.<b2Fixture>;
            this.createBufferedShapes();
            this.shapes();
            this.setUpdateMethod();
            return;
        }// end function

        public function setUpdateMethod() : void
        {
            stopListening(this.world, StepEvent.STEP, this.updateBodyMatrixSimple);
            stopListening(this.world, StepEvent.STEP, this.updateBodyMatrix);
            stopListening(this.world, StepEvent.STEP, this.updateTween);
            if (this._type == "Static")
            {
                return;
            }
            if (this._type == "Animated")
            {
                listenWhileVisible(this.world, StepEvent.STEP, this.updateTween, false, 2);
            }
            else if (parent == this.world)
            {
                listenWhileVisible(this.world, StepEvent.STEP, this.updateBodyMatrixSimple, false, -10);
            }
            else
            {
                listenWhileVisible(this.world, StepEvent.STEP, this.updateBodyMatrix, false, -10);
            }
            return;
        }// end function

        public function syncTransform() : void
        {
            this.body.matrix = Util.localizeMatrix(this.world, this.body);
            var _loc_1:* = this.body.matrix.tx / this.world.scale;
            var _loc_2:* = this.body.matrix.ty / this.world.scale;
            var _loc_3:* = Math.atan2(this.matrix.b, this.matrix.a);
            this.b2body.SetTransform(new V2(_loc_1, _loc_2), _loc_3);
            return;
        }// end function

        public function updateTween(event:Event) : void
        {
            var _loc_2:* = this.b2body.m_xf.position.v2;
            var _loc_3:* = this.b2body.m_sweep.a;
            var _loc_4:* = V2.fromP(Util.localizePoint(this.world, this)).divideN(this.world.scale);
            var _loc_5:* = Util.findBetterAngleTarget(_loc_3 * Util.R2D, Util.localizeRotation(this.world, this)) * Util.D2R;
            var _loc_6:* = V2.subtract(_loc_4, _loc_2);
            var _loc_7:* = _loc_5 - _loc_3;
            if (_loc_6.length() <= b2Settings.b2_maxTranslation)
            {
            }
            if (_loc_7 > b2Settings.b2_maxRotation)
            {
                this.syncTransform();
                _loc_6.x = 0;
                _loc_6.y = 0;
                _loc_7 = 0;
            }
            else
            {
                _loc_6.divideN(this.world.timeStep);
                _loc_7 = _loc_7 / this.world.timeStep;
            }
            this.b2body.SetAwake(true);
            this.b2body.SetLinearVelocity(_loc_6);
            this.b2body.SetAngularVelocity(_loc_7);
            return;
        }// end function

        public function createShapes() : void
        {
            if (this.isGround)
            {
                this.matrix = Util.localizeMatrix(this.world, this);
                this.body = this;
                this.b2body = this.world.b2world.m_groundBody;
            }
            else
            {
                this.body.ensureCreated();
                this.b2body = this.body.b2body;
                this.matrix = Util.localizeMatrix(this.body, this);
                this.matrix.concat(this.body.matrix);
            }
            this.selfBody = false;
            this.b2fixtures = new Vector.<b2Fixture>;
            this.shapes();
            this.createBufferedShapes();
            return;
        }// end function

        public function destroyBody() : void
        {
            this.world.doOutsideTimeStep(function () : void
            {
                b2body.destroy();
                return;
            }// end function
            );
            return;
        }// end function

        public function destroyShapes() : void
        {
            this.world.doOutsideTimeStep(function () : void
            {
                var _loc_1:* = 0;
                while (_loc_1 < b2fixtures.length)
                {
                    
                    b2fixtures[_loc_1].destroy();
                    b2fixtures[_loc_1] = null;
                    _loc_1 = _loc_1 + 1;
                }
                b2fixtures.length = 0;
                return;
            }// end function
            );
            return;
        }// end function

        public function updateBodyMatrix(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this.matrix.clone();
            _loc_2.rotate(this.b2body.m_sweep.a % Util.PI2);
            _loc_2.translate(this.b2body.m_xf.position.x * this.world.scale, this.b2body.m_xf.position.y * this.world.scale);
            if (parent != this.world)
            {
                _loc_3 = Util.localizeMatrix(this.world, parent);
                _loc_3.invert();
                _loc_2.concat(_loc_3);
            }
            transform.matrix = _loc_2;
            return;
        }// end function

        public function updateBodyMatrixSimple(event:Event) : void
        {
            rotation = this.b2body.m_sweep.a * Util.R2D % 360;
            x = this.b2body.m_xf.position.x * this.world.scale;
            y = this.b2body.m_xf.position.y * this.world.scale;
            return;
        }// end function

        public function modifyGravity(param1:V2) : void
        {
            param1.multiplyN(this.gravityScale);
            if (this.gravityAngle != 0)
            {
                param1.rotate(this.gravityAngle * Util.D2R);
            }
            return;
        }// end function

        public static function typeStringToInt(param1:String) : int
        {
            return {Static:b2Body.b2_staticBody, Kinematic:b2Body.b2_kinematicBody, Dynamic:b2Body.b2_dynamicBody, Animated:b2Body.b2_kinematicBody}[param1];
        }// end function

    }
}
