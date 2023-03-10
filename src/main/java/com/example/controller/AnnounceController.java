package com.example.controller;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.domain.AnnounceVo;
import com.example.domain.PageDto;
import com.example.service.AnnounceService;
import com.example.service.MySqlService;

@Controller
@RequestMapping("/board/announce/*")
public class AnnounceController {

	@Autowired
	private AnnounceService announceService;
	
	@Autowired
	private MySqlService mySqlService;
	
	@GetMapping("/notice")
	public String list(
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "") String category,
			@RequestParam(defaultValue = "") String search,
			Model model) {
		
		int count = announceService.getCountBySearch(category, search);
		
		
		
		int pageSize = 10;
		
		int startRow = (pageNum - 1) * pageSize;		
		
		List<AnnounceVo> announceList = null;
		if (count > 0) {
			announceList = announceService.getNoticesBySearch(startRow, pageSize, category, search);
		}
		
		
		PageDto pageDto = new PageDto();
		
		if (count > 0) {
			int pageCount = (count / pageSize) + (count % pageSize == 0 ? 0 : 1);
			
			int pageBlock = 5;
			
			int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
			
			int endPage = startPage + pageBlock - 1;
			if (endPage > pageCount) {
				endPage = pageCount;
			}
			
			pageDto.setCategory(category);
			pageDto.setSearch(search);
			pageDto.setCount(count);
			pageDto.setPageCount(pageCount);
			pageDto.setPageBlock(pageBlock);
			pageDto.setStartPage(startPage);
			pageDto.setEndPage(endPage);
		} // if
		
		
		model.addAttribute("announceList", announceList);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("pageNum", pageNum);
		
		return "board/announce";
	} // list
	
	
	@GetMapping("/write")
	public String write(@ModelAttribute("pageNum") String pageNum, HttpSession session, Model model) {

		return "board/announceWrite";
	} // Get - write
	
	
	@PostMapping("/write")
	public String write(String pageNum, AnnounceVo announceVo,
			HttpSession session, HttpServletRequest request) {

		int num = mySqlService.getNextNum("announce");
		
		// ??????????????? IP??????, ????????????, ????????? ??? ??????
		announceVo.setNum(num);
		announceVo.setRegDate(new Timestamp(System.currentTimeMillis()));
		announceVo.setUpdateDate(new Timestamp(System.currentTimeMillis()));
		announceVo.setReadcount(0); 
		
		// ????????????
		announceService.addNotice(announceVo);
		
		return "redirect:/board/announce/content?num=" + num + "&pageNum=" + pageNum;
	} // Post - write
	
	
	@GetMapping("/content")
	public String content(int num, String pageNum, Model model) {
		// ???????????? ?????? ?????? ????????? 1 ??????
		announceService.updateReadcount(num);
		
		// ???????????? ?????? ????????? VO??? ????????????
		AnnounceVo announceVo = announceService.getNoticeByNum(num);
		
		String content = "";
		if (announceVo.getContent() != null) {
			content = announceVo.getContent().replace("\n", "<br>");
			announceVo.setContent(content);
		}
		
		model.addAttribute("announceVo", announceVo);
		model.addAttribute("pageNum", pageNum);
		
		return "board/announceContent";
	} // content
	
	
	@GetMapping("/delete")
	public String delete(int num, String pageNum, RedirectAttributes rttr) {
		// ???????????? ???????????? ??? ?????? ????????????
		announceService.deleteNoticeByNum(num);
		
		// ????????? ???????????? ??????????????? ???????????????
		rttr.addAttribute("pageNum", pageNum);
		
		return "redirect:/board/announce/notice";
	} // delete
	
	
	@GetMapping("/modify")
	public String modify(int num, @ModelAttribute("pageNum") String pageNum, Model model) {
		// ????????? num??? ???????????? ????????? VO??? ????????????
		AnnounceVo announceVo = announceService.getNoticeByNum(num);
		
		model.addAttribute("announceVo", announceVo);
		//model.addAttribute("pageNum", pageNum);
		
		return "board/announceModify";
	} // GET - modify
	
	
	@PostMapping("/modify")
	public String modify(AnnounceVo announceVo, String pageNum, RedirectAttributes rttr) {
		
		announceService.updateBoard(announceVo);
		
		rttr.addAttribute("num", announceVo.getNum());
		rttr.addAttribute("pageNum", pageNum);
		
		// ????????? ?????? ???????????? ???????????? ??????????????? ??????
		return "redirect:/board/announce/content";
	} // POST - modify
	
	
}
