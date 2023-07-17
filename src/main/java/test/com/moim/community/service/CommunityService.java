package test.com.moim.community.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import test.com.moim.board.model.Somoim_BoardVO;
import test.com.moim.community.model.CommunityDAO;
import test.com.moim.community.model.CommunityVO;
import test.com.moim.somoim.model.SomoimVO;

@Service
@Slf4j
public class CommunityService {

    @Autowired
    CommunityDAO dao;

    public CommunityService() {
        log.info("CommunityService...");
    }


    public int insert(CommunityVO vo) {
        log.info("insert()....{}", vo);
        return dao.insert(vo);
    }

    public int update(CommunityVO vo) {
        return dao.update(vo);
    }

    public int delete(CommunityVO vo) {
        return dao.delete(vo);
    }

    public List<CommunityVO> selectAll() {
        return dao.selectAll();
    }

    public CommunityVO selectOne(CommunityVO vo) {
        return dao.selectOne(vo);
    }

    public List<CommunityVO> searchList(String searchKey, String searchWord) {
        return dao.searchList(searchKey, searchWord);
    }

    public List<CommunityVO> select_user_info() { return dao.select_user_info();}

    public void view_countUp(CommunityVO vo) {
        dao.view_countUp(vo);
    }

    public void good_countUp(CommunityVO vo) {
        dao.good_countUp(vo);
    }
}
