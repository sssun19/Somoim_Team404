package test.com.moim.point.model;

import java.util.List;

public interface PointDAO {
    public List<PointVO> selectList(PointVO vo);
}
