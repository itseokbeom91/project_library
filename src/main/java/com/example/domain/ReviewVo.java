package com.example.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReviewVo {
	
	private int rno;
	private int bno;
	private String id;
	private String content;
	private Timestamp regDate;
	private Timestamp updateDate;

}
