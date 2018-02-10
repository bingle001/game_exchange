package cmodule.Box2D
{
    import cmodule.Box2D.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class CSystemBridge extends Object implements CSystem
    {
        private var curPackBuf:ByteArray;
        private var sock:Socket;
        private var requests:Object;
        private var sentPackId:int = 1;
        private var curPackLen:int;
        var argv:Array;
        private var handlers:Object;
        var env:Object;
        private var curPackId:int;
        static const TELL:int = 9;
        static const ACCESS:int = 3;
        static const EXIT:int = 10;
        static const FSIZE:int = 1;
        static const OPEN:int = 4;
        static const LSEEK:int = 8;
        static const PSIZE:int = 2;
        static const READ:int = 7;
        static const CLOSE:int = 5;
        static const SETUP:int = 11;
        static const WRITE:int = 6;

        public function CSystemBridge(param1:String, param2:int)
        {
            this.curPackBuf = new LEByteArray();
            this.handlers = {};
            this.requests = {};
            this.sock = new Socket();
            this.sock.endian = "littleEndian";
            this.sock.addEventListener(Event.CONNECT, this.sockConnect);
            this.sock.addEventListener(ProgressEvent.SOCKET_DATA, this.sockData);
            this.sock.addEventListener(IOErrorEvent.IO_ERROR, this.sockError);
            this.sock.connect(param1, param2);
            return;
        }// end function

        public function psize(param1:int) : int
        {
            var p:* = param1;
            return this.asyncReq(function (param1:ByteArray) : void
            {
                param1.writeInt(PSIZE);
                param1.writeUTFBytes(gworker.stringFromPtr(p));
                return;
            }// end function
            , function (param1:ByteArray) : int
            {
                return param1.readInt();
            }// end function
            );
        }// end function

        private function asyncReq(param1:Function, param2:Function)
        {
            var rid:String;
            var req:Object;
            var pack:ByteArray;
            var create:* = param1;
            var handle:* = param2;
            rid = String(esp);
            req = this.requests[rid];
            if (req)
            {
                if (req.pending)
                {
                    throw new AlchemyBlock();
                }
                delete this.requests[rid];
                return req.result;
            }
            else
            {
                req;
                this.requests[rid] = req;
                pack = new LEByteArray();
                this.create(pack);
                this.sendRequest(pack, function (param1:ByteArray) : void
            {
                req.result = handle(param1);
                req.pending = false;
                return;
            }// end function
            );
                if (req.pending)
                {
                    throw new AlchemyBlock();
                }
            }
            return;
        }// end function

        public function setup(param1:Function) : void
        {
            var pack:ByteArray;
            var f:* = param1;
            pack = new LEByteArray();
            pack.writeInt(SETUP);
            this.sendRequest(pack, function (param1:ByteArray) : void
            {
                var _loc_4:* = null;
                var _loc_2:* = param1.readInt();
                argv = [];
                while (_loc_2--)
                {
                    
                    argv.push(param1.readUTF());
                }
                var _loc_3:* = param1.readInt();
                env = {};
                while (_loc_3--)
                {
                    
                    _loc_4 = /([^\=]*)\=(.*)""([^\=]*)\=(.*)/.exec(param1.readUTF());
                    if (_loc_4)
                    {
                    }
                    if (_loc_4.length == 3)
                    {
                        env[_loc_4[1]] = _loc_4[2];
                    }
                }
                f();
                return;
            }// end function
            );
            return;
        }// end function

        private function sockConnect(event:Event) : void
        {
            log(2, "bridge connected");
            return;
        }// end function

        private function sockData(event:ProgressEvent) : void
        {
            var _loc_2:* = 0;
            while (this.sock.bytesAvailable)
            {
                
                if (!this.curPackLen)
                {
                    if (this.sock.bytesAvailable >= 8)
                    {
                        this.curPackId = this.sock.readInt();
                        this.curPackLen = this.sock.readInt();
                        log(3, "bridge packet id: " + this.curPackId + " len: " + this.curPackLen);
                        this.curPackBuf.length = this.curPackLen;
                        this.curPackBuf.position = 0;
                    }
                    else
                    {
                        break;
                    }
                    continue;
                }
                _loc_2 = this.sock.bytesAvailable;
                if (_loc_2 > this.curPackLen)
                {
                    _loc_2 = this.curPackLen;
                }
                this.curPackLen = this.curPackLen - _loc_2;
                while (_loc_2--)
                {
                    
                    this.curPackBuf.writeByte(this.sock.readByte());
                }
                if (!this.curPackLen)
                {
                    this.handlePacket();
                }
            }
            return;
        }// end function

        public function read(param1:int, param2:int, param3:int) : int
        {
            var fd:* = param1;
            var buf:* = param2;
            var nbytes:* = param3;
            return this.asyncReq(function (param1:ByteArray) : void
            {
                param1.writeInt(READ);
                param1.writeInt(fd);
                param1.writeInt(nbytes);
                return;
            }// end function
            , function (param1:ByteArray) : int
            {
                var _loc_2:* = undefined;
                var _loc_3:* = undefined;
                var _loc_4:* = undefined;
                _loc_2 = param1.readInt();
                _loc_3 = "";
                ds.position = buf;
                while (param1.bytesAvailable)
                {
                    
                    _loc_4 = param1.readByte();
                    _loc_3 = _loc_3 + String.fromCharCode(_loc_4);
                    ds.writeByte(_loc_4);
                }
                log(4, "read from: " + fd + " : [" + _loc_3 + "]");
                return _loc_2;
            }// end function
            );
        }// end function

        public function exit(param1:int) : void
        {
            var _loc_2:* = null;
            _loc_2 = new LEByteArray();
            _loc_2.writeInt(EXIT);
            _loc_2.writeInt(param1);
            this.sendRequest(_loc_2, null);
            shellExit(param1);
            return;
        }// end function

        private function sockError(event:IOErrorEvent) : void
        {
            log(2, "bridge error");
            return;
        }// end function

        public function tell(param1:int) : int
        {
            var fd:* = param1;
            return this.asyncReq(function (param1:ByteArray) : void
            {
                param1.writeInt(TELL);
                param1.writeInt(fd);
                return;
            }// end function
            , function (param1:ByteArray) : int
            {
                return param1.readInt();
            }// end function
            );
        }// end function

        public function ioctl(param1:int, param2:int, param3:int) : int
        {
            return -1;
        }// end function

        public function getargv() : Array
        {
            return this.argv;
        }// end function

        public function open(param1:int, param2:int, param3:int) : int
        {
            var path:* = param1;
            var flags:* = param2;
            var mode:* = param3;
            return this.asyncReq(function (param1:ByteArray) : void
            {
                param1.writeInt(OPEN);
                param1.writeInt(flags);
                param1.writeInt(mode);
                param1.writeUTFBytes(gworker.stringFromPtr(path));
                return;
            }// end function
            , function (param1:ByteArray) : int
            {
                return param1.readInt();
            }// end function
            );
        }// end function

        private function handlePacket() : void
        {
            this.curPackBuf.position = 0;
            var _loc_1:* = this.handlers;
            _loc_1.this.handlers[this.curPackId](this.curPackBuf);
            if (this.curPackId)
            {
                delete this.handlers[this.curPackId];
            }
            return;
        }// end function

        public function getenv() : Object
        {
            return this.env;
        }// end function

        public function write(param1:int, param2:int, param3:int) : int
        {
            var fd:* = param1;
            var buf:* = param2;
            var nbytes:* = param3;
            return this.asyncReq(function (param1:ByteArray) : void
            {
                param1.writeInt(WRITE);
                param1.writeInt(fd);
                if (nbytes > 4096)
                {
                    nbytes = 4096;
                }
                param1.writeBytes(ds, buf, nbytes);
                return;
            }// end function
            , function (param1:ByteArray) : int
            {
                return param1.readInt();
            }// end function
            );
        }// end function

        private function sendRequest(param1:ByteArray, param2:Function) : void
        {
            if (param2)
            {
                this.handlers[this.sentPackId] = param2;
            }
            this.sock.writeInt(this.sentPackId);
            this.sock.writeInt(param1.length);
            this.sock.writeBytes(param1, 0);
            this.sock.flush();
            var _loc_3:* = this;
            var _loc_4:* = this.sentPackId + 1;
            _loc_3.sentPackId = _loc_4;
            return;
        }// end function

        public function lseek(param1:int, param2:int, param3:int) : int
        {
            var fd:* = param1;
            var offset:* = param2;
            var whence:* = param3;
            return this.asyncReq(function (param1:ByteArray) : void
            {
                param1.writeInt(LSEEK);
                param1.writeInt(fd);
                param1.writeInt(offset);
                param1.writeInt(whence);
                return;
            }// end function
            , function (param1:ByteArray) : int
            {
                return param1.readInt();
            }// end function
            );
        }// end function

        public function fsize(param1:int) : int
        {
            var fd:* = param1;
            return this.asyncReq(function (param1:ByteArray) : void
            {
                param1.writeInt(FSIZE);
                param1.writeInt(fd);
                return;
            }// end function
            , function (param1:ByteArray) : int
            {
                return param1.readInt();
            }// end function
            );
        }// end function

        public function access(param1:int, param2:int) : int
        {
            var path:* = param1;
            var mode:* = param2;
            return this.asyncReq(function (param1:ByteArray) : void
            {
                param1.writeInt(ACCESS);
                param1.writeInt(mode);
                param1.writeUTFBytes(gworker.stringFromPtr(path));
                return;
            }// end function
            , function (param1:ByteArray) : int
            {
                return param1.readInt();
            }// end function
            );
        }// end function

        public function close(param1:int) : int
        {
            var fd:* = param1;
            return this.asyncReq(function (param1:ByteArray) : void
            {
                param1.writeInt(CLOSE);
                param1.writeInt(fd);
                return;
            }// end function
            , function (param1:ByteArray) : int
            {
                return param1.readInt();
            }// end function
            );
        }// end function

    }
}
