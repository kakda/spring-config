<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<div class="content form-container project-budget project-member" id="tabsProBudget">  
	  <table id="budgetInfo" class="table table-noborder">
           <tr>
               <td>Project Start Date: <span id="startDate"></span></td>
               <td>Project End Date:    <span id="endDate"></span></td>
               <td class="right"><a id="tbnChangeOriginal" class="btn white" href="<c:url value='/project/update/O'/>">Original Plan Change</a></td>
           </tr>
           <tr>
               <td>Currency: <span id="currency"></span></td>
           </tr>
           <tr>
               <td>License Revenue: <span id="licenseRevenue"></span></td>
           </tr>
           <tr>
               <td>SI Revenue: <span id="siRevenue"></span></td>
               <td>SM Revenue: <span id="smRevenue"></span></td>
           </tr>
           <tr>
               <td>Outsource Revenue: <span id="outsourceRevenue"></span></td>
               <td class="internalRDRevenue">Internal R&D Revenue: <span id="internalRDRevenue"></span></td>
           </tr>
       </table>
       <div class="budgetExpense">
       		<div class="row-head left">
       			<table class="table table-border">
       				<colgroup>
       					<col style="width: 200px;" />
       					<col />
       				</colgroup>
       				<thead>
       					<tr class="divTitle">
       						<th class="widthLable invisible-border-bottom">Cost and Expense</th>
       						<td class="widthPlan invisible-border-bottom">Plan</td>
       					</tr>
       					<tr>
       						<td>&nbsp;</td>
       						<td>&nbsp;</td>
       					</tr>
       					<tr class="divSolution">
       						<th class="widthLable">3rd Party Solution</th>
       						<td class="widthPlan"><input type="text" class="text" id="vendorSolution" disabled="disabled" /></td>
       					</tr>
       					<tr class="divOutsource">
       						<th class="widthLable">3rd Party Outsourcing</th>
       						<td class="widthPlan"><input type="text" class="text" id="vendorOutSourcing" disabled="disabled" /></td>
       					</tr>
       					<tr class="divExpense">
       						<th class="widthLable">Project Expense</th>
       						<td class="widthPlan"><input type="text" class="text" id="expenseProject" disabled="disabled" /></td>
       					</tr>
       					<tr class="divOpex">
       						<th class="widthLable">Sales OPEX</th>
       						<td class="widthPlan"><input type="text" class="text" id="expenseOPEX" disabled="disabled" /></td>
       					</tr>
       					<tr class="divGross">
       						<th class="widthLable">Gross Profit</th>
       						<td class="widthPlan"><input type="text" class="text" id="grossProfit" disabled="disabled" /></td>
       					</tr>
       					<tr class="divNet">
       						<th class="widthLable">Net Profit</th>
       						<td class="widthPlan"><input type="text" class="text" id="netProfit" disabled="disabled" /></td>
       					</tr>
       				</thead>
       			</table>
       		</div>
       		<div class="scrollable">
       			<table class="table table-border">
       				<colgroup>
       				</colgroup>
       				<thead>
       					<tr>
       						<th>Actual</th>
       					</tr>
       				</thead>
       				<tbody>
			           <tr class="divTitle">
			               <td class="center widthSum">Sum</td>
			           </tr>
			           <tr class="divSolution">
			               <td class="center widthSum"><input type="text" class="text"  disabled="disabled"></td>
			           </tr>
			           <tr class="divOutsource">
			               <td class="center widthSum"><input type="text" class="text"  disabled="disabled"></td>
			           </tr>
			           <tr class="divExpense">
			               <td class="center widthSum"><input type="text" class="text"  disabled="disabled"></td>
			           </tr>
			           <tr class="divOpex">
			               <td class="center widthSum"><input type="text" class="text"  disabled="disabled"></td>
			           </tr>
			           <tr class="divGross">
			               <td class="center widthSum"><input type="text" class="text"  disabled="disabled"></td>
			           </tr>
			           <tr class="divNet">
			               <td class="center widthSum"><input type="text" class="text"  disabled="disabled"></td>
			           </tr>
       				</tbody>
       			</table>
       		</div>
       		<div class="row-head right">
       			<table class="table table-border">
       				<thead>
       					<tr class="divTitle">
       						<th class="invisible-border-bottom">Diff</th>
       						<th class="invisible-border-bottom">Ratio</th>
       					</tr>
       					<tr>
       						<td>&nbsp;</td>
       						<td>&nbsp;</td>
       					</tr>
       					<tr class="divSolution">
       						<th class="widthDiff"><input type="text" class="text" disabled="disabled"></th>
       						<th class="widthRatio"><input type="text" class="text" disabled="disabled"></th>
       					</tr>
       					<tr class="divOutsource">
       						<th class="widthDiff"><input type="text" class="text" disabled="disabled"></th>
       						<th class="widthRatio"><input type="text" class="text" disabled="disabled"></th>
       					</tr>
       					<tr class="divExpense">
       						<th class="widthDiff"><input type="text" class="text" disabled="disabled"></th>
       						<th class="widthRatio"><input type="text" class="text" disabled="disabled"></th>
       					</tr>
       					<tr class="divOpex">
       						<th class="widthDiff"><input type="text" class="text" disabled="disabled"></th>
       						<th class="widthRatio"><input type="text" class="text" disabled="disabled"></th>
       					</tr>
       					<tr class="divGross">
       						<th class="widthDiff"><input type="text" class="text" disabled="disabled"></th>
       						<th class="widthRatio"><input type="text" class="text" disabled="disabled"></th>
       					</tr>
       					<tr class="divNet">
       						<th class="widthDiff"><input type="text" class="text" disabled="disabled"></th>
       						<th class="widthRatio"><input type="text" class="text" disabled="disabled"></th>
       					</tr>
       				</thead>
       			</table>
       		</div>
       </div>
       
       <div class="clear"></div>

  		<div class="row">
  			<div class="col-6 pull-left">
  				<h3>Billing</h3> 
  			</div>
  		</div>
		<div class="row">
			<div class="col-12">
				<table class="table table-border" id="billTable">
					<tr>
					    <td rowspan="2" class="center">No</td>
					    <td colspan="2" class="center">Plan</td>
					    <td colspan="2" class="center">Actual</td>
						<td rowspan="2" class="center">Revenue Type</td>
						<td rowspan="2" class="center">Remark</td>
						<td rowspan="2" class="center">Action</td>
					</tr>
					<tr>
					    <td class="center widthMonth">Date</td>
					    <td class="center widthMonth">Amount</td>
					    <td class="center widthMonth">Date</td>
					    <td class="center widthMonth">Amount</td>
					</tr>
				</table>	
			</div>
		</div>  
		<div class="col-6">
				<button class="btn pull-right" id="addNewActual">Add New Billing</button>
  		</div>
</div>



<script type="text/javascript">
	$(document).ready(function(){
		$("#tabs").tabs({
			 active: 2,
			 activate : function(event, ui){
				 Yuga.redirect(url[ui.newPanel.selector]);
				
			 }
		});
		
		budgetPlan.init();
		
	});
	
	
	var budgetPlan = {
		removeBills : [],
		currency : null,
		init: function(){
			budgetPlan.viewRecord();
			budgetPlan.bindEvent();
			$(".widthDiff").find( "input" ).autoNumeric();
		},
		
		viewRecord: function(){
			var url = "<c:url value='/project/'/>" + page.projectID;
			$.get(url, function(json){
				if(json != null){
					
					budgetPlan.currency = json.currency;
					// view budget
					budgetPlan.viewBudgetRecord(json);
					
					// change format
					json.startDate = timeToString( json.startDate );
					json.endDate = timeToString( json.endDate );
					// show bedget into record
					$.each( json, function( key, value ){
						if(value != null){
							$( "#" + key  ).text( value );
							$( "#" + key  ).val( value );	
						}
					});

					// show bill records
				 	var bills = json.bills;
					budgetPlan.viewBills(bills); 

					// init date picker & numeric rule
					$(".date").datepicker();
					if( json.currency === currentUtil.unit.KRW ){
						$( "input[type=text], .billedAmount, .planBilledAmount, #budgetInfo td > span" ).autoNumeric({mDec:0});
					}else{
						$( "input[type=text], .billedAmount, .planBilledAmount, #budgetInfo td > span" ).autoNumeric();
					} 

					// hide R&D budget
					var isRnD = budgetPlan.isRnD(json.projectTypeID);
					if( !isRnD ){
						$(".internalRDRevenue").hide();
						
					}
					
				}
			});
			
		},
		
		
		isRnD : function(projectTypeId) {
			var url = "<c:url value='/projectType/'/>" + projectTypeId;
			var isRnD = false;
			$.ajax({
				type : "GET",
				url : url,
				contentType : "application/json",
				dataType : "json",
				cache : false,
				async : false,
				success : function(projecType) {
					isRnD = projecType.flag == CONSTANT.PROJECT_TYPE_RND;
				}
			});

			return isRnD;
		},
		
		viewBudgetRecord: function(json){
			// view plan gross profit
			var	revenue  = new Number(json.licenseRevenue) + new Number(json.smRevenue)
						+ new Number(json.siRevenue) + new Number(json.outsourceRevenue) 
						+ new Number(json.internalRDRevenue);
			var vendorExpense = new Number(json.vendorSolution) + new Number(json.vendorOutSourcing);
			var projectExpense = new Number(json.expenseProject) + new Number(json.expenseOPEX);
			var grossProfit =  revenue - ( vendorExpense + projectExpense  );
			var netProfit =  grossProfit;
			$( "#grossProfit" ).val(  grossProfit  );
			$( "#netProfit" ).val(  netProfit  );
			
			
			//view actual
			var months = budgetPlan.getDiffMonthList( timeToString(json.startDate), timeToString(json.endDate));

			$("#actualCount").attr("colspan", ( months.length + 1 ) );
			$(".scrollable .divTitle").closest("tbody").prev().find("th").attr("colspan", months.length+1);
			$(".scrollable .divTitle").closest("table").find("colgroup").append("<col />");
			
			$.each(months, function(index, object){
				var td = $("<td>");
				td.addClass("center");
				td.text(object.month + "-" + object.year);
				$(".scrollable .divTitle").find(".widthSum").before(td);
				$(".scrollable .divTitle").closest("table").find("colgroup").append("<col />");
				
				td = $("<td>");
				td.addClass("widthMonth");
				td.attr("month", object.month);
				td.attr("year", object.year);
				var input = $("<input>");
				input.addClass("vendorExpense");
				input.attr("type", 'text');
				input.addClass("text");
				td.html(input);
				$(".scrollable .divSolution").find(".widthSum").before(td);
				
				td = $("<td>");
				td.addClass("widthMonth");
				td.attr("month", object.month);
				td.attr("year", object.year);
				var input = $("<input>");
				input.addClass("outsourcingExpense");
				input.attr("type", 'text');
				input.addClass('text');
				td.html(input);
				$(".scrollable .divOutsource").find(".widthSum").before(td);
				
				td = $("<td>");
				td.addClass("widthMonth");
				td.attr("month", object.month);
				td.attr("year", object.year);
				var input = $("<input>");
				input.addClass("projectExpense");
				input.attr("type", 'text');
				input.addClass('text');
				td.html(input);
				$(".scrollable .divExpense").find(".widthSum").before(td);
				
				
				td = $("<td>");
				td.addClass("widthMonth");
				td.attr("month", object.month);
				td.attr("year", object.year);
				var input = $("<input>");
				input.addClass("opexExpense");
				input.attr("disabled", 'disabled');
				input.attr("type", 'text');
				input.addClass('text');
				td.html(input);
				$(".scrollable .divOpex").find(".widthSum").before(td); 
				
				
				td = $("<td>");
				td.addClass("widthMonth");
				td.attr("month", object.month);
				td.attr("year", object.year);
				var input = $("<input>");
				input.attr("type", 'text');
				input.addClass("grossProfit");
				input.attr("disabled", 'disabled');
				input.addClass('text');
				td.html(input);
				$(".scrollable .divGross").find(".widthSum").before(td); 
				
				
				td = $("<td>");
				td.addClass("widthMonth");
				td.attr("month", object.month);
				td.attr("year", object.year);
				var input = $("<input>");
				input.addClass("netProfit");
				input.attr("type", 'text');
				input.attr("disabled", 'disabled');
				input.addClass('text');
				td.html(input);
				$(".scrollable .divNet").find(".widthSum").before(td); 
			}); 
			
			budgetPlan.observerChange.init(json);

			var url = "<c:url value='/project/'/>" + page.projectID + "/budget/actual";
			$.get(url, function(array){
				$.each(array, function(index, actual){
					var year = actual.year;
					var month = actual.month;
					var tds = $("td[month=" + month + "][year=" + year + "]");
					
					tds.attr("budgetActualID", actual.budgetActualID);
					
					$.each(actual, function(att, val){
						var input = tds.find( "." + att );
						if( input[0] != null ){
							input.autoNumeric( "set", val );
							input.change();
						}
					});
				});
			});
			
		},
		
		viewBills: function(bills){

			var wrapper = $("<div>");
			var count = 0;
			$.each(bills, function(index, bill){
				var billedID = bill.billedID;
				
				if(bill.billedType == CONSTANT.BILL_PLAN_TYPE){
					
					var tr = $("<tr>");
					tr.attr("billedID", billedID);
					tr.attr("plannedBilledID", billedID);
					tr.addClass("billDataRow");

					var td = $("<td>");
					td.addClass("center widthMonth");
					td.text(++count);
					tr.append(td);
					
					td = $("<td>");
					td.addClass("widthMonth");
					td.text(timeToString(bill.billedDate));
					tr.append(td);
					
					td = $("<td>");
					td.addClass("widthMonth planBilledAmount");
					td.text(bill.billedAmount);
					tr.append(td);
					
					// check if have actual bill
					var hasActaul = false;
					$.each(bills, function(index, value){
						if(billedID == value.plannedBilledID && value.billedType == CONSTANT.BILL_ACTUAL_TYPE ){
							
							td = $("<td>");
							td.addClass("widthMonth");
							var billedDate = value.billedDate;
							var input = $("<input>");
							input.attr("value", timeToString(billedDate));
							input.addClass("date");
							input.addClass("billedDate");
							input.addClass('text');
							td.html(input);
							tr.append(td);
							
							td = $("<td>");
							td.addClass("widthMonth");
							var billedAmount = value.billedAmount;
							var input = $("<input>");
							input.addClass("billedAmount");
							input.addClass('text');
							input.attr("value", billedAmount);
							td.html(input);
							tr.append(td);

							// Added td of dropdown box for revenue type.
							td = $("<td>");
							td.addClass("widthMonth");
							var revenueType = bill.revenueType || '';
							var input = $("<input>");
							if(revenueType !== '') {
								revenueType = CONSTANT.REVENUETYPE(revenueType);
							}							
							input.attr("value", revenueType);
							input.attr("disabled", "disabled");
							input.addClass("revenueType");
							input.addClass('text');
							td.html(input);
							tr.append(td);							
							
							td = $("<td>");
							td.addClass("widthMonth");
							var remark = value.remark || '';
							var input = $("<input>");
							input.attr("value", remark);
							input.addClass("remark");
							input.addClass('text');
							td.html(input);
							tr.append(td);		
							
	 						td = $("<td>");
							td.addClass("widthMonth");
							tr.append(td);					
													
							var plannedBilledID = value.plannedBilledID;
							tr.attr("plannedBilledID", plannedBilledID);
							tr.attr("billedID", value.billedID);
							
							hasActaul = true;
						}
						
					});
					
					if(!hasActaul){
						
						td = $("<td>");
						td.addClass("widthMonth");
						var input = $("<input>");
						input.addClass("date");
						input.addClass("billedDate");
						input.addClass('text');
						td.html(input);
						tr.append(td);
						
						td = $("<td>");
						td.addClass("widthMonth");
						var input = $("<input>");
						input.addClass("billedAmount");
						input.addClass('text');
						td.html(input);
						tr.append(td);	
						
						// Added td of dropdown box for revenue type.
						td = $("<td>");
						td.addClass("widthMonth");
						var revenueType = bill.revenueType || '';
						var input = $("<input>");
						if(revenueType !== '') {
							revenueType = CONSTANT.REVENUETYPE(revenueType);
						}							
						input.attr("value", revenueType);
						input.attr("disabled", "disabled");
						input.addClass("revenueType");
						input.addClass('text');
						td.html(input);
						tr.append(td);						
						
						td = $("<td>");
						td.addClass("widthMonth");
						var remark = bill.remark || '';
						var input = $("<input>");
						input.attr("value", remark);
						input.addClass("remark");
						input.addClass('text');
						td.html(input);
						tr.append(td);
						
 						td = $("<td>");
						td.addClass("widthMonth");
						tr.append(td);
						tr.removeAttr("billedID");
					}
					
					wrapper.append(tr);
				}else if( (bill.plannedBilledID === undefined) && (bill.billedType == CONSTANT.BILL_ACTUAL_TYPE) ) {
					var tr = $("<tr>");
					tr.attr("billedID", billedID);
					tr.addClass('billDataRow');

					var td = $('<td>');
					td.addClass('center widthMonth no-border');
					td.attr('colspan', 3);
					tr.append(td);
					
					td = $("<td>");
					td.addClass("widthMonth");
					var billedDate = bill.billedDate;
					var input = $("<input>");
					input.attr("value", timeToString(billedDate));
					input.addClass("date");
					input.addClass("billedDate");
					input.addClass('text');
					td.html(input);
					tr.append(td);
					
					td = $("<td>");
					td.addClass("widthMonth");
					var billedAmount = bill.billedAmount;
					var input = $("<input>");
					input.addClass("billedAmount");
					input.addClass('text');
					input.attr("value", billedAmount);
					td.html(input);
					tr.append(td);

					// Added td of dropdown box for revenue type.
					td = $("<td>");
					td.addClass("widthMonth");
					var revenueType = bill.revenueType || '';
					var input = $("<input>");
					if(revenueType !== '') {
						revenueType = CONSTANT.REVENUETYPE(revenueType);
					}							
					input.attr("value", revenueType);
					input.attr("disabled", "disabled");
					input.addClass("revenueType");
					input.addClass('text');
					td.html(input);
					tr.append(td);							
					
					td = $("<td>");
					td.addClass("widthMonth");
					var remark = bill.remark || '';
					var input = $("<input>");
					input.attr("value", remark);
					input.addClass("remark");
					input.addClass('text');
					td.html(input);
					tr.append(td);
					
					td = $("<td>");
					td.addClass("widthMonth");
					var button = $('<button>');
					button.text('X');
					button.addClass('btn red btnDelete');
					td.html(button);
					tr.append(td);
					
					wrapper.append(tr);
				}
			});
			$("#billTable").append(wrapper.html());
			
		},
		// Pending task
		appendBillingRow : function(){
			var tr = $("<tr>");
			tr.addClass('billDataRow');

			var td = $('<td>');
			td.addClass('center widthMonth no-border');
			td.attr('colspan', 3);
			tr.append(td);
			
			var td = $('<td>');
			td.addClass('widthMonth');
			var input = $('<input>');
			input.attr('value', '');
			input.addClass('date billedDate text');
			td.html(input);
			tr.append(td);
						
			var td = $('<td>');
			td.addClass('widthMonth');
			var input = $('<input>');
			input.addClass('billedAmount text');
			td.html(input);
			tr.append(td);
			
			// Added dropdown box for revenue type.
			var td = $('<td>');
			td.addClass('widthMonth');
				var select = $('<select>'),
				items = CONSTANT.REVENUETYPE();
				$.each(items, function(value, text){
					select.append(new Option(text, value));
				});
			select.addClass('revenueType editable');
			td.html(select);
			tr.append(td);			
						
			// Added td of remark
			var td = $('<td>');
			td.addClass('widthMonth');
			var input = $('<input>');
			input.attr('value', '');
			input.addClass('remark text');
			td.html(input);
			tr.append(td);
			
			// Add td of delete button
			var td = $('<td>');
			td.addClass('widthMonth');
			var button = $('<button>');
			button.text('X');
			button.addClass('btn red btnDelete');
			td.html(button);
			tr.append(td);	
			
			return tr;
		},
		
		bindEvent: function(){
			$("#tbnChangeOriginal").click(function(){
				var href = $(this).attr( "href" );
				location.href = href;
			});
			
			$("#btnUpdate").click(function(){
				// update bills
				var updateBills = [];
				var createBills = [];
				var billTrs = $("#billTable").find(".billDataRow");
				$.each(billTrs, function(index, tr){
					var billedID = $(tr).attr("billedID");
					var plannedBilledID = $(tr).attr("plannedBilledID");
					
					var billedDate = $( tr ).find( ".billedDate").val();
					var billedAmount = $(tr).find(".billedAmount").autoNumeric("get");
					var revenueType = $(tr).find('.revenueType ').val();
						$.each(CONSTANT.REVENUETYPE(), function(key, text){
							if(revenueType === text){
								revenueType = key;
							}
						});
					var remark = $( tr ).find( ".remark").val();
					
					if(billedDate != "" && billedAmount != ""){
						var  bill = {
							billedDate: billedDate,
							billedAmount: billedAmount,
							remark: remark,
							billedType: CONSTANT.BILL_ACTUAL_TYPE
						};
						
						if( billedID != null){
							bill.billedID = billedID;
							updateBills.push(bill);
						}else{
							bill.plannedBilledID = plannedBilledID;
							bill.revenueType = revenueType;
							createBills.push(bill);
						}
					}
					
				});

				var url = "<c:url value='/project/'/>" + page.projectID + "/billings";
				if( createBills.length > 0 ){
					$.ajax( {
   						type			: "POST",
   						url				: url ,
   					    contentType		: "application/json",
   					    data			: JSON.stringify( createBills ),
   						dataType		: "json",
   						cache			: false,
   						async 			: false,
   						success: function( isCreate ){
   						}   
   					} ); 
				}
				
				if( updateBills.length > 0 ){
					$.ajax( {
   						type			: "PUT",
   						url				: url ,
   					    contentType		: "application/json",
   					    data			: JSON.stringify( updateBills ),
   						dataType		: "json",
   						cache			: false,
   						async 			: false,
   						success: function( isCreate ){
   						}   
   					} ); 
				}
				
				if(budgetPlan.removeBills.length > 0){
					$.ajax({
						type : "DELETE",
						url : url,
						contentType : "application/json",
						data : JSON.stringify(budgetPlan.removeBills),
						dataType : "json",
						cache : false,
						async : false,
						success : function(isCreate) {
						}
					});
				}
				
				var createBudgetActuals = [];
				var updateBudgetActuals = [];
				var vendors = $(".divSolution .vendorExpense");
				$.each(vendors, function(index, vendor){
					var vendorExpense = $(vendor).autoNumeric("get");
					var month = $(vendor).parent().attr("month");
					var year = $(vendor).parent().attr("year");
					var budgetActualID = $(vendor).parent().attr("budgetActualID");
						
					var data = {
						month: month,
						year: year,
						vendorExpense: vendorExpense
					};
					
					var outsources = $(".divOutsource .outsourcingExpense");
					$.each(outsources, function(index, outsource){
						if( month == $(outsource).parent().attr("month") &&
							year == $(outsource).parent().attr("year") ){
							
							data.outsourcingExpense = $(outsource).autoNumeric("get");
						}
					});
					
					
					var projectExpenses = $(".divExpense .projectExpense");
					$.each(projectExpenses, function(index, projectExpense){
						if( month == $(projectExpense).parent().attr("month") &&
							year == $(projectExpense).parent().attr("year") ){
							
							data.projectExpense = $(projectExpense).autoNumeric("get");
						}
					});
					
					
					var opexExpenses = $(".divOpex .opexExpense");
					$.each(opexExpenses, function(index, opexExpense){
						if( month == $(opexExpense).parent().attr("month") &&
							year == $(opexExpense).parent().attr("year") ){
							
							data.opexExpense = $(opexExpense).autoNumeric("get");
						}
					});
					
					
					if( budgetActualID != null && budgetActualID != "" ){
						data.budgetActualID = budgetActualID;
						updateBudgetActuals.push(data);
					}else{
						createBudgetActuals.push(data);
					}
					
				});
				//console.log(createBudgetActuals);
				//console.log(updateBudgetActuals);
				//return;
				url = "<c:url value='/project/'/>" + page.projectID + "/budget/actual";
				if( createBudgetActuals.length > 0 ){
					$.ajax( {
   						type			: "POST",
   						url				: url ,
   					    contentType		: "application/json",
   					    data			: JSON.stringify( createBudgetActuals ),
   						dataType		: "json",
   						cache			: false,
   						async 			: false,
   						success: function( isCreate ){
   						}   
   					} ); 
				}
				
				if( updateBudgetActuals.length > 0 ){
					$.ajax( {
   						type			: "PUT",
   						url				: url ,
   					    contentType		: "application/json",
   					    data			: JSON.stringify( updateBudgetActuals ),
   						dataType		: "json",
   						cache			: false,
   						async 			: false,
   						success: function( isCreate ){
   						}   
   					} ); 
				}
				
				
				if( tabUtil.hasNext() ){
	    			tabUtil.next();
	    		}
				
				
			});
			
			// Append new row after button addNewActual click
			$('#addNewActual').on('click', function(){
				var $newRow = budgetPlan.appendBillingRow();
				$('#billTable').append($newRow);
				$('.date').not('.hasDatepicker').datepicker();

				if( budgetPlan.currency === currentUtil.unit.KRW ){
					$newRow.find(".billedAmount").autoNumeric({mDec:0});
				}else{
					$newRow.find(".billedAmount").autoNumeric();
				}
			});
			
			
			//Delegate button delete event
			$('#billTable').on('click', '.btnDelete', function(){
				var $tr = $(this).closest("tr");
				var billedID = $tr.attr("billedid");
				
				if(billedID != null){
					budgetPlan.removeBills.push({
						billedID : billedID
					});	
				}
				$tr.remove();
			});
		},
		
		
		/* Observes the change of pair of observable & observer 
		   @param observables
		   @param observers
		   observable & observer are DOM Jquery Objects
		*/
		observerChange:{
			init: function( json ){
				var months = budgetPlan.getDiffMonthList( timeToString(json.startDate), timeToString(json.endDate) );

				budgetPlan.observerChange.profit.init(json);

				$.each(months, function(index, element){
					var year = element.year;
					var month = element.month;
					budgetPlan.observerChange.registerObserver(month, year);
				});
			},
			
			profit: {
				revenue: null,
				months: null,
				init: function(json){
					var	revenue  = new Number(json.licenseRevenue) + new Number(json.smRevenue)
						+ new Number(json.siRevenue) + new Number(json.outsourceRevenue) 
						+ new Number(json.internalRDRevenue);
					
					var months = budgetPlan.getDiffMonthList( timeToString(json.startDate), timeToString(json.endDate) );
					budgetPlan.observerChange.profit.revenue = revenue;
					budgetPlan.observerChange.profit.months = months;
					
					budgetPlan.observerChange.profit.change();
					
				},
				change: function(){
					
					// change profit data
					
					
					var revenue = budgetPlan.observerChange.profit.revenue;
					var months = budgetPlan.observerChange.profit.months;
	
					var leftProfit = revenue;
					var totalGrossProfit= 0;
 					$.each(months, function(index, element){
						var tds = $("td[month=" + element.month + "][year=" + element.year + "]");
						
						var vendorExpense = 0; 
						try{
							vendorExpense = new Number( tds.find( ".vendorExpense" ).autoNumeric("get") || 0 );
						}catch(ex){
							vendorExpense = new Number( tds.find( ".vendorExpense" ).val() || 0 );
						}
						
						var outsourcingExpense = 0;
						try{
							outsourcingExpense = new Number( tds.find( ".outsourcingExpense" ).autoNumeric("get") || 0 );
						}catch(ex){
							outsourcingExpense = new Number( tds.find( ".outsourcingExpense" ).val() || 0);
						}
						
						
						var projectExpense = 0;
						try{
							projectExpense = new Number( tds.find( ".projectExpense" ).autoNumeric("get") || 0 );
						}catch(ex){
							projectExpense = new Number( tds.find( ".projectExpense" ).val() || 0);
						}


						var opexExpense = 0;
						try{
							opexExpense = new Number( tds.find( ".opexExpense" ).autoNumeric("get") || 0 );
						}catch(ex){
							opexExpense = new Number( tds.find( ".opexExpense" ).val() || 0);
						}
						
						
						var expenseTotal = vendorExpense + outsourcingExpense + projectExpense + opexExpense;
						
						var grossProfit = leftProfit - expenseTotal;
						
						
						try{
							tds.find( ".grossProfit" ).autoNumeric( "set", grossProfit );
							tds.find( ".netProfit" ).autoNumeric( "set", grossProfit );
						}catch(ex){
							tds.find( ".grossProfit" ).val( grossProfit );
							tds.find( ".netProfit" ).val( grossProfit );
						}
						
						
						leftProfit = grossProfit;
						totalGrossProfit = leftProfit;
					}); 
 					
 					
 					var divGross = $(".divGross");
 					try{
 						divGross.find(".widthSum input").autoNumeric( "set", totalGrossProfit );
 						
 						var plan = new Number(  divGross.find(".widthPlan input").autoNumeric("get") );
 						var diff = totalGrossProfit - plan;
 						divGross.find(".widthDiff input").autoNumeric("set", diff );
 						var percentage = Math.round( ( totalGrossProfit / plan ) * 100 );
 						if( isFinite( percentage ) ){
	 						divGross.find(".widthRatio input").val( percentage + "%" );
 						}else{
 							divGross.find(".widthRatio input").val( "Infinity" );
 						}
 						
 					}catch( ex ){
 						divGross.find(".widthSum input").val( totalGrossProfit );
 						var plan = new Number(  divGross.find(".widthPlan input").val() );
 						var diff = totalGrossProfit - plan;
 						divGross.find(".widthDiff input").val( diff );
 						var percentage = Math.round( ( totalGrossProfit / plan ) * 100 );
 						if( isFinite( percentage ) ){
 							divGross.find(".widthRatio input").val( percentage + "%" );
 						}else{
 							divGross.find(".widthRatio input").val( "Infinity" );
 						}
 					}
 					
 					
 					var divGross = $(".divNet");
 					try{
 						divGross.find(".widthSum input").autoNumeric( "set", totalGrossProfit );
 						
 						var plan = new Number(  divGross.find(".widthPlan input").autoNumeric("get") );
 						var diff = totalGrossProfit - plan;
 						divGross.find(".widthDiff input").autoNumeric("set", diff );
 						var percentage = Math.round( ( totalGrossProfit / plan ) * 100 );
 						if( isFinite( percentage ) ){
	 						divGross.find(".widthRatio input").val( percentage + "%" );
 						}else{
 							divGross.find(".widthRatio input").val( "Infinity" );
 						}
 						
 					}catch( ex ){
 						divGross.find(".widthSum input").val( totalGrossProfit );
 						var plan = new Number(  divGross.find(".widthPlan input").val() );
 						var diff = totalGrossProfit - plan;
 						divGross.find(".widthDiff input").val( diff );
 						var percentage = Math.round( ( totalGrossProfit / plan ) * 100 );
 						if( isFinite( percentage ) ){
	 						divGross.find(".widthRatio input").val( percentage + "%" );
 						}else{
 							divGross.find(".widthRatio input").val( "Infinity" );
 						}
 					}
 					
				}
			},
			
			registerObserver: function( month, year ){
				var tds = $("td[month=" + month + "][year=" + year + "]");
				tds.on( 'change', 'input', function(){
					
					// change row of changed input
					
					
					var trs = $(this).parent().parent();
					var type = $(this).attr("class");
					
					var expenses = trs.find( "." + type.split(" ")[0] );
					var expenseTotal = 0;
					$.each( expenses, function(index, expense){
						expenseTotal += new Number( Yuga.removeComma($( expense ).val()));
					});
					
					trs.find(".widthSum input").autoNumeric( "set", expenseTotal );
					
					var plan = new Number( Yuga.removeComma($("." + trs.attr("class")).find(".widthPlan input").val()));
					var diff = expenseTotal - plan;
					$("." + trs.attr("class")).find(".widthDiff input").autoNumeric("set", diff );
					
					var percentage = Math.round( ( expenseTotal / plan ) * 100 );
					if( isFinite( percentage ) ){
						$("." + trs.attr("class")).find(".widthRatio input").val( percentage + "%" );
					}else{
						$("." + trs.attr("class")).find(".widthRatio input").val( "Infinity" );
					}
					
					budgetPlan.observerChange.profit.change();
					
				} );
			}
			
			
		},
		
		getDiffMonthList: function( startStr, endStr ){
			var monthsList = [];
			
			var startDate = startStr.toDate();
			startDate.setDate(1);
			var endDate = endStr.toDate();
			endDate.setDate(1);
			
			// add start month
			if( endDate.diffMonths( startDate ) > -1  ){
				monthsList.push( 
					{ 
						month: ( startDate.getMonth() + 1 ),
						year: startDate.getFullYear()
					}
				);
			}
			
			do{
				startDate.addMonths( 1 );
				
				if( endDate.diffMonths( startDate ) > -1  ){
					monthsList.push( 
						{ 
							month: ( startDate.getMonth() + 1 ),
							year: startDate.getFullYear()
						}
					);
				}
				else{
					break;
				}
			}
			while( true );
			
			return monthsList;
		}
	};
	
	var currentUtil = {
		unit: {
			KRW: "KRW",
			USD: "USD"
		},
		
		commaSeparateNumber: function( val ){
		    while (/(\d+)(\d{3})/.test(val.toString())){
		      val = val.toString().replace(/(\d+)(\d{3})/, '$1'+','+'$2');
		    }
		    return val;
		}
	};
	
</script>