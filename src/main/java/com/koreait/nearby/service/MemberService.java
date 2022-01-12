package com.koreait.nearby.service;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.koreait.nearby.domain.Member;

public interface MemberService {
   
	// 회원가입
	public void joinMember(HttpServletRequest request, HttpServletResponse response);
	
    // 회원가입시 아이디 중복 체크 
	public Map<String, Object> idCheck(String id);
	
	// 회원가입시 이메일 중복 체크 + 아이디 찾기
	public Map<String, Object> selectByEmail(String email);
	
	/* 비밀번호 찾기/ 임시 비밀번호 전송 */
	public Map<String, Object> findPw(String email);
	
	// 회원가입 이메일 인증
	public Map<String, Object> sendAuthCode(String email);

	// 로그인
	public void login(HttpServletRequest request, HttpServletResponse response);
   
	// 회원 조회
	public Map<String, Object> memberInfo(HttpServletRequest request);	
	
	// 회원정보 수정
	public Map<String, Object> modifyMember(Member member,HttpServletRequest request);
	
	// 회원 탈퇴
	public  Map<String,Object> leaveMember(Long mNo);
	
	// 관리자만 가능한 회원 활성화
	public  Map<String,Object> reInsertMember(Long mNo);
		
	// 비밀번호 확인
	public Map<String, Object> checkPassword(HttpServletRequest request);
	
	// 비밀번호 변경
	public void changePassword(HttpServletRequest request);
	
	//  관리자 제외 총 유저
	public List<Member> selectMemberList();
	
	// 남자 유저
	public List<Member> selectMemberMen();
	 
	// 여자 유저
	public List<Member> selectMemberWomen();
	
	// 성별없음 유저
	public List<Member> selectMemberNoGender();
	
	// 오늘 가입한 유저
	public List<Member> selectMemberCreatedDay();
	
	// 멤버 연령대 
	public List<Member> memberAge10();
	public List<Member> memberAge20();
	public List<Member> memberAge30();
	public List<Member> memberAge40();
	public List<Member> memberAge50();
	
	
	// 검색(총 수, 리스트)
	public Map<String, Object> findMember(HttpServletRequest request);
	
	// default method
	 	public default void message(int result, HttpServletResponse response, 
	 			String success, String fail, String path) {
	 		try {
	 			response.setContentType("text/html; charset=UTF-8");
	 			PrintWriter out = response.getWriter();
	 			if (result > 0) {
	 				out.println("<script>");
	 				out.println("alert('" + success + "')");
	 				out.println("location.href='" + path + "'");
	 				out.println("</script>");
	 				out.close();
	 			} else {
	 				out.println("<script>");
	 				out.println("alert('" + fail + "')");
	 				out.println("history.back()");
	 				out.println("</script>");
	 				out.close();
	 			}
	 		} catch (Exception e) {
	 			e.printStackTrace();
	 		}
	 	}
	    
   
   
}
