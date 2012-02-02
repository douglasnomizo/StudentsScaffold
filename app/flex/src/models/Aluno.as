package models
{
	import lib.Comum;

	[Bindable]
	[RemoteClass(alias="model.Aluno")]
	public class Aluno
	{
		public var id:String;
		public var nome:String;
		public var cpf:String;
		public var _data_nascimento:Date;

		public function Aluno()
		{
		}

		public function get data_nascimento():Date
		{
			return _data_nascimento;
		}

		public function set data_nascimento(value:Date):void
		{
			if (value != null) {
				_data_nascimento = Comum.arrumarData(value);
			} else {
				_data_nascimento = null;
			}
		}

	}
}

