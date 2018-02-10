package cmodule.Box2D
{
    import flash.display.*;
    import flash.utils.*;

    public class CLibInit extends Object
    {

        public function CLibInit()
        {
            return;
        }// end function

        public function init()
        {
            var runner:CRunner;
            var result:*;
            var saveState:MState;
            var regged:Boolean;
            runner = new CRunner(true);
            saveState = new MState(null);
            copyTo(saveState);
            try
            {
                runner.startSystem();
                do
                {
                    
                    try
                    {
                        while (true)
                        {
                            
                            runner.work();
                        }
                    }
                    catch (e:AlchemyDispatch)
                    {
                        ;
                    }
                    catch (e:AlchemyYield)
                    {
                    }
                }while (true)
            }
            catch (e:AlchemyLibInit)
            {
                log(3, "Caught AlchemyLibInit " + e.rv);
                regged;
                result = e.AS3ValType.valueTracker.release(e.rv);
            }
            finally
            {
                saveState.copyTo();
                if (!regged)
                {
                    log(1, "Lib didn\'t register");
                }
            }
            return result;
        }// end function

        public function supplyFile(param1:String, param2:ByteArray) : void
        {
            [param1] = param2;
            return;
        }// end function

        public function putEnv(param1:String, param2:String) : void
        {
            [param1] = param2;
            return;
        }// end function

        public function setSprite(param1:Sprite) : void
        {
             = param1;
            return;
        }// end function

    }
}
