<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="format"%>
<!DOCTYPE html>
<html lang="en">
<meta charset="utf-8">
<title>Error Page - ${exceptionMessage}</title>
<body>
	<section class="error-wrap">
		<div class="error-box">
			<img class="error-img" src="<c:url value='/resources/images/face_sad.png' />" />
			<h3>We are sorry...</h3>
			<p>You have request page: ${requestUri}</p>
			<p>Page Response: ${statusCode} - ${exceptionMessage}</p>
			<p><a href="<c:url value='/' />">Return to Home</a></p>
		</div>
	</section>
</body>
</html>