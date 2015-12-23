package com.mobilecnc.companies.service;

import java.util.List;

import com.mobilecnc.companies.Company;
import com.mobilecnc.helper.PagingCondition;

public interface CompanyDAO {
	
	List<Company> selectCompanyList() throws Exception;
	
	public void insertCompany(Company company) throws Exception;
	
	public void updateCompany(Company company) throws Exception;
	
	public void deleteCompany(String companyID) throws Exception;
	
	public Company getCompany(String companyID) throws Exception;
	
	public List<Company> getPagingRecord(PagingCondition pagingCondition);
	
	public int getRecordCount(PagingCondition pagingCondition);

}
