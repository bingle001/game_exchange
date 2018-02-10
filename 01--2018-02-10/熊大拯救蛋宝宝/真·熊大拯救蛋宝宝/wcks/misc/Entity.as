package wcks.misc
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class Entity extends MovieClip
    {
        public var disabled:Boolean = false;
        public var listeningTo:DictionaryTree;
        public var created:Boolean = false;
        public var removeRec:Rectangle;
        public var index:int;
        public var par:DisplayObjectContainer;
        private var oriAr:Array;

        public function Entity()
        {
            this.listeningTo = new DictionaryTree();
            addEventListener(Event.ADDED_TO_STAGE, stage ? (this.handlePublishedOnStage) : (this.handleAddedToStage));
            return;
        }// end function

        public function create() : void
        {
            return;
        }// end function

        public function destroy() : void
        {
            return;
        }// end function

        public function ensureCreated() : void
        {
            if (!this.created)
            {
            }
            if (!this.disabled)
            {
                this.created = true;
                this.create();
                addEventListener(Event.REMOVED_FROM_STAGE, this.handleRemovedFromStage);
            }
            return;
        }// end function

        public function ensureDestroyed() : void
        {
            if (this.created)
            {
            }
            if (!this.disabled)
            {
                addEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage);
                this.removeAllListeners();
                this.destroy();
                this.created = false;
            }
            return;
        }// end function

        public function handlePublishedOnStage(event:Event) : void
        {
            var self:Entity;
            var s:Stage;
            var f:Function;
            var e:* = event;
            if (stage)
            {
                self;
                s = stage;
                stage.invalidate();
                f = function (event:Event) : void
            {
                if (self.stage)
                {
                    self.ensureCreated();
                }
                s.removeEventListener(Event.RENDER, f);
                return;
            }// end function
            ;
                stage.addEventListener(Event.RENDER, f);
            }
            removeEventListener(Event.ADDED_TO_STAGE, this.handlePublishedOnStage);
            addEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage);
            return;
        }// end function

        public function handleAddedToStage(event:Event) : void
        {
            this.ensureCreated();
            return;
        }// end function

        public function handleRemovedFromStage(event:Event) : void
        {
            this.ensureDestroyed();
            return;
        }// end function

        public function listenWhileVisible(param1:EventDispatcher, param2:String, param3:Function, param4:Boolean = false, param5:int = 0, param6:Boolean = false) : void
        {
            param1.addEventListener(param2, param3, param4, param5, param6);
            this.listeningTo.store([param1, param2, param3, param4], 1);
            return;
        }// end function

        public function listenOnceWhileVisible(param1:EventDispatcher, param2:String, param3:Function, param4:Boolean = false, param5:int = 0) : void
        {
            var f:Function;
            var ed:* = param1;
            var type:* = param2;
            var listener:* = param3;
            var useCapture:* = param4;
            var priority:* = param5;
            f = function (event:Event) : void
            {
                listener(event);
                stopListening(ed, type, f, useCapture);
                return;
            }// end function
            ;
            this.listenWhileVisible(ed, type, f, useCapture, priority);
            return;
        }// end function

        public function listenNTimesWhileVisible(param1:int, param2:EventDispatcher, param3:String, param4:Function, param5:Boolean = false, param6:int = 0) : void
        {
            var i:int;
            var f:Function;
            var n:* = param1;
            var ed:* = param2;
            var type:* = param3;
            var listener:* = param4;
            var useCapture:* = param5;
            var priority:* = param6;
            i;
            f = function (event:Event) : void
            {
                listener(event, i);
                if (++i == n)
                {
                    stopListening(ed, type, f, useCapture);
                }
                return;
            }// end function
            ;
            if (n > 0)
            {
                this.listenWhileVisible(ed, type, f, useCapture, priority);
            }
            return;
        }// end function

        public function stopListening(param1:EventDispatcher, param2:String, param3:Function, param4:Boolean = false) : void
        {
            param1.removeEventListener(param2, param3, param4);
            this.listeningTo.remove([param1, param2, param3, param4]);
            return;
        }// end function

        public function removeAllListeners() : void
        {
            this.listeningTo.forEach(function (param1:Array, param2:uint) : void
            {
                stopListening(param1[0], param1[1], param1[2], param1[3] as Boolean);
                return;
            }// end function
            , this);
            return;
        }// end function

        public function remove(... args) : void
        {
            Util.remove(this);
            return;
        }// end function

        public function setPos(param1) : void
        {
            Util.setPos(this, param1);
            return;
        }// end function

        public function playReverse() : void
        {
            this.stop();
            this.listenWhileVisible(this, Event.ENTER_FRAME, this.reverse);
            return;
        }// end function

        public function reverse(event:Event) : void
        {
            gotoAndStop(currentFrame == 0 ? (totalFrames) : ((currentFrame - 1)));
            return;
        }// end function

        override public function play() : void
        {
            this.stopListening(this, Event.ENTER_FRAME, this.reverse);
            super.play();
            return;
        }// end function

        override public function stop() : void
        {
            this.stopListening(this, Event.ENTER_FRAME, this.reverse);
            super.stop();
            return;
        }// end function

    }
}
