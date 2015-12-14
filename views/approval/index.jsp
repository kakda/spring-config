<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<div class="approval">
	<div class="form-container hide">
		<form method="post" id="messageForm">
			<table class="form">
				<colgroup>
					<col />
					<col  style="width: 400px" />
				</colgroup>
				<tr>
					<th colspan="2"><label for="message">Message</label></th>
				</tr>
				<tr>
					<td colspan="2"><textarea id="responseMessage" class="area" name="responseMessage" style="height:200px"></textarea></td>
				</tr>
				<tr class="hide">
					<th><label for="plannedWorkSize">Plan Work Size</label></th>
					<td><input type="text" id="plannedWorkSize" class="text float" name="plannedWorkSize" /></td>
				</tr>
			</table>
			<div class="controls">
				<button type="submit" class="btn white">Send</button>
			</div>
		</form>
	</div>
	<h3>Request Project Membership</h3>
	<div class="grid  grid-request">
		<table id="list1"></table>
		<div id="pager1"></div>
	</div>
	<h3>Timecard Unsubmit</h3>
	<div class="grid  grid-request">
		<table id="list2"></table>
		<div id="pager2"></div>
	</div>
	<h3>Overtime Approval</h3>
	<div class="grid">
		<table id="list3"></table>
		<div id="pager3"></div>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function(){
	//List of membership approval
	$(".float").autoNumeric({aPad: false, aSep: ""});
	var grid1 = $("#list1");
	var options1 = {
		url 		: "<c:url value='/approval/getRequestGrid.json'/>",
		colNames 	: ['Project','Requestor','Request Date',''],
		colModel 	: [
		   				{
		    	   			name	:'projectName', 
		    	   			index	:'projectName', 
		    	   			width	: 200,
		    	   			search  : false,
		    	   			align	: 'center',
		    	   			formatter : function (cellvalue, options, rowObject){
								return rowObject.projectList[0].projectName;
							}
		    	   		},
		    	   		{
		    	   			name	:'employeeName', 
		    	   			index	:'employeeName', 
		    	   			align	: 'center',
		    	   			width	: 200,
		    	   			search  : false,
		    	   			formatter : function (cellvalue, options, rowObject){
								return rowObject.empList[0].employeeName;
							}
					    },
					    {
				   			name	:'noticeTime', 
				   			index	:'noticeTime', 
				   			align	: 'center',
				   			search  : false,
				   			width	: 200,
				   			formatter : function (cellvalue, options, rowObject){
				   				return "Requested ("+rowObject.noticeTime+")";
								
							}
				   		},
						{
							name	: 'Action',
							index	: 'Action',
							width	: 200,
							align	: 'center',
							search  : false,
							formatter : function (cellvalue, options, rowObject){
								var btnApprove = "<button class='btn white btnApprove' senderID='"+rowObject.senderID
								+"' projectID='"+rowObject.projectList[0].projectID+"' rel='"+ rowObject.noticeID + "'>Approve</button>";
								var btnCancel = "<button class='btn white btnCancel' senderID='"+rowObject.senderID
								+"' projectID='"+rowObject.projectList[0].projectID+"'rel='"+ rowObject.noticeID + "'>Denied</button>";
								return btnApprove+"  "+btnCancel;
							}
						}
		],
		pager 		: '#pager1',
		loadComplete : function(){
			$(".btnApprove", grid1).on("click",function(e){	
				var noticeID = $(this).attr('rel').trim();	
				var projectID = $(this).attr('projectID').trim();	
				var senderID = $(this).attr('senderID').trim();				
				//Yuga.redirect("<c:url value='/approval/update'/>/" + noticeID+"/1/"+projectID+"/"+senderID);				
				$(".form-container").dialog( {
					title: "Approval Message", 
					width: 600,
		            modal: true,
		            resizable: true,
		            autoResize: true,
					open: function() {
						$(".form-container, .form-container tr:last").removeClass('hide');
						 $(".btn").bind("click",function(event){
								event.preventDefault();
								var responseMessage = $(".form-container").find("textarea").val();
								var plannedWorkSize = $("#plannedWorkSize").val();
								var json = {
										noticeID:noticeID,
										isApproved:1,
										noticeType: CONSTANT.MEMBERSHIP,
										projectList:[{projectID:projectID}],
										senderID:senderID,
										responseMessage:responseMessage,
										plannedWorkSize:plannedWorkSize
										};
							       $.ajax({
							            contentType : "application/json",
							            dataType : 'json',
							            type : "POST",
							            url : "<c:url value='/approval/doUpdate'/>",
							           data:JSON.stringify(json),
							           success : function(data) {
					 		               // alert("submitting.  \n\n" + JSON.stringify(data));
					 		                grid1.trigger("reloadGrid");
					 		           		$(".form-container").dialog('close');
							           },
							           error: function(data){
					 		            	//  alert(JSON.stringify(data));
					 		            	 grid1.trigger("reloadGrid");
					 		            	$(".form-container").dialog('close');
							           },
							           processData: false,
							           async: false
							        });
							});
					},
					 close: function(){ grid1.trigger("reloadGrid");}
				});
			});
			$(".btnCancel", grid1).on("click",function(e){	
				var noticeID = $(this).attr('rel').trim();	
				var projectID = $(this).attr('projectID').trim();	
				var senderID = $(this).attr('senderID').trim();				
				//Yuga.redirect("<c:url value='/approval/update'/>/" + noticeID+"/1/"+projectID+"/"+senderID);				
				$(".form-container").dialog( {
					title: "Denied Message",
					width: 600,
		            modal: true,
		            resizable: true,
		            autoResize: true,
					open: function() {
						$(".form-container").removeClass('hide');
						$(".form-container tr:last").addClass('hide');
						 $(".btn").bind("click",function(event){
								event.preventDefault();
								var responseMessage = $(".form-container").find("textarea").val();
								var json = {
										noticeID:noticeID,
										isApproved:0,
										noticeType:CONSTANT.MEMBERSHIP,
										projectList:[{projectID:projectID}],
										senderID:senderID,
										responseMessage:responseMessage
										};
							       $.ajax({
							            contentType : "application/json",
							            dataType : 'json',
							            type : "POST",
							            url : "<c:url value='/approval/doUpdate'/>",
							           data:JSON.stringify(json),
							           success : function(data) {
					 		               // alert("submitting.  \n\n" + JSON.stringify(data));
					 		               Yuga.redirect("<c:url value='/approval/index'/>");
					 		           		$(".form-container").dialog('close');
							           },
							           error: function(data){
					 		            	 // alert(JSON.stringify(data));
					 		            	 Yuga.redirect("<c:url value='/approval/index'/>");
					 		            		$(".form-container").dialog('close');
							           },
							           processData: false,
							           async: false
							        });
						});
					},
					 close: function(){
						 grid1.trigger("reloadGrid");
					 }
				});
			});
		},
		height: 110
	};
	grid1.jqGrid(options1);
	
	//List of Timecard Unsubmit approval
	var grid2 = $("#list2");
	var options2 = {
		url 		: "<c:url value='/approval/getUnsubmitGrid.json'/>",
		colNames 	: ['Project','Requestor','Period',''],
		colModel 	: [
		   				{
		    	   			name	:'projectName', 
		    	   			index	:'projectName', 
		    	   			width	: 200,
		    	   			search  : false,
		    	   			align	: 'center',
		    	   			formatter : function (cellvalue, options, rowObject){
								return rowObject.projectList[0].projectName;
							}
		    	   		},
		    	   		{
		    	   			name	:'employeeName', 
		    	   			index	:'employeeName', 
		    	   			align	: 'center',
		    	   			width	: 150,
		    	   			search  : false,
		    	   			formatter : function (cellvalue, options, rowObject){
								return rowObject.empList[0].employeeName;
							}
					    },
					    {
				   			name	:'period', 
				   			index	:'period', 
				   			align	: 'center',
				   			search  : false,
				   			width	: 150,
				   			formatter : function (cellvalue, options, rowObject){
				   				return rowObject.timeStartDate+" - "+rowObject.timeEndDate;
								
							}
				   		},
						{
							name	: 'Action',
							index	: 'Action',
							width	: 100,
							align	: 'center',
							search  : false,
							formatter : function (cellvalue, options, rowObject){
								var btnApprove = "<button class='btn white btnApprove' timecardProjectID='"+rowObject.timecardProjectID+"' senderID='"+rowObject.senderID
								+"' projectID='"+rowObject.projectList[0].projectID+"' rel='"+ rowObject.noticeID + "'>Approve</button>";
								var btnCancel = "<button class='btn white btnCancel' timecardProjectID='"+rowObject.timecardProjectID+"' senderID='"+rowObject.senderID
								+"' projectID='"+rowObject.projectList[0].projectID+"'rel='"+ rowObject.noticeID + "'>Denied</button>";
								return btnApprove+"  "+btnCancel;
							}
						}
		],
		pager 		: '#pager2',
		loadComplete : function(){
			$(".btnApprove", grid2).on("click",function(e){	
				var noticeID = $(this).attr('rel').trim();	
				var projectID = $(this).attr('projectID').trim();	
				var senderID = $(this).attr('senderID').trim();	
				var timecardProjectID = $(this).attr('timecardProjectID').trim();	
				//Yuga.redirect("<c:url value='/approval/update'/>/" + noticeID+"/1/"+projectID+"/"+senderID);				
				$(".form-container").dialog( {
					title: "Approval Message", 
					open: function() {
						$(".form-container").removeClass('hide');
						$(".form-container tr:last").addClass('hide');
						 $(".btn").bind("click",function(event){
								event.preventDefault();
								var responseMessage = $(".form-container").find("textarea").val();
								var json = {
										noticeID:noticeID,
										isApproved:1,
										noticeType:CONSTANT.UNSUBMIT,
										timecardProjectID:timecardProjectID,
										projectList:[{projectID:projectID}],
										senderID:senderID,
										responseMessage:responseMessage
										};
							       $.ajax({
							            contentType : "application/json",
							            dataType : 'json',
							            type : "POST",
							            url : "<c:url value='/approval/doUpdate'/>",
							           data:JSON.stringify(json),
							           success : function(data) {
					 		                //alert("submitting.  \n\n" + JSON.stringify(data));
					 		               // Yuga.redirect("<c:url value='/approval/index'/>");
					 		               grid2.trigger("reloadGrid");
					 		           	 $(".form-container").dialog('close');
							           },
							           error: function(data){
					 		            	  //alert(JSON.stringify(data));
					 		            	  //Yuga.redirect("<c:url value='/approval/index'/>");
					 		            	  grid2.trigger("reloadGrid");
					 		            	$(".form-container").dialog('close');
							           },
							           processData: false,
							           async: false
							        });
							});
					},
					 close: function(){ grid2.trigger("reloadGrid");}
				});
			});
			$(".btnCancel", grid2).on("click",function(e){	
				var noticeID = $(this).attr('rel').trim();	
				var projectID = $(this).attr('projectID').trim();	
				var senderID = $(this).attr('senderID').trim();				
				var timecardProjectID = $(this).attr('timecardProjectID').trim();		
				//Yuga.redirect("<c:url value='/approval/update'/>/" + noticeID+"/1/"+projectID+"/"+senderID);				
				$(".form-container").dialog( {
					title: "Denied Message", 
					width: 600,
		            modal: true,
		            resizable: true,
		            autoResize: true,
					open: function() {
						$(".form-container").removeClass('hide');
						$(".form-container tr:last").addClass('hide');
						 $(".btn").click(function(event){
								event.preventDefault();
								var responseMessage = $(".form-container").find("textarea").val();
								var json = {
										noticeID:noticeID,
										isApproved:0,
										noticeType:CONSTANT.UNSUBMIT,
										timecardProjectID:timecardProjectID,
										projectList:[{projectID:projectID}],
										senderID:senderID,
										responseMessage:responseMessage
										};
							       $.ajax({
							            contentType : "application/json",
							            dataType : 'json',
							            type : "POST",
							            url : "<c:url value='/approval/doUpdate'/>",
							           data:JSON.stringify(json),
							           success : function(data) {
					 		               // alert("submitting.  \n\n" + JSON.stringify(data));
					 		               //Yuga.redirect("<c:url value='/approval/index'/>");
					 		               grid2.trigger("reloadGrid");
					 		           	   $(".form-container").dialog('close');
							           },
							           error: function(data){
					 		            	  //alert(JSON.stringify(data));
					 		            	 // Yuga.redirect("<c:url value='/approval/index'/>");
					 		            	 grid2.trigger("reloadGrid");
					 		            	$(".form-container").dialog('close');
							           },
							           processData: false,
							           async: false
							        });
							});
					},
					 close: function(){ grid2.trigger("reloadGrid");	}
				});
			});
		},
		height: 110
	};
	grid2.jqGrid(options2);
	
	//List of Overtime approval
	var grid3 = $("#list3");
	var options3 = {
		url 		: "<c:url value='/approval/getOvertimeGrid.json'/>",
		colNames 	: ['Project','Requestor','Plan/Actual(MM)','Request(H)','Request Date',''],
		colModel 	: [
		   				{
		    	   			name	:'projectName', 
		    	   			index	:'projectName', 
		    	   			width	: 200,
		    	   			search  : false,
		    	   			align	: 'center',
		    	   			formatter : function (cellvalue, options, rowObject){
								return rowObject.projectList[0].projectName;
							}
		    	   		},
		    	   		{
		    	   			name	:'employeeName', 
		    	   			index	:'employeeName', 
		    	   			align	: 'center',
		    	   			width	: 200,
		    	   			search  : false,
		    	   			formatter : function (cellvalue, options, rowObject){
								return rowObject.empList[0].employeeName;
							}
					    },
				   		{
				   			name	:'plan', 
				   			index	:'plan', 
				   			align	: 'center',
				   			search  : false,
				   			width	: 100,
		    	   			formatter : function (cellvalue, options, rowObject){
		    	   				
								return (rowObject.timecardProject.projectMember.plannedWorkSize).toFixed(2)+"/"+(rowObject.timecardProject.totalPreviousMM).toFixed(2);
							}
				   		},
				   		{
				   			name	:'requestHH', 
				   			index	:'requestHH', 
				   			align	: 'center',
				   			search  : false,
				   			width	: 100,
		    	   			formatter : function (cellvalue, options, rowObject){
								return rowObject.timecardProject.totalHour;
							}
				   		},
				   		{
				   			name	:'noticeTime', 
				   			index	:'noticeTime', 
				   			align	: 'center',
				   			search  : false,
				   			width	: 200,
				   			formatter : function (cellvalue, options, rowObject){
				   				return "Requested ("+rowObject.noticeTime+")";
								
							}
				   		},
						{
							name	: 'Action',
							index	: 'Action',
							width	: 250,
							align	: 'center',
							search  : false,
							formatter : function (cellvalue, options, rowObject){
								var btnApprove = "<button class='btn white btnApprove' timecardProjectID='"+rowObject.timecardProjectID+"' senderID='"+rowObject.senderID
								+"' projectID='"+rowObject.projectList[0].projectID+"' rel='"+ rowObject.noticeID + "'>Approve</button>";
								var btnCancel = "<button class='btn white btnCancel' timecardProjectID='"+rowObject.timecardProjectID+"' senderID='"+rowObject.senderID
								+"' projectID='"+rowObject.projectList[0].projectID+"'rel='"+ rowObject.noticeID + "'>Denied</button>";
								return btnApprove+"  "+btnCancel;
							}
						}
		],
		pager 		: '#pager3',
		loadComplete : function(){
			$(".btnApprove", grid3).on("click",function(e){	
				var noticeID = $(this).attr('rel').trim();	
				var projectID = $(this).attr('projectID').trim();	
				var senderID = $(this).attr('senderID').trim();			
				var timecardProjectID = $(this).attr('timecardProjectID').trim();	
				//Yuga.redirect("<c:url value='/approval/update'/>/" + noticeID+"/1/"+projectID+"/"+senderID);				
				$(".form-container").dialog( {
					title: "Approval Message", 
					open: function() {
						$(".form-container").removeClass('hide');
						 $(".btn").bind("click",function(event){
								event.preventDefault();
								var responseMessage = $(".form-container").find("textarea").val();
								var json = {
										noticeID:noticeID,
										isApproved:1,
										noticeType:CONSTANT.OVERTIME,
										timecardProjectID:timecardProjectID,
										projectList:[{projectID:projectID}],
										senderID:senderID,
										responseMessage:responseMessage
										};
							       $.ajax({
							            contentType : "application/json",
							            dataType : 'json',
							            type : "POST",
							            url : "<c:url value='/approval/doUpdate'/>",
							           data:JSON.stringify(json),
							           success : function(data) {
					 		                //alert("submitting.  \n\n" + JSON.stringify(data));
					 		               // Yuga.redirect("<c:url value='/approval/index'/>");
					 		               grid3.trigger("reloadGrid");
					 		           		$(".form-container").dialog('close');
							           },
							           error: function(data){
					 		            	//  alert(JSON.stringify(data));
					 		            	//Yuga.redirect("<c:url value='/approval/index'/>");
					 		            	grid3.trigger("reloadGrid");
					 		            	$(".form-container").dialog('close');
							           },
							           processData: false,
							           async: false
							        });
							});
					},
					 close: function(){ Yuga.redirect("<c:url value='/approval/index'/>");	}
				});
			});
			$(".btnCancel", grid3).on("click",function(e){	
				var noticeID = $(this).attr('rel').trim();	
				var projectID = $(this).attr('projectID').trim();	
				var senderID = $(this).attr('senderID').trim();		
				var timecardProjectID = $(this).attr('timecardProjectID').trim();	
				//Yuga.redirect("<c:url value='/approval/update'/>/" + noticeID+"/1/"+projectID+"/"+senderID);				
				$(".form-container").dialog( {
					title: "Denied Message",
					width: 600,
		            modal: true,
		            resizable: true,
		            autoResize: true,
					open: function() {
						$(".form-container").removeClass('hide');
						$(".form-container tr:last").addClass('hide');
						 $(".btn").bind("click",function(event){
								event.preventDefault();
								var responseMessage = $(".form-container").find("textarea").val();
								var json = {
										noticeID:noticeID,
										isApproved:0,
										noticeType:CONSTANT.OVERTIME,
										timecardProjectID:timecardProjectID,
										projectList:[{projectID:projectID}],
										senderID:senderID,
										responseMessage:responseMessage
										};
							       $.ajax({
							            contentType : "application/json",
							            dataType : 'json',
							            type : "POST",
							            url : "<c:url value='/approval/doUpdate'/>",
							           data:JSON.stringify(json),
							           success : function(data) {
					 		                //alert("submitting.  \n\n" + JSON.stringify(data));
					 		                //Yuga.redirect("<c:url value='/approval/index'/>");
					 		                grid3.trigger("reloadGrid");
					 		           		$(".form-container").dialog('close');
							           },
							           error: function(data){
					 		            	//  alert(JSON.stringify(data));
					 		            	//Yuga.redirect("<c:url value='/approval/index'/>");
					 		            	grid3.trigger("reloadGrid");
					 		            	$(".form-container").dialog('close');
							           },
							           processData: false,
							           async: false
							        });
							});
					},
					 close: function(){ grid3.trigger("reloadGrid");	}
				});
			});
		},
		height: 110
	};
	grid3.jqGrid(options3);
});
</script>
