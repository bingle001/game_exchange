package wcks.Box2DAS.Common
{

    public class b2Settings extends b2Base
    {

        public function b2Settings()
        {
            return;
        }// end function

        public static function get b2_maxFloat() : Number
        {
            return mem._mrf(lib.b2Settings.b2_maxFloat);
        }// end function

        public static function set b2_maxFloat(param1:Number) : void
        {
            mem._mwf(lib.b2Settings.b2_maxFloat, param1);
            return;
        }// end function

        public static function get b2_epsilon() : Number
        {
            return mem._mrf(lib.b2Settings.b2_epsilon);
        }// end function

        public static function set b2_epsilon(param1:Number) : void
        {
            mem._mwf(lib.b2Settings.b2_epsilon, param1);
            return;
        }// end function

        public static function get b2_pi() : Number
        {
            return mem._mrf(lib.b2Settings.b2_pi);
        }// end function

        public static function set b2_pi(param1:Number) : void
        {
            mem._mwf(lib.b2Settings.b2_pi, param1);
            return;
        }// end function

        public static function get b2_maxManifoldPoints() : int
        {
            return mem._mr32(lib.b2Settings.b2_maxManifoldPoints);
        }// end function

        public static function set b2_maxManifoldPoints(param1:int) : void
        {
            mem._mw32(lib.b2Settings.b2_maxManifoldPoints, param1);
            return;
        }// end function

        public static function get b2_maxPolygonVertices() : int
        {
            return mem._mr32(lib.b2Settings.b2_maxPolygonVertices);
        }// end function

        public static function set b2_maxPolygonVertices(param1:int) : void
        {
            mem._mw32(lib.b2Settings.b2_maxPolygonVertices, param1);
            return;
        }// end function

        public static function get b2_aabbExtension() : Number
        {
            return mem._mrf(lib.b2Settings.b2_aabbExtension);
        }// end function

        public static function set b2_aabbExtension(param1:Number) : void
        {
            mem._mwf(lib.b2Settings.b2_aabbExtension, param1);
            return;
        }// end function

        public static function get b2_aabbMultiplier() : Number
        {
            return mem._mrf(lib.b2Settings.b2_aabbMultiplier);
        }// end function

        public static function set b2_aabbMultiplier(param1:Number) : void
        {
            mem._mwf(lib.b2Settings.b2_aabbMultiplier, param1);
            return;
        }// end function

        public static function get b2_linearSlop() : Number
        {
            return mem._mrf(lib.b2Settings.b2_linearSlop);
        }// end function

        public static function set b2_linearSlop(param1:Number) : void
        {
            mem._mwf(lib.b2Settings.b2_linearSlop, param1);
            return;
        }// end function

        public static function get b2_angularSlop() : Number
        {
            return mem._mrf(lib.b2Settings.b2_angularSlop);
        }// end function

        public static function set b2_angularSlop(param1:Number) : void
        {
            mem._mwf(lib.b2Settings.b2_angularSlop, param1);
            return;
        }// end function

        public static function get b2_polygonRadius() : Number
        {
            return mem._mrf(lib.b2Settings.b2_polygonRadius);
        }// end function

        public static function set b2_polygonRadius(param1:Number) : void
        {
            mem._mwf(lib.b2Settings.b2_polygonRadius, param1);
            return;
        }// end function

        public static function get b2_maxSubSteps() : Number
        {
            return mem._mrf(lib.b2Settings.b2_maxSubSteps);
        }// end function

        public static function set b2_maxSubSteps(param1:Number) : void
        {
            mem._mwf(lib.b2Settings.b2_maxSubSteps, param1);
            return;
        }// end function

        public static function get b2_maxTOIContacts() : int
        {
            return mem._mr32(lib.b2Settings.b2_maxTOIContacts);
        }// end function

        public static function set b2_maxTOIContacts(param1:int) : void
        {
            mem._mw32(lib.b2Settings.b2_maxTOIContacts, param1);
            return;
        }// end function

        public static function get b2_velocityThreshold() : Number
        {
            return mem._mrf(lib.b2Settings.b2_velocityThreshold);
        }// end function

        public static function set b2_velocityThreshold(param1:Number) : void
        {
            mem._mwf(lib.b2Settings.b2_velocityThreshold, param1);
            return;
        }// end function

        public static function get b2_maxLinearCorrection() : Number
        {
            return mem._mrf(lib.b2Settings.b2_maxLinearCorrection);
        }// end function

        public static function set b2_maxLinearCorrection(param1:Number) : void
        {
            mem._mwf(lib.b2Settings.b2_maxLinearCorrection, param1);
            return;
        }// end function

        public static function get b2_maxAngularCorrection() : Number
        {
            return mem._mrf(lib.b2Settings.b2_maxAngularCorrection);
        }// end function

        public static function set b2_maxAngularCorrection(param1:Number) : void
        {
            mem._mwf(lib.b2Settings.b2_maxAngularCorrection, param1);
            return;
        }// end function

        public static function get b2_maxTranslation() : Number
        {
            return mem._mrf(lib.b2Settings.b2_maxTranslation);
        }// end function

        public static function set b2_maxTranslation(param1:Number) : void
        {
            mem._mwf(lib.b2Settings.b2_maxTranslation, param1);
            return;
        }// end function

        public static function get b2_maxTranslationSquared() : Number
        {
            return mem._mrf(lib.b2Settings.b2_maxTranslationSquared);
        }// end function

        public static function set b2_maxTranslationSquared(param1:Number) : void
        {
            mem._mwf(lib.b2Settings.b2_maxTranslationSquared, param1);
            return;
        }// end function

        public static function get b2_maxRotation() : Number
        {
            return mem._mrf(lib.b2Settings.b2_maxRotation);
        }// end function

        public static function set b2_maxRotation(param1:Number) : void
        {
            mem._mwf(lib.b2Settings.b2_maxRotation, param1);
            return;
        }// end function

        public static function get b2_maxRotationSquared() : Number
        {
            return mem._mrf(lib.b2Settings.b2_maxRotationSquared);
        }// end function

        public static function set b2_maxRotationSquared(param1:Number) : void
        {
            mem._mwf(lib.b2Settings.b2_maxRotationSquared, param1);
            return;
        }// end function

        public static function get b2_contactBaumgarte() : Number
        {
            return mem._mrf(lib.b2Settings.b2_contactBaumgarte);
        }// end function

        public static function set b2_contactBaumgarte(param1:Number) : void
        {
            mem._mwf(lib.b2Settings.b2_contactBaumgarte, param1);
            return;
        }// end function

        public static function get b2_timeToSleep() : Number
        {
            return mem._mrf(lib.b2Settings.b2_timeToSleep);
        }// end function

        public static function set b2_timeToSleep(param1:Number) : void
        {
            mem._mwf(lib.b2Settings.b2_timeToSleep, param1);
            return;
        }// end function

        public static function get b2_linearSleepTolerance() : Number
        {
            return mem._mrf(lib.b2Settings.b2_linearSleepTolerance);
        }// end function

        public static function set b2_linearSleepTolerance(param1:Number) : void
        {
            mem._mwf(lib.b2Settings.b2_linearSleepTolerance, param1);
            return;
        }// end function

        public static function get b2_angularSleepTolerance() : Number
        {
            return mem._mrf(lib.b2Settings.b2_angularSleepTolerance);
        }// end function

        public static function set b2_angularSleepTolerance(param1:Number) : void
        {
            mem._mwf(lib.b2Settings.b2_angularSleepTolerance, param1);
            return;
        }// end function

    }
}
