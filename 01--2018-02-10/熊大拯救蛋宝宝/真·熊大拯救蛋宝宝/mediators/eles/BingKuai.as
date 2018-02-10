package mediators.eles
{
    import defs.*;
    import flash.display.*;

    public class BingKuai extends Wp2
    {

        public function BingKuai(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            this.gravityScale = 2;
            type = Def.Dynamic;
            this.friction = 1.5;
            this.density = 20;
            return;
        }// end function

        override public function createShapes() : void
        {
            this.box(bodyMc.width, bodyMc.height);
            return;
        }// end function

    }
}
