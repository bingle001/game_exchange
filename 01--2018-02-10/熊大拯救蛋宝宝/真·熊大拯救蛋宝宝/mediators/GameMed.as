package mediators
{
    import com.greensock.*;
    import defs.*;
    import facade.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import mediators.eles.*;
    import mediators.eles.jing.*;
    import mediators.monsters.*;
    import mediators.roles.*;
    import tcUtils.*;
    import tcUtils.masked.*;
    import tcUtils.sound.*;
    import wcks.*;
    import wcks.wck.*;

    public class GameMed extends SimpleMed2
    {
        private var tongjiMc:MovieClip;
        private var mainGame:StoneMan2;
        public var staticBody:BodyShape;
        public var bottomFrame:MovieClip;
        private var curLevel:int;
        private var derailAr:Array;
        private var organAr:Array;
        private var derail2Ar:Array;
        private var derail3Ar:Array;
        private var derail4Ar:Array;
        private var derail5Ar:Array;
        private var sxAr:Array;
        private var zyAr:Array;
        private var huoAr:Array;
        private var overMc:MovieClip;
        public var fuhuoAr:Array;
        public var memo:Memo;
        private var maxCurScore:int = 2000;
        private var curScore:int = 0;
        public var oldlv:int;
        public var bg2:MovieClip;
        private var isWin:Boolean = false;
        private static var _instance:Gfacade;

        public function GameMed(param1:int)
        {
            var _loc_2:* = param1;
            this.curLevel = param1;
            Def.curLevel = _loc_2;
            this.oldlv = param1;
            Def.curScore = 0;
            Def.totalScore = 0;
            Gfacade.getInstance().roleDieNum = 0;
            this.derailAr = new Array();
            this.organAr = new Array();
            this.fuhuoAr = new Array();
            this.derail2Ar = new Array();
            this.derail3Ar = new Array();
            this.derail4Ar = new Array();
            this.derail5Ar = new Array();
            this.huoAr = new Array();
            this.sxAr = new Array();
            this.zyAr = new Array();
            super("游戏场景", param1);
            Gfacade.getInstance().mainGame.container.addChild(this.bottomFrame);
            this.bottomFrame.level.text = param1 + "";
            this.bottomFrame.ts.text = Def.totalScore + "";
            this.bottomFrame.cs.text = Def.curScore + "";
            return;
        }// end function

        public function setCurLive() : void
        {
            this.bottomFrame.lives.text = Gfacade.getInstance().role.lives + "";
            return;
        }// end function

        override protected function init() : void
        {
            var _loc_1:* = null;
            this.bottomFrame = Gfacade.getInstance().mainGame.getMovie("bui");
            this.bottomFrame.musicBn.buttonMode = true;
            this.bottomFrame.刷新.buttonMode = true;
            this.bottomFrame.返回首页.buttonMode = true;
            this.bottomFrame.更多游戏.buttonMode = true;
            this.bg2 = Gfacade.getInstance().mainGame.getMovie("bg2");
            this.initWord();
            this.initMap();
            this.initRole();
            for each (_loc_1 in this.huoAr)
            {
                
                Def.wck.addToWorld(_loc_1);
            }
            return;
        }// end function

        override protected function start() : void
        {
            super.start();
            EventManager.getInstance().eAddEvent(Def.WIN, this.onWin);
            EventManager.getInstance().eAddEvent(Def.FAIL, this.onFail);
            Gfacade.instance().role.addEvent();
            if (Gfacade.getInstance().judgeRole2())
            {
                Gfacade.instance().role2.addEvent();
            }
            Def.wck.world.paused = false;
            return;
        }// end function

        override protected function stop() : void
        {
            super.stop();
            EventManager.getInstance().eRemove(Def.WIN, this.onWin);
            EventManager.getInstance().eRemove(Def.FAIL, this.onFail);
            if (Gfacade.instance().role)
            {
                Gfacade.instance().role.removeEvent();
            }
            if (Gfacade.getInstance().judgeRole2())
            {
                Gfacade.instance().role2.removeEvent();
            }
            Def.wck.world.paused = true;
            return;
        }// end function

        override protected function destroy() : void
        {
            var _loc_1:* = undefined;
            super.destroy();
            Def.totalScore = 0;
            TcArrayUtil.delArray(this.derailAr);
            TcArrayUtil.delArray(this.organAr);
            TcArrayUtil.delArray(this.fuhuoAr);
            TcArrayUtil.delArray(this.derail2Ar);
            TcArrayUtil.delArray(this.derail3Ar);
            TcArrayUtil.delArray(this.derail4Ar);
            TcArrayUtil.delArray(this.sxAr);
            TcArrayUtil.delArray(this.zyAr);
            TcArrayUtil.delArray(this.derail5Ar);
            TcArrayUtil.delArray(this.huoAr);
            this.staticBody = null;
            this.memo = null;
            Gfacade.instance().role.destroy();
            Gfacade.instance().role = null;
            if (Gfacade.getInstance().judgeRole2())
            {
                Gfacade.instance().role2.destroy();
                Gfacade.instance().role2 = null;
            }
            if (this.bottomFrame)
            {
            }
            if (this.bottomFrame.parent)
            {
                this.bottomFrame.parent.removeChild(this.bottomFrame);
            }
            this.bottomFrame = null;
            Gfacade.instance().gameMed = null;
            if (this.overMc)
            {
                if (this.overMc.parent)
                {
                    this.overMc.parent.removeChild(this.overMc);
                }
                this.overMc = null;
            }
            while (Def.wck.world.numChildren > 0)
            {
                
                _loc_1 = Def.wck.world.removeChildAt(0);
                if (_loc_1 is Wp)
                {
                    (_loc_1 as Wp).removeEvent();
                    (_loc_1 as Wp).destroy();
                    continue;
                }
                if (_loc_1 is Goods)
                {
                    (_loc_1 as Goods).removeEvent();
                    (_loc_1 as Goods).destroy();
                }
            }
            Def.wck = null;
            Def.count = 0;
            return;
        }// end function

        override protected function onClick(event:MouseEvent) : void
        {
            var _mc:MovieClip;
            var e:* = event;
            switch(e.target.name)
            {
                case "下一关":
                {
                    GameSound.instance.playSoundEffect("按钮点击音乐");
                    this.onNext();
                    break;
                }
                case "刷新":
                {
                    GameSound.instance.playSoundEffect("按钮点击音乐");
                    this.replay();
                    break;
                }
                case "再玩一次":
                {
                    GameSound.instance.playSoundEffect("按钮点击音乐");
                    if (this.isWin)
                    {
                        var _loc_3:* = Def;
                        var _loc_4:* = Def.curLevel - 1;
                        _loc_3.curLevel = _loc_4;
                    }
                    this.replay();
                    break;
                }
                case "返回":
                case "返回首页":
                {
                    GameSound.instance.playSoundEffect("按钮点击音乐");
                    Masked.instance.toDrakAndToLight(Gfacade.getInstance().mainGame.stage, Def.SEC, function () : void
            {
                destroy();
                Def.jumpEmpty();
                new GateMed();
                return;
            }// end function
            );
                    break;
                }
                case "更多游戏":
                {
                    GameSound.instance.playSoundEffect("按钮点击音乐", true, 155);
                    Def.moreGame();
                    break;
                }
                case "soundOff":
                {
                    GameSound.instance.isAllSound = false;
                    GameSound.instance.playSoundEffect("按钮声音2");
                    this.bottomFrame.musicBn.gotoAndStop(2);
                    break;
                }
                case "soundOn":
                {
                    GameSound.instance.isAllSound = true;
                    GameSound.instance.playSoundEffect("按钮声音2");
                    this.bottomFrame.musicBn.gotoAndStop(1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function replay() : void
        {
            Def.curLevel = this.oldlv;
            this.stop();
            Masked.instance.toDrakAndToLight(Gfacade.getInstance().mainGame.stage, Def.SEC, function () : void
            {
                destroy();
                if (overMc)
                {
                    overMc.parent.removeChild(overMc);
                    overMc = null;
                }
                Def.jumpEmpty();
                Gfacade.getInstance().gameMed = new GameMed(Def.curLevel);
                return;
            }// end function
            );
            return;
        }// end function

        private function onNext() : void
        {
            super.stop();
            this.moveMc(this.overMc, function () : void
            {
                destroy();
                if (overMc)
                {
                    overMc.parent.removeChild(overMc);
                    overMc = null;
                }
                Def.jumpEmpty();
                Gfacade.getInstance().gameMed = new GameMed((Def.curLevel + 1));
                return;
            }// end function
            );
            return;
        }// end function

        private function moveMc(param1:MovieClip, param2:Function) : void
        {
            TweenMax.to(param1, Def.SEC * 2, {x:800, alpha:0.1, onComplete:param2});
            return;
        }// end function

        private function doMore() : void
        {
            return;
        }// end function

        private function initRole() : void
        {
            Gfacade.instance().role = new Role();
            if (Gfacade.getInstance().judgeRole2())
            {
                Gfacade.instance().role2 = new Role2();
            }
            else
            {
                Gfacade.getInstance().mainGame.getMovie("role2").visible = false;
            }
            Gfacade.instance().role.score = 0;
            Gfacade.instance().mainGame.stage.focus = Gfacade.instance().mainGame;
            Gfacade.instance().role.memo = this.memo;
            return;
        }// end function

        private function onFail(event:Event) : void
        {
            this.stop();
            this.isWin = false;
            this.overMc = new Gfacade.instance().mainGame.getClass("失败");
            this.doMore();
            GameSound.instance.playSoundEffect("失败音效");
            this.curScore = 0;
            this.playMc(this.overMc, super.start);
            return;
        }// end function

        private function onWin(event:Event) : void
        {
            GameSound.instance.playSoundEffect("胜利音效");
            this.isWin = true;
            this.stop();
            if (Def.curLevel < Def.totalGate)
            {
                if (Def.curLevel == Def.throwNum)
                {
                    var _loc_2:* = Def;
                    var _loc_3:* = Def.throwNum + 1;
                    _loc_2.throwNum = _loc_3;
                }
                Def.save((Def.curLevel + 1), this.curScore);
                this.overMc = new Gfacade.instance().mainGame.getClass("过关");
                this.doMore();
                this.playMc(this.overMc, super.start);
            }
            else
            {
                Def.save((Def.curLevel + 1), this.curScore);
                this.overMc = new Gfacade.instance().mainGame.getClass("通关");
                this.doMore();
                this.playMc(this.overMc, super.start);
            }
            return;
        }// end function

        private function playMc(param1:MovieClip, param2:Function) : void
        {
            param1.tx = 400;
            param1.ty = 240;
            param1.x = -350;
            param1.y = 240;
            param1.alpha = 0.5;
            Gfacade.instance().mainGame.container.addChild(param1);
            TweenMax.to(param1, Def.SEC * 2, {x:param1.tx, alpha:1, onComplete:param2});
            param1.返回.buttonMode = true;
            if (param1.再玩一次 != null)
            {
                param1.再玩一次.buttonMode = true;
            }
            if (param1.下一关 != null)
            {
                param1.下一关.buttonMode = true;
            }
            Gfacade.instance().mainGame.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            return;
        }// end function

        private function onKeyDown(event:KeyboardEvent) : void
        {
            switch(event.keyCode)
            {
                case Keyboard2.Spacebar:
                {
                    if (this.isWin == false)
                    {
                        return;
                    }
                    Gfacade.instance().mainGame.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
                    this.onNext();
                    break;
                }
                case Keyboard2.R:
                {
                    if (this.isWin == true)
                    {
                        var _loc_2:* = Def;
                        var _loc_3:* = Def.curLevel - 1;
                        _loc_2.curLevel = _loc_3;
                    }
                    Gfacade.instance().mainGame.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
                    this.replay();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function initMap() : void
        {
            var _loc_1:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_2:* = Gfacade.instance().mainGame.container;
            var _loc_3:* = 0;
            _loc_3 = 0;
            while (_loc_3 < _loc_2.numChildren)
            {
                
                _loc_9 = _loc_2.getChildAt(_loc_3) as MovieClip;
                if (!_loc_9)
                {
                }
                else
                {
                    if (_loc_9.name == "lg43")
                    {
                        if (_loc_9 != null)
                        {
                            _loc_12 = new LocalConnection();
                            _loc_13 = _loc_12.domain;
                            if (_loc_13.indexOf("4399") != -1)
                            {
                            }
                            if (_loc_9 != null)
                            {
                                _loc_9.visible = true;
                            }
                            else if (_loc_9 != null)
                            {
                                _loc_9.visible = false;
                                this.bg2.visible = false;
                            }
                        }
                    }
                    _loc_10 = _loc_9.toString().substring(8, (_loc_9.toString().length - 1));
                    _loc_11 = _loc_9.getChildByName("lg43") as MovieClip;
                    if (_loc_11)
                    {
                        _loc_12 = new LocalConnection();
                        _loc_13 = _loc_12.domain;
                        if (_loc_13.indexOf("4399") != -1)
                        {
                        }
                        if (_loc_11 != null)
                        {
                            _loc_11.visible = true;
                        }
                        else if (_loc_11 != null)
                        {
                            _loc_11.visible = false;
                        }
                    }
                    switch(_loc_10)
                    {
                        case "幽灵蓝":
                        case "幽灵红":
                        case "幽灵绿":
                        {
                            new MoveX(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "荷花":
                        {
                            this.sxAr[_loc_9.name] = new JumpBoard3(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "荷花按钮":
                        {
                            this.derail5Ar[_loc_9.name] = new Derail5(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "发射器右":
                        {
                            new PaoTong2(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "发射器左":
                        {
                            new Paotong(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "左右移动板":
                        {
                            this.zyAr[_loc_9.name] = new JumpBoard2(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "左右移动板1开关":
                        {
                            this.derail4Ar[_loc_9.name] = new Derail4(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "上下移动板2开关":
                        {
                            this.derail3Ar[_loc_9.name] = new Derail3(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "x型上下":
                        {
                            this.sxAr[_loc_9.name] = new JumpBoard(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "x型左右":
                        {
                            new MoveX(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "x型原地":
                        {
                            new MoveD(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "恐龙蛋":
                        {
                            new AiXin(_loc_9, true);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "上下移动板":
                        {
                            new JumpBoard4(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "木箱":
                        case "冰块":
                        {
                            new BingKuai(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "炮筒":
                        {
                            new Paotong3(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "两边范围":
                        {
                            new Space(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "海水":
                        {
                            new HaiShui(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "真齿刀":
                        case "齿刀":
                        {
                            this.huoAr.push(new Chidao(_loc_9));
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "能量水":
                        {
                            new Wudiyaoshui(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "碎石":
                        {
                            new Suishi(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "一次性地表":
                        {
                            new Yicidibiao(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "能量水":
                        {
                            new Wudiyaoshui(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "刚体":
                        {
                            new Dibiao(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "烂墙":
                        {
                            new LanQiang(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "地表1":
                        case "地表2":
                        case "地表3":
                        case "地表4":
                        {
                            new Dibiao2(_loc_9, false);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "沙滩球":
                        {
                            new CaiBox(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "机关1开关":
                        {
                            this.derailAr[_loc_9.name] = new Derail(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "机关2开关":
                        {
                            this.derail2Ar[_loc_9.name] = new Derail2(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "机关1":
                        case "机关2":
                        {
                            this.organAr[_loc_9.name] = new Organ(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "铁针":
                        case "食人花":
                        {
                            new MoveZhen(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "消失木板":
                        {
                            new MoveMuBan(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "四面炮筒":
                        {
                            new SiMianPaotong(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "艾莎":
                        {
                            this.memo = new Memo(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "小龙怪":
                        {
                            new Niao(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "齿轮动画":
                        {
                            new KuMonster(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "冰范围":
                        {
                            new HuoFanWei(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "跳台":
                        {
                            new TiaoTai(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        case "猴子一":
                        case "猴子二":
                        case "小鸟1":
                        case "小鸟2":
                        {
                            new Niao(_loc_9);
                            _loc_3 = _loc_3 - 1;
                            break;
                        }
                        default:
                        {
                            break;
                            break;
                        }
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            for each (_loc_4 in this.derailAr)
            {
                
                _loc_14 = _loc_4.bodyMc.name;
                _loc_15 = _loc_14.split("_");
                _loc_4.organ = this.organAr[_loc_15[1]];
            }
            for each (_loc_5 in this.derail2Ar)
            {
                
                _loc_14 = _loc_5.bodyMc.name;
                _loc_15 = _loc_14.split("_");
                _loc_5.organ = this.organAr[_loc_15[1]];
            }
            for each (_loc_6 in this.derail3Ar)
            {
                
                _loc_14 = _loc_6.bodyMc.name;
                _loc_16 = _loc_14.substr(3);
                _loc_6.jg = this.sxAr[_loc_16];
            }
            for each (_loc_7 in this.derail4Ar)
            {
                
                _loc_14 = _loc_7.bodyMc.name;
                _loc_16 = _loc_14.substr(3);
                _loc_7.jg = this.zyAr[_loc_16];
            }
            for each (_loc_8 in this.derail5Ar)
            {
                
                _loc_14 = _loc_8.bodyMc.name;
                _loc_16 = _loc_14.substr(3);
                _loc_8.jb3 = this.sxAr[_loc_16];
            }
            return;
        }// end function

        private function initWord() : void
        {
            WcksManager.instance.world.allowDragging = false;
            WcksManager.instance.world.gravityY = Def.worldGravityY;
            WcksManager.instance.world.paused = false;
            WcksManager.instance.world.createWall(new Rectangle(0, 0, 800, 435), true, true, true, true);
            Def.wck = WcksManager.instance;
            Gfacade.instance().mainGame.container.addChild(Def.wck);
            return;
        }// end function

    }
}
