package wcks.Box2DAS.Common
{
    import flash.events.*;

    public class b2EventDispatcher extends b2Base implements IEventDispatcher
    {
        public var dispatcher:IEventDispatcher;

        public function b2EventDispatcher(param1:IEventDispatcher = null)
        {
            if (!param1)
            {
            }
            this.dispatcher = new EventDispatcher(this);
            return;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            this.dispatcher.addEventListener(param1, param2, param3, param4);
            return;
        }// end function

        public function dispatchEvent(event:Event) : Boolean
        {
            return this.dispatcher.dispatchEvent(event);
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return this.dispatcher.hasEventListener(param1);
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            this.dispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return this.dispatcher.willTrigger(param1);
        }// end function

    }
}
