package wcks.misc
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class Input extends Object
    {
        public static const MOUSE_UP_OR_LOST:String = "mouseUpOrLost";
        public static var mousePos:Point = new Point(-1000, -1000);
        public static var mouseTrackable:Boolean = false;
        public static var mouseDetected:Boolean = false;
        public static var mouseIsDown:Boolean = false;
        public static var keysDown:Dictionary = new Dictionary();
        public static var keysPressed:Dictionary = new Dictionary();
        public static var keysUp:Dictionary = new Dictionary();
        public static var stage:Stage;
        public static var initialized:Boolean = false;

        public function Input()
        {
            return;
        }// end function

        public static function initialize(param1:Stage, param2:Boolean = true) : void
        {
            if (initialized)
            {
                return;
            }
            initialized = true;
            if (param2)
            {
                param1.addEventListener(Event.ENTER_FRAME, handleEnterFrame, false, -1000, true);
            }
            param1.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown, false, 0, true);
            param1.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp, false, 0, true);
            param1.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp, false, 0, true);
            param1.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown, false, 0, true);
            param1.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove, false, 0, true);
            param1.addEventListener(Event.MOUSE_LEAVE, handleMouseLeave, false, 0, true);
            param1.addEventListener(Event.DEACTIVATE, handleDeactivate, false, 0, true);
            stage = param1;
            return;
        }// end function

        public static function handleKeyDown(event:KeyboardEvent) : void
        {
            if (!keysDown[event.keyCode])
            {
                keysPressed[event.keyCode] = true;
                keysDown[event.keyCode] = true;
            }
            return;
        }// end function

        public static function handleKeyUp(event:KeyboardEvent) : void
        {
            keysUp[event.keyCode] = true;
            delete keysDown[event.keyCode];
            return;
        }// end function

        public static function handleEnterFrame(event:Event) : void
        {
            clear();
            return;
        }// end function

        public static function clear() : void
        {
            keysUp = new Dictionary();
            keysPressed = new Dictionary();
            return;
        }// end function

        public static function handleMouseEvent(event:MouseEvent) : void
        {
            if (Math.abs(event.stageX) < 900000)
            {
                mousePos.x = event.stageX < 0 ? (0) : (event.stageX > stage.stageWidth ? (stage.stageWidth) : (event.stageX));
                mousePos.y = event.stageY < 0 ? (0) : (event.stageY > stage.stageHeight ? (stage.stageHeight) : (event.stageY));
            }
            mouseTrackable = true;
            mouseDetected = true;
            return;
        }// end function

        public static function mousePositionIn(param1:DisplayObject) : Point
        {
            return param1.globalToLocal(mousePos);
        }// end function

        public static function handleMouseDown(event:MouseEvent) : void
        {
            mouseIsDown = true;
            handleMouseEvent(event);
            return;
        }// end function

        public static function handleMouseUp(event:MouseEvent) : void
        {
            mouseIsDown = false;
            handleMouseEvent(event);
            stage.dispatchEvent(new Event(MOUSE_UP_OR_LOST));
            return;
        }// end function

        public static function handleMouseMove(event:MouseEvent) : void
        {
            handleMouseEvent(event);
            return;
        }// end function

        public static function handleMouseLeave(event:Event) : void
        {
            mouseIsDown = false;
            stage.dispatchEvent(new Event(MOUSE_UP_OR_LOST));
            mouseTrackable = false;
            return;
        }// end function

        public static function handleDeactivate(event:Event) : void
        {
            mouseIsDown = false;
            stage.dispatchEvent(new Event(MOUSE_UP_OR_LOST));
            mouseTrackable = false;
            return;
        }// end function

        public static function kd(... args) : Boolean
        {
            return keySearch(keysDown, args);
        }// end function

        public static function ku(... args) : Boolean
        {
            return keySearch(keysUp, args);
        }// end function

        public static function kp(... args) : Boolean
        {
            return keySearch(keysPressed, args);
        }// end function

        public static function keySearch(param1:Dictionary, param2:Array) : Boolean
        {
            var _loc_3:* = 0;
            while (_loc_3 < param2.length)
            {
                
                if (param1[KeyCodes[param2[_loc_3]]])
                {
                    return true;
                }
                _loc_3 = _loc_3 + 1;
            }
            return false;
        }// end function

    }
}
