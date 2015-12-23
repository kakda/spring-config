package com.mobilecnc.helper;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;

import com.mobilecnc.employees.Employee;
import com.mobilecnc.helper.service.MailService;
import com.mobilecnc.helper.service.SchedulerService;

@Controller
public class SchedulerController {

	@Autowired
	SchedulerService schedulerService;

	@Resource(name = "mail")
	MailService mailService;

	@Scheduled(cron = "0 0 8 * * MON")
	public void timeCardAlert() throws Exception {

		List<Employee> employees = new ArrayList<Employee>();
		employees = schedulerService.getEmployeeUnsubmitted();

		String title = "Timecard Followup";
		String[] to_address = new String[1];

		for (Employee employee : employees) {
			to_address[0] = employee.getEmail();
			try {
				mailService.sendMail(title, to_address,
						employee.getEmployeeName());
				System.out.println(to_address[0]);
			} catch (Exception ex) {
			}
		}

	}
}
