<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
			<th><label for="projectTypeID">Project Type:</label></th>
			<td><select class="select" id="projectTypeID">
					<option value="">Choose</option>
					<c:forEach items="${projectTypes}" var="projectType">
						<option value="${projectType.projectTypeID}">${projectType.title}</option>
					</c:forEach>
			</select></td>
			<th><label for="projectID">Project Name:</label></th>
			<td><select class="select" id="projectID">
					<option>Choose</option>
			</select></td>
			<th><label for="revenueRecog">Revenue Recog:</label></th>
			<td><select class="select" id="revenueRecog">
					<option value="proportional">Proportional</option>
					<option value="accrual">Accrual</option>
			</select></td>
		</tr>
		<tr>
			<th><label for="PM">Project Manager</label></th>
			<td><span id="PM"></span></td>
			<th><label for="projectPeriod">Project Period</label></th>
			<td><span id="projectPeriod"></span></td>
			<th><label for="Currency">Currency</label></th>
			<td><input type="radio" id="krw" class='currency' name="currency" checked="checked"/><label for="krw">KRW</label><input type="radio" id='usd' class='currency' name='currency'/><label for='usd'> USD</label></td>
		</tr>
	</tbody>
</table>

<div class="budgetExpense ExpenseReport">
	<div class="row-head left rowLeft">
		<table class="table tblBorder">
<!-- 			<tr> -->
<!-- 				<td colspan="2"></td> -->
<!-- 				<th class="alignCenter">Sum</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td rowspan="13">Actual</td> -->
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
<!-- 				<td colspan="2" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td class="bgSum alignLeft">Cost (b)</td> -->
<!-- 				<th class="bgSum">0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td class="indent">Team Dev. Cost</td> -->
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
<!-- 			<tr> -->
<!-- 				<td class="bgSum">Projec Profit/Loss (a-b)</td> -->
<!-- 				<td class="bgSum">0</td> -->
<!-- 			</tr> -->
			
<!-- 			<tr> -->
<!-- 				<td colspan="3" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
			
<!-- 			<tr> -->
<!-- 				<td rowspan="13">Plan</td> -->
<!-- 				<td class="bgSum alignLeft">Revenue (a')</td> -->
<!-- 				<th class="bgSum">0</th> -->
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
<!-- 				<td colspan="2" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td class="bgSum alignLeft">Cost (b')</td> -->
<!-- 				<th class="bgSum">0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td class="indent">Team Dev. Cost</td> -->
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
<!-- 			<tr> -->
<!-- 				<td class="bgSum">Projec Profit/Loss (a'-b')</td> -->
<!-- 				<td class="bgSum">0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="2" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td rowspan="3">Gap</td> -->
<!-- 				<td>Revenue Gap (a-a')</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td>Cost Gap (b-b')</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td>Profit Gap ((a-b)-(a'-b'))</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
			
		</table>
	</div>
	<div class="scrollable noRight rowBody">
		<table class="tblBorder">
<!-- 			<tr class="alignCenter"> -->
<!-- 				<th>M1(YYMM)</th> -->
<!-- 				<th>M2(YYMM)</th> -->
<!-- 				<th>M3(YYMM)</th> -->
<!-- 				<th>M4(YYMM)</th> -->
<!-- 				<th>M5(YYMM)</th> -->
<!-- 				<th>M6(YYMM)</th> -->
<!-- 				<th>M7(YYMM)</th> -->
<!-- 				<th>M8(YYMM)</th> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr class="alignRight"> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some tesome textsome </td> -->
<!-- 			</tr> -->
<!-- 			<tr class="alignRight"> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some tesome textsome </td> -->
<!-- 			</tr> -->
<!-- 			<tr class="alignRight"> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some tesome textsome </td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="2" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr class="alignRight"> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some tesome textsome </td> -->
<!-- 			</tr> -->
<!-- 			<tr class="alignRight"> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some tesome textsome </td> -->
<!-- 			</tr> -->
<!-- 			<tr class="alignRight"> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some tesome textsome </td> -->
<!-- 			</tr> -->
<!-- 			<tr class="alignRight"> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some tesome textsome </td> -->
<!-- 			</tr> -->
<!-- 			<tr class="alignRight"> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some tesome textsome </td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="2" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="2" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr class="alignRight"> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some tesome textsome </td> -->
<!-- 			</tr> -->
<!-- 			<tr class="alignRight"> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some tesome textsome </td> -->
<!-- 			</tr> -->
<!-- 			<tr class="alignRight"> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some tesome textsome </td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="2" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr class="alignRight"> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some tesome textsome </td> -->
<!-- 			</tr> -->
<!-- 			<tr class="alignRight"> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some tesome textsome </td> -->
<!-- 			</tr> -->
<!-- 			<tr class="alignRight"> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some tesome textsome </td> -->
<!-- 			</tr> -->
<!-- 			<tr class="alignRight"> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some tesome textsome </td> -->
<!-- 			</tr> -->
<!-- 			<tr class="alignRight"> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some tesome textsome </td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="2" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="2" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
		</table>
	</div>
</div>

<script>


projectProfit = {
		data : "",
		exchangeRate : "",
		monthsList : [],
    	init : function(){
			this.bindEvent();
    	},
    	bindEvent : function(){
    		
    		// Event Change on ProjectTypeID
    		$("#projectTypeID").off("change").on("change", function(){
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
    						$('.rowLeft > table.tblBorder, .rowBody>table.tblBorder').empty();
    						$("#PM, #projectPeriod").text('');
    						$("#projectID").html(options);
        				}
        			});
    			}else{
    				$("#projectID").html(options);
    			}
    		});
    		
    		// Event change on projectName
    		$("#projectID").off("change").on("change", function(){
    			$('.rowLeft > table.tblBorder, .rowBody>table.tblBorder').empty();
    			projectProfit.monthsList = [];
    			if($(this).val() !== ''){
    				$.ajax({
    					url : "<c:url value='/project' />/" + $(this).val() + "/view",
    					dataType : "json",
        				success : function(response){

        					var startDate = new Date(response.startDate),
        						endDate =  new Date(response.endDate);
        					
							$("#PM").text(response.pmName[0].employeeName);
							$("#projectPeriod").text(startDate.toString(Yuga.config.format.date) + " - " + endDate.toString(Yuga.config.format.date));
							projectProfit.exchangeRate = response.exchangeRate;
							projectProfit.viewReport();
							projectProfit.getDiffMonthList(startDate,endDate);
        				}
    				});
    			}
    		});
    		
    		$('#revenueRecog, .currency').off("change").on('change',function(){
    			if($('#projectID').val() != "Choose" && $('#projectID').val() != ""){
    				projectProfit.viewData();
    			}
    		});
    	},
    	
    	//Get Report Project Cost
    	
    	viewReport : function(){
    		
    		$.ajax({
    			url : "<c:url value='/report' />/" + $("#projectID").val() + "/projectProfit",
    			dataType : "json",
    			success : function(response){
    				projectProfit.data = "";
    				console.log(response);
    				projectProfit.prepareData(response);
    			}
    		});
    	},
    	
    	prepareData : function(response){
    		var accruals = [];
    		var proportionals =[];
    		var plans = [];
//     		console.log(response);
    		$.each(response,function(index,value){
    			if(value.Level1 == "Accrual" || value.Level3 == "Accrual"){
    				accruals.push(value);
    			}else if(value.Level1 == "Plan"){
    				plans.push(value);
    			}else{
    				proportionals.push(value);
    			}
    		});
    		projectProfit.data = {
    			accrual : projectProfit.orderData(accruals),
    			proportional : projectProfit.orderData(proportionals),
    			plan : projectProfit.orderData(plans),
    		}
    		console.log(projectProfit.data);
    		projectProfit.viewData();
    	},
    	
    	orderData : function(data){
    		var newData = [];
    		var acutal=[]; cost = []; projectLoss = "", profitGap = "", revenueGap="",costGap = "";
    		$.each(data,function(i, v){
    			var value = {
						  Level1 : v.Level1,
						  Level2 : v.Level2,
						  Level3 : v.Level3,
						  sum : v.SUM,
						  yearmonthdata : projectProfit.orderDatabyYear(v),
						  classes : ""
				  };
    			if(v.Level1 != "Gap"){
    				if(v.Level2 != "Project Profit/Loss"){
    					value.classes = (v.Level3 == "") ? "bgsum" : "";
    					if(v.Level2 != "Cost"){
    						switch (v.Level3){
    							case "" : acutal[0] = value; break; 
    							case "Service" : acutal[1] = value; break;
    							case "License" : acutal[2] = value; break;
    							case "3rd Party Solution" : acutal[3] = value; break;
    						}
    					}else{
    						switch (v.Level3){
    						case "" : cost[0] = value; break;
    						case "Team Dev. Cost" : cost[1] = value; break;
							case "Internal Outsourcing" : cost[2] = value; break;
							case "Outsourcing" : cost[3] = value; break;
 							case "3rd Party Solution" : cost[4] = value; break;
							case "Project Expense" : cost[5] = value; break;
							case "Sales OPEX" : cost[6] = value; break;
							case "License R&D Cost" : cost[7] = value; break;
							}
    					}
    				}else{
    					value.classes = "bgsum";
    					projectLoss = value;
    				}
    			}else if(v.Level2 == "Cost Gap"){
    				value.classes = "bgsum";
    				costGap = value;
    			}else if(v.Level2 == "Profit Gap"){
    				value.classes = "bgsum";
    				profitGap = value;
    			}else if(v.Level2 == "Revenue Gap"){
    				value.classes = "bgsum";
    				revenueGap = value;
    			}
	    		
    		});
    		newData = $.merge(acutal, cost);
    		newData.push(projectLoss, revenueGap, costGap, profitGap);
    		return newData;
    	},
    	
    	
    	
    	viewData : function(){
    		var planData = projectProfit.data.plan;
    		var typeData = projectProfit.data[$("#revenueRecog").val()];
    		//Render type Data
    		projectProfit.renderData(typeData, planData);
    	},
    	
    	renderData : function(actualData, planData){
    		$('.rowLeft > table.tblBorder, .rowBody>table.tblBorder').empty();
    		projectProfit.appendHeader();
    		var isExisitMM = true;
    		var isFirstGap = true;
    		var EmptyTr = "<tr><td colspan='2' class='invisible'>invisible Text</td></tr>";
    		var currency = $(".currency:checked").attr("id");
    		var dataType = "";
    		$.each(actualData, function(i,v){
		    			var sum = (currency == "krw") ? Yuga.commaSeparateNumber(v.sum.toFixed(0)) : Yuga.commaSeparateNumber((v.sum/projectProfit.exchangeRate).toFixed(2));
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
		    			if(dataType != type && dataType!= ""){
		    				$('div.rowLeft > table').append(EmptyTr);	
		    				$('div.rowBody > table').append(EmptyTr);
		    			}
		    			
			    		$.each(v.yearmonthdata ,function(index,data){
				    		var value = (currency == "krw") ? Yuga.commaSeparateNumber(data.toFixed(0)) : Yuga.commaSeparateNumber((data/projectProfit.exchangeRate).toFixed(2));
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
    					}
			    		dataType = type;
				    	$leftTr.append($td);
				    	$('div.rowLeft > table').append($leftTr);
				    	$('div.rowBody > table').append($rightTr);
				    	isExisitMM = false;
	    			}
    		});
    		$('tr.actualRow').find('td:eq(0)').attr('rowspan', 15);
    		
//     		$('div.rowLeft > table tr:last, div.rowBody > table tr:last').prev().before("<tr><td class='invisible' colspan='4'>Invisible Text</td></tr>");
			isExisitMM = true;
			dataType = "";
    		$.each(planData, function(i,v){
    			if(v != ""){
    				$leftTr = $("<tr>"), $rightTr = $("<tr class='alignRight'>");
    				var sum = (currency == "krw") ? Yuga.commaSeparateNumber(v.sum.toFixed(0)) : Yuga.commaSeparateNumber((v.sum/projectProfit.exchangeRate).toFixed(2));
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
	    			if(dataType != type && dataType!= ""){
	    				$('div.rowLeft > table tr.gap').before(EmptyTr);	
	    				$('div.rowBody > table tr.gap').before(EmptyTr);
	    			}
		    		$.each(v.yearmonthdata ,function(index,data){
			    		var value = (currency == "krw") ? Yuga.commaSeparateNumber(data.toFixed(0)) : Yuga.commaSeparateNumber((data/projectProfit.exchangeRate).toFixed(2));
						$rightTr.append("<td>"+ value  +"</td>");	    				
			    	});
	    			
		    		var	$td = $("<td class="+(value != "" ? "indent" : "alignLeft")+">"+(value != "" ? value : type) +"</td><th>"+sum +"</th>");
					}
			    	$leftTr.append($td);
			    	isExisitMM = false;
			    	dataType = type;
		    		$('div.rowLeft > table tr.gap').before($leftTr);
		    		$('div.rowBody > table tr.gap').before($rightTr);
	    			
    			}
	    		});
    			$('div.rowLeft > table tr.gap, div.rowBody > table tr.gap').before(EmptyTr);
	    		$('tr.planRow').find('td:eq(0)').attr('rowspan', 15);
	    		
    	},
    	
    	appendHeader : function(){
    		var $tr = $("<tr>");
    		$.each(projectProfit.monthsList, function(i,v){
    			$tr.append("<th class='alignCenter'>" +v.month +"-"+ v.year+ "</th>");
    		});
    		$('div.rowLeft > table').append("<tr><td colspan='2'></td><th class='alignCenter'>Sum</th></tr>");
    		$('div.rowBody > table').append($tr);
    	},
    	
    	orderDatabyYear : function(data){
    		var listorderData = [];
    		$.each(projectProfit.monthsList, function(i, v){
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
				projectProfit.monthsList.push( 
					{ 
						month: (("0" + (startDate.getMonth() + 1)).slice(-2) ),
						year: startDate.getFullYear()
					}
				);
			}
			
			do{
				startDate.addMonths( 1 );
				
				if( endDate.diffMonths( startDate ) > -1  ){
					projectProfit.monthsList.push( 
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
		projectProfit.init();
	});
</script>