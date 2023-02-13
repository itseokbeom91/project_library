package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.domain.BookVo;
import com.example.domain.BorrowVo;

public interface TotalBorrowMapper {

	// 해당 도서 대출이력 확인
	int totalBorrowDupCheck(String memberId, int bookNum);
	
	// 대출이력에 추가하기
	void insertTotalBorrow(BorrowVo borrowVo);
	
	// 대출이력 개수
	int getCountTotalBorrow(String memberId);
	
	// 대출이력 리스트
	List<BookVo> getTotalBorrowList(
			@Param("startRow") int startRow, 
			@Param("pageSize") int pageSize, String memberId);
	
}
