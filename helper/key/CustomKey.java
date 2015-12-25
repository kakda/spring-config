package com.mcnc.yuga.helper.key;

public class CustomKey {
	
	private String tableName;
	private String fieldName;
	private String pattern;
	private int digitLength;
	private String value;
	
	
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getFieldName() {
		return fieldName;
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	public String getPattern() {
		return pattern;
	}
	public void setPattern(String pattern) {
		this.pattern = pattern;
	}
	public int getDigitLength() {
		return digitLength;
	}
	public void setDigitLength(int digitLength) {
		this.digitLength = digitLength;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
}
