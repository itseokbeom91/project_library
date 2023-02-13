package com.example.controller;

import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.domain.BookVo;
import com.example.domain.BorrowVo;
import com.example.domain.PageDto;
import com.example.domain.ReserveVo;
import com.example.service.BookService;
import com.example.service.BorrowService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/use/*")
public class BorrowController {
	
	@Autowired
	private BorrowService borrowService;
	
	@Autowired
	private BookService bookService;

	
	// 대출하기
	@GetMapping("/borrow")
	public ResponseEntity<String> borrowBook(BorrowVo borrowVo) throws Exception {
		
		// 중복 대출 확인
		int check = borrowService.borrowDupCheck(borrowVo.getMemberId(), borrowVo.getBookNum());
		
		if (check == 1) {
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");
			
			StringBuilder sb = new StringBuilder();
			sb.append("<script>");
			sb.append("	alert('이미 대출중인 책입니다..');");
			sb.append("	history.back();");
			sb.append("</script>");
			
			return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
		} else {
			// 한 아이디당 대출한 권수
			int borrowCount = borrowService.getCountBorrowById(borrowVo.getMemberId());
			log.info("카운트 : " + borrowCount);
			
			if (borrowCount > 4) {
				HttpHeaders headers = new HttpHeaders();
				headers.add("Content-Type", "text/html; charset=UTF-8");
				
				StringBuilder sb = new StringBuilder();
				sb.append("<script>");
				sb.append("	alert('동시에 5권까지 대출이 가능합니다..');");
				sb.append("	history.back();");
				sb.append("</script>");
				
				return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
			} else {
				// 현재시간
				Timestamp borrowDate = new Timestamp(System.currentTimeMillis());
				
				// 2주 뒤 시간
				int twoWeeks = 1000 * 60 * 60 * 24 * 14;
				Timestamp overDate = new Timestamp(System.currentTimeMillis() + twoWeeks);
				
//				int test = 1000*60;
//				Timestamp twoWeeks = new Timestamp(System.currentTimeMillis() + test);
				borrowVo.setBorrowDate(borrowDate);
				borrowVo.setOverDate(overDate);
				borrowService.borrowBook(borrowVo);
				bookService.addBorrowCount(borrowVo.getBookNum());
				bookService.addTotalBorrow(borrowVo.getBookNum());
			}
		}
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("location", "/book/list");
		
		return new ResponseEntity<String>(headers, HttpStatus.FOUND);
		
//				?memberId=" + borrowVo.getMemberId() + "&bookNum=" + borrowVo.getBookNum()
	}
	
	
	
	
}
