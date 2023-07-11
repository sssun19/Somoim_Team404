package test.com.moim.counting.model;

import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
@Slf4j
public class CountingDAOimpl implements CountingDAO{

    @Autowired
    SqlSession sqlSession;
    @Override
    public void good_count_up() {
        log.info("good_count_up");
        sqlSession.update("SB_GOOD_COUNT_UP");


    }

    @Override
    public void good_count_down() {
        log.info("good_count_down");
    }

    @Override
    public void v_count_up() {
        log.info("v_count_up");
    }

    @Override
    public void v_count_down() {
        log.info("v_count_down");
    }
}
