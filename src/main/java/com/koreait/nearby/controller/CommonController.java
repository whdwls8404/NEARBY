package com.koreait.nearby.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.koreait.nearby.domain.Member;

@Controller
public class CommonController {

	@GetMapping("/")
	public String index() {
		return "index";
	}
	
	// 프로필사진 변경 후 마이페이지 이동
	@GetMapping("board/updateProfilePicture")
	public String updateProfilePicture(Member member) {
		return "redirect:boardList";
	}
	

}
