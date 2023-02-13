package com.example.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BorrowVo {
	
	private String memberId;
	private int bookNum;
	private Timestamp borrowDate;
	private Timestamp overDate;

}
