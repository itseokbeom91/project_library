package com.example.service;

import java.util.List;

import org.springframework.stereotype.Service;


@Service
public class StudyService {

    // test코드
    public String solution(String s, String skip, int index) {
        String answer = "";

        String alphabet = "abcdefghijklmnopqrstuvwxyz";

        int i;
        for(i=0;i<skip.length();i++){
            //String test = String.valueOf(skip.charAt(i));
            alphabet = alphabet.replace(String.valueOf(skip.charAt(i)), "");
        }

        int j;
        for(j=0;j<s.length();j++){
            //console.log(alphabet.indexOf(s.charAt(j)));
            int wordIndex = alphabet.indexOf(s.charAt(j))+index;
            if(wordIndex >= alphabet.length()){
                answer += alphabet.charAt(wordIndex-alphabet.length());
                //console.log(wordIndex, alphabet.length());

            }else{
                answer += alphabet.charAt(wordIndex);
                //console.log(alphabet.charAt(wordIndex));
            }

        }

        return answer;
    }


}
