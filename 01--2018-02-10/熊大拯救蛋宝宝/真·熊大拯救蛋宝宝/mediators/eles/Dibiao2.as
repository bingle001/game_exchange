package mediators.eles
{
    import defs.*;
    import facade.*;
    import flash.display.*;
    import wcks.Box2DAS.Common.*;
    import wcks.Box2DAS.Dynamics.*;

    public class Dibiao2 extends Wp
    {

        public function Dibiao2(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            Def.wck.addToWorld(this);
            type = Def.Static;
            this.autoSleep = false;
            this.reportBeginContact = true;
            return;
        }// end function

        override public function createShapes() : void
        {
            var _loc_1:* = this.box(this.bodyMc.width - 2, this.bodyMc.height, null, this.bodyMc.rotation);
            _loc_1.m_friction = 0.5;
            var _loc_2:* = this.box(1, (this.bodyMc.height - 1), new V2((-bodyMc.width) * 0.5 + 1, 0), this.bodyMc.rotation);
            _loc_2.m_friction = 0;
            var _loc_3:* = this.box(1, (this.bodyMc.height - 1), new V2(bodyMc.width * 0.5 - 1, 0), this.bodyMc.rotation);
            _loc_3.m_friction = 0;
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

        private function onBegin(event:ContactEvent) : void
        {
            if (event.other.GetBody().GetUserData().name == "role")
            {
            }
            return;
        }// end function

        private function onEnd(event:ContactEvent) : void
        {
            if (event.other.GetBody().GetUserData().name == "role")
            {
                if (Gfacade.instance().role == null)
                {
                    return;
                }
                Gfacade.instance().role.onDibiao2 = false;
                event.contact.SetEnabled(true);
            }
            return;
        }// end function

    }
}
