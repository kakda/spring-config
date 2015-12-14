<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<div class="notice">
	<h3>Notice 
			<button class="btn white" id="btnPrev" type="button" class="back"> < </button>
			<button class="btn white" id="btnNext" type="button" class="next"> > </button></h3>
	<ul class="notice-list">
		<c:forEach items="${noticeList}" var="noticeTypeList" varStatus="list">
				<c:set var="fname" value="${userLog}"/>
			<c:choose>
	          <c:when test="${fn:trim(noticeTypeList.noticeType)=='1'}">
	          	<input type="hidden" name="noticeID" id="noticeID" value="${noticeTypeList.noticeID}"/> 
	          	<li class="notice-member" id="<c:url value="${list.index}"/>">
	          		<c:if test="${noticeTypeList.empList[0].employeeID == fname}">
   						<h3>You were assigned for a membership of "${noticeTypeList.projectList[0].projectName}"</h3>
					</c:if>   
					<c:if test="${noticeTypeList.empList[0].employeeID != fname}">
   						<h3>${noticeTypeList.empList[0].employeeName} asked for a membership of "${noticeTypeList.projectList[0].projectName}"</h3>
					</c:if>   		
					<span>${noticeTypeList.noticeTime}</span>
					<table class="detail">
						<thead>
							<tr>
								<th>PM</th>
								<th>Period</th>
								<th>Your M/M (Planned)</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>${noticeTypeList.pmName}</td>
								<td>${noticeTypeList.startDate} - ${noticeTypeList.endDate}</td>
								<td>${noticeTypeList.plannedWorkSize} M/M</td>
							</tr>
						</tbody>
					</table>
				</li>
	          </c:when>
	          <c:when test="${fn:trim(noticeTypeList.noticeType)=='2'}">
	          	<input type="hidden" name="noticeID" id="noticeID" value="${noticeTypeList.noticeID}"/> 
	           	<li class="notice-unsubmit" id="<c:url value="${list.index}"/>">
	           		<c:if test="${noticeTypeList.empList[0].employeeID == fname}">
   						<h3>You were unsubmitting some timecard data of "${noticeTypeList.projectList[0].projectName}"</h3>
					</c:if>   
					<c:if test="${noticeTypeList.empList[0].employeeID != fname}">
   						<h3>${noticeTypeList.empList[0].employeeName} asked for unsubmitting some timecard data of "${noticeTypeList.projectList[0].projectName}"</h3>
					</c:if>  
					<span>${noticeTypeList.noticeTime}</span>
					<table class="detail">
						<thead>
							<tr>
								<th>PM</th>
								<th>Period</th>
								<th>Your M/M (Planned)</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>${noticeTypeList.pmName}</td>
								<td>${noticeTypeList.startDate} - ${noticeTypeList.endDate}</td>
								<td>${noticeTypeList.plannedWorkSize} M/M</td>
							</tr>
						</tbody>
					</table>
				</li>
	           </c:when>
	           <c:when test="${fn:trim(noticeTypeList.noticeType)=='3'}">
	           	<input type="hidden" name="noticeID" id="noticeID" value="${noticeTypeList.noticeID}"/> 
	           	<li class="notice-pm" id="<c:url value="${list.index}"/>">  
	           		<c:if test="${noticeTypeList.empList[0].employeeID == fname}">
   						<h3>You were assigned as a PM for "${noticeTypeList.projectList[0].projectName}"</h3>
					</c:if>   
					<c:if test="${noticeTypeList.empList[0].employeeID != fname}">
   						<h3>${noticeTypeList.empList[0].employeeName} was assigned as a PM for "${noticeTypeList.projectList[0].projectName}"</h3>
					</c:if>   		
					<span>${noticeTypeList.noticeTime}</span>
					<table class="detail">
						<thead>
							<tr>
								<th>PM</th>
								<th>Period</th>
								<th>Your M/M (Planned)</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>${noticeTypeList.pmName}</td>
								<td>${noticeTypeList.startDate} - ${noticeTypeList.endDate}</td>
								<td>${noticeTypeList.plannedWorkSize} M/M</td>
							</tr>
						</tbody>
					</table>
				</li>
	           </c:when>
	          <c:otherwise>
	          	<input type="hidden" name="noticeID" id="noticeID" value="${noticeTypeList.noticeID}"/> 
	          	<li class="notice-overtime" id="<c:url value="${list.index}"/>">  		
	          		<c:if test="${noticeTypeList.empList[0].employeeID == fname}">
   						<h3>You were assigned to overtime for "${noticeTypeList.projectList[0].projectName}"</h3>
					</c:if>   
					<c:if test="${noticeTypeList.empList[0].employeeID != fname}">
   						<h3>${noticeTypeList.empList[0].employeeName} asked for overtime for "${noticeTypeList.projectList[0].projectName}"</h3>
					</c:if>  				
					<span>${noticeTypeList.noticeTime}</span>
					<table class="detail">
						<thead>
							<tr>
								<th>PM</th>
								<th>Period</th>
								<th>Your M/M (Planned)</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>${noticeTypeList.pmName}</td>
								<td>${noticeTypeList.startDate} - ${noticeTypeList.endDate}</td>
								<td>${noticeTypeList.plannedWorkSize} M/M</td>
							</tr>
						</tbody>
					</table>
				</li>
	          </c:otherwise>
			</c:choose>
		</c:forEach>
	</ul>
</div>
<script type="text/javascript">
	var page ={
		maxRecordsPerPage : "${noticeRecord}",
		perPage:10,
		showFrom:undefined,
		showTo:undefined,
		totalPages:undefined,
		totalRecords:$(".notice-list").find("li").length,
		init : function(){		
// 			page.initData();
			page.bindEvent();
		},
		initData : function(){
			if(parseInt(page.maxRecordsPerPage)<1){
				$(".notice-list").html("<li>No data view.</li>");
			}else{
				page.totalPages = ( page.totalRecords /parseInt(page.maxRecordsPerPage) );
				page.showFrom = page.perPage * (page.totalPages - 1);
				page.showTo = page.showFrom + page.perPage;
				$(".notice-list").find("li").each(function(index){
					if(index >= page.showTo){
						$(".notice-list").find("li[id='"+index+"']").hide();
					}else{				
						$(".notice-list").find("li[id='"+index+"']").show();	
					}			
				});
			}
		},
		bindEvent : function(){
			$("#btnPrev").bind("click",function(e){			
				e.preventDefault();
				if(parseInt(page.showFrom) > 0){
					page.showFrom = page.showFrom - page.perPage;	
					page.showTo = page.showFrom+page.perPage; 
					page.loadData();
				}
			});	
			$("#btnNext").bind("click",function(e){		
				e.preventDefault();
				page.showFrom = page.showTo;
				page.showTo =   page.showFrom + page.perPage;	
				page.loadData();
			});	
		},
		loadData : function(){
			if(page.showFrom<=parseInt(page.maxRecordsPerPage)){			 				
				$(".notice-list").find("li").each(function(index){					
					if((index >=  page.showFrom)&&(index<page.showTo)){	
						$(".notice-list").find("li[id='"+index+"']").show();
					}else{
						$(".notice-list").find("li[id='"+index+"']").hide();
					}
				
				});
			}		
		}
	};
	page.init();
</script>