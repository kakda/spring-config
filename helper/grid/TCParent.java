package com.mcnc.yuga.helper.grid;


public class TCParent extends Request{

	private String timecardID;
	private float day1 = 0.0f;
	private float day2 = 0.0f;
	private float day3 = 0.0f;
	private float day4 = 0.0f;
	private float day5 = 0.0f;
	private float day6 = 0.0f;
	private float day7 = 0.0f;
	private float actualHour = 0.0f;
	private String lastUpdated;
	
	public String getTimecardID() {
		return timecardID;
	}
	public void setTimecardID(String timecardID) {
		this.timecardID = timecardID;
	}
	public float getDay1() {
		return day1;
	}
	public void setDay1(float day1) {
		this.day1 = day1;
	}
	public float getDay2() {
		return day2;
	}
	public void setDay2(float day2) {
		this.day2 = day2;
	}
	public float getDay3() {
		return day3;
	}
	public void setDay3(float day3) {
		this.day3 = day3;
	}
	public float getDay4() {
		return day4;
	}
	public void setDay4(float day4) {
		this.day4 = day4;
	}
	public float getDay5() {
		return day5;
	}
	public void setDay5(float day5) {
		this.day5 = day5;
	}
	public float getDay6() {
		return day6;
	}
	public void setDay6(float day6) {
		this.day6 = day6;
	}
	public float getDay7() {
		return day7;
	}
	public void setDay7(float day7) {
		this.day7 = day7;
	}
	public float getActualHour() {
		return actualHour;
	}
	public void setActualHour(float actualHour) {
		this.actualHour = actualHour;
	}
	public String getLastUpdated() {
		return lastUpdated;
	}
	public void setLastUpdated(String lastUpdated) {
		this.lastUpdated = lastUpdated;
	}
	
	
	
}
