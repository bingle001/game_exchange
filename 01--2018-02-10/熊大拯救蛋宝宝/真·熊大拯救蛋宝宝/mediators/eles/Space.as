package mediators.eles
{
    import defs.*;
    import flash.display.*;
    import wcks.Box2DAS.Common.*;

    public class Space extends Wp
    {

        public function Space(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            Def.wck.addToWorld(this);
            type = Def.Static;
            this.friction = 0;
            return;
        }// end function

        override public function createShapes() : void
        {
            this.box(this.bodyMc.width, this.bodyMc.height, new V2(this.bodyMc.width / 2, this.bodyMc.height / 2));
            return;
        }// end function

    }
}
