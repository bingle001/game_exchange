package wcks
{
    import flash.events.*;
    import flash.geom.*;
    import wcks.shapes.*;
    import wcks.wck.*;

    public class WcksWorld extends World
    {
        public var wckScrollRec:Rectangle;

        public function WcksWorld()
        {
            return;
        }// end function

        override public function updateScroll(event:Event = null) : void
        {
            super.updateScroll(event);
            if (this.wckScrollRec != null)
            {
            }
            if (stage == null)
            {
                return;
            }
            if (x > -this.wckScrollRec.x)
            {
                x = -this.wckScrollRec.x;
            }
            else if (x < -this.wckScrollRec.x - this.wckScrollRec.width + stage.stageWidth)
            {
                x = -this.wckScrollRec.x - this.wckScrollRec.width + stage.stageWidth;
            }
            if (y > -this.wckScrollRec.y)
            {
                y = -this.wckScrollRec.y;
            }
            else if (y < -this.wckScrollRec.y - this.wckScrollRec.height + stage.stageHeight)
            {
                y = -this.wckScrollRec.y - this.wckScrollRec.height + stage.stageHeight;
            }
            return;
        }// end function

        public function createWall(param1:Rectangle, param2:Boolean = true, param3:Boolean = true, param4:Boolean = true, param5:Boolean = true) : void
        {
            var _loc_6:* = null;
            if (param2)
            {
                _loc_6 = new Box();
                _loc_6.graphics.beginFill(0, 0);
                _loc_6.graphics.drawRect(-5, (-param1.height) * 0.5 - 10, 10, param1.height + 20);
                _loc_6.graphics.endFill();
                _loc_6.x = param1.x - 5;
                _loc_6.y = param1.y + param1.height * 0.5;
                _loc_6.type = "Static";
                this.addChild(_loc_6);
            }
            if (param3)
            {
                _loc_6 = new Box();
                _loc_6.graphics.beginFill(0, 0);
                _loc_6.graphics.drawRect(-5, (-param1.height) * 0.5 - 10, 10, param1.height + 20);
                _loc_6.graphics.endFill();
                _loc_6.x = param1.x + param1.width + 5;
                _loc_6.y = param1.y + param1.height * 0.5;
                _loc_6.type = "Static";
                this.addChild(_loc_6);
            }
            if (param4)
            {
                _loc_6 = new Box();
                _loc_6.graphics.beginFill(0, 0);
                _loc_6.graphics.drawRect((-param1.width) * 0.5 - 10, -5, param1.width + 20, 10);
                _loc_6.graphics.endFill();
                _loc_6.x = param1.x + param1.width * 0.5;
                _loc_6.y = param1.y - 5;
                _loc_6.type = "Static";
                this.addChild(_loc_6);
            }
            if (param5)
            {
                _loc_6 = new Box();
                _loc_6.graphics.beginFill(0, 0);
                _loc_6.graphics.drawRect((-param1.width) * 0.5 - 10, -5, param1.width + 20, 10);
                _loc_6.graphics.endFill();
                _loc_6.x = param1.x + param1.width * 0.5;
                _loc_6.y = param1.y + param1.height + 50;
                _loc_6.type = "Static";
                this.addChild(_loc_6);
            }
            return;
        }// end function

    }
}
