package com.mcnc.yuga.helper.key;

import java.util.ArrayList;
import java.util.List;

public enum EmployeeLevelType {
	
	PRINCIPLE("Principal"),
	CHIEF("Chief"),
	SENIOR("Senior"),
	JUNIOR("Junior"),
	CAMBODIA("Cambodia");
	
	private final String value;

	EmployeeLevelType(String value) {
		this.value = value;
	}

	public String getValue() {
		return value;
	}

	@Override
	public String toString() {
		return value;
	}


	public static List<String> getAllEmpLevelTypes(){
		
		List<String> str = new ArrayList<String>();
		for(EmployeeLevelType value : EmployeeLevelType.values()){   
		    str.add(value.getValue());
		}
		return str;
	}
	
	
	public static EmployeeLevelType getEnum(String value) {
		EmployeeLevelType result = null;

		EmployeeLevelType[] values = EmployeeLevelType.values();
		for (EmployeeLevelType empLevelType : values) {
			if (empLevelType.getValue().equalsIgnoreCase(value)) {
				result = empLevelType;
				break;
			}
		}
		return result;
	}
}
