package cmodule.Box2D
{
    import __AS3__.vec.*;
    import flash.utils.*;

    public class MState extends MemUser
    {
        public var esp:int;
        public const syms:Object;
        public const ds:ByteArray;
        public var eax:int;
        public var cf:uint;
        public var gworker:Machine;
        public var st0:Number;
        public var ebp:int;
        public var funcs:Vector.<Object>;
        public var edx:int;
        public var system:CSystem;

        public function MState(param1:Machine)
        {
            if ( != null)
            {
            }
            this.ds = ds == null ? (get()) : (ds);
            this.syms =  == null ? ({}) : (syms);
            this.system =  == null ? (null) : (system);
            this.funcs =  == null ? (new Vector.<Object>(1)) : (funcs);
            if (param1)
            {
                this.gworker = param1;
                this.gworker.mstate = this;
            }
            if ( == null)
            {
                this.ds.length = this.ds.length + ;
                this.esp = this.ds.length;
            }
            return;
        }// end function

        public function copyTo(param1:MState) : void
        {
            param1.esp = this.esp;
            param1.ebp = this.ebp;
            param1.eax = this.eax;
            param1.edx = this.edx;
            param1.st0 = this.st0;
            param1.cf = this.cf;
            param1.gworker = this.gworker;
            return;
        }// end function

        public function pop() : int
        {
            var _loc_1:* = 0;
            _loc_1 = _mr32(this.esp);
            this.esp = this.esp + 4;
            return _loc_1;
        }// end function

        public function push(param1:int) : void
        {
            this.esp = this.esp - 4;
            _mw32(this.esp, param1);
            return;
        }// end function

    }
}
