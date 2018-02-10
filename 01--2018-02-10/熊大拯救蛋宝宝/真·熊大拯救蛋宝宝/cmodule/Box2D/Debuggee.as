package cmodule.Box2D
{

    public interface Debuggee
    {

        public function Debuggee();

        function cancelDebug() : void;

        function suspend() : void;

        function resume() : void;

        function get isRunning() : Boolean;

    }
}
