package com.example.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReserveVo {

	private String memberId;
	private int bookNum;
	private Timestamp reserveDate;
	private Timestamp overDate;
}
