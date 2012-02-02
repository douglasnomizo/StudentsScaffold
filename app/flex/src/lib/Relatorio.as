package lib
{
	import mx.core.UIComponent;
	

	public class Relatorio
	{
		import reports.ReportPreview;
		import reports.rListagem;
		import mx.containers.Box;
		import mx.managers.PopUpManager;

		public function Relatorio()
		{

			
		}
		
		public static function executaRelatorio(componente:UIComponent,obj:Object,titulo:String):void
			{
				var titleW:Box=Box(PopUpManager.createPopUp(componente, Box, true));
				// Objeto de Previsualização do Laudo
				var report:ReportPreview=new ReportPreview();
				// Nosso relatório
				var listagem:rListagem=new rListagem();

				var colunas:Array=obj.columns;
				colunas.pop();
				// Popup
				titleW.width=componente.screen.width;
				titleW.height=componente.screen.height;
				report.width=titleW.width;
				report.height=titleW.height;

				titleW.addChild(report);
				report.addChild(listagem);

				// Atibuindo as informações da Grid para a Grid 
				// do nosso Relatório
				listagem.grid.dataProvider=obj.dataProvider;
				listagem.grid.columns=colunas;
				listagem.header.title=titulo;

				report.execute(listagem);
			}

	}
}