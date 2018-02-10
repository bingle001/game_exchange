package tcUtils.masked
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class Masked extends Sprite
    {
        private var repeat:int;
        private var timer:Timer;
        private var fun:Function;
        private var fun1:Function;
        private var fun2:Function;
        private var isToLight:Boolean = false;
        private static var _instance:Masked;

        public function Masked(param1:Number, param2:Number = 733, param3:Number = 550)
        {
            this.graphics.beginFill(0);
            this.graphics.drawRect(0, 0, param2, param3);
            this.graphics.endFill();
            this.repeat = int(param1 * 1000 / 50);
            this.timer = new Timer(50, this.repeat);
            return;
        }// end function

        public function toDrakAndToLight(param1:Stage, param2:Number, param3:Function = null, param4:Function = null) : void
        {
            var stage:* = param1;
            var time:* = param2;
            var _fun1:* = param3;
            var _fun2:* = param4;
            this.repeat = int(time * 1000 / 50);
            this.timer.repeatCount = this.repeat;
            stage.addChild(this);
            this.graphics.clear();
            this.graphics.beginFill(0);
            this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
            this.graphics.endFill();
            this.isToLight = true;
            this.fun1 = _fun1;
            this.fun2 = _fun2;
            this.toDrak(function () : void
            {
                if (fun1 != null)
                {
                    fun1();
                    fun1 = null;
                }
                toLight(fun2);
                fun2 = null;
                return;
            }// end function
            );
            return;
        }// end function

        public function toDrak(param1:Function = null) : void
        {
            this.timer.addEventListener(TimerEvent.TIMER, this.onTimer1);
            this.timer.reset();
            this.timer.start();
            this.alpha = 0;
            this.fun = param1;
            return;
        }// end function

        private function onTimer1(event:Event) : void
        {
            this.alpha = this.timer.currentCount / this.repeat;
            if (this.timer.currentCount == this.repeat)
            {
                this.timer.stop();
                this.timer.removeEventListener(TimerEvent.TIMER, this.onTimer1);
                if (this.fun != null)
                {
                    this.fun();
                }
                if (!this.isToLight)
                {
                    this.fun = null;
                    if (this.parent)
                    {
                        this.parent.removeChild(this);
                    }
                }
            }
            return;
        }// end function

        public function toLight(param1:Function = null) : void
        {
            this.timer.addEventListener(TimerEvent.TIMER, this.onTimer2);
            this.timer.reset();
            this.timer.start();
            this.alpha = 1;
            this.fun = param1;
            return;
        }// end function

        private function onTimer2(event:Event) : void
        {
            this.alpha = (this.repeat - this.timer.currentCount) / this.repeat;
            if (this.timer.currentCount == this.repeat)
            {
                this.timer.stop();
                this.timer.removeEventListener(TimerEvent.TIMER, this.onTimer2);
                if (this.fun != null)
                {
                    this.fun();
                    this.fun = null;
                }
                if (this.parent)
                {
                    this.parent.removeChild(this);
                }
            }
            return;
        }// end function

        public static function get instance() : Masked
        {
            if (_instance == null)
            {
                _instance = new Masked(1);
            }
            return _instance;
        }// end function

    }
}
