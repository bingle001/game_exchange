package mediators
{
    import facade.*;
    import flash.events.*;

    public class SimpleMed2 extends Object
    {

        public function SimpleMed2(param1:String, param2:int = 1)
        {
            Gfacade.instance().mainGame.container.gotoAndStop(param2, param1);
            this.init();
            this.start();
            return;
        }// end function

        protected function start() : void
        {
            Gfacade.instance().mainGame.container.addEventListener(MouseEvent.CLICK, this.onClick);
            return;
        }// end function

        protected function stop() : void
        {
            Gfacade.instance().mainGame.container.removeEventListener(MouseEvent.CLICK, this.onClick);
            return;
        }// end function

        protected function destroy() : void
        {
            this.stop();
            return;
        }// end function

        protected function onClick(event:MouseEvent) : void
        {
            return;
        }// end function

        protected function init() : void
        {
            return;
        }// end function

    }
}
