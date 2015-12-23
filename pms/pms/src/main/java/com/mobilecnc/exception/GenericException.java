package com.mobilecnc.exception;

public class GenericException extends RuntimeException {

	private String customMessage;
	private String detailError;
	private String page;
	
	
	public GenericException(String customMessage, String detailError){
		this.setPage("default/customError");
		this.setCustomMessage(customMessage);
		this.setDetailError(detailError);
	}
	
	public GenericException(String customMessage){
		this.setPage("default/customError");
		this.setCustomMessage(customMessage);
	}
	
	public void setCustomMessage(String customMessage) {
		this.customMessage = customMessage;
	}
	public String getCustomMessage() {
		return customMessage;
	}

	public String getDetailError() {
		return detailError;
	}
	public void setDetailError(String detailError) {
		this.detailError = detailError;
	}

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page;
	}
	
}
