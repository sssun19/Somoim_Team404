package test.com.moim.point.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import test.com.moim.point.model.PointDAO;
import test.com.moim.point.model.PointVO;

import java.util.List;

@Service
public class PointService {

    @Autowired
    PointDAO dao;
    public List<PointVO> selectList(PointVO vo) {
        return dao.selectList(vo);
    }
}
