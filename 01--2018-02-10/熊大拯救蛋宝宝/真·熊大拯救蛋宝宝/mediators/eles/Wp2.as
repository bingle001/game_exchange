package mediators.eles
{
    import defs.*;
    import flash.display.*;

    public class Wp2 extends Wp
    {

        public function Wp2(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            this.initRice();
            Def.wck.addToWorld(this);
            return;
        }// end function

        protected function initRice() : void
        {
            this.density = 1;
            this.gravityMod = true;
            return;
        }// end function

    }
}
