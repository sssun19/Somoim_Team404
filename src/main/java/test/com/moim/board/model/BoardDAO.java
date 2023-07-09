package test.com.moim.board.model;

import java.util.List;

public interface BoardDAO {


    List<Somoim_BoardVO> selectList(Somoim_BoardVO vo);

    Somoim_BoardVO selectJoin(Somoim_BoardVO vo);

    List<Somoim_ScheduleVO> sch_selectList(Somoim_ScheduleVO vo);

    int update(Somoim_BoardVO vo);

    int delete(Somoim_BoardVO vo);

    int Sch_insert(Somoim_ScheduleVO vo);

    Somoim_ScheduleVO selectOne_schedule(Somoim_ScheduleVO vo);

    int Sch_update(Somoim_ScheduleVO vo);

    int Sch_delete(Somoim_ScheduleVO vo);

    int join_insert(Somoim_BoardVO vo);

    int SCH_PART_UPDATE(Somoim_ScheduleVO vo);

    int SCH_Part_Cancle(Somoim_ScheduleVO vo);

    List<Somoim_ScheduleVO> sch_selectList_part(Somoim_ScheduleVO vo);
}
