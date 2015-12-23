package com.mobilecnc.customers.service;

import java.util.List;

import com.mobilecnc.customers.Customer;

public class CustomerVO extends Customer{

	List<CustomerVO> customerList;
	
	public List<CustomerVO> getCustomerList()
	{
		return customerList;
	}
	
	public void setCustomerList(List<CustomerVO> customerList)
	{
		this.customerList = customerList;
	}
	
}
