package test.com.moim.userinfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import test.com.moim.userinfo.model.UserinfoDAO;
import test.com.moim.userinfo.model.UserinfoVO;
import test.com.moim.userinfo.model.UserinfoVO;

@Slf4j
@Service
public class UserinfoService {

	@Autowired
	UserinfoDAO dao;

	public List<UserinfoVO> selectAll(){
		return dao.selectAll();	
	}
	
	public UserinfoVO selectOne(UserinfoVO vo) {
		return dao.selectOne(vo);
	}
	
	public int insert(UserinfoVO vo) {
		return dao.insert(vo);
	}
	
	public UserinfoVO login(UserinfoVO vo) {
		return dao.login(vo);
	}
	
	public UserinfoVO idCheck(UserinfoVO vo) {
		return dao.idCheck(vo);
	}
	
	public UserinfoVO findId(String email) throws Exception {
	    log.info("findId()... email: {}", email);
	    
	    return dao.findId(email);
	}


}
