package test.com.moim.board.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import test.com.moim.board.model.BoardDAO;
import test.com.moim.board.model.Somoim_BoardVO;
import test.com.moim.board.model.Somoim_ScheduleVO;
import test.com.moim.userinfo.model.UserinfoVO;

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

    public List<UserinfoVO> select_userinfo(UserinfoVO uVo) {
        return dao.select_userinfo(uVo);
    }
}
