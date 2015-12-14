<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>

<div class="request">
	<h3>Project Type</h3>
	<div class="project-type">
		<ul id="projectTypeList">
			<c:forEach items="${projectTypeList}" var="projectType">
				<li><input type="checkbox" class="pType"
					id="${projectType.projectTypeID}"
					value="${projectType.projectTypeID}" /> <label
					for="${projectType.projectTypeID}">${projectType.title}</label></li>
			</c:forEach>
		</ul>
		<div class="check-all">
			<input type="checkbox" id="chk-all"><label for="chk-all">Select
				All</label>
		</div>
	</div>
	<h3>Request for Project Membership</h3>
	<div class="project-filter">
		<fieldset id="order-by">
			<input type="radio" name="order" id="projectTypeID" checked
				value="projectTypeID" /> <label for="projectTypeID">Order
				by Project Type</label> <input type="radio" name="order" id="projectName"
				value="projectName" /> <label for="projectName">Order by
				Project Name</label>
		</fieldset>
	</div>

	<div class="grid grid-request">
		<table id="list2"></table>
		<div id="pager2"></div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(
			function() {
						var grid = $("#list2");
						var options = {
							url : "<c:url value='/request/getProjectGrid.json'/>",
							colNames : [ 'Project', 'PM', '', 'Request Date' ],
							colModel : [
									{
										name : 'projectName',
										index : 'projectName',
										width : 200,
										search : false,
										align : 'center'
									},
									{
										name : 'pmName',
										index : 'pmName',
										align : 'center',
										width : 200,
										search : false,
										formatter : function(cellvalue,
												options, rowObject) {
											return rowObject.pmName[0].employeeName;
										}
									},
									{
										name : 'Action',
										index : 'Action',
										width : 100,
										align : 'center',
										search : false,
										formatter : function(cellvalue, options, rowObject) {
											var btn = "";
											if (rowObject.noteList.length > 0) {
												btn = "<button class='btn white btnCancel' projectName='"+rowObject.projectName + "' rel='" + rowObject.noteList[0].noticeID + "'>Cancel</button>";
											} else {
												btn = "<button class='btn white btnRequest' employeeID='"+rowObject.employeeID + "'rel='" + rowObject.projectID + "'>Request</button>";
											}

											return btn;
										}
									},
									{
										name : 'requestDate',
										index : 'requestDate',
										align : 'center',
										search : false,
										width : 200,
										formatter : function(cellvalue,
												options, rowObject) {
											if (rowObject.noteList.length > 0) {
												return "Requested (" + rowObject.noteList[0].noticeTime+ ")";
											} else {
												return "";
											}

										}
									} ],
							pager : '#pager2',
							loadComplete : function() {
								$(".btnRequest").on(
												"click",
												function(e) {
													var projectID = $(this).attr('rel');
													var receiverID = $(this).attr('employeeID');
													var url = "<c:url value='/request/add/" + projectID + "'/>";
													$.ajax({
														url 	: url,
														async	: false,
														success	: function(){															
															grid.trigger("reloadGrid");
														}
													});													
													$(this).removeClass('btnRequest').addClass('btnCancel');
													$(".btnCancel").text("Cancel");
													
												});

								$(".btnCancel").on(
												"click",
												function(e) {
													$(this).removeClass('btnCancel').addClass('btnRequest');
													$(".btnRequest").text("Request");
													var noticeID = $(this).attr('rel');
													var projectName = $(this).attr('projectName');
													var message = "Do you want to cancel request project [" + projectName + "] member?";
													
													Yuga.dialog.confirm(message,																	
															function() {
																var url = "<c:url value='/request/delete/"+ noticeID +"' />";
																$.ajax({
																	url : url,
																	async	: false,
																	success : function(result) {
																			grid.trigger("reloadGrid");
																	}
																});
															});													
													});
							},
							postData : {
								RequestPTypeID : function() {

									var projectTypeID = [];
									if ($("#chk-all").prop('checked')) {
										projectTypeID.push("all");
									} else {
										$('.project-type').find(':checkbox')
												.each(function() {
													if (this.checked) {
														projectTypeID.push($(this).val());																
													} 
													else {
														projectTypeID.push("");
													}
												});
									}												
									return projectTypeID;
								},
								RequestOrderBy : function() {
									var orderBy = "";
									if ($('input[name="order"]').is(":checked")) {
										orderBy = $('input[name="order"]:checked').val();
									}
									return orderBy;
								}
							}
						};

						grid.jqGrid(options);

						$('#chk-all').bind(
								'change',
								function() {
									if ($(this).is(':checked')) {
										$("#projectTypeList li").each(
												function() {
													$(this).find("input").prop('checked', 'checked');
												});
									} else {
										$("#projectTypeList li").each(
												function() {
													$(this).find("input")
															.removeAttr('checked','checked');
												});
									}
									grid.trigger("reloadGrid");
								});
						$('.pType')
								.bind(
									'change',
									function() {
										if ($(".pType").length == $(".pType:checked").length) {
											$("#chk-all").prop("checked","checked");
											} else {
												$("#chk-all").removeAttr("checked");
											}
											grid.trigger("reloadGrid");
									});
						$('input[name="order"]').bind('change', function() {
							grid.trigger("reloadGrid");
						});

					});
</script>
