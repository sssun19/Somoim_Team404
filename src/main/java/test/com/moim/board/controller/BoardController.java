package test.com.moim.board.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import test.com.moim.board.model.Somoim_BoardVO;
import test.com.moim.board.model.Somoim_MemberVO;
import test.com.moim.board.model.Somoim_ScheduleVO;
import test.com.moim.board.service.BoardService;
import test.com.moim.com_comments.model.som_comm_commentsVO;
import test.com.moim.com_comments.service.som_comm_comments_Service;
import test.com.moim.comments.model.som_commentsVO;
import test.com.moim.comments.service.som_comments_Service;

import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * Handles requests for the application home page.
 */

@Slf4j
@Controller


public class BoardController {

    @Autowired
    BoardService service;

    @Autowired
    HttpSession session;

    @Autowired
    som_comm_comments_Service c_commService;
    @Autowired
    som_comments_Service commService;


//    @RequestMapping(value = "/som_selectAll.do", method = RequestMethod.GET)
//    public String som_selectAll(Model model) {
//        log.info("som_selectAll.do().....{}");
//
//        List<BoardVO> vos = service.selectAll();
//
//        for (BoardVO vo : vos) {
//            log.info(vo.toString());
//        }
//
//        model.addAttribute("vos",vos);
//
//        return "board/som_selectAll";
//    }
//
//    @RequestMapping(value = "/som_insert.do", method = RequestMethod.GET)
//    public String som_insert() {
//        log.info("som_insert.do().....");
//
//
//        return "board/som_insert";
//    }
//
//    @RequestMapping(value = "/som_insertOK.do", method = RequestMethod.POST)
//    public String som_insertOK(BoardVO vo) {
//        log.info("som_insertOK.do().....");
//
//        int result = service.insert(vo);
//        log.info("insertOK...{}",vo);
//        return "board/som_insert";
//    }
//
//    @RequestMapping(value = "/som_selectOne.do", method = RequestMethod.GET)
//    public String som_selectOne(BoardVO vo, Model model) {
//        log.info("som_selectOne.do().....");
//
//        BoardVO vo2 = service.selectOne(vo);
//        log.info("test...{}",vo2);
//
//        model.addAttribute("vo2",vo2);
//
//        session.setAttribute("num",vo.getNum());
//        session.setAttribute("Board_num", vo.getNum());
//        log.info(String.valueOf(vo.getNum()));
//
//
//        return "board/som_selectOne";
//    }

    @RequestMapping(value = "/join_selectAll.do", method = RequestMethod.GET)
    public String join_selectAll(Model model, Somoim_BoardVO vo) {
        log.info("join_selectAll().....");

        List<Somoim_BoardVO> vos = service.selectList(vo);

        for (Somoim_BoardVO vo2 : vos) {
            log.info(vo2.toString());
        }
        model.addAttribute("vos", vos);

        return "board/join_selectAll";
    }

    @RequestMapping(value = "/join_selectOne.do", method = RequestMethod.GET)
    public String join_selectOne(Somoim_BoardVO vo, Model model) {
        log.info("join_selectOne.do().....{}", vo);
        String userId = (String) session.getAttribute("user_id");

        model.addAttribute("user_id", userId);

        Somoim_BoardVO vo2 = service.selectJoin(vo);
        log.info("test...{}", vo2);
        model.addAttribute("vo2", vo2);

        som_commentsVO cvo = new som_commentsVO();

        cvo.setSom_board_num(vo2.getNum());
        System.out.println("vo2.getNum!!!!!!!!!!!!:" + vo2.getNum());

        cvo.setSomoim_num(vo2.getSomoim_num());
        System.out.println("cvo:" + cvo.toString());
        List<som_commentsVO> coms = commService.selectAll(cvo);
        System.out.println("coms:" + coms.toString());


        som_comm_commentsVO c_cvo = new som_comm_commentsVO();
        c_cvo.setSom_board_num(cvo.getSom_board_num());
        c_cvo.setSomoim_num(cvo.getSomoim_num());
        log.info("cvo.getnum..{}", cvo.getNum());
        List<som_comm_commentsVO> c_coms = new ArrayList<som_comm_commentsVO>();
        c_coms = c_commService.selectAll(c_cvo);


        System.out.println("c_cvo:" + c_cvo);


        System.out.println("c_cvo.getSom_board_num:" + c_cvo.getSom_board_num());
        System.out.println("c_coms:" + c_coms.toString());


        model.addAttribute("coms", coms);
        model.addAttribute("c_coms", c_coms);

//		System.out.println("coms:::"+coms);
//
//		System.out.println("c_coms:::"+c_coms);
//




        return "board/join_selectOne";
    }

    @RequestMapping(value = "/join_insert.do", method = RequestMethod.GET)
    public String join_insert() {
        log.info("join_insert.do().....");


        return "board/join_insert";
    }

    @RequestMapping(value = "/join_insertOK.do", method = RequestMethod.POST)
    public String join_insertOK(Somoim_BoardVO vo) {
        log.info("join_insert.do().....{}", vo);

        int result = service.join_insert(vo);

        if (result == 1) {
            log.info("됐냐?");
            return "redirect:join_selectAll.do?somoim_num=" + vo.getSomoim_num();

        } else {
            return "redirect:join_insert.do";
        }


    }

    @RequestMapping(value = "/join_schedule.do", method = RequestMethod.GET)
    public String join_schedule(Model model, Somoim_ScheduleVO vo) {
        log.info("join_schedule.do().....{}", vo);

        List<Somoim_ScheduleVO> vos = service.sch_selelctList(vo);

        Map<String, Somoim_ScheduleVO> saveNamesMap = new HashMap<>(); // Save name을 담을 Map을 생성합니다.
        Set<String> participantSet = new HashSet<>(); // 중복되는 participant를 제거하기 위한 Set을 생성합니다.

        for (Somoim_ScheduleVO vo2 : vos) {
            log.info("각자의 vos 값"+vo2.toString());

            String[] Splits = vo2.getParticipant().split("/");

            for (String s : Splits) {
                participantSet.add(s); // 중복되는 participant를 제거하기 위해 Set에 추가합니다.
            }
        }

        for (String participant : participantSet) { // 중복을 제거한 participant에 대해 반복합니다.
            log.info("스플릿한 값"+participant);
            vo.setUser_id(participant);

            List<Somoim_ScheduleVO> vos2 = service.sch_selectList_part(vo);
            if(!vos2.isEmpty()) {
                saveNamesMap.put(participant, vos2.get(0)); // Save name을 담습니다.
            }

            for (Somoim_ScheduleVO t : vos2){
                log.info("저장된 세이브 네임"+t.getSave_name());
            }
        }

        model.addAttribute("vos", vos);
        model.addAttribute("saveNamesMap", saveNamesMap); // Model에 saveNamesMap을 추가합니다.

        return "board/join_schedule";
    }


    @RequestMapping(value = "/join_update.do", method = RequestMethod.GET)
    public String join_update(Model model, Somoim_BoardVO vo) {
        log.info("join_update.do().....");

        Somoim_BoardVO vo2 = service.selectJoin(vo);
        log.info("test...{}", vo2);

        model.addAttribute("vo2", vo2);


        return "board/join_update";
    }

    @RequestMapping(value = "/join_updateOK.do", method = RequestMethod.POST)
    public String join_updateOK(Somoim_BoardVO vo) {
        log.info("join_updateOK.do().....");

        int result = service.update(vo);

        if (result == 1) {

            return "redirect:join_selectAll.do?somoim_num=" + vo.getSomoim_num();
        } else {
            return "redirect:join_update.do?num=" + vo.getNum();
        }

    }

    @RequestMapping(value = "/join_deleteOK.do", method = RequestMethod.GET)
    public String join_deleteOK(Somoim_BoardVO vo) {
        log.info("join_deleteOK.do().....");

        int result = service.delete(vo);


        return "redirect:join_selectAll.do";


    }

    @RequestMapping(value = "/join_schedule_insert.do", method = RequestMethod.GET)
    public String join_schedule_insert() {
        log.info("join_schedule_insert.do().....");


        return "board/join_schedule_insert";


    }

    @RequestMapping(value = "/join_schedule_insertOK.do", method = RequestMethod.POST)
    public String join_schedule_insertOK(Somoim_ScheduleVO vo) {
        log.info("join_schedule_insertOK.do().....{}", vo);

        int result = service.Sch_insert(vo);


        return "board/join_schedule_insert";


    }

    @RequestMapping(value = "/join_schedule_update.do", method = RequestMethod.GET)
    public String join_schedule_update(Somoim_ScheduleVO vo, Model model) {
        log.info("join_schedule_update.do().....");

        Somoim_ScheduleVO vo2 = service.selectOne_schedule(vo);

        model.addAttribute("vo2", vo2);
        return "board/join_schedule_update";


    }

    @RequestMapping(value = "/join_schedule_updateOK.do", method = RequestMethod.POST)
    public String join_schedule_updateOK(Somoim_ScheduleVO vo) {
        log.info("join_schedule_update.do().....{}", vo);

        int result = service.Sch_update(vo);


        return "board/join_schedule_update";


    }

    @RequestMapping(value = "/join_schedule_deleteOK.do", method = RequestMethod.POST)
    public String join_schedule_deleteOK(Somoim_ScheduleVO vo) {
        log.info("join_schedule_deleteOK.do().....{}", vo);

        int result = service.Sch_delete(vo);

        if (result == 1) {
            return "redirect:join_schedule.do?somoim_num=" + vo.getSomoim_num();
        } else {
            return "redirect:join_schedule.do?somoim_num=" + vo.getSomoim_num();
        }


    }

    @RequestMapping(value = "/Participant_UpdateOK.do", method = RequestMethod.POST)
    public String Participant_UpdateOk(Somoim_ScheduleVO vo, Model model) {
        log.info("Participant_UpdateOk.do().....{}", vo);

        int result = service.SCH_Part_Update(vo);

        if (result == 1) {
            log.info("업데이트 완료");
            return "redirect:join_schedule.do?somoim_num=" + vo.getSomoim_num();

        } else {
            log.info("업데이트 X");
            return "redirect:join_schedule.do?somoim_num=" + vo.getSomoim_num();
        }


    }

    @RequestMapping(value = "/Participant_CancleOK.do", method = RequestMethod.POST)
    public String Participant_CancleOK(Somoim_ScheduleVO vo) {
        log.info("Participant_CancleOK.do().....{}", vo);

        int result = service.SCH_Part_Cancle(vo);

        if (result == 1) {
            log.info("업데이트 완료");
            return "redirect:join_schedule.do?somoim_num=" + vo.getSomoim_num();

        } else {
            log.info("업데이트 X");
            return "redirect:join_schedule.do?somoim_num=" + vo.getSomoim_num();
        }
    }

    @RequestMapping(value = "/join_pay.do", method = RequestMethod.GET)
    public String join_pay(Somoim_ScheduleVO vo,Model model) {


        List<Somoim_ScheduleVO> vos = service.sch_selelctList(vo);

        Map<String, Somoim_ScheduleVO> saveNamesMap = new HashMap<>(); // Save name을 담을 Map을 생성합니다.
        Set<String> participantSet = new HashSet<>(); // 중복되는 participant를 제거하기 위한 Set을 생성합니다.

        for (Somoim_ScheduleVO vo2 : vos) {
            log.info(vo2.toString());

            String[] Splits = vo2.getParticipant().split("/");

            for (String s : Splits) {
                participantSet.add(s); // 중복되는 participant를 제거하기 위해 Set에 추가합니다.
            }
        }

        for (String participant : participantSet) { // 중복을 제거한 participant에 대해 반복합니다.

            vo.setUser_id(participant);

            List<Somoim_ScheduleVO> vos2 = service.sch_selectList_part(vo);
            if(!vos2.isEmpty()) {
                saveNamesMap.put(participant, vos2.get(0)); // Save name을 담습니다.
            }

            for (Somoim_ScheduleVO t : vos2){

            }
        }



        model.addAttribute("vos", vos);
        model.addAttribute("saveNamesMap", saveNamesMap); // Model에 saveNamesMap을 추가합니다.

        return "board/join_pay";
    }



    @RequestMapping(value = "/schedule_payment.do", method = RequestMethod.POST)
    public String schedule_payment(Somoim_ScheduleVO vo,Somoim_MemberVO mvo) {

        log.info("schedule_payment.do().....{}",vo);

//        String userId = (String) request.getSession().getAttribute("user_id");


        log.info("세션 아이디"+vo.getSomoim_num());

        Somoim_ScheduleVO vo2 = service.selectPay(vo);

        Somoim_MemberVO mvo2 = service.selectMember(mvo);




        log.info("vo2 스트링"+vo2.toString());

        log.info("mvo2 스트링"+mvo2.toString());

        if (vo2.getSom_member_num() == mvo2.getNum()) {
            log.info("같음");
            return "redirect:join_pay.do?somoium_num="+vo.getSomoim_num();
        }else{
            log.info("다름");
            return "redirect:join_pay.do?somoium_num="+vo.getSomoim_num();
        }





    }



}