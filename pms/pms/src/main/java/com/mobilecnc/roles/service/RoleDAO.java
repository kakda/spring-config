package com.mobilecnc.roles.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.roles.Role;

/**
 * 
 * @author sereysopheak.eap
 *
 */
public interface RoleDAO {
	public List<Role> selectRoleList() throws Exception;
	
	public List<Role> getAllRoles() throws Exception;

	public void insertRole(Role role) throws Exception;

	public void updateRole(Role role) throws Exception;

	public void deleteRole(String roleID) throws Exception;

	public Role getRole(String roleID) throws Exception;

	public int checkExistName(Role role) throws Exception;
	
	public List<Role> getPagingRecord(PagingCondition pagingCondition);

	public int getRecordCount(PagingCondition pagingCondition);
	
	public void insertRolePermssion(@Param("roleID")String roleID,@Param("addList")String addList,@Param("removeList")String removeList);
}
