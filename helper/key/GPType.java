package com.mcnc.yuga.helper.key;

import java.util.ArrayList;
import java.util.List;

public enum GPType {
	
	SERVICE_REVENUE("SI & SM"),
	LICENSE_REVENUE("License"),
	VENDER_REVENUE("3rd Party"),
	LICENSE_RD_COST_RATIO("License R&D Cost Ratio");
	
	private final String value;

	GPType(String value) {
		this.value = value;
	}

	public String getValue() {
		return value;
	}

	@Override
	public String toString() {
		return value;
	}


	public static List<String> getAllGPTypes(){
		
		List<String> str = new ArrayList<String>();
		for(GPType value : GPType.values()){   
		    str.add(value.getValue());
		}
		return str;
	}
	
	
	public static GPType getEnum(String value) {
		GPType result = null;

		GPType[] values = GPType.values();
		for (GPType gpType : values) {
			if (gpType.getValue().equalsIgnoreCase(value)) {
				result = gpType;
				break;
			}
		}
		return result;
	}
}
