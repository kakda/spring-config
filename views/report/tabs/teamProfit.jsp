<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="format"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>


<table class="table table-noborder">
	<colgroup>
		<col style="width: 50px;">
		<col />
		<col style="width: 60px;">
		<col />
		<col style="width: 130px;">
		<col />
		<col style="width: 70px;">
		<col />
	</colgroup>
	<tbody>
		<tr>
			<th><label for="tpOrganization">Team:</label></th>
			<td>
				<input type="hidden" name="tpOrgID" id="tpOrgID"/>
				<input type="text" id="tpOrganization" readonly="readonly" class="text popup" />
			</td>
			<th><label for="tpYear">Year:</label></th>
			<td>
				<select class="select" id="tpYear">
					<option>2013</option>
					<option>2014</option>
					<option>2015</option>
					<option>2016</option>
					<option>2017</option>
					<option>2018</option>
					<option>2019</option>
					<option>2020</option>
				</select>
			</td>
			<th><label for="tpRevenueRecog">Revenue Recog:</label></th>
			<td>
				<select class="select" id="tpRevenueRecog">
					<option value="Proportional">Proportional</option>
					<option value="Accrual">Accrual</option>
				</select>
			</td>
			<th><label for="tpCurrency">Currency</label></th>
			<td><select id="tpCurrency" class="select" disabled="disabled" ><option value="KRW" selected="selected">KRW</option><option value="USD" >USD</option></select></td>
		</tr>
	</tbody>
</table>
<div id="treeDialog">
	<input type="text" id="tpSearch" class="text search" placeholder="Enter something to search ..." />
	<div id="orgTree"></div>
</div>
<div style="width: 98%;">
	<table id="teamProfitGrid"></table>
</div>

<script type="text/javascript">

	var teamProfit = {
		data : null,
		grid : $("#teamProfitGrid"),		
		init : function(){
			
			teamProfit.initTree();
			teamProfit.dialog();
			teamProfit.bindEvent();
		},
		
		initTree : function(){
			$('#orgTree').jstree({
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
				  "contextmenu", "search", "state", "types", "wholerow", "dnd"
				],
				dnd : {
					copy : false
				}
			});
		},
		
		bindEvent : function(){
			
			$("#tpSearch").on("keyup", teamProfit.search);
			$('#tpOrganization').click(function(){
				$('#treeDialog').dialog("open");
			});
			
			
			$('#orgTree').bind("dblclick.jstree", function (e) {
				 var tree = $.jstree.reference('#orgTree');
				 var selectedNodes = tree.get_selected();
				 var node = tree.get_node(selectedNodes[0]);
			  	 $("#tpOrganization").val(node.text);
			  	 $("#tpOrgID").val(node.id);
				 $('#treeDialog').dialog("close");
				 teamProfit.viewReport();
			});
			
			$("#tpYear").on("change", function(){
				teamProfit.viewReport();
			});

    		$("#tpRevenueRecog, #tpCurrency").on("change", function(){
    			teamProfit.changeRecog();
    		});
		},
		
		dialog : function(){
			$('#treeDialog').dialog({
				modal: true,
				autoOpen: false
			});
		},

		search : function(){
		    $.jstree.reference($('#orgTree')).search($('#tpSearch').val());
		},
		
		viewReport : function(){
			if($("#tpOrgID").val() == "" || $("#tpYear").val() == ""){
				return;
			}
			$.ajax({
    			url : "<c:url value='/report' />/" + $("#tpOrgID").val() + "/" + $("#tpYear").val() + "/teamProfit",
    			dataType : "json",
    			success : function(response){
    				teamProfit.data = response;
    				teamProfit.changeRecog();
   				}
			});
		},

		changeRecog : function(){

    		var recog = $("#tpRevenueRecog").val();
    		
    		if(teamProfit.data != null){
    			
    			var option = {
		                datatype: 'local',
		                colNames: ['', '', 'SUM'],
		                colModel: [
		                    { name: 'divider', width: 90, align: 'center', cellattr: arrtSetting, frozen: true},
		                    { name: 'level', width: 180, align: 'right', frozen: true},
		                    { name: 'sum', width: 90, align : "right", frozen: true}
		                ],
		                cmTemplate: {sortable: false},
		                height: '100%',
		        		rowNum: 9999,
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
					headers = projectProfit.sortMM(teamProfit.data[0]);

    			var DEF = {
    				SERVICE : "Service",
    				LICENSE : "License",
    				THIRD_PARTY: "3rd Party",
    				INTERNAL_RD_REVENUE : "Internal R&D Revenue",
    				TEAM_INTERNAL_COST : "Team Internal Cost",
    				INTERNAL_OUTSOURCING : "Internal Outsourcing",
    				OUTSOURCING : "Outsourcing",
    				SALES_OPEX : "Sales OPEX",
    				PROJECT_EXPENSE : "Project Expense",
    				REVENUE : "Revenue",
    				COST : "Cost",
    				TEAM_PROFIT_LOSS : "Team Profit/Loss",
    				ACCUMULATED_PL : "Accumulated P/L",

    				NET_PROFIT : "Net Profit",
    				ACCUMULATED_PROFIT : "Accumulated Profit",
    				
    				MONTHLY_GAP : "Monthly Gap",
    				ACCUMULATED_GAP : "Cost Gap"
    			};

   				plan 							= teamProfit.filterGroupData("Plan", DEF);
				actual 							= teamProfit.filterGroupData(recog, DEF);
				
				console.log(actual)
				
				plan[DEF.REVENUE] 				= projectProfit.getSummary([plan[DEF.SERVICE], plan[DEF.LICENSE], plan[DEF.THIRD_PARTY]], plan[DEF.INTERNAL_RD_REVENUE]);
				plan[DEF.COST] 					= projectProfit.getSummary([plan[DEF.TEAM_INTERNAL_COST], plan[DEF.INTERNAL_OUTSOURCING], plan[DEF.OUTSOURCING], plan[DEF.SALES_OPEX], plan[DEF.PROJECT_EXPENSE]]);
				plan[DEF.TEAM_PROFIT_LOSS] 		= projectProfit.getDataDiff(plan[DEF.REVENUE], plan[DEF.COST]);
				
				actual[DEF.REVENUE] 			= projectProfit.getSummary([actual[DEF.SERVICE], actual[DEF.LICENSE], actual[DEF.THIRD_PARTY]], actual[DEF.INTERNAL_RD_REVENUE]);
				actual[DEF.COST] 				= projectProfit.getSummary([actual[DEF.TEAM_INTERNAL_COST], actual[DEF.INTERNAL_OUTSOURCING], actual[DEF.OUTSOURCING], actual[DEF.SALES_OPEX], actual[DEF.PROJECT_EXPENSE]]);
				actual[DEF.TEAM_PROFIT_LOSS] 	= projectProfit.getDataDiff(actual[DEF.REVENUE], actual[DEF.COST]);

   				$.each(headers, function(index, value){
   					if(value[1] != 'label' && value[1] != 'group'){
						var name = "M" + (++colCount) + " (" + value[1] + ")"; 
   						option.colNames.push(name);
   						option.colModel.push({name: name, width: 90, align : "right" });
   					}
   				});

   				var actualRevenue 				= { attr: {divider: {rowspan: 13}}, 	divider: "Actual", level : DEF.REVENUE, sum : 0};
   				var actualService 				= { attr: {divider: {display: "none"}}, divider: "Actual", level : DEF.SERVICE, sum : 0};
   				var actualLicense 				= { attr: {divider: {display: "none"}}, divider: "Actual", level : DEF.LICENSE, sum : 0};
   				var actualThirdParty 			= { attr: {divider: {display: "none"}}, divider: "Actual", level : DEF.THIRD_PARTY, sum : 0};
   				var actualInternalRDRevenue 	= { attr: {divider: {display: "none"}}, divider: "Actual", level : DEF.INTERNAL_RD_REVENUE, sum : 0};
   				var actualCost 					= { attr: {divider: {display: "none"}}, divider: "Actual", level : DEF.COST, sum : 0};
   				var actualTeamInternalCost 		= { attr: {divider: {display: "none"}}, divider: "Actual", level : DEF.TEAM_INTERNAL_COST, sum : 0};
   				var actualInternalOutsourcing 	= { attr: {divider: {display: "none"}}, divider: "Actual", level : DEF.INTERNAL_OUTSOURCING, sum : 0};
   				var actualOutsourcing 			= { attr: {divider: {display: "none"}}, divider: "Actual", level : DEF.OUTSOURCING, sum : 0};
   				var actualSalesOpex 			= { attr: {divider: {display: "none"}}, divider: "Actual", level : DEF.SALES_OPEX, sum : 0};
   				var actualProjectExpense 		= { attr: {divider: {display: "none"}}, divider: "Actual", level : DEF.PROJECT_EXPENSE, sum : 0};
   				var actualTeamProfitLoss 		= { attr: {divider: {display: "none"}}, divider: "Actual", level : DEF.TEAM_PROFIT_LOSS, sum : 0};
   				var actualAccumulated 			= { attr: {divider: {display: "none"}}, divider: "Actual", level : DEF.ACCUMULATED_PL, sum : 0};
   				
   				$.extend(true, actualRevenue, 				projectProfit.fetchMM(actual[DEF.REVENUE], 					actualRevenue));
   				$.extend(true, actualService, 				projectProfit.fetchMM(actual[DEF.SERVICE], 					actualService));
   				$.extend(true, actualLicense, 				projectProfit.fetchMM(actual[DEF.LICENSE], 					actualLicense));
   				$.extend(true, actualThirdParty, 			projectProfit.fetchMM(actual[DEF.THIRD_PARTY], 				actualThirdParty));
   				$.extend(true, actualInternalRDRevenue, 	projectProfit.fetchMM(actual[DEF.INTERNAL_RD_REVENUE], 		actualInternalRDRevenue));
   				$.extend(true, actualCost, 					projectProfit.fetchMM(actual[DEF.COST], 					actualCost));
   				$.extend(true, actualTeamInternalCost, 		projectProfit.fetchMM(actual[DEF.TEAM_INTERNAL_COST], 		actualTeamInternalCost));
   				$.extend(true, actualInternalOutsourcing, 	projectProfit.fetchMM(actual[DEF.INTERNAL_OUTSOURCING], 	actualInternalOutsourcing));
   				$.extend(true, actualOutsourcing, 			projectProfit.fetchMM(actual[DEF.OUTSOURCING], 				actualOutsourcing));
   				$.extend(true, actualSalesOpex, 			projectProfit.fetchMM(actual[DEF.SALES_OPEX], 				actualSalesOpex));
   				$.extend(true, actualProjectExpense, 		projectProfit.fetchMM(actual[DEF.PROJECT_EXPENSE], 			actualProjectExpense));
   				$.extend(true, actualTeamProfitLoss, 		projectProfit.fetchMM(actual[DEF.TEAM_PROFIT_LOSS], 		actualTeamProfitLoss));
   				$.extend(true, actualAccumulated, 			teamProfit.fetchAccumulated(actual[DEF.TEAM_PROFIT_LOSS],	actualAccumulated));
   				
   				data.push(actualRevenue);
   				data.push(actualService);
   				data.push(actualLicense);
   				data.push(actualThirdParty);
   				data.push(actualInternalRDRevenue);
   				data.push(actualCost);
   				data.push(actualTeamInternalCost);
   				data.push(actualInternalOutsourcing);
   				data.push(actualOutsourcing);
   				data.push(actualSalesOpex);
   				data.push(actualProjectExpense);
   				data.push(actualTeamProfitLoss);
   				data.push(actualAccumulated);

   				$("#gbox_"+teamProfit.grid.attr("id"))
   					.removeAttr("class")
   					.removeAttr("style")
   					.removeAttr("dir")
   					.replaceWith($('<table id="'+teamProfit.grid.attr("id")+'"/>'));
   				teamProfit.grid.GridDestroy();
   				$("#"+teamProfit.grid.attr("id"))
   					.jqGrid(option)
   					.jqGrid('setGridParam',{data:data, colModel: option.colModel, colNames: option.colNames})
					.jqGrid('setFrozenColumns')
   		        	.trigger('reloadGrid');
    		}
		},

		filterSingleData : function(group, label){
			var object = {};
			$.each(teamProfit.data, function(index, value){
				if(group == "Accrual" && label == "3rd Party"){
					console.log(value);
					console.log(label + " - " + value['label'] + ": " + (value['label'] == label));
					console.log(group + " - " + value['group'] + ": " + (value['group'] == group));	
				}
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
				array[value] = teamProfit.filterSingleData(group, value);
			});
			return array;
		},
		
		fetchAccumulated : function(data, base){

			var colCount = 0;
			var sortData = projectProfit.sortMM(data);
			var accumulateValue = 0;
			$.each(sortData, function(index, value){
				if(value[1] != 'label' && value[1] != 'group'){
   					var name = "M" + (++colCount) + " (" + value[1] + ")"; 
   					if(!value[2]){
						value[2] = 0;
					}
   					accumulateValue += value[2];
   					base[name] = accumulateValue.toFixed(2);
				}
			});
			return base;
		}
	};
	
	$(document).ready(function(){
		teamProfit.init();
	});
	
	$(window).load(function(){
		$("#tpOrgID").val("");
		$("#tpOrganization").val("");
	});
	
</script>





