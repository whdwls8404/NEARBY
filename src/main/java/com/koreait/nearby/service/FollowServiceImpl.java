package com.koreait.nearby.service;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.koreait.nearby.domain.Follow;
import com.koreait.nearby.domain.Member;
import com.koreait.nearby.domain.Profile;
import com.koreait.nearby.repository.FollowRepository;
import com.koreait.nearby.repository.ProfileRepository;

public class FollowServiceImpl implements FollowService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	// 팔로잉
	@Override
	public Map<String, Object> following(Follow f, HttpSession session) {
		
		FollowRepository followRepository = sqlSession.getMapper(FollowRepository.class); 
		
		   Follow follow = new Follow();
		   follow.setFollowedId(f.getFollowedId());
		   Member user = (Member)session.getAttribute("loginUser");
		   follow.setFollowingId(user.getId());
		
		   int result = followRepository.following(follow);   
		   
		   Map<String, Object> map = new HashMap<String, Object>();
		   map.put("result", result);
		
		return map;
	}
	
	
	// 언팔
	@Override
	public Map<String, Object> unfollowing(Follow f, HttpSession session) {
		FollowRepository followRepository = sqlSession.getMapper(FollowRepository.class); 
		
		   Follow follow = new Follow();
		   follow.setFollowedId(f.getFollowedId());
		   Member user = (Member)session.getAttribute("loginUser");
		   follow.setFollowingId(user.getId());
		   
		   int result = followRepository.unfollowing(follow);   
		   
		   Map<String, Object> map = new HashMap<String, Object>();
		   
		   map.put("result", result);
		return map;
	}
	
	 

	// 팔로잉 하는 사람 리스트
	@Override
	public List<Follow> selectFollowingIdById(HttpSession session) {
		
		
		
		FollowRepository followRepository = sqlSession.getMapper(FollowRepository.class);
		
		Member user = (Member)session.getAttribute("loginUser");
		String id = user.getId();
		
		
		List<Follow> list = followRepository.selectFollowingIdById(id); 

		return list;
	}
	
	// 팔로우 하는 사람 리스트
	@Override
	public List<Follow> selectFollowedIdById(HttpSession session) {

		FollowRepository followRepository = sqlSession.getMapper(FollowRepository.class);
		
		Member user = (Member)session.getAttribute("loginUser");
		String id = user.getId();
		
		List<Follow> list = followRepository.selectFollowedIdById(id);

		
		return list;
		
	}
	@Override
	public List<Follow> selectUserFollowedIdById(String id) {
		FollowRepository followRepository = sqlSession.getMapper(FollowRepository.class);
		
		List<Follow> list = followRepository.selectFollowedIdById(id);
	
		
		
		return list;
	}
	
	@Override
	public List<Follow> selectUserFollowingIdById(String id) {
		
		FollowRepository followRepository = sqlSession.getMapper(FollowRepository.class);
		List<Follow> list = followRepository.selectFollowingIdById(id);
		return list;
	}
	
	// 프로필만 가져오기
	@Override
	public Profile selectUserProfileOnly(String id) {
		ProfileRepository profileRepository = sqlSession.getMapper(ProfileRepository.class);
		Profile profile =profileRepository.selectProfile(id);
		return profile;
	}
	
	
	// 팔로잉 체크
	@Override
	public Map<String, Object> checkFollow(Follow f, HttpSession session) {
		
		FollowRepository followRepository = sqlSession.getMapper(FollowRepository.class);
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		String followingId = loginUser.getId();
		String id = f.getProfile().getId();
		System.out.println("서비스 임플 followingId : " + followingId);
		
		Map<String, Object> dbmap = new HashMap<String, Object>();
		dbmap.put("followingId", followingId);
		dbmap.put("id", id);
		
		
		int result = followRepository.checkFollow(dbmap);
		
		System.out.println("디비다녀온결과" + result);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		return map;
	}
	
	 
	
	
}
