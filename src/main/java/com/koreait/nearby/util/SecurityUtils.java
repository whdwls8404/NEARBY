package com.koreait.nearby.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.koreait.nearby.service.MemberServiceImpl;

public class SecurityUtils {
	
	// 로그  
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	
	// 크로스 사이트 스크립트(XXS)
	// 스크립트 코드 입력을 무력화
	public String xxs(String str) {
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll(">", "&gt;");
		str = str.replaceAll("&", "&amp;");
		str = str.replaceAll("\"", "&quot;");
		return str;
	}
	
	// 자바 security 암호화
	// SHA-256 : 입력 -> 256비트(32바이트) 암호화 처리(복호는 불가)
	// 1바이트가 2글자로 표현되므로 DB필드는 64로 설정
	public static String sha256(String str) {
		MessageDigest md = null;
		try {
			md = MessageDigest.getInstance("SHA-256");
			md.update(str.getBytes());
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		// md.digest() : 입력된 문자열이 암호화된 32바이트 배열
		StringBuilder sb = new StringBuilder();
		for (byte b : md.digest()) {  // 1바이트를 2글자 16진수로 변환
			sb.append(String.format("%02X", b));
		}
		return sb.toString();
	}
	
	// 스프링 암호화/복호화
	// commons-codec 디펜던시
	
	// 암호 : 1111 -> alciun=-19kdi
	public static String encodeBase64(String str) {
		return new String(Base64.encodeBase64(str.getBytes()));
	}
	// 복호 : alciun=-19kdi -> 1111
	public static String decodeBase64(String str) {
		return new String(Base64.decodeBase64(str.getBytes()));
	}
	
	// 인증코드 생성
	public static String authCode(int length) {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < length; i++) {
			if (Math.random() < 0.5) {
				sb.append( (char)((int)(Math.random() * 26) + 'A') );
			} else {
				sb.append( (char)((int)(Math.random() * 10) + '0') );
			}
		}
		logger.info("인증번호 : "+sb.toString()); // 인증번호 확인용
		return sb.toString();
	}

}
