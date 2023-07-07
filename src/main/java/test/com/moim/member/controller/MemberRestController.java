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


@Slf4j

@Controller
public class MemberRestController {
	
	@Autowired
	MemberService service;

	@ResponseBody
	@RequestMapping(value = "/som_member_insertOK.do", method = RequestMethod.POST)
	public String som_member_insertOK(MemberVO vo) {
		log.info("som_member_insertOK.do().....{}", vo);
		log.info("==========="+ vo.getSom_title() + vo.getSave_name());
		log.info("{}", vo.getUser_id());
		log.info("{}", vo.getNum());
		
		int result = service.insert(vo);
		log.info("result : {}", result);
		log.info("된거야?");
		
		if(result==1)
			return "OK!";
		else
			return "FALSE...";
	}
	
	@ResponseBody
	@RequestMapping(value = "/som_member_profileCheck.do", method = RequestMethod.GET)
	public List<MemberVO> som_member_insert(MemberVO vo) {
		log.info("잘 넘어옴");
		log.info("num : {}", vo.getNum());
		
		List<MemberVO> vos = service.profileCheck(vo);
		for (MemberVO vo2 : vos) {
			log.info("..!!{}", vo2.getSave_name());
		}
		
		return vos;

	}
	
}