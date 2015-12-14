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
			<th><label for="year">Year:</label></th>
			<td>
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
			</td>
			<th><label for="organization">Team:</label></th>
			<td>
				<input type="hidden" name="orgID" id="orgID"/>
				<input type="text" id="organization" readonly="readonly" class="text popup" />
			</td>
			<th><label for="revenueRecog">Revenue Recog:</label></th>
			<td>
				<select class="select" id="revenueRecog">
					<option value="proportional">Proportional</option>
					<option value="accrual">Accrual</option>
				</select>
			</td>
			<th><label for="currency">Currency</label></th>
			<td><input type="radio" id="krw" class='currency' name="currency" checked="checked"/><label for="krw">KRW</label><input type="radio" id='usd' class='currency' name='currency'/><label for='usd'> USD</label></td>
		</tr>
	</tbody>
</table>
<div id="treeDialog" class="hide">
	<input type="text" id="search" class="text search" placeholder="Enter something to search ..." />
	<div id="orgTree"></div>
</div>
<div class="budgetExpense ExpenseReport">
	<div class="row-head left rowLeft">
		<table class="table tblBorder">
<!-- 			<tr> -->
<!-- 				<td colspan="2"></td> -->
<!-- 				<th class="alignCenter">Sum</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td rowspan="15">Actual</td> -->
<!-- 				<td class="bgSum alignLeft">Revenue (a)</td> -->
<!-- 				<th class="bgSum">900,000,000</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td class="indent">SI</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td class="indent">License</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td class="indent">3rd Party</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td class="indent">Internal R &amp; D Revenue</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="2" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td class="alignLeft">Cost (a)</td> -->
<!-- 				<th >900,000,000</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td class="indent">Team Internal Cost</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td class="indent">Internal Outsourcing</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td class="indent">Outsourcing</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td class="indent">Sales OPEX</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td class="indent">Project Expense</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="2" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td>Team Profit/Loss (a-b)</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td>Accumulated P/L</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="3" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td rowspan="2">Plan</td> -->
<!-- 				<td class="bgSum">Net Profit by Month</td> -->
<!-- 				<td class="bgSum">0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td class="bgSum">Accumulated Profit</td> -->
<!-- 				<td class="bgSum">0</td> -->
<!-- 			</tr> -->
			
<!-- 			<tr> -->
<!-- 				<td colspan="3" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td rowspan="2">Gap</td> -->
<!-- 				<td>Monthly Gap</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td>Accumulated Gap</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
		</table>
	</div>
	<div class="scrollable noRight rowBody">
		<table class="tblBorder">
<!-- 			<tr class="alignCenter"> -->
<!-- 				<th>YY01</th> -->
<!-- 				<th>YY02</th> -->
<!-- 				<th>YY03</th> -->
<!-- 				<th>YY04</th> -->
<!-- 				<th>YY05</th> -->
<!-- 				<th>YY06</th> -->
<!-- 				<th>...</th> -->
<!-- 				<th>YY12</th> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="2" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="2" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="2" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="2" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="2" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
		</table>
	</div>
</div>

<script>


teamProfit = {
		data : "",
		exchangeRate : "",
		monthsList : [],
    	init : function(){
    		this.initData();
			this.bindEvent();
    	},
    	
    	initData : function(){
    		teamProfit.initDialog();
    		var thisyear = new Date().getFullYear();
    		$('#orgTree').jstree('destroy');
    		teamProfit.initTree(thisyear);
    		$('#year').val(thisyear);
    		var startDate = new Date(thisyear, "0","1");
    		var endDate = new Date(thisyear, "11","1");
    		teamProfit.getDiffMonthList(startDate, endDate);
    	},
    	
    	initDialog : function(){
    		$('#treeDialog').dialog({
				modal: true,
				autoOpen: false
			});
    	},
    	
    	bindEvent : function(){
    		
    		$('#organization').click(function(){
				$('#treeDialog').dialog("open");
			});
    		
    		// change year
    		$("#year").off("change").on("change", function(){
    			teamProfit.monthsList = [];
    			$('#orgTree').jstree('destroy');
    			teamProfit.initTree($(this).val());
    			var startDate = new Date($(this).val(), '0','1');
    			var endDate = new Date($(this).val(), '11','1');
    			teamProfit.getDiffMonthList(startDate, endDate);
    			$('.rowLeft > table.tblBorder, .rowBody>table.tblBorder').empty();
    			$('#organization, #orgID').val('');
    			
    		});
    		
    		
    		$('#revenueRecog, .currency').off("change").on('change',function(){
    			if($('#orgID').val() != ""){
	    			teamProfit.viewData();
    			}
    		});
    	},
    	
    	
    	
    	initTree : function(year){
			var treeURL = Yuga.baseURL() + "/organization/"+year+"/getOrgTree.json";
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
			$('#orgTree')
					.unbind("dblclick.jstree")
					.bind("dblclick.jstree", function (e) {
				var tree = $.jstree.reference('#orgTree');
				var selectedNodes = tree.get_selected();
				var node = tree.get_node(selectedNodes[0]);
			  	 $("#organization").attr("value", node.text);
			  	 $("#orgID").val(node.id);
				 $('#treeDialog').dialog("close");
				 teamProfit.viewReport();
			});
		},
		
    	//Get Report Project Cost
    	
    	viewReport : function(){
    		
    		$.ajax({
    			url : "<c:url value='/report' />/"+ $("#year").val() +"/" + $("#orgID").val() + "/teamProfit",
    			dataType : "json",
    			success : function(response){
    				teamProfit.data = "";
    				console.log(response);
    				console.log(teamProfit.monthsList);
    				teamProfit.prepareData(response);
    			}
    		});
    	},
    	
    	prepareData : function(response){
    		var accruals = [];
    		var proportionals =[];
    		var plans = [];
    		$.each(response,function(index,value){
    			if(value.exchangeRate != undefined){
    				teamProfit.exchangeRate = value.exchangeRate;
    			}else if(value.Level1 == "Accrual" || value.Level3 == "Accrual"){
    				accruals.push(value);
    			}else if(value.Level1 == "Plan"){
    				plans.push(value);
    			}else{
    				proportionals.push(value);
    			}
    		});
    		teamProfit.data = {
    			accrual : teamProfit.orderData(accruals),
    			proportional : teamProfit.orderData(proportionals),
    			plan : teamProfit.orderData(plans),
    		}
    		teamProfit.viewData();
    	},
    	
    	orderData : function(data){
    		var newData = [];
    		var cost = []; teamPro = "",accumulate = "", monthlyGap = "", accumulatedGap="";
    		$.each(data,function(i, v){
    			var value = {
						  Level1 : v.Level1,
						  Level2 : v.Level2,
						  Level3 : v.Level3,
						  sum : v.SUM,
						  yearmonthdata : teamProfit.orderDatabyYear(v),
						  classes : "",
						  type : "",
				  };
    			if(v.Level1 != "Gap"){
    				if(v.Level2 != "Accumulated P/L" && v.Level2 != "Team Profit/Loss" && v.Level2 != "Accumulated Profit" && v.Level2 !="Net Profit by Month"){
    					value.classes = (v.Level3 == "") ? "bgsum" : "";
    					if(v.Level2 != "Cost"){
    						value.type = 'revenue';
    						//newData.push(value);
    						switch (v.Level3){
	    						case "" : newData[0] = value; break;
	    						case "Team-owned SI/SM Project Revenue" : newData[1] = value; break;
								case "Team-owned Internal R&D Project Revenue" : newData[2] = value; break;
								case "Internal Billing Revenue" : newData[3] = value; break;
							}
    					}else{
    						value.type ='cost';
							//cost.push(value);
							
							switch (v.Level3){
								case "" : cost[0] = value; break;
								case "Team Internal Cost" : 	cost[1] = value; break;
								case "Internal Outsourcing" : 	cost[2] = value; break;
								case "Outsourcing" : 			cost[3] = value; break;
								case "3rd Party Solution" : 	cost[4] = value; break;
								case "Project Expense" : 		cost[5] = value; break;
								case "Sales OPEX" : 			cost[6] = value; break;
							}
    					}
    				}else{
    					value.classes = "bgsum";
    					value.type = "total";
    					if(v.Level2 == "Accumulated P/L" || v.Level2 == "Accumulated Profit"){
	    					accumulate = value;
    					}else{
    						teamPro = value;
    					}
    				}
    			}else if(v.Level2 == "Accumulated Gap"){
    				value.classes = "bgsum";
    				accumulatedGap = value;
    			}else if(v.Level2 == "Monthly Gap"){
    				value.classes = "bgsum";
    				monthlyGap = value;
    			}
	    		
    		});
    		$.merge(newData, cost);
    		newData.push(teamPro, accumulate, monthlyGap, accumulatedGap);
    		return newData;
    	},
    	
    	
    	
    	viewData : function(){
    		var planData = teamProfit.data.plan;
    		var typeData = teamProfit.data[$("#revenueRecog").val()];
    		//Render type Data
    		teamProfit.renderData(typeData, planData);
    	},
    	
    	renderData : function(actualData, planData){
    		$('.rowLeft > table.tblBorder, .rowBody>table.tblBorder').empty();
    		teamProfit.appendHeader();
    		var isExisitMM = true;
    		var isFirstGap = true;
    		var count = 0;
    		var EmptyTr = "<tr><td colspan='2' class='invisible'>invisible Text</td></tr>";
    		var currency = $(".currency:checked").attr("id");
    		var dataType = "";
    		$.each(actualData, function(i,v){
		    			var sum = (currency == "krw") ? Yuga.commaSeparateNumber(v.sum.toFixed(0)) : Yuga.commaSeparateNumber((v.sum/teamProfit.exchangeRate).toFixed(2));
		    			if(v !=""){
		    			var $leftTr = $("<tr>"), $rightTr = $("<tr class='alignRight'>");
		    			if(v.classes == "bgsum"){
			    			$leftTr.addClass('bgSum');
			    			$rightTr.addClass('bgSum');
			    		}
		    			if(isExisitMM){
		    				$leftTr.addClass('actualRow');
		    				$leftTr.append("<td>Actual</td>");
		    			}
		    			var value = v.Level3 ;
		    			var type = v.Level1 == "Gap" ? v.Level1 : v.Level2;
		    			if(dataType != v.type && dataType!= ""){
		    				$('div.rowLeft > table').append(EmptyTr);	
		    				$('div.rowBody > table').append(EmptyTr);
		    				count++;
		    			}
		    			
			    		$.each(v.yearmonthdata ,function(index,data){
				    		var value = (currency == "krw") ? Yuga.commaSeparateNumber(data.toFixed(0)) : Yuga.commaSeparateNumber((data/teamProfit.exchangeRate).toFixed(2));
							$rightTr.append("<td>"+ value  +"</td>");	    				
				    	});
		    			var $td = '';
		    			if(v.Level1 == "Gap"){
							if(isFirstGap){
								$leftTr.addClass('gap');
								$rightTr.addClass('gap');
			    				$td = $("<td rowspan='3'>GAP</td><td>"+v.Level2+"</td><th>"+sum +"</th>");
			    				isFirstGap = false;
							}else{
								$td = $("<td>"+v.Level2+"</td><th>"+sum +"</th>");
							}
		    			}else{
			    			$td = $("<td class="+(value != "" ? "indent" : "alignLeft")+">"+(value != "" ? value : type) +"</td><th>"+sum +"</th>");
					    	count++;
    					}
			    		dataType = v.type;
				    	$leftTr.append($td);
				    	$('div.rowLeft > table').append($leftTr);
				    	$('div.rowBody > table').append($rightTr);
				    	isExisitMM = false;
	    			}
    		});
    		$('tr.actualRow').find('td:eq(0)').attr('rowspan', count-1);
    		
// //     		$('div.rowLeft > table tr:last, div.rowBody > table tr:last').prev().before("<tr><td class='invisible' colspan='4'>Invisible Text</td></tr>");
			isExisitMM = true;
			dataType = "";
			count = 0;
    		$.each(planData, function(i,v){
    			if(v != "" && v.type !='revenue' && v.type != 'cost'){
    				$leftTr = $("<tr>"), $rightTr = $("<tr class='alignRight'>");
    				var sum = (currency == "krw") ? Yuga.commaSeparateNumber(v.sum.toFixed(0)) : Yuga.commaSeparateNumber((v.sum/teamProfit.exchangeRate).toFixed(2));
	    			if(v !=""){
	    			var $leftTr = $("<tr>"), $rightTr = $("<tr class='alignRight'>");
	    			if(v.classes == "bgsum"){
		    			$leftTr.addClass('bgSum');
		    			$rightTr.addClass('bgSum');
		    		}
	    			if(isExisitMM == true){
	    				$leftTr.addClass('planRow');
	    				$leftTr.append("<td>Plan</td>");
	    			}
	    			var value = v.Level3 ;
	    			var type = v.Level2;
	    			if(dataType != v.type && dataType!= ""){
	    				$('div.rowLeft > table tr.gap').before(EmptyTr);	
	    				$('div.rowBody > table tr.gap').before(EmptyTr);
	    				count++;
	    			}
		    		$.each(v.yearmonthdata ,function(index,data){
			    		var value = (currency == "krw") ? Yuga.commaSeparateNumber(data.toFixed(0)) : Yuga.commaSeparateNumber((data/teamProfit.exchangeRate).toFixed(2));
						$rightTr.append("<td>"+ value  +"</td>");	    				
			    	});
	    			
		    		var	$td = $("<td class="+(value != "" ? "indent" : "alignLeft")+">"+(value != "" ? value : type) +"</td><th>"+sum +"</th>");
					}
			    	$leftTr.append($td);
			    	isExisitMM = false;
			    	dataType = v.type
			    	count++;
		    		$('div.rowLeft > table tr.gap').before($leftTr);
		    		$('div.rowBody > table tr.gap').before($rightTr);
	    			
    			}
	    		});
    			$('div.rowLeft > table tr.gap, div.rowBody > table tr.gap').before(EmptyTr);
	    		$('tr.planRow').find('td:eq(0)').attr('rowspan', count);
	    		
    	},
    	
    	appendHeader : function(){
    		var $tr = $("<tr>");
    		$.each(teamProfit.monthsList, function(i,v){
    			$tr.append("<th class='alignCenter'>" +v.month +"-"+ v.year+ "</th>");
    		});
    		$('div.rowLeft > table').append("<tr><td colspan='2'></td><th class='alignCenter'>Sum</th></tr>");
    		$('div.rowBody > table').append($tr);
    	},
    	
    	orderDatabyYear : function(data){
    		var listorderData = [];
    		$.each(teamProfit.monthsList, function(i, v){
    			var monthyear = v.month + "-" + v.year;
    			listorderData.push(( typeof data[monthyear] == 'undefined') ? 0: data[monthyear]);
    		});
    		return listorderData;
    	},
    	

    	
    	
    	getDiffMonthList: function( startStr, endStr ){
			var startDate = startStr;
			startDate.setDate(1);
			var endDate = endStr;
			endDate.setDate(1);
			
			// add start month
			if( endDate.diffMonths( startDate ) > -1  ){
				teamProfit.monthsList.push( 
					{ 
						month: (("0" + (startDate.getMonth() + 1)).slice(-2) ),
						year: startDate.getFullYear()
					}
				);
			}
			
			do{
				startDate.addMonths( 1 );
				
				if( endDate.diffMonths( startDate ) > -1  ){
					teamProfit.monthsList.push( 
						{ 
							month:(("0" + (startDate.getMonth() + 1)).slice(-2) ),
							year: startDate.getFullYear()
						}
					);
				}
				else{
					break;
				}
			}
			while( true );
		},
}


	$(document).ready(function(){
		teamProfit.init();
	});
</script>