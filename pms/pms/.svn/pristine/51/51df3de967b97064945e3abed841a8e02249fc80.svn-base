package com.mobilecnc.companies.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobilecnc.companies.Company;
import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.helper.service.AbstractPagingService;
import com.mobilecnc.helper.service.PKService;

@Service
public class CompanyService extends AbstractPagingService{
	@Autowired
	CompanyDAO companyDAO;
	
	public List<Company> selectCompanyList() throws Exception{
		return companyDAO.selectCompanyList();
	}
	
	public void insertCompany(Company company) throws Exception{
		company.setCompanyID(PKService.generateKey("Companies"));
		companyDAO.insertCompany(company);
	}
	
	public void updateCompany(Company company) throws Exception{
		companyDAO.updateCompany(company);
	}
	
	public void deleteCompany(String companyID) throws Exception{
		companyDAO.deleteCompany(companyID);
	}
	
	public Company getCompany(String companyID) throws Exception{
		return companyDAO.getCompany(companyID);
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public List<Company> getPagingRecord(PagingCondition pagingCondition)
			throws Exception {
		return companyDAO.getPagingRecord(pagingCondition);
	}

	@Override
	public int getRecordCount(PagingCondition pagingCondition) throws Exception {
		return companyDAO.getRecordCount(pagingCondition);
	}
}
