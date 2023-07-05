package test.com.moim;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@lombok
@Controller
public class HomeController {
	

	@RequestMapping(value = {"/","home.do"}, method = RequestMethod.GET)
	public String home() {
		

		log.info("테스트중입니다.");
		
    log.info(저는 테스트 중입니다.);
		return "home";
	}
	
}
