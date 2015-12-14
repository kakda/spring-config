<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="tabsProGeneral" class="form-container project-general">
		<form  id="projectGeneral">
			<table class="form">
				<colgroup>
					<col style="width:200px" />
					<col />
				</colgroup>
				<tr>
					<td><label for="projectName">Project Name</label></td>
					<td><input type="text" id="projectName" class="text" name="projectName" /></td>
				</tr>
				<tr>
					<td><label for="projectType">Project Type</label></td>
					<td>
						<select id="projectTypeID" class="select" name="projectTypeID" >
							<c:forEach var="item" items="${projectType}">
								<option class="${item.flag}" value="${item.projectTypeID}"> ${item.title}</option>		
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td><label>Project Period</label></td>
					<td class="dtp2fields">
						<div class="text1">
							<input type="text" placeholder="Select start date ..." class="text startDate" name="startDate" id="startDate"/>  
						</div>
						<span>-</span>
						<div class="text2">
							<input type="text" placeholder="Select end date ..." class="text endDate" name="endDate" id="endDate"/>
						</div> 
						 
					</td>
					<!-- <input type="hidden" name="startDate" id="startDate"/>
					<input type="hidden" name="endDate" id="endDate"/> -->
				</tr>
				<tr>
					<td><label for="projectOwner">Project Owner Team</label></td>
					<td>
						<input type="hidden" name="orgID" id="orgID"/>
						<input type="text" id="projectOwner" readonly="readonly" class="text popup" name="projectOwner" />
					</td>
					
				</tr>
				<tr>
					<td><label for="projectManager">Project Manager</label></td>
					<td>
						<input type="hidden" id="employeeID" name="employeeID"/>
						<input type="text" id="projectManager" readonly="readonly" class="text popup" name="projectManager" />
					</td>
					
				</tr>
			</table>
		</form>
	</div>
	<div id="treeDialog">
		<input type="text" id="search" class="text search" placeholder="Enter something to search ..." />
		<div id="orgTree"></div>
	</div>
	<div id="member">
		<table id="employee"></table>
		<div id="paging"></div>
	</div>

<script type="text/javascript">
	$(document).ready(function(){
		generalInfoTab.init();
		generalInfoTab.bindEvent();
	});
	
	var generalInfoTab = {
		selector : "",
		init : function(){
			
			generalInfoTab.tab();
			generalInfoTab.dialog();
			generalInfoTab.employeeInitGrid();
			generalInfoTab.viewSessionData();
			
		},
		tab : function(){
			
			
			$("#tabs").tabs({
				 active: 0,
				 
				 activate : function(event, ui){
					 generalInfoTab.validate();
				 },
				 
				 beforeActivate : function(event, ui){
					 
					 // check valid inputs
					 var valid = generalInfoTab.validate();
					 
					 if( valid ){
					 	// save form data into session
						if(! $('#projectOwner').is(":visible")) {
							$('#projectOwner').attr('value', null);
							$('#orgID').attr('value', null);
						}
						var	generalInfo = $( 'form#projectGeneral' ).serializeJSON();
						$.session.setJSON( session.keys.general, generalInfo );
							 
						// change to new page
						generalInfoTab.selector = ui.newPanel.selector;
						Yuga.redirect(url[generalInfoTab.selector]);
				 	}
					 
					return valid;
					
				 }
			});
		},
		
		viewSessionData: function(){
			var json = $.session.getJSON(session.keys.general);
			$(".startDate, .endDate").datepicker("option", "minDate", '-2 Y');
			$(".startDate").datepicker({
				onSelect : function() {
					var minDate = $(this).datepicker('getDate');
					$('.endDate').datepicker('option', 'minDate', minDate);
					$('#orgTree').jstree('destroy');
					generalInfoTab.initTree(minDate.getFullYear());
				}
			});
			if( json != null ){
				$.each( json, function( key, value ){
					$( "#" + key  ).val( value );
				});
				$('.startDate').datepicker('option', 'maxDate', new Date($('.endDate').val()));
				$('.endDate').datepicker('option', 'minDate', new Date($('.startDate').val()));
			}
		},
		
		dialog : function(){
			$('#treeDialog').dialog({
				modal: true,
				autoOpen: false
			});
			$('#member').dialog({
				modal: true,
				autoOpen: false,
				height : 522,
				width : 898
			});

			
		},
		
		bindEvent : function(){

			$( '#projectTypeID' ).on( 'change', function(evt){
				evt.preventDefault();
				if($(this).find('option:selected').attr('class') === 'Over Head') {
					$('#projectOwner').closest('tr').hide();
				}else {
					$('#projectOwner').closest('tr').show();
				}
				
			});			
			
			$('#projectOwner').click(function(){
				if($('#startDate').val() !== '' && $('startDate').val() !== 'undefined' ){
					generalInfoTab.initTree(new Date($('#startDate').val()).getFullYear());
					$('#treeDialog').dialog("open");
				}
				return;
			});
			
			$('#projectManager').click(function(){
				$('#member').dialog("open");
				
			});
			
			$("#search").on("keyup", generalInfoTab.search);
// 			$("#projectGeneral").submit(function(e){
// 				 if($("#projectGeneral").valid()){
// 					Yuga.redirect(url[ui.newPanel.selector]);
// 					Yuga.redirect(url[generalInfoTab.selector]);

// 				 }
// 			});

			
		},
		validate : function(){
			
			$( '#projectGeneral' ).removeData('validator');
			
			$.ajaxSetup({async:false});
			var validator = $("#projectGeneral").validate({
				ignore: '',
				rules: {
					projectName: {
						required: true,
						remote: "<c:url value='/project/valid'/>"
					},
					projectTypeID: {
						required: true,
					},
					startDate : {
						required : true
					},
					endDate : {
						required : true
					},
					projectOwner : function(){
						if($('#projectOwner').closest('tr').is(':visible')){
							return {required : true};
						}else {
							return {required : false};
						}
					}(),
					projectManager : {
						required : true
					}
				},
				messages: {
					title: {
						remote: "Project Name already exist."
					}
				}
			});
			
			return validator.form() || false;
			
		},
		initTree : function(year){
			var treeURL = "<c:url value='/organization/"+year+"/getProjectOrgTree.json'/>";
			
			$('#orgTree').jstree({
				core : {
				    animation : 0,
				    check_callback : true,
				    multiple: false,
				    themes : { stripes : true },
				    data : {
				      	url : treeURL
					}
				},
				plugins : [
				  "contextmenu", "search", "state", "types", "wholerow", "dnd"
				],
				dnd : {
					copy : false
				}
			});
			
			$('#orgTree').bind("dblclick.jstree", function (e) {
				var tree = $.jstree.reference('#orgTree');
				var selectedNodes = tree.get_selected();
				var node = tree.get_node(selectedNodes[0]);
			  	 $("#projectOwner").attr("value", node.text);
			  	 $("#orgID").val(node.id);
				  $('#treeDialog').dialog("close");
			});
		},
		search : function(){
		        $.jstree.reference($('#orgTree')).search($('#search').val());
		},
		
		employeeInitGrid : function(){
			var options = {
					url 		: "<c:url value='/employee/getGrid'/>",
					colNames 	: ['ID','Name', 'Email', 'Title', 'Level', 'Team', 'Department', 'Division'],
					colModel 	: [
				   		{
				   			name	:'employeeID', 
				   			index	:'employeeID', 
				   			align	: 'center',
				   			hidden	: true,
				   			search	: false
				   		},
				   		{
				   			name	:'employeeName', 
				   			index	:'employeeName'
				   		},
				   		{
				   			name	:'email', 
				   			index	:'email',
				   			search	: false,
				   			width	: 80
				   		},
				   		{
				   			name	:'title', 
				   			index	:'title',
				   			search	: false,
				   			width	: 80
				   		},
				   		{
				   			name	:'level', 
				   			index	:'level',
				   			width	: 40,
				   			search	: false,
				   		},
				   		{
				   			name	:'team', 
				   			index	:'team',
				   			search	: false
				   		},
				   		{
				   			name	:'department', 
				   			index	:'department',
				   			search	: false
				   		},
				   		{
				   			name	:'division', 
				   			index	:'division',
				   			search	: false
				   		}
					],
					pager 		: '#paging',
					rownumbers	: true,
					rowNum 		: 10,
					ondblClickRow : function(rowId){
						var rowData = $(this).getRowData(rowId);
						$('#projectManager').val(rowData.employeeName);
						$('#employeeID').val(rowData.employeeID);
						$('#member').dialog('close');
					}
				};
			
			$('#employee').jqGrid(options)
						  .jqGrid('filterToolbar',{searchOperators : true});
		}
	};
	
</script>