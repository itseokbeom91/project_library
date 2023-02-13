package com.example.controller;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.domain.AlarmVo;
import com.example.domain.BookVo;
import com.example.domain.BorrowVo;
import com.example.domain.PageDto;
import com.example.domain.ReserveVo;
import com.example.service.BookService;
import com.example.service.BorrowService;
import com.example.service.RecommendWishService;
import com.example.service.ReserveService;
import com.example.service.TotalBorrowService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/my/*")
public class MypageController {
	
	@Autowired
	private BookService bookService;
	
	@Autowired
	private BorrowService borrowService;
	
	@Autowired
	private ReserveService reserveService;
	
	@Autowired
	private TotalBorrowService totalBorrowService;
	
	@Autowired
	private RecommendWishService recommendWishService;
	
	
	
	// 내서재 페이지로 이동
	@GetMapping("/mypage")
	public String getBorrowListById(
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam("id") String memberId, Model model) {
		
		// 대출한 책, 예약한 책, 대출이력, 알람, 찜한 책 개수 가져오기
		int borrowCount = borrowService.getCountBorrowById(memberId);
		int reserveCount = reserveService.getCountReserveById(memberId);
		int totalBorrowCount = totalBorrowService.getCountTotalBorrow(memberId);
		int alarmCount = borrowService.getCountAlarm(memberId);
		int wishCount = recommendWishService.getCountWishById(memberId);

		// 대출, 예약, 알람, 찜한 책 번호 가져오기
		List<BookVo> borrowList = null;
		if (borrowCount > 0) {
			borrowList = borrowService.getBorrowListById(memberId);
		}
		
		List<BookVo> reserveList = null;
		if (reserveCount > 0) {
			reserveList = reserveService.getReserveListById(memberId);
		}
		
		List<BookVo> alarmList = null;
		if (alarmCount > 0) {
			alarmList = borrowService.getAlarmList(memberId);
		}
		
		List<BookVo> wishList = null;
		if (wishCount > 0) {
			wishList = recommendWishService.getWishList(memberId);
		}
		
		
		
		
		
		
		// ==================================================
		// 대출이력 가져오기
		// ==================================================
		
		
		// 한페이지당 보여줄 글갯수 설정
		int pageSize = 10;

		// 가져올 첫행번호 구하기
		int startRow = (pageNum - 1) * pageSize;

		// 도서목록
		List<BookVo> totalBorrwoList = null;
		if (totalBorrowCount > 0) {
			
			totalBorrwoList = totalBorrowService.getTotalBorrowList(startRow, pageSize, memberId);
		}
		
		log.info("대출이력 권수 : " + totalBorrowCount);
		
		// ==================================================
		// 페이지블록 관련정보 구하기 작업
		// ==================================================
		
		PageDto pageDto = new PageDto();
		
		// 글갯수가 0보다 크면 페이지블록 계산해서 출력하기
		if (totalBorrowCount > 0) {
			// 총 필요한 페이지 갯수 구하기
			// 글50개. 한화면에보여줄글 10개 => 50/10 = 5 
			// 글55개. 한화면에보여줄글 10개 => 55/10 = 5 + 1페이지(나머지존재) => 6
			int pageCount = (totalBorrowCount / pageSize) + (totalBorrowCount % pageSize == 0 ? 0 : 1);
			//int pageCount = (int) Math.ceil((double) count / pageSize);
			
			// 한 화면에 보여줄 페이지갯수 설정
			int pageBlock = 5;
			
			// 화면에 보여줄 시작페이지번호 구하기
			// 1~5          6~10          11~15          16~20       ...
			// 1~5 => 1     6~10 => 6     11~15 => 11    16~20 => 16
			int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
			
			// 화면에 보여줄 끝페이지번호 구하기
			int endPage = startPage + pageBlock - 1;
			if (endPage > pageCount) {
				endPage = pageCount;
			}
			
			// 뷰에서 필요한 데이터를 PageDto에 저장
			pageDto.setCount(totalBorrowCount);
			pageDto.setPageCount(pageCount);
			pageDto.setPageBlock(pageBlock);
			pageDto.setStartPage(startPage);
			pageDto.setEndPage(endPage);
		} // if
		
		
		// 뷰(jsp)에서 사용할 데이터를 request 영역객체에 저장
		model.addAttribute("borrowList", borrowList);
		model.addAttribute("reserveList", reserveList);
		model.addAttribute("totalBorrwoList", totalBorrwoList);
		model.addAttribute("alarmList", alarmList);
		model.addAttribute("wishList", wishList);
		
		return "member/mypage";
	}
	
	
	
	// 대출 반납하기
	@GetMapping("/returnBorrow")
	public String returnBorrow(BorrowVo borrowVo) {
		
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
//			int test = 1000*30;
//			Timestamp overDate = new Timestamp(System.currentTimeMillis() + test);
			
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
		return "redirect:/my/mypage?id=" + borrowVo.getMemberId();
	}
	
	
	// 예약 취소하기
	@GetMapping("/returnReserve")
	public String returnReserve(ReserveVo reserveVo) {
		
		// 예약 테이블에서 삭제하기
		reserveService.cancleReserve(reserveVo);
		
		// 도서 테이블에서 예약 카운트 1 감소
		bookService.subReserveCount(reserveVo.getBookNum());
		
		return "redirect:/my/mypage?id=" + reserveVo.getMemberId();
	}
	
	
	// 알림 삭제하기
	@GetMapping("/deleteAlarm")
	public String deleteAlarm(AlarmVo alarmVo) {
		
		borrowService.deleteAlarm(alarmVo);
		
		return "redirect:/my/mypage?id=" + alarmVo.getMemberId();
	}
	
	
	
	
}
