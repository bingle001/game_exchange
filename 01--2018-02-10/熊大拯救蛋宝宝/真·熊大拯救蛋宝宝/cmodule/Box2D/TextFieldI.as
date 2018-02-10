package cmodule.Box2D
{
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    class TextFieldI extends IO
    {
        private var m_buf:String = "";
        private var m_tf:TextField;
        private var m_start:int = -1;
        private var m_closed:Boolean = false;

        function TextFieldI(param1:TextField)
        {
            var tf:* = param1;
            this.m_tf = tf;
            this.m_tf.addEventListener(KeyboardEvent.KEY_DOWN, function (event:KeyboardEvent)
            {
                var event:* = event;
                if (String.fromCharCode(event.charCode).toLowerCase() == "d")
                {
                }
                if (event.ctrlKey)
                {
                    m_closed = true;
                }
                if (String.fromCharCode(event.charCode).toLowerCase() == "t")
                {
                }
                if (event.ctrlKey)
                {
                    setTimeout(function () : void
                {
                    m_start = -1;
                    m_tf.text = "";
                    return;
                }// end function
                , 1);
                }
                return;
            }// end function
            );
            this.m_tf.addEventListener(TextEvent.TEXT_INPUT, function (event:TextEvent)
            {
                var _loc_2:* = 0;
                var _loc_3:* = 0;
                var _loc_4:* = 0;
                var _loc_5:* = null;
                var _loc_6:* = null;
                var _loc_7:* = null;
                var _loc_8:* = 0;
                var _loc_9:* = 0;
                var _loc_10:* = 0;
                var _loc_11:* = false;
                _loc_2 = m_tf.length;
                _loc_3 = m_tf.selectionBeginIndex;
                if (m_start >= 0)
                {
                }
                if (m_start > _loc_3)
                {
                    m_start = _loc_3;
                }
                event.preventDefault();
                m_tf.replaceSelectedText(event.text);
                _loc_4 = m_tf.selectionEndIndex;
                _loc_5 = m_tf.getTextFormat(_loc_3, _loc_4);
                _loc_5.bold = false;
                m_tf.setTextFormat(_loc_5, _loc_3, _loc_4);
                if (event.text.indexOf("\n") >= 0)
                {
                    _loc_6 = m_tf.text;
                    _loc_7 = "";
                    _loc_2 = m_tf.length;
                    _loc_8 = m_start;
                    while (_loc_8 < _loc_2)
                    {
                        
                        _loc_5 = m_tf.getTextFormat(_loc_8, (_loc_8 + 1));
                        _loc_11 = _loc_5.bold;
                        if (_loc_11 != null)
                        {
                        }
                        if (!_loc_11.valueOf())
                        {
                            _loc_7 = _loc_7 + _loc_6.charAt(_loc_8);
                        }
                        _loc_8 = _loc_8 + 1;
                    }
                    _loc_7 = _loc_7.replace(/\r""\r/g, "\n");
                    _loc_9 = _loc_7.lastIndexOf("\n");
                    _loc_10 = _loc_2 - (_loc_7.length - _loc_9 - 1);
                    m_tf.setSelection(_loc_10, _loc_10);
                    _loc_7 = _loc_7.substr(0, (_loc_9 + 1));
                    if (!m_closed)
                    {
                        m_buf = m_buf + _loc_7;
                    }
                    m_start = _loc_10;
                }
                return;
            }// end function
            );
            return;
        }// end function

        override public function read(param1:int, param2:int) : int
        {
            var _loc_3:* = 0;
            if (!this.m_buf)
            {
                if (this.m_closed)
                {
                    return 0;
                }
                throw new AlchemyBlock();
            }
            _loc_3 = 0;
            do
            {
                
                _loc_3 = _loc_3 + 1;
                _mw8(param1++, this.m_buf.charCodeAt(0));
                this.m_buf = this.m_buf.substr(1);
                if (this.m_buf)
                {
                }
            }while (param2--)
            return _loc_3;
        }// end function

    }
}
