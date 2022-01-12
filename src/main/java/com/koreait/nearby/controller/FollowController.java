package com.koreait.nearby.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreait.nearby.domain.Follow;
import com.koreait.nearby.service.FollowService;

@Controller
public class FollowController {
	   
	
	   private FollowService service;
	   
	   @Autowired
	   public FollowController(FollowService service) {
	      super();
	      this.service = service;
	   }
	   
		// follow페이지로  이동
		@GetMapping(value="follow/followList")
		public String followList(Model model, HttpSession session) {
			model.addAttribute("followingList", service.selectFollowingIdById(session));
			model.addAttribute("followedList", service.selectFollowedIdById(session));
			return "member/follow";
		}
		// userFollow페이지 이동
		@GetMapping(value="follow/userFollow")
		public String userFollow(@RequestParam String id, Model model) {
			model.addAttribute("id", id);
			model.addAttribute("followingList", service.selectUserFollowingIdById(id));
			model.addAttribute("followedList", service.selectUserFollowedIdById(id));
			model.addAttribute("userProfile", service.selectUserProfileOnly(id));
			System.out.println("model로 반환할 profile : " + service.selectUserProfileOnly(id));
			return "/member/userFollow";
		}
	   
	   // 팔로잉
	   @ResponseBody
	   @PostMapping(value="follow/following", produces ="application/json; charset=UTF-8")
	   public Map<String, Object> following(@RequestBody Follow follow, HttpSession session) {
		   		   
		   return service.following(follow, session);
	   }
	   
	   // 언팔
	   @ResponseBody
	   @PostMapping(value="follow/unfollowing", produces ="application/json; charset=UTF-8")
	   public Map<String, Object> unfollowing(@RequestBody Follow follow, HttpSession session) {
		   
		   return service.unfollowing(follow, session);
	   }
	   
	   // 팔로우 체크
	   @ResponseBody
	   @PostMapping(value="follow/checkFollow", produces ="application/json; charset=UTF-8")
	   public Map<String, Object> checkFollow(@RequestBody Follow follow, HttpSession session) {
		   System.out.println("컨트롤러 :" + follow);
		   return service.checkFollow(follow, session);
	   }
	   
	  
	   
	 
	   

}