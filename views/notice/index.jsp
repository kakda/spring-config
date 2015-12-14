<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>


<div class="notice">
	<h3>Notice <div class="navigate"><button class="btn white" id="btnPrev" disabled="disabled" type="button" class="back"> < </button> <button class="btn white" id="btnNext" type="button" class="next"> > </button></div></h3>
	<ul class="notice-list"></ul>
	<div class="mark-info">
		<span class="icon icon-member"></span> Assign Member
		<span class="icon icon-pm"></span> Assign Project Manager
		<span class="icon icon-overtime"></span> Overtime Request
		<span class="icon icon-unsubmit"></span> Unsubmit Request
		<span class="icon icon-membership"></span> Membership Request
	</div>
</div>

<script type="text/javascript">
	
	var notice = {
			
			def : {
				flag : {
					REQUEST : "REQUEST",
					RESPONSE : "RESPONSE",
					INFO : "INFO"
				},
				noticeType : {
					UNSUBMIT : "UNSUBMIT",
					MEMBERSHIP : "MEMBERSHIP",
					MEMBER : "MEMBER",
					PM : "PM",
					OVERTIME : "OVERTIME"
				},
				result : {
					approved : "1",
					denied : "0"
				}
			},
			employeeID : "<security:authentication property='principal'></security:authentication>",
			template : null,
			navigate : {
				page : 1,
				rows : 10,
				total : 1
			},
			
			init : function(){
				
				notice.initTemplate();
				notice.bindEvent();
				notice.initFeed();
			},
			
			initTemplate : function(){
				
				
				notice.template = "<li>" +
	 							  	"<h3>You were assigned for a membership of My Project</h3>" +
		 						  	"<span>2014/04/02</span>" +
		 						  	"<table class=\"detail\">" +
		 						  		"<thead>" +
		 						  			"<tr>" +
					 						  "<th class=\"pm\">PM</th>" +
					 						  "<th class=\"period\">Period</th>" +
					 						  "<th class=\"mm\">Planned MM</th>" +
				 						  	"</tr>" +
		 						  		"</thead>" +
		 						  		"<tbody>" +
			 						  		"<tr>" +
			 						  			"<td class=\"pm\"></td>" +
			 						  			"<td class=\"period\"></td>" +
			 						  			"<td class=\"mm\"></td>" +
			 						  		"</tr>" +
			 						  		"<tr>" +
			 						  			"<th class=\"assignee\">Assignee</th>" +
			 						  		"</tr>" +
			 						  		"<tr>" +
			 						  			"<td class=\"assignee\"></td>" +
			 						  		"</tr>" +
			 						  "</tbody>" +
		 						  	"</table>" +
		 						  "</li>";
				
			},
			
			bindEvent : function(){
				
				$("#btnPrev").on("click", function(){
					
					notice.navigate.page--;
					notice.initFeed();
					notice.updateNavigation();
				});
				$("#btnNext").on("click", function(){
					
					notice.navigate.page++;
					notice.initFeed();
					notice.updateNavigation();
				});
			},
			
			initFeed : function(){
				
				notice.loadFeed(function(response){
					
					notice.navigate.total = response.total;
					notice.updateNavigation();
					
					$(".notice-list").html("");
					
					if(response.rows.length > 0){
						
						$.each(response.rows, function(index, feed){
							notice.renderFeed(feed);
						});						
					}
				});
			},
			
			loadFeed : function (callback){
				
				var url = "<c:url value='/notice/getFeeds' />",
					data = "page=" + notice.navigate.page + "&rows=" + notice.navigate.rows;
				
				$.ajax({
					url : url,
					data : data,
					method : "POST",
					dataType : "json",
					success : function(response){
						
						if(typeof callback == 'function'){
							
							callback.call(this, response);
						}
					}
				});
			},
			
			updateNavigation : function(){

				if(notice.navigate.page == notice.navigate.total){
					$("#btnNext").attr("disabled", "disabled");
				}else{
					$("#btnNext").removeAttr("disabled");
				}
				
				if(notice.navigate.page == 1){
					$("#btnPrev").attr("disabled", "disabled");
				}else{
					$("#btnPrev").removeAttr("disabled");
				}
			},
			
			renderFeed : function(feed){
				
				var YOU = "You";
				var $li = $(notice.template);
				var projectStartDate = new Date(feed.project.startDate);
				var projectEndDate = new Date(feed.project.endDate);
				
				$li.find("span").text(feed.notice.noticeTime);
				
				if(feed.pm.employeeID == notice.employeeID){
					$li.find("td.pm").text(YOU);
				}else{
					$li.find("td.pm").text(feed.pm.employeeName);
				}
				$li.find("td.period").text(projectStartDate.toString(Yuga.config.format.date) + " to " + projectEndDate.toString(Yuga.config.format.date));
				
				
				switch(feed.flag){
					
					case notice.def.flag.INFO:
						
						break;
					case notice.def.flag.REQUEST:
				
						$li.find(".assignee").parent().remove();
						break;
					case notice.def.flag.RESPONSE:
						$li.addClass("response");
						$li.find(".assignee").parent().remove();
						break;
						
				}

				
				switch(feed.notice.noticeType.trim()){
				
					case notice.def.noticeType.MEMBER:
						$li.addClass("notice-member");
						
						if(feed.sender.employeeID == notice.employeeID){
							$li.find("td.assignee").text(YOU);
						}else{
							$li.find("td.assignee").text(feed.sender.employeeName);
						}
						

						if(feed.receiver == null){
							$li.find("h3").text("TBN was ");
						}else if(feed.receiver.employeeID == notice.employeeID){
							$li.find("h3").text(YOU + " were ");
						}else{
							$li.find("h3").text(feed.receiver.employeeName + " was ");
						}
						
						$li.find("h3").text( $li.find("h3").text() + " assigned for a membership of \""+ feed.project.projectName +"\"");
						
						if(feed.projectMember != null){
							$li.find("td.mm").text(feed.projectMember.plannedWorkSize + " MM");
						}
						
						break;
						
					case notice.def.noticeType.PM:
						$li.addClass("notice-pm");

						if(feed.sender.employeeID == notice.employeeID){
							$li.find("td.assignee").text(YOU);
						}else{
							$li.find("td.assignee").text(feed.sender.employeeName);
						}

						if(feed.receiver.employeeID == notice.employeeID){
							$li.find("h3").text(YOU + " were ");
						}else{
							$li.find("h3").text(feed.receiver.employeeName + " was ");
						}

						$li.find("h3").text( $li.find("h3").text() + " assigned for a project manager of \""+ feed.project.projectName +"\"");
						$li.find(".mm").remove();
						break;
						
					case notice.def.noticeType.MEMBERSHIP:
						$li.addClass("notice-membership");
						
						if(feed.flag == notice.def.flag.REQUEST){
							if(feed.sender.employeeID == notice.employeeID){
								$li.find("h3").text(YOU);
							}else{
								$li.find("h3").text(feed.sender.employeeName);
							}
							$li.find("h3").text($li.find("h3").text() + " asked a membership of \""+feed.project.projectName+"\"");
							$li.find(".mm").remove();
						}else{
							if(feed.receiver.employeeID == notice.employeeID){
								$li.find("h3").text("Your");
							}else{
								$li.find("h3").text(feed.receiver.employeeName);
							}
							$li.find("h3").text($li.find("h3").text() + " requested (asked a membership of \""+feed.project.projectName+"\")");
							
							if(feed.notice.isApproved == notice.def.result.approved){
								$li.find("h3").text($li.find("h3").text() + "  was approved.");
								$li.find("td.mm").text(feed.projectMember.plannedWorkSize + " MM");
							}else{
								$li.find("h3").text($li.find("h3").text() + "  was denied.");
								$li.find(".mm").remove();
							}
						}
						
						break;
						
					case notice.def.noticeType.UNSUBMIT:
						

						var timecardStartDate = new Date(feed.timecardProject.timecard.startDate);
						var timecardEndDate = new Date(feed.timecardProject.timecard.endDate);
						
						$li.addClass("notice-unsubmit");
						$li.find(".mm").remove();
						
						if(feed.flag == notice.def.flag.REQUEST){
							if(feed.sender.employeeID == notice.employeeID){
								$li.find("h3").text(YOU);
							}else{
								$li.find("h3").text(feed.sender.employeeName);
							}
							$li.find("h3").text($li.find("h3").text() + " asked for unsubmit of some data project \""+feed.project.projectName+"\". ");
						}else{
							
							if(feed.receiver.employeeID == notice.employeeID){
								$li.find("h3").text("Your");
							}else{
								$li.find("h3").text(feed.receiver.employeeName);
							}
							$li.find("h3").text($li.find("h3").text() + " requested (asked for unsubmit of some data project \""+feed.project.projectName+"\")");

							if(feed.notice.isApproved == notice.def.result.approved){
								$li.find("h3").text($li.find("h3").text() + "  was approved.");
							}else{
								$li.find("h3").text($li.find("h3").text() + "  was denied.");
							}
						}

						$li.find("td.period").text(timecardStartDate.toString(Yuga.config.format.date) + " to " + timecardEndDate.toString(Yuga.config.format.date));
						
						break;
						
					case notice.def.noticeType.OVERTIME:

						var timecardStartDate = new Date(feed.timecardProject.timecard.startDate);
						var timecardEndDate = new Date(feed.timecardProject.timecard.endDate);
						
						if(feed.flag == notice.def.flag.REQUEST){
							if(feed.sender.employeeID == notice.employeeID){
								$li.find("h3").text(YOU);
							}else{
								$li.find("h3").text(feed.sender.employeeName);
							}
							$li.find("h3").text($li.find("h3").text() + " asked for work overtime of project \""+feed.project.projectName+"\". ");
						}else{
							
							if(feed.receiver.employeeID == notice.employeeID){
								$li.find("h3").text("Your");
							}else{
								$li.find("h3").text(feed.receiver.employeeName);
							}
							$li.find("h3").text($li.find("h3").text() + " requested (asked for work overtime of project \""+feed.project.projectName+"\")");

							if(feed.notice.isApproved == notice.def.result.approved){
								$li.find("h3").text($li.find("h3").text() + "  was approved.");
							}else{
								$li.find("h3").text($li.find("h3").text() + "  was denied.");
							}
						}
						
						$li.addClass("notice-overtime");
						$li.find(".mm").remove();

						$li.find("td.period").text(timecardStartDate.toString(Yuga.config.format.date) + " to " + timecardEndDate.toString(Yuga.config.format.date));
						
						break;
				}
				
				
				$(".notice-list").append($li);
			}
	};
	
	$(document).ready(notice.init);
</script>
