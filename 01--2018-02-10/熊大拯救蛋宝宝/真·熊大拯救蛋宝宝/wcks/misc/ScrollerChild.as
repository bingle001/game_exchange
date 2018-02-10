package wcks.misc
{

    public class ScrollerChild extends Entity
    {
        public var focusOn:Boolean = false;

        public function ScrollerChild()
        {
            return;
        }// end function

        override public function create() : void
        {
            var _loc_1:* = null;
            super.create();
            if (this.focusOn)
            {
                _loc_1 = Util.findAncestorOfClass(this, Scroller) as Scroller;
                if (_loc_1)
                {
                    _loc_1.focus = this;
                }
            }
            return;
        }// end function

    }
}
