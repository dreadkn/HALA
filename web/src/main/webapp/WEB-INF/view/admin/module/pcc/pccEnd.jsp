<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<html>
	<body>
		<form id="write-form" method="post">
			<input type="text" name="userName" value="${user.userName }"/>
			<input type="text" name="userTel" value="${user.userTel }"/>
			<input type="text" name="result" value="Y"/>
		</form>
        
</body>
<script>
	$(function(){
		
		if ($('[name=result]').val() == 'Y') {
			$("#write-form").attr("action", "/account/join/write");
			/* $('#write-form').submit(); */ 
		} 
	});
</script>
</html>

