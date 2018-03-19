<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>pie.html</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<script type="text/javascript">
		//相关对象的名字，颜色，比例。封装在全局数组中可以动态的改变
		var objectName = ${text};
		var color = ["#668800 ","#550088 ","#444444","#FF8800","#880000"]; 
		var data = ${number};
		//饼图的中心坐标(相对画布)，以及半径  ,设计时要考虑不能超出画布
		var x = 200;
		var y = 200;
		var r = 150;
		//鼠标点击后目标模块将要移动的圆心位置
		var moveX,moveY;
		//鼠标点击后目标模块提示百分比div的中心位置
		var middleX,middleY;
		//鼠标是否点击有效（用来控制当目标模块移动时，不允许其他操作）
		var ismouseForce = true;
		//是否需要从新画图
		var isDraw = true;		
		//点击饼图相关模块，弹出的距离，设为半径的1/10		
		var distance = r/10;
		//点击的模块号，与相关数组的下标一致
		var downNumber;	
		/**
		* 画饼图的基本方法
		*
		*/
		function drawCircle(px,py){
			var canvas = document.getElementById("circle");  
			var ctx = canvas.getContext("2d"); 
			//每次画图前先将原来的图清除
			ctx.clearRect(0,0,document.getElementById("circle").offsetWidth,
				document.getElementById("circle").offsetHeight);
			var ctx = canvas.getContext("2d"); 
			var startPoint = 0;
			for(i=0;i<data.length;i++){	    	
			    //路径开始
				ctx.beginPath(); 
				//边线宽度
				ctx.lineWidth = 1;
				//没有阴影效果
				ctx.strokeStyle = "#FFFFFF"; 			   		
				ctx.shadowOffsetX = 0;
				ctx.shadowOffsetY = 0;
				ctx.shadowBlur = 0;	
				//填充颜色
				ctx.fillStyle = color[i];     			   	
				if(i==downNumber){//如果是点击的模块，重新设定样式
				   	//边线样式
				   	ctx.shadowColor = "#888888";
				   	ctx.lineWidth = 2;
				   	//设置阴影效果
				   	ctx.strokeStyle = "#000000"; 
				   	ctx.shadowBlur = 5;
					ctx.shadowOffsetX = 5;
					ctx.shadowOffsetY = 5;
				   	ctx.moveTo(px,py); 
				   	ctx.arc(px,py,r,startPoint,startPoint+Math.PI*2*(data[i]/100),false); 
				 }else{//如果不是点击的模块用默认的样式画
				   	ctx.moveTo(x,y); 
				   	ctx.arc(x,y,r,startPoint,startPoint+Math.PI*2*(data[i]/100),false);  
				 }		   
				 ctx.closePath(); 	    			    
				 ctx.fill(); 
				 ctx.stroke();  			   	 			   	
				 startPoint+=Math.PI*2*(data[i]/100);  			   	
			 }		   	  	
		} 
		/**
		* 工具方法，获得模块点击后，中心偏移的相对(相对于画布)位置			
		* 和显示提示百分比div的中心位置.保存于全局变量中
		**/
		function getMovePoint(){
			//获得中心偏移的相对(相对于画布)位置
			var frontAngle = 0;
				for(var i=0;i<downNumber;i++){
				    frontAngle += Math.PI*2*(data[i]/100);
				}
			var angle = Math.PI*2*(data[downNumber]/100)/2+frontAngle;	
			moveX = x + Math.cos(angle)*distance;
			moveY = y + Math.sin(angle)*distance;
			//获得提示百分比div的中心位置(相对于画布)
			var showX = x + Math.cos(angle)*(1.5*r)+document.getElementById("circle").
				getBoundingClientRect().left;
			var showY = y + Math.sin(angle)*(1.5*r)+document.getElementById("circle").
				getBoundingClientRect().top;		
			if(showX>x&&showY>y){
				middleX = showX-document.getElementById("prompt").offsetWidth/2; 
				middleY = showY-document.getElementById("prompt").offsetHeight/2; 
			}else if(showX<x&&showY>y){					
				middleX = showX-document.getElementById("prompt").offsetWidth/2; 
				middleY = showY+document.getElementById("prompt").offsetHeight/2; 
			}else if(showX<x&&showY<y){
				middleX = showX-document.getElementById("prompt").offsetWidth/2; 
				middleY = showY+document.getElementById("prompt").offsetHeight/2; 
			}else{
				middleX = showX-document.getElementById("prompt").offsetWidth/2; 
				middleY = showY+document.getElementById("prompt").offsetHeight/2; 
			}
		}
		/**
		* 获取鼠标坐标(解决浏览器兼容性问题)
		*
		**/
		function mousePos(e){ 
		    var x,y; 
		    var e = e||window.event; 
		    return { 
		        x:e.clientX+document.body.scrollLeft+document.documentElement.scrollLeft, 
		        y:e.clientY+document.body.scrollTop+document.documentElement.scrollTop 
		    }; 
		}
		/**
		* 鼠标点击在饼图上，整个程序的核心控制器1
		*	
		**/
		function mouseDownpie(e){
			if(ismouseForce){
				var point = mousePos(e);
				var downX = point["x"] - document.getElementById("circle").getBoundingClientRect().left;
				var downY = point["y"] - document.getElementById("circle").getBoundingClientRect().top;
				getNumber(downX,downY);	
				//获取中心点移动后的坐标
				if(downNumber!=null){
					getMovePoint();
				}								
				if(isDraw){//如果需要重新画图
					//显示提示信息
					showPercent();
					//画饼图
					drawMovePie();
				}
			}
			
		}
		/**
		* 鼠标点击在按钮上，整个程序的核心控制器2
		*
		**/
		function mouseDownInput(e){
			if(ismouseForce){
				var e = e||window.event; 		
				var name = e.target.value;
				//获取点击模块的downNumber			
				for(var i=0;i<objectName.length;i++){
					if(objectName[i]== name){
						if(i==downNumber){
							downNumber = null;
							isDraw = true;	
						}else{
							downNumber = i;
							isDraw = true;	
						}
						break;	
					}							
				}
				//获取中心点移动后的坐标
				if(downNumber!=null){
					getMovePoint();
				}
				if(isDraw){//如果需要重新画图
					//显示提示信息
					showPercent();	
					//画饼图
					drawMovePie();
				}
			}
		}
		/**
		* 页面加载完显示饼图和操作按钮
		*
		**/
		window.onload=function(){
			showSheet();//操作按钮
			drawCircle();//饼图
		};
		/**
		* 定时器实现饼图移动的动态效果
		*
		**/
		function drawMovePie(){
			var n = 0;
			var nx = x;
			var ny = y;	
			var timer = setInterval( function(){
				//定时器开始时鼠标点击失效
				ismouseForce = false;		
				drawCircle(nx,ny);	
					nx = (moveX-x)/distance + nx;
					ny = (moveY-y)/distance + ny;
					n++;
				if(n == distance){
					clearInterval(timer);
					//定时器结束鼠标点击有效
					ismouseForce = true;
				}
			}, 30);
		}	
		/**
		* 获得鼠标点击的那个模块的模块号，保存在全局变量downNumber中
		*
		**/
		function getNumber(downX,downY){
			//鼠标点击的位置与中心点的距离
			var dist = Math.sqrt((x-downX)*(x-downX)+(y-downY)*(y-downY));
			var per;//点击点与中心点连线与起始线夹角所占饼图的百分比
			if(downX>x&&downY>y){
				per = (2*Math.atan((downY-y)/(downX-x))/Math.PI)/4;
			}
			else if(downX<x&&downY>y){					
				per = 1/4+(2*Math.atan((x-downX)/(downY-y))/Math.PI)/4;
			}
			else if(downX<x&&downY<y){
				per = 2/4+(2*Math.atan((downY-y)/(downX-x))/Math.PI)/4;
			}
			else{
				per = 3/4+(2*Math.atan((downX-x)/(y-downY))/Math.PI)/4;
			}
			//遍历求和求出每个模块的边线与起始线夹角所占饼图的百分比					
			var sum = 0;
			for(var i=0;i<data.length;i++){
				sum += data[i]/100;
				//当模块的比例大于点击点的比例时
				if(sum>per){
					//如果点击的是已经弹起的那个模块，判断距离为R加上弹起的移动距离
					if(i==downNumber&&(dist-distance)<r){
						//设置成没有模块弹起								
						downNumber= null;	
						isDraw = true;							
					}else if(dist<r){//如果点击不是弹起的那个模块，判断距离为半径R
						//该模块设置成弹起模块
						downNumber = i;	
						isDraw = true;								
					}else{
						//点击在模块外没有必要重新画图
						isDraw = false;
					}						
					break;
				}				
			}
		}
		/**
		* 定时器实现动态显示相关模块的提示信息。如January : 35%
		*
		**/
		function showPercent(){
			//获得提示信息内容
			var str = "";
			if(downNumber!=null){
				str = objectName[downNumber]+" : "+data[downNumber]+"%";
				document.getElementById("prompt").style.color = color[downNumber];
			}else{
				str = "";
			}
			//设定样式并显示内容	
			var elem = document.getElementById("prompt");
			elem.style.left = middleX+"px";
			elem.style.top = middleY+"px";
			//最开始透明级别为0
			setOpacity( elem, 0 );
			elem.innerHTML = str;
			//淡入效果实现		
			fadeIn(elem,100);
		}
		/**
		* 工具方法，实现淡入效果    
		* 参数说明  
		* elem==>需要淡入的元素     
		* speed==>淡入速度,正整数      
		**/     
		function fadeIn(elem,speed){       
		   	level = 0;
		    var fadeInTimer = setInterval(function(){
		    	 setOpacity( elem, level );
		    	 level = level+5;
		    	 if(level==100){
		    	 	clearInterval(fadeInTimer);
		    	 }
		    }, speed);  
		}
		/**
		* 工具方法，设置元素的透明度级别
		* level==>0-100的数字（级别）
		* 解决浏览器的兼容性问题
		**/
		function setOpacity( elem, level ) {		 	
		 	if ( elem.filters ){//如果滤镜存在是IE，于是设置Alpha滤镜
		   		elem.style.filter = 'alpha(opacity=' + level + ')';
		 	}else{//否则，使用W3C的opacity属性
		   		elem.style.opacity = level/100;
		 	}
		}
		/**
		* 动态生成饼图中各组分的按钮方法，其中颜色与按钮的颜色对应
		*
		**/
		function showSheet(){
			//给按钮定位
			document.getElementById("sheet").style.left = document.getElementById("circle").
				getBoundingClientRect().left-document.getElementById("sheet").offsetWidth+"px";
			document.getElementById("sheet").style.top = document.getElementById("circle").
				getBoundingClientRect().top+"px";
			//生成前先清空div
			document.getElementById("sheet").innerHTML = "";
			//动态的生成按钮
			var str = "";
			for(var i=0;i<objectName.length;i++){
				str += "<input onclick='mouseDownInput(event)' type='button' value='"+objectName[i]+
					"' style='background-color: "+color[i]+";'/>";			
			}	
			document.getElementById("sheet").innerHTML = str;		
		}		
		</script>
		<style type="text/css">
			body{
				margin:50px auto;
				text-align: center;
			}
			#sheet{
				position:absolute;
				width:150px; 
				height:400px;
			}
			#sheet>input{
				height: 30px;
				width: 80px;
				margin: 5px auto;
			}
			#prompt{
			
				margin-left:10px;
				width:100px;
				height: 20px;
			}
			#circle{
				
				top:8%;
				left:20%;
			}
		</style>  
  </head>
  <body >
  	<div id="prompt"></div>
    <canvas id="circle" width="400px" height="400px" onclick="mouseDownpie(event);">
    	您的浏览器暂不支持Canvas标签
    </canvas> 
    <div id="sheet"></div> 	
  </body>
</html>