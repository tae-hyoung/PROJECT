package com.homecat.sweethome.service.member;

import com.homecat.sweethome.vo.member.MemberVO;

public interface LogInService {
	
	/**
	 * 로그인
	 * @param memId
	 * @return MemberVO
	 */
	public MemberVO logInMember(String memId);
	
}
