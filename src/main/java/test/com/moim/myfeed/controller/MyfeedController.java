package test.com.moim.myfeed.controller;


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
public class MyfeedController {
	
	@Autowired
	HttpSession session;

	@Autowired
	MypageService mypageService;
	
	@RequestMapping(value = "/myfeed_feed_mine.do", method = RequestMethod.GET)
	public String myfeed_feed_mine(Model model) {
		log.info("myfeed_feed_mine.do().....");
		String user_id = (String) session.getAttribute("user_id");
		UserinfoVO vo = new UserinfoVO();
		vo.setUser_id(user_id);
		log.info("id?? : {}", vo.getUser_id());
		
		UserinfoVO vo2 = mypageService.mypageSelectOne(vo);

		model.addAttribute("vo2", vo2);
		return "myfeed/myfeed_feed_mine";
	}

	
}