<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="tabsProResouce" class="content form-container">
	<table id="resourceGrid"></table>
	<div id="paging"></div>
</div>


<script type="text/javascript">
	$(document).ready(function(){
		$("#tabs").tabs({
			 active: 3,
			 beforeActivate : function(event, ui){
				 var isValid = resourcePlan.validate();
				 if( isValid ){
					 var data = localGrid.data;
					 
					 if( data != null ){
						 $.session.setJSON( session.keys.resource, data );
					 }
					 
					 Yuga.redirect(url[ui.newPanel.selector]);
				 }else{
					 Yuga.dialog.alert( "Invalid MM input. There are error." );
				 }
				 return isValid;
			 }
		});
		
		resourcePlan.init();
	});
	
	
	var resourcePlan = {
		init: function(){
			resourcePlan.viewSessionData();
		},
		
		viewSessionData: function(){
			var sessionMember = $.session.getJSON( session.keys.member_data );
			var generalInfo = $.session.getJSON(session.keys.general);
			var resources = $.session.getJSON( session.keys.resource );
			
			console.log(JSON.stringify(resources));
			var members = [];
			$.each(sessionMember, function(index,sessionMM){
				if(sessionMM.groupName != undefined){
					groupObj = {
							orgID: "",
							org: "",
							employeeID: sessionMM.groupName,
							name: sessionMM.groupName,
							empLevel: "",
							position: "",
							empLevelID: "",
							plannedWorkSize: sessionMM.plannedWorkSize,
						};
					members.push(groupObj);
				}else{
					members.push(sessionMM);
				}
			});
			
			
			if( members != null ){
				localGrid.init({
					members: members,
					generalInfo: generalInfo,
					resources: resources
				});
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
		},
		
		validate: function(){
			var members = $.session.getJSON( session.keys.member_data );

			if( members == null ){
				return true;
			}else{
				
				var length = members.length;
				
				var isValid = true;
				
				for( var i = 0; i < length; i++ ){
					var rowId = i + 1;
		   			
		   			var limitMM = $( localGrid.gridId ).jqGrid ('getCell', rowId, 'plannedWorkSize');
		   			var inputs = $( "#" + rowId + "[role=row]" ).find( "input" );	
		   			
					/**
					* Checked the value of limitMM if it equal to -1 then break loop and return true.
					* @author  Kimsour Son
					* @version 2.0
					* @since   2014-10-10
					*/
  		   			if( limitMM == -1 ) {
		   				break;
		   			}
		   			
		   			var sumMM = 0;
		   			inputs.each( function(){
		   				sumMM += new Number($(this).val() );
		   			});
		   			
		   			if( limitMM != sumMM ){
		   				isValid = false;
		   				break;
		   			}
		   			
				}
				
				return isValid;
				
			}
			
		},
		
		getResourceData: function(){
			return localGrid.data;
		}
	};
	
	
	
	
	var localGrid = {
			gridId: "#resourceGrid",
			data : {},
			
			init: function( data ){
				var members = data.members;
				var generalInfo = data.generalInfo;
				var resources = data.resources || {};
				localGrid.data = resources;
				
				console.log(members);
				var colNames = [ "employeeID", "Name", "Level", "Position", "Team", "Total (MM)" ];
				var colModel = [ 
					{
		                name : 'employeeID',
		                hidden: true,
		                frozen: true
		            }, {
		                name : 'name',
		                index : 'name',
		                align: "center",
		                width : 100,
		                frozen: true
		            },
		            
		            {
		            	name : 'empLevel',
		                index : 'empLevel',
		                align: "center",
		                width : 100,
		                frozen: true
		            },
		            
		            {
		                name : 'position',
		                index : 'position',
		                align: "center",
		                width : 100,
		                frozen: true
		            },
		            
		            {
		                name : 'org',
		                index : 'org',
		                align: "center",
		                width : 100,
		                frozen: true
		            },
		            
		            {
		                name : 'plannedWorkSize',
		                index : 'plannedWorkSize',
		                align: "center",
		                width : 100,
		                frozen: true
		            }
		        ];
				
				
				
				if( generalInfo != null ){
					var startDate = generalInfo.startDate;
					var endDate = generalInfo.endDate;
					
					
					var monthList = resourcePlan.getDiffMonthList( startDate, endDate );
					
					$.each( monthList, function( index, value ){
						
						var name = value.month + "-" + value.year;
						
						colNames.push( name );
						
						colModel.push( {
			                name : name,
			                index : name,
			                width : 100,
			                editable: true, 
			                edittype: 'text',
			                formatter:function (cellvalue, options, rowObject) {
			                	var employeeID = rowObject.employeeID;
			                	var dateYearValue = resources[ employeeID ] || {};
			                	var value = dateYearValue[ name ] || "";
					  		    return value;
					  		},
			                editoptions: { dataInit: function(el) 
			                	{
					    			$(el).autoNumeric({aPad: false, aSep: ""});
				    			}
			                }
			            } );
					});
					
				}
				
				
				
				$( localGrid.gridId ).jqGrid(
				        {
				            datatype : "local",
// 				            data: members || [],
				            colNames : colNames,
				            colModel : colModel,
							rowNum: members.length+1,
				            autowidth : true,
				            shrinkToFit: false,
				            height : 380,
				            rowNum: 10,
				            pager 		: '#paging',
				            onSelectRow: function(id){
				            	
				            	$( localGrid.gridId ).editRow( id, true); 
				         
				           	},
				           	
				           	gridComplete : function(){
				           		
				           		
				           		var length = ( data.members || [] ).length;
				           		for( var i = 0; i <  length; i++  ){
					            	$( localGrid.gridId ).editRow( i + 1, true); 
				           		}
				           		
				           		
				           		$( localGrid.gridId ).undelegate( "[role=row]", "mouseout" );
				           		$( localGrid.gridId ).delegate( "[role=row]", " mouseout", function( event ){
				           			
				           			
				           			var rowId = $( this ).prop( "id" );
				           			
				           			
				           			if( rowId != null && rowId != "" ){
				           				
				           				 var data = {};
										 var inputs = $( "#" + rowId + "[role=row]" ).find( "input" );			           				 
				           				 var isValid = false;
				           				 $.each( inputs, function( index, value ){
				           					 var name = $( value ).attr( "name" );
				           					 var text = $( value ).val();
				           					 data[ name ] = text;
				           					 if( text != "" ){
				           						 isValid = true;
				           					 }
				           				 });
				           				 
				           				 if( isValid ){
				           					localGrid.editData( rowId , data);
				           				 }
				           			}
				           		});
				           	}
				 		});
				$(localGrid.gridId).jqGrid('setFrozenColumns');
				$(localGrid.gridId).jqGrid('setGridParam',{data: members}).trigger('reloadGrid');
			},
			
			editData: function( rowId, data ){
				var employeeID = $( localGrid.gridId ).jqGrid ('getCell', rowId, 'employeeID');
				localGrid.data[ employeeID ] = data;
			},
			
			
		};
</script>