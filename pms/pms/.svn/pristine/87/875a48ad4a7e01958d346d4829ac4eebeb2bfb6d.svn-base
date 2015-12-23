package com.mobilecnc.helper;

/**
 * 
 * @author sambath kakda
 * 
 */
public class Message {
	public Boolean isMessage;
	public Boolean isValid;
	public Boolean isAlert;
	public String title;
	public String message;

	public Boolean getIsAlert() {
		return isAlert;
	}

	public void setIsAlert(Boolean isAlert) {
		this.isAlert = isAlert;
	}

	public Message() {
		this.setIsMessage(false);
		this.setIsValid(true);
		this.setIsAlert(true);
		this.setTitle("Information");
		this.setMessage("");
	}

	public Boolean getIsMessage() {
		return isMessage;
	}

	public void setIsMessage(Boolean isMessage) {
		this.isMessage = isMessage;
	}

	public Boolean getIsValid() {
		return isValid;
	}

	public void setIsValid(Boolean isValid) {
		this.isValid = isValid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public void setSaveSuccess() {
		this.setIsAlert(false);
		this.setIsValid(true);
		this.setIsMessage(true);
		this.setMessage("Data has been saved !");
		this.setTitle("Information");
	}

	public void setSaveFail() {
		this.setIsAlert(false);
		this.setIsValid(false);
		this.setIsMessage(true);
		this.setMessage("Data could not be saved !");
		this.setTitle("Information");
	}

	public void setUpdateSuccess() {
		this.setIsAlert(false);
		this.setIsValid(true);
		this.setIsMessage(true);
		this.setMessage("Data has been updated !");
		this.setTitle("Information");
	}

	public void setUpdateFail() {
		this.setIsAlert(false);
		this.setIsValid(false);
		this.setIsMessage(true);
		this.setMessage("Data could not be updated ! Please try again.");
		this.setTitle("Information");
	}

	public void setDeleteSuccess() {
		this.setIsAlert(false);
		this.setIsValid(true);
		this.setIsMessage(true);
		this.setMessage("Data has been delete.");
		this.setTitle("Information");
	}
	
	public void setDeleteFail() {
		this.setIsAlert(false);
		this.setIsValid(false);
		this.setIsMessage(true);
		this.setMessage("Data could not be deleted ! Please try again.");
		this.setTitle("Information");
	}
	
	public void setLoginFail(){
		this.setIsAlert(false);
		this.setIsValid(false);
		this.setIsMessage(true);
		this.setMessage("Bad credentials, User Name/Password incorrect. Please contact administrator.");
		this.setTitle("Information");
	}
}
