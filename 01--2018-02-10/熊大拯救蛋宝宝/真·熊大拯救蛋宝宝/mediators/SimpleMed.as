package mediators
{
    import facade.*;
    import flash.display.*;
    import flash.events.*;
    import tcUtils.sound.*;

    public class SimpleMed extends Object
    {
        protected var musicBn:MovieClip;
        protected var zanTingBn:MovieClip;

        public function SimpleMed(param1:String, param2:int = 1)
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
            switch(event.target.name)
            {
                case "soundOff":
                {
                    GameSound.instance.isAllSound = false;
                    GameSound.instance.playSoundEffect("按钮声音2");
                    this.musicBn.gotoAndStop(2);
                    break;
                }
                case "soundOn":
                {
                    GameSound.instance.isAllSound = true;
                    GameSound.instance.playSoundEffect("按钮声音2");
                    this.musicBn.gotoAndStop(1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function init() : void
        {
            this.musicBn = Gfacade.instance().mainGame.getMovie("musicBn");
            this.musicBn.buttonMode = true;
            if (GameSound.instance.isAllSound)
            {
                this.musicBn.gotoAndStop(1);
            }
            else
            {
                this.musicBn.gotoAndStop(2);
            }
            return;
        }// end function

    }
}
