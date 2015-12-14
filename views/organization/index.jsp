<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>


<div id="tabsOrg">
	<div class="tree">
		<div class="validDate">
			<label for="lastUpdated">Last Update</label>
			<input type="text" readonly="readonly" class="text" id="lastUpdated" />
		</div>
		<div class="validDate">
			<label for="year">Year</label>
			<select class="select" id="year">
				<tiles:insertTemplate template="/WEB-INF/views/elements/masterData/yearSelect.jsp" />
			</select>
		</div>
		
		<div class="buttons">
			<input type="text" id="search" class="text search" placeholder="Enter something to search ..." />
			<button class="btn white" id="btnRoot" type="button">Add Root</button>
			<button class="btn white" id="btnChild" type="button">Add Child</button>
			<button class="btn white" id="btnUpdate" type="button">Edit</button>
			<button class="btn white" id="btnDelete" type="button">Delete</button>
		</div>
		<div id="orgTree"></div>
		<div class="btn-group">
			<button type="button" id="submitData" class="btn btn-primary">Submit</button>
		</div>
	</div>
</div>

<div id="orgDialog">
	<form method="post" id="orgForm">
		<table class="dialog-form">
			<colgroup>
				<col />
				<col />
				<col />
				<col />
			</colgroup>
			<tr>
				<th><label for="orgName">Name</label></th>
				<td><input type="text" class="text" id="orgName" name="orgName" /></td>
				<th><label for="orgAlias">Alias Name</label></th>
				<td><input type="text" class="text" id="orgAlias" name="orgAlias" /></td>
			</tr>
			<tr>
				<th><label for="chkAddProfit">Profit Center</label></th>
				<td><input type="checkbox" id="chkAddProfit" name="chkAddProfit" /></td>
			</tr>
			<tr>
				<th><label for="comment">Comment</label></th>
				<td colspan="3"><textarea class="area" id="comment" name="comment"></textarea></td>
			</tr>
		</table>
		<input type="hidden" id="parentOrgID" name="parentOrgID" />
		<input type="hidden" id="orgID" name="orgID" />
		<input type="hidden" id="profitCenter" name="profitCenter" value="N" />
	</form>
</div>

<div id="officeDialog" class="hide">
	<form method="post" id="officeForm">
		<table class="dialog-form">
			<colgroup>
				<col />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th><label for="office">Office</label></th>
					<td>
						<select id="office" class="select">
							<c:forEach var="office" items="${offices}">
								<option value="${office}">${office}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<script type="text/javascript">
	
		var $orgDialog 		= $("#orgDialog");
		var $officeDialog 	= $("#officeDialog");
		var org = {
			treeSelector : "#orgTree",
			type : "org",
			dialogForm : "#orgForm",
			searchTyping : null,
			DATA : "organization", 
			YES : 'Y',
			masterData : null,

			init : function(){
				org.initTab();
				org.initData();
				org.initTree();
				org.initDate();
				org.bindEvent();
			},
			
			bindEvent : function(){
				
				$("#btnRoot").on("click", org.addRoot);
				$("#btnChild").on("click", function(){

					var selectedNodes = $.jstree.reference(org.treeSelector).get_selected();
					if(selectedNodes.length == 0){
						return;
					}
					var parent = $.jstree.reference(org.treeSelector).get_node(selectedNodes[0]);
					parent.parentOrgID = parent.id;
					org.addChild(parent);
					
				});
				$("#btnUpdate").on("click", org.update);
				$("#btnDelete").on("click", org.remove);
				$("#search").on("keyup", org.search);
				$("#year").on("change", org.changeYear);
				$("#submitData").on("click", org.submitMasterData);
			},
			
			initTab : function(){
				$("#tabs").tabs({
					 active: 0,
					 activate : function(event, ui){
						 Yuga.redirect(url[ui.newPanel.selector]);
					 }
				});
			},
			
			initData : function(){
				$("#year").val(new Date().getFullYear());
				org.masterData = org.getMasterData();
			},
			
			initTree : function(){

				$(org.treeSelector).jstree({
					core : {
					    animation : 0,
					    check_callback : true,
					    multiple: false,
					    themes : { stripes : true },
					    data : {
					      	url : function(){
					      		return '<c:url value="/organization" />/' + $("#year").val() + '/getOrgTree';	
					      	}
						}
					},
					plugins : [
					  	"contextmenu", "search", "state", "types", "wholerow", "dnd"
					],
					contextmenu : {
					 	items : org.contextmenu
					},
					dnd : {
						copy : false
					}
				})
				.on('move_node.jstree', function(obj, par){
					
					var data = "orgID=" + par.node.id + "&parentOrgID=" + par.parent;
					var url = "<c:url value='/organization/updateParent' />";
					
					$.ajax({
						url : url,
						method : "post",
						data : data,
						dataType  : "json",
						success : function(obj){
							$.jstree.reference(org.treeSelector).open_node("#" + par.parent);
						}
					});
				})
				.on("refresh.jstree", function(){
					org.observeMasterData();
				})
				.on("loaded.jstree", function(){
					org.observeMasterData();
				})
				.on("rename_node.jstree", function(){
					org.observeMasterData();
				})
				.on("delete_node.jstree", function(){
					org.observeMasterData();
				})
				.on("move_node.jstree", function(){
					org.observeMasterData();
				})
				.on("create_node.jstree", function(){
					org.observeMasterData();
				});
			},
			
			contextmenu :  function(){
				if(org.masterData == null || org.masterData.editable != org.YES){
					return null;
				}				
				var contextmenu = {
					"Add Organization" : {
						"label"				: "Add Organization",
						"action"			: function(){
							$("#btnChild").click();
						}
					},
					"Update" : {
						"label"				: "Update Organization",
						"action"			: function(data){
							$("#btnUpdate").click();				
						}
					},
					"Office" : {
						"label"				: "Setup Office",
						"action"			: org.setUpOffice
					},
					"Delete" : {
						"label"				: "Delete Organization",
						"action"			: function(data){
							$("#btnDelete").click();
						}
					}
				};
				return contextmenu;
			},
			
			addRoot : function(){
				org.addChild(null);
			},
			
			addChild : function(parent){
				var title = "Add Organization";
				var opt = $.extend({
					title : title,
					success : function(){
						$(org.dialogForm).submit();
					}
				}, parent);
				org.dialog(opt, function(dialog){
					var previousValidate = $(org.dialogForm).validate();
					$.extend(previousValidate.settings, {
							rules : {
								orgName : {
									required : true
								}
							},
							submitHandler: function(){
								if($("#chkAddProfit").is(":checked")){
									$("#profitCenter").val("Y");
								}else{
									$("#profitCenter").val("N");
								}
								
								var url = "<c:url value='/organization/add' />";
								var data = $(org.dialogForm).serialize();
									data += "&year=" + $("#year").val();							
								$.ajax({
									url : url,
									method : "post",
									data : data,
									dataType  : "json",
									success : function(obj){
										
										var newNode = {
											id : obj.orgID,
											text : obj.orgName,
											type : org.type,
											children : false	
										};
										var tree = $.jstree.reference(org.treeSelector);
										tree.create_node("#" + obj.parentOrgID, newNode, "last", false, true);
										tree.open_node("#" + obj.parentOrgID);
										$orgDialog.dialog("close");
									}
								});
							}
					});
				});
			},
			
			update : function(){
				var tree = $.jstree.reference(org.treeSelector);
				var selectedNodes = tree.get_selected();
				if(selectedNodes.length == 0){
					return;
				}
				var node = tree.get_node(selectedNodes[0]);
				var url = "<c:url value='/organization/getByID' />/"+ node.id;
											
				$.ajax({
					url : url,
					method : "post",
					dataType  : "json",
					success : function(obj){
						var title = "Edit Organization [" + obj.orgName + "]";
						var opt = $.extend({
							title : title,
							success : function(){
								$(org.dialogForm).submit();
							}
						}, obj);
						org.dialog(opt, function(dialog){
							
							var previousValidate = $(org.dialogForm).validate();
							
							$.extend(true, previousValidate.settings, {	
								rules : {
									orgName : {
										required : true
									}
								},
								submitHandler: function(){

									if($("#chkAddProfit").is(":checked")){
										$("#profitCenter").val("Y");
									}else{
										$("#profitCenter").val("N");
									}
									
									var url = "<c:url value='/organization/update' />";
									var data = $(org.dialogForm).serialize();
									data += "&year=" + $("#year").val();							
									$.ajax({
										url : url,
										method : "post",
										data : data,
										dataType  : "json",
										success : function(obj){
											
											var tree = $.jstree.reference(org.treeSelector);											
											tree.rename_node(obj.orgID, obj.orgName);
											$orgDialog.dialog("close");
										}
									});
								}
							});
						});
					}
				});
			},
			
			remove : function(){

				var tree = $.jstree.reference(org.treeSelector);
				var selectedNodes = tree.get_selected();
				
				if(selectedNodes.length == 0){
					return;
				}
				
				var node = tree.get_node(selectedNodes[0]);
				var message = "Do you want to delete [" +node.text+ "]";
				
				Yuga.dialog.confirm(message, function(){
					var url = "<c:url value='/organization/delete'/>/" + node.id;
					$.ajax({
						url : url,
						success : function(result){
							
							if(result == "true"){
								tree.delete_node(node.id);
							}
						}
					});
				});
			},
			
			search : function(){
				if(org.searchTyping){ 
					clearTimeout(org.searchTyping); 
				}
				org.searchTyping = setTimeout(function () {
			        $.jstree.reference(org.treeSelector).search($('#search').val());
			    }, 250);
			},
			
			dialog : function(organization, callback){
				
				$orgDialog.find("input, textarea").val("");
				$orgDialog.dialog({
					
					title : organization.title,
					width: 700,
					modal : true,
					open : function(){
						
						for(var key in organization) {
							if(key == "profitCenter"){
								if(organization[key] == "Y"){
									$("#chkAddProfit").prop("checked", true);
								}else{
									$("#chkAddProfit").prop("checked", false);
								}
							}else{
						    	$('#' + key).val(organization[key]);
							}
						}
						
						callback.call(this);
					},
					buttons : {
						"Save" : function(){
							organization.success.call(this);
						},
						"Cancel" : function(){
							$orgDialog.dialog("close");
						}
					}
				});
				
			},
			
			setUpOffice : function(data){

				var tree = $.jstree.reference(org.treeSelector);
				var selectedNodes = tree.get_selected();
				var node = tree.get_node(selectedNodes[0]);
				var url = "<c:url value='/organization/getByID' />/"+ node.id;
				
				$.ajax({
					url : url,
					method : "post",
					dataType  : "json",
					success : function(organization){
						$officeDialog.dialog({
							title : organization.orgName,
							width: 700,
							modal : true,
							open : function(){
								$("#office").val(organization.office);
							},
							buttons : {
								"Save" : function(){
									var data = "orgID=" + organization.orgID + "&office="+ $("#office").val();
									$.ajax({
										url : "<c:url value='/organization/updateOffice' />",
										data : data,
										success : function(){
											$officeDialog.dialog("close");
										}
									});
								},
								"Cancel" : function(){
									$officeDialog.dialog("close");
								}
							}
						});
					}
				});
			},
			
			changeYear : function(){
				$.jstree.reference(org.treeSelector).refresh();
			},
			
			initDate : function(){
				
				var $validDate = $("#validDate"); 
				
				$validDate.datepicker("setDate", new Date("${validDate}"));
				$validDate.datepicker("option", "onSelect", function(dateText, inst){
					
					var url = "<c:url value='/organization/updateValidDate' />";
					var data = "validDate="+$(this).datepicker("getDate").toString(Yuga.getFormatDate());
					
					$.ajax({
						url : url,
						method : "POST",
						data : data,
						success : function(response){
							$("#lastUpdated").val((new Date()).toString("yyyy-mm-dd"));
						}
					});
				});
			},
			
			getMasterData : function(){
				var year  = $("#year").val();
				var url = "<c:url value='/masterData' />/" + year + "/" + org.DATA + "/get";
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
			
			submitMasterData : function(){
				
				var message = "Warning! when you click submit this masterdata <br /> You will not be able edit it in next time.";
			
				Yuga.dialog.confirm(message, function(){
					var url = "<c:url value='/masterData/submit' />";
					var data = {
						year : $("#year").val(),
						data : org.DATA
					};
					$.ajax({
						url : url,
						dataType : "json",
						method : "post",
						data : JSON.stringify(data), 
						contentType : "application/json",
						success : function(response){
							if(response){
								$.jstree.reference(org.treeSelector).refresh();
							}
						}
					});
				});
				
				
				/* var url = "<c:url value='/masterData/submit' />";
				var data = {
					year : $("#year").val(),
					data : org.DATA
				};
				$.ajax({
					url : url,
					dataType : "json",
					method : "post",
					data : JSON.stringify(data), 
					contentType : "application/json",
					success : function(response){
						if(response){
							$.jstree.reference(org.treeSelector).refresh();
						}
					}
				}); */
			},
			
			observeMasterData : function(){
				org.masterData = org.getMasterData();
				var $buttons = $('#submitData')
										.add("#btnRoot")
										.add("#btnChild")
										.add("#btnUpdate")
										.add("#btnDelete");
				if(org.masterData != null){	
					$("#lastUpdated").val(org.masterData.lastUpdated);
				}
				if(org.masterData != null && org.masterData.editable == org.YES){
					$buttons.show();
				}else{
					$buttons.hide();
				}
				$.jstree.reference(org.treeSelector).open_all();
			}
		};
		
	$(document).ready(function(){
		org.init();
	});
</script>
