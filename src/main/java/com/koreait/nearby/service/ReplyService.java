package com.koreait.nearby.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.koreait.nearby.domain.Reply;

public interface ReplyService {

	public Map<String, Object> replyList(HttpServletRequest request);
	public Map<String, Object> insertReply(Reply reply, HttpSession session);
	public Map<String, Object> updateReply(Reply reply);
	public Map<String, Object> deleteReply(Long rNo);
}
