package test.com.moim.myfeed.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import test.com.moim.myfeed.model.MyfeedVO;
import test.com.moim.myfeed.service.MyfeedService;
import test.com.moim.mypage.service.MypageService;
import test.com.moim.userinfo.model.UserinfoVO;


@Slf4j

@Controller
public class MyfeedController {
	
	@Autowired
	HttpSession session;

	@Autowired
	MypageService mypageService;
	
	@Autowired
	MyfeedService myfeedService;
	
	@RequestMapping(value = "/myfeed_feed_mine.do", method = RequestMethod.GET)
	public String myfeed_feed_mine(Model model) {
		log.info("myfeed_feed_mine.do().....");
		String user_id = (String) session.getAttribute("user_id");
		UserinfoVO vo = new UserinfoVO();
		MyfeedVO vo4 = new MyfeedVO();
		vo4.setUser_id(user_id);
		
		vo.setUser_id(user_id);
		log.info("id?? : {}", vo.getUser_id());
		
		UserinfoVO vo2 = mypageService.mypageSelectOne(vo);
		
		MyfeedVO vo3 = myfeedService.selectOne(vo4);
		
		if(vo3==null) {
			log.info("null이다");
			int result = myfeedService.insert(user_id);
			log.info("성공했남? : {}", result);
		}
		
		log.info("vo3....{}", vo3);
		

		model.addAttribute("vo2", vo2);
		model.addAttribute("vo3", vo3);
		return "myfeed/myfeed_feed_mine";
	}

	@RequestMapping(value = "/myfeed_feedupdate.do", method = RequestMethod.GET)
	public String myfeed_feedupdate(String user_id, Model model, String introduce) {
		log.info("user_id : {}", user_id);
		log.info("자기소개내용 : {}", introduce);
		MyfeedVO vo = new MyfeedVO();
		vo.setUser_id(user_id);
		vo.setIntroduce(introduce);
		
		int result = myfeedService.update(vo);
		log.info("result....:{}", result);
		
		
		return "redirect:myfeed_feed_mine.do?user_id="+user_id;
	}
	
	
}