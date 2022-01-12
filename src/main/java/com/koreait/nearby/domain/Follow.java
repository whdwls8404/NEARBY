package com.koreait.nearby.domain;

public class Follow {
	private Long fNo;
	private String followingId, followedId;
	private Profile profile;
	
	
	public Follow() {
		// TODO Auto-generated constructor stub
	}


	public Follow(Long fNo, String followingId, String followedId, Profile profile) {
		super();
		this.fNo = fNo;
		this.followingId = followingId;
		this.followedId = followedId;
		this.profile = profile;
	}


	public Long getfNo() {
		return fNo;
	}


	public void setfNo(Long fNo) {
		this.fNo = fNo;
	}


	public String getFollowingId() {
		return followingId;
	}


	public void setFollowingId(String followingId) {
		this.followingId = followingId;
	}


	public String getFollowedId() {
		return followedId;
	}


	public void setFollowedId(String followedId) {
		this.followedId = followedId;
	}


	public Profile getProfile() {
		return profile;
	}


	public void setProfile(Profile profile) {
		this.profile = profile;
	}


	@Override
	public String toString() {
		return "Follow [fNo=" + fNo + ", followingId=" + followingId + ", followedId=" + followedId + ", profile="
				+ profile + "]";
	}
	
	
	
	
}
