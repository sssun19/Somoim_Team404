package test.com.moim.board.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import test.com.moim.board.model.*;

import java.util.List;

@Service
@Slf4j
public class BoardService {

    @Autowired
    BoardDAO dao;


    public BoardService(){
        log.info("BoardService()....");
    }


    public List<Somoim_BoardVO> selectList(Somoim_BoardVO vo) {
        return dao.selectList(vo);
    }

    public Somoim_BoardVO selectJoin(Somoim_BoardVO vo) {
        return dao.selectJoin(vo);
    }

    public List<Somoim_ScheduleVO> sch_selelctList(Somoim_ScheduleVO vo) {
        return dao.sch_selectList(vo);
    }

    public int update(Somoim_BoardVO vo) {
        return dao.update(vo);
    }

    public int delete(Somoim_BoardVO vo) {
        return dao.delete(vo);    }

    public int Sch_insert(Somoim_ScheduleVO vo) {
        return dao.Sch_insert(vo);
    }

    public Somoim_ScheduleVO selectOne_schedule(Somoim_ScheduleVO vo) {
        return dao.selectOne_schedule(vo);
    }

    public int Sch_update(Somoim_ScheduleVO vo) {
        return dao.Sch_update(vo);
    }

    public int Sch_delete(Somoim_ScheduleVO vo) {
        return dao.Sch_delete(vo);
    }

    public int join_insert(Somoim_BoardVO vo) {
        return dao.join_insert(vo);
    }

    public int SCH_Part_Update(Somoim_ScheduleVO vo) { return dao.SCH_PART_UPDATE(vo);    }

    public int SCH_Part_Cancle(Somoim_ScheduleVO vo) {
        return dao.SCH_Part_Cancle(vo);
    }

    public List<Somoim_ScheduleVO> sch_selectList_part(Somoim_ScheduleVO vo) {
        return dao.sch_selectList_part(vo);
    }


    public Somoim_ScheduleVO selectPay(Somoim_ScheduleVO vo) {
        return dao.selectPay(vo);
    }


    public Somoim_MemberVO selectMember(Somoim_MemberVO mvo) {
        return dao.selectMember(mvo);
    }

    public List<Somoim_BoardVO> select_user_info() { return dao.select_user_info();}

    public int vote_insert(Somoim_Question_VoteVO vo) {
        return dao.vote_insert(vo);

    }

    public Somoim_Question_VoteVO vote_num(Somoim_Question_VoteVO vo) {
        return dao.vote_num(vo);
    }

    public int choice_insert(Somoim_Choice_Vote vo) {
        return dao.choice_num(vo);
    }

    public List<Somoim_Question_VoteVO> vote_selectList(Somoim_Question_VoteVO voteVos) {
        return dao.vote_selectList(voteVos);
    }
}
