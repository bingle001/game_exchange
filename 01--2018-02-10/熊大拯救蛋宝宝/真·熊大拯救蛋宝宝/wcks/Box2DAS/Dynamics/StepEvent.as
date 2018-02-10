package wcks.Box2DAS.Dynamics
{
    import flash.events.*;

    public class StepEvent extends Event
    {
        public var timeStep:Number;
        public var velocityIterations:Number;
        public var positionIterations:Number;
        public var stepTime:Number;
        public static var STEP:String = "onStep";

        public function StepEvent(param1:Number, param2:Number, param3:Number, param4:Number)
        {
            this.timeStep = param1;
            this.velocityIterations = param2;
            this.positionIterations = param3;
            this.stepTime = param4;
            super(STEP);
            return;
        }// end function

    }
}
