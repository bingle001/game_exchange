package mediators.eles
{
    import defs.*;
    import flash.display.*;

    public class FuHuo extends Wp2
    {

        public function FuHuo(param1:MovieClip)
        {
            super(param1, false);
            type = Def.Static;
            this.isSensor = true;
            return;
        }// end function

        override public function createShapes() : void
        {
            this.box(bodyMc.width, bodyMc.height);
            return;
        }// end function

    }
}
