package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.domain.RecommendWishVo;
import com.example.service.BookService;
import com.example.service.RecommendWishService;

@Controller
@RequestMapping("/use/*")
public class RecommendWishController {
	
	@Autowired
	private RecommendWishService recommendWishService;
	
	@Autowired
	private BookService bookService;
	
	
	// 추천하기
	@GetMapping("recommend")
	public ResponseEntity<String> recommend(RecommendWishVo recommendWishVo) throws Exception {
		
		// 추천 중복 확인
		int recommendCheck = recommendWishService.recommendDupCheck(recommendWishVo.getMemberId(), recommendWishVo.getBookNum());
		
		// 찜하기 여부 확인
		int wishCheck = recommendWishService.wishDupCheck(recommendWishVo.getMemberId(), recommendWishVo.getBookNum());
		
		if (recommendCheck == 1) { // 이미 추천을 했을 때
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");
			
			StringBuilder sb = new StringBuilder();
			sb.append("<script>");
//			sb.append("	alert('이미 추천한 책입니다..');");
//			sb.append("	history.back();");
			sb.append("var con = confirm('이미 추천한 책입니다.... 추천을 취소하시겠습니까?');");
			sb.append("if (con == true) {");
			sb.append("location.href='/use/cancleRecommend?memberId=" + recommendWishVo.getMemberId());
			sb.append("&bookNum=" + recommendWishVo.getBookNum() + "';}");
			sb.append("else {");
			sb.append("history.back(); }");
			sb.append("</script>");
			
			return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
			
		} else if (wishCheck == 1) { // 해당 도서를 찜했을 때
			recommendWishService.updateRecommend(recommendWishVo.getMemberId(), recommendWishVo.getBookNum());
			// 도서 테이블에 추천 카운트 1 추가하기
			bookService.addRecommendCount(recommendWishVo.getBookNum());
			
		} else {
			recommendWishVo.setRecommend("ok");
			recommendWishService.recommendWish(recommendWishVo);
			// 도서 테이블에 추천 카운트 1 추가하기
			bookService.addRecommendCount(recommendWishVo.getBookNum());
		}
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("location", "/book/list");
		
		return new ResponseEntity<String>(headers, HttpStatus.FOUND);
	}
	
	
	
	// 찜하기
	@GetMapping("wish")
	public ResponseEntity<String> wish(RecommendWishVo recommendWishVo) throws Exception {
		
		// 찜하기 중복 확인
		int wishCheck = recommendWishService.wishDupCheck(recommendWishVo.getMemberId(), recommendWishVo.getBookNum());
		
		// 추천 여부 확인
		int recommendCheck = recommendWishService.recommendDupCheck(recommendWishVo.getMemberId(), recommendWishVo.getBookNum());
		
		// 찜한 책 권수
		int wishCount = recommendWishService.getCountWishById(recommendWishVo.getMemberId());
		
		if (wishCount >= 10) {
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");
			
			StringBuilder sb = new StringBuilder();
			sb.append("<script>");
			sb.append("	alert('찜하기는 10권 까지 가능합니다..');");
			sb.append("	history.back();");
			sb.append("</script>");
			
			return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
			
		} else if (wishCheck == 1) { // 이미 찜하기를 했을 때
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");
			
			StringBuilder sb = new StringBuilder();
			sb.append("<script>");
			sb.append("	alert('이미 찜한 책입니다..');");
			sb.append("	history.back();");
			sb.append("</script>");
			
			return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
		} else if (recommendCheck == 1) { // 해당 도서를 추천 했을 때
			recommendWishService.updateWish(recommendWishVo.getMemberId(), recommendWishVo.getBookNum());
		} else {
			recommendWishVo.setWish("ok");
			recommendWishService.recommendWish(recommendWishVo);
		}
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("location", "/book/list");
		
		return new ResponseEntity<String>(headers, HttpStatus.FOUND);
	}
	
	
	
	// 추천 취소하기
	@GetMapping("cancleRecommend")
	public String cancleRecommend(RecommendWishVo recommendWishVo) {
		
		// 찜하기 여부 확인
		int wishCheck = recommendWishService.wishDupCheck(recommendWishVo.getMemberId(), recommendWishVo.getBookNum());
		
		if (wishCheck == 1) { // 해당도서 찜 했을 때
			// recommend 값을 null로 업데이트
			recommendWishService.cancleRecommend(recommendWishVo);
			
		}else { // 찜 안했을 때(삭제)
			// 데이터 삭제
			recommendWishService.deleteRecommendWish(recommendWishVo);
		}
		
		// 도서테이블에 해당 도서 추천카운트 1 감소
		bookService.subRecommendCount(recommendWishVo.getBookNum());
		
		return "redirect:/book/list";
	}
	
	
	// 찜하기 취소하기
	@GetMapping("cancleWish")
	public String cancleWish(RecommendWishVo recommendWishVo) {
		
		// 추천 여부 확인
		int recommendCheck = recommendWishService.recommendDupCheck(recommendWishVo.getMemberId(), recommendWishVo.getBookNum());
		
		if (recommendCheck == 1) { // 해당도서 추천 했을 때
			// wish 값을 null로 업데이트
			recommendWishService.cancleWish(recommendWishVo);
			
		}else { // 추천 안했을 때(삭제)
			// 데이터 삭제
			recommendWishService.deleteRecommendWish(recommendWishVo);
		}
		
		return "redirect:/my/mypage?id=" + recommendWishVo.getMemberId();
		
	}
	
	
}
