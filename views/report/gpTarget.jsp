<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<table class="table table-noborder">
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
		<th><label for="organization">Company:</label></th>
		<td>
			<input type="hidden" name="orgID" id="orgID"/>
			<input type="text" id="organization" readonly="readonly" class="text" />
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
<!-- 				<td rowspan="7">Actual</td> -->
<!-- 				<td class="bgSum alignLeft">Revenue</td> -->
<!-- 				<th class="bgSum">8</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td class="indent">SI</td> -->
<!-- 				<th>8</th> -->
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
<!-- 				<td colspan="3" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td class="alignLeft">Accumulated Revenue</td> -->
<!-- 				<th>8</th> -->
<!-- 			</tr> -->
			
<!-- 			<tr> -->
<!-- 				<td colspan="3" class="invisible">invisible Text</td> -->
<!-- 			</tr> -->
			
<!-- 			<tr> -->
<!-- 				<td rowspan="7">Plan</td> -->
<!-- 				<td class="bgSum alignLeft">Revenue</td> -->
<!-- 				<th class="bgSum">8</th> -->
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
<!-- 				<td colspan="2" class="invisible">invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td>Accumulated Revenue</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="3" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td rowspan="2">Achieve Ratio</td> -->
<!-- 				<td>Monthly</td> -->
<!-- 				<td>100%</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td>Accumulated</td> -->
<!-- 				<td>100%</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="3" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
			
<!-- 			<tr> -->
<!-- 				<td rowspan="11">Gap</td> -->
<!-- 				<td class="bgSum">Monthly Gap</td> -->
<!-- 				<td class="bgSum">0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>SI</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>License</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>3rd Party</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>Internal R &amp; D Revenue</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td colspan="3" class="invisible"> invisible Text</td> -->
<!-- 			</tr> -->
<!-- 			<tr class="bgSum"> -->
<!-- 				<td>Accumulated Gap</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>SI</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>License</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>3rd Party</td> -->
<!-- 				<td>0</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>Internal R &amp; D Revenue</td> -->
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
<!-- 				<td colspan="3" class="invisible"> invisible Text</td> -->
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
<!-- 				<td colspan="3" class="invisible"> invisible Text</td> -->
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
<!-- 				<td colspan="3" class="invisible"> invisible Text</td> -->
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
<!-- 				<td colspan="3" class="invisible"> invisible Text</td> -->
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
<!-- 				<td colspan="3" class="invisible"> invisible Text</td> -->
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
<!-- 				<td colspan="3" class="invisible"> invisible Text</td> -->
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
		</table>
	</div>
</div>


<script>


gpTarget = {
		data : "",
		exchangeRate : "",
		monthsList : [],
    	init : function(){
    		this.initData();
			this.bindEvent();
    	},
    	
    	initData : function(){
    		var thisyear = new Date().getFullYear();
    		$('#year').val(thisyear);
    		var startDate = new Date(thisyear, "0","1");
    		var endDate = new Date(thisyear, "11","1");
    		gpTarget.getDiffMonthList(startDate, endDate);
    		$('#year').trigger("change");
    	},
    	
    	bindEvent : function(){
    		
    		// change year
    		$("#year").off("change").on("change", function(){

	    		
    			gpTarget.monthsList = [];
    			var startDate = new Date($(this).val(), '0','1');
    			var endDate = new Date($(this).val(), '11','1');
    			gpTarget.getDiffMonthList(startDate, endDate);
    			$('.rowLeft > table.tblBorder, .rowBody>table.tblBorder').empty();

	    		$.ajax({
	    			url : "<c:url value='/organization' />/"+ $("#year").val() + "/mcnc",
	    			dataType : "json",
	    			success : function(response){
	    				if(response){
						  	$("#organization").val(response.orgName);
						  	$("#orgID").val(response.orgID);
			        		gpTarget.viewReport();
	    				}
	    			}
	    		});
    		});
    		
    		
    		$('#revenueRecog, .currency').on('change',function(){
    			if($('#orgID').val() != ""){
	    			gpTarget.viewData();
    			}
    		});
    	},		
    	
    	//Get Report Project Cost    	
    	viewReport : function(){
    		
    		$.ajax({
    			url : "<c:url value='/report' />/"+ $("#year").val() +"/" + $("#orgID").val() + "/gpTarget",
    			dataType : "json",
    			success : function(response){
//     				console.log(response);
//     				console.log(gpTarget.monthsList);
    				gpTarget.prepareData(response);
    			}
    		});
    	},
    	
    	prepareData : function(response){
    		console.log(response);
    		var accruals = [];
    		var proportionals =[];
    		var plans = [];
    		$.each(response,function(index,value){
    			if(value.exchangeRate != undefined){
    				gpTarget.exchangeRate = value.exchangeRate;
    			}else if(value.Level1 == "Accrual" || value.Level3 == "Accrual" || value.Level1.indexOf("Accrual") >= 0){
    				accruals.push(value);
    			}else if(value.Level1 == "Plan"){
    				plans.push(value);
    			}else{
    				proportionals.push(value);
    			}
    		});
    		gpTarget.data = "";
    		gpTarget.data = {
    			accrual : accruals,
    			proportional : proportionals,
    			plan : plans,
    		}
    		console.log(gpTarget.data);
    		gpTarget.viewData();
    	},
    	
//     	orderData : function(data){
//     		var newData = [];
//     		var accumulate = "", monthlyGap =[], accumulatedGap=[], ratioMonth ="", ratioAccural="";
//     		$.each(data,function(i, v){
//     			var value = {
// 						  Level1 : v.Level1,
// 						  Level2 : v.Level2,
// 						  Level3 : v.Level3,
//  						  sum : v.SUM,
// 						  yearmonthdata : gpTarget.orderDatabyYear(v),
// 						  classes : "",
// 						  type : "",
// 				  };
//     			if(v.Level1.indexOf("Gap") < 0 ){
//     				if(v.Level1.indexOf("Ratio") < 0){
// 	    				if(v.Level2 != "Accumulated GP"){
// 	    					value.classes = (v.Level3 == "") ? "bgsum" : "";
// 	    					value.type= "GP";
// 	    					switch(v.Level3){
// 	    						case "" : newData[0] = value; break;
// 	    						case "Service" : newData[1] = value; break;
// 	    						case "License" : newData[2] = value; break;
// 	    						case "3rd Party" : newData[3] = value; break;
// 	    					}
// 	    				}else{
// 	    					value.classes = "bgsum";
// 	    					value.type = "accgap";
// 		    				accumulate = value;
// 	    				}
//     				}else{
//     					value.classes = "bgsum";
//     					value.type = "ratio";
//     					if(v.Level2 == "Monthly"){
//     						ratioMonth = value;
//     					}else{
//     						ratioAccural = value;
//     					}
//     				}
    				
//     			}else {
// 	    				value.classes = (v.Level3 == "") ? "bgsum" : "";
// 	    				value.type = "GAP";
// 	    				if(v.Level2 == "Accumulated Gap"){
// 	    					switch(v.Level3){
// 		    					case "" : accumulatedGap[0] = value; break;
// 		    					case "Service" : accumulatedGap[1] = value; break;
// 		    					case "License" : accumulatedGap[2] = value; break;
// 		    					case "3rd Party" : accumulatedGap[3] = value; break;
// 	    					}
// 	    				}
// 	    				else{
// 	    					switch(v.Level3){
// 		    					case "" : monthlyGap[0] = value; break;
// 		    					case "Service" : monthlyGap[1] = value; break;
// 		    					case "License" : monthlyGap[2] = value; break;
// 		    					case "3rd Party" : monthlyGap[3] = value; break;
//     						}
// 	    				}
    				
//     			}
	    		
//     		});
//     		var gap = $.merge(monthlyGap, accumulatedGap);
//     		newData.push(accumulate, ratioMonth, ratioAccural);
//     		return $.merge(newData,gap);
//     	},
    	
    	
    	
    	viewData : function(){
    		var planData = gpTarget.data.plan;
    		var typeData = gpTarget.data[$("#revenueRecog").val()];
    		//Render type Data
    		gpTarget.renderData(typeData, planData);
    	},
    	
    	renderData : function(actualData, planData){
    		$('.rowLeft > table.tblBorder, .rowBody>table.tblBorder').empty();
    		gpTarget.appendHeader();
    		var currency = $(".currency:checked").attr("id");
    		
    		//Render ActualData
    		$.each(actualData, function(i,v){
			    		var $leftTr = $("<tr>");
			    		$rightTr = $("<tr>");
    					var monthValue = gpTarget.orderDatabyYear(v);
		    			var sum = (currency == "krw") ? Yuga.commaSeparateNumber(v.SUM.toFixed(0)) : Yuga.commaSeparateNumber((v.SUM/gpTarget.exchangeRate).toFixed(2));
				
		    			$leftTr.append("<td>Actual</td><td>"+v.Level2+"</td><td>"+sum+"</td>")
			    		$.each(monthValue ,function(index,data){
					    	var value = (currency == "krw") ? Yuga.commaSeparateNumber(data.toFixed(0)) : Yuga.commaSeparateNumber((data/gpTarget.exchangeRate).toFixed(2));
					    	$rightTr.append("<td>"+value+"</td>");
    					});
				$('div.rowBody > table').append($rightTr);
				$('div.rowLeft > table').append($leftTr);
    		});
    		
    		$('div.rowLeft > table , div.rowBody > table').append("<tr><td></td></tr>"); // append Blank
    		
    		//Render PlanData
			$.each(planData, function(i,v){
	    		var $leftTr = $("<tr>"),
	    		$rightTr = $("<tr>");
    					var monthValue = gpTarget.orderDatabyYear(v);
		    			var sum = (currency == "krw") ? Yuga.commaSeparateNumber(v.SUM.toFixed(0)) : Yuga.commaSeparateNumber((v.SUM/gpTarget.exchangeRate).toFixed(2));
				
		    			$leftTr.append("<td>Plan</td><td>"+v.Level2+"</td><td>"+sum+"</td>")
			    		$.each(monthValue ,function(index,data){
				    		var value = (currency == "krw") ? Yuga.commaSeparateNumber(data.toFixed(0)) : Yuga.commaSeparateNumber((data/gpTarget.exchangeRate).toFixed(2));
				    		$rightTr.append("<td>"+value+"</td>");
    					});
				$('div.rowBody > table').append($rightTr);
				$('div.rowLeft > table').append($leftTr);
			});
	    		
    	},
    	
    	appendHeader : function(){
    		var $tr = $("<tr>");
    		$.each(gpTarget.monthsList, function(i,v){
    			$tr.append("<th class='alignCenter'>" +v.month +"-"+ v.year+ "</th>");
    		});
    		$('div.rowLeft > table').append("<tr><td colspan='2'></td><th class='alignCenter'>Sum</th></tr>");
    		$('div.rowBody > table').append($tr);
    	},
    	
    	orderDatabyYear : function(data){
    		var listorderData = [];
    		$.each(gpTarget.monthsList, function(i, v){
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
				gpTarget.monthsList.push( 
					{ 
						month: (("0" + (startDate.getMonth() + 1)).slice(-2) ),
						year: startDate.getFullYear()
					}
				);
			}
			
			do{
				startDate.addMonths( 1 );
				
				if( endDate.diffMonths( startDate ) > -1  ){
					gpTarget.monthsList.push( 
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
		gpTarget.init();
	});
</script>
