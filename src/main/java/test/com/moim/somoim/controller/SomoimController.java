package test.com.moim.somoim.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import test.com.moim.somoim.model.SomoimVO;
import test.com.moim.somoim.service.SomoimService;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;


@Slf4j
@Controller
public class SomoimController {
	
	@Autowired
	SomoimService service;
	
	@Autowired
	ServletContext sContext;

	@Autowired
	HttpSession session;


	@RequestMapping(value = "/som_selectAll.do", method = RequestMethod.GET)
	public String som_selectAll(SomoimVO vo, Model model) {
		log.info("som_selectAll.do().....");
		log.info("-------");

		List<SomoimVO> vos = service.selectAll(vo);

		model.addAttribute("vos",vos);

		return "board/som_selectAll";
	}

	@RequestMapping(value = "/som_selectOne.do", method = RequestMethod.GET)
	public String som_selectOne(SomoimVO vo, Model model) {
		log.info("som_selectOne.do().....{}", vo);
		
		SomoimVO vo2 = service.selectOne(vo);

		session.setAttribute("num",vo.getNum());
		model.addAttribute("vo2", vo2);
		
		return "board/som_selectOne";
	}
	
	@RequestMapping(value = "/som_searchList.do", method = RequestMethod.GET)
	public String som_searchList(String searchKey, String searchWord, String category, Model model) {
		log.info("som_searchList.do().....{}, {}", searchKey, searchWord);
		log.info("------------{}", category);
		
		
		List<SomoimVO> vos = service.searchList(searchKey, searchWord, category);
		
		model.addAttribute("vos", vos);
		
		return "board/som_selectAll";
	}
	
	@RequestMapping(value = "/som_insert.do", method = RequestMethod.GET)
	public String som_insert() {

		log.info("som_insert.do().....");
		
		return "board/som_insert";
	}
	
	@RequestMapping(value = "/som_insertOK.do", method = RequestMethod.POST)
	public String som_insertOK(SomoimVO vo) throws IllegalStateException, IOException {

		log.info("som_insertOK.do().....{}", vo);
		
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
			BufferedImage original_buffer_img = ImageIO.read(f);
			BufferedImage thumb_buffer_img = new BufferedImage(50, 50, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D graphic = thumb_buffer_img.createGraphics();
			graphic.drawImage(original_buffer_img, 0, 0, 50, 50, null);
			File thumb_file = new File(realPath + "/thumb_" + vo.getSave_name());
			String formatName = vo.getSave_name().substring(vo.getSave_name().lastIndexOf(".")+1);
			log.info("formatName : {}", formatName);
			ImageIO.write(thumb_buffer_img, formatName, thumb_file);

		} // end else
		
		log.info("{}", vo);
		int result = service.insert(vo);
		
		log.info("result : {}", result);
		if (result==1)
			return "redirect:som_selectAll.do";
		else
			return "redirect:som_insert.do";
	}
	
	@RequestMapping(value = "/som_update.do", method = RequestMethod.GET)
	public String som_update(SomoimVO vo) {
		log.info("som_update.do().....{}", vo);
		
		int result = service.update(vo);
		
		
		return "redirect:selectAll.do";
	}
	
	@RequestMapping(value = "/som_delete.do", method = RequestMethod.GET)
	public String som_delete(SomoimVO vo) {
		log.info("som_delete.do().....{}", vo);
		
		int result = service.delete(vo);
		
		
		return "redirect:selectAll.do";
	}

	
}
