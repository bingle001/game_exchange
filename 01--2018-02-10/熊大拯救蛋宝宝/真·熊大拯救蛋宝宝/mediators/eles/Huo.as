package mediators.eles
{
    import defs.*;
    import facade.*;
    import flash.display.*;
    import mediators.roles.*;
    import wcks.Box2DAS.Common.*;
    import wcks.Box2DAS.Dynamics.*;

    public class Huo extends Wp
    {

        public function Huo(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            type = Def.Static;
            Def.wck.addToWorld(this);
            this.reportBeginContact = true;
            this.friction = 2;
            this.bullet = true;
            return;
        }// end function

        public function disappear() : void
        {
            this.isSensor = true;
            this.bodyMc.visible = false;
            this.remove();
            return;
        }// end function

        override public function createShapes() : void
        {
            this.box(this.bodyMc.width - 10, this.bodyMc.height - 10, new V2(0, 5), this.bodyMc.rotation);
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
            if (!(event.other.GetBody().GetUserData() is Role))
            {
            }
            if (!(event.other.GetBody().GetUserData() is Role2))
            {
            }
            if (event.other.GetBody().GetUserData() is Role3)
            {
                if (event.other.GetBody().GetUserData() is Role)
                {
                    if (Gfacade.instance().role.isCanChangeStatus)
                    {
                        Gfacade.instance().role.die();
                    }
                }
                else if (event.other.GetBody().GetUserData() is Role2)
                {
                    if (Gfacade.instance().role2.isCanChangeStatus)
                    {
                        Gfacade.instance().role2.die();
                    }
                }
                else if (Gfacade.instance().role3.isCanChangeStatus)
                {
                    Gfacade.instance().role3.die();
                }
            }
            else
            {
                event.contact.SetEnabled(false);
            }
            return;
        }// end function

    }
}
