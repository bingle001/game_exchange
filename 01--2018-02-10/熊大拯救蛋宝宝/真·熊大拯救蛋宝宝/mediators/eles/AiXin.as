package mediators.eles
{
    import com.greensock.*;
    import defs.*;
    import facade.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mediators.roles.*;
    import tcUtils.sound.*;
    import wcks.Box2DAS.Dynamics.*;
    import wcks.misc.*;

    public class AiXin extends Wp2
    {
        public var isHong:Boolean;

        public function AiXin(param1:MovieClip, param2:Boolean)
        {
            super(param1, true);
            type = Def.Static;
            var _loc_3:* = Def;
            var _loc_4:* = Def.totalScore + 1;
            _loc_3.totalScore = _loc_4;
            this.reportBeginContact = true;
            this.isSensor = true;
            this.isHong = param2;
            return;
        }// end function

        override public function createShapes() : void
        {
            this.circle(bodyMc.width * 0.6);
            return;
        }// end function

        override public function addEvent() : void
        {
            this.addEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            return;
        }// end function

        override public function removeEvent() : void
        {
            this.removeEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            return;
        }// end function

        public function onBegin(event:ContactEvent) : void
        {
            var p:Point;
            var e:* = event;
            if (!(e.other.GetUserData() is Role))
            {
            }
            if (!(e.other.GetUserData() is Role2))
            {
            }
            if (e.other.GetUserData() is Role3)
            {
                this.removeEvent();
                this.isSensor = true;
                bodyMc.gotoAndStop(2);
                GameSound.instance.playSoundEffect("吃恐龙蛋", false, 300);
                Def.wck.world.addChildAt(this, (Def.wck.world.numChildren - 1));
                p = Util.localizePoint(this, Gfacade.getInstance().gameMed.bottomFrame.cs);
                TweenMax.to(bodyMc, 0.5, {x:p.x, y:p.y, scaleX:0.1, scaleY:0.1, onComplete:function () : void
            {
                bodyMc.visible = false;
                var _loc_1:* = Def;
                var _loc_2:* = Def.curScore + 1;
                _loc_1.curScore = _loc_2;
                if (Def.totalScore == Def.curScore)
                {
                    EventManager.getInstance().eDispatchEvent(new Event(Def.WIN));
                }
                Gfacade.getInstance().gameMed.bottomFrame.cs.text = Def.curScore + "";
                remove();
                return;
            }// end function
            });
            }
            else
            {
                e.contact.SetEnabled(false);
            }
            return;
        }// end function

    }
}
