package com.example.controller;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.domain.BookVo;
import com.example.service.BookService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class HomeController {
	
	@Autowired
	BookService bookService;
	
	@GetMapping("/")
	public String index(Model model) {
		
		int totalCount = bookService.getCountBook();
		
		if (totalCount != 0) {
			Random random = new Random();
			int num = random.nextInt(totalCount) + 1;
			log.info("random : " + num);
	
			// 무작위 책 한권 가져오기
			BookVo bookVo = bookService.getBookByNum(num);
			
			
			int count = 5;
			int startRow = 1;
			int pageSize = 5;
			
			List<BookVo> bestBookList = null;
			if (count > 0) {
				bestBookList = bookService.getBestBooks(startRow, pageSize);
			}
			
			List<BookVo> newList = null;
			if (count > 0) {
				newList = bookService.getNewBooks(startRow, pageSize);
			}
			
			model.addAttribute("bookVo", bookVo);
			model.addAttribute("bestBookList", bestBookList);
			model.addAttribute("newList", newList);
		}
		return "index";
	}
	

}
