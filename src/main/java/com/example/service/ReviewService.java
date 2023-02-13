package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.domain.Criteria;
import com.example.domain.ReviewVo;
import com.example.mapper.ReviewMapper;

@Service
public class ReviewService {
	
	@Autowired
	private ReviewMapper reviewMapper;
	
	
	// 한줄평 입력
	public void insertReview(ReviewVo reviewVo) {
		reviewMapper.insertReview(reviewVo);
	}
	
	// 해당 한줄평 정보 가져오기
	public ReviewVo getReviewByRno(int rno) {
		ReviewVo reviewVo = reviewMapper.getReviewByRno(rno);
		return reviewVo;
	}
	
	// 한줄평 리스트
	public List<ReviewVo> getReviewList(int bno, Criteria cri) {
		List<ReviewVo> list = reviewMapper.getReviewList(bno, cri);
		return list;
	}
	
	// 해당 한줄평 수
	public int getTotalCountByBno(int bno) {
		int count = reviewMapper.getTotalCountByBno(bno);
		return count;
	}
	
	// 삭제하기
	public int deleteByRno(int rno) {
		int count = reviewMapper.deleteByRno(rno);
		return count;
	}
	
	// 수정하기
	public void update(ReviewVo reviewVo) {
		reviewMapper.update(reviewVo);
	}
	

}
