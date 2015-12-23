package com.mobilecnc.teams.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.helper.service.AbstractPagingService;
import com.mobilecnc.helper.service.PKService;
import com.mobilecnc.teams.Team;
import com.mobilecnc.teams.TeamVO;

/**
 * 
 * @author sereysopheak.eap
 *
 */
@Service
public class TeamService extends AbstractPagingService {
	@Autowired
	TeamDAO teamDAO;
	
	public TeamVO getTeam(String teamID) throws Exception{
		return teamDAO.getTeam(teamID);
	}
	
	public void insertTeam(Team team) throws Exception{
		team.setTeamID(PKService.generateKey("Teams"));
		teamDAO.insertTeam(team);
	}
	
	public void updateTeam(Team team) throws Exception{
		teamDAO.updateTeam(team);
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public List<TeamVO> getPagingRecord(PagingCondition pagingCondition) throws Exception{
		return teamDAO.getPagingRecord(pagingCondition);
	}
	
	@Override
	public int getRecordCount(PagingCondition pagingCondition) throws Exception{
		return teamDAO.getRecordCount(pagingCondition);
	}
	
	public void deleteTeam(String teamID) throws Exception{
		teamDAO.deleteTeam(teamID);
	}
	
	public int checkExistName(Team team) throws Exception{
		return teamDAO.checkExistName(team);
	}
	public List<Team> selectTeamList() throws Exception{
		return teamDAO.selectTeamList();
	}
}
