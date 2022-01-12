package com.koreait.nearby.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreait.nearby.domain.Member;
import com.koreait.nearby.service.BoardService;
import com.koreait.nearby.service.MemberService;

@Controller
public class adminController {


	 private BoardService bService;
	  private MemberService mService;
	
	  public  adminController(BoardService bService, MemberService mService) {
		super();
		this.bService = bService;
		this.mService = mService;
	}

    // 관리자
	@GetMapping("admin/admin")
	  public String admin(Model model) {
		   model.addAttribute("board", bService.selectBoardList());
		   model.addAttribute("member", mService.selectMemberList());
		   model.addAttribute("memberMen", mService.selectMemberMen());
		   model.addAttribute("memberWomen", mService.selectMemberWomen());
		   model.addAttribute("memberNoGender", mService.selectMemberNoGender());
		   model.addAttribute("memberCreatedDay", mService.selectMemberCreatedDay());
		   model.addAttribute("memberAge10", mService.memberAge10());
		   model.addAttribute("memberAge20", mService.memberAge20());
		   model.addAttribute("memberAge30", mService.memberAge30());
		   model.addAttribute("memberAge40", mService.memberAge40());
		   model.addAttribute("memberAge50", mService.memberAge50());
		   model.addAttribute("adminBoardMap", bService.adminBoardList());
		   return "admin/admin";
	  }
	
	// 관리자가 전체 유저보는 페이지
	@GetMapping("admin/memberList")
	public String memberList(Model model){
		   model.addAttribute("member", mService.selectMemberList());
		   model.addAttribute("memberMen", mService.selectMemberMen());
		   model.addAttribute("memberWomen", mService.selectMemberWomen());
		   model.addAttribute("memberNoGender", mService.selectMemberNoGender());
		   model.addAttribute("memberCreatedDay", mService.selectMemberCreatedDay());
		   return "admin/memberManage";
	}
	
	
	// 검색
	@GetMapping("admin/findMember")
	public String findMember(HttpServletRequest request, Model model) {
		  String query = request.getParameter("query");
		  String column = request.getParameter("column");
		  model.addAttribute("request", request);
		  Map<String, Object> map = mService.findMember(request);
	      model.addAttribute("map", map);
		  return "admin/memberManage";
	}
	
	
	// 회원 비활성화 = 탈퇴
	@ResponseBody
	@GetMapping(value="admin/deleteMember", produces ="application/json; charset=UTF-8" )
	public Map<String, Object> delteMember(@RequestParam Long mNo) {
		 Map<String, Object> map =  mService.leaveMember(mNo);
		 Map<String,Object> m = new HashMap<String, Object>();
	 	 m.put("result", map);
		 return m;
	}
	// 회원 활성화 
	@ResponseBody
	@GetMapping(value="admin/reInsertMember", produces ="application/json; charset=UTF-8" )
	public Map<String, Object> reInsertMember(@RequestParam Long mNo) {
		 Map<String, Object> map =  mService.reInsertMember(mNo);
		 Map<String,Object> m = new HashMap<String, Object>();
	 	 m.put("result", map);
		 return m;
	}
		
	
	// 게시글 삭제
	@ResponseBody
	@GetMapping(value="admin/adminBoardDelete", produces ="application/json; charset=UTF-8" )
	public Map<String, Object> adminBoardDelete(@RequestParam Long bNo, HttpServletRequest request) {
		 Map<String, Object> map = new HashMap<String, Object>();
		 Map<String, Object> m = bService.adminBoardDelete(bNo, request);
		 map.put("result", m);
		 return map;
	}
}
