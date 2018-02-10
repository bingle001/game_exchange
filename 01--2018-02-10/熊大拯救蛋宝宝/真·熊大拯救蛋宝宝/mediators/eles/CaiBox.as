package mediators.eles
{
    import defs.*;
    import facade.*;
    import flash.display.*;
    import wcks.Box2DAS.Dynamics.*;

    public class CaiBox extends Goods
    {

        public function CaiBox(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            type = Def.Animated;
            this.reportBeginContact = true;
            this.reportEndContact = true;
            this.friction = 0;
            return;
        }// end function

        override public function createShape() : void
        {
            this.box(this.bodyMc.height, this.bodyMc.width);
            return;
        }// end function

        override public function addEvent() : void
        {
            this.listenWhileVisible(this, ContactEvent.BEGIN_CONTACT, this.onBegin);
            this.listenWhileVisible(this, ContactEvent.END_CONTACT, this.onEnd);
            return;
        }// end function

        override public function removeEvent() : void
        {
            this.removeEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            this.removeEventListener(ContactEvent.END_CONTACT, this.onEnd);
            return;
        }// end function

        public function run(param1:Number) : void
        {
            if (param1 > 0)
            {
                bodyMc.rotation = bodyMc.rotation + 5;
            }
            else
            {
                bodyMc.rotation = bodyMc.rotation - 5;
            }
            x = Gfacade.instance().role.x;
            return;
        }// end function

        public function stopRun() : void
        {
            x = Gfacade.instance().role.x;
            return;
        }// end function

        private function onBegin(event:ContactEvent) : void
        {
            if (event.other.GetBody().GetUserData().name == "role")
            {
            }
            if (event.normal.y < 0.5)
            {
                Gfacade.instance().role.onBox = true;
                Gfacade.instance().role.caiBox = this;
            }
            return;
        }// end function

        private function onEnd(event:ContactEvent) : void
        {
            if (event.other.GetBody().GetUserData().name == "role")
            {
                Gfacade.instance().role.onBox = false;
                Gfacade.instance().role.caiBox = null;
            }
            return;
        }// end function

    }
}
