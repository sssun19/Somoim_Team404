package test.com.moim.userinfo.controller;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class UserinfoRestController {

	@Autowired
    private EmailSender emailSender;
	

    @Autowired
    private HttpServletRequest request;
	
    @ResponseBody
    @RequestMapping(value = "/sendEmail.do", method = RequestMethod.GET)
    public String sendEmail(String email) {
        log.info("이메일 전송 데이터 확인");
        log.info("인증번호: " + email);

        log.info("/sendEmail.do...{}", email);

        // 이메일 객체 생성
        Email email1 = new Email();
        email1.setReciver(email); // 수신자 설정
        email1.setSubject("이메일 제목"); // 이메일 제목 설정

        // 인증번호 생성
        Random random = new Random();
        int verificationCode = random.nextInt(900000) + 100000; // 100000부터 999999까지의 난수 생성
        String content = "이메일 내용입니다. 인증번호: " + verificationCode;
        email1.setContent(content); // 이메일 내용 설정

        try {
            emailSender.SendEmail(email1); // 이메일 전송
            log.info("SendEmail...successed");

            // 인증번호를 세션에 저장
            HttpSession session = request.getSession();
            session.setAttribute("verificationCode", verificationCode);

        } catch (Exception e) {
            log.info("SendEmail...failed");
            e.printStackTrace();
            return "{\"result\":\"FAIL\"}"; // 이메일 전송 실패 시 실패 결과 반환
        }

        return "{\"result\":\"OK\"}"; // 이메일 전송 성공 시 성공 결과 반환
    }	
	@ResponseBody
	@RequestMapping(value = "/send_email_token.do", method = RequestMethod.GET)
	public String compareEmailToken(String email, String email_token) {
	    log.info("이메일 인증 코드 확인");
	    log.info("이메일: " + email);
	    log.info("인증 코드: " + email_token);

	    // 세션에서 저장된 인증번호 가져오기
	    HttpSession session = request.getSession();
	    Object verificationCodeObject = session.getAttribute("verificationCode");
	    int savedVerificationCode = 0;

	    if (verificationCodeObject != null) {
	        savedVerificationCode = (Integer) verificationCodeObject;
	    }
	    
	    // 이메일과 인증 코드 비교
	    boolean isTokenValid = (savedVerificationCode == Integer.parseInt(email_token));

	    if (isTokenValid) {
	        return "{\"result\":\"OK\"}"; // 인증 코드 일치 시 성공 결과 반환
	    } else {
	        return "{\"result\":\"FAIL\"}"; // 인증 코드 불일치 시 실패 결과 반환
	    }
	}

	


}