<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<div class="request">
	<h3>Project Management <a id="btnNewProject" href="<c:url value='/project/add/G' />" class="btn">New Project</a></h3>
	<div class="project-type">
		<ul>
			<c:forEach var="PTJ" items="${projectType}">
				<li><input type="checkbox" name="projectType" id="${PTJ.projectTypeID}" value="${PTJ.projectTypeID}"/><label for="${PTJ.projectTypeID}">${PTJ.title}</label></li>
			</c:forEach>
		</ul>
		<div class="check-all">
			<input type="checkbox" id="chk-all"><label for="chk-all">Select All</label>
		</div>
	</div>
	
	
	<div class="project-filter">
		<fieldset>
			<legend>Order by</legend>
			<input type="radio" id="orType" name="order" value="projectTypeID"/> <label for="orType">by Project Type</label>
			<br/>
			<input type="radio" id="orName" name="order" value="projectName" checked="checked"/> <label for="orName">by Project Name</label>
		</fieldset>
		<fieldset id="status">
			<legend>Status</legend>
			<input type="checkbox" id="opened" checked="checked" value="O"/> <label for="opened">Opened</label>
			<input type="checkbox" id="closed" value="C"/> <label for="closed">Closed</label>
		</fieldset>
		<security:authorize access="hasRole('P')">
			<fieldset id="role">
				<legend>Role</legend>
				<input type="checkbox" id="pm" checked="checked" value="${rolePM}"/> <label for="pm">PM</label>
				<input type="checkbox" id="member" checked="checked" value="${roleMember}"/> <label for="member">Member</label>
			</fieldset>
		</security:authorize>
		<fieldset>
			<legend>Period</legend>
			<input type="radio" id="all" name="period"/> <label for="all">All</label>
			<input type="radio" id="thisYear" name="period" checked="checked"/> <label for="thisYear">This Year </label>
			<br/>
			<input type="radio" id="previousYear" name="period" /> <label for="year" id="year"></label>
		</fieldset>
	</div>
	<br/>
	<!-- PROJECT GRID -->
	<div class="grid grid-request">
		<table id="list"></table>
		<div id="paging"></div>
	</div>
	
</div>

<div id="dlgProjectDetail"></div>

<script type="text/javascript">
	$(document).ready(function(){
		var grid = $("#list");
		project.bindEvent(grid);
		project.init(grid);
		if( isAdmin == false ){
			$( "#btnNewProject" ).hide();
		}
		
		$('#dlgProjectDetail').dialog({
			modal: true,
			autoOpen: false,
			width: 1000
		});
	});
	
	
	var project ={
		//init GRID();
		init : function(grid){
			var options = {
					url 		: "<c:url value='/project/getGrid.json'/>",
					colNames 	: [ 'ProjectName', 'ROLE','PERIOD', 'STATUS', 'EDIT'],
					colModel 	: [
						{
							name	: 'projectName',
							index	: 'projectName',
							align	: 'left',
							search  :  true,
							stype	:  "text",
							width   :  120,
							formatter : function(cellvalue,options,rowObject){
								return "<a href='#' class='updateProject' rel='"+rowObject.projectID+"'>"+rowObject.projectName+"</a>";	
							}
						},
				   		{
				   			name	:'role', 
				   			index	:'role', 
				   			width	: 40,
				   			search  : false,
				   			align	: 'center'
				   			
				   		},
				   		{
				   			name	:'period', 
				   			index	:'period', 
				   			search  : false,
				   			width	: 80,
				   			align	: 'center',
				   			formatter  : function(cellvalue, options, rowObject){
				   				return new Date(rowObject.startDate).toString(Yuga.config.format.date) + " ~ " + new Date(rowObject.endDate).toString(Yuga.config.format.date);
				   			}
				   		},
				   		{
				   			name	:'Status', 
				   			index	:'Status', 
				   			width	: 40,
				   			search  : false,
				   			align	: 'center',
				   			formatter : function (cellvalue, options, rowObject){
				   				var id = rowObject.projectID;
				   				if( isAdmin ){
				   					if(rowObject.status === CONSTANT.PROJECT_STATUS_OPEN){
					   					return "<input type='checkbox' name='projectStatus' checked='checked' id='" +id+"' rel='"+id+"'/> <label for='" +id+"'>OPEN</label>";
					   				}else{
					   					return "<input type='checkbox' name='projectStatus' id='"+id+"' rel='"+id+"'/> <label for='" +id+"'>CLOSED</label>";
					   				}
				   				}else{
				   					if(rowObject.status === CONSTANT.PROJECT_STATUS_OPEN){
					   					return "<label>OPEN</label>";
					   				}else{
					   					return "<label>CLOSED</label>";
					   				}
				   				}
				   			
							}
				   		},
				   		
				   		{name:'action',width:40, align:"center",sortable: false,search  : false,
							   formatter:function ( cellvalue, options, rowObject ) {
								   
								   	var projectID = rowObject.projectID;
									
								   	var btEdit="<button type='button' class='btnEdit btn white' projectID='" + projectID + "'>Edit</button>";
									
								   	return btEdit;
									
							   },
							   hidden: !isAdmin
						}
					],
					pager 		: '#paging',
					loadComplete : function(){
						$.session.remove('projectID');
						$.session.clear();
						$(".btnEdit").click(function(){
			    			var projectID = $(this).attr("projectID");
			    			$.session.set("projectID", projectID);
			    			$.session.set("projectName", $(this).parents('tr').find('a[href]').text());			    			
			    			var url = '<c:url value="/project/update/"/>' + CONSTANT.PROJECT_STATUS_GENERAL_INFOR;
			    			location.href = url;
			    			
			    		});
	
						$("#gs_projectName").attr('placeholder', 'Search....');
						
						$(".updateProject").on("click", function(event){
							event.preventDefault();
							var id = $(this).attr("rel");
							var url = "<c:url value='/project' />/" + id + "/view/detail";
							
							
							$.ajax({
								url : url,
								success : function(response){
									console.log(response);
									$("#dlgProjectDetail").html(response)
														  .dialog({autoOpen: true, maxHeight : 600});	
								}
							});
						});
						
						
						$("input[name='projectStatus']").click(function(e){
							var projectID = $(this).attr('rel');
							var textStatus, statusUpdate;
							var object = $( this );
							var currentStatus = $(this).is(':checked');
							
							if(!currentStatus){
								textStatus = "close";
								statusUpdate = CONSTANT.PROJECT_STATUS_CLOSE;
							}else{
								textStatus = "open";
								statusUpdate = CONSTANT.PROJECT_STATUS_OPEN;
							}
							var message = "Do you want to " + textStatus + " the project [" + projectID+ "] ?";

							Yuga.dialog.confirm(message , function(){

								var url = "<c:url value='/project/closeProject'/>/" + projectID + "/" + statusUpdate;
								
								$.ajax({
									url : url,
									success : function(result){
										grid.trigger("reloadGrid");
									}
								});
							},
							function(){
								object .prop('checked', !currentStatus );
							});
						});
					},
					postData : {
						
						allType: function(){
							return ($("#chk-all").attr('checked') == "checked");
						},
						
						RequestPTypeID : function(){
							
							var projectTypeID = [];
							if($("#chk-all").attr('checked')){
								projectTypeID = null;
							}else{
								var projectTypeID = [];
								$('.project-type').find(':checkbox').each(function(){
									if(this.checked){
										projectTypeID.push($(this).val());
									}
								});
							}
							return projectTypeID;
						},
						RequestOrderBy : function(){
							return $('input[name="order"]:checked').val();
						},
						RequestStatus : function(){
							var status = [];
							$('#status').find(':checkbox').each(function(){
								if(this.checked){
									status.push($(this).val());
								}
							});
							
							if(status.length == 0){
								
								// push N = None project
								status.push('N');
							}
							return status;
						},
						RequestRole : function(){
							
							var role = [];
							$("#role").find(':checkbox').each(function(){
								if(this.checked){
									role.push($(this).val());
								}
							});
							
							return role;
						},
						RequestPeriod : function(){
							return $('input[name="period"]:checked').attr( "id" );
						}
						
					}
				};
				
				grid.jqGrid(options)
					.jqGrid('filterToolbar',{searchOperators : true});
		},
		
		// BIND EVENT
		bindEvent : function(grid){
			var d = new Date();
			var lastYear = d.getFullYear() - 1 ;
			$("#year").text(lastYear+  " ~ ");
			$("#previousYear").val(lastYear);
			$("#thisYear").val(d.getFullYear());
			
			$('#chk-all').removeAttr("checked")
						 .on('click',function(e){
							if(this.checked){
								$('.project-type').find(':checkbox').attr('checked', 'checked');
							}else{
								$('.project-type').find(':checkbox').removeAttr('checked');
							}
						 })
						 .click();
			
			$("input[name='projectType']").click(function(e){
				if($("input[name='projectType']:checked").length == $("input[name='projectType']").length){
					$('#chk-all').attr('checked',true);
				}else{
					$('#chk-all').attr('checked',false);
				}
			});
		
			$("input[type='checkbox'], input[type='radio']").click(function(){
				grid.trigger("reloadGrid");
			});
		}
	};

	
</script>
