<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">
<title>Renew Password</title>
<link rel="stylesheet" href="<c:url value='/resources/css/common.css' />" />
</head>
<body>
	<div class="header">
		<div class="head">
			<div class="logo">
				<img src="<c:url value='/resources/images/logo.png' />" />
			</div>	
			<div class="info">
				<a href="<c:url value='/j_spring_security_logout' />" > Logout </a>
				<security:authentication property="appUser.userName"/> <img src="<c:url value='/resources/images/user.png' />" />
			</div>
		</div>
	</div>
	<div class="login">
		<form method="post" id="renewPwd" >
			<label for="password">New Password</label>
			<input type="password" class="text" placeholder="Please Enter New Password" id="password" name="password"  />
			<label for="confirmPassword">Confirm New Password</label>
			<input type="password" class="text" placeholder="Please Confirm New Password"  id="confirmPassword" name="confirmPassword" />
			<button type="submit" class="btn">Save</button>
		</form>
	</div>
	<script type="text/javascript" src="<c:url value='/resources/js/jquery-1.11.1.js' />"></script>
	<script type="text/javascript" src="<c:url value='/resources/js/jquery.validate.js' />"></script>
	<script type="text/javascript">
	
		$(document).ready(function(){
	
			$("#renewPwd").validate({
				rules : {
					password : {
						required : true, 
						minlength: 5
					},
					confirmPassword : {
						required : true,
						equalTo: "#password", 
						minlength: 5
					}
				}
			});	
		});
	</script>
</body>
</html>