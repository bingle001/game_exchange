package com.greensock.loading.core
{
    import com.greensock.events.*;
    import com.greensock.loading.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;

    public class LoaderCore extends EventDispatcher
    {
        protected var _cachedBytesLoaded:uint;
        protected var _cachedBytesTotal:uint;
        protected var _status:int;
        protected var _prePauseStatus:int;
        protected var _dispatchProgress:Boolean;
        protected var _rootLoader:LoaderMax;
        protected var _cacheIsDirty:Boolean;
        protected var _auditedSize:Boolean;
        protected var _dispatchChildProgress:Boolean;
        protected var _type:String;
        protected var _time:uint;
        protected var _content:Object;
        public var vars:Object;
        public var name:String;
        public var autoDispose:Boolean;
        public static const version:Number = 1.65;
        static var _loaderCount:uint = 0;
        static var _rootLookup:Dictionary = new Dictionary(false);
        static var _isLocal:Boolean;
        static var _globalRootLoader:LoaderMax;
        static var _listenerTypes:Object = {onOpen:"open", onInit:"init", onComplete:"complete", onProgress:"progress", onCancel:"cancel", onFail:"fail", onError:"error", onSecurityError:"securityError", onHTTPStatus:"httpStatus", onIOError:"ioError", onScriptAccessDenied:"scriptAccessDenied", onChildOpen:"childOpen", onChildCancel:"childCancel", onChildComplete:"childComplete", onChildProgress:"childProgress", onChildFail:"childFail"};
        static var _types:Object = {};
        static var _extensions:Object = {};

        public function LoaderCore(param1:Object = null)
        {
            var _loc_2:* = null;
            this.vars = param1 != null ? (param1) : ({});
            if (this.vars.name != undefined)
            {
            }
            this.name = String(this.vars.name) != "" ? (this.vars.name) : ("loader" + _loaderCount++);
            this._cachedBytesLoaded = 0;
            this._cachedBytesTotal = uint(this.vars.estimatedBytes) != 0 ? (uint(this.vars.estimatedBytes)) : (LoaderMax.defaultEstimatedBytes);
            this.autoDispose = Boolean(this.vars.autoDispose == true);
            this._status = this.vars.paused == true ? (LoaderStatus.PAUSED) : (LoaderStatus.READY);
            if (uint(this.vars.estimatedBytes) != 0)
            {
            }
            this._auditedSize = Boolean(this.vars.auditSize != true);
            this._rootLoader = this.vars.requireWithRoot is DisplayObject ? (_rootLookup[this.vars.requireWithRoot]) : (_globalRootLoader);
            if (_globalRootLoader == null)
            {
                if (this.vars.__isRoot == true)
                {
                    return;
                }
                var _loc_3:* = new LoaderMax({name:"root", __isRoot:true});
                this._rootLoader = new LoaderMax({name:"root", __isRoot:true});
                _globalRootLoader = _loc_3;
                if (new LocalConnection().domain != "localhost")
                {
                }
                _isLocal = Boolean(Capabilities.playerType == "Desktop");
            }
            if (this._rootLoader)
            {
                this._rootLoader.append(this);
            }
            else
            {
                var _loc_3:* = new LoaderMax();
                this._rootLoader = new LoaderMax();
                _rootLookup[this.vars.requireWithRoot] = _loc_3;
                this._rootLoader.name = "subloaded_swf_" + this.vars.requireWithRoot.loaderInfo.url;
                this._rootLoader.append(this);
            }
            for (_loc_2 in _listenerTypes)
            {
                
                if (_loc_2 in this.vars)
                {
                }
                if (this.vars[_loc_2] is Function)
                {
                    this.addEventListener(_listenerTypes[_loc_2], this.vars[_loc_2], false, 0, true);
                }
            }
            return;
        }// end function

        public function load(param1:Boolean = false) : void
        {
            var _loc_2:* = getTimer();
            if (this.status == LoaderStatus.PAUSED)
            {
                this._status = this._prePauseStatus <= LoaderStatus.LOADING ? (LoaderStatus.READY) : (this._prePauseStatus);
                if (this._status == LoaderStatus.READY)
                {
                }
                if (this is LoaderMax)
                {
                    _loc_2 = _loc_2 - this._time;
                }
            }
            if (!param1)
            {
            }
            if (this._status == LoaderStatus.FAILED)
            {
                this._dump(1, LoaderStatus.READY);
            }
            if (this._status == LoaderStatus.READY)
            {
                this._status = LoaderStatus.LOADING;
                this._time = _loc_2;
                this._load();
                if (this.progress < 1)
                {
                    dispatchEvent(new LoaderEvent(LoaderEvent.OPEN, this));
                }
            }
            else if (this._status == LoaderStatus.COMPLETED)
            {
                this._completeHandler(null);
            }
            return;
        }// end function

        protected function _load() : void
        {
            return;
        }// end function

        public function pause() : void
        {
            this.paused = true;
            return;
        }// end function

        public function resume() : void
        {
            this.paused = false;
            this.load(false);
            return;
        }// end function

        public function cancel() : void
        {
            if (this._status == LoaderStatus.LOADING)
            {
                this._dump(0, LoaderStatus.READY);
            }
            return;
        }// end function

        protected function _dump(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
        {
            var _loc_5:* = null;
            this._content = null;
            var _loc_4:* = Boolean(this._status == LoaderStatus.LOADING);
            if (this._status == LoaderStatus.PAUSED)
            {
            }
            if (param2 != LoaderStatus.PAUSED)
            {
            }
            if (param2 != LoaderStatus.FAILED)
            {
                this._prePauseStatus = param2;
            }
            else if (this._status != LoaderStatus.DISPOSED)
            {
                this._status = param2;
            }
            if (_loc_4)
            {
                this._time = getTimer() - this._time;
            }
            if (this._dispatchProgress)
            {
            }
            if (!param3)
            {
            }
            if (this._status != LoaderStatus.DISPOSED)
            {
                if (this is LoaderMax)
                {
                    this._calculateProgress();
                }
                else
                {
                    this._cachedBytesLoaded = 0;
                }
                dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS, this));
            }
            if (_loc_4)
            {
            }
            if (!param3)
            {
                dispatchEvent(new LoaderEvent(LoaderEvent.CANCEL, this));
            }
            if (param2 == LoaderStatus.DISPOSED)
            {
                if (!param3)
                {
                    dispatchEvent(new Event("dispose"));
                }
                for (_loc_5 in _listenerTypes)
                {
                    
                    if (_loc_5 in this.vars)
                    {
                    }
                    if (this.vars[_loc_5] is Function)
                    {
                        this.removeEventListener(_listenerTypes[_loc_5], this.vars[_loc_5]);
                    }
                }
            }
            return;
        }// end function

        public function unload() : void
        {
            this._dump(1, LoaderStatus.READY);
            return;
        }// end function

        public function dispose(param1:Boolean = false) : void
        {
            this._dump(param1 ? (3) : (2), LoaderStatus.DISPOSED);
            return;
        }// end function

        public function prioritize(param1:Boolean = true) : void
        {
            dispatchEvent(new Event("prioritize"));
            if (param1)
            {
            }
            if (this._status != LoaderStatus.COMPLETED)
            {
            }
            if (this._status != LoaderStatus.LOADING)
            {
                this.load(false);
            }
            return;
        }// end function

        override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            if (param1 == LoaderEvent.PROGRESS)
            {
                this._dispatchProgress = true;
            }
            else
            {
                if (param1 == LoaderEvent.CHILD_PROGRESS)
                {
                }
                if (this is LoaderMax)
                {
                    this._dispatchChildProgress = true;
                }
            }
            super.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        protected function _calculateProgress() : void
        {
            return;
        }// end function

        public function auditSize() : void
        {
            return;
        }// end function

        override public function toString() : String
        {
            return this._type + " \'" + this.name + "\'" + (this is LoaderItem ? (" (" + (this as LoaderItem).url + ")") : (""));
        }// end function

        protected function _progressHandler(event:Event) : void
        {
            if (event is ProgressEvent)
            {
                this._cachedBytesLoaded = (event as ProgressEvent).bytesLoaded;
                this._cachedBytesTotal = (event as ProgressEvent).bytesTotal;
                if (!this._auditedSize)
                {
                    this._auditedSize = true;
                    dispatchEvent(new Event("auditedSize"));
                }
            }
            if (this._dispatchProgress)
            {
            }
            if (this._status == LoaderStatus.LOADING)
            {
            }
            if (this._cachedBytesLoaded != this._cachedBytesTotal)
            {
                dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS, this));
            }
            return;
        }// end function

        protected function _completeHandler(event:Event = null) : void
        {
            this._cachedBytesLoaded = this._cachedBytesTotal;
            if (this._status != LoaderStatus.COMPLETED)
            {
                dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS, this));
                this._status = LoaderStatus.COMPLETED;
                this._time = getTimer() - this._time;
            }
            dispatchEvent(new LoaderEvent(LoaderEvent.COMPLETE, this));
            if (this.autoDispose)
            {
                this.dispose();
            }
            return;
        }// end function

        protected function _errorHandler(event:Event) : void
        {
            if (event is LoaderEvent)
            {
            }
            var _loc_2:* = this.hasOwnProperty("getChildren") ? (event.target) : (this);
            var _loc_3:* = (event as Object).text;
            trace("Loading error on " + this.toString() + ": " + _loc_3);
            if (event.type != LoaderEvent.ERROR)
            {
            }
            if (this.hasEventListener(event.type))
            {
                dispatchEvent(new LoaderEvent(event.type, _loc_2, _loc_3));
            }
            if (this.hasEventListener(LoaderEvent.ERROR))
            {
                dispatchEvent(new LoaderEvent(LoaderEvent.ERROR, _loc_2, this.toString() + " > " + _loc_3));
            }
            return;
        }// end function

        protected function _failHandler(event:Event) : void
        {
            this._dump(0, LoaderStatus.FAILED);
            this._errorHandler(event);
            if (event is LoaderEvent)
            {
            }
            dispatchEvent(new LoaderEvent(LoaderEvent.FAIL, this.hasOwnProperty("getChildren") ? (event.target) : (this), this.toString() + " > " + (event as Object).text));
            return;
        }// end function

        protected function _passThroughEvent(event:Event) : void
        {
            var _loc_2:* = event.type;
            var _loc_3:* = this;
            if (this.hasOwnProperty("getChildren"))
            {
                if (event is LoaderEvent)
                {
                    _loc_3 = event.target;
                }
                if (_loc_2 == "complete")
                {
                    _loc_2 = "childComplete";
                }
                else if (_loc_2 == "open")
                {
                    _loc_2 = "childOpen";
                }
                else if (_loc_2 == "cancel")
                {
                    _loc_2 = "childCancel";
                }
                else if (_loc_2 == "fail")
                {
                    _loc_2 = "childFail";
                }
            }
            if (this.hasEventListener(_loc_2))
            {
                dispatchEvent(new LoaderEvent(_loc_2, _loc_3, event.hasOwnProperty("text") ? ((event as Object).text) : ("")));
            }
            return;
        }// end function

        public function get paused() : Boolean
        {
            return Boolean(this._status == LoaderStatus.PAUSED);
        }// end function

        public function set paused(param1:Boolean) : void
        {
            if (param1)
            {
            }
            if (this._status != LoaderStatus.PAUSED)
            {
                this._prePauseStatus = this._status;
                if (this._status == LoaderStatus.LOADING)
                {
                    this._dump(0, LoaderStatus.PAUSED);
                }
            }
            else
            {
                if (!param1)
                {
                }
                if (this._status == LoaderStatus.PAUSED)
                {
                    if (this._prePauseStatus == LoaderStatus.LOADING)
                    {
                        this.load(false);
                    }
                    else
                    {
                        this._status = this._prePauseStatus || LoaderStatus.READY;
                    }
                }
            }
            return;
        }// end function

        public function get status() : int
        {
            return this._status;
        }// end function

        public function get bytesLoaded() : uint
        {
            if (this._cacheIsDirty)
            {
                this._calculateProgress();
            }
            return this._cachedBytesLoaded;
        }// end function

        public function get bytesTotal() : uint
        {
            if (this._cacheIsDirty)
            {
                this._calculateProgress();
            }
            return this._cachedBytesTotal;
        }// end function

        public function get progress() : Number
        {
            return this.bytesTotal != 0 ? (this._cachedBytesLoaded / this._cachedBytesTotal) : (this._status == LoaderStatus.COMPLETED ? (1) : (0));
        }// end function

        public function get rootLoader() : LoaderMax
        {
            return this._rootLoader;
        }// end function

        public function get content()
        {
            return this._content;
        }// end function

        public function get auditedSize() : Boolean
        {
            return this._auditedSize;
        }// end function

        public function get loadTime() : Number
        {
            if (this._status == LoaderStatus.READY)
            {
                return 0;
            }
            if (this._status == LoaderStatus.LOADING)
            {
                return (getTimer() - this._time) / 1000;
            }
            return this._time / 1000;
        }// end function

        static function _activateClass(param1:String, param2:Class, param3:String) : Boolean
        {
            _types[param1.toLowerCase()] = param2;
            var _loc_4:* = param3.split(",");
            var _loc_5:* = _loc_4.length;
            while (--_loc_5 > -1)
            {
                
                _extensions[_loc_4[_loc_5]] = param2;
            }
            return true;
        }// end function

    }
}
