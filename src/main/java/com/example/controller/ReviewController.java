package com.example.controller;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.domain.Criteria;
import com.example.domain.ReviewVo;
import com.example.service.ReviewService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/review/*")
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService;
	

	
	// 한줄평 쓰기
	@PostMapping(value = "/new", consumes = "application/json", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<ReviewVo> createMain(@RequestBody ReviewVo reviewVo, HttpSession session) {
		
		String id = (String) session.getAttribute("id");
		
		// 현재시간
		Timestamp now = new Timestamp(System.currentTimeMillis());
		
		reviewVo.setId(id);
		reviewVo.setRegDate(now);
		reviewVo.setUpdateDate(now);
		log.info("reviewVo : " + reviewVo);
		
		reviewService.insertReview(reviewVo);
		
		reviewVo = reviewService.getReviewByRno(reviewVo.getRno());
		
		return new ResponseEntity<ReviewVo>(reviewVo, HttpStatus.OK);
	}	
	
	// 목록 불러오기
	@GetMapping("/pages/{bno}/{pageNum}/{numOfRows}")
	public ResponseEntity<Map<String, Object>> getListWithPage(
			@PathVariable("bno") int bno,
			@PathVariable("pageNum") int pageNum,
			@PathVariable("numOfRows") int numOfRows) {
		
		Criteria cri = new Criteria(pageNum, numOfRows);
		
		List<ReviewVo> reviewList = reviewService.getReviewList(bno, cri);
		
		int totalCount = reviewService.getTotalCountByBno(bno);
		
		Map<String, Object> map = new HashMap<>();
		map.put("reviewList", reviewList);
		map.put("totalCount", totalCount);
		
		return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
	}
	
	
	// 삭제하기
	@DeleteMapping(value = "/delete/{rno}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable("rno") int rno) {
		
		int count = reviewService.deleteByRno(rno);
		
		return (count > 0) 
				? new ResponseEntity<String>("success", HttpStatus.OK)
					: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	} 
	
	// 수정하기
	@PutMapping("/modify")
	public ResponseEntity<ReviewVo> modify(@RequestBody ReviewVo reviewVo) {
		log.info("reviewVo : " + reviewVo);
		
		reviewService.update(reviewVo);
		
		ReviewVo reviewVoGet = reviewService.getReviewByRno(reviewVo.getRno());
		
		return new ResponseEntity<ReviewVo>(reviewVoGet, HttpStatus.OK);
	} 
	
}
