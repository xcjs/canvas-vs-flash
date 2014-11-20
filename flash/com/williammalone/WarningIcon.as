// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//                                     WarningIcon.as
//                                     ______________
//
//                   Created by William Malone (www.williammalone.com)                
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

package com.williammalone
{	
	import flash.display.Sprite;
	import flash.display.GradientType;
	import flash.filters.DropShadowFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.display.JointStyle;
	import flash.display.GraphicsPath;
	import flash.display.GraphicsPathCommand;
	import flash.display.GraphicsStroke;
	import flash.display.GraphicsGradientFill;
	import flash.display.IGraphicsData;
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsPathWinding;

	public class WarningIcon extends Sprite
	{
		//-------------------------------------------------------------------------------
		//                                                                         FIELDS
		//-------------------------------------------------------------------------------
		public var iconWidth:Number = 125;
		public var iconHeight:Number = 105;
		public var padding:Number;
		public var lineWidth:Number;
		public var innerBorder:Number;
		public var primaryColor:uint;
		public var secondaryColor:uint;
		public var tertiaryColor:uint;
		public var label:String;
		public var canvasWidth:Number = 267;
		public var canvasHeight:Number = 200;
		/**
		*	Warning Icon Constructor
		*/
		public function WarningIcon() 
		{

		}
		/**
		*	This will draw the object based on its current properties.
		*/
		public function draw():void
		{
			// A little math to make life easier 
			var phi:Number = Math.tan((iconWidth/2) / iconHeight);
			var x:Number = innerBorder / Math.cos(phi);
			var y:Number = x / Math.tan(phi);
			var gamma:Number = Math.sqrt(Math.abs(innerBorder*innerBorder - x*x));			
			var centerX:Number = canvasWidth/2;
			
			// Create the triangular path (with rounded corners)
			var trianglePath:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
			// Top Corner
			trianglePath.moveTo(centerX - x, padding);			
			trianglePath.curveTo(centerX, padding - y, // Control Point
							 centerX + x, padding);
			// Right Corner
			trianglePath.lineTo((canvasWidth + iconWidth)/2 + gamma, padding + iconHeight - gamma);			
			trianglePath.curveTo((canvasWidth + iconWidth)/2 + y, padding + iconHeight + innerBorder, // Control Point
							 (canvasWidth + iconWidth)/2, padding + iconHeight + innerBorder);
			// Left Corner
			trianglePath.lineTo((canvasWidth - iconWidth)/2, padding + iconHeight + innerBorder);			
			trianglePath.curveTo((canvasWidth - iconWidth)/2 - y, padding + iconHeight + innerBorder, // Control Point
							 (canvasWidth - iconWidth)/2 - gamma, padding + iconHeight - gamma);		
			// Close Path
			trianglePath.lineTo(centerX - x, padding);			
			
			// Add a subtle shadow
			filters = new Array(new DropShadowFilter(0, 0, 0x000000, 1, 10, 10));
			
			// Create the inner border path
			var strokePath:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
			strokePath.moveTo(centerX, padding + innerBorder);
			strokePath.lineTo((canvasWidth + iconWidth)/2 - innerBorder, padding + iconHeight - innerBorder/2);
			strokePath.lineTo((canvasWidth - iconWidth)/2 + innerBorder, padding + iconHeight - innerBorder/2);
			strokePath.lineTo(centerX, padding + innerBorder);

			// Create the text (aka bang) path
			var bangPath:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
			// Top
			bangPath.moveTo(centerX - 8, padding + 45);			
			bangPath.curveTo(centerX, padding + 35, // Control Point
							 centerX + 8, padding + 45);
			// Bottom
			bangPath.lineTo(centerX + 3, padding + 66);
			bangPath.curveTo(centerX, padding + 78, // Control Point
							 centerX - 3, padding + 66);
			// Close path
			bangPath.lineTo(centerX - 8, padding + 44);
			
			// Draw Dot
			var radius:Number = 5;
			var centerY:Number = padding + 84;
			bangPath.moveTo(centerX, centerY - radius);
			bangPath.curveTo(centerX + radius, centerY - radius, centerX + radius, centerY);
			bangPath.curveTo(centerX + radius, centerY + radius, centerX, centerY + radius);
			bangPath.curveTo(centerX - radius, centerY + radius, centerX - radius, centerY);
			bangPath.curveTo(centerX - radius, centerY - radius, centerX, centerY - radius);
			// NOTE: Or use: 
			//graphics.drawCircle(centerX - 2, padding + 85 - 2, 4);

			// Background Gradient Fill 
			var backFill:GraphicsGradientFill = new GraphicsGradientFill(); 
			backFill.colors = [secondaryColor, tertiaryColor, primaryColor]; 
			backFill.ratios = [iconHeight/2, iconHeight, iconHeight];
			backFill.matrix = new Matrix();
			backFill.matrix.createGradientBox(iconWidth, iconHeight, 3*Math.PI/2, 0,  padding); 

			// Text and Stroke Fill 
			var bangFill:GraphicsGradientFill = new GraphicsGradientFill(); 
			bangFill.colors = [0x555555, 0x333333];  
			bangFill.matrix = new Matrix(); 
			bangFill.matrix.createGradientBox(iconWidth, iconHeight, Math.PI/2, 0, padding);
			
			// Transparent Fill
			var transparentFill:GraphicsSolidFill = new GraphicsSolidFill(); 
			transparentFill.alpha = 0;
			
			// Stroke
			var stroke:GraphicsStroke = new GraphicsStroke(lineWidth); 
			stroke.joints = JointStyle.ROUND;
			stroke.fill = bangFill;
			
			// Drawing everything!
			var iconGraphics:Vector.<IGraphicsData> = new Vector.<IGraphicsData>(); 
			iconGraphics.push(backFill, trianglePath, bangFill, bangPath, transparentFill, stroke, strokePath); 
			graphics.drawGraphicsData(iconGraphics);
		}
		//-------------------------------------------------------------------------------
		//                                                                     PROPERTIES
		//-------------------------------------------------------------------------------
		/**/
	}
}