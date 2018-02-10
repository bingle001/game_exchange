package cmodule.Box2D
{

    interface ICAllocator
    {

        function ICAllocator();

        function free(param1:int) : void;

        function alloc(param1:int) : int;

    }
}
