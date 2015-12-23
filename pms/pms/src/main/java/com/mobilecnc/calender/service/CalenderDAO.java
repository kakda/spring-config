package com.mobilecnc.calender.service;

import java.util.List;

import com.mobilecnc.calender.Calenders;

public interface CalenderDAO {

	public List<Calenders> getCalender(Calenders calender);

	public int insertCalender(Calenders calender);

	public int updateCalender(Calenders calender);

	public int deleteCalender(Calenders calender);

	public List<Calenders> getHistory();

	public List<Calenders> getentryJqgridCalender(Calenders calender);

	public List<Calenders> getPreviousYear();

	public void removeDataYear(Calenders calen);

}
