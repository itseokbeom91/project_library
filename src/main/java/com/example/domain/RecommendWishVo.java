package com.example.domain;

import lombok.Data;

@Data
public class RecommendWishVo {
	
	private String memberId;
	private int bookNum;
	private String recommend;
	private String wish;

}
