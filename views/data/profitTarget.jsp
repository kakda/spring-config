<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<div  class="request">
	<div class="tree">
		<table class="table table-noborder">
			<colgroup>
				<col style="width: 120px" />
				<col />
				<col style="width: 120px" />
				<col />
				<col style="width: 120px" />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th><label for="year">Year:</label></th>
					<td>
						<select class="select" id="year">
							<tiles:insertTemplate template="/WEB-INF/views/elements/masterData/yearSelect.jsp" />
						</select>
					</td>
					<th><label for="lastUpdated">Last Update:</label></th>
					<td>
						<input type="text" readonly="readonly" class="text" id="lastUpdated" />
					</td>
					<th><label for="currency">Currency:</label></th>
					<td>
						<input type="radio" id="krw" class="currency" checked="checked" name="currency" /> <label for="krw">KRW</label>  
						<input type="radio" id="usd" class="currency" name="currency" /> <label for="usd">USD</label>
					</td>
				</tr>
			</tbody>
		</table>
	<div class="grid tab-grid">
		<table id="list"></table>
	</div>
	</div>
</div>


<script type="text/javascript">

	var profitTarget = {
			
			grid : $("#list"),
			DATA : "profit_target", 
			masterData : null,
			exchangeRate : null,
			KRW : 'krw',
			USD : 'usd',
			init : function(){
				
				profitTarget.initValue();
				profitTarget.initGrid();
				profitTarget.bindEvent();
			},
			
			initValue : function(){
				
				$("#year").val(new Date().getFullYear());
				profitTarget.observeMasterData();
				profitTarget.observeCurrency();
			},
			
			initGrid : function(){
				var editoptons = { 
					dataInit : function(element){
	   					$(element).autoNumeric({aPad: false});
	   				}
				};
				var formatter = function(cellvalue, options, rowObject){
					var currency = $(".currency:checked").attr("id");
					var formatValue = cellvalue;
					
					if (formatValue==null){formatValue=0;}
					if(currency == profitTarget.USD){
						formatValue = (formatValue / profitTarget.exchangeRate.krw).toFixed(2); 
					}
	   				return Yuga.commaSeparateNumber(formatValue);
	   			};
				var options = {
					url 		: "<c:url value='/profitTarget/getGrid.json'/>",
					colNames 	: ['ID', 'flag', 'level', 'OrgID','Team','Profit Target'],
					colModel 	: [
				   		{
				   			name	:'ID', 
				   			index	:'ID', 
				   			hidden	: true,
				   			editable: false 
				   		},
				   		{
				   			name	:'flag', 
				   			index	:'flag', 
				   			hidden	: true,
				   			editable: true 
				   		},
				   		{
				   			name	:'level', 
				   			index	:'level', 
				   			hidden	: true,
				   			editable: true 
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
				   			editable: false
				   		},
				   		{
				   			name	:'amountKRW', 
				   			index	:'amountKRW', 
				   			width	: 200,
				   			editable: false,
				   			align   : 'right',
				   			editoptions : editoptons,
				   			formatter : formatter
				   		}
					],
				    ExpandColumn: 'orgName',
					ExpandColClick:false,
					tree_root_level:1,
				    sortname: 'ID',
					treeGrid: true,
					rowNum: 99999,
					postData : {
						year : function(){
							return $("#year").val();
						},
						search : true
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
				profitTarget	.grid
							.jqGrid(options)
							.jqGrid('destroyGroupHeader')
					 		.jqGrid('setGroupHeaders', {
									  useColSpanStyle: true, 
									  groupHeaders:[
										{startColumnName: '1', numberOfColumns: 12, titleText: $("#year").val()}
									  ]
				});
			},
			
			bindEvent : function(){
				
				$("#year").on("change", profitTarget.onChangeYear);
				$(".currency").on("change", profitTarget.onChangeCurrency);
				
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
			
			getExchangeRate : function(){
				var year  = $("#year").val();
				var url = "<c:url value='/exchangeRate/byYear' />/" + year;
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
			
			onChangeYear : function(){
				profitTarget.initGrid();
				profitTarget.observeMasterData();
				profitTarget.observeCurrency();
			},
			
			observeMasterData : function(){
				profitTarget.masterData = profitTarget.getMasterData();
				$("#lastUpdated").val(profitTarget.masterData.lastUpdated);
			},
			
			observeCurrency : function(){
				profitTarget.exchangeRate = profitTarget.getExchangeRate();
			},
			
			onChangeCurrency : function(){
				profitTarget.grid.trigger("reloadGrid");
			},
			
			getColIndex : function(mygrid,columnName) {
                var cm = mygrid.jqGrid('getGridParam','colModel');
                for (var i=0,l=cm.length; i<l; i++) {
                    if (cm[i].name===columnName) {
                        return i; // return the index
                    }
                }
                return -1;
            }
	};

	$(document).ready(function(){

		profitTarget.init();
	});
</script>
