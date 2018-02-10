package wcks.wck
{
    import wcks.Box2DAS.Common.*;
    import wcks.misc.*;

    public class WCK extends Entity
    {

        public function WCK()
        {
            return;
        }// end function

        override public function create() : void
        {
            b2Base.initialize();
            Input.initialize(stage);
            return;
        }// end function

    }
}
