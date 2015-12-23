package com.mobilecnc.teams.service;

import java.util.List;

import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.teams.Team;
import com.mobilecnc.teams.TeamVO;
/**
 * 
 * @author sereysopheak.eap
 *
 */
public interface TeamDAO{
	
	public TeamVO getTeam(String teamID) throws Exception;
	public void insertTeam(Team team) throws Exception;
	public void updateTeam(Team team) throws Exception;
	public List<TeamVO> getPagingRecord(PagingCondition pagingCondition) throws Exception;
	public int getRecordCount(PagingCondition pagingCondition) throws Exception;
	public void deleteTeam(String teamID) throws Exception;
	public int checkExistName(Team team) throws Exception;
	public List<Team> selectTeamList() throws Exception;
}
