package lib
{
    //import br.com.passwordinfo.gp.modelo.AvaliacaoDesempenho;
    
    import flash.events.Event;

    public class CustomEvent extends Event
    {
        public static var SALVOU:String = 'salvou' ;     
        public static var SAIR:String = 'sair';
        public static var OK:String = 'OK';
                

        public function CustomEvent( type:String, bubbles:Boolean=false, cancelable:Boolean=false )
        {
            super( type, bubbles, cancelable );
        }
    }
}