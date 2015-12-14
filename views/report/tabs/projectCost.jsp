<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="format"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<table class="table table-noborder">
	<colgroup>
		<col style="width: 150px;">
		<col />
		<col style="width: 150px;">
		<col />
		<col style="width: 150px;">
		<col />
	</colgroup>
	<tbody>
		<tr>
			<th><label for="pcProjectTypeID">Project Type:</label></th>
			<td><select class="select" id="pcProjectTypeID">
					<option value="">Choose</option>
					<c:forEach items="${projectTypes}" var="projectType">
						<option value="${projectType.projectTypeID}">${projectType.title}</option>
					</c:forEach>
			</select></td>
			<th><label for="pcProjectID">Project Name:</label></th>
			<td><select class="select" id="pcProjectID">
					<option>Choose</option>
			</select></td>
			<th><label for="pcRevenueRecog">Revenue Recog:</label></th>
			<td><select class="select" id="pcRevenueRecog">
					<option value="Proportional">Proportional</option>
					<option value="Accrual">Accrual</option>
			</select></td>
		</tr>
		<tr>
			<th><label for="pcPM">Project Manager</label></th>
			<td><span id="pcPM"></span></td>
			<th><label for="pcProjectPeriod">Project Period</label></th>
			<td><span id="pcProjectPeriod"></span></td>
			<th><label for="pcCurrency">Currency</label></th>
			<td><select id="pcCurrency" class="select" disabled="disabled" ><option
						value="KRW" selected="selected">KRW</option>
					<option value="USD" >USD</option></select></td>
		</tr>
	</tbody>
</table>


<div style="width: 98%;">
	<table id="projectCostGrid"></table>
</div>

<script type="text/javascript">

	var gridProjectCost = $("#projectCostGrid"),
    arrtSetting = function (rowId, val, rowObject, cm) {
        var attr = rowObject.attr[cm.name], result;
        
        if (attr.rowspan) {
            result = ' rowspan=' + '"' + attr.rowspan + '"';
        } else if (attr.display) {
            result = ' style="display:' + attr.display + '"';
        }
        return result;
    },
	projectCost = {
    	init : function(){
			this.bindEvent();
    	},
    	data : null,
    	bindEvent : function(){
    		
    		$("#pcProjectTypeID").on("change", function(){
				var options = "<option value=''>Choose</option>";
    			if($(this).val() !== ''){
        			$.ajax({
        				url : "<c:url value='/project' />/" + $(this).val() + "/projectType",
        				dataType : "json",
        				success : function(response){
    						var length = response.length;
    						for(var i=0; i < length; i++){
    							options += "<option value='"+response[i].projectID+"'>"+response[i].projectName+"</option>";
    						}
    						$("#pcProjectID").html(options);
        				}
        			});
    			}else{
    				$("#pcProjectID").html(options);
    			}
    		});
    		
    		$("#pcProjectID").on("change", function(){
    			if($(this).val() !== ''){
    				$.ajax({
    					url : "<c:url value='/project' />/" + $(this).val() + "/view",
    					dataType : "json",
        				success : function(response){

        					var startDate = new Date(response.startDate),
        						endDate =  new Date(response.endDate);
        					
							$("#pcPM").text(response.pmName[0].employeeName);
							$("#pcProjectPeriod").text(startDate.toString(Yuga.config.format.date) + " - " + endDate.toString(Yuga.config.format.date));
							projectCost.viewReport();
        				}
    				});
    			}
    		});
    		
    		$("#pcRevenueRecog, #pcCurrency").on("change", function(){
    			projectCost.changeRecog();
    		});
    		
    	},
    	viewReport : function(){
    		
    		$.ajax({
    			url : "<c:url value='/report' />/" + $("#pcProjectID").val() + "/projectCost",
    			dataType : "json",
    			success : function(response){
    				projectCost.data = response;
        			projectCost.changeRecog();
    			}
    		});
    	},
    	changeRecog : function(){
    		
    		var recog = $("#pcRevenueRecog").val();
    		
			if(projectCost.data != null){
				var option = {
		                datatype: 'local',
		                colNames: ['', '', 'SUM'],
		                colModel: [
		                    { name: 'divider',  width: 90, align: 'center', cellattr: arrtSetting, frozen: true},
		                    { name: 'level', width: 180, align: 'right', frozen: true},
		                    { name: 'sum', width: 90, align : "right", frozen: true}
		                ],
		                cmTemplate: {sortable: false},
		                height: '100%',
		        		rowNum: 9999 ,
			            autowidth : true,
			            shrinkToFit: false,
		        		beforeSelectRow : function(rowId, event){
		        			return false;
		        		}
			        },
			        data = [];
				
				$.each(projectCost.data.monthyears, function(index, value){
					var name = "M" + (index+1) + " (" + value.mmyy + ")";
					option.colNames.push(name);
					option.colModel.push({name: "M" + (index+1), width: 90, align : "right" });
				});
				
				// Actual Data
				var sumActualMM 		= { attr: {divider: {display: "none;"}}, divider: "Actual", level : "SUM", sum : 0};
				var actualDevCost 		= { attr: {divider: {display: "none;"}}, divider: "Actual", level : "Int. Dev. Cost", sum : 0};
				var actualOutsourcing 	= { attr: {divider: {display: "none;"}}, divider: "Actual", level : "Outsourcing", sum : 0};
				var actualExpense 		= { attr: {divider: {display: "none;"}}, divider: "Actual", level : "Expense", sum : 0};
				var actualTotal 		= { attr: {divider: {display: "none;"}}, divider: "Actual", level : "Total", sum : 0};
				
				$.each(projectCost.data.employeeLevels, function(index, value){
					var subdata = {}, sum = 0;
					if(index == 0){
						var rowspan = projectCost.data.employeeLevels.length + 5;
						subdata = { attr: {divider: {rowspan: rowspan}}, divider: "Actual", level : value.title, sum : 0};
						
						
					}else{
						subdata = { attr: {divider: {display: "none;"}}, divider: "Actual", level : value.title, sum : 0};
					}

					$.each(projectCost.data.monthyears, function(i, monthyear){
						var key = 'M' + (i +1);
						if(recog === "Proportional"){
							subdata[key] = projectCost.getLaborMM(projectCost.data.proportionalLevelCosts, monthyear.mmyy, value.empLevelID); 
						}else if(recog == "Accrual"){
							subdata[key] = projectCost.getLaborMM(projectCost.data.accrualLevelCosts, monthyear.mmyy, value.empLevelID);
						}
						sum += parseFloat(subdata[key]);
						if(index == 0){
							sumActualMM[key] = parseFloat(subdata[key]);
							if($("#pcCurrency").val() == "KRW"){
								actualDevCost[key] = parseFloat(subdata[key]) * value.devCostKRW;
							}else if($("#pcCurrency").val() == "USD"){
								actualDevCost[key] = parseFloat(subdata[key]) * value.devCostUS;
							}
						}else{
							sumActualMM[key] += parseFloat(subdata[key]);
							if($("#pcCurrency").val() == "KRW"){
								actualDevCost[key] += parseFloat(subdata[key]) * value.devCostKRW;
							}else if($("#pcCurrency").val() == "USD"){
								actualDevCost[key] += parseFloat(subdata[key]) * value.devCostUS;
							}
							actualDevCost.sum += actualDevCost[key];
						}
						
    				});
					sumActualMM.sum += sum;
					subdata.sum = (sum).toFixed(2);
					data.push(subdata);
				});

				sumActualMM.sum 			= sumActualMM.sum.toFixed(2);
				actualDevCost.sum 			= actualDevCost.sum.toFixed(2);
				var proportionalOutsourcing = projectCost.data.project.vendorOutSourcing / projectCost.data.monthyears.length;
				var proportionalExpense 	= projectCost.data.project.expenseProject / projectCost.data.monthyears.length;

				$.each(projectCost.data.monthyears, function(i, monthyear){
					
					var key = 'M' + (i +1);
					actualDevCost[key] = actualDevCost[key].toFixed(2);
					sumActualMM[key] = sumActualMM[key].toFixed(2);
					actualTotal[key] = actualDevCost[key];
					if(recog == "Proportional"){
						if(projectCost.isMonthBigger(new Date(), new Date(monthyear.year, monthyear.month-1, 1))){
							proportionalOutsourcing = proportionalExpense = 0;
						}
						actualOutsourcing[key] 	= proportionalOutsourcing.toFixed(2);
						actualExpense[key] 		= proportionalExpense.toFixed(2);
						actualTotal[key] 		= (proportionalOutsourcing + proportionalExpense + parseFloat(actualDevCost[key])).toFixed(2);
						actualOutsourcing.sum 	+= proportionalOutsourcing;
						actualExpense.sum 		+= proportionalExpense;
					}else{
						actualOutsourcing[key] 	= "0.00";
						actualExpense[key] 		= "0.00";
					}
				});
				

				if(recog == "Accrual"){
					$.each(projectCost.data.budgetActuals, function(i, budgetActual){
						var key 				= 'M' + budgetActual.mm;
							actualOutsourcing[key] 	= budgetActual.outsourcingExpense.toFixed(2);
							actualExpense[key] 		= budgetActual.projectExpense.toFixed(2);
							actualTotal[key] 		= (budgetActual.outsourcingExpense + budgetActual.projectExpense + parseFloat(actualDevCost[key])).toFixed(2);
							actualOutsourcing.sum 	+= budgetActual.outsourcingExpense;
							actualExpense.sum 		+= budgetActual.projectExpense;
					});	
				}
				
				actualOutsourcing.sum 	= actualOutsourcing.sum.toFixed(2);
				actualExpense.sum 		= actualExpense.sum.toFixed(2);
				actualTotal.sum 		= (parseFloat(actualOutsourcing.sum) + parseFloat(actualExpense.sum) + parseFloat(actualDevCost.sum)).toFixed(2);

				data.push(sumActualMM);
				data.push(actualDevCost);
				data.push(actualOutsourcing);
				data.push(actualExpense);
				data.push(actualTotal);
				
				// Plan Data
				var sumPlanMM 		= { attr: {divider: {display: "none;"}}, divider: "Plan", level : "SUM", sum : 0};
				var planDevCost 	= { attr: {divider: {display: "none;"}}, divider: "Plan", level : "Int. Dev. Cost", sum : 0};
				var planOutsourcing = { attr: {divider: {display: "none;"}}, divider: "Plan", level : "Outsourcing", sum : 0};
				var planExpense 	= { attr: {divider: {display: "none;"}}, divider: "Plan", level : "Expense", sum : 0};
				var planTotal 		= { attr: {divider: {display: "none;"}}, divider: "Plan", level : "Total", sum : 0};
				
				$.each(projectCost.data.employeeLevels, function(index, value){
					var subdata = {}, sum = 0;
					if(index == 0){
						var rowspan = projectCost.data.employeeLevels.length + 5;
						subdata = { attr: {divider: {rowspan: rowspan}}, divider: "Plan", level : value.title, sum : 0};
						
					}else{
						subdata = { attr: {divider: {display: "none;"}}, divider: "Plan", level : value.title, sum : 0};
					}

					$.each(projectCost.data.monthyears, function(i, monthyear){
						var key 		= 'M' + (i +1);
						subdata[key] 	= projectCost.getPlanMM(projectCost.data.planCosts, monthyear.mmyy, value.empLevelID);
						sum 			+= parseFloat(subdata[key]);
						
						if(index == 0){
							sumPlanMM[key] = parseFloat(subdata[key]);
							if($("#pcCurrency").val() == "KRW"){
								planDevCost[key] = parseFloat(subdata[key]) * value.devCostKRW;
							}else if($("#pcCurrency").val() == "USD"){
								planDevCost[key] = parseFloat(subdata[key]) * value.devCostUS;
							}
						}else{
							sumPlanMM[key] += parseFloat(subdata[key]);
							if($("#pcCurrency").val() == "KRW"){
								planDevCost[key] += parseFloat(subdata[key]) * value.devCostKRW;
							}else if($("#pcCurrency").val() == "USD"){
								planDevCost[key] += parseFloat(subdata[key]) * value.devCostUS;
							}
							planDevCost.sum += planDevCost[key];
						}
					});
					subdata.sum = sum.toFixed(2);
					sumPlanMM.sum += sum;
					data.push(subdata);
				});


				$.each(projectCost.data.monthyears, function(i, monthyear){
					
					var key 			= 'M' + (i +1);
					planDevCost[key] 	= planDevCost[key].toFixed(2);
					sumPlanMM[key] 		= sumPlanMM[key].toFixed(2);
					planTotal[key] 		= planDevCost[key];
					planOutsourcing[key]= "0.00";
					planExpense[key] 	= "0.00";
					
				});
				
				planOutsourcing.sum = projectCost.data.project.vendorOutSourcing;
				planExpense.sum 	= projectCost.data.project.expenseProject;
				planTotal.sum 		= projectCost.data.project.vendorOutSourcing + projectCost.data.project.expenseProject + planDevCost.sum;
				
				sumPlanMM.sum 		= sumPlanMM.sum.toFixed(2);
				planDevCost.sum 	= planDevCost.sum.toFixed(2);
				planOutsourcing.sum = planOutsourcing.sum.toFixed(2);
				planExpense.sum 	= planExpense.sum.toFixed(2);
				planTotal.sum 		= planTotal.sum.toFixed(2);

				data.push(sumPlanMM);
				data.push(planDevCost);
				data.push(planOutsourcing);
				data.push(planExpense);
				data.push(planTotal); 

				//GAP
				var gapMM = { attr: {divider: {rowspan: 2}}, divider: "Gap", level : "MM Gap", sum : 0};
				var gapAmount = { attr: {divider: {display: "none"}}, divider: "Gap", level : "Amount Gap", sum : 0};

				$.each(projectCost.data.monthyears, function(i, monthyear){
					var key = 'M' + (i +1);
					gapMM[key] = (parseFloat(sumActualMM[key]) - parseFloat(sumPlanMM[key])).toFixed(2);
					gapAmount[key] = (parseFloat(planTotal[key]) - parseFloat(actualTotal[key])).toFixed(2);
				});

				gapMM.sum = (sumPlanMM.sum- sumActualMM.sum).toFixed(2);
				gapAmount.sum = (planTotal.sum - actualTotal.sum).toFixed(2);
				
				data.push(gapMM);
				data.push(gapAmount);
				
				$("#gbox_"+gridProjectCost.attr("id"))
					.removeAttr("class")
					.removeAttr("style")
					.removeAttr("dir")
					.replaceWith($('<table id="'+gridProjectCost.attr("id")+'"/>'));
				gridProjectCost.GridDestroy();
				$("#"+gridProjectCost.attr("id"))
					.jqGrid(option)
					.jqGrid('setGridParam',{data:data, colModel: option.colModel, colNames: option.colNames})
					.jqGrid('setFrozenColumns')
		        	.trigger('reloadGrid');
			}
    	},
    	getLaborMM : function(levelCosts, mmyy, empLevelID){
    		for(var i = 0; i< levelCosts.length; i++){
    			if(levelCosts[i]['empLevelID'] != undefined &&
   					levelCosts[i]['empLevelID'].trim() == empLevelID.trim() &&
   					levelCosts[i]['mmyy'].trim() == mmyy.trim()){
    				return levelCosts[i].laborMM.toFixed(2);
    			}
    		}
    		return "0.00";
    	},
    	getPlanMM : function(planCosts, mmyy, empLevelID){
    		for(var i = 0; i< planCosts.length; i++){
    			
    			if(planCosts[i]['empLevelID'] != undefined && 
					planCosts[i]['empLevelID'].trim() == empLevelID.trim() &&
					planCosts[i]['mmyy'].trim() == mmyy.trim()){
    				return parseFloat(planCosts[i].plannedMM).toFixed(2);
    			}
    		}
    		return "0.00";
    	},
    	isMonthBigger: function(date1, date2){
    		
    		date1.moveToLastDayOfMonth().setHours(0, 0, 0, 0);
    		date2.moveToLastDayOfMonth().setHours(0, 0, 0, 0);
    		return date1.getTime() < date2.getTime();
    	}
    };
    
    $(document).ready(function(){
		projectCost.init();
    });
    $(window).load(function(){
    	$("#pcProjectTypeID").val("");
    });
    
</script>