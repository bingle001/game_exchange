package wcks.misc
{
    import flash.utils.*;

    public class DictionaryTree extends Object
    {
        public var storage:Dictionary;

        public function DictionaryTree()
        {
            this.storage = new Dictionary();
            return;
        }// end function

        public function store(param1:Array, param2) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = param1.shift();
            if (param1.length == 0)
            {
                this.storage[_loc_3] = param2;
            }
            else
            {
                _loc_4 = this.storage[_loc_3] as DictionaryTree;
                if (!_loc_4)
                {
                    var _loc_5:* = new DictionaryTree();
                    this.storage[_loc_3] = new DictionaryTree();
                    _loc_4 = _loc_5;
                }
                _loc_4.store(param1, param2);
            }
            return;
        }// end function

        public function retrieve(param1:Array)
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.shift();
            if (param1.length == 0)
            {
                return this.storage[_loc_2];
            }
            _loc_3 = this.storage[_loc_2] as DictionaryTree;
            if (!_loc_3)
            {
                return undefined;
            }
            return _loc_3.retrieve(param1);
        }// end function

        public function remove(param1:Array) : void
        {
            var _loc_2:* = param1.shift();
            var _loc_3:* = this.storage[_loc_2] as DictionaryTree;
            if (param1.length == 0)
            {
                if (_loc_3)
                {
                    _loc_3.flush();
                }
                delete this.storage[_loc_2];
            }
            else if (_loc_3)
            {
                _loc_3.remove(param1);
                if (_loc_3.isEmpty())
                {
                    delete this.storage[_loc_2];
                }
            }
            return;
        }// end function

        public function isEmpty() : Boolean
        {
            return Util.dictionaryIsEmpty(this.storage);
        }// end function

        public function flush() : void
        {
            var _loc_1:* = undefined;
            var _loc_2:* = null;
            for (_loc_1 in this.storage)
            {
                
                _loc_2 = this.storage[_loc_1] as DictionaryTree;
                if (_loc_2)
                {
                    _loc_2.flush();
                }
                delete this.storage[_loc_1];
            }
            return;
        }// end function

        public function get values() : Array
        {
            var vals:Array;
            vals;
            this.forEach(function (param1:Array, param2) : void
            {
                vals.push(param2);
                return;
            }// end function
            );
            return vals;
        }// end function

        public function forEach(param1:Function, param2 = null) : void
        {
            this._forEach(param1, this.filter, param2, []);
            return;
        }// end function

        public function _forEach(param1:Function, param2:Function, param3, param4:Array) : void
        {
            var _loc_5:* = undefined;
            var _loc_6:* = null;
            for (_loc_5 in this.storage)
            {
                
                param4.push(_loc_5);
                _loc_6 = this.storage[_loc_5] as DictionaryTree;
                if (_loc_6)
                {
                    _loc_6._forEach(param1, param2, param3, param4);
                }
                else if (this.param2(this.storage[_loc_5]))
                {
                    param1.apply(param3, [param4.concat(), this.storage[_loc_5]]);
                }
                param4.pop();
            }
            return;
        }// end function

        public function filter(param1) : Boolean
        {
            return true;
        }// end function

    }
}
