package cmodule.Box2D
{
    import flash.utils.*;

    dynamic public class DynamicProxy extends Proxy
    {
        var nextValue:Function;
        var getProperty:Function;
        var isAttribute:Function;
        var nextNameIndex:Function;
        var hasProperty:Function;
        var callProperty:Function;
        var nextName:Function;
        var getDescendants:Function;
        var deleteProperty:Function;
        var setProperty:Function;

        public function DynamicProxy()
        {
            return;
        }// end function

        override function hasProperty(param1) : Boolean
        {
            return this.hasProperty(param1);
        }// end function

        override function callProperty(param1, ... args)
        {
            return this.callProperty(param1, args);
        }// end function

        override function setProperty(param1, param2) : void
        {
            this.setProperty(param1, param2);
            return;
        }// end function

        override function isAttribute(param1) : Boolean
        {
            return this.isAttribute(param1);
        }// end function

        override function getProperty(param1)
        {
            return this.getProperty(param1);
        }// end function

        override function nextNameIndex(param1:int) : int
        {
            return this.nextNameIndex(param1);
        }// end function

        override function deleteProperty(param1) : Boolean
        {
            return this.deleteProperty(param1);
        }// end function

        override function nextName(param1:int) : String
        {
            return this.nextName(param1);
        }// end function

        override function getDescendants(param1)
        {
            return this.getDescendants(param1);
        }// end function

        override function nextValue(param1:int)
        {
            return this.nextValue(param1);
        }// end function

    }
}
