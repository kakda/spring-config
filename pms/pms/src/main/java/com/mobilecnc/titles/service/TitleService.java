package com.mobilecnc.titles.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.helper.service.AbstractPagingService;
import com.mobilecnc.helper.service.PKService;
import com.mobilecnc.titles.Title;

@Service
public class TitleService extends AbstractPagingService{
	@Autowired
	TitleDAO titleDAO;
	
	public List<Title> getAllTitles() throws Exception{
		return titleDAO.getAllTitles();
	}
	
	/**
	 * @author sereysopheak.eap
	 * @param titleID
	 * @return
	 */
	public Title getTitle(String titleID) throws Exception{
		return titleDAO.getTitle(titleID);
	}
	/**
	 * @author sereysopheak.eap
	 * @return
	 * @throws Exception
	 */
	public List<Title> selectTitleList() throws Exception{
		return titleDAO.selectTitleList();
	}
	
	/**
	 * @author Rin Rady
	 * @param title
	 * @return
	 * @throws Exception
	 */
	public void insertTitle(Title title) throws Exception
	{
		title.setTitleID(PKService.generateKey("Titles"));
		 titleDAO.insertTitle(title);
	}
	
	
	public void updateTitle(Title title) throws Exception{
		titleDAO.updateTitle(title);
	}


	@SuppressWarnings("unchecked")
	public List<Title> getPagingRecord(PagingCondition pagingCondition){
		pagingCondition.setWhere(" 1=1 "+pagingCondition.getWhere()) ;
		return titleDAO.getPagingRecord(pagingCondition);
	}

	public int getRecordCount(PagingCondition pagingCondition){
		return titleDAO.getRecordCount(pagingCondition);		
	}
	
	/**
	 * @author Rin Rady
	 * @param titleName
	 * @return
	 * @throws Exception 
	 */
	public int checkExisName(Title title) throws Exception
	{
		return titleDAO.checkExisName(title);
	}
	

	public void deleteTitle(String titleID)
	{
		titleDAO.deleteTitle(titleID);
	}

}
