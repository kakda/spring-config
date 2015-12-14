<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="tabsProResouce" class="content form-container">
	<h3 class="title-project">
		<div class="btn-bar">
			<a class="btn white" href="<c:url value='/project/update/PO'/>">Update Original Plan</a>
		</div>
	</h3>
	<table id="resourceGrid"></table>
	<div id="paging"></div>
	<div id="treeDialog">
		<input type="text" id="search" class="text search" placeholder="Enter something to search ..." />
		<div id="orgTree"></div>
	</div>
</div>


<script type="text/javascript">
	var members;
	$(document).ready(function(){
		$("#tabs").tabs({
			 active: 3,
			 activate : function(event, ui){
				 Yuga.redirect(url[ui.newPanel.selector]);
			 }
		});
		
		resourcePlan.init();
	});
	
	
	var resourcePlan = {
			
		init: function(){
			resourcePlan.viewResourceRecord();
			resourcePlan.bindEvent();
			resourcePlan.dialog();
// 			resourcePlan.initTree();
		},
		
		dialog: function(){			
			$('#treeDialog').dialog({
				modal: true,
				autoOpen: false
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
			
		},
		
		search : function(){
		    $.jstree.reference($('#orgTree')).search($('#search').val());
		},
		
		viewResourceRecord: function(){
			var resourceURL = "<c:url value='/project/'/>" + page.projectID;
			$.get(resourceURL, function(json){
				members = json.members;
				var generalInfo = json;
				
				
				if( members != null ){
					localGrid.init({
						members: members,
						generalInfo: generalInfo
					});
					resourcePlan.initTree(new Date(generalInfo.startDate).getFullYear());
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
		
		getOrgTree : function(callback){

			$('#orgTree').one("dblclick.jstree", function (e) {
				var tree = $.jstree.reference('#orgTree');
				var selectedNodes = tree.get_selected();
				var node = tree.get_node(selectedNodes[0]);
				
				callback.call(this, node.id, node.text);
			  	/* $("#projectOwner").attr("value", node.text);
			  	$("#orgID").val(node.id);
				$('#treeDialog').dialog("close"); */
			});
		},
		
		bindEvent: function(){
			//Enabled search
			$("#search").on("keyup", this.search);
			
			$("#btnUpdate").click(function(){
// 				var inputs = $(":text.editable.mm-data");
				var data = {};
// 				$.each(inputs, function(index, input){
// 					var td = $(input).parents("td");
// 					var	tr = td.closest("tr");
//  					var	names = $(input).attr("name").split("-");
// 					var	dataType = td.attr( "dataType" ),
// 						projectMemberID = td.attr( "memberID" ),
// 						resourcePlanID = td.attr( "resourcePlanID" ),
// 						resourceActualID = td.attr( "resourceActualID" ),
// 						employeeLevelID = td.attr( "employeeLevelID" ),
// 						orgID = td.attr( "orgID" );
// 						var organization = null;
// 					if( typeof tr.find( "td[organization]" ).attr("organization") !== typeof undefined ){
// 						organization = tr.find( "td[organization]" ).attr("organization");
// 					}
// 						var empLevel = null;
// 					if( typeof tr.find("td[empLevel]").attr( "empLevel" ) !== typeof undefined ){
// 						empLevel = tr.find("td[empLevel]").attr( "empLevel" );
// 					}

// 					var value = $(input).val();

// 					if( resourcePlanID != "" ){
// 						var actual = data[ resourcePlanID ];
// 						if( actual == null ){
// 							actual = {
// 								resourcePlanID: resourcePlanID,
// 								projectMemberID: projectMemberID,
// 							};
// 							actual[ dataType ] = value;
// 							actual[ employeeLevelID ] = empLevel;
// 							actual[ orgID ] = organization;
// 							actual.resourceActualID = "";
// 							data[resourcePlanID] = actual;
// 						}else{
// 							actual[ dataType ] = value;
// 							actual[ employeeLevelID ] = empLevel;
// 							actual[ orgID ] = organization;
// 							actual.resourceActualID = resourceActualID;
// 						}
// 					}else{
						
// 						var plan = {};
// 						var url = "<c:url value='/project/resouces/plan'/>";
						
// 						plan.projectMemberID = projectMemberID;
// 						plan.plannedWorkSize = 0;
// 						plan.month = names[0];
// 						plan.year = names[1];
// 						console.log("Plan" + plan);
// // 						$.ajax( {
// // 							type			: "POST",
// // 							url				: url,
// // 						    contentType		: "application/json",
// // 						    data			: JSON.stringify(plan),
// // 							dataType		: "json",
// // 							cache			: false,
// // 							async 			: false,
// // 							success: function(json){
// // 								var actual = {
// // 									resourcePlanID: json.resourcePlanID,
// // 									projectMemberID: plan.projectMemberID,
// // 									resourceActualID : ""
// // 								};
// // 								actual[ dataType ] = value;
// // 								actual[ employeeLevelID ] = empLevel;
// // 								actual[ orgID ] = organization;
// // 								data[json.resourcePlanID + names[0] + names[1] + dataType] = actual;
								
// // 							}   
// // 						}); 
// 					}
					
// 				});
// 				console.log(members);
				$.each(members, function(index,item){
					var projectMemberID = "";
					if(item.type == "ACTUAL" && item.projectMemberID != projectMemberID){
						projectMemberID = item.projectMemberID;
						
						$.each(item.resourcesActuals, function(index,actual){
								data[actual.resourcePlanID] = actual;
							});
						};
					});
				var  addActuals = [];
				var  updateActuals = [];
				
				$.each(data, function(key, actual){
					if( actual.resourceActualID != "" ){
						updateActuals.push( actual );
					}else{
						addActuals.push( actual );
					}
				});
				
				
				
				var url = "<c:url value='/project/resouces/actuals'/>";
				
				if( addActuals.length > 0 ){
					$.ajax( {
						type			: "POST",
						url				: url,
					    contentType		: "application/json",
					    data			: JSON.stringify(addActuals),
						dataType		: "json",
						cache			: false,
						async 			: false,
						success: function( isCreate ){
						}   
					} ); 
				}

				if( updateActuals.length > 0 ){
					$.ajax( {
						type			: "PUT",
						url				: url,
					    contentType		: "application/json",
					    data			: JSON.stringify(updateActuals),
						dataType		: "json",
						cache			: false,
						async 			: false,
						success: function( isCreate ){
						}   
					} ); 
				}
				$( "#btnCancel" ).trigger( "click" );
// 				return false;
				
			});
			
//   			$( localGrid.gridId ).delegate( ".editable" , "change", function(){
//   				var td = $(this).parents("td");
//   				var	tr = td.closest("tr");
//   				var organization = tr.find( "td[organization]" ).attr("organization");
  				
// 				var empLevel = tr.find("td[empLevel]").attr( "empLevel" );
				
// 				var td = $(this).parent();
// 				var dataType = td.attr( "dataType" );
// 				var projectMemberID = td.attr( "memberID" );
// 				var resourcePlanID = td.attr( "resourcePlanID" );
// 				var resourceActualID = td.attr( "resourceActualID" );
				
// 				console.log(dataType + '|' + projectMemberID + "|" + resourcePlanID  + "|" + resourceActualID  + "|" +  organization +"|"+ empLevel);
				
// 				var name = $(this).attr( "name" );				
// 				var value = $(this).val();				
				
// 				var table = td.parent().parent();
				
// 				var firstValue = table.find( "td[dataType=firstMM][memberID=" + projectMemberID + "]" ).find( "input[name="  + name + "]" ).val();
// 				var secondValue = table.find( "td[datatype=secondMM][memberID=" + projectMemberID + "]" ).find( "input[name="  + name + "]" ).val();
// 				var thirdValue = table.find( "td[datatype=thirdMM][memberID=" + projectMemberID +"]" ).find( "input[name="  + name + "]" ).val();
				
// 				var totalMM = new Number( firstValue || 0 ) + new Number(secondValue || 0) + new Number(thirdValue || 0);
				
// 				table.find( "td[datatype=total][aria-describedby=resourceGrid_" + name + "][memberID=" + projectMemberID+ "]" ).html( totalMM );
			
			
				
// 				var tr = td.parent();
// 				var inputs =  tr.find( ":text.text.editable.mm-data" );
// 				total = 0;
// 				$.each( inputs, function(index, input){
// 					total += new Number( $(input).val() || 0 );
// 				});			

// 				tr.find( "td[aria-describedby=resourceGrid_plannedWorkSize]" ).html( total );
				
				
// 				total = 0;
// 				var cells = table.find( "td[datatype=total][memberID=" + projectMemberID+ "]" );
// 				$.each(cells, function( index, cell){
// 					total += new Number( $(cell).html() || 0 );
// 				});
				
// 				cells.parent().find( "[aria-describedby=resourceGrid_plannedWorkSize]" ).html( total );
				
// 				var data = [];
// 				data.dataType = dataType;
// 				data.projectMemberID = projectMemberID;
// 				data.resourcePlanID = resourcePlanID;
// 				data.resourceActualID = resourceActualID;
// 				data.firstMM = firstValue;
// 				data.secondMM = secondValue;
// 				data.thirdMM = thirdValue;
// 				data.total = totalMM;
				
				
				
// 				localGrid.updateLocalData(data);
// 			}); 
	
		},

	};
	
	var localGrid = {
			gridId: "#resourceGrid",
			data : {},
			prevCellVal: null,
			
			init: function( data ){

				var generalInfo = data.generalInfo;
				var memberID = [];
				$.each(data.members, function(index, member){
					if((member.type != "TBN")){
						memberID.push(member.projectMemberID);
					}
				});
				
				if(memberID.length > 0){
					var url = "<c:url value='/project/members/'/>" + memberID + "/resouces/actuals";
					$.ajax( {
							type			: "GET",
							url				:  url,
						    contentType		: "application/json",
							dataType		: "json",
							cache			: false,
							async			: false,
							success: function( json ){
								if( json ){
								
									if( json != null ){
										resourcesActuals = json;
				   	    			}
								}
							}
					});
				}
 				members = [];
				$.each(data.members, function(index, member){
					var projectMemberID = member.projectMemberID;
					if((member.type != "TBN")){
						if(member.type == "OUTSOURCE"){
							member.org = "OUTSOURCE";
						}
						member.type = CONSTANT.BILL_PLAN_TYPE; 
						member.Class = "plan";
						members.push(member);
// 						var url = "<c:url value='/project/members/'/>" + projectMemberID + "/resouces/actuals";
						// get saved resource actuals
// 						var resourcesActuals = [];
// 						$.ajax( {
// 							type			: "GET",
// 							url				:  url,
// 						    contentType		: "application/json",
// 							dataType		: "json",
// 							cache			: false,
// 							async			: false,
// 							success: function( json ){
// 								if( json ){
									
// 									if( json != null ){
// 										resourcesActuals = json;
// 				   	    			}
// 								}
// 							}   
// 						}); 
						
						var actualText = {
							actual1: {
								employeeLevelID : "firstEmployeeLevelID",
								orgID : "firstOrgID",
								orgName : "firstOrgName",
								mm : "firstMM"
							},
							actual2: {
								employeeLevelID : "secondEmployeeLevelID",
								orgID : "secondOrgID",
								orgName : "secondOrgName",
								mm : "secondMM"
							},
							actual3: {
								employeeLevelID : "thirdEmployeeLevelID",
								orgID : "thirdOrgID",
								orgName : "thirdOrgName",
								mm : "thirdMM"
							}
						};
						
						for(var i=1; i < 4; i++){
							
							var actual = {
								Class: actualText[ "actual" + i ].mm,
								orgID : actualText[ "actual" + i ].orgID,
								orgName : actualText[ "actual" + i ].orgName,
								employeeLevelID : actualText[ "actual" + i ].employeeLevelID,
								employeeID: member.employeeID,
								name: member.name,
								type: CONSTANT.BILL_ACTUAL_TYPE,
								org: "",
								empLevel: "",
								plannedWorkSize: 0,
								resourcesActuals: resourcesActuals[projectMemberID],
								resourcePlans: member.resourcePlans,
								projectMemberID: projectMemberID
							};
							members.push( actual );
						}
						
						
						
						
						var total = {
							Class: "total",
							employeeID: member.employeeID,
							name: member.name,
							type: "Total",
							org: "",
							empLevel: "",
							plannedWorkSize: 0,
							resourcesActuals : resourcesActuals[projectMemberID],
							resourcePlans: member.resourcePlans,
							projectMemberID: projectMemberID
							
						};
							
						members.push( total );
					}
					
				} );
				
				
				var colNames = [ "Class", "employeeID", "Name", "Type", "Team", "Level", "MM" ];
				var colModel = [ 
				                
					{
					    name : 'Class',
					    hidden: true,
					    frozen: true
					},
				                
					{
		                name : 'employeeID',
		                hidden: true,
		                frozen: true
		            }, {
		                name : 'name',
		                index : 'name',
		                align: "center",
		                frozen: true,
		                width : 150,
		                cellattr: function( rowId, val, rawObject, cm, rdata ) {
	                        var result = "";
	                        var employeeID = rawObject.employeeID;
	                        if ( localGrid.prevCellVal == employeeID ) {
	                            result = ' style="display: none"';
	                        }
	                        else {
	                        	result = ' rowspan= 5';
	                        	localGrid.prevCellVal = employeeID;
	                        }

	                        return result;
	                    }
		            },
		            
		            
		            {
		            	name : 'type',
		                index : 'type',
		                align: "center",
		                width : 150,
		                frozen: true
		            },
		            
		            {
		                name : 'org',
		                index : 'org',
		                align: "center",
		                width : 150,
		                editable: true, 
		                frozen: true,
			   		    edittype: 'text',
		                formatter: function(cellvalue, options, rowObject){
		                	if(rowObject.type == CONSTANT.BILL_ACTUAL_TYPE ){

			   					var value = "";
			   					var resourcesActuals = rowObject.resourcesActuals;
			   					
				  		    	$.each(resourcesActuals, function(index, resourcesActual){
						  		    value = resourcesActual[ rowObject.orgName ];
					  		    	return;
						  		});
						
								return value != undefined ? value : "";
		                	}
					  		return cellvalue;
		                },
		                editoptions: {
		                	dataEvents :[
		                	      {
		                	    	  type : 'click',
				   					  fn : function(e){
				   							if($(e.currentTarget).closest('td').attr('type') == 'member'){
				   								var that = e.target;
			 			    				  	$('#treeDialog').dialog("open");	 
						    				  	
			 			    				  	resourcePlan.getOrgTree(function(id, text){
			 			    				  		$(that).val(text);
			 			    				  		$(that).parent().attr("title", text);
			 			    				  		$(that).parent().attr("organization", id);
			 			    				  		var datatype = $(that).parent().attr('datatype');
			 			   							var memberId = $(that).parent().attr('memberId');
			 			   							localGrid.orgLevelChange("org",datatype, id, memberId,text);
			 			    				  		$('#treeDialog').dialog("close");
			 			    				  	});
				   							}
				   						}
		                	      }
		                	 ],
		                	dataInit: function(el) {
			    				$(el).addClass("text").attr('readonly', 'readonly');
			    			}
		                },
 		                cellattr: function( rowId, val, rowObject, cm, rdata ) {
		                	
		                	if(rowObject.type == CONSTANT.BILL_ACTUAL_TYPE ){
		                		var result = " dataType='" + rowObject.Class + "'";
		                		result += " memberID='" + rowObject['projectMemberID'] + "'" ;
			                	result += "type='" +(rowObject.name.indexOf('group') == 0 ? 'group': 'member')+"'";
			                	result += "organization=";
			                	var value = "";
								var resourcesActuals = rowObject.resourcesActuals;
			   					
				  		    	$.each(resourcesActuals, function(index, resourcesActual){
						  		    value = resourcesActual[ rowObject.orgID ];
					  		    	return;
						  		});
				  		    	result += "'"+value+"'";
		                	}
		                	return result;
		                } 
		            },
		            
		            {
		            	name : 'empLevel',
		                index : 'empLevel',
		                align: "center",
		                width : 100,
		                editable: true, 
		                frozen: true,
			   		    edittype: 'select',
			   			editoptions : {
			   				value : "${levels}",
			   				dataEvents :[
			   					{
			   						type : 'change',
			   						fn : function(e){
			   							var value = $(e.target).val();
			   							$(e.target).closest('td').attr("emplevel",value);
			   							var datatype = $(e.target).closest('td').attr('datatype');
			   							var memberId = $(e.target).closest('td').attr('memberId');
			   							localGrid.orgLevelChange("Level",datatype, value, memberId,"");
			   						}
			   					}             
			   				]
			   			},
			   			addoptions : {
			   				value : "${levels}"
			   			},
			   			formatter:function (cellvalue, options, rowObject) {
			   				if(rowObject.type == CONSTANT.BILL_ACTUAL_TYPE ){

			   					var value = "";
			   					var resourcesActuals = rowObject.resourcesActuals;
			   					
				  		    	$.each(resourcesActuals, function(index, resourcesActual){
						  		    value = resourcesActual[ rowObject.employeeLevelID ];
					  		    	return;
						  		});
						
								return value != undefined ? value : "";
			   				}
					  		
					  		return cellvalue != undefined ? cellvalue : "";
			   			},
			   		  cellattr: function( rowId, val, rowObject, cm, rdata ) {
		                	
		                	if(rowObject.type == CONSTANT.BILL_ACTUAL_TYPE ){
		                		var result = " dataType='" + rowObject.Class + "'";
		                		result += " memberID='" + rowObject['projectMemberID'] + "'" ;
			                	result += "emplevel=";
			                	var value = "";
								var resourcesActuals = rowObject.resourcesActuals;
			   					
				  		    	$.each(resourcesActuals, function(index, resourcesActual){
						  		    value = resourcesActual[ rowObject.employeeLevelID ];
					  		    	return;
						  		});
						
				  		    	result += "'"+value+"'";
		                	}
		                	
		                	return result;
		                } 
		            },
		            {
		                name : 'plannedWorkSize',
		                index : 'plannedWorkSize',
		                align: "center",
		                frozen: true,
		                width : 100
		            }
		        ];
				
				
				
				if( generalInfo != null ){
					var startDate = timeToString( generalInfo.startDate );
					var endDate = timeToString( generalInfo.endDate );
					
					
					var monthList = resourcePlan.getDiffMonthList( startDate, endDate );
					
					$.each( monthList, function( index, value ){
						
						var name = value.month + "-" + value.year;
						
						colNames.push( name );
						
						colModel.push( {
			                name : name,
			                index : name,
			                width : 100,
			                align: "center",
			                editable: true, 
			                edittype: 'text',
			                
			                cellattr: function( rowId, val, rawObject, cm, rdata ) {
		                		var resourcePlans = rawObject.resourcePlans;
		                		var resourcePlanID = "";
			                	if( resourcePlans != null){
			                		$.each(resourcePlans, function(index, resourcePlan){
						  		    	
						  		    	if( name == (resourcePlan.month + "-" + resourcePlan.year ) ){
						  		    		resourcePlanID = resourcePlan.resourcePlanID;
						  		    		return;
						  		    	}
						  		    });
			                	}
			                	
			                	
			                	 var resourcesActuals = rawObject.resourcesActuals;
				  		    	 var Class = rawObject.Class;
								 var orgID = rawObject.orgID;
								 var employeeLevelID = rawObject.employeeLevelID;
				  		    	 var resourceActualID = "";
				  		    	 if( resourcesActuals != null && resourcesActuals.length != 0 ){
									$.each(resourcesActuals, function(index, resourcesActual){
						  		    	
						  		    	if( resourcePlanID == resourcesActual.resourcePlanID ){
						  		    		resourceActualID = resourcesActual.resourceActualID;
						  		    		return;
						  		    	}
						  		  	});
				  		    	 }
				  		    	 
								var result = " dataType='" + Class + "'";
 								result += " memberID='" + rawObject['projectMemberID'] + "'" ;
								result += " resourcePlanID='" + resourcePlanID + "'" ;
								result += " resourceActualID='" + resourceActualID + "'" ;
								result += " orgID='" + orgID + "'" ;
								result += " employeeLevelID='" + employeeLevelID + "'" ;
		                        return result;
		                    },
			                
			                formatter:function (cellvalue, options, rowObject) {
			                	if( rowObject.type == CONSTANT.BILL_PLAN_TYPE ){
			                		var resourcePlans = rowObject.resourcePlans;
				                	if( resourcePlans != null ){
							  		    var value = "";
							  		    $.each(resourcePlans, function(index, resourcePlan){
							  		    	if( name == (resourcePlan.month + "-" + resourcePlan.year ) ){
							  		    		value = resourcePlan.plannedWorkSize;
							  		    		return;
							  		    	}
							  		    });
							  		    return value;
				                	}else{
				                		return "";
				                	}
			                	}else if( rowObject.type == CONSTANT.BILL_ACTUAL_TYPE || rowObject.type == "Total" ){
			                		var resourcePlans = rowObject.resourcePlans;
				                	if( resourcePlans != null ){
							  		    var resourcePlanID = null;
							  		    $.each(resourcePlans, function(index, resourcePlan){
							  		    	
							  		    	if( name == (resourcePlan.month + "-" + resourcePlan.year ) ){
							  		    		resourcePlanID = resourcePlan.resourcePlanID;
							  		    		return;
							  		    	}
							  		    });
							  		   
							  		    if(resourcePlanID != null){
							  		    	
							  		    	 var resourcesActuals = rowObject.resourcesActuals;
							  		    	 var Class = rowObject.Class;
							  		    	 var value = "";
							  		    	 $.each(resourcesActuals, function(index, resourcesActual){
									  		    	if( resourcePlanID == resourcesActual.resourcePlanID ){
									  		    		if(rowObject.type == "Total"){
															value = resourcesActual["totalMM"];											  		    			
									  		    		}else{
								  		    				value = resourcesActual[ Class ];
									  		    		}
									  		    		return;
									  		    	}
									  		  });
						
											  return value;
							  		    	
							  		    }else{
							  		    	return "";
							  		    }
							  		    
				                	}else{
				                		return "";
				                	}
			                		
			                	}else{
			                		return "";
			                	}
			                	
			                	
			                	
					  		},
			                editoptions: { dataInit: function(el) 
			                	{
					    			$(el).addClass("text mm-data");
					    			$(el).autoNumeric({aPad: false, aSep: ""});
				    			},
				    			dataEvents :[
							   		{
								   		type : 'change',
								   		fn : function(e){
								   			localGrid.inputChange($(e.target));
								   		}
									}             
							   	]
			                }
			            } );
					});
					
				}
				$( localGrid.gridId ).jqGrid(
				        {
				            datatype : "local",
				            data: members || [],
				            colNames : colNames,
				            colModel : colModel,
				            autowidth : true,
				            shrinkToFit: false,
				            cellEdit : true,
// 				            height : auto,
				            rowNum: 10,
				            pager : '#paging',
				            beforeSelectRow: function(rowid, e) {
				            	return false;
				            },
				            onPaging : function(){
				            	console.log(members);
				            	$(localGrid.gridId).jqGrid('setGridParam',{data: members}).trigger('reloadGrid');
				            },
				           	gridComplete : function(){
				           		
				           		var length = ( members || [] ).length;
				           		for( var i = 0; i <  length; i++  ){
				           			var rowId = i + 1;
				           			
				           			var type = $( localGrid.gridId ).jqGrid('getCell', rowId,'type');
					            	if( type == CONSTANT.BILL_ACTUAL_TYPE ){
					           			$( localGrid.gridId ).editRow( rowId, true); 
					            	}
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
				           		localGrid.calculateTotal();
				           	}
				 		});
// 				$(localGrid.gridId).jqGrid('setFrozenColumns');
// 				$(localGrid.gridId).jqGrid('setGridParam',{data: members}).trigger('reloadGrid');
			},
			
			editData: function( rowId, data ){
				var employeeID = $( localGrid.gridId ).jqGrid ('getCell', rowId, 'employeeID');
				localGrid.data[ employeeID ] = data;
			},
			
			calculateTotal : function(){
				
				$("#resourceGrid tr[role='row']").each(function(){
					var id = parseInt($(this).attr('id'));
					var isappend = false;
					if(id % 5 == 0){
						isappend = true;
						var tr = $(this);
						var inputs =  tr.find("td[datatype='total']");
						total = 0;
						$.each( inputs, function(index, input){
							total += new Number( $(input).html() || 0 );
						});	
					}else{
						var tr = $(this);
						var inputs =  tr.find( ":text.text.editable.mm-data" );
						if(inputs.length != 0){
							isappend = true;
							total = 0;
							$.each( inputs, function(index, input){
								total += new Number( $(input).val() || 0 );
							});			
						}
					}
					if(isappend){
						tr.find( "td[aria-describedby=resourceGrid_plannedWorkSize]" ).html( total );
					}
				});
				
			},
			
			updateLocalData : function(data){
				var newData = [];
				$.each(members,function(i,item){
					if(item.type == "ACTUAL" || item.type == "Total"){
						var actualobject = item;
						if(item.projectMemberID == data.projectMemberID){
							var resourceActual = [];
								if(data.resourceActualID == ""){
									var defaultValue = {
											firstMM: data.firstMM,
											projectMemberID: data.projectMemberID,
											resourceActualID: "",
											resourcePlanID: data.resourcePlanID,
											secondMM: data.secondMM,
											thirdMM: data.thirdMM,
											totalMM: data.total
										};
									if(data.dataType == "firstMM"){
										defaultValue.firstOrgID  = data.orginzation;
										defaultValue.firstOrgName = data.orgName;
										defaultValue.firstEmployeeLevelID  = data.empLevel;
									}else if(data.dataType == "secondMM"){
										defaultValue.secondOrgID  = data.orginzation;
										defaultValue.secondOrgName = data.orgName;
										defaultValue.secondEmployeeLevelID  = data.empLevel;
									}else if(data.dataType == "thirdMM"){
										defaultValue.thirdOrgID  = data.orginzation;
										defaultValue.thirdOrgName = data.orgName;
										defaultValue.thirdEmployeeLevelID  = data.empLevel;										
									}
									if(item.resourcesActuals.length > 0 ){
										var isExist = false;
										$.each(item.resourcesActuals, function(i,actual){
											
											if(data.dataType == "firstMM"){
												actual.firstOrgID  = data.orginzation;
												actual.firstOrgName = data.orgName;
												actual.firstEmployeeLevelID  = data.empLevel;
												
												defaultValue.secondOrgID = actual.secondOrgID;
												defaultValue.secondOrgName = actual.secondOrgName;
												defaultValue.thirdOrgID  = defaultValue.thirdOrgID;
												defaultValue.thirdOrgName = actual.thirdOrgName;
												defaultValue.secondEmployeeLevelID = actual.secondEmployeeLevelID;
												defaultValue.thirdEmployeeLevelID = actual.thirdEmployeeLevelID;
												
											}else if(data.dataType == "secondMM"){
												actual.secondOrgID  = data.orginzation;
												actual.secondOrgName = data.orgName;
												actual.secondEmployeeLevelID  = data.empLevel;
												
												defaultValue.firstOrgID = actual.firstOrgID;
												defaultValue.firstOrgName = actual.firstOrgName;
												defaultValue.thirdOrgID  = defaultValue.thirdOrgID;
												defaultValue.thirdOrgName = actual.thirdOrgName;
												defaultValue.firstEmployeeLevelID = actual.firstEmployeeLevelID;
												defaultValue.thirdEmployeeLevelID = actual.thirdEmployeeLevelID;
												
											}else if(data.dataType == "thirdMM"){
												actual.thirdOrgID  = data.orginzation;
												actual.thirdOrgName = data.orgName;
												actual.thirdEmployeeLevelID  = data.empLevel;	
												
												defaultValue.firstOrgID = actual.firstOrgID;
												defaultValue.firstOrgName = actual.firstOrgName;
												defaultValue.secondOrgID = actual.secondOrgID;
												defaultValue.secondOrgName = actual.secondOrgName;
												defaultValue.firstEmployeeLevelID = actual.firstEmployeeLevelID;
												defaultValue.secondEmployeeLevelID = actual.secondEmployeeLevelID;
											}
											if(actual.resourcePlanID == data.resourcePlanID){
												actual.firstMM  = data.firstMM;
												actual.secondMM = data.secondMM;
												actual.thirdMM  = data.thirdMM;
												actual.totalMM = data.total;
												resourceActual.push(actual);
											}else{
												isExist = false;
												resourceActual.push(actual);
											}
										});
										if(!isExist){
											resourceActual.push(defaultValue);
										}
									}else{
										resourceActual.push(defaultValue);
									}
								}else{
									$.each(item.resourcesActuals, function(i,actual){
										if(data.dataType == "firstMM"){
											actual.firstOrgID  = data.orginzation;
											actual.firstOrgName = data.orgName;
											actual.firstEmployeeLevelID  = data.empLevel;
										}else if(data.dataType == "secondMM"){
											actual.secondOrgID  = data.orginzation;
											actual.secondOrgName = data.orgName;
											actual.secondEmployeeLevelID  = data.empLevel;
										}else if(data.dataType == "thirdMM"){
											actual.thirdOrgID  = data.orginzation;
											actual.thirdOrgName = data.orgName;
											actual.thirdEmployeeLevelID  = data.empLevel;										
										}
										if(actual.resourceActualID == data.resourceActualID){
											actual.firstMM  = data.firstMM;
											actual.secondMM = data.secondMM;
											actual.thirdMM  = data.thirdMM;
											actual.totalMM = data.total;
											resourceActual.push(actual);
										}else{
											resourceActual.push(actual);
										}
									});
								}
							actualobject.resourcesActuals = resourceActual;
							newData.push(actualobject);
						}else{
							newData.push(actualobject);
						}
					}else{
						newData.push(item);
					}
				});
				console.log(newData);
				members = newData;

			},
			
			inputChange : function(input){
				var td = input.parents("td");
  				var	tr = td.closest("tr");
  				var organization = tr.find( "td[organization]" ).attr("organization");
  				var orgName = tr.find( "td[organization]" ).attr("title");
				var empLevel = tr.find("td[empLevel]").attr( "empLevel" );
				
				
				var td = input.parent();
				var dataType = td.attr( "dataType" );
				var projectMemberID = td.attr( "memberID" );
				var resourcePlanID = td.attr( "resourcePlanID" );
				var resourceActualID = td.attr( "resourceActualID" );
				
// 				console.log(dataType + '|' + projectMemberID + "|" + resourcePlanID  + "|" + resourceActualID  + "|" +  organization +"|"+ empLevel);
				
				var name = input.attr( "name" );				
				var value = input.val();				
				
				var table = td.parent().parent();
				
				var firstValue = table.find( "td[dataType=firstMM][memberID=" + projectMemberID + "]" ).find( "input[name="  + name + "]" ).val();
				var secondValue = table.find( "td[datatype=secondMM][memberID=" + projectMemberID + "]" ).find( "input[name="  + name + "]" ).val();
				var thirdValue = table.find( "td[datatype=thirdMM][memberID=" + projectMemberID +"]" ).find( "input[name="  + name + "]" ).val();
				
				var totalMM = new Number( firstValue || 0 ) + new Number(secondValue || 0) + new Number(thirdValue || 0);
				
				table.find( "td[datatype=total][aria-describedby=resourceGrid_" + name + "][memberID=" + projectMemberID+ "]" ).html( totalMM );
			
			
				
				var tr = td.parent();
				var inputs =  tr.find( ":text.text.editable.mm-data" );
				total = 0;
				$.each( inputs, function(index, input){
					total += new Number( $(input).val() || 0 );
				});			

				tr.find( "td[aria-describedby=resourceGrid_plannedWorkSize]" ).html( total );
				
				
				total = 0;
				var cells = table.find( "td[datatype=total][memberID=" + projectMemberID+ "]" );
				$.each(cells, function( index, cell){
					total += new Number( $(cell).html() || 0 );
				});
				
				cells.parent().find( "[aria-describedby=resourceGrid_plannedWorkSize]" ).html( total );
				
				var data = [];
				data.dataType = dataType;
				data.projectMemberID = projectMemberID;
				data.resourcePlanID = resourcePlanID;
				data.resourceActualID = resourceActualID;
				data.firstMM = firstValue;
				data.secondMM = secondValue;
				data.thirdMM = thirdValue;
				data.total = totalMM;
				data.orginzation  = organization;
				data.empLevel = empLevel;
				data.orgName = orgName;
				localGrid.updateLocalData(data);			
				
			},
			
			orgLevelChange : function(type,Class,value,memberId,text){
				var newData = [];
				$.each(members,function(i,item){
					if(item.type == "ACTUAL"){
						var actualobject = item;
						if(item.projectMemberID == memberId){
							var resourceActual = [];
							$.each(item.resourcesActuals, function(i,actual){
								if(Class == "firstMM"){
									if(type == "org"){
										actual.firstOrgID  = value;
										actual.firstOrgName = text;
									}else{
										actual.firstEmployeeLevelID  = value;
									}
								}else if(Class == "secondMM"){
									if(type == "org"){
										actual.secondOrgID  = value;
										actual.secondOrgName = text;
									}else{
										actual.secondEmployeeLevelID  = value;
									}
								}else if(Class == "thirdMM"){
									if(type == "org"){
										actual.thirdOrgID  = value;
										actual.thirdOrgName = text;
									}else{
										actual.thirdEmployeeLevelID  = value;										
									}
								}
								resourceActual.push(actual);
							});
							actualobject.resourcesActuals = resourceActual;
							newData.push(actualobject);
						}else{
							newData.push(actualobject);
						}
					}else{
						newData.push(item);
					}
				});
				console.log(newData);
				members = newData;
			}
			
		};
</script>