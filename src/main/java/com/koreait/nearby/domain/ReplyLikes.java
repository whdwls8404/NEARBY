package com.koreait.nearby.domain;

import java.util.Date;

public class ReplyLikes {
	private Long rLikeNo, rNo, bNo, rLikeCheck;
	private String id;
	private Date rLikeDate;	
	
	public ReplyLikes() {
		// TODO Auto-generated constructor stub
	}

	public ReplyLikes(Long rLikeNo, Long rNo, Long bNo, Long rLikeCheck, String id, Date rLikeDate) {
		super();
		this.rLikeNo = rLikeNo;
		this.rNo = rNo;
		this.bNo = bNo;
		this.rLikeCheck = rLikeCheck;
		this.id = id;
		this.rLikeDate = rLikeDate;
	}

	public Long getrLikeNo() {
		return rLikeNo;
	}

	public void setrLikeNo(Long rLikeNo) {
		this.rLikeNo = rLikeNo;
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

	public Long getrLikeCheck() {
		return rLikeCheck;
	}

	public void setrLikeCheck(Long rLikeCheck) {
		this.rLikeCheck = rLikeCheck;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Date getrLikeDate() {
		return rLikeDate;
	}

	public void setrLikeDate(Date rLikeDate) {
		this.rLikeDate = rLikeDate;
	}

	@Override
	public String toString() {
		return "ReplyLikes [rLikeNo=" + rLikeNo + ", rNo=" + rNo + ", bNo=" + bNo + ", rLikeCheck=" + rLikeCheck
				+ ", id=" + id + ", rLikeDate=" + rLikeDate + "]";
	}
	
	
}
