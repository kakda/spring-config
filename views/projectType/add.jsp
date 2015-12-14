<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<div id="tabsPT">

	<div class="btn-bar">
		<a href="<c:url value='/projectType/index' />" class="btn">All Project Types</a>
	</div>
	<div class="form-container">
		<form method="post" id="projectTypeForm">
			<table class="form">
				<colgroup>
					<col style="width: 200px" />
					<col />
					<col style="width: 200px" />
					<col />
				</colgroup>
				<tr>
					<th><label for="title">Project Type</label></th>
					<td><input type="text" id="title" class="text" name="title" /></td>
					<th><label for="sortOrder">Order Number</label></th>
					<td><input type="text" id="sortOrder" class="text" name="sortOrder" /></td>
				</tr>
				<tr>
					<th><label for="remark">Remark</label></th>
					<td><textarea id="remark" class="area" name="remark"></textarea></td>
				</tr>
			</table>
			<div class="controls">
				<button type="submit" class="btn white">Save</button>
			</div>
		</form>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		
		
		$("#tabs").tabs({
			 active: 3,
			 activate : function(event, ui){
				 
				 Yuga.redirect(url[ui.newPanel.selector]);
			 }
		});

        $("#projectTypeForm").validate({
				rules: {
					title: {
						required: true,
						remote: "<c:url value='/projectType/checkDuplicate' />"
					},
					sortOrder: {
						required: true,
						min: 0,
						number: true
					}
				},
				messages: {
					title: {
						remote: "Project Type already exist."
					}
				}
		});
	});
</script>
