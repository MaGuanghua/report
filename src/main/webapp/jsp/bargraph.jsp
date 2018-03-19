<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>bargraph</title>
<script src="js/jquery.js"></script>
</head>
<body>

	<div>

		<div id="main" style="width: 800px; height: 400px"></div>
		<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
		<script type="text/javascript">
		var axisx = ${list1}
		var axisy = ${list2}
			$.ajax({
				url : "https://api.douban.com/v2/book/search?q=都市",
				dataType : "jsonp",
				type : "get",
				success : function(book) {
					console.log(book)
					suc(book);
				},
				error : function() {
					console.log("连接数据库失败")
				}
			})
			function suc(book) {

				/* alert('abc');
				var list1 = '${list1}';
				alert(list1[0]); */

				// 路径配置
				require.config({
					paths : {
						echarts : 'http://echarts.baidu.com/build/dist'
					}
				});

				// 使用
				require([ 'echarts', 'echarts/chart/bar' // 使用柱状图就加载bar模块，按需加载
				], function(ec) {
					// 基于准备好的dom，初始化echarts图表
					var myChart = ec.init(document.getElementById('main'));

					var option = {
						//设置标题
						title : {
							text : 'ADCT',
							subtext : 'ADCT报表'
						},

						//设置提示
						tooltip : {
							show : true
						},
						//设置图例
						legend : {
							data : [ 'ADCT' ]
						},
						
							
						grid: {  
							left: '10%',  
							bottom:'35%'  
							},  	
						//设置坐标轴
						xAxis : [ {
							type : 'category',

							data :${list1},
							
							axisLabel: {  
								   interval:0,  
								   rotate:10  
								}  

						} ],
						yAxis : [ {
							type : 'value'
						} ],
						series : [ {
							"name" : "ADCT",
							"type" : "bar",
							 barWidth : 40,//柱图宽度
							data :${list2}
						} ]
					};

					// 为echarts对象加载数据
					myChart.setOption(option);
				});
			}
		</script>
	</div>
</body>
</html>