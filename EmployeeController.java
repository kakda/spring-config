package com.mcnc.yuga.controller;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.codehaus.jackson.node.ArrayNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mcnc.yuga.dto.Employee;
import com.mcnc.yuga.dto.EmployeeLevel;
import com.mcnc.yuga.dto.EmployeeMonthlyUpdate;
import com.mcnc.yuga.dto.EmployeeYearlyUpdate;
import com.mcnc.yuga.dto.MasterData;
import com.mcnc.yuga.dto.Project;
import com.mcnc.yuga.dto.Utilization;
import com.mcnc.yuga.helper.grid.Request;
import com.mcnc.yuga.helper.grid.Response;
import com.mcnc.yuga.helper.key.Constant;
import com.mcnc.yuga.helper.tile.ViewMapper;
import com.mcnc.yuga.helper.workbook.EmployeeVO;
import com.mcnc.yuga.service.EmployeeLevelService;
import com.mcnc.yuga.service.EmployeeService;
import com.mcnc.yuga.service.MasterDataService;
import com.mcnc.yuga.service.NoticeMessageService;
import com.mcnc.yuga.service.OrganizationService;
import com.mcnc.yuga.service.PKService;
import com.mcnc.yuga.service.PagingResponseService;
import com.mcnc.yuga.util.CustomObjectMapper;
import com.mcnc.yuga.util.DateUtils;
import com.mcnc.yuga.util.WebUtils;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

	@Autowired
	NoticeMessageService noticeMessageService;

	@Autowired
	PKService pkService;

	@Autowired
	EmployeeService employeeService;

	@Autowired
	EmployeeLevelService employeeLevelService;

	@Autowired
	PagingResponseService pagingResponseService;

	@Autowired
	OrganizationService organizationService;

	@Autowired
	MasterDataService masterDataService;

	private static final Logger logger = LoggerFactory
			.getLogger(Employee.class);

	@RequestMapping("/index")
	public String index(ModelMap model) {
		
		String level = ":All";
		List<EmployeeLevel> list = employeeLevelService.getByYear(DateUtils
				.getCurrentYear());
		for (EmployeeLevel employeeLevel : list) {
			level += ";" + employeeLevel.getEmpLevelID() + ":"
					+ employeeLevel.getTitle();
		}
		model.addAttribute("level", level);
		model.addAttribute("role", "E:Employee;S:Super User;P:PM");
		model.addAttribute("listLevel",list);
		return ViewMapper.EMPLOYEE_INDEX;

	}
	@RequestMapping("/employeeLevel/{year}")
	@ResponseBody
	public List<EmployeeLevel> employeeLevel(@PathVariable("year") int year) {
		return employeeLevelService.getByYear(year);
	}
	
	@RequestMapping(value = "/{employeeID}", method = RequestMethod.GET)
	@ResponseBody
	public Employee getEmployeeByPK(@PathVariable("employeeID") String employeeID) {
		return employeeService.getEmployeeByPK(employeeID);
	}
	
	@RequestMapping(value = "/getEmployee", method = RequestMethod.GET)
	@ResponseBody
	public Employee getEmployee(Principal principal) {
		return employeeService.getEmployeeByPK(principal.getName());
	}

	@RequestMapping(value = "/import", method = RequestMethod.POST)
	public String doImport(MultipartFile file,
			RedirectAttributes redirectAttributes) throws IOException {
		if (file != null) {
			if (file.getContentType().equals(Constant.FILE_TYPE_EXCEL_2003)
					|| file.getContentType().equals(
							Constant.FILE_TYPE_EXCEL_2007)) {
				if (employeeService.importFile(file.getInputStream())) {
					redirectAttributes
							.addFlashAttribute(
									"noticeMessage",
									noticeMessageService
											.getSuccessMessage("Import file successed."));
					logger.debug("Import file completed..");
				} else {
					redirectAttributes.addFlashAttribute("noticeMessage",
							noticeMessageService
									.getErrorMessage("Invalid excel file."));
				}
			} else {
				redirectAttributes.addFlashAttribute("noticeMessage",
						noticeMessageService
								.getErrorMessage("Invalid file format."));
			}
		} else {
			redirectAttributes.addFlashAttribute("noticeMessage",
					noticeMessageService
							.getErrorMessage("Please select file import."));
		}
		return "redirect:/" + ViewMapper.EMPLOYEE_INDEX;
	}

	@RequestMapping(value = "/getGrid")
	@ResponseBody
	public Response getGrid(@ModelAttribute Request request,
			@ModelAttribute EmployeeVO employeeVO) {
		int count = employeeService.getTotalEmployee(employeeVO);
		CustomObjectMapper objectMapper = new CustomObjectMapper();
		ArrayNode rows = objectMapper.convertValue(
				employeeService.getGridEmployeeVO(employeeVO), ArrayNode.class);
		return pagingResponseService.makePaginationResponse(request, count,
				rows);
	}
	
	// get Total workable hour of employee monthly
	private float getAVGTotalWorkableHour(EmployeeMonthlyUpdate employeeMonthlyUpdate){						
		try {			
			
			float totalWorkableHour = employeeService.getAVGTotalWorkableHour(employeeMonthlyUpdate);		
			
			return totalWorkableHour;
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return 0;
		}		
	}	
	
	
	@RequestMapping(value = "/saveRow", method = RequestMethod.PUT)
	@ResponseBody
	public Boolean saveRow(@RequestBody EmployeeVO employeeData) {
		List<EmployeeMonthlyUpdate> monthly    = employeeData.getMonthly();
		List<EmployeeYearlyUpdate> yearly	  = employeeData.getYearly();
		boolean result = false;
		String empId = "";
		if (employeeData.getOperation().equalsIgnoreCase("add")) {
			
			empId = pkService.generateKey(Constant.DB_EMPLOYEE);
			
			// insert employee
			employeeData.setEmployeeID(empId);
			result = employeeService.insertEmployee(employeeData);
			
			// insert employeeMonthlyUpdate
			for (EmployeeMonthlyUpdate employeeMonthlyUpdate : monthly) {
				if(employeeMonthlyUpdate.getHasWorkableHour().equalsIgnoreCase("N")){
					employeeMonthlyUpdate.setWorkableHour(0);
				}else{
					employeeMonthlyUpdate.setWorkableHour(this.getAVGTotalWorkableHour(employeeMonthlyUpdate));
				}
				employeeMonthlyUpdate.setEmployeeID(empId);
				employeeMonthlyUpdate.setEmployeeMonthlyUpdateID(empId +"-" + employeeMonthlyUpdate.getYear() +'-'+ employeeMonthlyUpdate.getMonth());
				result = employeeService.insertEmployeeMonthlyUpdate(employeeMonthlyUpdate);
			}
			
			// insert employeeYearlyUpdate
			for (EmployeeYearlyUpdate employeeYearlyUpdate : yearly) {
				employeeYearlyUpdate.setEmployeeID(empId);
				employeeYearlyUpdate.setEmployeeYearlyUpdateID(empId +"-" + employeeYearlyUpdate.getYear());
				result = employeeService.insertEmployeeYearlyUpdate(employeeYearlyUpdate);
			}
			
		} else {
			
			empId = employeeData.getEmployeeID();
			Employee emp = this.getEmployeeByPK(empId);
			
			Date enrolledDate = emp.getEnrolledDate();
			Date newEnrolledDate = employeeData.getEffectiveDate();
			
			boolean isExist = false;
			
			if(newEnrolledDate.before(enrolledDate)){  // enrolledDate = 2015-07-01 , newEnrolledDate = 2014-09-01
				// Add month to table EmployeeMonthlyUpdate
				for (EmployeeMonthlyUpdate newEmpMonthlyUpdate  : monthly ) {
					int newEmpMonth = Integer.parseInt(newEmpMonthlyUpdate.getMonth());
					int newEmpMonthlyYear = newEmpMonthlyUpdate.getYear();
					for (EmployeeMonthlyUpdate empMonthlyUpdate : emp.getMonthly() ) {
						int empMonth = Integer.parseInt(empMonthlyUpdate.getMonth());
						int empMonthlyYear = empMonthlyUpdate.getYear();
						
						if((empMonthlyYear == newEmpMonthlyYear) && (empMonth == newEmpMonth)){
							isExist = true;
							break;
						}else{
							isExist = false;
						}
					}
					if(!isExist){
						newEmpMonthlyUpdate.setEmployeeID(empId);
						newEmpMonthlyUpdate.setEmployeeMonthlyUpdateID(empId +"-" + newEmpMonthlyYear +'-'+ newEmpMonthlyUpdate.getMonth());
						result = employeeService.insertEmployeeMonthlyUpdate(newEmpMonthlyUpdate);
					}
				}
				
				// add data to EmployeeYearlyUpdate
				for (EmployeeYearlyUpdate newEmpYearlyUpdate  : yearly ) {
					for (EmployeeYearlyUpdate empYearlyUpdate : emp.getYearly() ) {
						if(empYearlyUpdate.getYear() == newEmpYearlyUpdate.getYear()){
							isExist = true;
							break;
						}else{
							isExist = false;
						}
					}
					if(!isExist){
						// insert data to EmployeeYearlyUpdate
						newEmpYearlyUpdate.setEmployeeID(empId);
						newEmpYearlyUpdate.setEmployeeYearlyUpdateID(empId +"-" + newEmpYearlyUpdate.getYear());
						result = employeeService.insertEmployeeYearlyUpdate(newEmpYearlyUpdate);
					}
				}
				
			}else if(newEnrolledDate.after(enrolledDate)){ // enrolledDate = 2014-04-01 , newEnrolledDate = 2015-05-01
				
				// delete month in table EmployeeMonthlyUpdate
				for (EmployeeMonthlyUpdate empMonthlyUpdate : emp.getMonthly()) {
					for (EmployeeMonthlyUpdate newEmpMonthlyUpdate : monthly) {
						
						int empMonth = Integer.parseInt(empMonthlyUpdate.getMonth());
						int newEmpMonth = Integer.parseInt(newEmpMonthlyUpdate.getMonth());
						int empMonthlyYear = empMonthlyUpdate.getYear();
						int newEmpMonthlyYear = newEmpMonthlyUpdate.getYear();
						
						if((empMonthlyYear == newEmpMonthlyYear) && (empMonth>=newEmpMonth) ){
							isExist = true;
							break;
						}else{
							isExist = false;
						}
					}
					if(!isExist){
						// delete less month of empMonthlyUpdate
						result = employeeService.deleteEmployeeMonthlyUpdateMonthYear(empMonthlyUpdate);
					}
				}
				
				// delete data to EmployeeYearlyUpdate
				for (EmployeeYearlyUpdate empYearlyUpdate : emp.getYearly()) {
					for (EmployeeYearlyUpdate newEmpYearlyUpdate : yearly) {
						if(empYearlyUpdate.getYear() == newEmpYearlyUpdate.getYear()){
							isExist = true;
							break;
						}else{
							isExist = false;
						}
					} 
					if(!isExist){
						// Delete EmployeeYearlyUpdate
						employeeService.deleteEmployeeYearlyUpdate(empYearlyUpdate);
					}
				}	
			}
			
			// Update Table Employee set  enrolledDate = newEnrolledDate WHERE employeeID = empId;
			employeeService.updateEmployee(employeeData);
		}

		if (result) {
			logger.debug("Update employee : {}", employeeData);
			MasterData masterData = new MasterData();
			masterData.setData("employee");
			masterData.setYear(DateUtils.getCurrentYear());
			masterDataService.save(masterData);

			logger.debug("update in Master Data: {} ", masterData);
			return true;
		} else {
			logger.error("Failed update employee in masterData: {}", employeeData);
			return false;
		}
	}
	
	@RequestMapping(value = "/updateEmployee", method = RequestMethod.PUT)
	@ResponseBody
	public Boolean updateEmployee(@RequestBody EmployeeVO employeeData) {
		boolean result = false;
		List<EmployeeMonthlyUpdate> monthly = employeeData.getMonthly();
		List<EmployeeYearlyUpdate> yearly = employeeData.getYearly();
		
		result = employeeService.updateEmployeeData(employeeData);
		
		for (EmployeeMonthlyUpdate employeeMonthlyUpdate : monthly) {
			result = employeeService.updateEmployeeMonthlyUpdate(employeeMonthlyUpdate);
		}
		for (EmployeeYearlyUpdate employeeYearlyUpdate : yearly) {
			result = employeeService.updateEmployeeYearlyUpdate(employeeYearlyUpdate);
		}
		if (result) {
			logger.debug("Update employee : {}", employeeData);
			MasterData masterData = new MasterData();
			masterData.setData("employee");
			masterData.setYear(DateUtils.getCurrentYear());
			masterDataService.save(masterData);

			logger.debug("update in Master Data: {} ", masterData);
			return true;
		} else {
			logger.error("Failed update employee in masterData: {}", employeeData);
			return false;
		}
	}
	
	@RequestMapping(value = "/changeRole", method = RequestMethod.POST)
	@ResponseBody
	public Boolean changeRole(@ModelAttribute Employee employee) {
		return employeeService.updateEmployeeRole(employee);
	}

	@RequestMapping(value = "/resetPwd/{employeeID}")
	@ResponseBody
	public Boolean resetPwd(@PathVariable("employeeID") String employeeID) {
		return employeeService.resetPassword(employeeID);
	}

	/*
	 * @RequestMapping(value = "/delete/{employeeID}", method =
	 * RequestMethod.DELETE)
	 * 
	 * @ResponseBody public Boolean deleteEmployee(@PathVariable("employeeID")
	 * String employeeID){ boolean result =
	 * employeeService.deleteEmployee(employeeID); if (result) { MasterData
	 * masterData = new MasterData();
	 * //masterData.setMasterDataID("MAD0000002");
	 * masterData.setData("employee");
	 * masterData.setYear(DateUtils.getCurrentYear());
	 * masterDataService.save(masterData);
	 * 
	 * logger.debug("update in Master Data: {} ", masterData); } else {
	 * logger.error("Failed update employee in masterData"); } return result; }
	 */

	@RequestMapping(value = "/deactive/{employeeID}/{deactiveType}", method = RequestMethod.PUT)
	@ResponseBody
	public Boolean deactivateByEmployeeID(
			@PathVariable("employeeID") String employeeID,
			@PathVariable("deactiveType") String deactiveType,
			@RequestBody Employee employee) {
		boolean result;
		employee.setLastModifiedBy(WebUtils.getSessionUserId());

		if (deactiveType.equalsIgnoreCase("deactivate")) {
			result = employeeService.deactivateByEmployeeID(employee);
			logger.debug("deactive : {} ", result);
		} else if (deactiveType.equalsIgnoreCase("retire")) {
			result = employeeService.retireByEmployeeID(employee);
			logger.debug("retire : {} ", result);
		} else {
			result = employeeService.reviveByEmployeeID(employee);
			logger.debug("revive : {} ", result);
		}
		return result;
	}

	/*@RequestMapping(value = "/check/{param}", method = RequestMethod.POST)
	@ResponseBody
	public Boolean checkEmployee(@PathVariable("param") String param,
			@ModelAttribute Employee employee) {

		if (param.equalsIgnoreCase("")) {
			return !employeeService.isExistName(employee);
		} else if (param.equalsIgnoreCase("email")) {
			return !employeeService.isExistEmail(employee);
		}
		return false;
	}*/
	
	/**
	 * Check if not valid employee
	 * @param employee
	 * @return
	 */
	@RequestMapping(value = "/check/{param}", method = RequestMethod.POST)
	@ResponseBody
	public Boolean checkEmployee(@PathVariable("param") String param, @ModelAttribute("Employee") Employee employee){
		
		if(param.equalsIgnoreCase("employeeName")){
			return !employeeService.isExistName(employee);
		} else if (param.equalsIgnoreCase("email")) {
			return !employeeService.isExistEmail(employee);
		}
		return false;
		
	}

	@RequestMapping(value = "/{orgID}/getEmployeeByOrgID")
	@ResponseBody
	public List<Employee> getEmployeeByOrgID(@PathVariable("orgID") String orgID) {
		List<Employee> employee = new ArrayList<Employee>();
		employee = employeeService.getEmployeeByOrgID(orgID);
		return employee;
	}

}
