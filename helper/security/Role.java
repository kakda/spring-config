package com.mcnc.yuga.helper.security;

public enum Role {

	ROLE_EMPLOYEE("E"),
	ROLE_PM("P"),
	ROLE_SUPER_USER("S");
	

	private final String value;
	
	Role(String value) {
		this.value = value;
	}

	public String getValue() {
		return value;
	}

	@Override
	public String toString() {
		return value;
	}
	
	 public static Role getEnum( String value ){
		Role result = null;
	
		Role[] values = Role.values();
		for ( Role jobStatus : values ) {
			if( jobStatus.getValue().equalsIgnoreCase( value ) ){
				result = jobStatus;
				break;
			}
		}
    	return result;
    }
}
