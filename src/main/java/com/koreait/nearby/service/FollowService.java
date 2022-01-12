package com.koreait.nearby.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.koreait.nearby.domain.Follow;
import com.koreait.nearby.domain.Profile;

@Service
public interface FollowService {
	
	public Map<String, Object> following(Follow follow, HttpSession session);
	public Map<String, Object> unfollowing(Follow follow, HttpSession session);
	public List<Follow> selectFollowingIdById(HttpSession session);
	public List<Follow> selectFollowedIdById(HttpSession session);
	public Map<String, Object> checkFollow(Follow follow, HttpSession session);
	public List<Follow> selectUserFollowingIdById(String id); 
	public List<Follow> selectUserFollowedIdById(String id); 
	public Profile selectUserProfileOnly(String id);
}
