package com.koreait.nearby.controller;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreait.nearby.domain.Member;
import com.koreait.nearby.service.MemberService;

@Controller
@RequestMapping("member")
public class MemberController {
	
	private MemberService service;
	
	@Autowired
	public MemberController(MemberService service) {
		super();
		this.service = service;
	}
	
	// 회원가입 전 동의
	@GetMapping("agreement")
	public String agreement() {
		return "member/agreement";
	}

	
    // 회원가입하러 가기
	@GetMapping("memberJoin")
	public String memberJoin() {
		return "member/join";
	}
	
	// 회원가입하기 
	@PostMapping("insertMember")
	public void insertMember(HttpServletRequest request, HttpServletResponse response) {
	      service.joinMember(request, response);
	}
	
	// 아이디 비번 찾으러 가기 
	@GetMapping("findIdPw")
	public String findIdPw() {
		return "member/findIdPw";
	}
	
	/* 비밀번호 찾기 / 임시 비밀번호 전송 */
	@PostMapping(value = "findPw", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> findPw(@RequestParam("email") String email) {
		System.out.println(email.toString());
		Map<String, Object> map = service.findPw(email);
		return map;
	}	
	
	
    // 아이디 중복확인하기 
	@ResponseBody
	@PostMapping(value="idCheck", produces ="application/json; charset=UTF-8" )
	public Map<String,Object> idCheck(@RequestParam String id) {
		return service.idCheck(id);
	}
	
	// 이메일 중복확인 + 아이디 찾기 
	@ResponseBody
	@PostMapping(value="selectByEmail", produces ="application/json; charset=UTF-8" )
	public Map<String,Object> selectByEmail(@RequestParam String email) {
		return service.selectByEmail(email);
	}
	
	// 이메일 인증 
	@PostMapping(value="sendAuthCode", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> sendAuthCode(@RequestParam("email") String email) {
		return service.sendAuthCode(email);
	}
	
	/*
	 * // 로그인
	 * @PostMapping(value="login") public void login(HttpServletRequest request,
	 * HttpServletResponse response) { service.login(request, response); }
	 */
	
	
	// 로그인
		@PostMapping(value="login")
		public void login(HttpServletRequest request, HttpServletResponse response, String id) {
			
			// 쿠키 아이디 기억하기
			// 체크 안하면 널
			// 문자열 검사 요청 매개변수("체크아이디");
			String checkId = request.getParameter("checkId");
			
			// 체크 하면 아이디 를 저장한다.
			if (checkId != null) {	// 확인하는 경우 아이디
				Cookie cookie = new Cookie("id", id);	// 쿠키 쿠키 = 새로운 쿠키 아이디, 아이디
				cookie.setMaxAge(5 * 24 * 60 * 60); // 쿠키에서  5일동안 아이디 저장 유지
				response.addCookie(cookie);	// 응답쿠키 
			} else {	// 체크 안하면 아이디를 쿠킹 삭제한다.
				Cookie[] cookies = request.getCookies();	// 쿠키[] 쿠키 = 요청하는 쿠키
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("id")) {	// 쿠키.이름.같으(아이디)
						cookie.setMaxAge(0);	// 아이디 기억 유지 안함!
						response.addCookie(cookie);	// 응답쿠키
						break;
					}
				}
			}
			
			service.login(request, response);
			
		}
	
	// 로그아웃
	@GetMapping(value="logout")
	public String logout(HttpSession session) {
		if (session.getAttribute("loginUser") != null) {
			session.invalidate();
		}
		return "redirect:/";
	}
		
	// 마이페이지 수정으로 가기
	@GetMapping("mypage")
	public String mypage() {
		return "member/mypage";
	}
	
	// 회원정보 업데이트하기 mapping : member/updateMember  method memberInfo
	@ResponseBody
	@PostMapping(value="modifyMember", produces ="application/json; charset=UTF-8")
	public Map<String, Object> modifyMember(@RequestBody Member member, HttpServletRequest request) {
		System.out.println(member);
		return service.modifyMember(member, request);
	}
	
	// 회원정보 select  /nearby/member/memberInfo'
	@PostMapping(value="memberInfo", produces="application/json; charset=UTF-8")   // method 구현해야 함.
	@ResponseBody
	public Map<String, Object> memberInfo(HttpServletRequest request) {
		return service.memberInfo(request);
	}
	
	// 회원 탈퇴
	@PostMapping(value="leaveMember", produces="application/json; charset=UTF-8")
	public String leaveMember(@RequestParam("mNo") Long mNo) {
		service.leaveMember(mNo);
		return "redirect:/";
	}
	
	// 비밀번호 변경 페이지로 이동
	@GetMapping(value="changePasswordPage")
	public String findPasswordPage() {
		return "member/changePw";
	}
	
	// 비밀번호 확인
	@PostMapping(value="checkPassword", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> checkPassword(HttpServletRequest request){
		return service.checkPassword(request);
	}
	
	// 찐 비밀번호 변경
	@PostMapping(value="changePassword")
	public String changePassword(HttpServletRequest request) {
		service.changePassword(request);
		return "redirect:/";
	}
	
	// follow페이지로  이동
	@GetMapping(value="followList")
	public String followList(Model model, HttpSession session) {
		model.addAttribute("list", service);
		return "member/follow";
	}
	
	/* 박종진 */
	// 이용약관
	@GetMapping("serviceTerms")
	public String terms(){
		return "member/terms";
	}
	
	
	
	
}
