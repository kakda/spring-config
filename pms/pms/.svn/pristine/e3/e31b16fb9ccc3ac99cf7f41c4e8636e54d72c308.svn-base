package com.mobilecnc.employees.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mobilecnc.contractors.service.ContractorService;
import com.mobilecnc.employees.ADUser;
import com.mobilecnc.employees.Employee;
import com.mobilecnc.employees.SearchEmployeeExcel;
import com.mobilecnc.employees.service.ADService;
import com.mobilecnc.employees.service.EmployeeService;
import com.mobilecnc.employees.service.EmployeeVO;
import com.mobilecnc.exception.GenericException;
import com.mobilecnc.helper.BaseController;
import com.mobilecnc.helper.Message;
import com.mobilecnc.helper.Paging;
import com.mobilecnc.helper.report.DownloadService;
import com.mobilecnc.skills.Skill;

@Controller
@RequestMapping(value = "/employees")
public class EmployeeController extends BaseController{

	@Autowired 
	EmployeeService employeeService;
	
	@Autowired
	ADService adService;

	@RequestMapping("/selectEmployeeList")
	public String selectEmployeeList(ModelMap model, @ModelAttribute("employeeVO") EmployeeVO employeeVO, HttpServletRequest request, @RequestParam(defaultValue = "247px", value="width") String width) throws Exception {
		employeeVO.setRoleID(request.getParameter("roleID"));
		employeeVO.setType(request.getParameter("type"));
		model.addAttribute("employeeList", employeeService.selectEmployeeList(employeeVO));
		model.addAttribute("id", request.getParameter("id"));
		model.addAttribute("placeholder", request.getParameter("placeholder"));
		model.addAttribute("finished", request.getParameter("finished"));
		model.addAttribute("require", request.getParameter("require"));
		model.addAttribute("width", width);
		String multiple = "";
		if(request.getParameter("multiple") != null && request.getParameter("multiple").equalsIgnoreCase("true"))
		{
			multiple = "multiple";
		}
		model.addAttribute("multiple", multiple);
		model.addAttribute("validate", request.getParameter("validate"));
		return "employees/selectEmployeeList";
	}
	@RequestMapping("/add")
	public String add(ModelMap model,HttpSession session) {
		
		model.addAttribute("message", session.getAttribute("message"));
		session.setAttribute("message", null);
		
		model.addAttribute("page", "employees/add");

		return "layout/main";
	}
	
	@RequestMapping("/doAdd")
	public String doAdd(ModelMap model, @ModelAttribute("Employee") Employee employee,@ModelAttribute("Message") Message message,HttpSession session, HttpServletRequest request)
			throws Exception {
		employee.setEntryBy((String)session.getAttribute("user"));
		employee.setLastModifyBy((String)session.getAttribute("user"));
		employee.setType("employee");
		employee.setCompanyID(null);
		
		employee.setActiveUser(employee.setActive(true)?1:0);
		employeeService.insertemployee(employee);
		String[] skillID = request.getParameterValues("skillID");
		if(skillID!=null){
			for(int i=0; i<skillID.length; i++)
			{
				employee.setSkillID(skillID[i]);
				employeeService.insertEmployeeSkill(employee);
			}
		}
		message.setSaveSuccess();
		session.setAttribute("message", message);
		if(request.getParameter("save").equalsIgnoreCase("save")){
			return "redirect:/employees/add.html";			
		}else{
			return "redirect:/employees/index.html";	
		}
	}
	
	@RequestMapping("/index")
	public String index(ModelMap model){
		model.addAttribute("page", "employees/index");
		return "layout/main";
	}
	
	@RequestMapping(value = "/ajaxGrid", method = RequestMethod.GET)
	public @ResponseBody
	Paging<Employee> ajaxGrid(HttpServletRequest request, ModelMap model)
			throws Exception {
		return employeeService.getTotalRecords(request);

	}
	
	@RequestMapping(value="/doDelete/{employeeID}", method = RequestMethod.POST)
	public String doDelete(@PathVariable String employeeID, ModelMap model)
			throws Exception {
		employeeService.deleteEmployee(employeeID);
		model.addAttribute("result", "true");
		return "cmm/resultType";
	}
	
	@RequestMapping("/update/{employeeID}")
	public String update(@PathVariable String employeeID, @ModelAttribute EmployeeVO employeeVO, ModelMap model) throws Exception{
		Employee employee = employeeService.getEmployee(employeeID);
		if(employee==null)
		{ 	logger.debug("Provided ID is not the employee");
			throw new GenericException("Employee's not found.");
		}
		model.addAttribute("employee", employee);
		employeeVO.setEmployeeID(employeeID);
		model.addAttribute("skill", employeeService.getSkill(employeeVO));
		model.addAttribute("page", "employees/update");
		return "layout/main";
	}
	
	@RequestMapping("/doUpdate")
	public String doUpdate(@ModelAttribute Employee employee,@ModelAttribute("Message") Message message, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception{
		employee.setLastModifyBy((String)session.getAttribute("user"));
		employee.setType("employee");
		employee.setCompanyID("CPN0001");
		employeeService.updateEmployee(employee);
		String[] skillID = request.getParameterValues("skillID");
		if(skillID!=null){
			for(int i=0; i<skillID.length; i++)
			{
				employee.setSkillID(skillID[i]);
				employeeService.insertEmployeeSkill(employee);
			}
		}
		message.setUpdateSuccess();
		session.setAttribute("message", message);
		
		return "redirect:/employees/index.html";
	}
	public boolean found(List<EmployeeVO> lst, String username){
		
		for(EmployeeVO e:lst){
			if(e.getUserName().equalsIgnoreCase(username))
				return true;
		}
		return false;
	}
	@RequestMapping("aduser")
	public String aduser(ModelMap model, @ModelAttribute("employeeVO") EmployeeVO employeeVO,HttpServletRequest request, @RequestParam(defaultValue = "247px", value="width") String width) throws Exception{
		
		List<EmployeeVO> username = employeeService.getUser(employeeVO);
		List<ADUser> aduserList = adService.getAllUsers();
		List<ADUser> adList=new ArrayList<ADUser>();
		for(ADUser user:aduserList){
			if(!found(username,user.getLogin()))
				adList.add(user);
		}
		
		model.addAttribute("aduserList",adList);
		model.addAttribute("id",request.getParameter("id"));
		model.addAttribute("placeholder", request.getParameter("placeholder"));
		model.addAttribute("width", width);
		String multiple = "";
		if(request.getParameter("multiple") != null && request.getParameter("multiple").equalsIgnoreCase("true"))
		{
			multiple = "multiple";
		}
		model.addAttribute("multiple", multiple);
		return "employees/adUserList";
	}
	
	@RequestMapping("/ajaxCheckUser")
	public @ResponseBody
	String ajaxCheckEmployee(@ModelAttribute("Employee") Employee employee, ModelMap model, HttpServletRequest request) throws Exception {
		employee.setUserName(request.getParameter("fieldValue"));
		
		String EmployeeID = "";
		if(request.getParameter("employeeID") != null)
		{
			EmployeeID = request.getParameter("employeeID");
		}
		employee.setEmployeeID(EmployeeID);
		
		int cnt = employeeService.checkExisName(employee);
		String test = "";
		if (cnt > 0) {
			test = "false";
		} else {
			test = "true";
		}
		return "[\"" + request.getParameter("fieldId") + "\"," + test + "]";
	}

	/**
	 * @author Chamroeun
	 * @param model
	 * @param employeeID
	 * @return
	 * @throws Exception
	 */
	
	@Autowired
	ContractorService contractorService;
	
	@RequestMapping("/view/{employeeID}")
	public String view(ModelMap model, @PathVariable String employeeID) throws Exception{
		Employee employee = employeeService.getEmployee(employeeID);
		if(employee==null)
		{ 	logger.debug("Invalid ID");
			throw new GenericException("Employee's not found.");
		}
		List<Skill> skillList = contractorService.getEmployeeSkills(employeeID);
		model.addAttribute("employee", employee);
		model.addAttribute("skillList", skillList);
		model.addAttribute("page", "employees/view");
		return "layout/main";
	}
	
	@RequestMapping("/selectEmployeeYear")
	public String projectYear(ModelMap model, @ModelAttribute("employeeVO") EmployeeVO employeeVO, HttpServletRequest request) throws Exception {
		employeeVO.setEmployeeList(employeeService.selectEmployeeYear());
		model.addAttribute("id", request.getParameter("id"));
		model.addAttribute("placeholder", request.getParameter("placeholder"));
		model.addAttribute("width", request.getParameter("width"));
		model.addAttribute("employeeList", employeeVO.getEmployeeList());
		return "employees/selectEmployeeYear";
	}
	
	@RequestMapping(value = "/ajaxReportGrid", method = RequestMethod.GET)
	public @ResponseBody
	Paging<Employee> ajaxReportGrid(HttpServletRequest request, ModelMap model)
			throws Exception {
		return employeeService.getTotalReportRecords(request);

	}
	
	@RequestMapping("/report")
	public String report(ModelMap model){
		model.addAttribute("page", "employees/report");
		return "layout/main";
	}
	
	@Autowired
	DownloadService downloadService;
	
	@RequestMapping(value="/reports/download")
	public void download(@RequestParam String type,
			@RequestParam String token,
			HttpServletResponse response,
			@RequestParam String p,	
			@RequestParam String y, 
			@RequestParam String s,
			@RequestParam String pn,
			@RequestParam String sn
			) throws SQLException, JSONException {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		String where = "";
		
		if(p!=null)
		{
			String aval = p.trim();
			where += " WHERE (projectIDs LIKE '%"+ aval +"%')";
			params.put("fltProjectName",pn);
		}
		
		if(y!=null)
		{
			String val1 = "'" + y.trim() + "'";
			where += (where.isEmpty()?" WHERE":" AND") + " ((YEAR(joinDate) <= "+ val1 +") AND (YEAR(quitDate) >= "+ val1 +") OR (YEAR(joinDate) <= "+ val1 +") AND (quitDate IS NULL))";
			params.put("fltEmployeeYear",y);
		}
		
		if(s!=null)
		{
			s = s.replace(',', '%');
			where += (where.isEmpty()?" WHERE":" AND") +  " (skillIDs LIKE '%" + s + "%')";
			params.put("fltSkillNames",sn);
		}
		
		/*JSONObject project = p;
		if(project.length() > 0){
			String pk = (String)project.keys().next();
			params.put("fltProjectID", project.getString(pk));
			where = " WHERE (projectID = '"+pk+"')";
		}
		
		if(!y.isEmpty()){
			params.put("fltYear", y);
			where += (where.isEmpty()?" WHERE":" AND") +  " (DATEPART(year, actualStartDate) = "+y+")";
		}
		
		JSONObject skills = s;
		Iterator skillIDs = skills.keys();

		if(skills.length() > 0){
			String skill_txt = "", skill_cond = "";
			String sk = (String)skillIDs.next();
			skill_txt = skills.getString(sk);
			where += (where.isEmpty()?" WHERE":" AND") + " (skillID = '"+sk+"'";
			while(skillIDs.hasNext())
			{
				sk = (String)skillIDs.next();
				skill_txt += ", "+skills.getString(sk);
				where += " OR skillID = '"+sk+"'";
			}
			where +=") GROUP BY employeeID, employeeName, type, companyName, titleName, grade, email, mobilePhone, joinDateOnly HAVING (COUNT(*) = "+skills.length()+")";
			
			params.put("fltSkillID", skill_txt);
		}*/
		
		params.put("where", where);
		
		downloadService.download(type, token, response,"/mobilecnc/reports/employees" + (type.equals("xls")?"_xls":"") +".jrxml",params);
	}
	
	
	
	
	@RequestMapping(value="/reports/downloadEmployeeExcel")
	public ModelAndView employeeExcelDown(HttpServletRequest request, @ModelAttribute SearchEmployeeExcel searchEmployeeExcel) throws Exception{
		ModelAndView map = new ModelAndView("reportEmployeeExcelView");
		
		List<EmployeeVO> employeeList = employeeService.getTotalReport(searchEmployeeExcel);
		map.addObject("EmployeeList",employeeList);
		map.addObject("searchEmployeeExcel",searchEmployeeExcel);
		return map;
		
	} 
	
	@RequestMapping(value="/reports/downloadEmployeePdf")
	public ModelAndView employeePdfDown(HttpServletRequest request,@ModelAttribute SearchEmployeeExcel searchEmployee) throws Exception{
		ModelAndView map= new ModelAndView("reportEmployeePDFView");
		
		map.addObject("EmployeeList",employeeService.getTotalReport(searchEmployee));
		map.addObject("searchEmployee",searchEmployee);
	
		return map;
	}
	


}
