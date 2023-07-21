package test.com.moim.point.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import test.com.moim.community.model.CommunityVO;
import test.com.moim.community.service.CommunityService;
import test.com.moim.point.model.PointVO;
import test.com.moim.point.service.PointService;
import test.com.moim.somoim.model.SomoimVO;
import test.com.moim.somoim.service.SomoimService;
import test.com.moim.userinfo.model.UserinfoVO;

import java.util.List;

@Slf4j
@Controller
public class PointController {
    @Autowired
    PointService service;


    @RequestMapping(value = "/point_selectAll.do", method = RequestMethod.GET)
    public String point_selectAll(PointVO vo,Model model) {

        log.info("point_selectAll.do()......{}", vo);

        List<PointVO> vos = service.selectList(vo);

        model.addAttribute("vos", vos);



        return "point/point_selectAll";



    }

    @RequestMapping(value = "/point_purchase.do", method = RequestMethod.POST)
    public String point_purchase(UserinfoVO vo) {
        log.info("point_purchase.do()......{}", vo);







        return "point/point_selectAll";



    }


}
