<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="format"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<div id="tabs">
	<ul>
		<li><a href="<c:url value='/data/organization' />">Organization</a></li>
		<li><a href="<c:url value='/data/employee' />">Employee</a></li>
		<li><a href="<c:url value='/data/employeeLevel' />">Unit Price</a></li>
		<li><a href="<c:url value='/data/projectType' />">Project Type</a></li>
		<li><a href="<c:url value='/data/holiday' />">Holiday</a></li>
		<li><a href="<c:url value='/data/opexCharge' />">Opex Charge</a></li>
		<li><a href="<c:url value='/data/profitTarget' />">Profit Target</a></li>
		<%-- <li><a href="<c:url value='/data/revenueTarget' />">Revenue Target</a></li> --%>
		<li><a href="<c:url value='/data/gpTarget' />">GP Target</a></li>
		<li><a href="<c:url value='/data/exchangeRate' />">Exchange Rate</a></li>
		<li><a href="<c:url value='/data/timecard' />">Timecard</a></li>
	</ul>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		$("#tabs").tabs({
			activate: function(event, ui){
				ui.oldPanel.empty();
			}
		});
	});
</script>