package test.com.moim.community_comments.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import test.com.moim.comments.model.som_commentsVO;
import test.com.moim.comments.service.som_comments_Service;
import test.com.moim.community_comments.model.Community_commentsVO;
import test.com.moim.community_comments.service.Community_commentsService;

@Slf4j
@Controller
public class Community_commentsController {
	
	@Autowired
	Community_commentsService commService;



	
	@RequestMapping(value = "/Community_comments_updateOK.do", method = RequestMethod.GET)
	public String Community_comments_updateOK(Community_commentsVO vo) {
		log.info("/Community_comments_updateOK.do...{}", vo);
		
		int result = commService.update(vo);
		log.info("result...{}", result);
		
		return "redirect:community_selectOne.do?num="+vo.getBoard_num();
		
	}
	
	@RequestMapping(value = "/Community_comments_deleteOK.do", method = RequestMethod.GET)
	public String Community_comments_deleteOK(Community_commentsVO vo) {
		log.info("/-------------------------Community_comments_deleteOK.-----------------o...{}", vo);
		log.info("vo.getNum()....{}", vo.getNum());
		Community_commentsVO vo2 = new Community_commentsVO();
		vo2.setNum(vo.getNum());
		vo2.setBoard_num(vo.getBoard_num());
		log.info("vo2", vo2);
		int result = commService.delete(vo2);

		log.info("result...{}", result);

			return "redirect:community_selectOne.do?num="+vo.getBoard_num();

	}
	
	@RequestMapping(value = "/Community_comments_insertOK.do", method = RequestMethod.GET)
	public String Community_comments_insertOK(Community_commentsVO vo) {

		log.info("community_comments_insertOK...{}", vo);
		int result = commService.insert(vo);
		
		log.info("result...{}", result);
		
		return "redirect:community_selectOne.do?num="+vo.getBoard_num();
		
	}
	

}
