/**
 * @author Chamroeun
 */
package com.mobilecnc.skills.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.helper.service.AbstractPagingService;
import com.mobilecnc.helper.service.PKService;
import com.mobilecnc.skills.Skill;

@Service
public class SkillService extends AbstractPagingService {

	@Autowired
	SkillDAO skillDAO;

	public List<Skill> getAllSkills() throws Exception {
		return skillDAO.getAllSkills();
	}
	
	public void insertSkill(Skill skill) throws Exception {
		skill.setSkillID(PKService.generateKey("Skills"));
		skillDAO.insertSkill(skill);
	}

	public void updateSkill(Skill skill) throws Exception{
		skillDAO.updateSkill(skill);
	}
	
	public void deleteSkill(String skillID) throws Exception{
		skillDAO.deleteSkill(skillID);
	}
	
	public Skill getSkill(String skillID) throws Exception{
		return skillDAO.getSkill(skillID);
	}
	
	public int checkExistName(Skill skill) throws Exception {
		return skillDAO.checkExistName(skill);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Skill> getPagingRecord(PagingCondition pagingCondition)
			throws Exception {
		return skillDAO.getPagingRecord(pagingCondition);
	}

	@Override
	public int getRecordCount(PagingCondition pagingCondition) throws Exception {
		return skillDAO.getRecordCount(pagingCondition);
	}

}
