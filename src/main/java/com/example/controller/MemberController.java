package com.example.controller;

import java.sql.Timestamp;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.MemberVo;
import com.example.service.MemberService;

import lombok.extern.java.Log;

@Controller
@Log
@RequestMapping("/member/*")
public class MemberController {

	@Autowired
	private MemberService memberService;
	

	// 회원가입 페이지로 이동
	@GetMapping("/join")
	public void join() {
		log.info("GET - join() 호출됨");
	} // join
	
	
	// 회원가입
	@PostMapping("/join")
	public String join(MemberVo memberVo) {
		log.info("POST - join() 호출됨");
		
		// 사용자 입력 패스워드를 암호화된 문자열로 변경
		String passwd = memberVo.getPasswd();
		String hashedPwd = BCrypt.hashpw(passwd, BCrypt.gensalt());
		memberVo.setPasswd(hashedPwd);
				
		// 회원가입 날짜 설정
		memberVo.setRegDate(new Timestamp(System.currentTimeMillis()));
		log.info("memberVo : " + memberVo);
		
		// 회원가입 처리
		memberService.addMember(memberVo);
		
		return "redirect:/member/login";
	} //join
	
	
	
	
	// 아이디 중복체크
	@GetMapping("/ajax/joinIdDupChk")
	@ResponseBody
	public int ajaxJoinIdDupChk(@RequestParam("id") String id) {
		
		int count = memberService.getCountById(id);
		
		return count;
	}
	
	
	
	
	
	// 로그인 페이지로 이동
	@GetMapping("/login")
	public void login() {
		log.info("GET - login() 호출됨");
	}
	
	
	// 로그인
	@PostMapping("/login")
	public ResponseEntity<String> login(String id, String passwd, 
			@RequestParam(defaultValue = "false") boolean keepLogin,
			HttpSession session,
			HttpServletResponse response) {
		
			
		int check = memberService.userCheck(id, passwd);
		
		// 로그인 실패시
		if (check != 1) {
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");
			
			StringBuilder sb = new StringBuilder();
			sb.append("<script>");
			sb.append("  alert('아이디 또는 패스워드가 일치하지 않습니다.');");
			sb.append("  history.back();");
			sb.append("</script>");
			
			return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
		}
		
		session.setAttribute("id", id);
		
		if (keepLogin) { // keepLogin == true
			Cookie cookie = new Cookie("id", id);
			cookie.setMaxAge(60 * 10);  // 쿠키 유효시간 10분
			cookie.setPath("/");

			response.addCookie(cookie);
		}
		
//		return "redirect:/";
			
		HttpHeaders headers = new HttpHeaders();
		headers.add("Location", "/"); // 리다이렉트 경로를 Location으로 설정
		// 리다이렉트일 경우는 HttpStatus.FOUND 를 지정해야 함
		return new ResponseEntity<String>(headers, HttpStatus.FOUND);
	} // login
	
	
	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session,
			HttpServletRequest request,
			HttpServletResponse response) {
		
		// 세션 초기화
		session.invalidate();
		
		// 로그인 상태유지용 쿠키가 존재하면 삭제
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("id")) {
					cookie.setMaxAge(0); // 유효시간 0
					cookie.setPath("/"); // 경로는 생성할때와 동일하게 설정해야 삭제됨
					
					response.addCookie(cookie); // 삭제할 쿠키정보를 추가
				}
			}
		}
		
		return "redirect:/";
	} // logout
	
	
	
	// 아이디 찾기
	@GetMapping("/idSearch")
	public String idSearch() {
		return "member/idSearch";
	} // idSearch
	
	
//	@RequestMapping(value="/member/idSearchOk", method=RequestMethod.GET)
//	public String idSearchOkGET() {
//		return "redirect:login";
//	} // idSearchOkGET
	
	@GetMapping("/back")
	public ResponseEntity<String> back() {
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=UTF-8");
		
		StringBuilder sb = new StringBuilder();
		sb.append("<script>");
		sb.append("  alert('존재하지 않는 아이디거나 정보가 일치하지 않습니다.');");
		sb.append("  history.back();");
		sb.append("</script>");
		
		return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
	}
	
	@PostMapping("/idSearchOk")
	public String idSearchOkPOST(@ModelAttribute MemberVo memberVo, Model model) {
		log.info(memberVo.toString());
		// 서비스를 호출해서 로그인 확인
		MemberVo vo = memberService.idSearch(memberVo);
		if(vo == null) {
			return "redirect:/member/back";
		}else {
			model.addAttribute("vo", vo);
			return "member/viewUserID";
		}
			
	}
	
	// 비밀번호 찾기
	@GetMapping("/passwordSearch")
	public String passwordSearch() {
		return "member/passwordSearch";
	}
	
	
//	@RequestMapping(value="/member/passwordSearchOk", method=RequestMethod.GET)
//	public String passwordSearchOkGET() {
//		return "redirect:login";
//	}
	
	@PostMapping("/passwordSearchOk")
	public String passwordSearchOkPOST(@ModelAttribute MemberVo memberVo, Model model) {
		log.info(memberVo.toString());
		
		// 서비스를 호출해서 로그인 확인
		MemberVo vo = memberService.passwdSearch(memberVo);
		if(vo == null) {
			return "redirect:/member/back";
		}else {
			
			String UUPasswd = UUID.randomUUID().toString();
			UUPasswd = UUPasswd.substring(0, 8);
			
			memberService.updatePasswd(UUPasswd, vo.getId());
			
			long beginTime = System.currentTimeMillis();
			
			// SimpleEmail 객체 준비
			
			SimpleEmail email = new SimpleEmail();
			
			// SMTP 서버 연결설정
			email.setHostName("smtp.naver.com");
			email.setSmtpPort(587);
			email.setAuthentication("power0617", "kll1597533!!");
			
			// 보안연결 SSL, TLS 사용 설정
			email.setSSLOnConnect(true);
			email.setStartTLSEnabled(true);
			
			String response = "fail";

			try {
				// 보내는 사람 설정 (SMTP 서비스 로그인 계정 아이디와 동일하게 해야함에 주의!)
				email.setFrom("power0617@naver.com", "관리자", "utf-8");
				
				// 받는 사람 설정
				email.addTo(vo.getEmail(), vo.getName(), "utf-8");
				
				// 제목 설정
				email.setSubject("전자 도서관 임시 비밀번호입니다.");
				
				// 본문 설정
				email.setMsg(UUPasswd + "\n\n임시비밀번호입니다.\n로그인하셔서 비밀번호변경을 해주시기 바랍니다.");
				
				// 메일 전송하기
				response = email.send();
				
			} catch (EmailException e) {
				e.printStackTrace();
			} finally {
				long endTime = System.currentTimeMillis();
				long execTime = endTime - beginTime;
				
				System.out.println("실행시간: " + execTime + "ms");
				System.out.println("응답메시지: " + response);
				log.info("실행시간: " + execTime + "ms");
				log.info("응답메시지: " + response);
			}
			
			
			model.addAttribute("vo", vo);
			return "member/viewPassword";
		}
		
			
	}
	
	@GetMapping("/update")
	public String updateMember(String id, Model model) {
		
		MemberVo memberVo = memberService.update(id);
		
		model.addAttribute("memberVo", memberVo);
		return "member/update";
	}
	
	
	@PostMapping("/update")
	public String update(MemberVo memberVo) {
		
		// 사용자 입력 패스워드를 암호화된 문자열로 변경
		String passwd = memberVo.getPasswd();
		String hashedPwd = BCrypt.hashpw(passwd, BCrypt.gensalt());
		memberVo.setPasswd(hashedPwd);
				
		// 회원가입 날짜 설정
		memberVo.setRegDate(new Timestamp(System.currentTimeMillis()));
		log.info("memberVo : " + memberVo);
		
		// 회원정보수정
		memberService.updateMember(memberVo);
		return "redirect:/my/mypage?id="+ memberVo.getId();
	}
	
	
}
