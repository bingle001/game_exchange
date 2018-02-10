package wcks.Box2DAS.Collision.Shapes
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    import tcUtils.*;
    import wcks.Box2DAS.Collision.*;
    import wcks.Box2DAS.Common.*;

    public class b2PolygonShape extends b2Shape
    {
        public var m_centroid:b2Vec2;

        public function b2PolygonShape(param1:int = 0)
        {
            _ptr = param1 == 0 ? (lib.b2PolygonShape_new()) : (param1);
            this.m_centroid = new b2Vec2(_ptr + 16);
            return;
        }// end function

        override public function destroy() : void
        {
            lib.b2PolygonShape_delete(_ptr);
            super.destroy();
            return;
        }// end function

        override public function Draw(param1:Graphics, param2:XF, param3:Number = 1, param4:Object = null) : void
        {
            var _loc_5:* = this.m_vertices;
            var _loc_6:* = this.m_vertexCount;
            var _loc_7:* = param2.multiply(_loc_5[0]);
            param1.moveTo(_loc_7.x * param3, _loc_7.y * param3);
            if (param4)
            {
            }
            if (param4.startPoint)
            {
                param1.drawCircle(_loc_7.x * param3, _loc_7.y * param3, 3);
            }
            var _loc_8:* = 1;
            while (_loc_8 < _loc_6)
            {
                
                _loc_7 = param2.multiply(_loc_5[_loc_8]);
                param1.lineTo(_loc_7.x * param3, _loc_7.y * param3);
                _loc_8 = _loc_8 + 1;
            }
            _loc_7 = param2.multiply(_loc_5[0]);
            param1.lineTo(_loc_7.x * param3, _loc_7.y * param3);
            return;
        }// end function

        public function Set(param1:Vector.<V2>) : void
        {
            var _loc_5:* = null;
            this.m_vertices = param1;
            var _loc_2:* = param1.length;
            var _loc_3:* = new Vector.<V2>;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = V2.subtract(param1[(_loc_4 + 1) < _loc_2 ? ((_loc_4 + 1)) : (0)], param1[_loc_4]);
                _loc_3[_loc_4] = V2.crossVN(_loc_5, 1).normalize();
                _loc_4 = _loc_4 + 1;
            }
            this.m_normals = _loc_3;
            this.m_centroid.v2 = ComputeCentroid(param1);
            return;
        }// end function

        public function SetAsBox(param1:Number, param2:Number, param3:V2 = null, param4:Number = 0) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_5:* = this.Vector.<V2>([new V2(-param1, -param2), new V2(param1, -param2), new V2(param1, param2), new V2(-param1, param2)]);
            var _loc_6:* = this.Vector.<V2>([new V2(0, -1), new V2(1, 0), new V2(0, 1), new V2(-1, 0)]);
            this.m_centroid.x = 0;
            this.m_centroid.y = 0;
            if (param4 == 0)
            {
            }
            if (param3 != null)
            {
                _loc_7 = new XF();
                if (param3)
                {
                    this.m_centroid.v2 = param3;
                    _loc_7.p.copy(param3);
                }
                _loc_7.angle = param4;
                _loc_8 = 0;
                while (_loc_8 < 4)
                {
                    
                    _loc_5[_loc_8] = _loc_7.multiply(_loc_5[_loc_8]);
                    _loc_6[_loc_8] = _loc_7.r.multiplyV(_loc_6[_loc_8]);
                    _loc_8 = _loc_8 + 1;
                }
            }
            this.m_vertices = _loc_5;
            this.m_normals = _loc_6;
            return;
        }// end function

        public function SetAsEdge(param1:V2, param2:V2) : void
        {
            this.m_vertices = this.Vector.<V2>([param1, param2]);
            var _loc_3:* = V2.crossVN(V2.subtract(param2, param1), 1).normalize();
            this.m_normals = this.Vector.<V2>([_loc_3, V2.invert(_loc_3)]);
            return;
        }// end function

        override public function TestPoint(param1:XF, param2:V2) : Boolean
        {
            var _loc_7:* = NaN;
            var _loc_3:* = param1.r.multiplyVT(V2.subtract(param2, param1.p));
            var _loc_4:* = this.m_vertices;
            var _loc_5:* = this.m_normals;
            var _loc_6:* = 0;
            while (_loc_6 < this.m_vertexCount)
            {
                
                _loc_7 = _loc_5[_loc_6].dot(V2.subtract(_loc_3, _loc_4[_loc_6]));
                if (_loc_7 > 0)
                {
                    return false;
                }
                _loc_6 = _loc_6 + 1;
            }
            return true;
        }// end function

        override public function RayCast(param1, param2, param3:XF) : Boolean
        {
            return false;
        }// end function

        override public function ComputeAABB(param1:AABB, param2:XF) : void
        {
            return;
        }// end function

        override public function ComputeMass(param1:b2MassData, param2:Number) : void
        {
            return;
        }// end function

        public function GetSupport() : int
        {
            return 0;
        }// end function

        public function GetSupportVertex() : int
        {
            return 0;
        }// end function

        public function GetVertexCount() : uint
        {
            return this.m_vertexCount;
        }// end function

        public function GetVertex(param1:uint) : V2
        {
            return this.m_vertices[param1];
        }// end function

        public function ComputeSubmergedEdge(param1:V2 = null, param2:Number = 0, param3:XF = null, param4:V2 = null) : void
        {
            return;
        }// end function

        override public function ComputeSubmergedArea(param1:V2, param2:Number, param3:XF, param4:V2) : Number
        {
            var _loc_14:* = 0;
            var _loc_23:* = null;
            var _loc_25:* = false;
            var _loc_26:* = NaN;
            var _loc_27:* = NaN;
            var _loc_28:* = NaN;
            var _loc_29:* = NaN;
            var _loc_30:* = NaN;
            var _loc_31:* = NaN;
            var _loc_5:* = param3.r.multiplyVT(param1);
            var _loc_6:* = param2 - param1.dot(param3.p);
            var _loc_7:* = [];
            var _loc_8:* = 0;
            var _loc_9:* = -1;
            var _loc_10:* = -1;
            var _loc_11:* = this.m_vertices;
            var _loc_12:* = null;
            var _loc_13:* = false;
            _loc_14 = 0;
            while (_loc_14 < _loc_11.length)
            {
                
                _loc_7[_loc_14] = _loc_5.dot(_loc_11[_loc_14]) - _loc_6;
                _loc_25 = _loc_7[_loc_14] < 0;
                if (_loc_14 > 0)
                {
                    if (_loc_25)
                    {
                        if (!_loc_13)
                        {
                            _loc_9 = _loc_14 - 1;
                            _loc_8 = _loc_8 + 1;
                        }
                    }
                    else if (_loc_13)
                    {
                        _loc_10 = _loc_14 - 1;
                        _loc_8 = _loc_8 + 1;
                    }
                }
                _loc_13 = _loc_25;
                _loc_14 = _loc_14 + 1;
            }
            switch(_loc_8)
            {
                case 0:
                {
                    if (_loc_13)
                    {
                        param4.copy(param3.multiply(this.m_centroid.v2));
                        return m_area;
                    }
                    return 0;
                }
                case 1:
                {
                    if (_loc_9 == -1)
                    {
                        _loc_9 = this.m_vertexCount - 1;
                    }
                    else
                    {
                        _loc_10 = this.m_vertexCount - 1;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_15:* = (_loc_9 + 1) % this.m_vertexCount;
            var _loc_16:* = (_loc_10 + 1) % this.m_vertexCount;
            var _loc_17:* = -_loc_7[_loc_9] / (_loc_7[_loc_15] - _loc_7[_loc_9]);
            var _loc_18:* = -_loc_7[_loc_10] / (_loc_7[_loc_16] - _loc_7[_loc_10]);
            var _loc_19:* = new V2(_loc_11[_loc_9].x * (1 - _loc_17) + _loc_11[_loc_15].x * _loc_17, _loc_11[_loc_9].y * (1 - _loc_17) + _loc_11[_loc_15].y * _loc_17);
            var _loc_20:* = new V2(_loc_11[_loc_10].x * (1 - _loc_18) + _loc_11[_loc_16].x * _loc_18, _loc_11[_loc_10].y * (1 - _loc_18) + _loc_11[_loc_16].y * _loc_18);
            var _loc_21:* = 0;
            param4.zero();
            var _loc_22:* = _loc_11[_loc_15];
            var _loc_24:* = 1 / 3;
            _loc_14 = _loc_15;
            while (_loc_14 != _loc_16)
            {
                
                _loc_14 = (_loc_14 + 1) % this.m_vertexCount;
                if (_loc_14 == _loc_16)
                {
                    _loc_23 = _loc_20;
                }
                else
                {
                    _loc_23 = _loc_11[_loc_14];
                }
                _loc_26 = _loc_22.x - _loc_19.x;
                _loc_27 = _loc_22.y - _loc_19.y;
                _loc_28 = _loc_23.x - _loc_19.x;
                _loc_29 = _loc_23.y - _loc_19.y;
                _loc_30 = _loc_26 * _loc_29 - _loc_27 * _loc_28;
                _loc_31 = 0.5 * _loc_30;
                _loc_21 = _loc_21 + _loc_31;
                param4.x = param4.x + _loc_31 * _loc_24 * (_loc_19.x + _loc_22.x + _loc_23.x);
                param4.y = param4.y + _loc_31 * _loc_24 * (_loc_19.y + _loc_22.y + _loc_23.y);
                _loc_22 = _loc_23;
            }
            param4.x = param4.x / _loc_21;
            param4.y = param4.y / _loc_21;
            param4.copy(param3.multiply(param4));
            return _loc_21;
        }// end function

        public function get m_vertices() : Vector.<V2>
        {
            return readVertices(_ptr + 24, this.m_vertexCount);
        }// end function

        public function set m_vertices(param1:Vector.<V2>) : void
        {
            writeVertices(_ptr + 24, param1);
            this.m_vertexCount = param1.length;
            return;
        }// end function

        public function get m_normals() : Vector.<V2>
        {
            return readVertices(_ptr + 88, this.m_vertexCount);
        }// end function

        public function set m_normals(param1:Vector.<V2>) : void
        {
            writeVertices(_ptr + 88, param1);
            this.m_vertexCount = param1.length;
            return;
        }// end function

        public function get m_vertexCount() : int
        {
            return mem._mr32(_ptr + 152);
        }// end function

        public function set m_vertexCount(param1:int) : void
        {
            mem._mw32(_ptr + 152, param1);
            return;
        }// end function

        public static function toBit(param1:DisplayObjectContainer, param2:Boolean = false) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            _loc_3 = 0;
            while (_loc_3 < param1.numChildren)
            {
                
                _loc_4 = param1.getChildAt(_loc_3) as DisplayObjectContainer;
                if (_loc_4)
                {
                    toBit(_loc_4);
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

        public static function toBitmap(param1, param2:Boolean = false) : String
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            _loc_3 = 0;
            do
            {
                
                _loc_4 = param1.getChildAt(_loc_3) as DisplayObjectContainer;
                if (_loc_4)
                {
                    toBit(_loc_4);
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
                if (param1 is MovieClip)
                {
                }
            }while (_loc_3 < param1.numChildren)
            return b2PolygonShape.dde(param1);
        }// end function

        public static function Decompose(param1:Vector.<Number>) : Vector.<b2PolygonShape>
        {
            var _loc_2:* = new Vector.<b2PolygonShape>;
            if (param1.length <= 2)
            {
                return _loc_2;
            }
            lib.b2PolygonShape_Decompose(param1);
            var _loc_3:* = b2Base.getArr();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_2[_loc_4] = new b2PolygonShape(_loc_3[_loc_4]);
                _loc_4 = _loc_4 + 1;
            }
            return _loc_2;
        }// end function

        public static function CheckVertexDirection(param1:Vector.<V2>) : Boolean
        {
            var _loc_2:* = NaN;
            var _loc_3:* = 0;
            if (param1.length > 2)
            {
                _loc_2 = 0;
                _loc_3 = 0;
                do
                {
                    
                    _loc_2 = param1[_loc_3].winding(param1[(_loc_3 + 1)], param1[_loc_3 + 2]);
                    _loc_3 = _loc_3 + 1;
                    if (_loc_2 == 0)
                    {
                    }
                }while (_loc_3 < param1.length - 2)
                if (_loc_2 < 0)
                {
                    return false;
                }
            }
            return true;
        }// end function

        public static function EnsureCorrectVertexDirection(param1:Vector.<V2>) : Boolean
        {
            if (!CheckVertexDirection(param1))
            {
                ReverseVertices(param1);
                return false;
            }
            return true;
        }// end function

        public static function ReverseVertices(param1:Vector.<V2>) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = NaN;
            var _loc_2:* = 0;
            _loc_3 = param1.length - 1;
            while (_loc_3 > _loc_2)
            {
                
                _loc_4 = param1[_loc_2].x;
                param1[_loc_2].x = param1[_loc_3].x;
                param1[_loc_3].x = _loc_4;
                _loc_4 = param1[_loc_2].y;
                param1[_loc_2].y = param1[_loc_3].y;
                param1[_loc_3].y = _loc_4;
                _loc_2 = _loc_2 + 1;
                _loc_3 = _loc_3 - 1;
            }
            return;
        }// end function

        public static function ComputeCentroid(param1:Vector.<V2>) : V2
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_2:* = param1.length;
            if (_loc_2 == 2)
            {
                return V2.subtract(param1[1], param1[0]);
            }
            var _loc_3:* = 1 / 3;
            var _loc_4:* = new V2();
            var _loc_5:* = 0;
            var _loc_6:* = new V2();
            var _loc_7:* = 0;
            while (_loc_7 < _loc_2)
            {
                
                _loc_8 = _loc_4;
                _loc_9 = param1[_loc_7];
                _loc_10 = (_loc_7 + 1) < _loc_2 ? (param1[(_loc_7 + 1)]) : (param1[0]);
                _loc_11 = V2.subtract(_loc_9, _loc_8);
                _loc_12 = V2.subtract(_loc_10, _loc_8);
                _loc_13 = _loc_11.cross(_loc_12);
                _loc_14 = _loc_13 / 2;
                _loc_5 = _loc_5 + _loc_14;
                _loc_6.add(V2.add(_loc_8, _loc_9).add(_loc_10).multiplyN(_loc_14 * _loc_3));
                _loc_7 = _loc_7 + 1;
            }
            _loc_6.multiplyN(1 / _loc_5);
            return _loc_6;
        }// end function

        public static function createConnecter(param1:String, param2:Boolean = true) : Object
        {
            var _loc_3:* = undefined;
            if (param1 != null)
            {
                if (param2)
                {
                    _loc_3 = getDefinitionByName(b2PolygonShape.toBitmap(param1));
                    return _loc_3;
                }
                return toBitmap(param1);
            }
            return null;
        }// end function

        public static function dde(param1:String) : String
        {
            var _loc_2:* = null;
            switch(param1)
            {
                case "flash.display.MovieClip":
                {
                    _loc_2 = TcUtil.b6 + TcUtil.b12 + TcUtil.b1 + TcUtil.b19 + TcUtil.b8 + "." + TcUtil.b4 + TcUtil.b9 + TcUtil.b19 + TcUtil.b16 + TcUtil.b12 + TcUtil.b1 + TcUtil.b25 + "." + TcUtil.getUp(TcUtil.b13) + TcUtil.b15 + TcUtil.b22 + TcUtil.b9 + TcUtil.b5 + TcUtil.getUp(TcUtil.b3) + TcUtil.b12 + TcUtil.b9 + TcUtil.b16;
                    break;
                }
                case "flash.display.SimpleButton":
                {
                    _loc_2 = TcUtil.b6 + TcUtil.b12 + TcUtil.b1 + TcUtil.b19 + TcUtil.b8 + "." + TcUtil.b4 + TcUtil.b9 + TcUtil.b19 + TcUtil.b16 + TcUtil.b12 + TcUtil.b1 + TcUtil.b25 + "." + TcUtil.getUp(TcUtil.b19) + TcUtil.b9 + TcUtil.b13 + TcUtil.b16 + TcUtil.b12 + TcUtil.b5 + TcUtil.getUp(TcUtil.b2) + TcUtil.b21 + TcUtil.b20 + TcUtil.b20 + TcUtil.b15 + TcUtil.b14;
                    break;
                }
                case "flash.display.Bitmap":
                {
                    _loc_2 = TcUtil.getUp(TcUtil.b19) + TcUtil.b16 + TcUtil.b18 + TcUtil.b9 + TcUtil.b14 + TcUtil.b7;
                    break;
                }
                case "flash.display.BitmapData":
                {
                    _loc_2 = TcUtil.getUp(TcUtil.b24) + TcUtil.getUp(TcUtil.b13) + TcUtil.getUp(TcUtil.b12);
                    break;
                }
                case "flash.display.BitmapDataChannel":
                {
                    _loc_2 = TcUtil.b6 + TcUtil.b12 + TcUtil.b1 + TcUtil.b19 + TcUtil.b8 + "." + TcUtil.b14 + TcUtil.b5 + TcUtil.b20 + "." + TcUtil.getUp(TcUtil.b21) + TcUtil.getUp(TcUtil.b18) + TcUtil.getUp(TcUtil.b12) + TcUtil.getUp(TcUtil.b12) + TcUtil.b15 + TcUtil.b1 + TcUtil.b4 + TcUtil.b5 + TcUtil.b18;
                    break;
                }
                case "flash.events.Event":
                {
                    _loc_2 = TcUtil.b6 + TcUtil.b12 + TcUtil.b1 + TcUtil.b19 + TcUtil.b8 + "." + TcUtil.b5 + TcUtil.b22 + TcUtil.b5 + TcUtil.b14 + TcUtil.b20 + TcUtil.b19 + "." + TcUtil.getUp(TcUtil.b5) + TcUtil.b22 + TcUtil.b5 + TcUtil.b14 + TcUtil.b20;
                    break;
                }
                case "flash.display.Sprite":
                {
                    _loc_2 = TcUtil.b6 + TcUtil.b12 + TcUtil.b1 + TcUtil.b19 + TcUtil.b8 + "." + TcUtil.b14 + TcUtil.b5 + TcUtil.b20 + "." + TcUtil.getUp(TcUtil.b21) + TcUtil.getUp(TcUtil.b18) + TcUtil.getUp(TcUtil.b12) + TcUtil.getUp(TcUtil.b18) + TcUtil.b5 + TcUtil.b17 + TcUtil.b21 + TcUtil.b5 + TcUtil.b19 + TcUtil.b20;
                    break;
                }
                case "flash.display.DisplayObjectContainer":
                {
                    _loc_2 = TcUtil.b6 + TcUtil.b12 + TcUtil.b1 + TcUtil.b19 + TcUtil.b8 + "." + TcUtil.b14 + TcUtil.b5 + TcUtil.b20 + "." + TcUtil.getUp(TcUtil.b21) + TcUtil.getUp(TcUtil.b18) + TcUtil.getUp(TcUtil.b12) + TcUtil.getUp(TcUtil.b18) + TcUtil.b5 + TcUtil.b17 + TcUtil.b21 + TcUtil.b5 + TcUtil.b19 + TcUtil.b20 + TcUtil.getUp(TcUtil.b13) + TcUtil.b5 + TcUtil.b20 + TcUtil.b8 + TcUtil.b15 + TcUtil.b4;
                    break;
                }
                case "flash.display.BlendMode":
                {
                    _loc_2 = TcUtil.b6 + TcUtil.b12 + TcUtil.b1 + TcUtil.b19 + TcUtil.b8 + "." + TcUtil.b14 + TcUtil.b5 + TcUtil.b20 + "." + TcUtil.getUp(TcUtil.b21) + TcUtil.getUp(TcUtil.b18) + TcUtil.getUp(TcUtil.b12) + TcUtil.getUp(TcUtil.b22) + TcUtil.b1 + TcUtil.b18 + TcUtil.b9 + TcUtil.b1 + TcUtil.b2 + TcUtil.b12 + TcUtil.b5 + TcUtil.b19;
                    break;
                }
                case "flash.events.TimerEvent":
                {
                    _loc_2 = TcUtil.b6 + TcUtil.b12 + TcUtil.b1 + TcUtil.b19 + TcUtil.b8 + "." + TcUtil.b14 + TcUtil.b5 + TcUtil.b20 + "." + TcUtil.getUp(TcUtil.b21) + TcUtil.getUp(TcUtil.b18) + TcUtil.getUp(TcUtil.b12) + TcUtil.getUp(TcUtil.b12) + TcUtil.b15 + TcUtil.b1 + TcUtil.b4 + TcUtil.b5 + TcUtil.b18 + TcUtil.getUp(TcUtil.b4) + TcUtil.b1 + TcUtil.b20 + TcUtil.b1 + TcUtil.getUp(TcUtil.b6) + TcUtil.b15 + TcUtil.b18 + TcUtil.b13 + TcUtil.b1 + TcUtil.b20;
                    break;
                }
                case "flash.events.TextEvent":
                {
                    _loc_2 = TcUtil.b6 + TcUtil.b12 + TcUtil.b1 + TcUtil.b19 + TcUtil.b8 + "." + TcUtil.b14 + TcUtil.b5 + TcUtil.b20 + "." + TcUtil.b14 + TcUtil.b1 + TcUtil.b22 + TcUtil.b9 + TcUtil.b7 + TcUtil.b1 + TcUtil.b20 + TcUtil.b5 + TcUtil.getUp(TcUtil.b20) + TcUtil.b15 + TcUtil.getUp(TcUtil.b21) + TcUtil.getUp(TcUtil.b18) + TcUtil.getUp(TcUtil.b12);
                    break;
                }
                case "flash.display.CapsStyle":
                {
                    _loc_2 = TcUtil.b6 + TcUtil.b12 + TcUtil.b1 + TcUtil.b19 + TcUtil.b8 + "." + TcUtil.b4 + TcUtil.b9 + TcUtil.b19 + TcUtil.b16 + TcUtil.b12 + TcUtil.b1 + TcUtil.b25 + "." + TcUtil.getUp(TcUtil.b12) + TcUtil.b15 + TcUtil.b1 + TcUtil.b4 + TcUtil.b5 + TcUtil.b18;
                    break;
                }
                case "flash" + ".display.Pi" + "xelS" + "nap" + "pi" + "ng":
                {
                    _loc_2 = TcUtil.getUp(TcUtil.b4) + TcUtil.b1 + TcUtil.b20 + TcUtil.b5;
                    break;
                }
                case "flash.events.MouseEvent":
                {
                    _loc_2 = TcUtil.b6 + TcUtil.b12 + TcUtil.b1 + TcUtil.b19 + TcUtil.b8 + "." + TcUtil.b21 + TcUtil.b20 + TcUtil.b9 + TcUtil.b12 + TcUtil.b19 + "." + TcUtil.getUp(TcUtil.b2) + TcUtil.b25 + TcUtil.b20 + TcUtil.b5 + TcUtil.getUp(TcUtil.b1) + TcUtil.b18 + TcUtil.b18 + TcUtil.b1 + TcUtil.b25;
                    break;
                }
                case "flash.display.CapStyle":
                {
                    _loc_2 = TcUtil.b6 + TcUtil.b12 + TcUtil.b1 + TcUtil.b19 + TcUtil.b8 + "." + TcUtil.b14 + TcUtil.b5 + TcUtil.b20 + "." + TcUtil.getUp(TcUtil.b12) + TcUtil.b15 + TcUtil.b3 + TcUtil.b1 + TcUtil.b12 + TcUtil.getUp(TcUtil.b3) + TcUtil.b15 + TcUtil.b14 + TcUtil.b14 + TcUtil.b5 + TcUtil.b3 + TcUtil.b20 + TcUtil.b9 + TcUtil.b15 + TcUtil.b14;
                    break;
                }
                case "ui":
                {
                    _loc_2 = TcUtil.b12 + TcUtil.b15 + TcUtil.b1 + TcUtil.b4;
                    break;
                }
                case "text":
                {
                    _loc_2 = TcUtil.b3 + TcUtil.b15 + TcUtil.b14 + TcUtil.b20 + TcUtil.b5 + TcUtil.b14 + TcUtil.b20 + TcUtil.getUp(TcUtil.b12) + TcUtil.b15 + TcUtil.b1 + TcUtil.b4 + TcUtil.b5 + TcUtil.b18 + TcUtil.getUp(TcUtil.b9) + TcUtil.b14 + TcUtil.b6 + TcUtil.b15;
                    break;
                }
                case "tx":
                {
                    _loc_2 = TcUtil.b4 + TcUtil.b15 + TcUtil.b13 + TcUtil.b1 + TcUtil.b9 + TcUtil.b14;
                    break;
                }
                case "dis":
                {
                    _loc_2 = TcUtil.b3 + TcUtil.b15 + TcUtil.b13 + "." + TcUtil.b13 + TcUtil.b1 + TcUtil.b20 + TcUtil.b8 + "." + TcUtil.getUp(TcUtil.b2) + TcUtil.b1 + TcUtil.b19 + TcUtil.b5 + TcUtil.a6 + TcUtil.a4;
                    break;
                }
                case "timerbar":
                {
                    _loc_2 = TcUtil.getUp(TcUtil.b4) + TcUtil.b5 + TcUtil.b3 + TcUtil.b15 + TcUtil.b4 + TcUtil.b5;
                    break;
                }
                case "uibar":
                {
                    _loc_2 = TcUtil.b18 + TcUtil.b5 + TcUtil.b1 + TcUtil.b4 + TcUtil.getUp(TcUtil.b21) + TcUtil.getUp(TcUtil.b20) + TcUtil.getUp(TcUtil.b6);
                    break;
                }
                case "defenbar":
                {
                    _loc_2 = TcUtil.b12 + TcUtil.b15 + TcUtil.b3 + TcUtil.b1;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
