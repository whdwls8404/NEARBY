package com.koreait.nearby.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.exceptions.PersistenceException;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.ui.Model;

import com.koreait.nearby.domain.Member;
import com.koreait.nearby.domain.Profile;
import com.koreait.nearby.repository.BoardRepository;
import com.koreait.nearby.repository.MemberRepository;
import com.koreait.nearby.repository.ProfileRepository;
import com.koreait.nearby.util.SecurityUtils;
import com.koreait.nearby.util.adminPage;

public class MemberServiceImpl implements MemberService {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private JavaMailSender javaMailSender;
	
	// birthday 파라미터 세개 더해야 돼서 request로 받음.. 
	@Override
	public void joinMember(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id"); 
		Member member = new Member();
		 member.setId(id);
		 member.setPw(SecurityUtils.sha256(request.getParameter("pw")));
		 member.setName(request.getParameter("name"));
		 member.setEmail(request.getParameter("email"));
		 member.setPhone(request.getParameter("phone"));
		 String birthday = request.getParameter("year") + request.getParameter("month")+request.getParameter("day");
		 member.setBirthday(birthday);
		 member.setGender(request.getParameter("gender"));
		 
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);	
		int result = memberRepository.joinMember(member);
		
		/* 회원가입과 동시에 프로필 테이블에 DATA삽입. */
		Profile profile = new Profile(); //DTO
		// DB에 전달 할 data 담기
		profile.setId(id);
		profile.setpContent("");
		profile.setpPath("");
		profile.setpOrigin("");
		profile.setpSaved("");
		ProfileRepository profileRepository = sqlSession.getMapper(ProfileRepository.class);
		int profileResult = profileRepository.insertProfile(profile);
		System.out.println("profileResult 결과 : " + profileResult );
		
		message(result, response, "회원가입성공", "회원가입실패", "/nearby");
	}
	


    // 아이디 중복 확인 
	@Override
	public Map<String, Object> idCheck(String id){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
		map.put("result", memberRepository.idCheck(id));
		return map;
	}
	
	// 이메일 중복확인 + 아이디 찾기
	@Override
	public Map<String, Object> selectByEmail(String email) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
		map.put("result", memberRepository.selectByEmail(email));
		return map;
	}
	
	/* 비밀번호 찾기 */
	@Override
	public Map<String, Object> findPw(String email) {

		// 임시 비밀번호 생성
		String pw = "";
		for (int i = 0; i < 12; i++) {
			pw += (char) ((Math.random() * 26) + 97);
		}

		// 이메일로 임시 비밀번호 보내기
		try {
			MimeMessage findPwMessage = javaMailSender.createMimeMessage();
			findPwMessage.setHeader("Content-Type", "text/plain; charset=UTF-8");
			findPwMessage.setFrom(new InternetAddress("nearby.corp@gmail.com", "NearBy"));
			findPwMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
			findPwMessage.setSubject("NearBy 임시 비밀번호 발급");
			findPwMessage.setText("임시 비밀번호는 " + pw + "입니다.");
			javaMailSender.send(findPwMessage);
			System.out.println("MemberServiceImple 이메일로 보낸 임시 비밀번호 : " + pw + "입니다.");

		} catch (Exception e) {
			e.printStackTrace();
		}

		// 임시 비밀번호를 담을 Member 호출
		Member member = new Member();
		// 임시 비밀번호를 담음
		member.setEmail(email);
		member.setPw(SecurityUtils.sha256((pw)));
		System.out.println("SecurityUtils 암호화가된 임시 비밀번호 : " + pw + "입니다.");

		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
		int result = memberRepository.findPw(member);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		return map;
	}
	
	
	
	// 이메일 인증
	@Override
	public Map<String, Object> sendAuthCode(String email) {
		
		// 인증코드 발생
		String authCode = SecurityUtils.authCode(6);
		
		// 이메일 전송
		try {
			
			MimeMessage message = javaMailSender.createMimeMessage();
			message.setHeader("Content-Type", "text/plain; charset=UTF-8");
			message.setFrom(new InternetAddress("nearby.corp@gmail.com", "NEARBY"));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
			message.setSubject("NEARBY 인증 요청 메일입니다.");
			message.setText("인증번호는 " + authCode + " 입니다.");
			System.out.println(authCode);
			javaMailSender.send(message);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("authCode", authCode);
		return map;
		
	}

	// 로그인  
	@Override
	public void login(HttpServletRequest request, HttpServletResponse response) {
			Member member = new Member();
			String id = request.getParameter("id");
			member.setId(id);
			member.setPw(SecurityUtils.sha256(request.getParameter("pw")));
			MemberRepository repository = sqlSession.getMapper(MemberRepository.class);
			Member loginUser = repository.login(member);
			System.out.println("loginUser information : " + loginUser);
			
			// 로그인한 유저 보드에 좋아요한 유무 DB에서 갖고와서 세션에 저장하기 
			if (loginUser != null) {
				request.getSession().setAttribute("loginUser", loginUser);
				logger.info(loginUser.toString());
			}		
							
				try {
		 			response.setContentType("text/html; charset=UTF-8");
		 			PrintWriter out = response.getWriter();
		 			if (loginUser != null) {
		 				out.println("<script>");
		 				if( "admin".equals(loginUser.getId()) == false) {
		 					out.println("location.href='/nearby/board/boardList';");
		 				} else {
		 					out.println("location.href='/nearby/admin/admin';");
		 				}
	 					out.println("</script>");
		 				out.close();
		 			} else {
	                    out.println("<script src='https://code.jquery.com/jquery-3.6.0.js' integrity='sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=' crossorigin='anonymous'></script>");
	                    out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@10'></script> ");
	                    out.println("<script src='https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.4/sweetalert2.all.js'></script>");
		 				out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
	                    out.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
	                    out.println("<style> .swal2-styled.swal2-confirm { width: 100px; background-color: #d4d4d4;  }</style>");
		 				out.println("<script>");
		 			    out.println("$(document).ready(function(){");
		 		//		out.println("alert('아이디와 비밀번호를 확인해주세요');");
		 			  	out.println("Swal.fire({ text: '아이디와 비밀번호를 확인해주세요', confirmButtonText:'OK',   closeOnClickOutside: false, timer: 11000 }).then((result) => {   if (result.isConfirmed) {  history.back(); }; }) ");
		 			//	out.println("history.back();");
		 				out.println("});");
	 					out.println("</script>");
		 				out.close();
		 			}
		 		} catch (Exception e) {
		 			e.printStackTrace();
		 		}
				
			
		}

	// 회원정보 확인
	@Override
	public Map<String, Object> memberInfo(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			// 세션에 저장된 loginUser정보 받아오기.
			Member loginUser = (Member)request.getSession().getAttribute("loginUser");
			if (loginUser == null) throw new NullPointerException("다시 로그인을 진행해주세요.");
			// DB로 보낼 Bean 생성
			Member member = new Member();
			member.setId(loginUser.getId());
			member.setPw(loginUser.getPw()); // 수정
			MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
			Member selectResult = memberRepository.selectMemberById(member);
			if (selectResult == null ) throw new PersistenceException("일치하는 회원정보가 없습니다.");
			map.put("member", member);
			map.put("result", selectResult);
		} catch(PersistenceException e) {
			map.put("updateErrorMsg", e.getMessage());
		} catch(NullPointerException e) {
			map.put("loginErrorMsg", e.getMessage());
		} catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println("DB갔다온 Map : " + map.toString());
		
		return map;
	}
	
	// 회원정보 수정  // 받아올 파라미터 이름/핸드폰번호/생년월일/성별 
	@Override
	public Map<String, Object> modifyMember(Member m, HttpServletRequest request) {
		// 보낼 map 생성
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			// 세션에 저장된 loginUser정보 받아오기.
			Member loginUser = (Member)request.getSession().getAttribute("loginUser");
			// 파라미터 처리
			Long mNo = m.getmNo();
			String birthday = m.getBirthday();
			String name = m.getName();
			String phone = m.getPhone();
			String gender = m.getGender();
			String content = m.getProfile().getpContent();
			if (birthday.length() != 8) throw new NullPointerException("생일 정보가 없습니다.");
			if (name.isEmpty()) throw new NullPointerException("입력된 이름이 없습니다.");
			if (phone == null || phone.isEmpty()) throw new NullPointerException("입력된 핸드폰 번호가 없습니다.");
			if (phone.length() != 11 ) throw new NullPointerException("올바른 형식이 아닙니다.");
			
			// Profile DB로 보낼 Bean 
			Profile profile = new Profile();
			profile.setpContent(content);
			profile.setId(loginUser.getId());
			ProfileRepository profileRepository = sqlSession.getMapper(ProfileRepository.class);
			profileRepository.updateContent(profile);
			map.put("profile", profile);

			// DB로 보낼 Bean 생성
			Member member = new Member();
			member.setmNo(mNo);
			member.setId(loginUser.getId());
			member.setName(name);
			member.setPw(loginUser.getPw());
			member.setPhone(phone);
			member.setBirthday(birthday);
			member.setGender(gender);
			MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
			int updateResult = memberRepository.updateMember(member);
			if (updateResult < 0 ) throw new PersistenceException("일치하는 회원정보가 없습니다");
			map.put("member", member);
			map.put("result", updateResult);
			// 세션에 올릴 로그인정보 업데이트
			loginUser = memberRepository.login(member);
			if (loginUser != null ) {
				request.getSession().invalidate();
				request.getSession().setAttribute("loginUser", loginUser);
			}
		} catch(NullPointerException e) {
			map.put("nullErrorMsg", e.getMessage());
		} catch(NumberFormatException e) {
			map.put("formatErrorMsg", e.getMessage());
		} catch(PersistenceException e) {
			map.put("updateErrorMsg", e.getMessage());
		} catch(Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	// 회원 탈퇴 // 받아올 파라미터 mNo
	public Map<String,Object> leaveMember(Long mNo) {
		// 파라미터 받기
		Map<String, Object> map = new HashMap<String, Object>();
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
		int result = memberRepository.leaveMember(mNo);
		map.put("result", result);
		
		return map;
	}
	
	// 관리자만 가능한 회원 활성화
    @Override
    public Map<String, Object> reInsertMember(Long mNo) {
    	Map<String, Object> map = new HashMap<String, Object>();
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
		int result = memberRepository.reInsertMember(mNo);
		map.put("result", result);
		return map;
    }
	
	@Override
	public Map<String, Object> checkPassword(HttpServletRequest request) {
		// 가입당시 비밀번호는 ajax 처리하여 pass true - false 매김 -- DB 에서 비밀번호 일치하는지 확인 필요.
		// 비밀번호가 일치하면 1 아니면 0
		//javax.mail.internet.AddressException: Illegal address in string ``''
		Map<String, Object> map = new HashMap<String, Object>();	
		try {
			String password = SecurityUtils.sha256(request.getParameter("pw"));
			MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
			int selectResult = memberRepository.selectPassword(password);
			map.put("selectResult", selectResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	
	// 회원비밀번호 변경
	@Override
	public void changePassword(HttpServletRequest request) {
		// 비밀번호 찾기 process 
		// 변경할 비밀번호와 비밀번호 재확인을 통해 비밀번호를 확인하고 -- pass true / false
		// 이후 통과되면 가입당시 입력한 이메일을 작성 -> 인증번호받고 인증하기 -- pass true / false
		// 다 끝난 뒤에 수정완료 버튼을 누르면 page이동 : 페이지는 내 정보 변경 mypage
		// 보낼 파라미터 새로운 pw / email
		Member member = new Member();
		member.setPw(SecurityUtils.sha256(request.getParameter("newPw")));
		System.out.println(request.getParameter("newPw"));
		member.setEmail(request.getParameter("email"));
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
		memberRepository.updatePw(member);
		System.out.println("결과 : " + memberRepository.updatePw(member));
		return;
	}

	
	
	
	// 관리자를 위한 페이지
	// 총 멤버 
	@Override
	public List<Member> selectMemberList() {
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
		List<Member> member = memberRepository.memberCount();
		return member;
	}
	
	// 남자 회원
	@Override
	public List<Member> selectMemberMen() {
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
		return memberRepository.memberMen();
	}
	
	// 여자 회원
	@Override
	public List<Member> selectMemberWomen() {
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
		return memberRepository.memberWomen();
	}
	// 성별없음 회원 
	@Override
	public List<Member> selectMemberNoGender() {
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
		return memberRepository.memberNoGender();
	}
	// 오늘 가입한 사람 목록
	@Override
	public List<Member> selectMemberCreatedDay() {
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
		return memberRepository.memberCreatedDay();
	}
	
	
	@Override
	public List<Member> memberAge10() {
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
		return memberRepository.memberAge10();
	}
	
	@Override
	public List<Member> memberAge20() {
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
		return memberRepository.memberAge20();
	}
	
	@Override
	public List<Member> memberAge30() {
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
		return memberRepository.memberAge30();
	}
	
	@Override
	public List<Member> memberAge40() {
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
		return memberRepository.memberAge40();
	}
	
	@Override
	public List<Member> memberAge50() {
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
		return memberRepository.memberAge50();
	}
	
	// 관리자가 회원 검색한 결과 받기
	@Override
	public Map<String, Object> findMember(HttpServletRequest request) {
	    MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
	      String query = request.getParameter("query");
	      String column = request.getParameter("column");
	      logger.info("column + query "+ column+", "+query);
	      
	      // 페이징2. 현재 페이지 번호 확인하기
	      // page가 안 넘어오면 page = 1로 처리함.
	      Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
	      int page = Integer.parseInt(opt.orElse("1"));
	      
	      Map<String, Object> dbMap = new HashMap<String, Object>();
	      dbMap.put("query", query);
	      dbMap.put("column", column);

	      //검색수
	      int cnt = memberRepository.selectFindRecordCount(dbMap);
	      
	      // 페이징3. 페이징에 필요한 모든 계산 처리하기
	      adminPage p = new adminPage();
	      p.setPageEntity(cnt, page);
	  
	  
	      dbMap.put("beginRecord", p.getBeginRecord()-1 );
	      dbMap.put("recordPerPage", p.getRecordPerPage());
	      
	      
	      // 검색 결과 리스트
	      List<Member> searchResult = memberRepository.selectFindList(dbMap);
	      System.out.println("검색 결과 리스트 : "+searchResult);
	      
	      int index = searchResult.size();
	      
	      
		// view에서 쓸 resultMap
	   Map<String, Object> resultMap = new HashMap<String, Object>();
			
			
		//  DB로 보낼 beginRecord, endRecord 작업 
		   resultMap.put("beginRecord", p.getBeginRecord()+"");
		   resultMap.put("endRecord", p.getEndRecord()+"");
		   resultMap.put("searchResult", searchResult); //list
		   resultMap.put("pageEntity", p.getPageEntity("/nearby/admin/findMember?column="+column+"&query="+query)); 
	       resultMap.put("startNum", cnt - (page - 1) * p.getRecordPerPage());
		   resultMap.put("cnt",cnt);
		   resultMap.put("index",index);
	       resultMap.put("query", query);
	       
	      return resultMap;
	  		
	}

	
	
	
}
