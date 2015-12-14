<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="format"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!-- Data UnitPrice -->

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

	var employeeLevel = {
		grid : $("#list"),
		DATA : "employee_level",
		YES : 'Y',
		KRW : 'krw',
		USD : 'usd',
		masterData : null,
		exchangeRate : null,
		init : function() {
			employeeLevel.initValue();
			employeeLevel.initGrid();
			employeeLevel.bindEvent();
		},

		initValue : function() {
			$("#year").val(new Date().getFullYear());
			employeeLevel.observeCurrency();
		},

		bindEvent : function() {
			$("#year").on("change", employeeLevel.onChangeYear);
			$(".currency").on("change", employeeLevel.onChangeCurrency);
		},

		onChangeYear : function() {
			employeeLevel.grid.trigger("reloadGrid");
			employeeLevel.observeMasterData();
			employeeLevel.observeCurrency();
		},

		getMasterData : function() {
			var year = $("#year").val();
			var url = "<c:url value='/masterData' />/" + year + "/"
					+ employeeLevel.DATA + "/get";
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

		observeMasterData : function() {
			employeeLevel.masterData = employeeLevel.getMasterData();
			$("#lastUpdated").val(employeeLevel.masterData.lastUpdated);

		},

		observeCurrency : function() {
			employeeLevel.exchangeRate = employeeLevel.getExchangeRate();
		},

		onChangeCurrency : function() {
			employeeLevel.grid.trigger("reloadGrid");
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
		initGrid : function() {
			var numberOption = {
				dataInit : function(element) {
					$(element).autoNumeric({
						aPad : false
					});
				}
			}, formatter = function(cellvalue, options, rowObject) {

				var currency = $(".currency:checked").attr("id");
				var formatValue = cellvalue;
				if (currency == employeeLevel.USD) {
					formatValue = (formatValue / employeeLevel.exchangeRate.krw)
							.toFixed(2);
				}
				return Yuga.commaSeparateNumber(formatValue);

			}, unformat = function(cellvalue, options, rowObject) {
				return Yuga.removeComma(cellvalue);
			};
			options = {
				url : "<c:url value='/employeeLevel/getGrid'/>",
				colNames : [ 'ID', 'Level', 'List Price', 'Dev. Cost',
						'Internal Billing Price', 'Internal Dev. Cost',
						'Remark' ],
				colModel : [ {
					name : 'empLevelID',
					index : 'empLevelID',
					width : 100,
					align : 'center',
					hidden : true,
					editable : true
				}, {
					name : 'title',
					index : 'title',
					width : 70,
					editable : true,
					hiddden : true
				}, {
					name : 'listPriceKRW',
					index : 'listPriceKRW',
					width : 50,
					align : 'right',
					editable : true,
					editrules : {
						number : true,
						minValue : 0
					},
					editoptions : numberOption,
					editrules : {
						required : true
					},
					formatter : formatter,
					unformat : unformat,
					editrules : {
						required : true
					}
				}, {
					name : 'devCostKRW',
					index : 'devCostKRW',
					width : 50,
					align : 'right',
					editable : true,
					editrules : {
						number : true,
						minValue : 0
					},
					editoptions : numberOption,
					formatter : formatter,
					unformat : unformat,
					editrules : {
						required : true
					}
				}, {
					name : 'internalBillingPriceKRW',
					index : 'internalBillingPriceKRW',
					width : 50,
					align : 'right',
					editable : true,
					editrules : {
						number : true,
						minValue : 0
					},
					editoptions : numberOption,
					editrules : {
						required : true
					},
					formatter : formatter,
					unformat : unformat,
					editrules : {
						required : true
					}
				}, {
					name : 'internalDevCostKRW',
					index : 'internalDevCostKRW',
					width : 50,
					align : 'right',
					editrules : {
						number : true,
						minValue : 0
					},
					editoptions : numberOption,
					editrules : {
						required : true
					},
					formatter : formatter,
					unformat : unformat,
					editrules : {
						required : true
					}
				}, {
					name : 'remark',
					index : 'remark',
					width : 110,
					editable : true
				} ],
				rowNum : 999,
				pager : '#paging',
				postData : {
					year : function() {
						return $("#year").val();
					}
				},

				loadComplete : function() {
					employeeLevel.observeMasterData();
				}
			};

			employeeLevel.grid.jqGrid(options).jqGrid('navGrid', "#paging", {
				edit : false,
				add : false,
				del : false,
				search : false,
				refresh : true
			});

		}
	};

	$(document).ready(employeeLevel.init);
</script>

