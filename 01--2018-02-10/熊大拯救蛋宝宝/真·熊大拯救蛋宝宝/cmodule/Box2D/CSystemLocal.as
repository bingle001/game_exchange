package cmodule.Box2D
{
    import cmodule.Box2D.*;
    import flash.events.*;
    import flash.net.*;
    import flash.text.*;
    import flash.utils.*;

    public class CSystemLocal extends Object implements CSystem
    {
        private const statCache:Object;
        private var forceSync:Boolean;
        private const fds:Array;

        public function CSystemLocal(param1:Boolean = false)
        {
            this.fds = [];
            this.statCache = {};
            this.forceSync = param1;
             = new TextField();
            width =  ? (stage.stageWidth) : (800);
            height =  ? (stage.stageHeight) : (600);
            multiline = true;
            defaultTextFormat = new TextFormat("Courier New");
            type = TextFieldType.INPUT;
            doubleClickEnabled = true;
            this.fds[0] = new TextFieldI();
            this.fds[1] = new TextFieldO(,  == null);
            this.fds[2] = new TextFieldO(, true);
            if ()
            {
            }
            if ()
            {
                addChild();
            }
            else
            {
                log(3, "local system w/o gsprite");
            }
            return;
        }// end function

        public function getargv() : Array
        {
            return ;
        }// end function

        public function lseek(param1:int, param2:int, param3:int) : int
        {
            var _loc_4:* = null;
            _loc_4 = this.fds[param1];
            if (param3 == 0)
            {
                _loc_4.position = param2;
            }
            else if (param3 == 1)
            {
                _loc_4.position = _loc_4.position + param2;
            }
            else if (param3 == 2)
            {
                _loc_4.position = _loc_4.size + param2;
            }
            return _loc_4.position;
        }// end function

        public function open(param1:int, param2:int, param3:int) : int
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            _loc_4 = gworker.stringFromPtr(param1);
            if (param2 != 0)
            {
                log(3, "failed open(" + _loc_4 + ") flags(" + param2 + ")");
                return -1;
            }
            _loc_5 = this.fetch(_loc_4);
            if (_loc_5.pending)
            {
                throw new AlchemyBlock();
            }
            if (_loc_5.size < 0)
            {
                log(3, "failed open(" + _loc_4 + ") doesn\'t exist");
                return -1;
            }
            _loc_6 = 0;
            while (this.fds[_loc_6])
            {
                
                _loc_6 = _loc_6 + 1;
            }
            _loc_7 = new ByteArrayIO();
            _loc_7.byteArray = new ByteArray();
            _loc_7.byteArray.writeBytes(_loc_5.data);
            _loc_7.byteArray.position = 0;
            this.fds[_loc_6] = _loc_7;
            log(4, "open(" + _loc_4 + "): " + _loc_7.size);
            return _loc_6;
        }// end function

        public function psize(param1:int) : int
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            _loc_2 = gworker.stringFromPtr(param1);
            _loc_3 = this.fetch(_loc_2);
            if (_loc_3.pending)
            {
                throw new AlchemyBlock();
            }
            if (_loc_3.size < 0)
            {
                log(3, "psize(" + _loc_2 + ") failed");
            }
            else
            {
                log(3, "psize(" + _loc_2 + "): " + _loc_3.size);
            }
            return _loc_3.size;
        }// end function

        public function read(param1:int, param2:int, param3:int) : int
        {
            return this.fds[param1].read(param2, param3);
        }// end function

        public function getenv() : Object
        {
            return ;
        }// end function

        public function write(param1:int, param2:int, param3:int) : int
        {
            return this.fds[param1].write(param2, param3);
        }// end function

        public function access(param1:int, param2:int) : int
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            _loc_3 = gworker.stringFromPtr(param1);
            if (param2 & ~4)
            {
                log(3, "failed access(" + _loc_3 + ") mode(" + param2 + ")");
                return -1;
            }
            _loc_4 = this.fetch(_loc_3);
            if (_loc_4.pending)
            {
                throw new AlchemyBlock();
            }
            log(3, "access(" + _loc_3 + "): " + (_loc_4.size >= 0));
            if (_loc_4.size < 0)
            {
                return -1;
            }
            return 0;
        }// end function

        public function exit(param1:int) : void
        {
            log(3, "exit: " + param1);
            shellExit(param1);
            return;
        }// end function

        public function fsize(param1:int) : int
        {
            return this.fds[param1].size;
        }// end function

        public function tell(param1:int) : int
        {
            return this.fds[param1].position;
        }// end function

        public function ioctl(param1:int, param2:int, param3:int) : int
        {
            return -1;
        }// end function

        public function close(param1:int) : int
        {
            var _loc_2:* = 0;
            _loc_2 = this.fds[param1].close();
            this.fds[param1] = null;
            return _loc_2;
        }// end function

        private function fetch(param1:String) : Object
        {
            var res:Object;
            var gf:ByteArray;
            var request:URLRequest;
            var loader:URLLoader;
            var path:* = param1;
            res = this.statCache[path];
            if (!res)
            {
                gf = [path];
                if (gf)
                {
                    res;
                    this.statCache[path] = res;
                    return res;
                }
            }
            if (this.forceSync)
            {
                if (!res)
                {
                }
                return {size:-1, pending:false};
            }
            if (!res)
            {
                request = new URLRequest(path);
                loader = new URLLoader();
                loader.dataFormat = URLLoaderDataFormat.BINARY;
                loader.addEventListener(Event.COMPLETE, function (event:Event) : void
            {
                statCache[path].data = loader.data;
                statCache[path].size = loader.data.length;
                statCache[path].pending = false;
                return;
            }// end function
            );
                loader.addEventListener(IOErrorEvent.IO_ERROR, function (event:Event) : void
            {
                statCache[path].size = -1;
                statCache[path].pending = false;
                return;
            }// end function
            );
                var _loc_3:* = {pending:true};
                res;
                this.statCache[path] = _loc_3;
                loader.load(request);
            }
            return res;
        }// end function

        public function setup(param1:Function) : void
        {
            this.param1();
            return;
        }// end function

    }
}
