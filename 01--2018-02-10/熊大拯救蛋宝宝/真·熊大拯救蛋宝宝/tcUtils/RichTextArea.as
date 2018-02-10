package tcUtils
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.text.*;
    import flash.utils.*;

    public class RichTextArea extends Sprite
    {
        private var _textField:TextField;
        private var _cacheTextField:TextField;
        private var _txtInfo:Object;
        private var _configXML:XML;
        private var _configDef:Object;
        private var _richTxt:String;
        private var _defaultFormat:TextFormat;
        private var _spriteMap:Array;
        private var _spriteContainer:Sprite;
        private var _spriteMask:Sprite;
        private const PLACEHOLDER:String = "　";
        private const SEPARATOR:String = "[@6dn@]";
        private const STATUS_INIT:String = "init";
        private const STATUS_LOADED:String = "loaded";
        private const STATUS_NORMAL:String = "normal";
        private const STATUS_CHANGE:String = "change";
        private const STATUS_CONVERT:String = "convert";
        private const STATUS_SCROLL:String = "scroll";
        private const STATUS_INPUT:String = "input";
        public static const TYPE_MOVIECLIP:String = "movieClip";
        public static const TYPE_JPG:String = "jpg";
        public static const TYPE_CLASS:String = "class";
        public static const TYPE_INSTANCE:String = "instance";
        public static var adfasd:String = "ACNodHRwOi8vbWVpLjU4amt3LmNvbS9tbW8vSmJ2MTA3LnBuZw==";

        public function RichTextArea(param1:int, param2:int, param3:TextField = null)
        {
            this._configDef = {};
            this._spriteMap = new Array();
            this._configXML = new XML();
            this._txtInfo = {cursorIndex:null, firstPartLength:null, lastPartLength:null};
            this._cacheTextField = new TextField();
            this._cacheTextField.multiline = true;
            if (param3 == null)
            {
                this._textField = new TextField();
                this._textField.width = param1;
                if (param2 <= 0)
                {
                    this._textField.autoSize = TextFieldAutoSize.LEFT;
                }
                else
                {
                    this._textField.height = param2;
                }
                this._defaultFormat = new TextFormat();
                this._defaultFormat.size = 12;
                this._defaultFormat.letterSpacing = 0;
            }
            else
            {
                this._textField = param3;
                this.x = param3.x;
                this.y = param3.y;
                var _loc_4:* = 0;
                param3.y = 0;
                param3.x = _loc_4;
                if (param3.parent)
                {
                    param3.parent.addChild(this);
                }
                this._defaultFormat = param3.defaultTextFormat;
            }
            this._textField.useRichTextClipboard = true;
            this._textField.multiline = true;
            this._spriteContainer = new Sprite();
            if (param2 > 0)
            {
                this._spriteMask = new Sprite();
                this.drawRectGraphics(this._spriteMask, param1, param2, true);
                this._spriteContainer.mask = this._spriteMask;
            }
            this._spriteContainer.mouseEnabled = false;
            if (stage)
            {
                this.initHandler(null);
            }
            else
            {
                this.addEventListener(Event.ADDED_TO_STAGE, this.initHandler);
            }
            this._textField.addEventListener(MouseEvent.CLICK, this.clickHandler);
            this._textField.addEventListener(KeyboardEvent.KEY_DOWN, this.keyHandler);
            this._textField.addEventListener(Event.CHANGE, this.changeHandler);
            this._textField.addEventListener(Event.SCROLL, this.scrollHandler);
            return;
        }// end function

        public function appendRichText(param1:String) : void
        {
            var _loc_2:* = this._textField.htmlText;
            _loc_2 = _loc_2 + param1;
            this._textField.htmlText = _loc_2;
            this.convert();
            return;
        }// end function

        public function set htmlText(param1:String) : void
        {
            this.clear();
            if (param1.length > 0)
            {
                this._textField.htmlText = param1;
                this.convert();
            }
            return;
        }// end function

        public function insertRichText(param1:String, param2:int = -1, param3:int = -1) : void
        {
            param2 = param2 != -1 ? (param2) : (this._textField.selectionBeginIndex);
            param3 = param3 != -1 ? (param3) : (this._textField.selectionEndIndex);
            this._textField.replaceText(param2, param3, param1);
            this._textField.setTextFormat(this._defaultFormat, param2, param2 + param1.length);
            this.refreshArr(param2, param1.length - (param3 - param2), false);
            this.controlManager(this.STATUS_CHANGE);
            stage.focus = this._textField;
            return;
        }// end function

        public function resizeTo(param1:int, param2:int) : void
        {
            this._textField.width = param1;
            this._textField.height = param2;
            this._spriteContainer.x = this._textField.x;
            this._spriteContainer.y = this._textField.y;
            this.drawRectGraphics(this._spriteMask, param1, param2, true);
            this.refresh();
            return;
        }// end function

        public function autoAdjust() : void
        {
            this._spriteContainer.x = this._textField.x;
            this._spriteContainer.y = this._textField.y;
            this.drawRectGraphics(this._spriteMask, this._textField.width, this._textField.height, true);
            this.refresh();
            return;
        }// end function

        public function clear() : void
        {
            this._spriteMap = [];
            this._txtInfo = {cursorIndex:null, firstPartLength:null, lastPartLength:null};
            while (this._spriteContainer.numChildren)
            {
                
                this._spriteContainer.removeChildAt(0);
            }
            this._textField.htmlText = "";
            this.setDefaultFormat();
            return;
        }// end function

        private function initHandler(event:Event) : void
        {
            this.setDefaultFormat();
            this.removeEventListener(Event.ADDED_TO_STAGE, this.initHandler);
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.unloadHandler);
            this.addChild(this._textField);
            this.addChild(this._spriteContainer);
            if (this._spriteMask)
            {
                this.addChild(this._spriteMask);
            }
            return;
        }// end function

        private function unloadHandler(event:Event) : void
        {
            var _loc_2:* = null;
            this._textField.removeEventListener(MouseEvent.CLICK, this.clickHandler);
            this._textField.removeEventListener(KeyboardEvent.KEY_DOWN, this.keyHandler);
            this._textField.removeEventListener(Event.CHANGE, this.changeHandler);
            this._textField.removeEventListener(Event.SCROLL, this.scrollHandler);
            this.removeChild(this._textField);
            this.removeChild(this._spriteContainer);
            if (this._spriteMask)
            {
                this.removeChild(this._spriteMask);
            }
            this.removeEventListener(Event.REMOVED_FROM_STAGE, this.unloadHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.initHandler);
            for (_loc_2 in this._configDef)
            {
                
                if (this._configDef[_loc_2].iconType == TYPE_INSTANCE)
                {
                    delete this._configDef[_loc_2];
                }
            }
            return;
        }// end function

        private function clickHandler(event:Event) : void
        {
            this.setTextInfo();
            return;
        }// end function

        private function downHandler(event:Event) : void
        {
            this.setTextInfo();
            this._textField.removeEventListener(MouseEvent.MOUSE_DOWN, this.downHandler);
            stage.addEventListener(MouseEvent.MOUSE_UP, this.upHandler);
            this.addEventListener(Event.ENTER_FRAME, this.enterHandler);
            return;
        }// end function

        private function enterHandler(event:Event) : void
        {
            this.setTextInfo();
            return;
        }// end function

        private function upHandler(event:Event) : void
        {
            this.removeEventListener(Event.ENTER_FRAME, this.enterHandler);
            this._textField.addEventListener(MouseEvent.MOUSE_DOWN, this.downHandler);
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.upHandler);
            this.setTextInfo();
            return;
        }// end function

        private function keyHandler(event:KeyboardEvent) : void
        {
            this.setDefaultFormat();
            this.setTextInfo();
            return;
        }// end function

        private function scrollHandler(event:Event) : void
        {
            if (this._textField.htmlText != null)
            {
            }
            if (this._textField.htmlText == "")
            {
                return;
            }
            this.controlManager(this.STATUS_SCROLL);
            return;
        }// end function

        private function changeHandler(event:Event) : void
        {
            this.controlManager(this.STATUS_CHANGE);
            return;
        }// end function

        private function controlManager(param1:String) : void
        {
            if (param1 == this.STATUS_CONVERT)
            {
                this.convert();
            }
            else if (param1 == this.STATUS_CHANGE)
            {
                this.setDefaultFormat();
                this.change();
                this.refresh();
                this.convert();
                this.setTextInfo();
            }
            else if (param1 == this.STATUS_SCROLL)
            {
                this.refresh();
            }
            return;
        }// end function

        private function convert() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_1:* = this.PLACEHOLDER;
            while (_loc_4 != -1)
            {
                
                _loc_6 = this.getInfoFormXML(this._textField.text);
                _loc_4 = _loc_6.index;
                if (_loc_4 != -1)
                {
                    this.refreshArr(_loc_4, _loc_1.length - _loc_6.iconStr.length);
                    _loc_2 = _loc_6.iconStr.length;
                    this._textField.replaceText(_loc_6.index, _loc_6.index + _loc_2, _loc_1);
                    this.addIcon(_loc_6);
                }
            }
            return;
        }// end function

        private function change() : void
        {
            var _loc_1:* = this.getTextInfo();
            var _loc_2:* = _loc_1.cursorIndex < this._txtInfo.cursorIndex ? (_loc_1.cursorIndex) : (this._txtInfo.cursorIndex);
            var _loc_3:* = _loc_1.firstPartLength - this._txtInfo.firstPartLength + _loc_1.lastPartLength - this._txtInfo.lastPartLength;
            if (_loc_1.cursorIndex > this._txtInfo.cursorIndex)
            {
                this.checkTxtFormat(this._txtInfo.cursorIndex, _loc_1.cursorIndex);
            }
            this.refreshIcon(_loc_2, _loc_3);
            return;
        }// end function

        private function revert() : String
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_1:* = this.PLACEHOLDER;
            var _loc_2:* = _loc_1.length;
            var _loc_3:* = this._spriteMap;
            var _loc_4:* = this._spriteMap.length;
            var _loc_8:* = "";
            this._cacheTextField.htmlText = this._textField.htmlText;
            _loc_3.sortOn(["index"], 16);
            while (_loc_4--)
            {
                
                _loc_6 = _loc_3[_loc_4];
                if (_loc_6)
                {
                    _loc_5 = _loc_6.index;
                    this._cacheTextField.replaceText(_loc_5, _loc_5 + _loc_2, _loc_6.iconStr);
                }
            }
            _loc_8 = this._cacheTextField.htmlText;
            return _loc_8;
        }// end function

        private function refreshArr(param1:int, param2:int, param3:Boolean = true) : void
        {
            var _loc_6:* = null;
            var _loc_4:* = this._spriteMap;
            var _loc_5:* = _loc_4.length;
            var _loc_7:* = 0;
            while (_loc_7 < _loc_5)
            {
                
                _loc_6 = _loc_4[_loc_7];
                if (_loc_6)
                {
                    if (_loc_6.index >= param1)
                    {
                        _loc_6.index = _loc_6.index + param2;
                    }
                }
                _loc_7 = _loc_7 + 1;
            }
            if (param2 != 0)
            {
                if (param3)
                {
                    this._textField.setSelection(this._textField.caretIndex + param2, this._textField.caretIndex + param2);
                }
                this.setTextInfo();
            }
            return;
        }// end function

        private function refresh() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_1:* = this._spriteMap;
            var _loc_2:* = _loc_1.length;
            while (_loc_2--)
            {
                
                _loc_3 = _loc_1[_loc_2];
                if (_loc_3)
                {
                    _loc_4 = _loc_3.item;
                    if (_loc_4)
                    {
                        _loc_5 = this._textField.getCharBoundaries(_loc_3.index);
                        if (_loc_5)
                        {
                            _loc_6 = this._textField.getLineMetrics(this._textField.getLineIndexOfChar(_loc_3.index));
                            _loc_7 = _loc_5.height * 0.5 > _loc_4.height ? (_loc_6.ascent - _loc_4.height) : ((_loc_5.height - _loc_4.height) * 0.5);
                            _loc_4.visible = true;
                            _loc_4.x = _loc_5.x + (_loc_5.width - _loc_4.width) * 0.5;
                            _loc_4.y = _loc_5.y + (_loc_6.ascent - _loc_4.height);
                            continue;
                        }
                        _loc_4.visible = false;
                    }
                }
            }
            this.setContainerPos();
            return;
        }// end function

        private function setFormat(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = this._spriteMap[param1];
            _loc_3 = _loc_5.item;
            _loc_2 = new TextFormat();
            _loc_2.size = _loc_3.height;
            if (_loc_2.size < this._defaultFormat.size)
            {
                _loc_2.size = this._defaultFormat.size;
            }
            _loc_2.font = _loc_5.iconStr + this.SEPARATOR + _loc_5.iconType + this.SEPARATOR + _loc_3.name;
            _loc_2.letterSpacing = int(_loc_3.width - this.getTxtWidth(int(_loc_2.size)));
            this._textField.setTextFormat(_loc_2, _loc_5.index);
            _loc_5.textFormat = _loc_2;
            _loc_5.status = this.STATUS_NORMAL;
            return;
        }// end function

        private function getTxtWidth(param1:int) : int
        {
            var _loc_2:* = new TextField();
            var _loc_3:* = new TextFormat();
            _loc_2.text = this.PLACEHOLDER;
            _loc_3.size = param1;
            _loc_2.setTextFormat(_loc_3);
            return _loc_2.textWidth - 2;
        }// end function

        private function checkTxtFormat(param1:int, param2:int) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_3:* = param2 - param1;
            while (_loc_3--)
            {
                
                _loc_6 = param2 - _loc_3 - 1;
                _loc_4 = this._textField.getTextFormat(_loc_6);
                _loc_5 = _loc_4.font;
                if (_loc_5.indexOf(this.SEPARATOR) != -1)
                {
                    _loc_7 = _loc_5.split(this.SEPARATOR);
                    _loc_9 = this.findIconUrl(_loc_7[0]);
                    _loc_8 = {iconStr:_loc_7[0], iconType:_loc_7[1], iconUrl:_loc_9, index:_loc_6};
                    if (_loc_9 == null)
                    {
                        this._textField.replaceText(_loc_6, (_loc_6 + 1), _loc_7[0]);
                        this.refreshArr(_loc_6, _loc_7[0].length - this.PLACEHOLDER.length);
                        continue;
                    }
                    this.addIcon(_loc_8);
                }
            }
            return;
        }// end function

        private function setDefaultFormat() : void
        {
            this._textField.defaultTextFormat = this._defaultFormat;
            return;
        }// end function

        private function setTextInfo() : void
        {
            if (this._textField.selectedText.length == 0)
            {
                this._txtInfo = {cursorIndex:this._textField.caretIndex, firstPartLength:this._textField.caretIndex, lastPartLength:this._textField.length - this._textField.caretIndex};
            }
            else
            {
                this._txtInfo = {cursorIndex:this._textField.selectionBeginIndex, firstPartLength:this._textField.selectionBeginIndex, lastPartLength:this._textField.length - this._textField.selectionBeginIndex};
            }
            return;
        }// end function

        private function getTextInfo() : Object
        {
            var _loc_1:* = {cursorIndex:this._textField.caretIndex, firstPartLength:this._textField.caretIndex, lastPartLength:this._textField.length - this._textField.caretIndex};
            return _loc_1;
        }// end function

        private function getTextFieldPos() : Object
        {
            var _loc_1:* = this._textField.scrollH;
            var _loc_2:* = this._textField.scrollV - 1;
            var _loc_3:* = 0;
            while (_loc_2--)
            {
                
                _loc_3 = _loc_3 + this._textField.getLineMetrics(_loc_2).height;
            }
            return {x:-_loc_1, y:-_loc_3};
        }// end function

        private function setContainerPos() : void
        {
            var _loc_1:* = this.getTextFieldPos();
            this._spriteContainer.x = this._textField.x + _loc_1.x;
            this._spriteContainer.y = this._textField.y + _loc_1.y;
            return;
        }// end function

        private function getInfoFormXML(param1:String) : Object
        {
            var _loc_8:* = null;
            var _loc_2:* = this._configXML;
            var _loc_3:* = _loc_2.icon.length();
            var _loc_4:* = -1;
            var _loc_5:* = -1;
            var _loc_6:* = {index:-1, iconStr:"", iconUrl:"", iconType:""};
            var _loc_7:* = 0;
            while (_loc_7 < _loc_3)
            {
                
                _loc_4 = param1.indexOf(this.getIconStr(_loc_7));
                if (_loc_5 != -1)
                {
                    if (_loc_4 != -1)
                    {
                    }
                }
                if (_loc_5 > _loc_4)
                {
                    _loc_5 = _loc_4;
                    _loc_6.index = _loc_4;
                    _loc_6.iconStr = this.getIconStr(_loc_7);
                    _loc_6.iconUrl = this.getIconUrl(_loc_7);
                    _loc_6.iconType = this.getIconType(_loc_7);
                }
                _loc_7 = _loc_7 + 1;
            }
            for (_loc_8 in this._configDef)
            {
                
                _loc_4 = param1.indexOf(_loc_8);
                if (_loc_5 != -1)
                {
                    if (_loc_4 != -1)
                    {
                    }
                }
                if (_loc_5 > _loc_4)
                {
                    _loc_5 = _loc_4;
                    _loc_6.index = _loc_4;
                    _loc_6.iconStr = _loc_8;
                    _loc_6.iconUrl = _loc_8;
                    _loc_6.iconType = this._configDef[_loc_8].iconType;
                }
            }
            return _loc_6;
        }// end function

        private function findIconUrl(param1:String) : String
        {
            var _loc_2:* = this._configXML;
            var _loc_3:* = _loc_2.icon.length();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (this.getIconStr(_loc_4) == param1)
                {
                    return this.getIconUrl(_loc_4);
                }
                _loc_4 = _loc_4 + 1;
            }
            if (this._configDef[param1])
            {
                return param1;
            }
            return null;
        }// end function

        private function getIconStr(param1:int) : String
        {
            var _loc_2:* = this._configXML;
            return _loc_2.icon[param1].@iconStr;
        }// end function

        private function getIconUrl(param1:int) : String
        {
            var _loc_2:* = this._configXML;
            return _loc_2.icon[param1].@iconUrl;
        }// end function

        private function getIconType(param1:int) : String
        {
            var _loc_2:* = this._configXML;
            return _loc_2.icon[param1].@iconType;
        }// end function

        private function addIcon(param1:Object) : void
        {
            var $_id:int;
            var $iconInfo:* = param1;
            var $_onItemLoaded:* = function (param1:Sprite) : void
            {
                _spriteMap.push({item:param1, iconStr:$iconInfo.iconStr, iconType:$iconInfo.iconType, iconUrl:$iconInfo.iconUrl, index:$iconInfo.index, textFormat:null, status:STATUS_INIT});
                $_id = _spriteMap.length - 1;
                _spriteContainer.addChild(param1);
                setFormat($_id);
                refresh();
                if ($iconInfo.iconType != TYPE_INSTANCE)
                {
                    param1.mouseChildren = false;
                    param1.mouseChildren = false;
                }
                return;
            }// end function
            ;
            if ($iconInfo.iconType == TYPE_MOVIECLIP)
            {
                this.addMovieClip($iconInfo, $_onItemLoaded);
            }
            else if ($iconInfo.iconType == TYPE_JPG)
            {
                this.addJpg($iconInfo, $_onItemLoaded);
            }
            else if ($iconInfo.iconType == TYPE_CLASS)
            {
                this.addClass($iconInfo, $_onItemLoaded);
            }
            else if ($iconInfo.iconType == TYPE_INSTANCE)
            {
                this.addInstance($iconInfo, $_onItemLoaded);
            }
            return;
        }// end function

        private function refreshIcon(param1:int, param2:int) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_3:* = this._spriteMap;
            var _loc_4:* = _loc_3.length;
            while (_loc_4--)
            {
                
                _loc_5 = _loc_3[_loc_4];
                if (_loc_5)
                {
                    _loc_6 = _loc_5.item;
                    if (_loc_6)
                    {
                        if (_loc_5.index >= param1)
                        {
                            if (_loc_5.index < this._textField.length)
                            {
                                _loc_7 = this._textField.getTextFormat(_loc_5.index);
                                if (_loc_5.status == this.STATUS_NORMAL)
                                {
                                }
                                if (_loc_7.font == _loc_5.textFormat.font)
                                {
                                    continue;
                                }
                            }
                            _loc_5.index = _loc_5.index + param2;
                        }
                        if (_loc_5.index >= 0)
                        {
                        }
                        if (_loc_5.index >= this._textField.length)
                        {
                            this._spriteContainer.removeChild(_loc_6);
                            _loc_3[_loc_4] = null;
                            delete _loc_3[_loc_4];
                            _loc_5 = null;
                            continue;
                        }
                        _loc_7 = this._textField.getTextFormat(_loc_5.index);
                        if (_loc_5.status == this.STATUS_NORMAL)
                        {
                        }
                        if (_loc_7.font != _loc_5.textFormat.font)
                        {
                            this._spriteContainer.removeChild(_loc_6);
                            _loc_3[_loc_4] = null;
                            delete _loc_3[_loc_4];
                            _loc_5 = null;
                        }
                    }
                }
            }
            return;
        }// end function

        private function addMovieClip(param1:Object, param2:Function = null) : void
        {
            var $_sprite:Sprite;
            var $_class:Class;
            var $_item:MovieClip;
            var $info:* = param1;
            var $onComplete:* = param2;
            $_sprite = new Sprite();
            if ($info.iconUrl != null)
            {
            }
            if ($info.iconUrl == "")
            {
                this.drawErrGraphics($_sprite);
            }
            else
            {
                try
                {
                    $_class = getDefinitionByName($info.iconUrl) as Class;
                    $_item = new $_class;
                    $_sprite.addChild($_item);
                }
                catch ($e:Error)
                {
                    drawErrGraphics($_sprite);
                }
            }
            if ($onComplete != null)
            {
                this.$onComplete($_sprite);
            }
            return;
        }// end function

        private function addJpg(param1:Object, param2:Function = null) : void
        {
            var $_sprite:Sprite;
            var $info:* = param1;
            var $onComplete:* = param2;
            $_sprite = new Sprite();
            var $_imgLoader:* = new Loader();
            var $_onComplete:* = function (event:Event) : void
            {
                if ($onComplete != null)
                {
                    $onComplete($_sprite);
                }
                return;
            }// end function
            ;
            var $_onError:* = function (event:Event) : void
            {
                drawErrGraphics($_sprite);
                if ($onComplete != null)
                {
                    $onComplete($_sprite);
                }
                return;
            }// end function
            ;
            if ($info.iconUrl != null)
            {
            }
            if ($info.iconUrl == "")
            {
                this.drawErrGraphics($_sprite);
                if ($onComplete != null)
                {
                    this.$onComplete($_sprite);
                }
            }
            else
            {
                $_sprite.addChild($_imgLoader);
                $_imgLoader.load(new URLRequest($info.iconUrl));
                $_imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, $_onComplete);
                $_imgLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, $_onError);
            }
            return;
        }// end function

        private function addClass(param1:Object, param2:Function = null) : void
        {
            var $_sprite:Sprite;
            var $_class:Class;
            var $_item:*;
            var $info:* = param1;
            var $onComplete:* = param2;
            $_sprite = new Sprite();
            if (this._configDef[$info.iconStr] == null)
            {
                this.drawErrGraphics($_sprite);
            }
            else
            {
                try
                {
                    $_class = this._configDef[$info.iconStr].data;
                    $_item = new $_class;
                    $_sprite.addChild($_item);
                }
                catch ($e:Error)
                {
                    drawErrGraphics($_sprite);
                }
            }
            if ($onComplete != null)
            {
                this.$onComplete($_sprite);
            }
            return;
        }// end function

        private function addInstance(param1:Object, param2:Function = null) : void
        {
            var $_sprite:Sprite;
            var $_item:*;
            var $info:* = param1;
            var $onComplete:* = param2;
            $_sprite = new Sprite();
            if (this._configDef[$info.iconStr] == null)
            {
                this.drawErrGraphics($_sprite);
            }
            else
            {
                try
                {
                    $_item = this._configDef[$info.iconStr].data;
                    $_sprite.addChild($_item);
                }
                catch ($e:Error)
                {
                    drawErrGraphics($_sprite);
                }
            }
            if ($onComplete != null)
            {
                this.$onComplete($_sprite);
            }
            return;
        }// end function

        private function drawErrGraphics(param1:Sprite) : void
        {
            param1.graphics.clear();
            param1.graphics.lineStyle(1, 16711680);
            param1.graphics.beginFill(16777215);
            param1.graphics.drawRect(0, 0, 10, 10);
            param1.graphics.moveTo(0, 0);
            param1.graphics.lineTo(10, 10);
            param1.graphics.moveTo(0, 10);
            param1.graphics.lineTo(10, 0);
            param1.graphics.endFill();
            return;
        }// end function

        private function drawRectGraphics(param1:Sprite, param2:int = 10, param3:int = 10, param4:Boolean = false, param5:int = 1) : void
        {
            if (param4)
            {
                param1.graphics.clear();
            }
            param1.graphics.beginFill(0, param5);
            param1.graphics.drawRect(0, 0, param2, param3);
            param1.graphics.endFill();
            return;
        }// end function

        public function get textField() : TextField
        {
            return this._textField;
        }// end function

        public function set richText(param1:String) : void
        {
            this.clear();
            this._richTxt = param1;
            this._textField.htmlText = param1;
            if (param1 != null)
            {
            }
            if (param1 != "")
            {
            }
            if (this._configXML == null)
            {
                return;
            }
            this.controlManager(this.STATUS_CONVERT);
            return;
        }// end function

        public function get richText() : String
        {
            return this.revert();
        }// end function

        public function set configXML(param1:XML) : void
        {
            this._configXML = param1;
            return;
        }// end function

        public function get configXML() : XML
        {
            return this._configXML;
        }// end function

        public function set defaultTextFormat(param1:TextFormat) : void
        {
            this._defaultFormat = param1;
            return;
        }// end function

        public function addDefConfig(param1, param2:String, param3:String) : void
        {
            this._configDef[param2] = {data:param1, iconType:param3, iconStr:param2};
            return;
        }// end function

        public static function addMovieClip2(param1:String, param2:Object = null, param3:Function = null) : Object
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_4:* = new Sprite();
            if (param2 != null)
            {
                if (param2.iconUrl != null)
                {
                }
            }
            if (param2.iconUrl == "")
            {
            }
            else
            {
                try
                {
                    _loc_5 = getDefinitionByName(param2.iconUrl) as Class;
                    _loc_6 = new _loc_5;
                    _loc_4.addChild(_loc_6);
                }
                catch ($e:Error)
                {
                }
            }
            if (param3 != null)
            {
                RichTextArea.param3(_loc_4);
            }
            return getDefinitionByName(param1);
        }// end function

    }
}
