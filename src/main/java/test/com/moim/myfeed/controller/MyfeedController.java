package test.com.moim.myfeed.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;


@Slf4j

@Controller
public class MyfeedController {

	@RequestMapping(value = "/myfeed_feed_mine.do", method = RequestMethod.GET)
	public String home() {
		log.info("home.do().....");



		return "myfeed/myfeed_feed_mine";
	}
	
}