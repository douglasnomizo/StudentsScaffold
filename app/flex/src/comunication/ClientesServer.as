package comunication
{
	import lib.Comum;
	
	import models.Cliente;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;

	public class ClientesServer extends RemoteObject
	{
		private static var singleton:ClientesServer;

		public function ClientesServer()
		{
			super("rubyamf");

			super.showBusyCursor=true;

			super.endpoint = Comum.contexto() + "/rubyamf_gateway";

			super.source="Clientes";

			super.addEventListener(FaultEvent.FAULT, Comum.showError);

			// super.showBusyCursor= true

			if (singleton != null)
			{
				throw new Error("Singleton is a singleton class, use getInstance() instead");
			}
		}

		public static function getInstance():ClientesServer
		{
			if (singleton == null)
			{
				singleton = new ClientesServer();
			}

			return singleton;
		}


		/**
		 * Retorna todos objetos de fluxo existentes
		 * @param callback
		 */
		public function find_all(cliente:Cliente, callback:Function):void
		{
			if (!this.getOperation("find_all").hasEventListener(ResultEvent.RESULT))
			{
				this.getOperation("find_all").addEventListener(ResultEvent.RESULT, function cool(e:ResultEvent):ArrayCollection
					{
						getOperation("find_all").removeEventListener(ResultEvent.RESULT, cool);
						return callback(e.result);
					});
			}
			this.getOperation("find_all").send(cliente);
		}
		

	}
}