package test.com.moim.mypage.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import test.com.moim.mypage.service.MypageService;
import test.com.moim.userinfo.model.UserinfoVO;


@Slf4j
@Controller
public class MypageController {
	
	@Autowired
	HttpSession session;
	
	@Autowired
	MypageService service;

	@RequestMapping(value = "/mypage.do", method = RequestMethod.GET)
	public String home(Model model) {
		log.info("mypage open....");
		UserinfoVO vo = new UserinfoVO();
		String user_id = (String)session.getAttribute("user_id");
		vo.setUser_id(user_id);
		log.info(vo.getUser_id());
		
		UserinfoVO vo2 = service.mypageSelectOne(vo);
		
		log.info(vo2.getSave_name());
		log.info(vo2.getName());
		log.info(vo2.getEmail());
		log.info(vo2.getBirthday());
		
		String mypageBirth = vo2.getBirthday().substring(0, 10);
		log.info(mypageBirth);
		
		vo2.setBirthday(mypageBirth);

		model.addAttribute("vo2", vo2);

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