package lib
{
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.containers.Panel;
	import mx.controls.Button;
	import mx.core.Application;
	import mx.core.EdgeMetrics;
	import mx.core.UIComponent;
	import mx.effects.Resize;
	import mx.events.DragEvent;
	import mx.events.EffectEvent;
	
	
	
	public class ResizableWindow extends Panel {
		
		[Bindable] public var showCloseButton:Boolean = false;
		[Bindable] public var showControls:Boolean = false;
		[Bindable] public var enableResize:Boolean = false;
		
		public var skinBorder:Object; 
		
		private var pTitleBar:UIComponent;
		private var oW:Number;
		private var oH:Number;
		private var oX:Number;
		private var oY:Number;
		private var closeButton:Button      = new Button();
		private var normalMaxButton:Button  = new Button();
		private var minButton:Button        = new Button();
		private var resizeHandler:Button    = new Button();
		private var upMotion:Resize         = new Resize();
		private var downMotion:Resize       = new Resize();
		private var resizeCur:Number        = 0;
		private var oPoint:Point             = new Point();
		private var glow:GlowFilter;
		
		public function ResizableWindow() {
			super();
		}
		
		
		
		override public function get viewMetrics():EdgeMetrics {
			return new EdgeMetrics(skinBorder[0], skinBorder[1], skinBorder[2], skinBorder[3]);       
		}
		
		
		override protected function createChildren():void {
			super.createChildren();
			this.pTitleBar = super.titleBar;
			this.doubleClickEnabled = true;
			
			if (enableResize) {
				this.resizeHandler.width     = 13;
				this.resizeHandler.height    = 13;
				this.resizeHandler.styleName = "resize";
				this.rawChildren.addChild(resizeHandler);
				this.initPos();
			}
			
			if (showControls) {
				this.normalMaxButton.width         = 15;
				this.normalMaxButton.height        = 15;
				this.normalMaxButton.styleName     = "maximizeButton";
				this.closeButton.width             = 15;
				this.closeButton.height            = 15;
				this.closeButton.styleName         = "closeButton";
				this.minButton.width     = 15;
				this.minButton.height    = 15;
				this.minButton.styleName = "minimizeButton";
				this.pTitleBar.addChild(this.minButton);               
				this.pTitleBar.addChild(this.normalMaxButton);
				this.pTitleBar.addChild(this.closeButton);
				normalMaxButton.addEventListener(MouseEvent.MOUSE_OVER, trateMouseOver);
				closeButton.addEventListener(MouseEvent.MOUSE_OVER, trateMouseOver);
				minButton.addEventListener(MouseEvent.MOUSE_OVER, trateMouseOver);
				normalMaxButton.addEventListener(MouseEvent.MOUSE_OUT, trateMouseOut);
				closeButton.addEventListener(MouseEvent.MOUSE_OUT, trateMouseOut);
				minButton.addEventListener(MouseEvent.MOUSE_OUT, trateMouseOut);
			}
			
			if (showCloseButton) {
				this.closeButton.width             = 16;
				this.closeButton.height            = 14;
				this.closeButton.styleName         = "closeButton";
				this.pTitleBar.addChild(this.closeButton);
			}
			
			this.positionChildren();    
			this.addListeners();
		}
		
		private function trateMouseOver(evt:MouseEvent):void
		{
			glow = new GlowFilter();
			glow.color=0xffffff;
			glow.blurX=glow.blurY=20;
			evt.currentTarget.filters=[glow];
		}
		
		private function trateMouseOut(evt:MouseEvent):void
		{
			evt.currentTarget.filters=[];
		}
		
		public function initPos():void {
			this.oW = this.width;
			this.oH = this.height;
			this.oX = this.x;
			this.oY = this.y;
		}
		
		public function positionChildren():void {
			if (showControls) {
				this.minButton.buttonMode    = true;
				this.minButton.useHandCursor = true;
				this.minButton.y             = 7;
				this.minButton.x             = this.unscaledWidth - this.minButton.width - 45;  
				this.normalMaxButton.buttonMode    = true;
				this.normalMaxButton.useHandCursor = true;
				this.normalMaxButton.x = this.unscaledWidth - this.normalMaxButton.width - 26;
				this.normalMaxButton.y = 7;
				this.closeButton.buttonMode       = true;
				this.closeButton.useHandCursor = true;
				this.closeButton.x = this.unscaledWidth - this.closeButton.width - 7;
				this.closeButton.y = 7;
			}
			
			if (showCloseButton) {
				this.closeButton.buttonMode       = true;
				this.closeButton.useHandCursor = true;
				this.closeButton.x = this.unscaledWidth - this.closeButton.width - 7;
				this.closeButton.y = 7;
			}
			
			if (enableResize) {
				this.resizeHandler.y = this.unscaledHeight - resizeHandler.height - 1;
				this.resizeHandler.x = this.unscaledWidth - resizeHandler.width - 1;
			}
		}
		
		public function addListeners():void {
			//this.addEventListener(MouseEvent.CLICK, panelClickHandler);
			this.pTitleBar.addEventListener(MouseEvent.MOUSE_DOWN, titleBarDownHandler);
			this.pTitleBar.addEventListener(MouseEvent.DOUBLE_CLICK, titleBarDoubleClickHandler);
			
			if (showControls) {
				this.minButton.addEventListener(MouseEvent.CLICK, titleBarDoubleClickHandler);
				this.closeButton.addEventListener(MouseEvent.CLICK, closeClickHandler);
				this.normalMaxButton.addEventListener(MouseEvent.CLICK, normalMaxClickHandler);
			}
			if (showCloseButton) {
				this.closeButton.addEventListener(MouseEvent.CLICK, closeClickHandler);
			}
			
			if (enableResize) {
				this.resizeHandler.addEventListener(MouseEvent.MOUSE_DOWN, resizeDownHandler);
			}
		}
		
		public function panelClickHandler(event:MouseEvent):void {
			this.pTitleBar.removeEventListener(MouseEvent.MOUSE_MOVE, titleBarMoveHandler);
			this.parent.setChildIndex(this, this.parent.numChildren - 1);
		}
		
		public function titleBarDownHandler(event:MouseEvent):void {
			this.pTitleBar.addEventListener(MouseEvent.MOUSE_MOVE, titleBarMoveHandler);
		}
		
		public function titleBarMoveHandler(event:MouseEvent):void {
			if (this.width < screen.width) {
				Application.application.parent.addEventListener(MouseEvent.MOUSE_UP, titleBarDragDropHandler);
				this.pTitleBar.addEventListener(DragEvent.DRAG_DROP,titleBarDragDropHandler);
				this.parent.setChildIndex(this, this.parent.numChildren - 1);
				this.startDrag(false, new Rectangle(0, 0, screen.width - this.width, screen.height - this.height));
			}
		}
		
		public function titleBarDragDropHandler(event:MouseEvent):void {
			this.pTitleBar.removeEventListener(MouseEvent.MOUSE_MOVE, titleBarMoveHandler);
			this.stopDrag();
		}
		
		
		public function titleBarDoubleClickHandler(event:MouseEvent):void {
			this.pTitleBar.removeEventListener(MouseEvent.MOUSE_MOVE, titleBarMoveHandler);
			Application.application.parent.removeEventListener(MouseEvent.MOUSE_UP, resizeUpHandler);
			
			this.verticalScrollPolicy = "off";
			this.horizontalScrollPolicy = "off";  
			
			this.upMotion.target = this;
			this.upMotion.duration = 300;
			this.upMotion.heightFrom = oH;
			this.upMotion.heightTo = 32;
			this.upMotion.end();
			
			this.downMotion.target = this;
			this.downMotion.duration = 300;
			this.downMotion.heightFrom = 32;
			this.downMotion.heightTo = oH;
			this.downMotion.end();
			
			if (this.width < screen.width) {
				if (this.height == oH) {
					this.upMotion.play();
					this.resizeHandler.visible = false;
				} else {
					this.downMotion.play();
					this.downMotion.addEventListener(EffectEvent.EFFECT_END, endEffectEventHandler);
				}
			}
		}
		
		public function endEffectEventHandler(event:EffectEvent):void {
			this.resizeHandler.visible = true;
		}
		
		public function normalMaxClickHandler(event:MouseEvent):void {
			if (this.normalMaxButton.styleName == "maximizeButton") {
				if (this.height > 28) {
					this.initPos();
					this.x = 0;
					this.y = 0;
					this.width = screen.width;
					this.height = screen.height;
					this.normalMaxButton.styleName = "restoreButton";
					this.positionChildren();
				}
			} else {
				this.x = this.oX;
				this.y = this.oY;
				this.width = this.oW;
				this.height = this.oH;
				this.normalMaxButton.styleName = "maximizeButton";
				this.positionChildren();
			}
		}
		
		public function closeClickHandler(event:MouseEvent):void {
			this.removeEventListener(MouseEvent.CLICK, panelClickHandler);
			this.parent.removeChild(this);
		}
		
		
		public function resizeDownHandler(event:MouseEvent):void {
			Application.application.parent.addEventListener(MouseEvent.MOUSE_MOVE, resizeMoveHandler);
			Application.application.parent.addEventListener(MouseEvent.MOUSE_UP, resizeUpHandler);
			this.panelClickHandler(event);
			this.oPoint.x = mouseX;
			this.oPoint.y = mouseY;
			this.oPoint = this.localToGlobal(oPoint);
		}
		
		public function resizeMoveHandler(event:MouseEvent):void {
			this.stopDragging();
			var xPlus:Number = Application.application.parent.mouseX - this.oPoint.x;            
			var yPlus:Number = Application.application.parent.mouseY - this.oPoint.y;
			
			if (this.oW + xPlus > 140) {
				this.width = this.oW + xPlus;
			}
			
			if (this.oH + yPlus > 80) {
				this.height = this.oH + yPlus;
			}
			this.positionChildren();
		}
		
		public function resizeUpHandler(event:MouseEvent):void {
			Application.application.parent.removeEventListener(MouseEvent.MOUSE_MOVE, resizeMoveHandler);
			Application.application.parent.removeEventListener(MouseEvent.MOUSE_UP, resizeUpHandler);
			this.initPos();
		}
		
		
	}
	
	
}

