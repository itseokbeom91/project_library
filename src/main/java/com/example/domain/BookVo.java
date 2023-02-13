package com.example.domain;

import lombok.Data;

@Data
public class BookVo {
	
	private int num;
	private String sort;
	private String cover;
	private String publisher;
	private String birth;
	private String bookName;
	private String writer;
	private String introduceWriter;
	private String introduceBook;
	private String neckKick;
	private int borrowCount;
	private int reserveCount;
	private int totalBorrow;
	private int recommendCount;
	
	private BorrowVo borrowVo;
	private ReserveVo reserveVo;
	private AlarmVo alarmVo;
		
}
