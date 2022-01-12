package com.koreait.nearby.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.koreait.nearby.domain.Member;
import com.koreait.nearby.domain.Profile;
import com.koreait.nearby.repository.MemberRepository;
import com.koreait.nearby.repository.ProfileRepository;

public class ProfileServiceImpl implements ProfileService {
	
	private static final Logger logger = LoggerFactory.getLogger(ProfileServiceImpl.class);
	

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	// profile 사진 수정
	@Override
	public Map<String, Object> updateProfile(MultipartHttpServletRequest multipartRequest) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
				// 세션에 저장된 유저 정보 저장
				Member loginUser = (Member)multipartRequest.getSession().getAttribute("loginUser");
				System.out.println("loginUser info before update : " + loginUser);
				String id = loginUser.getId();
				
				// 파일 저장 경로 
				String sep = Matcher.quoteReplacement(File.separator);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String pPath = "resources" + sep + "upload" + sep + id + sep + "profile" + sep + sdf.format(new Date()).replaceAll("-", sep);
				String realPath = multipartRequest.getServletContext().getRealPath(pPath);
				
				// 디렉터리 생성 
				File dir = new File(realPath);
				if ( dir.exists() == false) dir.mkdirs();
				
				// 서버에서 받아온 파일 저장
				MultipartFile file = multipartRequest.getFile("file");
				System.out.println("서버에서 받아온 파일 값 : " +  file);
				// DB에 저장된 profile info 가져오기
				Profile profile = new Profile();
				ProfileRepository profileRepository = sqlSession.getMapper(ProfileRepository.class);
				Profile originProfile = profileRepository.selectProfile(id);
					if (file == null && originProfile.getpSaved() == null) { // 첨부된 파일과 DB에 저장된 정보 모두 없을 경우 null값 전달.
						System.out.println("if로 떨어지는지 확인해보기 ");
						profile.setpPath(pPath);
						profile.setpOrigin("");
						profile.setpSaved("");
						profile.setId(id);
					} else if(file == null) { // 첨부된 파일이 없을 경우, 이전 정보를 업데이트할 DTO에 실어준다.
						profile.setpPath(originProfile.getpPath());
						profile.setpOrigin(originProfile.getpOrigin());
						profile.setpSaved(originProfile.getpSaved());
						profile.setId(id);
					} else if (file != null && file.isEmpty() == false) { // 첨부된 파일이 있을경우 받아온 파일을 저장한다.
						String pOrigin = file.getOriginalFilename();
						String extName = pOrigin.substring(pOrigin.lastIndexOf("."));
						String uuid = UUID.randomUUID().toString().replaceAll("-", "");
						String pSaved = uuid + extName;
						File uploadFile = new File(realPath, pSaved);
						file.transferTo(uploadFile);
					
						profile.setpOrigin(pOrigin);
						profile.setpSaved(pSaved);
						profile.setpPath(pPath);
						profile.setId(id);
					} // End if
				
			// inf 문의 결과에 따른 profile DTO의 값을 DB에 저장
			int insertResult = profileRepository.updateProfile(profile);
			System.out.println("DB 저장 후 profile 값 : " + profile.toString());
			// 결과를 map에 실어준다.
			map.put("insertResult", insertResult);
			map.put("profile", profile);
			
			// set session loginUser info after update
			Member member = new Member();
			member.setId(id);
			member.setPw(loginUser.getPw());
			MemberRepository repository = sqlSession.getMapper(MemberRepository.class);
			loginUser = repository.login(member);
			System.out.println("loginUser information after update : " + loginUser);
			if (loginUser != null) {
				multipartRequest.getSession().invalidate();
				multipartRequest.getSession().setAttribute("loginUser", loginUser);
			}		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map; 
	} // End updateProfile
	
	
	// profile 사진 초기화
	@Override
	public Map<String, Object> deleteProfile(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Member loginUser = (Member)request.getSession().getAttribute("loginUser");
			Profile profile = new Profile();
			profile.setId(loginUser.getId());
			profile.setpPath("");
			profile.setpOrigin("");
			profile.setpSaved("");
			ProfileRepository profileRepository = sqlSession.getMapper(ProfileRepository.class);
			int deleteResult = profileRepository.updateProfile(profile);
			map.put("profile", profile);
			map.put("deleteResult", deleteResult);
			
			// set session loginUser info after update
			Member member = new Member();
			member.setId(loginUser.getId());
			member.setPw(loginUser.getPw());
			MemberRepository repository = sqlSession.getMapper(MemberRepository.class);
			loginUser = repository.login(member);
			System.out.println("loginUser information after update : " + loginUser);
			if (loginUser != null) {
				request.getSession().invalidate();
				request.getSession().setAttribute("loginUser", loginUser);
			}		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	} // End deleteProfile
	
	
	
} // End ProfileServiceImpl

