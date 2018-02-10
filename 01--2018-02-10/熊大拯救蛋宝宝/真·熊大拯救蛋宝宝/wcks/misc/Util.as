package wcks.misc
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class Util extends Object
    {
        public static const D2R:Number = 0.0174533;
        public static const R2D:Number = 57.2958;
        public static const PI2:Number = 6.28319;

        public function Util()
        {
            return;
        }// end function

        public static function remove(param1:DisplayObject) : void
        {
            if (param1)
            {
            }
            if (param1.parent)
            {
                param1.parent.removeChild(param1);
            }
            return;
        }// end function

        public static function relocate(param1:DisplayObject, param2:DisplayObjectContainer, param3:int = -1, param4:Function = null) : void
        {
            var _loc_5:* = localizeMatrix(param2, param1);
            param1.transform.matrix = _loc_5;
            remove(param1);
            if (param4 != null)
            {
                Util.param4();
            }
            param2.addChildAt(param1, param3 == -1 ? (param2.numChildren) : (param3));
            return;
        }// end function

        public static function setPos(param1:DisplayObject, param2) : void
        {
            param1.x = param2.x;
            param1.y = param2.y;
            return;
        }// end function

        public static function addChildAtPos(param1:DisplayObjectContainer, param2:DisplayObject, param3, param4:int = -1) : void
        {
            setPos(param2, param3);
            if (param4 == -1)
            {
                param1.addChild(param2);
            }
            else
            {
                param1.addChildAt(param2, param4);
            }
            return;
        }// end function

        public static function addChildAtPosOf(param1:DisplayObjectContainer, param2:DisplayObject, param3:DisplayObject, param4:int = -1, param5:Point = null) : void
        {
            addChildAtPos(param1, param2, Util.localizePoint(param1, param3, param5), param4);
            return;
        }// end function

        public static function addChildUnder(param1:DisplayObject, param2:DisplayObject, param3:Boolean = true) : void
        {
            if (param2.parent)
            {
                if (param2.parent == param1.parent)
                {
                    remove(param1);
                }
                param2.parent.addChildAt(param1, param2.parent.getChildIndex(param2));
                if (param3)
                {
                    setPos(param1, param2);
                }
            }
            return;
        }// end function

        public static function addChildAbove(param1:DisplayObject, param2:DisplayObject, param3:Boolean = true) : void
        {
            var _loc_4:* = 0;
            if (param2.parent)
            {
                if (param2.parent == param1.parent)
                {
                    remove(param1);
                }
                _loc_4 = param2.parent.getChildIndex(param2) + 1;
                param2.parent.addChildAt(param1, _loc_4);
                if (param3)
                {
                    setPos(param1, param2);
                }
            }
            return;
        }// end function

        public static function addChildUnderNested(param1:DisplayObject, param2:DisplayObject, param3:DisplayObject, param4:Boolean = true) : void
        {
            addChildUnder(param2, findChildContaining(param1, param3), param4);
            return;
        }// end function

        public static function addChildAboveNested(param1:DisplayObject, param2:DisplayObject, param3:DisplayObject, param4:Boolean = true) : void
        {
            addChildAbove(param2, findChildContaining(param1, param3), param4);
            return;
        }// end function

        public static function removeChildren(param1:DisplayObjectContainer) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt(0);
            }
            return;
        }// end function

        public static function replace(param1:DisplayObject, param2:DisplayObject) : void
        {
            if (param1.parent)
            {
                param1.parent.addChildAt(param2, param1.parent.getChildIndex(param1));
                remove(param1);
            }
            return;
        }// end function

        public static function findChildContaining(param1:DisplayObject, param2:DisplayObject) : DisplayObject
        {
            do
            {
                
                param2 = param2.parent;
                if (param2)
                {
                }
            }while (param2.parent != param1)
            return param2;
        }// end function

        public static function dictionaryIsEmpty(param1:Dictionary) : Boolean
        {
            var _loc_2:* = undefined;
            for (_loc_2 in param1)
            {
                
                return false;
            }
            return true;
        }// end function

        public static function findAncestorOfClass(param1:DisplayObject, param2:Class, param3:Boolean = false) : DisplayObject
        {
            if (param3)
            {
            }
            if (param1 is param2)
            {
                return param1;
            }
            do
            {
                
                param1 = param1.parent;
                if (param1)
                {
                }
            }while (!(param1 as param2))
            return param1;
        }// end function

        public static function mergeObjects(param1:Object, param2:Object) : void
        {
            var _loc_3:* = null;
            for (_loc_3 in param2)
            {
                
                param1[_loc_3] = param2[_loc_3];
            }
            return;
        }// end function

        public static function rotateXY(param1:Array, param2:Number) : void
        {
            var _loc_3:* = param1[0];
            param1[0] = Math.cos(param2) * _loc_3 - Math.sin(param2) * param1[1];
            param1[1] = Math.sin(param2) * _loc_3 + Math.cos(param2) * param1[1];
            return;
        }// end function

        public static function stopInvisibleEnterFrame(param1:DisplayObject) : void
        {
            param1.addEventListener(Event.ENTER_FRAME, checkInvisibleEnterFrame, false, 9999999, true);
            return;
        }// end function

        public static function resumeInvisibleEnterFrame(param1:DisplayObject) : void
        {
            param1.removeEventListener(Event.ENTER_FRAME, checkInvisibleEnterFrame);
            return;
        }// end function

        public static function checkInvisibleEnterFrame(event:Event) : void
        {
            var _loc_2:* = event.target as DisplayObject;
            if (!_loc_2.stage)
            {
                event.stopImmediatePropagation();
            }
            return;
        }// end function

        public static function localizeMatrix(param1:DisplayObject, param2:DisplayObject) : Matrix
        {
            var _loc_5:* = null;
            var _loc_3:* = param2.transform.concatenatedMatrix;
            var _loc_4:* = param1.transform.concatenatedMatrix;
            _loc_4.invert();
            _loc_3.concat(_loc_4);
            if (!param2.cacheAsBitmap)
            {
            }
            if (param1.cacheAsBitmap)
            {
                _loc_5 = Util.localizePoint(param1, param2);
                _loc_3.tx = _loc_5.x;
                _loc_3.ty = _loc_5.y;
            }
            return _loc_3;
        }// end function

        public static function localizePoint(param1:DisplayObject, param2:DisplayObject, param3:Point = null) : Point
        {
            return param1.globalToLocal(param2.localToGlobal(param3 ? (param3) : (new Point(0, 0))));
        }// end function

        public static function localizeRotation(param1:DisplayObject, param2:DisplayObject, param3:Number = 0) : Number
        {
            return param3 + globalRotation(param2) - globalRotation(param1);
        }// end function

        public static function globalRotation(param1:DisplayObject) : Number
        {
            var _loc_2:* = param1.rotation;
            do
            {
                
                _loc_2 = _loc_2 + param1.rotation;
                var _loc_3:* = param1.parent;
                param1 = param1.parent;
            }while (_loc_3)
            return _loc_2;
        }// end function

        public static function getRoot(param1:DisplayObject) : DisplayObject
        {
            while (param1.parent)
            {
                
                param1 = param1.parent;
            }
            return param1;
        }// end function

        public static function bounds(param1:DisplayObject, param2:Boolean = false) : Rectangle
        {
            return param2 ? (param1.getBounds(param1)) : (param1.getRect(param1));
        }// end function

        public static function getDisplayObjectByPath(param1:DisplayObject, param2:String, param3:DisplayObjectContainer = null) : DisplayObject
        {
            if (param2.charAt(0) == "/")
            {
                param1 = param3 ? (param3) : (getRoot(param1));
                param2 = param2.substr(1);
            }
            var _loc_4:* = param2.split("/");
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4.length)
            {
                
                if (_loc_4[_loc_5] == "..")
                {
                    param1 = param1.parent;
                }
                else if (_loc_4[_loc_5] != ".")
                {
                    param1 = (param1 as DisplayObjectContainer).getChildByName(_loc_4[_loc_5]);
                }
                _loc_5 = _loc_5 + 1;
            }
            return param1;
        }// end function

        public static function getObjectsUnderPointByClass(param1:DisplayObjectContainer, param2:Point, param3:Class, param4:int = 0, param5:Array = null, param6:Boolean = true) : Array
        {
            var _loc_10:* = null;
            var _loc_11:* = false;
            var _loc_7:* = param1.stage.getObjectsUnderPoint(param2);
            var _loc_8:* = [];
            if (!param5)
            {
            }
            param5 = [];
            var _loc_9:* = _loc_7.length - 1;
            while (_loc_9 >= 0)
            {
                
                _loc_10 = _loc_7[_loc_9];
                _loc_11 = false;
                while (_loc_10)
                {
                    
                    if (param5.indexOf(_loc_10) == -1)
                    {
                        if (_loc_10 is param3)
                        {
                            _loc_8.push(_loc_10);
                            if (true)
                            {
                            }
                            _loc_11 = param6;
                            if (param4 > 0)
                            {
                            }
                            if (_loc_8.length == param4)
                            {
                                return _loc_8;
                            }
                            param5.push(_loc_10);
                        }
                    }
                    _loc_10 = _loc_11 ? (null) : (_loc_10.parent);
                }
                _loc_9 = _loc_9 - 1;
            }
            return _loc_8;
        }// end function

        public static function sign(param1:Number) : int
        {
            return isNaN(param1) ? (0) : (param1 > 0 ? (1) : (param1 < 0 ? (-1) : (0)));
        }// end function

        public static function incrementAngleToTarget(param1:Number, param2:Number, param3:Number) : Number
        {
            param2 = findBetterAngleTarget(param1, param2);
            if (param2 > param1)
            {
                param1 = param1 + param3;
                if (param1 > param2)
                {
                    param1 = param2;
                }
            }
            else if (param1 > param2)
            {
                param1 = param1 - param3;
                if (param2 > param1)
                {
                    param1 = param2;
                }
            }
            return param1;
        }// end function

        public static function findBetterAngleTarget(param1:Number, param2:Number) : Number
        {
            var _loc_3:* = param2 % 360;
            _loc_3 = param1 + _loc_3 - param1 % 360;
            if (_loc_3 - param1 > 180)
            {
                _loc_3 = _loc_3 - 360;
            }
            else if (param1 - _loc_3 > 180)
            {
                _loc_3 = _loc_3 + 360;
            }
            return _loc_3;
        }// end function

        public static function linearEase(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            return param2 + param3 * param1 / param4;
        }// end function

        public static function sinEaseIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            return (-param3) * Math.cos(param1 / param4 * (Math.PI / 2)) + param3 + param2;
        }// end function

        public static function sinEaseOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            return param3 * Math.sin(param1 / param4 * (Math.PI / 2)) + param2;
        }// end function

        public static function sinEaseInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            return (-param3) / 2 * (Math.cos(Math.PI * param1 / param4) - 1) + param2;
        }// end function

        public static function sleep(param1:int) : void
        {
            var _loc_2:* = getTimer();
            while (getTimer() - _loc_2 < param1)
            {
                
            }
            return;
        }// end function

        public static function killEvent(event:Event) : void
        {
            event.stopImmediatePropagation();
            return;
        }// end function

    }
}
