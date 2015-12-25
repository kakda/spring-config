package com.mcnc.yuga.helper.tree;

import java.util.Map;


public class Root {

	public Root() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Root(String id, String text, Object children, String type) {
		super();
		this.id = id;
		this.text = text;
		this.children = children;
		this.type = type;
	}

	private String id;
	private String text;
	private Object children;
	private String type;
	private Map<String, Boolean> state;
	private String empLevelID;
	private String empLevel;
	private String position;

	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public Object getChildren() {
		return children;
	}

	public void setChildren(Object children) {
		this.children = children;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public Map<String, Boolean> getState() {
		return state;
	}

	public void setState(Map<String, Boolean> state) {
		this.state = state;
	}

	public String getEmpLevelID() {
		return empLevelID;
	}

	public void setEmpLevelID(String empLevelID) {
		this.empLevelID = empLevelID;
	}
	
	public String getEmpLevel() {
		return empLevel;
	}

	public void setEmpLevel(String empLevel) {
		this.empLevel = empLevel;
	}
	

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	@Override
	public String toString() {
		return "Root [id=" + id + ", text=" + text + ", children=" + children
				+ ", type=" + type + ", state=" + state + ", empLevelID=" + empLevelID
				+ ", empLevel=" + empLevel + ", position=" + position + "]";
	}

	

}
