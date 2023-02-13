package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.AnnounceVo;

public interface AnnounceMapper {

//	@Insert("INSERT INTO announce (id, subject, content, readcount, reg_date, ip, re_ref, re_lev, re_seq) "
//			+ "VALUES (#{id}, #{subject}, #{content}, #{readcount}, #{regDate}, #{ip}, #{reRef}, #{reLev}, #{reSeq})")
	void addNotice(AnnounceVo announceVo);
	
	
	@Select("SELECT * FROM announce WHERE num = #{num}")
	AnnounceVo getNoticeByNum(int num);
	
	
	
	void updateReadcount(int num);
	
	
//	@Select("SELECT COUNT(*) FROM announce")
	int getCountAll();
	
	
	List<AnnounceVo> getNotices(@Param("startRow") int startRow, @Param("pageSize") int pageSize);
	
	
	void updateBoard(AnnounceVo announceVo);
	
	@Delete("DELETE FROM announce WHERE num = #{num}")
	void deleteNoticeByNum(int num);
	
	@Delete("DELETE FROM announce")
	void deleteAll();
	
	
//	void updateReSeq(
//			@Param("reRef") int reRef, 
//			@Param("reSeq") int reSeq);
	
	
	
	int getCountBySearch(
			@Param("category") String category, 
			@Param("search") String search);
	
	
	List<AnnounceVo> getNoticesBySearch(
			@Param("startRow") int startRow, 
			@Param("pageSize") int pageSize, 
			@Param("category") String category, 
			@Param("search") String search);
	
	
//	AnnounceVo getNoticeAndAttaches(int num);
	
	
	
//	List<AnnounceVo> getNoticesByNums(@Param("numList") List<Integer> numList);
	
	
}






