package test.com.moim.somoim.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import test.com.moim.somoim.model.SomoimDAOimpl;
import test.com.moim.somoim.model.SomoimVO;
import test.com.moim.userinfo.model.UserinfoVO;

@Service
@Slf4j
public class SomoimService {
	
	@Autowired
	SomoimDAOimpl dao;
	
	
	public List<SomoimVO> selectAll(SomoimVO vo) {
		log.info("somoim_selectAll().....");
		return dao.selectAll(vo);
	}


	public SomoimVO selectOne(SomoimVO vo) {
		log.info("somoim_selectOne()....{}", vo);
		return dao.selectOne(vo);
	}


	public List<SomoimVO> searchList(String searchKey, String searchWord, String category) {
		log.info("searchList()....{},{}", searchKey, searchWord);
		log.info("searchList()....{}", category);
		return dao.searchList(searchKey, searchWord, category);
	}


	public int insert(SomoimVO vo) {
		log.info("insert()....{}", vo);
		return dao.insert(vo);
	}


	public int update(SomoimVO vo) {
		log.info("update()....{}", vo);
		return dao.update(vo);
	}


	public int delete(SomoimVO vo) {
		log.info("delete().....{}", vo);
		return dao.delete(vo);
	}


	public UserinfoVO searchSavename(UserinfoVO uvo) {
		log.info("searchSavename...{}", uvo);
		return dao.searchSavename(uvo);
	}
	
//	public UserinfoVO selectprofileOne(UserinfoVO uvo) {
//		log.info(".....!!{}", uvo);
//		return dao.selectprofileOne(uvo);
//	}

	
}
