package com.example.controller;

import com.example.service.StudyService;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@Slf4j
public class StudyController {

    @Autowired
    private StudyService studyService;

    @GetMapping("/test")
    public String test(){
        String answer = studyService.solution("aukks","wbqd",5);
        log.info("answer : " + answer);

        return "";
    }

}
