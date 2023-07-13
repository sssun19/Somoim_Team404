package test.com.moim.userinfo.model;

import java.util.List;

public interface UserinfoDAO {

	List<UserinfoVO> selectAll();

	UserinfoVO selectOne(UserinfoVO vo);

	int insert(UserinfoVO vo);

	UserinfoVO login(UserinfoVO vo);

	UserinfoVO idCheck(UserinfoVO vo);

	UserinfoVO mypageSelectOne(UserinfoVO vo);

	UserinfoVO selectUser(UserinfoVO vo2);

	int mypage_update(UserinfoVO vo);

}
