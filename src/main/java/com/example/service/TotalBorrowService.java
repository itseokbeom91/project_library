package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.domain.BookVo;
import com.example.domain.BorrowVo;
import com.example.mapper.TotalBorrowMapper;

@Service
public class TotalBorrowService {
	
	@Autowired
	private TotalBorrowMapper totalBorrowMapper;
	
	
	// 해당도서 대출확인
	public int totalBorrowDupCheck(String memberId, int bookNum) {
		return totalBorrowMapper.totalBorrowDupCheck(memberId, bookNum);
	}
	
	// 대출이력에 추가하기
	public void insertTotalBorrow(BorrowVo borrowVo) {
		totalBorrowMapper.insertTotalBorrow(borrowVo);
	}

	// 대출이력 개수
	public int getCountTotalBorrow(String memberId) {
		return totalBorrowMapper.getCountTotalBorrow(memberId);
	}
	
	// 대풀이력 리스트
	public List<BookVo>	getTotalBorrowList(int startRow, int pageSize, String memberId) {
		return totalBorrowMapper.getTotalBorrowList(startRow, pageSize, memberId);
	}
}
