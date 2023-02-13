package com.example.mapper;

import java.sql.Timestamp;
import java.util.List;

import com.example.domain.BookVo;
import com.example.domain.ReserveVo;

public interface ReserveMapper {

	// 해당 도서 예약 확인
	int reserveDupCheck(String memberId, int bookNum);
	
	// 예약하기
	void reserveBook(String memberId, int bookNum, Timestamp reserveDate, Timestamp overDate);
	
	// 내서재 예약한 책 개수
	int getCountReserveById(String memberId);
	
	// 내서재 예약 목록
	List<BookVo> getReserveListById(String memberId);
	
	// 예약중인 도서 확인
	int getCountReserveByBookNum(int bookNum);
	
	// 대툴로 올릴 때 예약 테이블에서 삭제
	void delelteReserve(int bookNum);
	
	// 예약 취소하기
	void cancleReserve(ReserveVo reserveVo);
}
