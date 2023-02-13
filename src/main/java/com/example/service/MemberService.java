package com.example.service;

import java.util.HashMap;
import java.util.Random;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.MemberVo;
import com.example.mapper.MemberMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class MemberService {
	
	@Autowired
	private MemberMapper memberMapper;

	
	// 회원가입
	public void addMember(MemberVo memberVo) {
		memberMapper.addMember(memberVo);
	}
	
	// 아이디 중복 체크
	public int getCountById(String id) {
		return memberMapper.getCountById(id);
	}
	
	
	// 로그인시 아이디 패스워드 일치 여부
	public int userCheck(String id, String passwd) {
		int check = -1;
		
		String dbPasswd = memberMapper.userCheck(id);
		
		if (dbPasswd != null) {
			if (BCrypt.checkpw(passwd, dbPasswd)) { // passwd.equals(dbPasswd)
				check = 1;
			} else {
				check = 0;
			}
		} else { // dbPasswd == null
			check = -1;
		}
		return check;
	}
	
	
	// 아이디 찾기
	public MemberVo idSearch(MemberVo memberVo) {
		
		return memberMapper.idSearch(memberVo);
	}
	
	
	// 비밀번호 찾기
	public MemberVo passwdSearch(MemberVo memberVo) {
		return memberMapper.passwdSearch(memberVo);
	}
	
	// 비밀번호 생성
	public void updatePasswd(String passwd, String id) {
		String hashPasswd = BCrypt.hashpw(passwd, BCrypt.gensalt());
		memberMapper.updatePasswd(hashPasswd, id);
	}
	
	public MemberVo update(String id) {
		return memberMapper.update(id);
	}
	
	public void updateMember(MemberVo memberVo) {
		memberMapper.updateMember(memberVo);
	}

	
	
	
}
