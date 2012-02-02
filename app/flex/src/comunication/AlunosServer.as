package comunication
{
	import lib.Comum;
	
	import models.Aluno;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;

	public class AlunosServer extends RemoteObject
	{
		private static var singleton:AlunosServer;

		public function AlunosServer()
		{
			super("rubyamf");

			super.showBusyCursor=true;

			super.endpoint = Comum.contexto() + "/rubyamf_gateway";

			super.source="Alunos";

			super.addEventListener(FaultEvent.FAULT, Comum.showError);

			// super.showBusyCursor= true

			if (singleton != null)
			{
				throw new Error("Singleton is a singleton class, use getInstance() instead");
			}
		}

		public static function getInstance():AlunosServer
		{
			if (singleton == null)
			{
				singleton=new AlunosServer();
			}

			return singleton;
		}


		/**
		 * Retorna todos objetos de fluxo existentes
		 * @param callback
		 */
		//public function find_all(aluno:Aluno, callback:Function):void
		public function find_all(callback:Function):void
		{
			if (!this.getOperation("find_all").hasEventListener(ResultEvent.RESULT))
			{
				this.getOperation("find_all").addEventListener(ResultEvent.RESULT, function cool(e:ResultEvent):ArrayCollection
					{
						getOperation("find_all").removeEventListener(ResultEvent.RESULT, cool);
						return callback(e.result);
					});
			}
			this.getOperation("find_all").send();
		}
		
		public function new_aluno(aluno:Aluno, callback:Function):void
		{ 
			if (!this.getOperation("new_aluno").hasEventListener(ResultEvent.RESULT))
			{
				this.getOperation("new_aluno").addEventListener(ResultEvent.RESULT, function cool(e:ResultEvent):ArrayCollection
				{
					getOperation("new_aluno").removeEventListener(ResultEvent.RESULT, cool);
					return callback(e.result);
				});
			}
			this.getOperation("new_aluno").send(aluno);
		}
		
		public function remover_aluno(aluno:Aluno, callback:Function):void
		{ 
			if (!this.getOperation("remover_aluno").hasEventListener(ResultEvent.RESULT))
			{
				this.getOperation("remover_aluno").addEventListener(ResultEvent.RESULT, function cool(e:ResultEvent):ArrayCollection
				{
					getOperation("remover_aluno").removeEventListener(ResultEvent.RESULT, cool);
					return callback();
				});
			}
			this.getOperation("remover_aluno").send(aluno);
		}
	}
}