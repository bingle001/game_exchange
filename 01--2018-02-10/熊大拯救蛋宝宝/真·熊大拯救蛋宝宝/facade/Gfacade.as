package facade
{
    import defs.*;
    import mediators.*;
    import mediators.roles.*;

    public class Gfacade extends Object
    {
        public var mainGame:StoneMan2;
        public var role:Role;
        public var role2:Role2;
        public var role3:Role3;
        public var gameMed:GameMed;
        public var roleNum:int;
        public var roleDieNum:int;
        private static var _instance:Gfacade;

        public function Gfacade()
        {
            return;
        }// end function

        public function judgeRole2() : Boolean
        {
            return this.roleNum >= 2;
        }// end function

        public function judgeRole3() : Boolean
        {
            return this.roleNum == 3;
        }// end function

        public function startGame(param1:StoneMan2) : void
        {
            this.mainGame = param1;
            Def.read();
            new CoverMed();
            return;
        }// end function

        public static function instance() : Gfacade
        {
            if (!_instance)
            {
                _instance = new Gfacade;
            }
            return _instance;
        }// end function

        public static function getInstance() : Gfacade
        {
            if (!_instance)
            {
                _instance = new Gfacade;
            }
            return _instance;
        }// end function

    }
}
