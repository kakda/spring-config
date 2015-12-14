<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.ExpenseReport .left {width: 100%;}
.ExpenseReport span.title {
			border-top : 0px;
			float : right;}
</style>
<table class="table table-noborder">
	<tr>
		<th><label for="year">Year:</label></th>
			<td>
				<select class="select" id="year">
<!-- 					<option>2013</option> -->
<!-- 					<option>2014</option> -->
<!-- 					<option>2015</option> -->
<!-- 					<option>2016</option> -->
<!-- 					<option>2017</option> -->
<!-- 					<option>2018</option> -->
<!-- 					<option>2019</option> -->
<!-- 					<option>2020</option> -->
				</select>
			</td>
		<th><label for="organization">Company:</label></th>
		<td>
			<input type="hidden" name="orgID" id="orgID"/>
			<input type="text" id="organization" readonly="readonly" class="text" />
		</td>
<!-- 		<th><label for="revenueRecog">Revenue Recog:</label></th> -->
<!-- 		<td> -->
<!-- 			<select class="select" id="revenueRecog"> -->
<!-- 				<option value="proportional">Proportional</option> -->
<!-- 				<option value="accrual">Accrual</option> -->
<!-- 			</select> -->
<!-- 		</td> -->
			<th><label for="currency">Currency</label></th>
			<td><input type="radio" id="krw" class='currency' name="currency" checked="checked"/><label for="krw">KRW</label><input type="radio" id='usd' class='currency' name='currency'/><label for='usd'> USD</label></td>
	</tr>
</table>

<div class="budgetExpense ExpenseReport">
	<div class="row-head left rowLeft">
		<span class='title'></span>
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
<!-- 	<div class="scrollable noRight rowBody"> -->
<!-- 		<table class="tblBorder"> -->
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
<!-- 		</table> -->
<!-- 	</div> -->
</div>


<script type="text/javascript">


	revenueTarget = {
			data : "",
			exchangeRate : "",
			monthsList : [],
	    	init : function(){
				this.bindEvent();
	    		this.initData();
	    	},
	    	
	    	initData : function(){
	    		var thisyear = new Date().getFullYear();
	    		var options="";
	    		for(var i=2012; i <= thisyear; i++){
					options += "<option value='"+i+"'>"+i+"</option>";
				}
	    		$('#year').html(options);
	    		$('#year').val(thisyear).trigger("change");
	    	},
	    	
	    	bindEvent : function(){
	    		
	    		
	    		// change year
	    		$("#year").off("change")
	    				  .on("change", function(){

		    		$.ajax({
		    			url : "<c:url value='/organization' />/"+ $("#year").val() + "/mcnc",
		    			dataType : "json",
		    			success : function(response){
		    				if(response){
							  	$("#organization").val(response.orgName);
							  	$("#orgID").val(response.orgID);
								revenueTarget.viewReport();	
		    				}
		    			}
		    		});
	    			
	    		});
	    		
	    		
	    		$('#revenueRecog, .currency').off("change").on('change',function(){
	    			if($('#orgID').val() != ""){
		    			revenueTarget.viewData();
	    			}
	    		});
	    	},
	    	
	    	//Get Report Project Cost	    	
	    	viewReport : function(){
	    		
	    		$.ajax({
	    			url : "<c:url value='/report' />/"+ $("#year").val() +"/" + $("#orgID").val() + "/revenueTarget",
	    			dataType : "json",
	    			success : function(response){
	    				revenueTarget.data = "";
	    				revenueTarget.prepareData(response);
	    			}
	    		});
	    	},
	    	
	    	prepareData : function(response){
	    		var accruals = [];
	    		var proportionals =[];
	    		var plans = [];
	    		$.each(response,function(index,value){
	    			if(value.exchangeRate != undefined){
	    				revenueTarget.exchangeRate = value.exchangeRate;
	    			}else if(value.Level1 == "Accrual" || value.Level3 == "Accrual" || value.Level1.indexOf("Accrual") >= 0){
	    				accruals.push(value);
	    			}else if(value.Level1 == "Plan"){
	    				plans.push(value);
	    			}else{
	    				proportionals.push(value);
	    			}
	    		});
	    		revenueTarget.data = {
	    			accrual : revenueTarget.orderData(accruals),
	    			proportional : revenueTarget.orderData(proportionals),
	    			plan : revenueTarget.orderData(plans),
	    		}
	    		revenueTarget.viewData();
	    	},
	    	
	    	orderData : function(data){
	    		var newData = [];
	    		$.each(data,function(i, v){
	    			var value = {
							  Level1 : v.Level1,
							  Level2 : v.Level2,
							  Level3 : v.Level3,
							  Revenue : v.Revenue,
							  classes : "",
					  };
	    			switch (v.Level3){
						case "" : {
								value.classes = 'bgSum';
								newData[0] = value;
								break;
							}
						case "Service(SI/SM)" : newData[1] = value; break;
						case "License" : newData[2] = value; break;
						case "3rd Party Solution" : newData[3] = value; break;
					}
	    		});
	    		return newData
	    	},
	    	
	    	
	    	
	    	viewData : function(){
	    		var planData = revenueTarget.data.plan;
	    		var typeData = revenueTarget.data['accrual'];
	    		//Render type Data
	    		revenueTarget.renderData(typeData, planData);
	    	},
	    	
	    	//Render Data
	    	renderData : function(actualData, planData){
	    		$('.rowLeft > table.tblBorder').empty();
	    		var spanText = "As of ";
	    		var monthNames = [ "January", "February", "March", "April", "May", "June",
	    		                   "July", "August", "September", "October", "November", "December" ];
	    		var date = new Date();
	    		if(date.getFullYear() == $("#year").val()){
	    			spanText +=  date.getDate() + " " + monthNames[date.getMonth()];
	    		}else{
	    			spanText += "31 December";
	    		}
	    		$('.rowLeft > span.title').text(spanText);
	    		var isExisitMM = true;
	    		var currency = $(".currency:checked").attr("id");
	    		$.each(actualData, function(i,v){
		    		if(v !=""){
		    			var value = (currency == "krw") ? Yuga.commaSeparateNumber(v.Revenue.toFixed(0)) : Yuga.commaSeparateNumber((v.Revenue/revenueTarget.exchangeRate).toFixed(2));; 
		    			var text = "";
		    			if(v.Level3 == ""){
		    				text = v.Level2;
		    			}else{
		    				text = v.Level3;
		    			}
				    	var $Tr = $("<tr class="+(v.classes != "" ? v.classes : "")+">"+(isExisitMM ? "<td>Actual</td>": "")+"<td class="+(isExisitMM ? "alignLeft": "")+">"+text+"</td><td>"+value+"</td></tr>");
				    	$('div.rowLeft > table').append($Tr);
				    	isExisitMM = false;
	    			} 
	    		});
	    		$('tr:first-child').find('td:eq(0)').attr('rowspan', actualData.length);
		    		
	    	},
	    	
	}


	$(document).ready(function(){
		revenueTarget.init();
	});
</script>
