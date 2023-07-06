package test.com.moim.member.controller;


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
		log.info("==========="+ vo.getNum() + vo.getSom_title() + vo.getSave_name());
		
		int result = service.insert(vo);
		
		if(result==1)
			return "가입완료!"+vo.getNum()+vo.getSom_title();
		else
			return "가입실패..."+vo.getNum()+vo.getSom_title();
	}
	
}
