package com.mobilecnc.redmine;

import java.util.Iterator;
import java.util.List;

import org.redmine.ta.RedmineManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobilecnc.helper.service.PropertiesService;
import com.mobilecnc.redmine.service.RepositoryService;

@Service
public class RedmineService {

	@Autowired
	static
	RepositoryService repositoryService;
	
	public void createRedmineRepository(String redmineName, String indentifier) {
		if(redmineName != null && !redmineName.equals(""))
		{	
			RedmineConfig redmineConfig = new RedmineConfig();
			RedmineManager mgr = new RedmineManager(redmineConfig.getURI(),	redmineConfig.getApiKey());
			try {
				org.redmine.ta.beans.Project project = new org.redmine.ta.beans.Project();
				project.setName(redmineName);
				project.setDescription(redmineName);
				project.setIdentifier(indentifier);
				project.setHomepage(PropertiesService.getProperty("redmine.uri"));
				mgr.createProject(project);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	
	}
	
	public  static void main(String[] args) {
		String t = "";
		try{
			
		
		List<Repository> list = repositoryService.getAllRepository();
		Iterator<Repository> iter = list.iterator();
		while(iter.hasNext())
		{
			System.out.println(iter.next());
		}
		}catch(Exception e)
		{
			System.err.println(e.getMessage());
		}
	}

}