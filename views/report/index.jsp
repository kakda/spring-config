<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="format"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<div id="tabs">
	<ul>
		<li><a href="<c:url value="/report/projectCost" />">Project Cost</a></li>
		<li><a href="<c:url value="/report/projectProfit" />">Project Profit</a></li>
		<li><a href="<c:url value="/report/teamProfit" />">Team Profit</a></li>
		<li><a href="<c:url value="/report/revenueTarget" />">Revenue</a></li>
		<li><a href="<c:url value="/report/gpTarget" />">Team GP</a></li>
		<li><a href="<c:url value="/report/timecard" />">Timecard</a></li>
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