package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.Criteria;
import com.example.domain.ReviewVo;

public interface ReviewMapper {

	// 한줄평 입력
	void insertReview(ReviewVo reviewVo);
	
	// 해당 한줄평 정보 가져오기
	ReviewVo getReviewByRno(int rno);
	
	// 한줄평 리스트
//	@Select("SELECT * "
//			+ "FROM review "
//			+ "WHERE bno = #{bno} "
//			+ "ORDER BY reg_date DESC "
//			+ "LIMIT #{cri.startRow}, #{cri.amount} ")
	List<ReviewVo> getReviewList(@Param("bno") int bno, @Param("cri") Criteria cri);
	
	// 해당 한줄평 개수
	int getTotalCountByBno(int bno);
	
	// 삭제하기
	@Delete("DELETE FROM review WHERE rno = #{rno}")
	int deleteByRno(int rno);
	
	// 수정하기
	void update(ReviewVo reviewVo);
	
}
