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
			<th><label for="ppProjectTypeID">Project Type:</label></th>
			<td><select class="select" id="ppProjectTypeID">
					<option value="">Choose</option>
					<c:forEach items="${projectTypes}" var="projectType">
						<option value="${projectType.projectTypeID}">${projectType.title}</option>
					</c:forEach>
			</select></td>
			<th><label for="ppProjectID">Project Name:</label></th>
			<td><select class="select" id="ppProjectID">
					<option>Choose</option>
			</select></td>
			<th><label for="ppRevenueRecog">Revenue Recog:</label></th>
			<td><select class="select" id="ppRevenueRecog">
					<option value="Proportional">Proportional</option>
					<option value="Accrual">Accrual</option>
			</select></td>
		</tr>
		<tr>
			<th><label for="ppPM">Project Manager</label></th>
			<td><span id="ppPM"></span></td>
			<th><label for="ppProjectPeriod">Project Period</label></th>
			<td><span id="ppProjectPeriod"></span></td>
			<th><label for="ppCurrency">Currency</label></th>
			<td><select id="ppCurrency" class="select" disabled="disabled" ><option value="KRW" selected="selected">KRW</option><option value="USD" >USD</option></select></td>
		</tr>
	</tbody>
</table>
<div style="width: 98%;">
	<table id="projectProfitGrid"></table>
</div>

<script type="text/javascript">
	var projectProfit = {
			
		data : null,
		grid : $("#projectProfitGrid"),
		init : function(){
			projectProfit.bindEvent();
		},
		
		bindEvent : function(){
			
			$("#ppProjectTypeID").on("change", function(){
				
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
    						$("#ppProjectID").html(options);
        				}
        			});
    			}else{
    				$("#ppProjectID").html(options);
    			}
			});				

    		$("#ppProjectID").on("change", function(){
    			if($(this).val() !== ''){
    				$.ajax({
    					url : "<c:url value='/project' />/" + $(this).val() + "/view",
    					dataType : "json",
        				success : function(response){

        					var startDate = new Date(response.startDate),
        						endDate =  new Date(response.endDate);
        					
							$("#ppPM").text(response.pmName[0].employeeName);
							$("#ppProjectPeriod").text(startDate.toString(Yuga.config.format.date) + " - " + endDate.toString(Yuga.config.format.date));
							projectProfit.viewReport();
        				}
    				});
    			}
    		});
    		
    		$("#ppRevenueRecog, #ppCurrency").on("change", function(){
    			projectProfit.changeRecog();
    		});
		},
		
		viewReport : function(){
			$.ajax({
    			url : "<c:url value='/report' />/" + $("#ppProjectID").val() + "/projectProfit",
    			dataType : "json",
    			success : function(response){
    				projectProfit.data = response;
    				projectProfit.changeRecog();
   				}
			});
		},
		
		changeRecog : function(){

    		var recog = $("#ppRevenueRecog").val();
    		
    		if(projectProfit.data != null){
    			
    			var option = {
		                datatype: 'local',
		                colNames: ['', '', 'SUM'],
		                colModel: [
		                    { name: 'divider',  width: 90, align: 'center', cellattr: arrtSetting, frozen: true },
		                    { name: 'level', width: 180, align: 'right', frozen: true },
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
			        data = [],
			        colCount = 0,
			        actual = {},
			        plan = {},
			        gap = {},
					headers = projectProfit.sortMM(projectProfit.data[0]);
    			
    			var DEF = {
    				SERVICE : "Service",
    				LICENSE : "License",
    				THIRD_PARTY: "3rd Party",
    				TEAM_DEV_COST : "Team Dev. Cost",
    				INTERNAL_OUTSOURCING : "Internal Outsourcing",
    				OUTSOURCING : "Outsourcing",
    				SALES_OPEX : "Sales OPEX",
    				PROJECT_EXPENSE : "Project Expense",
    				REVENUE : "Revenue",
    				COST : "Cost",
    				PROJECT_PROFIT_LOSS : "Project Profit/Loss",
    				
    				REVENUE_GAP : "Revenue Gap",
    				COST_GAP : "Cost Gap",
    				PROFIT_GAP : "Profit Gap"
    			};
				
   				plan 							= projectProfit.filterGroupData("Plan", DEF);
				actual 							= projectProfit.filterGroupData(recog, DEF);
				
   				plan[DEF.REVENUE] 				= projectProfit.getSummary([plan[DEF.SERVICE], plan[DEF.LICENSE], plan[DEF.THIRD_PARTY]]);
				plan[DEF.COST] 					= projectProfit.getSummary([plan[DEF.TEAM_DEV_COST], plan[DEF.INTERNAL_OUTSOURCING], plan[DEF.OUTSOURCING], plan[DEF.SALES_OPEX], plan[DEF.PROJECT_EXPENSE]]);
				plan[DEF.PROJECT_PROFIT_LOSS] 	= projectProfit.getDataDiff(plan[DEF.REVENUE], plan[DEF.COST]);
				
				actual[DEF.REVENUE] 			= projectProfit.getSummary([actual[DEF.SERVICE], actual[DEF.LICENSE], actual[DEF.THIRD_PARTY]]);
				actual[DEF.COST] 				= projectProfit.getSummary([actual[DEF.TEAM_DEV_COST], actual[DEF.INTERNAL_OUTSOURCING], actual[DEF.OUTSOURCING], actual[DEF.SALES_OPEX], actual[DEF.PROJECT_EXPENSE]]);
				actual[DEF.PROJECT_PROFIT_LOSS] = projectProfit.getDataDiff(actual[DEF.REVENUE], actual[DEF.COST]);
				
				gap[DEF.REVENUE_GAP]			= projectProfit.getDataDiff(plan[DEF.REVENUE], actual[DEF.REVENUE]);
				gap[DEF.COST_GAP]				= projectProfit.getDataDiff(plan[DEF.COST], actual[DEF.COST]);
				gap[DEF.PROFIT_GAP]				= projectProfit.getDataDiff(plan[DEF.PROJECT_PROFIT_LOSS], actual[DEF.PROJECT_PROFIT_LOSS]);

   				$.each(headers, function(index, value){
   					if(value[1] != 'label' && value[1] != 'group'){
						var name = "M" + (++colCount) + " (" + value[1] + ")"; 
   						option.colNames.push(name);
   						option.colModel.push({name: name, width: 90, align : "right" });
   					}
   				});
   				
   				var actualRevenue 				= { attr: {divider: {rowspan: 11}}, 	divider: "Actual", level : DEF.REVENUE, sum : 0};
   				var actualService 				= { attr: {divider: {display: "none"}}, divider: "Actual", level : DEF.SERVICE, sum : 0};
   				var actualLicense 				= { attr: {divider: {display: "none"}}, divider: "Actual", level : DEF.LICENSE, sum : 0};
   				var actualThirdParty 			= { attr: {divider: {display: "none"}}, divider: "Actual", level : DEF.THIRD_PARTY, sum : 0};
   				var actualCost 					= { attr: {divider: {display: "none"}}, divider: "Actual", level : DEF.COST, sum : 0};
   				var actualTeamDevCost 			= { attr: {divider: {display: "none"}}, divider: "Actual", level : DEF.TEAM_DEV_COST, sum : 0};
   				var actualInternalOutsourcing 	= { attr: {divider: {display: "none"}}, divider: "Actual", level : DEF.INTERNAL_OUTSOURCING, sum : 0};
   				var actualOutsourcing 			= { attr: {divider: {display: "none"}}, divider: "Actual", level : DEF.OUTSOURCING, sum : 0};
   				var actualSalesOpex 			= { attr: {divider: {display: "none"}}, divider: "Actual", level : DEF.SALES_OPEX, sum : 0};
   				var actualProjectExpense 		= { attr: {divider: {display: "none"}}, divider: "Actual", level : DEF.PROJECT_EXPENSE, sum : 0};
   				var actualProjectProfitLost 	= { attr: {divider: {display: "none"}}, divider: "Actual", level : DEF.PROJECT_PROFIT_LOSS, sum : 0};
   				
   				var planRevenue 				= { attr: {divider: {rowspan: 11}}, 	divider: "Plan", level : DEF.REVENUE, sum : 0};
   				var planService 				= { attr: {divider: {display: "none"}}, divider: "Plan", level : DEF.SERVICE, sum : 0};
   				var planLicense 				= { attr: {divider: {display: "none"}}, divider: "Plan", level : DEF.LICENSE, sum : 0};
   				var planThirdParty 				= { attr: {divider: {display: "none"}}, divider: "Plan", level : DEF.THIRD_PARTY, sum : 0};
   				var planCost 					= { attr: {divider: {display: "none"}}, divider: "Plan", level : DEF.COST, sum : 0};
   				var planTeamDevCost 			= { attr: {divider: {display: "none"}}, divider: "Plan", level : DEF.TEAM_DEV_COST, sum : 0};
   				var planInternalOutsourcing 	= { attr: {divider: {display: "none"}}, divider: "Plan", level : DEF.INTERNAL_OUTSOURCING, sum : 0};
   				var planOutsourcing 			= { attr: {divider: {display: "none"}}, divider: "Plan", level : DEF.OUTSOURCING, sum : 0};
   				var planSalesOpex 				= { attr: {divider: {display: "none"}}, divider: "Plan", level : DEF.SALES_OPEX, sum : 0};
   				var planProjectExpense 			= { attr: {divider: {display: "none"}}, divider: "Plan", level : DEF.PROJECT_EXPENSE, sum : 0};
   				var planProjectProfitLost 		= { attr: {divider: {display: "none"}}, divider: "Plan", level : DEF.PROJECT_PROFIT_LOSS, sum : 0};
   				
   				var gapRevenue					= { attr: {divider: {rowspan: 3}}, 	divider: "Gap", level : DEF.REVENUE_GAP, sum : 0};
   				var gapCost 					= { attr: {divider: {display: "none"}}, divider: "Gap", level : DEF.COST_GAP, sum : 0};
   				var gapProfit 					= { attr: {divider: {display: "none"}}, divider: "Gap", level : DEF.PROFIT_GAP, sum : 0};
   				
   				$.extend(true, actualRevenue, 				projectProfit.fetchMM(actual[DEF.REVENUE], 		actualRevenue));
   				$.extend(true, actualService,				projectProfit.fetchMM(actual[DEF.SERVICE], 		actualService));
   				$.extend(true, actualLicense, 				projectProfit.fetchMM(actual[DEF.LICENSE], 		actualLicense));
   				$.extend(true, actualThirdParty, 			projectProfit.fetchMM(actual[DEF.THIRD_PARTY], 	actualThirdParty));
   				$.extend(true, actualCost, 					projectProfit.fetchMM(actual[DEF.COST], 		actualCost));
   				$.extend(true, actualTeamDevCost, 			projectProfit.fetchMM(actual[DEF.TEAM_DEV_COST],actualTeamDevCost));
   				$.extend(true, actualInternalOutsourcing, 	projectProfit.fetchMM(actual[DEF.INTERNAL_OUTSOURCING], actualInternalOutsourcing));
   				$.extend(true, actualOutsourcing, 			projectProfit.fetchMM(actual[DEF.OUTSOURCING], 	actualOutsourcing));
   				$.extend(true, actualSalesOpex, 			projectProfit.fetchMM(actual[DEF.SALES_OPEX], 	actualSalesOpex));
   				$.extend(true, actualProjectExpense,		projectProfit.fetchMM(actual[DEF.PROJECT_EXPENSE], actualProjectExpense));
   				$.extend(true, actualProjectProfitLost, 	projectProfit.fetchMM(actual[DEF.PROJECT_PROFIT_LOSS], actualProjectProfitLost));
   				
   				$.extend(true, planRevenue, 				projectProfit.fetchMM(plan[DEF.REVENUE], 		planRevenue));
   				$.extend(true, planService,					projectProfit.fetchMM(plan[DEF.SERVICE], 		planService));
   				$.extend(true, planLicense, 				projectProfit.fetchMM(plan[DEF.LICENSE], 		planLicense));
   				$.extend(true, planThirdParty, 				projectProfit.fetchMM(plan[DEF.THIRD_PARTY], 	planThirdParty));
   				$.extend(true, planCost, 					projectProfit.fetchMM(plan[DEF.COST], 		planCost));
   				$.extend(true, planTeamDevCost, 			projectProfit.fetchMM(plan[DEF.TEAM_DEV_COST],planTeamDevCost));
   				$.extend(true, planInternalOutsourcing, 	projectProfit.fetchMM(plan[DEF.INTERNAL_OUTSOURCING], planInternalOutsourcing));
   				$.extend(true, planOutsourcing, 			projectProfit.fetchMM(plan[DEF.OUTSOURCING], 	planOutsourcing));
   				$.extend(true, planSalesOpex, 				projectProfit.fetchMM(plan[DEF.SALES_OPEX], 	planSalesOpex));
   				$.extend(true, planProjectExpense,			projectProfit.fetchMM(plan[DEF.PROJECT_EXPENSE], planProjectExpense));
   				$.extend(true, planProjectProfitLost, 		projectProfit.fetchMM(plan[DEF.PROJECT_PROFIT_LOSS], planProjectProfitLost));

   				$.extend(true, gapRevenue, 					projectProfit.fetchMM(gap[DEF.REVENUE_GAP], gapRevenue));
   				$.extend(true, gapCost, 					projectProfit.fetchMM(gap[DEF.COST_GAP], gapCost));
   				$.extend(true, gapProfit, 					projectProfit.fetchMM(gap[DEF.PROFIT_GAP], gapProfit));

				data.push(actualRevenue);
				data.push(actualService);
				data.push(actualLicense);
				data.push(actualThirdParty);
				data.push(actualCost);
				data.push(actualTeamDevCost);
				data.push(actualInternalOutsourcing);
				data.push(actualOutsourcing);
				data.push(actualSalesOpex);
				data.push(actualProjectExpense);
				data.push(actualProjectProfitLost);
				
				data.push(planRevenue);
				data.push(planService);
				data.push(planLicense);
				data.push(planThirdParty);
				data.push(planCost);
				data.push(planTeamDevCost);
				data.push(planInternalOutsourcing);
				data.push(planOutsourcing);
				data.push(planSalesOpex);
				data.push(planProjectExpense);
				data.push(planProjectProfitLost);
				
				data.push(gapRevenue);
				data.push(gapCost);
				data.push(gapProfit);
   				
   				$("#gbox_"+projectProfit.grid.attr("id"))
   					.removeAttr("class")
   					.removeAttr("style")
   					.removeAttr("dir")
   					.replaceWith($('<table id="'+projectProfit.grid.attr("id")+'"/>'));
   				projectProfit.grid.GridDestroy();
   				$("#"+projectProfit.grid.attr("id"))
   					.jqGrid(option)
   					.jqGrid('setGridParam',{data:data, colModel: option.colModel, colNames: option.colNames})
					.jqGrid('setFrozenColumns')
   		        	.trigger('reloadGrid');
    		}
		},
		
		sortMM : function(json){
			var sortable = [];
			var clone = $.extend({}, json) ;
			if(clone['group']){
				delete clone['group'];
			}
			if(clone['label']){
				delete clone['label'];
			}
			$.each(clone, function(index, value){
				var arr = index.split("-");
				var mmyy = parseInt(arr[1] + arr[0]);
				sortable.push([mmyy, index, value]);
			});
			sortable.sort(function(previous, after){
			    return previous[0] - after[0];
			}); 
			
			return sortable;
		},

		filterSingleData : function(group, label){
			var object = {};
			$.each(projectProfit.data, function(index, value){
				if(value['label'] == label && value['group'] == group){
					object = value;
					return;
				}
			});
			return object;
		},
		
		filterGroupData : function(group, DEF){
			var array = {};
			$.each(DEF, function(index, value){
				array[value] = projectProfit.filterSingleData(group, value);
			});
			return array;
		},
		
		getSummary : function(array){
			var object = {}; 
			$.each(array, function(){
				$.each(this, function(index, value){
					if(index != 'label' && index != 'group'){
						if(!value){
							value = 0;
						}
						if(object[index] != undefined){
							object[index] = Number(object[index]) + Number(value);
						}else{
							object[index] = value;
						}
					}
				});
			});
			return object;
		},
		
		getDataDiff : function(data1, data2){
			var data3 = {};
			$.each(data1, function(index, value){
				if(index != 'label' && index != 'group'){
					data3[index] = data1[index] - data2[index];
				}
			});
			return data3;
		},
		
		fetchMM : function(data, base){
			var colCount = 0;
			var sortData = projectProfit.sortMM(data);
			$.each(sortData, function(index, value){
				if(value[1] != 'label' && value[1] != 'group'){
   					var name = "M" + (++colCount) + " (" + value[1] + ")"; 
   					if(!value[2]){
						value[2] = 0;
					}
   					base[name] = value[2].toFixed(2);
   					base.sum += value[2];
				}
			});
			base.sum = base.sum.toFixed(2);
			return base;
		}
	};
	
	$(document).ready(function(){
		projectProfit.init();
	});
	
    $(window).load(function(){
    	$("#ppProjectTypeID").val("");
    });
    
</script>
