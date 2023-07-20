package test.com.moim.message.controller;


import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import test.com.moim.community.model.CommunityVO;
import test.com.moim.message.model.MessageVO;
import test.com.moim.message.service.MessageService;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@Slf4j
public class MessageController {

    @Autowired
    MessageService service;

    @Autowired
    HttpSession session;

    @ResponseBody
    @RequestMapping(value = "/josn_message.do" ,method = RequestMethod.GET)
    public List<MessageVO> josn_message(Model model, MessageVO vo) {

        log.info("josn_message_insertOK.do()......");
        String user_id = (String)session.getAttribute("user_id");
        vo.setUser_id((String)session.getAttribute("user_id"));
        log.info("vo입니다. 제이슨!..{}", vo );
        List<MessageVO> vos = service.message_selectAll(vo);
        log.info("vos는 impl을 다녀온 값입니다!");

        return vos;


    }

    @RequestMapping(value = "/message_insertOK.do" ,method = RequestMethod.GET)
    public String josn_message_insertOK(Model model, MessageVO vo) {

        log.info("josn_message_insertOK.do()......");
        int result = service.mes_insert(vo);


        return "redirect:mypage.do";


    }


    @RequestMapping(value = "/message_deleteOK.do" ,method = RequestMethod.GET)
    public String josn_message_deleteOK(Model model, MessageVO vo) {

        log.info("josn_message_insertOK.do()......");
        int result = service.mes_delete(vo);

        return "redirect:mypage.do";


    }

    @RequestMapping(value = "/josn_message_update.do" ,method = RequestMethod.GET)
    public String josn_message_update(Model model, MessageVO vo) {

        log.info("josn_message_insertOK.do()......");
        int result = service.mes_delete(vo);

        return "redirect:mypage.do";


    }

}
