package com.mobilecnc.unsubmitReasons.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.helper.service.AbstractPagingService;
import com.mobilecnc.helper.service.PKService;
import com.mobilecnc.unsubmitReasons.UnsubmitReason;

/**
 * @author sambath kakda
 * @param unsubmitReason
 * @param model
 * @return
 */

@Service
public class UnsubmitReasonService extends AbstractPagingService{
	@Autowired
	UnsubmitReasonDAO unsubmitReasonDAO;
	
	public List<UnsubmitReason> getAllUnsubmitReasons() throws Exception{
		return unsubmitReasonDAO.getAllUnsubmitReasons();
	}
	
	public UnsubmitReason getUnsubmitReason(String unsubmitReasonID) throws Exception{
		return unsubmitReasonDAO.getUnsubmitReason(unsubmitReasonID);
	}
	
	public void insertUnsubmitReason(UnsubmitReason unsubmitReason) throws Exception
	{
		unsubmitReason.setUnsubmitReasonID(PKService.generateKey("UnsubmitReasons"));
		 unsubmitReasonDAO.insertUnsubmitReason(unsubmitReason);
	}
	
	
	public void updateUnsubmitReason(UnsubmitReason unsubmitReason) throws Exception{
		unsubmitReasonDAO.updateUnsubmitReason(unsubmitReason);
	}


	@SuppressWarnings("unchecked")
	public List<UnsubmitReason> getPagingRecord(PagingCondition pagingCondition){
		return unsubmitReasonDAO.getPagingRecord(pagingCondition);
	}

	public int getRecordCount(PagingCondition pagingCondition){
		return unsubmitReasonDAO.getRecordCount(pagingCondition);		
	}
	
	public int checkExisName(UnsubmitReason unsubmitReason) throws Exception
	{
		return unsubmitReasonDAO.checkExisName(unsubmitReason);
	}
	

	public void deleteUnsubmitReason(String unsubmitReasonID) throws Exception
	{
		unsubmitReasonDAO.deleteUnsubmitReason(unsubmitReasonID);
	}

	public List<UnsubmitReason> getUnsubmitReasonLists() throws Exception{
		return unsubmitReasonDAO.getUnsubmitReasonLists();
	}
}
