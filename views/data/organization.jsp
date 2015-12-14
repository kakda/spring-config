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
		</div>
		<div id="orgTree"></div>
		
	</div>
</div>




<script type="text/javascript">
	$(document).ready(function(){
		
		var org = {
			treeSelector : "#orgTree",
			type : "org",
			searchTyping : null,
			DATA : "organization", 
			YES : 'Y',
			masterData : null,

			init : function(){
				
				org.initData();
				org.initTree();
				org.bindEvent();
			},
			
			bindEvent : function(){
			
				$("#search").on("keyup", org.search);
				$("#year").on("change", org.changeYear);
				
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
					  	 "search", "state", "types", "wholerow", "dnd"
					],
					
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
	
			search : function(){
				if(org.searchTyping){ 
					clearTimeout(org.searchTyping); 
				}
				org.searchTyping = setTimeout(function () {
			        $.jstree.reference(org.treeSelector).search($('#search').val());
			    }, 250);
			},
			
			
			changeYear : function(){
				$.jstree.reference(org.treeSelector).refresh();
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
			},
			
			observeMasterData : function(){
				org.masterData = org.getMasterData();
				
				if(org.masterData != null){	
					$("#lastUpdated").val(org.masterData.lastUpdated);
				}
				$.jstree.reference(org.treeSelector).open_all();
			}
		};
		
		org.init();
	});
</script>
