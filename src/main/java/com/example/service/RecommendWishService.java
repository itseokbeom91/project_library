package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.domain.BookVo;
import com.example.domain.RecommendWishVo;
import com.example.mapper.RecommendWishMapper;

@Service
public class RecommendWishService {

	@Autowired
	private RecommendWishMapper recommendWishMapper;
	
	// 추천 중복 확인
	public int recommendDupCheck(String memberId, int bookNum) {
		return recommendWishMapper.recommendDupCheck(memberId, bookNum);
	}
	
	// 추천, 찜하기
	public void recommendWish(RecommendWishVo recommendWishVo) {
		recommendWishMapper.recommendWish(recommendWishVo);
	}
	
	// 찜하기 중복 확인
	public int wishDupCheck(String memberId, int bookNum) {
		return recommendWishMapper.wishDupCheck(memberId, bookNum);
	}

	// 찜한 도서 추천하기
	public void updateRecommend(String memberId, int bookNum) {
		recommendWishMapper.updateRecommend(memberId, bookNum);
	}
	
	// 추천한 도서 찜하기
	public void updateWish(String memberId, int bookNum) {
		recommendWishMapper.updateWish(memberId, bookNum);
	}
	
	// 한 아이디당 찜한 개수 구하기
	public int getCountWishById(String memberId) {
		return recommendWishMapper.getCountWishById(memberId);
	}
	
	// 찜한 리스트 가져오기
	public List<BookVo> getWishList(String memberId) {
		return recommendWishMapper.getWishList(memberId);
	}

	// 추천, 찜 삭제하기
	public void deleteRecommendWish(RecommendWishVo recommendWishVo) {
		recommendWishMapper.deleteRecommendWish(recommendWishVo);
	}
	
	// 찜한 도서 있을 때 추천 취소하기 
	public void cancleRecommend(RecommendWishVo recommendWishVo) {
		recommendWishMapper.cancleRecommend(recommendWishVo);
	}
	
	// 찜한 도서 있을 때 추천 취소하기 
	public void cancleWish(RecommendWishVo recommendWishVo) {
		recommendWishMapper.cancleWish(recommendWishVo);
	}

	
	
}
