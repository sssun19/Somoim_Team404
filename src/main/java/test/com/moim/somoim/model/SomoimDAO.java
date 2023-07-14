package test.com.moim.somoim.model;

import java.util.List;

import test.com.moim.paging.model.PagingVO;
import test.com.moim.userinfo.model.UserinfoVO;

public interface SomoimDAO {

	public List<SomoimVO> selectAll(SomoimVO vo);
	public SomoimVO selectOne(SomoimVO vo);
	public int insert(SomoimVO vo);
	public int update(SomoimVO vo);
	public int delete(SomoimVO vo);
	public List<SomoimVO> searchList(String searchKey, String searchWord, String category);
	//	public UserinfoVO selectprofileOne(UserinfoVO uvo);
	public UserinfoVO searchSavename(UserinfoVO uvo);
	public List<SomoimVO> mypageSelectSomoim(String user_id);
	public int countSomoim();
	public List<SomoimVO> selectSomoim(PagingVO vo);

}