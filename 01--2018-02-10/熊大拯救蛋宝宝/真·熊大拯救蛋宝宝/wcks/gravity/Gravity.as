package wcks.gravity
{
    import flash.events.*;
    import wcks.Box2DAS.Common.*;
    import wcks.Box2DAS.Dynamics.*;
    import wcks.misc.*;
    import wcks.shapes.*;
    import wcks.wck.*;

    public class Gravity extends Entity
    {
        public var base:V2;
        public var world:World;
        public var sensorName:String = "";

        public function Gravity()
        {
            return;
        }// end function

        override public function create() : void
        {
            var _loc_1:* = null;
            visible = false;
            this.world = Util.findAncestorOfClass(this, World) as World;
            this.world.ensureCreated();
            if (this.sensorName != "")
            {
                _loc_1 = Util.getDisplayObjectByPath(this.world, this.sensorName, this.world) as ShapeBase;
                _loc_1.reportBeginContact = true;
                _loc_1.reportEndContact = true;
                _loc_1.ensureCreated();
                listenWhileVisible(_loc_1, ContactEvent.BEGIN_CONTACT, this.handleBeginContact);
                listenWhileVisible(_loc_1, ContactEvent.END_CONTACT, this.handleEndContact);
            }
            else
            {
                this.world.customGravity = this;
            }
            this.base = new V2(this.world.gravityX, this.world.gravityY);
            listenWhileVisible(this.world, StepEvent.STEP, this.initStep, false, 15);
            return;
        }// end function

        public function handleBeginContact(event:ContactEvent) : void
        {
            var _loc_2:* = event.relatedObject as BodyShape;
            _loc_2 = _loc_2.body;
            _loc_2.customGravity = this;
            return;
        }// end function

        public function handleEndContact(event:ContactEvent) : void
        {
            var _loc_2:* = event.relatedObject as BodyShape;
            _loc_2 = _loc_2.body;
            _loc_2.customGravity = null;
            return;
        }// end function

        public function initStep(event:Event) : void
        {
            return;
        }// end function

        public function gravity(param1:V2, param2:b2Body = null, param3:BodyShape = null) : V2
        {
            return this.base;
        }// end function

    }
}
