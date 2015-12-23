package com.mobilecnc.helper.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Service;
import org.tmatesoft.svn.core.SVNCommitInfo;
import org.tmatesoft.svn.core.SVNDirEntry;
import org.tmatesoft.svn.core.SVNException;
import org.tmatesoft.svn.core.SVNNodeKind;
import org.tmatesoft.svn.core.SVNURL;
import org.tmatesoft.svn.core.auth.ISVNAuthenticationManager;
import org.tmatesoft.svn.core.internal.io.dav.DAVRepositoryFactory;
import org.tmatesoft.svn.core.internal.io.fs.FSRepositoryFactory;
import org.tmatesoft.svn.core.internal.io.svn.SVNRepositoryFactoryImpl;
import org.tmatesoft.svn.core.io.ISVNEditor;
import org.tmatesoft.svn.core.io.SVNRepository;
import org.tmatesoft.svn.core.io.SVNRepositoryFactory;
import org.tmatesoft.svn.core.wc.SVNWCUtil;

@Service
public class SVNService {
	

	/**
	 * Rin Rady
	 */
	
	public static List<String> getProjectsName() {
        /*
         * default values:
         */
		String url = PropertiesService.getProperty("SVN.url");
		String name = PropertiesService.getProperty("SVN.username");
        String password = PropertiesService.getProperty("SVN.password");

        /*
         * initializes the library (it must be done before ever using the
         * library itself)
         */
        setupLibrary();
        SVNRepository repository = null;
        ArrayList<String> projects = new ArrayList<String>();
        try {
            /*
             * Creates an instance of SVNRepository to work with the repository.
             * All user's requests to the repository are relative to the
             * repository location used to create this SVNRepository.
             * SVNURL is a wrapper for URL strings that refer to repository locations.
             */
            repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded(url));
            ISVNAuthenticationManager authManager = SVNWCUtil.createDefaultAuthenticationManager(name, password);
            repository.setAuthenticationManager(authManager);
        } catch (SVNException svne) {
            /*
             * Perhaps a malformed URL is the cause of this exception
             */
            System.err.println("error while creating an SVNRepository for location '"+ url + "': " + svne.getMessage());
            System.exit(1);
        }   

        try {
            SVNNodeKind nodeKind = repository.checkPath("", -1);
            if (nodeKind == SVNNodeKind.NONE) {
                System.err.println("There is no entry at '" + url + "'.");
                System.exit(1);
            } else if (nodeKind == SVNNodeKind.FILE) {
                System.err.println("The entry at '" + url + "' is a file while a directory was expected.");
                System.exit(1);
            }
            /**
             * Read projects Name
             */
            Collection entries = repository.getDir("", -1, null,(Collection) null);
            Iterator iterator = entries.iterator();
            while (iterator.hasNext()) {
                SVNDirEntry entry = (SVNDirEntry) iterator.next();
                projects.add(entry.getName().toLowerCase());
            }
        } catch (SVNException svne) {
            System.err.println("error while listing entries: " + svne.getMessage());
            System.exit(1);
        }
		return projects;
    }
	
	public static void createSVNRepository(String svnName) throws SVNException{
		if(svnName != null && !svnName.equals(""))
		{
			String url = PropertiesService.getProperty("SVN.url");
			String name = PropertiesService.getProperty("SVN.username");
	        String password = PropertiesService.getProperty("SVN.password");
	        String projectName = svnName;
	        
	        /*
	         * Initializes the library (it must be done before ever using the
	         * library itself)
	         */
	        setupLibrary();
	        SVNRepository repository = null;
	        try{
	        	repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded(url));
	        	ISVNAuthenticationManager authManager = SVNWCUtil.createDefaultAuthenticationManager(name, password);
	            repository.setAuthenticationManager(authManager);
	        	populateSourceRepository(repository,projectName);
	
			} catch (SVNException svne) {
		        /*
		         * getFullMessage() will give us a full tree of SVNException 
		         * errors.
		         */
		        System.err.println(svne.getErrorMessage().getFullMessage());
		        System.exit(1);
			}
		}
	}
	private static void populateSourceRepository(SVNRepository srcRepository,String projectName) throws SVNException {
        /*
         * Simple repository tree to create. Each entry will be 
         * added in its own revision.
         */
        String projectDir = projectName;
        String subDirs[]={"/branches","/tags","/trunk"};

        long revision = -1;
        SVNCommitInfo info = null;

        
        /*
         * First commit "/projectDir".
         */
        ISVNEditor editor = srcRepository.getCommitEditor("adding " + projectDir, null);
        editor.openRoot(-1);
        editor.addDir(projectDir, null, -1);
        editor.closeDir();
        editor.closeDir();
        info = editor.closeEdit();
        System.out.println(info);
        revision = info.getNewRevision();
        

        /*
         * Then commit "/projectDir/subDir".
         */
        for(String subDir : subDirs)
	    {	subDir = projectDir + subDir;
        	editor = srcRepository.getCommitEditor("adding " + subDir, null);
	        editor.openRoot(-1);
	        editor.openDir(projectDir, revision);
	        editor.addDir(subDir, null, -1);
	        editor.closeDir();
	        editor.closeDir();
	        editor.closeDir();
	        info = editor.closeEdit();
	        System.out.println(info);
	        revision = info.getNewRevision();
        }
    }
	private static void setupLibrary() {
        /*
         * For using over http:// and https://
         */
        DAVRepositoryFactory.setup();
        /*
         * For using over svn:// and svn+xxx://
         */
        SVNRepositoryFactoryImpl.setup();
        /*
         * For using over file:///
         */
        FSRepositoryFactory.setup();
    }
	
}
