package com.example.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.domain.AlarmVo;
import com.example.domain.BookVo;
import com.example.domain.BorrowVo;
import com.example.mapper.BorrowMapper;

@Service
public class BorrowService {

	@Autowired
	private BorrowMapper borrowMapper;
	
	// 해당도서 대출확인
	public int borrowDupCheck(String memberId, int bookNum) {
		return borrowMapper.borrowDupCheck(memberId, bookNum);
	}
	
	// 대출하기
	public void borrowBook(BorrowVo borrowVo) {
		borrowMapper.borrowBook(borrowVo);
	}
	
	// 내서재 대출한 책 개수
	public int getCountBorrowById(String memberId) {
		return borrowMapper.getCountBorrowById(memberId);
	}
	
	// 내서재 대촐 목록
	public List<BookVo> getBorrowListById(String memberId) {
		return borrowMapper.getBorrowListById(memberId);
	}
	
	// 반납하기
	public void delelteBorrow(BorrowVo borrowVo) {
		borrowMapper.delelteBorrow(borrowVo);
	}
	
	// 한 아이디 전체 반납하기
	public void deleteAll(String memberId) {
		borrowMapper.deleteAll(memberId);
	}
	
	// 예약 도서를 대출로 전환
	 public void changeReserveToBorrow(int bookNum) {
		 borrowMapper.changeReserveToBorrow(bookNum);
	 }
	 
	 // 대출로 전환한 도서 반납 시간 변경
	 public void updateDate(Timestamp borrowDate, Timestamp overDate, int bookNum) {
		 borrowMapper.updateDate(borrowDate, overDate, bookNum);
	 }
	 
	 // 예약할 때 해당 도서 젤 처음 반납예정 일 구하기
	 public String expectBorrowDate(int bookNum) {
		return borrowMapper.expectBorrowDate(bookNum);
	 }
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	// 대출로 전환된 도서 알람테이블에 가져오기
	public void insertAlarm(BorrowVo borrowVo) {
		borrowMapper.insertAlarm(borrowVo);
	}
	
	// 알람 개수 구하기
	public int getCountAlarm(String memberId) {
		return borrowMapper.getCountAlarm(memberId);
	}
	
	// 알람목록
	public List<BookVo> getAlarmList(String memberId) {
		return borrowMapper.getAlarmList(memberId);
	}
	
	// 알림 삭제하기
	public void deleteAlarm(AlarmVo alarmVo) {
		borrowMapper.deleteAlarm(alarmVo);
	}
	
	// 대출 2주 지났는지 확인
	 public List<BorrowVo> isOverBorrow() {
		 return borrowMapper.isOverBorrow();
	 }
	 
	 
//	 public void testDelete(List<BorrowVo> list) {
//		 borrowMapper.testDelete(list);
//	 }
	
}
