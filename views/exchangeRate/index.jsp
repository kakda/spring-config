<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<div id="tsbExR">
	<div class="request">
		<div class="tree">
			<div class="validDate">
				<label for="selectYear" >Select year : </label> <select
					class="select" id="year">
					<tiles:insertTemplate template="/WEB-INF/views/elements/masterData/yearSelect.jsp" />
				</select>
			</div>
			<div
				style="padding: 20px; border: 1px solid gray; width: 320px; align: 'center';">
				<label for="krw">1USD = </label> <input type="text" id="krw" />KRW
				<div class="btn-group">
					<button type="button" id="saveData" class="btn btn-primary">Save</button>
					<button type="button" id="submitData" class="btn btn-primary">Submit</button>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">

	var exchangeRate = {
		masterData : null,
		DATA : "exhcange_rate",
		YES : 'Y',
		//-------------------------------------------
		init : function() {
			exchangeRate.initData();	
			exchangeRate.onChangeYear();
			exchangeRate.bindEvent();
		},
		//-------------------------------------------
		initData : function(){
			
			$("#year").val(new Date().getFullYear());
			$("#krw").autoNumeric({
				aPad : false
			});

			$("#tabs").tabs({
				active : 7,
				activate : function(event, ui) {
					Yuga.redirect(url[ui.newPanel.selector]);
				}
			});
		},
		//-------------------------------------------
		submitMasterData : function() {
			var url = "<c:url value='/masterData/submit' />";
			var data = {
				year : $("#year option:selected").text(),
				data : exchangeRate.DATA
			};
			$.ajax({
				url : url,
				dataType : "json",
				method : "post",
				data : JSON.stringify(data),
				contentType : "application/json",
				success : function(response) {
					if (response) {
						exchangeRate.observeMasterData();
					}
				}
			});
		},
		//-------------------------------------
		onChangeYear : function(){
			exchangeRate.renderExchangeRate();
			exchangeRate.observeMasterData();
		},
		//--------------------------------------------------
		observeMasterData : function() {
			exchangeRate.masterData = exchangeRate.getMasterData();
			if (exchangeRate.masterData.editable == exchangeRate.YES) {
				$("#submitData")
						.add("#saveData")
						.show();
			} else {
				$("#submitData")
						.add("#saveData")
						.hide();
			}
		},
		//-------------------------------------------
		getMasterData : function() {
			var year = $("#year option:selected").text();
			var url = "<c:url value='/masterData' />/" + year + "/"+ exchangeRate.DATA + "/get";
			var obj = null;

			$.ajax({
				url : url,
				dataType : "json",
				async : false,
				success : function(response) {
					obj = response;
				}
			});
			return obj;
		},
		//--------------------------------------
		renderExchangeRate : function(){

			var url = "<c:url value='/exchangeRate/byYear' />/" + $("#year").val();
			$.ajax({
				url : url,
				dataType : "json",
				success : function(response){
					if(response != null &&
							response.krw != undefined){
						$("#krw").val(Yuga.commaSeparateNumber(response.krw));
					}else{
						$("#krw").val("");
					}
				}
			});
		},
		//--------------------------------------
		bindEvent : function() {


			$("#saveData").on("click", function() {
				var url = "<c:url value='/exchangeRate/save' />";
				var valKrw = $("#krw").autoNumeric("get");
				var valYear = $("#year option:selected").text();
				$.ajax({
					url : url,
					dataType : "json",
					method : "post",
					contentType : "application/json",
					data : JSON.stringify({
						"exchangeRateID" : null,
						"krw" : valKrw,
						"year" : valYear
					}),
					success : function(data) {

					}
				});
			});
			
			$("#year").on("change", exchangeRate.onChangeYear);

			$("#submitData").on("click",function() {
							
									Yuga.dialog.confirm("Warning! when you click submit this masterdata <br /> You will not be able edit it in next time.",
									exchangeRate.submitMasterData);
					});
		},
	};
	$(document).ready(function(){

		exchangeRate.init();
	});
</script>


