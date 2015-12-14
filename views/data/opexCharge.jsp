<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="format"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>


<div id="tabsOC">
	<div class="tree">
		<div class="validDate">
			<label for="lastUpdated">Last Update</label> <input type="text"
				readonly="readonly" class="text" id="lastUpdated" />
		</div>

		<div class="validDate">
			<label for="year">Year</label> <select class="select" id="year">
				<tiles:insertTemplate
					template="/WEB-INF/views/elements/masterData/yearSelect.jsp" />
			</select>
		</div>
	</div>

	<div class="grid tab-grid" style="width: 100%">
		<table id="list"></table>
		<div id="paging"></div>
	</div>

</div>


<script type="text/javascript">	

	var opexCharge = {
		grid : $("#list"),
		DATA : "opex_charge",
		YES : 'Y',
		masterData : null,
		init : function() {

			opexCharge.initValue();
			opexCharge.initGrid();
			opexCharge.bindEvent();
		},

		bindEvent : function() {

			$("#year").on("change", opexCharge.onChangeYear);
			
		},

		initGrid : function() {
			add = {
				recreateForm : true,
				left : 100,
				closeAfterEdit : true,
				onclickSubmit : function(options, postData) {										
					return {
						year : $("#year").val(),
						data : opexCharge.DATA,					
					};
				},
				beforeShowForm : function(form) {
					$(form).append($('<div>', {
						rel : "add",
						id : "operation"
					}));
				}
			}, edit = $.extend(add, {
				beforeShowForm : function(form) {
					$(form).append($('<div>', {
						rel : "edit",
						id : "operation"
					}));
				}
			});
			options = {
				url : "<c:url value='/opexCharge/getGrid'/>",
				colNames : [ 'OpexChargeID', 'GP Type', 'Rate', 'Remark' ],
				colModel : [ {
					name : 'opexChargeID',
					index : 'opexChargeID',
					width : 10,
					hidden : true,
					editable : true
				}, {
					name : 'gpType',
					index : 'gpType',
					width : 100,
					editable : false
				}, {
					name : 'rate',
					index : 'rate',
					width : 30,
					editable : true,
					editrules : {
						required : true
					},
					editoptions : {
						dataInit : function(element) {
							$(element).autoNumeric({
								aPad : false,
								aSep : ""
							});
						}
					},
					formatter : function(cellvalue, options, rowObject) {
						return cellvalue.toFixed(2) + " %";
					},
					unformat : function(cellvalue, options, rowObject) {
						return parseFloat(cellvalue);
					}
				}, {
					name : 'remark',
					index : 'remark',
					width : 120,
					editable : true
				} ],
				autowidth:true,
				rowNum : 999,
				pager : '#paging',
				editurl : "<c:url value='/opexCharge/saveRow'/>",
				postData : {
					year : function() {
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
				loadComplete : function() {
					opexCharge.observeMasterData();
				}
			};

			opexCharge.grid.jqGrid(options).jqGrid('navGrid', "#paging", {
				edit : false,
				add : false,
				del : false,
				search : false,
				refresh : true
			}, add, edit);

		},

		

		initValue : function() {
			$("#year").val(new Date().getFullYear());
		},

		onChangeYear : function() {
			opexCharge.grid.trigger("reloadGrid");
		},

		getMasterData : function() {
			var year = $("#year").val();
			var url = "<c:url value='/masterData' />/" + year + "/"
					+ opexCharge.DATA + "/get";
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

		submitMasterData : function() {
			var url = "<c:url value='/masterData/submit' />";
			var data = {
				year : $("#year").val(),
				data : opexCharge.DATA
			};
			$.ajax({
				url : url,
				dataType : "json",
				method : "post",
				data : JSON.stringify(data),
				contentType : "application/json",
				success : function(response) {
					if (response) {
						opexCharge.observeMasterData();
					}
				}
			});
		},

		observeMasterData : function() {
			opexCharge.masterData = opexCharge.getMasterData();
			if (opexCharge.masterData != null) {
				$("#lastUpdated").val(opexCharge.masterData.lastUpdated);
			}
			
		}
	};

	$(document).ready(opexCharge.init);
</script>
