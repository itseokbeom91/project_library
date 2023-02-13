package com.example.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class AlarmVo {

	private String memberId;
	private int bookNum;
	private Timestamp regDate;
}
