package test.com.moim.member.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import test.com.moim.member.model.MemberVO;
import test.com.moim.member.service.MemberService;
import test.com.moim.userinfo.model.UserinfoVO;
import test.com.moim.userinfo.service.UserinfoService;


@Slf4j

@Controller
public class MemberRestController {
	
	@Autowired
	MemberService service;
	
	@Autowired
	UserinfoService service2;

	@ResponseBody
	@RequestMapping(value = "/som_member_insertOK.do", method = RequestMethod.POST)
	public String som_member_insertOK(MemberVO vo) {
		log.info("som_member_insertOK.do().....{}", vo);
		log.info("==========="+ vo.getSom_title() + vo.getSave_name());
		log.info("{}", vo.getUser_id());
		log.info("{}", vo.getNum());
		
		int result = service.insert(vo);
		log.info("result : {}", result);
		
		UserinfoVO vo2 = new UserinfoVO();
		vo2.setSom_title(vo.getSom_title());
		vo2.setUser_id(vo.getUser_id());
		
		UserinfoVO vo3 = service2.selectUser(vo2);
		log.info("이게머게...{}", vo3.getSom_title());
		log.info("이건 또 머게...{}", vo3.getUser_id());
		
		
		if(result==1)
			return "OK!";
		else
			return "FALSE...";
	}
	
	@ResponseBody
	@RequestMapping(value = "/som_member_profileCheck.do", method = RequestMethod.GET)
	public List<MemberVO> som_member_profileCheck(MemberVO vo) {
		log.info("잘 넘어옴");
		log.info("num : {}", vo.getNum());
		
		List<MemberVO> vos = service.profileCheck(vo);
		for (MemberVO vo2 : vos) {
			log.info("..!!{}", vo2.getSave_name());
		}
		
		return vos;

	}
	
}
