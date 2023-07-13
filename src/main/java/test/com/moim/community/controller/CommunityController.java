package test.com.moim.community.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import test.com.moim.community.model.CommunityVO;
import test.com.moim.community.service.CommunityService;
import test.com.moim.community_comments.model.Community_commentsVO;
import test.com.moim.community_comments.model.Community_re_commentsVO;
import test.com.moim.community_comments.service.Community_commentsService;
import test.com.moim.community_comments.service.Community_re_commentsService;
import test.com.moim.events.model.EventsVO;
import test.com.moim.userinfo.model.UserinfoVO;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Handles requests for the application home page.
 */

@Slf4j
@Controller



public class CommunityController {
	
	@Autowired
	HttpSession session;

	@Autowired
	ServletContext sContext;

	@Autowired
	CommunityService service;

	@Autowired
	Community_commentsService community_comservice;

	@Autowired
	Community_re_commentsService community_re_comservice;


	@RequestMapping(value = "/community_selectAll.do", method = RequestMethod.GET)
	public String community_selectAll(Model model) {
		log.info("community_selectAll.do().....{}");

		List<CommunityVO> vos = service.selectAll();

		for (CommunityVO vo : vos) {
			log.info(vo.toString());
		}

		model.addAttribute("vos",vos);

		return "community/selectAll";
	}

	@RequestMapping(value = "/community_selectOne.do", method = RequestMethod.GET)
	public String community_selectOne(CommunityVO vo, Model model) {
		log.info("community_selectOne.do().....");

		CommunityVO vo2 = service.selectOne(vo);
		log.info("test...{}",vo2);

		model.addAttribute("vo2",vo2);



		Community_commentsVO vo3 = new Community_commentsVO();
		vo3.setBoard_num(vo2.getNum());
		log.info("vo3...!!!!!!!!!!!!!!!!{}", vo3);

		List<Community_commentsVO> ccoms = community_comservice.selectAll(vo3);
		List<Community_commentsVO> filteredCcoms = new ArrayList<>();

		for (Community_commentsVO ccom : ccoms) {
			if (ccom.getParent_com() == 0) {
				filteredCcoms.add(ccom);
			}
		}
		log.info("filteredCcoms...{}",filteredCcoms);
		model.addAttribute("ccoms", filteredCcoms);
		model.addAttribute("vo3", vo3);

		Community_re_commentsVO c_cvo = new Community_re_commentsVO();
		c_cvo.setBoard_num(vo3.getBoard_num());
		log.info("vo3.getnum..{}", vo3.getNum());
		List<Community_re_commentsVO> filteredcoms = new ArrayList<>();
		List<Community_re_commentsVO> c_coms = new ArrayList<Community_re_commentsVO>();
		c_coms = community_re_comservice.selectAll(c_cvo);
		for (Community_re_commentsVO dcom : c_coms) {
			if (dcom.getParent_com() != 0) {
				filteredcoms.add(dcom);
			}
		}
		log.info("filteredcoms@@@@@@@@@@@@@@@@...{}",filteredcoms);

		model.addAttribute("c_coms", filteredcoms);
		return "community/selectOne";
	}
	
	@RequestMapping(value = "/community_insert.do", method = RequestMethod.GET)
	public String community_insert() {


		log.info("community_insert.do().....");


		return "community/insert";
	}

	@RequestMapping(value = "/community_insertOK.do", method = RequestMethod.POST)
	public String community_insertOK(CommunityVO vo) throws IllegalStateException, IOException {

		log.info("community_insertOK.do().....{}", vo);

		int fileNameLength = vo.getFile().getOriginalFilename().length();
		String getOriginalFileName = vo.getFile().getOriginalFilename();

		log.info("getOriginalFilename : {}", getOriginalFileName);
		log.info("fileNameLength : {}", fileNameLength);

		vo.setSave_name(getOriginalFileName.length() == 0 ? "아이유.png" : getOriginalFileName);

		if (getOriginalFileName.length() == 0) {
			vo.setSave_name("아이유.png");

		} else {
			vo.setSave_name(getOriginalFileName);
			// 웹 어플리케이션이 갖는 실제 경로 : 이미지를 업로드할 대상 경로를 찾아서 파일 저장
			String realPath = sContext.getRealPath("resources/uploadimg");

			log.info("realPath : {}", realPath);

			File f = new File(realPath + "\\" + vo.getSave_name());

			vo.getFile().transferTo(f);

			//// create thumbnail image/////////
			/*BufferedImage original_buffer_img = ImageIO.read(f);
			BufferedImage thumb_buffer_img = new BufferedImage(50, 50, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D graphic = thumb_buffer_img.createGraphics();
			graphic.drawImage(original_buffer_img, 0, 0, 50, 50, null);
			File thumb_file = new File(realPath + "/thumb_" + vo.getSave_name());
			String formatName = vo.getSave_name().substring(vo.getSave_name().lastIndexOf(".")+1);
			log.info("formatName : {}", formatName);
			ImageIO.write(thumb_buffer_img, formatName, thumb_file);*/

		} // end else

		log.info("{}", vo);
		int result = service.insert(vo);

		log.info("result : {}", result);
		if (result==1)
			return "redirect:community_selectAll.do";
		else
			return "redirect:community_insert.do";
	}
	/*@RequestMapping(value = "/community_insertOK.do", method = RequestMethod.POST)
	public String community_insertOK(CommunityVO vo){

		log.info("/community_insertOK.do...{}", vo);
		
		int result = service.insert(vo);
		log.info("result...{}", result);
		
		if(result==1) {
			return "redirect:community_selectAll.do";
		}else {
			return "redirect:community_insert.do";
		}
		
	}*/
	
	@RequestMapping(value = "/community_update.do", method = RequestMethod.GET)
	public String community_update(CommunityVO vo, Model model) {
		log.info("/community_update.do...{}", vo);

		CommunityVO vo2 = service.selectOne(vo);

		model.addAttribute("vo2", vo2);
		log.info("vo2...{}", vo2);

		return "community/update";
	}

	@RequestMapping(value = "/community_updateOK.do", method = RequestMethod.POST)
	public String community_updateOK(CommunityVO vo) throws IllegalStateException, IOException {
		log.info("community_updateOK.do....{}", vo);

		log.info("사진 변경...{}", vo.getFile());
		int fileNameLength = vo.getFile().getOriginalFilename().length();
		String getOriginalFileName = vo.getFile().getOriginalFilename();
		log.info("getOriginalFilename : {}", getOriginalFileName);
		log.info("fileNameLength : {}", fileNameLength);
		vo.setSave_name(getOriginalFileName.length() == 0 ? vo.getSave_name() : getOriginalFileName);

		if (getOriginalFileName.length() != 0) {
			vo.setSave_name(getOriginalFileName);
			// 웹 어플리케이션이 갖는 실제 경로 : 이미지를 업로드할 대상 경로를 찾아서 파일 저장
			String realPath = sContext.getRealPath("resources/uploadimg");
			log.info("realPath : {}", realPath);
			File f = new File(realPath + "\\" + vo.getSave_name());
			vo.getFile().transferTo(f);
		}
		log.info("최종 변경 : {}", vo.getSave_name());

		int result = service.update(vo);
		log.info("result...{}", result);

		if(result==1) {
			return "redirect:community_selectOne.do?num="+vo.getNum();
		}else {
			return "redirect:community_update.do?num="+vo.getNum();
		}
	}

	@RequestMapping(value = "/community_deleteOK.do", method = RequestMethod.GET)
	public String community_deleteOK(CommunityVO vo){
		log.info("/community_deleteOK.do...{}", vo);
		
		int result = service.delete(vo);
		log.info("result...{}", result);
		
		if(result==1) {
			return "redirect:community_selectAll.do";
		}else {
			return "redirect:community_selectOne.do?num="+vo.getNum();
		}
		
	}
	
}
