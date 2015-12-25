package com.mcnc.yuga.helper.key;

public enum RevenueType {

	SI("SI Revenue"),
	SM("SM Revenue"),
	LICENSE("License Revenue"),
	OUT_SOURCE("3rd party Solutions Revenue"),
	INTERNAL_RD("Internal R&D Revenue");
	
	private final String value;

	RevenueType(String value) {
		this.value = value;
	}

	public String getValue() {
		return value;
	}

	@Override
	public String toString() {
		return value;
	}
}
