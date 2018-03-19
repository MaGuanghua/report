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

	<div align="center">
		<div align="left" id="left" style="float: left;">

			<form action="${pageContext.request.contextPath}/piechart"
				method="post" onsubmit="fun()">

				<strong>开始日期:</strong><br> <select style="width: 100px;"
					name="startprodate" id="start">
					<!-- <option selected>请选择</option> -->
					<c:forEach items="${prodate}" var="d">
						<option value="${d.prodate}" <c:if test="${sessionScope.startday_ != NULL && sessionScope.startday_ != '' && d.prodate==sessionScope.startday_}"> selected </c:if> >
							${d.prodate}
						</option>
					</c:forEach>
				</select><br> <br> <strong>结束日期:</strong><br> <select
					style="width: 100px;" name="endprodate" id="end">
					<!-- <option selected>请选择</option> -->
					<c:forEach items="${prodate}" var="d">
						<option value="${d.prodate}" <c:if test="${sessionScope.endday_ != NULL && sessionScope.endday_ != '' && d.prodate==sessionScope.endday_}"> selected </c:if> >
							${d.prodate}
						</option>
					</c:forEach>
				</select><br> <br> <strong>生产线:</strong><br> <select
					style="width: 100px;" name="proline">
					<!-- <option selected>请选择</option> -->
					<c:forEach items="${proline}" var="line">
						<option value="${line.proline}" <c:if test="${sessionScope.proline_ != NULL && sessionScope.proline_ != '' && line.proline==sessionScope.proline_}"> selected </c:if> >${line.proline}</option>
					</c:forEach>
				</select><br> <br> <strong>班次:</strong><br> <select
					style="width: 100px;" name="shift">
					<!-- <option selected>请选择</option> -->
					<c:forEach items="${proshift}" var="shift">
						<option value="${shift.shift}" <c:if test="${sessionScope.shift_ != NULL && sessionScope.shift_ != '' && shift.shift==sessionScope.shift_}"> selected </c:if> >${shift.shift}</option>
					</c:forEach>
				</select><br> <br> <input type="submit" id="hello" name="submit" value="提交">
			</form>
		</div>
		&nbsp;
		<div align="right" style="float: left;">
			<div align="left" id="cen">
				<table border="10">
					<tr align="center">停线率报表
					</tr>
					<tr>
						<td width="120px">&nbsp;<strong>事件名称</strong>&nbsp;
						</td>
						<td width="80px">&nbsp;<strong>生产线</strong>&nbsp;
						</td>
						<td width="80px">&nbsp;<strong>班次</strong>&nbsp;
						</td>
						<td width="120px">&nbsp;<strong>开始日期</strong>&nbsp;
						</td>
						<td width="120px">&nbsp;<strong>结束日期</strong>&nbsp;
						</td>
						<td width="80px" align="center">&nbsp;<strong>时间minute</strong>&nbsp;
						</td>
						<td width="80px">&nbsp;<strong>百分比%</strong>&nbsp;
						</td>
					</tr>
					<c:forEach items="${tableList}" var="info">
					<tr>
						<td>&nbsp;<strong>${info.equitmentstatus}</strong>&nbsp;</td>
						<td>&nbsp;<strong>${info.proline}</strong>&nbsp;</td>
						<td>&nbsp;<strong>${info.shift}</strong>&nbsp;</td>
						<td>&nbsp;<strong>${info.startprodate}</strong>&nbsp;</td>
						<td>&nbsp;<strong>${info.endprodate}</strong>&nbsp;</td>
						<td>&nbsp;<strong>${info.statustime}</strong>&nbsp;</td>
						<td>&nbsp;<strong>${info.percentage}</strong>&nbsp;</td>
					</tr>
					</c:forEach>
				</table>
			</div>
			<div align="center" id="right">
				<jsp:include page="pie.jsp"></jsp:include>
			</div>
		</div>

	</div>


</body>
</html>