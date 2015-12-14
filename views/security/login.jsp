<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">
<title>Login</title>
<link rel="stylesheet" href="<c:url value='/resources/css/common.css' />" />
</head>
<body>
	<div class="header">
		<div class="head">
			<div class="logo">
				<img src="<c:url value='/resources/images/logo.png' />" />
			</div>	
			<div class="info">
				Please Login <img src="<c:url value='/resources/images/user.png' />" />
			</div>
		</div>
	</div>
	<div class="login">
	
		<c:if test="${not empty noticeMessage}">
	  			<div class="message type${noticeMessage.type }">
	  				${noticeMessage.message }
	  			</div>
		</c:if>
		
		<form method="post" action="<c:url value='/j_spring_security_check' />" id="login" >
			<label for="id">Full Name</label>
			<input type="text" class="text" placeholder="Please Enter Username" id="id" name="j_username"  />
			<label for="password">Password</label>
			<input type="password" class="text" placeholder="Please Enter Password"  id="password" name="j_password" />
			<button type="submit" class="btn">Login</button>
		</form>
	</div>
	<script type="text/javascript" src="<c:url value='/resources/js/jquery-1.11.1.js' />"></script>
	<script type="text/javascript" src="<c:url value='/resources/js/jquery.validate.js' />"></script>
	<script type="text/javascript" src="<c:url value='/resources/js/login.js' />"></script>
</body>
</html>