package com.example.mapper;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.example.domain.AlarmVo;
import com.example.domain.BookVo;
import com.example.domain.BorrowVo;
import com.example.domain.ReserveVo;

public interface BorrowMapper {

	// 해당 도서 대출확인
	int borrowDupCheck(String memberId, int bookNum);
	
	// 대출하기
	void borrowBook(BorrowVo borrowVo);
	
	// 내서재 대출한 책 개수
	int getCountBorrowById(String memberId);
	
	// 내서재 대출 목록
	List<BookVo> getBorrowListById(String memberId);
	
	// 반납하기
	void delelteBorrow(BorrowVo borrowVo);
	
	// 한 아이디 전제 반납하기
	void deleteAll(String memberId);
	
	// 예약 도서를 대출로 전환
	void changeReserveToBorrow(int bookNum);
	
	// 대출로 전환한 도서 반납 시간 변경
	void updateDate(Timestamp borrowDate, Timestamp overDate, int bookNum);
	
	// 예약할 때 해당 도서 젤 처음 반납예정 일 구하기
	String expectBorrowDate(int bookNum);
	
	
	// 대출로 전환된 도서 알람테이블에 가져오기
	void insertAlarm(BorrowVo borrowVo);
	
	// 알람 개수 구하기
	int getCountAlarm(String memberId);
	
	// 알람목록
	List<BookVo> getAlarmList(String memberId);
	
	// 알림 삭제하기
	void deleteAlarm(AlarmVo alarmVo);
	
	// 대출 2주 지났는지 확인
	List<BorrowVo> isOverBorrow();
	
//	void testDelete(List<BorrowVo> list);
}
