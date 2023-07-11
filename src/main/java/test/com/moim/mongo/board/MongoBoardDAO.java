package test.com.moim.mongo.board;

import java.util.List;

public interface MongoBoardDAO {
    List<MongoBoardVO> findAll(MongoBoardVO vo);

    int insert(MongoBoardVO vo);

    MongoBoardVO findOne(MongoBoardVO vo);
}
