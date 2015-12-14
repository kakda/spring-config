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
			<th><label for="ProjectPeriod">Project Period</label></th>
			<td><span id="ProjectPeriod"></span></td>
			<th><label for="Currency">Currency</label></th>
			<td><input type="radio" id="krw" class='currency' name="currency" checked="checked"/><label for="krw">KRW</label><input type="radio" id='usd' class='currency' name='currency'/><label for='usd'> USD</label></td>
		</tr>
	</tbody>
</table>
<div class="budgetExpense ExpenseReport">
	<div class="row-head left rowLeft">
		<table class="table tblBorder">
<!-- 			<tr> -->
<!-- 				<td colspan="3"></td> -->
<!-- 				<th class="alignCenter">Sum</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td rowspan="11">Actual</td> -->
<!-- 				<td rowspan="6" >MM</td> -->
<!-- 				<td>Principal</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>Chief</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>Senior</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>Junior</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>Cambodia</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td>SUM</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="3" class="invisible">Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="2">Int. Dev. Cost</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="2">Outsourcing</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="2">Expense</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td colspan="2">Total</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
			
<!-- 			<tr> -->
<!-- 				<td class="invisible" colspan="4">Invisible Text</td> -->
<!-- 			</tr> -->
			
<!-- 			<tr> -->
<!-- 				<td rowspan="11">Actual</td> -->
<!-- 				<td rowspan="6" >MM</td> -->
<!-- 				<td>Principal</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>Chief</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>Senior</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>Junior</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>Cambodia</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td>SUM</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="3" class="invisible">Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="2">Int. Dev. Cost</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="2">Outsourcing</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="2">Expense</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td colspan="2">Total</td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="3" class="invisible">Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td rowspan="2">Gap</td> -->
<!-- 				<td>MM Gap</td> -->
<!-- 				<td  rowspan="2"> </td> -->
<!-- 				<th>0</th> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td>Amount Gap</td> -->
<!-- 				<th>0</th> -->
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
<!-- 				<td>Long TextLong TextLong Text Long Text Long TextLong Text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some tesome textsome </td> -->
<!-- 			</tr> -->
<!-- 			<tr class="alignRight"> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>Long TextLong TextLong Text Long Text Long TextLong Text</td> -->
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
<!-- 				<td class="invisible" colspan="5">Invisible Text</td> -->
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
<!-- 			<tr class="bgSum"> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 			</tr>  -->
			
<!-- 			<tr> -->
<!-- 				<td class="invisible" colspan="5">Invisible Text</td> -->
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
<!-- 				<td>Long TextLong TextLong Text Long Text Long TextLong Text</td> -->
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
<!-- 				<td class="invisible" colspan="2">Invisible Text</td> -->
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
<!-- 			<tr class="bgSum"> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 				<th>0</th> -->
<!-- 			</tr>  -->
<!-- 			<tr> -->
<!-- 				<td class="invisible" colspan="2">Invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="alignRight bgSum"> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some tesome textsome </td> -->
<!-- 			</tr> -->
<!-- 			<tr class="alignRight bgSum"> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some text</td> -->
<!-- 				<td>some tesome textsome </td> -->
<!-- 			</tr> -->
		</table>
	</div>
</div>

<script>


projectCost = {
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
    						$("#PM, #ProjectPeriod").text('');
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
    			projectCost.monthsList = [];
    			if($(this).val() !== ''){
    				$.ajax({
    					url : "<c:url value='/project' />/" + $(this).val() + "/view",
    					dataType : "json",
        				success : function(response){

        					var startDate = new Date(response.startDate),
        						endDate =  new Date(response.endDate);
        					
							$("#PM").text(response.pmName[0].employeeName);
							$("#ProjectPeriod").text(startDate.toString(Yuga.config.format.date) + " - " + endDate.toString(Yuga.config.format.date));
							projectCost.exchangeRate = response.exchangeRate;
							projectCost.viewReport();
							projectCost.getDiffMonthList(startDate,endDate);
        				}
    				});
    			}
    		});
    		
    		$('#revenueRecog, .currency').off("change").on('change',function(){
    			if($('#projectID').val() != "Choose" && $('#projectID').val() != ""){
	    			projectCost.viewData();
    			}
    		});
    	},
    	
    	//Get Report Project Cost
    	
    	viewReport : function(){
    		
    		$.ajax({
    			url : "<c:url value='/report' />/" + $("#projectID").val() + "/projectCost",
    			dataType : "json",
    			success : function(response){
    				projectCost.data = "";
					projectCost.prepareData(response);
    			}
    		});
    	},
    	
    	prepareData : function(response){
    		var accruals = [];
    		var proportionals =[];
    		var plans = [];
    		console.log(response);
    		$.each(response,function(index,value){
    			if(value.Level1 == "Accrual" || value.Level3 == "Accurual"){
    				accruals.push(value);
    			}else if(value.Level1 == "Plan"){
    				plans.push(value);
    			}else{
    				proportionals.push(value);
    			}
    		});
    		projectCost.data = {
    			accrual : projectCost.orderData(accruals),
    			proportional : projectCost.orderData(proportionals),
    			plan : projectCost.orderData(plans),
    		}
    		console.log(projectCost.data);
    		projectCost.viewData();
    	},
    	
    	orderData : function(data){
    		var newData = [];
    		var principal="", cheif="",senior="",junior="",cambodia="",expense = "", outSourcing = "", init="", total="", amoutGap="", MMGap="", sum="";
    		$.each(data,function(i, v){
    			var value = {
						  Level1 : v.Level1,
						  Level2 : v.Level2,
						  Level3 : v.Level3,
						  sum : v.SUM,
						  yearmonthdata : projectCost.orderDatabyYear(v),
						  classes : "",
						  type : "",
				  };
	    		if(v.Level2 == "MM"){
	    			value.type = "MM";
					switch (v.Level3){
						case "SUM":
							value.classes = "bgsum";
							sum = value;
						 break;
						case "Principal": principal = value; break;
						case "Chief": cheif = value; break;
						case "Senior": senior = value; break;
						case "Junior": junior = value; break;
						case "Cambodia": cambodia = value; break;
					}
	    		}else{ 
		    		value.type = "EOUT";
		    		if(v.Level2 == "Expense"){
		    			expense = value;	
		    		}else if(v.Level2  == "Outsourcing"){
		    			outSourcing = value;
		    		}else if(v.Level2 == "Int. Dev. Cost"){
		    			init = value;
		    		}else if(v.Level2 == "Total"){
		    			value.classes = "bgsum";
		    			total = value;
		    		}else if(v.Level2 == "Amount Gap"){
		    			value.type ="GAP";
		    			value.classes = "bgsum";
		    			amoutGap = value;
		    		}else if(v.Level2 == "MM Gap"){
		    			value.type ="GAP";
		    			value.classes = "bgsum";
		    			MMGap = value;
		    		}
	    		}
    		});
    		console.log(principal);
    		newData.push(principal,cheif,senior,junior,cambodia,sum,init,outSourcing,expense,total,MMGap,amoutGap);
    		return newData;
    	},
    	
    	
    	
    	viewData : function(){
    		var planData = projectCost.data.plan;
    		var typeData = projectCost.data[$("#revenueRecog").val()]
    		//Render type Data
    		projectCost.renderData(typeData, planData);
    	},
    	
    	renderData : function(actualData, planData){
//     		console.log(actualData);
    		$('.rowLeft > table.tblBorder, .rowBody>table.tblBorder').empty();
    		projectCost.appendHeader();
    		var count = 0;
    		var isExisitMM = true;
    		var isFirstGap = true;
    		var currency = $(".currency:checked").attr("id");
    		var EmptyTr = "<tr><td colspan='2' class='invisible'>invisible Text</td></tr>";
    		var dataType = "";
    		$.each(actualData, function(i,v){
    			if(v !=""){
    				var sum = "";
    				if(v.type == "MM" || v.Level2 == "MM Gap"){
    					sum = v.sum.toFixed(2);
    				}else{
    					sum = (currency == "krw") ? Yuga.commaSeparateNumber(v.sum.toFixed(0)) : Yuga.commaSeparateNumber((v.sum/projectCost.exchangeRate).toFixed(2));
    				}
    			var $leftTr = $("<tr>"), $rightTr = $("<tr class='alignRight'>");
    			var $leftTd = $("<td>"+(v.Level3 != "" ? v.Level3 : v.Level2) +"</td><td>"+sum +"</td>");
	    		$.each(v.yearmonthdata ,function(index,data){
	    			var value = "";
	    			if(v.type == "MM" || v.Level2 == "MM Gap"){
	    				value = data.toFixed(2);
	    			}else{
	    				value = (currency == "krw") ? Yuga.commaSeparateNumber(data.toFixed(0)) : Yuga.commaSeparateNumber((data/projectCost.exchangeRate).toFixed(2));
	    			}
					$rightTr.append("<td>"+ value  +"</td>");	    				
	    		});
	    		if(v.classes == "bgsum"){
	    			$leftTr.addClass('bgSum');
	    			$rightTr.addClass('bgSum');
	    		}
	    		if(dataType != v.type && dataType!= ""){
    				$('div.rowLeft > table').append(EmptyTr);	
    				$('div.rowBody > table').append(EmptyTr);
    				count++;
    			}
	    		
    			if(v.Level2 == "MM"){
	    			if(v.Level3 == "SUM"){
	    				$leftTr.addClass('bgSum');
		    			$rightTr.addClass('bgSum');
	    				isExisitMM = false;
	    			}else if(i == 0){
	    				$leftTr.addClass('actualRow');
		    			$leftTr.append("<td>Actual</td><td>MM</td>");
	    			}
	    			$leftTr.append($leftTd);
	    			count++;
    			}else{
    				$leftTd.eq(0).attr('colspan','2');
    				if(v.Level1 == "Gap"){
    					if(isFirstGap){
    						$leftTr.addClass('gap');
    						$rightTr.addClass('gap');
	    					$leftTr.append("<td rowspan='2'>GAP</td><td>MM Gap</td><td rowspan='2'></td><th>"+sum+"</th>");
	    					isFirstGap = false;
    					}else{
    						$leftTr.append("<td>Amout Gap</td><th>"+sum+"</th>");
    					}
    				}else{
	    				$leftTr.append($leftTd);
    				}
    			}
	    		$('div.rowLeft > table').append($leftTr);
	    		$('div.rowBody > table').append($rightTr);
	    		dataType = v.type;
    			}
    		});
    		$('tr.actualRow').find('td:eq(0)').attr('rowspan', count + 3);
    		$('tr.actualRow').find('td:eq(1)').attr('rowspan', count - 2);
    		
    		count = 0;    	 
    		dataType = "";
    		$.each(planData, function(i,v){
    			if(v != ""){
    				var sum = "";
    				if(v.type == "MM"){
    					sum = v.sum.toFixed(2);
    				}else{
    					sum = (currency == "krw") ? Yuga.commaSeparateNumber(v.sum.toFixed(0)) : Yuga.commaSeparateNumber((v.sum/projectCost.exchangeRate).toFixed(2));
    				}
	    			var $leftTr = $("<tr>"), $rightTr = $("<tr class='alignRight'>");
	    			var $leftTd = $("<td>"+(v.Level3 != "" ? v.Level3 : v.Level2) +"</td><td>"+sum+"</td>");
		    		$.each(v.yearmonthdata ,function(index,data){
		    			var value = "";
		    			if(v.type == "MM"){
		    				value = data.toFixed(2);
		    			}else{
		    				value = (currency == "krw") ? Yuga.commaSeparateNumber(data.toFixed(0)) : Yuga.commaSeparateNumber((data/projectCost.exchangeRate).toFixed(2));
		    			}
						$rightTr.append("<td>"+ value +"</td>");	    				
		    		});
		    		if(dataType != v.type && dataType!= ""){
		    			$('div.rowLeft > table tr.gap').before(EmptyTr);
			    		$('div.rowBody > table tr.gap').before(EmptyTr);
	    			}
	    			if(v.Level2 == "MM"){
		    			if(v.Level3 == "SUM"){
		    				$leftTr.addClass('bgSum');
		    				$rightTr.addClass('bgSum');
		    				isExisitMM = false;
		    			}else if(i == 0){
		    				$leftTr.addClass('planRow');
			    			$leftTr.append("<td>Plan</td><td>MM</td>");
		    			}
		    			$leftTr.append($leftTd);
	    			}else{
	    				if(v.Level2 == "Total"){
	    					$leftTr.addClass('bgSum');
	    					$rightTr.addClass('bgSum');
	    					count++;
	    				}
	    				$leftTd.eq(0).attr('colspan','2');
		    			$leftTr.append($leftTd);
	    				
	    			}
	    			count++;
		    		$('div.rowLeft > table tr.gap').before($leftTr);
		    		$('div.rowBody > table tr.gap').before($rightTr);
		    		dataType = v.type;
    			}
	    		});
	    		$('div.rowLeft > table tr.gap , div.rowBody > table tr.gap').before(EmptyTr);
	    		$('tr.planRow').find('td:eq(0)').attr('rowspan', count);
	    		$('tr.planRow').find('td:eq(1)').attr('rowspan', count - 5);
	    		
    	},
    	
    	appendHeader : function(){
    		var $tr = $("<tr>");
    		$.each(projectCost.monthsList, function(i,v){
    			$tr.append("<th class='alignCenter'>" +v.month +"-"+ v.year+ "</th>");
    		});
    		$('div.rowLeft > table').append("<tr><td colspan='3'></td><th class='alignCenter'>Sum</th></tr>");
    		$('div.rowBody > table').append($tr);
    	},
    	
    	orderDatabyYear : function(data){
    		var listorderData = [];
    		$.each(projectCost.monthsList, function(i, v){
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
				projectCost.monthsList.push( 
					{ 
						month: (("0" + (startDate.getMonth() + 1)).slice(-2) ),
						year: startDate.getFullYear()
					}
				);
			}
			
			do{
				startDate.addMonths( 1 );
				
				if( endDate.diffMonths( startDate ) > -1  ){
					projectCost.monthsList.push( 
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
		projectCost.init();
	});
</script>