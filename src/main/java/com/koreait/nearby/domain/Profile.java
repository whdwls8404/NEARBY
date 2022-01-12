package com.koreait.nearby.domain;

public class Profile {

	private String id, pContent, pOrigin, pSaved, pPath;
	
	public Profile() {
		// TODO Auto-generated constructor stub
	}

	public Profile(String id, String pContent, String pOrigin, String pSaved, String pPath) {
		super();
		this.id = id;
		this.pContent = pContent;
		this.pOrigin = pOrigin;
		this.pSaved = pSaved;
		this.pPath = pPath;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getpContent() {
		return pContent;
	}

	public void setpContent(String pContent) {
		this.pContent = pContent;
	}

	public String getpOrigin() {
		return pOrigin;
	}

	public void setpOrigin(String pOrigin) {
		this.pOrigin = pOrigin;
	}

	public String getpSaved() {
		return pSaved;
	}

	public void setpSaved(String pSaved) {
		this.pSaved = pSaved;
	}

	public String getpPath() {
		return pPath;
	}

	public void setpPath(String pPath) {
		this.pPath = pPath;
	}

	@Override
	public String toString() {
		return "Profile [id=" + id + ", pContent=" + pContent + ", pOrigin=" + pOrigin + ", pSaved=" + pSaved
				+ ", pPath=" + pPath + "]";
	}
	
	
	
	
}
