package mediators.eles
{
    import flash.display.*;
    import wcks.Box2DAS.Common.*;

    public class MoveD extends Huo
    {

        public function MoveD(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            return;
        }// end function

        override public function createShapes() : void
        {
            this.box(bodyMc.width * 0.8, this.bodyMc.height * 0.7, new V2(0, 5), this.bodyMc.rotation);
            return;
        }// end function

    }
}
