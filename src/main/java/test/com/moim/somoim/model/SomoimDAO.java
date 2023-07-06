package test.com.moim.somoim.model;

import java.util.List;

public interface SomoimDAO {

	public List<SomoimVO> selectAll(SomoimVO vo);
	public SomoimVO selectOne(SomoimVO vo);
	public int insert(SomoimVO vo);
	public int update(SomoimVO vo);
	public int delete(SomoimVO vo);
	public List<SomoimVO> searchList(String searchKey, String searchWord, String category);
	
}
