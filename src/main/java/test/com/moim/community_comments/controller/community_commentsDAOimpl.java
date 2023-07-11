package test.com.moim.community_comments.controller;

import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import test.com.moim.comments.model.som_commentsVO;

import java.util.List;

@Slf4j
@Repository
public class community_commentsDAOimpl implements som_commentsDAO {

	@Autowired
	SqlSession sqlsession;


	public community_commentsDAOimpl() {
		log.info("som_commentsDAOimpl()...constructor");
		
	
	}
	@Override
	public int insert(som_commentsVO vo) {
		log.info(" dao.inserct().... {}", vo );
		log.info("��ϵ˴ϴ�");
		
		return sqlsession.update("SOM_C_INSERT",vo);
	}

	@Override
	public int update(som_commentsVO vo) {
		log.info("update()...{}",vo);
		return sqlsession.update("SOM_C_UPDATE",vo);
	}

	@Override
	public int delete(som_commentsVO vo) {
		log.info("delete()...{}",vo);
		return sqlsession.delete("SOM_C_DELETE",vo);
	}

	@Override
	public List<som_commentsVO> selectAll(som_commentsVO vo) {
		log.info("selectAll()...{}",vo);
		return sqlsession.selectList("SOM_C_SELECT_ALL", vo);
	}
	@Override
	public void good_count_up(som_commentsVO vo) {
//		log.info("vcountUp()....{}",vo);
//		sqlSession.update("B_VCOUNT_UP",vo);
		log.info("�ö󰩴ϴ�");
		
	}
	@Override
	public void som_board_num_down(som_commentsVO vo) {
//		log.info("vcountUp()....{}",vo);
//		sqlSession.update("B_VCOUNT_UP",vo);
		log.info("�������ϴ�");

	}

}
