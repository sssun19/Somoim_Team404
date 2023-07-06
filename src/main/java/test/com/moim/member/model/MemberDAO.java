package test.com.moim.member.model;

import java.util.List;

public interface MemberDAO {
	
	public int insert(MemberVO vo);
	public int delete(MemberVO vo);
	public List<MemberVO> selectAll();
	public List<MemberVO> searchList(String searchKey, String searchWord);

}
