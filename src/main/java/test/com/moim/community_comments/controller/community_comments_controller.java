package test.com.moim.community_comments.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import test.com.moim.comments.model.som_commentsVO;
import test.com.moim.comments.service.som_comments_Service;

@Slf4j
@Controller
public class community_comments_controller {
	
	@Autowired
	community_comments_Service commService;



	
	@RequestMapping(value = "/community_comments_updateOK.do", method = RequestMethod.GET)
	public String community_comments_updateOK(Community_comments_commentsVO vo) {
		log.info("/community_comments_updateOK.do...{}", vo);
		
		int result = commService.update(vo);
		log.info("result...{}", result);
		
		return "redirect:community_selectOne.do?num="+vo.getCommunity_board_num();
		
	}
	
	@RequestMapping(value = "/community_comments_deleteOK.do", method = RequestMethod.GET)
	public String community_comments_deleteOK(Community_comments_VO vo) {
		log.info("/-------------------------community_comments_deleteOK.-----------------o...{}", vo);
		log.info("vo.getNum()....{}", vo.getNum());
		Community_comments_commentsVO vo2 = new Community_comments_commentsVO();
		vo2.setNum(vo.getNum());
		vo2.setCommunity_board_num(vo.getCommunity_board_num());
		log.info("vo2", vo2);
		int result = commService.delete(vo2);

		log.info("result...{}", result);

			return "redirect:community_selectOne.do?num="+vo.getCommunity_board_num();

	}
	
	@RequestMapping(value = "/community_comments_insertOK.do", method = RequestMethod.GET)
	public String community_comments_insertOK(Community_comments_VO vo) {

		log.info("somcommcommcommcommcommcommcomm...{}", vo);
		int result = commService.insert(vo);
		
		log.info("result...{}", result);
		
		return "redirect:community_selectOne.do?num="+vo.getCommunity_board_num();
		
	}
	

}
