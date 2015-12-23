package com.mobilecnc.unsubmitReasons.service;

import java.util.List;

import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.unsubmitReasons.UnsubmitReason;
/**
 * @author sambath kakda
 * @param unsubmitReason
 * @param model
 * @return
 */

public interface UnsubmitReasonDAO {
	
	public List<UnsubmitReason> getAllUnsubmitReasons() throws Exception;
	
	public UnsubmitReason getUnsubmitReason(String unsubmitReasonID) throws Exception;

	public void insertUnsubmitReason(UnsubmitReason unsubmitReason) throws Exception;

	public void updateUnsubmitReason(UnsubmitReason unsubmitReason) throws Exception;
	
	public List<UnsubmitReason> getPagingRecord(PagingCondition pagingCondition);
	public int getRecordCount(PagingCondition pagingCondition);
	public void deleteUnsubmitReason(String unsubmitReasonID) throws Exception;

	public int checkExisName(UnsubmitReason unsubmitReason) throws Exception;
	public List<UnsubmitReason> getUnsubmitReasonLists() throws Exception;
}
