package com.koreait.nearby.repository;

import org.springframework.stereotype.Repository;

import com.koreait.nearby.domain.Profile;

@Repository
public interface ProfileRepository {
	
	// 프로필 등록
	public int insertProfile(Profile profile);

	// 프로필 사진수정 + 사진 초기화
	public int updateProfile(Profile profile);
	
	// 프로필 자기소개 수정
	public int updateContent(Profile profile);
	
	// 프로필 정보
	public Profile selectProfile(String id);
	
}
