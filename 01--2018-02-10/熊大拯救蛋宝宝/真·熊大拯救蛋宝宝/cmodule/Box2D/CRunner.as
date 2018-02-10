package cmodule.Box2D
{
    import cmodule.Box2D.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class CRunner extends Object implements Debuggee
    {
        var timer:Timer;
        var forceSyncSystem:Boolean;
        var suspended:int = 0;
        var debugger:GDBMIDebugger;

        public function CRunner(param1:Boolean = false)
        {
            if ()
            {
                log(1, "More than one CRunner!");
            }
            ;
            this.forceSyncSystem = param1;
            return;
        }// end function

        public function cancelDebug() : void
        {
            this.debugger = null;
            return;
        }// end function

        public function get isRunning() : Boolean
        {
            return this.suspended <= 0;
        }// end function

        public function createArgv(param1:Array) : Array
        {
            return this.rawAllocStringArray(param1).concat(0);
        }// end function

        public function createEnv(param1:Object) : Array
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            _loc_2 = [];
            for (_loc_3 in param1)
            {
                
                _loc_2.push(_loc_3 + "=" + param1[_loc_3]);
            }
            return this.rawAllocStringArray(_loc_2).concat(0);
        }// end function

        public function startInit() : void
        {
            var args:Array;
            var env:Object;
            var argv:Array;
            var envp:Array;
            var startArgs:Array;
            var ap:int;
            log(2, "Static init...");
            modStaticInit();
            args = system.getargv();
            env = system.getenv();
            argv = this.createArgv(args);
            envp = this.createEnv(env);
            startArgs = [args.length].concat(argv, envp);
            ap = this.rawAllocIntArray(startArgs);
            ds.length = ds.length + 4095 & ~4095;
            push(ap);
            push(0);
            log(2, "Starting work...");
            this.timer = new Timer(1);
            this.timer.addEventListener(TimerEvent.TIMER, function (event:TimerEvent) : void
            {
                work();
                return;
            }// end function
            );
            try
            {
                start();
            }
            catch (e:AlchemyExit)
            {
                e.system.exit(e.rv);
                return;
                ;
            }
            catch (e:AlchemyYield)
            {
                ;
            }
            catch (e:AlchemyDispatch)
            {
                ;
            }
            catch (e:AlchemyBlock)
            {
            }
            this.startWork();
            return;
        }// end function

        private function startWork() : void
        {
            if (!this.timer.running)
            {
                this.timer.delay = 1;
                this.timer.start();
            }
            return;
        }// end function

        public function work() : void
        {
            var startTime:Number;
            var checkInterval:int;
            var ms:int;
            if (!this.isRunning)
            {
                return;
            }
            try
            {
                startTime = new Date().time;
                while (true)
                {
                    
                    checkInterval;
                    do
                    {
                        
                        try
                        {
                            do
                            {
                                
                                gworker.work();
                                checkInterval = (checkInterval - 1);
                            }while (checkInterval > 0)
                        }
                        catch (e:AlchemyDispatch)
                        {
                        }
                    }while (checkInterval > 0)
                    if (new Date().time - startTime >= 1000 * 10)
                    {
                        throw new AlchemyYield();
                    }
                }
            }
            catch (e:AlchemyExit)
            {
                timer.stop();
                e.system.exit(e.rv);
                ;
            }
            catch (e:AlchemyYield)
            {
                ms = e.ms;
                timer.delay = ms > 0 ? (ms) : (1);
                ;
            }
            catch (e:AlchemyBlock)
            {
                timer.delay = 10;
                ;
            }
            catch (e:AlchemyBreakpoint)
            {
                throw e;
            }
            return;
        }// end function

        public function startSystemBridge(param1:String, param2:int) : void
        {
            log(3, "bridge: " + param1 + " port: " + param2);
            system = new CSystemBridge(param1, param2);
            system.setup(this.startInit);
            return;
        }// end function

        public function rawAllocString(param1:String) : int
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            _loc_2 = ds.length;
            ds.length = ds.length + (param1.length + 1);
            ds.position = _loc_2;
            _loc_3 = 0;
            while (_loc_3 < param1.length)
            {
                
                ds.writeByte(param1.charCodeAt(_loc_3));
                _loc_3 = _loc_3 + 1;
            }
            ds.writeByte(0);
            return _loc_2;
        }// end function

        public function rawAllocStringArray(param1:Array) : Array
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            _loc_2 = [];
            _loc_3 = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_2.push(this.rawAllocString(param1[_loc_3]));
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        public function resume() : void
        {
            var _loc_1:* = this;
            _loc_1.suspended = this.suspended - 1;
            if (!--this.suspended)
            {
                this.startWork();
            }
            return;
        }// end function

        public function startSystem() : void
        {
            var request:URLRequest;
            var loader:URLLoader;
            if (!this.forceSyncSystem)
            {
                request = new URLRequest(".swfbridge");
                loader = new URLLoader();
                loader.dataFormat = URLLoaderDataFormat.TEXT;
                loader.addEventListener(Event.COMPLETE, function (event:Event) : void
            {
                var _loc_2:* = null;
                _loc_2 = new XML(loader.data);
                if (_loc_2)
                {
                }
                if (_loc_2.name() == "bridge")
                {
                }
                if (_loc_2.host)
                {
                }
                if (_loc_2.port)
                {
                    startSystemBridge(_loc_2.host, _loc_2.port);
                }
                else
                {
                    startSystemLocal();
                }
                return;
            }// end function
            );
                loader.addEventListener(IOErrorEvent.IO_ERROR, function (event:Event) : void
            {
                startSystemLocal();
                return;
            }// end function
            );
                loader.load(request);
                return;
            }
            this.startSystemLocal(true);
            return;
        }// end function

        public function rawAllocIntArray(param1:Array) : int
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            _loc_2 = ds.length;
            ds.length = ds.length + (param1.length + 1) * 4;
            ds.position = _loc_2;
            _loc_3 = 0;
            while (_loc_3 < param1.length)
            {
                
                ds.writeInt(param1[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        public function startSystemLocal(param1:Boolean = false) : void
        {
            log(3, "local system");
            system = new CSystemLocal(param1);
            system.setup(this.startInit);
            return;
        }// end function

        public function suspend() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this.suspended + 1;
            _loc_1.suspended = _loc_2;
            if (this.timer)
            {
            }
            if (this.timer.running)
            {
                this.timer.stop();
            }
            return;
        }// end function

    }
}
