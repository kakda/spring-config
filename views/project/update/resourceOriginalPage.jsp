<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="tabsProResouce" class="content form-container">

	<h3 class="title-project">Update Original Resource Plan
		<div class="btn-bar">
			<a class="btn white" href="<c:url value='/project/update/R'/>"><< Back To Resource Actual</a>
		</div>
	</h3>
	
	<div class="clear"></div>
	<table id="resourceGrid"></table>
	<div id="paging"></div>
</div>


<script type="text/javascript">
	$(document).ready(function(){
		$("#tabs").tabs({
			 active: 3,
			 beforeActivate : function(event, ui){	 
				Yuga.redirect(url[ui.newPanel.selector]);
				return true;
			 }
		});
		
		resourcePlan.init();
	});
	
	
	var resourcePlan = {
		init: function(){
			resourcePlan.viewRecordData();
			resourcePlan.bindEvent();
		},
		
		bindEvent : function(){

			$("#btnUpdate").click( function(event) {

				var isValid = resourcePlan.validate();
				if (isValid) {
					var members = $(localGrid.gridId).jqGrid('getGridParam','data');
					if( members != null ){
						 $.each( members, function( index, member ){
							 var resource = localGrid.data[ member.projectMemberID ];
							 if( resource != null ){
								 var resourcePlans = [];
								 $.each( resource, function( index, value ){
									 var arr = index.split("-");
									 var month = arr[ 0 ];
									 var year = arr[ 1 ];
									 resourcePlans.push( {
										 month: month,
										 year: year,
										 plannedWorkSize: value
									 });
								 });
								 member.resourcePlans = resourcePlans;
							 }
						 });
						 

						 $.ajax( {
							type			: "PUT",
							url				: "<c:url value='/project/resouces/plans' />" ,
						    contentType		: "application/json",
						    data			: JSON.stringify(members),
							dataType		: "json",
							cache			: false,
							success: function( isCreate ){
								if( isCreate ){
									var newUrl = "<c:url value='/project/update/' />" + CONSTANT.PROJECT_STATUS_PROJECT_RESOURCE;
									Yuga.redirect(newUrl);
								}
							}   
						 }); 
					}
					
				}else{
					Yuga.dialog.alert("Invalid MM data.");
				}
			});
		},
		
		viewRecordData: function(){
			var url = "<c:url value='/project/'/>" + page.projectID;
			$.get(url, function(json){
				var members = json.members;
				var generalInfo = json;
				
				if( members != null ){
					localGrid.init({
						members: members,
						generalInfo: generalInfo
					});
				}
			});
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
			var members = $(localGrid.gridId).jqGrid('getGridParam','data');
			if( members == null ){
				return true;
			}else{
				
				var length = members.length;
				
				var isValid = true;
				
				for( var i = 0; i < length; i++ ){
					var rowId = i + 1;
		   			var limitMM = $( localGrid.gridId ).jqGrid ('getCell', rowId, 'plannedWorkSize');
		   			var inputs = $( "#" + rowId + "[role=row]" ).find( "input" );	
		   			
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
				var members = localGrid.serializeMembers(data.members);
				var generalInfo = data.generalInfo;				
				var colNames = [ "projectMemberID", "Name", "Level", "Position", "Team", "Total (MM)" ];
				var colModel = [ 
					{
		                name : 'projectMemberID',
		                hidden: true,
		                frozen: true
		            }, 
		            {
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
					var startDate = timeToString(generalInfo.startDate);
					var endDate = timeToString(generalInfo.endDate);
					var monthList = resourcePlan.getDiffMonthList( startDate, endDate );
					
					$.each( monthList, function( index, value ){
						
						var name = value.month + "-" + value.year;
						
						colNames.push( name );
						
						colModel.push( {
			                name : name,
			                index : name,
			                width : 100,
			                editable: true, 
			                edittype: 'text',/* 
			                formatter:function (cellvalue, options, rowObject) {
			                	var names = name.split("-");
			                	var value = "0";
			                	$.each(data.members, function(index, member){
			                		if(member.resourcePlans.length > 0 && 
			                				member.projectMemberID == rowObject.projectMemberID){
			                			$.each(member.resourcePlans, function(){
			                				if(this.month == Number(names[0]) &&
			                						this.year == Number(names[1])){
			                					value = this.plannedWorkSize;
			                					return;
			                				}
			                			});
			                			return;
			                		}
			                	});
					  		    return value;
					  		}, */
			                editoptions: { 
			                	dataInit: function(el){
					    			$(el).autoNumeric({aPad: false, aSep: ""});
				    			},
				    			dataEvents: [
									{
									    type: 'change',
									    fn: function(e) {
									    	var rowId = $(this).closest("tr").prop("id");
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
						           				 
 						           				$(localGrid.gridId).jqGrid('saveRow', rowId, { url : 'clientArray', aftersavefunc : function(){
						           					$(localGrid.gridId).editRow(rowId, true); 
						           				}}); 
						           			} 
									    }
									}
									
				    			]             
			                }
			            } );
					});
				}
				
				$( localGrid.gridId ).jqGrid({
		            datatype : "local",
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
		           		
		           		var length = $(localGrid.gridId).jqGrid('getGridParam','data').length;
		           		for( var i = 0; i <  length; i++  ){
			            	$(localGrid.gridId).editRow( i + 1, true); 
		           		}
		           		
		           		/* $( localGrid.gridId ).undelegate( "[role=row]", "mouseout" );
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
		           		}); */
		           	}
		 		});
				$(localGrid.gridId).jqGrid('setFrozenColumns');
				$(localGrid.gridId).jqGrid('setGridParam',{data: members}).trigger('reloadGrid');
			},
			
			editData: function( rowId, data ){
				var projectMemberID = $( localGrid.gridId ).jqGrid ('getCell', rowId, 'projectMemberID');
				localGrid.data[ projectMemberID ] = data;
			},
			
			serializeMembers : function(members){
				var newMembers = [];
				$.each(members, function(){
					var member = $.extend(this, localGrid.getResourcePlan(this));
					newMembers.push(member);
				});
				return newMembers;
			},
			
			getResourcePlan : function(member){
				var value= {};
				if(member.resourcePlans.length > 0){
        			$.each(member.resourcePlans, function(){
       					value[this.month + '-' + this.year] = this.plannedWorkSize;
       					return;
        			});
        		}
				return value;
			}
		};
</script>