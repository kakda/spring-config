<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<div class="request">
	<h3>Timecard</h3>
	<div class="project-type">
		<ul>
			<c:forEach var="PTJ" items="${projectType}">
				<li><input type="checkbox" checked="checked" class="project-type projectTypeFilter" id="${PTJ.projectTypeID}" value="${PTJ.projectTypeID}"/><label for="${PTJ.projectTypeID}">${PTJ.title}</label></li>
			</c:forEach>
		</ul>
		<div class="check-all">
			<input type="checkbox" class="projectTypeFilter" id="chk-all"><label for="chk-all">Select All</label>
		</div>
	</div>
	
	<div class="timecard-filter">
		<div class="left">
			<label for="date">Date</label>
			<input type="text" class="text week" />
			
			<label for="empName">Employee</label>
			<select class="select" id="empName">
				<c:forEach var="emp" items="${empName}">
					<option value="${emp.employeeID}">${emp.employeeName} </option>					
				</c:forEach>
			</select>
		</div>
		
		<div class="right">
			<button class="btn white" id="btnPrev" type="button" class="back"> < </button>
			<button class="btn white" id="btnNext" type="button" class="next"> > </button>
		</div>
	</div>
	
	<div id="timecard">
		<table id="list"></table>
	</div>
	
	
	
</div>
<div id="dlgUnsubmit">
	<table id="submitList"></table>
</div>
<div id="dlgProjectDetail">
	<table class="dialog-form">
		<colgroup>
			<col width="150" />
			<col />
		</colgroup>
		<tr><td>Project Name</td><td><span class="info-project-name gray"></span></td></tr>
		<tr><td>Project Type</td><td><span class="info-project-type gray"></span></td></tr>
		<tr><td>Project Period</td><td><span class="info-project-period gray"></span></td></tr>
		<tr><td id="POT">Project Own Team</td><td><span class="info-project-own-team gray"></span></td></tr>
		<tr><td>Project Manager</td><td><span class="info-project-manager gray"></span></td></tr>
	</table>
	<div class="no-content">No more project.</div>
</div>


<script type="text/javascript">
	
	var DEF = {
		WORKING_HOUR : 8,
		SATUDAY : 6,
		SUNDAY : 0,
		DAY_IN_MONTH : 30,
		MAX_HOUR_PER_DAY : 24
	};

	$.fn.toString = function() {
		return $(this).wrap("<div>").parent().html();
	};

	var timecard = {
		
			dpWeek : $(".week"),
			grid : $("#list"),
			sortField : "projectName",
			lastsel : null,
			dateFormat : 'yyyy-MM-dd',
			init : function (){
				
				timecard.initData();
				timecard.bindingEvent();
				timecard.plugin();
				timecard.applyFilter();
				timecard.dialog();
				
			},
			
			
			initData : function(){
				
				// var ratioHour = timecard.formular.getRatioOfMM(new Date(), (new Date()).addDays(20), []);
				//console.log("1 Hour = " + ratioHour + " MM ");
			},
			
			dialog : function(){

				$('#dlgProjectDetail').dialog({
					modal: true,
					autoOpen: false,
					width: 800
				});
			},
			
			formular : {
				
				getRatioOfMM : function(startDate, endDate, holidays){
					
					startDate = new Date(startDate);
					endDate = new Date(endDate);
					
					var diffDate = endDate.diffPrevious(startDate),
						totalMM = diffDate/DEF.DAY_IN_MONTH,
						calculateHour = function(){
							var hour = 0;
							while(startDate < endDate){
								
								// Check not in weekend and holiday
								if(startDate.getDay() != DEF.SATUDAY &&
									startDate.getDay() != DEF.SUNDAY &&
									$.inArray( startDate.toString(Yuga.config.format.date), holidays) == -1){
									hour += DEF.WORKING_HOUR;
								}
								startDate.addDays(1);
							}
							return hour;
						},
						
						ratioHour = totalMM / calculateHour();
						
					return ratioHour;
				},
				
				getMMOfHour : function(ratio, totalHour){
					return ratio * totalHour;
				}
			},
			
			bindingEvent : function(){

				$('#chk-all').on('change',function(e){
					if(this.checked){
						$('.project-type').find(':checkbox').attr('checked', 'checked');
					}else{
						$('.project-type').find(':checkbox').removeAttr('checked');
					}
				 })
				 .click();
				$(".projectTypeFilter").on("change", function(){
					
					timecard.applyFilter();
				});
				$("#empName").on("change",function(){
					timecard.applyFilter();
				});
				
				$("#btnPrev").on("click", function(){
					timecard.moveDate.previousWeek();
				});
				
				$("#btnNext").on("click", function(){
					timecard.moveDate.nextWeek();
				});
				
				
			},
			
			date : {
				
				getStartDate : function(format){

					var date = timecard.dpWeek.datepicker('getDate').addDays(-1),
						startDate = (new Date(date)).addDays(-6).sunday();
					
					
					if(format == null){
						format = Yuga.config.format.date;
						
					}
					
					return startDate.toString(format); 
				},
				
				getEndDate : function(format){

					var date = timecard.dpWeek.datepicker('getDate').addDays(-1),
						endDate = (new Date(date)).saturday();
	
					if(format == null){
						format = Yuga.config.format.date;
					}
					
					return endDate.toString(format);
				}
			},
			
			preview : {
				rowId : 0,
				click : function(event){
					event.preventDefault();
					timecard.preview.rowId = $(this).attr("href");
					timecard.preview.view();
				},
				
				previous : function(){
					if(timecard.preview.rowId > 0){
						timecard.preview.rowId--;	
					}
					timecard.preview.view();
				},
				
				next : function(){
					if(timecard.preview.rowId <= timecard.grid.jqGrid('getGridParam', 'records')){
						timecard.preview.rowId++;
					}
					timecard.preview.view();
				},
				
				view : function(){

					var dlg = $("#dlgProjectDetail");
					var projectID = timecard.grid.jqGrid("getCell", timecard.preview.rowId, "projectID");
					var url = "<c:url value='/project' />/" + projectID + "/view";
					
					
					$.ajax({
						dataType : "json",
						url : url,
						success : function(response){
							if(response != null){
								$(".dialog-form").show();
								$(".no-content").hide();
								
								var startDate = new Date(response.startDate).toString(Yuga.config.format.date);
								var endDate = new Date(response.endDate).toString(Yuga.config.format.date);
								
								$(".gray").text("");
								$(".info-project-name").text(response.projectName);
								$(".info-project-type").text(response.projectType.title);
								$(".info-project-period").text(startDate + " - " + endDate);
								if (response.organization.orgName==null)
									{
										$("#POT").hide();
									}
								else{
										$("#POT").show();
										$(".info-project-own-team").text(response.organization.orgName);
									}
								
								$(".info-project-manager").text(response.employee.employeeName);	
								

								dlg.dialog({
									autoOpen: true,
									title : response.projectName,
									buttons : {
										"Close" : function(){
											$(this).dialog("close");
										}
									}
								});
								
							}else{
								dlg.dialog({ title : "No Project." });
								$(".dialog-form").hide();
								$(".no-content").show();
							}							
						}
					});
					
				}
			},
			
			
			moveDate : {
				
				previousWeek : function(){
					var currentDate = timecard.dpWeek.datepicker('getDate').addDays(-7);
					timecard.dpWeek.datepicker("setDate", currentDate);
					timecard.applyFilter();
				},
				
				nextWeek : function(){
					var currentDate = timecard.dpWeek.datepicker('getDate').addDays(7);
					timecard.dpWeek.datepicker("setDate", currentDate);
					timecard.applyFilter();
				},
				nexWeekDisable : function(){
					var saturdayOfWeek = timecard.dpWeek.datepicker('getDate').addDays(-1).saturday();
					
					// get current date
					var d = new Date();
					var month = d.getMonth()+1;
					var day = d.getDate();

					var currentDate = d.getFullYear() + '/' + month + '/' + day;					
					
					var x =  new Date(saturdayOfWeek);
					var y = new Date(currentDate);
					if(y<x){						
						$("#btnNext").attr('disabled',true);								
					}else{
						$("#btnNext").attr('disabled',false);								
					}
				}
			},
			
			applyFilter : function(){
				
				timecard.lastsel = null;
				var currentDate = timecard.dpWeek.datepicker('getDate').addDays(-7).sunday(),
					sunday = (new Date(currentDate)).toString(Yuga.config.format.date),
					monday = (new Date(currentDate))	.addDays(1).toString(Yuga.config.format.date),
					tuesday = (new Date(currentDate))	.addDays(2).toString(Yuga.config.format.date),
					wednesday = (new Date(currentDate))	.addDays(3).toString(Yuga.config.format.date),
					thursday = (new Date(currentDate))	.addDays(4).toString(Yuga.config.format.date),
					friday = (new Date(currentDate))	.addDays(5).toString(Yuga.config.format.date),
					saturday = (new Date(currentDate))	.addDays(6).toString(Yuga.config.format.date),
					$sortBy = $("<select>"),
					
					dayEditOption = {
			   				dataInit : function(element){
			   					$(element).autoNumeric({aPad: false, aSep: ""});
			   				},
			   				dataEvents : [
			   				    {
			   				    	type : "focus",
			   				    	fn : function(event){
			   				    		if($(event.target).val()=== "0"){
			   				    			$(event.target).val("");
			   				    		}
			   				    		$(event.target).select();
			   				    	}
			   				    },
			   				    {
			   				    	type : "blur",
			   				    	fn : function(event){
			   				    		if($(event.target).val()=== "0"){
			   				    			$(event.target).val("");
			   				    		}
			   				    	}
			   				    },
			   				    {
			   				    	type : "keydown",
			   				    	fn : function(event){
			   				    		var id = timecard.grid.jqGrid('getGridParam', 'selrow');
			   							var key = event.charCode || event.keyCode;
			   							if(key == 9){
			   								  if (id == null) return;
			   								  var ids = timecard.grid.jqGrid("getDataIDs");
			   								  var index =timecard.grid.getInd(id);
			   								  var cellEdit = $(event.target).attr("name");
			   								  if (ids.length < 2){
			   									  return;
			   								  }
			   								  index++;
			   								  if (index > ids.length) index = 1;
			   								  if(id && id!==timecard.lastsel){ 
			   									timecard.grid.restoreRow(timecard.lastsel); 
			   									timecard.lastsel=id; 
			   								  }
			   								  timecard.grid.saveRow(id,false);
			   								  timecard.grid.editRow(ids[index - 1],true,function(){
			   									  var elementSelect = ids[index - 1]+'_'+cellEdit;
			   									  $("#" + elementSelect).focus();
			   									  timecard.lastsel = ids[index - 1];
			   								  });
			   								 timecard.grid.resetSelection();
			   								 timecard.grid.jqGrid('setSelection',ids[index - 1]);
			   								 return false; 
			   							}
			   				    	}
			   				    }
			   				]
			   		},
			   		
			   		removeZeroFormatter = function(cellvalue, options, rowObject){
						if(cellvalue == "0"){	
		   					return "";
						} 
						return cellvalue;
					},
			   		
					options = {
						url 		: "<c:url value='/data/timecard/grid'/>",
						colNames 	: ['Timecard ID','ID', 'Project ID', 'Holiday', 'Status', 'Flag', 'Project Name', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Week HH', 'Week MM','Current MM', 'Assigned MM'],
						rownumbers	: true,
						multiselect	: false,
						userDataOnFooter : true, 
						footerrow : true, 
						editurl:'clientArray',
						editable: true,
						gridview: true,
						rowNum: 999999,
						/* treeGrid: true, */
						sortable: false,
						cmTemplate: { sortable: false },
						postData : {
							startDate: timecard.date.getStartDate,
							endDate: timecard.date.getEndDate,
							employeeID: function (){
								return $("#empName").val();
							},
							sortField: function(){
								return timecard.sortField; 
							},
							projectTypeIDs : function(){
								var projectTypeIDs = [];
								projectTypeIDs.push($("#chk-all").val());
								$('.project-type').find(':checkbox').not("#chk-all").each(function(){
									if($(this).is(':checked')){
										projectTypeIDs.push($(this).val());
									}
								});
								return projectTypeIDs;
							}
						},
						prmNames : {
							sort: "sort"
						},
						colModel 	: [
					   		{
					   			name	:'timecardID', 
					   			index	:'timecardID',
					   			hidden	: true
					   		},
					   		{
					   			name	:'timecardProjectID', 
					   			index	:'timecardProjectID', 
					   			hidden	: true
					   		},
					   		{
					   			name	:'projectID', 
					   			index	:'projectID', 
					   			hidden	: true
					   			
					   		},
					   		{
					   			name	:'holidays', 
					   			index	:'holidays', 
					   			hidden	: true
					   			
					   		},
					   		{
					   			name	:'status', 
					   			index	:'status', 
					   			hidden	: true
					   			
					   		},
					   		{
					   			name	:'flag', 
					   			index	:'flag', 
					   			width	: 30,
					   			formatter : function(cellvalue, options, rowObject){
					   				
					   				var $div = $("<div>");

									if(rowObject.status == CONSTANT.TIMECARD_STATUS_SUBMIT){
										$div.addClass("ico yes");
									}else{

						   				var totalMM = rowObject.currentMM + rowObject.weekMM;
										console.log(totalMM)
						   				if(totalMM > rowObject.plannedWorkSize && 
						   						rowObject.totalHour > 0 && 
						   						rowObject.plannedWorkSize != -1){
						   					$div.addClass("ico error overtime")
					   							.attr("id", rowObject.projectID)
					   							.attr("rel", rowObject.timecardProjectID);
						   				}
									}
					   				
					   				return $div.toString();
					   			}
					   		},
					   		{
					   			name	:'projectName', 
					   			index	:'projectName', 
					   			width	: 200,
					   			formatter : function(cellvalue, options, rowObject){
					   				
					   				var $a = $("<a>");
					   				
					   				$a.addClass("project-preview");
					   				$a.attr("href", options.rowId);
					   				$a.html(cellvalue);
					   				
					   				return $a.toString();
					   			}
					   		},
					   		{
					   			name	:'day1', 
					   			index	:'day1',
								editable: true,
								width	: 50,
					   			align	: 'center',
					   			editoptions : dayEditOption,
					   			formatter : removeZeroFormatter
					   		},
					   		{
					   			name	:'day2', 
					   			index	:'day2',
								editable: true,
								width	: 50,
					   			align	: 'center',
					   			editoptions : dayEditOption,
					   			formatter : removeZeroFormatter
					   		},
					   		{
					   			name	:'day3', 
					   			index	:'day3',
								editable: true,
								width	: 50,
					   			align	: 'center',
					   			editoptions : dayEditOption,
					   			formatter : removeZeroFormatter
					   		},
					   		{
					   			name	:'day4', 
					   			index	:'day4',
								editable: true,
								width	: 50,
					   			align	: 'center',
					   			editoptions : dayEditOption,
					   			formatter : removeZeroFormatter
					   		},
					   		{
					   			name	:'day5', 
					   			index	:'day5',
								editable: true,
								width	: 50,
					   			align	: 'center',
					   			editoptions : dayEditOption,
					   			formatter : removeZeroFormatter
					   		},
					   		{
					   			name	:'day6', 
					   			index	:'day6',
								editable: true,
								width	: 50,
					   			align	: "center",
					   			editoptions : dayEditOption,
					   			formatter : removeZeroFormatter
					   		},
					   		{
					   			name	:'day7', 
					   			index	:'day7',
								editable: true,
								width	: 50,
					   			align	: "center",
					   			editoptions : dayEditOption,
					   			formatter : removeZeroFormatter
					   		},
					   		{
					   			name	:'totalHour', 
					   			index	:'totalHour',
								width	: 40,
					   			align	: "center"
					   		},
					   		{
					   			name	:'weekMM', 
					   			index	:'weekMM',
								width	: 40,
					   			align	: "center",
					   			formatter : function(cellvalue, options, rowObject){
					   				return cellvalue.toFixed(CONSTANT.MM_FORMAT);
					   			}
					   		},
					   		{
					   			name	:'currentMM', 
					   			index	:'currentMM',
								width	: 50,
					   			align	: "center",
					   			formatter : function(cellvalue, options, rowObject){
					   				return cellvalue.toFixed(CONSTANT.MM_FORMAT);
					   			}
					   		},
					   		{
					   			name	:'assignedMM', 
					   			index	:'assignedMM',
								width	: 50,
					   			align	: "center",
					   			formatter : function(cellvalue, options, rowObject){
					   				return rowObject.plannedWorkSize.toFixed(CONSTANT.MM_FORMAT);
					   			}
					   		}
						],
						loadComplete : function(data){
							
							timecard.moveDate.nexWeekDisable();
							
							timecard.grid.jqGrid('footerData', 'set', {project : {projectName: "Total: "}});
							timecard.grid.jqGrid('footerData', 'set', {day1 : timecard.grid.jqGrid('getCol','day1',false,'sum')});
							timecard.grid.jqGrid('footerData', 'set', {day2 : timecard.grid.jqGrid('getCol','day2',false,'sum')});
							timecard.grid.jqGrid('footerData', 'set', {day3 : timecard.grid.jqGrid('getCol','day3',false,'sum')});
							timecard.grid.jqGrid('footerData', 'set', {day4 : timecard.grid.jqGrid('getCol','day4',false,'sum')});
							timecard.grid.jqGrid('footerData', 'set', {day5 : timecard.grid.jqGrid('getCol','day5',false,'sum')});
							timecard.grid.jqGrid('footerData', 'set', {day6 : timecard.grid.jqGrid('getCol','day6',false,'sum')});
							timecard.grid.jqGrid('footerData', 'set', {day7 : timecard.grid.jqGrid('getCol','day7',false,'sum')});
							timecard.grid.jqGrid('footerData', 'set', {totalHour : timecard.grid.jqGrid('getCol','totalHour',false,'sum')});
							

							$(".overtime").click(function(e){
								
								var projectID = $(this).attr('id');
								var timecardProjectID = $(this).attr('rel');
								var message = "Do you want to request for overtime this project ?";

								Yuga.dialog.confirm(message , function(){

									var url = "<c:url value='/timecard/requestOvertime'/>";
									var data = "projectID=" + projectID + "&timecardProjectID=" + timecardProjectID;
									
									$.ajax({
										url : url,
										method : "POST",
										data : data,
										success : function(result){
											
											console.log(result);
										}
									});
								});
							});
							
							var url = "<c:url value='/holiday/getHoliday' />";
							var data = "startDate=" + timecard.date.getStartDate(Yuga.config.format.date) 
								     + "&endDate=" + timecard.date.getEndDate(Yuga.config.format.date)
								     + "&empName="+$( "#empName option:selected" ).val();
							//------------include empName which is ID of employee as request parameter 
							
							$.ajax({
								url : url,
								dataType : "json",
								data : data,
								method : "POST",
								success : function(result){
									if(result.length > 0){
										var ids = timecard.grid.jqGrid('getDataIDs');
										for(var i = 0; i < result.length; i ++){
											for (var j=0; j < ids.length; j++) {
												timecard.grid.jqGrid("setCell",ids[j],"day" + result[i].weekDay,"","red");
											}
										}
									}
								}
							});
							
							var ids = timecard.grid.jqGrid('getDataIDs');
							var jsonData = timecard.grid.jqGrid('getGridParam', 'data');							

							for (var i=0;i < ids.length; i++) {
			                    var id=ids[i];			                    
			                    var status 		=  timecard.grid.jqGrid("getCell", id, "status");
			                    
			                    if (status == CONSTANT.TIMECARD_STATUS_SUBMIT) {
			                        $("#"+ id).addClass("not-editable-row");
			                    	$("#"+ id).find(":checkbox")
			                    			  .attr("disabled", "disabled")
			                    			  .hide();
			                    }

			                    timecard.grid.jqGrid("setCell",id,"day1","","red");
			                    timecard.grid.jqGrid("setCell",id,"day7","","red");
								
			                }		
							
							$(".project-preview").on("click", timecard.preview.click);
							$("#projectType").one("change", function(){
								
								timecard.sortField = $(this).val();
								timecard.grid.trigger("reloadGrid");
							});
						}
					};
				
				$sortBy.attr("id", "projectType");
				
				if(timecard.sortField == "projectName"){
					$sortBy.append("<option selected='selected' value='projectName'>Project Name</option>")
				    	   .append("<option value='sortOrder'>Project Type</option>");
				}else{
					$sortBy.append("<option value='projectName'>Project Name</option>")
			    	       .append("<option selected='selected' value='sortOrder'>Project Type</option>");
				}
					
					
				timecard.grid.trigger("reloadGrid");
				timecard.grid.jqGrid(options)
						 .jqGrid('destroyGroupHeader')
				 		 .jqGrid('setGroupHeaders', {
								  useColSpanStyle: true, 
								  groupHeaders:[
									{startColumnName: 'flag', 		numberOfColumns: 2, titleText: "Sort By: " + $sortBy.toString()},
									{startColumnName: 'day1', 		numberOfColumns: 1, titleText: sunday},
									{startColumnName: 'day2', 		numberOfColumns: 1, titleText: monday},
									{startColumnName: 'day3', 		numberOfColumns: 1, titleText: tuesday},
									{startColumnName: 'day4', 		numberOfColumns: 1, titleText: wednesday},
									{startColumnName: 'day5', 		numberOfColumns: 1, titleText: thursday},
									{startColumnName: 'day6', 		numberOfColumns: 1, titleText: friday},
									{startColumnName: 'day7', 		numberOfColumns: 1, titleText: saturday},
									{startColumnName: 'totalHour', 	numberOfColumns: 4, titleText: "Total"}
								  ]
				}); 
			},
			
			
			plugin : function(){

				// Apply weekly datepicker				
				var applyWeeklySelected = function(input, inst){
					
					setTimeout(function(){

						inst.dpDiv
								.find(".ui-state-active")
								.closest("tr")
								.addClass("current-week");

						inst.dpDiv.find("tbody tr").hover(
								function(){
									$(this).addClass("selected-week");
									
								},
								function(){
									$(this).removeClass("selected-week");
								});
						
					}, 100);
				},
					lastDayOfWeek = (new Date()).addDays(-1).saturday();
				
				
				timecard.dpWeek.datepicker({
					beforeShow: applyWeeklySelected,
					showOtherMonths: true,
					selectOtherMonths: true,
					maxDate: lastDayOfWeek,
					onChangeMonthYear : function(year, month, inst){
						applyWeeklySelected($(this), inst);
						
					
					},
					onSelect: function(dateText, inst){
						timecard.applyFilter();
						
					}
				})
				.datepicker("setDate", new Date());
			}
	};
	
	$(document).ready(timecard.init);
</script>
