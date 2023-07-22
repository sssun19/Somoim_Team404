package test.com.moim.userinfo.controller;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.scribejava.core.model.OAuth2AccessToken;

import lombok.extern.slf4j.Slf4j;
import test.com.moim.userinfo.service.UserinfoService;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import test.com.moim.userinfo.model.UserinfoVO;
import test.com.moim.userinfo.service.UserinfoService;

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

        // 생년월일을 Date 타입으로 변환하여 vo에 저장
        int birthday_year = Integer.parseInt(vo.getBirthday_year());
        int birthday_month = Integer.parseInt(vo.getBirthday_month());
        int birthday_day = Integer.parseInt(vo.getBirthday_day());
        Calendar calendar = Calendar.getInstance();
        calendar.set(birthday_year, birthday_month - 1, birthday_day); // month는 0부터 시작하므로 month-1
        vo.setBirthday(calendar.getTime());

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


//	// login
//	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
//	public String login(String message, Model model) {
//		log.info("/login.do....{}", message);
//
//		if (message != null)
//			message = "아이디/비밀번호를 확인하세요";
//		model.addAttribute("message", message);
//
//		return "userinfo/login";
//	}

	// loginOK
	
	/* NaverLoginBO */
    private NaverLoginBO naverLoginBO;
    private String apiResult = null;

    @Autowired
    public void setNaverLoginBO(NaverLoginBO naverLoginBO) {
        this.naverLoginBO = naverLoginBO;
    }

    // 로그인 첫 화면 요청 메소드
    @RequestMapping(value = "/login.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String login(Model model, HttpSession session, String message) {
        log.info("/login.do....{}", message);

        /* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);

        // 네이버
        model.addAttribute("url", naverAuthUrl);

        if (message != null)
            model.addAttribute("message", "아이디/비밀번호를 확인하세요");

        return "userinfo/login";
    }

    // 네이버 로그인 성공시 callback 호출 메소드
//    @RequestMapping(value = "/home.do", method = { RequestMethod.GET, RequestMethod.POST })
//    public String home(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, ParseException {
    // 새로운 URL로 변경
    @RequestMapping(value = "/userhome.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String home(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, ParseException {
   
    log.info("/home.do....");


        OAuth2AccessToken oauthToken;
        oauthToken = naverLoginBO.getAccessToken(session, code, state);
 		log.info("oauthToken", oauthToken);
        //1. 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken);  //String형식의 json데이터
		log.info("apiResult", apiResult);
		
		/** apiResult json 구조
		{"resultcode":"00",
		 "message":"success",
		 "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
		**/
		
		//2. String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		
		//3. 데이터 파싱 
		//Top레벨 단계 _response 파싱
	    // JSON 형태의 사용자 정보 파싱
        JSONParser parser1 = new JSONParser();
        JSONObject jsonObj1 = (JSONObject) parser1.parse(apiResult);
        JSONObject responseObj = (JSONObject) jsonObj1.get("response");

        String userId = (String) responseObj.get("user_id");
        String email = (String) responseObj.get("email");
        String birthday = (String) responseObj.get("birthday");
        String name = (String) responseObj.get("name");

        // 사용자 정보를 데이터베이스에 저장하기 위해 UserinfoVO 객체 생성
        UserinfoVO userinfo = new UserinfoVO();
        userinfo.setUser_id(userId);
        userinfo.setEmail(email);
        userinfo.setName(name);
        

        // 사용자 정보를 데이터베이스에 저장
        int result = service.userhome(userinfo);
        if (result != 1) {
            // 저장에 실패한 경우 에러 처리
            // 이 부분은 상황에 따라 적절한 처리를 해주어야 합니다.
            log.error("Failed to insert user info to the database.");
        }
        // 모델에 user_id를 추가하여 뷰에서 사용할 수 있도록 함
        model.addAttribute("user_id", userId);
        model.addAttribute("result", apiResult);
		return "userinfo/home";
    }


    
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


	@RequestMapping(value = "/u_findId2.do", method = RequestMethod.GET)
	public String u_findId2(String email, Model model) {
	    log.info("/u_findId2.do... {}", email);

	    try {
	       
	        UserinfoVO userinfoVO = service.findId(email);
	        log.info("{}", userinfoVO);

	        if (userinfoVO != null) {
	            // 아이디가 존재하는 경우 모델에 추가
	            model.addAttribute("user_id", userinfoVO.getUser_id());
	        } else {
	            // 아이디가 존재하지 않는 경우 메시지를 출력하기 위해 모델에 추가
	            model.addAttribute("user_id", "일치하는 회원 정보를 찾을 수 없습니다.");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        // 아이디 조회 중 오류 발생 시 메시지를 출력하기 위해 모델에 추가
	        model.addAttribute("user_id", "아이디 검색 중 오류가 발생했습니다.");
	    }

	    return "userinfo/findId2";
	}



	@RequestMapping(value = "/findPassword.do", method = RequestMethod.GET)
	public String findPassword() {
		log.info("/findPassword.do");

		return "userinfo/findPassword";
	}

	
	@RequestMapping(value = "/findPassword2.do", method = RequestMethod.GET)
	public String findPassword2(UserinfoVO vo, Model model) {
		log.info("/findPassword2.do...{}",vo);
		
		 try {
		        String email = vo.getEmail();

		        // 이메일을 가진 비밀번호 조회
		        UserinfoVO userinfoVO = service.findPassword(email);
		        log.info("{}", userinfoVO);

		        if (userinfoVO != null) {
		            // 비밀번호가 존재하는 경우 모델에 추가
		            model.addAttribute("pw", userinfoVO.getPw());
		        } else {
		            // 비밀번호가 존재하지 않는 경우 메시지를 출력하기 위해 모델에 추가
		            model.addAttribute("pw", "일치하는 회원 정보를 찾을 수 없습니다.");
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		        // 비밀번호 조회 중 오류 발생 시 메시지를 출력하기 위해 모델에 추가
		        model.addAttribute("pw", "아이디 검색 중 오류가 발생했습니다.");
		    }

	    return "userinfo/findPassword2";
	}
	
	
	

	@RequestMapping(value = "/resetPassword.do", method = RequestMethod.GET)
	public String resetPassword(UserinfoVO vo, Model model) {
		log.info("/resetPassword.do..{}",vo);

	    try {
	        String email = vo.getEmail();

	        // 이메일을 가진 비밀번호 조회
	        UserinfoVO userinfoVO = service.findPassword2(email);
	        log.info("{}", userinfoVO);

	        if (userinfoVO != null) {
	            // 비밀번호가 존재하는 경우 모델에 추가
	            model.addAttribute("password", userinfoVO.getPw());
	        } else {
	            // 비밀번호가 존재하지 않는 경우 메시지를 출력하기 위해 모델에 추가
	            model.addAttribute("password", "일치하는 회원 정보를 찾을 수 없습니다.");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        // 비밀번호 조회 중 오류 발생 시 메시지를 출력하기 위해 모델에 추가
	        model.addAttribute("password", "아이디 검색 중 오류가 발생했습니다.");
	    }

		return "userinfo/resetPassword";
	}

	
	@RequestMapping(value = "/u_resetPassword_update.do", method = RequestMethod.GET)
		public String b_update(UserinfoVO vo, Model model) {
			log.info("/u_resetPassword_update.do...{}", vo);

			UserinfoVO vo2 = service.selectOne(vo);

			model.addAttribute("vo2", vo2);

			return "Userinfo/u_resetPassword_update";
		}
		
		@RequestMapping(value = "/u_resetPassword_updateOK.do", method = RequestMethod.POST)
		public String b_updateOK(UserinfoVO vo) {
			log.info("/u_resetPassword_updateOK.do...{}", vo);
			
			int result = service.resetPassword_update(vo);
			log.info("result...{}", result);
			
			if(result==1) {
				return "redirect:b_selectOne.do?user_id="+vo.getUser_id();
			}else {
				return "redirect:b_update.do?user_id="+vo.getUser_id();
			}
			
		}
		
		@ResponseBody
		@RequestMapping(value = "VerifyRecaptcha", method = RequestMethod.POST)
		public int VerifyRecaptcha(HttpServletRequest request) {
		    VerifyRecaptcha.setSecretKey("시크릿 코드");
		    String gRecaptchaResponse = request.getParameter("recaptcha");
		    try {
		       if(VerifyRecaptcha.verify(gRecaptchaResponse))
		          return 0; // 성공
		       else return 1; // 실패
		    } catch (Exception e) {
		        e.printStackTrace();
		        return -1; //에러
		    }
		}

		
		
}


