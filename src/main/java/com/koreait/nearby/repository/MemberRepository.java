package com.koreait.nearby.repository;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.koreait.nearby.domain.Member;
@Repository
public interface MemberRepository {
 
	// 회원가입 
	public int joinMember(Member member);
	
	// 아이디중복 
	public Member idCheck(String id);
	
	// 이메일중복 + 아이디 찾기 
	public Member selectByEmail(String email);
	
	/* 비밀번호 찾기/ 임시 비밀번호 전송 */
	public int findPw(Member member);
	
	// 로그인
	public Member login(Member member);
	
	// 회원정보 받아오기 
	public Member selectMemberById(Member member);
	
	// 비밀번호 일치여부 (조회 성공 : 1 / 조회 실패 : 0)
	public int selectPassword(String password);
	
	// 비밀번호수정 
	public int updatePw(Member member);
	
	// 정보수정(이름, 생일, 성별, 폰)
	public int updateMember(Member member);
	
	// 회원탈퇴(DB삭제x)
	public int leaveMember(Long mNo);

	
	// 관리자 관련 /////////
	// 관리자만 가능한 회원 활성화
	public int reInsertMember(Long mNo);
	
	// 이용하는 총멤버
	public List<Member> memberCount();
	
    // 남자 유저
	public List<Member> memberMen();
	
	// 여자 유저
	public List<Member> memberWomen();
	
	// 성별 없음 유저
	public List<Member> memberNoGender();

	//오늘 가입한 유저
	public List<Member> memberCreatedDay();
	
	// 10대  20대 30대 40대 50대~
	public List<Member> memberAge10();
	public List<Member> memberAge20();
	public List<Member> memberAge30();
	public List<Member> memberAge40();
	public List<Member> memberAge50();
	
	
	// 관리자의 검색 결과 수 
	public int selectFindRecordCount(Map<String, Object> map);
	
	// 관리자의 검색 결과 리스트 
	public List<Member> selectFindList(Map<String, Object> map);
		
}
