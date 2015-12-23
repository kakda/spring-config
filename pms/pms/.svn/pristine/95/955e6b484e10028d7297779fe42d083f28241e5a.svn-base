package com.mobilecnc.security.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.security.UserVO;

/**
 * 
 * @author sereysopheak.eap
 *
 */
public interface UserDAO {
	
	public UserVO getUser(String userName) throws Exception;
	
	public UserVO getUserByID(String userID) throws Exception;
	
	public void updateUser(UserVO userVO) throws Exception;
	
	public void changePassword(UserVO userVO) throws Exception;
	
	public List<UserVO> getUsers() throws Exception;
	
	public List<UserVO> getPagingRecord(PagingCondition pagingCondition) throws Exception;

	public int getRecordCount(PagingCondition pagingCondition) throws Exception;
	
	public void updateUserStatus(@Param("activeList") String activeList, @Param("inActiveList") String inActiveList, @Param("userID") String userID) throws Exception;

}
