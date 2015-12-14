<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<form class="content form-container project-budget" id="tabsProBudget">  
	<div class="info">
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
				 
				var isValid = budgetPlan.validate();
				
		
				if( isValid  ){
					
					budgetPlan.save();
					Yuga.redirect(url[ui.newPanel.selector]);
				}
				
				
				return isValid;
				
			 }
		});
		
		budgetPlan.init();
		
	});
	
	var budgetPlan = {
		init: function(){
			// init defaul currency
			budgetPlan.changeCurrencyText();

			budgetPlan.bindEvent();
			budgetPlan.viewSessionData();
			budgetPlan.viewProjectDeadline();
			
		},
		
		opexCharges : [],
		
		save : function(){
			
			var budgetInfo = {};
			var inputs = $( ".leftSide" ).find( "input.numeric" );
			$.each( inputs, function(index, value){
				budgetInfo[$(value).attr("name")] = $(value).autoNumeric("get");
			});
			
			var currency = $( "[name=currency]:input:checked" ).val();
			budgetInfo.currency = currency;
			
			
			$.session.setJSON( session.keys.budget, budgetInfo );
			$.session.setJSON( session.keys.billing, localGrid.data || [] );
		},
		
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
				outsourceRevenue = parseInt( $( "#outsourceRevenue" ).autoNumeric("get") ) || 0,
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
					 var billedDate = $(value).children('td').find('input[name=date]');
					 var billed = $(value).children('td').find('input[name=amount]');
					if((billedDate.val() == "") || (billedDate.val() == 'undefined')) {
						billedDate.focus();
						checkDate = true;
					}else if(billed.val() == "" || (billed.val() == 'undefined')) {
						billed.focus();
						billed.attr('placeholder', 'Required...');
						checkDate = true;
					}					
					var revenueType = $(value).children('td').find( 'select[name=revenueType]' ).children("option").filter(":selected").text();
					var input = $(value).children('td').find( 'input[name=amount]' ).val();
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
					return false;
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
		
		viewSessionData: function(){
			var json = $.session.getJSON( session.keys.budget );
			if( json != null ){
				
				$( "[value="  + json.currency + "]:input").prop('checked', true );
				
				$.each( json, function( key, value ){
					$( "#" + key  ).val( currentUtil.commaSeparateNumber(value) );
					//$( "#" + key  ).trigger( "change" );
				});
			}
			
			var json = $.session.getJSON( session.keys.billing );
			var grossProfit = budgetPlan.totalRevenue() - ( budgetPlan.totalThirdParty() + budgetPlan.totalExpense() );
			budgetPlan.viewBillingTable( json );
			
			// Load Tax object and store in session.
			budgetPlan.opexCharges = budgetPlan.ajaxRequest();
			var projectPeriod = $.session.getJSON(session.keys.general);
			var startDate = new Date(projectPeriod.startDate);
			var endDate = new Date(projectPeriod.endDate);

			//budgetPlan.opexCharges.push({'startDate' : startDate.getTime(), 'endDate' : endDate.getTime()});
			$( '#grossProfit' ).val( currentUtil.commaSeparateNumber( grossProfit ));
		},
		
		viewProjectDeadline: function() {
			var json = $.session.getJSON( session.keys.general );
			if( json != null ){
				$( "#startDate" ).text( json.startDate );
				$( "#endDate" ).text( json.endDate );

				// hide R&D budget
				var isRnD = budgetPlan.isRnD(json.projectTypeID);
				if( !isRnD ){
					$("#internalRDRevenue").val(0);
					$(".internalRDRevenue").hide();
				}
			}
		},
		
		viewBillingTable: function( data ) {
			localGrid.init( data );
		},

		bindEvent: function(){
			// register observer changed
			var array = new Array();
			array.push( { observable: $( "#licenseRevenue" ), observer: $( "#grossProfit" )} );
			array.push( { observable: $( "#smRevenue" ), observer: $( "#grossProfit" )} );
			array.push( { observable: $( "#siRevenue" ), observer: $( "#grossProfit" )} );
			array.push( { observable: $( "#outsourceRevenue" ), observer: $( "#grossProfit" )} );
			array.push( { observable: $( "#internalRDRevenue" ), observer: $( "#grossProfit" )} );
			array.push( { observable: $( "#vendorSolution" ), observer: $( "#grossProfit" )} );
			array.push( { observable: $( "#vendorOutSourcing" ), observer: $( "#grossProfit" )} );
			array.push( { observable: $( "#expenseProject" ), observer: $( "#grossProfit" )} );
			array.push( { observable: $( "#expenseOPEX" ), observer: $( "#grossProfit" ), inject : "expenseOPEX"} );
			budgetPlan.observeChange(array);
			
			
			// registered changes of currency
			$( $("input[name=currency]") ).change( function(){
				
				/* var allInputs = $( "[type=text]:input" );
				$.each( allInputs, function(index, value){
					if( $( value ).val() != "" && !$( value ).hasClass( "hasDatepicker") ){
						$( value ).val( budgetPlan.formatCurrrency($( value ).val()) );
					}
					
				}); */
				
				// change currency text
				budgetPlan.changeCurrencyText();
				
			} );
			
			
			$( "#btnAdd" ).click( function(){
				localGrid.addNewRow();
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
			var total = ( parseFloat( $( "#licenseRevenue" ).autoNumeric("get") ) || 0 ) 
			+ ( parseFloat($( "#smRevenue" ).autoNumeric("get") )|| 0 ) 
			+ ( parseFloat( $( "#siRevenue" ).autoNumeric("get"))|| 0 )
			+ ( parseFloat($( "#outsourceRevenue" ).autoNumeric("get") )|| 0 ) 
			+ ( parseFloat( $( "#internalRDRevenue" ).autoNumeric("get"))|| 0 );
	
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
			var total = parseFloat( Yuga.removeComma($('#expenseProject').val()) || 0 ) 
			//+ ( parseFloat( $('#expenseOPEX').autoNumeric('get')) || 0 );

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
					var grossProfit = budgetPlan.totalRevenue() -  ( budgetPlan.totalThirdParty() + budgetPlan.totalExpense() );
					$( '#grossProfit' ).val( currentUtil.commaSeparateNumber( grossProfit ));
					
					budgetPlan.changeCurrencyText();
					
				});
			});		
		},
		
		ajaxRequest : function() {
			var response = {};
			var projectPeriod = $.session.getJSON(session.keys.general);
			var startDate = new Date(projectPeriod.startDate);
			var url = '<c:url value="/opexCharge"/>/' + startDate.getFullYear() + "/year";
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
		unit: {
			KRW: "KRW",
			USD: "USD"
		},
		
		text: {
			KRW: "KRW",
			USD: "USD($)"
		},
		commaSeparateNumber: function( val ){
			if(val == null || val == undefined){
				val = 0;
			}
		    while (/(\d+)(\d{3})/.test(val.toString())){
		      val = val.toString().replace(/(\d+)(\d{3})/, '$1'+','+'$2');
		    }
		    return val;
		}
	};
	
	
	var localGrid = {
		gridId: "#billingGrid",
		data : [],
		lastEditRowId: null,
		
		init: function( data ){
			
			
			localGrid.data = data || [];
			$( localGrid.gridId ).jqGrid(
			        {
			            datatype : "local",
			            data: localGrid.data,
			            colNames : [ 'No', 'Date', 'Amount', 'Revenue Type', 'Delete' ],
			            colModel : [ {
			                name : 'no',
			                width : 45,
			                align: "center",
			                formatter: function(cellvalue, options, rowObject){
			                	return options.rowId;
			                }
			            }, {
			                name : 'date',
			                index : 'date',
			                align: "center",
			                width : 80,
			                editable: true, 
			                edittype: 'text',
			                editoptions: { dataInit: function(el) {  
			                	try{
			        				$( el ).autoNumeric('destroy');
			        			}catch( ex){
			        				
			        			}
			        			$( el ).prop( "disabled" );
			        			$(el).datepicker(); 
			                }}
			            },
			            {
			                name : 'amount',
			                index : 'amount',
			                width : 100,
			                editable: true, 
			                edittype: 'text',
			                editoptions: { dataInit: function(el) {
			                		$(el).addClass('numeric');
			                		var currency = $( "[name=currency]:input:checked" ).val();
					    			if( currency === currentUtil.unit.KRW ){
					    				$(el).autoNumeric({mDec:0});
					    			}else{
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
			                editoptions: {}
						},			            
			            {	width:60,
							align: "center", 
							sortable: false,
					  		formatter:function (cellvalue, options, rowObject) {
					  			var btDelete="<button type='button' class='btn red btnDelete' ";
					  			btDelete += 'value=' + options.rowId 
					  			btDelete += ">X</button>";
					  		    return btDelete;
					  		}
					  	}
			            ],
			            
			            onSelectRow: function(id){
			            	
			            	$( localGrid.gridId ).editRow( id, true); 
			           		localGrid.lastEditRowId = id;
			         
			           	},
			           	afterEditCell : function(rowid, cellname, value, iRow, iCol){
			           		localGrid.lastEditRowId = rowid;
			           	},
			           	gridComplete : function(){	           		
			           		
							// Load default select options.
	 						$(localGrid.gridId).setColProp('revenueType', { editoptions: { 
	 							value : CONSTANT.REVENUETYPE()
							}});
			           		
			           		var length = localGrid.data.length;
			           		for( var i = 0; i <  length; i++  ){
				            	$( localGrid.gridId ).editRow( i + 1, true); 
			           		}
			           		$(".hasDatepicker").datepicker("hide");
			           		
			           	 	$( ".btnDelete").off( "click");
			           		$( ".btnDelete").on(  "click", function( event ){
			           			var rowId = $( event.target ).prop( "value" );
			           			localGrid.removeRow(rowId);
			           			localGrid.reArrangeRow();
			           		});
			           	
			           		
			           		$( localGrid.gridId ).off( "change", ".editable" );
			           		$( localGrid.gridId ).on('focus', '.editable', function(){
			           			$(localGrid.gridId).jqGrid("setSelection", $(this).closest("tr").attr("id") ,true);
			           		});
			           		$( localGrid.gridId ).on( "change", ".editable", function( event ){
			           			var rowId = localGrid.lastEditRowId;
// 			           			var rowId = $(this).closest("tr").attr("id");
			           			if( rowId != null && rowId != "" ){
			           				 var data = {};
									 var inputs = $( "#" + rowId + "[role=row]" ).find( "input, select" );
			           				 var isValid = false;
			           				 $.each( inputs, function( index, value ){
			           					 var name = $( value ).attr( "name" );
			           					 var text;
			           					 try{
			           						text = $( value ).autoNumeric("get");
			           					 }
			           					 catch( ex ){
			           						text = $( value ).val();
			           					 }
			           					 
			           					 data[ name ] = text;
			           					 if( text != "" && name != "" ){
			           						 isValid = true;
			           					 }else{
			           						 isValid = false;
			           						 return;
			           					 }
			           				 });
			           				 
			           				 if( isValid === true ){
			           					 localGrid.editData( rowId , data);
			           				 }
			           			}
			           		});
			           		
			           	}
			 		});
		},
		
		editData: function( rowId, data ){
			if( localGrid.data == null ){
				localGrid.data = [];
			}
			localGrid.data[ rowId -1 ] = data;
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
		
		addNewRow: function( ){
			var lastId = localGrid.getLastIndex();
			var data = {
				no : lastId
			};

			// add to UI
			$( localGrid.gridId ).jqGrid("addRowData", lastId, data, "last");
			localGrid.reArrangeRow();
		},
		
		removeRow: function( rowId ){
			localGrid.data.splice( rowId -1 , 1);
			$( localGrid.gridId ).jqGrid('delRowData',rowId);
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
				var serviceRevenue = (parseInt($( '#siRevenue' ).val().replace(/,/g, '')) + parseInt($( '#smRevenue' ).val().replace(/,/g, ''))) || 0;
					serviceRevenue *= this.getGPTypeByYear(year, CONSTANT.SERVICE.trim());
				var	licenseRevenue = parseInt($( '#licenseRevenue' ).val().replace(/,/g, '')) || 0;
					licenseRevenue *= this.getGPTypeByYear(year, CONSTANT.LICENSE.trim());
				var	outsourcingRevenue = parseInt($( '#outsourceRevenue' ).val().replace(/,/g, '')) || 0;

				return (serviceRevenue + licenseRevenue + outsourcingRevenue) / 100;
			},
			getOpexChargeFilter : function(){
				var startDate = new Date();
				var endDate = new Date();
				$.each(budgetPlan.opexCharges, function(key, val){
					startDate.setTime(val.startDate);
					endDate.setTime(val.endDate);
				});
				var saleOpex = 0;
				var totalDays = this.getCountDays(startDate.getTime(), endDate.getTime());

				if(startDate.getFullYear() == endDate.getFullYear()){
					saleOpex += parseInt(this.getTotalOpex(startDate.getFullYear()));
				} else if(startDate.getFullYear() < endDate.getFullYear()) {
						var thisYear = startDate;
					for(var i = thisYear.getFullYear(); i <= endDate.getFullYear(); i++ ){	
						var daysOfYear = 0;
						if(i < endDate.getFullYear()){
							var	nextYear = new Date();
								nextYear.setFullYear(thisYear.getFullYear() + 1);
								nextYear.setMonth(0);
								nextYear.setDate(1);
							daysOfYear = this.getCountDays(thisYear.getTime(), nextYear.getTime());
							thisYear = nextYear;
						}else if(i == endDate.getFullYear()){
							daysOfYear = this.getCountDays(thisYear.getTime(), endDate.getTime());
						}
						saleOpex += (daysOfYear / totalDays) * this.getTotalOpex(i);
					}
				}
				return saleOpex;
			}
		}
	
	var opexCharge = {
			
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