package com.koreait.nearby.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Service
public interface ProfileService {

	public Map<String, Object> updateProfile(MultipartHttpServletRequest multipartRequest);
	public Map<String, Object> deleteProfile(HttpServletRequest request);
}
