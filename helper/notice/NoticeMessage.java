package com.mcnc.yuga.helper.notice;

public class NoticeMessage {

	private String type;
	private String message;
	
	
	public NoticeMessage(String type, String message) {
		super();
		this.type = type;
		this.message = message;
	}
	
	public NoticeMessage() {
		super();
	}
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}

	@Override
	public String toString() {
		return "NoticeMessage [type=" + type + ", message=" + message + "]";
	}
	
	
}
