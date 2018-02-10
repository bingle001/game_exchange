package defs
{
    import flash.events.*;

    public class EventManager extends EventDispatcher
    {
        private var m_params:Object;
        private static var instance:EventManager;

        public function EventManager()
        {
            this.m_params = new Object();
            if (instance != null)
            {
                throw new Error("单例");
            }
            return;
        }// end function

        public function getObject(param1:String) : Object
        {
            return this.m_params[param1];
        }// end function

        public function eTo(param1:String, param2:Function, param3:String = null, param4:Object = null) : void
        {
            this.eAddEvent(param1, param2, param3, param4);
            this.eDispatchEvent(new Event(param1));
            return;
        }// end function

        public function eDispatchEvent(event:Event) : void
        {
            getInstance().dispatchEvent(event);
            return;
        }// end function

        public function eAddEvent(param1:String, param2:Function, param3:String = null, param4:Object = null) : void
        {
            getInstance().addEventListener(param1, param2);
            if (param3 != null)
            {
                this.m_params[param3] = param4;
            }
            return;
        }// end function

        public function eRemove(param1:String, param2:Function, param3:String = null) : void
        {
            getInstance().removeEventListener(param1, param2);
            if (param3 != null)
            {
                this.m_params[param3] = null;
            }
            return;
        }// end function

        public static function getInstance() : EventManager
        {
            if (instance == null)
            {
                instance = new EventManager;
            }
            return instance;
        }// end function

    }
}
