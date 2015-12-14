<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>


<div id="tabsPRT">
	<div  class="request">
		<div class="tree">
			<div class="validDate">
				<label for="year">Year</label>
				<select class="select" id="year">
					<tiles:insertTemplate template="/WEB-INF/views/elements/masterData/yearSelect.jsp" />
				</select>
				(Unit Base: KRW)
			</div>
		</div>
		<div class="grid tab-grid">
			<table id="list"></table>
			<div id="paging"></div>
		</div>
		<div class="btn-group">
			<button type="button" id="submitData" class="btn btn-primary">Submit</button>
		</div>
	</div>
</div>


<script type="text/javascript">

	var profitTarget = {
			
			grid : $("#list"),
			DATA : "profit_target", 
			YES : 'Y',
			masterData : null,
			init : function(){
				
				profitTarget.initTab();
				profitTarget.initValue();
				profitTarget.initGrid();
				profitTarget.bindEvent();
			},
			
			initValue : function(){
				
				$("#year").val(new Date().getFullYear());
				profitTarget.observeMasterData();
			},
			
			initTab : function(){

				$("#tabs").tabs({
					 active: 6,
					 activate : function(event, ui){	 
						 Yuga.redirect(url[ui.newPanel.selector]);
					 }
				});
			},
			
			initGrid : function(){
				add = {
						recreateForm : true,
						left : 100,
						closeAfterEdit : true,
						onclickSubmit : function(options, postData) {			
							return {
								year : $("#year").val(),
								data : profitTarget.DATA,					
							};
						},
						
						beforeShowForm : function(form) {
							$(form).append($('<div>', {
								rel : "add",
								id : "operation"
							}));
						}
				};
				var editoptons = { 
					dataInit : function(element){
	   					$(element).autoNumeric({aPad: false});
	   				}
				};
				var formatter = function(cellvalue, options, rowObject){
	   				return Yuga.commaSeparateNumber(cellvalue);
	   			};
	   			var unformat = function(cellvalue, options, rowObject){
	   				return Yuga.removeComma(cellvalue);
	   			};
				var options = {
					url 		: "<c:url value='/profitTarget/getGrid.json'/>",
					colNames 	: ['ID', 'OrgID','Team','Profit Target'],
					colModel 	: [
				   		{
				   			name	:'ID', 
				   			index	:'ID', 
				   			hidden	: true,
				   			editable: false 
				   		},
				   		
				   		{
				   			name	:'orgID', 
				   			index	:'orgID', 
				   			width	: 200,
				   			hidden	: true,
				   			editable: true 
				   		},
				   		{
				   			name	:'orgName', 
				   			index	:'orgName', 
				   			width	: 200,
				   			editable: true,
							editoptions : {
								readonly : 'readonly'
							}
				   		},
				   		{
				   			name	:'amountKRW', 
				   			index	:'amountKRW', 
				   			width	: 200,
				   			editable: false,
				   			formatter : formatter,
				   			unformat : unformat,
				   			align   : 'right',
				   			editable: true,
				   			editoptions : {
								dataInit : function(element) {
									$(element).autoNumeric({
										aPad : false,
										aSep : ""
									});
								}
							}
				   		
				 
				   		}
				   		
					],
					rowNum: 99999,
					pager : '#paging',
					rownumbers : true,
				    sortname: 'ID',
				//	cellsubmit : "remote", 
					//treeGrid: true,
				  //  ExpandColumn: 'orgName',
				
					//tree_root_level:1,
					//viewrecords: false,
				   // treeGridModel: "adjacency",
					//cellurl : "<c:url value='/profitTarget/saveRow'/>",
					editurl : "<c:url value='/profitTarget/saveRow'/>",
					postData : {
						year : function(){
							return $("#year").val();
							
						}
					},
					edit : {
						addCaption : "Add Record",
						editCaption : "Edit Record",
						bSubmit : "Submit",
						bCancel : "Cancel",
						bClose : "Close",
						saveData : "Data has been changed! Save changes?",
						bYes : "Yes",
						bNo : "No",
						bExit : "Cancel"
						},
					beforeSubmitCell : function(rowID, cellName, value, iRow, iCol){
						var obj = {};
						obj.year = $("#year").val() ;
						obj.amountKRW = Yuga.removeComma(value);
						obj.orgID = profitTarget.grid.jqGrid("getCell", iRow, "orgID");
						
						return obj;
					},
					loadComplete: function (data) {

						 var 	iCol = profitTarget.getColIndex($(this), 'level'),
						        cRows = this.rows.length, 
						        iRow, 
						        row, 
						        className;

					    for (iRow=0; iRow<cRows; iRow++) {
					        row = this.rows[iRow];
					        className = row.className;
					        if ($.inArray('jqgrow', className.split(' ')) > 0) {
					        	var level = profitTarget.grid.jqGrid("getCell", iRow, "level");
					        	if(level === 1 || level === '1'){
					                if ($.inArray('cccccc', className.split(' ')) === -1) {
					                    row.className = className + ' cccccc';
					                }	
					        	}else if(level === 2 || level === '2'){
					        		if ($.inArray('gray', className.split(' ')) === -1) {
					                    row.className = className + ' gray';
					                }
					        	}
					        }
					    }
	                }
				};

				profitTarget.grid
							.trigger("reloadGrid");
				profitTarget.grid
							.jqGrid(options)
							.jqGrid('destroyGroupHeader')
					 		/* .jqGrid('setGroupHeaders', {
									  useColSpanStyle: true, 
									  groupHeaders:[
										{startColumnName: '1', numberOfColumns: 12, titleText: $("#year").val()}
									  ]
				}) */.jqGrid('navGrid',"#paging",{
					edit : true,
					add : false,
					del : false,
					search : false,
					refresh : false
				},add);
			},
			
			bindEvent : function(){
				
				$("#year").on("change", profitTarget.onChangeYear);
				
				$("#submitData").on("click", function(){
					Yuga.dialog.confirm(
						"Warning! when you click submit this masterdata <br /> You will not be able edit it in next time.", 
						profitTarget.submitMasterData
					);
				});
			},
			
			getAmountOfMonth : function(rowObject, month){
				var result = 0;
				$.each(rowObject, function(index, value){
					if (Number(index.substr(0, 2)) == month ){
						result = value;
						return;
					}
				});
				return result;
			},
			
			getMasterData : function(){
				var year  = $("#year").val();
				var url = "<c:url value='/masterData' />/" + year + "/" + profitTarget.DATA + "/get";
				var obj = null; 
				
				$.ajax({
					url : url,
					dataType : "json",
					async : false,
					success : function(response){
						obj = response;
					}
				});
				return obj;
			},
			getColIndex : function(mygrid,columnName) {
                var cm = mygrid.jqGrid('getGridParam','colModel');
                for (var i=0,l=cm.length; i<l; i++) {
                    if (cm[i].name===columnName) {
                        return i; // return the index
                    }
                }
                return -1;
            },
			submitMasterData : function(){
				var url = "<c:url value='/masterData/submit' />";
				var data = {
					year : $("#year").val(),
					data : profitTarget.DATA
				};
				$.ajax({
					url : url,
					dataType : "json",
					method : "post",
					data : JSON.stringify(data), 
					contentType : "application/json",
					success : function(response){
						if(response){
							profitTarget.observeMasterData();
							gpTarget.grid.trigger("reloadGrid");
						}
					}
				});
			},
			
			onChangeYear : function(){
				profitTarget.initGrid();
				profitTarget.observeMasterData();
			},
			
			observeMasterData : function(){
				profitTarget.masterData = profitTarget.getMasterData();
				if(profitTarget.masterData.editable == profitTarget.YES){
					$("#submitData").show();
				}else{
					$("#submitData").hide();
				}
			},
			
			reloadGrid : function(){
				profitTarget.grid.trigger("reloadGrid");
				profitTarget.grid.jqGrid('destroyGroupHeader')
								 .jqGrid('setGroupHeaders', {
										  useColSpanStyle: true, 
										  groupHeaders:[
											{startColumnName: '1', numberOfColumns: 12, titleText: $("#year").val()}
										  ]});
			}
	};

	$(document).ready(function(){
		profitTarget.init();
		
		
	});
</script>
