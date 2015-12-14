<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="format"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>


<div id="tabsUP">

	<div class="tree">
		<div class="validDate">
			<label for="lastUpdated">Last Update</label>
			<input type="text" readonly="readonly" class="text" id="lastUpdated" />
		</div>
		<div class="validDate">
			<label for="year">Year</label>
			<select class="select" id="year">
				<tiles:insertTemplate template="/WEB-INF/views/elements/masterData/yearSelect.jsp" />
			</select>
			(Unit Base: KRW)
		</div>
	</div>
	
	<div class="grid tab-grid" style="width: 95%;">
		<table id="list"></table>
		<div id="paging"></div>
	</div>
	
	<div class="btn-group">
		<button type="button" id="submitData" class="btn btn-primary">Submit</button>
	</div>
</div>

<script type="text/javascript">

	var employeeLevel = {
			grid : $("#list"),
			DATA : "employee_level", 
			YES : 'Y',
			masterData : null,
			init : function(){
				
				employeeLevel.initValue();
				employeeLevel.initGrid();
				employeeLevel.initTab();
				employeeLevel.bindEvent();
			},
			
			bindEvent : function(){

				$("#year").on("change", employeeLevel.onChangeYear);
				$("#submitData").on("click", function(){
					Yuga.dialog.confirm(
						"Warning! when you click submit this masterdata <br /> You will not be able edit it in next time.", 
						employeeLevel.submitMasterData
					);	
				});
			},
			
			initGrid : function(){
				var	numberOption = {
						dataInit : function(element){
		   					$(element).autoNumeric({aPad: false});
		   				}
					},
					formatter = function(cellvalue, options, rowObject){
		   				return Yuga.commaSeparateNumber(cellvalue);
		   			},
		   			unformat = function(cellvalue, options, rowObject){
		   				return Yuga.removeComma(cellvalue);
		   			},
					add = {
						recreateForm: true,
						left: 100,
						closeAfterEdit: true,
						onclickSubmit : function(options, postData){
							return {
								year : $("#year").val(),
								data : employeeLevel.DATA,
								devCostKRW : Yuga.removeComma(postData.devCostKRW),
								internalBillingPriceKRW : Yuga.removeComma(postData.internalBillingPriceKRW),
								internalDevCostKRW : Yuga.removeComma(postData.internalDevCostKRW),
								listPriceKRW : Yuga.removeComma(postData.listPriceKRW)
							};
						},
						beforeShowForm : function(form){
							$(form).append($('<div>', {rel : "add", id : "operation"}));
						}
					},
					edit = $.extend(add, {
						beforeShowForm : function(form){
							$(form).append($('<div>', {rel : "edit", id : "operation"}));
						}
					});
					options = {
					url 		: "<c:url value='/employeeLevel/getGrid'/>",
					colNames 	: ['ID','Level', 'List Price', 'Dev. Cost', 'Internal Billing Price', 'Internal Dev. Cost', 'Remark'],
					colModel 	: [
				   		{
				   			name	:'empLevelID', 
				   			index	:'empLevelID', 
				   			width	: 40,
				   			align	: 'center',
				   			hidden	: true,
				   			editable: true 
				   		},
				   		{
				   			name	:'title', 
				   			index	:'title',
				   			width	: 70,
				   			editable: true, 
				   			editrules: {required: true, custom: true, custom_func : employeeLevel.validator.title}
				   		},
				   		{
				   			name	:'listPriceKRW', 
				   			index	:'listPriceKRW', 
				   			width	: 50,
				   			align	: 'right',
				   			editable: true, 
				   			editrules : {
				   				number : true,
				   				minValue :  0
				   			},
				   			editoptions : numberOption,
				   			editrules:{required:true},
				   			formatter: formatter,
				   			unformat : unformat,
				   			editrules: {required: true}
				   		},
				   		{
				   			name	:'devCostKRW', 
				   			index	:'devCostKRW', 
				   			width	: 50,
				   			align	: 'right',
				   			editable: true, 
				   			editrules : {
				   				number : true,
				   				minValue :  0
				   			},
				   			editoptions : numberOption,
				   			formatter: formatter,
				   			unformat : unformat,
				   			editrules: {required: true}
				   		},
				   		{
				   			name	:'internalBillingPriceKRW', 
				   			index	:'internalBillingPriceKRW', 
				   			width	: 50,
				   			align	: 'right',
				   			editable: true, 
				   			editrules : {
				   				number : true,
				   				minValue :  0
				   			},
				   			editoptions : numberOption,
				   			editrules:{required:true},
				   			formatter: formatter,
				   			unformat : unformat,
				   			editrules: {required: true}
				   		},
				   		{
				   			name	:'internalDevCostKRW', 
				   			index	:'internalDevCostKRW', 
				   			width	: 50,
				   			align	: 'right',
				   			editable: true, 
				   			editrules : {
				   				number : true,
				   				minValue :  0
				   			},
				   			editoptions : numberOption,
				   			editrules:{required:true},
				   			formatter: formatter,
				   			unformat : unformat,
				   			editrules: {required: true}
				   		},
				   		{
				   			name	:'remark', 
				   			index	:'remark', 
				   			width	: 110,
				   			editable: true
				   		}
					],					
					autowidth	: true,					
					rowNum		: 999,
					pager 		: '#paging',
					editurl 	: "<c:url value='/employeeLevel/saveRow'/>",
					postData : {
						year : function(){
							return $("#year").val();
						}
					},
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
						employeeLevel.observeMasterData();
					}
				};
				
				employeeLevel.grid
					.jqGrid(options)
					.jqGrid('navGrid',"#paging",{edit: true,add:true,del:false, search: false,refresh: true}, add, edit);

			},
			
			initTab : function(){
				$("#tabs").tabs({
					 active: 2,
					 activate : function(event, ui){
						 Yuga.redirect(url[ui.newPanel.selector]);
					 }
				});		
			},
			
			initValue : function(){
				$("#year").val(new Date().getFullYear());
			},

			validator : {
				title : function(value, colName){
					var valid = [false, "Level already exist."];
					var oper = $("#operation").attr("rel");
					var url = "<c:url value='/employeeLevel/checkTitle' />";
					var data = "title=" + value + "&year=" + $("#year").val();					
					if(oper == "edit"){
						var rowID = employeeLevel.grid.jqGrid ('getGridParam', 'selrow');
						var empLevelID = employeeLevel.grid.jqGrid ('getCell', rowID, 'empLevelID');
						data += "&empLevelID=" + empLevelID;
					}
					$.ajax({
						url : url,
						method : "post",
						data : data,
						async  : false,
						dataType : "json",
						success : function(response){
							valid[0] = response;
						}
					});					
					return valid;
				}
			},
			
			onChangeYear : function(){
				employeeLevel.grid.trigger("reloadGrid");
			},

			getMasterData : function(){
				var year  = $("#year").val();
				var url = "<c:url value='/masterData' />/" + year + "/" + employeeLevel.DATA + "/get";
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
			
			submitMasterData : function(){
				var url = "<c:url value='/masterData/submit' />";
				var data = {
					year : $("#year").val(),
					data : employeeLevel.DATA
				};
				$.ajax({
					url : url,
					dataType : "json",
					method : "post",
					data : JSON.stringify(data), 
					contentType : "application/json",
					success : function(response){
						if(response){
							employeeLevel.observeMasterData();
						}
					}
				});
			},
			
			observeMasterData : function(){
				employeeLevel.masterData = employeeLevel.getMasterData();
				if(employeeLevel.masterData != null){	
					$("#lastUpdated").val(employeeLevel.masterData.lastUpdated);
				}
				if(employeeLevel.masterData != null && employeeLevel.masterData.editable == employeeLevel.YES){
					$('#add_' + employeeLevel.grid.attr("id"))
							.add('#edit_' + employeeLevel.grid.attr("id"))
							.add('#submitData')
							.show();
				}else{
					$('#add_' + employeeLevel.grid.attr("id"))
							.add('#edit_' + employeeLevel.grid.attr("id"))
							.add("#submitData")
							.hide();
				}
				
			}
	};

	$(document).ready(employeeLevel.init);
</script>
