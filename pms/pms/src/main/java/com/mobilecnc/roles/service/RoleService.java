package com.mobilecnc.roles.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.helper.service.AbstractPagingService;
import com.mobilecnc.helper.service.PKService;
import com.mobilecnc.roles.Role;

@Service
public class RoleService extends AbstractPagingService{
	@Autowired
	RoleDAO roleDAO;
	
	
	public List<Role> selectRoleList() throws Exception{
		return roleDAO.selectRoleList(); 
	}
	
	public List<Role> getAllRoles() throws Exception {
		return roleDAO.getAllRoles();
	}
	
	public void insertRole(Role role,String addList,String removeList) throws Exception {
		role.setRoleID(PKService.generateKey("Roles"));
		roleDAO.insertRole(role);
		if(addList.isEmpty() && removeList.isEmpty()) return;
		roleDAO.insertRolePermssion(role.getRoleID(), addList, removeList);
	}

	public void updateRole(Role role,String addList,String removeList) throws Exception{
		roleDAO.updateRole(role);
		if(addList.isEmpty() && removeList.isEmpty()) return;
		roleDAO.insertRolePermssion(role.getRoleID(), addList, removeList);
	}
	
	public void deleteRole(String roleID) throws Exception{
		roleDAO.deleteRole(roleID);
	}
	
	public Role getRole(String roleID) throws Exception{
		return roleDAO.getRole(roleID);
	}
	
	public int checkExistName(Role role) throws Exception {
		return roleDAO.checkExistName(role);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Role> getPagingRecord(PagingCondition pagingCondition)
			throws Exception {
		return roleDAO.getPagingRecord(pagingCondition);
	}

	@Override
	public int getRecordCount(PagingCondition pagingCondition) throws Exception {
		return roleDAO.getRecordCount(pagingCondition);
	}
}
