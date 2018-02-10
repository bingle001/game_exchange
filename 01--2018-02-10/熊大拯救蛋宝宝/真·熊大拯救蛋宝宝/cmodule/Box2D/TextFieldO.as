package cmodule.Box2D
{
    import flash.text.*;

    class TextFieldO extends IO
    {
        private var m_trace:Boolean;
        private var m_tf:TextField;

        function TextFieldO(param1:TextField, param2:Boolean = false)
        {
            this.m_tf = param1;
            this.m_trace = param2;
            return;
        }// end function

        override public function write(param1:int, param2:int) : int
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_3:* = param2;
            _loc_4 = "";
            while (_loc_3--)
            {
                
                _loc_4 = _loc_4 + String.fromCharCode(_mru8(param1));
                param1 = param1 + 1;
            }
            if (this.m_trace)
            {
                trace(_loc_4);
            }
            _loc_5 = this.m_tf.length;
            this.m_tf.replaceText(_loc_5, _loc_5, _loc_4);
            _loc_6 = this.m_tf.length;
            _loc_7 = this.m_tf.getTextFormat(_loc_5, _loc_6);
            _loc_7.bold = true;
            this.m_tf.setTextFormat(_loc_7, _loc_5, _loc_6);
            this.m_tf.setSelection(_loc_6, _loc_6);
            return param2;
        }// end function

    }
}
