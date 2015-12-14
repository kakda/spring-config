<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="format"%>

<format:parseDate value="${transaction.lastUpdated}" var="dLastUpdated" pattern="yyyy-MM-dd" />
<format:formatDate value="${dLastUpdated}" var="lastUpdated" pattern="yyyy-MM-dd" />


<div id="tabsPT">

	<div class="tree">
		<div class="validDate">
			<label for="lastUpdated">Last Update</label>
			<input type="text" readonly="readonly" value="${lastUpdated}" class="text" id="lastUpdated" />
		</div>
	</div>
		
	<div class="grid tab-grid" style="width: 98%;">
		<table id="list"></table>
		<div id="paging"></div>
	</div>
</div>


<script type="text/javascript">

	var grid = $("#list");
	var projectType = {
			masterData : null,
			DATA : "project_type",
			init : function(){
				
				projectType.initTab();
				projectType.initGrid();
			},
			
			initTab : function(){
				$("#tabs").tabs({
					 active: 3,
					 activate : function(event, ui){	 
						 Yuga.redirect(url[ui.newPanel.selector]);
					 }
				});
			},
			
			initGrid : function(){
				var options = {
					url 		: "<c:url value='/projectType/getGrid.json'/>",
					colNames 	: ['ID','Project Type', 'Order Number', 'Flag', 'Remarks'],
					colModel 	: [
				   		{
				   			name	:'projectTypeID', 
				   			index	:'projectTypeID', 
				   			width	: 20,
				   			hidden	: true,
				   			editable: true 
				   		},
				   		{
				   			name	:'title', 
				   			index	:'title', 
				   			width	: 200,
				   			editable: true , 
				   			editrules : {
				   				required : true
				   			}
				   		},
				   		{
				   			name	:'sortOrder', 
				   			index	:'sortOrder', 
				   			width	: 90,
				   			editable: true , 
				   			editrules : {
				   				required : true
				   			},
				   			editoptions : {
				   				dataInit : function(element){
				   					$(element).autoNumeric({aPad: false, aSep: ""});
				   				}
				   			},
				   			addoptions : {
				   				dataInit : function(element){
				   					$(element).autoNumeric({aPad: false, aSep: ""});
				   				}
				   			}
				   		},
				   		{
				   			name	:'flag', 
				   			index	:'flag',
				   			editable: true , 
				   			editrules : {
				   				required : true
				   			},
				   			stype:'select',
				   		    edittype: 'select',
				   			editoptions : {
				   				value : "${flags}"
				   			},
				   			addoptions : {
				   				value : "${flags}"
				   			}
				   		},
				   		{
				   			name	:'remark', 
				   			index	:'remark', 
				   			width	: 200,
				   			editable: true 
				   		}
					],											
					
					pager 		: '#paging',
					editurl 	: "<c:url value='/projectType/saveRow'/>",
					sortname	: 'sortOrder',
					edit : {
						addCaption: "Add Record",
						editCaption: "Edit Record",
						bSubmit: "Submit",
						bCancel: "Cancel",
						bClose: "Close",
						saveData: "Data has been changed! Save changes?",
						bYes : "Yes",
						bNo : "No",
						bExit : "Cancel"
					},
					loadComplete : function(){
						projectType.observeMasterData();
					}
				};
				
				grid.jqGrid(options)
					.jqGrid('filterToolbar',{searchOperators : true})
					.jqGrid('navGrid',"#paging",{edit: true,add:true,del:false, search: false,refresh: true}, {closeAfterEdit : true});
			},
			

			getMasterData : function(){
				var url = "<c:url value='/masterData' />/0/" + projectType.DATA + "/get";
				var obj = null; 
				
				$.ajax({
					url : url,
					dataType : "json",
					async : false,
					success : function(response){
						obj = response;
					}
				});
				return obj;
			},

			observeMasterData : function(){
				projectType.masterData = projectType.getMasterData();
				if(projectType.masterData != null){	
					$("#lastUpdated").val(projectType.masterData.lastUpdated);
				}
			}
	}

	$(document).ready(function(){
		projectType.init();		
	});
</script>
