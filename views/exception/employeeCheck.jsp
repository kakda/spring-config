<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="count" value="1" ></c:set>

<div class="request">
	<h3>Employee Check <a href="<c:url value='/employee/index' />" class="btn">Go to Employee Import Page</a> </h3>
	<div class="project-type">
		<table class="table table-border">
			<colgroup>
				<col width="50" />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col width="50" />
				<col />
			</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>Name</th>
					<th>Title</th>
					<th>Level</th>
					<th>Division</th>
					<th>Department</th>
					<th>Team</th>
					<th>Email</th>
					<th>Valid</th>
					<th>Remark</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="employee"  items="${employees}" >
					<tr>
						<td>${count}</td>
						<td>${employee.name}</td>
						<td>${employee.title}</td>
						<td>${employee.level}</td>
						<td>${employee.division}</td>
						<td>${employee.department}</td>
						<td>${employee.team}</td>
						<td>${employee.email}</td>
						<td>
							<c:choose>
								<c:when test="${employee.valid == true}"><div class="ico yes"></div></c:when>
								<c:otherwise><div class="ico error"></div></c:otherwise>
							</c:choose>
						</td>
						<td>${employee.erroMsg}</td>
					</tr>
					<c:set  var="count" value="${count + 1}" ></c:set>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>