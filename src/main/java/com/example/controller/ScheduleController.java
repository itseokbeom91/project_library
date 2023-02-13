package com.example.controller;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.example.domain.BorrowVo;
import com.example.service.BookService;
import com.example.service.BorrowService;
import com.example.service.ReserveService;
import com.example.service.TotalBorrowService;

import lombok.extern.slf4j.Slf4j;

@Component
@EnableAsync
@Slf4j
public class ScheduleController {
	
	@Autowired
	private BookService bookService;
	
	@Autowired
	private ReserveService reserveService;
	
	@Autowired
	private BorrowService borrowService;
	
	@Autowired
	private TotalBorrowService totalBorrowService;
	
	
//	@Scheduled(fixedRate = 30000)
	@Scheduled(cron = "59 59 23 * * *")
	public void test1() {

		// 대출 2주 지난 책 가져오기
		List<BorrowVo> list = borrowService.isOverBorrow();
		
		if (list.isEmpty()) {
			log.info("대출 시간 지난 책 없음");
		} else {
			
			log.info("대출 시간 지난 책" + list);
//			log.info("첫번째 : " + list.get(0).toString());
//			log.info("두번째 : " + list.get(1).toString());
//			
//			log.info("첫번째의 책넘버 : " + list.get(0).getBookNum());
//			log.info("첫번째의 아이디 : " + list.get(0).getMemberId());
//			
//			log.info("몇개 : " + list.size());
			
			
			for(int i=0; i<list.size(); i++) {
				
				BorrowVo borrowVo = list.get(i);
				
				log.info(borrowVo.toString());
				
				// 대출테이블에서 삭제
				borrowService.delelteBorrow(borrowVo);
				
				// 대출 이력에 추가하기
				int totalCheck = totalBorrowService.totalBorrowDupCheck(borrowVo.getMemberId(), borrowVo.getBookNum());
				if (totalCheck != 1) {
					totalBorrowService.insertTotalBorrow(borrowVo);
				}
				
				// 예약중인 도서 유무 확인 (1~5)이면 있음
				int reserveCheck = reserveService.getCountReserveByBookNum(borrowVo.getBookNum());
				if (reserveCheck >= 1) { // 예약중인 도서 있을 때 
					
					// 해당 도서 예약 중 가장 빠른 번호 대출 테이블로 가져오기
					borrowService.changeReserveToBorrow(borrowVo.getBookNum());
					
					// 현재시간
					Timestamp borrowDate = new Timestamp(System.currentTimeMillis());
					
					// 2주 뒤 시간
					int twoWeeks = 1000 * 60 * 60 * 24 * 14;
					Timestamp overDate = new Timestamp(System.currentTimeMillis() + twoWeeks);
//					int test = 1000*30;
//					Timestamp overDate = new Timestamp(System.currentTimeMillis() + test);
					
					borrowVo.setBorrowDate(borrowDate);
					borrowVo.setOverDate(overDate);
					
					// 예약에서 넘어온 대출 도서 반납날짜 변경
					borrowService.updateDate(borrowVo.getBorrowDate(), borrowVo.getOverDate(), borrowVo.getBookNum());
					
					// 해당 정보 알람 테이브롤 이동
					borrowService.insertAlarm(borrowVo);
					
					// 예약 테이블에서 가장 빠른번호의 해당 도서 삭제하기
					reserveService.delelteReserve(borrowVo.getBookNum());
					
					// 도서 테이블에서 예약 카운트 1 감소
					bookService.subReserveCount(borrowVo.getBookNum());
				} else {
					// 도서 테이블에서 대출 카운트 1 감소
					bookService.subBorrowCount(borrowVo.getBookNum());
				}
			} // for
		}
		
		
		
		
		
		
	}

}
