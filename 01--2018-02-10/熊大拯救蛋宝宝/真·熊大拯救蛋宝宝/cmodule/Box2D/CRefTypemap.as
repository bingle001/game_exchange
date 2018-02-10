package cmodule.Box2D
{

    class CRefTypemap extends CTypemap
    {
        private var subtype:CTypemap;

        function CRefTypemap(param1:CTypemap)
        {
            this.subtype = param1;
            return;
        }// end function

        override public function fromC(param1:Array)
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            _loc_2 = param1[0];
            _loc_3 = 0;
            while (_loc_3 < this.subtype.ptrLevel)
            {
                
                ds.position = _loc_2;
                _loc_2 = ds.readInt();
                _loc_3 = _loc_3 + 1;
            }
            return this.subtype.readValue(_loc_2);
        }// end function

        override public function createC(param1, param2:int = 0) : Array
        {
            return null;
        }// end function

    }
}
