package mediators.eles
{
    import flash.display.*;

    public class KuMonster extends Monster3
    {

        public function KuMonster(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            return;
        }// end function

        override public function createShape() : void
        {
            this.circle(bodyMc.width * 0.5);
            return;
        }// end function

    }
}
