<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>jump</title>

<script language=javascript>
	function out(obj) {
		var i = obj;
		if (i == 0)
			document.location.href = "${pageContext.request.contextPath}/a";
		document.body.innerHTML = i;
		i--;
		setTimeout("out(" + i + ")", 0);
	}
</script>

</head>
<body onload="out(0)">
</body>
</html>