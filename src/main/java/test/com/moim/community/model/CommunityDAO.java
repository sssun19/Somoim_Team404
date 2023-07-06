package test.com.moim.community.model;

import java.util.List;

public interface CommunityDAO {

	public int insert(CommunityVO vo);

	public int update(CommunityVO vo);

	public int delete(CommunityVO vo);

	public List<CommunityVO> selectAll();

	public CommunityVO selectOne(CommunityVO vo);

	public List<CommunityVO> searchList(String searchKey, String searchWord);

	public void view_countUp(CommunityVO vo);
	
	public void good_countUp(CommunityVO vo);

}