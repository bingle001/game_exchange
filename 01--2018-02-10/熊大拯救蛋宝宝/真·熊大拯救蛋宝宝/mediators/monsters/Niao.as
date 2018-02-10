package mediators.monsters
{
    import flash.display.*;
    import mediators.eles.*;

    public class Niao extends Monster
    {
        private var bname:String;

        public function Niao(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            var _loc_3:* = bodyMc.toString();
            if (_loc_3.indexOf("1") != -1)
            {
                hp = 5;
                this.bname = "子弹1";
            }
            else if (_loc_3.indexOf("2") != -1)
            {
                hp = 10;
                this.bname = "子弹2";
            }
            else
            {
                hp = 20;
                this.bname = "子弹3";
            }
            return;
        }// end function

        override public function createShape() : void
        {
            this.box(bodyMc.width * 0.4, bodyMc.height * 0.8);
            return;
        }// end function

        override public function attack() : void
        {
            return;
        }// end function

    }
}
