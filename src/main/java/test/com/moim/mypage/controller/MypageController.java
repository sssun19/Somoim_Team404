package test.com.moim.mypage.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import test.com.moim.mypage.service.MypageService;
import test.com.moim.somoim.model.SomoimVO;
import test.com.moim.userinfo.model.UserinfoVO;
import test.com.moim.userinfo.service.UserinfoService;


@Slf4j
@Controller
public class MypageController {
	
	@Autowired
	HttpSession session;
	
	@Autowired
	MypageService service;
	
	@Autowired
	UserinfoService userService;

	@RequestMapping(value = "/mypage.do", method = RequestMethod.GET)
	public String mypage(Model model) {
		log.info("mypage open....");
		UserinfoVO vo = new UserinfoVO();
		String user_id = (String)session.getAttribute("user_id");
		vo.setUser_id(user_id);
		log.info(vo.getUser_id());
		
		UserinfoVO vo2 = service.mypageSelectOne(vo);
		
		log.info(vo2.getSave_name());
		log.info(vo2.getName());
		log.info(vo2.getEmail());
		log.info(vo2.getSom_title());
		
		String mypageBirth = vo2.getBirthday().substring(0, 10);
		log.info(mypageBirth);
		vo2.setBirthday(mypageBirth);
		
//		SomoimVO vo3 = new SomoimVO();
//		vo3.setSom_title(vo2.getSom_title());
//		
//		String som_title = vo3.getSom_title();
//		for(int i=0; i<som_title.length(); i++) {
//			if(som_title.charAt(i)=='/') {
//				log.info("몇번쨰? :{}", i);
//				
//			}
//		}

		Map<String, Object> map = new HashMap<>();
		map.put("vo2", vo2);
		
		model.addAllAttributes(map);

		return "mypage/mypage";
	}
	
	@RequestMapping(value = "/mypage_update.do", method = RequestMethod.GET)
	public String mypage_update(UserinfoVO vo, Model model) {
		log.info("mypage_update open....{}", vo);
		String user_id =(String) session.getAttribute("user_id");
		vo.setUser_id(user_id);
		
		UserinfoVO vo2 = service.mypageSelectOne(vo);
		log.info("편집할 유저의 정보입니다.....{}", vo2);
		
		model.addAttribute("vo2", vo2);
		
		return "mypage/mypage_update";
	}
	
	@RequestMapping(value = "/mypage_updateOK.do", method = RequestMethod.POST)
	public String mypage_updateOK(UserinfoVO vo) {
		log.info("mypage_updateOK.do....{}", vo);
		
		log.info("변경사항.....{}", vo.getName());
		
		return "mypage/mypage_update";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/mypageSelectSomoim.do", method = RequestMethod.GET)
	public List<SomoimVO> mypageSelectSomoim(Model model) {
		log.info("mypageSelectSomoim.do....{}");
		
		String user_id = (String) session.getAttribute("user_id");
		
		List<SomoimVO> vos = service.mypageSelectSomoim(user_id);
		log.info("vo....!!{}", vos);
		
		return vos;
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