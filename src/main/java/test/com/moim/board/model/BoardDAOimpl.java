package test.com.moim.board.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class BoardDAOimpl implements BoardDAO{

    @Autowired
    SqlSession sqlSession;

    public BoardDAOimpl(){
        log.info("Boardimpl()....");
    }




    @Override
    public List<Somoim_BoardVO> selectList(Somoim_BoardVO vo) {

    log.info("JOIN_SOMOIM_SELECT_ALL!!!!!!!!!!!!!!!!!!!!!!!!!!", vo);
        return sqlSession.selectList("JOIN_SOMOIM_SELECT_ALL",vo);
    }

    @Override
    public Somoim_BoardVO selectJoin(Somoim_BoardVO vo) {
        return sqlSession.selectOne("JOIN_SOMOIM_SELECT_ONE",vo);
    }

    @Override
    public List<Somoim_ScheduleVO> sch_selectList(Somoim_ScheduleVO vo) {
        return sqlSession.selectList("Sch_SELECT_ALL",vo);
    }

    @Override
    public int update(Somoim_BoardVO vo) {
        return sqlSession.update("JOIN_SOMOIM_UPDATE",vo);
    }

    @Override
    public int delete(Somoim_BoardVO vo) {
        return sqlSession.delete("JOIN_SOMOIM_DELETE",vo);
    }

    @Override
    public int Sch_insert(Somoim_ScheduleVO vo) {
        return sqlSession.insert("Sch_INSERT",vo);
    }

    @Override
    public Somoim_ScheduleVO selectOne_schedule(Somoim_ScheduleVO vo) {
        return sqlSession.selectOne("Sch_SELECT_ONE",vo);
    }

    @Override
    public int Sch_update(Somoim_ScheduleVO vo) {
        return sqlSession.update("Sch_UPDATE",vo);
    }

    @Override
    public int Sch_delete(Somoim_ScheduleVO vo) {
        return sqlSession.delete("Sch_DELETE",vo);
    }

    @Override
    public int join_insert(Somoim_BoardVO vo) {
        return sqlSession.insert("JOIN_INSERT",vo);
    }

    @Override
    public int SCH_PART_UPDATE(Somoim_ScheduleVO vo) {
        return sqlSession.update("SCH_PART_UPDATE",vo);
    }

    @Override
    public int SCH_Part_Cancle(Somoim_ScheduleVO vo) {
        return sqlSession.update("SCH_CANCEL_UPDATE",vo);
    }

    @Override
    public List<Somoim_ScheduleVO> sch_selectList_part(Somoim_ScheduleVO vo) {
        return sqlSession.selectList("Sch_SELECT_PART",vo);
    }

    @Override
    public Somoim_ScheduleVO selectPay(Somoim_ScheduleVO vo) {
        return sqlSession.selectOne("SCHEDULE_PAYMENT",vo);
    }

    @Override
    public Somoim_MemberVO selectMember(Somoim_MemberVO mvo) {
        return sqlSession.selectOne("PAYMENT_USER_CHECK",mvo);
    }

    @Override
    public List<Somoim_BoardVO> select_user_info() {
        return sqlSession.selectList("JOIN_SOMOIM_SELECT_SAVE_NAME");
    }




	@Override
	public List<Somoim_BoardVO> mypageMyactivity_boardbyme(Somoim_BoardVO vo) {
		log.info("mypageBoardbyme....user_id:{}", vo.getUser_id());
		return sqlSession.selectList("MYPAGE_BOARDBYME", vo);
	}




	@Override
	public List<Somoim_ScheduleVO> som_schedule_selectOne(Somoim_ScheduleVO vo) {
		log.info("som_schedule_selectOne....somoim_num:{}", vo);
		return sqlSession.selectList("SOM_SCHEDULE_SELECTONE", vo);
	}


}
