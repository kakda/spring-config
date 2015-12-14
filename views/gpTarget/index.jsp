<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<div id="tabsGPT">
	<div class="request gpTargetpanel">
		<div class="tree">
			<div class="validDate">
				<label for="year">Year</label> <select class="select" id="year">
					<tiles:insertTemplate
						template="/WEB-INF/views/elements/masterData/yearSelect.jsp" />
				</select> (Unit Base: KRW)
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
	var gpTarget = {

		grid : $("#list"),
		DATA : "gp_target",
		YES : 'Y',
		masterData : null,
		init : function() {

			gpTarget.initTab();
			gpTarget.initValue();
			gpTarget.initGrid();
			gpTarget.bindEvent();
		},

		initValue : function() {
			$("#year").val(new Date().getFullYear());
			gpTarget.observeMasterData();
		},

		initTab : function() {
			$("#tabs").tabs({
				active : 8,
				activate : function(event, ui) {
					Yuga.redirect(url[ui.newPanel.selector]);
				}
			});
		},

		initGrid : function() {

			var formatter = function(cellvalue, options, rowObject) {
				return Yuga.commaSeparateNumber(cellvalue);
			};
			var unformat = function(cellvalue, options, rowObject) {
				return Yuga.removeComma(cellvalue);
			};

			var options = {
				url : "<c:url value='/gpTarget/getGrid.json'/>",
				colNames : [ 'OrgID', 'gpTargetID', 'Team', 'GP Target' ],
				colModel : [ {
					name : 'orgID',
					index : 'orgID',
					width : 200,
					hidden : true,
					editable : true,
					editoptions : {
						readonly : 'readonly',
					}
				}, {
					name : 'gpTargetID',
					index : 'gpTargetID',
					width : 200,
					hidden : true,
					editable : true,
					editoptions : {
						readonly : 'readonly',
					}
				}, {
					name : 'orgName',
					index : 'orgName',
					width : 400,
					editable : true,
					editoptions : {
						readonly : 'readonly'
					}
				}, {
					name : 'amountKRW',
					index : 'amountKRW',
					width : 400,
					editable : true,
					align : "right",
					formatter : formatter,
					unformat : unformat,
					editoptions : {
						dataInit : function(element) {
							$(element).autoNumeric({
								aPad : false,
								aSep : ""
							});
						}
					}
				} ],
				autowidth : true,
				rowNum : 999,
				pager : '#paging',				
				postData : {
					year : function() {
						return $("#year").val();
					}
				},
				edit : {
					mtype : "POST",
					url : "<c:url value='/gpTarget/saveRow'/>",
					closeAfterEdit : true,
					editCaption : "Edit Records",		
				    onclickSubmit : function(options, postData) {										
						return {
							year : $("#year").val(),
							data : gpTarget.DATA,					
						};
					},
					bSubmit : "Submit",
					bCancel : "Cancel",
					bClose : "Close",
					saveData : "Data has been changed! Save changes?",
					bYes : "Yes",
					bNo : "No",
					bExit : "Cancel",					
				},
				beforeSelectRow : function(rowid, e) {
					if (gpTarget.masterData.editable === gpTarget.YES) {
						return true;
					}
					return false;
				},
				loadComplete : function() {
					gpTarget.observeMasterData();
				}			
			};
			
			gpTarget.grid.jqGrid(options).jqGrid('navGrid', "#paging", {
				edit : true,
				add : false,
				del : false,
				search : false,
				refresh : true
			}, options.edit,{ reloadAfterSubmit:true } );
		},

		bindEvent : function() {

			$("#year").on("change", gpTarget.onChangeYear);

			$("#submitData")
					.on(
							"click",
							function() {
								Yuga.dialog
										.confirm(
												"Warning! when you click submit this masterdata <br /> You will not be able edit it in next time.",
												gpTarget.submitMasterData);
							});
		},

		getMasterData : function() {
			var year = $("#year").val();
			var url = "<c:url value='/masterData' />/" + year + "/"
					+ gpTarget.DATA + "/get";
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
				data : gpTarget.DATA
			};
			$.ajax({
				url : url,
				dataType : "json",
				method : "post",
				data : JSON.stringify(data),
				contentType : "application/json",
				success : function(response) {
					if (response) {
						gpTarget.observeMasterData();
						gpTarget.grid.trigger("reloadGrid");
					}
				}
			});
		},

		onChangeYear : function() {
			gpTarget.initGrid();
			gpTarget.observeMasterData();
			gpTarget.grid.trigger("reloadGrid");
		},
		
		observeMasterData : function() {
			gpTarget.masterData = gpTarget.getMasterData();
			if (gpTarget.masterData.editable == gpTarget.YES) {
				$("#submitData").show();
				$('#edit_list').show();
			} else {
				$("#submitData").hide();
				$('#edit_list').hide();
			}
		}
	};

	$(document).ready(function() {
		gpTarget.init();
		/* 
		$('div .gpTargetpanel').css({
			marginLeft : 200
		});
		 */

	});
</script>
