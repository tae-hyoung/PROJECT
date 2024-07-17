package com.homecat.sweethome.mapper.member;


import com.homecat.sweethome.vo.member.MemberVO;

public interface LogInMapper {

	/**
	 * 로그인
	 * @param memId
	 * @return MemberVO
	 */
	public MemberVO logInMember(String memId);
	
}
