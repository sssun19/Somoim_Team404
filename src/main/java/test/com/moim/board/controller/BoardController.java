package test.com.moim.board.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import test.com.moim.board.model.Somoim_BoardVO;
import test.com.moim.board.model.Somoim_ScheduleVO;
import test.com.moim.board.service.BoardService;

import javax.servlet.http.HttpSession;
import java.util.List;

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
    public String join_selectAll(Model model,Somoim_BoardVO vo) {
        log.info("join_selectAll().....");

        List<Somoim_BoardVO> vos = service.selectList(vo);

        for (Somoim_BoardVO vo2 : vos) {
            log.info(vo2.toString());
        }
        model.addAttribute("vos",vos);

        return "board/join_selectAll";
    }

    @RequestMapping(value = "/join_selectOne.do", method = RequestMethod.GET)
    public String join_selectOne(Somoim_BoardVO vo, Model model) {
        log.info("join_selectOne.do().....");


        Somoim_BoardVO vo2 = service.selectJoin(vo);
        log.info("test...{}",vo2);

        model.addAttribute("vo2",vo2);






        return "board/join_selectOne";
    }

    @RequestMapping(value = "/join_gallery.do", method = RequestMethod.GET)
    public String join_gallery() {
        log.info("join_gallery.do().....");



        return "board/join_gallery";
    }
    @RequestMapping(value = "/join_insert.do", method = RequestMethod.GET)
    public String join_insert() {
        log.info("join_insert.do().....");



        return "board/join_insert";
    }
    @RequestMapping(value = "/join_insertOK.do", method = RequestMethod.POST)
    public String join_insertOK(Somoim_BoardVO vo) {
        log.info("join_insert.do().....{}",vo);

        int result = service.join_insert(vo);

        if(result==1){
            log.info("됐냐?");
            return "redirect:join_selectAll.do?somoim_num="+vo.getSomoim_num();

        }else{
            return "redirect:join_insert.do";
        }


    }

    @RequestMapping(value = "/join_schedule.do", method = RequestMethod.GET)
    public String join_schedule(Model model, Somoim_ScheduleVO vo) {
        log.info("join_schedule.do().....{}");

        List<Somoim_ScheduleVO> vos = service.sch_selelctList(vo);


        for (Somoim_ScheduleVO vo2 : vos) {
            log.info(vo2.toString());
        }

        model.addAttribute("vos", vos);


        return "board/join_schedule";
    }

    @RequestMapping(value = "/join_update.do", method = RequestMethod.GET)
    public String join_update(Model model, Somoim_BoardVO vo) {
        log.info("join_update.do().....");

        Somoim_BoardVO vo2 = service.selectJoin(vo);
        log.info("test...{}",vo2);

        model.addAttribute("vo2",vo2);


        return "board/join_update";
    }

    @RequestMapping(value = "/join_updateOK.do", method = RequestMethod.POST)
    public String join_updateOK(Somoim_BoardVO vo) {
        log.info("join_updateOK.do().....");

        int result = service.update(vo);

        if (result==1){

            return "redirect:join_selectAll.do?somoim_num="+vo.getSomoim_num();
        }else{
            return "redirect:join_update.do?num="+vo.getNum();
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
        log.info("join_schedule_insertOK.do().....{}",vo);

        int result = service.Sch_insert(vo);


        return "board/join_schedule_insert";



    }
    @RequestMapping(value = "/join_schedule_update.do", method = RequestMethod.GET)
    public String join_schedule_update(Somoim_ScheduleVO vo,Model model) {
        log.info("join_schedule_update.do().....");

        Somoim_ScheduleVO vo2 = service.selectOne_schedule(vo);

        model.addAttribute("vo2",vo2);
        return "board/join_schedule_update";



    }

    @RequestMapping(value = "/join_schedule_updateOK.do", method = RequestMethod.POST)
    public String join_schedule_updateOK(Somoim_ScheduleVO vo) {
        log.info("join_schedule_update.do().....{}",vo);

        int result = service.Sch_update(vo);


        return "board/join_schedule_update";



    }

    @RequestMapping(value = "/join_schedule_delete.do", method = RequestMethod.GET)
    public String join_schedule_delete(Somoim_ScheduleVO vo) {
        log.info("join_schedule_delete.do().....{}",vo);

        int result = service.Sch_delete(vo);



        return "redirect:join_schedule.do";



    }








}