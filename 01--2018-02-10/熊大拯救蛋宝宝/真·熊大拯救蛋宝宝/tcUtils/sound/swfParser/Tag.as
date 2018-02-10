package tcUtils.sound.swfParser
{

    public class Tag extends Object
    {
        public var type:int;
        public var position:uint;
        public var length:uint;
        public var data:Data;

        public function Tag(param1:uint = 0, param2:uint = 0, param3:uint = 0)
        {
            this.type = param1;
            this.position = param2;
            this.length = param3;
            return;
        }// end function

        public function toString() : String
        {
            return "Tag:" + this.type + "," + this.data;
        }// end function

    }
}
