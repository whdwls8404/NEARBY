package com.koreait.nearby.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreait.nearby.domain.Reply;
import com.koreait.nearby.service.ReplyService;

@Controller
@RequestMapping("reply")
public class ReplyController {
	
	private ReplyService service;
	
	@Autowired
	public ReplyController(ReplyService service) {
		super();
		this.service = service;
	}
	
	// 댓글 전체 리스트
	@GetMapping(value="replyList", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> replyList(HttpServletRequest request){
		return service.replyList(request);
	}
	
	// 댓글 삽입
	@PostMapping(value="insertReply", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> insertReply(@RequestBody Reply reply, HttpSession session){
		return service.insertReply(reply, session);
	}
	
	// 댓글 수정
	@PostMapping(value="updateReply", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> updateReply(@RequestBody Reply reply) {
		return service.updateReply(reply);
	}
	
	
	// 댓글 삭제
	@GetMapping(value="deleteReply", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> deleteReply(@RequestParam("rNo") Long rNo){
		return service.deleteReply(rNo);
	}
	

}
