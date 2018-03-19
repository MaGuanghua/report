<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Index</title>
<style type="text/css">
#left {
	margin-left: 200px;
	margin-top: 50px;
}
</style>
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

		var obj = document.getElementById("start");
		var txt = obj.options[obj.selectedIndex].text;

		if (txt == "请选择") {
			alert("请选择开始日期！");
		}

		var obj1 = document.getElementById("end");
		var txt1 = obj1.options[obj1.selectedIndex].text;

		if (txt1 == "请选择") {
			alert("请选择结束日期！");
		}

		var DayNum1 = DateDiff(a0, a1);
		var DayNum2 = DateDiff(a0, a2);

		var a = DayNum1 - DayNum2;
		if (a > 0) {
			alert("开始的时间要比结束的时间早!");

		}

	}
</script>
</head>
<body>

	<div align="center">
		<div align="left" id="left" style="float: left;">

			<form action="${pageContext.request.contextPath}/day" method="post"
				onsubmit="fun()">
				<strong>生产线:</strong><br> <select style="width: 100px;"
					name="proline">
					<option value="">请选择</option>
					<c:forEach items="${proline}" var="line">
						<option value="${line.proline}" <c:if test="${sessionScope.proline_ != NULL && sessionScope.proline_ != '' && line.proline==sessionScope.proline_}"> selected </c:if> >${line.proline}</option>
					</c:forEach>
				</select><br> <br> <strong>班次:</strong><br> <select
					style="width: 100px;" name="shift">
					<option selected>请选择</option>
					<c:forEach items="${proshift}" var="shift">
						<option value="${shift.shift}" <c:if test="${sessionScope.shift_ != NULL && sessionScope.shift_ != '' && shift.shift==sessionScope.shift_}"> selected </c:if>>${shift.shift}</option>
					</c:forEach>
				</select><br> <br> <strong>模具名称:</strong><br>
				
				 <select
					style="width: 100px;" name="mould">
					<option selected>请选择</option>
					<c:forEach items="${promould}" var="mould">
						<option value="${mould.mould}" <c:if test="${sessionScope.mould_ != NULL && sessionScope.mould_ != '' && mould.mould==sessionScope.mould_}"> selected </c:if>>${mould.mould}</option>
					</c:forEach>
				</select><br> <br> <strong>报表类型:</strong><br> <select
					style="width: 100px;" name="daytype">
					<option selected>请选择</option>
					<option value="日" <c:if test="${sessionScope.daytype_ != NULL && sessionScope.daytype_ != '' && '日'==sessionScope.daytype_}">selected</c:if>>日</option>
					<option value="月" <c:if test="${sessionScope.daytype_ != NULL && sessionScope.daytype_ != '' && '月'==sessionScope.daytype_}">selected</c:if>>月</option>
				</select><br> <br> <strong>开始日期:${s1}</strong><br> <select
					style="width: 100px;" name="startday" id="start">
					<option selected value="s1" id="s1">请选择</option>
					<c:forEach items="${prodate}" var="d">
						<option value="${d.prodate}" <c:if test="${sessionScope.startday_ != NULL && sessionScope.startday_ != '' && d.prodate==sessionScope.startday_}"> selected </c:if>>
							${d.prodate}
						</option>
					</c:forEach>
				</select><br> <br> <strong>结束日期:</strong><br> <select
					style="width: 100px;" name="endday" id="end">
					<option selected="selected" value="s2" id="s2">请选择</option>
					<c:forEach items="${prodate}" var="d">
						<option value="${d.prodate}" <c:if test="${sessionScope.endday_ != NULL && sessionScope.endday_ != '' && d.prodate==sessionScope.endday_}"> selected </c:if>>
							${d.prodate}
						</option>
					</c:forEach>
				</select><br> <br> <input type="submit" name="submit" value="提交">
			</form>
		</div>
		<div align="right" id="right" style="float: left; height: 800px" >
			<jsp:include page="bargraph.jsp" flush="true" />
		</div>
		
	</div>


</body>
</html>