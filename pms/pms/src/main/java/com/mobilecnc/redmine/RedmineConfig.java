package com.mobilecnc.redmine;

import com.mobilecnc.helper.service.PropertiesService;

public class RedmineConfig {

    public String getURI() {
        return PropertiesService.getProperty("redmine.uri");
    }

    public String getLogin() {
        return PropertiesService.getProperty("redmine.user");
    }

    public String getPassword() {
        return PropertiesService.getProperty("redmine.password");
    }

    public String getApiKey() {
        return PropertiesService.getProperty("redmine.apikey");
    }

    public String getParam(String key) {
        return PropertiesService.getProperty(key);
    }
	
}
