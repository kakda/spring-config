/**
 * @author Chamroeun
 */
package com.mobilecnc.customers.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobilecnc.customers.Customer;
import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.helper.service.AbstractPagingService;
import com.mobilecnc.helper.service.PKService;

@Service
public class CustomerService extends AbstractPagingService {

	@Autowired
	CustomerDAO customerDAO;
	
	public List<Customer> getAllCustomers() throws Exception{
		return customerDAO.getAllCustomers();
	}
	
	public void insertCustomer(Customer customer) throws Exception{
		customer.setCustomerID(PKService.generateKey("Customers"));
		customerDAO.insertCustomer(customer);
	}
	
	public void updateCustomer(Customer customer) throws Exception{
		customerDAO.updateCustomer(customer);
	}
	
	public void deleteCustomer(String customerID) throws Exception{
		customerDAO.deleteCustomer(customerID);
	}
	
	public Customer getCustomer(String customerID) throws Exception{
		return customerDAO.getCustomer(customerID);
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public List<Customer> getPagingRecord(PagingCondition pagingCondition)
			throws Exception {
		return customerDAO.getPagingRecord(pagingCondition);
	}

	@Override
	public int getRecordCount(PagingCondition pagingCondition) throws Exception {
		return customerDAO.getRecordCount(pagingCondition);
	}
	
	public List<CustomerVO> selectCustomerList(CustomerVO customerVO) throws Exception
	{
		return customerDAO.selectCustomerList(customerVO);
	}
}
