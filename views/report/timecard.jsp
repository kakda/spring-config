<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<table class="table table-noborder">
	<colgroup>
		<col style="width: 350px;">
		<col />
		<col style="width: 150px;">
		<col />
		<col />
	</colgroup>
	<tr>
		<th><label for="organization">Team:</label></th>
			<td>
				<input type="hidden" name="orgID" id="orgID"/>
				<input type="text" id="organization" readonly="readonly" class="text popup" />
			</td>
		<th>Employee:</th>
		<td>
			<select id="employee" name="employee"></select>
		</td>
	</tr>
	<tr>
		<th>From:</th>
		<td>
			<input type="text" placeholder="Select date ..." class="text date" name="fromDate" id="fromDate"/> 
		</td>
		<th>To:</th>
		<td>
			<input type="text" placeholder="Select date ..." class="text date" name="toDate" id="toDate"/>	
		</td>
	</tr>
	<tr>
		<td>
			<input type="radio" id="none" class='period' name="period" checked="checked"/><label for="none">None</label>
			<input type="radio" id='week' class='period' name='period'/><label for="week"> 1 Week</label>
			<input type="radio" id='month' class='period' name='period'/><label for="month">1 Month</label>
			<input type="radio" id='quarter' class='period' name='period'/><label for="quarter">1 Quarter</label>
		</td>
	</tr>
</table>
<div id="timeCardTreeDialog" class="hide">
	<div>
		<label for="year">Year:</label>
		<select class="select" id="year">
			<option>2013</option>
			<option>2014</option>
			<option>2015</option>
			<option>2016</option>
			<option>2017</option>
			<option>2018</option>
			<option>2019</option>
			<option>2020</option>
		</select>
	</div>
	<div id="timeCardOrgTree"></div>
</div>
<div class='timecardReportGrid'>
	<table id="list"></table>
</div>

<script>

timecardReport ={
		grid : $('#list'),
		init : function(){
			this.initData();
			this.initTree();
			this.bindEvent();
			this.initGrid();
		},
		
		initData : function(){
			$('#year').val(new Date().getFullYear());
			$('#timeCardTreeDialog').dialog({
				modal: true,
				autoOpen: false
			});
			$("#fromDate, #toDate").datepicker("option", "minDate", '-2 Y');
			$("#fromDate").datepicker({
				onSelect : function() {
					var minDate = $(this).datepicker('getDate');
					$('#toDate').datepicker('option', 'minDate', minDate);
					$("input[id='none']").attr('checked', 'checked');
					timecardReport.getReport();
				}
			});
			$('#toDate').datepicker({
				onSelect : function() {
					var maxDate = $(this).datepicker('getDate');
					$('#fromDate').datepicker('option', 'maxDate', maxDate);
					$("input[id='none']").attr('checked', 'checked');
					timecardReport.getReport();
				}
			});
			
		},
		
		initTree : function(){
			$('#timeCardOrgTree').jstree({
				core : {
				    animation : 0,
				    check_callback : true,
				    multiple: false,
				    themes : { stripes : true },
				    data : {
				    	url : function(){
				      		return '<c:url value="/organization" />/' + $("#year").val() + '/getOrgTree';	
				      	}	
			      	}
				},
				plugins : [
				  "contextmenu", "search", "state", "types", "wholerow", "dnd"
				],
				dnd : {
					copy : false
				}
			});
			$('#timeCardOrgTree')
				.unbind("dblclick.jstree")
				.bind("dblclick.jstree", function (e) {
				var tree = $.jstree.reference('#timeCardOrgTree');
				var selectedNodes = tree.get_selected();
				var node = tree.get_node(selectedNodes[0]);
			  	 $("#organization").attr("value", node.text);
			  	 $("#orgID").val(node.id);
				 $('#timeCardTreeDialog').dialog("close");
				 timecardReport.getEmployee();
			});
			
		},
		
		bindEvent : function(){
			$('#organization').click(function(){
				$('#timeCardTreeDialog').dialog("open");
			});
			$("input:radio").change(function(){
				var value = $(this).attr('id');
				var date = new Date();
				switch (value){
					case "week"  :
						$("#fromDate").datepicker("setDate", new Date(date.getFullYear(), date.getMonth(), date.getDate() - 7));
						$("#toDate").datepicker("setDate", date);
						timecardReport.getReport();
						break;
					case "month" : 
						$("#fromDate").datepicker("setDate", new Date(date.getFullYear(), date.getMonth() - 1, date.getDate()));
						$("#toDate").datepicker("setDate", date);
						timecardReport.getReport();
						break;
					case "quarter" :
						$("#fromDate").datepicker("setDate", new Date(date.getFullYear(), date.getMonth() - 3, date.getDate()));
						$("#toDate").datepicker("setDate", date);
						timecardReport.getReport();
						break;
					case "none" :
						$("#fromDate, #toDate").val('');
						timecardReport.getReport();
						break;
				}
			});
			
			$('#employee').on('change',function(){
				timecardReport.getReport();
			});
			
			$('#year').off("change").on('change',function(){
				$.jstree.reference('#timeCardOrgTree').refresh();
			});
			
		},
		
		getEmployee : function(){
			var URL = Yuga.baseURL() + "/employee/"+$("#orgID").val()+"/getEmployeeByOrgID.json";
			$.ajax({
    			url : URL,
    			dataType : "json",
    			success : function(response){
    				$("#employee").html('');
    				var length = response.length;
    				if(length > 0){
    					var options = "<option value='ALL'>ALL</option>";;
						for(var i=0; i < length; i++){
							options += "<option value='"+response[i].employeeID+"'>"+response[i].employeeName+"</option>";
						}
						$("#employee").html(options);
    				}
    				$("#employee").trigger('change');
    			}
    		});
			
		},
		
		getReport : function(){
				var data = {
						orgID      : $("#orgID").val(),
						employeeID : $('#employee').val(),
						fromDate   : $('#fromDate').val(),
						toDate     : $("#toDate").val() 
				}
				timecardReport.grid.setGridParam({'postData': data});
				timecardReport.grid.trigger("reloadGrid");
		},
		
		initGrid : function(){
			var options = {
					url 		: "<c:url value='/report/getTimeCardReport'/>",
					colNames 	: ['Date','Employee', 'Project', 'Project Type', 'Approve hour', 'Actual Hour'],
					colModel 	: [
				   		{
				   			name	:'date', 
				   			index	:'date', 
				   			align 	: 'center',
				   		},
				   		{
				   			name	:'employeeName', 
				   			index	:'employeeName',
				   		},
				   		{
				   			name	:'projectName', 
				   			index	:'projectName',
				   		},
				   		{
				   			name	:'projectTypeName', 
				   			index	:'projectTypeName',
				   		},
				   		{
				   			name	:'approvedHour', 
				   			index	:'approvedHour',
				   			formatter:function(cellvalue, options, rowObject) {
				   				return parseFloat(cellvalue).toFixed(2);
				   			}
				   		},
				   		{
				   			name	:'actualHour', 
				   			index	:'actualHour',
				   			formatter:function(cellvalue, options, rowObject) {
				   				return parseFloat(cellvalue).toFixed(2);
				   			}
				   		}
					],
					rownumbers	: true,
					rowNum 		: 99999,
					footerrow	: true,
					loadComplete: function () {
	                    var $self = $(this),
	                        sumApp = $self.jqGrid("getCol", "approvedHour", false, "sum");
	                    	sumActual = $self.jqGrid("getCol", "actualHour", false, "sum");
	                    $self.jqGrid("footerData", "set", {projectTypeName: "Total:", approvedHour: sumApp, actualHour : sumActual});
	                }

				};
			
			timecardReport.grid.jqGrid(options).jqGrid();
			
		}
};

$(document).ready(function(){
	timecardReport.init();
});
</script>
