package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.BookVo;

public interface BookMapper {
	
	// 도서 등록하기
	void insertBook(BookVo bookVo);
	
	// 검색어를 적용한 글갯수 가져오기
	int getCountBySearch(
			@Param("category") String category, 
			@Param("search") String search);
	
	// 검색 리스트 가져오기
	List<BookVo> getListBySearch(
			@Param("startRow") int startRow, 
			@Param("pageSize") int pageSize, 
			@Param("category") String category, 
			@Param("search") String search);
	
	// 대출 카온트 1 추가하기
	void addBorrowCount(int num);
	
	// 대출 카온트 1 감소하기
	void subBorrowCount(int num);
	
	// 누적대출 카운트 1 추가하기
	void addTotalBorrow(int num);
	
	// 예약 카온트 1 추가하기
	void addReserveCount(int num);
	
	// 예약 카온트 1 감소하기
	void subReserveCount(int num);
	
	// 추천 카운트 1 추가하기
	void addRecommendCount(int num);

	// 추천 카운트 1 감소하기
	void subRecommendCount(int num);
	
	// 신간 권수 가져오기
	int getCountByNewBooks(
			@Param("strThisMonth") String strThisMonth, 
			@Param("strThisYear") String strThisYear, 
			@Param("strLastMonth") String strLastMonth, 
			@Param("strLatMothYear") String strLatMothYear);
	
	// 신간 리스트 가져오기
	List<BookVo> getListByNewBooks(
			@Param("startRow") int startRow, 
			@Param("pageSize") int pageSize, 
			@Param("strThisMonth") String strThisMonth, 
			@Param("strThisYear") String strThisYear, 
			@Param("strLastMonth") String strLastMonth, 
			@Param("strLatMothYear") String strLatMothYear);
	
	
	@Select("SELECT * FROM book WHERE num = #{num}")
	BookVo getBookByNum(int num);
	
	@Select("SELECT COUNT(*) FROM book")
	int getCountBook();
	
	List<BookVo> getBestBooks(@Param("startRow") int startRow, @Param("pageSize") int pageSize);
	
	List<BookVo> getRecommendBooks(@Param("startRow") int startRow, @Param("pageSize") int pageSize);

	List<BookVo> getNewBooks(@Param("startRow") int startRow, @Param("pageSize") int pageSize);

}
