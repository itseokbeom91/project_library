package com.example.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.domain.BookVo;
import com.example.domain.PageDto;
import com.example.service.BookService;
import com.example.service.MySqlService;

import lombok.extern.java.Log;

@Controller
@Log
@RequestMapping("/book/*")
public class BookController {
	
	@Autowired
	private BookService bookService;
	
	@Autowired
	private MySqlService mySqlService;
	
	
	
	
	// upload 날짜 폴더 생성
	private String getFolder() {
		// 오늘날짜 년월일 폴더가 존재하는지 확인해서 없으면 생성하기
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		String strDate = sdf.format(date); // "2020/11/11"
		return strDate;
	} // getFoler
	
	
	// 도서 등록 페이지 이동
	@GetMapping("/insert")
	public String insert() {
		return "book/insertBook";
	} // insert
	
	
	// 도서 등록
	@PostMapping("/insert")
	public String insert(BookVo bookVo, HttpServletRequest request, @RequestParam("file") MultipartFile multiPartFile) throws IOException {
		
		int num = mySqlService.getNextNum("notice"); // insert될 글번호 가져오기
		bookVo.setNum(num);
		bookVo.setBorrowCount(0);
		bookVo.setReserveCount(0);
		bookVo.setTotalBorrow(0);
		bookVo.setRecommendCount(0);
		
		
		// ========== 파일 업로드를 위한 폴더준비 ========
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/"); // webapp 폴더의 실제경로
		
		File dir = new File(realPath + "/upload");
		
		if (!dir.exists()) {
			dir.mkdirs();
		}
		
		// 파일 이름 가져오기
		String filename = multiPartFile.getOriginalFilename();
		
		// 생성할 파일정보를 File 객체로 준비
		File saveFile = new File(dir, filename);
		
		multiPartFile.transferTo(saveFile);
		
		
		bookVo.setCover(filename);
		
		
		bookService.insertBook(bookVo);
		
		return "redirect:/book/list";
	} // insert
	
	
	
	// 도서 목록
	@GetMapping("/list")
	public String list(
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "") String category,
			@RequestParam(defaultValue = "") String search,
			Model model) {
		
		// 검색어 기준으로 도서 수 가져오기
		int bookCount = bookService.getCountBySearch(category, search);
		int bestCount = 10;
		int recommendCount = 10;
		// 한페이지당 보여줄 글갯수 설정
		int pageSize = 10;

		// 가져올 첫행번호 구하기
		int startRow = (pageNum - 1) * pageSize;

		// 도서목록
		List<BookVo> bookList = null;
		if (bookCount > 0) {
			
			bookList = bookService.getListBySearch(startRow, pageSize, category, search);
		}
		
		List<BookVo> bestBookList = null;
		if (bestCount > 0) {
			
			bestBookList = bookService.getBestBooks(startRow, pageSize);
		}
		
		List<BookVo> recommendList = null;
		if (recommendCount > 0) {
			
			recommendList = bookService.getRecommendBooks(startRow, pageSize);
		}
		
		log.info("전채 책 권수 : " + bookCount);
		
		// ==================================================
		// 페이지블록 관련정보 구하기 작업
		// ==================================================
		
		PageDto pageDto = new PageDto();
		
		// 글갯수가 0보다 크면 페이지블록 계산해서 출력하기
		if (bookCount > 0) {
			// 총 필요한 페이지 갯수 구하기
			// 글50개. 한화면에보여줄글 10개 => 50/10 = 5 
			// 글55개. 한화면에보여줄글 10개 => 55/10 = 5 + 1페이지(나머지존재) => 6
			int pageCount = (bookCount / pageSize) + (bookCount % pageSize == 0 ? 0 : 1);
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
			pageDto.setCategory(category);
			pageDto.setSearch(search);
			pageDto.setCount(bookCount);
			pageDto.setPageCount(pageCount);
			pageDto.setPageBlock(pageBlock);
			pageDto.setStartPage(startPage);
			pageDto.setEndPage(endPage);
		} // if
		
		// 뷰(jsp)에서 사용할 데이터를 request 영역객체에 저장
		model.addAttribute("bookList", bookList);
		model.addAttribute("bestBookList", bestBookList);
		model.addAttribute("recommendList", recommendList);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("pageNum", pageNum);
		
		
		return "book/bookList";
	} // list
	
	
	
	// 신간 목록
	@GetMapping("/newBooks")
	public String newBooks(@RequestParam(defaultValue = "1") int pageNum, Model model) {
		// 신간 기준 : 당일 기준 저번달부터 오늘까지 출간된 도서

		SimpleDateFormat day = new SimpleDateFormat("yyyyMMdd");
		
		// 오늘날짜		
		String thisDay = day.format(System.currentTimeMillis());
		
		// 해당달
		int thisMonth = Integer.parseInt(thisDay.substring(4, 6));
		
		// 저번달
		int lastMonth = 0;
		if (thisMonth == 1) {
			lastMonth = 12;
		} else {
			lastMonth = thisMonth -1;
		}
		
		// 1월일 경우 저번달은 작년 12월로 계산
		// 올해
		int thisYear = Integer.parseInt(thisDay.substring(0, 4));
		
		// 작년
		int latMothYear = Integer.parseInt(thisDay.substring(0, 4));
		
		if (thisMonth == 1) {
			latMothYear -= 1;
		}
		
		String strThisMonth = String.format("%02d", thisMonth);
		String strLastMonth = String.format("%02d", lastMonth);
		String strThisYear = Integer.toString(thisYear);
		String strLatMothYear = Integer.toString(latMothYear);
		
		

		// 전체 글갯수 가져오기
		int count = bookService.getCountByNewBooks(strThisMonth, strThisYear, strLastMonth, strLatMothYear); // 검색어 기준으로 글갯수 가져오기
				
		// 한페이지당 보여줄 글갯수 설정
		int pageSize = 10;

		// 가져올 첫행번호 구하기
		int startRow = (pageNum - 1) * pageSize;

		// 글목록 가져오기
		List<BookVo> bookList = null;
		if (count > 0) {
			//noticeList = noticeDao.getNotices(startRow, pageSize);
			bookList = bookService.getListByNewBooks(startRow, pageSize, strThisMonth, strThisYear, strLastMonth, strLatMothYear);
		}
		
		log.info("신간 권수 : " + count);
		
		// ==================================================
		// 페이지블록 관련정보 구하기 작업
		// ==================================================
		
		PageDto pageDto = new PageDto();
		
		// 글갯수가 0보다 크면 페이지블록 계산해서 출력하기
		if (count > 0) {
			// 총 필요한 페이지 갯수 구하기
			// 글50개. 한화면에보여줄글 10개 => 50/10 = 5 
			// 글55개. 한화면에보여줄글 10개 => 55/10 = 5 + 1페이지(나머지존재) => 6
			int pageCount = (count / pageSize) + (count % pageSize == 0 ? 0 : 1);
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
			pageDto.setCount(count);
			pageDto.setPageCount(pageCount);
			pageDto.setPageBlock(pageBlock);
			pageDto.setStartPage(startPage);
			pageDto.setEndPage(endPage);
		} // if
		
		
		// 뷰(jsp)에서 사용할 데이터를 request 영역객체에 저장
		model.addAttribute("bookList", bookList);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("pageNum", pageNum);
		
		
		return "book/newBookList";
		
	} // newBooks
	
	
	// 베스트 목록
	@GetMapping("/bestBooks")
	public String bestBooks(
			@RequestParam(defaultValue = "1") int pageNum,
//			@RequestParam(defaultValue = "") String category,
//			@RequestParam(defaultValue = "") String search,
			Model model) {
		
		// 검색어 기준으로 도서 수 가져오기
		int count = 10;
				
		// 한페이지당 보여줄 글갯수 설정
		int pageSize = 10;

		// 가져올 첫행번호 구하기
		int startRow = (pageNum - 1) * pageSize;

		// 도서목록
		List<BookVo> bookList = null;
		if (count > 0) {
			
			bookList = bookService.getBestBooks(startRow, pageSize);
		}
		
		log.info("전채 책 권수 : " + count);
		
		// ==================================================
		// 페이지블록 관련정보 구하기 작업
		// ==================================================
		
		PageDto pageDto = new PageDto();
		
		// 글갯수가 0보다 크면 페이지블록 계산해서 출력하기
		if (count > 0) {
			// 총 필요한 페이지 갯수 구하기
			int pageCount = (count / pageSize) + (count % pageSize == 0 ? 0 : 1);
			//int pageCount = (int) Math.ceil((double) count / pageSize);
			
			// 한 화면에 보여줄 페이지갯수 설정
			int pageBlock = 5;
			
			// 화면에 보여줄 시작페이지번호 구하기
			int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
			
			// 화면에 보여줄 끝페이지번호 구하기
			int endPage = startPage + pageBlock - 1;
			if (endPage > pageCount) {
				endPage = pageCount;
			}
			
			// 뷰에서 필요한 데이터를 PageDto에 저장
			pageDto.setCount(count);
			pageDto.setPageCount(pageCount);
			pageDto.setPageBlock(pageBlock);
			pageDto.setStartPage(startPage);
			pageDto.setEndPage(endPage);
		} // if
		
		// 뷰(jsp)에서 사용할 데이터를 request 영역객체에 저장
		model.addAttribute("bookList", bookList);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("pageNum", pageNum);
		
		
		return "book/bestBooks";
	}
	
	// 도서 상세페이지
	@GetMapping("/content")
	public String content(int num, String pageNum, Model model) {
		
		// 글 한개 가져오기
		BookVo bookVo = bookService.getBookByNum(num);
		
		// 글 내용에서 "\n" 줄바꿈 문자열을 "<br>"로 교체하기
		if (bookVo.getIntroduceBook() != null) {
			String content = bookVo.getIntroduceBook().replace("\n", "<br><br>");
			bookVo.setIntroduceBook(content);
		}
		if (bookVo.getIntroduceWriter() != null) {
			String content = bookVo.getIntroduceWriter().replace("\n", "<br><br>");
			bookVo.setIntroduceWriter(content);
		}
		if (bookVo.getNeckKick() != null) {
			String content = bookVo.getNeckKick().replace("\n", "<br><br>");
			bookVo.setNeckKick(content);
		}
		
		// 댓글 리스트 불러오기
//		List<ReviewVo> reviewList = reviewService.getReviewList(num);
		
		// 뷰(jsp)에서 사용할 데이터를 request 영역객체에 저장
		model.addAttribute("bookVo", bookVo);
		model.addAttribute("pageNum", pageNum);
//		model.addAttribute("reviewList", reviewList);

		return "book/bookContent";
	}
	
	
	
	
	
	
	
	
	

}
