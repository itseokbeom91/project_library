package com.example.mapper;

import java.util.List;

import com.example.domain.BookVo;
import com.example.domain.RecommendWishVo;

public interface RecommendWishMapper {
	
	
	// 추천 중복확인
	int recommendDupCheck(String memberId, int bookNum);
	
	// 추천, 찜하기
	void recommendWish(RecommendWishVo recommendWishVo);
	
	// 찜하기 중복확인
	int wishDupCheck(String memberId, int bookNum);
	
	// 찜한 도서 추천하기
	void updateRecommend(String memberId, int bookNum);
	
	// 추천한 도서 찜하기
	void updateWish(String memberId, int bookNum);
	
	// 한 아이디당 찜한 개수 구하기
	int getCountWishById(String memberId);
	
	// 찜한 리스트 가져오기
	List<BookVo> getWishList(String memberId);
	
	// 추천, 찜 삭제하기
	void deleteRecommendWish(RecommendWishVo recommendWishVo);
	
	// 찜한 도서 있을 때 추천 취소하기 
	void cancleRecommend(RecommendWishVo recommendWishVo);

	// 찜한 도서 있을 때 추천 취소하기 
	void cancleWish(RecommendWishVo recommendWishVo);

}
