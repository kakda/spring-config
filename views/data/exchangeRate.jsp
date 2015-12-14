<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>


<div id="tabExR">
		<div class="tree">
			<div class="validDate">
				<label for="selectYear">Select year : </label>
				<select class="select" id="selectYear">
				<tiles:insertTemplate template="/WEB-INF/views/elements/masterData/yearSelect.jsp" />
			</select>
			</div>
			<div style=" padding:20px; border: 1px solid gray;width: 320px;align:'center';">
				<label for="krw">1USD = </label>
				<input type="text" id="krw" disabled="disabled"/> KRW
				
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		
		var data={
				
				initFilterYear : function()
				{
					data.observeYear();
					$("#selectYear").change(function(){
						data.observeYear();
					});
				},
				
				observeYear : function(){
					var valYear = $("#selectYear").val();
					var url = "<c:url value='/exchangeRate/byYear/" +valYear+"'/>";
				
					$.ajax({
						url:url,
						dataType:"json",
						method:"post",
						contentType : "application/json",
						success: function(data) {
							if (data != null &&
									data != undefined &&
									data.krw != undefined){
								var krwNum= Yuga.commaSeparateNumber(data.krw);
								$("#krw").val(krwNum);
							}
							else 
							{
								$("#krw").val("");
							}
						}
					});
				}
			
		};
		
		
		$(document).ready(data.initFilterYear);
	</script>