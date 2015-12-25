package com.mcnc.yuga.helper.grid;

import java.util.Calendar;
import java.util.List;

public class ProjectRequest extends Request{

	private List<String> RequestPTypeID;
	private boolean allType;
	private String requestOrderBy;
	private List<String> requestStatus;
	private List<String> requestRole;
	private String requestPeriod;
	
	
	public List<String> getRequestPTypeID() {		
		return RequestPTypeID;
	}
	public void setRequestPTypeID(List<String> requestPTypeID) {	
		if(requestPTypeID.size() !=0 && !requestPTypeID.get(0).equalsIgnoreCase("all")){
			RequestPTypeID = requestPTypeID;
		}		
	}
	public String getRequestOrderBy() {
		return requestOrderBy;
	}
	public void setRequestOrderBy(String requestOrderBy) {
		this.requestOrderBy = requestOrderBy;
	}
	public List<String> getRequestStatus() {
		return requestStatus;
	}
	public void setRequestStatus(List<String> requestStatus) {
		if(requestStatus.size() > 0){
			this.requestStatus = requestStatus;
		}
	}
	public String getRequestPeriod() {
		return requestPeriod;
	}
	public void setRequestPeriod(String requestPeriod) {
		try{
			if(!requestPeriod.equalsIgnoreCase("all")){
				if(Integer.parseInt(requestPeriod) == Calendar.getInstance().get(Calendar.YEAR)){
					this.requestPeriod = "thisYear";
				}else{
					this.requestPeriod = "period";
				}
			}else{
				this.requestPeriod = requestPeriod;
			}
		}catch( Exception ex){
			this.requestPeriod = requestPeriod;
		}
	}
	
	public boolean isAllType() {
		return allType;
	}
	public void setAllType(boolean allType) {
		this.allType = allType;
	}
	public List<String> getRequestRole() {
		return requestRole;
	}
	public void setRequestRole(List<String> requestRole) {
		this.requestRole = requestRole;
	}
	@Override
	public String toString() {
		return "ProjectRequest [RequestPTypeID=" + RequestPTypeID
				+ ", allType=" + allType + ", requestOrderBy=" + requestOrderBy
				+ ", requestStatus=" + requestStatus + ", requestRole="
				+ requestRole + ", requestPeriod=" + requestPeriod + "]";
	}
	
}
