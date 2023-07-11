package test.com.moim.userinfo.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UserinfoDAOimpl implements UserinfoDAO {

	@Autowired
	SqlSession sqlSession;

	public UserinfoDAOimpl() {
		log.info("UserinfoDAOimpl()..");
	}
	
	@Override
	public List<UserinfoVO> selectAll(){
		log.info("selectAll()..");
		
		return sqlSession.selectList("U_SELECT_ALL");
	}
	
	@Override
	public UserinfoVO selectOne(UserinfoVO vo) {
		log.info("selectOne()...{}",vo);
		
		return sqlSession.selectOne("U_SELECT_ONE",vo);
	}
	
	@Override
	public int insert(UserinfoVO vo) {
		log.info("insert()..{}",vo);
		
		return sqlSession.insert("U_INSERT",vo);
	}
	
	@Override
	public UserinfoVO login(UserinfoVO vo) {
		log.info("login()..{}",vo);
		return sqlSession.selectOne("LOGIN",vo);
	}

	@Override
	public UserinfoVO idCheck(UserinfoVO vo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public UserinfoVO mypageSelectOne(UserinfoVO vo) {
		log.info("mypageSelectOne....{}", vo);
		return sqlSession.selectOne("U_SELECT_ID", vo);
	}

	@Override
	public UserinfoVO selectUser(UserinfoVO vo2) {
		log.info("selectUserID....{}", vo2);
		return sqlSession.selectOne("SELECT_USER", vo2);
	}

		
}
