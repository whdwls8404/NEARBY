package com.koreait.nearby.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Reply {

	private Long rNo, bNo, rLikes;
	private String id, rContent;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date rCreated, rModified;
	private int depth, state, groupNo, groupOrd;
	private Profile profile;

	
	public Reply() {
		// TODO Auto-generated constructor stub
	}


	public Reply(Long rNo, Long bNo, Long rLikes, String id, String rContent, Date rCreated, Date rModified, int depth,
			int state, int groupNo, int groupOrd, Profile profile) {
		super();
		this.rNo = rNo;
		this.bNo = bNo;
		this.rLikes = rLikes;
		this.id = id;
		this.rContent = rContent;
		this.rCreated = rCreated;
		this.rModified = rModified;
		this.depth = depth;
		this.state = state;
		this.groupNo = groupNo;
		this.groupOrd = groupOrd;
		this.profile = profile;
	}


	public Long getrNo() {
		return rNo;
	}


	public void setrNo(Long rNo) {
		this.rNo = rNo;
	}


	public Long getbNo() {
		return bNo;
	}


	public void setbNo(Long bNo) {
		this.bNo = bNo;
	}


	public Long getrLikes() {
		return rLikes;
	}


	public void setrLikes(Long rLikes) {
		this.rLikes = rLikes;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getrContent() {
		return rContent;
	}


	public void setrContent(String rContent) {
		this.rContent = rContent;
	}


	public Date getrCreated() {
		return rCreated;
	}


	public void setrCreated(Date rCreated) {
		this.rCreated = rCreated;
	}


	public Date getrModified() {
		return rModified;
	}


	public void setrModified(Date rModified) {
		this.rModified = rModified;
	}


	public int getDepth() {
		return depth;
	}


	public void setDepth(int depth) {
		this.depth = depth;
	}


	public int getState() {
		return state;
	}


	public void setState(int state) {
		this.state = state;
	}


	public int getGroupNo() {
		return groupNo;
	}


	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}


	public int getGroupOrd() {
		return groupOrd;
	}


	public void setGroupOrd(int groupOrd) {
		this.groupOrd = groupOrd;
	}


	public Profile getProfile() {
		return profile;
	}


	public void setProfile(Profile profile) {
		this.profile = profile;
	}


	@Override
	public String toString() {
		return "Reply [rNo=" + rNo + ", bNo=" + bNo + ", rLikes=" + rLikes + ", id=" + id + ", rContent=" + rContent
				+ ", rCreated=" + rCreated + ", rModified=" + rModified + ", depth=" + depth + ", state=" + state
				+ ", groupNo=" + groupNo + ", groupOrd=" + groupOrd + ", profile=" + profile + "]";
	}
	
	
	
	
	
}
