package test.com.moim.community_comments.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import test.com.moim.community_comments.model.Community_re_commentsVO;
import test.com.moim.community_comments.service.Community_commentsService;
import test.com.moim.community_comments.service.Community_re_commentsService;

@Slf4j
@Controller
public class Community_re_commnetsController {

	@Autowired
	Community_re_commentsService commService;
	
	@RequestMapping(value = "/Community_re_comments_updateOK.do", method = RequestMethod.GET)
	public String Community_re_comments_updateOK(Community_re_commentsVO vo) {
		log.info("/Community_re_comments_updateOK.do...{}", vo);
		log.info("/parent.do...{}", vo.getParent_com());
		log.info("/num.do...{}", vo.getNum());
		
		int result = commService.update(vo);
		log.info("result...{}", result);
		
		return "redirect:community_selectOne.do?num="+vo.getBoard_num();
		
	}
	
	@RequestMapping(value = "/Community_re_comments_deleteOK.do", method = RequestMethod.GET)
	public String Community_re_comments_deleteOK(Community_re_commentsVO vo) {
		log.info("/Community_re_comments_deleteOK.do...{}", vo);
		int result = commService.delete(vo);

		log.info("result...{}", result);
		
		return "redirect:community_selectOne.do?num="+vo.getBoard_num();
	}
	
	@RequestMapping(value = "/Community_re_comments_insertOK.do", method = RequestMethod.GET)
	public String Community_re_comments_insertOK(Community_re_commentsVO vo) {
		log.info("Community_re_comments_insertOK!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", vo);
		
		log.info("VOVOVOVOVOOVOVOVOVO....{}", vo);
		int result = commService.insert(vo);
		
		log.info("result...{}", result);
		
		return "redirect:community_selectOne.do?num="+vo.getBoard_num();
		
	}
	

}
