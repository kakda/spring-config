<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.inpMember .text {
	width: 50% !important;
}
</style>
<div id="tabsProMember" class="form-container project-member">
		<div class="orgTree">
			<fieldset>
				<legend>Organization Tree</legend>
				<input type="text" id="search" class="text search" placeholder="Enter something to search ..."/>
				<div class="orgMember" id="orgMember"></div>
			</fieldset>
		</div>
		
		<div class="member">
			<h4 >
				Member
				<button type="button" class="btnTBN btn white">TBN</button>
				<button type="button" class="btnOUS btn white">OutSourcing</button>
				<button type="button" class="btnGroup btn white">Create Group</button>
				<a href="<c:url value="/project/update/UP/"/>"><button type="button" class="btn white right">Update Plan</button></a>
			</h4>
			
			<form id="frmValidation">
				<table class="table" id="table">
					<colgroup>
						<col width="30%">
						<col width="25%">
						<col width="12%">
						<col width="12%">
						<col width="12%">
						<col />
					</colgroup>
					<thead>
						<tr class="drop">
							<td class="dropHere" colspan="6">
								Drop Here
							</td>
						</tr>
						<tr>
							<td>Name</td>
							<td>Team</td>
							<td>Level</td>
							<td>Planned MM</td>
							<td class="center">Actual MM</td>
							<td class="center">Action</td>
						</tr>
					</thead>
					
					<tbody>
						<tr>
							<td colspan='6'>
								<div class="scrollProjectTBN">
									<table>
										<colgroup>
											<col width="30%">
											<col width="25%">
											<col width="12%">
											<col width="12%">
											<col width="12%">
											<col />
										</colgroup>
										<tbody class="mmlist"></tbody>
									</table>
								</div>
							</td>
						</tr>
					</tbody>
					
					<tfoot>
						<tr>
							<td colspan="3">Total MM:</td>
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
				 
				Yuga.redirect(url[ui.newPanel.selector]);
				
				return true;
			
			 }
		});
		memberTab.init();
	});
	
	var memberTab = {
			employeeLevelHtml: null,
			members : [],
			removedOldMembers: [],
			memberLoaded : false,
			projectInfo: "",
			init: function(){
				// init tree view
				memberTab.getProjectInfo();
				var tree = treeUtil.init();
					memberTab.viewMembersData();	
					memberTab.initEmployeeLevels();
					memberTab.bindEvent( tree );
			},
			
			initDrag : function(){
				$('.tabledata').draggable({
					 helper: "clone",
				     cursor: "move"
				});
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
			
			initEmployeeLevels: function(){
				
				var url = '<c:url value="/employeeLevel/levels"/>';
				$.get( url, function( employeeLevels ) {
					var select = $("<select>");
					select.addClass("levelChange");
					$.each(employeeLevels, function(key, value) {
						select.append(new Option(value.title, value.empLevelID.replace(/\s+/g, '')));
					});
					
					memberTab.employeeLevelHtml = select.prop("outerHTML");
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
				newHtml.attr( "projectMemberID",  dropElement.attr('projectMemberID') );
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
					newHtml.append( "<td class='actualMM center'> 0.00 </td>" );
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
			
			getProjectInfo : function(){
				var url = '<c:url value="/project/"/>' + page.projectID;
				$.ajax({
					type			: "GET",
					url				: url ,
					async 			: false,
					contentType		: "application/json",
					success: function(json){
						memberTab.projectInfo = json;
					 },
				});			
			},
			
			bindEvent: function( tree ){
				$('.btnPlan').on('click',function(){
					var url='<c:url value="/project/update/UP/"/>';
					return url;
				});
				$('.mmlist').on('click','.btnRemove, .minus',function(){
					var nodeData ="";
					if($(this).hasClass('groupRM')){
						var $groupTable = $(this).parents().find('table.tbl01');
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
					
					var nextValue = memberTab.getAutoTBNId();
					var tbnId = "TBN" + nextValue;
					var newHtml = $( "<tr>" );
					newHtml.addClass( "newRow" );
					newHtml.addClass( "drop" );
					newHtml.addClass( "tabledata" );
					newHtml.attr( "TBN", "TBN" );
					newHtml.attr( "empName", tbnId );
					newHtml.attr( "employeeID", tbnId );
					newHtml.append( "<td>" + tbnId +"</td>" +
							"<td></td>" +
							"<td>" + memberTab.employeeLevelHtml + "</td>" +
							"<td><input type='text' value = '0' class='text planmm' name='" + tbnId + "'/></td>" +
							"<th></th>"+
							"<th><button class='remove btn red'>X</button></th>" );
					
					$("#table").find( ".mmlist" ).append( newHtml );
				});
				
				$('.btnOUS').click(function(){
					var nextValue =$("#table span[name='OUS']:last").text().toNumber() + 1;
					var tbnId = "OutSourcing" + nextValue;
					var newHtml = $( "<tr>" );
					newHtml.addClass( "drop" );
					newHtml.addClass( "tabledata" );
					newHtml.attr( "empName", tbnId );
					newHtml.attr( "employeeID", tbnId );
					newHtml.attr( "outsouring", "outsouring");
					newHtml.append( "<td>Outsourcing <span name='OUS'>"+ nextValue + "</span></td>" +
							"<td></td>" +
							"<td>" + memberTab.employeeLevelHtml + "</td>" +
							"<td><input type='text' value = '0' class='text planmm' name='" + tbnId + "'/></td>" +
							"<td class='actualMM center' > 0.00</td>" +
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
					newHtml += "<td class='actualMM center'>0.00</td>";
					newHtml += "<th><button class='btnRemove btn red'>X</button></th>";
					newHtml += "</tr>"; 
					$('.mmlist').append(newHtml);
					
/*  					var groupMemberHtml = "<tr><td colspan='6'><div class='inpMember'><input type='text' value='0' class='text planmm' />";
					var fieldsetTable = "<fieldset class='dropHere'><legend><input type='text' name='groupName' class='groupName'/></legend><div class='scroll'><table class='table tbl01'><tbody></tbody></table></div></fieldset></td></tr>";
					$('.mmlist').append(groupMemberHtml + fieldsetTable); */
					memberTab.initDrop();
				});
				
				$( "#table" ).delegate( "input[type=text]" , "change", function(){
					memberTab.caculateTotalMM();
				});
				
				
				$( "#table" ).delegate( ".levelChange" , "change", function(){
					$( this ).closest("tr").attr( "empLevelID", $( this ).find('option:selected').val());
					$( this ).closest("tr").attr( "empLevel", $( this ).find('option:selected').text());
					
				});
				
				$("#btnUpdate").click(function(){
					var isValid = memberTab.validate(); 
		
					if( isValid ){
						var mmlist = $( ".mmlist").children( "tr" );
						var addMembers = [];
						var updateMembers = [];
						var url = '<c:url value="/project/"/>' + page.projectID + "/members";
												
						$.each(mmlist, function( key, element ){
							if(!$(element).hasClass('tabledata')){       // is Group
								var groupId =  $(element).attr('employeeid');
								var $trGroup = $(element).find('tr.tabledata');
								if($(element).attr('employeeid') != null){  // is updateGroup
									var updateGMember=[], addGMember = [];
									$.each($trGroup , function(i, data){
										groupMember ={
												orgID: $( data ).attr( "orgID" ),
												org: $( data ).attr( "org" ),
												employeeID: $( data).attr( "employeeID" ),
												name: $( data ).attr( "empName" ),
												empLevel: $( data ).attr( "empLevel" ) ,
												position: $( data ).attr( "position" ),
												empLevelID: $( data ).attr( "empLevelID" ),
												type: memberTab.defineType($( data).attr( "employeeID" ), ($( data ).attr( "orgID" ) == undefined ? 'OUT' : 'group') ),
												projectMemberGroupID : groupId,
												projectMemberID :  $( data ).attr( "projectmemberid" )
										}
										if($( data ).attr( "groupid" ) != null || $( data ).attr( "projectmemberid" ) != null){
											updateGMember.push(groupMember);
										}else{
											addGMember.push(groupMember);
										}
									});
									var group = {
											groupName :$(element).find('.groupName').val() ,
											plannedWorkSize : $(element).find('.planmm').val(),	
											updateGroupMember : updateGMember,
											addGroupMember : addGMember,
											employeeID :groupId,
									};
									updateMembers.push(group);
								}else{
									// Add Group
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
												type: memberTab.defineType($( data).attr( "employeeID" ), ($( data ).attr( "orgID" ) == undefined ? 'OUT' : 'group') ),
												projectMemberID :  $( data ).attr( "projectmemberid" ),
										}
										groupMembers.push(groupMember);
									});
									var group = {
											groupName :$(element).find('.groupName').val() ,
											plannedWorkSize : $(element).find('.planmm').val(),	
											member : groupMembers
									};
									addMembers.push(group);
								}
							}else{
								// is Member
	 							var member = {
									employeeID : $( element ).attr( "employeeID" ),
									projectMemberID : $( element ).attr( "projectMemberID" ),
									name : $( element ).attr( "empName" ),
									position : $( element ).attr( "position" ),
									orgID :  $( element ).attr( "orgID" ),
									org :  $( element ).attr( "org" ),
									plannedWorkSize : $( element ).find( ".planmm" ).val(),
									type : memberTab.defineType($( element).attr( "employeeID" ), ($( element ).attr( "orgID" ) == undefined ? 'OUT' : 'member'))
								};
								
								if(typeof member.projectMemberID === "undefined"){
									member.empLevelID = typeof $( element ).attr( "empLevelID" ) != "undefined" ? $( element ).attr( "empLevelID" ) : $( ".levelChange option:first" ).val();
									member.empLevel = typeof $( element ).attr( "empLevel" ) != "undefined" ? $( element ).attr( "empLevel" ) : $( ".levelChange option:first" ).text();
									addMembers.push( member );
								}else {
									updateMembers.push( member );
								}
							}
						});
						
						if( memberTab.removedOldMembers.length > 0 ) {
							var url = '<c:url value="/project/"/>' + page.projectID + "/members";
							$.ajax({
								type : "DELETE",
								url : url,
								contentType : "application/json",
								data : JSON.stringify(memberTab.removedOldMembers),
								dataType : "json",
								cache : false,
								async : false,
								success : function(isDelete) {
									if(isDelete){
										memberTab.removedOldMembers = [];
									}
								}
							});
						}
						
						if( addMembers.length > 0 ) {
							var nextTab = true;
							$.ajax({
		   						type			: "POST",
		   						url				: url ,
		   					    contentType		: "application/json",
		   					    data			: JSON.stringify( addMembers ),
		   						dataType		: "json",
		   						async 			: false,
// 		   						cache			: false,
		   						success			: function( isCreate ){
		   							if(!isCreate) {
		   								Yuga.dialog.alert( "MESSAGE: There is an error while processing add. Please try again." );
		   								nextTab = false;
		   							}
		   						}
		   					});
							if(! nextTab) {
								return;
							}
						}

						if(updateMembers.length > 0) {
							var nextTab = true;
   							$.ajax( {
   			   					type			: "PUT",
   			   					url				: url ,
   			   				    contentType		: "application/json",
   			   				    data			: JSON.stringify( updateMembers ),
   			   					dataType		: "json",
   			   					async 			: false,
//    			   					cache			: false,
   			   					success			: function( isCreate ){
   			   						if(!isCreate) {
   			   							Yuga.dialog.alert( "MESSAGE: There is an error while processing update. Please try again." );
   			   						nextTab = false;
   			   						}
   			   					}
   			   				}); 
							if(! nextTab) {
								return;
							} 							
   						}
	   					if(tabUtil.hasNext() ){
			   	    		tabUtil.next();
 			   			}
					} // close validator
					
				});
				
				// remove old members which was saved in databases.
				$(".mmlist").on("click", ".btnRemove, .minus", function(evt){
					evt.preventDefault();
					var type;
					var	tr = $(this).closest("tr");
					var actualMM = tr.find(".actualMM").text() != "" ? parseFloat(tr.find(".actualMM").text()) : tr.find(".actualMM").text();
					var projectID = page.projectID;
					if($(this).hasClass('groupRM')){
						type = 'GROUP';
					}else{
						type = "MEMBER";
					}

 					if( actualMM <= 0 || actualMM == "") {
 						memberTab.removedOldMembers.push({
 							projectMemberID : typeof tr.attr("projectmemberid") !== "undefined" ? tr.attr("projectmemberid") : "",
 							employeeID : typeof tr.attr("employeeid") !== "undefined" ? tr.attr("employeeid") : tr.attr("groupid"),
 							type : type,
 							projectMemberGroupID : typeof tr.attr("groupid") !== "undefined" ? tr.attr("groupid") : "",
						});
						tr.remove();
					}else{
						Yuga.dialog.alert( "The account has been using in timecard and your reqeust could not be deleted.");
					}

				});
			},
			
			defineType : function(employeeID, type){
				var memberType = "";
				if(employeeID == page.employeeID){
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
			
			
			
			getAutoTBNId: function(){
				var nextValue = 0;
				try{
					nextValue = $("#table").find("tr[TBN=TBN]").last().find("td:first-child").text().match(/\d/g).join("");
				}
				catch(ex){
					
				}
				return parseInt(nextValue) + 1;
			},
			
			viewMembersData: function(){
				
				var url = '<c:url value="/project/"/>' + page.projectID + "/members";
				
				$.get(url, function(members){
					console.log(members);
					var totalMM = 0;
					memberTab.memberLoaded = true;
					memberTab.members = members;
					
					var wrapper = $('.mmlist');
					$('.mmlist').html('');
					$.each(members, function(index, data){
						
						var isTBN = false;
						if( data.orgID == null && data.member == null){
							isTBN = true;
						}	
						var newHtml = "";
						if(data.member != null && data.member.length >= 0){
   							newHtml = $("<tr employeeid='" + data.employeeID + "' projectmemberid='" + data.employeeID + "'>"
									+ "<td colspan='3'>"
									+ "<fieldset class='dropHere'><legend><input type='text' id='"+data.employeeID+"' name='groupName' value='"+data.groupName+"' class='groupName'/></legend><div class='scroll'><table class='table tbl01'><tbody></tbody></table></div></fieldset>"
									+ "</td>"				
									+ "<td><input type='text' class='text planmm' value='"+ data.plannedWorkSize +"'></td>"
									+ "<td class='actualMM center'>"+ data.actualWorkSize.toFixed(2) +"</td>"
									+ "<th><button class='groupRM btnRemove btn red'>X</button></th>");
							$('.mmlist').append(newHtml);
							
/*   							newHtml = $("<tr employeeid='"+data.employeeID+"' projectmemberid='"+data.employeeID+"'><td colspan='6'><div class='inpMember'><input type='text' value='"+data.plannedWorkSize+"' class='text planmm' /><label class='actualMM'>"+data.actualWorkSize.toFixed(2)+"</label><button type='button' class='btnRemove groupRM remove btn red'>X</button></div><fieldset class='dropHere'><legend><input type='text' id='"+data.employeeID+"'name='groupName' value='"+data.groupName+"'class='groupName'/></legend><div class='scroll'><table class='table tbl01'><tbody>");
							$('.mmlist').append(newHtml); */
							
							totalMM += data.plannedWorkSize;
							$.each(data.member,function(index, groupemp){
								var groupMMhtml = $( "<tr>" );
								groupMMhtml.addClass( "tabledata" );
								groupMMhtml.addClass( "newRow" );
								groupMMhtml.attr( "employeeID", groupemp.employeeID );
								groupMMhtml.attr( "empName", groupemp.name );
								groupMMhtml.attr( "empLevelID", groupemp.empLevelID );
								groupMMhtml.attr( "empLevel", groupemp.empLevel );
								groupMMhtml.attr( "position",  groupemp.position );
								groupMMhtml.attr( "orgID", groupemp.orgID);
								groupMMhtml.attr( "org", groupemp.org);
								groupMMhtml.attr( "projectMemberID", groupemp.projectMemberID);
								groupMMhtml.attr( "groupID", data.employeeID);  // Group ID
								groupMMhtml.append( "<td><button class='minus red'>_</button></td>" );
								groupMMhtml.append( "<td>" + groupemp.name + "</td>" );
								groupMMhtml.append( "<td>" + ( groupemp.org || "" ) + "</td>" );
								groupMMhtml.append( "<td>" + ( groupemp.empLevel || "" ) + "</td>" );
								newHtml.find('table.tbl01 tbody').append(groupMMhtml);
							});
							
						}else{
							newHtml = $( "<tr>" );
							newHtml.addClass( "tabledata" );
							newHtml.attr( "employeeID", data.employeeID );
							newHtml.attr( "empName", data.name );
							newHtml.attr( "empLevelID", data.empLevelID );
							newHtml.attr( "empLevel", data.empLevel );
							newHtml.attr( "position",  data.position );
							newHtml.attr( "orgID", data.orgID);
							newHtml.attr( "org", data.org);
							newHtml.attr( "projectMemberID", data.projectMemberID  );
							if( data.type == "TBN" ){
								newHtml.attr("TBN", "TBN");
								newHtml.addClass( "drop" );
							}
							if( data.type == "OUTSOURCE" ){
								newHtml.attr("outsouring", "outsouring");
								
							}
							if(isTBN){
								if(data.name.toLowerCase().indexOf("outsourcing") == -1){
									newHtml.addClass( "drop" );
								}
							}
							var lengthName = data.name.length;
							newHtml.append( "<td>" + (data.org != undefined ?  data.name : data.name.substring(0,lengthName-1) + "<span name='OUS'>"+data.name.substring(lengthName-1 ,lengthName)+"</span>")+ "</td>" );
							newHtml.append( "<td>" + ( data.org || '' ) + "</td>" );
							newHtml.append( "<td>" + ( data.empLevel || '' ) + "</td>" );
							newHtml.append( "<td><input type='text' class='text planmm' value='"+data.plannedWorkSize+"'/></td>" );
							newHtml.append( "<td class='actualMM center'>" + data.actualWorkSize.toFixed(2) + "</td>" );
							newHtml.append( "<th><button class='btnRemove btn red'>X</button></th>" );
							if(data.plannedWorkSize >= 0) {
								totalMM += data.plannedWorkSize;
							}
							
						}
						wrapper.append(newHtml);
					});
// 					$("#table").find( ".mmlist" ).append( wrapper.html() );
					$("#totalMM").text(totalMM);
					memberTab.initDrag();
					memberTab.initDrop();
				});
			},
			
			
			validate: function(){
				
				$( '#frmValidation' ).removeData('validator');
				
		        var arr = $( ".planmm" );
		        var rule = {
		        		
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
			},
			
		};
	
	
	var treeUtil = {
			
		init: function(){
			var year = new Date(memberTab.projectInfo.startDate).getFullYear();
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
						"valid_children" : ["default", "org", "emp"]
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
				var asyne = setInterval(function(){
					if(memberTab.memberLoaded){
						treeUtil.removeSelectedMembers(tree);
						clearInterval(asyne);
					}
				}, 100);
			});
			$(document)
			.bind("dnd_move.vakata",function(e,data){
				var targetElement = data.event.target;
				var nodeDetail = tree.get_node(data.data.nodes[0]);
				if(targetElement.textContent == "Drop Here" || $( targetElement).parent().hasClass( "drop" ) || $(targetElement).hasClass( "dropHere" )){
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
				// if nodes has children then loop via recuresive
 				for(var i = 0; i < nodeDetail.children.length; i++){
 					var childNodeDetails = tree.get_node(nodeDetail.children[i]);
 					// Process recuresive function
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
						newHtml.append( "<td class='actualMM center'> 0.00 </td>" );
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
					tree.create_node(value.parent, value);
					treeUtil.removedNodes.splice(index, 1);
					return;
				}
			});
		},
		
		removeSelectedMembers : function(tree){
			var members = memberTab.members;
			$.each(members, function(index, value){
				if(value != undefined && 
						typeof value === 'object'){
					if(value.member != null && value.member.length > 0 ){
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
	};
	
</script>