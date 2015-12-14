<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="format"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<div class="request gpTargetpanel" >
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
	var gpTarget = {

		grid : $("#list"),
		DATA : "gp_target",
		masterData : null,
		exchangeRate : null,
		KRW : 'krw',
		USD : 'usd',
		init : function() {

			gpTarget.initValue();
			gpTarget.initGrid();
			gpTarget.bindEvent();
		},

		initValue : function() {

			$("#year").val(new Date().getFullYear());
			gpTarget.observeMasterData();
			gpTarget.observeCurrency();
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
				if(formatValue == null ){					
					formatValue = 0;	
				}else if (currency == gpTarget.USD) {
					formatValue = (formatValue / gpTarget.exchangeRate.krw).toFixed(2);
				}
				return Yuga.commaSeparateNumber(formatValue);
			};
			var options = {
					url 		: "<c:url value='/gpTarget/getGrid.json'/>",
					colNames 	: ['OrgID', 'Team','GP Target'],
					colModel 	: [
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
				   			width	: 400,
				   			editable: false
				   		},
				   		{
				   			name 	: 'amountKRW',
				   			index	: 'amountKRW',
				   			width	: 400,
				   			editable: false,
				   			align : "right",
				   			editoptions : editoptons,
				   			formatter : formatter
				   		}
					],
					autowidth:true,
					shrinkToFit: true,
					rowNum: 99999,
					sortname: "OrgID",							
					cellEdit: false,
					cellsubmit : "remote",
					gridview: true,
					viewrecords: false,				
					cellurl : "<c:url value='/gpTarget/saveRow'/>",
					postData : {
						year : function(){
							return $("#year").val();
						}
					}					
			};

			gpTarget.grid.trigger("reloadGrid");
			gpTarget.grid.jqGrid(options).jqGrid('destroyGroupHeader')
					.jqGrid('setGroupHeaders', {
						useColSpanStyle : true,
						groupHeaders : [ {
							startColumnName : '1',
							numberOfColumns : 2,
							titleText : $("#year").val()
						} ]
					});
		},

		bindEvent : function() {

			$("#year").on("change", gpTarget.onChangeYear);
			$(".currency").on("change", gpTarget.onChangeCurrency);

		},

		getMasterData : function() {
			var year = $("#year").val();
			var url = "<c:url value='/masterData' />/" 
					+ year + "/"
					+ gpTarget.DATA 
					+ "/get";
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
			gpTarget.initGrid();
			gpTarget.observeMasterData();
			gpTarget.observeCurrency();
		},

		observeMasterData : function() {
			gpTarget.masterData = gpTarget.getMasterData();
			$("#lastUpdated").val(gpTarget.masterData.lastUpdated);
		},

		observeCurrency : function() {
			gpTarget.exchangeRate = gpTarget.getExchangeRate();
		},

		onChangeCurrency : function() {
			gpTarget.grid.trigger("reloadGrid");
		}
	};

	$(function(){
			gpTarget.init();
// 			$('div .gpTargetpanel').css( { marginLeft : 200 } );		
	});
</script>

