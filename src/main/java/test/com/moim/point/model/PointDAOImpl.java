package test.com.moim.point.model;

import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Slf4j
@Repository
public class PointDAOImpl implements PointDAO {

    @Autowired
    SqlSession sqlSession;

    @Override
    public List<PointVO> selectList(PointVO vo) {
        return sqlSession.selectList("POINT_SELECT_LIST", vo);
    }
}
