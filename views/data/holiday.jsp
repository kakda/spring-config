<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<div id="tabsHC">
	<div class="opr">
		<fieldset>
			<legend>Calender Holiday</legend>
			<div id='calendar' class="fc fc-ltr"></div>
			<div id='calendarList' class='hide'></div>
		</fieldset>
	</div>
	</div>
	
<div id='historytab' class='hide'></div>	
	


<script type="text/javascript">

	$(document).ready(function() {
				
			
		
		var calendar = $('#calendar').fullCalendar({
			header: {
				left: 'today',
				center: 'prev,title,next ',
				right: 'month,agendaWeek',
			},
			contentHeight: 500,
			selectable: true,
			selectHelper: true,
			select: function(start, end, allDay,jsEvent, view) {
				$('.save').removeClass('hide');
				$('.edit,.delete').addClass('hide');
				
			
			},
			viewRender : function(view,element){
				console.log(view.title);
			},
			loading : function(isLoading,view){
				if(isLoading){
					 $("#loading").show();
				}else{
					 $("#loading").hide();
				}
			},
			editable : false,
			events : function(start, ends, callback){
				var data = {
						"startDate" : start.getTime(),
						"endDate" : ends.getTime()
				};
				$.ajax({
					type : "POST",
					url : "<c:url value='/holiday/ajaxGetCalender' />",
					dataType : "json",
					contentType : "application/json",
					data : JSON.stringify(data),
					success : function(event){
						if(event.length != 0){
						var eventData = [];
						$.each(event,function(key,value){
							eventData.push({
								id : value.holidayID,
								start : new Date(value.startDate),
								end : new Date(value.endDate),
								title : value.holidayTitle,
								allDay : true,
								textColor : 'black',
								color : (value.office == "KOREA" ? "#FFFF00" : "#FF0000"),
								office : value.office
							});
						});
					callback(eventData);
					}
					}
				});
			}
		});
		    
		$('.fc-button-month')
		.click(
				function() {
					$(
							'.fc-button-prev,.fc-button-next,.fc-button-today')
							.removeClass('hide');
					$("#historytab").addClass('hide');
					$("#historytab").tabs("destroy");
					$('#calendar').fullCalendar(
							'refetchEvents');
				});
		
		
		// Week Click
		$('.fc-button-agendaWeek').click(
				function() {
					$('.fc-view-agendaWeek').html('');
					$('.fc-header-title h2').text('Holiday List');
					$('.fc-button-prev,.fc-button-next,.fc-button-today').addClass('hide');
					$.ajax({
							type : 'post',
							url : "<c:url value='/holiday/getHistory'/>",
							dataType : "json",
							contentType : 'application/json',
							success : function(json) {
								tabGenerator(json);
							}
						});

				});
		
		function tabGenerator(json) {
			// 			$('#historytab').tabs('refresh');
			if (!$.isEmptyObject(json)) {
				var html = '';
				html += '<ul>';
				$
						.each(
								json,
								function(key, value) {
									html += "<li key="+key+"><a href='#"+key+"'>"
											+ key + "";
									html += "</a><span class='ui-icon ui-icon-close'>s</span></li>";
								});
// 				html += "<li><a id='tabAdd' href='#addTab'>"
						+ "+" + "</a></li>";
				html += '</ul>';
				$.each(json,function(key, value) {
						html += "<div id='"+key+"' class='project-member'>";
						html += "<table id='test' class='table table-border'>";
						html += "<tr><th>Period</th><th>Descripition</th><th>Office</th></tr>";
						var arrayJson = [];
						arrayJson = json[key];
						$.each(arrayJson,function(k,v) {
														html += "<tr id="+arrayJson[k].holidayID+"><td >"
																+ $.fullCalendar.formatDate(new Date(arrayJson[k].startDate),'yyyy-MM-dd')
																+ " ~ "
																+ $.fullCalendar.formatDate(new Date(arrayJson[k].endDate),'yyyy-MM-dd')
																+ "</td><td>"
																+ arrayJson[k].holidayTitle
																+ "</td><td>"
																+ arrayJson[k].office
																+ "</td></tr>";
													});
									html += '</table></div>';
									html += '</div>';
								});
				html += "<div id='add'></div>";
				$('#historytab').removeClass('hide');
				$('#historytab').html(html);
				$('#historytab').tabs({
					selected : 0
				});
			} else {
				$('#historytab').html('');
				$('#historytab').addClass('hide');
			}
		}
		
		
	});
	
</script>



