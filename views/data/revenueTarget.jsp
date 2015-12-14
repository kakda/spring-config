<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="format"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>



<!-- RevenueTarget Data -->

<div class="request">
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
					<td><select class="select" id="year">
							<tiles:insertTemplate
								template="/WEB-INF/views/elements/masterData/yearSelect.jsp" />
					</select></td>
					<th><label for="lastUpdated">Last Update:</label></th>
					<td><input type="text" readonly="readonly" class="text"
						id="lastUpdated" /></td>
					<th><label for="currency">Currency:</label></th>
					<td><input type="radio" id="krw" class="currency"
						checked="checked" name="currency" /> <label for="krw">KRW</label>
						<input type="radio" id="usd" class="currency" name="currency" />
						<label for="usd">USD</label></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="grid tab-grid">
		<table id="list"></table>
	</div>
</div>


<script type="text/javascript">
	var revenueTarget = {

		grid : $("#list"),
		DATA : "revenue_target",
		masterData : null,
		exchangeRate : null,
		KRW : 'krw',
		USD : 'usd',
		init : function() {

			revenueTarget.initValue();
			revenueTarget.initGrid();
			revenueTarget.bindEvent();
			
		},

		initValue : function() {

			$("#year").val(new Date().getFullYear());
			revenueTarget.observeMasterData();
			revenueTarget.observeCurrency();
		},

		initGrid : function() {
			var editoptons = {
				dataInit : function(element) {
					$(element).autoNumeric({
						aPad : false
					});
				}
			};
			var formatter = function(cellvalue, options, rowObject) {
				var currency = $(".currency:checked").attr("id");
				var formatValue = cellvalue;
				if (currency == revenueTarget.USD) {
					formatValue = (formatValue / revenueTarget.exchangeRate.krw).toFixed(2);
				}
				return Yuga.commaSeparateNumber(formatValue);
			};
			var options = {
				url : "<c:url value='/revenueTarget/getGrid.json'/>",
				colNames 	: ['ID', 'OrgID',  'level', 'Team', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'],
				colModel 	: [
			   		{
			   			name	:'ID', 
			   			index	:'ID', 
			   			hidden	: true
			   		},
			   		{
			   			name	:'orgID', 
			   			index	:'orgID', 
			   			hidden	: true
			   		},
			   		{
			   			name	:'level', 
			   			index	:'level', 
			   			hidden	: true
			   		},
			   		{
			   			name	:'orgName', 
			   			index	:'orgName', 
			   			width	: 200
			   		},
			   		{
			   			name 	: '1',
			   			index	: '1',
			   			width	: 90,
			   			align   : 'right',
			   			formatter : formatter
			   		},
			   		{
			   			name 	: '2',
			   			index	: '2',
			   			width	: 90,
			   			align : "right",
			   			formatter : formatter
			   		},
			   		{
			   			name 	: '3',
			   			index	: '3',
			   			width	: 90,
			   			align : "right",
			   			formatter : formatter
			   		},
			   		{
			   			name 	: '4',
			   			index	: '4',
			   			width	: 90,
			   			align : "right",
			   			formatter : formatter
			   		},
			   		{
			   			name 	: '5',
			   			index	: '5',
			   			width	: 90,
			   			align : "right",
			   			formatter : formatter
			   		},
			   		{
			   			name 	: '6',
			   			index	: '6',
			   			width	: 90,
			   			align : "right",
			   			formatter : formatter
			   		},
			   		{
			   			name 	: '7',
			   			index	: '7',
			   			width	: 90,
			   			align : "right",
			   			formatter : formatter
			   		},
			   		{
			   			name 	: '8',
			   			index	: '8',
			   			width	: 90,
			   			align : "right",
			   			formatter : formatter
			   		},
			   		{
			   			name 	: '9',
			   			index	: '9',
			   			width	: 90,
			   			align : "right",
			   			formatter : formatter
			   		},
			   		{
			   			name 	: '10',
			   			index	: '10',
			   			width	: 90,
			   			align : "right",
			   			formatter : formatter
			   		},
			   		{
			   			name 	: '11',
			   			index	: '11',
			   			width	: 90,
			   			align : "right",
			   			formatter : formatter
			   		},
			   		{
			   			name 	: '12',
			   			index	: '12',
			   			width	: 90,
			   			align : "right",
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
					year : function() {
						return $("#year").val();
					},
					search : true
				},
				loadComplete: function (data) {

					 var 	
					        cRows = this.rows.length, 
					        iRow, 
					        row, 
					        className;

				    for (iRow=0; iRow<cRows; iRow++) {
				        row = this.rows[iRow];
				        className = row.className;
				        if ($.inArray('jqgrow', className.split(' ')) > 0) {
				        	var level = revenueTarget.grid.jqGrid("getCell", iRow, "level");
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

			revenueTarget.grid.trigger("reloadGrid");
			revenueTarget.grid.jqGrid(options).jqGrid('destroyGroupHeader')
					.jqGrid('setGroupHeaders', {
						useColSpanStyle : true,
						groupHeaders : [ {
							startColumnName : '1',
							numberOfColumns : 12,
							titleText : $("#year").val()
						} ]
					});
		},

		bindEvent : function() {

			$("#year").on("change", revenueTarget.onChangeYear);
			$(".currency").on("change", revenueTarget.onChangeCurrency);

		},

		getMasterData : function() {
			var year = $("#year").val();
			var url = "<c:url value='/masterData' />/" + year + "/"
					+ revenueTarget.DATA + "/get";
			var obj = null;

			$.ajax({
				url : url,
				dataType : "json",
				async : false,
				success : function(response) {
					obj = response;
				}
			});
			return obj;
		},

		getExchangeRate : function() {
			var year = $("#year").val();
			var url = "<c:url value='/exchangeRate/byYear' />/" + year;
			var obj = null;

			$.ajax({
				url : url,
				dataType : "json",
				async : false,
				success : function(response) {
					obj = response;
				}
			});
			return obj;
		},

		onChangeYear : function() {
			revenueTarget.initGrid();
			revenueTarget.observeMasterData();
			revenueTarget.observeCurrency();
		},

		observeMasterData : function() {
			revenueTarget.masterData = revenueTarget.getMasterData();
			$("#lastUpdated").val(revenueTarget.masterData.lastUpdated);
		},

		observeCurrency : function() {
			revenueTarget.exchangeRate = revenueTarget.getExchangeRate();
		},

		onChangeCurrency : function() {
			revenueTarget.grid.trigger("reloadGrid");
		}
	};

	$(document).ready(revenueTarget.init());	
	
</script>

