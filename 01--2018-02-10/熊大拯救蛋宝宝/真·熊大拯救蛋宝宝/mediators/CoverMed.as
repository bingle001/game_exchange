package mediators
{
    import com.greensock.*;
    import com.greensock.loading.core.*;
    import defs.*;
    import facade.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import tcUtils.masked.*;
    import tcUtils.sound.*;
    import wcks.misc.*;

    public class CoverMed extends SimpleMed
    {
        private var t:Object;
        private var ren:MovieClip;
        private var helpMc:MovieClip;

        public function CoverMed(param1:String = "首页")
        {
            this.t = Gfacade.getInstance().mainGame;
            super(param1);
            return;
        }// end function

        override protected function onClick(event:MouseEvent) : void
        {
            var _mc:MovieClip;
            var tx:Number;
            var ty:Number;
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
                case "双人游戏":
                {
                    Gfacade.getInstance().roleNum = 2;
                    this.startGame();
                    break;
                }
                case "三人游戏":
                {
                    Gfacade.getInstance().roleNum = 3;
                    this.startGame();
                    break;
                }
                case "单人游戏":
                {
                    Gfacade.getInstance().roleNum = 1;
                    this.startGame();
                    break;
                }
                case "继续游戏":
                {
                    GameSound.instance.playSoundEffect("按钮点击音乐");
                    Masked.instance.toDrakAndToLight(Gfacade.instance().mainGame.stage, Def.SEC, function () : void
            {
                destroy();
                new GameMed(Def.throwNum);
                return;
            }// end function
            );
                    break;
                }
                case "返回":
                {
                    break;
                }
                case "帮助按钮":
                {
                    break;
                }
                case "玩一次":
                {
                    break;
                }
                case "开始游戏":
                {
                    tx = Gfacade.getInstance().mainGame.stage.stageWidth * 0.5;
                    ty = Gfacade.getInstance().mainGame.stage.stageHeight * 0.5;
                    TweenLite.to(this.ren, 0.3, {x:tx, y:ty});
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function startGame() : void
        {
            GameSound.instance.playSoundEffect("按钮点击音乐");
            Masked.instance.toDrakAndToLight(Gfacade.instance().mainGame.stage, Def.SEC, function () : void
            {
                destroy();
                new GateMed();
                return;
            }// end function
            );
            return;
        }// end function

        override protected function init() : void
        {
            var lg43:MovieClip;
            var sm:SimpleButton;
            var tx:Number;
            var ty:Number;
            var m:SimpleButton;
            var ty2:Number;
            super.init();
            Gfacade.getInstance().mainGame.container.stage.stageFocusRect = false;
            Gfacade.getInstance().mainGame.stage.focus = Gfacade.getInstance().mainGame.container;
            lg43 = Gfacade.getInstance().mainGame.getMovie("lg43");
            var localDomainLC:* = new LocalConnection();
            var ul:* = localDomainLC.domain;
            if (ul.indexOf("4399") != -1)
            {
            }
            if (lg43 != null)
            {
                lg43.visible = true;
            }
            else if (lg43 != null)
            {
                lg43.visible = false;
            }
            var i:int;
            var j:int;
            sm = Gfacade.getInstance().mainGame.getMovie("单人游戏");
            tx = sm.x;
            ty = sm.y;
            sm.x = tx;
            TweenMax.to(sm, 0.452, {x:tx, y:ty, alpha:1, onComplete:function () : void
            {
                sm.x = tx;
                sm.y = ty;
                return;
            }// end function
            });
            m = Gfacade.getInstance().mainGame.getMovie("更多游戏");
            ty2 = m.y;
            TweenMax.to(m, 0.4513, {y:ty2, onComplete:function () : void
            {
                m.y = ty2;
                return;
            }// end function
            });
            var loa:* = new LoaderCore();
            var scr:* = new Scroller();
            var xyt:* = new XYTracer();
            return;
        }// end function

    }
}
