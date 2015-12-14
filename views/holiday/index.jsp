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

	<div class="bubblemain">
		<form>
			<div class="popup">
				<h1>Holiday</h1>
				<div>
					<table>
						<tr>
							<td><label>Start Date</label></td>
							<td><input type="text" readonly="readonly" name="startDate" id="startDate" class="startDate dateText text" /></td>
						</tr>
						<tr>
							<td><label>End Date</label></td>
							<td><input type="text" readonly="readonly" name="endDate"
								id="endDate" class="endDate dateText text" /></td>
						</tr>
						<tr>
							<td><label>Holiday Title</label></td>
							<td><input type="text" class='value text'></td>
						</tr>
						<tr>
							<td><label>Office</label></td>
							<td><select id="office" class="select" >
									<option value="KOREA">KOREA</option>
									<option value="CAMBODIA">CAMBODIA</option>
							</select></td>
						</tr>
					</table>
					<div>
						<button type="button" class='btn white save'>Create</button>
						<button type="button" class='btn red delete'>Delete</button>
						<button type="button" class='btn edit'>Update</button>						
					</div>
				</div>
			</div>
		</form>
	</div>
</div>


<script type="text/javascript">
	$(document).ready(function() {
						$("#tabs").tabs({
							active : 4,
							activate : function(event, ui) {
								Yuga.redirect(url[ui.newPanel.selector]);
							}
						});
						var tabSelection = 0;

						$(".dateText").datepicker({
							changeMonth : true,
						});
						$(".dateText").datepicker("disable");

						var calendar = $('#calendar')
								.fullCalendar(
										{
											header : {
												left : 'today',
												center : 'prev,title,next ',
												right : 'month,agendaWeek',
											},
											contentHeight : 500,
											selectable : true,
											selectHelper : true,
											select : function(start, end,
													allDay, jsEvent, view) {
												$('.save').removeClass('hide');
												$('.edit,.delete').addClass(
														'hide');
												$(".bubblemain")
														.dialog("close");
												$(".bubblemain")
														.dialog(
																{
																	modal : true,
																	open : function() {
																		$(
																				"input[type='text']")
																				.val(
																						'');
																		$(
																				'.dateText')
																				.val(
																						$.fullCalendar
																								.formatDate(
																										start,
																										"yyyy-MM-dd"));
																		$(
																				".dateText")
																				.datepicker(
																						"enable");
																		$(
																				'.save')
																				.unbind();
																		$(
																				".save")
																				.bind(
																						'click',
																						function(
																								e) {
																							var text = $(
																									'.value')
																									.val();
																							var startedDate = $.fullCalendar
																									.parseISO8601($(
																											'#startDate')
																											.val());
																							var endedDate = $.fullCalendar
																									.parseISO8601($(
																											'#endDate')
																											.val());
																							var office = $(
																									'#office option:selected')
																									.val();
																							saveCalender(
																									office,
																									text,
																									startedDate,
																									endedDate,
																									allDay);
																							$(
																									".bubblemain")
																									.dialog(
																											"close");
																						});
																	},
																	close : function() {
																		$(
																				".dateText")
																				.datepicker(
																						"disable");
																		calendar
																				.fullCalendar('unselect');
																	}
																});

												$(".bubblemain").dialog("open");

											},
											viewRender : function(view, element) {
												console.log(view.title);
											},
											eventClick : function(calEvent,
													jsEvent, view) {
												console.log(calEvent);
												$(".bubblemain")
														.dialog("close");
												$('.edit,.delete').removeClass(
														'hide');
												$('.save').addClass('hide');
												$(".bubblemain")
														.dialog(
																{
																	position : {
																		my : "bottom",
																		of : jsEvent,
																		collision : "fix"
																	},
																	open : function() {
																		$(
																				'#startDate')
																				.val(
																						$.fullCalendar
																								.formatDate(
																										calEvent.start,
																										"yyyy-MM-dd"));
																		$(
																				'#endDate')
																				.val(
																						$.fullCalendar
																								.formatDate(
																										(calEvent.end != null) ? calEvent.end
																												: calEvent.start,
																										"yyyy-MM-dd"));
																		$(
																				'.value')
																				.val(
																						calEvent.title);
																		$(
																				'#office')
																				.val(
																						calEvent.office);
																		$(
																				'.edit')
																				.unbind();
																		$(
																				".dateText")
																				.datepicker(
																						"enable");
																		$(
																				".edit")
																				.bind(
																						'click',
																						function(
																								e) {
																							calEvent.title = $(
																									'.value')
																									.val();
																							calEvent.start = $.fullCalendar
																									.parseISO8601($(
																											'#startDate')
																											.val());
																							calEvent.end = $.fullCalendar
																									.parseISO8601($(
																											'#endDate')
																											.val());
																							calEvent.office = $(
																									'#office option:selected')
																									.val();
																									calEvent.color = ($(
																											'#office option:selected')
																											.val() == "KOREA" ? "#FFFF00"
																											: "#FF0000"),
																									updateCalender(calEvent);
																							$(
																									".bubblemain")
																									.dialog(
																											"close");
																						});
																		$(
																				'.delete')
																				.unbind();
																		$(
																				".delete")
																				.bind(
																						'click',
																						function(
																								e) {
																							deleteCalender(calEvent);
																							$(
																									".bubblemain")
																									.dialog(
																											"close");
																						})

																	},
																	close : function() {
																		$(
																				".dateText")
																				.datepicker(
																						"disable");
																		calendar
																				.fullCalendar('unselect');
																	}
																});
												$(".bubblemain").dialog("open");
											},
											eventDrop : function(event,
													dayDelta, minuteDelta,
													allDay, revertFunc,
													jsEvent, ui, view) {
												updateCalender(event);
											},
											loading : function(isLoading, view) {
												if (isLoading) {
													$("#loading").show();
												} else {
													$("#loading").hide();
												}
											},
											editable : true,
											events : function(start, ends,
													callback) {
												var data = {
													"startDate" : start
															.getTime(),
													"endDate" : ends.getTime()
												};
												$
														.ajax({
															type : "POST",
															url : "<c:url value='/holiday/ajaxGetCalender' />",
															dataType : "json",
															contentType : "application/json",
															data : JSON
																	.stringify(data),
															success : function(
																	event) {
																if (event.length != 0) {
																	var eventData = [];
																	$
																			.each(
																					event,
																					function(
																							key,
																							value) {
																						eventData
																								.push({
																									id : value.holidayID,
																									start : new Date(
																											value.startDate),
																									end : new Date(
																											value.endDate),
																									title : value.holidayTitle,
																									allDay : true,
																									textColor : 'black',
																									color : (value.office == "KOREA" ? "#FFFF00"
																											: "#FF0000"),
																									office : value.office
																								});
																					});
																	callback(eventData);
																}
															}
														});
											}
										});
						$(".bubblemain").dialog({
							autoOpen : false,
							resizable : false,
							width : 'auto',
							height : 'auto'
						});
						$(".popupDialog")
								.dialog(
										{
											autoOpen : false,
											resizable : true,
											modal : true,
											buttons : {
												"ok" : function() {
													$
															.ajax({
																type : "POST",
																url : "<c:url value='/holiday/copyCalender' />",
																dataType : "json",
																contentType : "application/json",
																success : function(
																		event) {
																	if (event) {
																		$(
																				"#historytab")
																				.tabs(
																						"destroy");
																		$(
																				'.fc-button-agendaWeek')
																				.click();
																		$(
																				".popupDialog")
																				.dialog(
																						"close");
																	}
																}
															});
												},
												"cancel" : function() {
													$(".popupDialog").dialog(
															"close");
												}
											},
											close : function() {
												$(".popupDialog").dialog(
														"close");
											}
										});
						$(".bubblemain").dialog("widget").find(
								".ui-dialog-titlebar").css({
							"float" : "right",
							border : 0,
							padding : 0
						}).find(".ui-dialog-title").css({
							display : "none"
						}).end().find(".ui-dialog-titlebar-close").css({
							top : 0,
							right : 0,
							margin : 0,
							"z-index" : 999
						});
						function saveCalender(office, text, start, end, allDay) {
							var data = {
								"startDate" : start.getTime(),
								"endDate" : end.getTime(),
								"holidayTitle" : text,
								"office" : office
							}
							$.ajax({
								type : "POST",
								url : "<c:url value='/holiday/doadd' />",
								dataType : "json",
								contentType : "application/json",
								data : JSON.stringify(data),
								success : function(json) {
									calendar.fullCalendar('renderEvent', {
										title : text,
										start : start,
										end : end,
										allDay : true,
										textColor : 'black',
										color : (office == "KOREA" ? "#FFFF00"
												: "#FF0000"),
										id : json.holidayID,
										office : office
									});
								}
							});

						}
						function updateCalender(calEvent) {
							var data = {
								"startDate" : calEvent.start.getTime(),
								"endDate" : (calEvent.end == null) ? calEvent.start
										.getTime()
										: calEvent.end.getTime(),
								"holidayTitle" : calEvent.title,
								"holidayID" : calEvent.id,
								"office" : calEvent.office
							}
							$.ajax({
								type : "POST",
								url : "<c:url value='/holiday/doUpdate' />",
								dataType : "json",
								contentType : "application/json",
								data : JSON.stringify(data),
								success : function(json) {
									console.log(json);
									calendar.fullCalendar('updateEvent',
											calEvent);
								}
							});
						}
						function deleteCalender(calEvent) {
							var data = {
								"holidayID" : calEvent.id
							};
							$.ajax({
								type : "POST",
								url : "<c:url value='/holiday/doDelete' />",
								dataType : "json",
								contentType : "application/json",
								data : JSON.stringify(data),
								success : function(json) {
									calendar.fullCalendar('removeEvents',
											calEvent.id);
								}
							});

						}
						$('.fc-button-agendaWeek')
								.click(
										function() {
											$('.fc-view-agendaWeek').html('');
											$('.fc-header-title h2').text(
													'Holiday List');
											$(
													'.fc-button-prev,.fc-button-next,.fc-button-today')
													.addClass('hide');
											$
													.ajax({
														type : 'post',
														url : "<c:url value='/holiday/getHistory'/>",
														dataType : "json",
														contentType : 'application/json',
														success : function(json) {
															tabGenerator(json);
														}
													});

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
								html += "<li><a id='tabAdd' href='#addTab'>"
										+ "+" + "</a></li>";
								html += '</ul>';
								$
										.each(
												json,
												function(key, value) {
													html += "<div id='"+key+"' class='project-member'>";
													html += "<table id='test' class='table table-border'>";
													html += "<tr><th>Period</th><th>Descripition</th><th>Office</th></tr>";
													var arrayJson = [];
													arrayJson = json[key];
													$
															.each(
																	arrayJson,
																	function(k,
																			v) {
																		html += "<tr id="+arrayJson[k].holidayID+"><td >"
																				+ $.fullCalendar
																						.formatDate(
																								new Date(
																										arrayJson[k].startDate),
																								'yyyy-MM-dd')
																				+ " ~ "
																				+ $.fullCalendar
																						.formatDate(
																								new Date(
																										arrayJson[k].endDate),
																								'yyyy-MM-dd')
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
									selected : tabSelection
								});
							} else {
								$('#historytab').html('');
								$('#historytab').addClass('hide');
							}
						}

						$("#historytab").bind("tabsselect",
								function(event, ui) {
									tabSelection = ui.index;
								});

						$('#historytab')
								.delegate(
										'table tbody tr',
										'click',
										function(e) {
											var calEvent = new Object();
											eventId = $(this).attr('id');
											if (eventId != undefined) {
												$(".bubblemain")
														.dialog("close");
												var trThis = $(this);
												trThis.toggleClass('hilight');
												split = trThis.find('td:first')
														.html().split("~");
												holidayText = trThis.find(
														'td:nth-child(2)')
														.html().trim();
												office = trThis.find(
														'td:nth-child(3)')
														.html().trim();
												console.log(office);
												$(".bubblemain")
														.dialog(
																{
																	position : {
																		my : "bottom",
																		of : e,
																		collision : "fix"
																	},
																	open : function() {
																		$(
																				'.edit,.delete')
																				.removeClass(
																						'hide');
																		$(
																				'.save')
																				.addClass(
																						'hide');
																		$(
																				'#startDate')
																				.val(
																						split[0]
																								.trim());
																		$(
																				'#endDate')
																				.val(
																						split[1]
																								.trim());
																		$(
																				"#office")
																				.val(
																						office);
																		$(
																				'.value')
																				.val(
																						holidayText);
																		$(
																				".dateText")
																				.datepicker(
																						"enable");
																		$(
																				".edit")
																				.unbind()
																				.bind(
																						'click',
																						function(
																								e) {
																							e
																									.preventDefault();
																							calEvent.id = eventId;
																							calEvent.title = $(
																									'.value')
																									.val();
																							calEvent.start = $.fullCalendar
																									.parseISO8601($(
																											'#startDate')
																											.val());
																							calEvent.end = $.fullCalendar
																									.parseISO8601($(
																											'#endDate')
																											.val());
																							calEvent.office = $(
																									'#office option:selected')
																									.val();
																									calEvent.color = ($(
																											'#office option:selected')
																											.val() == "KOREA" ? "#FFFF00"
																											: "#FF0000"),
																									updateCalender(calEvent);
																							$(
																									".bubblemain")
																									.dialog(
																											"close");
																							trThis
																									.removeClass('hilight');
																							$(
																									"#historytab")
																									.tabs(
																											"destroy");
																							$(
																									'.fc-button-agendaWeek')
																									.click();
																						});

																		$(
																				".delete")
																				.unbind()
																				.bind(
																						'click',
																						function(
																								e) {
																							e
																									.preventDefault();
																							calEvent.id = eventId;
																							deleteCalender(calEvent);
																							trThis
																									.removeClass('hilight');
																							$(
																									".bubblemain")
																									.dialog(
																											"close");
																							$(
																									".edit")
																									.unbind();
																							tabSelection = 0;
																							$(
																									"#historytab")
																									.tabs(
																											"destroy");
																							$(
																									'.fc-button-agendaWeek')
																									.click();
																						})
																	},
																	close : function() {
																		$(
																				".dateText")
																				.datepicker(
																						"disable");
																		trThis
																				.removeClass('hilight');
																	}
																});
												$(".bubblemain").dialog("open");
											}
										});

						$('#historytab')
								.delegate(
										'#tabAdd',
										'click',
										function() {
											var value = parseInt($(
													"div#historytab ul li").eq(
													-2).text()) + 1;
											// 			 $("<li class='ui-state-default ui-corner-top ui-tabs-selected'><a href='#" + value + "'>" + value + "</a></li>").insertBefore($(this).parent());
											// 			 $("div#tab").append("<div id='" + value + "'></div>");
											$('.popupDialog')
													.text(
															"Are you sure want to create "
																	+ value
																	+ " Holiday and Copy All Data From the Previous year?");
											$('.popupDialog').dialog("open");
										});

						$('#historytab')
								.delegate(
										'span.ui-icon-close',
										'click',
										function() {
											var id = $(this).closest("li")
													.attr('key');
											var panelId = $(this).closest("li")
													.remove().attr(
															"aria-controls");
											$("#" + panelId).remove();
											$
													.ajax({
														type : 'post',
														url : "<c:url value='/holiday/removeDataYear'/>",
														data : 'years=' + id,
														success : function(json) {
															if (json) {
																tabSelection = 0;
																$("#historytab")
																		.tabs(
																				"destroy");
																$('#calendar')
																		.fullCalendar(
																				'refetchEvents');
																$(
																		'.fc-button-agendaWeek')
																		.click();
															} else {
																console
																		.log('ERROR');
															}
														}
													});

										});

					});
</script>

<div id='historytab' class='hide'></div>
<div class="popupDialog">
	<p>Do you want to copy Holiday from the Previous to New Year?</p>
</div>

