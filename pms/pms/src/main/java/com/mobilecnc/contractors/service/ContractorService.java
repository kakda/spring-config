package com.mobilecnc.contractors.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Service;

import com.mobilecnc.contractors.Contractor;
import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.helper.service.AbstractPagingService;
import com.mobilecnc.helper.service.PKService;
import com.mobilecnc.projects.Project;
import com.mobilecnc.skills.Skill;

@Service
public class ContractorService extends AbstractPagingService{
	
	@Autowired
	ContractorDAO contracterDAO;
	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Project> getPagingRecord(PagingCondition pagingCondition)
			throws Exception {
		return contracterDAO.getPagingRecord(pagingCondition);
	}

	@Override
	public int getRecordCount(PagingCondition pagingCondition) throws Exception {
		return contracterDAO.getRecordCount(pagingCondition);
	}
	public void deleteContractor(String employeeID) throws Exception{
		contracterDAO.deleteContractor(employeeID);
	}
	
	public void insertContractor(Contractor contractor) throws Exception{
		contractor.setEmployeeID(PKService.generateKey("Employees"));
		ShaPasswordEncoder pwdEnc = new ShaPasswordEncoder();
		contractor.setPassword(pwdEnc.encodePassword(contractor.getPassword(),contractor.getEmployeeID()));
		contracterDAO.insertContractor(contractor);
		contracterDAO.insertContractorHistory(contractor);
		contracterDAO.insertUser(contractor);
	}
	
	public void insertContractorSkill(Contractor contractor) throws Exception{
		contracterDAO.insertContractorSkill(contractor);
	}
	public List<ContractorVO> getSkill(ContractorVO contractorVO) throws Exception{
		return contracterDAO.getSkill(contractorVO);
	}
	public Contractor getEmployee(String employeeID) throws Exception{
		return contracterDAO.getEmployee(employeeID);
	}
	public void updateContractor(Contractor contractor,boolean isReEmploy) throws Exception{
		contracterDAO.updateContractor(contractor);
		if(isReEmploy)
			contracterDAO.insertContractorHistory(contractor);
		else
			contracterDAO.updateContractorHistory(contractor);
			
		contracterDAO.deleteContractorSkill(contractor);
	}
	
	public Contractor getPassword(Contractor contractor) throws Exception{
		return contracterDAO.getPassword(contractor);
	}
	
	/**
	 * @author Chamroeun
	 * @param employeeID
	 * @return
	 * @throws Exception
	 */
	
	public List<Skill> getEmployeeSkills(String employeeID) throws Exception{
		return contracterDAO.getEmployeeSkills(employeeID);
	}
}
