/**
 * @author Chamroeun
 */
package com.mobilecnc.customers.service;

import java.util.List;

import com.mobilecnc.customers.Customer;
import com.mobilecnc.helper.PagingCondition;

public interface CustomerDAO {

	public List<Customer> getAllCustomers() throws Exception;
	public void insertCustomer(Customer customer) throws Exception;
	public void updateCustomer(Customer customer) throws Exception;
	public void deleteCustomer(String customerID) throws Exception;
	public Customer getCustomer(String customerID) throws Exception;
	public List<Customer> getPagingRecord(PagingCondition pagingCondition);
	public int getRecordCount(PagingCondition pagingCondition);
	public List<CustomerVO> selectCustomerList(CustomerVO customerVO) throws Exception;
	
}
