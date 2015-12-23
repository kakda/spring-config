package com.mobilecnc.titles.service;

import java.util.List;

import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.titles.Title;


public interface TitleDAO {
	
	public List<Title> getAllTitles() throws Exception;
	
	/**
	 * @author sereysopheak.eap
	 * @param titleID
	 * @return
	 */
	public Title getTitle(String titleID) throws Exception;
	
	/**
	 * @author sereysopheak.eap
	 * @return
	 * @throws Exception
	 */
	public List<Title> selectTitleList() throws Exception;
	
	/**
	 * @author Rin Rady
	 * @param title
	 * @return
	 * @throws Exception
	 */
	public void insertTitle(Title title) throws Exception;
	
	/**
	 * @author sambath kakda
	 * @param title
	 * @return
	 */
	public void updateTitle(Title title) throws Exception;
	
	public List<Title> getPagingRecord(PagingCondition pagingCondition);
	public int getRecordCount(PagingCondition pagingCondition);
	public void deleteTitle(String titleID);
	
	/**
	 * @author Rin Rady
	 * @param titleName
	 * @return
	 * @throws Exception
	 */
	public int checkExisName(Title title) throws Exception;
}
