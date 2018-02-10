package mediators.eles
{
    import defs.*;
    import facade.*;
    import flash.display.*;
    import wcks.Box2DAS.Dynamics.*;

    public class Dibiao extends Wp
    {

        public function Dibiao(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            Def.wck.addToWorld(this);
            type = Def.Static;
            this.friction = 0.31;
            this.autoSleep = false;
            this.reportBeginContact = true;
            return;
        }// end function

        override public function createShapes() : void
        {
            this.box(bodyMc.width, bodyMc.height - 9);
            return;
        }// end function

        override public function addEvent() : void
        {
            this.listenWhileVisible(this, ContactEvent.BEGIN_CONTACT, this.onBegin);
            return;
        }// end function

        override public function removeEvent() : void
        {
            this.removeEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            return;
        }// end function

        private function onBegin(event:ContactEvent) : void
        {
            var _loc_2:* = Gfacade.instance().role.y - this.y;
            if (event.normal)
            {
                if (event.normal.y <= 0)
                {
                }
                if (event.normal.y >= -1)
                {
                    event.contact.SetEnabled(true);
                }
                else
                {
                    event.contact.SetEnabled(false);
                }
            }
            return;
        }// end function

        private function onEnd(event:ContactEvent) : void
        {
            if (event.other.GetBody().GetUserData().name == "role")
            {
                Gfacade.instance().role.onDibiao2 = false;
                event.contact.SetEnabled(true);
            }
            return;
        }// end function

    }
}
