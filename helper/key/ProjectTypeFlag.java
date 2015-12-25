package com.mcnc.yuga.helper.key;

import java.util.ArrayList;
import java.util.List;

public enum ProjectTypeFlag {

	OVER_HEAD("Over Head"), 
	RD("R&D"), 
	MA("MA"), 
	BILLABLE_SM("Billable SM"), 
	BILLABLE_SI("Billable SI"), 
	NONE_BILLABLE("None Billable");

	private final String value;

	ProjectTypeFlag(String value) {
		this.value = value;
	}

	public String getValue() {
		return value;
	}

	@Override
	public String toString() {
		return value;
	}

	public static ProjectTypeFlag getEnum(String value) {
		ProjectTypeFlag result = null;

		ProjectTypeFlag[] values = ProjectTypeFlag.values();
		for (ProjectTypeFlag flag : values) {
			if (flag.getValue().equalsIgnoreCase(value)) {
				result = flag;
				break;
			}
		}
		return result;
	}
	
	public static List<String> getAllFlags(){
		
		List<String> str = new ArrayList<String>();
		for(ProjectTypeFlag value : ProjectTypeFlag.values()){   
		    str.add(value.getValue());
		}
		return str;
	}
}
