package test.com.moim.mypage.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class MypageController {

	@RequestMapping(value = "/mypage.do", method = RequestMethod.GET)
	public String home() {
		log.info("home.do().....");

		

		return "mypage/mypage";
	}
	@RequestMapping(value = "/mypage_myactivity_good.do", method = RequestMethod.GET)
	public String mypage_myactivity_good() {
		log.info("mypage_myactivity_good.do().....");
		
		
		
		return "mypage/mypage_myactivity_good";
	}
	
	@RequestMapping(value = "/Mypage_myactivity_likedboard.do", method = RequestMethod.GET)
	public String Mypage_myactivity_likedboard() {
		log.info("Mypage_myactivity_likedboard.do().....");
		
		
		
		return "mypage/Mypage_myactivity_likedboard";
	}
	
	@RequestMapping(value = "/Mypage_myactivity_commbyme.do", method = RequestMethod.GET)
	public String Mypage_myactivity_commbyme() {
		log.info("Mypage_myactivity_commbyme.do().....");
		
		
		
		return "mypage/Mypage_myactivity_commbyme";
	}
	
}