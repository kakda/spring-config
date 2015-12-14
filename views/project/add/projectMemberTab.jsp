<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="tabsProMember" class="form-container project-member">
		<div class="orgTree">
			<fieldset>
				<legend>Organization Tree</legend>
				<input type="text" id="search" class="text search" placeholder="Enter something to search ..."/>
				<div class="orgMember" id="orgMember"></div>
			</fieldset>
		</div>
		
		<div class="member">
			<h4>
				Member
				<button type="button" class="btnTBN btn white">TBN</button>
				<button type="button" class="btnOUS btn white">OutSourcing</button>
				<button type="button" class="btnGroup btn white">Create Group</button>
			</h4>
			<form id="frmValidation">
				<table class="table" id="table">
					<colgroup>
						<col width="30%" />
						<col width="30%" />
						<col width="12%" />
						<col width="15%" />
						<col width="13%"/>
					</colgroup>
					<thead>
						<tr class="drop">
							<td class="dropHere" colspan="5">
								Drop Here
							</td>
						</tr>
						<tr>
							<td>Name</td>
							<td>Team</td>
							<td>Level</td>
							<td>Planned MM</td>
							<td>Action</td>
						</tr>
					</thead>
					
					<tbody>
						<tr>
							<td colspan='5'>
								<div class="scrollProjectTBN">
								<table class="tr-hidden">
									<thead>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td class="center"></td>
											<td class="center"></td>
										</tr>
									</thead> 
									<colgroup>
										<col width="30%" />
										<col width="30%" />
										<col width="12%" />
										<col width="15%" />
										<col width="13%"/>
									</colgroup>
									<tbody class="mmlist"></tbody>
								</table>
								</div>
							</td>
						</tr>
					</tbody>
					
					<tfoot>
						<tr>
							<td></td>
							<td colspan="2">Total MM:</td>
							<td colspan="3" id="totalMM">0</td>
						</tr>
					</tfoot>
				</table>
			</form>
			
		</div>
		
</div>



<script type="text/javascript">
	$(document).ready(function(){

		$("#tabs").tabs({
			 active: 1,
			 beforeActivate : function(event, ui){
				
				var isValid = memberTab.validate(); 
				if( isValid ){
					memberTab.save();
					Yuga.redirect(url[ui.newPanel.selector]);
				}else{
					Yuga.dialog.alert("Please Check the data of project member");					
				}
				return isValid;
			
			 }
		});
		
		memberTab.init();
	});

	var memberTab = {
		employeeLevelHtml: null,
		save : function(){
			var members = new Array();
			var data = $( ".mmlist").children( "tr" );
			$.each( data, function( index, element ){
				var member = "";
				if(!$(element).hasClass('tabledata')){
					var $trGroup = $(element).find('tr.tabledata');
					var groupMembers =[];
					$.each($trGroup , function(i, data){
						groupMember ={
								orgID: $( data ).attr( "orgID" ),
								org: $( data ).attr( "org" ),
								employeeID: $( data).attr( "employeeID" ),
								name: $( data ).attr( "empName" ),
								empLevel: $( data ).attr( "empLevel" ) ,
								position: $( data ).attr( "position" ),
								empLevelID: $( data ).attr( "empLevelID" ),
								type: memberTab.defineType($( data).attr( "employeeID" ), ($( data ).attr( "orgID" ) == undefined ? 'OUT' : 'group') )
						}
						groupMembers.push(groupMember);
					});
					var group = {
							groupName :$(element).find('.groupName').val() ,
							plannedWorkSize : $(element).find('.planmm').val(),	
							member : groupMembers
					};
					members.push(group);
				}else{
					member = {
						orgID: $( element ).attr( "orgID" ),
						org: $( element ).attr( "org" ),
						employeeID: $( element ).attr( "employeeID" ),
						name: $( element ).attr( "empName" ),
						empLevel: $( element ).attr( "empLevel" ) != undefined ? $( element ).attr( "empLevel" ) : $( ".levelChange option:first" ).text(),
						position: $( element ).attr( "position" ),
						empLevelID: $( element ).attr( "empLevelID" ) != undefined ? $( element ).attr( "empLevelID" ) : $( ".levelChange option:first" ).val(),
						plannedWorkSize: $( element ).find( ".planmm" ).val(),
						type: memberTab.defineType($( element).attr( "employeeID" ), ($( element ).attr( "orgID" ) == undefined ? 'OUT' : 'member'))
					};
					
					data.find(".levelChange").find("option[value='"+member.employeeID+"']").prop("selected", true);
					members.push(member);
				}
			} );

			if( members.length > 0 ){
				$.session.setJSON( session.keys.member_data, members );
			}
		},
		init: function(){
			// init tree view
			var tree = treeUtil.init();
			
			memberTab.initEmployeeLevels();
			memberTab.bindEvent( tree );
			memberTab.viewSessionData();

		},
		initDrag : function(){
			$('.tabledata').draggable({
				 helper: "clone",
			     cursor: "move"
			});
		},
		
		defineType : function(employeeID, type){
			var json = $.session.getJSON(session.keys.general);
			var memberType = "";
			if(employeeID == json.employeeID){
				memberType  = CONSTANT.PROJECT_MEMBER_PM;
			}else if(type == 'group'){
				memberType = CONSTANT.PROJECT_MEMBER_GROUP;
			}else if(type == 'member'){
				memberType = CONSTANT.PROJECT_MEMBER_MEMBER;
			}else {
				if(employeeID.indexOf('TBN') != -1){
					memberType = CONSTANT.PROJECT_MEMBER_TBN;
				}else{
					memberType = CONSTANT.PROJECT_MEMBER_OUTSOURCE
				}
			}
			return memberType;
		},
		
		initDrop : function(){
			$('fieldset.dropHere').droppable({
				accept: ".tabledata",
	            drop: function( event, ui ) {
	            	var dropElement = $(ui.draggable);
	            	dropElement.remove();
	            	memberTab.generateHtml(dropElement, $(this), 'group');
	            }
	        });
			
			$('td.dropHere').droppable({
				accept: ".tabledata",
	            drop: function( event, ui ) {
	            	var dropElement = $(ui.draggable);
	            	dropElement.remove();
	            	memberTab.generateHtml(dropElement, $(this), 'table');
	            }
	        });
		},
		
		generateHtml : function(dropElement,e, type){
			var newHtml = $( "<tr>" );
			newHtml.addClass( "tabledata" );
			newHtml.addClass( "newRow" );
			newHtml.attr( "employeeID", dropElement.attr('employeeID'));
			newHtml.attr( "empName", dropElement.attr('empName') );
			newHtml.attr( "empLevelID", ( dropElement.attr('empLevelID') || "" ).replace(/\s+/g, '') );
			newHtml.attr( "empLevel", dropElement.attr('empLevel') );
			newHtml.attr( "position",  dropElement.attr('position') );
			newHtml.attr( "orgID", dropElement.attr('orgID'));
			newHtml.attr( "org", dropElement.attr('org'));
			
			if(type == 'group'){
				newHtml.append( "<td><button class='minus red'>_</button></td>" );
				newHtml.append( "<td>" + dropElement.attr('empName') + "</td>" );
				newHtml.append( "<td>" + ( dropElement.attr('org') || "" ) + "</td>" );
				newHtml.append( "<td>" + ( dropElement.attr('empLevel') || "" ) + "</td>" );
				e.find('table tbody').append(newHtml);
			}else{
				newHtml.append( "<td>" + dropElement.attr('empName') + "</td>" );
				newHtml.append( "<td>" +( dropElement.attr('org') || "" ) + "</td>" );
				newHtml.append( "<td>" + ( dropElement.attr('empLevel')  || "" ) + "</td>" );
				newHtml.append( "<td><input type='text' value='0' class='text planmm' name='" + dropElement.attr('employeeID') + "'/></td>" );
				newHtml.append( "<th><button class='remove btn red'>X</button></th>" );
				$("#table").find( ".mmlist" ).append( newHtml );
			}
			memberTab.initDrag();
		},
		
		
		caculateTotalMM : function(){
			var arr = $( "#table").find( ".planmm" );
			var totalMM = 0;
			$.each(arr, function(index, value){
				if( $(value).val() >= 0 ) {
					totalMM += new Number( $(value).val());
				}
			});
			$("#totalMM").text(parseFloat(Math.round(totalMM * 100) / 100).toFixed(2));
		},
		
		initEmployeeLevels: function(){
			
			var url = '<c:url value="/employeeLevel/levels"/>';
			
			$.ajax({
	            url: url,
	            type: "GET",
	            async: false,
	            success: function(employeeLevels) {
					var select = $("<select>");
					select.addClass("levelChange");
					$.each(employeeLevels, function(key, value) {
						select.append(new Option(value.title, value.empLevelID.replace(/\s+/g, '')));
					});	            	
					memberTab.employeeLevelHtml = select.prop("outerHTML");
	            }
	        });
		},
		
		bindEvent: function( tree ){
			$('.mmlist').on('click','.remove, .minus',function(){
				var nodeData ="";
				if($(this).hasClass('groupRM')){
					var $groupTable = $(this).parents().next().find('table.tbl01');
					var $groupTableTR = $groupTable.find('tr.tabledata');
					$groupTableTR.each(function(){
						nodeData = {
								"id" : $(this).attr('employeeID'),
								"text" : $(this).find("td:first").text(),
								"type" : "emp",
								"children" : false
						};
						$(this).remove();
						treeUtil.restoreNode(tree, nodeData.id);
					});
					$(this).closest('tr').remove();
				}else{
					var parent = $(this).closest('tr');
					var parentId = parent.attr('orgID');
					nodeData = {
							"id" : parent.attr('employeeID'),
							"text" : parent.find("td:first").text(),
							"type" : "emp",
							"children" : false
					};
					//tree.create_node(parentId,nodeData);
	
					var newProjectMemberId = parent.attr('projectmemberid'); 
					var removedMembers = treeUtil.removedMembers; 
					
					// Check if projectMemberId has value
					if(newProjectMemberId !== undefined){
						for(var removedMember in removedMembers){
							if(newProjectMemberId === removedMembers[removedMember].projectmemberid){
								parent.replaceWith(removedMembers[removedMember].tr);
								removedMembers.splice(removedMember, 1);
							}
						}
					} else {
						parent.remove();
					}
					treeUtil.restoreNode(tree, nodeData.id);
				}
				

				var count = 0;
				$("#table tr span[name='TBN']").each(function(){
					$(this).text(++count);
					$(this).parent().parent().attr("employeeID", "TBN" + count);
					$(this).parent().parent().attr("empName", "TBN" + count);
				});
				var count = 0;
				$("#table tr span[name='OUS']").each(function(){
					$(this).text(++count);
					$(this).parent().parent().attr("employeeID", "Outsourcing" + count);
					$(this).parent().parent().attr("empName", "Outsourcing" + count);
				});
				
				
				memberTab.caculateTotalMM();
				
				return;
			});
			
			$('.btnTBN').click(function(){
				var nextValue =$("#table span[name='TBN']:last").text().toNumber() + 1;
				var tbnId = "TBN" + nextValue;
				var newHtml = $( "<tr>" );
				newHtml.addClass( "drop" );
				newHtml.addClass( "tabledata" );
				newHtml.attr( "empName", tbnId );
				newHtml.attr( "employeeID", tbnId );			
				newHtml.append( "<td>TBN <span name='TBN'>"+ nextValue + "</span></td>" +
						"<td></td>" +
						"<td>" + memberTab.employeeLevelHtml + "</td>" +
						"<td><input type='text' value = '0' class='text planmm' name='" + tbnId + "'/></td>" +
						"<th><button type='button' class='remove btn red'>X</button></th>" );
				
				$("#table").find( ".mmlist" ).append( newHtml );
				memberTab.initDrag();
						
			});
			$('.btnOUS').click(function(){
				var nextValue =$("#table span[name='OUS']:last").text().toNumber() + 1;
				var tbnId = "OutSourcing" + nextValue;
				var newHtml = $( "<tr>" );
				newHtml.addClass( "drop" );
				newHtml.addClass( "tabledata" );
				newHtml.attr( "empName", tbnId );
				newHtml.attr( "employeeID", tbnId );			
				newHtml.append( "<td>Outsourcing <span name='OUS'>"+ nextValue + "</span></td>" +
						"<td></td>" +
						"<td>" + memberTab.employeeLevelHtml + "</td>" +
						"<td><input type='text' value = '0' class='text planmm' name='" + tbnId + "'/></td>" +
						"<th><button type='button' class='remove btn red'>X</button></th>" );
				
				$("#table").find( ".mmlist" ).append( newHtml );
				memberTab.initDrag();
						
			});
			
			$('.btnGroup').click(function(){
				var newHtml = "<tr>";
				newHtml += "<td colspan='3'>";
				newHtml += "<fieldset class='dropHere'><legend><input type='text' name='groupName' class='groupName'/></legend><div class='scroll'><table class='table tbl01'><tbody></tbody></table></div></fieldset>";
				newHtml += "</td>";					
				newHtml += "<td><input type='text' class='text planmm' value='0'></td>";
				newHtml += "<th><button class='btnRemove btn red'>X</button></th>";
				newHtml += "</tr>";			
				$('.mmlist').append(newHtml);				
				
/* 				var groupMemberHtml = "<tr><td colspan='5'><div class='inpMember'><input type='text' value='0' class='text planmm' /><button type='button' class='groupRM remove btn red'>X</button></div>";
				var fieldsetTable = "<fieldset class='dropHere'><legend><input type='text' name='groupName' class='groupName'/></legend><div class='scroll'><table class='table tbl01'><tbody></tbody></table></div></fieldset></td></tr>";
				$('.mmlist').append(groupMemberHtml + fieldsetTable); */
				memberTab.initDrop();
			});
			
			$( "#table" ).on( "keyup" , ".planmm", function(){
				$( this ).attr( "value", $( this ).val() );
				
				// remove relative session data
				var employeeID = $( this ).closest('tr').attr( "employeeID");
				if( employeeID != null && employeeID != "" ){
					memberTab.removeResourcePlanSessionByEmployeeId(employeeID);
				}
				
				memberTab.caculateTotalMM();
				
			});
			
			
			$( "#table" ).delegate( ".levelChange" , "change", function(){
				$( this ).closest("tr").attr( "empLevelID", $( this ).find('option:selected').val());
				$( this ).closest("tr").attr( "empLevel", $( this ).find('option:selected').text());
				
			});
		
		},
		
		viewSessionData: function(){
			if($.session.get( session.keys.member_data ) != undefined){
			var session_json = JSON.parse($.session.get( session.keys.member_data ));
			console.log(session_json);
				$('.mmlist').html("");
				$.each(session_json, function(index, emp){
					if(emp.groupName != undefined){
						var groupMemberHtml = $("<tr>"
								+ "<td colspan='3'>"
								+ "<fieldset class='dropHere'><legend><input type='text' name='groupName' value='"+emp.groupName+"' class='groupName'/></legend><div class='scroll'><table class='table tbl01'><tbody></tbody></table></div></fieldset>"
								+ "</td>"				
								+ "<td><input type='text' class='text planmm' value='"+ emp.plannedWorkSize +"'></td>"
								+ "<th><button class='groupRM remove btn red'>X</button></th>");						
						//var groupMemberHtml = $("<tr><td colspan='5'><div class='inpMember'><input type='text' value='"+emp.plannedWorkSize+"' class='text planmm' /><button type='button' class='groupRM remove btn red'>X</button></div><fieldset class='dropHere'><legend><input type='text' name='groupName' value='"+emp.groupName+"'class='groupName'/></legend><div class='scroll'><table class='table tbl01'><tbody>");
						$('.mmlist').append(groupMemberHtml);
						$.each(emp.member,function(index, groupemp){
							var newHtml = $( "<tr>" );
							newHtml.addClass( "tabledata" );
							newHtml.addClass( "newRow" );
							newHtml.attr( "employeeID", groupemp.employeeID );
							newHtml.attr( "empName", groupemp.name );
							newHtml.attr( "empLevelID", groupemp.empLevelID );
							newHtml.attr( "empLevel", groupemp.empLevel );
							newHtml.attr( "position",  groupemp.position );
							newHtml.attr( "orgID", groupemp.orgID);
							newHtml.attr( "org", (groupemp.org != undefined ? groupemp.org : ""));
							newHtml.append( "<td><button class='minus red'>_</button></td>" );
							newHtml.append( "<td>" + groupemp.name + "</td>" );
							newHtml.append( "<td>" + (groupemp.org != undefined ? groupemp.org : "") + "</td>" );
							newHtml.append( "<td>" + ( groupemp.empLevel || "" ) + "</td>" );
							groupMemberHtml.find('table.tbl01 tbody').append(newHtml);
						});
					}else{
						var newHtml = $( "<tr>" );
						newHtml.addClass( "tabledata" );
						newHtml.addClass( "newRow" );
						newHtml.attr( "employeeID", emp.employeeID );
						newHtml.attr( "empName", emp.name );
						newHtml.attr( "empLevelID", emp.empLevelID );
						newHtml.attr( "empLevel", emp.empLevel );
						newHtml.attr( "position",  emp.position );
						newHtml.attr( "orgID", emp.orgID);
						newHtml.attr( "org", (emp.org != undefined ? emp.org : ""));
						var lengthName = emp.name.length;
						newHtml.append( "<td>" + (emp.org != undefined ?  emp.name : emp.name.substring(0,lengthName-1) + "<span>"+emp.name.substring(lengthName-1 ,lengthName)+"</span>")+ "</td>" );
						newHtml.append( "<td>" + (emp.org == undefined ? "" : emp.org) + "</td>" );
						newHtml.append( "<td>" + (emp.org == undefined ? memberTab.employeeLevelHtml: emp.empLevel) + "</td>" );
						newHtml.append( "<td><input type='text' class='text planmm' value='"+emp.plannedWorkSize+"' name='" + emp.employeeID + "'/></td>" );
						newHtml.append( "<th><button class='remove btn red'>X</button></th>" );
						newHtml.find(".levelChange").find("option[value='"+emp.empLevelID+"']").prop("selected", true);
						$('.mmlist').append(newHtml);	
					}
				});
				memberTab.initDrag();
				memberTab.initDrop();
				memberTab.caculateTotalMM();
			}
		},
		
		removeResourcePlanSessionByEmployeeId: function( employeeID ){
			var resources = $.session.getJSON( session.keys.resource );
			if( resources != null ){
				resources[ employeeID ] = null;
				$.session.setJSON( session.keys.resource, resources );
			}
		},
		
		validate: function(){
			
			$( '#frmValidation' ).removeData('validator');
			
	        var arr = $( ".planmm" );
	        if(arr.length == 0){
	        	return false;
	        }else{
		        var rule = {
		        	groupName :	{
		        		required : true
		        	}	
		        };
		        $.each(arr, function(index, value){
					rule[ $( value ).attr( "name" ) ] = {
							required : true
					};
		        });
		        
	
		        var validator = $("#frmValidation").validate({
					ignore: '',
					rules: rule
				});
		        return validator.form() || false;
	        }
		}
		
	};
	
	
	
	var treeUtil = {
		init: function(){
			var json = $.session.getJSON(session.keys.general);
			var year = new Date(json.startDate).getFullYear();
			$('#orgMember').jstree({
				core : {
				    animation : 0,
				    check_callback : function (operation, node, node_parent, node_position) {
		 				return operation == 'delete_node' || operation == 'create_node'? true : false;
		 			},
				    multiple: true,
				    themes : { stripes : true },
				    data : {
				    	url : function(){
				      		return '<c:url value="/organization" />/' + year + '/getOrgTreeEmployee';	
				      	}
					}
				},
				plugins : [ "search", "state", "types", "wholerow", "dnd"],
				dnd : {
					copy : true
				},
				types :{
					"#" : {
						"valid_children" : ["default"]
					},
					"org" :{
						"valid_children" : ["default", "emp", "org"]
					},
					"emp" :{
						"icon" : "jstree-default jstree-file",
						"valid_children" : ["default"]
					},
				}
			});
			
			var tree =  $.jstree.reference( $('#orgMember') );
			treeUtil.bindEvent( tree );
			return tree;
		},
		
		bindEvent: function( tree ){
			
			$('#orgMember').bind("loaded.jstree", function(e, data){
				treeUtil.removeSelectedMembers(tree);
			});
			$(document)
			.bind("dnd_move.vakata",function(e,data){
				var targetElement = data.event.target;
				var nodeDetail = tree.get_node(data.data.nodes[0]);
				if(targetElement.textContent == "Drop Here" || $( targetElement).parent().hasClass( "drop" ) || $(targetElement).hasClass( "dropHere" ) ){
					data.helper.find('.jstree-icon').removeClass('jstree-er').addClass('jstree-ok');
				}else{
					data.helper.find('.jstree-icon').removeClass('jstree-ok').addClass('jstree-er');
				}
			})
			.bind('dnd_stop.vakata', function (e, data) {
				var targetElement = data.event.target;

 				for(var i = 0; i < data.data.nodes.length; i++){
					var nodeId = data.data.nodes[i];
					var nodeDetail = tree.get_node(nodeId);
					treeUtil.getChildNodes(nodeDetail, tree, targetElement);
					tree.delete_node(treeUtil.removedNodes);
				} //end of loop
				
			}); // end of bind function
			
			
			$("#search").on("keyup", function(){
				$.jstree.reference($('#orgMember')).search($('#search').val());
			});
		},
		
		/* temporary of projectMembers was deleted. */
		removedMembers: [],
		removedNodes: [],
		
		/* Loop thought treeList and return child nodes as array */
		getChildNodes : function(nodeDetail, tree, targetElement){
			if(nodeDetail.children.length === 0){
				if(nodeDetail.type === 'emp'){
					var isAppend = treeUtil.appendRow(nodeDetail, tree, targetElement);
					if(isAppend){
						treeUtil.removedNodes.push(nodeDetail);
					}
				}
			}else{
 				for(var i = 0; i < nodeDetail.children.length; i++){
 					var childNodeDetails = tree.get_node(nodeDetail.children[i]);
					treeUtil.getChildNodes(childNodeDetails, tree, targetElement);
				}
			}
		},
		
		/* Append row or rows to class mmlist*/
		appendRow : function(nodeDetail, tree, targetElement){
			var parentNode 	= tree.get_node(nodeDetail.parent);
			var newHtml = $( "<tr>" );
			newHtml.addClass( "tabledata" );
			newHtml.addClass( "newRow" );
			newHtml.attr( "employeeID", nodeDetail.id );
			newHtml.attr( "empName", nodeDetail.original.text );
			newHtml.attr( "empLevelID", ( nodeDetail.original.empLevelID || "" ).replace(/\s+/g, '') );
			newHtml.attr( "empLevel", nodeDetail.original.empLevel );
			newHtml.attr( "position",  nodeDetail.original.position );
			newHtml.attr( "orgID", parentNode.id);
			newHtml.attr( "org", parentNode.text);
			
			
			var isExist = $("#table").find( "tr[employeeid=" + nodeDetail.id + "]" )[0] !== undefined;
			if( !isExist ){
				
				if($(targetElement).hasClass( "dropHere" )  && $(targetElement).find('table').hasClass('tbl01')){
						newHtml.append( "<td><button class='minus red'>_</button></td>" );
						newHtml.append( "<td>" + nodeDetail.original.text + "</td>" );
						newHtml.append( "<td>" + parentNode.text + "</td>" );
						newHtml.append( "<td>" + ( nodeDetail.original.empLevel || "" ) + "</td>" );
				}else{
						newHtml.append( "<td>" + nodeDetail.original.text + "</td>" );
						newHtml.append( "<td>" + parentNode.text + "</td>" );
						newHtml.append( "<td>" + ( nodeDetail.original.empLevel || "" ) + "</td>" );
						newHtml.append( "<td><input type='text' value='0' class='text planmm' name='" + nodeDetail.id + "'/></td>" );
						newHtml.append( "<th><button class='remove btn red'>X</button></th>" );
				}
				if( $(targetElement).hasClass( "dropHere" )){
					if($(targetElement).find('table').hasClass('tbl01')){
						$(targetElement).find('table tbody').append(newHtml);
					}else{
						$("#table").find( ".mmlist" ).append( newHtml );
					}
					memberTab.initDrag();
					return true;
				}else if( $( targetElement).parent().hasClass( "drop" ) ){	
					var planMM = $( targetElement).parent().find(".planmm").val();
					var planMMInput = newHtml.find(".planmm").val( planMM );
					
					var projectMemberID = $( targetElement).parent().attr( "projectMemberID" );
					newHtml.attr( "projectMemberID", projectMemberID  );
					
					// Keep old row into object treeUtil.removedMembers before replace with new row.
					treeUtil.removedMembers.push({'projectmemberid' : projectMemberID, 'tr' : $( targetElement ).parent()});
					$( targetElement ).parent().replaceWith( newHtml );
					memberTab.initDrag();
					return true;
				}  
				
			}
			
			return false;
		},
		
		restoreNode: function(tree, employeeID){
			$.each(treeUtil.removedNodes, function(index, value){
				if(value != undefined && value.id == employeeID){
					value = $.extend(value, value.original);
					delete value.original;
					tree.create_node(value.parent, value, "last", false, true);
					treeUtil.removedNodes.splice(index, 1);
				}
				return;
			});
		},
		
		removeSelectedMembers : function(tree){
			var members = $.session.getJSON( session.keys.member_data );
			if(members != null){
				$.each(members, function(index, value){
					if(value != undefined && 
							typeof value === 'object'){
						if(value.member != undefined ){
							$.each(value.member,function(index, empID){
								var node = tree.get_node(empID.employeeID);
								treeUtil.removedNodes.push(node);
							});
						}else{
							var node = tree.get_node(value.employeeID);
							treeUtil.removedNodes.push(node);
						}	
					}
					
				});
				tree.delete_node(treeUtil.removedNodes);
			}
		}
	};
</script>