<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<form class="content form-container project-budget" id="tabsProBudget">  
	<div class="info">
		
		 <p>Project Number: <span id="projectID"></span></p>
		 <p>Project Name: <span id="projectName"></span></p>
        <p>Project Period: <span id="startDate"></span> - <span id="endDate"></span></p>
        <div class="currency">Currency:
        	<span><input type="radio"  name="currency" value="KRW" checked="checked">KRW</span>
        	<span><input type="radio"  name="currency" value="USD">USD</span>
        </div>
	</div>  	
    <div class="leftSide">
        <fieldset>
            <legend>Revenue</legend>
            <table class="form">
            	<colgroup>
            		<col width="150" />
            		<col width="50" />
            		<col />
            	</colgroup>
            	<tr>
            		<td><label for="licenseRevenue">License Revenue:</label></td>
            		<td class="unitText"></td>
            		<td><input type="text" class="text numeric" name="licenseRevenue" id="licenseRevenue"/></td>
            	</tr>
            	<tr>
            		<td><label for="licenseRevenue">SI Revenue:</label></td>
            		<td class="unitText"></td>
            		<td><input type="text" class="text numeric" name="siRevenue" id="siRevenue"/></td>
            	</tr>
            	<tr>
            		<td><label for="smRevenue">SM Revenue:</label></td>
            		<td class="unitText"></td>
            		<td><input type="text" class="text numeric" name="smRevenue" id="smRevenue" /></td>
            	</tr>
            	<tr>
            		<td><label for="outsourceRevenue">3rd party Solutions Revenue:</label></td>
            		<td class="unitText"></td>
            		<td><input type="text" class="text numeric" name="outsourceRevenue" id="outsourceRevenue"/></td>
            	</tr>
            	<tr class="internalRDRevenue">
            		<td><label for="internalRDRevenue">Internal R&amp;D Revenue:</label></td>
            		<td class="unitText"></td>
            		<td><input type="text" class="text numeric" name="internalRDRevenue" id="internalRDRevenue" /></td>
            	</tr>
            	
            </table>
        </fieldset>
        <fieldset>
            <legend>3rd Party Cost</legend>
            <table class="form">
            	<colgroup>
            		<col width="150" />
            		<col width="50" />
            		<col />
            	</colgroup>            	
            	<tr>
            		<td><label for="vendorSolution">Solution:</label></td>
            		<td class="unitText"></td>
            		<td><input type="text" class="text numeric" name="vendorSolution" id="vendorSolution" /></td>
            	</tr>
            	<tr>
            		<td><label for="vendorOutSourcing">Outsourcing:</label></td>
            		<td class="unitText"></td>
            		<td><input type="text" class="text numeric" name="vendorOutSourcing" id="vendorOutSourcing" /></td>
            	</tr>
            </table>
        </fieldset>
        <fieldset>
            <legend>Expense</legend> 
            <table class="form">
            	<colgroup>
            		<col width="150" />
            		<col width="50" />
            		<col />
            	</colgroup>            	
            	<tr>
            		<td><label for="expenseProject">Project:</label></td>
            		<td class="unitText"></td>
            		<td><input type="text" class="text numeric" name="expenseProject" id="expenseProject" /></td>
            	</tr>
            	<tr>
            		<td><label for="expenseOPEX">Sales OPEX:</label></td>
            		<td class="unitText"></td>
            		<td><input type="text" class="text numeric" name="expenseOPEX" id="expenseOPEX" /></td>
            	</tr>
            </table>
        </fieldset>
        
        <div class="profit">
            <table class="form">
            	<colgroup>
            		<col width="150" />
            		<col width="50" />
            		<col />
            	</colgroup>            	
            	<tr>
            		<td>Gross Profit:</td>
            		<td class="unitText"></td>
            		<td><input type="text" class="text numeric" name="grossProfit" disabled="disabled" id="grossProfit" /></td>
            	</tr>
<!--             	<tr>
            		<td>Net. Profit:</td>
            		<td class="unitText"></td>
            		<td><input type="text" class="text" name="grossProfit" disabled="disabled" id="netProfit" /></td>
            	</tr> -->
            </table>
        </div>
    </div>
    <div class="rightSide">
        <div>
            <h3 class="tit">Billing</h3>
            
            <table id="billingGrid"></table>
            <button id="btnAdd" type="button" class="btn white">Add</button>
            
        </div>
    </div>
</form>



<script type="text/javascript">
	$(document).ready(function(){
		$("#tabs").tabs({
			 active: 2,
			 beforeActivate : function(event, ui){
				
				Yuga.redirect(url[ui.newPanel.selector]);
				return true;
				
			 }
		});
		
		budgetPlan.init();
		
	});
	
	var budgetPlan = {
		init: function(){
			// init defaul currency
			budgetPlan.changeCurrencyText();

			budgetPlan.bindEvent();
			budgetPlan.viewData();
		},
		
		opexCharges : [],
		
		validate: function(){
			var form = $( '#tabsProBudget' ),
			arr = form.find( "input" ),
        	rule = {};
			form.removeData('validator');
	        var validator = form.validate({
				ignore: '',
				rules: rule
			});
			
			// Defined variables of revenue details
			var licenseRevenue = parseInt( $( "#licenseRevenue" ).autoNumeric("get") ) || 0,
				siRevenue = parseInt( $( "#siRevenue" ).autoNumeric("get") ) || 0,
				smRevenue = parseInt( $( "#smRevenue" ).autoNumeric("get") ) || 0,
				outsourceRevenue = parseInt( $( "#outsourceRevenue" ).autoNumeric("get") )|| 0,
				internalRDRevenue = parseInt( $('#internalRDRevenue').autoNumeric('get') ) || 0;
			
			// Defined variables of billing details
			var totalLicenseRevenue = 0, 
				totalSiRevenue = 0,
				totalSmRevenue = 0,
				totalOutsourceRevenue = 0,
				totalInternalRDRevenue = 0,
				totalBill = 0,
				checkDate = false,
				
				// Get tr collections from localgrid.
				billingRows = $(localGrid.gridId).find('tr');
			
				$.each(billingRows, function(index, value) {
					 var billedDate = $(value).children('td').find('input[name=billedDate]');
					 var billed = $(value).children('td').find( 'input[name=billedAmount]' );
					if((billedDate.val() == "") || (billedDate.val() == 'undefined')) {
						billedDate.focus();
						checkDate = true;
					}else if(billed.val() == "" || (billed.val() == 'undefined')) {
						billed.focus();
						billed.attr('placeholder', 'Required...');
						checkDate = true;
					}
					var revenueType = $(value).children('td').find( 'select[name=revenueType]' ).children("option").filter(":selected").text();
					var input = $(value).children('td').find( 'input[name=billedAmount]' ).val();
					if( (typeof input === 'string') && (input != '') ) {
						var billedAmount = parseInt(input.replace(/,/g, ''));
	 					totalBill += billedAmount;
	 					switch( revenueType ){
							case CONSTANT.REVENUETYPE('LICENSE'): 
								totalLicenseRevenue += billedAmount;
								break;
							case CONSTANT.REVENUETYPE('SI'): 
								totalSiRevenue += billedAmount;
								break;
							case CONSTANT.REVENUETYPE('SM'): 
								totalSmRevenue += billedAmount;
								break;
							case CONSTANT.REVENUETYPE('OUT_SOURCE'): 
								totalOutsourceRevenue += billedAmount;
								break;
							case CONSTANT.REVENUETYPE('INTERNAL_RD'):
								totalInternalRDRevenue += billedAmount;
								break;								
						}
					}
				});
			if(checkDate) {
				checkDate = false;
				return;
			}else {
				// Check if totalLicenseRevenue dose not match
				if( totalLicenseRevenue != licenseRevenue ) {
					var message = "The License Revenue dose not match total License amount of billing. ";
					var amount = parseInt( licenseRevenue - totalLicenseRevenue );
						if(amount > 0){
							Yuga.dialog.alert(  message + "The remain amount is " + amount );
						}else {
							Yuga.dialog.alert( message + "The insufficient mount is " + amount );
						}
					return false;
				}
				// Check if totalSiRevenue dose not match
				if( totalSiRevenue != siRevenue ) {
					var message = "The SI Revenue dose not match total SI amount of billing. ";
					var amount = parseInt( siRevenue - totalSiRevenue );
						if( amount > 0 ) {
							Yuga.dialog.alert( message + "The remain amount is " + amount );
						}else {
							Yuga.dialog.alert( message + "The insufficient amount is " + amount );
						}
					return false;
				}
				// Check if totalSmRevenue dose not match
				if( totalSmRevenue != smRevenue ) {
					var message = "The SM Revenue dose not match total SM amount of billing. ";
					var amount = parseInt( smRevenue - totalSmRevenue );
						if( amount > 0 ) {
							Yuga.dialog.alert( message + "The remain amount is " + amount );
						}else {
							Yuga.dialog.alert( message + "The insufficient amount is " + amount );
						}
					return false;
				}
				// Check if totalOutsourceRevenue dose not match
				if( totalOutsourceRevenue != outsourceRevenue ) {
					var message = "The Outsource Revenue dose not match total Outsource amount of billing. ";
					var amount = parseInt( outsourceRevenue - totalOutsourceRevenue );
						if( amount > 0 ) {
							Yuga.dialog.alert( message + "The remain amount is " + amount );
						}else {
							Yuga.dialog.alert( message + "The insufficient amount is " + amount );
						}
					return false;
				}
				// Check if totalInternalRDRevenue dose not match
				if( totalInternalRDRevenue != internalRDRevenue ) {
					var message = "The Internal R&D Revenue dose not match total Internal R&D amount of billing. ";
					var amount = parseInt( internalRDRevenue - totalInternalRDRevenue );
						if( amount > 0 ) {
							Yuga.dialog.alert( message + "The remain amount is " + amount );
						}else {
							Yuga.dialog.alert( message + "The insufficient amount is " + amount );
						}
					return false;
				}
				// Check if totalBill dose not match
				var revenue = budgetPlan.totalRevenue();
				if( totalBill !=  revenue) {
					var message = "The total revenue dose not match total of billing amount. ";
					var amount = parseInt( revenue - totalBill );
						if(amount > 0) {
							Yuga.dialog.alert( message + "The remain amount is " + amount );
						}else {
							Yuga.dialog.alert( message + "The insufficient amount is " + amount );
						}
					return false;	
				}
			}
			
	    	// Return validated
	        return validator.form();
		},
		
		viewData: function(){
			
			var url = "<c:url value='/project/'/>" + page.projectID;
			$.get(url, function(json){

				if( json != null ){
					budgetPlan.opexCharges = budgetPlan.ajaxRequest(json);
					//budgetPlan.opexCharges.push({'startDate' : json.startDate, 'endDate' : json.endDate});
					
					json.startDate = timeToString(json.startDate);
					json.endDate = timeToString(json.endDate);
					
					$( "[value="  + json.currency + "]:input").prop('checked', true );

					$.each( json, function( key, value ){
						switch(key) {
							case "projectID" :
							case "projectName" :
							case "startDate" : 
							case "endDate" :
								$( "#" + key  ).text( value ); 
								break;
							default : 
								$( "#" + key  ).val( currentUtil.commaSeparateNumber(value) ); 
								break;
						}
					});

					// View bills
					var bills = [];
					for(var i = 0; i < json.bills.length; i++) {
						if(json.bills[i].billedType == CONSTANT.BILL_PLAN_TYPE){
							bills.push(json.bills[i]);
						}
					}
					localGrid.init(bills);
					
					// hide R&D budget
					var isRnD = budgetPlan.isRnD(json.projectTypeID);
					var grossProfit = budgetPlan.totalRevenue() - ( budgetPlan.totalThirdParty() + budgetPlan.totalExpense() );
					if( !isRnD ){
						$("#internalRDRevenue").val(0);
						$(".internalRDRevenue").hide();
						
					}
					$( '#grossProfit' ).val( currentUtil.commaSeparateNumber( grossProfit ));
				
					// Initializ value and currency
					$( ".unitText" ).text( json.currency );
					budgetPlan.changeCurrencyText();
				}
				
			});
		},

		bindEvent : function() {
			// register observer changed
			var array = new Array();
			array.push( { observable : $("#licenseRevenue"), observer : $("#grossProfit") });
			array.push( { observable : $("#smRevenue"), observer : $("#grossProfit") });
			array.push( { observable : $("#siRevenue"), observer : $("#grossProfit")});
			array.push( { observable : $("#outsourceRevenue"), observer : $("#grossProfit") });
			array.push( { observable : $("#internalRDRevenue"), observer : $("#grossProfit") });
			array.push( { observable: $( "#vendorSolution" ), observer: $( "#grossProfit" )} );
			array.push( { observable: $( "#vendorOutSourcing" ), observer: $( "#grossProfit" )} );
			array.push( { observable: $( "#expenseProject" ), observer: $( "#grossProfit" )} );
			array.push( { observable: $( "#expenseOPEX" ), observer: $( "#grossProfit" ), inject : "expenseOPEX"} );

			budgetPlan.observeChange(array);

			// registered changes of currency
			$($("input[name=currency]")).change(function() {

				// change currency text
				budgetPlan.changeCurrencyText();

			});

			$("#btnAdd").click(function() {
				localGrid.addNewRow();
			});

			$("#btnUpdate").click( function(event) {

				var isValid = budgetPlan.validate();
				if (isValid) {
					var budgetInfo = {};
					var inputs = $(".leftSide").find("input.numeric");
					$.each(inputs, function(index, value) {
						budgetInfo[$(value).attr("name")] = $(value).autoNumeric("get");
					});
					
					
					var currency = $( "[name=currency]:input:checked" ).val();
					budgetInfo.currency = currency;		
					var url = '<c:url value="/project/"/>'+ page.projectID + "/budget";

					$.ajax({
						type : "PUT",
						url : url,
						contentType : "application/json",
						data : JSON.stringify(budgetInfo),
						dataType : "json",
						cache : false,
						success : function(isUpdate) {
							
							if (isUpdate) {

								var url = '<c:url value="/project/"/>' + page.projectID + "/billings";
								var updateBills = [];
								var createBills = [];
								
								$.each(localGrid.data, function( index,bill) {
									if (bill.billedID != null && bill.billedID != "" && bill.billedID != false) {
										updateBills.push(bill);
									} else {
										createBills.push(bill);
									}
								});

								if (createBills.length > 0) {
									$.ajax({
										type : "POST",
										url : url,
										contentType : "application/json",
										data : JSON.stringify(createBills),
										dataType : "json",
										cache : false,
										async : false,
										success : function(isCreate) {
										}
									});
								}

								if (updateBills.length > 0) {
									$.ajax({
										type : "PUT",
										url : url,
										contentType : "application/json",
										data : JSON.stringify(updateBills),
										dataType : "json",
										cache : false,
										async : false,
										success : function(isCreate) {
										}
									});
								}

								if (localGrid.removeBills.length > 0) {
									$.ajax({
										type : "DELETE",
										url : url,
										contentType : "application/json",
										data : JSON
												.stringify(localGrid.removeBills),
										dataType : "json",
										cache : false,
										async : false,
										success : function(
												isCreate) {
										}
									});
								}

								var newUrl = "<c:url value='/project/update/' />" + CONSTANT.PROJECT_STATUS_BUDGET;
								location.href = newUrl;
							} else {
								Yuga.dialog.alert("Project budget updated fail.");
							}
						}
					});
				}
			});

		},
		
		changeCurrencyText: function(){
			var currency = $( "[name=currency]:input:checked" ).val();
			$( ".unitText" ).text( currentUtil.text[ currency ] );
			
			try{
				var arr = $( ".numeric" );
				$.each( arr, function(index, value){
					$(value).val($(value).autoNumeric("get"));
				});
				
				$( ".numeric" ).autoNumeric('destroy');
			}catch( ex){
				
			}
			
			if( currency === currentUtil.unit.KRW ){
				$( ".numeric" ).autoNumeric({mDec:0});
			}else{
				$( ".numeric" ).autoNumeric();
			} 
		},		
		
		// Find total revenue
		totalRevenue : function() {
			var total = ( parseInt( $( "#licenseRevenue" ).autoNumeric("get") ) || 0 ) 
			+ ( parseInt($( "#smRevenue" ).autoNumeric("get") )|| 0 ) 
			+ ( parseInt( $( "#siRevenue" ).autoNumeric("get"))|| 0 )
			+ ( parseInt($( "#outsourceRevenue" ).autoNumeric("get") )|| 0 ) 
			+ ( parseInt( $( "#internalRDRevenue" ).autoNumeric("get"))|| 0 );
			
			return total;
		},
		
		// Find total third party
		totalThirdParty : function() {
			var total = ( parseFloat( $('#vendorSolution').autoNumeric('get')) || 0 )  
			+ ( parseFloat( $('#vendorOutSourcing').autoNumeric('get')) || 0 );
			
			return total;
		},
		
		// Find total expense
		totalExpense : function() {
			var total = (parseFloat( $('#expenseProject').autoNumeric('get')) || 0 ) 
			//+ ( parseInt( $('#expenseOPEX').autoNumeric('get')) || 0 );
			return total;
		},

		
		// Return Sale Opex
		getSaleOpex : function() {
			return parseFloat($('#expenseOPEX').autoNumeric('get')) || 0;
		},

		/* Observes the change of pair of observable & observer.*/
		observeChange : function(array) {
			// observes when observable is changeed on Keyup & change event
			$.each(array, function(index, value) {
				value.observable.on( "change", function( event ) {
					event.preventDefault();
					
					if($(this).attr("id") != value.inject){
						
						// expenseOPEX display value when observable is changed on keyup & changed event.
						$('#expenseOPEX').val(currentUtil.commaSeparateNumber(opexCharge.getOpexChargeFilter()));
					}
					
					// grossProfile display value when it observable is changed on keyup & changed event.
					var grossProfit = budgetPlan.totalRevenue() - (budgetPlan.totalThirdParty() + budgetPlan.totalExpense());
					$( '#grossProfit' ).val( currentUtil.commaSeparateNumber( grossProfit ));
					
					budgetPlan.changeCurrencyText();
					
				});
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
		
		ajaxRequest : function(json) {
			var response = [];
			var url = '<c:url value="/opexCharge"/>/' + new Date(json.startDate).getFullYear() + "/year";
			$.ajax({
				type : "GET",
				url : url,
				contentType : "application/json",
				dataType : "json",
				async : false,
				success : function(result) {
					$.each(result, function(key, value){
						response[value.gpType] = value.rate/100;
					});
				}
			});
			return response;
		}	

	};

	var currentUtil = {
		unit : {
			KRW : "KRW",
			USD : "USD"
		},

		text : {
			KRW : "KRW",
			USD : "USD($)"
		},
		commaSeparateNumber : function(val) {
			if(val == null || val == undefined){
				val = 0;
			}
			while (/(\d+)(\d{3})/.test(val.toString())) {
				val = val.toString().replace(/(\d+)(\d{3})/, '$1' + ',' + '$2');
			}
			return val;
		}
	};

	var localGrid = {
		gridId : "#billingGrid",
		data : [],
		removeBills : [],
		
		init : function(data) {
		
			localGrid.data = data || [];
			
			$.each(localGrid.data, function(index, element) {
				element.billedDate = timeToString(element.billedDate);
			});

				
			$(localGrid.gridId).jqGrid(
				{
					datatype : "local",
					data : localGrid.data,
					colNames : [ 'billedID', 'No', 'Date', 'Amount', 'Revenue Type', 'Delete' ],
					colModel : [

							{
								name : 'billedID',
								index : 'billedID',
								hidden : true
							},

							{
								name : 'no',
								width : 45,
								align : "center",
								formatter : function(cellvalue,
										options, rowObject) {
									return options.rowId;
								}
							},

							{
								name : 'billedDate',
								index : 'billedDate',
								align : "center",
								width : 80,
								editable : true,
								edittype : 'text',
								editoptions : {
									dataInit : function(el) {
										try {
											$(el).autoNumeric(
													'destroy');
										} catch (ex) {

										}
										$(el).prop("disabled");
										$(el).datepicker();
									}
								}
							},
							{
								name : 'billedAmount',
								index : 'billedAmount',
								width : 100,
								editable : true,
								edittype : 'text',
								editoptions : {
									dataInit : function(el) {
										$(el).addClass('numeric');
										var currency = $("[name=currency]:input:checked").val();
										if (currency === currentUtil.unit.KRW) {
											$(el).autoNumeric({ mDec : 0 });
										} else {
											$(el).autoNumeric();
										}
									}
								}
							},
							{
								name : 'revenueType',
								index : 'revenueType',
								width : 125,
				                sortable: false, 
				                editable: true, 
				                edittype: "select", 
				                editoptions: {
				                	value : data.revenueType
				                }
							},
							{
								width : 60,
								align : "center",
								sortable : false,
								formatter : function(cellvalue,
										options, rowObject) {
									var btDelete = "<button type='button' class='btn red btnDelete' ";
		  			btDelete += 'value=' + options.rowId 
		  			btDelete += ">X</button>";
									return btDelete;
								}
							} ],

					onSelectRow : function(id) {

						$(localGrid.gridId).editRow(id, true);

					},

					gridComplete : function() {
						
						// Load default select options.
 						$(localGrid.gridId).setColProp('revenueType', { editoptions: { 
		                	value : CONSTANT.REVENUETYPE()
						}});

						var length = localGrid.data.length;
						for (var i = 0; i < length; i++) {
							$(localGrid.gridId).editRow(i + 1, true);
						}
						$(".hasDatepicker").datepicker("hide");

						$(".btnDelete").off("click");
						$(".btnDelete").on("click", function(event) {
							var rowId = $(event.target).prop("value");
							localGrid.removeRow(rowId);
							localGrid.reArrangeRow();
							
						});
						
						$(localGrid.gridId).off( "change" , ".editable" );
						$( localGrid.gridId ).on('focus', '.editable', function(){
		           			$(localGrid.gridId).jqGrid("setSelection", $(this).closest("tr").attr("id") ,true);
		           		});
						$(localGrid.gridId).on( "change" , ".editable" , function( event ) {
							var rowId = $( this ).parent().parent().attr( "id" );	
							if ( rowId != null && rowId != "" ) {
								var billedID = $( localGrid.gridId ).jqGrid( 'getCell' , rowId , 'billedID' );
								var data = { billedID : billedID };
								var inputs = $( "#" + rowId + "[role=row]" ).find( "input, select" );
								var isValid = false;
								$.each(
										inputs,
										function( index , value ) {
											var name = $(value).attr("name");
											var text;
											try {
												text = $(value).autoNumeric("get");
											} catch (ex) {
												text = $(value).val();
											}

											data[name] = text;
											if (text != "" && name != "") {
												isValid = true;
											} else {
												isValid = false;
												return;
											}
										});

								if (isValid === true) {
									localGrid.editData( rowId , data);
								}
							}
						});

					}
				});
		},

		editData : function(rowId, data) {
			if (localGrid.data == null) {
				localGrid.data = [];
			}
			if (data.billedID != null && data.billedID != false) {

				$.each(localGrid.data, function(index, bill) {
					if (bill.billedID == data.billedID) {
						localGrid.data[index] = data;
						return;
					}
				});
			} else {
				localGrid.data[rowId - 1] = data;
			}
			//localGrid.refreshData();
		},

		getLastIndex: function(){
			var gridData = $(localGrid.gridId).getDataIDs();
			if(gridData.length > 0) {
				var lastId = gridData[parseInt(gridData.length) -1];
				return parseInt(lastId) + 1;
			}else{
				return 1;
			}
		},

		addNewRow : function() {
			var lastId = localGrid.getLastIndex();
			var data = {
				no : lastId
			};
			
			// add to UI
			$(localGrid.gridId).jqGrid("addRowData", lastId, data, "last");
			localGrid.reArrangeRow();
		},

		removeRow : function(rowId) {

			var billedID = $(localGrid.gridId).jqGrid('getCell', rowId,
					'billedID');
			if (billedID != null && billedID != false) {
				localGrid.removeBills.push({
					billedID : billedID
				});
			}

			localGrid.data.splice(rowId - 1, 1);
			//localGrid.refreshData();
			$(localGrid.gridId).jqGrid('delRowData', rowId);

		},
		reArrangeRow : function(){
			var count = 0;
			$('#billingGrid tbody tr td[aria-describedby=billingGrid_no]').each(function(){
				$(this).attr('title',++count);
				$(this).text(count);
			});
		}

	};
	

	var opexCharge = {
			
		getOpexChargeFilter : function(){
			
			var serviceRevenue = (parseFloat(Yuga.removeComma($('#siRevenue' ).val()))  || 0) + (parseFloat(Yuga.removeComma($( '#smRevenue' ).val())) || 0);
			var licenseRevenue = parseFloat(Yuga.removeComma($( '#licenseRevenue' ).val())) || 0;
			var outsourcingRevenue = parseFloat(Yuga.removeComma($( '#outsourceRevenue' ).val())) || 0;
			var vendorSolution = parseFloat(Yuga.removeComma($( '#vendorSolution' ).val())) || 0;
			
			
			var salesOpex = 
								(serviceRevenue * budgetPlan.opexCharges[CONSTANT.SERVICE]) +
								(licenseRevenue * budgetPlan.opexCharges[CONSTANT.LICENSE]) +
								((outsourcingRevenue - vendorSolution) * budgetPlan.opexCharges[CONSTANT.OUT_SOURCE])
								
			return salesOpex; 
		}
	};
	
	/* var opexCharge = {
			
			getCountDays : function(startDate, endDate){
				return parseInt((endDate - startDate) / (1000 * 60 * 60 * 24));
			},
			
			getGPTypeByYear : function(year, gpType){
				var result = null;
				$.each(budgetPlan.opexCharges, function(key, val){
					if((year == val.year) && (gpType == val.gpType)){
						result = val.rate;
					}
				});
				
				return result;
			},
			
			getTotalOpex : function(year){
				
				var serviceRevenue = (parseFloat($( '#siRevenue' ).val().replace(/,/g, '')) + parseFloat($( '#smRevenue' ).val().replace(/,/g, ''))) || 0;
					serviceRevenue *= this.getGPTypeByYear(year, CONSTANT.SERVICE.trim());
					
				var	licenseRevenue = parseFloat($( '#licenseRevenue' ).val().replace(/,/g, '')) || 0;
					licenseRevenue *= this.getGPTypeByYear(year, CONSTANT.LICENSE.trim());
					
				var	outsourcingRevenue = (parseFloat($( '#outsourceRevenue' ).val().replace(/,/g, '')) - parseFloat($('#vendorSolution').val().replace(/,/g, ''))) || 0;
					outsourcingRevenue *= this.getGPTypeByYear(year, CONSTANT.OUT_SOURCE.trim());
			
				return (serviceRevenue + licenseRevenue + outsourcingRevenue) / 100;
			},
			
			getOpexChargeFilter : function(){
				var startDate = new Date();
				var endDate = new Date();
				$.each(budgetPlan.opexCharges, function(key, val){
					startDate.setTime(val.startDate);
					endDate.setTime(val.endDate);
				});
				var totalDays = this.getCountDays(startDate.getTime(), endDate.getTime());
			
				if(startDate.getFullYear() == endDate.getFullYear()){
					return parseInt(this.getTotalOpex(startDate.getFullYear()));
				} else if(startDate.getFullYear() < endDate.getFullYear()) {
					var saleOpex = 0;
					var thisYear = new Date();
					var	nextYear = new Date();
					var daysOfYear = 0;
					
					for(var i = startDate.getFullYear(); i <= endDate.getFullYear(); i++ ){	
						if(i < endDate.getFullYear()){
							thisYear.setTime(startDate.getTime());
							nextYear.setFullYear(i + 1, 0, 1);
							daysOfYear = this.getCountDays(thisYear.getTime(), nextYear.getTime());
							saleOpex += (daysOfYear * this.getTotalOpex(i)) / totalDays;
							thisYear.setTime(nextYear.getTime());
						}else if(i == endDate.getFullYear()){
							thisYear.setFullYear(endDate.getFullYear(), 0, 1);
							daysOfYear = this.getCountDays(thisYear.getTime(), endDate.getTime());
							saleOpex += (daysOfYear * this.getTotalOpex(i)) / totalDays;
						}
					}
					return saleOpex;
				}
			return null;
			}
		} */
</script>