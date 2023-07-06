package test.com.moim;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Slf4j
@Controller
public class HomeController {
	

	@RequestMapping(value = {"/","home.do"}, method = RequestMethod.GET)
	public String home() {
		
		log.info("home.do()......");
		
		return "home";
	}

	
}
