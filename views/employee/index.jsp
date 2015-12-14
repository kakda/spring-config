<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="format"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>

<div id="tabsEmp">

	<div class="tree">
		<div class="validDate">
			<label for="lastUpdated">Last Update</label> <input type="text"
				readonly="readonly" class="text" id="lastUpdated" />
		</div>
	</div>

	<form method="post" action="<c:url value='/employee/import/' />"
		id="form" enctype="multipart/form-data">
		<div class="buttons">
			<a href="<c:url value='/resources/samples/employee.xlsx' />"
				target="_blank" class="btn white" id="btnDownload">Download
				Sample</a> <a href="#" class="btn white" id="btnImport">Import From
				Excel File</a> <a href="#" class="btn white" id="btnAdd">New
				Employee</a> <input type="file" name="file" class="hide" />
		</div>
	</form>

	<div class="grid tab-grid" style="width: 94%;">
		<table id="list"></table>
		<div id="paging"></div>
	</div>

</div>
<div id="treeDialog" class="hide">
	<div id="orgTree"></div>
</div>
<script type="text/javascript">
	var employee = {

		grid : $("#list"),
		role : {
			roleEmployee : CONSTANT.ROLE_EMPLOYEE,
			rolePM : CONSTANT.ROLE_PM,
			roleSuperUser : CONSTANT.ROLE_SUPER_USER
		},
		elTeamFocus : null,
		formatter : {

			radio : function(cellvalue, options, rowObject) {

				var $radio = $("<input>").attr("type", "radio").attr("name",
						rowObject.employeeID).val(options.colModel.name)
						.addClass("radioRow");

				var isMe = '<security:authentication property="principal" />' == rowObject.employeeID ? true
						: false;

				if (cellvalue) {
					$radio.attr("checked", "checked");
				}
				if (isMe) {
					$radio.attr("disabled", "disabled");
				}

				return $radio.wrap("<div>").parent().html();
			},
			resetPwd : function(cellvalue, options, rowObject) {

				var $button = $("<button>").attr("type", "button").attr(
						"class", "btn btnReset").attr("rel",
						rowObject.employeeID).text("Reset");

				return $button.wrap("<div>").parent().html();
			},
			allowDel : function(cellvalue, options, rowObject) {
				var isMe = '<security:authentication property="principal" />' == rowObject.employeeID ? true
						: false;
				//alert( "testtest:"+rowObject.employeeID+":"+cellvalue);
				if (isMe) {
					return "";
				} else {
					return $("<button>", {
						"type" : "button",
						"class" : "btn red btnRemove",
						"text" : "Delete",
						"rel" : rowObject.employeeID
					}).wrap("<div>").parent().html();
				}

			}
		},
		validator : {
			name : function(value, colName) {
				var valid = [ false, "Name already exist." ];
				var oper = $("#operation").attr("rel");
				var url = "<c:url value='/employee/check/name' />";
				var data = "employeeName=" + value;
				if (oper == "edit") {
					var rowID = employee.grid.jqGrid('getGridParam', 'selrow');
					var employeeID = employee.grid.jqGrid('getCell', rowID,
							'employeeID');
					data += "&employeeID=" + employeeID;
				}
				$.ajax({
					url : url,
					method : "post",
					data : data,
					async : false,
					dataType : "json",
					success : function(response) {
						valid[0] = response;
					}
				});
				return valid;
			},
			email : function(value, colName) {
				var valid = [ false, "Email already exist." ];
				var oper = $("#operation").attr("rel");
				var url = "<c:url value='/employee/check/email' />";
				var data = "email=" + value;
				if (oper == "edit") {
					var rowID = employee.grid.jqGrid('getGridParam', 'selrow');
					var employeeID = employee.grid.jqGrid('getCell', rowID,
							'employeeID');
					data += "&employeeID=" + employeeID;
				}
				$.ajax({
					url : url,
					method : "post",
					data : data,
					async : false,
					dataType : "json",
					success : function(response) {
						valid[0] = response;
					}
				});
				return valid;
			},

			team : function(value, colName) {
				var valid = [ false, "Invalid " + colName + "." ];
				if ($("#team").val().trim() != ""
						|| $("#department").val().trim() != ""
						|| $("#division").val().trim() != "") {
					valid[0] = true;
				}
				return valid;
			}
		},

		init : function() {
			employee.initData();
			employee.initTree();
			employee.bindingEvent();
		},

		initData : function() {
			employee.initGrid();
		},

		initTree : function() {
			var currentYear = new Date().getFullYear();
			$('#orgTree').jstree(
					{
						core : {
							animation : 0,
							check_callback : true,
							multiple : false,
							themes : {
								stripes : true
							},
							data : {
								url : '<c:url value="/organization" />/'
										+ currentYear + '/getOrgTree'
							}
						},
						plugins : [ "contextmenu", "state", "types",
								"wholerow", "dnd" ],
						dnd : {
							copy : false
						}
					});

		},

		editoptions : {
			team : {
				dataInit : function(el) {
					var $del = $("<span>", {
						on : {
							click : function() {
								$(this).prev().val("");
							}
						},
						"class" : "ico error"
					});
					$(el).prop("readonly", true).after($del);
				},
				dataEvents : [ {
					type : "focus",
					fn : function(event) {
						$('#treeDialog').dialog({
							modal : true,
							autoOpen : true,
							maxHeight : 500,
							width : 800,
							close : function() {
								$(this).dialog('destroy');
							}
						});
						employee.elTeamFocus = event.target;
					}
				} ]
			}
		},

		initGrid : function() {
			var options = {
				url : "<c:url value='/employee/getGrid'/>",
				colNames : [ 'ID', 'Name', 'Email', 'Title', 'Level', 'Team',
						'Department', 'Division', 'Employee', 'PM',
						'Super User', 'Role', 'Password', 'Delete' ],
				colModel : [ {
					name : 'employeeID',
					index : 'employeeID',
					align : 'center',
					hidden : true,
					editable : true,
					search : false
				}, {
					name : 'employeeName',
					index : 'employeeName',
					editable : true,
					search : true,
					styp : "text",
					editrules : {
						required : true,
						custom : true,
						custom_func : employee.validator.name
					}
				}, {
					name : 'email',
					index : 'email',
					width : 80,
					hidden : true,
					editable : true,
					editrules : {
						edithidden : true,
						required : true,
						email : true,
						custom : true,
						custom_func : employee.validator.email
					}
				}, {
					name : 'title',
					index : 'title',
					width : 80,
					editable : true
				}, {
					name : 'level',
					index : 'level',
					width : 40,
					stype : 'select',
					editoptions : {
						value : "${level}"
					},
					editable : true,
					edittype : 'select',
					addoptions : {
						value : "${level}"
					},
					editrules : {
						required : true
					}
				}, {
					name : 'team',
					index : 'team',
					editable : true,
					editrules : {
						custom : true,
						custom_func : employee.validator.team
					},
					editoptions : employee.editoptions.team
				}, {
					name : 'department',
					index : 'department',
					editable : true,
					editrules : {
						custom : true,
						custom_func : employee.validator.team
					},
					editoptions : employee.editoptions.team
				}, {
					name : 'division',
					index : 'division',
					editable : true,
					editrules : {
						custom : true,
						custom_func : employee.validator.team
					},
					editoptions : employee.editoptions.team
				}, {
					name : 'roleEmployee',
					index : 'roleEmployee',
					search : false,
					width : 60,
					formatter : employee.formatter.radio,
					align : "center"
				}, {
					name : 'rolePM',
					index : 'rolePM',
					search : false,
					width : 50,
					formatter : employee.formatter.radio,
					align : "center"
				}, {
					name : 'roleSuperUser',
					index : 'roleSuperUser',
					search : false,
					width : 70,
					formatter : employee.formatter.radio,
					align : "center"
				}, {
					name : 'role',
					index : 'role',
					width : 80,
					hidden : true,
					editable : true,
					editrules : {
						edithidden : true
					},
					stype : 'select',
					edittype : 'select',
					editoptions : {
						value : "${role}"
					},
					addoptions : {
						value : "${role}"
					}
				}, {
					name : 'reset',
					index : 'reset',
					width : 100,
					align : 'center',
					search : false,
					formatter : employee.formatter.resetPwd
				}, {
					name : 'allowDel',
					index : 'allowDel',
					width : 100,
					align : 'center',
					search : false,
					formatter : employee.formatter.allowDel
				} ],
				pager : '#paging',
				rowNum : 10,
				rownumbers : true,
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
				editurl : "<c:url value='/employee/saveRow'/>",
				loadComplete : function() {

					$(".radioRow")
							.on(
									"change",
									function() {

										var url = "<c:url value='/employee/changeRole' />";
										var data = "";
										data += "employeeID="
												+ $(this).attr("name");
										data += "&role="
												+ employee.role[$(this).attr(
														"value")];

										$.ajax({
											url : url,
											method : "post",
											data : data,
											success : function(response) {
												console.log(response);
											}
										});
									});

					$(".btnReset")
							.on(
									"click",
									function() {

										var employeeID = $(this).attr("rel");
										var url = "<c:url value='/employee/resetPwd' />/"
												+ employeeID;
										var message = "Do you want to reset this employee password.";

										Yuga.dialog
												.confirm(
														message,
														function() {
															$
																	.ajax({
																		url : url,
																		success : function(
																				response) {
																			console
																					.log(response);
																			Yuga.dialog
																					.alert("Employee password has been reset.")
																		}
																	});
														});
									});

					$(".btnRemove")
							.on(
									"click",
									function() {

										var employeeID = $(this).attr("rel");
										var url = "<c:url value='/employee/delete' />/"
												+ employeeID;
										var message = "Do you want to remove this employee ?";

										Yuga.dialog
												.confirm(
														message,
														function() {
															$
																	.ajax({
																		url : url,
																		method : "DELETE",
																		success : function(
																				response) {
																			console
																					.log(response);
																			employee.grid
																					.trigger("reloadGrid");
																			Yuga.dialog
																					.alert("Employee has been delete.")
																		}
																	});
														});
									});
				}
			};

			employee.grid.jqGrid(options).jqGrid('filterToolbar', {
				searchOperators : true
			}).jqGrid('navGrid', "#paging", {
				edit : true,
				add : true,
				del : false,
				search : false,
				refresh : true
			}, {
				modal : true,
				zIndex : 50,
				closeAfterEdit : true,
				beforeShowForm : function(form) {
					$("#operation", form).remove();
					$(form).append($('<div>', {
						rel : "edit",
						id : "operation"
					}));
					$('#tr_role', form).hide();
				}
			}, {
				modal : true,
				zIndex : 50,
				beforeShowForm : function(form) {
					$("#operation", form).remove();
					$(form).append($('<div>', {
						rel : "add",
						id : "operation"
					}));
					$('#tr_role', form).hide();
				}
			});
		},

		bindingEvent : function() {

			$("#tabs").tabs({
				active : 1,
				activate : function(event, ui) {
					Yuga.redirect(url[ui.newPanel.selector]);
				}
			});

			$("#btnImport").on("click", function(event) {
				event.preventDefault();
				$(":file", "#form").click();
			});

			$(":file", "#form").on("change", function() {
				$("#form").submit();
			});

			$('#orgTree').on("dblclick.jstree", function(e) {
				var tree = $.jstree.reference('#orgTree');
				var selectedNodes = tree.get_selected();
				var node = tree.get_node(selectedNodes[0]);
				$(employee.elTeamFocus).val(node.text);
				$('#treeDialog').dialog("destroy");
			});

			$("#btnAdd").on("click", function(e) {
				e.preventDefault();
				employee.grid.jqGrid("editGridRow", "new", {
					modal : true,
					zIndex : 50,
					beforeShowForm : function(form) {
						$("#operation", form).remove();
						$(form).append($('<div>', {
							rel : "add",
							id : "operation"
						}));
						$('#tr_role', form).hide();
					}
				});
			});
		}
	};

	$(document).ready(employee.init);
</script>