package cmodule.Box2D
{

    public class Machine extends MemUser
    {
        public var dbgFileId:int = 0;
        public var mstate:MState;
        public var dbgLabel:int = 0;
        public var caller:Machine;
        public var state:int = 0;
        public var dbgLineNo:int = 0;
        public static var dbgFrameBreakLow:int = 0;
        public static const dbgFileNames:Array = [];
        public static const dbgFuncs:Array = [];
        public static const dbgGlobals:Array = [];
        public static const dbgScopes:Array = [];
        public static const dbgLabels:Array = [];
        public static var sMS:uint;
        public static const dbgBreakpoints:Object = {};
        public static const dbgFuncNames:Array = [];
        public static const dbgLocs:Array = [];
        public static var dbgFrameBreakHigh:int = -1;

        public function Machine()
        {
            this.caller =  ? (gworker) : (null);
            this.mstate = this.caller ? (this.caller.mstate) : (null);
            return;
        }// end function

        public function debugTraceMem(param1:int, param2:int) : void
        {
            trace("");
            trace("*****");
            while (param1 <= param2)
            {
                
                trace("* " + param1 + " : " + this.mstate._mr32(param1));
                param1 = param1 + 4;
            }
            trace("");
            return;
        }// end function

        public function get dbgFuncId() : int
        {
            return -1;
        }// end function

        public function work() : void
        {
            throw new AlchemyYield();
        }// end function

        public function stringFromPtr(param1:int) : String
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            _loc_2 = "";
            while (true)
            {
                
                _loc_3 = this.mstate._mru8(param1++);
                if (!_loc_3)
                {
                    break;
                }
                _loc_2 = _loc_2 + String.fromCharCode(_loc_3);
            }
            return _loc_2;
        }// end function

        public function get dbgLoc() : Object
        {
            return {fileId:this.dbgFileId, lineNo:this.dbgLineNo};
        }// end function

        public function get dbgDepth() : int
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            _loc_1 = this;
            while (_loc_1)
            {
                
                _loc_2 = _loc_2 + 1;
                _loc_1 = _loc_1.caller;
            }
            return _loc_2;
        }// end function

        public function get dbgTrace() : String
        {
            return this.dbgFuncName + "(" + (this as Object).constructor + ") - " + this.dbgFileName + " : " + this.dbgLineNo + "(" + this.state + ")";
        }// end function

        public function debugTraverseCurrentScope(param1:Function) : void
        {
            debugTraverseScope(dbgScopes[this.dbgFuncId], this.dbgLabel, param1);
            return;
        }// end function

        public function debugLabel(param1:int) : void
        {
            this.dbgLabel = param1;
            return;
        }// end function

        public function stringToPtr(param1:int, param2:int, param3:String) : int
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            _loc_4 = param3.length;
            if (param2 >= 0)
            {
            }
            if (param2 < _loc_4)
            {
                _loc_4 = param2;
            }
            _loc_5 = 0;
            while (_loc_5 < _loc_4)
            {
                
                this.mstate._mw8(param1++, param3.charCodeAt(_loc_5));
                _loc_5 = _loc_5 + 1;
            }
            return _loc_4;
        }// end function

        public function debugBreak(param1:Object) : void
        {
            throw new AlchemyBreakpoint(param1);
        }// end function

        public function debugLoc(param1:int, param2:int) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            if (this.dbgFileId == param1)
            {
            }
            if (this.dbgLineNo == param2)
            {
                return;
            }
            this.dbgFileId = param1;
            this.dbgLineNo = param2;
            _loc_3 = param1 + ":" + param2;
            _loc_4 = dbgBreakpoints[_loc_3];
            if (_loc_4)
            {
            }
            if (_loc_4.enabled)
            {
                if (_loc_4.temp)
                {
                    delete dbgBreakpoints[_loc_3];
                }
                this.debugBreak(_loc_4);
            }
            else if (dbgFrameBreakHigh >= dbgFrameBreakLow)
            {
                _loc_5 = this.dbgDepth;
                if (_loc_5 >= dbgFrameBreakLow)
                {
                }
                if (_loc_5 <= dbgFrameBreakHigh)
                {
                    this.debugBreak(null);
                }
            }
            return;
        }// end function

        public function get dbgFileName() : String
        {
            return dbgFileNames[this.dbgFileId];
        }// end function

        public function getSecsSetMS() : uint
        {
            var _loc_1:* = NaN;
            _loc_1 = new Date().time;
            sMS = _loc_1 % 1000;
            return _loc_1 / 1000;
        }// end function

        public function get dbgFuncName() : String
        {
            return dbgFuncNames[this.dbgFuncId];
        }// end function

        public function backtrace() : void
        {
            var cur:Machine;
            var framePtr:int;
            cur;
            trace("");
            trace("*** backtrace");
            framePtr = this.mstate.ebp;
            while (cur)
            {
                
                trace(cur.dbgTrace);
                cur.debugTraverseCurrentScope(function (param1:Object) : void
            {
                var _loc_2:* = null;
                var _loc_3:* = 0;
                var _loc_4:* = 0;
                var _loc_5:* = 0;
                var _loc_6:* = null;
                var _loc_7:* = 0;
                trace("{{{");
                _loc_2 = param1.vars;
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    _loc_4 = _loc_2[_loc_3 + 0];
                    _loc_5 = mstate._mr32(_loc_4 + 8);
                    _loc_6 = stringFromPtr(_loc_5);
                    _loc_7 = _loc_2[(_loc_3 + 1)];
                    trace("--- " + _loc_6 + " (" + (_loc_7 + framePtr) + ")");
                    _loc_3 = _loc_3 + 2;
                }
                return;
            }// end function
            );
                framePtr = this.mstate._mr32(framePtr);
                cur = cur.caller;
            }
            trace("");
            return;
        }// end function

        public static function debugTraverseScope(param1:Object, param2:int, param3:Function) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            if (param1)
            {
            }
            if (param2 >= param1.startLabelId)
            {
            }
            if (param2 < param1.endLabelId)
            {
                Machine.param3(param1);
                _loc_4 = param1.scopes;
                _loc_5 = 0;
                while (_loc_5 < _loc_4.length)
                {
                    
                    debugTraverseScope(_loc_4[_loc_5], param2, param3);
                    _loc_5 = _loc_5 + 1;
                }
            }
            return;
        }// end function

    }
}
