package com.mobilecnc.security.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.helper.service.AbstractPagingService;
import com.mobilecnc.security.UserVO;

/**
 * 
 * @author sereysopheak.eap
 *
 */
@Service
public class UserService extends AbstractPagingService{
	
	@Autowired
	UserDAO userDAO;
	
	public UserVO getUser(String userName) throws Exception{
		return userDAO.getUser(userName);
	}
	
	public UserVO getUserByID(String userID) throws Exception{
		return userDAO.getUserByID(userID);
	}
	
	public void updateUser(UserVO userVO) throws Exception{
		userDAO.updateUser(userVO);
	}
	
	public void changePassword(UserVO userVO) throws Exception{
		userDAO.changePassword(userVO);
	}
	public List<UserVO> getUsers() throws Exception{
		return userDAO.getUsers();
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public List<UserVO> getPagingRecord(PagingCondition pagingCondition)
			throws Exception {
		return userDAO.getPagingRecord(pagingCondition);
	}

	@Override
	public int getRecordCount(PagingCondition pagingCondition) throws Exception {
		return userDAO.getRecordCount(pagingCondition);
	}
	public void updateUserStatus(String activeList, String inActiveList, String userID) throws Exception{
		userDAO.updateUserStatus(activeList, inActiveList,userID);
	}
}
