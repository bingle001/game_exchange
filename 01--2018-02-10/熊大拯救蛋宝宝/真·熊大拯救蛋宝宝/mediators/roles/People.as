package mediators.roles
{
    import defs.*;
    import flash.display.*;
    import tcUtils.*;
    import wcks.wck.*;

    public class People extends BodyShape
    {
        public var bodyMc:MovieClip;
        public var bodyWidth:Number = 0;
        public var bodyHeight:Number = 0;
        public var runDir:Object;
        private var _speedNum:Number = 0;
        private var _hpNum:Number = 0;
        private var _oldStatus:String;
        private var _curStatus:String;
        public var isCanChangeStatus:Boolean = true;
        public var iswudi:Boolean = false;
        public var iscircle:Boolean = false;

        public function People(param1:MovieClip)
        {
            this.bodyMc = param1;
            this.x = param1.x;
            this.y = param1.y;
            param1.tx = param1.x;
            param1.ty = param1.y;
            this.autoSleep = false;
            this.fixedRotation = true;
            param1.x = 0;
            param1.y = 0;
            this.runDir = new Object();
            addChild(this.bodyMc);
            world = Def.wck.world;
            Def.wck.addToWorld(this);
            return;
        }// end function

        public function clearRunDir() : void
        {
            this.runDir[Keyboard2.W] = false;
            this.runDir[Keyboard2.A] = false;
            this.runDir[Keyboard2.S] = false;
            this.runDir[Keyboard2.D] = false;
            this.runDir[Keyboard2.up] = false;
            this.runDir[Keyboard2.down] = false;
            this.runDir[Keyboard2.left] = false;
            this.runDir[Keyboard2.right] = false;
            return;
        }// end function

        public function addEvent() : void
        {
            return;
        }// end function

        public function removeEvent() : void
        {
            return;
        }// end function

        override public function destroy() : void
        {
            super.destroy();
            return;
        }// end function

        public function walkLeft() : void
        {
            return;
        }// end function

        public function walkRight() : void
        {
            return;
        }// end function

        public function die() : void
        {
            return;
        }// end function

        public function jump() : void
        {
            return;
        }// end function

        public function stopRun() : void
        {
            this.runDir[Keyboard2.left] = false;
            this.runDir[Keyboard2.right] = false;
            this.linearVelocityX = 0;
            this.changeStatus(Role.STAND);
            return;
        }// end function

        public function changeBodyScale(param1:int) : void
        {
            if (this.bodyMc)
            {
            }
            if (this.bodyMc.scaleX != param1)
            {
                this.bodyMc.scaleX = param1;
            }
            return;
        }// end function

        public function changeStatus(param1:String) : Boolean
        {
            if (this.curStatus != param1)
            {
            }
            if (this.bodyMc)
            {
            }
            if (this.isCanChangeStatus == false)
            {
                return false;
            }
            if (this.iscircle)
            {
                if (param1.indexOf("球") == -1)
                {
                    this.curStatus = "球" + param1;
                }
            }
            else
            {
                this.curStatus = param1;
            }
            this.oldStatus = this.curStatus;
            this.curStatus = param1;
            this.bodyMc.gotoAndStop(this.curStatus);
            return true;
        }// end function

        override public function createBody() : void
        {
            super.createBody();
            createShapes();
            return;
        }// end function

        public function get speedNum() : Number
        {
            return this._speedNum;
        }// end function

        public function set speedNum(param1:Number) : void
        {
            this._speedNum = param1;
            return;
        }// end function

        public function get hpNum() : Number
        {
            return this._hpNum;
        }// end function

        public function set hpNum(param1:Number) : void
        {
            this._hpNum = param1;
            return;
        }// end function

        public function get curStatus() : String
        {
            return this._curStatus;
        }// end function

        public function set curStatus(param1:String) : void
        {
            this._curStatus = param1;
            return;
        }// end function

        public function get oldStatus() : String
        {
            return this._oldStatus;
        }// end function

        public function set oldStatus(param1:String) : void
        {
            this._oldStatus = param1;
            return;
        }// end function

    }
}
