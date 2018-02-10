package wcks
{
    import flash.display.*;
    import flash.geom.*;
    import wcks.Box2DAS.Collision.*;
    import wcks.Box2DAS.Collision.Shapes.*;
    import wcks.Box2DAS.Common.*;
    import wcks.Box2DAS.Dynamics.*;
    import wcks.misc.*;
    import wcks.wck.*;

    public class WcksManager extends WCK
    {
        public var world:WcksWorld;
        private var scale:Number;
        private var _bodyAr:Array;
        private static var _instance:WcksManager;

        public function WcksManager()
        {
            this.world = new WcksWorld();
            this.addChild(this.world);
            this.scale = this.world.scale;
            this._bodyAr = new Array();
            return;
        }// end function

        public function get bodyAr() : Array
        {
            return this._bodyAr;
        }// end function

        public function getBodyByName(param1:String) : BodyShape
        {
            return this.bodyAr[param1];
        }// end function

        public function getBodyBySearchName(param1:String) : BodyShape
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in this.bodyAr)
            {
                
                _loc_3 = _loc_2.getChildAt((_loc_2.numChildren - 1)) as MovieClip;
                if (_loc_3.name.indexOf(param1) != -1)
                {
                }
                if (_loc_3.name.indexOf("begin") != -1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function creatBodyShape(param1:DisplayObjectContainer, param2:Class) : BodyShape
        {
            var _loc_3:* = null;
            _loc_3 = new param2;
            _loc_3.x = param1.x;
            _loc_3.y = param1.y;
            _loc_3.rotation = param1.rotation;
            _loc_3.scaleX = param1.scaleX;
            _loc_3.scaleY = param1.scaleY;
            var _loc_4:* = 0;
            param1.rotation = 0;
            param1.y = _loc_4;
            param1.x = _loc_4;
            var _loc_4:* = 1;
            param1.scaleY = 1;
            param1.scaleX = _loc_4;
            _loc_3.addChild(param1);
            this.bodyAr[param1.name] = _loc_3;
            return _loc_3;
        }// end function

        public function creatBodyShapeTwo(param1:DisplayObjectContainer, param2:Class) : BodyShape
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            _loc_3 = new param2;
            if (param1.parent)
            {
                _loc_4 = param1.getRect(param1.parent);
                _loc_3.x = _loc_4.x + _loc_4.width * 0.5;
                _loc_3.y = _loc_4.y + _loc_4.height * 0.5;
            }
            else
            {
                _loc_3.x = param1.x;
                _loc_3.y = param1.y;
            }
            _loc_3.rotation = param1.rotation;
            _loc_3.scaleX = param1.scaleX;
            _loc_3.scaleY = param1.scaleY;
            param1.x = param1.x - _loc_3.x;
            param1.y = param1.y - _loc_3.y;
            param1.rotation = param1.rotation - _loc_3.rotation;
            var _loc_5:* = 1;
            param1.scaleY = 1;
            param1.scaleX = _loc_5;
            _loc_3.addChild(param1);
            this.bodyAr[param1.name] = _loc_3;
            return _loc_3;
        }// end function

        public function creatJoint(param1:DisplayObjectContainer, param2:String, param3:Boolean = false) : Joint
        {
            var _loc_4:* = new Joint();
            _loc_4.x = param1.x;
            _loc_4.y = param1.y;
            if (!param3)
            {
                if (param1.parent)
                {
                    param1.parent.removeChild(param1);
                }
            }
            else
            {
                param1.x = 0;
                param1.y = 0;
                _loc_4.addChild(param1);
            }
            _loc_4.jointName = param1.name;
            _loc_4.type = param2;
            return _loc_4;
        }// end function

        public function toBit(param1:DisplayObjectContainer, param2:Boolean = false) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < param1.numChildren)
            {
                
                _loc_4 = param1.getChildAt(_loc_3) as DisplayObjectContainer;
                if (_loc_4)
                {
                    this.toBit(_loc_4);
                }
                else
                {
                    _loc_5 = param1.getChildAt(_loc_3);
                    if (!(_loc_5 is Bitmap))
                    {
                        _loc_6 = new BitmapData(_loc_5.width, _loc_5.height, param2, 0);
                        _loc_7 = _loc_5.getRect(_loc_5);
                        _loc_6.draw(_loc_5, new Matrix(1, 0, 0, 1, -_loc_7.x, -_loc_7.y), null, null, null, true);
                        _loc_8 = new Bitmap(_loc_6);
                        _loc_8.x = _loc_7.x;
                        _loc_8.y = _loc_7.y;
                        param1.removeChildAt(_loc_3);
                        param1.addChildAt(_loc_8, _loc_3);
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function creatParallax(param1:MovieClip, param2:Number = 0.5, param3:Number = 0.5) : Parallax
        {
            var _loc_4:* = new Parallax();
            _loc_4.factorX = param2;
            _loc_4.factorY = param3;
            _loc_4.x = param1.x;
            _loc_4.y = param1.y;
            _loc_4.rotation = param1.rotation;
            _loc_4.scaleX = param1.scaleX;
            _loc_4.scaleY = param1.scaleY;
            var _loc_5:* = 0;
            param1.rotation = 0;
            param1.y = _loc_5;
            param1.x = _loc_5;
            var _loc_5:* = 1;
            param1.scaleY = 1;
            param1.scaleX = _loc_5;
            _loc_4.addChild(param1);
            return _loc_4;
        }// end function

        public function addToWorld(param1) : void
        {
            this.world.addChild(param1);
            return;
        }// end function

        public function ApplyImpulse(param1:BodyShape, param2:V2, param3:V2 = null) : void
        {
            if (param3 == null)
            {
                param3 = param1.b2body.GetWorldCenter();
            }
            param1.b2body.ApplyImpulse(param2, param3);
            return;
        }// end function

        public function physExplosion(param1:Point, param2:Number, param3:Number, param4:Array = null) : Array
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = undefined;
            var _loc_14:* = null;
            var _loc_5:* = this.getBodyAtPoint(param1, param2, true, false);
            var _loc_6:* = [];
            var _loc_7:* = 0;
            while (_loc_7 < _loc_5.length)
            {
                
                _loc_8 = _loc_5[_loc_7];
                if (param4 != null)
                {
                    if (param4.indexOf(_loc_8.GetUserData()) == -1)
                    {
                        ;
                    }
                }
                _loc_9 = _loc_8.GetWorldCenter();
                _loc_10 = new V2(_loc_9.x - param1.x / this.scale, _loc_9.y - param1.y / this.scale);
                _loc_11 = _loc_10.length();
                _loc_10.normalize();
                _loc_11 = _loc_11 * this.scale;
                if (_loc_11 <= param2)
                {
                    _loc_8.SetAwake(true);
                    _loc_12 = (param2 - _loc_11) / param2 * param3;
                    _loc_13 = _loc_8.GetUserData();
                    _loc_14 = new V2(_loc_10.x * _loc_12, _loc_10.y * _loc_12);
                    _loc_8.ApplyImpulse(_loc_14, _loc_8.GetWorldCenter());
                    _loc_6.push(_loc_8);
                }
                _loc_7 = _loc_7 + 1;
            }
            return _loc_6;
        }// end function

        public function getBodyAtPoint(param1:Point, param2:Number = 1, param3:Boolean = true, param4:Boolean = true) : Array
        {
            var vec:V2;
            var real_x:Number;
            var real_y:Number;
            var bodys:Array;
            var fixture:b2Fixture;
            var GetBodyCallback:Function;
            var point:* = param1;
            var radius:* = param2;
            var includeStatic:* = param3;
            var isTestPoint:* = param4;
            GetBodyCallback = function (param1:b2Fixture) : Boolean
            {
                var _loc_3:* = false;
                var _loc_2:* = param1.GetShape();
                if (param1.GetBody().GetType() == b2Body.b2_staticBody)
                {
                }
                if (includeStatic)
                {
                    _loc_3 = true;
                    if (isTestPoint)
                    {
                        _loc_3 = _loc_2.TestPoint(param1.GetBody().GetTransform(), vec);
                    }
                    if (_loc_3)
                    {
                        bodys.push(param1.GetBody());
                    }
                }
                return true;
            }// end function
            ;
            vec = new V2();
            real_x = point.x / this.scale;
            real_y = point.y / this.scale;
            vec.xy(real_x, real_y);
            var aabb:* = new AABB();
            aabb.lowerBound.xy(real_x - radius / this.scale, real_y - radius / this.scale);
            aabb.upperBound.xy(real_x + radius / this.scale, real_y + radius / this.scale);
            bodys;
            this.world.b2world.QueryAABB(GetBodyCallback, aabb);
            return bodys;
        }// end function

        public function getBodyShapeAtPoint(param1:Point, param2:Number = 1, param3:Boolean = true, param4:Boolean = true) : Array
        {
            var vec:V2;
            var real_x:Number;
            var real_y:Number;
            var bodys:Array;
            var fixture:b2Fixture;
            var GetBodyCallback:Function;
            var point:* = param1;
            var radius:* = param2;
            var includeStatic:* = param3;
            var isTestPoint:* = param4;
            GetBodyCallback = function (param1:b2Fixture) : Boolean
            {
                var _loc_3:* = false;
                var _loc_2:* = param1.GetShape();
                if (param1.GetBody().GetType() == b2Body.b2_staticBody)
                {
                }
                if (includeStatic)
                {
                    _loc_3 = true;
                    if (isTestPoint)
                    {
                        _loc_3 = _loc_2.TestPoint(param1.GetBody().GetTransform(), vec);
                    }
                    if (_loc_3)
                    {
                        bodys.push(param1);
                    }
                }
                return true;
            }// end function
            ;
            vec = new V2();
            real_x = point.x / this.scale;
            real_y = point.y / this.scale;
            vec.xy(real_x, real_y);
            var aabb:* = new AABB();
            aabb.lowerBound.xy(real_x - radius / this.scale, real_y - radius / this.scale);
            aabb.upperBound.xy(real_x + radius / this.scale, real_y + radius / this.scale);
            bodys;
            this.world.b2world.QueryAABB(GetBodyCallback, aabb);
            return bodys;
        }// end function

        public static function get instance() : WcksManager
        {
            if (_instance == null)
            {
                _instance = new WcksManager;
            }
            return _instance;
        }// end function

    }
}
