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


    Somoim_ScheduleVO selectPay(Somoim_ScheduleVO vo);


    Somoim_MemberVO selectMember(Somoim_MemberVO mvo);

    List<Somoim_BoardVO> select_user_info();
	List<Somoim_BoardVO> mypageMyactivity_boardbyme(Somoim_BoardVO vo);

	List<Somoim_ScheduleVO> som_schedule_selectOne(Somoim_ScheduleVO vo);
    int adding_good_count_list(Somoim_BoardVO vo);
    int del_good_count_list(Somoim_BoardVO vo);

    int good_count_up(Somoim_BoardVO vo);
    int good_count_down(Somoim_BoardVO vo);
    int vvcountup(Somoim_BoardVO vo);
    List<Somoim_BoardVO> JSON_SELECT_ALL(Somoim_BoardVO vo);

	Somoim_BoardVO select_all_goodList(Somoim_BoardVO vo);
}
