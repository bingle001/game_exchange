package mediators.eles
{
    import facade.*;
    import flash.display.*;
    import mediators.roles.*;
    import wcks.Box2DAS.Dynamics.*;

    public class MoveX extends JumpBoard2
    {

        public function MoveX(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            return;
        }// end function

        override public function createShape() : void
        {
            this.box(bodyMc.width * 0.7, bodyMc.height * 0.8);
            return;
        }// end function

        override public function addEvent() : void
        {
            super.addEvent();
            this.listenWhileVisible(this, ContactEvent.BEGIN_CONTACT, this.onBegin);
            return;
        }// end function

        override public function removeEvent() : void
        {
            super.removeEvent();
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
                    if (Gfacade.instance().role.iswudi == false)
                    {
                        Gfacade.instance().role.die();
                    }
                }
                else if (event.other.GetBody().GetUserData() is Role2)
                {
                    if (Gfacade.instance().role2.iswudi == false)
                    {
                        Gfacade.instance().role2.die();
                    }
                }
                else if (Gfacade.instance().role3.iswudi == false)
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
