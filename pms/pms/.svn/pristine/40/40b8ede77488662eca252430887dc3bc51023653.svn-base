package com.mobilecnc.contractors.service;

import java.util.List;

import com.mobilecnc.contractors.Contractor;
import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.projects.Project;
import com.mobilecnc.skills.Skill;

public interface ContractorDAO {
	

	public List<Project> getPagingRecord(PagingCondition pagingCondition) throws Exception;
	public int getRecordCount(PagingCondition pagingCondition) throws Exception;
	public void deleteContractor(String employeeID) throws Exception;
	public void insertContractor(Contractor contractor) throws Exception;
	public void insertContractorHistory(Contractor contractor) throws Exception;
	public void insertUser(Contractor contractor) throws Exception;
	public void insertContractorSkill(Contractor contractor) throws Exception;
	public List<ContractorVO> getSkill(ContractorVO contractorVO) throws Exception;
	public Contractor getEmployee(String employeeID) throws Exception;
	public void updateContractor(Contractor contractor) throws Exception;
	public void updateContractorHistory(Contractor contractor) throws Exception;
	public void deleteContractorSkill(Contractor contractor) throws Exception;
	public Contractor getPassword(Contractor contractor) throws Exception;
	
	/**
	 * @author Chamroeun
	 * @param employeeID
	 * @return
	 * @throws Exception
	 */
	
	public List<Skill> getEmployeeSkills(String employeeID) throws Exception;
}
