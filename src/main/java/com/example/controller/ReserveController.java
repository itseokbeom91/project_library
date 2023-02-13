package com.example.controller;

import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.domain.ReserveVo;
import com.example.service.BookService;
import com.example.service.BorrowService;
import com.example.service.ReserveService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/use/*")
public class ReserveController {
	
	@Autowired
	private ReserveService reserveService;
	
	@Autowired
	private BorrowService borrowService;
	
	@Autowired
	private BookService bookService;

	@GetMapping("/reserve")
	public ResponseEntity<String> reserveBook(String memberId, int bookNum) throws Exception {
		
		// 중복 예약 확인
		int reserveCheck = reserveService.reserveDupCheck(memberId, bookNum);
		
		// 이미 대출해 있는 도서 확인
		int borrowCheck = borrowService.borrowDupCheck(memberId, bookNum);
		
		if (borrowCheck == 1) {
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");
			
			StringBuilder sb = new StringBuilder();
			sb.append("<script>");
			sb.append("	alert('이미 대출중인 책입니다..');");
			sb.append("	history.back();");
			sb.append("</script>");
			
			return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
		} else {
			if (reserveCheck == 1) { // 책이 중복일시
				HttpHeaders headers = new HttpHeaders();
				headers.add("Content-Type", "text/html; charset=UTF-8");
				
				StringBuilder sb = new StringBuilder();
				sb.append("<script>");
				sb.append("	alert('이미 예약중인 책입니다..');");
				sb.append("	history.back();");
				sb.append("</script>");
				
				return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
			} else {
				// 한 아이디 당 예약한 권수
				int reserveCount = reserveService.getCountReserveById(memberId);
				log.info("카운트 : " + reserveCount);
				
				if (reserveCount > 4) {
					HttpHeaders headers = new HttpHeaders();
					headers.add("Content-Type", "text/html; charset=UTF-8");
					
					StringBuilder sb = new StringBuilder();
					sb.append("<script>");
					sb.append("	alert('동시에 5권까지 예약이 가능합니다..');");
					sb.append("	history.back();");
					sb.append("</script>");
					
					return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
				} else {
					// 현재시간
					Timestamp reserveDate = new Timestamp(System.currentTimeMillis());
					
					// 해당 도서 가장 빨리 반납될 날짜
					String  strOverDate = borrowService.expectBorrowDate(bookNum);
					Timestamp overDate = Timestamp.valueOf(strOverDate);
					
					reserveService.reserveBook(memberId, bookNum, reserveDate, overDate);
					bookService.addReserveCount(bookNum);
				}
			} // if else (reserveCheck)
		} // if else (borrowCheck)
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("location", "/book/list");
		
		return new ResponseEntity<String>(headers, HttpStatus.FOUND);
	}

}
