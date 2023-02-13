package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.domain.AnnounceVo;
import com.example.mapper.AnnounceMapper;

@Service
public class AnnounceService {
	
	@Autowired
	private AnnounceMapper announceMapper;
	
	
	// 주글쓰기
	public void addNotice(AnnounceVo announceVo) {
		announceMapper.addNotice(announceVo);
	}
	
	
	public AnnounceVo getNoticeByNum(int num) {
		AnnounceVo announceVo = announceMapper.getNoticeByNum(num);
		return announceVo;
	}
	
	
	
	public void updateReadcount(int num) {
		announceMapper.updateReadcount(num);
	}
	
	
	
	public int getCountAll() {
		int count = announceMapper.getCountAll();
		return count;
	}
	
	
	public List<AnnounceVo> getNotices(int startRow, int pageSize) {
		List<AnnounceVo> list = announceMapper.getNotices(startRow, pageSize);
		return list;
	}
	
	
	public void updateBoard(AnnounceVo announceVo) {
		announceMapper.updateBoard(announceVo);
	}
	
	public void deleteNoticeByNum(int num) {
		announceMapper.deleteNoticeByNum(num);
	}
	
	
	public void deleteAll() {
		announceMapper.deleteAll();
	}
	
	
	
	public int getCountBySearch(String category, String search) {
		int count = announceMapper.getCountBySearch(category, search);
		return count;
	}
	
	
	public List<AnnounceVo> getNoticesBySearch(int startRow, int pageSize, String category, String search) {
		return announceMapper.getNoticesBySearch(startRow, pageSize, category, search);
	}
	
	
//	public AnnounceVo getNoticeAndAttaches(int num) {
//		return announceMapper.getNoticeAndAttaches(num);
//	}
	
	//public List<AnnounceVo> getNoticesByNums(List<Integer> numList)
//	public List<AnnounceVo> getNoticesByNums(Integer... numArr) {
//		
//		List<Integer> numList = Arrays.asList(numArr);
//		
//		return announceMapper.getNoticesByNums(numList);
//	}
	
	
//	// 자료실 게시판 주글쓰기
//	@Transactional
//	public void addNoticeAndAttaches(AnnounceVo announceVo, List<AttachVo> attachList) {
//		// 게시글 등록
//		announceMapper.addNotice(announceVo);
//		
//		// 첨부파일정보 등록
//		for (AttachVo attachVo : attachList) {
//			attachMapper.insertAttach(attachVo);
//		}
//	}
//	
//	// 자료실 게시판 답글쓰기
//	@Transactional
//	public void updateAndAddReplyAndAddAttaches(AnnounceVo announceVo, List<AttachVo> attachList) {
//		// 답글을 쓰는 대상글과 같은 글그룹에서 
//		// 답글을 쓰는 대상글의 순번보다 큰 글의 순번을 1씩 증가시킴
//		announceMapper.updateReSeq(announceVo.getReRef(), announceVo.getReSeq());
//		
//		// insert할 답글정보로 수정
//		announceVo.setReLev(announceVo.getReLev() + 1);
//		announceVo.setReSeq(announceVo.getReSeq() + 1);
//		
//		// 답글 insert하기
//		announceMapper.addNotice(announceVo);
//		
//		
//		// 첨부파일 정보 insert
//		for (AttachVo attachVo : attachList) {
//			attachMapper.insertAttach(attachVo);
//		}
//	}
	
	
	
}





