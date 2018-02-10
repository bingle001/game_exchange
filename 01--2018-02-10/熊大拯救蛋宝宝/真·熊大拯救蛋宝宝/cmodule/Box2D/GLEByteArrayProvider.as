package cmodule.Box2D
{
    import flash.utils.*;

    class GLEByteArrayProvider extends Object
    {

        function GLEByteArrayProvider()
        {
            return;
        }// end function

        public static function get() : ByteArray
        {
            var result:ByteArray;
            try
            {
                result = currentDomain.domainMemory;
            }
            catch (e)
            {
            }
            if (!result)
            {
                result = new LEByteArray();
                try
                {
                    result.length = MIN_DOMAIN_MEMORY_LENGTH;
                    currentDomain.domainMemory = result;
                }
                catch (e)
                {
                    log(3, "Not using domain memory");
                }
            }
            return result;
        }// end function

    }
}
