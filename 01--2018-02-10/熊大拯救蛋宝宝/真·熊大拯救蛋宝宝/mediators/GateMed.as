package mediators
{
    import com.greensock.easing.*;
    import defs.*;
    import facade.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import tcUtils.masked.*;
    import tcUtils.sound.*;

    public class GateMed extends SimpleMed
    {
        private var t:Object;

        public function GateMed(param1:String = "选关场景", param2:int = 1)
        {
            this.t = Gfacade.getInstance().mainGame;
            super(param1, param2);
            return;
        }// end function

        override protected function init() : void
        {
            super.init();
            Gfacade.getInstance().mainGame.container.stage.stageFocusRect = false;
            Gfacade.getInstance().mainGame.stage.focus = Gfacade.getInstance().mainGame.container;
            this.initBnFrame();
            return;
        }// end function

        override protected function onClick(event:MouseEvent) : void
        {
            var _mc:MovieClip;
            var e:* = event;
            super.onClick(e);
            switch(e.target.name)
            {
                case "更多游戏":
                {
                    GameSound.instance.playSoundEffect("按钮点击音乐", true, 155);
                    Def.moreGame();
                    break;
                }
                case "返回":
                {
                    this.destroy();
                    new CoverMed();
                    break;
                }
                default:
                {
                    if (e.target)
                    {
                    }
                    if (e.target is MovieClip)
                    {
                    }
                    if (e.target.txt)
                    {
                        GameSound.instance.playSoundEffect("按钮点击音乐");
                        Masked.instance.toDrakAndToLight(Gfacade.instance().mainGame.stage, Def.SEC, function () : void
            {
                destroy();
                Gfacade.instance().gameMed = new GameMed(int(e.target.txt.text));
                return;
            }// end function
            );
                    }
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function initBnFrame() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            Check.getInstance().checkGame(this.t);
            var _loc_1:* = 1;
            while (_loc_1 <= Def.totalGate)
            {
                
                _loc_2 = Gfacade.getInstance().mainGame.container.getChildByName("num" + _loc_1) as MovieClip;
                _loc_3 = _loc_2.getChildByName("txt") as TextField;
                _loc_3.text = _loc_1 + "";
                _loc_3.mouseEnabled = false;
                if (_loc_1 <= Def.throwNum)
                {
                    _loc_2.buttonMode = true;
                    _loc_2.gotoAndStop(1);
                }
                else
                {
                    _loc_2.gotoAndStop(2);
                    _loc_2.mouseEnabled = false;
                    _loc_2.mouseChildren = false;
                    _loc_2.buttonMode = false;
                }
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

    }
}
