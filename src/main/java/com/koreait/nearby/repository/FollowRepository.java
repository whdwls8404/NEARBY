package com.koreait.nearby.repository;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.koreait.nearby.domain.Follow;

@Repository
public interface FollowRepository {
	public int following(Follow follow);
	public int unfollowing(Follow follow);
	public int deleteLeaveMebmberFollow(Long mNo);
	public List<Follow> selectFollowingIdById(String id);
	public List<Follow> selectFollowedIdById(String id);
	public int checkFollow(Map<String, Object> map);
	
}