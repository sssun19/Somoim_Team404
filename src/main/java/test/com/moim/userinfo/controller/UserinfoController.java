package test.com.moim.userinfo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import test.com.moim.userinfo.model.UserinfoVO;
import test.com.moim.userinfo.service.UserinfoService;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

@Slf4j
@Controller
public class UserinfoController {

	@Autowired
	ServletContext sContext;

	@Autowired
	UserinfoService service;

	@Autowired
	HttpSession session;

	@RequestMapping(value = "/u_selectAll.do", method = RequestMethod.GET)
	public String u_selectAll(Model model) {
		log.info("/u_selectAll.do");
		List<UserinfoVO> vos = service.selectAll();

		model.addAttribute("vos", vos);

		return "userinfo/selectAll";
	}

	@RequestMapping(value = "/u_selectOne.do", method = RequestMethod.GET)
	public String u_selectOne(UserinfoVO vo, Model model) {
		log.info("/u_selectOne.do");

		UserinfoVO vo2 = service.selectOne(vo);

		model.addAttribute("vo2", vo2);

		return "userinfo/selectOne";
	}

	@RequestMapping(value = "/u_insert.do", method = RequestMethod.GET)
	public String u_insert() {
		log.info("/u_insert.do");

		return "userinfo/insert";
	}

	@RequestMapping(value = "/u_insertOK.do", method = RequestMethod.POST)
	public String u_insertOK(UserinfoVO vo) throws IllegalStateException, IOException {

		log.info("/u_insertOK.do...{}", vo);
		vo.setBirthday(vo.getBirthday_year()+"/"+vo.getBirthday_month()+"/"+vo.getBirthday_day());
		log.info("/u_insertOK.do...{}", vo);

		String getOriginalFilename = vo.getFile().getOriginalFilename();
		int fileNameLength = vo.getFile().getOriginalFilename().length();
		log.info("getOriginalFilename:{}", getOriginalFilename);
		log.info("fileNameLength:{}", fileNameLength);

		if (getOriginalFilename.length() == 0) {
			vo.setSave_name("default.png");
		} else {
			vo.setSave_name(getOriginalFilename);

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
			String formatName = vo.getSave_name().substring(vo.getSave_name().lastIndexOf(".") + 1);
			log.info("formatName : {}", formatName);
			ImageIO.write(thumb_buffer_img, formatName, thumb_file);

		} // end else
		log.info("{}", vo);

		int result = service.insert(vo);

		if (result == 1) {
			return "redirect:login.do";
		} else {
			return "redirect:u_insert.do";
		}

	}

	// login
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String login(String message, Model model) {
		log.info("/login.do....{}", message);

		if (message != null)
			message = "아이디/비밀번호를 확인하세요";
		model.addAttribute("message", message);

		return "userinfo/login";
	}

	// loginOK

	@RequestMapping(value = "/loginOK.do", method = RequestMethod.POST)
	public String loginOK(UserinfoVO vo) {
		log.info("/loginOK.do...{}", vo);

		UserinfoVO vo2 = service.login(vo);
		log.info("vo2...{}", vo2);

		if (vo2 == null) {
			return "redirect:login.do?message=fail";
		} else {
			session.setAttribute("user_id", vo2.getUser_id());
			return "redirect:home.do";
		}

	}

	@RequestMapping(value = "/logout.do", method = RequestMethod.GET)
	public String logout() {
		log.info("/logout.do");

		session.invalidate();

		return "redirect:home.do";
	}


	@RequestMapping(value = "/u_findId.do", method = RequestMethod.GET)
	public String u_findId() {
		log.info("/u_findId.do");

		return "userinfo/findId";
	}

	@RequestMapping(value = "/findPassword.do", method = RequestMethod.GET)
	public String findPassword() {
		log.info("/findPassword.do");

		return "userinfo/findPassword";
	}

	@RequestMapping(value = "/findPassword2.do", method = RequestMethod.GET)
	public String findPassword2() {
		log.info("/findPassword2.do");

		return "userinfo/findPassword2";
	}

	@RequestMapping(value = "/findPassword3.do", method = RequestMethod.GET)
	public String findPassword3() {
		log.info("/findPassword3.do");

		return "userinfo/findPassword3";
	}

}


