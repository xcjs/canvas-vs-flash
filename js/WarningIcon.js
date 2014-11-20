/**
*  HTML5 Canvas Example
*
*  @author William Malone (www.williammalone.com)
*/
var context;
var canvasWidth = 267;
var canvasHeight = 200;

window.onload = function()
{	
	//context = document.getElementById('canvasDiv').getContext("2d"); // Can't do this with IE
	
	// To account for IE all this must be done
	var foo = document.getElementById("canvasDiv");
	var canvas = document.createElement('canvas');
	canvas.setAttribute("width", canvasWidth);
	canvas.setAttribute("height", canvasHeight);
	canvas.setAttribute("id", "canvas");
	foo.appendChild(canvas);
	context = canvas.getContext("2d");
	
	var warningIconObj = new WarningIcon();
	warningIconObj.width = 125;
	warningIconObj.height = 105;
	warningIconObj.padding = 20;
	warningIconObj.lineWidth = 8;
	warningIconObj.innerBorder = 5;
	warningIconObj.primaryColor = "#ffc821";
	warningIconObj.secondaryColor = "#faf100";
	warningIconObj.tertiaryColor = "#dcaa09";
	warningIconObj.draw();
};

function draw()
{
	// A little math to make life easier 
	var phi = Math.tan((this.width/2) / this.height);
	var x = this.innerBorder / Math.cos(phi);
	var y = x / Math.tan(phi);
	var gamma = Math.sqrt(Math.abs(this.innerBorder*this.innerBorder - x*x));
	var centerX = canvasWidth/2;
	
	// Create the triangular path (with rounded corners)
	context.beginPath();
	// Top Corner
	context.moveTo(centerX - x, this.padding);	
	context.quadraticCurveTo(centerX, this.padding - y, centerX + x, this.padding);
	// Right Corner
	context.lineTo((canvasWidth + this.width)/2 + gamma, this.padding + this.height - gamma);	
	context.quadraticCurveTo((canvasWidth + this.width)/2 + y, this.padding + this.height + this.innerBorder, (canvasWidth + this.width)/2, this.padding + this.height + this.innerBorder);	
	// Left Corner
	context.lineTo((canvasWidth - this.width)/2, this.padding + this.height + this.innerBorder);
	context.quadraticCurveTo((canvasWidth - this.width)/2 - y, this.padding + this.height + this.innerBorder, (canvasWidth - this.width)/2 - gamma, this.padding + this.height - gamma);
	// Close Path
	context.lineTo(centerX - x, this.padding);
	context.closePath();
	
	// Add a subtle shadow
	context.shadowOffsetX = 0;
	context.shadowOffsetY = 0;
	context.shadowBlur = 10;
	context.shadowColor = "black";
	
	// Background Gradient Fill
	var backFill = context.createLinearGradient(0, this.padding, 0, this.padding + this.height);
	backFill.addColorStop(0.55, this.primaryColor);
	backFill.addColorStop(0.55, this.tertiaryColor);
	backFill.addColorStop(1, this.secondaryColor, "transparent");
	context.fillStyle = backFill;
	context.fill();

	// Turn off the shadow otherwise all other paths filled will have shadows
	context.shadowBlur = 0;

	// Create the inner border path
	context.beginPath();
	context.moveTo(centerX, this.padding + this.lineWidth);
	context.lineTo((canvasWidth + this.width)/2 - this.lineWidth, this.padding + this.height - this.lineWidth/2);
	context.lineTo((canvasWidth - this.width)/2 + this.lineWidth, this.padding + this.height - this.lineWidth/2);
	context.lineTo(centerX, this.padding + this.lineWidth);
	context.closePath();
	
	// Text and Stroke Fill 
  	bangFill = context.createLinearGradient(0, this.padding, 0, this.padding + this.height);
	bangFill.addColorStop(0, "#555");
	bangFill.addColorStop(1, "#333");
	
	// Stroke
	context.lineWidth = this.lineWidth;
  	context.lineJoin = "round";	
  	context.strokeStyle = bangFill;
	context.stroke();
	
	// Create the text (aka bang) path
	context.beginPath();	
	// Top
	context.moveTo(centerX - 8, this.padding + 45);			
	context.quadraticCurveTo(centerX, this.padding + 35,  centerX + 8, this.padding + 45);
	// Bottom
	context.lineTo(centerX + 3, this.padding + 66);
	context.quadraticCurveTo(centerX, this.padding + 78, centerX - 3, this.padding + 66);
	// Close path
	context.lineTo(centerX - 8, this.padding + 44);
    context.closePath();

	// Draw dot
	context.arc(centerX, this.padding + 85, 5, 0, Math.PI*2, true);
	
	// Draw the bang
	context.fillStyle = bangFill;
	context.fill();	
}

function WarningIcon(width, height, padding, lineWidth, innerBorder, primaryColor, secondaryColor, tertiaryColor)
{
	this.width = width;
	this.height = height;
	this.padding = padding;
	this.lineWidth = lineWidth;
	this.innerBorder = innerBorder;
	this.primaryColor = primaryColor;
	this.secondaryColor = secondaryColor;
	this.tertiaryColor = tertiaryColor;
	
	this.draw = draw;
}

/**/