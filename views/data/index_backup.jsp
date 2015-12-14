<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="format"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<c:set var="dateFormat" value="yyyy-MM-dd"></c:set>
<format:parseDate value="${trOrganization.lastUpdated}" var="dOrgLastUpdated" pattern="${dateFormat}" />
<format:parseDate value="${trEmployee.lastUpdated}" var="dEmpLastUpdated" pattern="${dateFormat}" />
<format:parseDate value="${trEmployeeLevel.lastUpdated}" var="dEmplLastUpdated" pattern="${dateFormat}" />
<format:parseDate value="${trProjectType.lastUpdated}" var="dPTLastUpdated" pattern="${dateFormat}" />
<format:parseDate value="${trOpexCharge.lastUpdated}" var="dOCLastUpdated" pattern="${dateFormat}" />

<format:formatDate value="${dOrgLastUpdated}" 	var="orgLastUpdated" 	pattern="${dateFormat}" />
<format:formatDate value="${dEmpLastUpdated}" 	var="empLastUpdated" 	pattern="${dateFormat}" />
<format:formatDate value="${dEmplLastUpdated}" 	var="emplLastUpdated" 	pattern="${dateFormat}" />
<format:formatDate value="${dPTLastUpdated}" 	var="ptLastUpdated" 	pattern="${dateFormat}" />
<format:formatDate value="${dOCLastUpdated}" 	var="ocLastUpdated" 	pattern="${dateFormat}" />
<format:formatDate value="${trOrganization.validDate}" var="dOrgValidDate" pattern="${dateFormat}" />

<div id="tabs">
	<ul>
		<li><a href="#tabsOrg">Organization</a></li>
		<li><a href="#tabsEmp">Employee</a></li>
		<li><a href="#tabsUP">Unit Price</a></li>
		<li><a href="#tabsPT">Project Type</a></li>
		<li><a href="#tabsHC">Holiday</a></li>
		<li><a href="#tabsOC">Opex Charge</a></li>
		<li><a href="#tabsExR">Exchange Rate</a></li>
	</ul>
	<div id="tabsOrg">
		
		<div class="tree">
			<div class="validDate">
				<label for="lastUpdated">Last Update</label>
				<input type="text" readonly="readonly" value="${orgLastUpdated}" class="text" />
			</div>
			<div id="orgTree"></div>
			<div class="validDate">
				<label for="validDate">Valid Date</label>
				<input type="text" class="text" value="${dOrgValidDate}" readonly="readonly"  />
			</div>
		</div>
	</div>
	
	<div id="tabsEmp">
		<div class="tree">
			<div class="validDate">
				<label for="lastUpdated">Last Update</label>
				<input type="text" readonly="readonly" value="${empLastUpdated}" class="text" />
			</div>
		</div>
		
		<div class="grid tab-grid" style="width: 95%;">
			<table id="empList"></table>
			<div id="empPaging"></div>
		</div>
	</div>
	
	<div id="tabsUP">
		<div class="tree">
			<div class="validDate">
				<label for="lastUpdated">Last Update</label>
				<input type="text" readonly="readonly" value="${emplLastUpdated}" class="text" />
			</div>
		</div>
		<div class="grid tab-grid" style="width: 97%;">
			<table id="emplList"></table>
			<div id="emplPaging"></div>
		</div>
	</div>
	
	<div id="tabsPT">
		<div class="tree">
			<div class="validDate">
				<label for="lastUpdated">Last Update</label>
				<input type="text" readonly="readonly" value="${ptLastUpdated}" class="text" />
			</div>
			<div class="grid tab-grid" style="width: 97%;">
				<table id="ptList"></table>
				<div id="ptPaging"></div>
			</div>
		</div>
	</div>
	
	<div id="tabsHC">
		<div id='calendar' class="fc fc-ltr"></div>
		<div id='calendarList' class='hide'></div>
	</div>
	
	<div id="tabsOC">
		<div class="tree">
			<div class="validDate">
				<label for="lastUpdated">Last Update</label>
				<input type="text" readonly="readonly" value="${ocLastUpdated}" class="text" />
			</div>
			<div class="grid tab-grid" style="width: 97%;">
				<table id="ocList"></table>
				<div id="ocPaging"></div>
			</div>
		</div>
	</div>
	<div id="tabExR">
		<div class="tree">
			<div class="validDate">
				<label for="selectYear">Select year : </label>
					<select class="select" id="selectYear">
					<option>2013</option>
					<option selected="selected">2014</option>
					<option>2015</option>
					<option>2016</option>
					<option>2017</option>
					<option>2018</option>
					<option>2019</option>
					<option>2020</option>
				</select>
			</div>
			<div style=" padding:20px; border: 1px solid gray;width: 320px;align:'center';">
				<label for="krw">1USD = </label>
				<input type="text" id="krw" disabled="disabled"/> KRW
				
			</div>
		</div>
	</div>
</div>
	


<script type="text/javascript">
// to format text in KRW textbox
		$(document).on('keyup', '#krw', function() {
		    var x = $(this).val();
		    $(this).val(x.toString().replace(/,/g, "").replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		});
		
		var data = {
				
			init : function(){
				
				data.initOrganization();
				data.initEmployee();
				data.initEmployeeLevel();
				data.initProjectType();
				data.initHoliday();
				data.initOpexCharge();
				data.bindEvent();	
				data.initFilterYear();
			},
			initFilterYear : function()
			{
				$("#selectYear").change(function(){
					var valYear = $("#selectYear option:selected").text();
					var url = "<c:url value='/exchangeRate/byYear/" +valYear+"'/>";
				
					$.ajax({
						url:url,
						datatype:"json",
						method:"post",
						contentType : "application/json",
						success: function(data) {
							var krwNum=data.krw.toString().replace(/,/g, "").replace(/\B(?=(\d{3})+(?!\d))/g, ",");
							$("#krw").val(krwNum);
						}
					});
					
				});
			},
			
			initOrganization : function(){
				
				$("#orgTree").jstree({
					core : {
					    animation : 0,
					    check_callback : true,
					    multiple: false,
					    themes : { stripes : true },
					    data : {
					      	url : '<c:url value="/organization/getOrgTree.json" />'
						}
					},
					plugins : [
					   "state", "types", "wholerow"
					]
				});
			},
			
			initEmployee : function(){

				var employee = {
						
						grid: $("#empList"),
						role : {
							roleEmployee : 	CONSTANT.ROLE_EMPLOYEE,
							rolePM : 		CONSTANT.ROLE_PM,
							roleSuperUser : CONSTANT.ROLE_SUPER_USER
						},
						formatter : {
							
							radio : function(cellvalue, options, rowObject){
								
								var $radio = $("<input>")
												.attr("type", "radio")
									  			.attr("name", rowObject.employeeID)
									  			.val(options.colModel.name)
												.addClass("radioRow")
												.attr("disabled", "disabled")
								
								if(cellvalue){
									$radio.attr("checked", "checked");
								}
								
								return $radio.wrap("<div>").parent().html();
							},
							resetPwd : function(cellvalue, options, rowObject){
								
								var $button = $("<button>")
												.attr("type", "button")
												.attr("class", "btn btnReset")
												.attr("rel", rowObject.employeeID)
												.text("Reset");
												
								return $button.wrap("<div>").parent().html();
							}
						},
						init: function(){
							
							employee.initData();
						},
						
						initData : function(){
							
							employee.initGrid();
						},
						
						initGrid : function(){
							var options = {
									url 		: "<c:url value='/employee/getGrid'/>",
									colNames 	: ['ID','Name', 'Email', 'Title', 'Level', 'Team', 'Department', 'Division', 'Employee', 'PM', 'Super User', 'Password'],
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
								   			width	: 80,
								   			hidden	: true
								   		},
								   		{
								   			name	:'title', 
								   			index	:'title',
								   			width	: 80
								   		},
								   		{
								   			name	:'level', 
								   			index	:'level',
								   			width	: 40,
								   			stype:'select',
								   			editoptions : {value : "${level}"}
								   		},
								   		{
								   			name	:'team', 
								   			index	:'team'
								   		},
								   		{
								   			name	:'department', 
								   			index	:'department'
								   		},
								   		{
								   			name	:'division', 
								   			index	:'division'
								   		},
								   		{
								   			name	:'roleEmployee', 
								   			index	:'roleEmployee',
								   			search	: false,
								   			width	: 60,
								   			formatter : employee.formatter.radio,
									   		align: "center"
								   		},
								   		{
								   			name	:'rolePM', 
								   			index	:'rolePM',
								   			search	: false,
								   			width	: 50,
								   			formatter : employee.formatter.radio,
									   		align: "center"
								   		},
								   		{
								   			name	:'roleSuperUser', 
								   			index	:'roleSuperUser',
								   			search	: false,
								   			width	: 70,
								   			formatter : employee.formatter.radio,
									   		align: "center"
								   		},
										{
											name	: 'action',
											index	: 'action',
											width	: 100,
											align	: 'center',
											search  : false,
											formatter : employee.formatter.resetPwd
										}
									],
									pager 		: '#empPaging',
									rownumbers	: true,
									editurl 	: "clientArray",
									loadComplete : function(){
																				
										$(".btnReset").on("click", function(){
											
											var employeeID = $(this).attr("rel");
											var url = "<c:url value='/employee/resetPwd' />/" + employeeID;
											var message = "Do you want to reset this employee password.";
											
											Yuga.dialog.confirm(message, function(){
												$.ajax({
													url : url,
													success : function(response){
														
														Yuga.dialog.alert("Employee password has been reset.")
													}
												});
											});
										});
									}
								};
							
							employee.grid.jqGrid(options)
										 .jqGrid('filterToolbar',{searchOperators : true});
						}
				};
				
				employee.init();
			},
			
			initEmployeeLevel : function(){
				var employeeLevel = {
						grid : $("#emplList"),
						init : function(){							
							employeeLevel.initGrid();
						},
						
						initGrid : function(){
							var	options = {
								url 		: "<c:url value='/employeeLevel/getGrid'/>",
								colNames 	: ['ID','Level', 'US', 'KRW', 'US', 'KRW', 'US', 'KRW', 'US', 'KRW', 'US', 'KRW',  'Remark'],
								colModel 	: [
							   		{
							   			name	:'empLevelID', 
							   			index	:'empLevelID', 
							   			width	: 100,
							   			align	: 'center',
							   			hidden	: true
							   		},
							   		{
							   			name	:'title', 
							   			index	:'title',
							   			width	: 70
							   		},
							   		{
							   			name	:'laborCostUS', 
							   			index	:'laborCostUS', 
							   			align	: 'right',
							   			width	: 50,
							   			hidden	: true
							   		},
							   		{
							   			name	:'laborCostKRW', 
							   			index	:'laborCostKRW', 
							   			width	: 50, 
							   			align	: 'right',
							   			hidden	: true
							   		},
							   		{
							   			name	:'listPriceUS', 
							   			index	:'listPriceUS', 
							   			width	: 50,
							   			align	: 'right'
							   		},
							   		{
							   			name	:'listPriceKRW', 
							   			index	:'listPriceKRW', 
							   			width	: 50,
							   			align	: 'right'
							   		},
							   		{
							   			name	:'devCostUS', 
							   			index	:'devCostUS', 
							   			width	: 50,
							   			align	: 'right'
							   		},
							   		{
							   			name	:'devCostKRW', 
							   			index	:'devCostKRW', 
							   			width	: 50,
							   			align	: 'right'
							   		},
							   		{
							   			name	:'internalBillingPriceUS', 
							   			index	:'internalBillingPriceUS',
							   			width	: 50,
							   			align	: 'right'
							   		},
							   		{
							   			name	:'internalBillingPriceKRW', 
							   			index	:'internalBillingPriceKRW', 
							   			width	: 50,
							   			align	: 'right'
							   		},
							   		{
							   			name	:'internalDevCostUS', 
							   			index	:'internalDevCostUS', 
							   			width	: 50,
							   			align	: 'right'
							   		},
							   		{
							   			name	:'internalDevCostKRW', 
							   			index	:'internalDevCostKRW', 
							   			width	: 50,
							   			align	: 'right',
							   			editrules:{required:true}
							   		},
							   		{
							   			name	:'remark', 
							   			index	:'remark', 
							   			width	: 110
							   		}
								],
								pager 		: '#emplPaging'
							};
							
							employeeLevel.grid
								.jqGrid(options)
								.jqGrid('filterToolbar',{searchOperators : true});
							

							employeeLevel.grid
								.jqGrid('setGroupHeaders', {
									  useColSpanStyle: true, 
									  groupHeaders:[
										{startColumnName: 'laborCostUS', 		numberOfColumns: 2, titleText: "Labor Cost"},
										{startColumnName: 'listPriceUS', 		numberOfColumns: 2, titleText: "List Price"},
										{startColumnName: 'devCostUS', 			numberOfColumns: 2, titleText:  "Development Cost"},
										{startColumnName: 'internalBillingPriceUS', numberOfColumns: 2, titleText:  "Internal Billing Price"},
										{startColumnName: 'internalDevCostUS', 		numberOfColumns: 2, titleText:  "Internal Development Cost"}
									  ]
							}); 
						}
				};
				employeeLevel.init();
			},
			
			initProjectType : function(){
				var grid = $("#ptList");
				var options = {
					url 		: "<c:url value='/projectType/getGrid.json'/>",
					colNames 	: ['ID','Project Type', 'Order Number', 'Flag', 'Remarks'],
					colModel 	: [
				   		{
				   			name	:'projectTypeID', 
				   			index	:'projectTypeID', 
				   			width	: 200,
				   			hidden	: true
				   		},
				   		{
				   			name	:'title', 
				   			index	:'title', 
				   			width	: 200
				   		},
				   		{
				   			name	:'sortOrder', 
				   			index	:'sortOrder', 
				   			width	: 90
				   		},
				   		{
				   			name	:'flag', 
				   			index	:'flag',
				   			editable: true ,
				   			stype:'select',
				   			editoptions : {value : "${flag}"}
				   		},
				   		{
				   			name	:'remark', 
				   			index	:'remark', 
				   			width	: 200
				   		}
					],
					pager 		: '#ptPaging',
					sortname	: 'sortOrder'
				};
				
				grid.jqGrid(options)
					.jqGrid('filterToolbar',{searchOperators : true});
			},
			
			initHoliday : function(){
				
				var calendar = $('#calendar').fullCalendar({
					header: {
						left: 'today',
						center: 'prev,title,next ',
						right: 'month,agendaWeek',
					},
					contentHeight: 500,
					selectable: true,
					selectHelper: true,
					events : function(start, ends, callback){
						var data = {
								"startDate" : start.getTime(),
								"endDate" : ends.getTime()
						};
						$.ajax({
							type : "POST",
							url : "<c:url value='/holiday/ajaxGetCalender' />",
							dataType : "json",
							contentType : "application/json",
							data : JSON.stringify(data),
							success : function(event){
								if(event.length != 0){
								var eventData = [];
								$.each(event,function(key,value){
									eventData.push({
										id : value.holidayID,
										start : new Date(value.startDate),
										end : new Date(value.endDate),
										title : value.holidayTitle,
										allDay : true,
										textColor : 'black',
										color : (value.office == "KOREA" ? "#FFFF00" : "#FF0000"),
										office : value.office
									});
								});
							callback(eventData);
							}
							}
						});
					}
				});
			},
			
			initOpexCharge : function(){
				
				var grid = $("#ocList");
				var options = {
					url 		: "<c:url value='/opexCharge/getGrid.json'/>",
					colNames 	: ['OpexChargeID', 'GP Type', 'Rate', 'Remark'],
					colModel 	: [
				   		{
				   			name	:'opexChargeID', 
				   			index	:'opexChargeID', 
				   			width	: 200,
				   			hidden	: true 
				   		},
				   		{
				   			name	:'gpType', 
				   			index	:'gpType', 
				   			width	: 200
				   		},
				   		{
				   			name	:'rate', 
				   			index	:'rate', 
				   			width	: 90,
				   			formatter : function(cellvalue, options, rowObject){
				   				return cellvalue.toFixed(2) + " %";
				   			}
				   		},
				   		{
				   			name	:'remark', 
				   			index	:'remark', 
				   			width	: 200,
				   			editable: true 
				   		}
					],
					pager 		: '#ocPaging',
					sortname	: 'opexChargeID'
				};
				
				grid.jqGrid(options);
			},
			
			bindEvent: function(){
				$("#tabs").tabs({
					activate: function(event, ui){
						$('#calendar').fullCalendar('render');
					}
				});
			}
		};
		
		
		$(document).ready(data.init);
		
</script>