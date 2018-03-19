<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Index2</title>
<script src="js/jquery1.9.js"></script>
<script src="js/echarts.min.js"></script>
<link rel="stylesheet" type="text/css" href="/js/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="/js/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="/js/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="/js/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="/js/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	function DateDiff(sDate1, sDate2) {
		var arrDate, objDate1, objDate2, intDays;
		arrDate = sDate1.split("-");
		objDate1 = new Date(arrDate[1] + '-' + arrDate[2] + '-' + arrDate[0]);
		arrDate = sDate2.split("-");
		objDate2 = new Date(arrDate[1] + '-' + arrDate[2] + '-' + arrDate[0]);
		intDays = parseInt(Math.abs(objDate1 - objDate2) / 1000 / 60 / 60 / 24);
		return intDays;
	}

	function fun() {
		var a0 = "Tue Jan 02 00:00:00 CST 2018";
		var a1 = document.getElementById("start").value;
		var a2 = document.getElementById("end").value;

		var DayNum1 = DateDiff(a0, a1);
		var DayNum2 = DateDiff(a0, a2);

		var a = DayNum1 - DayNum2;
		if (a > 0) {
			alert("开始的时间要比结束的时间早!");

		}

	}
</script>
<style type="text/css">
#left {
	margin-left: 200px;
	margin-right: 200px;
	margin-top: 150px;
}

#cen {
	margin-bottom: 50px;
}
}
</style>
</head>
<body>


				开始日期：&nbsp;<input class="easyui-datebox" name="startprodate" id="startprodate" editable="false" size="10"/>
		


</body>
</html>