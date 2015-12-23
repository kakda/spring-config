/**
 * @author Chamroeun
 */
package com.mobilecnc.skills.service;

import java.util.List;

import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.skills.Skill;

public interface SkillDAO {

	public List<Skill> getAllSkills() throws Exception;

	public void insertSkill(Skill skill) throws Exception;

	public void updateSkill(Skill skill) throws Exception;

	public void deleteSkill(String skillID) throws Exception;

	public Skill getSkill(String skillID) throws Exception;

	public int checkExistName(Skill skill) throws Exception;
	
	public List<Skill> getPagingRecord(PagingCondition pagingCondition);

	public int getRecordCount(PagingCondition pagingCondition);

}
