package test.com.moim.community.model;

import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Slf4j
@Repository
public class CommunityDAOimpl implements CommunityDAO{

    @Autowired
    SqlSession sqlSession;

    public CommunityDAOimpl() {
		log.info("CommunityDAOimpl....");
	}

	@Override
	public int insert(CommunityVO vo) {
		log.info("insert()....{}",vo);
		return sqlSession.insert("CB_INSERT",vo);
	}

	@Override
	public int update(CommunityVO vo) {
		log.info("update()....{}",vo);
		return sqlSession.update("CB_UPDATE",vo);
	}

	@Override
	public int delete(CommunityVO vo) {
		log.info("delete()....{}",vo);
		return sqlSession.delete("CB_DELETE",vo);
	}

	@Override
	public List<CommunityVO> selectAll() {
		log.info("selectAll()....");
		return sqlSession.selectList("CB_SELECT_ALL");
	}

	@Override
	public CommunityVO selectOne(CommunityVO vo) {
		log.info("selectOne()....{}",vo);
		
		return sqlSession.selectOne("CB_SELECT_ONE",vo);
	}

	@Override
	public List<CommunityVO> searchList(String searchKey, String searchWord) {
		log.info("searchList()....searchKey:{}",searchKey);
		log.info("searchList()....searchWord:{}",searchWord);
		String key = "";
		if(searchKey.equals("title")) {
			key = "CB_SEARCH_LIST_TITLE";
		}else if(searchKey.equals("content")) {
			key = "CB_SEARCH_LIST_CONTENT";
			
		}else {
			key = "CB_SEARCH_LIST_WRITER";
			
		}
		return sqlSession.selectList(key,"%"+searchWord+"%");
	}

	@Override
	public void view_countUp(CommunityVO vo) {
		log.info("view_countUp()....{}",vo);
		sqlSession.update("CB_view_count_UP",vo);
	}
	
	@Override
	public void good_countUp(CommunityVO vo) {
		log.info("good_countUp()....{}",vo);
		sqlSession.update("CB_good_count_UP",vo);
	}

}