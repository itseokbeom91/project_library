package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.domain.BookVo;
import com.example.mapper.BookMapper;

@Service
public class BookService {
	
	@Autowired
	private BookMapper bookMapper;
	
	// 도서 등록하기
	public void insertBook(BookVo bookVo) {
		bookMapper.insertBook(bookVo);
	}
	
	// 검색어를 적용한 글갯수 가져오기
	public int getCountBySearch(String category, String search) {
		return bookMapper.getCountBySearch(category, search);
	}
	
	// 검색 리스트 가져오기
	public List<BookVo> getListBySearch(int startRow, int pageSize, String category, String search) {
		return bookMapper.getListBySearch(startRow, pageSize, category, search);
	}
	
	// 대출 카온트 1 추가하기
	public void addBorrowCount(int num) {
		bookMapper.addBorrowCount(num);
	}

	// 대출 카온트 1 감소하기
	public void subBorrowCount(int num) {
		bookMapper.subBorrowCount(num);
	}
	
	// 누적대출 카운트 1 추가하기
	public void addTotalBorrow(int num) {
		bookMapper.addTotalBorrow(num);
	}
	
	// 예약 카온트 1 추가하기
	public void addReserveCount(int num) {
		bookMapper.addReserveCount(num);
	}
	
	// 예약 카온트 1 감소하기
	public void subReserveCount(int num) {
		bookMapper.subReserveCount(num);
	}
	
	// 추천 카운트 1 추가하기
	public void addRecommendCount(int num) {
		bookMapper.addRecommendCount(num);
	}

	// 추천 카운트 1 감소하기
	public void subRecommendCount(int num) {
		bookMapper.subRecommendCount(num);
	}
	
	// 신간 권수 가져오기
	public int getCountByNewBooks(String strThisMonth, String strThisYear, String strLastMonth, String strLatMothYear) {
		return bookMapper.getCountByNewBooks(strThisMonth, strThisYear, strLastMonth, strLatMothYear);
	}
	
	// 신간 리스트 가져오기
	public List<BookVo> getListByNewBooks(int startRow, int pageSize, String strThisMonth, String strThisYear, String strLastMonth, String strLatMothYear) {
		return bookMapper.getListByNewBooks(startRow, pageSize, strThisMonth, strThisYear, strLastMonth, strLatMothYear);
	}
	
	
	
	public BookVo getBookByNum(int num) {
		BookVo bookVo = bookMapper.getBookByNum(num);
		return bookVo;
	}
	
	public int getCountBook() {
		return bookMapper.getCountBook();
	}
	
	public List<BookVo> getBestBooks(int startRow, int pageSize) {
		return bookMapper.getBestBooks(startRow, pageSize);
	}
	
	public List<BookVo> getRecommendBooks(int startRow, int pageSize) {
		return bookMapper.getNewBooks(startRow, pageSize);
	}
	
	public List<BookVo> getNewBooks(int startRow, int pageSize) {
		return bookMapper.getNewBooks(startRow, pageSize);
	}
}
