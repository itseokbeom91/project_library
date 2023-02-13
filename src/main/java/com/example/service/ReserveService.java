package com.example.service;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.domain.BookVo;
import com.example.domain.ReserveVo;
import com.example.mapper.ReserveMapper;

@Service
public class ReserveService {
	
	@Autowired
	private ReserveMapper reserveMapper;
	
	// 해당 도서 예약 확인
	public int reserveDupCheck(String memberId, int bookNum) {
		return reserveMapper.reserveDupCheck(memberId, bookNum);
	}
	
	// 예약하기
	public void reserveBook(String memberId, int bookNum, Timestamp reserveDate, Timestamp overDate) {
		reserveMapper.reserveBook(memberId, bookNum, reserveDate, overDate);
	}
	
	// 내서재 예약한 책 개수
	public int getCountReserveById(String memberId) {
		return reserveMapper.getCountReserveById(memberId);
	}
	
	// 내서재 예약 목록
	public List<BookVo> getReserveListById(String memberId) {
		return reserveMapper.getReserveListById(memberId);
	}
	
	// 예약중인 도서 확인
	public int getCountReserveByBookNum(int bookNum) {
		return reserveMapper.getCountReserveByBookNum(bookNum);
	}

	// 대툴로 올릴 때 예약 테이블에서 삭제
	public void delelteReserve(int bookNum) {
		reserveMapper.delelteReserve(bookNum);
	}
	
	// 예약 취소하기
	public void cancleReserve(ReserveVo reserveVo) {
		reserveMapper.cancleReserve(reserveVo);
	}
}
