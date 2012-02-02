package lib
{
	import flash.events.KeyboardEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	import mx.core.IFlexDisplayObject;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	import mx.rpc.events.FaultEvent;
	
	public class Comum
	{
		public static function contexto():String
		{
			return "";
		}
		
		public static function centralizarTela(componente:UIComponent):void
		{
			if (componente != null)
			{
				var diferencaLargura:Number=componente.screen.width - componente.width;
				var diferencaAltura:Number=componente.screen.height - componente.height;
				componente.x=componente.screen.x + (diferencaLargura / 2);
				componente.y=componente.screen.y + (diferencaAltura / 2);
			}
		}
		
		public static function arrumarData(data:Date):Date{
			var dataFinal:Date = new Date(data.fullYearUTC, data.getUTCMonth() as Number, data.getUTCDate() as Number);
			dataFinal.setHours(data.getUTCHours(),data.getUTCMinutes(),data.getUTCSeconds(),data.getUTCMilliseconds());
			return dataFinal; 
		}
		
		
		
		public static function clone(source:Object):*
		{
			var buffer:ByteArray=new ByteArray();
			buffer.writeObject(source);
			buffer.position=0;
			return buffer.readObject();
		}
		
		public static function moedaToNumber(valor:String):Number
		{
			return new Number(valor.replace(".", "").replace(".", "").replace(".", "").replace(".", "").replace(",", "."));
		}
		
		
		
		public static function calcularResolucao(componente:UIComponent):void
		{
			
			if (componente != null)
			{
				var largura:Number=componente.screen.width;
				var altura:Number=componente.screen.height;
				componente.width=largura;
				componente.height=altura;
			}
		}
		
		
		public static function montarJanela(componente:UIComponent):void
		{
			componente.setFocus();
		}
		
		public static function titleWindow_close(evt:CloseEvent):void
		{
			PopUpManager.removePopUp(evt.target as IFlexDisplayObject);
		}
		
		
		public static function titleWindow_keyDown(evt:KeyboardEvent, componente:UIComponent):void
		{
			if (evt.charCode == Keyboard.ESCAPE)
			{
				componente.dispatchEvent(new CloseEvent(CloseEvent.CLOSE));
			}
		}
		
		public static function url():String
		{
			return "http://localhost:3001/"
		}
		
		public static function showError(event:FaultEvent):void
		{
			var alert:Alert;
			[Embed(source="/assets/icons/alert-exclamation.png")]
			var alertExclamation:Class;
			[Embed(source="/assets/icons/alert-error.png")]
			var alertError:Class;
			if (event.fault.faultString == "login_invalido")
			{
				alert=Alert.show("Usuário não logado no sistema! \nFavor efetuar login.", "Atenção", Alert.OK, null, Comum.redireciona_login, alertExclamation);
			}
			else if (event.fault.faultString == "sessao_expirada")
			{
				alert=Alert.show("Sessão expirada! \nFavor efetuar login.", "Atenção", Alert.OK, null, Comum.redireciona_login, alertExclamation);
			}
			else if (event.fault.faultString == "sem_permissao")
			{
				alert=Alert.show("Permissão Negada! \nUsuário sem permissão para acessar este recurso.", "Atenção", Alert.OK, null, null, alertExclamation);
				//Comum.fechaProgressBarCarregando();
			}
			else
			{
				//Comum.fechaProgressBarCarregando();
				alert=Alert.show(event.fault.faultString, "Atenção", 4, null, null, alertExclamation);
			}
			alert.titleIcon=alertError;
			//Alert.index(event.fault.faultString, "InconsistÃªncias foram encontradas:");
		}
		
		public static function showErrorAlert(msg:String):void
		{
			var alert:Alert;
			[Embed(source="/assets/alert-exclamation.png")]
			var alertExclamation:Class;
			[Embed(source="/assets/alert-error.png")]
			var alertError:Class;
			alert=Alert.show(msg, "Atenção", 4, null, null, alertExclamation);
			alert.titleIcon=alertError;
			//Alert.index(event.fault.faultString, "InconsistÃªncias foram encontradas:");
		}
		
		public static function showConfirmAlert(msg:String):void
		{
			var alert:Alert;
			[Embed(source="/assets/alert-confirm.png")]
			var alertConfirm:Class;
			[Embed(source="/assets/alert-confirm-mini.png")]
			var alertConfirmMini:Class;
			alert=Alert.show(msg, "Atenção", 4, null, null, alertConfirm);
			alert.titleIcon=alertConfirmMini;
			//Alert.index(event.fault.faultString, "InconsistÃªncias foram encontradas:");
		}
		
		public static function redireciona_login(eventObj:Object):void
		{
			navigateToURL(new URLRequest("erro.html"), "_self")
		}
		
		public static function zeroPad(number:String, width:int):String
		{
			//var ret:String="" + number;
			while (number.length < width)
				number="0" + number;
			return number;
		}
		
		public static function montaCpf(cpf:String):String
		{
			var tamanho:String;
			var numero:Number;
			if (cpf != null)
			{
				cpf=zeroPad(cpf, 11);
				if (cpf.length == 11)
				{
					for (var m:Number=0; m < cpf.length; m++)
					{
						if (m == 3 || m == 7)
						{
							cpf=cpf.substr(0, m) + "." + cpf.substring(m)
						}
						if (m == 11)
						{
							cpf=cpf.substring(0, m) + "-" + cpf.substring(m);
						}
					}
				}
				else
				{
					//cpf="CPF Inválido";
				}
			}
			return cpf as String;
		}
		
		public static function mascaraDataKeyboard(event:KeyboardEvent):void
		{
			var str:String=event.target.text as String;
			var mask:String;
			if (event != null)
			{
				if (event.charCode != Keyboard.BACKSPACE && event.charCode != Keyboard.DELETE && event.charCode != Keyboard.LEFT && event.charCode != Keyboard.RIGHT)
				{
					if (str.length == 2)
					{
						mask=str.substr(0, 2) + "/" + str.substr(2)
						event.target.text=mask;
					}
					if (str.length == 5)
					{
						mask=str.substr(0, 5) + "/" + str.substr(5)
						event.target.text=mask;
					}
					
					if (str.length > 10)
					{
						mask=str.substr(0, 10)
						event.target.text=mask;
					}
				}
				
				event.target.setSelection(event.target.text.length, event.target.text.length);
			}
		}
		
		
		public static function dateValidateString(data:String):Boolean
		{
			if (data != null && data != "")
			{
				var partes:Array=data.split("/");
				var dia:int=parseInt(partes[0]);
				var mes:int=parseInt(partes[1]);
				var ano:int=parseInt(partes[2]);
				var valida:Boolean=true;
				var msg:String="";
				
				
				// vamos verificar se o mês é válido
				if ((mes < 1) || (mes > 12))
				{
					msg+="Mês inválido.\n";
					valida=false;
				}
					
					// vamos verificar se o ano é válido	
				else if ((ano < 1900) || (ano > 2030))
				{
					msg+="Ano inválido. Ano deve ser maior que 1900.\n";
					valida=false;
				}
					
					// vamos verificar se o dia é válido
				else if ((dia < 1) || (dia > diasMes(mes, ano)))
				{
					msg+="Dia inválido.\n";
					valida=false;
				}
				
				if (!valida)
				{
					Comum.showErrorAlert(msg);
					return false;
				}
				else
				{
					return true;
				}
			}
			else
				return true;
		}
		
		public static function diasMes(mes:int, ano:int):int
		{
			var dias_meses:Array=[31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
			
			var quant_dias:int=dias_meses[mes - 1];
			
			// verifica se o ano é bissexto
			if ((anoBissexto(ano)) && (mes == 2))
				quant_dias=29;
			
			return quant_dias;
		}
		
		// código da função anoBissexto
		public static function anoBissexto(ano:int):Boolean
		{
			return ((ano % 4 == 0) && ((!(ano % 100 == 0)) || (ano % 400 == 0)));
		}
		
		public static function montaCnpj(cnpj:String):String
		{
			var tamanho:String;
			var numero:Number;
			//numero=new String(cnpj);
			tamanho=new String(cnpj);
			if (tamanho.length == 14)
			{
				if (cnpj == "              ")
				{
					cnpj="Cnpj Inválido";
				}
				else
				{
					for (var m:Number=0; m < cnpj.length; m++)
					{
						if (m == 2 || m == 6)
						{
							cnpj=cnpj.substr(0, m) + "." + cnpj.substring(m)
						}
						if (m == 10)
						{
							cnpj=cnpj.substring(0, m) + "/" + cnpj.substring(m);
						}
						if (m == 15)
						{
							cnpj=cnpj.substring(0, m) + "-" + cnpj.substring(m);
						}
					}
				}
			}
			else
			{
				//cnpj="CNPJ Inválido";
			}
			return cnpj as String;
		}
		
		
	}
	
	
}

