<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="format"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="function"%>

<c:set var="dateFormat" value="yyyy-MM-dd" scope="page" />
<c:set var="decimalFormat" value="###,###" scope="page" />
<c:set var="billAmount" value="0" scope="page" />

<format:formatDate value="${project.startDate}" var="startDate" pattern="${dateFormat}" />
<format:formatDate value="${project.endDate}" var="endDate" pattern="${dateFormat}" />
<style type="text/css">
	#tabsProMember, #tabsProResouce, #tabsProBudget {overflow-y: auto;max-height: 350px;}
</style>
<div id="tabs">
	<ul>
		<li><a href="#tabsProGeneral">General Information</a></li>
		<li><a href="#tabsProMember">Project Member</a></li>
		<li><a href="#tabsProBudget">Budget Plan</a></li>
		<li><a href="#tabsProResouce">Resource Plan</a></li>
	</ul>
	<div id="tabsProGeneral">
		<table class="dialog-form">
			<colgroup>
				<col width="150" />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<td>Project Name</td>
					<td><span class="info-project-name gray">${project.projectName}</span></td>
				</tr>
				<tr>
					<td>Project Type</td>
					<td><span class="info-project-name gray">${project.projectType.title}</span></td>
				</tr>
				<tr>
					<td>Project Period</td>
					<td><span class="info-project-period gray">${startDate} - ${endDate}</span></td>
				</tr>
				<tr>
					<td>Project Own Team</td>
					<td><span class="info-project-own-team gray">${project.projectOwner}</span></td>
				</tr>
				<tr>
					<td>Project Manager</td>
					<td><span class="info-project-manager gray">${project.projectManager}</span></td>
				</tr>
				<tr>
					<td>Status </td>
					<td>
						<span class="info-project-manager gray">
							<c:if test="${project.status == 'O'}">
								<c:out value="Open"></c:out>
							</c:if>
							<c:if test="${project.status == 'C'}">
								<c:out value="Close"></c:out>
							</c:if>
						</span>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div id="tabsProMember" class="project-member">
		<table class="dialog-form table table-border">
			<colgroup>
				<col width="150" />
				<col width="150" />
				<col width="150" />
				<col />
			</colgroup>
			<thead>
				<tr>
					<th>Name</th>
					<th>Team</th>
					<th>Level</th>
					<th>Planned MM</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="member" items="${project.members}">
					<tr>
						<td>${member.name}</td>
						<td class="center">${member.org}</td>
						<td class="center">${member.empLevel}</td>
						<td class="center">${member.plannedWorkSize}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div id="tabsProBudget" class="project-budget">
		<div class="leftSide">
			<fieldset>
				<legend>Revenue</legend>
				<table class="form">
					<colgroup>
						<col width="150" />
						<col width="50" />
						<col />
					</colgroup>
					<tr>
						<td><label>License Revenue:</label></td>
            			<td>${project.currency}</td>
						<td><format:formatNumber value="${project.licenseRevenue}"  pattern="${decimalFormat}" type="number"/></td>
					</tr>
					<tr>
						<td><label>SI Revenue:</label></td>
            			<td>${project.currency}</td>
						<td><format:formatNumber value="${project.siRevenue}"  pattern="${decimalFormat}" type="number"/></td>
					</tr>
					<tr>
						<td><label>SM Revenue:</label></td>
            			<td>${project.currency}</td>
						<td><format:formatNumber value="${project.smRevenue}"  pattern="${decimalFormat}" type="number"/></td>
					</tr>
					<tr>
						<td><label>Outsource Revenue:</label></td>
						<td class="unitText"></td>
						<td><format:formatNumber value="${project.outsourceRevenue}"  pattern="${decimalFormat}" type="number"/></td>
					</tr>
					<tr>
						<td><label>Internal R&D
								Revenue:</label></td>
            			<td>${project.currency}</td>
						<td><format:formatNumber value="${project.internalRDRevenue}"  pattern="${decimalFormat}" type="number"/></td>
					</tr>

				</table>
			</fieldset>
			
	        <fieldset>
	            <legend>3rd Party</legend>
	            <table class="form">
	            	<colgroup>
	            		<col width="150" />
	            		<col width="50" />
	            		<col />
	            	</colgroup>            	
	            	<tr>
	            		<td><label>Solution:</label></td>
	            		<td>${project.currency}</td>
	            		<td><format:formatNumber value="${project.vendorSolution}"  pattern="${decimalFormat}" type="number"/></td>
	            	</tr>
	            	<tr>
	            		<td><label>Outsourcing:</label></td>
	            		<td>${project.currency}</td>
	            		<td><format:formatNumber value="${project.vendorOutSourcing}"  pattern="${decimalFormat}" type="number"/></td>
	            	</tr>
	            </table>
	        </fieldset>
	        <fieldset>
	            <legend>Expense</legend> 
	            <table class="form">
	            	<colgroup>
	            		<col width="150" />
	            		<col width="50" />
	            		<col />
	            	</colgroup>            	
	            	<tr>
	            		<td><label>Project:</label></td>
	            		<td>${project.currency}</td>
	            		<td><format:formatNumber value="${project.expenseProject}"  pattern="${decimalFormat}" type="number"/></td>
	            	</tr>
	            	<tr>
	            		<td><label>Sales OPEX:</label></td>
	            		<td>${project.currency}</td>
	            		<td><format:formatNumber value="${project.expenseOPEX}"  pattern="${decimalFormat}" type="number"/></td>
	            	</tr>
	            </table>
	        </fieldset>
		</div>
		
	    <div class="rightSide">
	        <div class="project-member">
	            <h3 class="tit">Billing</h3>
	            
				<table class="dialog-form table">
					<colgroup>
						<col width="50" />
						<col width="100" />
						<col />
					</colgroup>
					<thead>
						<tr>
							<th>No</th>
							<th>Date</th>
							<th>Amount</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="bill" items="${project.bills}">
							<c:if test="${bill.billedType == 'PLAN'}">
								<c:set var="billAmount" value="${billAmount + 1}" scope="page"/>
								<tr>
									<td>${billAmount}</td>
									<td class="center"><format:formatDate value="${bill.billedDate}"  pattern="${dateFormat}" /></td>
									<td class="center"><format:formatNumber value="${bill.billedAmount}"  pattern="${decimalFormat}" type="number"/></td>
								</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
				<p>Gross Profit: <format:formatNumber value="${project.licenseRevenue + project.siRevenue + project.smRevenue + project.outsourceRevenue + project.internalRDRevenue - project.vendorSolution - project.vendorOutSourcing - project.expenseProject - project.expenseOPEX}"  pattern="${decimalFormat}" type="number"/></p>
	        </div>
	    </div>
	</div>
	
	<div id="tabsProResouce">
		<div class="scroll-both">
			<div class="fixed-header">
				<table class="table table-border">
					<colgroup>
						<col  style="width: 150px;" />
						<col  style="width: 150px;" />
						<col  style="width: 150px;" />
						<col  style="width: 90px;" />
						<c:forEach var="my" items="${project.monthYear}" >
							<col  style="width: 90px;" />
						</c:forEach>
					</colgroup>
					<thead>
						<tr>
							<th>Name</th>
							<th>Level</th>
							<th>Team</th>
							<th>Total (MM)</th>
							<c:forEach var="my" items="${project.monthYear}" >
								<th >${my.mmyy}</th>
							</c:forEach>
						</tr>
					</thead>
				</table>
			</div>
			<div class="body-scroll">
				<table  class="table table-border">	
					<colgroup>
						<col  style="width: 150px;" />
						<col  style="width: 150px;" />
						<col  style="width: 150px;" />
						<col  style="width: 90px;" />
						<c:forEach var="my" items="${project.monthYear}" >
							<col  style="width: 90px;" />
						</c:forEach>
					</colgroup>
					<tbody> 
						<c:forEach var="member" items="${project.members}">
							<tr height="54px">
								<td>${member.name}</td>
								<td>${member.empLevel}</td>
								<td>${member.org}</td>
								<td>${member.plannedWorkSize}</td>
								<c:forEach var="my" items="${project.monthYear}" >
									<td>
										<c:set var="monthFound" value="false" />
										<c:forEach var="plan" items="${member.resourcePlans}">
											<c:if test="${my.month == plan.month && my.year == plan.year}">
												<format:formatNumber value="${plan.plannedWorkSize}"  pattern="${decimalFormat}" type="number"/>
												<c:set var="monthFound" value="true" />
											</c:if>
										</c:forEach>
										<c:if test="${monthFound == false}">0</c:if>
									</td>
								</c:forEach>
								<%-- <c:forEach var="plan" items="${member.resourcePlans}" >
									<td>${plan.plannedWorkSize}</td>
								</c:forEach> --%>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		
	 </div>
</div>


<script type="text/javascript">
	$(document).ready(function() {

		$("#tabs").tabs();
		$('#dlgProjectDetail').dialog({title : "${project.projectName}"});
	});
</script>