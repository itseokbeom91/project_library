package com.example.mapper;

import java.util.HashMap;

import com.example.domain.MemberVo;

public interface MemberMapper {

	// 회원가입
	void addMember(MemberVo memberVo);
	
	// 아이디 중복 체크
	int getCountById(String id);
	
	// 로그인시 아이디 패스워드 일치 여부
	String userCheck(String id);
	
	// 아이디 찾기
	MemberVo idSearch(MemberVo memberVo);

	// 비밀번호 찾기
	MemberVo passwdSearch(MemberVo memberVo);
	
	// 비밀번호찾기에서 비밀번호 생성
	void updatePasswd(String passwd, String id);
	
	// 회원정보 가져오기
	MemberVo update(String id);

	// 회원정보 수정
	void updateMember(MemberVo memberVo);

}
