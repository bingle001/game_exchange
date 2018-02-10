package 
{
    import StoneMan2_resourceClass.*;
    import flash.utils.*;
    import mx.core.*;

    public class StoneMan2_resourceClass extends MovieClipLoaderAsset
    {
        public var dataClass:Class;
        private static var bytes:ByteArray = null;

        public function StoneMan2_resourceClass()
        {
            this.dataClass = StoneMan2_resourceClass_dataClass;
            initialWidth = 16000 / 20;
            initialHeight = 9600 / 20;
            return;
        }// end function

        override public function get movieClipData() : ByteArray
        {
            if (bytes == null)
            {
                bytes = ByteArray(new this.dataClass());
            }
            return bytes;
        }// end function

    }
}
