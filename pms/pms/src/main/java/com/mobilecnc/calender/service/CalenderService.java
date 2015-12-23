package com.mobilecnc.calender.service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.time.DateUtils;
import org.apache.poi.ss.usermodel.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobilecnc.calender.Calenders;
import com.mobilecnc.helper.service.PKService;

@Service
public class CalenderService {
	
	@Autowired
	CalenderDAO calenderDAO;

	public List<Calenders> getCalender(Calenders calender) {
		// TODO Auto-generated method stub
		return calenderDAO.getCalender(calender);
	}

	public Calenders insertCalender(Calenders calender) {
		// TODO Auto-generated method stub
		calender.setHolidayId(PKService.generateKey("Holiday"));
		if(calenderDAO.insertCalender(calender) == 1){
			return calender; 
		}else{
			return null;
		}
	}

	public Calenders updateCalender(Calenders calender) {
		// TODO Auto-generated method stub
		if(calenderDAO.updateCalender(calender)==1){
			return calender;
		}else{
			return null;
		}
	}

	public boolean deleteCalender(Calenders calender) {
		// TODO Auto-generated method stub
		if(calenderDAO.deleteCalender(calender) == 1){
			return true;
		}else{
			return false;
		}
	}

	public List<Calenders> getHistory() {
		// TODO Auto-generated method stub
		return calenderDAO.getHistory();
	}

	public List<Calenders> getentryJqgridCalender(Calenders calender) {
		// TODO Auto-generated method stub
		return calenderDAO.getentryJqgridCalender(calender);
	}

	public boolean copyCalender() {
		List<Calenders> calender = calenderDAO.getPreviousYear();
		for (Calenders cal : calender) {
			cal.setHolidayId(PKService.generateKey("Holiday"));
			cal.setStartDate(DateUtils.addYears(cal.getStartDate(), 1));
			cal.setEndDate(DateUtils.addYears(cal.getEndDate(), 1));
			cal.setHolidayTitle(cal.getHolidayTitle());
			calenderDAO.insertCalender(cal);
		}
		// TODO Auto-generated method stub
		return true;
	}

	public void removeDataYear(Calenders calen) {
		// TODO Auto-generated method stub
		calenderDAO.removeDataYear(calen);
	}

}
