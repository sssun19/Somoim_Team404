package test.com.moim.mypage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import test.com.moim.somoim.model.SomoimDAO;
import test.com.moim.somoim.model.SomoimVO;
import test.com.moim.userinfo.model.UserinfoDAO;
import test.com.moim.userinfo.model.UserinfoVO;

@Slf4j
@Service
public class MypageService {

	@Autowired
	UserinfoDAO dao;
	
	@Autowired
	SomoimDAO dao2;


	public UserinfoVO mypageSelectOne(UserinfoVO vo) {
		log.info("mypageSelectOne....{}", vo);
		return dao.mypageSelectOne(vo);
	}


	public SomoimVO mypageSelectSomoim(SomoimVO vo3) {
		log.info("mypageSelectSomoim...{}", vo3);
		return dao2.mypageSelectSomoim(vo3);
	}


}
