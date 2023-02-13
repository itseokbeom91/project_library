package com.example.domain;

import lombok.Data;

//VO(Value Object) : 데이터베이스 테이블과 연관된 값객체
//DTO(Data Tranfer Object) : 데이터베이스 테이블과 무관한 데이터 전송용도의 값객체

@Data
public class PageDto {
	
	private String category; // 검색유형
	private String search;  // 검색어
	private int count; // 전체글갯수
	private int pageCount;  // 총 필요한 페이지(마지막 페이지번호)
	private int pageBlock;  // 페이지블록 당 페이지 갯수
	private int startPage;  // 페이지블록 내 시작페이지 번호
	private int endPage;    // 페이지블록 내 끝페이지 번호
	
	
}
